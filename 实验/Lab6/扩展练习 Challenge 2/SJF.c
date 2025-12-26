#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <default_sched.h>
#include <skew_heap.h>

static int
proc_sjf_comp_f(void *a, void *b)
{
     struct proc_struct *p = le2proc(a, lab6_run_pool);
     struct proc_struct *q = le2proc(b, lab6_run_pool);
     int32_t c = p->lab6_priority - q->lab6_priority;
     if (c > 0) return 1;
     else if (c == 0) return 0;
     else return -1;
}

static void
SJF_init(struct run_queue *rq)
{
    rq->lab6_run_pool = NULL;
    rq->proc_num = 0;
}

static void
SJF_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(rq != NULL && proc != NULL);
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, &(proc->lab6_run_pool), proc_sjf_comp_f);
    if (proc->time_slice <= 0) {
        proc->time_slice = rq->max_time_slice;
    }
    proc->rq = rq;
    rq->proc_num ++;
}

static void
SJF_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(rq != NULL && proc != NULL);
    assert(proc->rq == rq);
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, &(proc->lab6_run_pool), proc_sjf_comp_f);
    rq->proc_num --;
}

static struct proc_struct *
SJF_pick_next(struct run_queue *rq)
{
    if (rq->lab6_run_pool == NULL) {
        return NULL;
    }
    struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
    return p;
}

static void
SJF_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // SJF is non-preemptive
}

struct sched_class sjf_sched_class = {
    .name = "SJF_scheduler",
    .init = SJF_init,
    .enqueue = SJF_enqueue,
    .dequeue = SJF_dequeue,
    .pick_next = SJF_pick_next,
    .proc_tick = SJF_proc_tick,
};
