### 扩展练习 Challenge：

#### 1.说明语句

`local_intr_save(intr_flag);....local_intr_restore(intr_flag);`是如何实现开关中断的？

riscv/labcode/lab3/kern/sync/sync.h

```c
#ifndef __KERN_SYNC_SYNC_H__
#define __KERN_SYNC_SYNC_H__

#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
        intr_disable();
        return 1;
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
    }
}

#define local_intr_save(x) \
    do {                   \
        x = __intr_save(); \
    } while (0)
#define local_intr_restore(x) __intr_restore(x);

#endif /* !__KERN_SYNC_SYNC_H__ */
```

**1. `local_intr_save(intr_flag)`：**

- 读取 `sstatus` 寄存器中的 `SIE` (Supervisor Interrupt Enable) 位
- 如果中断原本是开启的 (`SIE=1`)：
  - 调用 `intr_disable()` 关闭中断
  - 返回 `1` 并保存到 `intr_flag`
- 如果中断原本就是关闭的 (`SIE=0`)：
  - 返回 `0` 并保存到 `intr_flag`

**2. `local_intr_restore(intr_flag)`：**

- 根据保存的 `intr_flag` 值决定是否重新开启中断
- 只有当中断原本是开启状态时才重新开启

#### 2.深入理解不同分页模式的工作原理（思考题）

get_pte()函数（位于`kern/mm/pmm.c`）用于在页表中查找或创建页表项，从而实现对指定线性地址对应的物理页的访问和映射操作。这在操作系统中的分页机制下，是实现虚拟内存与物理内存之间映射关系非常重要的内容。

```c
// get_pte - get pte and return the kernel virtual address of this pte for la
//        - if the PT contians this pte didn't exist, alloc a page for PT
// parameter:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
    if (!(*pdep1 & PTE_V))
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
    }
    pde_t *pdep0 = &((pte_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
    if (!(*pdep0 & PTE_V))
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
}
```

- get_pte()函数中有两段形式类似的代码， 结合sv32，sv39，sv48的异同，解释这两段代码为什么如此相像。

Sv39 采用 9-9-9-12 的地址划分，每一级都是9位索引

每一级的查找和分配逻辑完全相同：

1. 检查页表项有效性 (`PTE_V`)
2. 如果需要创建且允许创建，分配物理页
3. 初始化页表内容为0
4. 设置页表项权限

在get_pte()函数中，两段类似的代码分别处理Sv39分页模式下的第一级和第二级页表查找与分配。这种相似性源于RISC-V分页模式的对称设计：Sv39采用三级页表结构（9-9-9-12地址划分），每一级都使用9位索引，且处理逻辑完全相同——检查页表项有效性（PTE_V位）、根据需要分配物理页、初始化页面内容并设置页表项权限。这种对称性在Sv32（二级页表）和Sv48（四级页表）中同样存在，尽管级数不同，但每一级的核心操作一致，导致代码重复。

- 目前get_pte()函数将页表项的查找和页表项的分配合并在一个函数里，你认为这种写法好吗？有没有必要把两个功能拆开？

这个我觉得不好说，分开呢，纯查找逻辑可在多个场景使用，我们可以自定义页表项分配与测试查找。但是一般这些操作我们没必要去干，合并后查找分配一起完成，避免可能重复调用遍历页表项的情况，集中处理错误，我觉得就目前而言没啥必要拆开吧