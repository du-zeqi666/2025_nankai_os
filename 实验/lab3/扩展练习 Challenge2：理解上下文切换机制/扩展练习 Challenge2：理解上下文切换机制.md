### 扩展练习 Challenge2：理解上下文切换机制 ###

回答：在trapentry.S中汇编代码 csrw sscratch, sp；csrrw s0, sscratch, x0实现了什么操作，目的是什么？save all里面保存了stval scause这些csr，而在restore all里面却不还原它们？那这样store的意义何在呢？

#### trapentry.S代码 ####

```
#include <riscv.h>

    .macro SAVE_ALL    #汇编宏 SAVE_ALL, 用来保存所有寄存器到栈顶（实际上把一个trapFrame结构体放到了栈顶）

    csrw sscratch, sp#保存原先的栈顶指针到sscratch

    addi sp, sp, -36 * REGBYTES
 #REGBYTES是riscv.h定义的常量，表示一个寄存器占据几个字节
    #让栈顶指针向低地址空间延伸 36个寄存器的空间，可以放下一个trapFrame结构体。
    #除了32个通用寄存器，我们还要保存4个和中断有关的CSR

    #依次保存32个通用寄存器。但栈顶指针需要特殊处理。
    #因为我们想在trapFrame里保存分配36个REGBYTES之前的sp
    #也就是保存之前写到sscratch里的sp的值
    STORE x0, 0*REGBYTES(sp)
    STORE x1, 1*REGBYTES(sp)
    STORE x3, 3*REGBYTES(sp)
    STORE x4, 4*REGBYTES(sp)
    STORE x5, 5*REGBYTES(sp)
    STORE x6, 6*REGBYTES(sp)
    STORE x7, 7*REGBYTES(sp)
    STORE x8, 8*REGBYTES(sp)
    STORE x9, 9*REGBYTES(sp)
    STORE x10, 10*REGBYTES(sp)
    STORE x11, 11*REGBYTES(sp)
    STORE x12, 12*REGBYTES(sp)
    STORE x13, 13*REGBYTES(sp)
    STORE x14, 14*REGBYTES(sp)
    STORE x15, 15*REGBYTES(sp)
    STORE x16, 16*REGBYTES(sp)
    STORE x17, 17*REGBYTES(sp)
    STORE x18, 18*REGBYTES(sp)
    STORE x19, 19*REGBYTES(sp)
    STORE x20, 20*REGBYTES(sp)
    STORE x21, 21*REGBYTES(sp)
    STORE x22, 22*REGBYTES(sp)
    STORE x23, 23*REGBYTES(sp)
    STORE x24, 24*REGBYTES(sp)
    STORE x25, 25*REGBYTES(sp)
    STORE x26, 26*REGBYTES(sp)
    STORE x27, 27*REGBYTES(sp)
    STORE x28, 28*REGBYTES(sp)
    STORE x29, 29*REGBYTES(sp)
    STORE x30, 30*REGBYTES(sp)
    STORE x31, 31*REGBYTES(sp)
# RISCV不能直接从CSR写到内存, 需要csrr把CSR读取到通用寄存器，再从通用寄存器STORE到内存
    csrrw s0, sscratch, x0
    csrr s1, sstatus
    csrr s2, sepc
    csrr s3, sbadaddr
    csrr s4, scause

    STORE s0, 2*REGBYTES(sp)
    STORE s1, 32*REGBYTES(sp)
    STORE s2, 33*REGBYTES(sp)
    STORE s3, 34*REGBYTES(sp)
    STORE s4, 35*REGBYTES(sp)
    .endm #汇编宏定义结束

    .macro RESTORE_ALL
#恢复上下文的汇编宏，恢复的顺序和当时保存的顺序反过来，先加载两个CSR, 再加载通用寄存器
    LOAD s1, 32*REGBYTES(sp)
    LOAD s2, 33*REGBYTES(sp)
# 注意之前保存的几个CSR并不都需要恢复
    csrw sstatus, s1
    csrw sepc, s2

# 恢复sp之外的通用寄存器，这时候还需要根据sp来确定其他寄存器数值保存的位置
    LOAD x1, 1*REGBYTES(sp)
    LOAD x3, 3*REGBYTES(sp)
    LOAD x4, 4*REGBYTES(sp)
    LOAD x5, 5*REGBYTES(sp)
    LOAD x6, 6*REGBYTES(sp)
    LOAD x7, 7*REGBYTES(sp)
    LOAD x8, 8*REGBYTES(sp)
    LOAD x9, 9*REGBYTES(sp)
    LOAD x10, 10*REGBYTES(sp)
    LOAD x11, 11*REGBYTES(sp)
    LOAD x12, 12*REGBYTES(sp)
    LOAD x13, 13*REGBYTES(sp)
    LOAD x14, 14*REGBYTES(sp)
    LOAD x15, 15*REGBYTES(sp)
    LOAD x16, 16*REGBYTES(sp)
    LOAD x17, 17*REGBYTES(sp)
    LOAD x18, 18*REGBYTES(sp)
    LOAD x19, 19*REGBYTES(sp)
    LOAD x20, 20*REGBYTES(sp)
    LOAD x21, 21*REGBYTES(sp)
    LOAD x22, 22*REGBYTES(sp)
    LOAD x23, 23*REGBYTES(sp)
    LOAD x24, 24*REGBYTES(sp)
    LOAD x25, 25*REGBYTES(sp)
    LOAD x26, 26*REGBYTES(sp)
    LOAD x27, 27*REGBYTES(sp)
    LOAD x28, 28*REGBYTES(sp)
    LOAD x29, 29*REGBYTES(sp)
    LOAD x30, 30*REGBYTES(sp)
    LOAD x31, 31*REGBYTES(sp)
  # 最后恢复sp
    LOAD x2, 2*REGBYTES(sp)
    .endm
#真正的中断入口点
    .globl __alltraps
    .align(2) #中断入口点 __alltraps必须四字节对齐
__alltraps:
    SAVE_ALL#保存上下文

    move  a0, sp#传递参数
     #按照RISCV calling convention, a0寄存器传递参数给接下来调用的函数trap。
    #trap是trap.c里面的一个C语言函数，也就是我们的中断处理程序
    jal trap
   #trap函数指向完之后，会回到这里向下继续执行__trapret里面的内容，RESTORE_ALL,sret 

    .globl __trapret
__trapret:
    RESTORE_ALL
    # return from supervisor call
    sret

```

 `trapentry.S` 的执行流程：

1. 作为**唯一的陷入入口（trap vector）**
    在内核初始化里，`stvec` 被设置为 `__alltraps`，所以无论是中断还是异常，一发生就会跳到 `__alltraps` 执行，这使它成为 S 模式下的统一入口。  
2. **建立 trapframe：完整保存上下文**
    入口首先执行 `SAVE_ALL` 宏：
   - 把当前 `sp` 暂存进 `sscratch`，为区分内核/用户来源与后续恢复做准备；
   - 在栈上为一个 `trapframe` 预留空间（包含 32 个通用寄存器 + 若干与 trap 相关的 CSR 槽位）；
   - 逐个 `STORE` 所有通用寄存器到栈中；
   - 用 `csrr` 读出 `sstatus / sepc / stval(badvaddr) / scause` 并写入 `trapframe` 对应位置。
      经过该步骤，**当时机状态被“定格”为一个 C 语言可读取的结构体**（`struct trapframe`），为后续 C 层判断类型/原因/返回点提供依据。  
3. **把 trapframe 交给 C 处理逻辑**
    `move a0, sp` 把当前栈顶（正对着 trapframe）作为第 1 参数传给 C 函数 `trap()`，随后 `jal trap` 进入 C 层；C 层会依据 `tf->cause/epc/status/stval` 分发到中断或异常处理，并可按需修改 `tf->epc`（如跳过触发异常的指令），或设置下一次时钟中断等。**这里的关键思想：汇编只做“保存与封装”，决策留给 C。**  
4. **从 trap() 返回后执行“精确恢复”并返回原流**
    `__trapret` 调用 `RESTORE_ALL`：
   - 仅恢复 **`sstatus` 与 `sepc`**（影响返回特权级与返回地址），以及所有通用寄存器；
   - 最后 `sret`，按 `sepc` 返回到被打断/出错的现场（或 C 层改好的新地址），并按 `sstatus` 恢复中断使能与特权级。
      注意：**不会恢复 `scause` / `stval`**——它们是“诊断信息”，给 C 用来判断与打印，恢复无意义。
5. **与内核其他模块的协作关系**
   - 初始化阶段由 `idt_init()` 将 `sscratch=0` 并把 `stvec` 指向 `__alltraps`，完成“接管陷入”的最后一环；
   - 时钟/外设等引发的 trap 统一走 `trapentry.S → trap()` 的路径，C 层里再调用具体的时钟设置、计数与关机逻辑等。

总结：
 **`trapentry.S` 是 S 模式 trap 的“薄包装层”——对硬件现场做“原子快照”（SAVE_ALL），把它打包成 `trapframe` 交给 C 处理，返回时只恢复“会影响继续执行的状态”（`sstatus`/`sepc` + GPR），最后 `sret` 精确回到正确的指令地址继续跑。** 

####  csrw sscratch, sp；csrrw s0, sscratch, x0实现了什么操作，目的是什么？ ####

**回答：这两条汇编指令在中断入口 `trapentry.S` 中的作用，就是为了正确保存“进入中断前的原始 `sp`（栈指针）”到 `trapframe` 结构里。**

------

#####  指令含义（逐条解释） #####

1. **`csrw sscratch, sp`**

   - `csrw` = *write CSR register*（向 CSR 寄存器写值）
   - 作用：**把当前 CPU 正在使用的 `sp` 写入 `sscratch` 寄存器**

    简单理解：

   > *“先把当前的 sp 暂时藏到 sscratch 里。”*

   在中断发生时，CPU 可能来自 **用户态**，也可能来自 **内核态**。用户态的中断会切换到 **内核栈**，但我们仍然需要记住中断发生前的用户态 `sp`，以便恢复。因此，`sscratch` 就起到 **临时存放原始 sp 的保险柜** 的作用。

------

1. **`csrrw s0, sscratch, x0`**

   - `csrrw` = *atomic read & write CSR register*（读–改–写 CSR）
   - **作用：**
     - 将 `sscratch` 里的值读出到 `s0`
     - 同时将 `x0`（恒为0）写入 `sscratch`

    简单理解：

   > *“从 sscratch 取出先前的 sp 保存到 s0，并把 sscratch 清零。”*

------

#####  实际效果（放回上下文理解） #####

结合这两条指令：

| 步骤                     | 操作                         | 目的                                           |
| ------------------------ | ---------------------------- | ---------------------------------------------- |
| `csrw sscratch, sp`      | 保存原始 sp 到 sscratch      | 不丢失用户态原始栈                             |
| `csrrw s0, sscratch, x0` | s0 ← 原来的 sp；sscratch ← 0 | 从 sscratch 取回 sp 放到 trapframe，并清空标识 |

>  `s0` 随后被按照 trapframe 的位置存入内存（见 `STORE s0, 2*REGBYTES(sp)`）
>   `sscratch = 0` 表示当前处理中断发生在内核态（trap.c 中判断是否 trap in kernel）

------

#####  为什么这样设计？ #####

因为中断进入时，寄存器和栈会发生变化。如果是 **用户态 → 内核态**：

- 内核要切换到 *自己的内核栈* 来处理中断
- 如果不提前保存用户的 `sp`，就**无法恢复回用户态**

所以它必须这样：

> 进入中断 → 保存原始 sp → 切换内核栈 → 处理 → 恢复 sp 返回用户态

#####  总结 #####

> `csrw sscratch, sp` 和 `csrrw s0, sscratch, x0` 的组合，就是为了 **安全保存 trap 前的栈指针，并在形成 trapframe 时写入正确位置**，确保中断处理后能够恢复执行。

------

#### save all里面保存了stval scause这些csr，而在restore all里面却不还原它们？那这样store的意义何在呢？ ####

**回答：**`SAVE_ALL` 把 `stval / scause / status / epc` 这些 CSR 保存进 `trapframe` 是 **为了让 C 语言的 trap() 能读到它们用于中断 / 异常处理**，而不是为了在 `RESTORE_ALL` 时恢复它们。

**也就是说：这些 CSR 被保存下来供软件“使用”，不是用来“恢复”。**

------

##### 为什么保存 CSR？ #####

看 `trap.h`，trapframe 的结构体包含：

```c
struct trapframe {
    struct pushregs gpr;
    uintptr_t status;   // sstatus
    uintptr_t epc;      // sepc
    uintptr_t badvaddr; // stval
    uintptr_t cause;    // scause
};
```

这些内容 **会被 trap() / exception_handler() / interrupt_handler() 用来判断 trap 类型、出错地址、恢复点等逻辑**。

例如：

- `scause`：判断是中断还是异常
- `sepc`：决定 trap 返回到哪里
- `stval`：非法访问的虚拟地址
- `sstatus`：记录 trap 前 CPU 状态

> 保存的目的是：**把 trap 当时的机器状态传给 C 语言层**。
>  而不是为了“恢复”这些 CSR 到 trap 前。

证明：trap.c 中读取 `tf->cause`、`tf->epc`、`tf->status` 用于分发处理中断或异常：

```c
static inline void trap_dispatch(struct trapframe *tf) {
    if ((intptr_t)tf->cause < 0) {
        interrupt_handler(tf);
    } else {
        exception_handler(tf);
    }
}
```

------

##### 为什么 restore 不恢复 `scause / stval`？ #####

因为：

> 在 trap 返回（`sret`）时，只需要恢复：
>
> - **通用寄存器**
> - **sstatus**
> - **sepc**

这三个决定了：

1. CPU 状态是否允许中断 (`sstatus`)
2. 从哪里继续执行 (`sepc`)
3. 用户程序继续执行前的通用寄存器内容

但 **`scause`、`stval` 是只读诊断寄存器**，用于报告 trap 原因，它们不影响 CPU 下一步执行。

- trap 结束后，CSR 的内容已经 “过去了”，不会影响继续执行。
- 恢复它们没有意义，也不允许直接恢复（有的 CSR 只读）。

特别是 `scause` 与 `stval`：

> 它们的存在目的 = **报告错误**，不是供恢复。

------

##### 更深层的理解 #####

中断处理的流程是：

```
SAVE_ALL   →   进入 trap()（C 部分利用 trapframe）  →   RESTORE_ALL → sret 返回
```

`trap()` 在处理中断或异常时，会自己决定**是否修改 epc / status**：

例如异常处理中会：

```c
tf->epc += 4;   // 跳过 ecall 或非法指令
```

而最终：

```asm
csrw sepc, s2      // 只恢复 sepc
csrw sstatus, s1   // 只恢复 sstatus
sret               // 返回原先执行的位置
```

> **因为 sepc + sstatus 就足够使 CPU 恢复执行路径和 CPU 状态。**

------

##### 既然不恢复 CSR，为什么还 STORE 到 trapframe？ #####

为了实现：

1. `trap()` 可以知道**是什么 trap**
2. 异常处理时可以用 `stval` 输出**错误地址**
3. 系统调用需要知道**异常发生在哪条指令**
4. 在用户态 trap 时更容易调试/打印信息

**不保存就无法让 C 代码知道 trap 的来源。**

------

##### 总结 #####

> `SAVE_ALL` 保存所有寄存器（包括 CSR）是为了 **把 trap 当时完整 CPU 状态封装成 trapframe，让 C 层 trap() 读取和处理**；
>
> `RESTORE_ALL` 只恢复 **通用寄存器 + sepc + sstatus**，
>  因为 trap 返回只依赖执行地址和状态；
>  `scause / stval` 是只读诊断寄存器，不需要恢复。