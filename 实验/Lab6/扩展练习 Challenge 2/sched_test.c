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
            // Child process
            lab6_setpriority(priorities[i]);
            yield();
            
            int my_pid = getpid();
            int arrival = gettime_msec();
            cprintf("Child %d (PID %d) created. Workload: %d, Prio: %d\n", 
                    i, my_pid, workload[i], priorities[i]);
            
            work(workload[i]);
            
            int end = gettime_msec();
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
