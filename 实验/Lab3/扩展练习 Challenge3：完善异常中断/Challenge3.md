### 扩展练习Challenge3：完善异常中断

#### 1. 补全代码
根据提示，编写异常中断处理代码：
```C
void exception_handler(struct trapframe *tf) {
    switch (tf->cause) {
        case CAUSE_MISALIGNED_FETCH:
            break;
        case CAUSE_FAULT_FETCH:
            break;
        case CAUSE_ILLEGAL_INSTRUCTION:
             // 非法指令异常处理
             /* LAB3 CHALLENGE3   2311272 :  */
            /*(1)输出指令异常类型（ Illegal instruction）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Exception type: Illegal instruction\n");
            cprintf("Illegal instruction caught at 0x%08x\n", tf->epc);
            tf->epc += 4; // 更新 epc 寄存器，跳过当前非法指令
            break;
        case CAUSE_BREAKPOINT:
            //断点异常处理
            /* LAB3 CHALLLENGE3   2311272 :  */
            /*(1)输出指令异常类型（ breakpoint）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Exception type: breakpoint\n");
            cprintf("ebreak caught at 0x%08x\n", tf->epc);
            tf->epc += 4; // 更新 epc 寄存器，跳过 ebreak 指令
            break;
        ...
    }
}
```
#### 2. 测试
编写测试函数`trap_test()`：
```C
void trap_test(void) {
    cprintf("\n============ Test Begin ============\n");
    
    // 测试非法指令
    cprintf("Testing illegal instruction:\n");
    asm volatile(".word 0x00000000");  // 非法指令
    
    cprintf("Testing breakpoint:\n");
    asm volatile("ebreak");  // 断点指令
    
    // 添加一个明确的跳转或 NOP，确保指令流不会意外地再次触发异常
    asm volatile("nop");
    cprintf("============ Tests End ============\n");
}
```

在`kern_init`中调用测试函数，结果如下：
```
============ Test Begin ============
Testing illegal instruction:
Exception type: Illegal instruction
Illegal instruction caught at 0xc0200b5c
Testing breakpoint:
Exception type: breakpoint
ebreak caught at 0xc0200b6c
============ Tests End ============
```
使用 `riscv64-unknown-elf-objdump -d bin/kernel > kernel.asm` 指令对内核进行反汇编，在生成的`kernel.asm`文件中查找`trap_test`函数的标签：
```riscv
ffffffffc0200b40 <trap_test>:
...
ffffffffc0200b58:	d82ff0ef         jal	ffffffffc02000da <cprintf>
ffffffffc0200b5c:	00000000         .word	0x00000000
ffffffffc0200b60:	00002517         auipc	a0,0x2
ffffffffc0200b64:	d3050513         addi	a0,a0,-720 # ffffffffc0202890 <etext+0x908>
ffffffffc0200b68:	d72ff0ef         jal	ffffffffc02000da <cprintf>
ffffffffc0200b6c:	9002             ebreak
ffffffffc0200b6e:	0001             nop
ffffffffc0200b70:	60a2             ld	ra,8(sp)
...
```
可以看到我添加的非法指令地址为0xc0200b5c，断点指令地址为0xc0200b6c，测试结果正确无误。

**注：在 RISC-V 架构中，sbadaddr CSR（控制和状态寄存器）已经被重命名为 stval。需要在`trapentry.S`中将`csrr s3, sbadaddr`改为`csrr s3, stval`**
