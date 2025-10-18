#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>

/* In the first fit algorithm, the allocator keeps a list of free blocks (known as the free list) and,
   on receiving a request for memory, scans along the list for the first block that is large enough to
   satisfy the request. If the chosen block is significantly larger than that requested, then it is 
   usually split, and the remainder added to the list as another free block.
   Please see Page 196~198, Section 8.2 of Yan Wei Min's chinese book "Data Structure -- C programming language"
*/
// LAB2 EXERCISE 1: YOUR CODE
// you should rewrite functions: default_init,default_init_memmap,default_alloc_pages, default_free_pages.
/*
 * Details of FFMA
 * (1) Prepare: In order to implement the First-Fit Mem Alloc (FFMA), we should manage the free mem block use some list.
 *              The struct free_area_t is used for the management of free mem blocks. At first you should
 *              be familiar to the struct list in list.h. struct list is a simple doubly linked list implementation.
 *              You should know howto USE: list_init, list_add(list_add_after), list_add_before, list_del, list_next, list_prev
 *              Another tricky method is to transform a general list struct to a special struct (such as struct page):
 *              you can find some MACRO: le2page (in memlayout.h), (in future labs: le2vma (in vmm.h), le2proc (in proc.h),etc.)
 * (2) default_init: you can reuse the  demo default_init fun to init the free_list and set nr_free to 0.
 *              free_list is used to record the free mem blocks. nr_free is the total number for free mem blocks.
 * (3) default_init_memmap:  CALL GRAPH: kern_init --> pmm_init-->page_init-->init_memmap--> pmm_manager->init_memmap
 *              This fun is used to init a free block (with parameter: addr_base, page_number).
 *              First you should init each page (in memlayout.h) in this free block, include:
 *                  p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c),
 *                  the bit PG_reserved is setted in p->flags)
 *                  if this page  is free and is not the first page of free block, p->property should be set to 0.
 *                  if this page  is free and is the first page of free block, p->property should be set to total num of block.
 *                  p->ref should be 0, because now p is free and no reference.
 *                  We can use p->page_link to link this page to free_list, (such as: list_add_before(&free_list, &(p->page_link)); )
 *              Finally, we should sum the number of free mem block: nr_free+=n
 * (4) default_alloc_pages: search find a first free block (block size >=n) in free list and reszie the free block, return the addr
 *              of malloced block.
 *              (4.1) So you should search freelist like this:
 *                       list_entry_t le = &free_list;
 *                       while((le=list_next(le)) != &free_list) {
 *                       ....
 *                 (4.1.1) In while loop, get the struct page and check the p->property (record the num of free block) >=n?
 *                       struct Page *p = le2page(le, page_link);
 *                       if(p->property >= n){ ...
 *                 (4.1.2) If we find this p, then it' means we find a free block(block size >=n), and the first n pages can be malloced.
 *                     Some flag bits of this page should be setted: PG_reserved =1, PG_property =0
 *                     unlink the pages from free_list
 *                     (4.1.2.1) If (p->property >n), we should re-caluclate number of the the rest of this free block,
 *                           (such as: le2page(le,page_link))->property = p->property - n;)
 *                 (4.1.3)  re-caluclate nr_free (number of the the rest of all free block)
 *                 (4.1.4)  return p
 *               (4.2) If we can not find a free block (block size >=n), then return NULL
 * (5) default_free_pages: relink the pages into  free list, maybe merge small free blocks into big free blocks.
 *               (5.1) according the base addr of withdrawed blocks, search free list, find the correct position
 *                     (from low to high addr), and insert the pages. (may use list_next, le2page, list_add_before)
 *               (5.2) reset the fields of pages, such as p->ref, p->flags (PageProperty)
 *               (5.3) try to merge low addr or high addr blocks. Notice: should change some pages's p->property correctly.
 */
static free_area_t free_area;

#define free_list (free_area.free_list)//空闲链表头
#define nr_free (free_area.nr_free)//空闲页数

static void
default_init(void) {
    list_init(&free_list);//初始化空闲链表为空
    nr_free = 0;//初始化空闲页数为0
}

static void
default_init_memmap(struct Page *base, size_t n) {//初始化内存块
    assert(n > 0);//确保块大小大于0
    struct Page *p = base;//从块的起始页开始
    for (; p != base + n; p ++) {//遍历块中的每一页
        assert(PageReserved(p));//确保页最初被标记为“保留页”
        p->flags = p->property = 0;//重置页的标志和属性
        set_page_ref(p, 0);//将页引用计数设为0
    }
    base->property = n;//设置块的起始页的属性为块大小
    SetPageProperty(base);//标记该页为“空闲块起点”
    nr_free += n;//更新空闲页总数
    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));//如果空闲链表为空，直接添加块
    } else {//否则找到合适位置插入块
        list_entry_t* le = &free_list;//遍历空闲链表
        while ((le = list_next(le)) != &free_list) {//找到插入位置
            struct Page* page = le2page(le, page_link);//获取当前页
            if (base < page) {
                list_add_before(le, &(base->page_link));
                break;//在找到的位置前插入块
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));//如果到达链表末尾，插入块
            }
        }
    }
}//本函数将 [base, base+n) 范围内的物理页初始化为空闲块；

static struct Page *
default_alloc_pages(size_t n) {//分配连续的n页
    assert(n > 0);//确保请求的页数大于0
    if (n > nr_free) {//如果请求的页数超过空闲页总数
        return NULL;//返回NULL表示无法满足请求
    }
    struct Page *page = NULL;//初始化返回页指针为NULL
    list_entry_t *le = &free_list;//从空闲链表头开始遍历
    while ((le = list_next(le)) != &free_list) {//遍历空闲链表
        struct Page *p = le2page(le, page_link);
        if (p->property >= n) {
            page = p;
            break;
        }
    }  //找到第一个满足请求的空闲块
    if (page != NULL) {
        list_entry_t* prev = list_prev(&(page->page_link));//记录前驱节点位置（便于后续插入）
        list_del(&(page->page_link));//从空闲链表中移除分配的块
        if (page->property > n) {
            struct Page *p = page + n;
            p->property = page->property - n;//更新剩余空闲块的页数属性
            SetPageProperty(p);//标记下一剩余页为“空闲块起点”
            list_add(prev, &(p->page_link));//将剩余块重新插入空闲链表
        }
        nr_free -= n;//更新空闲页总数
        ClearPageProperty(page);//标记分配的页为非空闲
    }//调整空闲链表和空闲页总数
    return page;//返回分配到的空闲块起始页地址
}

static void
default_free_pages(struct Page *base, size_t n) {//释放连续的n页
    assert(n > 0);//确保释放的页数大于0
    struct Page *p = base;//从释放块的起始页开始
    for (; p != base + n; p ++) {
        assert(!PageReserved(p) && !PageProperty(p));//确保页不是“保留页”且不是“空闲块起点”
        p->flags = 0;
        set_page_ref(p, 0);
    }//重置释放块中每一页的标志和引用计数
    base->property = n;//设置释放块起始页的属性为块大小
    SetPageProperty(base);//标记该页为“空闲块起点”
    nr_free += n;//更新空闲页总数

    if (list_empty(&free_list)) {//如果空闲链表为空，直接添加释放块
        list_add(&free_list, &(base->page_link));//添加释放块到空闲链表
    } else {//否则找到合适位置插入释放块
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {//遍历空闲链表
            struct Page* page = le2page(le, page_link);//获取当前页
            if (base < page) {//找到插入位置
                list_add_before(le, &(base->page_link));
                break;
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));//如果到达链表末尾，直接插入释放块
            }
        }
    }

    list_entry_t* le = list_prev(&(base->page_link));//尝试合并低地址相邻块
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (p + p->property == base) {//如果前块的结束地址紧邻当前块起始地址
            p->property += base->property;//合并块
            ClearPageProperty(base);//当前块不再是起点
            list_del(&(base->page_link));//从空闲链表中移除当前块
            base = p;
        }
    }

    le = list_next(&(base->page_link));//尝试合并高地址相邻块
    if (le != &free_list) {//如果当前块的结束地址紧邻后块起始地址
        p = le2page(le, page_link);
        if (base + base->property == p) {
            base->property += p->property;
            ClearPageProperty(p);
            list_del(&(p->page_link));
        }
    }
}

static size_t
default_nr_free_pages(void) {
    return nr_free;//返回当前空闲页总数
}

static void
basic_check(void) {
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);//分配三个页

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);//检查分配的页不相等且引用计数为0

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);//检查分配的页地址合法

    list_entry_t free_list_store = free_list;//保存当前空闲链表状态
    list_init(&free_list);//重置空闲链表
    assert(list_empty(&free_list));//清空空闲链表

    unsigned int nr_free_store = nr_free;//保存当前空闲页数
    nr_free = 0;//重置空闲页数

    assert(alloc_page() == NULL);//尝试分配页，预期失败

    free_page(p0);
    free_page(p1);
    free_page(p2);
    assert(nr_free == 3);//释放三个页，检查空闲页数

    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);//重新分配三个页

    assert(alloc_page() == NULL);//尝试分配第四个页，预期失败

    free_page(p0);
    assert(!list_empty(&free_list));

    struct Page *p;
    assert((p = alloc_page()) == p0);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    free_list = free_list_store;
    nr_free = nr_free_store;

    free_page(p);
    free_page(p1);
    free_page(p2);
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count ++, total += p->property;
    }
    assert(total == nr_free_pages());

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
    assert(p0 != NULL);
    assert(!PageProperty(p0));

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
    assert(alloc_pages(4) == NULL);
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
    assert((p1 = alloc_pages(3)) != NULL);
    assert(alloc_page() == NULL);
    assert(p0 + 2 == p1);

    p2 = p0 + 1;
    free_page(p0);
    free_pages(p1, 3);
    assert(PageProperty(p0) && p0->property == 1);
    assert(PageProperty(p1) && p1->property == 3);

    assert((p0 = alloc_page()) == p2 - 1);
    free_page(p0);
    assert((p0 = alloc_pages(2)) == p2 + 1);

    free_pages(p0, 2);
    free_page(p2);

    assert((p0 = alloc_pages(5)) != NULL);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
    }
    assert(count == 0);
    assert(total == 0);
}

const struct pmm_manager default_pmm_manager = {
    .name = "default_pmm_manager",
    .init = default_init,//初始化函数
    .init_memmap = default_init_memmap,//内存块初始化函数
    .alloc_pages = default_alloc_pages,//页分配函数
    .free_pages = default_free_pages,//页释放函数
    .nr_free_pages = default_nr_free_pages,//空闲页计数函数
    .check = default_check,//检查函数
};//定义默认的物理内存管理器，包含初始化、内存块初始化、页分配、页释放、空闲页计数和检查函数的实现

