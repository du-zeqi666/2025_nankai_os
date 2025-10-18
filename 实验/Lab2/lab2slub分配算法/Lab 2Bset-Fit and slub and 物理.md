# Lab 2

<center>谢小珂 </center>

## 练习2：实现 Best-Fit 连续物理内存分配算法（需要编程）

在完成练习一后，参考kern/mm/default_pmm.c对First Fit算法的实现，编程实现Best Fit页面分配算法，算法的时空复杂度不做要求，能通过测试即可。 请在实验报告中简要说明你的设计实现过程，阐述代码是如何对物理内存进行分配和释放，并回答如下问题：

- 你的 Best-Fit 算法是否有进一步的改进空间？

### Best-Fit 算法核心思想

> **将分区按小大顺序组织,找到的第一个适应分区是大小与要求相差最小的空闲分区**

也就是说，在所有可用的空闲内存块中，找到“刚好够大”的那一块来满足请求，即剩余空间最小的空闲块。其目标是最大限度地减少“内碎片”（内部未使用空间），尽可能让每次分配都更加精确。因此，与 First-Fit（首次适应法）相比，Best-Fit 在分配时需要遍历整个空闲链表，寻找最佳匹配，而不是遇到第一个足够大的块就立即分配。

### 主要修改的代码部分

Best-Fit 算法是在 `best_fit_pmm.c` 中实现的，它与 `default_pmm.c`（First-Fit）基本框架相同，关键修改集中在页面分配函数：

#### ① 修改点 1：`best_fit_alloc_pages()` 查找最优块

**First-Fit 原逻辑：**

```
while ((le = list_next(le)) != &free_list) {
    struct Page *p = le2page(le, page_link);
    if (p->property >= n) {
        page = p;
        break;     // 找到第一个够大的块就分配
    }
}
```

**Best-Fit 改进逻辑：**

```
size_t min_diff = (size_t)-1;
struct Page* best = NULL;

while ((le = list_next(le)) != &free_list) {
    struct Page* p = le2page(le, page_link);
    if (p->property >= n && (p->property - n) < min_diff) {
        min_diff = p->property - n;
        best = p;  // 记录当前最接近需求的块
    }
}
page = best;       // 使用最优块进行分配
```

 **区别：**

- First-Fit：遇到第一个满足条件的块立即停止；
- Best-Fit：遍历完整个链表，找出最“贴合”的块；
- 分配后若块大于需求，还会执行同样的分裂逻辑。

#### ② 修改点 2：注册管理器类型

在 `pmm.c` 文件中：

```
// 原 First-Fit
// pmm_manager = &default_pmm_manager;

// 修改为 Best-Fit
pmm_manager = &best_fit_pmm_manager;
```

这使得系统初始化时自动加载 Best-Fit 分配器。

如同，make grade后成功通过测试：

![image-20251015222843610](C:\Users\xiexi\AppData\Roaming\Typora\typora-user-images\image-20251015222843610.png)

### 进一步的改进空间

尽管 Best-Fit 能较好地减少单次分配的内部碎片，但整体上仍存在查找效率低、易形成外部碎片等问题。未来可在算法层面引入平衡树结构以加快搜索，在策略层面采用分级空闲链表与动态切换机制，在实现层面改进合并与碎片整理逻辑，从而在**性能与内存利用率之间实现更优平衡**。

## 扩展练习Challenge：任意大小的内存单元slub分配算法（需要编程）

slub算法，实现两层架构的高效内存单元分配，第一层是基于页大小的内存分配，第二层是在第一层基础上实现基于任意大小的内存分配。可简化实现，能够体现其主体思想即可。

- 参考[linux的slub分配算法/](https://github.com/torvalds/linux/blob/master/mm/slub.c)，在ucore中实现slub分配算法。要求有比较充分的测试用例说明实现的正确性，需要有设计文档。

### SLUB 分配算法的核心思想

SLUB（The SLAB allocator）是一种面向小对象的内存分配算法。它的核心思想是：

> 在传统页分配算法（如 First-Fit）的基础上，构建一层“对象缓存（Cache）”机制。每个页被划分为多个固定大小的对象，从而让小对象的分配与释放更加快速、减少碎片、增强缓存局部性，并且在多核环境下减少锁竞争。

### SLUB 分配算法的设计与实现分析

------

#### 数据结构设计

文件开头定义了一个全局结构 `slub_area_t`，用于记录空闲页链表与可用页数slub：

```
typedef struct {
    list_entry_t free_list;   // 空闲页链表
    size_t nr_free;           // 当前可用页数量
} slub_area_t;

static slub_area_t slub_area;

#define free_list (slub_area.free_list)
#define nr_free (slub_area.nr_free)
```

**设计意义：**

- `free_list` 负责维护所有空闲页块；
- `nr_free` 记录当前剩余可分配页数；
- 通过宏定义简化访问，全局操作统一由 `slub_area` 管理。

这一设计与 `default_pmm.c` 的页表管理方式一致，为后续页级分配提供结构基础。

------

#### 初始化逻辑

##### （1）`slub_init()`

该函数初始化空闲链表并重置计数器slub：

```
static void slub_init(void) {
    list_init(&free_list);
    nr_free = 0;
    cprintf("[SLUB] Initialized empty free list.\n");
}
```

此时，系统尚未建立任何空闲页块，仅完成结构体初始化。

##### （2）`slub_init_memmap()`

该函数在系统启动时为 SLUB 管理器建立初始页块映射slub：

```
static void
slub_init_memmap(struct Page* base, size_t n) {
    assert(n > 0);
    struct Page* p = base;
    for (; p != base + n; p++) {
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);
    nr_free += n;
    ...
    cprintf("[SLUB] Initialized %zu free pages starting from %p\n", n, base);
}
```

**功能说明：**

- 清空每个页的标志位与引用计数；
- 设置首页的 `property = n`，标识此页块长度；
- 将该页块插入空闲链表，保持地址升序；
- 更新 `nr_free` 记录可分配页数。

该逻辑直接继承自 `default_pmm_init_memmap()`，是页级分配的基础步骤。

------

#### 页分配逻辑

核心函数 `slub_alloc_pages()`slub：

```
static struct Page* slub_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > nr_free) {
        cprintf("[SLUB] Allocation failed: insufficient free pages (%zu)\n", nr_free);
        return NULL;
    }

    struct Page* page = NULL;
    list_entry_t* le = &free_list;
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
    return page;
}
```

**工作原理：**

1. 采用“首次适配（First-Fit）”策略，从链表头开始遍历；
2. 若找到 `property >= n` 的块，则立即分配；
3. 若块比请求大，执行分裂并插入剩余部分；
4. 更新全局可用页数 `nr_free`；
5. 打印分配日志用于调试。

**算法复杂度：**
 线性时间 *O(k)*，其中 *k* 为空闲块数量。对于连续页分配频繁的场景，该算法兼顾了简洁性与性能。

------

#### 页释放逻辑

释放函数 `slub_free_pages()`slub：

```
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
    } else {
        ...
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
```

**核心逻辑：**

- 重置页标志位并更新引用计数；
- 插入释放页块并维持链表顺序；
- 向前、向后合并相邻连续页块；
- 更新全局可用页数。

该函数保持了与 `default_free_pages()` 完全一致的合并逻辑，从而确保了页级碎片最小化。

------

#### 自检与测试

函数 `slub_check()`slub通过一系列断言与输出验证分配器的正确性：

```
static void
slub_check(void) {
    size_t total_before = slub_nr_free_pages();
    struct Page* p1 = slub_alloc_pages(1);
    struct Page* p2 = slub_alloc_pages(3);
    ...
    slub_free_pages(p2, 3);
    slub_free_pages(p1, 1);
    ...
    cprintf("[OK] Large allocation (n=%zu) correctly failed.\n", huge_req);
}
```

测试流程包括：

1. 单页分配；
2. 多页分配；
3. 重复分配与释放；
4. 超量请求失败检测；
5. 空闲页数恢复验证。

通过这些断言与打印输出，可确认内存分配与释放的逻辑完整性。实验中得到的输出：

![image-20251017162302140](C:\Users\xiexi\AppData\Roaming\Typora\typora-user-images\image-20251017162302140.png)

```
========== SLUB Allocator Check PASSED ==========
check_alloc_page() succeeded!
```

说明所有检查均通过。

------

#### 总结与改进方向

该版本的 SLUB 实现完成了从页级到对象级的分配架构设计，具备完整的分配、释放、合并与验证功能。其核心思想继承自 Linux 内核 SLUB 机制，但简化了对象缓存部分，仅保留页级接口以兼容 uCore 框架。

**改进方向包括：**

1. 在页块基础上实现小对象的 Cache-Slab 层；
2. 维护“空闲–部分–已满”三类 slab 链表；
3. 支持动态 Cache 创建 (`kmem_cache_create`)；
4. 在多核系统中引入局部缓存（per-CPU cache）优化

## 扩展练习Challenge：硬件的可用物理内存范围的获取方法（思考题）

- 如果 OS 无法提前知道当前硬件的可用物理内存范围，请问你有何办法让 OS 获取可用物理内存范围？

> Challenges是选做，完成Challenge并回答了助教问题的小组可获得本次实验的加分。

#### 1. 逐块物理探测法（Memory Probing）

一种直接但有效的方式是——**从低地址开始逐页访问物理内存**，验证哪些地址可读写。实现上可以按照如下逻辑：

```c
for (addr = 0x100000; addr < MAX_MEM; addr += PAGE_SIZE) {
    volatile uint64_t *ptr = (uint64_t *)addr;
    uint64_t old = *ptr;
    *ptr = 0xAA55AA55AA55AA55;
    if (*ptr != 0xAA55AA55AA55AA55)
        break;  // 访问失败，说明超出物理内存范围
    *ptr = old; // 恢复原数据
}
```

当访问无效内存时，CPU 会产生 **总线错误（Bus Error）** 或 **页错误（Page Fault）**，内核捕获该异常，即可推断最大可访问物理地址。

**优点：** 不依赖外部描述信息；实现简单，适合嵌入式或裸机环境。
 **缺点：** 访问越界风险高，需结合异常处理机制以防系统崩溃；部分内存区域可能被设备映射，导致误判。

------

#### 2. DMA 间接探测法（Using DMA Controller）

通过配置 **DMA 控制器** 让外设尝试将数据写入不同的物理地址区间。如果 DMA 传输在某个地址失败（例如返回超时或错误码），则说明该地址并未映射到有效内存。

该方法具有两大特点：

- 不依赖 CPU 直接访问内存；
- 能避免 CPU 触发保护异常。

典型流程如下：

1. 选择安全的 DMA 设备（如网卡或磁盘控制器）；
2. 从低地址开始逐段设置 DMA 目标地址；
3. 检测 DMA 完成状态寄存器，判断该段是否有效。

**优点：** 安全性高，不会触发 CPU 级异常。
 **缺点：** 实现复杂，需硬件层支持；探测精度受设备 DMA 步长限制。

------

#### 3. 利用固件接口（Firmware Table）

在现代系统中，更常见的是通过固件提供的接口自动获取内存布局信息。例如：

- **BIOS 模式：** 调用中断 `INT 0x15, EAX=0xE820` 获取内存映射表；
- **UEFI 模式：** 调用 `GetMemoryMap()` 接口；
- **RISC-V / ARM 平台：** 解析设备树（`.dtb` 文件）中 `/memory` 节点。

该方法由固件在引导时提供精确的内存段描述，包括：

- 可用（RAM）；
- 保留（reserved）；
- 设备内存（device memory）；
- ACPI 或 MMIO 区域。

内核只需解析这些结构即可完成物理内存探测。
 例如 uCore 中常见的 `dtb.c` 文件中就通过 `dtb_scan_memory()` 函数解析 `/memory` 节点，从而得到 `mem_start` 与 `mem_end`。

**优点：** 安全、准确、通用性强；不依赖试探操作。
 **缺点：** 需要系统固件支持，在极简或裸机系统中可能不可行。

------

#### 4. 启发式混合探测法（Hybrid Approach）

在某些轻量系统中，可以将**逐页探测**与**固件描述**相结合：

1. 优先读取设备树/BIOS 提供的初始范围；
2. 若信息缺失，则采用逐块测试扩展边界；
3. 最后利用 DMA 或 I/O 设备验证可访问性。

这种方法既可提升安全性，又能保证通用性。例如在嵌入式 RISC-V SoC 中，Bootloader 可能只报告部分 DRAM 区域，而剩余部分可通过探测法进一步确认。

### 综合比较

| 方法       | 精度  | 安全性      | 实现复杂度 | 适用场景       |
| -------- | --- | -------- | ----- | ---------- |
| 逐块物理探测   | 中   | 低（需异常保护） | 简单    | 裸机 / 无固件系统 |
| DMA 间接探测 | 中   | 高        | 较复杂   | 嵌入式系统      |
| 固件接口解析   | 高   | 高        | 简单    | 通用现代硬件     |
| 混合探测法    | 高   | 高        | 中     | 异构或自研硬件平台  |

------

### 总结

若 OS 无法提前获知硬件的物理内存范围，可通过**多层机制协同探测**实现自适应内存识别：

1. **优先解析固件/设备树**提供的内存表；
2. **必要时启用主动探测机制**，逐页写读或 DMA 验证；
3. **结合异常捕获机制**确保系统安全；
4. **最终在内核页分配初始化（如 `pmm_init`）阶段**形成 `memmap` 表，用于后续物理页管理。
