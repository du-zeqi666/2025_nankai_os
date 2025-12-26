## Challenge1：完成基于“UNIX的PIPE机制”的设计方案

### 数据结构设计
- 管道核心结构：一个共享环形缓冲区 + 引用计数 + 锁与等待队列。

示例 C 定义：
```c
#define PIPE_BUF_SIZE 65536  /* 或 4096，根据内核/实现选择 */

typedef struct wait_queue {
    /* 等待队列抽象（可用现有内核 wait/monitor/cond 实现替代） */
    /* 这里只给出语义字段占位 */
    void *head;
} wait_queue_t;

typedef struct pipe {
    char *buf;                 /* 环形缓冲区指针，大小为 PIPE_BUF_SIZE */
    size_t size;               /* 缓冲区总容量（PIPE_BUF_SIZE） */
    size_t read_pos;           /* 下一个读位置（环缓冲索引） */
    size_t write_pos;          /* 下一个写位置（环缓冲索引） */
    int readers;               /* 当前打开为读端的文件描述符计数（atomic） */
    int writers;               /* 当前打开为写端的文件描述符计数（atomic） */
    int refcount;              /* 管道对象总引用计数（atomic） */
    spinlock_t lock;          /* 保护上面状态的自旋锁/互斥锁 */
    wait_queue_t read_wait;    /* 读端等待队列（缓冲区为空时等待） */
    wait_queue_t write_wait;   /* 写端等待队列（缓冲区满时等待） */
} pipe_t;

typedef struct pipe_file {
    pipe_t *p;                 /* 指向共享 pipe 对象 */
    int flags;                 /* O_NONBLOCK 等文件标志 */
    int mode;                  /* 只读/只写/读写 标识（只写端或只读端）*/
} pipe_file_t;
```

说明：
- `buf` 可用内核页分配或 kmalloc，推荐按页对齐并使用固定大小以简化实现。
- `read_pos` / `write_pos` 用环形缓冲算法：valid data size = (write_pos - read_pos + size) % size。
- `readers`/`writers` 用作判断 EOF（当 writers==0 且缓冲为空，读返回 0）或当 readers==0 写触发 SIGPIPE/EPIPE。

### 接口语义
- `pipe_create(int fds[2])` $\rightarrow$ `int`
  - 创建一个新的 `pipe_t`，分配缓冲区并初始化锁/等待队列。
  - 在成功时返回两个已打开的文件描述符（`fds[0]` 读端、`fds[1]` 写端），每个对应一个 `pipe_file_t` 对象指向相同的 `pipe_t`。
  - `readers=1， writers=1， refcount=2`。
- `pipe_read(struct file *f， void *buf， size_t count)` $\rightarrow$ `ssize_t`
  - 语义：
    - 在 `lock` 保护下检查缓冲中可读字节 n.
    - 如果 n > 0，复制 min(n， count) 到用户缓冲区，更新 `read_pos`，在必要时唤醒写队列。
    - 如果 n == 0:
      - 若 `writers == 0`：返回 0（EOF）。
      - 若文件为非阻塞（O_NONBLOCK）：返回 -EAGAIN。
      - 否则阻塞（把当前线程加入 `read_wait`，释放 `lock`，睡眠直到被唤醒或信号打断），被唤醒后重试。
    - 处理信号中断：若睡眠被信号中断，返回 `-EINTR`（或部分读取后返回已读字节，视实现而定）。
- `pipe_write(struct file *f， const void *buf， size_t count)` $\rightarrow$ `ssize_t`
  - 语义：
    - 在 `lock` 保护下检查缓冲可写空间 `m = size - used`。
    - 若 m > 0，写入 min(m， count) 字节，更新 `write_pos`，唤醒读队列，返回写入字节数。
    - 若 m == 0:
      - 若 `readers == 0`：产生 SIGPIPE 给当前进程并返回 -EPIPE（或按内核行为先发送信号再返回 EPIPE）。
      - 若文件为非阻塞：返回 `-EAGAIN`。
      - 否则阻塞（加入 `write_wait`，释放 `lock`，睡眠直到唤醒或信号），被唤醒后重试。
    - 对于大于缓冲区大小的单次写，按实现可以循环写入（重复阻塞-唤醒）或在某些实现中限制单次写最大为 PIPE_BUF 保证原子性。
- `pipe_close(struct file *f)` $\rightarrow$ `void`
  - 语义：
    - 关闭端口时，减少 `readers` 或 `writers`，减少 `refcount`。
    - 如果 `refcount` 变为 0，释放 `pipe_t` 及其缓冲区。
    - 在关闭写端时，如果 `writers` 变为 0，应唤醒所有在 `read_wait` 中阻塞的读者，使其看到 EOF。
    - 在关闭读端时，如果 `readers` 变为 0，应唤醒所有在 `write_wait` 中阻塞的写者，使其收到 EPIPE（或在写者被唤醒后检测 readers==0 并返回 `EPIPE`）。
- `pipe_poll/select(pollfd) / pipe_fstat / pipe_ioctl`
  - 支持 `poll`/`select`：读可用时设置 `POLLIN`，`POLLRDNORM`；写可用时设置 `POLLOUT`，`POLLWRNORM`；EOF 时报告 `POLLIN`（可读且返回 0）。
  - 支持 `fcntl` 设置 `O_NONBLOCK` 通过底层 `pipe_file_t->flags`。

### 同步/互斥策略（解决竞态与死锁）
- 单个自旋锁（`spinlock_t lock`）保护对 `read_pos`/`write_pos`/`readers`/`writers`/`refcount` 等共享状态的所有读写访问。所有对缓冲状态的检查与修改都在获得 `lock` 后进行，保证原子性。
- 等待队列（`read_wait`、`write_wait`）用于阻塞线程。阻塞流程：
  - 在持有 `lock` 时判断条件不满足（比如读时缓冲为空），将当前线程加入相应等待队列、释放 `lock` 并睡眠（内核睡眠会做上下文切换）。
  - 其他线程在修改会改变条件的操作（写入/关闭）后，获得 `lock` 并执行 `wake_up()` 来唤醒等待者。
- 原子计数（`readers`/`writers`/`refcount`）用于跨关闭/打开的正确计数判断。更新这些计数建议使用原子操作（如 `atomic_inc/dec`）。
- 避免死锁：阻塞前务必在持有 `lock` 的条件下检查并在加入等待队列之前释放 `lock`（由睡眠/等待实现保证）。唤醒操作应在持有 `lock` 时进行或在修改状态后执行 wake_up（通常 wake_up 不需要持锁，但持锁可以避免竞争；按照内核实现规范选择一致方式）。
- 关于信号与中断：当线程在等待队列睡眠被信号中断时，必须正确恢复 `lock` 并返回 -EINTR 或部分结果。
- 关于写入原子性：POSIX 要求小于等于 `PIPE_BUF` 的写操作是原子的（不会和其他写混合）。实现时当单次写长度 <= PIPE_BUF 而缓冲有足够连续空间（或实现逻辑保证分段写仍被视为原子），应保证完整性；否则，可以限制或复制 Linux 的 `pipe_buffer` 机制来保证单次小写的原子性。

### 错误/边界语义
- 读空且无写端 $\rightarrow$ 返回 0（EOF）。
- 写无读端 $\rightarrow$ 发送 SIGPIPE 并返回 `-EPIPE`。
- 非阻塞 I/O $\rightarrow$ 立即返回 `-EAGAIN`/`EWOULDBLOCK` 而不阻塞。
- 信号中断的睡眠 $\rightarrow$ 返回 `-EINTR`（或返回已完成的部分字节数，需统一实现语义）。
- 资源释放 $\rightarrow$ 管道对象应在所有引用（readers+writers 或 refcount）为 0 时释放。

### 与系统其它部分的集成注意事项
- 与 `file` / `VFS` 交互：管道的读/写应以 `struct file` 的 read/write 回调实现，`file->private_data` 可指向 `pipe_file_t`。（在 ucore 中相应结构名可能不同，但语义一致）
- 权限与安全：管道默认是匿名于创建进程对的内核对象，权限继承自创建进程，只有通过 `pipe2`/`socketpair` 等机制暴露给子进程或通过 fd 传递。
- 内存/页分配：大缓冲区建议按页分配并映射到内核地址空间；若实现用户可 mmap 管道缓冲（高级），需额外同步机制。
- 测试用例：提供阻塞读/写、非阻塞读/写、写时读端关闭（SIGPIPE）、读时写端关闭（EOF）等单元测试。
