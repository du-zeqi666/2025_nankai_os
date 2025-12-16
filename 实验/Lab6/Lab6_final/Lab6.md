# <center>lab6 进程调度

小组成员：

吴禹骞-2311272

谢小珂-2310422

杜泽琦-2313508

[TOC]

## 前期准备

#### 练习0：填写已有实验

本实验依赖实验2/3/4/5。请把你做的实验2/3/4/5的代码填入本实验中代码中有“LAB2”/“LAB3”/“LAB4”“LAB5”的注释相应部分。并确保编译通过。 注意：为了能够正确执行lab6的测试应用程序，可能需对已完成的实验2/3/4/5的代码进行进一步改进。 由于我们在进程控制块中记录了一些和调度有关的信息，例如Stride、优先级、时间片等等，因此我们需要对进程控制块的初始化进行更新，将调度有关的信息初始化。同时，由于时间片轮转的调度算法依赖于时钟中断，你可能也要对时钟中断的处理进行一定的更新。

**Lab2:**

已完整不做处理

**Lab3:**

```c++
// kern/schedule/sched.c
void sched_class_proc_tick(struct proc_struct *proc)
{
    if (proc != idleproc)
    {
        sched_class->proc_tick(rq, proc);
    }
    else
    {
        proc->need_resched = 1;
    }
}
```

- if (proc != idleproc) { sched_class->proc_tick(rq, proc); }
  - 若被滴答的进程不是空闲进程，调用调度类的 `proc_tick`，由调度策略处理该进程的时间片消耗、时间统计、以及是否应当被抢占（可能设置 `proc->need_resched` 或把进程移出就绪队列等）。`rq` 为全局运行队列，`sched_class` 是当前选定的调度算法实现（例如默认调度类）。
- else { proc->need_resched = 1; }
  - 若是 `idleproc` 收到 tick，直接把它标记需要重新调度（`need_resched = 1`），促使 `idleproc` 在下一轮放弃 CPU，让调度器挑选其他可运行进程。空闲进程自身不应占用 CPU 很久，因此直接请求调度。

```c
// 2313508  (update LAB3 steps)
//  在时钟中断时调用调度器的 sched_class_proc_tick 函数
clock_set_next_event();          // (1) 设置下一次时钟中断
ticks++;                         // (2) 计数器 +1
/* 通知调度器当前进程经过一个时钟滴答，可能触发抢占 */
if (current != NULL)
{
sched_class_proc_tick(current);
}
break;
```

**Lab4:**

**alloc_proc**

由于当前

```c
// kern/process/proc.h
struct proc_struct
{
    enum proc_state state;                  // Process state
    int pid;                                // Process ID
    int runs;                               // the running times of Proces
    uintptr_t kstack;                       // Process kernel stack
    volatile bool need_resched;             // bool value: need to be rescheduled to release CPU?
    struct proc_struct *parent;             // the parent process
    struct mm_struct *mm;                   // Process's memory management field
    struct context context;                 // Switch here to run process
    struct trapframe *tf;                   // Trap frame for current interrupt
    uintptr_t pgdir;                        // the base addr of Page Directroy Table(PDT)
    uint32_t flags;                         // Process flag
    char name[PROC_NAME_LEN + 1];           // Process name
    list_entry_t list_link;                 // Process link list
    list_entry_t hash_link;                 // Process hash list
    int exit_code;                          // exit code (be sent to parent proc)
    uint32_t wait_state;                    // waiting state
    struct proc_struct *cptr, *yptr, *optr; // relations between processes
    struct run_queue *rq;                   // running queue contains Process
    list_entry_t run_link;                  // the entry linked in run queue
    int time_slice;                         // time slice for occupying the CPU
    skew_heap_entry_t lab6_run_pool;        // FOR LAB6 ONLY: the entry in the run pool
    uint32_t lab6_stride;                   // FOR LAB6 ONLY: the current stride of the process
    uint32_t lab6_priority;                 // FOR LAB6 ONLY: the priority of process, set by lab6_set_priority(uint32_t)
};
```

所以

```c
// kern/process/proc.c
// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
    if (proc != NULL)
    {
        // LAB4:填写你在lab4中实现的代码
        /*
         * below fields in proc_struct need to be initialized
         *       enum proc_state state;                      // Process state
         *       int pid;                                    // Process ID
         *       int runs;                                   // the running times of Proces
         *       uintptr_t kstack;                           // Process kernel stack
         *       volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
         *       struct proc_struct *parent;                 // the parent process
         *       struct mm_struct *mm;                       // Process's memory management field
         *       struct context context;                     // Switch here to run process
         *       struct trapframe *tf;                       // Trap frame for current interrupt
         *       uintptr_t pgdir;                            // the base addr of Page Directroy Table(PDT)
         *       uint32_t flags;                             // Process flag
         *       char name[PROC_NAME_LEN + 1];               // Process name
         */
        proc->state = PROC_UNINIT;
        proc->pid = -1;
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
        proc->tf = NULL;
        proc->pgdir = 0;  // 实验5修改：改为NULL，后续为每个进程创建独立的页表
        proc->flags = 0;
        memset(proc->name, 0, PROC_NAME_LEN + 1);
        // LAB5:填写你在lab5中实现的代码 (update LAB4 steps)
        /*
         * below fields(add in LAB5) in proc_struct need to be initialized
         *       uint32_t wait_state;                        // waiting state
         *       struct proc_struct *cptr, *yptr, *optr;     // relations between processes
         */

        // LAB5 YOUR CODE : (update LAB4 steps)
        /*
         * below fields(add in LAB5) in proc_struct need to be initialized
         *       uint32_t wait_state;                        // waiting state
         *       struct proc_struct *cptr, *yptr, *optr;     // relations between processes
         */
        proc->wait_state = 0;        // 初始化等待状态
        proc->cptr = NULL;           // 子进程指针
        proc->yptr = NULL;           // 弟弟进程指针  
        proc->optr = NULL;           // 哥哥进程指针
        // LAB6:2313508 (update LAB5 steps)
        /*
         * below fields(add in LAB6) in proc_struct need to be initialized
         *       struct run_queue *rq;                       // run queue contains Process
         *       list_entry_t run_link;                      // the entry linked in run queue
         *       int time_slice;                             // time slice for occupying the CPU
         *       skew_heap_entry_t lab6_run_pool;            // entry in the run pool (lab6 stride)
         *       uint32_t lab6_stride;                       // stride value (lab6 stride)
         *       uint32_t lab6_priority;                     // priority value (lab6 stride)
         */
        proc->rq = NULL;                        // LAB6: 初始时进程不在任何 run_queue 中
	    list_init(&(proc->run_link));           // LAB6: 初始化 run_queue 链表结点
	    proc->time_slice = 0;                   // LAB6: 初始时间片为0，入队时由调度器设置为 max_time_slice
	    skew_heap_init(&(proc->lab6_run_pool)); // LAB6: 初始化斜堆结点(Stride 调度会用到)
	    proc->lab6_stride = 0;                  // LAB6: 初始 stride 为0
	    proc->lab6_priority = 1;                // LAB6: 默认优先级为1(防止除0)
         
    }
    return proc;
}

```

**proc_run**

```c
// kern/process/proc.c
void proc_run(struct proc_struct *proc)
{
    if (proc != current)
    {
        // LAB4:填写你在lab4中实现的代码
        /*
         * Some Useful MACROs, Functions and DEFINEs, you can use them in below implementation.
         * MACROs or Functions:
         *   local_intr_save():        Disable interrupts
         *   local_intr_restore():     Enable Interrupts
         *   lsatp():                   Modify the value of satp register
         *   switch_to():              Context switching between two processes
         */
        bool intr_flag;
        struct proc_struct *prev = current, *next = proc;
        
        // Disable interrupts
        local_intr_save(intr_flag);
        {
            // Switch current process to the new process
            current = proc;
            
            // Switch page table to use new process's address space
            lsatp(next->pgdir);
            
            // Switch context
            switch_to(&(prev->context), &(next->context));
        }
        // Enable interrupts
        local_intr_restore(intr_flag);
    }
}
```

本次实验出现问题，发现报错

![]()

当前 `alloc_proc()` 里把 `proc->pgdir` 初始化成了 `0`（表示“未初始化/特殊情况”）。而你的 `proc_run()` 里**无条件**执行 `lsatp(next->pgdir)` —— 一旦调度从 `idleproc` 切到 `initproc`（这是内核启动后一定会发生的第一次切换），就会把 `satp` 写成基于 `0` 计算出的页表根，**页表根非法 -> 立刻访存异常 -> OpenSBI 打印 `page/access fault handler failed`**。

修改后

```c
// kern/process/proc.c
void proc_run(struct proc_struct *proc)
{
    if (proc != current)
    {
        // LAB4:填写你在lab4中实现的代码
        /*
         * Some Useful MACROs, Functions and DEFINEs, you can use them in below implementation.
         * MACROs or Functions:
         *   local_intr_save():        Disable interrupts
         *   local_intr_restore():     Enable Interrupts
         *   lsatp():                   Modify the value of satp register
         *   switch_to():              Context switching between two processes
         */
        bool intr_flag;
        struct proc_struct *prev = current, *next = proc;
        
        // Disable interrupts
        local_intr_save(intr_flag);
        {
            // Switch current process to the new process
            current = proc;
            
            // Switch page table to use new process's address space
            if (next->pgdir != 0) {                          // 行注释：用户进程/有独立页表的进程
                lsatp(next->pgdir);                          // 行注释：切到该进程的页表根
            } else {
                lsatp(boot_pgdir_pa);                        // 行注释：pgdir==0（内核线程/未初始化）用内核页表根兜底，防止切到非法 satp
            }
            
            // Switch context
            switch_to(&(prev->context), &(next->context));
        }
        // Enable interrupts
        local_intr_restore(intr_flag);
    }
}
```

**do_fork**

```c
// kern/process/proc.c
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
    {
        goto fork_out;
    }
    ret = -E_NO_MEM;
    // LAB4:填写你在lab4中实现的代码
    /*
     * Some Useful MACROs, Functions and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   alloc_proc:   create a proc struct and init fields (lab4:exercise1)
     *   setup_kstack: alloc pages with size KSTACKPAGE as process kernel stack
     *   copy_mm:      process "proc" duplicate OR share process "current"'s mm according clone_flags
     *                 if clone_flags & CLONE_VM, then "share" ; else "duplicate"
     *   copy_thread:  setup the trapframe on the  process's kernel stack top and
     *                 setup the kernel entry point and stack of process
     *   hash_proc:    add proc into proc hash_list
     *   get_pid:      alloc a unique pid for process
     *   wakeup_proc:  set proc->state = PROC_RUNNABLE
     * VARIABLES:
     *   proc_list:    the process set's list
     *   nr_process:   the number of process set
     */

    //    1. call alloc_proc to allocate a proc_struct
    //    2. call setup_kstack to allocate a kernel stack for child process
    //    3. call copy_mm to dup OR share mm according clone_flag
    //    4. call copy_thread to setup tf & context in proc_struct
    //    5. insert proc_struct into hash_list && proc_list
    //    6. call wakeup_proc to make the new child process RUNNABLE
    //    7. set ret vaule using child proc's pid

    // LAB5:填写你在lab5中实现的代码 (update LAB4 steps)
    /* Some Functions
     *    set_links:  set the relation links of process.  ALSO SEE: remove_links:  lean the relation links of process
     *    -------------------
     *    update step 1: set child proc's parent to current process, make sure current process's wait_state is 0
     *    update step 5: insert proc_struct into hash_list && proc_list, set the relation links of process
     */
    //    1. call alloc_proc to allocate a proc_struct
    if ((proc = alloc_proc()) == NULL) {
        goto fork_out;
    }

    // LAB5 UPDATE: set child proc's parent to current process
    proc->parent = current;
    // Make sure current process's wait_state is 0
    assert(current->wait_state == 0);

    //    2. call setup_kstack to allocate a kernel stack for child process
    if (setup_kstack(proc) != 0) {
        goto bad_fork_cleanup_proc;
    }

    //    3. call copy_mm to dup OR share mm according clone_flag
    if (copy_mm(clone_flags, proc) != 0) {
        goto bad_fork_cleanup_kstack;
    }

    //    4. call copy_thread to setup tf & context in proc_struct
    copy_thread(proc, stack, tf);

    //    5. insert proc_struct into hash_list && proc_list
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        proc->pid = get_pid();
        hash_proc(proc);
        // LAB5 UPDATE: use set_links to set relation links instead of list_add
        set_links(proc);
        // list_add(&proc_list, &(proc->list_link));  // 实验4的代码，现在被set_links替代
        //nr_process++;
    }
    local_intr_restore(intr_flag);

    //    6. call wakeup_proc to make the new child process RUNNABLE
    wakeup_proc(proc);

    //    7. set ret vaule using child proc's pid
    ret = proc->pid;
fork_out:
    return ret;

bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
```

**Lab5：**

**copy_range**

```c
// kern/mm/pmm.c
int copy_range(pde_t *to, pde_t *from, uintptr_t start, uintptr_t end,
               bool share)
{
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
    assert(USER_ACCESS(start, end));
    // copy content by page unit.
    do
    {
        // call get_pte to find process A's pte according to the addr start
        pte_t *ptep = get_pte(from, start, 0), *nptep;
        if (ptep == NULL)
        {
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
            continue;
        }
        // call get_pte to find process B's pte according to the addr start. If
        // pte is NULL, just alloc a PT
        if (*ptep & PTE_V)
        {
            if ((nptep = get_pte(to, start, 1)) == NULL)
            {
                return -E_NO_MEM;
            }
            uint32_t perm = (*ptep & PTE_USER);
            // get page from ptep
            struct Page *page = pte2page(*ptep);
            // alloc a page for process B
            struct Page *npage = alloc_page();
            assert(page != NULL);
            assert(npage != NULL);
            int ret = 0;
            /* LAB5:填写你在lab5中实现的代码
             * replicate content of page to npage, build the map of phy addr of
             * nage with the linear addr start
             *
             * Some Useful MACROs and DEFINEs, you can use them in below
             * implementation.
             * MACROs or Functions:
             *    page2kva(struct Page *page): return the kernel vritual addr of
             * memory which page managed (SEE pmm.h)
             *    page_insert: build the map of phy addr of an Page with the
             * linear addr la
             *    memcpy: typical memory copy function
             *
             * (1) find src_kvaddr: the kernel virtual address of page
             * (2) find dst_kvaddr: the kernel virtual address of npage
             * (3) memory copy from src_kvaddr to dst_kvaddr, size is PGSIZE
             * (4) build the map of phy addr of  nage with the linear addr start
             */
            // (1) find src_kvaddr: the kernel virtual address of page
            void *src_kvaddr = page2kva(page);
            // (2) find dst_kvaddr: the kernel virtual address of npage
            void *dst_kvaddr = page2kva(npage);
            // (3) memory copy from src_kvaddr to dst_kvaddr, size is PGSIZE
            memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
            // (4) build the map of phy addr of nage with the linear addr start
            ret = page_insert(to, npage, start, perm);
            assert(ret == 0);
        }
        start += PGSIZE;
    } while (start != 0 && start < end);
    return 0;
}

```

**load_icode**

```c
// kern/process/proc.c
	// 设置用户栈指针为用户栈顶部
    tf->gpr.sp = USTACKTOP;

    // 设置程序入口点为ELF文件的入口地址
    tf->epc = elf->e_entry;

    // setup sstatus for returning to user mode
    // 1. 清掉 SPP 位（表示 sret 返回到 U 模式而不是 S 模式）
    // 2. 置位 SPIE 位（在 sret 后开启用户态中断）
    sstatus &= ~SSTATUS_SPP;   // 清 SPP
    sstatus |= SSTATUS_SPIE;   // 置 SPIE
    tf->status = sstatus;
```

## 实验目的

- 理解操作系统的调度管理机制
- 熟悉 ucore 的系统调度器框架，实现缺省的Round-Robin 调度算法
- 基于调度器框架实现一个(Stride Scheduling)调度算法来替换缺省的调度算法

## 实验内容

在前两章中，我们已经分别实现了内核进程和用户进程，并且让他们正确运行了起来。同时我们也实现了一个简单的调度算法，FIFO调度算法，来对我们的进程进行调度,可通过阅读实验五下的 kern/schedule/sched.c 的 schedule 函数的实现来了解其FIFO调度策略。但是，单单如此就够了吗？显然，我们可以让ucore支持更加丰富的调度算法，从而满足各方面的调度需求。与实验五相比，实验六专门需要针对处理器调度框架和各种算法进行设计与实现，为此对ucore的调度部分进行了适当的修改，使得kern/schedule/sched.c 只实现调度器框架，而不再涉及具体的调度算法实现。而调度算法在单独的文件（default_sched.[ch]）中实现。

在本次实验中，我们在`init/init.c`中加入了对`sched_init`函数的调用。这个函数主要完成调度器和特定调度算法的绑定。初始化后，我们在调度函数中就可以使用相应的接口，切换你实现的不同的调度算法了。这也是在C语言环境下对于面向对象编程模式的一种模仿。这样之后，我们只需要关注于实现调度类的接口即可，操作系统也同样不关心调度类具体的实现，方便了新调度算法的开发。本次实验，主要是熟悉ucore的系统调度器框架，以及基于此框架实现Round-Robin（RR） 调度算法。然后进一步完成Stride调度算法。



## 老师实验视频知识点



## 练习

#### 练习1: 理解调度器框架的实现（不需要编码）

请仔细阅读和分析调度器框架的相关代码，特别是以下两个关键部分的实现：

在完成练习0后，请仔细阅读并分析以下调度器框架的实现：

- 调度类结构体 sched_class 的分析：请详细解释 sched_class 结构体中每个函数指针的作用和调用时机，分析为什么需要将这些函数定义为函数指针，而不是直接实现函数。
- 运行队列结构体 run_queue 的分析：比较lab5和lab6中 run_queue 结构体的差异，解释为什么lab6的 run_queue 需要支持两种数据结构（链表和斜堆）。
- 调度器框架函数分析：分析 sched_init()、wakeup_proc() 和 schedule() 函数在lab6中的实现变化，理解这些函数如何与具体的调度算法解耦。

对于调度器框架的使用流程，请在实验报告中完成以下分析：

- 调度类的初始化流程：描述从内核启动到调度器初始化完成的完整流程，分析 default_sched_class 如何与调度器框架关联。
- 进程调度流程：绘制一个完整的进程调度流程图，包括：时钟中断触发、proc_tick 被调用、schedule() 函数执行、调度类各个函数的调用顺序。并解释 need_resched 标志位在调度过程中的作用
- 调度算法的切换机制：分析如果要添加一个新的调度算法（如stride），需要修改哪些代码？并解释为什么当前的设计使得切换调度算法变得容易。







#### 练习2: 实现 Round Robin 调度算法（需要编码）

完成练习0后，建议大家比较一下（可用kdiff3等文件比较软件）个人完成的lab5和练习0完成后的刚修改的lab6之间的区别，分析了解lab6采用RR调度算法后的执行过程。理解调度器框架的工作原理后，请在此框架下实现时间片轮转（Round Robin）调度算法。

注意有“LAB6”的注释，你需要完成 kern/schedule/default_sched.c 文件中的 RR_init、RR_enqueue、RR_dequeue、RR_pick_next 和 RR_proc_tick 函数的实现，使系统能够正确地进行进程调度。代码中所有需要完成的地方都有“LAB6”和“YOUR CODE”的注释，请在提交时特别注意保持注释，将“YOUR CODE”替换为自己的学号，并且将所有标有对应注释的部分填上正确的代码。

提示，请在实现时注意以下细节：

- 链表操作：list_add_before、list_add_after等。
- 宏的使用：le2proc(le, member) 宏等。
- 边界条件处理：空队列的处理、进程时间片耗尽后的处理、空闲进程的处理等。

请在实验报告中完成：

- 比较一个在lab5和lab6都有, 但是实现不同的函数, 说说为什么要做这个改动, 不做这个改动会出什么问题
  - 提示: 如`kern/schedule/sched.c`里的函数。你也可以找个其他地方做了改动的函数。
- 描述你实现每个函数的具体思路和方法，解释为什么选择特定的链表操作方法。对每个实现函数的关键代码进行解释说明，并解释如何处理**边界情况**。
- 展示 make grade 的**输出结果**，并描述在 QEMU 中观察到的调度现象。

```
make qemu
```

![](pic/2-2.png)

![](pic/2-3.png)

```
make grade
```

![](pic/2-4.png)





















- 分析 Round Robin 调度算法的优缺点，讨论如何调整时间片大小来优化系统性能，并解释为什么需要在 RR_proc_tick 中设置 need_resched 标志。
- **拓展思考**：如果要实现优先级 RR 调度，你的代码需要如何修改？当前的实现是否支持多核调度？如果不支持，需要如何改进？

#### 扩展练习 Challenge 1: 实现 Stride Scheduling 调度算法（需要编码）

首先需要换掉RR调度器的实现，在sched_init中切换调度方法。然后根据此文件和后续文档对Stride度器的相关描述，完成Stride调度算法的实现。 注意有“LAB6”的注释，主要是修改default_sched_stride_c中的内容。代码中所有需要完成的地方都有“LAB6”和“YOUR CODE”的注释，请在提交时特别注意保持注释，将“YOUR CODE”替换为自己的学号，并且将所有标有对应注释的部分填上正确的代码。

后面的实验文档部分给出了Stride调度算法的大体描述。这里给出Stride调度算法的一些相关的资料（目前网上中文的资料比较欠缺）。

- [strid-shed paper location](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.138.3502&rank=1)
- 也可GOOGLE “Stride Scheduling” 来查找相关资料

请在实验报告中完成：

- 简要说明如何设计实现”多级反馈队列调度算法“，给出概要设计，鼓励给出详细设计
- 简要证明/说明（不必特别严谨，但应当能够”说服你自己“），为什么Stride算法中，经过足够多的时间片之后，每个进程分配到的时间片数目和优先级成正比。

请在实验报告中简要说明你的设计实现过程。

#### 扩展练习 Challenge 2 ：在ucore上实现尽可能多的各种基本调度算法(FIFO, SJF,...)，并设计各种测试用例，能够定量地分析出各种调度算法在各种指标上的差异，说明调度算法的适用范围。

#### 扩展阅读：Linux 的 CFS 调度算法 （感兴趣的同学可以学习并实现，不计入成绩）

在ucore的调度器框架下也可以实现Linux的CFS调度算法。可阅读相关Linux内核书籍或查询网上资料，这里给出CFS调度算法的一些相关的资料。

- [CFS 调度器 — Linux 内核文档](https://docs.linuxkernel.org.cn/scheduler/sched-design-CFS.html)
- [Linux完全公平调度(CFS)深度解剖（安卓流畅度核心）](https://www.cnblogs.com/16msyanjiusuo/articles/18720910)
- [一文搞懂linux cfs调度器](https://zhuanlan.zhihu.com/p/556295381)

可通过这些相关资料了解CFS的细节，然后大致实现在ucore中。（可以作为Challenge 2的实现）
