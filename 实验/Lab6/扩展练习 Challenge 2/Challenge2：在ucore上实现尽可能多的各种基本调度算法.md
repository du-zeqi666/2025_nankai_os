## Challenge2：在ucore上实现尽可能多的各种基本调度算法(FIFO, SJF,...)，并设计各种测试用例，能够定量地分析出各种调度算法在各种指标上的差异，说明调度算法的适用范围。

### 一、 FIFO调度算法实现

#### 1. 核心数据结构

FIFO 使用双向链表（`list.h` 中的实现）管理就绪队列：

- `run_list`：运行队列的头节点
- `proc_num`：队列中的进程数量
- `proc_struct->run_link`：进程在就绪队列中的链接节点

#### 2.关键函数实现

##### （1) `FIFO_init()`

```c
static void FIFO_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));  // 初始化空链表
    rq->proc_num = 0;            // 进程计数清零
}
```


初始化空就绪队列。

##### (2) `FIFO_enqueue()`

```c
static void FIFO_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(rq != NULL && proc != NULL);
    assert(list_empty(&(proc->run_link)));  // 确保进程不在其他队列中
    
    proc->rq = rq;  // 设置进程所属队列
    
    // 重置时间片（如果为0或负数）
    if (proc->time_slice <= 0) {
        proc->time_slice = rq->max_time_slice;
    }
    
    // 关键：插入到队列尾部（先进先出）
    list_add_before(&(rq->run_list), &(proc->run_link));
    rq->proc_num ++;
}
```

**特点**：使用 `list_add_before(&(rq->run_list), &(proc->run_link))`

- `rq->run_list` 是循环链表的头节点
- `list_add_before` 将新进程插入到头节点之前，相当于插入到队列**尾部**
- 保持了 FIFO 顺序：最早进入的进程在链表头部

##### (3)`FIFO_dequeue()`

```c
static void FIFO_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(rq != NULL && proc != NULL);
    assert(proc->rq == rq);  // 验证进程属于该队列
    
    list_del_init(&(proc->run_link));  // 从链表中移除
    rq->proc_num --;
}
```

从队列中移除指定进程。

##### (4) `FIFO_pick_next()`

```c
static struct proc_struct * FIFO_pick_next(struct run_queue *rq)
{
    if (list_empty(&(rq->run_list))) {
        return NULL;
    }
    // 关键：选择队列头部的进程（最早进入的）
    list_entry_t *le = list_next(&(rq->run_list));
    return le2proc(le, run_link);
}
```

**特点**：

- `list_next(&(rq->run_list))` 获取头节点的下一个节点，即队列**头部**（最早进入的进程）
- 实现了"先来先服务"的选择策略

##### (5) `FIFO_proc_tick()`

```c
static void FIFO_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // FIFO is non-preemptive
}
```

**重要特性**：FIFO 是**非抢占式**调度，时间片中断时不进行抢占。

### 二、SJF 调度算法实现

#### 1. 核心数据结构

SJF 使用**斜堆（Skew Heap）** 优先队列管理就绪队列：

- `lab6_run_pool`：斜堆的根节点
- `proc_struct->lab6_run_pool`：进程在斜堆中的节点
- `proc_struct->lab6_priority`：进程优先级（值越小优先级越高）

#### 2. 关键函数实现

##### (1) 比较函数 `proc_sjf_comp_f()`

```c
static int proc_sjf_comp_f(void *a, void *b)
{
    struct proc_struct *p = le2proc(a, lab6_run_pool);
    struct proc_struct *q = le2proc(b, lab6_run_pool);
    int32_t c = p->lab6_priority - q->lab6_priority;
    if (c > 0) return 1;     // p优先级低于q
    else if (c == 0) return 0; // 优先级相等
    else return -1;           // p优先级高于q
}
```

**特点**：`lab6_priority` 值越小表示作业越短，优先级越高。

##### (2) `SJF_init()`

```c
static void SJF_init(struct run_queue *rq)
{
    rq->lab6_run_pool = NULL;  // 初始化斜堆为空
    rq->proc_num = 0;
}
```

##### (3) `SJF_enqueue()`

```c
static void SJF_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(rq != NULL && proc != NULL);
    
    // 关键：插入到斜堆中，自动维持堆序性质
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, 
                                         &(proc->lab6_run_pool), 
                                         proc_sjf_comp_f);
    
    if (proc->time_slice <= 0) {
        proc->time_slice = rq->max_time_slice;
    }
    proc->rq = rq;
    rq->proc_num ++;
}
```

**特点**：

- 使用 `skew_heap_insert()` 将进程插入斜堆
- 斜堆自动调整结构，保证堆顶是最小优先级值（最短作业）

##### (4) `SJF_dequeue()`

```c
static void SJF_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(rq != NULL && proc != NULL);
    assert(proc->rq == rq);
    
    // 从斜堆中移除指定进程
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, 
                                         &(proc->lab6_run_pool), 
                                         proc_sjf_comp_f);
    rq->proc_num --;
}
```

##### (5) `SJF_pick_next()`

```c
static struct proc_struct * SJF_pick_next(struct run_queue *rq)
{
    if (rq->lab6_run_pool == NULL) {
        return NULL;
    }
    // 关键：选择斜堆根节点（优先级最高/作业最短的进程）
    struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
    return p;
}
```

**核心特性**：

- 斜堆的根节点总是具有最小 `lab6_priority` 值
- 实现了"短作业优先"的选择策略

##### (6) `SJF_proc_tick()`

```c
static void SJF_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // SJF is non-preemptive
}
```

**重要特性**：SJF 也是**非抢占式**调度。


### 三、测试

#### 1. 测试代码

```C
#include <ulib.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_PROCESS_NUM 5
#define WORKLOAD_SMALL  20000000
#define WORKLOAD_LARGE  100000000

// 简单的忙等待模拟计算任务
void work(int amount) {
    volatile int i;
    for (i = 0; i < amount; i++);
}

int main(void) {
    int pids[MAX_PROCESS_NUM];
    int i;
    // 模拟不同长度的任务
    // 0: Short, 1: Long, 2: Short, 3: Long, 4: Short
    int workload[MAX_PROCESS_NUM] = {
        WORKLOAD_SMALL,
        WORKLOAD_LARGE,
        WORKLOAD_SMALL,
        WORKLOAD_LARGE,
        WORKLOAD_SMALL
    };
    
    // 优先级设置
    // 注意：
    // SJF (你的实现): 数值越小优先级越高 (1最高)
    // Stride: 数值越大优先级越高 (步长越小)
    // 为了测试 SJF，我们给短作业设置较小的数值，长作业设置较大的数值
    int priorities[MAX_PROCESS_NUM] = {
        1, // Short -> High Prio (SJF)
        5, // Long  -> Low Prio (SJF)
        2, // Short -> High Prio
        4, // Long  -> Low Prio
        3  // Short -> Medium
    };

    cprintf("Starting scheduling test...\n");
    cprintf("Workloads: S=Small(%d), L=Large(%d)\n", WORKLOAD_SMALL, WORKLOAD_LARGE);
    cprintf("Processes: 0(S), 1(L), 2(S), 3(L), 4(S)\n");

    int start_time = gettime_msec();

    for (i = 0; i < MAX_PROCESS_NUM; i++) {
        if ((pids[i] = fork()) == 0) {
            // 子进程
            lab6_setpriority(priorities[i]); // 设置优先级
            yield(); // 主动让出CPU
            
            int my_pid = getpid();
            int arrival = gettime_msec(); // 记录到达时间
            cprintf("Child %d (PID %d) created. Workload: %d, Prio: %d\n", 
                    i, my_pid, workload[i], priorities[i]);
            
            work(workload[i]); // 执行工作负载
            
            int end = gettime_msec(); // 记录完成时间
            cprintf("Child %d (PID %d) finished at %d ms. Duration: %d ms\n", 
                    i, my_pid, end - start_time, end - arrival);
            exit(0);
        }
    }

    // Parent waits
    cprintf("Parent waiting...\n");
    for (i = 0; i < MAX_PROCESS_NUM; i++) {
        waitpid(pids[i], NULL);
    }

    cprintf("All processes finished.\n");
    return 0;
}

```

测试设计了**5个**进程的配置组合：0(S), 1(L), 2(S), 3(L), 4(S)，交替安排短/长作业。在设置优先级后调用`yield()` 立即主动让出CPU，确保所有进程进入就绪队列后再开始竞争。

#### 2. FIFO调度算法测试结果

```bash
kernel_execve: pid = 2, name = "sched_test".
Starting scheduling test...
Workloads: S=Small(20000000), L=Large(100000000)
Processes: 0(S), 1(L), 2(S), 3(L), 4(S)
Parent waiting...
set priority to 1
set priority to 5
set priority to 2
set priority to 4
set priority to 3
Child 0 (PID 3) created. Workload: 20000000, Prio: 1
Child 0 (PID 3) finished at 60 ms. Duration: 60 ms
Child 1 (PID 4) created. Workload: 100000000, Prio: 5
Child 1 (PID 4) finished at 340 ms. Duration: 280 ms
Child 2 (PID 5) created. Workload: 20000000, Prio: 2
Child 2 (PID 5) finished at 390 ms. Duration: 50 ms
Child 3 (PID 6) created. Workload: 100000000, Prio: 4
Child 3 (PID 6) finished at 660 ms. Duration: 270 ms
Child 4 (PID 7) created. Workload: 20000000, Prio: 3
Child 4 (PID 7) finished at 720 ms. Duration: 60 ms
All processes finished.
all user-mode processes have quit.
init check memory pass.
kernel panic at kern/process/proc.c:567:
    initproc exit.
```

FIFO算法按照进入队列的顺序执行，所以执行顺序应该是0、1、2、3、4，符合预期。

#### 3. SJF调度算法测试结果

```bash
kernel_execve: pid = 2, name = "sched_test".
Starting scheduling test...
Workloads: S=Small(20000000), L=Large(100000000)
Processes: 0(S), 1(L), 2(S), 3(L), 4(S)
Parent waiting...
set priority to 3
set priority to 4
set priority to 2
set priority to 5
set priority to 1
Child 0 (PID 3) created. Workload: 20000000, Prio: 1
Child 0 (PID 3) finished at 60 ms. Duration: 60 ms
Child 2 (PID 5) created. Workload: 20000000, Prio: 2
Child 2 (PID 5) finished at 130 ms. Duration: 70 ms
Child 4 (PID 7) created. Workload: 20000000, Prio: 3
Child 4 (PID 7) finished at 200 ms. Duration: 70 ms
Child 3 (PID 6) created. Workload: 100000000, Prio: 4
Child 3 (PID 6) finished at 520 ms. Duration: 320 ms
Child 1 (PID 4) created. Workload: 100000000, Prio: 5
Child 1 (PID 4) finished at 850 ms. Duration: 320 ms
All processes finished.
all user-mode processes have quit.
```

SJF会根据优先级（优先级数值越小，作业越短，优先级越高）来调度，符合预期。

#### 4. 综合分析

##### (1) FIFO调度量化结果

| 进程 | 完成时间(ms) | 周转时间(ms) | 运行时间(ms) | 等待时间(ms) |
| :--- | :----------- | :----------- | :----------- | :----------- |
| 0    | 60           | 60           | 60           | 0            |
| 1    | 340          | 340          | 280          | 60           |
| 2    | 390          | 390          | 50           | 340          |
| 3    | 660          | 660          | 270          | 390          |
| 4    | 720          | 720          | 60           | 660          |

##### (2) SJF调度量化结果

| 进程 | 完成时间(ms) | 周转时间(ms) | 运行时间(ms) | 等待时间(ms) |
| :--- | :----------- | :----------- | :----------- | :----------- |
| 0    | 60           | 60           | 60           | 0            |
| 2    | 130          | 130          | 70           | 60           |
| 4    | 200          | 200          | 70           | 130          |
| 3    | 520          | 520          | 320          | 200          |
| 1    | 850          | 850          | 320          | 530          |

##### (3)关键性能指标对比

**① 平均周转时间**

- **FIFO**: (60+340+390+660+720)/5 = **434ms**
- **SJF**: (60+130+200+520+850)/5 = **352ms**
- **优势**: SJF比FIFO减少 **18.9%**

**② 平均等待时间**

- **FIFO**: (0+60+340+390+660)/5 = **290ms**
- **SJF**: (0+60+130+200+530)/5 = **184ms**
- **优势**: SJF比FIFO减少 **36.6%**

**③ 最大等待时间（最长作业等待）**

- **FIFO**: 进程4等待660ms
- **SJF**: 进程1等待530ms
- **改善**: SJF减少 **19.7%**

**④ 系统吞吐量（5个进程总完成时间）**

- **FIFO**: 720ms完成所有进程
- **SJF**: 850ms完成所有进程
- **差异**: FIFO比SJF快 **15.3%**

**⑤ 公平性指标（等待时间方差）**

- **FIFO**: 方差 = 58960
- **SJF**: 方差 = 34040
- **公平性**: SJF更公平（方差更小）

**⑥ 护航效应影响**

**FIFO护航效应明显**：

- 长作业1阻塞了后续2个短作业
- 短作业2和4的平均等待时间为500ms，是自身运行时间的5-10倍

**SJF减少护航效应**：

- 短作业优先执行
- 但长作业等待时间显著增加

##### (4)适用范围：

- **FIFO**：实现简单，但是可能导致平均等待时间较长，且不利于短作业。适用于作业长度相近且非抢占的场景。
- **SJF**：可以最小化平均等待时间，但是需要知道作业的运行时间（这里用优先级表示），且对长作业不利，可能导致饥饿。适用于可以估计运行时间的批处理系统。
