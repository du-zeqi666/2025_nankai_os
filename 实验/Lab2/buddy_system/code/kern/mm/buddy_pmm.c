#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h> 
#include <buddy_pmm.h>
#include <stdio.h>

#define MAX_ORDER 15

typedef struct {
    free_area_t free_area[MAX_ORDER+1];  // 0 到 MAX_ORDER-1 阶的空闲链表; free_area_t定义在memlayout.h
    unsigned int nr_free;              // 总空闲页数
} buddy_area_t;

static buddy_area_t buddy_area;

#define buddy_free_area (buddy_area.free_area)
#define buddy_nr_free (buddy_area.nr_free)

// 计算阶数
static size_t get_order(size_t n){
    if(n <= 1) return 0;
    size_t order = 0;
    size_t size = 1;
    while(size < n){
        size <<= 1;
        order++;
    }
    return order;  
}
// 初始化 buddy pmm manager
static void buddy_init(void){
    for(int i = 0; i < MAX_ORDER+1; i++){
        list_init(&(buddy_free_area[i].free_list));  //每层链表表头的前向指针和后向指针指向本身
        buddy_free_area[i].nr_free = 0;
    }
    buddy_nr_free = 0;
}
// 计算页块p的伙伴页块地址    p:页块的起始Page结构体指针    order:页块的阶数(2^order页)
static struct Page *get_buddy_page(struct Page *p, size_t order){
    size_t page_num = page2ppn(p);
    size_t buddy_page_num = page_num ^ (1 << order);
    return pa2page(buddy_page_num << PGSHIFT);
}
//初始化内存映射,将连续的n个页块base插入到buddy system中
static void buddy_init_memmap(struct Page *base, size_t n){
    assert(n > 0);
    struct Page *p = base;
    size_t count = n;
    // 初始化所有页
    for(; p != base + n; p++){
        assert(PageReserved(p)); // 确保页已经被内核保留
        p->flags = 0;           // 清除所有标志
        p->property = 0;        // 阶数清零
        set_page_ref(p, 0);     // 引用计数清零
        ClearPageProperty(p);   // 确保不是空闲块头部
    }
    // 将n页内存块分解成2^i页的块，并插入到对应的空闲列表
    struct Page *curr_page = base;
    while(count > 0){
        size_t order = get_order(count);
        size_t page_num = 1 << order;
        if(page_num > count){ // 实际页数不能比当前剩余的页数大
            order--;
            page_num = 1 << order;
        }
        // 阶数不能超过最大阶数限制
        if (order > MAX_ORDER) {
            order = MAX_ORDER;
            page_num = 1 << order;
        }
        
        curr_page->property = order;
        SetPageProperty(curr_page); // 标记为空闲块的头部
        
        // 插入到对应的空闲链表
        list_add(&(buddy_free_area[order].free_list), &(curr_page->page_link));
        buddy_free_area[order].nr_free += page_num;
   
        count -= page_num;
        buddy_nr_free += page_num;
        curr_page += page_num;
    }
}
// 分配n个连续页
static struct Page *buddy_alloc_pages(size_t n){
    assert(n > 0);
    if(n > buddy_nr_free) return NULL; // 空闲页不足
    // 计算所需的最小阶数 k
    size_t min_order = get_order(n);
    if(min_order >= MAX_ORDER) return NULL; // 太大
    // 从第k层向上找空闲块
    size_t order = min_order;
    while(order <= MAX_ORDER){
        if(list_empty(&(buddy_free_area[order].free_list))){
            order++;
        }else{
            break;
        }
    }
    if(order == MAX_ORDER+1) return NULL; // 空闲不足
    // 从列表中取出找到的空闲块
    list_entry_t *target = list_next(&(buddy_free_area[order].free_list));
    struct Page *page = le2page(target, page_link);
    list_del(target);
    
    size_t size = 1 << order;
    buddy_free_area[order].nr_free -= size;
    buddy_nr_free -= size;
    // 如果阶数大于所需阶数，则分裂
    while(order > min_order){
        order--;
        size >>= 1;
        // 将后半块放入对应阶数的空闲列表
        struct Page *back = page + size;
        SetPageProperty(back);
        back->property = order;
        
        list_add(&(buddy_free_area[order].free_list), &(back->page_link));
        buddy_free_area[order].nr_free += size;
        buddy_nr_free += size;
    }
    
    ClearPageProperty(page); // 分配后清除头部标记
    page->property = min_order;      // 分配后清除阶数信息
    
    // 确保块内所有页都是干净的
    size_t allocated_size = 1 << min_order; // 实际分配页数 (例如 64)
    struct Page *p_to_clear = page;
    
    for (size_t i = 0; i < allocated_size; i++) {
        // 清除所有 flags (确保 PG_reserved/PG_property 都是 0)
        p_to_clear->flags = 0; 
        set_page_ref(p_to_clear, 0); // 引用计数清零
        p_to_clear++;
    }  
    ClearPageProperty(page); // 确保 PG_property 仍是 0
    page->property = min_order; // 重新设置阶数
    
    return page;
}
// 释放n个连续页
static void buddy_free_pages(struct Page *base, size_t n){
    assert(n > 0);
    // 确定释放块的阶数
    size_t order = get_order(n);
    assert(order <= MAX_ORDER);
    // 设置要释放块的属性
    struct Page *p = base;
    for (; p != base + n; p ++) {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0; // 清除所有标志
        set_page_ref(p, 0);
    }
    // 向上合并
    struct Page *curr_page = base;
    while(order < MAX_ORDER){
        struct Page *buddy = get_buddy_page(curr_page, order);
        // 检查伙伴块是否空闲且具有相同的阶数
        if (PageProperty(buddy) && buddy->property == order) {
            // 从空闲链表中移除伙伴块
            list_del(&(buddy->page_link));
            buddy_free_area[order].nr_free -= (1 << order);
            buddy_nr_free -= (1 << order);
            // 确定合并后的新块起始页 (始终是地址较低的一个)
            if (buddy < curr_page) {
                curr_page = buddy;
            }
            order++;
        }else{
            break;
        }
    }
    // 将最终合并后的块插入到对应的空闲列表
    curr_page->property = order;
    SetPageProperty(curr_page);
    
    size_t size = 1 << order;
    list_add_before(&(buddy_free_area[order].free_list), &(curr_page->page_link));
    buddy_free_area[order].nr_free += size;
    buddy_nr_free += size;
}    

static size_t
buddy_nr_free_pages(void) {
    return buddy_nr_free;
}

static void buddy_show(void) {
    cprintf("Total Free Pages: %u\n", buddy_nr_free);
    
    int i;
    for (i = 0; i < MAX_ORDER; i++) {
        if (!list_empty(&(buddy_free_area[i].free_list))) {
            cprintf("  阶数 %d(%u 页): 空闲 %u 块, 总空闲 %u 页. 内存块起始PPN:\n", 
                    i, 1 << i, buddy_free_area[i].nr_free / (1 << i), buddy_free_area[i].nr_free);
            
            // 遍历链表，打印每个空闲块的起始页号
            list_entry_t *le = list_next(&(buddy_free_area[i].free_list));
            cprintf("    [ ");
            int block_count = 0;
            while (le != &(buddy_free_area[i].free_list)) {
                struct Page *p = le2page(le, page_link);
                // 确保属性正确
                assert(PageProperty(p) && p->property == i);
                cprintf("0x%lx(O%d) ", page2ppn(p), p->property);
                
                // 为了避免输出过长，只显示前几个块
                if (block_count++ > 5) {
                    cprintf("...");
                    break;
                }
                le = list_next(le);
            }
            cprintf(" ]\n");
        } else {
            cprintf("  阶数 %d(%u 页): EMPTY\n", i, 1 << i);
        }
    }
    cprintf("----------------------------------\n");
}
// 检查函数
static void buddy_check(void) {
    // 基础检查
    cprintf("-------------------------------Check Begin-----------------------------------\n");
    
    struct Page *p0, *p1, *p2, *p3;
    size_t total_free_pages = buddy_nr_free_pages();
    buddy_show();
    cprintf("\n-----------Test 1:分配最小块(1)-----------\n");
    
    // 1. 分配最小块 (1页)
    assert((p0 = buddy_alloc_pages(1)) != NULL);
    assert((p1 = buddy_alloc_pages(1)) != NULL);
    assert((p2 = buddy_alloc_pages(1)) != NULL);
    assert(buddy_nr_free_pages() == total_free_pages - 3);
    cprintf("分配3个最小块后...");
    buddy_show();
    
    // 2. 释放最小块
    cprintf("\n-----------Test 2:释放最小块(1页)-----------\n");
    buddy_free_pages(p0, 1);
    buddy_free_pages(p1, 1);
    buddy_free_pages(p2, 1);
    assert(buddy_nr_free_pages() == total_free_pages);
    cprintf("释放3个最小块后...");
    buddy_show();
    
    // 3. 检查大块分配和分裂 
    size_t large_size = 50; 
    
    // 分配 50 页 
    cprintf("\n-----------Test 3:大块分配和分裂-----------\n");
    p0 = buddy_alloc_pages(large_size);
    assert(p0 != NULL);
    assert(buddy_nr_free_pages() == total_free_pages - 64);
    cprintf("分配p0 50页后...");
    buddy_show();
    
    // 分配另一个 50 页块
    p1 = buddy_alloc_pages(large_size);
    assert(p1 != NULL);
    assert(buddy_nr_free_pages() == total_free_pages - 2 * 64);
    cprintf("分配p1 50页后...");
    buddy_show();
    
    // 分配 25 页块
    p2 = buddy_alloc_pages(25);
    assert(p2 != NULL);
    assert(buddy_nr_free_pages() == total_free_pages - 2 * 64 - 32);
    cprintf("分配p2 25页后...");
    buddy_show();
    
    // 检查合并 
    cprintf("\n-----------Test 4:大块释放和合并-----------\n");
    buddy_free_pages(p0, 64);
    cprintf("释放p0后...");
    buddy_show();
    
    buddy_free_pages(p1, 64);
    cprintf("释放p1后...");
    buddy_show();
    
    buddy_free_pages(p2, 32);
    cprintf("释放p2后...");
    buddy_show();
    
    //
    cprintf("\n-----------Test 5:最大单元操作-----------\n");
    p0 = buddy_alloc_pages(16384);
    cprintf("分配p0 16384页后...");
    buddy_show();
    
    buddy_free_pages(p0, 16384);
    cprintf("释放p0后...");
    buddy_show();
    
    cprintf("buddy_check() succeeded!\n");
}

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check
};