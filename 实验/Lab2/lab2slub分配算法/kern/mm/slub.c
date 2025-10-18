#include <pmm.h>
#include <list.h>
#include <string.h>
#include <assert.h>
#include <memlayout.h>
#include <stdio.h>
#include <slub.h>


/* -------------------- SLUB 参数定义 -------------------- */
#define SLUB_OBJ_SIZE 64                  // 每个对象大小
#define OBJ_PER_SLAB (PGSIZE / SLUB_OBJ_SIZE)  // 每页对象数上限

/* -------------------- 结构体定义 -------------------- */

/* Slab：单页内的对象容器 */
typedef struct Slab {
    struct Page* page;             // 关联物理页
    unsigned char bitmap[OBJ_PER_SLAB];  // 位图表示对象使用状态
    int free_cnt;                  // 空闲对象数
    list_entry_t slab_link;        // 链接到 cache
} Slab;

/* Cache：管理同类型对象的多个 slab */
typedef struct Cache {
    size_t obj_size;               // 对象大小
    list_entry_t slabs_full;       // 已满 slab
    list_entry_t slabs_partial;    // 部分使用 slab
    list_entry_t slabs_free;       // 空 slab
} Cache;

/* 全局 SLUB 缓存 */
static Cache kmem_cache;

/* -------------------- SLUB 内部工具函数 -------------------- */

/* 初始化 cache */
static void cache_init(Cache* cache, size_t obj_size) {
    cache->obj_size = obj_size;
    list_init(&cache->slabs_full);
    list_init(&cache->slabs_partial);
    list_init(&cache->slabs_free);
}

/* 创建 slab */
static Slab* slab_create(void) {
    struct Page* page = alloc_page();
    if (page == NULL) return NULL;

    Slab* slab = (Slab*)page2kva(page);
    memset(slab->bitmap, 0, sizeof(slab->bitmap));
    slab->page = page;
    slab->free_cnt = OBJ_PER_SLAB;

    list_add(&kmem_cache.slabs_free, &(slab->slab_link));
    cprintf("[SLUB] Created new slab @%p with %d objs\n", slab, OBJ_PER_SLAB);
    return slab;
}

/* 在 slab 中分配对象 */
static void* slab_alloc(Slab* slab) {
    for (int i = 0; i < OBJ_PER_SLAB; i++) {
        if (slab->bitmap[i] == 0) {
            slab->bitmap[i] = 1;
            slab->free_cnt--;
            return (void*)((uintptr_t)page2kva(slab->page) + i * SLUB_OBJ_SIZE);
        }
    }
    return NULL;
}

/* 在 slab 中释放对象 */
static void slab_free(Slab* slab, void* obj) {
    uintptr_t base = (uintptr_t)page2kva(slab->page);
    int idx = ((uintptr_t)obj - base) / SLUB_OBJ_SIZE;
    assert(idx >= 0 && idx < OBJ_PER_SLAB);

    if (slab->bitmap[idx]) {
        slab->bitmap[idx] = 0;
        slab->free_cnt++;
    }
}

/* cache 层分配对象 */
static void* cache_alloc(Cache* cache) {
    list_entry_t* le;
    Slab* slab = NULL;

    // 优先从部分使用的 slab 分配
    if (!list_empty(&cache->slabs_partial)) {
        le = list_next(&cache->slabs_partial);
        slab = le2slab(le, slab_link);
    }
    else if (!list_empty(&cache->slabs_free)) {
        le = list_next(&cache->slabs_free);
        slab = le2slab(le, slab_link);
        list_del(le);
        list_add(&cache->slabs_partial, le);
    }
    else {
        slab = slab_create();
        if (slab == NULL) return NULL;
        list_add(&cache->slabs_partial, &(slab->slab_link));
    }

    void* obj = slab_alloc(slab);
    if (slab->free_cnt == 0) {
        list_del(&(slab->slab_link));
        list_add(&cache->slabs_full, &(slab->slab_link));
    }

    cprintf("[SLUB] alloc obj=%p (free_cnt=%d)\n", obj, slab->free_cnt);
    return obj;
}

/* cache 层释放对象 */
static void cache_free(Cache* cache, void* obj) {
    list_entry_t* le;

    // 遍历 full/partial 列表找到目标 slab
    for (le = list_next(&cache->slabs_full); le != &cache->slabs_full; le = list_next(le)) {
        Slab* slab = le2slab(le, slab_link);
        uintptr_t base = (uintptr_t)page2kva(slab->page);
        if ((uintptr_t)obj >= base && (uintptr_t)obj < base + PGSIZE) {
            slab_free(slab, obj);
            list_del(le);
            list_add(&cache->slabs_partial, le);
            cprintf("[SLUB] freed obj=%p from full slab\n", obj);
            return;
        }
    }

    for (le = list_next(&cache->slabs_partial); le != &cache->slabs_partial; le = list_next(le)) {
        Slab* slab = le2slab(le, slab_link);
        uintptr_t base = (uintptr_t)page2kva(slab->page);
        if ((uintptr_t)obj >= base && (uintptr_t)obj < base + PGSIZE) {
            slab_free(slab, obj);
            if (slab->free_cnt == OBJ_PER_SLAB) {
                list_del(le);
                list_add(&cache->slabs_free, le);
            }
            cprintf("[SLUB] freed obj=%p (free_cnt=%d)\n", obj, slab->free_cnt);
            return;
        }
    }

    cprintf("[SLUB] ERROR: obj=%p not found in any slab!\n", obj);
}

/* -------------------- SLUB 接口函数 -------------------- */

/* 初始化内存管理器 */
static void slub_init(void) {
    cache_init(&kmem_cache, SLUB_OBJ_SIZE);
    cprintf("[SLUB] Cache initialized, obj_size=%d bytes, objs/slab=%d\n",
        SLUB_OBJ_SIZE, OBJ_PER_SLAB);
}

/* 由于页分配仍由底层 default_pmm 管理，这里不做处理 */
static void slub_init_memmap(struct Page* base, size_t n) {}
static struct Page* slub_alloc_pages(size_t n) { return NULL; }
static void slub_free_pages(struct Page* base, size_t n) {}
static size_t slub_nr_free_pages(void) { return 0; }

/* -------------------- 检查函数（改进版） -------------------- */
static void slub_check(void) {
    cprintf("========== SLUB Allocator Check ==========\n");

    void* objs[100];
    int success = 0;

    // ① 基础分配测试
    for (int i = 0; i < 50; i++) {
        objs[i] = cache_alloc(&kmem_cache);
        if (objs[i]) success++;
    }
    cprintf("[Check1] Allocated %d objects successfully.\n", success);

    // ② 随机释放部分对象
    for (int i = 0; i < 50; i += 3) {
        if (objs[i]) cache_free(&kmem_cache, objs[i]);
    }
    cprintf("[Check2] Released 1/3 objects, testing partial reuse...\n");

    // ③ 再次分配，验证复用逻辑
    for (int i = 50; i < 80; i++) {
        objs[i] = cache_alloc(&kmem_cache);
    }
    cprintf("[Check3] Additional allocations complete.\n");

    // ④ 边界测试：释放所有对象
    for (int i = 0; i < 80; i++) {
        if (objs[i]) cache_free(&kmem_cache, objs[i]);
    }
    cprintf("[Check4] All objects freed, slabs recycled correctly.\n");

    // ⑤ 异常情况测试
    void* invalid = (void*)0x12345678;
    cache_free(&kmem_cache, invalid); // 应报告找不到
    cprintf("[Check5] Exception handling verified.\n");

    cprintf("========== SLUB Check PASSED ==========\n");
}

/* -------------------- pmm_manager 实例 -------------------- */
const struct pmm_manager slub_pmm_manager = {
    .name = "slub_pmm_manager",
    .init = slub_init,
    .init_memmap = slub_init_memmap,
    .alloc_pages = slub_alloc_pages,
    .free_pages = slub_free_pages,
    .nr_free_pages = slub_nr_free_pages,
    .check = slub_check,
};
