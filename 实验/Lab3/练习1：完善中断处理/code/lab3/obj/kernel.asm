
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00007297          	auipc	t0,0x7
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0207000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00007297          	auipc	t0,0x7
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0207008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02062b7          	lui	t0,0xc0206
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c0206137          	lui	sp,0xc0206

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 1. 使用临时寄存器 t1 计算栈顶的精确地址
    lui t1, %hi(bootstacktop)
ffffffffc0200040:	c0206337          	lui	t1,0xc0206
    addi t1, t1, %lo(bootstacktop)
ffffffffc0200044:	00030313          	mv	t1,t1
    # 2. 将精确地址一次性地、安全地传给 sp
    mv sp, t1
ffffffffc0200048:	811a                	mv	sp,t1
    # 现在栈指针已经完美设置，可以安全地调用任何C函数了
    # 然后跳转到 kern_init (不再返回)
    lui t0, %hi(kern_init)
ffffffffc020004a:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020004e:	05428293          	addi	t0,t0,84 # ffffffffc0200054 <kern_init>
    jr t0
ffffffffc0200052:	8282                	jr	t0

ffffffffc0200054 <kern_init>:
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
ffffffffc0200054:	00007517          	auipc	a0,0x7
ffffffffc0200058:	fd450513          	addi	a0,a0,-44 # ffffffffc0207028 <free_area>
ffffffffc020005c:	00007617          	auipc	a2,0x7
ffffffffc0200060:	44460613          	addi	a2,a2,1092 # ffffffffc02074a0 <end>
int kern_init(void) {
ffffffffc0200064:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200066:	8e09                	sub	a2,a2,a0
ffffffffc0200068:	4581                	li	a1,0
int kern_init(void) {
ffffffffc020006a:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020006c:	70f010ef          	jal	ra,ffffffffc0201f7a <memset>
    dtb_init();
ffffffffc0200070:	40e000ef          	jal	ra,ffffffffc020047e <dtb_init>
    cons_init();  // init the console
ffffffffc0200074:	3fc000ef          	jal	ra,ffffffffc0200470 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc0200078:	00002517          	auipc	a0,0x2
ffffffffc020007c:	f1850513          	addi	a0,a0,-232 # ffffffffc0201f90 <etext+0x4>
ffffffffc0200080:	090000ef          	jal	ra,ffffffffc0200110 <cputs>

    print_kerninfo();
ffffffffc0200084:	0dc000ef          	jal	ra,ffffffffc0200160 <print_kerninfo>

    // grade_backtrace();
    idt_init();  // init interrupt descriptor table
ffffffffc0200088:	7b2000ef          	jal	ra,ffffffffc020083a <idt_init>

    pmm_init();  // init physical memory management
ffffffffc020008c:	772010ef          	jal	ra,ffffffffc02017fe <pmm_init>

    idt_init();  // init interrupt descriptor table
ffffffffc0200090:	7aa000ef          	jal	ra,ffffffffc020083a <idt_init>

    clock_init();   // init clock interrupt
ffffffffc0200094:	39a000ef          	jal	ra,ffffffffc020042e <clock_init>
    intr_enable();  // enable irq interrupt
ffffffffc0200098:	796000ef          	jal	ra,ffffffffc020082e <intr_enable>

    /* do nothing */
    while (1)
ffffffffc020009c:	a001                	j	ffffffffc020009c <kern_init+0x48>

ffffffffc020009e <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020009e:	1141                	addi	sp,sp,-16
ffffffffc02000a0:	e022                	sd	s0,0(sp)
ffffffffc02000a2:	e406                	sd	ra,8(sp)
ffffffffc02000a4:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc02000a6:	3cc000ef          	jal	ra,ffffffffc0200472 <cons_putc>
    (*cnt) ++;
ffffffffc02000aa:	401c                	lw	a5,0(s0)
}
ffffffffc02000ac:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc02000ae:	2785                	addiw	a5,a5,1
ffffffffc02000b0:	c01c                	sw	a5,0(s0)
}
ffffffffc02000b2:	6402                	ld	s0,0(sp)
ffffffffc02000b4:	0141                	addi	sp,sp,16
ffffffffc02000b6:	8082                	ret

ffffffffc02000b8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000b8:	1101                	addi	sp,sp,-32
ffffffffc02000ba:	862a                	mv	a2,a0
ffffffffc02000bc:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000be:	00000517          	auipc	a0,0x0
ffffffffc02000c2:	fe050513          	addi	a0,a0,-32 # ffffffffc020009e <cputch>
ffffffffc02000c6:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000c8:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000ca:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000cc:	17f010ef          	jal	ra,ffffffffc0201a4a <vprintfmt>
    return cnt;
}
ffffffffc02000d0:	60e2                	ld	ra,24(sp)
ffffffffc02000d2:	4532                	lw	a0,12(sp)
ffffffffc02000d4:	6105                	addi	sp,sp,32
ffffffffc02000d6:	8082                	ret

ffffffffc02000d8 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000d8:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000da:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000de:	8e2a                	mv	t3,a0
ffffffffc02000e0:	f42e                	sd	a1,40(sp)
ffffffffc02000e2:	f832                	sd	a2,48(sp)
ffffffffc02000e4:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000e6:	00000517          	auipc	a0,0x0
ffffffffc02000ea:	fb850513          	addi	a0,a0,-72 # ffffffffc020009e <cputch>
ffffffffc02000ee:	004c                	addi	a1,sp,4
ffffffffc02000f0:	869a                	mv	a3,t1
ffffffffc02000f2:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000f4:	ec06                	sd	ra,24(sp)
ffffffffc02000f6:	e0ba                	sd	a4,64(sp)
ffffffffc02000f8:	e4be                	sd	a5,72(sp)
ffffffffc02000fa:	e8c2                	sd	a6,80(sp)
ffffffffc02000fc:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02000fe:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc0200100:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200102:	149010ef          	jal	ra,ffffffffc0201a4a <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc0200106:	60e2                	ld	ra,24(sp)
ffffffffc0200108:	4512                	lw	a0,4(sp)
ffffffffc020010a:	6125                	addi	sp,sp,96
ffffffffc020010c:	8082                	ret

ffffffffc020010e <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc020010e:	a695                	j	ffffffffc0200472 <cons_putc>

ffffffffc0200110 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200110:	1101                	addi	sp,sp,-32
ffffffffc0200112:	e822                	sd	s0,16(sp)
ffffffffc0200114:	ec06                	sd	ra,24(sp)
ffffffffc0200116:	e426                	sd	s1,8(sp)
ffffffffc0200118:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc020011a:	00054503          	lbu	a0,0(a0)
ffffffffc020011e:	c51d                	beqz	a0,ffffffffc020014c <cputs+0x3c>
ffffffffc0200120:	0405                	addi	s0,s0,1
ffffffffc0200122:	4485                	li	s1,1
ffffffffc0200124:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200126:	34c000ef          	jal	ra,ffffffffc0200472 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc020012a:	00044503          	lbu	a0,0(s0)
ffffffffc020012e:	008487bb          	addw	a5,s1,s0
ffffffffc0200132:	0405                	addi	s0,s0,1
ffffffffc0200134:	f96d                	bnez	a0,ffffffffc0200126 <cputs+0x16>
    (*cnt) ++;
ffffffffc0200136:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc020013a:	4529                	li	a0,10
ffffffffc020013c:	336000ef          	jal	ra,ffffffffc0200472 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200140:	60e2                	ld	ra,24(sp)
ffffffffc0200142:	8522                	mv	a0,s0
ffffffffc0200144:	6442                	ld	s0,16(sp)
ffffffffc0200146:	64a2                	ld	s1,8(sp)
ffffffffc0200148:	6105                	addi	sp,sp,32
ffffffffc020014a:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc020014c:	4405                	li	s0,1
ffffffffc020014e:	b7f5                	j	ffffffffc020013a <cputs+0x2a>

ffffffffc0200150 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200150:	1141                	addi	sp,sp,-16
ffffffffc0200152:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200154:	326000ef          	jal	ra,ffffffffc020047a <cons_getc>
ffffffffc0200158:	dd75                	beqz	a0,ffffffffc0200154 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020015a:	60a2                	ld	ra,8(sp)
ffffffffc020015c:	0141                	addi	sp,sp,16
ffffffffc020015e:	8082                	ret

ffffffffc0200160 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200160:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200162:	00002517          	auipc	a0,0x2
ffffffffc0200166:	e4e50513          	addi	a0,a0,-434 # ffffffffc0201fb0 <etext+0x24>
void print_kerninfo(void) {
ffffffffc020016a:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc020016c:	f6dff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", kern_init);
ffffffffc0200170:	00000597          	auipc	a1,0x0
ffffffffc0200174:	ee458593          	addi	a1,a1,-284 # ffffffffc0200054 <kern_init>
ffffffffc0200178:	00002517          	auipc	a0,0x2
ffffffffc020017c:	e5850513          	addi	a0,a0,-424 # ffffffffc0201fd0 <etext+0x44>
ffffffffc0200180:	f59ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc0200184:	00002597          	auipc	a1,0x2
ffffffffc0200188:	e0858593          	addi	a1,a1,-504 # ffffffffc0201f8c <etext>
ffffffffc020018c:	00002517          	auipc	a0,0x2
ffffffffc0200190:	e6450513          	addi	a0,a0,-412 # ffffffffc0201ff0 <etext+0x64>
ffffffffc0200194:	f45ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200198:	00007597          	auipc	a1,0x7
ffffffffc020019c:	e9058593          	addi	a1,a1,-368 # ffffffffc0207028 <free_area>
ffffffffc02001a0:	00002517          	auipc	a0,0x2
ffffffffc02001a4:	e7050513          	addi	a0,a0,-400 # ffffffffc0202010 <etext+0x84>
ffffffffc02001a8:	f31ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc02001ac:	00007597          	auipc	a1,0x7
ffffffffc02001b0:	2f458593          	addi	a1,a1,756 # ffffffffc02074a0 <end>
ffffffffc02001b4:	00002517          	auipc	a0,0x2
ffffffffc02001b8:	e7c50513          	addi	a0,a0,-388 # ffffffffc0202030 <etext+0xa4>
ffffffffc02001bc:	f1dff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc02001c0:	00007597          	auipc	a1,0x7
ffffffffc02001c4:	6df58593          	addi	a1,a1,1759 # ffffffffc020789f <end+0x3ff>
ffffffffc02001c8:	00000797          	auipc	a5,0x0
ffffffffc02001cc:	e8c78793          	addi	a5,a5,-372 # ffffffffc0200054 <kern_init>
ffffffffc02001d0:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001d4:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc02001d8:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001da:	3ff5f593          	andi	a1,a1,1023
ffffffffc02001de:	95be                	add	a1,a1,a5
ffffffffc02001e0:	85a9                	srai	a1,a1,0xa
ffffffffc02001e2:	00002517          	auipc	a0,0x2
ffffffffc02001e6:	e6e50513          	addi	a0,a0,-402 # ffffffffc0202050 <etext+0xc4>
}
ffffffffc02001ea:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001ec:	b5f5                	j	ffffffffc02000d8 <cprintf>

ffffffffc02001ee <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc02001ee:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02001f0:	00002617          	auipc	a2,0x2
ffffffffc02001f4:	e9060613          	addi	a2,a2,-368 # ffffffffc0202080 <etext+0xf4>
ffffffffc02001f8:	04d00593          	li	a1,77
ffffffffc02001fc:	00002517          	auipc	a0,0x2
ffffffffc0200200:	e9c50513          	addi	a0,a0,-356 # ffffffffc0202098 <etext+0x10c>
void print_stackframe(void) {
ffffffffc0200204:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200206:	1cc000ef          	jal	ra,ffffffffc02003d2 <__panic>

ffffffffc020020a <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020020a:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020020c:	00002617          	auipc	a2,0x2
ffffffffc0200210:	ea460613          	addi	a2,a2,-348 # ffffffffc02020b0 <etext+0x124>
ffffffffc0200214:	00002597          	auipc	a1,0x2
ffffffffc0200218:	ebc58593          	addi	a1,a1,-324 # ffffffffc02020d0 <etext+0x144>
ffffffffc020021c:	00002517          	auipc	a0,0x2
ffffffffc0200220:	ebc50513          	addi	a0,a0,-324 # ffffffffc02020d8 <etext+0x14c>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200224:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200226:	eb3ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
ffffffffc020022a:	00002617          	auipc	a2,0x2
ffffffffc020022e:	ebe60613          	addi	a2,a2,-322 # ffffffffc02020e8 <etext+0x15c>
ffffffffc0200232:	00002597          	auipc	a1,0x2
ffffffffc0200236:	ede58593          	addi	a1,a1,-290 # ffffffffc0202110 <etext+0x184>
ffffffffc020023a:	00002517          	auipc	a0,0x2
ffffffffc020023e:	e9e50513          	addi	a0,a0,-354 # ffffffffc02020d8 <etext+0x14c>
ffffffffc0200242:	e97ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
ffffffffc0200246:	00002617          	auipc	a2,0x2
ffffffffc020024a:	eda60613          	addi	a2,a2,-294 # ffffffffc0202120 <etext+0x194>
ffffffffc020024e:	00002597          	auipc	a1,0x2
ffffffffc0200252:	ef258593          	addi	a1,a1,-270 # ffffffffc0202140 <etext+0x1b4>
ffffffffc0200256:	00002517          	auipc	a0,0x2
ffffffffc020025a:	e8250513          	addi	a0,a0,-382 # ffffffffc02020d8 <etext+0x14c>
ffffffffc020025e:	e7bff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    }
    return 0;
}
ffffffffc0200262:	60a2                	ld	ra,8(sp)
ffffffffc0200264:	4501                	li	a0,0
ffffffffc0200266:	0141                	addi	sp,sp,16
ffffffffc0200268:	8082                	ret

ffffffffc020026a <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc020026a:	1141                	addi	sp,sp,-16
ffffffffc020026c:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020026e:	ef3ff0ef          	jal	ra,ffffffffc0200160 <print_kerninfo>
    return 0;
}
ffffffffc0200272:	60a2                	ld	ra,8(sp)
ffffffffc0200274:	4501                	li	a0,0
ffffffffc0200276:	0141                	addi	sp,sp,16
ffffffffc0200278:	8082                	ret

ffffffffc020027a <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc020027a:	1141                	addi	sp,sp,-16
ffffffffc020027c:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020027e:	f71ff0ef          	jal	ra,ffffffffc02001ee <print_stackframe>
    return 0;
}
ffffffffc0200282:	60a2                	ld	ra,8(sp)
ffffffffc0200284:	4501                	li	a0,0
ffffffffc0200286:	0141                	addi	sp,sp,16
ffffffffc0200288:	8082                	ret

ffffffffc020028a <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc020028a:	7115                	addi	sp,sp,-224
ffffffffc020028c:	ed5e                	sd	s7,152(sp)
ffffffffc020028e:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200290:	00002517          	auipc	a0,0x2
ffffffffc0200294:	ec050513          	addi	a0,a0,-320 # ffffffffc0202150 <etext+0x1c4>
kmonitor(struct trapframe *tf) {
ffffffffc0200298:	ed86                	sd	ra,216(sp)
ffffffffc020029a:	e9a2                	sd	s0,208(sp)
ffffffffc020029c:	e5a6                	sd	s1,200(sp)
ffffffffc020029e:	e1ca                	sd	s2,192(sp)
ffffffffc02002a0:	fd4e                	sd	s3,184(sp)
ffffffffc02002a2:	f952                	sd	s4,176(sp)
ffffffffc02002a4:	f556                	sd	s5,168(sp)
ffffffffc02002a6:	f15a                	sd	s6,160(sp)
ffffffffc02002a8:	e962                	sd	s8,144(sp)
ffffffffc02002aa:	e566                	sd	s9,136(sp)
ffffffffc02002ac:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002ae:	e2bff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02002b2:	00002517          	auipc	a0,0x2
ffffffffc02002b6:	ec650513          	addi	a0,a0,-314 # ffffffffc0202178 <etext+0x1ec>
ffffffffc02002ba:	e1fff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    if (tf != NULL) {
ffffffffc02002be:	000b8563          	beqz	s7,ffffffffc02002c8 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc02002c2:	855e                	mv	a0,s7
ffffffffc02002c4:	756000ef          	jal	ra,ffffffffc0200a1a <print_trapframe>
ffffffffc02002c8:	00002c17          	auipc	s8,0x2
ffffffffc02002cc:	f20c0c13          	addi	s8,s8,-224 # ffffffffc02021e8 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002d0:	00002917          	auipc	s2,0x2
ffffffffc02002d4:	ed090913          	addi	s2,s2,-304 # ffffffffc02021a0 <etext+0x214>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02002d8:	00002497          	auipc	s1,0x2
ffffffffc02002dc:	ed048493          	addi	s1,s1,-304 # ffffffffc02021a8 <etext+0x21c>
        if (argc == MAXARGS - 1) {
ffffffffc02002e0:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02002e2:	00002b17          	auipc	s6,0x2
ffffffffc02002e6:	eceb0b13          	addi	s6,s6,-306 # ffffffffc02021b0 <etext+0x224>
        argv[argc ++] = buf;
ffffffffc02002ea:	00002a17          	auipc	s4,0x2
ffffffffc02002ee:	de6a0a13          	addi	s4,s4,-538 # ffffffffc02020d0 <etext+0x144>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02002f2:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002f4:	854a                	mv	a0,s2
ffffffffc02002f6:	2d7010ef          	jal	ra,ffffffffc0201dcc <readline>
ffffffffc02002fa:	842a                	mv	s0,a0
ffffffffc02002fc:	dd65                	beqz	a0,ffffffffc02002f4 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02002fe:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc0200302:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200304:	e1bd                	bnez	a1,ffffffffc020036a <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc0200306:	fe0c87e3          	beqz	s9,ffffffffc02002f4 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020030a:	6582                	ld	a1,0(sp)
ffffffffc020030c:	00002d17          	auipc	s10,0x2
ffffffffc0200310:	edcd0d13          	addi	s10,s10,-292 # ffffffffc02021e8 <commands>
        argv[argc ++] = buf;
ffffffffc0200314:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200316:	4401                	li	s0,0
ffffffffc0200318:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020031a:	407010ef          	jal	ra,ffffffffc0201f20 <strcmp>
ffffffffc020031e:	c919                	beqz	a0,ffffffffc0200334 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200320:	2405                	addiw	s0,s0,1
ffffffffc0200322:	0b540063          	beq	s0,s5,ffffffffc02003c2 <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200326:	000d3503          	ld	a0,0(s10)
ffffffffc020032a:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020032c:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020032e:	3f3010ef          	jal	ra,ffffffffc0201f20 <strcmp>
ffffffffc0200332:	f57d                	bnez	a0,ffffffffc0200320 <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200334:	00141793          	slli	a5,s0,0x1
ffffffffc0200338:	97a2                	add	a5,a5,s0
ffffffffc020033a:	078e                	slli	a5,a5,0x3
ffffffffc020033c:	97e2                	add	a5,a5,s8
ffffffffc020033e:	6b9c                	ld	a5,16(a5)
ffffffffc0200340:	865e                	mv	a2,s7
ffffffffc0200342:	002c                	addi	a1,sp,8
ffffffffc0200344:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200348:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc020034a:	fa0555e3          	bgez	a0,ffffffffc02002f4 <kmonitor+0x6a>
}
ffffffffc020034e:	60ee                	ld	ra,216(sp)
ffffffffc0200350:	644e                	ld	s0,208(sp)
ffffffffc0200352:	64ae                	ld	s1,200(sp)
ffffffffc0200354:	690e                	ld	s2,192(sp)
ffffffffc0200356:	79ea                	ld	s3,184(sp)
ffffffffc0200358:	7a4a                	ld	s4,176(sp)
ffffffffc020035a:	7aaa                	ld	s5,168(sp)
ffffffffc020035c:	7b0a                	ld	s6,160(sp)
ffffffffc020035e:	6bea                	ld	s7,152(sp)
ffffffffc0200360:	6c4a                	ld	s8,144(sp)
ffffffffc0200362:	6caa                	ld	s9,136(sp)
ffffffffc0200364:	6d0a                	ld	s10,128(sp)
ffffffffc0200366:	612d                	addi	sp,sp,224
ffffffffc0200368:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020036a:	8526                	mv	a0,s1
ffffffffc020036c:	3f9010ef          	jal	ra,ffffffffc0201f64 <strchr>
ffffffffc0200370:	c901                	beqz	a0,ffffffffc0200380 <kmonitor+0xf6>
ffffffffc0200372:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc0200376:	00040023          	sb	zero,0(s0)
ffffffffc020037a:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020037c:	d5c9                	beqz	a1,ffffffffc0200306 <kmonitor+0x7c>
ffffffffc020037e:	b7f5                	j	ffffffffc020036a <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc0200380:	00044783          	lbu	a5,0(s0)
ffffffffc0200384:	d3c9                	beqz	a5,ffffffffc0200306 <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc0200386:	033c8963          	beq	s9,s3,ffffffffc02003b8 <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc020038a:	003c9793          	slli	a5,s9,0x3
ffffffffc020038e:	0118                	addi	a4,sp,128
ffffffffc0200390:	97ba                	add	a5,a5,a4
ffffffffc0200392:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200396:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc020039a:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc020039c:	e591                	bnez	a1,ffffffffc02003a8 <kmonitor+0x11e>
ffffffffc020039e:	b7b5                	j	ffffffffc020030a <kmonitor+0x80>
ffffffffc02003a0:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02003a4:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003a6:	d1a5                	beqz	a1,ffffffffc0200306 <kmonitor+0x7c>
ffffffffc02003a8:	8526                	mv	a0,s1
ffffffffc02003aa:	3bb010ef          	jal	ra,ffffffffc0201f64 <strchr>
ffffffffc02003ae:	d96d                	beqz	a0,ffffffffc02003a0 <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003b0:	00044583          	lbu	a1,0(s0)
ffffffffc02003b4:	d9a9                	beqz	a1,ffffffffc0200306 <kmonitor+0x7c>
ffffffffc02003b6:	bf55                	j	ffffffffc020036a <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003b8:	45c1                	li	a1,16
ffffffffc02003ba:	855a                	mv	a0,s6
ffffffffc02003bc:	d1dff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
ffffffffc02003c0:	b7e9                	j	ffffffffc020038a <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc02003c2:	6582                	ld	a1,0(sp)
ffffffffc02003c4:	00002517          	auipc	a0,0x2
ffffffffc02003c8:	e0c50513          	addi	a0,a0,-500 # ffffffffc02021d0 <etext+0x244>
ffffffffc02003cc:	d0dff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    return 0;
ffffffffc02003d0:	b715                	j	ffffffffc02002f4 <kmonitor+0x6a>

ffffffffc02003d2 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02003d2:	00007317          	auipc	t1,0x7
ffffffffc02003d6:	06e30313          	addi	t1,t1,110 # ffffffffc0207440 <is_panic>
ffffffffc02003da:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc02003de:	715d                	addi	sp,sp,-80
ffffffffc02003e0:	ec06                	sd	ra,24(sp)
ffffffffc02003e2:	e822                	sd	s0,16(sp)
ffffffffc02003e4:	f436                	sd	a3,40(sp)
ffffffffc02003e6:	f83a                	sd	a4,48(sp)
ffffffffc02003e8:	fc3e                	sd	a5,56(sp)
ffffffffc02003ea:	e0c2                	sd	a6,64(sp)
ffffffffc02003ec:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02003ee:	020e1a63          	bnez	t3,ffffffffc0200422 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02003f2:	4785                	li	a5,1
ffffffffc02003f4:	00f32023          	sw	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02003f8:	8432                	mv	s0,a2
ffffffffc02003fa:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02003fc:	862e                	mv	a2,a1
ffffffffc02003fe:	85aa                	mv	a1,a0
ffffffffc0200400:	00002517          	auipc	a0,0x2
ffffffffc0200404:	e3050513          	addi	a0,a0,-464 # ffffffffc0202230 <commands+0x48>
    va_start(ap, fmt);
ffffffffc0200408:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc020040a:	ccfff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020040e:	65a2                	ld	a1,8(sp)
ffffffffc0200410:	8522                	mv	a0,s0
ffffffffc0200412:	ca7ff0ef          	jal	ra,ffffffffc02000b8 <vcprintf>
    cprintf("\n");
ffffffffc0200416:	00002517          	auipc	a0,0x2
ffffffffc020041a:	3ea50513          	addi	a0,a0,1002 # ffffffffc0202800 <commands+0x618>
ffffffffc020041e:	cbbff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
ffffffffc0200422:	412000ef          	jal	ra,ffffffffc0200834 <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200426:	4501                	li	a0,0
ffffffffc0200428:	e63ff0ef          	jal	ra,ffffffffc020028a <kmonitor>
    while (1) {
ffffffffc020042c:	bfed                	j	ffffffffc0200426 <__panic+0x54>

ffffffffc020042e <clock_init>:

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
ffffffffc020042e:	1141                	addi	sp,sp,-16
ffffffffc0200430:	e406                	sd	ra,8(sp)
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
ffffffffc0200432:	02000793          	li	a5,32
ffffffffc0200436:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020043a:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020043e:	67e1                	lui	a5,0x18
ffffffffc0200440:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200444:	953e                	add	a0,a0,a5
ffffffffc0200446:	255010ef          	jal	ra,ffffffffc0201e9a <sbi_set_timer>
}
ffffffffc020044a:	60a2                	ld	ra,8(sp)
    ticks = 0;
ffffffffc020044c:	00007797          	auipc	a5,0x7
ffffffffc0200450:	fe07be23          	sd	zero,-4(a5) # ffffffffc0207448 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200454:	00002517          	auipc	a0,0x2
ffffffffc0200458:	dfc50513          	addi	a0,a0,-516 # ffffffffc0202250 <commands+0x68>
}
ffffffffc020045c:	0141                	addi	sp,sp,16
    cprintf("++ setup timer interrupts\n");
ffffffffc020045e:	b9ad                	j	ffffffffc02000d8 <cprintf>

ffffffffc0200460 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200460:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200464:	67e1                	lui	a5,0x18
ffffffffc0200466:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc020046a:	953e                	add	a0,a0,a5
ffffffffc020046c:	22f0106f          	j	ffffffffc0201e9a <sbi_set_timer>

ffffffffc0200470 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200470:	8082                	ret

ffffffffc0200472 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc0200472:	0ff57513          	zext.b	a0,a0
ffffffffc0200476:	20b0106f          	j	ffffffffc0201e80 <sbi_console_putchar>

ffffffffc020047a <cons_getc>:
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int cons_getc(void) {
    int c = 0;
    c = sbi_console_getchar();
ffffffffc020047a:	23b0106f          	j	ffffffffc0201eb4 <sbi_console_getchar>

ffffffffc020047e <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc020047e:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200480:	00002517          	auipc	a0,0x2
ffffffffc0200484:	df050513          	addi	a0,a0,-528 # ffffffffc0202270 <commands+0x88>
void dtb_init(void) {
ffffffffc0200488:	fc86                	sd	ra,120(sp)
ffffffffc020048a:	f8a2                	sd	s0,112(sp)
ffffffffc020048c:	e8d2                	sd	s4,80(sp)
ffffffffc020048e:	f4a6                	sd	s1,104(sp)
ffffffffc0200490:	f0ca                	sd	s2,96(sp)
ffffffffc0200492:	ecce                	sd	s3,88(sp)
ffffffffc0200494:	e4d6                	sd	s5,72(sp)
ffffffffc0200496:	e0da                	sd	s6,64(sp)
ffffffffc0200498:	fc5e                	sd	s7,56(sp)
ffffffffc020049a:	f862                	sd	s8,48(sp)
ffffffffc020049c:	f466                	sd	s9,40(sp)
ffffffffc020049e:	f06a                	sd	s10,32(sp)
ffffffffc02004a0:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc02004a2:	c37ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc02004a6:	00007597          	auipc	a1,0x7
ffffffffc02004aa:	b5a5b583          	ld	a1,-1190(a1) # ffffffffc0207000 <boot_hartid>
ffffffffc02004ae:	00002517          	auipc	a0,0x2
ffffffffc02004b2:	dd250513          	addi	a0,a0,-558 # ffffffffc0202280 <commands+0x98>
ffffffffc02004b6:	c23ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc02004ba:	00007417          	auipc	s0,0x7
ffffffffc02004be:	b4e40413          	addi	s0,s0,-1202 # ffffffffc0207008 <boot_dtb>
ffffffffc02004c2:	600c                	ld	a1,0(s0)
ffffffffc02004c4:	00002517          	auipc	a0,0x2
ffffffffc02004c8:	dcc50513          	addi	a0,a0,-564 # ffffffffc0202290 <commands+0xa8>
ffffffffc02004cc:	c0dff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc02004d0:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc02004d4:	00002517          	auipc	a0,0x2
ffffffffc02004d8:	dd450513          	addi	a0,a0,-556 # ffffffffc02022a8 <commands+0xc0>
    if (boot_dtb == 0) {
ffffffffc02004dc:	120a0463          	beqz	s4,ffffffffc0200604 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc02004e0:	57f5                	li	a5,-3
ffffffffc02004e2:	07fa                	slli	a5,a5,0x1e
ffffffffc02004e4:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc02004e8:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004ea:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004ee:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004f0:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02004f4:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004f8:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004fc:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200500:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200504:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200506:	8ec9                	or	a3,a3,a0
ffffffffc0200508:	0087979b          	slliw	a5,a5,0x8
ffffffffc020050c:	1b7d                	addi	s6,s6,-1
ffffffffc020050e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200512:	8dd5                	or	a1,a1,a3
ffffffffc0200514:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200516:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020051a:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc020051c:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed8a4d>
ffffffffc0200520:	10f59163          	bne	a1,a5,ffffffffc0200622 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc0200524:	471c                	lw	a5,8(a4)
ffffffffc0200526:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc0200528:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020052a:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020052e:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200532:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200536:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020053a:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020053e:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200542:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200546:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020054a:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020054e:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200552:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200554:	01146433          	or	s0,s0,a7
ffffffffc0200558:	0086969b          	slliw	a3,a3,0x8
ffffffffc020055c:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200560:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200562:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200566:	8c49                	or	s0,s0,a0
ffffffffc0200568:	0166f6b3          	and	a3,a3,s6
ffffffffc020056c:	00ca6a33          	or	s4,s4,a2
ffffffffc0200570:	0167f7b3          	and	a5,a5,s6
ffffffffc0200574:	8c55                	or	s0,s0,a3
ffffffffc0200576:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020057a:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020057c:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020057e:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200580:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200584:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200586:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200588:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020058c:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020058e:	00002917          	auipc	s2,0x2
ffffffffc0200592:	d6a90913          	addi	s2,s2,-662 # ffffffffc02022f8 <commands+0x110>
ffffffffc0200596:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200598:	4d91                	li	s11,4
ffffffffc020059a:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020059c:	00002497          	auipc	s1,0x2
ffffffffc02005a0:	d5448493          	addi	s1,s1,-684 # ffffffffc02022f0 <commands+0x108>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc02005a4:	000a2703          	lw	a4,0(s4)
ffffffffc02005a8:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005ac:	0087569b          	srliw	a3,a4,0x8
ffffffffc02005b0:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005b4:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005b8:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005bc:	0107571b          	srliw	a4,a4,0x10
ffffffffc02005c0:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005c2:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005c6:	0087171b          	slliw	a4,a4,0x8
ffffffffc02005ca:	8fd5                	or	a5,a5,a3
ffffffffc02005cc:	00eb7733          	and	a4,s6,a4
ffffffffc02005d0:	8fd9                	or	a5,a5,a4
ffffffffc02005d2:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc02005d4:	09778c63          	beq	a5,s7,ffffffffc020066c <dtb_init+0x1ee>
ffffffffc02005d8:	00fbea63          	bltu	s7,a5,ffffffffc02005ec <dtb_init+0x16e>
ffffffffc02005dc:	07a78663          	beq	a5,s10,ffffffffc0200648 <dtb_init+0x1ca>
ffffffffc02005e0:	4709                	li	a4,2
ffffffffc02005e2:	00e79763          	bne	a5,a4,ffffffffc02005f0 <dtb_init+0x172>
ffffffffc02005e6:	4c81                	li	s9,0
ffffffffc02005e8:	8a56                	mv	s4,s5
ffffffffc02005ea:	bf6d                	j	ffffffffc02005a4 <dtb_init+0x126>
ffffffffc02005ec:	ffb78ee3          	beq	a5,s11,ffffffffc02005e8 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc02005f0:	00002517          	auipc	a0,0x2
ffffffffc02005f4:	d8050513          	addi	a0,a0,-640 # ffffffffc0202370 <commands+0x188>
ffffffffc02005f8:	ae1ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc02005fc:	00002517          	auipc	a0,0x2
ffffffffc0200600:	dac50513          	addi	a0,a0,-596 # ffffffffc02023a8 <commands+0x1c0>
}
ffffffffc0200604:	7446                	ld	s0,112(sp)
ffffffffc0200606:	70e6                	ld	ra,120(sp)
ffffffffc0200608:	74a6                	ld	s1,104(sp)
ffffffffc020060a:	7906                	ld	s2,96(sp)
ffffffffc020060c:	69e6                	ld	s3,88(sp)
ffffffffc020060e:	6a46                	ld	s4,80(sp)
ffffffffc0200610:	6aa6                	ld	s5,72(sp)
ffffffffc0200612:	6b06                	ld	s6,64(sp)
ffffffffc0200614:	7be2                	ld	s7,56(sp)
ffffffffc0200616:	7c42                	ld	s8,48(sp)
ffffffffc0200618:	7ca2                	ld	s9,40(sp)
ffffffffc020061a:	7d02                	ld	s10,32(sp)
ffffffffc020061c:	6de2                	ld	s11,24(sp)
ffffffffc020061e:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc0200620:	bc65                	j	ffffffffc02000d8 <cprintf>
}
ffffffffc0200622:	7446                	ld	s0,112(sp)
ffffffffc0200624:	70e6                	ld	ra,120(sp)
ffffffffc0200626:	74a6                	ld	s1,104(sp)
ffffffffc0200628:	7906                	ld	s2,96(sp)
ffffffffc020062a:	69e6                	ld	s3,88(sp)
ffffffffc020062c:	6a46                	ld	s4,80(sp)
ffffffffc020062e:	6aa6                	ld	s5,72(sp)
ffffffffc0200630:	6b06                	ld	s6,64(sp)
ffffffffc0200632:	7be2                	ld	s7,56(sp)
ffffffffc0200634:	7c42                	ld	s8,48(sp)
ffffffffc0200636:	7ca2                	ld	s9,40(sp)
ffffffffc0200638:	7d02                	ld	s10,32(sp)
ffffffffc020063a:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc020063c:	00002517          	auipc	a0,0x2
ffffffffc0200640:	c8c50513          	addi	a0,a0,-884 # ffffffffc02022c8 <commands+0xe0>
}
ffffffffc0200644:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200646:	bc49                	j	ffffffffc02000d8 <cprintf>
                int name_len = strlen(name);
ffffffffc0200648:	8556                	mv	a0,s5
ffffffffc020064a:	0a1010ef          	jal	ra,ffffffffc0201eea <strlen>
ffffffffc020064e:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200650:	4619                	li	a2,6
ffffffffc0200652:	85a6                	mv	a1,s1
ffffffffc0200654:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc0200656:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200658:	0e7010ef          	jal	ra,ffffffffc0201f3e <strncmp>
ffffffffc020065c:	e111                	bnez	a0,ffffffffc0200660 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc020065e:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc0200660:	0a91                	addi	s5,s5,4
ffffffffc0200662:	9ad2                	add	s5,s5,s4
ffffffffc0200664:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200668:	8a56                	mv	s4,s5
ffffffffc020066a:	bf2d                	j	ffffffffc02005a4 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc020066c:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200670:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200674:	0087d71b          	srliw	a4,a5,0x8
ffffffffc0200678:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020067c:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200680:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200684:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200688:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020068c:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200690:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200694:	00eaeab3          	or	s5,s5,a4
ffffffffc0200698:	00fb77b3          	and	a5,s6,a5
ffffffffc020069c:	00faeab3          	or	s5,s5,a5
ffffffffc02006a0:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006a2:	000c9c63          	bnez	s9,ffffffffc02006ba <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc02006a6:	1a82                	slli	s5,s5,0x20
ffffffffc02006a8:	00368793          	addi	a5,a3,3
ffffffffc02006ac:	020ada93          	srli	s5,s5,0x20
ffffffffc02006b0:	9abe                	add	s5,s5,a5
ffffffffc02006b2:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02006b6:	8a56                	mv	s4,s5
ffffffffc02006b8:	b5f5                	j	ffffffffc02005a4 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006ba:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006be:	85ca                	mv	a1,s2
ffffffffc02006c0:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c2:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c6:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ca:	0187971b          	slliw	a4,a5,0x18
ffffffffc02006ce:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006d2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02006d6:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006d8:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006dc:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e0:	8d59                	or	a0,a0,a4
ffffffffc02006e2:	00fb77b3          	and	a5,s6,a5
ffffffffc02006e6:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc02006e8:	1502                	slli	a0,a0,0x20
ffffffffc02006ea:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006ec:	9522                	add	a0,a0,s0
ffffffffc02006ee:	033010ef          	jal	ra,ffffffffc0201f20 <strcmp>
ffffffffc02006f2:	66a2                	ld	a3,8(sp)
ffffffffc02006f4:	f94d                	bnez	a0,ffffffffc02006a6 <dtb_init+0x228>
ffffffffc02006f6:	fb59f8e3          	bgeu	s3,s5,ffffffffc02006a6 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc02006fa:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02006fe:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200702:	00002517          	auipc	a0,0x2
ffffffffc0200706:	bfe50513          	addi	a0,a0,-1026 # ffffffffc0202300 <commands+0x118>
           fdt32_to_cpu(x >> 32);
ffffffffc020070a:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020070e:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200712:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200716:	0187de1b          	srliw	t3,a5,0x18
ffffffffc020071a:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020071e:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200722:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200726:	0187d693          	srli	a3,a5,0x18
ffffffffc020072a:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020072e:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200732:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200736:	0106561b          	srliw	a2,a2,0x10
ffffffffc020073a:	010f6f33          	or	t5,t5,a6
ffffffffc020073e:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200742:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200746:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020074a:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020074e:	0186f6b3          	and	a3,a3,s8
ffffffffc0200752:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200756:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020075a:	0107581b          	srliw	a6,a4,0x10
ffffffffc020075e:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200762:	8361                	srli	a4,a4,0x18
ffffffffc0200764:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200768:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020076c:	01e6e6b3          	or	a3,a3,t5
ffffffffc0200770:	00cb7633          	and	a2,s6,a2
ffffffffc0200774:	0088181b          	slliw	a6,a6,0x8
ffffffffc0200778:	0085959b          	slliw	a1,a1,0x8
ffffffffc020077c:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200780:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200784:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200788:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020078c:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200790:	011b78b3          	and	a7,s6,a7
ffffffffc0200794:	005eeeb3          	or	t4,t4,t0
ffffffffc0200798:	00c6e733          	or	a4,a3,a2
ffffffffc020079c:	006c6c33          	or	s8,s8,t1
ffffffffc02007a0:	010b76b3          	and	a3,s6,a6
ffffffffc02007a4:	00bb7b33          	and	s6,s6,a1
ffffffffc02007a8:	01d7e7b3          	or	a5,a5,t4
ffffffffc02007ac:	016c6b33          	or	s6,s8,s6
ffffffffc02007b0:	01146433          	or	s0,s0,a7
ffffffffc02007b4:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc02007b6:	1702                	slli	a4,a4,0x20
ffffffffc02007b8:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007ba:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007bc:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007be:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007c0:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007c4:	0167eb33          	or	s6,a5,s6
ffffffffc02007c8:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc02007ca:	90fff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc02007ce:	85a2                	mv	a1,s0
ffffffffc02007d0:	00002517          	auipc	a0,0x2
ffffffffc02007d4:	b5050513          	addi	a0,a0,-1200 # ffffffffc0202320 <commands+0x138>
ffffffffc02007d8:	901ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc02007dc:	014b5613          	srli	a2,s6,0x14
ffffffffc02007e0:	85da                	mv	a1,s6
ffffffffc02007e2:	00002517          	auipc	a0,0x2
ffffffffc02007e6:	b5650513          	addi	a0,a0,-1194 # ffffffffc0202338 <commands+0x150>
ffffffffc02007ea:	8efff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc02007ee:	008b05b3          	add	a1,s6,s0
ffffffffc02007f2:	15fd                	addi	a1,a1,-1
ffffffffc02007f4:	00002517          	auipc	a0,0x2
ffffffffc02007f8:	b6450513          	addi	a0,a0,-1180 # ffffffffc0202358 <commands+0x170>
ffffffffc02007fc:	8ddff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200800:	00002517          	auipc	a0,0x2
ffffffffc0200804:	ba850513          	addi	a0,a0,-1112 # ffffffffc02023a8 <commands+0x1c0>
        memory_base = mem_base;
ffffffffc0200808:	00007797          	auipc	a5,0x7
ffffffffc020080c:	c487b423          	sd	s0,-952(a5) # ffffffffc0207450 <memory_base>
        memory_size = mem_size;
ffffffffc0200810:	00007797          	auipc	a5,0x7
ffffffffc0200814:	c567b423          	sd	s6,-952(a5) # ffffffffc0207458 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200818:	b3f5                	j	ffffffffc0200604 <dtb_init+0x186>

ffffffffc020081a <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc020081a:	00007517          	auipc	a0,0x7
ffffffffc020081e:	c3653503          	ld	a0,-970(a0) # ffffffffc0207450 <memory_base>
ffffffffc0200822:	8082                	ret

ffffffffc0200824 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc0200824:	00007517          	auipc	a0,0x7
ffffffffc0200828:	c3453503          	ld	a0,-972(a0) # ffffffffc0207458 <memory_size>
ffffffffc020082c:	8082                	ret

ffffffffc020082e <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc020082e:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200832:	8082                	ret

ffffffffc0200834 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200834:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200838:	8082                	ret

ffffffffc020083a <idt_init>:
     */

    extern void __alltraps(void);
    /* Set sup0 scratch register to 0, indicating to exception vector
       that we are presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc020083a:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc020083e:	00000797          	auipc	a5,0x0
ffffffffc0200842:	37a78793          	addi	a5,a5,890 # ffffffffc0200bb8 <__alltraps>
ffffffffc0200846:	10579073          	csrw	stvec,a5
}
ffffffffc020084a:	8082                	ret

ffffffffc020084c <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020084c:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs *gpr) {
ffffffffc020084e:	1141                	addi	sp,sp,-16
ffffffffc0200850:	e022                	sd	s0,0(sp)
ffffffffc0200852:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200854:	00002517          	auipc	a0,0x2
ffffffffc0200858:	b6c50513          	addi	a0,a0,-1172 # ffffffffc02023c0 <commands+0x1d8>
void print_regs(struct pushregs *gpr) {
ffffffffc020085c:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020085e:	87bff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200862:	640c                	ld	a1,8(s0)
ffffffffc0200864:	00002517          	auipc	a0,0x2
ffffffffc0200868:	b7450513          	addi	a0,a0,-1164 # ffffffffc02023d8 <commands+0x1f0>
ffffffffc020086c:	86dff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200870:	680c                	ld	a1,16(s0)
ffffffffc0200872:	00002517          	auipc	a0,0x2
ffffffffc0200876:	b7e50513          	addi	a0,a0,-1154 # ffffffffc02023f0 <commands+0x208>
ffffffffc020087a:	85fff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc020087e:	6c0c                	ld	a1,24(s0)
ffffffffc0200880:	00002517          	auipc	a0,0x2
ffffffffc0200884:	b8850513          	addi	a0,a0,-1144 # ffffffffc0202408 <commands+0x220>
ffffffffc0200888:	851ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc020088c:	700c                	ld	a1,32(s0)
ffffffffc020088e:	00002517          	auipc	a0,0x2
ffffffffc0200892:	b9250513          	addi	a0,a0,-1134 # ffffffffc0202420 <commands+0x238>
ffffffffc0200896:	843ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc020089a:	740c                	ld	a1,40(s0)
ffffffffc020089c:	00002517          	auipc	a0,0x2
ffffffffc02008a0:	b9c50513          	addi	a0,a0,-1124 # ffffffffc0202438 <commands+0x250>
ffffffffc02008a4:	835ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02008a8:	780c                	ld	a1,48(s0)
ffffffffc02008aa:	00002517          	auipc	a0,0x2
ffffffffc02008ae:	ba650513          	addi	a0,a0,-1114 # ffffffffc0202450 <commands+0x268>
ffffffffc02008b2:	827ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02008b6:	7c0c                	ld	a1,56(s0)
ffffffffc02008b8:	00002517          	auipc	a0,0x2
ffffffffc02008bc:	bb050513          	addi	a0,a0,-1104 # ffffffffc0202468 <commands+0x280>
ffffffffc02008c0:	819ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02008c4:	602c                	ld	a1,64(s0)
ffffffffc02008c6:	00002517          	auipc	a0,0x2
ffffffffc02008ca:	bba50513          	addi	a0,a0,-1094 # ffffffffc0202480 <commands+0x298>
ffffffffc02008ce:	80bff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02008d2:	642c                	ld	a1,72(s0)
ffffffffc02008d4:	00002517          	auipc	a0,0x2
ffffffffc02008d8:	bc450513          	addi	a0,a0,-1084 # ffffffffc0202498 <commands+0x2b0>
ffffffffc02008dc:	ffcff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02008e0:	682c                	ld	a1,80(s0)
ffffffffc02008e2:	00002517          	auipc	a0,0x2
ffffffffc02008e6:	bce50513          	addi	a0,a0,-1074 # ffffffffc02024b0 <commands+0x2c8>
ffffffffc02008ea:	feeff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02008ee:	6c2c                	ld	a1,88(s0)
ffffffffc02008f0:	00002517          	auipc	a0,0x2
ffffffffc02008f4:	bd850513          	addi	a0,a0,-1064 # ffffffffc02024c8 <commands+0x2e0>
ffffffffc02008f8:	fe0ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc02008fc:	702c                	ld	a1,96(s0)
ffffffffc02008fe:	00002517          	auipc	a0,0x2
ffffffffc0200902:	be250513          	addi	a0,a0,-1054 # ffffffffc02024e0 <commands+0x2f8>
ffffffffc0200906:	fd2ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc020090a:	742c                	ld	a1,104(s0)
ffffffffc020090c:	00002517          	auipc	a0,0x2
ffffffffc0200910:	bec50513          	addi	a0,a0,-1044 # ffffffffc02024f8 <commands+0x310>
ffffffffc0200914:	fc4ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200918:	782c                	ld	a1,112(s0)
ffffffffc020091a:	00002517          	auipc	a0,0x2
ffffffffc020091e:	bf650513          	addi	a0,a0,-1034 # ffffffffc0202510 <commands+0x328>
ffffffffc0200922:	fb6ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200926:	7c2c                	ld	a1,120(s0)
ffffffffc0200928:	00002517          	auipc	a0,0x2
ffffffffc020092c:	c0050513          	addi	a0,a0,-1024 # ffffffffc0202528 <commands+0x340>
ffffffffc0200930:	fa8ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200934:	604c                	ld	a1,128(s0)
ffffffffc0200936:	00002517          	auipc	a0,0x2
ffffffffc020093a:	c0a50513          	addi	a0,a0,-1014 # ffffffffc0202540 <commands+0x358>
ffffffffc020093e:	f9aff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200942:	644c                	ld	a1,136(s0)
ffffffffc0200944:	00002517          	auipc	a0,0x2
ffffffffc0200948:	c1450513          	addi	a0,a0,-1004 # ffffffffc0202558 <commands+0x370>
ffffffffc020094c:	f8cff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200950:	684c                	ld	a1,144(s0)
ffffffffc0200952:	00002517          	auipc	a0,0x2
ffffffffc0200956:	c1e50513          	addi	a0,a0,-994 # ffffffffc0202570 <commands+0x388>
ffffffffc020095a:	f7eff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc020095e:	6c4c                	ld	a1,152(s0)
ffffffffc0200960:	00002517          	auipc	a0,0x2
ffffffffc0200964:	c2850513          	addi	a0,a0,-984 # ffffffffc0202588 <commands+0x3a0>
ffffffffc0200968:	f70ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc020096c:	704c                	ld	a1,160(s0)
ffffffffc020096e:	00002517          	auipc	a0,0x2
ffffffffc0200972:	c3250513          	addi	a0,a0,-974 # ffffffffc02025a0 <commands+0x3b8>
ffffffffc0200976:	f62ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc020097a:	744c                	ld	a1,168(s0)
ffffffffc020097c:	00002517          	auipc	a0,0x2
ffffffffc0200980:	c3c50513          	addi	a0,a0,-964 # ffffffffc02025b8 <commands+0x3d0>
ffffffffc0200984:	f54ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200988:	784c                	ld	a1,176(s0)
ffffffffc020098a:	00002517          	auipc	a0,0x2
ffffffffc020098e:	c4650513          	addi	a0,a0,-954 # ffffffffc02025d0 <commands+0x3e8>
ffffffffc0200992:	f46ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200996:	7c4c                	ld	a1,184(s0)
ffffffffc0200998:	00002517          	auipc	a0,0x2
ffffffffc020099c:	c5050513          	addi	a0,a0,-944 # ffffffffc02025e8 <commands+0x400>
ffffffffc02009a0:	f38ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02009a4:	606c                	ld	a1,192(s0)
ffffffffc02009a6:	00002517          	auipc	a0,0x2
ffffffffc02009aa:	c5a50513          	addi	a0,a0,-934 # ffffffffc0202600 <commands+0x418>
ffffffffc02009ae:	f2aff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02009b2:	646c                	ld	a1,200(s0)
ffffffffc02009b4:	00002517          	auipc	a0,0x2
ffffffffc02009b8:	c6450513          	addi	a0,a0,-924 # ffffffffc0202618 <commands+0x430>
ffffffffc02009bc:	f1cff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02009c0:	686c                	ld	a1,208(s0)
ffffffffc02009c2:	00002517          	auipc	a0,0x2
ffffffffc02009c6:	c6e50513          	addi	a0,a0,-914 # ffffffffc0202630 <commands+0x448>
ffffffffc02009ca:	f0eff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02009ce:	6c6c                	ld	a1,216(s0)
ffffffffc02009d0:	00002517          	auipc	a0,0x2
ffffffffc02009d4:	c7850513          	addi	a0,a0,-904 # ffffffffc0202648 <commands+0x460>
ffffffffc02009d8:	f00ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02009dc:	706c                	ld	a1,224(s0)
ffffffffc02009de:	00002517          	auipc	a0,0x2
ffffffffc02009e2:	c8250513          	addi	a0,a0,-894 # ffffffffc0202660 <commands+0x478>
ffffffffc02009e6:	ef2ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02009ea:	746c                	ld	a1,232(s0)
ffffffffc02009ec:	00002517          	auipc	a0,0x2
ffffffffc02009f0:	c8c50513          	addi	a0,a0,-884 # ffffffffc0202678 <commands+0x490>
ffffffffc02009f4:	ee4ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02009f8:	786c                	ld	a1,240(s0)
ffffffffc02009fa:	00002517          	auipc	a0,0x2
ffffffffc02009fe:	c9650513          	addi	a0,a0,-874 # ffffffffc0202690 <commands+0x4a8>
ffffffffc0200a02:	ed6ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a06:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200a08:	6402                	ld	s0,0(sp)
ffffffffc0200a0a:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a0c:	00002517          	auipc	a0,0x2
ffffffffc0200a10:	c9c50513          	addi	a0,a0,-868 # ffffffffc02026a8 <commands+0x4c0>
}
ffffffffc0200a14:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a16:	ec2ff06f          	j	ffffffffc02000d8 <cprintf>

ffffffffc0200a1a <print_trapframe>:
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a1a:	1141                	addi	sp,sp,-16
ffffffffc0200a1c:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a1e:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a20:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a22:	00002517          	auipc	a0,0x2
ffffffffc0200a26:	c9e50513          	addi	a0,a0,-866 # ffffffffc02026c0 <commands+0x4d8>
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a2a:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a2c:	eacff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200a30:	8522                	mv	a0,s0
ffffffffc0200a32:	e1bff0ef          	jal	ra,ffffffffc020084c <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200a36:	10043583          	ld	a1,256(s0)
ffffffffc0200a3a:	00002517          	auipc	a0,0x2
ffffffffc0200a3e:	c9e50513          	addi	a0,a0,-866 # ffffffffc02026d8 <commands+0x4f0>
ffffffffc0200a42:	e96ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200a46:	10843583          	ld	a1,264(s0)
ffffffffc0200a4a:	00002517          	auipc	a0,0x2
ffffffffc0200a4e:	ca650513          	addi	a0,a0,-858 # ffffffffc02026f0 <commands+0x508>
ffffffffc0200a52:	e86ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
ffffffffc0200a56:	11043583          	ld	a1,272(s0)
ffffffffc0200a5a:	00002517          	auipc	a0,0x2
ffffffffc0200a5e:	cae50513          	addi	a0,a0,-850 # ffffffffc0202708 <commands+0x520>
ffffffffc0200a62:	e76ff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a66:	11843583          	ld	a1,280(s0)
}
ffffffffc0200a6a:	6402                	ld	s0,0(sp)
ffffffffc0200a6c:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a6e:	00002517          	auipc	a0,0x2
ffffffffc0200a72:	cb250513          	addi	a0,a0,-846 # ffffffffc0202720 <commands+0x538>
}
ffffffffc0200a76:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a78:	e60ff06f          	j	ffffffffc02000d8 <cprintf>

ffffffffc0200a7c <interrupt_handler>:

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200a7c:	11853783          	ld	a5,280(a0)
ffffffffc0200a80:	472d                	li	a4,11
ffffffffc0200a82:	0786                	slli	a5,a5,0x1
ffffffffc0200a84:	8385                	srli	a5,a5,0x1
ffffffffc0200a86:	08f76363          	bltu	a4,a5,ffffffffc0200b0c <interrupt_handler+0x90>
ffffffffc0200a8a:	00002717          	auipc	a4,0x2
ffffffffc0200a8e:	d9e70713          	addi	a4,a4,-610 # ffffffffc0202828 <commands+0x640>
ffffffffc0200a92:	078a                	slli	a5,a5,0x2
ffffffffc0200a94:	97ba                	add	a5,a5,a4
ffffffffc0200a96:	439c                	lw	a5,0(a5)
ffffffffc0200a98:	97ba                	add	a5,a5,a4
ffffffffc0200a9a:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc0200a9c:	00002517          	auipc	a0,0x2
ffffffffc0200aa0:	cfc50513          	addi	a0,a0,-772 # ffffffffc0202798 <commands+0x5b0>
ffffffffc0200aa4:	e34ff06f          	j	ffffffffc02000d8 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc0200aa8:	00002517          	auipc	a0,0x2
ffffffffc0200aac:	cd050513          	addi	a0,a0,-816 # ffffffffc0202778 <commands+0x590>
ffffffffc0200ab0:	e28ff06f          	j	ffffffffc02000d8 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc0200ab4:	00002517          	auipc	a0,0x2
ffffffffc0200ab8:	c8450513          	addi	a0,a0,-892 # ffffffffc0202738 <commands+0x550>
ffffffffc0200abc:	e1cff06f          	j	ffffffffc02000d8 <cprintf>
            break;
        case IRQ_U_TIMER:
            cprintf("User Timer interrupt\n");
ffffffffc0200ac0:	00002517          	auipc	a0,0x2
ffffffffc0200ac4:	cf850513          	addi	a0,a0,-776 # ffffffffc02027b8 <commands+0x5d0>
ffffffffc0200ac8:	e10ff06f          	j	ffffffffc02000d8 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc0200acc:	1141                	addi	sp,sp,-16
ffffffffc0200ace:	e406                	sd	ra,8(sp)
             *(2)计数器（ticks）加一
             *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
            * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
            */
            /* LAB3 EXERCISE1 完整实现 */
            clock_set_next_event();          // (1) 设置下一次时钟中断
ffffffffc0200ad0:	991ff0ef          	jal	ra,ffffffffc0200460 <clock_set_next_event>
            ticks++;                         // (2) 计数器 +1
ffffffffc0200ad4:	00007797          	auipc	a5,0x7
ffffffffc0200ad8:	97478793          	addi	a5,a5,-1676 # ffffffffc0207448 <ticks>
ffffffffc0200adc:	6398                	ld	a4,0(a5)
ffffffffc0200ade:	0705                	addi	a4,a4,1
ffffffffc0200ae0:	e398                	sd	a4,0(a5)

            if (ticks % TICK_NUM == 0) {     // (3) 每 100 次打印一次
ffffffffc0200ae2:	639c                	ld	a5,0(a5)
ffffffffc0200ae4:	06400713          	li	a4,100
ffffffffc0200ae8:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200aec:	c38d                	beqz	a5,ffffffffc0200b0e <interrupt_handler+0x92>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200aee:	60a2                	ld	ra,8(sp)
ffffffffc0200af0:	0141                	addi	sp,sp,16
ffffffffc0200af2:	8082                	ret
            cprintf("Supervisor external interrupt\n");
ffffffffc0200af4:	00002517          	auipc	a0,0x2
ffffffffc0200af8:	d1450513          	addi	a0,a0,-748 # ffffffffc0202808 <commands+0x620>
ffffffffc0200afc:	ddcff06f          	j	ffffffffc02000d8 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc0200b00:	00002517          	auipc	a0,0x2
ffffffffc0200b04:	c5850513          	addi	a0,a0,-936 # ffffffffc0202758 <commands+0x570>
ffffffffc0200b08:	dd0ff06f          	j	ffffffffc02000d8 <cprintf>
            print_trapframe(tf);
ffffffffc0200b0c:	b739                	j	ffffffffc0200a1a <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200b0e:	06400593          	li	a1,100
ffffffffc0200b12:	00002517          	auipc	a0,0x2
ffffffffc0200b16:	cbe50513          	addi	a0,a0,-834 # ffffffffc02027d0 <commands+0x5e8>
ffffffffc0200b1a:	dbeff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
                print_cnt++;
ffffffffc0200b1e:	00007717          	auipc	a4,0x7
ffffffffc0200b22:	94270713          	addi	a4,a4,-1726 # ffffffffc0207460 <print_cnt>
ffffffffc0200b26:	431c                	lw	a5,0(a4)
                if (print_cnt >= 10) {       // (4) 打印 10 行后关机
ffffffffc0200b28:	46a5                	li	a3,9
                print_cnt++;
ffffffffc0200b2a:	0017861b          	addiw	a2,a5,1
ffffffffc0200b2e:	c310                	sw	a2,0(a4)
                if (print_cnt >= 10) {       // (4) 打印 10 行后关机
ffffffffc0200b30:	fac6ffe3          	bgeu	a3,a2,ffffffffc0200aee <interrupt_handler+0x72>
                    cprintf("System shutdown after 10 prints.\n");
ffffffffc0200b34:	00002517          	auipc	a0,0x2
ffffffffc0200b38:	cac50513          	addi	a0,a0,-852 # ffffffffc02027e0 <commands+0x5f8>
ffffffffc0200b3c:	d9cff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
}
ffffffffc0200b40:	60a2                	ld	ra,8(sp)
ffffffffc0200b42:	0141                	addi	sp,sp,16
                    sbi_shutdown();
ffffffffc0200b44:	38c0106f          	j	ffffffffc0201ed0 <sbi_shutdown>

ffffffffc0200b48 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    switch (tf->cause) {
ffffffffc0200b48:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200b4c:	1141                	addi	sp,sp,-16
ffffffffc0200b4e:	e022                	sd	s0,0(sp)
ffffffffc0200b50:	e406                	sd	ra,8(sp)
    switch (tf->cause) {
ffffffffc0200b52:	470d                	li	a4,3
void exception_handler(struct trapframe *tf) {
ffffffffc0200b54:	842a                	mv	s0,a0
    switch (tf->cause) {
ffffffffc0200b56:	04e78663          	beq	a5,a4,ffffffffc0200ba2 <exception_handler+0x5a>
ffffffffc0200b5a:	02f76c63          	bltu	a4,a5,ffffffffc0200b92 <exception_handler+0x4a>
ffffffffc0200b5e:	4709                	li	a4,2
             /* LAB3 CHALLENGE3   YOUR CODE :  2313508*/
            /*(1)输出指令异常类型（ Illegal instruction）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Exception: Illegal instruction\n");
ffffffffc0200b60:	00002517          	auipc	a0,0x2
ffffffffc0200b64:	cf850513          	addi	a0,a0,-776 # ffffffffc0202858 <commands+0x670>
    switch (tf->cause) {
ffffffffc0200b68:	02e79163          	bne	a5,a4,ffffffffc0200b8a <exception_handler+0x42>
            /* LAB3 CHALLLENGE3   YOUR CODE :2313508  */
            /*(1)输出指令异常类型（ breakpoint）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Exception: Breakpoint\n");
ffffffffc0200b6c:	d6cff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
            cprintf("  Bad instruction address: 0x%08x\n", tf->epc);
ffffffffc0200b70:	10843583          	ld	a1,264(s0)
ffffffffc0200b74:	00002517          	auipc	a0,0x2
ffffffffc0200b78:	d0450513          	addi	a0,a0,-764 # ffffffffc0202878 <commands+0x690>
ffffffffc0200b7c:	d5cff0ef          	jal	ra,ffffffffc02000d8 <cprintf>
            tf->epc += 4; //跳过断点指令
ffffffffc0200b80:	10843783          	ld	a5,264(s0)
ffffffffc0200b84:	0791                	addi	a5,a5,4
ffffffffc0200b86:	10f43423          	sd	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200b8a:	60a2                	ld	ra,8(sp)
ffffffffc0200b8c:	6402                	ld	s0,0(sp)
ffffffffc0200b8e:	0141                	addi	sp,sp,16
ffffffffc0200b90:	8082                	ret
    switch (tf->cause) {
ffffffffc0200b92:	17f1                	addi	a5,a5,-4
ffffffffc0200b94:	471d                	li	a4,7
ffffffffc0200b96:	fef77ae3          	bgeu	a4,a5,ffffffffc0200b8a <exception_handler+0x42>
}
ffffffffc0200b9a:	6402                	ld	s0,0(sp)
ffffffffc0200b9c:	60a2                	ld	ra,8(sp)
ffffffffc0200b9e:	0141                	addi	sp,sp,16
            print_trapframe(tf);
ffffffffc0200ba0:	bdad                	j	ffffffffc0200a1a <print_trapframe>
            cprintf("Exception: Breakpoint\n");
ffffffffc0200ba2:	00002517          	auipc	a0,0x2
ffffffffc0200ba6:	cfe50513          	addi	a0,a0,-770 # ffffffffc02028a0 <commands+0x6b8>
ffffffffc0200baa:	b7c9                	j	ffffffffc0200b6c <exception_handler+0x24>

ffffffffc0200bac <trap>:

static inline void trap_dispatch(struct trapframe *tf) {
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200bac:	11853783          	ld	a5,280(a0)
ffffffffc0200bb0:	0007c363          	bltz	a5,ffffffffc0200bb6 <trap+0xa>
        // interrupts
        interrupt_handler(tf);
    } else {
        // exceptions
        exception_handler(tf);
ffffffffc0200bb4:	bf51                	j	ffffffffc0200b48 <exception_handler>
        interrupt_handler(tf);
ffffffffc0200bb6:	b5d9                	j	ffffffffc0200a7c <interrupt_handler>

ffffffffc0200bb8 <__alltraps>:
    .endm

    .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
ffffffffc0200bb8:	14011073          	csrw	sscratch,sp
ffffffffc0200bbc:	712d                	addi	sp,sp,-288
ffffffffc0200bbe:	e002                	sd	zero,0(sp)
ffffffffc0200bc0:	e406                	sd	ra,8(sp)
ffffffffc0200bc2:	ec0e                	sd	gp,24(sp)
ffffffffc0200bc4:	f012                	sd	tp,32(sp)
ffffffffc0200bc6:	f416                	sd	t0,40(sp)
ffffffffc0200bc8:	f81a                	sd	t1,48(sp)
ffffffffc0200bca:	fc1e                	sd	t2,56(sp)
ffffffffc0200bcc:	e0a2                	sd	s0,64(sp)
ffffffffc0200bce:	e4a6                	sd	s1,72(sp)
ffffffffc0200bd0:	e8aa                	sd	a0,80(sp)
ffffffffc0200bd2:	ecae                	sd	a1,88(sp)
ffffffffc0200bd4:	f0b2                	sd	a2,96(sp)
ffffffffc0200bd6:	f4b6                	sd	a3,104(sp)
ffffffffc0200bd8:	f8ba                	sd	a4,112(sp)
ffffffffc0200bda:	fcbe                	sd	a5,120(sp)
ffffffffc0200bdc:	e142                	sd	a6,128(sp)
ffffffffc0200bde:	e546                	sd	a7,136(sp)
ffffffffc0200be0:	e94a                	sd	s2,144(sp)
ffffffffc0200be2:	ed4e                	sd	s3,152(sp)
ffffffffc0200be4:	f152                	sd	s4,160(sp)
ffffffffc0200be6:	f556                	sd	s5,168(sp)
ffffffffc0200be8:	f95a                	sd	s6,176(sp)
ffffffffc0200bea:	fd5e                	sd	s7,184(sp)
ffffffffc0200bec:	e1e2                	sd	s8,192(sp)
ffffffffc0200bee:	e5e6                	sd	s9,200(sp)
ffffffffc0200bf0:	e9ea                	sd	s10,208(sp)
ffffffffc0200bf2:	edee                	sd	s11,216(sp)
ffffffffc0200bf4:	f1f2                	sd	t3,224(sp)
ffffffffc0200bf6:	f5f6                	sd	t4,232(sp)
ffffffffc0200bf8:	f9fa                	sd	t5,240(sp)
ffffffffc0200bfa:	fdfe                	sd	t6,248(sp)
ffffffffc0200bfc:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c00:	100024f3          	csrr	s1,sstatus
ffffffffc0200c04:	14102973          	csrr	s2,sepc
ffffffffc0200c08:	143029f3          	csrr	s3,stval
ffffffffc0200c0c:	14202a73          	csrr	s4,scause
ffffffffc0200c10:	e822                	sd	s0,16(sp)
ffffffffc0200c12:	e226                	sd	s1,256(sp)
ffffffffc0200c14:	e64a                	sd	s2,264(sp)
ffffffffc0200c16:	ea4e                	sd	s3,272(sp)
ffffffffc0200c18:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c1a:	850a                	mv	a0,sp
    jal trap
ffffffffc0200c1c:	f91ff0ef          	jal	ra,ffffffffc0200bac <trap>

ffffffffc0200c20 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200c20:	6492                	ld	s1,256(sp)
ffffffffc0200c22:	6932                	ld	s2,264(sp)
ffffffffc0200c24:	10049073          	csrw	sstatus,s1
ffffffffc0200c28:	14191073          	csrw	sepc,s2
ffffffffc0200c2c:	60a2                	ld	ra,8(sp)
ffffffffc0200c2e:	61e2                	ld	gp,24(sp)
ffffffffc0200c30:	7202                	ld	tp,32(sp)
ffffffffc0200c32:	72a2                	ld	t0,40(sp)
ffffffffc0200c34:	7342                	ld	t1,48(sp)
ffffffffc0200c36:	73e2                	ld	t2,56(sp)
ffffffffc0200c38:	6406                	ld	s0,64(sp)
ffffffffc0200c3a:	64a6                	ld	s1,72(sp)
ffffffffc0200c3c:	6546                	ld	a0,80(sp)
ffffffffc0200c3e:	65e6                	ld	a1,88(sp)
ffffffffc0200c40:	7606                	ld	a2,96(sp)
ffffffffc0200c42:	76a6                	ld	a3,104(sp)
ffffffffc0200c44:	7746                	ld	a4,112(sp)
ffffffffc0200c46:	77e6                	ld	a5,120(sp)
ffffffffc0200c48:	680a                	ld	a6,128(sp)
ffffffffc0200c4a:	68aa                	ld	a7,136(sp)
ffffffffc0200c4c:	694a                	ld	s2,144(sp)
ffffffffc0200c4e:	69ea                	ld	s3,152(sp)
ffffffffc0200c50:	7a0a                	ld	s4,160(sp)
ffffffffc0200c52:	7aaa                	ld	s5,168(sp)
ffffffffc0200c54:	7b4a                	ld	s6,176(sp)
ffffffffc0200c56:	7bea                	ld	s7,184(sp)
ffffffffc0200c58:	6c0e                	ld	s8,192(sp)
ffffffffc0200c5a:	6cae                	ld	s9,200(sp)
ffffffffc0200c5c:	6d4e                	ld	s10,208(sp)
ffffffffc0200c5e:	6dee                	ld	s11,216(sp)
ffffffffc0200c60:	7e0e                	ld	t3,224(sp)
ffffffffc0200c62:	7eae                	ld	t4,232(sp)
ffffffffc0200c64:	7f4e                	ld	t5,240(sp)
ffffffffc0200c66:	7fee                	ld	t6,248(sp)
ffffffffc0200c68:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200c6a:	10200073          	sret

ffffffffc0200c6e <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200c6e:	00006797          	auipc	a5,0x6
ffffffffc0200c72:	3ba78793          	addi	a5,a5,954 # ffffffffc0207028 <free_area>
ffffffffc0200c76:	e79c                	sd	a5,8(a5)
ffffffffc0200c78:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200c7a:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200c7e:	8082                	ret

ffffffffc0200c80 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0200c80:	00006517          	auipc	a0,0x6
ffffffffc0200c84:	3b856503          	lwu	a0,952(a0) # ffffffffc0207038 <free_area+0x10>
ffffffffc0200c88:	8082                	ret

ffffffffc0200c8a <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0200c8a:	715d                	addi	sp,sp,-80
ffffffffc0200c8c:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200c8e:	00006417          	auipc	s0,0x6
ffffffffc0200c92:	39a40413          	addi	s0,s0,922 # ffffffffc0207028 <free_area>
ffffffffc0200c96:	641c                	ld	a5,8(s0)
ffffffffc0200c98:	e486                	sd	ra,72(sp)
ffffffffc0200c9a:	fc26                	sd	s1,56(sp)
ffffffffc0200c9c:	f84a                	sd	s2,48(sp)
ffffffffc0200c9e:	f44e                	sd	s3,40(sp)
ffffffffc0200ca0:	f052                	sd	s4,32(sp)
ffffffffc0200ca2:	ec56                	sd	s5,24(sp)
ffffffffc0200ca4:	e85a                	sd	s6,16(sp)
ffffffffc0200ca6:	e45e                	sd	s7,8(sp)
ffffffffc0200ca8:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200caa:	2c878763          	beq	a5,s0,ffffffffc0200f78 <default_check+0x2ee>
    int count = 0, total = 0;
ffffffffc0200cae:	4481                	li	s1,0
ffffffffc0200cb0:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200cb2:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200cb6:	8b09                	andi	a4,a4,2
ffffffffc0200cb8:	2c070463          	beqz	a4,ffffffffc0200f80 <default_check+0x2f6>
        count ++, total += p->property;
ffffffffc0200cbc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200cc0:	679c                	ld	a5,8(a5)
ffffffffc0200cc2:	2905                	addiw	s2,s2,1
ffffffffc0200cc4:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200cc6:	fe8796e3          	bne	a5,s0,ffffffffc0200cb2 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200cca:	89a6                	mv	s3,s1
ffffffffc0200ccc:	2f9000ef          	jal	ra,ffffffffc02017c4 <nr_free_pages>
ffffffffc0200cd0:	71351863          	bne	a0,s3,ffffffffc02013e0 <default_check+0x756>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200cd4:	4505                	li	a0,1
ffffffffc0200cd6:	271000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200cda:	8a2a                	mv	s4,a0
ffffffffc0200cdc:	44050263          	beqz	a0,ffffffffc0201120 <default_check+0x496>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200ce0:	4505                	li	a0,1
ffffffffc0200ce2:	265000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200ce6:	89aa                	mv	s3,a0
ffffffffc0200ce8:	70050c63          	beqz	a0,ffffffffc0201400 <default_check+0x776>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200cec:	4505                	li	a0,1
ffffffffc0200cee:	259000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200cf2:	8aaa                	mv	s5,a0
ffffffffc0200cf4:	4a050663          	beqz	a0,ffffffffc02011a0 <default_check+0x516>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200cf8:	2b3a0463          	beq	s4,s3,ffffffffc0200fa0 <default_check+0x316>
ffffffffc0200cfc:	2aaa0263          	beq	s4,a0,ffffffffc0200fa0 <default_check+0x316>
ffffffffc0200d00:	2aa98063          	beq	s3,a0,ffffffffc0200fa0 <default_check+0x316>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200d04:	000a2783          	lw	a5,0(s4)
ffffffffc0200d08:	2a079c63          	bnez	a5,ffffffffc0200fc0 <default_check+0x336>
ffffffffc0200d0c:	0009a783          	lw	a5,0(s3)
ffffffffc0200d10:	2a079863          	bnez	a5,ffffffffc0200fc0 <default_check+0x336>
ffffffffc0200d14:	411c                	lw	a5,0(a0)
ffffffffc0200d16:	2a079563          	bnez	a5,ffffffffc0200fc0 <default_check+0x336>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d1a:	00006797          	auipc	a5,0x6
ffffffffc0200d1e:	7567b783          	ld	a5,1878(a5) # ffffffffc0207470 <pages>
ffffffffc0200d22:	40fa0733          	sub	a4,s4,a5
ffffffffc0200d26:	870d                	srai	a4,a4,0x3
ffffffffc0200d28:	00002597          	auipc	a1,0x2
ffffffffc0200d2c:	3185b583          	ld	a1,792(a1) # ffffffffc0203040 <error_string+0x38>
ffffffffc0200d30:	02b70733          	mul	a4,a4,a1
ffffffffc0200d34:	00002617          	auipc	a2,0x2
ffffffffc0200d38:	31463603          	ld	a2,788(a2) # ffffffffc0203048 <nbase>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200d3c:	00006697          	auipc	a3,0x6
ffffffffc0200d40:	72c6b683          	ld	a3,1836(a3) # ffffffffc0207468 <npage>
ffffffffc0200d44:	06b2                	slli	a3,a3,0xc
ffffffffc0200d46:	9732                	add	a4,a4,a2

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d48:	0732                	slli	a4,a4,0xc
ffffffffc0200d4a:	28d77b63          	bgeu	a4,a3,ffffffffc0200fe0 <default_check+0x356>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d4e:	40f98733          	sub	a4,s3,a5
ffffffffc0200d52:	870d                	srai	a4,a4,0x3
ffffffffc0200d54:	02b70733          	mul	a4,a4,a1
ffffffffc0200d58:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d5a:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200d5c:	4cd77263          	bgeu	a4,a3,ffffffffc0201220 <default_check+0x596>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d60:	40f507b3          	sub	a5,a0,a5
ffffffffc0200d64:	878d                	srai	a5,a5,0x3
ffffffffc0200d66:	02b787b3          	mul	a5,a5,a1
ffffffffc0200d6a:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d6c:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200d6e:	30d7f963          	bgeu	a5,a3,ffffffffc0201080 <default_check+0x3f6>
    assert(alloc_page() == NULL);
ffffffffc0200d72:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200d74:	00043c03          	ld	s8,0(s0)
ffffffffc0200d78:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200d7c:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200d80:	e400                	sd	s0,8(s0)
ffffffffc0200d82:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200d84:	00006797          	auipc	a5,0x6
ffffffffc0200d88:	2a07aa23          	sw	zero,692(a5) # ffffffffc0207038 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200d8c:	1bb000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200d90:	2c051863          	bnez	a0,ffffffffc0201060 <default_check+0x3d6>
    free_page(p0);
ffffffffc0200d94:	4585                	li	a1,1
ffffffffc0200d96:	8552                	mv	a0,s4
ffffffffc0200d98:	1ed000ef          	jal	ra,ffffffffc0201784 <free_pages>
    free_page(p1);
ffffffffc0200d9c:	4585                	li	a1,1
ffffffffc0200d9e:	854e                	mv	a0,s3
ffffffffc0200da0:	1e5000ef          	jal	ra,ffffffffc0201784 <free_pages>
    free_page(p2);
ffffffffc0200da4:	4585                	li	a1,1
ffffffffc0200da6:	8556                	mv	a0,s5
ffffffffc0200da8:	1dd000ef          	jal	ra,ffffffffc0201784 <free_pages>
    assert(nr_free == 3);
ffffffffc0200dac:	4818                	lw	a4,16(s0)
ffffffffc0200dae:	478d                	li	a5,3
ffffffffc0200db0:	28f71863          	bne	a4,a5,ffffffffc0201040 <default_check+0x3b6>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200db4:	4505                	li	a0,1
ffffffffc0200db6:	191000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200dba:	89aa                	mv	s3,a0
ffffffffc0200dbc:	26050263          	beqz	a0,ffffffffc0201020 <default_check+0x396>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200dc0:	4505                	li	a0,1
ffffffffc0200dc2:	185000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200dc6:	8aaa                	mv	s5,a0
ffffffffc0200dc8:	3a050c63          	beqz	a0,ffffffffc0201180 <default_check+0x4f6>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200dcc:	4505                	li	a0,1
ffffffffc0200dce:	179000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200dd2:	8a2a                	mv	s4,a0
ffffffffc0200dd4:	38050663          	beqz	a0,ffffffffc0201160 <default_check+0x4d6>
    assert(alloc_page() == NULL);
ffffffffc0200dd8:	4505                	li	a0,1
ffffffffc0200dda:	16d000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200dde:	36051163          	bnez	a0,ffffffffc0201140 <default_check+0x4b6>
    free_page(p0);
ffffffffc0200de2:	4585                	li	a1,1
ffffffffc0200de4:	854e                	mv	a0,s3
ffffffffc0200de6:	19f000ef          	jal	ra,ffffffffc0201784 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0200dea:	641c                	ld	a5,8(s0)
ffffffffc0200dec:	20878a63          	beq	a5,s0,ffffffffc0201000 <default_check+0x376>
    assert((p = alloc_page()) == p0);
ffffffffc0200df0:	4505                	li	a0,1
ffffffffc0200df2:	155000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200df6:	30a99563          	bne	s3,a0,ffffffffc0201100 <default_check+0x476>
    assert(alloc_page() == NULL);
ffffffffc0200dfa:	4505                	li	a0,1
ffffffffc0200dfc:	14b000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200e00:	2e051063          	bnez	a0,ffffffffc02010e0 <default_check+0x456>
    assert(nr_free == 0);
ffffffffc0200e04:	481c                	lw	a5,16(s0)
ffffffffc0200e06:	2a079d63          	bnez	a5,ffffffffc02010c0 <default_check+0x436>
    free_page(p);
ffffffffc0200e0a:	854e                	mv	a0,s3
ffffffffc0200e0c:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0200e0e:	01843023          	sd	s8,0(s0)
ffffffffc0200e12:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0200e16:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0200e1a:	16b000ef          	jal	ra,ffffffffc0201784 <free_pages>
    free_page(p1);
ffffffffc0200e1e:	4585                	li	a1,1
ffffffffc0200e20:	8556                	mv	a0,s5
ffffffffc0200e22:	163000ef          	jal	ra,ffffffffc0201784 <free_pages>
    free_page(p2);
ffffffffc0200e26:	4585                	li	a1,1
ffffffffc0200e28:	8552                	mv	a0,s4
ffffffffc0200e2a:	15b000ef          	jal	ra,ffffffffc0201784 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0200e2e:	4515                	li	a0,5
ffffffffc0200e30:	117000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200e34:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0200e36:	26050563          	beqz	a0,ffffffffc02010a0 <default_check+0x416>
ffffffffc0200e3a:	651c                	ld	a5,8(a0)
ffffffffc0200e3c:	8385                	srli	a5,a5,0x1
    assert(!PageProperty(p0));
ffffffffc0200e3e:	8b85                	andi	a5,a5,1
ffffffffc0200e40:	54079063          	bnez	a5,ffffffffc0201380 <default_check+0x6f6>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0200e44:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200e46:	00043b03          	ld	s6,0(s0)
ffffffffc0200e4a:	00843a83          	ld	s5,8(s0)
ffffffffc0200e4e:	e000                	sd	s0,0(s0)
ffffffffc0200e50:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0200e52:	0f5000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200e56:	50051563          	bnez	a0,ffffffffc0201360 <default_check+0x6d6>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0200e5a:	05098a13          	addi	s4,s3,80
ffffffffc0200e5e:	8552                	mv	a0,s4
ffffffffc0200e60:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0200e62:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0200e66:	00006797          	auipc	a5,0x6
ffffffffc0200e6a:	1c07a923          	sw	zero,466(a5) # ffffffffc0207038 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0200e6e:	117000ef          	jal	ra,ffffffffc0201784 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0200e72:	4511                	li	a0,4
ffffffffc0200e74:	0d3000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200e78:	4c051463          	bnez	a0,ffffffffc0201340 <default_check+0x6b6>
ffffffffc0200e7c:	0589b783          	ld	a5,88(s3)
ffffffffc0200e80:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0200e82:	8b85                	andi	a5,a5,1
ffffffffc0200e84:	48078e63          	beqz	a5,ffffffffc0201320 <default_check+0x696>
ffffffffc0200e88:	0609a703          	lw	a4,96(s3)
ffffffffc0200e8c:	478d                	li	a5,3
ffffffffc0200e8e:	48f71963          	bne	a4,a5,ffffffffc0201320 <default_check+0x696>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0200e92:	450d                	li	a0,3
ffffffffc0200e94:	0b3000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200e98:	8c2a                	mv	s8,a0
ffffffffc0200e9a:	46050363          	beqz	a0,ffffffffc0201300 <default_check+0x676>
    assert(alloc_page() == NULL);
ffffffffc0200e9e:	4505                	li	a0,1
ffffffffc0200ea0:	0a7000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200ea4:	42051e63          	bnez	a0,ffffffffc02012e0 <default_check+0x656>
    assert(p0 + 2 == p1);
ffffffffc0200ea8:	418a1c63          	bne	s4,s8,ffffffffc02012c0 <default_check+0x636>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0200eac:	4585                	li	a1,1
ffffffffc0200eae:	854e                	mv	a0,s3
ffffffffc0200eb0:	0d5000ef          	jal	ra,ffffffffc0201784 <free_pages>
    free_pages(p1, 3);
ffffffffc0200eb4:	458d                	li	a1,3
ffffffffc0200eb6:	8552                	mv	a0,s4
ffffffffc0200eb8:	0cd000ef          	jal	ra,ffffffffc0201784 <free_pages>
ffffffffc0200ebc:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0200ec0:	02898c13          	addi	s8,s3,40
ffffffffc0200ec4:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0200ec6:	8b85                	andi	a5,a5,1
ffffffffc0200ec8:	3c078c63          	beqz	a5,ffffffffc02012a0 <default_check+0x616>
ffffffffc0200ecc:	0109a703          	lw	a4,16(s3)
ffffffffc0200ed0:	4785                	li	a5,1
ffffffffc0200ed2:	3cf71763          	bne	a4,a5,ffffffffc02012a0 <default_check+0x616>
ffffffffc0200ed6:	008a3783          	ld	a5,8(s4)
ffffffffc0200eda:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0200edc:	8b85                	andi	a5,a5,1
ffffffffc0200ede:	3a078163          	beqz	a5,ffffffffc0201280 <default_check+0x5f6>
ffffffffc0200ee2:	010a2703          	lw	a4,16(s4)
ffffffffc0200ee6:	478d                	li	a5,3
ffffffffc0200ee8:	38f71c63          	bne	a4,a5,ffffffffc0201280 <default_check+0x5f6>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0200eec:	4505                	li	a0,1
ffffffffc0200eee:	059000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200ef2:	36a99763          	bne	s3,a0,ffffffffc0201260 <default_check+0x5d6>
    free_page(p0);
ffffffffc0200ef6:	4585                	li	a1,1
ffffffffc0200ef8:	08d000ef          	jal	ra,ffffffffc0201784 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0200efc:	4509                	li	a0,2
ffffffffc0200efe:	049000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200f02:	32aa1f63          	bne	s4,a0,ffffffffc0201240 <default_check+0x5b6>

    free_pages(p0, 2);
ffffffffc0200f06:	4589                	li	a1,2
ffffffffc0200f08:	07d000ef          	jal	ra,ffffffffc0201784 <free_pages>
    free_page(p2);
ffffffffc0200f0c:	4585                	li	a1,1
ffffffffc0200f0e:	8562                	mv	a0,s8
ffffffffc0200f10:	075000ef          	jal	ra,ffffffffc0201784 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0200f14:	4515                	li	a0,5
ffffffffc0200f16:	031000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200f1a:	89aa                	mv	s3,a0
ffffffffc0200f1c:	48050263          	beqz	a0,ffffffffc02013a0 <default_check+0x716>
    assert(alloc_page() == NULL);
ffffffffc0200f20:	4505                	li	a0,1
ffffffffc0200f22:	025000ef          	jal	ra,ffffffffc0201746 <alloc_pages>
ffffffffc0200f26:	2c051d63          	bnez	a0,ffffffffc0201200 <default_check+0x576>

    assert(nr_free == 0);
ffffffffc0200f2a:	481c                	lw	a5,16(s0)
ffffffffc0200f2c:	2a079a63          	bnez	a5,ffffffffc02011e0 <default_check+0x556>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0200f30:	4595                	li	a1,5
ffffffffc0200f32:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0200f34:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0200f38:	01643023          	sd	s6,0(s0)
ffffffffc0200f3c:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0200f40:	045000ef          	jal	ra,ffffffffc0201784 <free_pages>
    return listelm->next;
ffffffffc0200f44:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f46:	00878963          	beq	a5,s0,ffffffffc0200f58 <default_check+0x2ce>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0200f4a:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200f4e:	679c                	ld	a5,8(a5)
ffffffffc0200f50:	397d                	addiw	s2,s2,-1
ffffffffc0200f52:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f54:	fe879be3          	bne	a5,s0,ffffffffc0200f4a <default_check+0x2c0>
    }
    assert(count == 0);
ffffffffc0200f58:	26091463          	bnez	s2,ffffffffc02011c0 <default_check+0x536>
    assert(total == 0);
ffffffffc0200f5c:	46049263          	bnez	s1,ffffffffc02013c0 <default_check+0x736>
}
ffffffffc0200f60:	60a6                	ld	ra,72(sp)
ffffffffc0200f62:	6406                	ld	s0,64(sp)
ffffffffc0200f64:	74e2                	ld	s1,56(sp)
ffffffffc0200f66:	7942                	ld	s2,48(sp)
ffffffffc0200f68:	79a2                	ld	s3,40(sp)
ffffffffc0200f6a:	7a02                	ld	s4,32(sp)
ffffffffc0200f6c:	6ae2                	ld	s5,24(sp)
ffffffffc0200f6e:	6b42                	ld	s6,16(sp)
ffffffffc0200f70:	6ba2                	ld	s7,8(sp)
ffffffffc0200f72:	6c02                	ld	s8,0(sp)
ffffffffc0200f74:	6161                	addi	sp,sp,80
ffffffffc0200f76:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f78:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0200f7a:	4481                	li	s1,0
ffffffffc0200f7c:	4901                	li	s2,0
ffffffffc0200f7e:	b3b9                	j	ffffffffc0200ccc <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0200f80:	00002697          	auipc	a3,0x2
ffffffffc0200f84:	93868693          	addi	a3,a3,-1736 # ffffffffc02028b8 <commands+0x6d0>
ffffffffc0200f88:	00002617          	auipc	a2,0x2
ffffffffc0200f8c:	94060613          	addi	a2,a2,-1728 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0200f90:	0f000593          	li	a1,240
ffffffffc0200f94:	00002517          	auipc	a0,0x2
ffffffffc0200f98:	94c50513          	addi	a0,a0,-1716 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0200f9c:	c36ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200fa0:	00002697          	auipc	a3,0x2
ffffffffc0200fa4:	9d868693          	addi	a3,a3,-1576 # ffffffffc0202978 <commands+0x790>
ffffffffc0200fa8:	00002617          	auipc	a2,0x2
ffffffffc0200fac:	92060613          	addi	a2,a2,-1760 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0200fb0:	0bd00593          	li	a1,189
ffffffffc0200fb4:	00002517          	auipc	a0,0x2
ffffffffc0200fb8:	92c50513          	addi	a0,a0,-1748 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0200fbc:	c16ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200fc0:	00002697          	auipc	a3,0x2
ffffffffc0200fc4:	9e068693          	addi	a3,a3,-1568 # ffffffffc02029a0 <commands+0x7b8>
ffffffffc0200fc8:	00002617          	auipc	a2,0x2
ffffffffc0200fcc:	90060613          	addi	a2,a2,-1792 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0200fd0:	0be00593          	li	a1,190
ffffffffc0200fd4:	00002517          	auipc	a0,0x2
ffffffffc0200fd8:	90c50513          	addi	a0,a0,-1780 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0200fdc:	bf6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200fe0:	00002697          	auipc	a3,0x2
ffffffffc0200fe4:	a0068693          	addi	a3,a3,-1536 # ffffffffc02029e0 <commands+0x7f8>
ffffffffc0200fe8:	00002617          	auipc	a2,0x2
ffffffffc0200fec:	8e060613          	addi	a2,a2,-1824 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0200ff0:	0c000593          	li	a1,192
ffffffffc0200ff4:	00002517          	auipc	a0,0x2
ffffffffc0200ff8:	8ec50513          	addi	a0,a0,-1812 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0200ffc:	bd6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201000:	00002697          	auipc	a3,0x2
ffffffffc0201004:	a6868693          	addi	a3,a3,-1432 # ffffffffc0202a68 <commands+0x880>
ffffffffc0201008:	00002617          	auipc	a2,0x2
ffffffffc020100c:	8c060613          	addi	a2,a2,-1856 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201010:	0d900593          	li	a1,217
ffffffffc0201014:	00002517          	auipc	a0,0x2
ffffffffc0201018:	8cc50513          	addi	a0,a0,-1844 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020101c:	bb6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201020:	00002697          	auipc	a3,0x2
ffffffffc0201024:	8f868693          	addi	a3,a3,-1800 # ffffffffc0202918 <commands+0x730>
ffffffffc0201028:	00002617          	auipc	a2,0x2
ffffffffc020102c:	8a060613          	addi	a2,a2,-1888 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201030:	0d200593          	li	a1,210
ffffffffc0201034:	00002517          	auipc	a0,0x2
ffffffffc0201038:	8ac50513          	addi	a0,a0,-1876 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020103c:	b96ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(nr_free == 3);
ffffffffc0201040:	00002697          	auipc	a3,0x2
ffffffffc0201044:	a1868693          	addi	a3,a3,-1512 # ffffffffc0202a58 <commands+0x870>
ffffffffc0201048:	00002617          	auipc	a2,0x2
ffffffffc020104c:	88060613          	addi	a2,a2,-1920 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201050:	0d000593          	li	a1,208
ffffffffc0201054:	00002517          	auipc	a0,0x2
ffffffffc0201058:	88c50513          	addi	a0,a0,-1908 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020105c:	b76ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201060:	00002697          	auipc	a3,0x2
ffffffffc0201064:	9e068693          	addi	a3,a3,-1568 # ffffffffc0202a40 <commands+0x858>
ffffffffc0201068:	00002617          	auipc	a2,0x2
ffffffffc020106c:	86060613          	addi	a2,a2,-1952 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201070:	0cb00593          	li	a1,203
ffffffffc0201074:	00002517          	auipc	a0,0x2
ffffffffc0201078:	86c50513          	addi	a0,a0,-1940 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020107c:	b56ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0201080:	00002697          	auipc	a3,0x2
ffffffffc0201084:	9a068693          	addi	a3,a3,-1632 # ffffffffc0202a20 <commands+0x838>
ffffffffc0201088:	00002617          	auipc	a2,0x2
ffffffffc020108c:	84060613          	addi	a2,a2,-1984 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201090:	0c200593          	li	a1,194
ffffffffc0201094:	00002517          	auipc	a0,0x2
ffffffffc0201098:	84c50513          	addi	a0,a0,-1972 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020109c:	b36ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(p0 != NULL);
ffffffffc02010a0:	00002697          	auipc	a3,0x2
ffffffffc02010a4:	a1068693          	addi	a3,a3,-1520 # ffffffffc0202ab0 <commands+0x8c8>
ffffffffc02010a8:	00002617          	auipc	a2,0x2
ffffffffc02010ac:	82060613          	addi	a2,a2,-2016 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02010b0:	0f800593          	li	a1,248
ffffffffc02010b4:	00002517          	auipc	a0,0x2
ffffffffc02010b8:	82c50513          	addi	a0,a0,-2004 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02010bc:	b16ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(nr_free == 0);
ffffffffc02010c0:	00002697          	auipc	a3,0x2
ffffffffc02010c4:	9e068693          	addi	a3,a3,-1568 # ffffffffc0202aa0 <commands+0x8b8>
ffffffffc02010c8:	00002617          	auipc	a2,0x2
ffffffffc02010cc:	80060613          	addi	a2,a2,-2048 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02010d0:	0df00593          	li	a1,223
ffffffffc02010d4:	00002517          	auipc	a0,0x2
ffffffffc02010d8:	80c50513          	addi	a0,a0,-2036 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02010dc:	af6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02010e0:	00002697          	auipc	a3,0x2
ffffffffc02010e4:	96068693          	addi	a3,a3,-1696 # ffffffffc0202a40 <commands+0x858>
ffffffffc02010e8:	00001617          	auipc	a2,0x1
ffffffffc02010ec:	7e060613          	addi	a2,a2,2016 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02010f0:	0dd00593          	li	a1,221
ffffffffc02010f4:	00001517          	auipc	a0,0x1
ffffffffc02010f8:	7ec50513          	addi	a0,a0,2028 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02010fc:	ad6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201100:	00002697          	auipc	a3,0x2
ffffffffc0201104:	98068693          	addi	a3,a3,-1664 # ffffffffc0202a80 <commands+0x898>
ffffffffc0201108:	00001617          	auipc	a2,0x1
ffffffffc020110c:	7c060613          	addi	a2,a2,1984 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201110:	0dc00593          	li	a1,220
ffffffffc0201114:	00001517          	auipc	a0,0x1
ffffffffc0201118:	7cc50513          	addi	a0,a0,1996 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020111c:	ab6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201120:	00001697          	auipc	a3,0x1
ffffffffc0201124:	7f868693          	addi	a3,a3,2040 # ffffffffc0202918 <commands+0x730>
ffffffffc0201128:	00001617          	auipc	a2,0x1
ffffffffc020112c:	7a060613          	addi	a2,a2,1952 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201130:	0b900593          	li	a1,185
ffffffffc0201134:	00001517          	auipc	a0,0x1
ffffffffc0201138:	7ac50513          	addi	a0,a0,1964 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020113c:	a96ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201140:	00002697          	auipc	a3,0x2
ffffffffc0201144:	90068693          	addi	a3,a3,-1792 # ffffffffc0202a40 <commands+0x858>
ffffffffc0201148:	00001617          	auipc	a2,0x1
ffffffffc020114c:	78060613          	addi	a2,a2,1920 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201150:	0d600593          	li	a1,214
ffffffffc0201154:	00001517          	auipc	a0,0x1
ffffffffc0201158:	78c50513          	addi	a0,a0,1932 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020115c:	a76ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201160:	00001697          	auipc	a3,0x1
ffffffffc0201164:	7f868693          	addi	a3,a3,2040 # ffffffffc0202958 <commands+0x770>
ffffffffc0201168:	00001617          	auipc	a2,0x1
ffffffffc020116c:	76060613          	addi	a2,a2,1888 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201170:	0d400593          	li	a1,212
ffffffffc0201174:	00001517          	auipc	a0,0x1
ffffffffc0201178:	76c50513          	addi	a0,a0,1900 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020117c:	a56ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201180:	00001697          	auipc	a3,0x1
ffffffffc0201184:	7b868693          	addi	a3,a3,1976 # ffffffffc0202938 <commands+0x750>
ffffffffc0201188:	00001617          	auipc	a2,0x1
ffffffffc020118c:	74060613          	addi	a2,a2,1856 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201190:	0d300593          	li	a1,211
ffffffffc0201194:	00001517          	auipc	a0,0x1
ffffffffc0201198:	74c50513          	addi	a0,a0,1868 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020119c:	a36ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02011a0:	00001697          	auipc	a3,0x1
ffffffffc02011a4:	7b868693          	addi	a3,a3,1976 # ffffffffc0202958 <commands+0x770>
ffffffffc02011a8:	00001617          	auipc	a2,0x1
ffffffffc02011ac:	72060613          	addi	a2,a2,1824 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02011b0:	0bb00593          	li	a1,187
ffffffffc02011b4:	00001517          	auipc	a0,0x1
ffffffffc02011b8:	72c50513          	addi	a0,a0,1836 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02011bc:	a16ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(count == 0);
ffffffffc02011c0:	00002697          	auipc	a3,0x2
ffffffffc02011c4:	a4068693          	addi	a3,a3,-1472 # ffffffffc0202c00 <commands+0xa18>
ffffffffc02011c8:	00001617          	auipc	a2,0x1
ffffffffc02011cc:	70060613          	addi	a2,a2,1792 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02011d0:	12500593          	li	a1,293
ffffffffc02011d4:	00001517          	auipc	a0,0x1
ffffffffc02011d8:	70c50513          	addi	a0,a0,1804 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02011dc:	9f6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(nr_free == 0);
ffffffffc02011e0:	00002697          	auipc	a3,0x2
ffffffffc02011e4:	8c068693          	addi	a3,a3,-1856 # ffffffffc0202aa0 <commands+0x8b8>
ffffffffc02011e8:	00001617          	auipc	a2,0x1
ffffffffc02011ec:	6e060613          	addi	a2,a2,1760 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02011f0:	11a00593          	li	a1,282
ffffffffc02011f4:	00001517          	auipc	a0,0x1
ffffffffc02011f8:	6ec50513          	addi	a0,a0,1772 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02011fc:	9d6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201200:	00002697          	auipc	a3,0x2
ffffffffc0201204:	84068693          	addi	a3,a3,-1984 # ffffffffc0202a40 <commands+0x858>
ffffffffc0201208:	00001617          	auipc	a2,0x1
ffffffffc020120c:	6c060613          	addi	a2,a2,1728 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201210:	11800593          	li	a1,280
ffffffffc0201214:	00001517          	auipc	a0,0x1
ffffffffc0201218:	6cc50513          	addi	a0,a0,1740 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020121c:	9b6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201220:	00001697          	auipc	a3,0x1
ffffffffc0201224:	7e068693          	addi	a3,a3,2016 # ffffffffc0202a00 <commands+0x818>
ffffffffc0201228:	00001617          	auipc	a2,0x1
ffffffffc020122c:	6a060613          	addi	a2,a2,1696 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201230:	0c100593          	li	a1,193
ffffffffc0201234:	00001517          	auipc	a0,0x1
ffffffffc0201238:	6ac50513          	addi	a0,a0,1708 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020123c:	996ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201240:	00002697          	auipc	a3,0x2
ffffffffc0201244:	98068693          	addi	a3,a3,-1664 # ffffffffc0202bc0 <commands+0x9d8>
ffffffffc0201248:	00001617          	auipc	a2,0x1
ffffffffc020124c:	68060613          	addi	a2,a2,1664 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201250:	11200593          	li	a1,274
ffffffffc0201254:	00001517          	auipc	a0,0x1
ffffffffc0201258:	68c50513          	addi	a0,a0,1676 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020125c:	976ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201260:	00002697          	auipc	a3,0x2
ffffffffc0201264:	94068693          	addi	a3,a3,-1728 # ffffffffc0202ba0 <commands+0x9b8>
ffffffffc0201268:	00001617          	auipc	a2,0x1
ffffffffc020126c:	66060613          	addi	a2,a2,1632 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201270:	11000593          	li	a1,272
ffffffffc0201274:	00001517          	auipc	a0,0x1
ffffffffc0201278:	66c50513          	addi	a0,a0,1644 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020127c:	956ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201280:	00002697          	auipc	a3,0x2
ffffffffc0201284:	8f868693          	addi	a3,a3,-1800 # ffffffffc0202b78 <commands+0x990>
ffffffffc0201288:	00001617          	auipc	a2,0x1
ffffffffc020128c:	64060613          	addi	a2,a2,1600 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201290:	10e00593          	li	a1,270
ffffffffc0201294:	00001517          	auipc	a0,0x1
ffffffffc0201298:	64c50513          	addi	a0,a0,1612 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020129c:	936ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc02012a0:	00002697          	auipc	a3,0x2
ffffffffc02012a4:	8b068693          	addi	a3,a3,-1872 # ffffffffc0202b50 <commands+0x968>
ffffffffc02012a8:	00001617          	auipc	a2,0x1
ffffffffc02012ac:	62060613          	addi	a2,a2,1568 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02012b0:	10d00593          	li	a1,269
ffffffffc02012b4:	00001517          	auipc	a0,0x1
ffffffffc02012b8:	62c50513          	addi	a0,a0,1580 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02012bc:	916ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(p0 + 2 == p1);
ffffffffc02012c0:	00002697          	auipc	a3,0x2
ffffffffc02012c4:	88068693          	addi	a3,a3,-1920 # ffffffffc0202b40 <commands+0x958>
ffffffffc02012c8:	00001617          	auipc	a2,0x1
ffffffffc02012cc:	60060613          	addi	a2,a2,1536 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02012d0:	10800593          	li	a1,264
ffffffffc02012d4:	00001517          	auipc	a0,0x1
ffffffffc02012d8:	60c50513          	addi	a0,a0,1548 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02012dc:	8f6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02012e0:	00001697          	auipc	a3,0x1
ffffffffc02012e4:	76068693          	addi	a3,a3,1888 # ffffffffc0202a40 <commands+0x858>
ffffffffc02012e8:	00001617          	auipc	a2,0x1
ffffffffc02012ec:	5e060613          	addi	a2,a2,1504 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02012f0:	10700593          	li	a1,263
ffffffffc02012f4:	00001517          	auipc	a0,0x1
ffffffffc02012f8:	5ec50513          	addi	a0,a0,1516 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02012fc:	8d6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201300:	00002697          	auipc	a3,0x2
ffffffffc0201304:	82068693          	addi	a3,a3,-2016 # ffffffffc0202b20 <commands+0x938>
ffffffffc0201308:	00001617          	auipc	a2,0x1
ffffffffc020130c:	5c060613          	addi	a2,a2,1472 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201310:	10600593          	li	a1,262
ffffffffc0201314:	00001517          	auipc	a0,0x1
ffffffffc0201318:	5cc50513          	addi	a0,a0,1484 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020131c:	8b6ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201320:	00001697          	auipc	a3,0x1
ffffffffc0201324:	7d068693          	addi	a3,a3,2000 # ffffffffc0202af0 <commands+0x908>
ffffffffc0201328:	00001617          	auipc	a2,0x1
ffffffffc020132c:	5a060613          	addi	a2,a2,1440 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201330:	10500593          	li	a1,261
ffffffffc0201334:	00001517          	auipc	a0,0x1
ffffffffc0201338:	5ac50513          	addi	a0,a0,1452 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020133c:	896ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0201340:	00001697          	auipc	a3,0x1
ffffffffc0201344:	79868693          	addi	a3,a3,1944 # ffffffffc0202ad8 <commands+0x8f0>
ffffffffc0201348:	00001617          	auipc	a2,0x1
ffffffffc020134c:	58060613          	addi	a2,a2,1408 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201350:	10400593          	li	a1,260
ffffffffc0201354:	00001517          	auipc	a0,0x1
ffffffffc0201358:	58c50513          	addi	a0,a0,1420 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020135c:	876ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201360:	00001697          	auipc	a3,0x1
ffffffffc0201364:	6e068693          	addi	a3,a3,1760 # ffffffffc0202a40 <commands+0x858>
ffffffffc0201368:	00001617          	auipc	a2,0x1
ffffffffc020136c:	56060613          	addi	a2,a2,1376 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201370:	0fe00593          	li	a1,254
ffffffffc0201374:	00001517          	auipc	a0,0x1
ffffffffc0201378:	56c50513          	addi	a0,a0,1388 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020137c:	856ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(!PageProperty(p0));
ffffffffc0201380:	00001697          	auipc	a3,0x1
ffffffffc0201384:	74068693          	addi	a3,a3,1856 # ffffffffc0202ac0 <commands+0x8d8>
ffffffffc0201388:	00001617          	auipc	a2,0x1
ffffffffc020138c:	54060613          	addi	a2,a2,1344 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201390:	0f900593          	li	a1,249
ffffffffc0201394:	00001517          	auipc	a0,0x1
ffffffffc0201398:	54c50513          	addi	a0,a0,1356 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020139c:	836ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc02013a0:	00002697          	auipc	a3,0x2
ffffffffc02013a4:	84068693          	addi	a3,a3,-1984 # ffffffffc0202be0 <commands+0x9f8>
ffffffffc02013a8:	00001617          	auipc	a2,0x1
ffffffffc02013ac:	52060613          	addi	a2,a2,1312 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02013b0:	11700593          	li	a1,279
ffffffffc02013b4:	00001517          	auipc	a0,0x1
ffffffffc02013b8:	52c50513          	addi	a0,a0,1324 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02013bc:	816ff0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(total == 0);
ffffffffc02013c0:	00002697          	auipc	a3,0x2
ffffffffc02013c4:	85068693          	addi	a3,a3,-1968 # ffffffffc0202c10 <commands+0xa28>
ffffffffc02013c8:	00001617          	auipc	a2,0x1
ffffffffc02013cc:	50060613          	addi	a2,a2,1280 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02013d0:	12600593          	li	a1,294
ffffffffc02013d4:	00001517          	auipc	a0,0x1
ffffffffc02013d8:	50c50513          	addi	a0,a0,1292 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02013dc:	ff7fe0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(total == nr_free_pages());
ffffffffc02013e0:	00001697          	auipc	a3,0x1
ffffffffc02013e4:	51868693          	addi	a3,a3,1304 # ffffffffc02028f8 <commands+0x710>
ffffffffc02013e8:	00001617          	auipc	a2,0x1
ffffffffc02013ec:	4e060613          	addi	a2,a2,1248 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc02013f0:	0f300593          	li	a1,243
ffffffffc02013f4:	00001517          	auipc	a0,0x1
ffffffffc02013f8:	4ec50513          	addi	a0,a0,1260 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc02013fc:	fd7fe0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201400:	00001697          	auipc	a3,0x1
ffffffffc0201404:	53868693          	addi	a3,a3,1336 # ffffffffc0202938 <commands+0x750>
ffffffffc0201408:	00001617          	auipc	a2,0x1
ffffffffc020140c:	4c060613          	addi	a2,a2,1216 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201410:	0ba00593          	li	a1,186
ffffffffc0201414:	00001517          	auipc	a0,0x1
ffffffffc0201418:	4cc50513          	addi	a0,a0,1228 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc020141c:	fb7fe0ef          	jal	ra,ffffffffc02003d2 <__panic>

ffffffffc0201420 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0201420:	1141                	addi	sp,sp,-16
ffffffffc0201422:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201424:	14058a63          	beqz	a1,ffffffffc0201578 <default_free_pages+0x158>
    for (; p != base + n; p ++) {
ffffffffc0201428:	00259693          	slli	a3,a1,0x2
ffffffffc020142c:	96ae                	add	a3,a3,a1
ffffffffc020142e:	068e                	slli	a3,a3,0x3
ffffffffc0201430:	96aa                	add	a3,a3,a0
ffffffffc0201432:	87aa                	mv	a5,a0
ffffffffc0201434:	02d50263          	beq	a0,a3,ffffffffc0201458 <default_free_pages+0x38>
ffffffffc0201438:	6798                	ld	a4,8(a5)
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc020143a:	8b05                	andi	a4,a4,1
ffffffffc020143c:	10071e63          	bnez	a4,ffffffffc0201558 <default_free_pages+0x138>
ffffffffc0201440:	6798                	ld	a4,8(a5)
ffffffffc0201442:	8b09                	andi	a4,a4,2
ffffffffc0201444:	10071a63          	bnez	a4,ffffffffc0201558 <default_free_pages+0x138>
        p->flags = 0;
ffffffffc0201448:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc020144c:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0201450:	02878793          	addi	a5,a5,40
ffffffffc0201454:	fed792e3          	bne	a5,a3,ffffffffc0201438 <default_free_pages+0x18>
    base->property = n;
ffffffffc0201458:	2581                	sext.w	a1,a1
ffffffffc020145a:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc020145c:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201460:	4789                	li	a5,2
ffffffffc0201462:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc0201466:	00006697          	auipc	a3,0x6
ffffffffc020146a:	bc268693          	addi	a3,a3,-1086 # ffffffffc0207028 <free_area>
ffffffffc020146e:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0201470:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc0201472:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc0201476:	9db9                	addw	a1,a1,a4
ffffffffc0201478:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc020147a:	0ad78863          	beq	a5,a3,ffffffffc020152a <default_free_pages+0x10a>
            struct Page* page = le2page(le, page_link);
ffffffffc020147e:	fe878713          	addi	a4,a5,-24
ffffffffc0201482:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0201486:	4581                	li	a1,0
            if (base < page) {
ffffffffc0201488:	00e56a63          	bltu	a0,a4,ffffffffc020149c <default_free_pages+0x7c>
    return listelm->next;
ffffffffc020148c:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc020148e:	06d70263          	beq	a4,a3,ffffffffc02014f2 <default_free_pages+0xd2>
    for (; p != base + n; p ++) {
ffffffffc0201492:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0201494:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0201498:	fee57ae3          	bgeu	a0,a4,ffffffffc020148c <default_free_pages+0x6c>
ffffffffc020149c:	c199                	beqz	a1,ffffffffc02014a2 <default_free_pages+0x82>
ffffffffc020149e:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02014a2:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02014a4:	e390                	sd	a2,0(a5)
ffffffffc02014a6:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02014a8:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02014aa:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc02014ac:	02d70063          	beq	a4,a3,ffffffffc02014cc <default_free_pages+0xac>
        if (p + p->property == base) {
ffffffffc02014b0:	ff872803          	lw	a6,-8(a4)
        p = le2page(le, page_link);
ffffffffc02014b4:	fe870593          	addi	a1,a4,-24
        if (p + p->property == base) {
ffffffffc02014b8:	02081613          	slli	a2,a6,0x20
ffffffffc02014bc:	9201                	srli	a2,a2,0x20
ffffffffc02014be:	00261793          	slli	a5,a2,0x2
ffffffffc02014c2:	97b2                	add	a5,a5,a2
ffffffffc02014c4:	078e                	slli	a5,a5,0x3
ffffffffc02014c6:	97ae                	add	a5,a5,a1
ffffffffc02014c8:	02f50f63          	beq	a0,a5,ffffffffc0201506 <default_free_pages+0xe6>
    return listelm->next;
ffffffffc02014cc:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc02014ce:	00d70f63          	beq	a4,a3,ffffffffc02014ec <default_free_pages+0xcc>
        if (base + base->property == p) {
ffffffffc02014d2:	490c                	lw	a1,16(a0)
        p = le2page(le, page_link);
ffffffffc02014d4:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc02014d8:	02059613          	slli	a2,a1,0x20
ffffffffc02014dc:	9201                	srli	a2,a2,0x20
ffffffffc02014de:	00261793          	slli	a5,a2,0x2
ffffffffc02014e2:	97b2                	add	a5,a5,a2
ffffffffc02014e4:	078e                	slli	a5,a5,0x3
ffffffffc02014e6:	97aa                	add	a5,a5,a0
ffffffffc02014e8:	04f68863          	beq	a3,a5,ffffffffc0201538 <default_free_pages+0x118>
}
ffffffffc02014ec:	60a2                	ld	ra,8(sp)
ffffffffc02014ee:	0141                	addi	sp,sp,16
ffffffffc02014f0:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc02014f2:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02014f4:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc02014f6:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc02014f8:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc02014fa:	02d70563          	beq	a4,a3,ffffffffc0201524 <default_free_pages+0x104>
    prev->next = next->prev = elm;
ffffffffc02014fe:	8832                	mv	a6,a2
ffffffffc0201500:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0201502:	87ba                	mv	a5,a4
ffffffffc0201504:	bf41                	j	ffffffffc0201494 <default_free_pages+0x74>
            p->property += base->property;
ffffffffc0201506:	491c                	lw	a5,16(a0)
ffffffffc0201508:	0107883b          	addw	a6,a5,a6
ffffffffc020150c:	ff072c23          	sw	a6,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201510:	57f5                	li	a5,-3
ffffffffc0201512:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201516:	6d10                	ld	a2,24(a0)
ffffffffc0201518:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc020151a:	852e                	mv	a0,a1
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc020151c:	e61c                	sd	a5,8(a2)
    return listelm->next;
ffffffffc020151e:	6718                	ld	a4,8(a4)
    next->prev = prev;
ffffffffc0201520:	e390                	sd	a2,0(a5)
ffffffffc0201522:	b775                	j	ffffffffc02014ce <default_free_pages+0xae>
ffffffffc0201524:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0201526:	873e                	mv	a4,a5
ffffffffc0201528:	b761                	j	ffffffffc02014b0 <default_free_pages+0x90>
}
ffffffffc020152a:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc020152c:	e390                	sd	a2,0(a5)
ffffffffc020152e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201530:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201532:	ed1c                	sd	a5,24(a0)
ffffffffc0201534:	0141                	addi	sp,sp,16
ffffffffc0201536:	8082                	ret
            base->property += p->property;
ffffffffc0201538:	ff872783          	lw	a5,-8(a4)
ffffffffc020153c:	ff070693          	addi	a3,a4,-16
ffffffffc0201540:	9dbd                	addw	a1,a1,a5
ffffffffc0201542:	c90c                	sw	a1,16(a0)
ffffffffc0201544:	57f5                	li	a5,-3
ffffffffc0201546:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc020154a:	6314                	ld	a3,0(a4)
ffffffffc020154c:	671c                	ld	a5,8(a4)
}
ffffffffc020154e:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0201550:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc0201552:	e394                	sd	a3,0(a5)
ffffffffc0201554:	0141                	addi	sp,sp,16
ffffffffc0201556:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0201558:	00001697          	auipc	a3,0x1
ffffffffc020155c:	6d068693          	addi	a3,a3,1744 # ffffffffc0202c28 <commands+0xa40>
ffffffffc0201560:	00001617          	auipc	a2,0x1
ffffffffc0201564:	36860613          	addi	a2,a2,872 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201568:	08300593          	li	a1,131
ffffffffc020156c:	00001517          	auipc	a0,0x1
ffffffffc0201570:	37450513          	addi	a0,a0,884 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0201574:	e5ffe0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(n > 0);
ffffffffc0201578:	00001697          	auipc	a3,0x1
ffffffffc020157c:	6a868693          	addi	a3,a3,1704 # ffffffffc0202c20 <commands+0xa38>
ffffffffc0201580:	00001617          	auipc	a2,0x1
ffffffffc0201584:	34860613          	addi	a2,a2,840 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201588:	08000593          	li	a1,128
ffffffffc020158c:	00001517          	auipc	a0,0x1
ffffffffc0201590:	35450513          	addi	a0,a0,852 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0201594:	e3ffe0ef          	jal	ra,ffffffffc02003d2 <__panic>

ffffffffc0201598 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0201598:	c959                	beqz	a0,ffffffffc020162e <default_alloc_pages+0x96>
    if (n > nr_free) {
ffffffffc020159a:	00006597          	auipc	a1,0x6
ffffffffc020159e:	a8e58593          	addi	a1,a1,-1394 # ffffffffc0207028 <free_area>
ffffffffc02015a2:	0105a803          	lw	a6,16(a1)
ffffffffc02015a6:	862a                	mv	a2,a0
ffffffffc02015a8:	02081793          	slli	a5,a6,0x20
ffffffffc02015ac:	9381                	srli	a5,a5,0x20
ffffffffc02015ae:	00a7ee63          	bltu	a5,a0,ffffffffc02015ca <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc02015b2:	87ae                	mv	a5,a1
ffffffffc02015b4:	a801                	j	ffffffffc02015c4 <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc02015b6:	ff87a703          	lw	a4,-8(a5)
ffffffffc02015ba:	02071693          	slli	a3,a4,0x20
ffffffffc02015be:	9281                	srli	a3,a3,0x20
ffffffffc02015c0:	00c6f763          	bgeu	a3,a2,ffffffffc02015ce <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc02015c4:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc02015c6:	feb798e3          	bne	a5,a1,ffffffffc02015b6 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc02015ca:	4501                	li	a0,0
}
ffffffffc02015cc:	8082                	ret
    return listelm->prev;
ffffffffc02015ce:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc02015d2:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc02015d6:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc02015da:	00060e1b          	sext.w	t3,a2
    prev->next = next;
ffffffffc02015de:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc02015e2:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc02015e6:	02d67b63          	bgeu	a2,a3,ffffffffc020161c <default_alloc_pages+0x84>
            struct Page *p = page + n;
ffffffffc02015ea:	00261693          	slli	a3,a2,0x2
ffffffffc02015ee:	96b2                	add	a3,a3,a2
ffffffffc02015f0:	068e                	slli	a3,a3,0x3
ffffffffc02015f2:	96aa                	add	a3,a3,a0
            p->property = page->property - n;
ffffffffc02015f4:	41c7073b          	subw	a4,a4,t3
ffffffffc02015f8:	ca98                	sw	a4,16(a3)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02015fa:	00868613          	addi	a2,a3,8
ffffffffc02015fe:	4709                	li	a4,2
ffffffffc0201600:	40e6302f          	amoor.d	zero,a4,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201604:	0088b703          	ld	a4,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201608:	01868613          	addi	a2,a3,24
        nr_free -= n;
ffffffffc020160c:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201610:	e310                	sd	a2,0(a4)
ffffffffc0201612:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201616:	f298                	sd	a4,32(a3)
    elm->prev = prev;
ffffffffc0201618:	0116bc23          	sd	a7,24(a3)
ffffffffc020161c:	41c8083b          	subw	a6,a6,t3
ffffffffc0201620:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201624:	5775                	li	a4,-3
ffffffffc0201626:	17c1                	addi	a5,a5,-16
ffffffffc0201628:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020162c:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc020162e:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0201630:	00001697          	auipc	a3,0x1
ffffffffc0201634:	5f068693          	addi	a3,a3,1520 # ffffffffc0202c20 <commands+0xa38>
ffffffffc0201638:	00001617          	auipc	a2,0x1
ffffffffc020163c:	29060613          	addi	a2,a2,656 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201640:	06200593          	li	a1,98
ffffffffc0201644:	00001517          	auipc	a0,0x1
ffffffffc0201648:	29c50513          	addi	a0,a0,668 # ffffffffc02028e0 <commands+0x6f8>
default_alloc_pages(size_t n) {
ffffffffc020164c:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020164e:	d85fe0ef          	jal	ra,ffffffffc02003d2 <__panic>

ffffffffc0201652 <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc0201652:	1141                	addi	sp,sp,-16
ffffffffc0201654:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201656:	c9e1                	beqz	a1,ffffffffc0201726 <default_init_memmap+0xd4>
    for (; p != base + n; p ++) {
ffffffffc0201658:	00259693          	slli	a3,a1,0x2
ffffffffc020165c:	96ae                	add	a3,a3,a1
ffffffffc020165e:	068e                	slli	a3,a3,0x3
ffffffffc0201660:	96aa                	add	a3,a3,a0
ffffffffc0201662:	87aa                	mv	a5,a0
ffffffffc0201664:	00d50f63          	beq	a0,a3,ffffffffc0201682 <default_init_memmap+0x30>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201668:	6798                	ld	a4,8(a5)
        assert(PageReserved(p));
ffffffffc020166a:	8b05                	andi	a4,a4,1
ffffffffc020166c:	cf49                	beqz	a4,ffffffffc0201706 <default_init_memmap+0xb4>
        p->flags = p->property = 0;
ffffffffc020166e:	0007a823          	sw	zero,16(a5)
ffffffffc0201672:	0007b423          	sd	zero,8(a5)
ffffffffc0201676:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc020167a:	02878793          	addi	a5,a5,40
ffffffffc020167e:	fed795e3          	bne	a5,a3,ffffffffc0201668 <default_init_memmap+0x16>
    base->property = n;
ffffffffc0201682:	2581                	sext.w	a1,a1
ffffffffc0201684:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201686:	4789                	li	a5,2
ffffffffc0201688:	00850713          	addi	a4,a0,8
ffffffffc020168c:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc0201690:	00006697          	auipc	a3,0x6
ffffffffc0201694:	99868693          	addi	a3,a3,-1640 # ffffffffc0207028 <free_area>
ffffffffc0201698:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc020169a:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc020169c:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02016a0:	9db9                	addw	a1,a1,a4
ffffffffc02016a2:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02016a4:	04d78a63          	beq	a5,a3,ffffffffc02016f8 <default_init_memmap+0xa6>
            struct Page* page = le2page(le, page_link);
ffffffffc02016a8:	fe878713          	addi	a4,a5,-24
ffffffffc02016ac:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02016b0:	4581                	li	a1,0
            if (base < page) {
ffffffffc02016b2:	00e56a63          	bltu	a0,a4,ffffffffc02016c6 <default_init_memmap+0x74>
    return listelm->next;
ffffffffc02016b6:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc02016b8:	02d70263          	beq	a4,a3,ffffffffc02016dc <default_init_memmap+0x8a>
    for (; p != base + n; p ++) {
ffffffffc02016bc:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc02016be:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc02016c2:	fee57ae3          	bgeu	a0,a4,ffffffffc02016b6 <default_init_memmap+0x64>
ffffffffc02016c6:	c199                	beqz	a1,ffffffffc02016cc <default_init_memmap+0x7a>
ffffffffc02016c8:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02016cc:	6398                	ld	a4,0(a5)
}
ffffffffc02016ce:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02016d0:	e390                	sd	a2,0(a5)
ffffffffc02016d2:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02016d4:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02016d6:	ed18                	sd	a4,24(a0)
ffffffffc02016d8:	0141                	addi	sp,sp,16
ffffffffc02016da:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc02016dc:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02016de:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc02016e0:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc02016e2:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc02016e4:	00d70663          	beq	a4,a3,ffffffffc02016f0 <default_init_memmap+0x9e>
    prev->next = next->prev = elm;
ffffffffc02016e8:	8832                	mv	a6,a2
ffffffffc02016ea:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc02016ec:	87ba                	mv	a5,a4
ffffffffc02016ee:	bfc1                	j	ffffffffc02016be <default_init_memmap+0x6c>
}
ffffffffc02016f0:	60a2                	ld	ra,8(sp)
ffffffffc02016f2:	e290                	sd	a2,0(a3)
ffffffffc02016f4:	0141                	addi	sp,sp,16
ffffffffc02016f6:	8082                	ret
ffffffffc02016f8:	60a2                	ld	ra,8(sp)
ffffffffc02016fa:	e390                	sd	a2,0(a5)
ffffffffc02016fc:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02016fe:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201700:	ed1c                	sd	a5,24(a0)
ffffffffc0201702:	0141                	addi	sp,sp,16
ffffffffc0201704:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201706:	00001697          	auipc	a3,0x1
ffffffffc020170a:	54a68693          	addi	a3,a3,1354 # ffffffffc0202c50 <commands+0xa68>
ffffffffc020170e:	00001617          	auipc	a2,0x1
ffffffffc0201712:	1ba60613          	addi	a2,a2,442 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201716:	04900593          	li	a1,73
ffffffffc020171a:	00001517          	auipc	a0,0x1
ffffffffc020171e:	1c650513          	addi	a0,a0,454 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0201722:	cb1fe0ef          	jal	ra,ffffffffc02003d2 <__panic>
    assert(n > 0);
ffffffffc0201726:	00001697          	auipc	a3,0x1
ffffffffc020172a:	4fa68693          	addi	a3,a3,1274 # ffffffffc0202c20 <commands+0xa38>
ffffffffc020172e:	00001617          	auipc	a2,0x1
ffffffffc0201732:	19a60613          	addi	a2,a2,410 # ffffffffc02028c8 <commands+0x6e0>
ffffffffc0201736:	04600593          	li	a1,70
ffffffffc020173a:	00001517          	auipc	a0,0x1
ffffffffc020173e:	1a650513          	addi	a0,a0,422 # ffffffffc02028e0 <commands+0x6f8>
ffffffffc0201742:	c91fe0ef          	jal	ra,ffffffffc02003d2 <__panic>

ffffffffc0201746 <alloc_pages>:
#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201746:	100027f3          	csrr	a5,sstatus
ffffffffc020174a:	8b89                	andi	a5,a5,2
ffffffffc020174c:	e799                	bnez	a5,ffffffffc020175a <alloc_pages+0x14>
struct Page *alloc_pages(size_t n) {
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc020174e:	00006797          	auipc	a5,0x6
ffffffffc0201752:	d2a7b783          	ld	a5,-726(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201756:	6f9c                	ld	a5,24(a5)
ffffffffc0201758:	8782                	jr	a5
struct Page *alloc_pages(size_t n) {
ffffffffc020175a:	1141                	addi	sp,sp,-16
ffffffffc020175c:	e406                	sd	ra,8(sp)
ffffffffc020175e:	e022                	sd	s0,0(sp)
ffffffffc0201760:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201762:	8d2ff0ef          	jal	ra,ffffffffc0200834 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201766:	00006797          	auipc	a5,0x6
ffffffffc020176a:	d127b783          	ld	a5,-750(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020176e:	6f9c                	ld	a5,24(a5)
ffffffffc0201770:	8522                	mv	a0,s0
ffffffffc0201772:	9782                	jalr	a5
ffffffffc0201774:	842a                	mv	s0,a0
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
ffffffffc0201776:	8b8ff0ef          	jal	ra,ffffffffc020082e <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc020177a:	60a2                	ld	ra,8(sp)
ffffffffc020177c:	8522                	mv	a0,s0
ffffffffc020177e:	6402                	ld	s0,0(sp)
ffffffffc0201780:	0141                	addi	sp,sp,16
ffffffffc0201782:	8082                	ret

ffffffffc0201784 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201784:	100027f3          	csrr	a5,sstatus
ffffffffc0201788:	8b89                	andi	a5,a5,2
ffffffffc020178a:	e799                	bnez	a5,ffffffffc0201798 <free_pages+0x14>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc020178c:	00006797          	auipc	a5,0x6
ffffffffc0201790:	cec7b783          	ld	a5,-788(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201794:	739c                	ld	a5,32(a5)
ffffffffc0201796:	8782                	jr	a5
void free_pages(struct Page *base, size_t n) {
ffffffffc0201798:	1101                	addi	sp,sp,-32
ffffffffc020179a:	ec06                	sd	ra,24(sp)
ffffffffc020179c:	e822                	sd	s0,16(sp)
ffffffffc020179e:	e426                	sd	s1,8(sp)
ffffffffc02017a0:	842a                	mv	s0,a0
ffffffffc02017a2:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc02017a4:	890ff0ef          	jal	ra,ffffffffc0200834 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02017a8:	00006797          	auipc	a5,0x6
ffffffffc02017ac:	cd07b783          	ld	a5,-816(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017b0:	739c                	ld	a5,32(a5)
ffffffffc02017b2:	85a6                	mv	a1,s1
ffffffffc02017b4:	8522                	mv	a0,s0
ffffffffc02017b6:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc02017b8:	6442                	ld	s0,16(sp)
ffffffffc02017ba:	60e2                	ld	ra,24(sp)
ffffffffc02017bc:	64a2                	ld	s1,8(sp)
ffffffffc02017be:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02017c0:	86eff06f          	j	ffffffffc020082e <intr_enable>

ffffffffc02017c4 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017c4:	100027f3          	csrr	a5,sstatus
ffffffffc02017c8:	8b89                	andi	a5,a5,2
ffffffffc02017ca:	e799                	bnez	a5,ffffffffc02017d8 <nr_free_pages+0x14>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc02017cc:	00006797          	auipc	a5,0x6
ffffffffc02017d0:	cac7b783          	ld	a5,-852(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017d4:	779c                	ld	a5,40(a5)
ffffffffc02017d6:	8782                	jr	a5
size_t nr_free_pages(void) {
ffffffffc02017d8:	1141                	addi	sp,sp,-16
ffffffffc02017da:	e406                	sd	ra,8(sp)
ffffffffc02017dc:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc02017de:	856ff0ef          	jal	ra,ffffffffc0200834 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc02017e2:	00006797          	auipc	a5,0x6
ffffffffc02017e6:	c967b783          	ld	a5,-874(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017ea:	779c                	ld	a5,40(a5)
ffffffffc02017ec:	9782                	jalr	a5
ffffffffc02017ee:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02017f0:	83eff0ef          	jal	ra,ffffffffc020082e <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc02017f4:	60a2                	ld	ra,8(sp)
ffffffffc02017f6:	8522                	mv	a0,s0
ffffffffc02017f8:	6402                	ld	s0,0(sp)
ffffffffc02017fa:	0141                	addi	sp,sp,16
ffffffffc02017fc:	8082                	ret

ffffffffc02017fe <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc02017fe:	00001797          	auipc	a5,0x1
ffffffffc0201802:	47a78793          	addi	a5,a5,1146 # ffffffffc0202c78 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201806:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0201808:	7179                	addi	sp,sp,-48
ffffffffc020180a:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020180c:	00001517          	auipc	a0,0x1
ffffffffc0201810:	4a450513          	addi	a0,a0,1188 # ffffffffc0202cb0 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc0201814:	00006417          	auipc	s0,0x6
ffffffffc0201818:	c6440413          	addi	s0,s0,-924 # ffffffffc0207478 <pmm_manager>
void pmm_init(void) {
ffffffffc020181c:	f406                	sd	ra,40(sp)
ffffffffc020181e:	ec26                	sd	s1,24(sp)
ffffffffc0201820:	e44e                	sd	s3,8(sp)
ffffffffc0201822:	e84a                	sd	s2,16(sp)
ffffffffc0201824:	e052                	sd	s4,0(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0201826:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201828:	8b1fe0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    pmm_manager->init();
ffffffffc020182c:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020182e:	00006497          	auipc	s1,0x6
ffffffffc0201832:	c6248493          	addi	s1,s1,-926 # ffffffffc0207490 <va_pa_offset>
    pmm_manager->init();
ffffffffc0201836:	679c                	ld	a5,8(a5)
ffffffffc0201838:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020183a:	57f5                	li	a5,-3
ffffffffc020183c:	07fa                	slli	a5,a5,0x1e
ffffffffc020183e:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0201840:	fdbfe0ef          	jal	ra,ffffffffc020081a <get_memory_base>
ffffffffc0201844:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0201846:	fdffe0ef          	jal	ra,ffffffffc0200824 <get_memory_size>
    if (mem_size == 0) {
ffffffffc020184a:	16050163          	beqz	a0,ffffffffc02019ac <pmm_init+0x1ae>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc020184e:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0201850:	00001517          	auipc	a0,0x1
ffffffffc0201854:	4a850513          	addi	a0,a0,1192 # ffffffffc0202cf8 <default_pmm_manager+0x80>
ffffffffc0201858:	881fe0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc020185c:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0201860:	864e                	mv	a2,s3
ffffffffc0201862:	fffa0693          	addi	a3,s4,-1
ffffffffc0201866:	85ca                	mv	a1,s2
ffffffffc0201868:	00001517          	auipc	a0,0x1
ffffffffc020186c:	4a850513          	addi	a0,a0,1192 # ffffffffc0202d10 <default_pmm_manager+0x98>
ffffffffc0201870:	869fe0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0201874:	c80007b7          	lui	a5,0xc8000
ffffffffc0201878:	8652                	mv	a2,s4
ffffffffc020187a:	0d47e863          	bltu	a5,s4,ffffffffc020194a <pmm_init+0x14c>
ffffffffc020187e:	00007797          	auipc	a5,0x7
ffffffffc0201882:	c2178793          	addi	a5,a5,-991 # ffffffffc020849f <end+0xfff>
ffffffffc0201886:	757d                	lui	a0,0xfffff
ffffffffc0201888:	8d7d                	and	a0,a0,a5
ffffffffc020188a:	8231                	srli	a2,a2,0xc
ffffffffc020188c:	00006597          	auipc	a1,0x6
ffffffffc0201890:	bdc58593          	addi	a1,a1,-1060 # ffffffffc0207468 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0201894:	00006817          	auipc	a6,0x6
ffffffffc0201898:	bdc80813          	addi	a6,a6,-1060 # ffffffffc0207470 <pages>
    npage = maxpa / PGSIZE;
ffffffffc020189c:	e190                	sd	a2,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc020189e:	00a83023          	sd	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018a2:	000807b7          	lui	a5,0x80
ffffffffc02018a6:	02f60663          	beq	a2,a5,ffffffffc02018d2 <pmm_init+0xd4>
ffffffffc02018aa:	4701                	li	a4,0
ffffffffc02018ac:	4781                	li	a5,0
ffffffffc02018ae:	4305                	li	t1,1
ffffffffc02018b0:	fff808b7          	lui	a7,0xfff80
        SetPageReserved(pages + i);
ffffffffc02018b4:	953a                	add	a0,a0,a4
ffffffffc02018b6:	00850693          	addi	a3,a0,8 # fffffffffffff008 <end+0x3fdf7b68>
ffffffffc02018ba:	4066b02f          	amoor.d	zero,t1,(a3)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018be:	6190                	ld	a2,0(a1)
ffffffffc02018c0:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc02018c2:	00083503          	ld	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018c6:	011606b3          	add	a3,a2,a7
ffffffffc02018ca:	02870713          	addi	a4,a4,40
ffffffffc02018ce:	fed7e3e3          	bltu	a5,a3,ffffffffc02018b4 <pmm_init+0xb6>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02018d2:	00261693          	slli	a3,a2,0x2
ffffffffc02018d6:	96b2                	add	a3,a3,a2
ffffffffc02018d8:	fec007b7          	lui	a5,0xfec00
ffffffffc02018dc:	97aa                	add	a5,a5,a0
ffffffffc02018de:	068e                	slli	a3,a3,0x3
ffffffffc02018e0:	96be                	add	a3,a3,a5
ffffffffc02018e2:	c02007b7          	lui	a5,0xc0200
ffffffffc02018e6:	0af6e763          	bltu	a3,a5,ffffffffc0201994 <pmm_init+0x196>
ffffffffc02018ea:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc02018ec:	77fd                	lui	a5,0xfffff
ffffffffc02018ee:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02018f2:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc02018f4:	04b6ee63          	bltu	a3,a1,ffffffffc0201950 <pmm_init+0x152>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc02018f8:	601c                	ld	a5,0(s0)
ffffffffc02018fa:	7b9c                	ld	a5,48(a5)
ffffffffc02018fc:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc02018fe:	00001517          	auipc	a0,0x1
ffffffffc0201902:	49a50513          	addi	a0,a0,1178 # ffffffffc0202d98 <default_pmm_manager+0x120>
ffffffffc0201906:	fd2fe0ef          	jal	ra,ffffffffc02000d8 <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc020190a:	00004597          	auipc	a1,0x4
ffffffffc020190e:	6f658593          	addi	a1,a1,1782 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc0201912:	00006797          	auipc	a5,0x6
ffffffffc0201916:	b6b7bb23          	sd	a1,-1162(a5) # ffffffffc0207488 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc020191a:	c02007b7          	lui	a5,0xc0200
ffffffffc020191e:	0af5e363          	bltu	a1,a5,ffffffffc02019c4 <pmm_init+0x1c6>
ffffffffc0201922:	6090                	ld	a2,0(s1)
}
ffffffffc0201924:	7402                	ld	s0,32(sp)
ffffffffc0201926:	70a2                	ld	ra,40(sp)
ffffffffc0201928:	64e2                	ld	s1,24(sp)
ffffffffc020192a:	6942                	ld	s2,16(sp)
ffffffffc020192c:	69a2                	ld	s3,8(sp)
ffffffffc020192e:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0201930:	40c58633          	sub	a2,a1,a2
ffffffffc0201934:	00006797          	auipc	a5,0x6
ffffffffc0201938:	b4c7b623          	sd	a2,-1204(a5) # ffffffffc0207480 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc020193c:	00001517          	auipc	a0,0x1
ffffffffc0201940:	47c50513          	addi	a0,a0,1148 # ffffffffc0202db8 <default_pmm_manager+0x140>
}
ffffffffc0201944:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201946:	f92fe06f          	j	ffffffffc02000d8 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc020194a:	c8000637          	lui	a2,0xc8000
ffffffffc020194e:	bf05                	j	ffffffffc020187e <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0201950:	6705                	lui	a4,0x1
ffffffffc0201952:	177d                	addi	a4,a4,-1
ffffffffc0201954:	96ba                	add	a3,a3,a4
ffffffffc0201956:	8efd                	and	a3,a3,a5
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc0201958:	00c6d793          	srli	a5,a3,0xc
ffffffffc020195c:	02c7f063          	bgeu	a5,a2,ffffffffc020197c <pmm_init+0x17e>
    pmm_manager->init_memmap(base, n);
ffffffffc0201960:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0201962:	fff80737          	lui	a4,0xfff80
ffffffffc0201966:	973e                	add	a4,a4,a5
ffffffffc0201968:	00271793          	slli	a5,a4,0x2
ffffffffc020196c:	97ba                	add	a5,a5,a4
ffffffffc020196e:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0201970:	8d95                	sub	a1,a1,a3
ffffffffc0201972:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0201974:	81b1                	srli	a1,a1,0xc
ffffffffc0201976:	953e                	add	a0,a0,a5
ffffffffc0201978:	9702                	jalr	a4
}
ffffffffc020197a:	bfbd                	j	ffffffffc02018f8 <pmm_init+0xfa>
        panic("pa2page called with invalid pa");
ffffffffc020197c:	00001617          	auipc	a2,0x1
ffffffffc0201980:	3ec60613          	addi	a2,a2,1004 # ffffffffc0202d68 <default_pmm_manager+0xf0>
ffffffffc0201984:	06b00593          	li	a1,107
ffffffffc0201988:	00001517          	auipc	a0,0x1
ffffffffc020198c:	40050513          	addi	a0,a0,1024 # ffffffffc0202d88 <default_pmm_manager+0x110>
ffffffffc0201990:	a43fe0ef          	jal	ra,ffffffffc02003d2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201994:	00001617          	auipc	a2,0x1
ffffffffc0201998:	3ac60613          	addi	a2,a2,940 # ffffffffc0202d40 <default_pmm_manager+0xc8>
ffffffffc020199c:	07100593          	li	a1,113
ffffffffc02019a0:	00001517          	auipc	a0,0x1
ffffffffc02019a4:	34850513          	addi	a0,a0,840 # ffffffffc0202ce8 <default_pmm_manager+0x70>
ffffffffc02019a8:	a2bfe0ef          	jal	ra,ffffffffc02003d2 <__panic>
        panic("DTB memory info not available");
ffffffffc02019ac:	00001617          	auipc	a2,0x1
ffffffffc02019b0:	31c60613          	addi	a2,a2,796 # ffffffffc0202cc8 <default_pmm_manager+0x50>
ffffffffc02019b4:	05a00593          	li	a1,90
ffffffffc02019b8:	00001517          	auipc	a0,0x1
ffffffffc02019bc:	33050513          	addi	a0,a0,816 # ffffffffc0202ce8 <default_pmm_manager+0x70>
ffffffffc02019c0:	a13fe0ef          	jal	ra,ffffffffc02003d2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc02019c4:	86ae                	mv	a3,a1
ffffffffc02019c6:	00001617          	auipc	a2,0x1
ffffffffc02019ca:	37a60613          	addi	a2,a2,890 # ffffffffc0202d40 <default_pmm_manager+0xc8>
ffffffffc02019ce:	08c00593          	li	a1,140
ffffffffc02019d2:	00001517          	auipc	a0,0x1
ffffffffc02019d6:	31650513          	addi	a0,a0,790 # ffffffffc0202ce8 <default_pmm_manager+0x70>
ffffffffc02019da:	9f9fe0ef          	jal	ra,ffffffffc02003d2 <__panic>

ffffffffc02019de <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02019de:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02019e2:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02019e4:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02019e8:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02019ea:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02019ee:	f022                	sd	s0,32(sp)
ffffffffc02019f0:	ec26                	sd	s1,24(sp)
ffffffffc02019f2:	e84a                	sd	s2,16(sp)
ffffffffc02019f4:	f406                	sd	ra,40(sp)
ffffffffc02019f6:	e44e                	sd	s3,8(sp)
ffffffffc02019f8:	84aa                	mv	s1,a0
ffffffffc02019fa:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02019fc:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201a00:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0201a02:	03067e63          	bgeu	a2,a6,ffffffffc0201a3e <printnum+0x60>
ffffffffc0201a06:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201a08:	00805763          	blez	s0,ffffffffc0201a16 <printnum+0x38>
ffffffffc0201a0c:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201a0e:	85ca                	mv	a1,s2
ffffffffc0201a10:	854e                	mv	a0,s3
ffffffffc0201a12:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0201a14:	fc65                	bnez	s0,ffffffffc0201a0c <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a16:	1a02                	slli	s4,s4,0x20
ffffffffc0201a18:	00001797          	auipc	a5,0x1
ffffffffc0201a1c:	3e078793          	addi	a5,a5,992 # ffffffffc0202df8 <default_pmm_manager+0x180>
ffffffffc0201a20:	020a5a13          	srli	s4,s4,0x20
ffffffffc0201a24:	9a3e                	add	s4,s4,a5
}
ffffffffc0201a26:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a28:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201a2c:	70a2                	ld	ra,40(sp)
ffffffffc0201a2e:	69a2                	ld	s3,8(sp)
ffffffffc0201a30:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a32:	85ca                	mv	a1,s2
ffffffffc0201a34:	87a6                	mv	a5,s1
}
ffffffffc0201a36:	6942                	ld	s2,16(sp)
ffffffffc0201a38:	64e2                	ld	s1,24(sp)
ffffffffc0201a3a:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a3c:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201a3e:	03065633          	divu	a2,a2,a6
ffffffffc0201a42:	8722                	mv	a4,s0
ffffffffc0201a44:	f9bff0ef          	jal	ra,ffffffffc02019de <printnum>
ffffffffc0201a48:	b7f9                	j	ffffffffc0201a16 <printnum+0x38>

ffffffffc0201a4a <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201a4a:	7119                	addi	sp,sp,-128
ffffffffc0201a4c:	f4a6                	sd	s1,104(sp)
ffffffffc0201a4e:	f0ca                	sd	s2,96(sp)
ffffffffc0201a50:	ecce                	sd	s3,88(sp)
ffffffffc0201a52:	e8d2                	sd	s4,80(sp)
ffffffffc0201a54:	e4d6                	sd	s5,72(sp)
ffffffffc0201a56:	e0da                	sd	s6,64(sp)
ffffffffc0201a58:	fc5e                	sd	s7,56(sp)
ffffffffc0201a5a:	f06a                	sd	s10,32(sp)
ffffffffc0201a5c:	fc86                	sd	ra,120(sp)
ffffffffc0201a5e:	f8a2                	sd	s0,112(sp)
ffffffffc0201a60:	f862                	sd	s8,48(sp)
ffffffffc0201a62:	f466                	sd	s9,40(sp)
ffffffffc0201a64:	ec6e                	sd	s11,24(sp)
ffffffffc0201a66:	892a                	mv	s2,a0
ffffffffc0201a68:	84ae                	mv	s1,a1
ffffffffc0201a6a:	8d32                	mv	s10,a2
ffffffffc0201a6c:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201a6e:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201a72:	5b7d                	li	s6,-1
ffffffffc0201a74:	00001a97          	auipc	s5,0x1
ffffffffc0201a78:	3b8a8a93          	addi	s5,s5,952 # ffffffffc0202e2c <default_pmm_manager+0x1b4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201a7c:	00001b97          	auipc	s7,0x1
ffffffffc0201a80:	58cb8b93          	addi	s7,s7,1420 # ffffffffc0203008 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201a84:	000d4503          	lbu	a0,0(s10)
ffffffffc0201a88:	001d0413          	addi	s0,s10,1
ffffffffc0201a8c:	01350a63          	beq	a0,s3,ffffffffc0201aa0 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201a90:	c121                	beqz	a0,ffffffffc0201ad0 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201a92:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201a94:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201a96:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201a98:	fff44503          	lbu	a0,-1(s0)
ffffffffc0201a9c:	ff351ae3          	bne	a0,s3,ffffffffc0201a90 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201aa0:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201aa4:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201aa8:	4c81                	li	s9,0
ffffffffc0201aaa:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0201aac:	5c7d                	li	s8,-1
ffffffffc0201aae:	5dfd                	li	s11,-1
ffffffffc0201ab0:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201ab4:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ab6:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201aba:	0ff5f593          	zext.b	a1,a1
ffffffffc0201abe:	00140d13          	addi	s10,s0,1
ffffffffc0201ac2:	04b56263          	bltu	a0,a1,ffffffffc0201b06 <vprintfmt+0xbc>
ffffffffc0201ac6:	058a                	slli	a1,a1,0x2
ffffffffc0201ac8:	95d6                	add	a1,a1,s5
ffffffffc0201aca:	4194                	lw	a3,0(a1)
ffffffffc0201acc:	96d6                	add	a3,a3,s5
ffffffffc0201ace:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201ad0:	70e6                	ld	ra,120(sp)
ffffffffc0201ad2:	7446                	ld	s0,112(sp)
ffffffffc0201ad4:	74a6                	ld	s1,104(sp)
ffffffffc0201ad6:	7906                	ld	s2,96(sp)
ffffffffc0201ad8:	69e6                	ld	s3,88(sp)
ffffffffc0201ada:	6a46                	ld	s4,80(sp)
ffffffffc0201adc:	6aa6                	ld	s5,72(sp)
ffffffffc0201ade:	6b06                	ld	s6,64(sp)
ffffffffc0201ae0:	7be2                	ld	s7,56(sp)
ffffffffc0201ae2:	7c42                	ld	s8,48(sp)
ffffffffc0201ae4:	7ca2                	ld	s9,40(sp)
ffffffffc0201ae6:	7d02                	ld	s10,32(sp)
ffffffffc0201ae8:	6de2                	ld	s11,24(sp)
ffffffffc0201aea:	6109                	addi	sp,sp,128
ffffffffc0201aec:	8082                	ret
            padc = '0';
ffffffffc0201aee:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201af0:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201af4:	846a                	mv	s0,s10
ffffffffc0201af6:	00140d13          	addi	s10,s0,1
ffffffffc0201afa:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201afe:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b02:	fcb572e3          	bgeu	a0,a1,ffffffffc0201ac6 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0201b06:	85a6                	mv	a1,s1
ffffffffc0201b08:	02500513          	li	a0,37
ffffffffc0201b0c:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201b0e:	fff44783          	lbu	a5,-1(s0)
ffffffffc0201b12:	8d22                	mv	s10,s0
ffffffffc0201b14:	f73788e3          	beq	a5,s3,ffffffffc0201a84 <vprintfmt+0x3a>
ffffffffc0201b18:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201b1c:	1d7d                	addi	s10,s10,-1
ffffffffc0201b1e:	ff379de3          	bne	a5,s3,ffffffffc0201b18 <vprintfmt+0xce>
ffffffffc0201b22:	b78d                	j	ffffffffc0201a84 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0201b24:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201b28:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b2c:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201b2e:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0201b32:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201b36:	02d86463          	bltu	a6,a3,ffffffffc0201b5e <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201b3a:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201b3e:	002c169b          	slliw	a3,s8,0x2
ffffffffc0201b42:	0186873b          	addw	a4,a3,s8
ffffffffc0201b46:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201b4a:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201b4c:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201b50:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201b52:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201b56:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201b5a:	fed870e3          	bgeu	a6,a3,ffffffffc0201b3a <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201b5e:	f40ddce3          	bgez	s11,ffffffffc0201ab6 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201b62:	8de2                	mv	s11,s8
ffffffffc0201b64:	5c7d                	li	s8,-1
ffffffffc0201b66:	bf81                	j	ffffffffc0201ab6 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201b68:	fffdc693          	not	a3,s11
ffffffffc0201b6c:	96fd                	srai	a3,a3,0x3f
ffffffffc0201b6e:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b72:	00144603          	lbu	a2,1(s0)
ffffffffc0201b76:	2d81                	sext.w	s11,s11
ffffffffc0201b78:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201b7a:	bf35                	j	ffffffffc0201ab6 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201b7c:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b80:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201b84:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b86:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201b88:	bfd9                	j	ffffffffc0201b5e <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201b8a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201b8c:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201b90:	01174463          	blt	a4,a7,ffffffffc0201b98 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201b94:	1a088e63          	beqz	a7,ffffffffc0201d50 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201b98:	000a3603          	ld	a2,0(s4)
ffffffffc0201b9c:	46c1                	li	a3,16
ffffffffc0201b9e:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201ba0:	2781                	sext.w	a5,a5
ffffffffc0201ba2:	876e                	mv	a4,s11
ffffffffc0201ba4:	85a6                	mv	a1,s1
ffffffffc0201ba6:	854a                	mv	a0,s2
ffffffffc0201ba8:	e37ff0ef          	jal	ra,ffffffffc02019de <printnum>
            break;
ffffffffc0201bac:	bde1                	j	ffffffffc0201a84 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0201bae:	000a2503          	lw	a0,0(s4)
ffffffffc0201bb2:	85a6                	mv	a1,s1
ffffffffc0201bb4:	0a21                	addi	s4,s4,8
ffffffffc0201bb6:	9902                	jalr	s2
            break;
ffffffffc0201bb8:	b5f1                	j	ffffffffc0201a84 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201bba:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201bbc:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201bc0:	01174463          	blt	a4,a7,ffffffffc0201bc8 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201bc4:	18088163          	beqz	a7,ffffffffc0201d46 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201bc8:	000a3603          	ld	a2,0(s4)
ffffffffc0201bcc:	46a9                	li	a3,10
ffffffffc0201bce:	8a2e                	mv	s4,a1
ffffffffc0201bd0:	bfc1                	j	ffffffffc0201ba0 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bd2:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201bd6:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bd8:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201bda:	bdf1                	j	ffffffffc0201ab6 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0201bdc:	85a6                	mv	a1,s1
ffffffffc0201bde:	02500513          	li	a0,37
ffffffffc0201be2:	9902                	jalr	s2
            break;
ffffffffc0201be4:	b545                	j	ffffffffc0201a84 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201be6:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201bea:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bec:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201bee:	b5e1                	j	ffffffffc0201ab6 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201bf0:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201bf2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201bf6:	01174463          	blt	a4,a7,ffffffffc0201bfe <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201bfa:	14088163          	beqz	a7,ffffffffc0201d3c <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201bfe:	000a3603          	ld	a2,0(s4)
ffffffffc0201c02:	46a1                	li	a3,8
ffffffffc0201c04:	8a2e                	mv	s4,a1
ffffffffc0201c06:	bf69                	j	ffffffffc0201ba0 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201c08:	03000513          	li	a0,48
ffffffffc0201c0c:	85a6                	mv	a1,s1
ffffffffc0201c0e:	e03e                	sd	a5,0(sp)
ffffffffc0201c10:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0201c12:	85a6                	mv	a1,s1
ffffffffc0201c14:	07800513          	li	a0,120
ffffffffc0201c18:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c1a:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201c1c:	6782                	ld	a5,0(sp)
ffffffffc0201c1e:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c20:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0201c24:	bfb5                	j	ffffffffc0201ba0 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201c26:	000a3403          	ld	s0,0(s4)
ffffffffc0201c2a:	008a0713          	addi	a4,s4,8
ffffffffc0201c2e:	e03a                	sd	a4,0(sp)
ffffffffc0201c30:	14040263          	beqz	s0,ffffffffc0201d74 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0201c34:	0fb05763          	blez	s11,ffffffffc0201d22 <vprintfmt+0x2d8>
ffffffffc0201c38:	02d00693          	li	a3,45
ffffffffc0201c3c:	0cd79163          	bne	a5,a3,ffffffffc0201cfe <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c40:	00044783          	lbu	a5,0(s0)
ffffffffc0201c44:	0007851b          	sext.w	a0,a5
ffffffffc0201c48:	cf85                	beqz	a5,ffffffffc0201c80 <vprintfmt+0x236>
ffffffffc0201c4a:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201c4e:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c52:	000c4563          	bltz	s8,ffffffffc0201c5c <vprintfmt+0x212>
ffffffffc0201c56:	3c7d                	addiw	s8,s8,-1
ffffffffc0201c58:	036c0263          	beq	s8,s6,ffffffffc0201c7c <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201c5c:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201c5e:	0e0c8e63          	beqz	s9,ffffffffc0201d5a <vprintfmt+0x310>
ffffffffc0201c62:	3781                	addiw	a5,a5,-32
ffffffffc0201c64:	0ef47b63          	bgeu	s0,a5,ffffffffc0201d5a <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201c68:	03f00513          	li	a0,63
ffffffffc0201c6c:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c6e:	000a4783          	lbu	a5,0(s4)
ffffffffc0201c72:	3dfd                	addiw	s11,s11,-1
ffffffffc0201c74:	0a05                	addi	s4,s4,1
ffffffffc0201c76:	0007851b          	sext.w	a0,a5
ffffffffc0201c7a:	ffe1                	bnez	a5,ffffffffc0201c52 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201c7c:	01b05963          	blez	s11,ffffffffc0201c8e <vprintfmt+0x244>
ffffffffc0201c80:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201c82:	85a6                	mv	a1,s1
ffffffffc0201c84:	02000513          	li	a0,32
ffffffffc0201c88:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201c8a:	fe0d9be3          	bnez	s11,ffffffffc0201c80 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201c8e:	6a02                	ld	s4,0(sp)
ffffffffc0201c90:	bbd5                	j	ffffffffc0201a84 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201c92:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c94:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201c98:	01174463          	blt	a4,a7,ffffffffc0201ca0 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201c9c:	08088d63          	beqz	a7,ffffffffc0201d36 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201ca0:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201ca4:	0a044d63          	bltz	s0,ffffffffc0201d5e <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201ca8:	8622                	mv	a2,s0
ffffffffc0201caa:	8a66                	mv	s4,s9
ffffffffc0201cac:	46a9                	li	a3,10
ffffffffc0201cae:	bdcd                	j	ffffffffc0201ba0 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201cb0:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201cb4:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201cb6:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201cb8:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201cbc:	8fb5                	xor	a5,a5,a3
ffffffffc0201cbe:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201cc2:	02d74163          	blt	a4,a3,ffffffffc0201ce4 <vprintfmt+0x29a>
ffffffffc0201cc6:	00369793          	slli	a5,a3,0x3
ffffffffc0201cca:	97de                	add	a5,a5,s7
ffffffffc0201ccc:	639c                	ld	a5,0(a5)
ffffffffc0201cce:	cb99                	beqz	a5,ffffffffc0201ce4 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201cd0:	86be                	mv	a3,a5
ffffffffc0201cd2:	00001617          	auipc	a2,0x1
ffffffffc0201cd6:	15660613          	addi	a2,a2,342 # ffffffffc0202e28 <default_pmm_manager+0x1b0>
ffffffffc0201cda:	85a6                	mv	a1,s1
ffffffffc0201cdc:	854a                	mv	a0,s2
ffffffffc0201cde:	0ce000ef          	jal	ra,ffffffffc0201dac <printfmt>
ffffffffc0201ce2:	b34d                	j	ffffffffc0201a84 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201ce4:	00001617          	auipc	a2,0x1
ffffffffc0201ce8:	13460613          	addi	a2,a2,308 # ffffffffc0202e18 <default_pmm_manager+0x1a0>
ffffffffc0201cec:	85a6                	mv	a1,s1
ffffffffc0201cee:	854a                	mv	a0,s2
ffffffffc0201cf0:	0bc000ef          	jal	ra,ffffffffc0201dac <printfmt>
ffffffffc0201cf4:	bb41                	j	ffffffffc0201a84 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201cf6:	00001417          	auipc	s0,0x1
ffffffffc0201cfa:	11a40413          	addi	s0,s0,282 # ffffffffc0202e10 <default_pmm_manager+0x198>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201cfe:	85e2                	mv	a1,s8
ffffffffc0201d00:	8522                	mv	a0,s0
ffffffffc0201d02:	e43e                	sd	a5,8(sp)
ffffffffc0201d04:	200000ef          	jal	ra,ffffffffc0201f04 <strnlen>
ffffffffc0201d08:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201d0c:	01b05b63          	blez	s11,ffffffffc0201d22 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201d10:	67a2                	ld	a5,8(sp)
ffffffffc0201d12:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d16:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201d18:	85a6                	mv	a1,s1
ffffffffc0201d1a:	8552                	mv	a0,s4
ffffffffc0201d1c:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d1e:	fe0d9ce3          	bnez	s11,ffffffffc0201d16 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201d22:	00044783          	lbu	a5,0(s0)
ffffffffc0201d26:	00140a13          	addi	s4,s0,1
ffffffffc0201d2a:	0007851b          	sext.w	a0,a5
ffffffffc0201d2e:	d3a5                	beqz	a5,ffffffffc0201c8e <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201d30:	05e00413          	li	s0,94
ffffffffc0201d34:	bf39                	j	ffffffffc0201c52 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0201d36:	000a2403          	lw	s0,0(s4)
ffffffffc0201d3a:	b7ad                	j	ffffffffc0201ca4 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201d3c:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d40:	46a1                	li	a3,8
ffffffffc0201d42:	8a2e                	mv	s4,a1
ffffffffc0201d44:	bdb1                	j	ffffffffc0201ba0 <vprintfmt+0x156>
ffffffffc0201d46:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d4a:	46a9                	li	a3,10
ffffffffc0201d4c:	8a2e                	mv	s4,a1
ffffffffc0201d4e:	bd89                	j	ffffffffc0201ba0 <vprintfmt+0x156>
ffffffffc0201d50:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d54:	46c1                	li	a3,16
ffffffffc0201d56:	8a2e                	mv	s4,a1
ffffffffc0201d58:	b5a1                	j	ffffffffc0201ba0 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201d5a:	9902                	jalr	s2
ffffffffc0201d5c:	bf09                	j	ffffffffc0201c6e <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201d5e:	85a6                	mv	a1,s1
ffffffffc0201d60:	02d00513          	li	a0,45
ffffffffc0201d64:	e03e                	sd	a5,0(sp)
ffffffffc0201d66:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201d68:	6782                	ld	a5,0(sp)
ffffffffc0201d6a:	8a66                	mv	s4,s9
ffffffffc0201d6c:	40800633          	neg	a2,s0
ffffffffc0201d70:	46a9                	li	a3,10
ffffffffc0201d72:	b53d                	j	ffffffffc0201ba0 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201d74:	03b05163          	blez	s11,ffffffffc0201d96 <vprintfmt+0x34c>
ffffffffc0201d78:	02d00693          	li	a3,45
ffffffffc0201d7c:	f6d79de3          	bne	a5,a3,ffffffffc0201cf6 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201d80:	00001417          	auipc	s0,0x1
ffffffffc0201d84:	09040413          	addi	s0,s0,144 # ffffffffc0202e10 <default_pmm_manager+0x198>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201d88:	02800793          	li	a5,40
ffffffffc0201d8c:	02800513          	li	a0,40
ffffffffc0201d90:	00140a13          	addi	s4,s0,1
ffffffffc0201d94:	bd6d                	j	ffffffffc0201c4e <vprintfmt+0x204>
ffffffffc0201d96:	00001a17          	auipc	s4,0x1
ffffffffc0201d9a:	07ba0a13          	addi	s4,s4,123 # ffffffffc0202e11 <default_pmm_manager+0x199>
ffffffffc0201d9e:	02800513          	li	a0,40
ffffffffc0201da2:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201da6:	05e00413          	li	s0,94
ffffffffc0201daa:	b565                	j	ffffffffc0201c52 <vprintfmt+0x208>

ffffffffc0201dac <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201dac:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201dae:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201db2:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201db4:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201db6:	ec06                	sd	ra,24(sp)
ffffffffc0201db8:	f83a                	sd	a4,48(sp)
ffffffffc0201dba:	fc3e                	sd	a5,56(sp)
ffffffffc0201dbc:	e0c2                	sd	a6,64(sp)
ffffffffc0201dbe:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201dc0:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201dc2:	c89ff0ef          	jal	ra,ffffffffc0201a4a <vprintfmt>
}
ffffffffc0201dc6:	60e2                	ld	ra,24(sp)
ffffffffc0201dc8:	6161                	addi	sp,sp,80
ffffffffc0201dca:	8082                	ret

ffffffffc0201dcc <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0201dcc:	715d                	addi	sp,sp,-80
ffffffffc0201dce:	e486                	sd	ra,72(sp)
ffffffffc0201dd0:	e0a6                	sd	s1,64(sp)
ffffffffc0201dd2:	fc4a                	sd	s2,56(sp)
ffffffffc0201dd4:	f84e                	sd	s3,48(sp)
ffffffffc0201dd6:	f452                	sd	s4,40(sp)
ffffffffc0201dd8:	f056                	sd	s5,32(sp)
ffffffffc0201dda:	ec5a                	sd	s6,24(sp)
ffffffffc0201ddc:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0201dde:	c901                	beqz	a0,ffffffffc0201dee <readline+0x22>
ffffffffc0201de0:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0201de2:	00001517          	auipc	a0,0x1
ffffffffc0201de6:	04650513          	addi	a0,a0,70 # ffffffffc0202e28 <default_pmm_manager+0x1b0>
ffffffffc0201dea:	aeefe0ef          	jal	ra,ffffffffc02000d8 <cprintf>
readline(const char *prompt) {
ffffffffc0201dee:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201df0:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0201df2:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0201df4:	4aa9                	li	s5,10
ffffffffc0201df6:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0201df8:	00005b97          	auipc	s7,0x5
ffffffffc0201dfc:	248b8b93          	addi	s7,s7,584 # ffffffffc0207040 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e00:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0201e04:	b4cfe0ef          	jal	ra,ffffffffc0200150 <getchar>
        if (c < 0) {
ffffffffc0201e08:	00054a63          	bltz	a0,ffffffffc0201e1c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e0c:	00a95a63          	bge	s2,a0,ffffffffc0201e20 <readline+0x54>
ffffffffc0201e10:	029a5263          	bge	s4,s1,ffffffffc0201e34 <readline+0x68>
        c = getchar();
ffffffffc0201e14:	b3cfe0ef          	jal	ra,ffffffffc0200150 <getchar>
        if (c < 0) {
ffffffffc0201e18:	fe055ae3          	bgez	a0,ffffffffc0201e0c <readline+0x40>
            return NULL;
ffffffffc0201e1c:	4501                	li	a0,0
ffffffffc0201e1e:	a091                	j	ffffffffc0201e62 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc0201e20:	03351463          	bne	a0,s3,ffffffffc0201e48 <readline+0x7c>
ffffffffc0201e24:	e8a9                	bnez	s1,ffffffffc0201e76 <readline+0xaa>
        c = getchar();
ffffffffc0201e26:	b2afe0ef          	jal	ra,ffffffffc0200150 <getchar>
        if (c < 0) {
ffffffffc0201e2a:	fe0549e3          	bltz	a0,ffffffffc0201e1c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e2e:	fea959e3          	bge	s2,a0,ffffffffc0201e20 <readline+0x54>
ffffffffc0201e32:	4481                	li	s1,0
            cputchar(c);
ffffffffc0201e34:	e42a                	sd	a0,8(sp)
ffffffffc0201e36:	ad8fe0ef          	jal	ra,ffffffffc020010e <cputchar>
            buf[i ++] = c;
ffffffffc0201e3a:	6522                	ld	a0,8(sp)
ffffffffc0201e3c:	009b87b3          	add	a5,s7,s1
ffffffffc0201e40:	2485                	addiw	s1,s1,1
ffffffffc0201e42:	00a78023          	sb	a0,0(a5)
ffffffffc0201e46:	bf7d                	j	ffffffffc0201e04 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0201e48:	01550463          	beq	a0,s5,ffffffffc0201e50 <readline+0x84>
ffffffffc0201e4c:	fb651ce3          	bne	a0,s6,ffffffffc0201e04 <readline+0x38>
            cputchar(c);
ffffffffc0201e50:	abefe0ef          	jal	ra,ffffffffc020010e <cputchar>
            buf[i] = '\0';
ffffffffc0201e54:	00005517          	auipc	a0,0x5
ffffffffc0201e58:	1ec50513          	addi	a0,a0,492 # ffffffffc0207040 <buf>
ffffffffc0201e5c:	94aa                	add	s1,s1,a0
ffffffffc0201e5e:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0201e62:	60a6                	ld	ra,72(sp)
ffffffffc0201e64:	6486                	ld	s1,64(sp)
ffffffffc0201e66:	7962                	ld	s2,56(sp)
ffffffffc0201e68:	79c2                	ld	s3,48(sp)
ffffffffc0201e6a:	7a22                	ld	s4,40(sp)
ffffffffc0201e6c:	7a82                	ld	s5,32(sp)
ffffffffc0201e6e:	6b62                	ld	s6,24(sp)
ffffffffc0201e70:	6bc2                	ld	s7,16(sp)
ffffffffc0201e72:	6161                	addi	sp,sp,80
ffffffffc0201e74:	8082                	ret
            cputchar(c);
ffffffffc0201e76:	4521                	li	a0,8
ffffffffc0201e78:	a96fe0ef          	jal	ra,ffffffffc020010e <cputchar>
            i --;
ffffffffc0201e7c:	34fd                	addiw	s1,s1,-1
ffffffffc0201e7e:	b759                	j	ffffffffc0201e04 <readline+0x38>

ffffffffc0201e80 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201e80:	4781                	li	a5,0
ffffffffc0201e82:	00005717          	auipc	a4,0x5
ffffffffc0201e86:	19673703          	ld	a4,406(a4) # ffffffffc0207018 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201e8a:	88ba                	mv	a7,a4
ffffffffc0201e8c:	852a                	mv	a0,a0
ffffffffc0201e8e:	85be                	mv	a1,a5
ffffffffc0201e90:	863e                	mv	a2,a5
ffffffffc0201e92:	00000073          	ecall
ffffffffc0201e96:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201e98:	8082                	ret

ffffffffc0201e9a <sbi_set_timer>:
    __asm__ volatile (
ffffffffc0201e9a:	4781                	li	a5,0
ffffffffc0201e9c:	00005717          	auipc	a4,0x5
ffffffffc0201ea0:	5fc73703          	ld	a4,1532(a4) # ffffffffc0207498 <SBI_SET_TIMER>
ffffffffc0201ea4:	88ba                	mv	a7,a4
ffffffffc0201ea6:	852a                	mv	a0,a0
ffffffffc0201ea8:	85be                	mv	a1,a5
ffffffffc0201eaa:	863e                	mv	a2,a5
ffffffffc0201eac:	00000073          	ecall
ffffffffc0201eb0:	87aa                	mv	a5,a0

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}
ffffffffc0201eb2:	8082                	ret

ffffffffc0201eb4 <sbi_console_getchar>:
    __asm__ volatile (
ffffffffc0201eb4:	4501                	li	a0,0
ffffffffc0201eb6:	00005797          	auipc	a5,0x5
ffffffffc0201eba:	15a7b783          	ld	a5,346(a5) # ffffffffc0207010 <SBI_CONSOLE_GETCHAR>
ffffffffc0201ebe:	88be                	mv	a7,a5
ffffffffc0201ec0:	852a                	mv	a0,a0
ffffffffc0201ec2:	85aa                	mv	a1,a0
ffffffffc0201ec4:	862a                	mv	a2,a0
ffffffffc0201ec6:	00000073          	ecall
ffffffffc0201eca:	852a                	mv	a0,a0

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
ffffffffc0201ecc:	2501                	sext.w	a0,a0
ffffffffc0201ece:	8082                	ret

ffffffffc0201ed0 <sbi_shutdown>:
    __asm__ volatile (
ffffffffc0201ed0:	4781                	li	a5,0
ffffffffc0201ed2:	00005717          	auipc	a4,0x5
ffffffffc0201ed6:	14e73703          	ld	a4,334(a4) # ffffffffc0207020 <SBI_SHUTDOWN>
ffffffffc0201eda:	88ba                	mv	a7,a4
ffffffffc0201edc:	853e                	mv	a0,a5
ffffffffc0201ede:	85be                	mv	a1,a5
ffffffffc0201ee0:	863e                	mv	a2,a5
ffffffffc0201ee2:	00000073          	ecall
ffffffffc0201ee6:	87aa                	mv	a5,a0

void sbi_shutdown(void)
{
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
ffffffffc0201ee8:	8082                	ret

ffffffffc0201eea <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201eea:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201eee:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201ef0:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201ef2:	cb81                	beqz	a5,ffffffffc0201f02 <strlen+0x18>
        cnt ++;
ffffffffc0201ef4:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201ef6:	00a707b3          	add	a5,a4,a0
ffffffffc0201efa:	0007c783          	lbu	a5,0(a5)
ffffffffc0201efe:	fbfd                	bnez	a5,ffffffffc0201ef4 <strlen+0xa>
ffffffffc0201f00:	8082                	ret
    }
    return cnt;
}
ffffffffc0201f02:	8082                	ret

ffffffffc0201f04 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201f04:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f06:	e589                	bnez	a1,ffffffffc0201f10 <strnlen+0xc>
ffffffffc0201f08:	a811                	j	ffffffffc0201f1c <strnlen+0x18>
        cnt ++;
ffffffffc0201f0a:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f0c:	00f58863          	beq	a1,a5,ffffffffc0201f1c <strnlen+0x18>
ffffffffc0201f10:	00f50733          	add	a4,a0,a5
ffffffffc0201f14:	00074703          	lbu	a4,0(a4)
ffffffffc0201f18:	fb6d                	bnez	a4,ffffffffc0201f0a <strnlen+0x6>
ffffffffc0201f1a:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201f1c:	852e                	mv	a0,a1
ffffffffc0201f1e:	8082                	ret

ffffffffc0201f20 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f20:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f24:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f28:	cb89                	beqz	a5,ffffffffc0201f3a <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0201f2a:	0505                	addi	a0,a0,1
ffffffffc0201f2c:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f2e:	fee789e3          	beq	a5,a4,ffffffffc0201f20 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f32:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0201f36:	9d19                	subw	a0,a0,a4
ffffffffc0201f38:	8082                	ret
ffffffffc0201f3a:	4501                	li	a0,0
ffffffffc0201f3c:	bfed                	j	ffffffffc0201f36 <strcmp+0x16>

ffffffffc0201f3e <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f3e:	c20d                	beqz	a2,ffffffffc0201f60 <strncmp+0x22>
ffffffffc0201f40:	962e                	add	a2,a2,a1
ffffffffc0201f42:	a031                	j	ffffffffc0201f4e <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201f44:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f46:	00e79a63          	bne	a5,a4,ffffffffc0201f5a <strncmp+0x1c>
ffffffffc0201f4a:	00b60b63          	beq	a2,a1,ffffffffc0201f60 <strncmp+0x22>
ffffffffc0201f4e:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201f52:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f54:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201f58:	f7f5                	bnez	a5,ffffffffc0201f44 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f5a:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201f5e:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f60:	4501                	li	a0,0
ffffffffc0201f62:	8082                	ret

ffffffffc0201f64 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0201f64:	00054783          	lbu	a5,0(a0)
ffffffffc0201f68:	c799                	beqz	a5,ffffffffc0201f76 <strchr+0x12>
        if (*s == c) {
ffffffffc0201f6a:	00f58763          	beq	a1,a5,ffffffffc0201f78 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0201f6e:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0201f72:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0201f74:	fbfd                	bnez	a5,ffffffffc0201f6a <strchr+0x6>
    }
    return NULL;
ffffffffc0201f76:	4501                	li	a0,0
}
ffffffffc0201f78:	8082                	ret

ffffffffc0201f7a <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201f7a:	ca01                	beqz	a2,ffffffffc0201f8a <memset+0x10>
ffffffffc0201f7c:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201f7e:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201f80:	0785                	addi	a5,a5,1
ffffffffc0201f82:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201f86:	fec79de3          	bne	a5,a2,ffffffffc0201f80 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201f8a:	8082                	ret
