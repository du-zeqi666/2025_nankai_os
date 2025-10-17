#include <pmm.h>
#include <list.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>
#include <slub.h>

/*
 * ===========================================================
 *  简化版 SLUB 连续物理页分配算法（兼容 pmm_manager 接口）
 * ===========================================================
 *  - 第一层：基于页块（page block）的分配与释放
 *  - 第二层（可扩展）：对象级分配（当前留接口）
 *  - 与 default_pmm.c 完全兼容，可在 pmm.c 中直接切换使用
 * ===========================================================
 */

typedef struct {
    list_entry_t free_list;   // 空闲页链表
    size_t nr_free;           // 当前可用页数量
} slub_area_t;

static slub_area_t slub_area;

#define free_list (slub_area.free_list)
#define nr_free (slub_area.nr_free)

/* ======================== 初始化函数 ======================== */

static void
slub_init(void) {
    list_init(&free_list);
    nr_free = 0;
    cprintf("[SLUB] Initialized empty free list.\n");
}

/*
 * 初始化连续的空闲页区域
 * base: 起始页
 * n:    连续空闲页数量
 */
static void
slub_init_memmap(struct Page* base, size_t n) {
    assert(n > 0);
    struct Page* p = base;

    for (; p != base + n; p++) {
        assert(PageReserved(p));   // 确保是可初始化页
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }

    // 设置首页属性并清理其余页
    base->property = n;
    SetPageProperty(base);
    nr_free += n;

    for (size_t i = 1; i < n; i++) {
        ClearPageProperty(base + i);
        (base + i)->property = 0;
    }

    // 将新空闲块插入空闲链表（按地址升序）
    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));
    }
    else {
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            if (base < page) {
                list_add_before(le, &(base->page_link));
                break;
            }
            else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));
                break;
            }
        }
    }

    cprintf("[SLUB] Initialized %zu free pages starting from %p\n", n, base);
}

/* ======================== 页面分配 ======================== */

static struct Page*
slub_alloc_pages(size_t n) {
    assert(n > 0);

    if (n > nr_free) {
        cprintf("[SLUB] Allocation failed: insufficient free pages (%zu)\n", nr_free);
        return NULL;
    }

    struct Page* page = NULL;
    list_entry_t* le = &free_list;

    // 遍历链表，寻找第一个足够大的连续块（First-Fit）
    while ((le = list_next(le)) != &free_list) {
        struct Page* p = le2page(le, page_link);
        if (p->property >= n) {
            page = p;
            break;
        }
    }

    if (page != NULL) {
        list_entry_t* prev = list_prev(&(page->page_link));
        list_del(&(page->page_link));

        // 如果块比需求大，则分裂
        if (page->property > n) {
            struct Page* p = page + n;
            p->property = page->property - n;
            SetPageProperty(p);
            list_add(prev, &(p->page_link));
        }

        nr_free -= n;
        ClearPageProperty(page);
        cprintf("[SLUB] alloc page=%p (n=%zu)\n", page, n);
    }
    else {
        cprintf("[SLUB] No suitable block found for n=%zu\n", n);
    }

    return page;
}

/* ======================== 页面释放 ======================== */

static void
slub_free_pages(struct Page* base, size_t n) {
    assert(n > 0);

    struct Page* p = base;
    for (; p != base + n; p++) {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }

    base->property = n;
    SetPageProperty(base);
    nr_free += n;

    // 插入到空闲链表（地址升序）
    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));
    }
    else {
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            if (base < page) {
                list_add_before(le, &(base->page_link));
                break;
            }
            else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));
                break;
            }
        }
    }

    // 向前合并
    list_entry_t* le = list_prev(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (p + p->property == base) {
            p->property += base->property;
            ClearPageProperty(base);
            list_del(&(base->page_link));
            base = p;
        }
    }

    // 向后合并
    le = list_next(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (base + base->property == p) {
            base->property += p->property;
            ClearPageProperty(p);
            list_del(&(p->page_link));
        }
    }

    cprintf("[SLUB] free page=%p (n=%zu)\n", base, n);
}

/* ======================== 工具函数 ======================== */

static size_t
slub_nr_free_pages(void) {
    return nr_free;
}

/* ======================== 自检函数 ======================== */

static void
slub_check(void) {
    cprintf("========== SLUB Allocator Check ==========\n");

    size_t total_before = slub_nr_free_pages();
    cprintf("[Check] Free pages before test: %zu\n", total_before);

    // 单页分配
    struct Page* p1 = slub_alloc_pages(1);
    assert(p1 != NULL);
    cprintf("[OK] Single page allocation succeeded: %p\n", p1);

    // 多页分配
    struct Page* p2 = slub_alloc_pages(3);
    assert(p2 != NULL);
    cprintf("[OK] Multi-page (3 pages) allocation succeeded: %p\n", p2);

    // 检查剩余页数减少
    size_t total_after_alloc = slub_nr_free_pages();
    assert(total_after_alloc < total_before);
    cprintf("[OK] Free pages decreased correctly after allocation: %zu -> %zu\n",
        total_before, total_after_alloc);

    // 释放测试
    slub_free_pages(p2, 3);
    cprintf("[OK] Freed 3 pages at %p\n", p2);
    slub_free_pages(p1, 1);
    cprintf("[OK] Freed 1 page at %p\n", p1);

    // 循环分配释放
    for (int i = 0; i < 5; i++) {
        struct Page* px = slub_alloc_pages(1);
        assert(px != NULL);
        slub_free_pages(px, 1);
    }
    cprintf("[OK] Repeated alloc/free cycles (5x) succeeded.\n");

    // 大块分配失败测试
    size_t huge_req = total_before + 10;
    struct Page* fail_page = slub_alloc_pages(huge_req);
    assert(fail_page == NULL);
    cprintf("[OK] Large allocation (n=%zu) correctly failed.\n", huge_req);

    // 页数恢复验证
    size_t total_after_free = slub_nr_free_pages();
    assert(total_after_free == total_before);
    cprintf("[OK] Free page count restored: %zu\n", total_after_free);

    cprintf("========== SLUB Allocator Check PASSED ==========\n");
}

/* ======================== pmm_manager 接口注册 ======================== */

const struct pmm_manager slub_pmm_manager = {
    .name = "slub_pmm_manager",
    .init = slub_init,
    .init_memmap = slub_init_memmap,
    .alloc_pages = slub_alloc_pages,
    .free_pages = slub_free_pages,
    .nr_free_pages = slub_nr_free_pages,
    .check = slub_check,
};

/* ======================== 手动测试入口 ======================== */

void slub_test(void) {
    cprintf("==== SLUB TEST (manual) ====\n");
    struct Page* p = slub_alloc_pages(1);
    if (p) {
        cprintf("[TEST] Manual alloc succeeded: %p\n", p);
        slub_free_pages(p, 1);
        cprintf("[TEST] Manual free succeeded: %p\n", p);
    }
    else {
        cprintf("[TEST] Manual alloc failed.\n");
    }
    cprintf("==== END SLUB TEST ====\n");
}
