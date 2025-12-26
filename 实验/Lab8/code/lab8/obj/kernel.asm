
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	6140b0ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	67658593          	addi	a1,a1,1654 # ffffffffc020b6e0 <etext>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	68e50513          	addi	a0,a0,1678 # ffffffffc020b700 <etext+0x20>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	409020ef          	jal	ra,ffffffffc0202c8e <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	635030ef          	jal	ra,ffffffffc0203ec6 <vmm_init>
ffffffffc0200096:	388070ef          	jal	ra,ffffffffc020741e <sched_init>
ffffffffc020009a:	78f060ef          	jal	ra,ffffffffc0207028 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	066050ef          	jal	ra,ffffffffc0205108 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	146070ef          	jal	ra,ffffffffc02071f4 <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	64050513          	addi	a0,a0,1600 # ffffffffc020b708 <etext+0x28>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	04e0b0ef          	jal	ra,ffffffffc020b1e8 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	0120b0ef          	jal	ra,ffffffffc020b1e8 <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	3d40b0ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	4b20b0ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	4e250513          	addi	a0,a0,1250 # ffffffffc020b710 <etext+0x30>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	4ec50513          	addi	a0,a0,1260 # ffffffffc020b730 <etext+0x50>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	49058593          	addi	a1,a1,1168 # ffffffffc020b6e0 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	4f850513          	addi	a0,a0,1272 # ffffffffc020b750 <etext+0x70>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	50450513          	addi	a0,a0,1284 # ffffffffc020b770 <etext+0x90>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	51050513          	addi	a0,a0,1296 # ffffffffc020b790 <etext+0xb0>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	50250513          	addi	a0,a0,1282 # ffffffffc020b7b0 <etext+0xd0>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	52460613          	addi	a2,a2,1316 # ffffffffc020b7e0 <etext+0x100>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	53050513          	addi	a0,a0,1328 # ffffffffc020b7f8 <etext+0x118>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	53860613          	addi	a2,a2,1336 # ffffffffc020b810 <etext+0x130>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	55058593          	addi	a1,a1,1360 # ffffffffc020b830 <etext+0x150>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	55050513          	addi	a0,a0,1360 # ffffffffc020b838 <etext+0x158>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	55260613          	addi	a2,a2,1362 # ffffffffc020b848 <etext+0x168>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	57258593          	addi	a1,a1,1394 # ffffffffc020b870 <etext+0x190>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	53250513          	addi	a0,a0,1330 # ffffffffc020b838 <etext+0x158>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	56e60613          	addi	a2,a2,1390 # ffffffffc020b880 <etext+0x1a0>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	58658593          	addi	a1,a1,1414 # ffffffffc020b8a0 <etext+0x1c0>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	51650513          	addi	a0,a0,1302 # ffffffffc020b838 <etext+0x158>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	55450513          	addi	a0,a0,1364 # ffffffffc020b8b0 <etext+0x1d0>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	55a50513          	addi	a0,a0,1370 # ffffffffc020b8d8 <etext+0x1f8>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	5b4c0c13          	addi	s8,s8,1460 # ffffffffc020b948 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	56490913          	addi	s2,s2,1380 # ffffffffc020b900 <etext+0x220>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	56448493          	addi	s1,s1,1380 # ffffffffc020b908 <etext+0x228>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	562b0b13          	addi	s6,s6,1378 # ffffffffc020b910 <etext+0x230>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	47aa0a13          	addi	s4,s4,1146 # ffffffffc020b830 <etext+0x150>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	570d0d13          	addi	s10,s10,1392 # ffffffffc020b948 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	2360b0ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	2220b0ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	2280b0ef          	jal	ra,ffffffffc020b660 <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	1ea0b0ef          	jal	ra,ffffffffc020b660 <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	4a050513          	addi	a0,a0,1184 # ffffffffc020b930 <etext+0x250>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	4c450513          	addi	a0,a0,1220 # ffffffffc020b990 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	78e50513          	addi	a0,a0,1934 # ffffffffc020cc70 <default_pmm_manager+0x630>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	49a50513          	addi	a0,a0,1178 # ffffffffc020b9b0 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000c517          	auipc	a0,0xc
ffffffffc020053a:	73a50513          	addi	a0,a0,1850 # ffffffffc020cc70 <default_pmm_manager+0x630>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	46850513          	addi	a0,a0,1128 # ffffffffc020b9d0 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	34250513          	addi	a0,a0,834 # ffffffffc020b9f0 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	32450513          	addi	a0,a0,804 # ffffffffc020ba00 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	31e50513          	addi	a0,a0,798 # ffffffffc020ba10 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	32650513          	addi	a0,a0,806 # ffffffffc020ba28 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	2bc90913          	addi	s2,s2,700 # ffffffffc020ba78 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	2a648493          	addi	s1,s1,678 # ffffffffc020ba70 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	2d250513          	addi	a0,a0,722 # ffffffffc020baf0 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	2fe50513          	addi	a0,a0,766 # ffffffffc020bb28 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	1de50513          	addi	a0,a0,478 # ffffffffc020ba48 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	55d0a0ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	5b50a0ef          	jal	ra,ffffffffc020b63a <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	5010a0ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	15050513          	addi	a0,a0,336 # ffffffffc020ba80 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	0a250513          	addi	a0,a0,162 # ffffffffc020baa0 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	0a850513          	addi	a0,a0,168 # ffffffffc020bab8 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	0b650513          	addi	a0,a0,182 # ffffffffc020bad8 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	0fa50513          	addi	a0,a0,250 # ffffffffc020bb28 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	08868693          	addi	a3,a3,136 # ffffffffc020bb40 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	09860613          	addi	a2,a2,152 # ffffffffc020bb58 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	0a650513          	addi	a0,a0,166 # ffffffffc020bb70 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	0b268693          	addi	a3,a3,178 # ffffffffc020bb88 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	07a60613          	addi	a2,a2,122 # ffffffffc020bb58 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	08850513          	addi	a0,a0,136 # ffffffffc020bb70 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	00a68693          	addi	a3,a3,10 # ffffffffc020bba0 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	fba60613          	addi	a2,a2,-70 # ffffffffc020bb58 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	fc650513          	addi	a0,a0,-58 # ffffffffc020bb70 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	01268693          	addi	a3,a3,18 # ffffffffc020bbc8 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	f9a60613          	addi	a2,a2,-102 # ffffffffc020bb58 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	fa650513          	addi	a0,a0,-90 # ffffffffc020bb70 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	f7468693          	addi	a3,a3,-140 # ffffffffc020bba0 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	f2460613          	addi	a2,a2,-220 # ffffffffc020bb58 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	f3050513          	addi	a0,a0,-208 # ffffffffc020bb70 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	f7c68693          	addi	a3,a3,-132 # ffffffffc020bbc8 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	f0460613          	addi	a2,a2,-252 # ffffffffc020bb58 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	f1050513          	addi	a0,a0,-240 # ffffffffc020bb70 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	2310a0ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	2070a0ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	1930a0ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	f0e50513          	addi	a0,a0,-242 # ffffffffc020bc20 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	f4458593          	addi	a1,a1,-188 # ffffffffc020bc78 <commands+0x330>
ffffffffc0200d3c:	0cf0a0ef          	jal	ra,ffffffffc020b60a <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	e8c50513          	addi	a0,a0,-372 # ffffffffc020bc08 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	ebe60613          	addi	a2,a2,-322 # ffffffffc020bc48 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	eca50513          	addi	a0,a0,-310 # ffffffffc020bc60 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	ec450513          	addi	a0,a0,-316 # ffffffffc020bc88 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	ecc50513          	addi	a0,a0,-308 # ffffffffc020bca0 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	ed650513          	addi	a0,a0,-298 # ffffffffc020bcb8 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	ee050513          	addi	a0,a0,-288 # ffffffffc020bcd0 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	eea50513          	addi	a0,a0,-278 # ffffffffc020bce8 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	ef450513          	addi	a0,a0,-268 # ffffffffc020bd00 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	efe50513          	addi	a0,a0,-258 # ffffffffc020bd18 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	f0850513          	addi	a0,a0,-248 # ffffffffc020bd30 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	f1250513          	addi	a0,a0,-238 # ffffffffc020bd48 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	f1c50513          	addi	a0,a0,-228 # ffffffffc020bd60 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	f2650513          	addi	a0,a0,-218 # ffffffffc020bd78 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	f3050513          	addi	a0,a0,-208 # ffffffffc020bd90 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	f3a50513          	addi	a0,a0,-198 # ffffffffc020bda8 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	f4450513          	addi	a0,a0,-188 # ffffffffc020bdc0 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	f4e50513          	addi	a0,a0,-178 # ffffffffc020bdd8 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	f5850513          	addi	a0,a0,-168 # ffffffffc020bdf0 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	f6250513          	addi	a0,a0,-158 # ffffffffc020be08 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	f6c50513          	addi	a0,a0,-148 # ffffffffc020be20 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	f7650513          	addi	a0,a0,-138 # ffffffffc020be38 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	f8050513          	addi	a0,a0,-128 # ffffffffc020be50 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	f8a50513          	addi	a0,a0,-118 # ffffffffc020be68 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	f9450513          	addi	a0,a0,-108 # ffffffffc020be80 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	f9e50513          	addi	a0,a0,-98 # ffffffffc020be98 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	fa850513          	addi	a0,a0,-88 # ffffffffc020beb0 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	fb250513          	addi	a0,a0,-78 # ffffffffc020bec8 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	fbc50513          	addi	a0,a0,-68 # ffffffffc020bee0 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	fc650513          	addi	a0,a0,-58 # ffffffffc020bef8 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	fd050513          	addi	a0,a0,-48 # ffffffffc020bf10 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	fda50513          	addi	a0,a0,-38 # ffffffffc020bf28 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	fe450513          	addi	a0,a0,-28 # ffffffffc020bf40 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	fee50513          	addi	a0,a0,-18 # ffffffffc020bf58 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	ff450513          	addi	a0,a0,-12 # ffffffffc020bf70 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	ff650513          	addi	a0,a0,-10 # ffffffffc020bf88 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	ff650513          	addi	a0,a0,-10 # ffffffffc020bfa0 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	ffe50513          	addi	a0,a0,-2 # ffffffffc020bfb8 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	00650513          	addi	a0,a0,6 # ffffffffc020bfd0 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	00250513          	addi	a0,a0,2 # ffffffffc020bfe0 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	09e70713          	addi	a4,a4,158 # ffffffffc020c098 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	04c50513          	addi	a0,a0,76 # ffffffffc020c058 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	02050513          	addi	a0,a0,32 # ffffffffc020c038 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	fd450513          	addi	a0,a0,-44 # ffffffffc020bff8 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	fe850513          	addi	a0,a0,-24 # ffffffffc020c018 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00096717          	auipc	a4,0x96
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0296870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	6dc060ef          	jal	ra,ffffffffc020772e <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	5a10706f          	j	ffffffffc0208dfe <dev_stdin_write>
ffffffffc0201062:	0000b517          	auipc	a0,0xb
ffffffffc0201066:	01650513          	addi	a0,a0,22 # ffffffffc020c078 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000b717          	auipc	a4,0xb
ffffffffc0201086:	1d670713          	addi	a4,a4,470 # ffffffffc020c258 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000b517          	auipc	a0,0xb
ffffffffc0201098:	11c50513          	addi	a0,a0,284 # ffffffffc020c1b0 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	0950606f          	j	ffffffffc0207944 <syscall>
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	11c50513          	addi	a0,a0,284 # ffffffffc020c1d0 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000b517          	auipc	a0,0xb
ffffffffc02010ca:	12a50513          	addi	a0,a0,298 # ffffffffc020c1f0 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000b517          	auipc	a0,0xb
ffffffffc02010d4:	14050513          	addi	a0,a0,320 # ffffffffc020c210 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000b517          	auipc	a0,0xb
ffffffffc02010de:	14e50513          	addi	a0,a0,334 # ffffffffc020c228 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000b517          	auipc	a0,0xb
ffffffffc02010e8:	15c50513          	addi	a0,a0,348 # ffffffffc020c240 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000b517          	auipc	a0,0xb
ffffffffc02010f2:	fda50513          	addi	a0,a0,-38 # ffffffffc020c0c8 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000b517          	auipc	a0,0xb
ffffffffc02010fc:	ff050513          	addi	a0,a0,-16 # ffffffffc020c0e8 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000b517          	auipc	a0,0xb
ffffffffc0201106:	00650513          	addi	a0,a0,6 # ffffffffc020c108 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000b517          	auipc	a0,0xb
ffffffffc0201110:	01450513          	addi	a0,a0,20 # ffffffffc020c120 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000b517          	auipc	a0,0xb
ffffffffc020111a:	01a50513          	addi	a0,a0,26 # ffffffffc020c130 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000b517          	auipc	a0,0xb
ffffffffc0201124:	03050513          	addi	a0,a0,48 # ffffffffc020c150 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000b517          	auipc	a0,0xb
ffffffffc020112e:	06e50513          	addi	a0,a0,110 # ffffffffc020c198 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000b617          	auipc	a2,0xb
ffffffffc0201142:	02a60613          	addi	a2,a2,42 # ffffffffc020c168 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000b517          	auipc	a0,0xb
ffffffffc020114e:	03650513          	addi	a0,a0,54 # ffffffffc020c180 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00095417          	auipc	s0,0x95
ffffffffc020115e:	76640413          	addi	s0,s0,1894 # ffffffffc02968c0 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	3500606f          	j	ffffffffc0207522 <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	6e9040ef          	jal	ra,ffffffffc02060c0 <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	00090797          	auipc	a5,0x90
ffffffffc02012b2:	4fa78793          	addi	a5,a5,1274 # ffffffffc02917a8 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	00090517          	auipc	a0,0x90
ffffffffc02012c4:	4f856503          	lwu	a0,1272(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	00090417          	auipc	s0,0x90
ffffffffc02012d2:	4da40413          	addi	s0,s0,1242 # ffffffffc02917a8 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00095797          	auipc	a5,0x95
ffffffffc020135e:	54e7b783          	ld	a5,1358(a5) # ffffffffc02968a8 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000e617          	auipc	a2,0xe
ffffffffc020136a:	66263603          	ld	a2,1634(a2) # ffffffffc020f9c8 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00095697          	auipc	a3,0x95
ffffffffc0201376:	52e6b683          	ld	a3,1326(a3) # ffffffffc02968a0 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	00090797          	auipc	a5,0x90
ffffffffc02013b4:	4007a423          	sw	zero,1032(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	00090797          	auipc	a5,0x90
ffffffffc0201496:	3207a323          	sw	zero,806(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000b697          	auipc	a3,0xb
ffffffffc02015b0:	cec68693          	addi	a3,a3,-788 # ffffffffc020c298 <commands+0x950>
ffffffffc02015b4:	0000a617          	auipc	a2,0xa
ffffffffc02015b8:	5a460613          	addi	a2,a2,1444 # ffffffffc020bb58 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000b517          	auipc	a0,0xb
ffffffffc02015c4:	ce850513          	addi	a0,a0,-792 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000b697          	auipc	a3,0xb
ffffffffc02015d0:	d7468693          	addi	a3,a3,-652 # ffffffffc020c340 <commands+0x9f8>
ffffffffc02015d4:	0000a617          	auipc	a2,0xa
ffffffffc02015d8:	58460613          	addi	a2,a2,1412 # ffffffffc020bb58 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000b517          	auipc	a0,0xb
ffffffffc02015e4:	cc850513          	addi	a0,a0,-824 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000b697          	auipc	a3,0xb
ffffffffc02015f0:	d7c68693          	addi	a3,a3,-644 # ffffffffc020c368 <commands+0xa20>
ffffffffc02015f4:	0000a617          	auipc	a2,0xa
ffffffffc02015f8:	56460613          	addi	a2,a2,1380 # ffffffffc020bb58 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000b517          	auipc	a0,0xb
ffffffffc0201604:	ca850513          	addi	a0,a0,-856 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000b697          	auipc	a3,0xb
ffffffffc0201610:	d9c68693          	addi	a3,a3,-612 # ffffffffc020c3a8 <commands+0xa60>
ffffffffc0201614:	0000a617          	auipc	a2,0xa
ffffffffc0201618:	54460613          	addi	a2,a2,1348 # ffffffffc020bb58 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000b517          	auipc	a0,0xb
ffffffffc0201624:	c8850513          	addi	a0,a0,-888 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000b697          	auipc	a3,0xb
ffffffffc0201630:	e0468693          	addi	a3,a3,-508 # ffffffffc020c430 <commands+0xae8>
ffffffffc0201634:	0000a617          	auipc	a2,0xa
ffffffffc0201638:	52460613          	addi	a2,a2,1316 # ffffffffc020bb58 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000b517          	auipc	a0,0xb
ffffffffc0201644:	c6850513          	addi	a0,a0,-920 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000b697          	auipc	a3,0xb
ffffffffc0201650:	c9468693          	addi	a3,a3,-876 # ffffffffc020c2e0 <commands+0x998>
ffffffffc0201654:	0000a617          	auipc	a2,0xa
ffffffffc0201658:	50460613          	addi	a2,a2,1284 # ffffffffc020bb58 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000b517          	auipc	a0,0xb
ffffffffc0201664:	c4850513          	addi	a0,a0,-952 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000b697          	auipc	a3,0xb
ffffffffc0201670:	db468693          	addi	a3,a3,-588 # ffffffffc020c420 <commands+0xad8>
ffffffffc0201674:	0000a617          	auipc	a2,0xa
ffffffffc0201678:	4e460613          	addi	a2,a2,1252 # ffffffffc020bb58 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000b517          	auipc	a0,0xb
ffffffffc0201684:	c2850513          	addi	a0,a0,-984 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000b697          	auipc	a3,0xb
ffffffffc0201690:	d7c68693          	addi	a3,a3,-644 # ffffffffc020c408 <commands+0xac0>
ffffffffc0201694:	0000a617          	auipc	a2,0xa
ffffffffc0201698:	4c460613          	addi	a2,a2,1220 # ffffffffc020bb58 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000b517          	auipc	a0,0xb
ffffffffc02016a4:	c0850513          	addi	a0,a0,-1016 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000b697          	auipc	a3,0xb
ffffffffc02016b0:	d3c68693          	addi	a3,a3,-708 # ffffffffc020c3e8 <commands+0xaa0>
ffffffffc02016b4:	0000a617          	auipc	a2,0xa
ffffffffc02016b8:	4a460613          	addi	a2,a2,1188 # ffffffffc020bb58 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000b517          	auipc	a0,0xb
ffffffffc02016c4:	be850513          	addi	a0,a0,-1048 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000b697          	auipc	a3,0xb
ffffffffc02016d0:	dac68693          	addi	a3,a3,-596 # ffffffffc020c478 <commands+0xb30>
ffffffffc02016d4:	0000a617          	auipc	a2,0xa
ffffffffc02016d8:	48460613          	addi	a2,a2,1156 # ffffffffc020bb58 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000b517          	auipc	a0,0xb
ffffffffc02016e4:	bc850513          	addi	a0,a0,-1080 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000b697          	auipc	a3,0xb
ffffffffc02016f0:	d7c68693          	addi	a3,a3,-644 # ffffffffc020c468 <commands+0xb20>
ffffffffc02016f4:	0000a617          	auipc	a2,0xa
ffffffffc02016f8:	46460613          	addi	a2,a2,1124 # ffffffffc020bb58 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000b517          	auipc	a0,0xb
ffffffffc0201704:	ba850513          	addi	a0,a0,-1112 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000b697          	auipc	a3,0xb
ffffffffc0201710:	cfc68693          	addi	a3,a3,-772 # ffffffffc020c408 <commands+0xac0>
ffffffffc0201714:	0000a617          	auipc	a2,0xa
ffffffffc0201718:	44460613          	addi	a2,a2,1092 # ffffffffc020bb58 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000b517          	auipc	a0,0xb
ffffffffc0201724:	b8850513          	addi	a0,a0,-1144 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000b697          	auipc	a3,0xb
ffffffffc0201730:	d1c68693          	addi	a3,a3,-740 # ffffffffc020c448 <commands+0xb00>
ffffffffc0201734:	0000a617          	auipc	a2,0xa
ffffffffc0201738:	42460613          	addi	a2,a2,1060 # ffffffffc020bb58 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000b517          	auipc	a0,0xb
ffffffffc0201744:	b6850513          	addi	a0,a0,-1176 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000b697          	auipc	a3,0xb
ffffffffc0201750:	b9468693          	addi	a3,a3,-1132 # ffffffffc020c2e0 <commands+0x998>
ffffffffc0201754:	0000a617          	auipc	a2,0xa
ffffffffc0201758:	40460613          	addi	a2,a2,1028 # ffffffffc020bb58 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000b517          	auipc	a0,0xb
ffffffffc0201764:	b4850513          	addi	a0,a0,-1208 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000b697          	auipc	a3,0xb
ffffffffc0201770:	c9c68693          	addi	a3,a3,-868 # ffffffffc020c408 <commands+0xac0>
ffffffffc0201774:	0000a617          	auipc	a2,0xa
ffffffffc0201778:	3e460613          	addi	a2,a2,996 # ffffffffc020bb58 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000b517          	auipc	a0,0xb
ffffffffc0201784:	b2850513          	addi	a0,a0,-1240 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000b697          	auipc	a3,0xb
ffffffffc0201790:	b9468693          	addi	a3,a3,-1132 # ffffffffc020c320 <commands+0x9d8>
ffffffffc0201794:	0000a617          	auipc	a2,0xa
ffffffffc0201798:	3c460613          	addi	a2,a2,964 # ffffffffc020bb58 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000b517          	auipc	a0,0xb
ffffffffc02017a4:	b0850513          	addi	a0,a0,-1272 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000b697          	auipc	a3,0xb
ffffffffc02017b0:	b5468693          	addi	a3,a3,-1196 # ffffffffc020c300 <commands+0x9b8>
ffffffffc02017b4:	0000a617          	auipc	a2,0xa
ffffffffc02017b8:	3a460613          	addi	a2,a2,932 # ffffffffc020bb58 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	0000b517          	auipc	a0,0xb
ffffffffc02017c4:	ae850513          	addi	a0,a0,-1304 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000b697          	auipc	a3,0xb
ffffffffc02017d0:	b5468693          	addi	a3,a3,-1196 # ffffffffc020c320 <commands+0x9d8>
ffffffffc02017d4:	0000a617          	auipc	a2,0xa
ffffffffc02017d8:	38460613          	addi	a2,a2,900 # ffffffffc020bb58 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	0000b517          	auipc	a0,0xb
ffffffffc02017e4:	ac850513          	addi	a0,a0,-1336 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000b697          	auipc	a3,0xb
ffffffffc02017f0:	ddc68693          	addi	a3,a3,-548 # ffffffffc020c5c8 <commands+0xc80>
ffffffffc02017f4:	0000a617          	auipc	a2,0xa
ffffffffc02017f8:	36460613          	addi	a2,a2,868 # ffffffffc020bb58 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	0000b517          	auipc	a0,0xb
ffffffffc0201804:	aa850513          	addi	a0,a0,-1368 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000b697          	auipc	a3,0xb
ffffffffc0201810:	c5c68693          	addi	a3,a3,-932 # ffffffffc020c468 <commands+0xb20>
ffffffffc0201814:	0000a617          	auipc	a2,0xa
ffffffffc0201818:	34460613          	addi	a2,a2,836 # ffffffffc020bb58 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	0000b517          	auipc	a0,0xb
ffffffffc0201824:	a8850513          	addi	a0,a0,-1400 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000b697          	auipc	a3,0xb
ffffffffc0201830:	bdc68693          	addi	a3,a3,-1060 # ffffffffc020c408 <commands+0xac0>
ffffffffc0201834:	0000a617          	auipc	a2,0xa
ffffffffc0201838:	32460613          	addi	a2,a2,804 # ffffffffc020bb58 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	0000b517          	auipc	a0,0xb
ffffffffc0201844:	a6850513          	addi	a0,a0,-1432 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000b697          	auipc	a3,0xb
ffffffffc0201850:	b7c68693          	addi	a3,a3,-1156 # ffffffffc020c3c8 <commands+0xa80>
ffffffffc0201854:	0000a617          	auipc	a2,0xa
ffffffffc0201858:	30460613          	addi	a2,a2,772 # ffffffffc020bb58 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	0000b517          	auipc	a0,0xb
ffffffffc0201864:	a4850513          	addi	a0,a0,-1464 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000b697          	auipc	a3,0xb
ffffffffc0201870:	d1c68693          	addi	a3,a3,-740 # ffffffffc020c588 <commands+0xc40>
ffffffffc0201874:	0000a617          	auipc	a2,0xa
ffffffffc0201878:	2e460613          	addi	a2,a2,740 # ffffffffc020bb58 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	0000b517          	auipc	a0,0xb
ffffffffc0201884:	a2850513          	addi	a0,a0,-1496 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000b697          	auipc	a3,0xb
ffffffffc0201890:	cdc68693          	addi	a3,a3,-804 # ffffffffc020c568 <commands+0xc20>
ffffffffc0201894:	0000a617          	auipc	a2,0xa
ffffffffc0201898:	2c460613          	addi	a2,a2,708 # ffffffffc020bb58 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	0000b517          	auipc	a0,0xb
ffffffffc02018a4:	a0850513          	addi	a0,a0,-1528 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000b697          	auipc	a3,0xb
ffffffffc02018b0:	c9468693          	addi	a3,a3,-876 # ffffffffc020c540 <commands+0xbf8>
ffffffffc02018b4:	0000a617          	auipc	a2,0xa
ffffffffc02018b8:	2a460613          	addi	a2,a2,676 # ffffffffc020bb58 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	0000b517          	auipc	a0,0xb
ffffffffc02018c4:	9e850513          	addi	a0,a0,-1560 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000b697          	auipc	a3,0xb
ffffffffc02018d0:	c4c68693          	addi	a3,a3,-948 # ffffffffc020c518 <commands+0xbd0>
ffffffffc02018d4:	0000a617          	auipc	a2,0xa
ffffffffc02018d8:	28460613          	addi	a2,a2,644 # ffffffffc020bb58 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	0000b517          	auipc	a0,0xb
ffffffffc02018e4:	9c850513          	addi	a0,a0,-1592 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000b697          	auipc	a3,0xb
ffffffffc02018f0:	c1c68693          	addi	a3,a3,-996 # ffffffffc020c508 <commands+0xbc0>
ffffffffc02018f4:	0000a617          	auipc	a2,0xa
ffffffffc02018f8:	26460613          	addi	a2,a2,612 # ffffffffc020bb58 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	0000b517          	auipc	a0,0xb
ffffffffc0201904:	9a850513          	addi	a0,a0,-1624 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	0000b697          	auipc	a3,0xb
ffffffffc0201910:	afc68693          	addi	a3,a3,-1284 # ffffffffc020c408 <commands+0xac0>
ffffffffc0201914:	0000a617          	auipc	a2,0xa
ffffffffc0201918:	24460613          	addi	a2,a2,580 # ffffffffc020bb58 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	0000b517          	auipc	a0,0xb
ffffffffc0201924:	98850513          	addi	a0,a0,-1656 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000b697          	auipc	a3,0xb
ffffffffc0201930:	bbc68693          	addi	a3,a3,-1092 # ffffffffc020c4e8 <commands+0xba0>
ffffffffc0201934:	0000a617          	auipc	a2,0xa
ffffffffc0201938:	22460613          	addi	a2,a2,548 # ffffffffc020bb58 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	0000b517          	auipc	a0,0xb
ffffffffc0201944:	96850513          	addi	a0,a0,-1688 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000b697          	auipc	a3,0xb
ffffffffc0201950:	b6c68693          	addi	a3,a3,-1172 # ffffffffc020c4b8 <commands+0xb70>
ffffffffc0201954:	0000a617          	auipc	a2,0xa
ffffffffc0201958:	20460613          	addi	a2,a2,516 # ffffffffc020bb58 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	0000b517          	auipc	a0,0xb
ffffffffc0201964:	94850513          	addi	a0,a0,-1720 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000b697          	auipc	a3,0xb
ffffffffc0201970:	b3468693          	addi	a3,a3,-1228 # ffffffffc020c4a0 <commands+0xb58>
ffffffffc0201974:	0000a617          	auipc	a2,0xa
ffffffffc0201978:	1e460613          	addi	a2,a2,484 # ffffffffc020bb58 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	0000b517          	auipc	a0,0xb
ffffffffc0201984:	92850513          	addi	a0,a0,-1752 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	0000b697          	auipc	a3,0xb
ffffffffc0201990:	a7c68693          	addi	a3,a3,-1412 # ffffffffc020c408 <commands+0xac0>
ffffffffc0201994:	0000a617          	auipc	a2,0xa
ffffffffc0201998:	1c460613          	addi	a2,a2,452 # ffffffffc020bb58 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	0000b517          	auipc	a0,0xb
ffffffffc02019a4:	90850513          	addi	a0,a0,-1784 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	0000b697          	auipc	a3,0xb
ffffffffc02019b0:	adc68693          	addi	a3,a3,-1316 # ffffffffc020c488 <commands+0xb40>
ffffffffc02019b4:	0000a617          	auipc	a2,0xa
ffffffffc02019b8:	1a460613          	addi	a2,a2,420 # ffffffffc020bb58 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	0000b517          	auipc	a0,0xb
ffffffffc02019c4:	8e850513          	addi	a0,a0,-1816 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000b697          	auipc	a3,0xb
ffffffffc02019d0:	bdc68693          	addi	a3,a3,-1060 # ffffffffc020c5a8 <commands+0xc60>
ffffffffc02019d4:	0000a617          	auipc	a2,0xa
ffffffffc02019d8:	18460613          	addi	a2,a2,388 # ffffffffc020bb58 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	0000b517          	auipc	a0,0xb
ffffffffc02019e4:	8c850513          	addi	a0,a0,-1848 # ffffffffc020c2a8 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000b697          	auipc	a3,0xb
ffffffffc02019f0:	bec68693          	addi	a3,a3,-1044 # ffffffffc020c5d8 <commands+0xc90>
ffffffffc02019f4:	0000a617          	auipc	a2,0xa
ffffffffc02019f8:	16460613          	addi	a2,a2,356 # ffffffffc020bb58 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	0000b517          	auipc	a0,0xb
ffffffffc0201a04:	8a850513          	addi	a0,a0,-1880 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	0000b697          	auipc	a3,0xb
ffffffffc0201a10:	8b468693          	addi	a3,a3,-1868 # ffffffffc020c2c0 <commands+0x978>
ffffffffc0201a14:	0000a617          	auipc	a2,0xa
ffffffffc0201a18:	14460613          	addi	a2,a2,324 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	0000b517          	auipc	a0,0xb
ffffffffc0201a24:	88850513          	addi	a0,a0,-1912 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	0000b697          	auipc	a3,0xb
ffffffffc0201a30:	8d468693          	addi	a3,a3,-1836 # ffffffffc020c300 <commands+0x9b8>
ffffffffc0201a34:	0000a617          	auipc	a2,0xa
ffffffffc0201a38:	12460613          	addi	a2,a2,292 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	0000b517          	auipc	a0,0xb
ffffffffc0201a44:	86850513          	addi	a0,a0,-1944 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	00090697          	auipc	a3,0x90
ffffffffc0201a92:	d1a68693          	addi	a3,a3,-742 # ffffffffc02917a8 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	0000b697          	auipc	a3,0xb
ffffffffc0201b7c:	a7868693          	addi	a3,a3,-1416 # ffffffffc020c5f0 <commands+0xca8>
ffffffffc0201b80:	0000a617          	auipc	a2,0xa
ffffffffc0201b84:	fd860613          	addi	a2,a2,-40 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	0000a517          	auipc	a0,0xa
ffffffffc0201b90:	71c50513          	addi	a0,a0,1820 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	0000b697          	auipc	a3,0xb
ffffffffc0201b9c:	a5068693          	addi	a3,a3,-1456 # ffffffffc020c5e8 <commands+0xca0>
ffffffffc0201ba0:	0000a617          	auipc	a2,0xa
ffffffffc0201ba4:	fb860613          	addi	a2,a2,-72 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	0000a517          	auipc	a0,0xa
ffffffffc0201bb0:	6fc50513          	addi	a0,a0,1788 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	00090597          	auipc	a1,0x90
ffffffffc0201bbe:	bee58593          	addi	a1,a1,-1042 # ffffffffc02917a8 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	0000b697          	auipc	a3,0xb
ffffffffc0201c4e:	99e68693          	addi	a3,a3,-1634 # ffffffffc020c5e8 <commands+0xca0>
ffffffffc0201c52:	0000a617          	auipc	a2,0xa
ffffffffc0201c56:	f0660613          	addi	a2,a2,-250 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	0000a517          	auipc	a0,0xa
ffffffffc0201c62:	64a50513          	addi	a0,a0,1610 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	00090697          	auipc	a3,0x90
ffffffffc0201caa:	b0268693          	addi	a3,a3,-1278 # ffffffffc02917a8 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	0000b697          	auipc	a3,0xb
ffffffffc0201d20:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c618 <commands+0xcd0>
ffffffffc0201d24:	0000a617          	auipc	a2,0xa
ffffffffc0201d28:	e3460613          	addi	a2,a2,-460 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	0000a517          	auipc	a0,0xa
ffffffffc0201d34:	57850513          	addi	a0,a0,1400 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	0000b697          	auipc	a3,0xb
ffffffffc0201d40:	8ac68693          	addi	a3,a3,-1876 # ffffffffc020c5e8 <commands+0xca0>
ffffffffc0201d44:	0000a617          	auipc	a2,0xa
ffffffffc0201d48:	e1460613          	addi	a2,a2,-492 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	0000a517          	auipc	a0,0xa
ffffffffc0201d54:	55850513          	addi	a0,a0,1368 # ffffffffc020c2a8 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008f617          	auipc	a2,0x8f
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0291050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00095697          	auipc	a3,0x95
ffffffffc0201e24:	a886b683          	ld	a3,-1400(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000e697          	auipc	a3,0xe
ffffffffc0201e30:	b9c6b683          	ld	a3,-1124(a3) # ffffffffc020f9c8 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00095717          	auipc	a4,0x95
ffffffffc0201e40:	a6473703          	ld	a4,-1436(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00095697          	auipc	a3,0x95
ffffffffc0201e4e:	a6e6b683          	ld	a3,-1426(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	0000b617          	auipc	a2,0xb
ffffffffc0201e60:	81c60613          	addi	a2,a2,-2020 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	0000b517          	auipc	a0,0xb
ffffffffc0201e6c:	83850513          	addi	a0,a0,-1992 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008f917          	auipc	s2,0x8f
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0291050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	0000a697          	auipc	a3,0xa
ffffffffc0201f4e:	76668693          	addi	a3,a3,1894 # ffffffffc020c6b0 <default_pmm_manager+0x70>
ffffffffc0201f52:	0000a617          	auipc	a2,0xa
ffffffffc0201f56:	c0660613          	addi	a2,a2,-1018 # ffffffffc020bb58 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	0000a517          	auipc	a0,0xa
ffffffffc0201f62:	77250513          	addi	a0,a0,1906 # ffffffffc020c6d0 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	0000a517          	auipc	a0,0xa
ffffffffc0201f70:	77c50513          	addi	a0,a0,1916 # ffffffffc020c6e8 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	0000a517          	auipc	a0,0xa
ffffffffc0201f80:	78450513          	addi	a0,a0,1924 # ffffffffc020c700 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00095797          	auipc	a5,0x95
ffffffffc0201fda:	8b278793          	addi	a5,a5,-1870 # ffffffffc0296888 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00095797          	auipc	a5,0x95
ffffffffc0202016:	87678793          	addi	a5,a5,-1930 # ffffffffc0296888 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00095797          	auipc	a5,0x95
ffffffffc020205c:	8307b783          	ld	a5,-2000(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00095697          	auipc	a3,0x95
ffffffffc0202068:	82468693          	addi	a3,a3,-2012 # ffffffffc0296888 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00095697          	auipc	a3,0x95
ffffffffc0202090:	82c6b683          	ld	a3,-2004(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00095797          	auipc	a5,0x95
ffffffffc020209c:	8087b783          	ld	a5,-2040(a5) # ffffffffc02968a0 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000e517          	auipc	a0,0xe
ffffffffc02020a8:	92453503          	ld	a0,-1756(a0) # ffffffffc020f9c8 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00094517          	auipc	a0,0x94
ffffffffc02020b4:	7f853503          	ld	a0,2040(a0) # ffffffffc02968a8 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00094797          	auipc	a5,0x94
ffffffffc02020ec:	7a07b783          	ld	a5,1952(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	0000a617          	auipc	a2,0xa
ffffffffc0202106:	64660613          	addi	a2,a2,1606 # ffffffffc020c748 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	0000a517          	auipc	a0,0xa
ffffffffc0202112:	59250513          	addi	a0,a0,1426 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	0000a617          	auipc	a2,0xa
ffffffffc0202120:	60460613          	addi	a2,a2,1540 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	0000a517          	auipc	a0,0xa
ffffffffc020212c:	57850513          	addi	a0,a0,1400 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	0000a617          	auipc	a2,0xa
ffffffffc020213a:	61260613          	addi	a2,a2,1554 # ffffffffc020c748 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	0000a517          	auipc	a0,0xa
ffffffffc0202146:	55e50513          	addi	a0,a0,1374 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	61660613          	addi	a2,a2,1558 # ffffffffc020c768 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	54250513          	addi	a0,a0,1346 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00094797          	auipc	a5,0x94
ffffffffc0202178:	73c7b783          	ld	a5,1852(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00094797          	auipc	a5,0x94
ffffffffc0202190:	7247b783          	ld	a5,1828(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00094797          	auipc	a5,0x94
ffffffffc02021b6:	6fe7b783          	ld	a5,1790(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00094797          	auipc	a5,0x94
ffffffffc02021d2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00094797          	auipc	a5,0x94
ffffffffc02021f6:	6be7b783          	ld	a5,1726(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00094797          	auipc	a5,0x94
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00094997          	auipc	s3,0x94
ffffffffc0202252:	65298993          	addi	s3,s3,1618 # ffffffffc02968a0 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00094797          	auipc	a5,0x94
ffffffffc020226a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00094b17          	auipc	s6,0x94
ffffffffc020227e:	62eb0b13          	addi	s6,s6,1582 # ffffffffc02968a8 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00094997          	auipc	s3,0x94
ffffffffc020228e:	61698993          	addi	s3,s3,1558 # ffffffffc02968a0 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00094797          	auipc	a5,0x94
ffffffffc02022b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	3ba090ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00094a97          	auipc	s5,0x94
ffffffffc02022ea:	5d2a8a93          	addi	s5,s5,1490 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00094797          	auipc	a5,0x94
ffffffffc020231a:	59a7b783          	ld	a5,1434(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00094b17          	auipc	s6,0x94
ffffffffc020232c:	580b0b13          	addi	s6,s6,1408 # ffffffffc02968a8 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	318090ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00094797          	auipc	a5,0x94
ffffffffc02023bc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00094797          	auipc	a5,0x94
ffffffffc02023d6:	4de7b783          	ld	a5,1246(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	0000a617          	auipc	a2,0xa
ffffffffc02023ec:	29060613          	addi	a2,a2,656 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	0000a517          	auipc	a0,0xa
ffffffffc02023f8:	39c50513          	addi	a0,a0,924 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	0000a617          	auipc	a2,0xa
ffffffffc0202404:	27860613          	addi	a2,a2,632 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	0000a517          	auipc	a0,0xa
ffffffffc0202410:	38450513          	addi	a0,a0,900 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	0000a617          	auipc	a2,0xa
ffffffffc020241e:	25e60613          	addi	a2,a2,606 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	0000a517          	auipc	a0,0xa
ffffffffc020242a:	36a50513          	addi	a0,a0,874 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	0000a617          	auipc	a2,0xa
ffffffffc0202438:	24460613          	addi	a2,a2,580 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	0000a517          	auipc	a0,0xa
ffffffffc0202444:	35050513          	addi	a0,a0,848 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	0000a697          	auipc	a3,0xa
ffffffffc02024d6:	2e668693          	addi	a3,a3,742 # ffffffffc020c7b8 <default_pmm_manager+0x178>
ffffffffc02024da:	00009617          	auipc	a2,0x9
ffffffffc02024de:	67e60613          	addi	a2,a2,1662 # ffffffffc020bb58 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	0000a517          	auipc	a0,0xa
ffffffffc02024ea:	2aa50513          	addi	a0,a0,682 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	0000a697          	auipc	a3,0xa
ffffffffc02024f6:	2ae68693          	addi	a3,a3,686 # ffffffffc020c7a0 <default_pmm_manager+0x160>
ffffffffc02024fa:	00009617          	auipc	a2,0x9
ffffffffc02024fe:	65e60613          	addi	a2,a2,1630 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	0000a517          	auipc	a0,0xa
ffffffffc020250a:	28a50513          	addi	a0,a0,650 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00094717          	auipc	a4,0x94
ffffffffc0202540:	36473703          	ld	a4,868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00094517          	auipc	a0,0x94
ffffffffc0202558:	35453503          	ld	a0,852(a0) # ffffffffc02968a8 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00094c97          	auipc	s9,0x94
ffffffffc02025a8:	2fcc8c93          	addi	s9,s9,764 # ffffffffc02968a0 <npage>
ffffffffc02025ac:	00094c17          	auipc	s8,0x94
ffffffffc02025b0:	2fcc0c13          	addi	s8,s8,764 # ffffffffc02968a8 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00094d17          	auipc	s10,0x94
ffffffffc02025bc:	2f8d0d13          	addi	s10,s10,760 # ffffffffc02968b0 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	0000a697          	auipc	a3,0xa
ffffffffc020266c:	16068693          	addi	a3,a3,352 # ffffffffc020c7c8 <default_pmm_manager+0x188>
ffffffffc0202670:	00009617          	auipc	a2,0x9
ffffffffc0202674:	4e860613          	addi	a2,a2,1256 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	0000a517          	auipc	a0,0xa
ffffffffc0202680:	11450513          	addi	a0,a0,276 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	0000a697          	auipc	a3,0xa
ffffffffc020268c:	17068693          	addi	a3,a3,368 # ffffffffc020c7f8 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00009617          	auipc	a2,0x9
ffffffffc0202694:	4c860613          	addi	a2,a2,1224 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	0000a517          	auipc	a0,0xa
ffffffffc02026a0:	0f450513          	addi	a0,a0,244 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00094d17          	auipc	s10,0x94
ffffffffc0202706:	19ed0d13          	addi	s10,s10,414 # ffffffffc02968a0 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00094717          	auipc	a4,0x94
ffffffffc0202712:	19a70713          	addi	a4,a4,410 # ffffffffc02968a8 <pages>
ffffffffc0202716:	00094d97          	auipc	s11,0x94
ffffffffc020271a:	19ad8d93          	addi	s11,s11,410 # ffffffffc02968b0 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00094817          	auipc	a6,0x94
ffffffffc0202776:	14680813          	addi	a6,a6,326 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00094817          	auipc	a6,0x94
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00094717          	auipc	a4,0x94
ffffffffc020281c:	09070713          	addi	a4,a4,144 # ffffffffc02968a8 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00094717          	auipc	a4,0x94
ffffffffc0202854:	05870713          	addi	a4,a4,88 # ffffffffc02968a8 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00094717          	auipc	a4,0x94
ffffffffc02028a2:	00a70713          	addi	a4,a4,10 # ffffffffc02968a8 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00094817          	auipc	a6,0x94
ffffffffc02028b4:	00880813          	addi	a6,a6,8 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00094717          	auipc	a4,0x94
ffffffffc02028d8:	fd470713          	addi	a4,a4,-44 # ffffffffc02968a8 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	0000a697          	auipc	a3,0xa
ffffffffc02028e6:	ee668693          	addi	a3,a3,-282 # ffffffffc020c7c8 <default_pmm_manager+0x188>
ffffffffc02028ea:	00009617          	auipc	a2,0x9
ffffffffc02028ee:	26e60613          	addi	a2,a2,622 # ffffffffc020bb58 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	0000a517          	auipc	a0,0xa
ffffffffc02028fa:	e9a50513          	addi	a0,a0,-358 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	0000a617          	auipc	a2,0xa
ffffffffc0202906:	d7660613          	addi	a2,a2,-650 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	0000a517          	auipc	a0,0xa
ffffffffc0202912:	d9250513          	addi	a0,a0,-622 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	0000a697          	auipc	a3,0xa
ffffffffc0202922:	eda68693          	addi	a3,a3,-294 # ffffffffc020c7f8 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00009617          	auipc	a2,0x9
ffffffffc020292a:	23260613          	addi	a2,a2,562 # ffffffffc020bb58 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	0000a517          	auipc	a0,0xa
ffffffffc0202936:	e5e50513          	addi	a0,a0,-418 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <copy_range>:
ffffffffc020293e:	7119                	addi	sp,sp,-128
ffffffffc0202940:	00d667b3          	or	a5,a2,a3
ffffffffc0202944:	fc86                	sd	ra,120(sp)
ffffffffc0202946:	f8a2                	sd	s0,112(sp)
ffffffffc0202948:	f4a6                	sd	s1,104(sp)
ffffffffc020294a:	f0ca                	sd	s2,96(sp)
ffffffffc020294c:	ecce                	sd	s3,88(sp)
ffffffffc020294e:	e8d2                	sd	s4,80(sp)
ffffffffc0202950:	e4d6                	sd	s5,72(sp)
ffffffffc0202952:	e0da                	sd	s6,64(sp)
ffffffffc0202954:	fc5e                	sd	s7,56(sp)
ffffffffc0202956:	f862                	sd	s8,48(sp)
ffffffffc0202958:	f466                	sd	s9,40(sp)
ffffffffc020295a:	f06a                	sd	s10,32(sp)
ffffffffc020295c:	ec6e                	sd	s11,24(sp)
ffffffffc020295e:	17d2                	slli	a5,a5,0x34
ffffffffc0202960:	16079e63          	bnez	a5,ffffffffc0202adc <copy_range+0x19e>
ffffffffc0202964:	002007b7          	lui	a5,0x200
ffffffffc0202968:	8db2                	mv	s11,a2
ffffffffc020296a:	12f66d63          	bltu	a2,a5,ffffffffc0202aa4 <copy_range+0x166>
ffffffffc020296e:	84b6                	mv	s1,a3
ffffffffc0202970:	12d67a63          	bgeu	a2,a3,ffffffffc0202aa4 <copy_range+0x166>
ffffffffc0202974:	4785                	li	a5,1
ffffffffc0202976:	07fe                	slli	a5,a5,0x1f
ffffffffc0202978:	12d7e663          	bltu	a5,a3,ffffffffc0202aa4 <copy_range+0x166>
ffffffffc020297c:	8a2a                	mv	s4,a0
ffffffffc020297e:	892e                	mv	s2,a1
ffffffffc0202980:	6985                	lui	s3,0x1
ffffffffc0202982:	00094c17          	auipc	s8,0x94
ffffffffc0202986:	f1ec0c13          	addi	s8,s8,-226 # ffffffffc02968a0 <npage>
ffffffffc020298a:	00094b97          	auipc	s7,0x94
ffffffffc020298e:	f1eb8b93          	addi	s7,s7,-226 # ffffffffc02968a8 <pages>
ffffffffc0202992:	fff80b37          	lui	s6,0xfff80
ffffffffc0202996:	00094a97          	auipc	s5,0x94
ffffffffc020299a:	f1aa8a93          	addi	s5,s5,-230 # ffffffffc02968b0 <pmm_manager>
ffffffffc020299e:	00200d37          	lui	s10,0x200
ffffffffc02029a2:	ffe00cb7          	lui	s9,0xffe00
ffffffffc02029a6:	4601                	li	a2,0
ffffffffc02029a8:	85ee                	mv	a1,s11
ffffffffc02029aa:	854a                	mv	a0,s2
ffffffffc02029ac:	879ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029b0:	842a                	mv	s0,a0
ffffffffc02029b2:	c559                	beqz	a0,ffffffffc0202a40 <copy_range+0x102>
ffffffffc02029b4:	611c                	ld	a5,0(a0)
ffffffffc02029b6:	8b85                	andi	a5,a5,1
ffffffffc02029b8:	e785                	bnez	a5,ffffffffc02029e0 <copy_range+0xa2>
ffffffffc02029ba:	9dce                	add	s11,s11,s3
ffffffffc02029bc:	fe9de5e3          	bltu	s11,s1,ffffffffc02029a6 <copy_range+0x68>
ffffffffc02029c0:	4501                	li	a0,0
ffffffffc02029c2:	70e6                	ld	ra,120(sp)
ffffffffc02029c4:	7446                	ld	s0,112(sp)
ffffffffc02029c6:	74a6                	ld	s1,104(sp)
ffffffffc02029c8:	7906                	ld	s2,96(sp)
ffffffffc02029ca:	69e6                	ld	s3,88(sp)
ffffffffc02029cc:	6a46                	ld	s4,80(sp)
ffffffffc02029ce:	6aa6                	ld	s5,72(sp)
ffffffffc02029d0:	6b06                	ld	s6,64(sp)
ffffffffc02029d2:	7be2                	ld	s7,56(sp)
ffffffffc02029d4:	7c42                	ld	s8,48(sp)
ffffffffc02029d6:	7ca2                	ld	s9,40(sp)
ffffffffc02029d8:	7d02                	ld	s10,32(sp)
ffffffffc02029da:	6de2                	ld	s11,24(sp)
ffffffffc02029dc:	6109                	addi	sp,sp,128
ffffffffc02029de:	8082                	ret
ffffffffc02029e0:	4605                	li	a2,1
ffffffffc02029e2:	85ee                	mv	a1,s11
ffffffffc02029e4:	8552                	mv	a0,s4
ffffffffc02029e6:	83fff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029ea:	cd3d                	beqz	a0,ffffffffc0202a68 <copy_range+0x12a>
ffffffffc02029ec:	601c                	ld	a5,0(s0)
ffffffffc02029ee:	0017f713          	andi	a4,a5,1
ffffffffc02029f2:	cb69                	beqz	a4,ffffffffc0202ac4 <copy_range+0x186>
ffffffffc02029f4:	000c3703          	ld	a4,0(s8)
ffffffffc02029f8:	078a                	slli	a5,a5,0x2
ffffffffc02029fa:	83b1                	srli	a5,a5,0xc
ffffffffc02029fc:	08e7f863          	bgeu	a5,a4,ffffffffc0202a8c <copy_range+0x14e>
ffffffffc0202a00:	000bb403          	ld	s0,0(s7)
ffffffffc0202a04:	97da                	add	a5,a5,s6
ffffffffc0202a06:	079a                	slli	a5,a5,0x6
ffffffffc0202a08:	943e                	add	s0,s0,a5
ffffffffc0202a0a:	100027f3          	csrr	a5,sstatus
ffffffffc0202a0e:	8b89                	andi	a5,a5,2
ffffffffc0202a10:	e3a1                	bnez	a5,ffffffffc0202a50 <copy_range+0x112>
ffffffffc0202a12:	000ab783          	ld	a5,0(s5)
ffffffffc0202a16:	4505                	li	a0,1
ffffffffc0202a18:	6f9c                	ld	a5,24(a5)
ffffffffc0202a1a:	9782                	jalr	a5
ffffffffc0202a1c:	c821                	beqz	s0,ffffffffc0202a6c <copy_range+0x12e>
ffffffffc0202a1e:	fd51                	bnez	a0,ffffffffc02029ba <copy_range+0x7c>
ffffffffc0202a20:	0000a697          	auipc	a3,0xa
ffffffffc0202a24:	e0068693          	addi	a3,a3,-512 # ffffffffc020c820 <default_pmm_manager+0x1e0>
ffffffffc0202a28:	00009617          	auipc	a2,0x9
ffffffffc0202a2c:	13060613          	addi	a2,a2,304 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202a30:	1cf00593          	li	a1,463
ffffffffc0202a34:	0000a517          	auipc	a0,0xa
ffffffffc0202a38:	d5c50513          	addi	a0,a0,-676 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202a3c:	a63fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202a40:	9dea                	add	s11,s11,s10
ffffffffc0202a42:	019dfdb3          	and	s11,s11,s9
ffffffffc0202a46:	f60d8de3          	beqz	s11,ffffffffc02029c0 <copy_range+0x82>
ffffffffc0202a4a:	f49deee3          	bltu	s11,s1,ffffffffc02029a6 <copy_range+0x68>
ffffffffc0202a4e:	bf8d                	j	ffffffffc02029c0 <copy_range+0x82>
ffffffffc0202a50:	a22fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202a54:	000ab783          	ld	a5,0(s5)
ffffffffc0202a58:	4505                	li	a0,1
ffffffffc0202a5a:	6f9c                	ld	a5,24(a5)
ffffffffc0202a5c:	9782                	jalr	a5
ffffffffc0202a5e:	e42a                	sd	a0,8(sp)
ffffffffc0202a60:	a0cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202a64:	6522                	ld	a0,8(sp)
ffffffffc0202a66:	bf5d                	j	ffffffffc0202a1c <copy_range+0xde>
ffffffffc0202a68:	5571                	li	a0,-4
ffffffffc0202a6a:	bfa1                	j	ffffffffc02029c2 <copy_range+0x84>
ffffffffc0202a6c:	0000a697          	auipc	a3,0xa
ffffffffc0202a70:	da468693          	addi	a3,a3,-604 # ffffffffc020c810 <default_pmm_manager+0x1d0>
ffffffffc0202a74:	00009617          	auipc	a2,0x9
ffffffffc0202a78:	0e460613          	addi	a2,a2,228 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202a7c:	1ce00593          	li	a1,462
ffffffffc0202a80:	0000a517          	auipc	a0,0xa
ffffffffc0202a84:	d1050513          	addi	a0,a0,-752 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202a88:	a17fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202a8c:	0000a617          	auipc	a2,0xa
ffffffffc0202a90:	cbc60613          	addi	a2,a2,-836 # ffffffffc020c748 <default_pmm_manager+0x108>
ffffffffc0202a94:	06900593          	li	a1,105
ffffffffc0202a98:	0000a517          	auipc	a0,0xa
ffffffffc0202a9c:	c0850513          	addi	a0,a0,-1016 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0202aa0:	9fffd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202aa4:	0000a697          	auipc	a3,0xa
ffffffffc0202aa8:	d5468693          	addi	a3,a3,-684 # ffffffffc020c7f8 <default_pmm_manager+0x1b8>
ffffffffc0202aac:	00009617          	auipc	a2,0x9
ffffffffc0202ab0:	0ac60613          	addi	a2,a2,172 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202ab4:	1b600593          	li	a1,438
ffffffffc0202ab8:	0000a517          	auipc	a0,0xa
ffffffffc0202abc:	cd850513          	addi	a0,a0,-808 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202ac0:	9dffd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202ac4:	0000a617          	auipc	a2,0xa
ffffffffc0202ac8:	ca460613          	addi	a2,a2,-860 # ffffffffc020c768 <default_pmm_manager+0x128>
ffffffffc0202acc:	07f00593          	li	a1,127
ffffffffc0202ad0:	0000a517          	auipc	a0,0xa
ffffffffc0202ad4:	bd050513          	addi	a0,a0,-1072 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0202ad8:	9c7fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202adc:	0000a697          	auipc	a3,0xa
ffffffffc0202ae0:	cec68693          	addi	a3,a3,-788 # ffffffffc020c7c8 <default_pmm_manager+0x188>
ffffffffc0202ae4:	00009617          	auipc	a2,0x9
ffffffffc0202ae8:	07460613          	addi	a2,a2,116 # ffffffffc020bb58 <commands+0x210>
ffffffffc0202aec:	1b500593          	li	a1,437
ffffffffc0202af0:	0000a517          	auipc	a0,0xa
ffffffffc0202af4:	ca050513          	addi	a0,a0,-864 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0202af8:	9a7fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202afc <page_remove>:
ffffffffc0202afc:	7179                	addi	sp,sp,-48
ffffffffc0202afe:	4601                	li	a2,0
ffffffffc0202b00:	ec26                	sd	s1,24(sp)
ffffffffc0202b02:	f406                	sd	ra,40(sp)
ffffffffc0202b04:	f022                	sd	s0,32(sp)
ffffffffc0202b06:	84ae                	mv	s1,a1
ffffffffc0202b08:	f1cff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202b0c:	c511                	beqz	a0,ffffffffc0202b18 <page_remove+0x1c>
ffffffffc0202b0e:	611c                	ld	a5,0(a0)
ffffffffc0202b10:	842a                	mv	s0,a0
ffffffffc0202b12:	0017f713          	andi	a4,a5,1
ffffffffc0202b16:	e711                	bnez	a4,ffffffffc0202b22 <page_remove+0x26>
ffffffffc0202b18:	70a2                	ld	ra,40(sp)
ffffffffc0202b1a:	7402                	ld	s0,32(sp)
ffffffffc0202b1c:	64e2                	ld	s1,24(sp)
ffffffffc0202b1e:	6145                	addi	sp,sp,48
ffffffffc0202b20:	8082                	ret
ffffffffc0202b22:	078a                	slli	a5,a5,0x2
ffffffffc0202b24:	83b1                	srli	a5,a5,0xc
ffffffffc0202b26:	00094717          	auipc	a4,0x94
ffffffffc0202b2a:	d7a73703          	ld	a4,-646(a4) # ffffffffc02968a0 <npage>
ffffffffc0202b2e:	06e7f363          	bgeu	a5,a4,ffffffffc0202b94 <page_remove+0x98>
ffffffffc0202b32:	fff80537          	lui	a0,0xfff80
ffffffffc0202b36:	97aa                	add	a5,a5,a0
ffffffffc0202b38:	079a                	slli	a5,a5,0x6
ffffffffc0202b3a:	00094517          	auipc	a0,0x94
ffffffffc0202b3e:	d6e53503          	ld	a0,-658(a0) # ffffffffc02968a8 <pages>
ffffffffc0202b42:	953e                	add	a0,a0,a5
ffffffffc0202b44:	411c                	lw	a5,0(a0)
ffffffffc0202b46:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202b4a:	c118                	sw	a4,0(a0)
ffffffffc0202b4c:	cb11                	beqz	a4,ffffffffc0202b60 <page_remove+0x64>
ffffffffc0202b4e:	00043023          	sd	zero,0(s0)
ffffffffc0202b52:	12048073          	sfence.vma	s1
ffffffffc0202b56:	70a2                	ld	ra,40(sp)
ffffffffc0202b58:	7402                	ld	s0,32(sp)
ffffffffc0202b5a:	64e2                	ld	s1,24(sp)
ffffffffc0202b5c:	6145                	addi	sp,sp,48
ffffffffc0202b5e:	8082                	ret
ffffffffc0202b60:	100027f3          	csrr	a5,sstatus
ffffffffc0202b64:	8b89                	andi	a5,a5,2
ffffffffc0202b66:	eb89                	bnez	a5,ffffffffc0202b78 <page_remove+0x7c>
ffffffffc0202b68:	00094797          	auipc	a5,0x94
ffffffffc0202b6c:	d487b783          	ld	a5,-696(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b70:	739c                	ld	a5,32(a5)
ffffffffc0202b72:	4585                	li	a1,1
ffffffffc0202b74:	9782                	jalr	a5
ffffffffc0202b76:	bfe1                	j	ffffffffc0202b4e <page_remove+0x52>
ffffffffc0202b78:	e42a                	sd	a0,8(sp)
ffffffffc0202b7a:	8f8fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202b7e:	00094797          	auipc	a5,0x94
ffffffffc0202b82:	d327b783          	ld	a5,-718(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b86:	739c                	ld	a5,32(a5)
ffffffffc0202b88:	6522                	ld	a0,8(sp)
ffffffffc0202b8a:	4585                	li	a1,1
ffffffffc0202b8c:	9782                	jalr	a5
ffffffffc0202b8e:	8defe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202b92:	bf75                	j	ffffffffc0202b4e <page_remove+0x52>
ffffffffc0202b94:	da0ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202b98 <page_insert>:
ffffffffc0202b98:	7139                	addi	sp,sp,-64
ffffffffc0202b9a:	e852                	sd	s4,16(sp)
ffffffffc0202b9c:	8a32                	mv	s4,a2
ffffffffc0202b9e:	f822                	sd	s0,48(sp)
ffffffffc0202ba0:	4605                	li	a2,1
ffffffffc0202ba2:	842e                	mv	s0,a1
ffffffffc0202ba4:	85d2                	mv	a1,s4
ffffffffc0202ba6:	f426                	sd	s1,40(sp)
ffffffffc0202ba8:	fc06                	sd	ra,56(sp)
ffffffffc0202baa:	f04a                	sd	s2,32(sp)
ffffffffc0202bac:	ec4e                	sd	s3,24(sp)
ffffffffc0202bae:	e456                	sd	s5,8(sp)
ffffffffc0202bb0:	84b6                	mv	s1,a3
ffffffffc0202bb2:	e72ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202bb6:	c961                	beqz	a0,ffffffffc0202c86 <page_insert+0xee>
ffffffffc0202bb8:	4014                	lw	a3,0(s0)
ffffffffc0202bba:	611c                	ld	a5,0(a0)
ffffffffc0202bbc:	89aa                	mv	s3,a0
ffffffffc0202bbe:	0016871b          	addiw	a4,a3,1
ffffffffc0202bc2:	c018                	sw	a4,0(s0)
ffffffffc0202bc4:	0017f713          	andi	a4,a5,1
ffffffffc0202bc8:	ef05                	bnez	a4,ffffffffc0202c00 <page_insert+0x68>
ffffffffc0202bca:	00094717          	auipc	a4,0x94
ffffffffc0202bce:	cde73703          	ld	a4,-802(a4) # ffffffffc02968a8 <pages>
ffffffffc0202bd2:	8c19                	sub	s0,s0,a4
ffffffffc0202bd4:	000807b7          	lui	a5,0x80
ffffffffc0202bd8:	8419                	srai	s0,s0,0x6
ffffffffc0202bda:	943e                	add	s0,s0,a5
ffffffffc0202bdc:	042a                	slli	s0,s0,0xa
ffffffffc0202bde:	8cc1                	or	s1,s1,s0
ffffffffc0202be0:	0014e493          	ori	s1,s1,1
ffffffffc0202be4:	0099b023          	sd	s1,0(s3) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202be8:	120a0073          	sfence.vma	s4
ffffffffc0202bec:	4501                	li	a0,0
ffffffffc0202bee:	70e2                	ld	ra,56(sp)
ffffffffc0202bf0:	7442                	ld	s0,48(sp)
ffffffffc0202bf2:	74a2                	ld	s1,40(sp)
ffffffffc0202bf4:	7902                	ld	s2,32(sp)
ffffffffc0202bf6:	69e2                	ld	s3,24(sp)
ffffffffc0202bf8:	6a42                	ld	s4,16(sp)
ffffffffc0202bfa:	6aa2                	ld	s5,8(sp)
ffffffffc0202bfc:	6121                	addi	sp,sp,64
ffffffffc0202bfe:	8082                	ret
ffffffffc0202c00:	078a                	slli	a5,a5,0x2
ffffffffc0202c02:	83b1                	srli	a5,a5,0xc
ffffffffc0202c04:	00094717          	auipc	a4,0x94
ffffffffc0202c08:	c9c73703          	ld	a4,-868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202c0c:	06e7ff63          	bgeu	a5,a4,ffffffffc0202c8a <page_insert+0xf2>
ffffffffc0202c10:	00094a97          	auipc	s5,0x94
ffffffffc0202c14:	c98a8a93          	addi	s5,s5,-872 # ffffffffc02968a8 <pages>
ffffffffc0202c18:	000ab703          	ld	a4,0(s5)
ffffffffc0202c1c:	fff80937          	lui	s2,0xfff80
ffffffffc0202c20:	993e                	add	s2,s2,a5
ffffffffc0202c22:	091a                	slli	s2,s2,0x6
ffffffffc0202c24:	993a                	add	s2,s2,a4
ffffffffc0202c26:	01240c63          	beq	s0,s2,ffffffffc0202c3e <page_insert+0xa6>
ffffffffc0202c2a:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202c2e:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202c32:	00d92023          	sw	a3,0(s2)
ffffffffc0202c36:	c691                	beqz	a3,ffffffffc0202c42 <page_insert+0xaa>
ffffffffc0202c38:	120a0073          	sfence.vma	s4
ffffffffc0202c3c:	bf59                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c3e:	c014                	sw	a3,0(s0)
ffffffffc0202c40:	bf49                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c42:	100027f3          	csrr	a5,sstatus
ffffffffc0202c46:	8b89                	andi	a5,a5,2
ffffffffc0202c48:	ef91                	bnez	a5,ffffffffc0202c64 <page_insert+0xcc>
ffffffffc0202c4a:	00094797          	auipc	a5,0x94
ffffffffc0202c4e:	c667b783          	ld	a5,-922(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202c52:	739c                	ld	a5,32(a5)
ffffffffc0202c54:	4585                	li	a1,1
ffffffffc0202c56:	854a                	mv	a0,s2
ffffffffc0202c58:	9782                	jalr	a5
ffffffffc0202c5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202c5e:	120a0073          	sfence.vma	s4
ffffffffc0202c62:	bf85                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c64:	80efe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202c68:	00094797          	auipc	a5,0x94
ffffffffc0202c6c:	c487b783          	ld	a5,-952(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202c70:	739c                	ld	a5,32(a5)
ffffffffc0202c72:	4585                	li	a1,1
ffffffffc0202c74:	854a                	mv	a0,s2
ffffffffc0202c76:	9782                	jalr	a5
ffffffffc0202c78:	ff5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202c7c:	000ab703          	ld	a4,0(s5)
ffffffffc0202c80:	120a0073          	sfence.vma	s4
ffffffffc0202c84:	b7b9                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c86:	5571                	li	a0,-4
ffffffffc0202c88:	b79d                	j	ffffffffc0202bee <page_insert+0x56>
ffffffffc0202c8a:	caaff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202c8e <pmm_init>:
ffffffffc0202c8e:	0000a797          	auipc	a5,0xa
ffffffffc0202c92:	9b278793          	addi	a5,a5,-1614 # ffffffffc020c640 <default_pmm_manager>
ffffffffc0202c96:	638c                	ld	a1,0(a5)
ffffffffc0202c98:	7159                	addi	sp,sp,-112
ffffffffc0202c9a:	f85a                	sd	s6,48(sp)
ffffffffc0202c9c:	0000a517          	auipc	a0,0xa
ffffffffc0202ca0:	b9450513          	addi	a0,a0,-1132 # ffffffffc020c830 <default_pmm_manager+0x1f0>
ffffffffc0202ca4:	00094b17          	auipc	s6,0x94
ffffffffc0202ca8:	c0cb0b13          	addi	s6,s6,-1012 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202cac:	f486                	sd	ra,104(sp)
ffffffffc0202cae:	e8ca                	sd	s2,80(sp)
ffffffffc0202cb0:	e4ce                	sd	s3,72(sp)
ffffffffc0202cb2:	f0a2                	sd	s0,96(sp)
ffffffffc0202cb4:	eca6                	sd	s1,88(sp)
ffffffffc0202cb6:	e0d2                	sd	s4,64(sp)
ffffffffc0202cb8:	fc56                	sd	s5,56(sp)
ffffffffc0202cba:	f45e                	sd	s7,40(sp)
ffffffffc0202cbc:	f062                	sd	s8,32(sp)
ffffffffc0202cbe:	ec66                	sd	s9,24(sp)
ffffffffc0202cc0:	00fb3023          	sd	a5,0(s6)
ffffffffc0202cc4:	ce2fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc8:	000b3783          	ld	a5,0(s6)
ffffffffc0202ccc:	00094997          	auipc	s3,0x94
ffffffffc0202cd0:	bec98993          	addi	s3,s3,-1044 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202cd4:	679c                	ld	a5,8(a5)
ffffffffc0202cd6:	9782                	jalr	a5
ffffffffc0202cd8:	57f5                	li	a5,-3
ffffffffc0202cda:	07fa                	slli	a5,a5,0x1e
ffffffffc0202cdc:	00f9b023          	sd	a5,0(s3)
ffffffffc0202ce0:	d69fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202ce4:	892a                	mv	s2,a0
ffffffffc0202ce6:	d6dfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202cea:	280502e3          	beqz	a0,ffffffffc020376e <pmm_init+0xae0>
ffffffffc0202cee:	84aa                	mv	s1,a0
ffffffffc0202cf0:	0000a517          	auipc	a0,0xa
ffffffffc0202cf4:	b7850513          	addi	a0,a0,-1160 # ffffffffc020c868 <default_pmm_manager+0x228>
ffffffffc0202cf8:	caefd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cfc:	00990433          	add	s0,s2,s1
ffffffffc0202d00:	fff40693          	addi	a3,s0,-1
ffffffffc0202d04:	864a                	mv	a2,s2
ffffffffc0202d06:	85a6                	mv	a1,s1
ffffffffc0202d08:	0000a517          	auipc	a0,0xa
ffffffffc0202d0c:	b7850513          	addi	a0,a0,-1160 # ffffffffc020c880 <default_pmm_manager+0x240>
ffffffffc0202d10:	c96fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202d14:	c8000737          	lui	a4,0xc8000
ffffffffc0202d18:	87a2                	mv	a5,s0
ffffffffc0202d1a:	5e876e63          	bltu	a4,s0,ffffffffc0203316 <pmm_init+0x688>
ffffffffc0202d1e:	757d                	lui	a0,0xfffff
ffffffffc0202d20:	00095617          	auipc	a2,0x95
ffffffffc0202d24:	bef60613          	addi	a2,a2,-1041 # ffffffffc029790f <end+0xfff>
ffffffffc0202d28:	8e69                	and	a2,a2,a0
ffffffffc0202d2a:	00094497          	auipc	s1,0x94
ffffffffc0202d2e:	b7648493          	addi	s1,s1,-1162 # ffffffffc02968a0 <npage>
ffffffffc0202d32:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202d36:	00094b97          	auipc	s7,0x94
ffffffffc0202d3a:	b72b8b93          	addi	s7,s7,-1166 # ffffffffc02968a8 <pages>
ffffffffc0202d3e:	e088                	sd	a0,0(s1)
ffffffffc0202d40:	00cbb023          	sd	a2,0(s7)
ffffffffc0202d44:	000807b7          	lui	a5,0x80
ffffffffc0202d48:	86b2                	mv	a3,a2
ffffffffc0202d4a:	02f50863          	beq	a0,a5,ffffffffc0202d7a <pmm_init+0xec>
ffffffffc0202d4e:	4781                	li	a5,0
ffffffffc0202d50:	4585                	li	a1,1
ffffffffc0202d52:	fff806b7          	lui	a3,0xfff80
ffffffffc0202d56:	00679513          	slli	a0,a5,0x6
ffffffffc0202d5a:	9532                	add	a0,a0,a2
ffffffffc0202d5c:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202d60:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202d64:	6088                	ld	a0,0(s1)
ffffffffc0202d66:	0785                	addi	a5,a5,1
ffffffffc0202d68:	000bb603          	ld	a2,0(s7)
ffffffffc0202d6c:	00d50733          	add	a4,a0,a3
ffffffffc0202d70:	fee7e3e3          	bltu	a5,a4,ffffffffc0202d56 <pmm_init+0xc8>
ffffffffc0202d74:	071a                	slli	a4,a4,0x6
ffffffffc0202d76:	00e606b3          	add	a3,a2,a4
ffffffffc0202d7a:	c02007b7          	lui	a5,0xc0200
ffffffffc0202d7e:	3af6eae3          	bltu	a3,a5,ffffffffc0203932 <pmm_init+0xca4>
ffffffffc0202d82:	0009b583          	ld	a1,0(s3)
ffffffffc0202d86:	77fd                	lui	a5,0xfffff
ffffffffc0202d88:	8c7d                	and	s0,s0,a5
ffffffffc0202d8a:	8e8d                	sub	a3,a3,a1
ffffffffc0202d8c:	5e86e363          	bltu	a3,s0,ffffffffc0203372 <pmm_init+0x6e4>
ffffffffc0202d90:	0000a517          	auipc	a0,0xa
ffffffffc0202d94:	b1850513          	addi	a0,a0,-1256 # ffffffffc020c8a8 <default_pmm_manager+0x268>
ffffffffc0202d98:	c0efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202d9c:	000b3783          	ld	a5,0(s6)
ffffffffc0202da0:	7b9c                	ld	a5,48(a5)
ffffffffc0202da2:	9782                	jalr	a5
ffffffffc0202da4:	0000a517          	auipc	a0,0xa
ffffffffc0202da8:	b1c50513          	addi	a0,a0,-1252 # ffffffffc020c8c0 <default_pmm_manager+0x280>
ffffffffc0202dac:	bfafd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202db0:	100027f3          	csrr	a5,sstatus
ffffffffc0202db4:	8b89                	andi	a5,a5,2
ffffffffc0202db6:	5a079363          	bnez	a5,ffffffffc020335c <pmm_init+0x6ce>
ffffffffc0202dba:	000b3783          	ld	a5,0(s6)
ffffffffc0202dbe:	4505                	li	a0,1
ffffffffc0202dc0:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc2:	9782                	jalr	a5
ffffffffc0202dc4:	842a                	mv	s0,a0
ffffffffc0202dc6:	180408e3          	beqz	s0,ffffffffc0203756 <pmm_init+0xac8>
ffffffffc0202dca:	000bb683          	ld	a3,0(s7)
ffffffffc0202dce:	5a7d                	li	s4,-1
ffffffffc0202dd0:	6098                	ld	a4,0(s1)
ffffffffc0202dd2:	40d406b3          	sub	a3,s0,a3
ffffffffc0202dd6:	8699                	srai	a3,a3,0x6
ffffffffc0202dd8:	00080437          	lui	s0,0x80
ffffffffc0202ddc:	96a2                	add	a3,a3,s0
ffffffffc0202dde:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202de2:	8ff5                	and	a5,a5,a3
ffffffffc0202de4:	06b2                	slli	a3,a3,0xc
ffffffffc0202de6:	30e7fde3          	bgeu	a5,a4,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc0202dea:	0009b403          	ld	s0,0(s3)
ffffffffc0202dee:	6605                	lui	a2,0x1
ffffffffc0202df0:	4581                	li	a1,0
ffffffffc0202df2:	9436                	add	s0,s0,a3
ffffffffc0202df4:	8522                	mv	a0,s0
ffffffffc0202df6:	081080ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0202dfa:	0009b683          	ld	a3,0(s3)
ffffffffc0202dfe:	77fd                	lui	a5,0xfffff
ffffffffc0202e00:	0000a917          	auipc	s2,0xa
ffffffffc0202e04:	8df90913          	addi	s2,s2,-1825 # ffffffffc020c6df <default_pmm_manager+0x9f>
ffffffffc0202e08:	00f97933          	and	s2,s2,a5
ffffffffc0202e0c:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202e10:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202e14:	964a                	add	a2,a2,s2
ffffffffc0202e16:	4729                	li	a4,10
ffffffffc0202e18:	40da86b3          	sub	a3,s5,a3
ffffffffc0202e1c:	c02005b7          	lui	a1,0xc0200
ffffffffc0202e20:	8522                	mv	a0,s0
ffffffffc0202e22:	e2aff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202e26:	c8000637          	lui	a2,0xc8000
ffffffffc0202e2a:	41260633          	sub	a2,a2,s2
ffffffffc0202e2e:	3f596ce3          	bltu	s2,s5,ffffffffc0203a26 <pmm_init+0xd98>
ffffffffc0202e32:	0009b683          	ld	a3,0(s3)
ffffffffc0202e36:	85ca                	mv	a1,s2
ffffffffc0202e38:	4719                	li	a4,6
ffffffffc0202e3a:	40d906b3          	sub	a3,s2,a3
ffffffffc0202e3e:	8522                	mv	a0,s0
ffffffffc0202e40:	00094917          	auipc	s2,0x94
ffffffffc0202e44:	a5890913          	addi	s2,s2,-1448 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202e48:	e04ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202e4c:	00893023          	sd	s0,0(s2)
ffffffffc0202e50:	2d5464e3          	bltu	s0,s5,ffffffffc0203918 <pmm_init+0xc8a>
ffffffffc0202e54:	0009b783          	ld	a5,0(s3)
ffffffffc0202e58:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202e5a:	8c1d                	sub	s0,s0,a5
ffffffffc0202e5c:	00c45793          	srli	a5,s0,0xc
ffffffffc0202e60:	00094717          	auipc	a4,0x94
ffffffffc0202e64:	a2873823          	sd	s0,-1488(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202e68:	0147ea33          	or	s4,a5,s4
ffffffffc0202e6c:	180a1073          	csrw	satp,s4
ffffffffc0202e70:	12000073          	sfence.vma
ffffffffc0202e74:	0000a517          	auipc	a0,0xa
ffffffffc0202e78:	a8c50513          	addi	a0,a0,-1396 # ffffffffc020c900 <default_pmm_manager+0x2c0>
ffffffffc0202e7c:	b2afd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202e80:	0000e717          	auipc	a4,0xe
ffffffffc0202e84:	18070713          	addi	a4,a4,384 # ffffffffc0211000 <bootstack>
ffffffffc0202e88:	0000e797          	auipc	a5,0xe
ffffffffc0202e8c:	17878793          	addi	a5,a5,376 # ffffffffc0211000 <bootstack>
ffffffffc0202e90:	5cf70d63          	beq	a4,a5,ffffffffc020346a <pmm_init+0x7dc>
ffffffffc0202e94:	100027f3          	csrr	a5,sstatus
ffffffffc0202e98:	8b89                	andi	a5,a5,2
ffffffffc0202e9a:	4a079763          	bnez	a5,ffffffffc0203348 <pmm_init+0x6ba>
ffffffffc0202e9e:	000b3783          	ld	a5,0(s6)
ffffffffc0202ea2:	779c                	ld	a5,40(a5)
ffffffffc0202ea4:	9782                	jalr	a5
ffffffffc0202ea6:	842a                	mv	s0,a0
ffffffffc0202ea8:	6098                	ld	a4,0(s1)
ffffffffc0202eaa:	c80007b7          	lui	a5,0xc8000
ffffffffc0202eae:	83b1                	srli	a5,a5,0xc
ffffffffc0202eb0:	08e7e3e3          	bltu	a5,a4,ffffffffc0203736 <pmm_init+0xaa8>
ffffffffc0202eb4:	00093503          	ld	a0,0(s2)
ffffffffc0202eb8:	04050fe3          	beqz	a0,ffffffffc0203716 <pmm_init+0xa88>
ffffffffc0202ebc:	03451793          	slli	a5,a0,0x34
ffffffffc0202ec0:	04079be3          	bnez	a5,ffffffffc0203716 <pmm_init+0xa88>
ffffffffc0202ec4:	4601                	li	a2,0
ffffffffc0202ec6:	4581                	li	a1,0
ffffffffc0202ec8:	e4aff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202ecc:	2e0511e3          	bnez	a0,ffffffffc02039ae <pmm_init+0xd20>
ffffffffc0202ed0:	100027f3          	csrr	a5,sstatus
ffffffffc0202ed4:	8b89                	andi	a5,a5,2
ffffffffc0202ed6:	44079e63          	bnez	a5,ffffffffc0203332 <pmm_init+0x6a4>
ffffffffc0202eda:	000b3783          	ld	a5,0(s6)
ffffffffc0202ede:	4505                	li	a0,1
ffffffffc0202ee0:	6f9c                	ld	a5,24(a5)
ffffffffc0202ee2:	9782                	jalr	a5
ffffffffc0202ee4:	8a2a                	mv	s4,a0
ffffffffc0202ee6:	00093503          	ld	a0,0(s2)
ffffffffc0202eea:	4681                	li	a3,0
ffffffffc0202eec:	4601                	li	a2,0
ffffffffc0202eee:	85d2                	mv	a1,s4
ffffffffc0202ef0:	ca9ff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0202ef4:	26051be3          	bnez	a0,ffffffffc020396a <pmm_init+0xcdc>
ffffffffc0202ef8:	00093503          	ld	a0,0(s2)
ffffffffc0202efc:	4601                	li	a2,0
ffffffffc0202efe:	4581                	li	a1,0
ffffffffc0202f00:	b24ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202f04:	280505e3          	beqz	a0,ffffffffc020398e <pmm_init+0xd00>
ffffffffc0202f08:	611c                	ld	a5,0(a0)
ffffffffc0202f0a:	0017f713          	andi	a4,a5,1
ffffffffc0202f0e:	26070ee3          	beqz	a4,ffffffffc020398a <pmm_init+0xcfc>
ffffffffc0202f12:	6098                	ld	a4,0(s1)
ffffffffc0202f14:	078a                	slli	a5,a5,0x2
ffffffffc0202f16:	83b1                	srli	a5,a5,0xc
ffffffffc0202f18:	62e7f363          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0202f1c:	000bb683          	ld	a3,0(s7)
ffffffffc0202f20:	fff80637          	lui	a2,0xfff80
ffffffffc0202f24:	97b2                	add	a5,a5,a2
ffffffffc0202f26:	079a                	slli	a5,a5,0x6
ffffffffc0202f28:	97b6                	add	a5,a5,a3
ffffffffc0202f2a:	2afa12e3          	bne	s4,a5,ffffffffc02039ce <pmm_init+0xd40>
ffffffffc0202f2e:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202f32:	4785                	li	a5,1
ffffffffc0202f34:	2cf699e3          	bne	a3,a5,ffffffffc0203a06 <pmm_init+0xd78>
ffffffffc0202f38:	00093503          	ld	a0,0(s2)
ffffffffc0202f3c:	77fd                	lui	a5,0xfffff
ffffffffc0202f3e:	6114                	ld	a3,0(a0)
ffffffffc0202f40:	068a                	slli	a3,a3,0x2
ffffffffc0202f42:	8efd                	and	a3,a3,a5
ffffffffc0202f44:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202f48:	2ae673e3          	bgeu	a2,a4,ffffffffc02039ee <pmm_init+0xd60>
ffffffffc0202f4c:	0009bc03          	ld	s8,0(s3)
ffffffffc0202f50:	96e2                	add	a3,a3,s8
ffffffffc0202f52:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202f56:	0a8a                	slli	s5,s5,0x2
ffffffffc0202f58:	00fafab3          	and	s5,s5,a5
ffffffffc0202f5c:	00cad793          	srli	a5,s5,0xc
ffffffffc0202f60:	06e7f3e3          	bgeu	a5,a4,ffffffffc02037c6 <pmm_init+0xb38>
ffffffffc0202f64:	4601                	li	a2,0
ffffffffc0202f66:	6585                	lui	a1,0x1
ffffffffc0202f68:	9ae2                	add	s5,s5,s8
ffffffffc0202f6a:	abaff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202f6e:	0aa1                	addi	s5,s5,8
ffffffffc0202f70:	03551be3          	bne	a0,s5,ffffffffc02037a6 <pmm_init+0xb18>
ffffffffc0202f74:	100027f3          	csrr	a5,sstatus
ffffffffc0202f78:	8b89                	andi	a5,a5,2
ffffffffc0202f7a:	3a079163          	bnez	a5,ffffffffc020331c <pmm_init+0x68e>
ffffffffc0202f7e:	000b3783          	ld	a5,0(s6)
ffffffffc0202f82:	4505                	li	a0,1
ffffffffc0202f84:	6f9c                	ld	a5,24(a5)
ffffffffc0202f86:	9782                	jalr	a5
ffffffffc0202f88:	8c2a                	mv	s8,a0
ffffffffc0202f8a:	00093503          	ld	a0,0(s2)
ffffffffc0202f8e:	46d1                	li	a3,20
ffffffffc0202f90:	6605                	lui	a2,0x1
ffffffffc0202f92:	85e2                	mv	a1,s8
ffffffffc0202f94:	c05ff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0202f98:	1a0519e3          	bnez	a0,ffffffffc020394a <pmm_init+0xcbc>
ffffffffc0202f9c:	00093503          	ld	a0,0(s2)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	6585                	lui	a1,0x1
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	10050ce3          	beqz	a0,ffffffffc02038c0 <pmm_init+0xc32>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	0107f713          	andi	a4,a5,16
ffffffffc0202fb2:	0e0707e3          	beqz	a4,ffffffffc02038a0 <pmm_init+0xc12>
ffffffffc0202fb6:	8b91                	andi	a5,a5,4
ffffffffc0202fb8:	0c0784e3          	beqz	a5,ffffffffc0203880 <pmm_init+0xbf2>
ffffffffc0202fbc:	00093503          	ld	a0,0(s2)
ffffffffc0202fc0:	611c                	ld	a5,0(a0)
ffffffffc0202fc2:	8bc1                	andi	a5,a5,16
ffffffffc0202fc4:	08078ee3          	beqz	a5,ffffffffc0203860 <pmm_init+0xbd2>
ffffffffc0202fc8:	000c2703          	lw	a4,0(s8)
ffffffffc0202fcc:	4785                	li	a5,1
ffffffffc0202fce:	06f719e3          	bne	a4,a5,ffffffffc0203840 <pmm_init+0xbb2>
ffffffffc0202fd2:	4681                	li	a3,0
ffffffffc0202fd4:	6605                	lui	a2,0x1
ffffffffc0202fd6:	85d2                	mv	a1,s4
ffffffffc0202fd8:	bc1ff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0202fdc:	040512e3          	bnez	a0,ffffffffc0203820 <pmm_init+0xb92>
ffffffffc0202fe0:	000a2703          	lw	a4,0(s4)
ffffffffc0202fe4:	4789                	li	a5,2
ffffffffc0202fe6:	00f71de3          	bne	a4,a5,ffffffffc0203800 <pmm_init+0xb72>
ffffffffc0202fea:	000c2783          	lw	a5,0(s8)
ffffffffc0202fee:	7e079963          	bnez	a5,ffffffffc02037e0 <pmm_init+0xb52>
ffffffffc0202ff2:	00093503          	ld	a0,0(s2)
ffffffffc0202ff6:	4601                	li	a2,0
ffffffffc0202ff8:	6585                	lui	a1,0x1
ffffffffc0202ffa:	a2aff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202ffe:	54050263          	beqz	a0,ffffffffc0203542 <pmm_init+0x8b4>
ffffffffc0203002:	6118                	ld	a4,0(a0)
ffffffffc0203004:	00177793          	andi	a5,a4,1
ffffffffc0203008:	180781e3          	beqz	a5,ffffffffc020398a <pmm_init+0xcfc>
ffffffffc020300c:	6094                	ld	a3,0(s1)
ffffffffc020300e:	00271793          	slli	a5,a4,0x2
ffffffffc0203012:	83b1                	srli	a5,a5,0xc
ffffffffc0203014:	52d7f563          	bgeu	a5,a3,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203018:	000bb683          	ld	a3,0(s7)
ffffffffc020301c:	fff80ab7          	lui	s5,0xfff80
ffffffffc0203020:	97d6                	add	a5,a5,s5
ffffffffc0203022:	079a                	slli	a5,a5,0x6
ffffffffc0203024:	97b6                	add	a5,a5,a3
ffffffffc0203026:	58fa1e63          	bne	s4,a5,ffffffffc02035c2 <pmm_init+0x934>
ffffffffc020302a:	8b41                	andi	a4,a4,16
ffffffffc020302c:	56071b63          	bnez	a4,ffffffffc02035a2 <pmm_init+0x914>
ffffffffc0203030:	00093503          	ld	a0,0(s2)
ffffffffc0203034:	4581                	li	a1,0
ffffffffc0203036:	ac7ff0ef          	jal	ra,ffffffffc0202afc <page_remove>
ffffffffc020303a:	000a2c83          	lw	s9,0(s4)
ffffffffc020303e:	4785                	li	a5,1
ffffffffc0203040:	5cfc9163          	bne	s9,a5,ffffffffc0203602 <pmm_init+0x974>
ffffffffc0203044:	000c2783          	lw	a5,0(s8)
ffffffffc0203048:	58079d63          	bnez	a5,ffffffffc02035e2 <pmm_init+0x954>
ffffffffc020304c:	00093503          	ld	a0,0(s2)
ffffffffc0203050:	6585                	lui	a1,0x1
ffffffffc0203052:	aabff0ef          	jal	ra,ffffffffc0202afc <page_remove>
ffffffffc0203056:	000a2783          	lw	a5,0(s4)
ffffffffc020305a:	200793e3          	bnez	a5,ffffffffc0203a60 <pmm_init+0xdd2>
ffffffffc020305e:	000c2783          	lw	a5,0(s8)
ffffffffc0203062:	1c079fe3          	bnez	a5,ffffffffc0203a40 <pmm_init+0xdb2>
ffffffffc0203066:	00093a03          	ld	s4,0(s2)
ffffffffc020306a:	608c                	ld	a1,0(s1)
ffffffffc020306c:	000a3683          	ld	a3,0(s4)
ffffffffc0203070:	068a                	slli	a3,a3,0x2
ffffffffc0203072:	82b1                	srli	a3,a3,0xc
ffffffffc0203074:	4cb6f563          	bgeu	a3,a1,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203078:	000bb503          	ld	a0,0(s7)
ffffffffc020307c:	96d6                	add	a3,a3,s5
ffffffffc020307e:	069a                	slli	a3,a3,0x6
ffffffffc0203080:	00d507b3          	add	a5,a0,a3
ffffffffc0203084:	439c                	lw	a5,0(a5)
ffffffffc0203086:	4f979e63          	bne	a5,s9,ffffffffc0203582 <pmm_init+0x8f4>
ffffffffc020308a:	8699                	srai	a3,a3,0x6
ffffffffc020308c:	00080637          	lui	a2,0x80
ffffffffc0203090:	96b2                	add	a3,a3,a2
ffffffffc0203092:	00c69713          	slli	a4,a3,0xc
ffffffffc0203096:	8331                	srli	a4,a4,0xc
ffffffffc0203098:	06b2                	slli	a3,a3,0xc
ffffffffc020309a:	06b773e3          	bgeu	a4,a1,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc020309e:	0009b703          	ld	a4,0(s3)
ffffffffc02030a2:	96ba                	add	a3,a3,a4
ffffffffc02030a4:	629c                	ld	a5,0(a3)
ffffffffc02030a6:	078a                	slli	a5,a5,0x2
ffffffffc02030a8:	83b1                	srli	a5,a5,0xc
ffffffffc02030aa:	48b7fa63          	bgeu	a5,a1,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc02030ae:	8f91                	sub	a5,a5,a2
ffffffffc02030b0:	079a                	slli	a5,a5,0x6
ffffffffc02030b2:	953e                	add	a0,a0,a5
ffffffffc02030b4:	100027f3          	csrr	a5,sstatus
ffffffffc02030b8:	8b89                	andi	a5,a5,2
ffffffffc02030ba:	32079463          	bnez	a5,ffffffffc02033e2 <pmm_init+0x754>
ffffffffc02030be:	000b3783          	ld	a5,0(s6)
ffffffffc02030c2:	4585                	li	a1,1
ffffffffc02030c4:	739c                	ld	a5,32(a5)
ffffffffc02030c6:	9782                	jalr	a5
ffffffffc02030c8:	000a3783          	ld	a5,0(s4)
ffffffffc02030cc:	6098                	ld	a4,0(s1)
ffffffffc02030ce:	078a                	slli	a5,a5,0x2
ffffffffc02030d0:	83b1                	srli	a5,a5,0xc
ffffffffc02030d2:	46e7f663          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc02030d6:	000bb503          	ld	a0,0(s7)
ffffffffc02030da:	fff80737          	lui	a4,0xfff80
ffffffffc02030de:	97ba                	add	a5,a5,a4
ffffffffc02030e0:	079a                	slli	a5,a5,0x6
ffffffffc02030e2:	953e                	add	a0,a0,a5
ffffffffc02030e4:	100027f3          	csrr	a5,sstatus
ffffffffc02030e8:	8b89                	andi	a5,a5,2
ffffffffc02030ea:	2e079063          	bnez	a5,ffffffffc02033ca <pmm_init+0x73c>
ffffffffc02030ee:	000b3783          	ld	a5,0(s6)
ffffffffc02030f2:	4585                	li	a1,1
ffffffffc02030f4:	739c                	ld	a5,32(a5)
ffffffffc02030f6:	9782                	jalr	a5
ffffffffc02030f8:	00093783          	ld	a5,0(s2)
ffffffffc02030fc:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203100:	12000073          	sfence.vma
ffffffffc0203104:	100027f3          	csrr	a5,sstatus
ffffffffc0203108:	8b89                	andi	a5,a5,2
ffffffffc020310a:	2a079663          	bnez	a5,ffffffffc02033b6 <pmm_init+0x728>
ffffffffc020310e:	000b3783          	ld	a5,0(s6)
ffffffffc0203112:	779c                	ld	a5,40(a5)
ffffffffc0203114:	9782                	jalr	a5
ffffffffc0203116:	8a2a                	mv	s4,a0
ffffffffc0203118:	7d441463          	bne	s0,s4,ffffffffc02038e0 <pmm_init+0xc52>
ffffffffc020311c:	0000a517          	auipc	a0,0xa
ffffffffc0203120:	b3c50513          	addi	a0,a0,-1220 # ffffffffc020cc58 <default_pmm_manager+0x618>
ffffffffc0203124:	882fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203128:	100027f3          	csrr	a5,sstatus
ffffffffc020312c:	8b89                	andi	a5,a5,2
ffffffffc020312e:	26079a63          	bnez	a5,ffffffffc02033a2 <pmm_init+0x714>
ffffffffc0203132:	000b3783          	ld	a5,0(s6)
ffffffffc0203136:	779c                	ld	a5,40(a5)
ffffffffc0203138:	9782                	jalr	a5
ffffffffc020313a:	8c2a                	mv	s8,a0
ffffffffc020313c:	6098                	ld	a4,0(s1)
ffffffffc020313e:	c0200437          	lui	s0,0xc0200
ffffffffc0203142:	7afd                	lui	s5,0xfffff
ffffffffc0203144:	00c71793          	slli	a5,a4,0xc
ffffffffc0203148:	6a05                	lui	s4,0x1
ffffffffc020314a:	02f47c63          	bgeu	s0,a5,ffffffffc0203182 <pmm_init+0x4f4>
ffffffffc020314e:	00c45793          	srli	a5,s0,0xc
ffffffffc0203152:	00093503          	ld	a0,0(s2)
ffffffffc0203156:	3ae7f763          	bgeu	a5,a4,ffffffffc0203504 <pmm_init+0x876>
ffffffffc020315a:	0009b583          	ld	a1,0(s3)
ffffffffc020315e:	4601                	li	a2,0
ffffffffc0203160:	95a2                	add	a1,a1,s0
ffffffffc0203162:	8c2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0203166:	36050f63          	beqz	a0,ffffffffc02034e4 <pmm_init+0x856>
ffffffffc020316a:	611c                	ld	a5,0(a0)
ffffffffc020316c:	078a                	slli	a5,a5,0x2
ffffffffc020316e:	0157f7b3          	and	a5,a5,s5
ffffffffc0203172:	3a879663          	bne	a5,s0,ffffffffc020351e <pmm_init+0x890>
ffffffffc0203176:	6098                	ld	a4,0(s1)
ffffffffc0203178:	9452                	add	s0,s0,s4
ffffffffc020317a:	00c71793          	slli	a5,a4,0xc
ffffffffc020317e:	fcf468e3          	bltu	s0,a5,ffffffffc020314e <pmm_init+0x4c0>
ffffffffc0203182:	00093783          	ld	a5,0(s2)
ffffffffc0203186:	639c                	ld	a5,0(a5)
ffffffffc0203188:	48079d63          	bnez	a5,ffffffffc0203622 <pmm_init+0x994>
ffffffffc020318c:	100027f3          	csrr	a5,sstatus
ffffffffc0203190:	8b89                	andi	a5,a5,2
ffffffffc0203192:	26079463          	bnez	a5,ffffffffc02033fa <pmm_init+0x76c>
ffffffffc0203196:	000b3783          	ld	a5,0(s6)
ffffffffc020319a:	4505                	li	a0,1
ffffffffc020319c:	6f9c                	ld	a5,24(a5)
ffffffffc020319e:	9782                	jalr	a5
ffffffffc02031a0:	8a2a                	mv	s4,a0
ffffffffc02031a2:	00093503          	ld	a0,0(s2)
ffffffffc02031a6:	4699                	li	a3,6
ffffffffc02031a8:	10000613          	li	a2,256
ffffffffc02031ac:	85d2                	mv	a1,s4
ffffffffc02031ae:	9ebff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc02031b2:	4a051863          	bnez	a0,ffffffffc0203662 <pmm_init+0x9d4>
ffffffffc02031b6:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc02031ba:	4785                	li	a5,1
ffffffffc02031bc:	48f71363          	bne	a4,a5,ffffffffc0203642 <pmm_init+0x9b4>
ffffffffc02031c0:	00093503          	ld	a0,0(s2)
ffffffffc02031c4:	6405                	lui	s0,0x1
ffffffffc02031c6:	4699                	li	a3,6
ffffffffc02031c8:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc02031cc:	85d2                	mv	a1,s4
ffffffffc02031ce:	9cbff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc02031d2:	38051863          	bnez	a0,ffffffffc0203562 <pmm_init+0x8d4>
ffffffffc02031d6:	000a2703          	lw	a4,0(s4)
ffffffffc02031da:	4789                	li	a5,2
ffffffffc02031dc:	4ef71363          	bne	a4,a5,ffffffffc02036c2 <pmm_init+0xa34>
ffffffffc02031e0:	0000a597          	auipc	a1,0xa
ffffffffc02031e4:	bc058593          	addi	a1,a1,-1088 # ffffffffc020cda0 <default_pmm_manager+0x760>
ffffffffc02031e8:	10000513          	li	a0,256
ffffffffc02031ec:	41e080ef          	jal	ra,ffffffffc020b60a <strcpy>
ffffffffc02031f0:	10040593          	addi	a1,s0,256
ffffffffc02031f4:	10000513          	li	a0,256
ffffffffc02031f8:	424080ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc02031fc:	4a051363          	bnez	a0,ffffffffc02036a2 <pmm_init+0xa14>
ffffffffc0203200:	000bb683          	ld	a3,0(s7)
ffffffffc0203204:	00080737          	lui	a4,0x80
ffffffffc0203208:	547d                	li	s0,-1
ffffffffc020320a:	40da06b3          	sub	a3,s4,a3
ffffffffc020320e:	8699                	srai	a3,a3,0x6
ffffffffc0203210:	609c                	ld	a5,0(s1)
ffffffffc0203212:	96ba                	add	a3,a3,a4
ffffffffc0203214:	8031                	srli	s0,s0,0xc
ffffffffc0203216:	0086f733          	and	a4,a3,s0
ffffffffc020321a:	06b2                	slli	a3,a3,0xc
ffffffffc020321c:	6ef77263          	bgeu	a4,a5,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc0203220:	0009b783          	ld	a5,0(s3)
ffffffffc0203224:	10000513          	li	a0,256
ffffffffc0203228:	96be                	add	a3,a3,a5
ffffffffc020322a:	10068023          	sb	zero,256(a3)
ffffffffc020322e:	3a6080ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc0203232:	44051863          	bnez	a0,ffffffffc0203682 <pmm_init+0x9f4>
ffffffffc0203236:	00093a83          	ld	s5,0(s2)
ffffffffc020323a:	609c                	ld	a5,0(s1)
ffffffffc020323c:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203240:	068a                	slli	a3,a3,0x2
ffffffffc0203242:	82b1                	srli	a3,a3,0xc
ffffffffc0203244:	2ef6fd63          	bgeu	a3,a5,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203248:	8c75                	and	s0,s0,a3
ffffffffc020324a:	06b2                	slli	a3,a3,0xc
ffffffffc020324c:	6af47a63          	bgeu	s0,a5,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc0203250:	0009b403          	ld	s0,0(s3)
ffffffffc0203254:	9436                	add	s0,s0,a3
ffffffffc0203256:	100027f3          	csrr	a5,sstatus
ffffffffc020325a:	8b89                	andi	a5,a5,2
ffffffffc020325c:	1e079c63          	bnez	a5,ffffffffc0203454 <pmm_init+0x7c6>
ffffffffc0203260:	000b3783          	ld	a5,0(s6)
ffffffffc0203264:	4585                	li	a1,1
ffffffffc0203266:	8552                	mv	a0,s4
ffffffffc0203268:	739c                	ld	a5,32(a5)
ffffffffc020326a:	9782                	jalr	a5
ffffffffc020326c:	601c                	ld	a5,0(s0)
ffffffffc020326e:	6098                	ld	a4,0(s1)
ffffffffc0203270:	078a                	slli	a5,a5,0x2
ffffffffc0203272:	83b1                	srli	a5,a5,0xc
ffffffffc0203274:	2ce7f563          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203278:	000bb503          	ld	a0,0(s7)
ffffffffc020327c:	fff80737          	lui	a4,0xfff80
ffffffffc0203280:	97ba                	add	a5,a5,a4
ffffffffc0203282:	079a                	slli	a5,a5,0x6
ffffffffc0203284:	953e                	add	a0,a0,a5
ffffffffc0203286:	100027f3          	csrr	a5,sstatus
ffffffffc020328a:	8b89                	andi	a5,a5,2
ffffffffc020328c:	1a079863          	bnez	a5,ffffffffc020343c <pmm_init+0x7ae>
ffffffffc0203290:	000b3783          	ld	a5,0(s6)
ffffffffc0203294:	4585                	li	a1,1
ffffffffc0203296:	739c                	ld	a5,32(a5)
ffffffffc0203298:	9782                	jalr	a5
ffffffffc020329a:	000ab783          	ld	a5,0(s5)
ffffffffc020329e:	6098                	ld	a4,0(s1)
ffffffffc02032a0:	078a                	slli	a5,a5,0x2
ffffffffc02032a2:	83b1                	srli	a5,a5,0xc
ffffffffc02032a4:	28e7fd63          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc02032a8:	000bb503          	ld	a0,0(s7)
ffffffffc02032ac:	fff80737          	lui	a4,0xfff80
ffffffffc02032b0:	97ba                	add	a5,a5,a4
ffffffffc02032b2:	079a                	slli	a5,a5,0x6
ffffffffc02032b4:	953e                	add	a0,a0,a5
ffffffffc02032b6:	100027f3          	csrr	a5,sstatus
ffffffffc02032ba:	8b89                	andi	a5,a5,2
ffffffffc02032bc:	16079463          	bnez	a5,ffffffffc0203424 <pmm_init+0x796>
ffffffffc02032c0:	000b3783          	ld	a5,0(s6)
ffffffffc02032c4:	4585                	li	a1,1
ffffffffc02032c6:	739c                	ld	a5,32(a5)
ffffffffc02032c8:	9782                	jalr	a5
ffffffffc02032ca:	00093783          	ld	a5,0(s2)
ffffffffc02032ce:	0007b023          	sd	zero,0(a5)
ffffffffc02032d2:	12000073          	sfence.vma
ffffffffc02032d6:	100027f3          	csrr	a5,sstatus
ffffffffc02032da:	8b89                	andi	a5,a5,2
ffffffffc02032dc:	12079a63          	bnez	a5,ffffffffc0203410 <pmm_init+0x782>
ffffffffc02032e0:	000b3783          	ld	a5,0(s6)
ffffffffc02032e4:	779c                	ld	a5,40(a5)
ffffffffc02032e6:	9782                	jalr	a5
ffffffffc02032e8:	842a                	mv	s0,a0
ffffffffc02032ea:	488c1e63          	bne	s8,s0,ffffffffc0203786 <pmm_init+0xaf8>
ffffffffc02032ee:	0000a517          	auipc	a0,0xa
ffffffffc02032f2:	b2a50513          	addi	a0,a0,-1238 # ffffffffc020ce18 <default_pmm_manager+0x7d8>
ffffffffc02032f6:	eb1fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02032fa:	7406                	ld	s0,96(sp)
ffffffffc02032fc:	70a6                	ld	ra,104(sp)
ffffffffc02032fe:	64e6                	ld	s1,88(sp)
ffffffffc0203300:	6946                	ld	s2,80(sp)
ffffffffc0203302:	69a6                	ld	s3,72(sp)
ffffffffc0203304:	6a06                	ld	s4,64(sp)
ffffffffc0203306:	7ae2                	ld	s5,56(sp)
ffffffffc0203308:	7b42                	ld	s6,48(sp)
ffffffffc020330a:	7ba2                	ld	s7,40(sp)
ffffffffc020330c:	7c02                	ld	s8,32(sp)
ffffffffc020330e:	6ce2                	ld	s9,24(sp)
ffffffffc0203310:	6165                	addi	sp,sp,112
ffffffffc0203312:	c59fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203316:	c80007b7          	lui	a5,0xc8000
ffffffffc020331a:	b411                	j	ffffffffc0202d1e <pmm_init+0x90>
ffffffffc020331c:	957fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203320:	000b3783          	ld	a5,0(s6)
ffffffffc0203324:	4505                	li	a0,1
ffffffffc0203326:	6f9c                	ld	a5,24(a5)
ffffffffc0203328:	9782                	jalr	a5
ffffffffc020332a:	8c2a                	mv	s8,a0
ffffffffc020332c:	941fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203330:	b9a9                	j	ffffffffc0202f8a <pmm_init+0x2fc>
ffffffffc0203332:	941fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203336:	000b3783          	ld	a5,0(s6)
ffffffffc020333a:	4505                	li	a0,1
ffffffffc020333c:	6f9c                	ld	a5,24(a5)
ffffffffc020333e:	9782                	jalr	a5
ffffffffc0203340:	8a2a                	mv	s4,a0
ffffffffc0203342:	92bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203346:	b645                	j	ffffffffc0202ee6 <pmm_init+0x258>
ffffffffc0203348:	92bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020334c:	000b3783          	ld	a5,0(s6)
ffffffffc0203350:	779c                	ld	a5,40(a5)
ffffffffc0203352:	9782                	jalr	a5
ffffffffc0203354:	842a                	mv	s0,a0
ffffffffc0203356:	917fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020335a:	b6b9                	j	ffffffffc0202ea8 <pmm_init+0x21a>
ffffffffc020335c:	917fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203360:	000b3783          	ld	a5,0(s6)
ffffffffc0203364:	4505                	li	a0,1
ffffffffc0203366:	6f9c                	ld	a5,24(a5)
ffffffffc0203368:	9782                	jalr	a5
ffffffffc020336a:	842a                	mv	s0,a0
ffffffffc020336c:	901fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203370:	bc99                	j	ffffffffc0202dc6 <pmm_init+0x138>
ffffffffc0203372:	6705                	lui	a4,0x1
ffffffffc0203374:	177d                	addi	a4,a4,-1
ffffffffc0203376:	96ba                	add	a3,a3,a4
ffffffffc0203378:	8ff5                	and	a5,a5,a3
ffffffffc020337a:	00c7d713          	srli	a4,a5,0xc
ffffffffc020337e:	1ca77063          	bgeu	a4,a0,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203382:	000b3683          	ld	a3,0(s6)
ffffffffc0203386:	fff80537          	lui	a0,0xfff80
ffffffffc020338a:	972a                	add	a4,a4,a0
ffffffffc020338c:	6a94                	ld	a3,16(a3)
ffffffffc020338e:	8c1d                	sub	s0,s0,a5
ffffffffc0203390:	00671513          	slli	a0,a4,0x6
ffffffffc0203394:	00c45593          	srli	a1,s0,0xc
ffffffffc0203398:	9532                	add	a0,a0,a2
ffffffffc020339a:	9682                	jalr	a3
ffffffffc020339c:	0009b583          	ld	a1,0(s3)
ffffffffc02033a0:	bac5                	j	ffffffffc0202d90 <pmm_init+0x102>
ffffffffc02033a2:	8d1fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033a6:	000b3783          	ld	a5,0(s6)
ffffffffc02033aa:	779c                	ld	a5,40(a5)
ffffffffc02033ac:	9782                	jalr	a5
ffffffffc02033ae:	8c2a                	mv	s8,a0
ffffffffc02033b0:	8bdfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033b4:	b361                	j	ffffffffc020313c <pmm_init+0x4ae>
ffffffffc02033b6:	8bdfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033ba:	000b3783          	ld	a5,0(s6)
ffffffffc02033be:	779c                	ld	a5,40(a5)
ffffffffc02033c0:	9782                	jalr	a5
ffffffffc02033c2:	8a2a                	mv	s4,a0
ffffffffc02033c4:	8a9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033c8:	bb81                	j	ffffffffc0203118 <pmm_init+0x48a>
ffffffffc02033ca:	e42a                	sd	a0,8(sp)
ffffffffc02033cc:	8a7fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033d0:	000b3783          	ld	a5,0(s6)
ffffffffc02033d4:	6522                	ld	a0,8(sp)
ffffffffc02033d6:	4585                	li	a1,1
ffffffffc02033d8:	739c                	ld	a5,32(a5)
ffffffffc02033da:	9782                	jalr	a5
ffffffffc02033dc:	891fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033e0:	bb21                	j	ffffffffc02030f8 <pmm_init+0x46a>
ffffffffc02033e2:	e42a                	sd	a0,8(sp)
ffffffffc02033e4:	88ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033e8:	000b3783          	ld	a5,0(s6)
ffffffffc02033ec:	6522                	ld	a0,8(sp)
ffffffffc02033ee:	4585                	li	a1,1
ffffffffc02033f0:	739c                	ld	a5,32(a5)
ffffffffc02033f2:	9782                	jalr	a5
ffffffffc02033f4:	879fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033f8:	b9c1                	j	ffffffffc02030c8 <pmm_init+0x43a>
ffffffffc02033fa:	879fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033fe:	000b3783          	ld	a5,0(s6)
ffffffffc0203402:	4505                	li	a0,1
ffffffffc0203404:	6f9c                	ld	a5,24(a5)
ffffffffc0203406:	9782                	jalr	a5
ffffffffc0203408:	8a2a                	mv	s4,a0
ffffffffc020340a:	863fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020340e:	bb51                	j	ffffffffc02031a2 <pmm_init+0x514>
ffffffffc0203410:	863fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203414:	000b3783          	ld	a5,0(s6)
ffffffffc0203418:	779c                	ld	a5,40(a5)
ffffffffc020341a:	9782                	jalr	a5
ffffffffc020341c:	842a                	mv	s0,a0
ffffffffc020341e:	84ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203422:	b5e1                	j	ffffffffc02032ea <pmm_init+0x65c>
ffffffffc0203424:	e42a                	sd	a0,8(sp)
ffffffffc0203426:	84dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020342a:	000b3783          	ld	a5,0(s6)
ffffffffc020342e:	6522                	ld	a0,8(sp)
ffffffffc0203430:	4585                	li	a1,1
ffffffffc0203432:	739c                	ld	a5,32(a5)
ffffffffc0203434:	9782                	jalr	a5
ffffffffc0203436:	837fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020343a:	bd41                	j	ffffffffc02032ca <pmm_init+0x63c>
ffffffffc020343c:	e42a                	sd	a0,8(sp)
ffffffffc020343e:	835fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203442:	000b3783          	ld	a5,0(s6)
ffffffffc0203446:	6522                	ld	a0,8(sp)
ffffffffc0203448:	4585                	li	a1,1
ffffffffc020344a:	739c                	ld	a5,32(a5)
ffffffffc020344c:	9782                	jalr	a5
ffffffffc020344e:	81ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203452:	b5a1                	j	ffffffffc020329a <pmm_init+0x60c>
ffffffffc0203454:	81ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203458:	000b3783          	ld	a5,0(s6)
ffffffffc020345c:	4585                	li	a1,1
ffffffffc020345e:	8552                	mv	a0,s4
ffffffffc0203460:	739c                	ld	a5,32(a5)
ffffffffc0203462:	9782                	jalr	a5
ffffffffc0203464:	809fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203468:	b511                	j	ffffffffc020326c <pmm_init+0x5de>
ffffffffc020346a:	00010417          	auipc	s0,0x10
ffffffffc020346e:	b9640413          	addi	s0,s0,-1130 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203472:	00010797          	auipc	a5,0x10
ffffffffc0203476:	b8e78793          	addi	a5,a5,-1138 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc020347a:	a0f41de3          	bne	s0,a5,ffffffffc0202e94 <pmm_init+0x206>
ffffffffc020347e:	4581                	li	a1,0
ffffffffc0203480:	6605                	lui	a2,0x1
ffffffffc0203482:	8522                	mv	a0,s0
ffffffffc0203484:	1f2080ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0203488:	0000d597          	auipc	a1,0xd
ffffffffc020348c:	b7858593          	addi	a1,a1,-1160 # ffffffffc0210000 <bootstackguard>
ffffffffc0203490:	0000e797          	auipc	a5,0xe
ffffffffc0203494:	b60787a3          	sb	zero,-1169(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc0203498:	0000d797          	auipc	a5,0xd
ffffffffc020349c:	b6078423          	sb	zero,-1176(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc02034a0:	00093503          	ld	a0,0(s2)
ffffffffc02034a4:	2555ec63          	bltu	a1,s5,ffffffffc02036fc <pmm_init+0xa6e>
ffffffffc02034a8:	0009b683          	ld	a3,0(s3)
ffffffffc02034ac:	4701                	li	a4,0
ffffffffc02034ae:	6605                	lui	a2,0x1
ffffffffc02034b0:	40d586b3          	sub	a3,a1,a3
ffffffffc02034b4:	f99fe0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02034b8:	00093503          	ld	a0,0(s2)
ffffffffc02034bc:	23546363          	bltu	s0,s5,ffffffffc02036e2 <pmm_init+0xa54>
ffffffffc02034c0:	0009b683          	ld	a3,0(s3)
ffffffffc02034c4:	4701                	li	a4,0
ffffffffc02034c6:	6605                	lui	a2,0x1
ffffffffc02034c8:	40d406b3          	sub	a3,s0,a3
ffffffffc02034cc:	85a2                	mv	a1,s0
ffffffffc02034ce:	f7ffe0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02034d2:	12000073          	sfence.vma
ffffffffc02034d6:	00009517          	auipc	a0,0x9
ffffffffc02034da:	45250513          	addi	a0,a0,1106 # ffffffffc020c928 <default_pmm_manager+0x2e8>
ffffffffc02034de:	cc9fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02034e2:	ba4d                	j	ffffffffc0202e94 <pmm_init+0x206>
ffffffffc02034e4:	00009697          	auipc	a3,0x9
ffffffffc02034e8:	79468693          	addi	a3,a3,1940 # ffffffffc020cc78 <default_pmm_manager+0x638>
ffffffffc02034ec:	00008617          	auipc	a2,0x8
ffffffffc02034f0:	66c60613          	addi	a2,a2,1644 # ffffffffc020bb58 <commands+0x210>
ffffffffc02034f4:	28500593          	li	a1,645
ffffffffc02034f8:	00009517          	auipc	a0,0x9
ffffffffc02034fc:	29850513          	addi	a0,a0,664 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	86a2                	mv	a3,s0
ffffffffc0203506:	00009617          	auipc	a2,0x9
ffffffffc020350a:	17260613          	addi	a2,a2,370 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc020350e:	28500593          	li	a1,645
ffffffffc0203512:	00009517          	auipc	a0,0x9
ffffffffc0203516:	27e50513          	addi	a0,a0,638 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020351a:	f85fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020351e:	00009697          	auipc	a3,0x9
ffffffffc0203522:	79a68693          	addi	a3,a3,1946 # ffffffffc020ccb8 <default_pmm_manager+0x678>
ffffffffc0203526:	00008617          	auipc	a2,0x8
ffffffffc020352a:	63260613          	addi	a2,a2,1586 # ffffffffc020bb58 <commands+0x210>
ffffffffc020352e:	28600593          	li	a1,646
ffffffffc0203532:	00009517          	auipc	a0,0x9
ffffffffc0203536:	25e50513          	addi	a0,a0,606 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	bf7fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203542:	00009697          	auipc	a3,0x9
ffffffffc0203546:	59e68693          	addi	a3,a3,1438 # ffffffffc020cae0 <default_pmm_manager+0x4a0>
ffffffffc020354a:	00008617          	auipc	a2,0x8
ffffffffc020354e:	60e60613          	addi	a2,a2,1550 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203552:	26200593          	li	a1,610
ffffffffc0203556:	00009517          	auipc	a0,0x9
ffffffffc020355a:	23a50513          	addi	a0,a0,570 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020355e:	f41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203562:	00009697          	auipc	a3,0x9
ffffffffc0203566:	7de68693          	addi	a3,a3,2014 # ffffffffc020cd40 <default_pmm_manager+0x700>
ffffffffc020356a:	00008617          	auipc	a2,0x8
ffffffffc020356e:	5ee60613          	addi	a2,a2,1518 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203572:	28f00593          	li	a1,655
ffffffffc0203576:	00009517          	auipc	a0,0x9
ffffffffc020357a:	21a50513          	addi	a0,a0,538 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020357e:	f21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203582:	00009697          	auipc	a3,0x9
ffffffffc0203586:	67e68693          	addi	a3,a3,1662 # ffffffffc020cc00 <default_pmm_manager+0x5c0>
ffffffffc020358a:	00008617          	auipc	a2,0x8
ffffffffc020358e:	5ce60613          	addi	a2,a2,1486 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203592:	26e00593          	li	a1,622
ffffffffc0203596:	00009517          	auipc	a0,0x9
ffffffffc020359a:	1fa50513          	addi	a0,a0,506 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020359e:	f01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035a2:	00009697          	auipc	a3,0x9
ffffffffc02035a6:	62e68693          	addi	a3,a3,1582 # ffffffffc020cbd0 <default_pmm_manager+0x590>
ffffffffc02035aa:	00008617          	auipc	a2,0x8
ffffffffc02035ae:	5ae60613          	addi	a2,a2,1454 # ffffffffc020bb58 <commands+0x210>
ffffffffc02035b2:	26400593          	li	a1,612
ffffffffc02035b6:	00009517          	auipc	a0,0x9
ffffffffc02035ba:	1da50513          	addi	a0,a0,474 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02035be:	ee1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c2:	00009697          	auipc	a3,0x9
ffffffffc02035c6:	47e68693          	addi	a3,a3,1150 # ffffffffc020ca40 <default_pmm_manager+0x400>
ffffffffc02035ca:	00008617          	auipc	a2,0x8
ffffffffc02035ce:	58e60613          	addi	a2,a2,1422 # ffffffffc020bb58 <commands+0x210>
ffffffffc02035d2:	26300593          	li	a1,611
ffffffffc02035d6:	00009517          	auipc	a0,0x9
ffffffffc02035da:	1ba50513          	addi	a0,a0,442 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02035de:	ec1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e2:	00009697          	auipc	a3,0x9
ffffffffc02035e6:	5d668693          	addi	a3,a3,1494 # ffffffffc020cbb8 <default_pmm_manager+0x578>
ffffffffc02035ea:	00008617          	auipc	a2,0x8
ffffffffc02035ee:	56e60613          	addi	a2,a2,1390 # ffffffffc020bb58 <commands+0x210>
ffffffffc02035f2:	26800593          	li	a1,616
ffffffffc02035f6:	00009517          	auipc	a0,0x9
ffffffffc02035fa:	19a50513          	addi	a0,a0,410 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02035fe:	ea1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203602:	00009697          	auipc	a3,0x9
ffffffffc0203606:	45668693          	addi	a3,a3,1110 # ffffffffc020ca58 <default_pmm_manager+0x418>
ffffffffc020360a:	00008617          	auipc	a2,0x8
ffffffffc020360e:	54e60613          	addi	a2,a2,1358 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203612:	26700593          	li	a1,615
ffffffffc0203616:	00009517          	auipc	a0,0x9
ffffffffc020361a:	17a50513          	addi	a0,a0,378 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00009697          	auipc	a3,0x9
ffffffffc0203626:	6ae68693          	addi	a3,a3,1710 # ffffffffc020ccd0 <default_pmm_manager+0x690>
ffffffffc020362a:	00008617          	auipc	a2,0x8
ffffffffc020362e:	52e60613          	addi	a2,a2,1326 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203632:	28900593          	li	a1,649
ffffffffc0203636:	00009517          	auipc	a0,0x9
ffffffffc020363a:	15a50513          	addi	a0,a0,346 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00009697          	auipc	a3,0x9
ffffffffc0203646:	6e668693          	addi	a3,a3,1766 # ffffffffc020cd28 <default_pmm_manager+0x6e8>
ffffffffc020364a:	00008617          	auipc	a2,0x8
ffffffffc020364e:	50e60613          	addi	a2,a2,1294 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203652:	28e00593          	li	a1,654
ffffffffc0203656:	00009517          	auipc	a0,0x9
ffffffffc020365a:	13a50513          	addi	a0,a0,314 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00009697          	auipc	a3,0x9
ffffffffc0203666:	68668693          	addi	a3,a3,1670 # ffffffffc020cce8 <default_pmm_manager+0x6a8>
ffffffffc020366a:	00008617          	auipc	a2,0x8
ffffffffc020366e:	4ee60613          	addi	a2,a2,1262 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203672:	28d00593          	li	a1,653
ffffffffc0203676:	00009517          	auipc	a0,0x9
ffffffffc020367a:	11a50513          	addi	a0,a0,282 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00009697          	auipc	a3,0x9
ffffffffc0203686:	76e68693          	addi	a3,a3,1902 # ffffffffc020cdf0 <default_pmm_manager+0x7b0>
ffffffffc020368a:	00008617          	auipc	a2,0x8
ffffffffc020368e:	4ce60613          	addi	a2,a2,1230 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203692:	29700593          	li	a1,663
ffffffffc0203696:	00009517          	auipc	a0,0x9
ffffffffc020369a:	0fa50513          	addi	a0,a0,250 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00009697          	auipc	a3,0x9
ffffffffc02036a6:	71668693          	addi	a3,a3,1814 # ffffffffc020cdb8 <default_pmm_manager+0x778>
ffffffffc02036aa:	00008617          	auipc	a2,0x8
ffffffffc02036ae:	4ae60613          	addi	a2,a2,1198 # ffffffffc020bb58 <commands+0x210>
ffffffffc02036b2:	29400593          	li	a1,660
ffffffffc02036b6:	00009517          	auipc	a0,0x9
ffffffffc02036ba:	0da50513          	addi	a0,a0,218 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00009697          	auipc	a3,0x9
ffffffffc02036c6:	6c668693          	addi	a3,a3,1734 # ffffffffc020cd88 <default_pmm_manager+0x748>
ffffffffc02036ca:	00008617          	auipc	a2,0x8
ffffffffc02036ce:	48e60613          	addi	a2,a2,1166 # ffffffffc020bb58 <commands+0x210>
ffffffffc02036d2:	29000593          	li	a1,656
ffffffffc02036d6:	00009517          	auipc	a0,0x9
ffffffffc02036da:	0ba50513          	addi	a0,a0,186 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	86a2                	mv	a3,s0
ffffffffc02036e4:	00009617          	auipc	a2,0x9
ffffffffc02036e8:	03c60613          	addi	a2,a2,60 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc02036ec:	0dc00593          	li	a1,220
ffffffffc02036f0:	00009517          	auipc	a0,0x9
ffffffffc02036f4:	0a050513          	addi	a0,a0,160 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02036f8:	da7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036fc:	86ae                	mv	a3,a1
ffffffffc02036fe:	00009617          	auipc	a2,0x9
ffffffffc0203702:	02260613          	addi	a2,a2,34 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0203706:	0db00593          	li	a1,219
ffffffffc020370a:	00009517          	auipc	a0,0x9
ffffffffc020370e:	08650513          	addi	a0,a0,134 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203712:	d8dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203716:	00009697          	auipc	a3,0x9
ffffffffc020371a:	25a68693          	addi	a3,a3,602 # ffffffffc020c970 <default_pmm_manager+0x330>
ffffffffc020371e:	00008617          	auipc	a2,0x8
ffffffffc0203722:	43a60613          	addi	a2,a2,1082 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203726:	24700593          	li	a1,583
ffffffffc020372a:	00009517          	auipc	a0,0x9
ffffffffc020372e:	06650513          	addi	a0,a0,102 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203732:	d6dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203736:	00009697          	auipc	a3,0x9
ffffffffc020373a:	21a68693          	addi	a3,a3,538 # ffffffffc020c950 <default_pmm_manager+0x310>
ffffffffc020373e:	00008617          	auipc	a2,0x8
ffffffffc0203742:	41a60613          	addi	a2,a2,1050 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203746:	24600593          	li	a1,582
ffffffffc020374a:	00009517          	auipc	a0,0x9
ffffffffc020374e:	04650513          	addi	a0,a0,70 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203752:	d4dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203756:	00009617          	auipc	a2,0x9
ffffffffc020375a:	18a60613          	addi	a2,a2,394 # ffffffffc020c8e0 <default_pmm_manager+0x2a0>
ffffffffc020375e:	0aa00593          	li	a1,170
ffffffffc0203762:	00009517          	auipc	a0,0x9
ffffffffc0203766:	02e50513          	addi	a0,a0,46 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020376a:	d35fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020376e:	00009617          	auipc	a2,0x9
ffffffffc0203772:	0da60613          	addi	a2,a2,218 # ffffffffc020c848 <default_pmm_manager+0x208>
ffffffffc0203776:	06500593          	li	a1,101
ffffffffc020377a:	00009517          	auipc	a0,0x9
ffffffffc020377e:	01650513          	addi	a0,a0,22 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203782:	d1dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203786:	00009697          	auipc	a3,0x9
ffffffffc020378a:	4aa68693          	addi	a3,a3,1194 # ffffffffc020cc30 <default_pmm_manager+0x5f0>
ffffffffc020378e:	00008617          	auipc	a2,0x8
ffffffffc0203792:	3ca60613          	addi	a2,a2,970 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203796:	2a000593          	li	a1,672
ffffffffc020379a:	00009517          	auipc	a0,0x9
ffffffffc020379e:	ff650513          	addi	a0,a0,-10 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02037a2:	cfdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037a6:	00009697          	auipc	a3,0x9
ffffffffc02037aa:	2ca68693          	addi	a3,a3,714 # ffffffffc020ca70 <default_pmm_manager+0x430>
ffffffffc02037ae:	00008617          	auipc	a2,0x8
ffffffffc02037b2:	3aa60613          	addi	a2,a2,938 # ffffffffc020bb58 <commands+0x210>
ffffffffc02037b6:	25500593          	li	a1,597
ffffffffc02037ba:	00009517          	auipc	a0,0x9
ffffffffc02037be:	fd650513          	addi	a0,a0,-42 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02037c2:	cddfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037c6:	86d6                	mv	a3,s5
ffffffffc02037c8:	00009617          	auipc	a2,0x9
ffffffffc02037cc:	eb060613          	addi	a2,a2,-336 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc02037d0:	25400593          	li	a1,596
ffffffffc02037d4:	00009517          	auipc	a0,0x9
ffffffffc02037d8:	fbc50513          	addi	a0,a0,-68 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02037dc:	cc3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037e0:	00009697          	auipc	a3,0x9
ffffffffc02037e4:	3d868693          	addi	a3,a3,984 # ffffffffc020cbb8 <default_pmm_manager+0x578>
ffffffffc02037e8:	00008617          	auipc	a2,0x8
ffffffffc02037ec:	37060613          	addi	a2,a2,880 # ffffffffc020bb58 <commands+0x210>
ffffffffc02037f0:	26100593          	li	a1,609
ffffffffc02037f4:	00009517          	auipc	a0,0x9
ffffffffc02037f8:	f9c50513          	addi	a0,a0,-100 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02037fc:	ca3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203800:	00009697          	auipc	a3,0x9
ffffffffc0203804:	3a068693          	addi	a3,a3,928 # ffffffffc020cba0 <default_pmm_manager+0x560>
ffffffffc0203808:	00008617          	auipc	a2,0x8
ffffffffc020380c:	35060613          	addi	a2,a2,848 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203810:	26000593          	li	a1,608
ffffffffc0203814:	00009517          	auipc	a0,0x9
ffffffffc0203818:	f7c50513          	addi	a0,a0,-132 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020381c:	c83fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203820:	00009697          	auipc	a3,0x9
ffffffffc0203824:	35068693          	addi	a3,a3,848 # ffffffffc020cb70 <default_pmm_manager+0x530>
ffffffffc0203828:	00008617          	auipc	a2,0x8
ffffffffc020382c:	33060613          	addi	a2,a2,816 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203830:	25f00593          	li	a1,607
ffffffffc0203834:	00009517          	auipc	a0,0x9
ffffffffc0203838:	f5c50513          	addi	a0,a0,-164 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020383c:	c63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203840:	00009697          	auipc	a3,0x9
ffffffffc0203844:	31868693          	addi	a3,a3,792 # ffffffffc020cb58 <default_pmm_manager+0x518>
ffffffffc0203848:	00008617          	auipc	a2,0x8
ffffffffc020384c:	31060613          	addi	a2,a2,784 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203850:	25d00593          	li	a1,605
ffffffffc0203854:	00009517          	auipc	a0,0x9
ffffffffc0203858:	f3c50513          	addi	a0,a0,-196 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020385c:	c43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203860:	00009697          	auipc	a3,0x9
ffffffffc0203864:	2d868693          	addi	a3,a3,728 # ffffffffc020cb38 <default_pmm_manager+0x4f8>
ffffffffc0203868:	00008617          	auipc	a2,0x8
ffffffffc020386c:	2f060613          	addi	a2,a2,752 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203870:	25c00593          	li	a1,604
ffffffffc0203874:	00009517          	auipc	a0,0x9
ffffffffc0203878:	f1c50513          	addi	a0,a0,-228 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020387c:	c23fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203880:	00009697          	auipc	a3,0x9
ffffffffc0203884:	2a868693          	addi	a3,a3,680 # ffffffffc020cb28 <default_pmm_manager+0x4e8>
ffffffffc0203888:	00008617          	auipc	a2,0x8
ffffffffc020388c:	2d060613          	addi	a2,a2,720 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203890:	25b00593          	li	a1,603
ffffffffc0203894:	00009517          	auipc	a0,0x9
ffffffffc0203898:	efc50513          	addi	a0,a0,-260 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020389c:	c03fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a0:	00009697          	auipc	a3,0x9
ffffffffc02038a4:	27868693          	addi	a3,a3,632 # ffffffffc020cb18 <default_pmm_manager+0x4d8>
ffffffffc02038a8:	00008617          	auipc	a2,0x8
ffffffffc02038ac:	2b060613          	addi	a2,a2,688 # ffffffffc020bb58 <commands+0x210>
ffffffffc02038b0:	25a00593          	li	a1,602
ffffffffc02038b4:	00009517          	auipc	a0,0x9
ffffffffc02038b8:	edc50513          	addi	a0,a0,-292 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02038bc:	be3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038c0:	00009697          	auipc	a3,0x9
ffffffffc02038c4:	22068693          	addi	a3,a3,544 # ffffffffc020cae0 <default_pmm_manager+0x4a0>
ffffffffc02038c8:	00008617          	auipc	a2,0x8
ffffffffc02038cc:	29060613          	addi	a2,a2,656 # ffffffffc020bb58 <commands+0x210>
ffffffffc02038d0:	25900593          	li	a1,601
ffffffffc02038d4:	00009517          	auipc	a0,0x9
ffffffffc02038d8:	ebc50513          	addi	a0,a0,-324 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02038dc:	bc3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038e0:	00009697          	auipc	a3,0x9
ffffffffc02038e4:	35068693          	addi	a3,a3,848 # ffffffffc020cc30 <default_pmm_manager+0x5f0>
ffffffffc02038e8:	00008617          	auipc	a2,0x8
ffffffffc02038ec:	27060613          	addi	a2,a2,624 # ffffffffc020bb58 <commands+0x210>
ffffffffc02038f0:	27600593          	li	a1,630
ffffffffc02038f4:	00009517          	auipc	a0,0x9
ffffffffc02038f8:	e9c50513          	addi	a0,a0,-356 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02038fc:	ba3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203900:	00009617          	auipc	a2,0x9
ffffffffc0203904:	d7860613          	addi	a2,a2,-648 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0203908:	07100593          	li	a1,113
ffffffffc020390c:	00009517          	auipc	a0,0x9
ffffffffc0203910:	d9450513          	addi	a0,a0,-620 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0203914:	b8bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203918:	86a2                	mv	a3,s0
ffffffffc020391a:	00009617          	auipc	a2,0x9
ffffffffc020391e:	e0660613          	addi	a2,a2,-506 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0203922:	0ca00593          	li	a1,202
ffffffffc0203926:	00009517          	auipc	a0,0x9
ffffffffc020392a:	e6a50513          	addi	a0,a0,-406 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc020392e:	b71fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203932:	00009617          	auipc	a2,0x9
ffffffffc0203936:	dee60613          	addi	a2,a2,-530 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc020393a:	08100593          	li	a1,129
ffffffffc020393e:	00009517          	auipc	a0,0x9
ffffffffc0203942:	e5250513          	addi	a0,a0,-430 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203946:	b59fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020394a:	00009697          	auipc	a3,0x9
ffffffffc020394e:	15668693          	addi	a3,a3,342 # ffffffffc020caa0 <default_pmm_manager+0x460>
ffffffffc0203952:	00008617          	auipc	a2,0x8
ffffffffc0203956:	20660613          	addi	a2,a2,518 # ffffffffc020bb58 <commands+0x210>
ffffffffc020395a:	25800593          	li	a1,600
ffffffffc020395e:	00009517          	auipc	a0,0x9
ffffffffc0203962:	e3250513          	addi	a0,a0,-462 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203966:	b39fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020396a:	00009697          	auipc	a3,0x9
ffffffffc020396e:	07668693          	addi	a3,a3,118 # ffffffffc020c9e0 <default_pmm_manager+0x3a0>
ffffffffc0203972:	00008617          	auipc	a2,0x8
ffffffffc0203976:	1e660613          	addi	a2,a2,486 # ffffffffc020bb58 <commands+0x210>
ffffffffc020397a:	24c00593          	li	a1,588
ffffffffc020397e:	00009517          	auipc	a0,0x9
ffffffffc0203982:	e1250513          	addi	a0,a0,-494 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203986:	b19fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020398a:	fc6fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc020398e:	00009697          	auipc	a3,0x9
ffffffffc0203992:	08268693          	addi	a3,a3,130 # ffffffffc020ca10 <default_pmm_manager+0x3d0>
ffffffffc0203996:	00008617          	auipc	a2,0x8
ffffffffc020399a:	1c260613          	addi	a2,a2,450 # ffffffffc020bb58 <commands+0x210>
ffffffffc020399e:	24f00593          	li	a1,591
ffffffffc02039a2:	00009517          	auipc	a0,0x9
ffffffffc02039a6:	dee50513          	addi	a0,a0,-530 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02039aa:	af5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039ae:	00009697          	auipc	a3,0x9
ffffffffc02039b2:	00268693          	addi	a3,a3,2 # ffffffffc020c9b0 <default_pmm_manager+0x370>
ffffffffc02039b6:	00008617          	auipc	a2,0x8
ffffffffc02039ba:	1a260613          	addi	a2,a2,418 # ffffffffc020bb58 <commands+0x210>
ffffffffc02039be:	24800593          	li	a1,584
ffffffffc02039c2:	00009517          	auipc	a0,0x9
ffffffffc02039c6:	dce50513          	addi	a0,a0,-562 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02039ca:	ad5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039ce:	00009697          	auipc	a3,0x9
ffffffffc02039d2:	07268693          	addi	a3,a3,114 # ffffffffc020ca40 <default_pmm_manager+0x400>
ffffffffc02039d6:	00008617          	auipc	a2,0x8
ffffffffc02039da:	18260613          	addi	a2,a2,386 # ffffffffc020bb58 <commands+0x210>
ffffffffc02039de:	25000593          	li	a1,592
ffffffffc02039e2:	00009517          	auipc	a0,0x9
ffffffffc02039e6:	dae50513          	addi	a0,a0,-594 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc02039ea:	ab5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039ee:	00009617          	auipc	a2,0x9
ffffffffc02039f2:	c8a60613          	addi	a2,a2,-886 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc02039f6:	25300593          	li	a1,595
ffffffffc02039fa:	00009517          	auipc	a0,0x9
ffffffffc02039fe:	d9650513          	addi	a0,a0,-618 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203a02:	a9dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a06:	00009697          	auipc	a3,0x9
ffffffffc0203a0a:	05268693          	addi	a3,a3,82 # ffffffffc020ca58 <default_pmm_manager+0x418>
ffffffffc0203a0e:	00008617          	auipc	a2,0x8
ffffffffc0203a12:	14a60613          	addi	a2,a2,330 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203a16:	25100593          	li	a1,593
ffffffffc0203a1a:	00009517          	auipc	a0,0x9
ffffffffc0203a1e:	d7650513          	addi	a0,a0,-650 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203a22:	a7dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a26:	86ca                	mv	a3,s2
ffffffffc0203a28:	00009617          	auipc	a2,0x9
ffffffffc0203a2c:	cf860613          	addi	a2,a2,-776 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0203a30:	0c600593          	li	a1,198
ffffffffc0203a34:	00009517          	auipc	a0,0x9
ffffffffc0203a38:	d5c50513          	addi	a0,a0,-676 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203a3c:	a63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a40:	00009697          	auipc	a3,0x9
ffffffffc0203a44:	17868693          	addi	a3,a3,376 # ffffffffc020cbb8 <default_pmm_manager+0x578>
ffffffffc0203a48:	00008617          	auipc	a2,0x8
ffffffffc0203a4c:	11060613          	addi	a2,a2,272 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203a50:	26c00593          	li	a1,620
ffffffffc0203a54:	00009517          	auipc	a0,0x9
ffffffffc0203a58:	d3c50513          	addi	a0,a0,-708 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203a5c:	a43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a60:	00009697          	auipc	a3,0x9
ffffffffc0203a64:	18868693          	addi	a3,a3,392 # ffffffffc020cbe8 <default_pmm_manager+0x5a8>
ffffffffc0203a68:	00008617          	auipc	a2,0x8
ffffffffc0203a6c:	0f060613          	addi	a2,a2,240 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203a70:	26b00593          	li	a1,619
ffffffffc0203a74:	00009517          	auipc	a0,0x9
ffffffffc0203a78:	d1c50513          	addi	a0,a0,-740 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203a7c:	a23fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203a80 <pgdir_alloc_page>:
ffffffffc0203a80:	7179                	addi	sp,sp,-48
ffffffffc0203a82:	ec26                	sd	s1,24(sp)
ffffffffc0203a84:	e84a                	sd	s2,16(sp)
ffffffffc0203a86:	e052                	sd	s4,0(sp)
ffffffffc0203a88:	f406                	sd	ra,40(sp)
ffffffffc0203a8a:	f022                	sd	s0,32(sp)
ffffffffc0203a8c:	e44e                	sd	s3,8(sp)
ffffffffc0203a8e:	8a2a                	mv	s4,a0
ffffffffc0203a90:	84ae                	mv	s1,a1
ffffffffc0203a92:	8932                	mv	s2,a2
ffffffffc0203a94:	100027f3          	csrr	a5,sstatus
ffffffffc0203a98:	8b89                	andi	a5,a5,2
ffffffffc0203a9a:	00093997          	auipc	s3,0x93
ffffffffc0203a9e:	e1698993          	addi	s3,s3,-490 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203aa2:	ef8d                	bnez	a5,ffffffffc0203adc <pgdir_alloc_page+0x5c>
ffffffffc0203aa4:	0009b783          	ld	a5,0(s3)
ffffffffc0203aa8:	4505                	li	a0,1
ffffffffc0203aaa:	6f9c                	ld	a5,24(a5)
ffffffffc0203aac:	9782                	jalr	a5
ffffffffc0203aae:	842a                	mv	s0,a0
ffffffffc0203ab0:	cc09                	beqz	s0,ffffffffc0203aca <pgdir_alloc_page+0x4a>
ffffffffc0203ab2:	86ca                	mv	a3,s2
ffffffffc0203ab4:	8626                	mv	a2,s1
ffffffffc0203ab6:	85a2                	mv	a1,s0
ffffffffc0203ab8:	8552                	mv	a0,s4
ffffffffc0203aba:	8deff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0203abe:	e915                	bnez	a0,ffffffffc0203af2 <pgdir_alloc_page+0x72>
ffffffffc0203ac0:	4018                	lw	a4,0(s0)
ffffffffc0203ac2:	fc04                	sd	s1,56(s0)
ffffffffc0203ac4:	4785                	li	a5,1
ffffffffc0203ac6:	04f71e63          	bne	a4,a5,ffffffffc0203b22 <pgdir_alloc_page+0xa2>
ffffffffc0203aca:	70a2                	ld	ra,40(sp)
ffffffffc0203acc:	8522                	mv	a0,s0
ffffffffc0203ace:	7402                	ld	s0,32(sp)
ffffffffc0203ad0:	64e2                	ld	s1,24(sp)
ffffffffc0203ad2:	6942                	ld	s2,16(sp)
ffffffffc0203ad4:	69a2                	ld	s3,8(sp)
ffffffffc0203ad6:	6a02                	ld	s4,0(sp)
ffffffffc0203ad8:	6145                	addi	sp,sp,48
ffffffffc0203ada:	8082                	ret
ffffffffc0203adc:	996fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203ae0:	0009b783          	ld	a5,0(s3)
ffffffffc0203ae4:	4505                	li	a0,1
ffffffffc0203ae6:	6f9c                	ld	a5,24(a5)
ffffffffc0203ae8:	9782                	jalr	a5
ffffffffc0203aea:	842a                	mv	s0,a0
ffffffffc0203aec:	980fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203af0:	b7c1                	j	ffffffffc0203ab0 <pgdir_alloc_page+0x30>
ffffffffc0203af2:	100027f3          	csrr	a5,sstatus
ffffffffc0203af6:	8b89                	andi	a5,a5,2
ffffffffc0203af8:	eb89                	bnez	a5,ffffffffc0203b0a <pgdir_alloc_page+0x8a>
ffffffffc0203afa:	0009b783          	ld	a5,0(s3)
ffffffffc0203afe:	8522                	mv	a0,s0
ffffffffc0203b00:	4585                	li	a1,1
ffffffffc0203b02:	739c                	ld	a5,32(a5)
ffffffffc0203b04:	4401                	li	s0,0
ffffffffc0203b06:	9782                	jalr	a5
ffffffffc0203b08:	b7c9                	j	ffffffffc0203aca <pgdir_alloc_page+0x4a>
ffffffffc0203b0a:	968fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b0e:	0009b783          	ld	a5,0(s3)
ffffffffc0203b12:	8522                	mv	a0,s0
ffffffffc0203b14:	4585                	li	a1,1
ffffffffc0203b16:	739c                	ld	a5,32(a5)
ffffffffc0203b18:	4401                	li	s0,0
ffffffffc0203b1a:	9782                	jalr	a5
ffffffffc0203b1c:	950fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203b20:	b76d                	j	ffffffffc0203aca <pgdir_alloc_page+0x4a>
ffffffffc0203b22:	00009697          	auipc	a3,0x9
ffffffffc0203b26:	31668693          	addi	a3,a3,790 # ffffffffc020ce38 <default_pmm_manager+0x7f8>
ffffffffc0203b2a:	00008617          	auipc	a2,0x8
ffffffffc0203b2e:	02e60613          	addi	a2,a2,46 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203b32:	22d00593          	li	a1,557
ffffffffc0203b36:	00009517          	auipc	a0,0x9
ffffffffc0203b3a:	c5a50513          	addi	a0,a0,-934 # ffffffffc020c790 <default_pmm_manager+0x150>
ffffffffc0203b3e:	961fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b42 <check_vma_overlap.part.0>:
ffffffffc0203b42:	1141                	addi	sp,sp,-16
ffffffffc0203b44:	00009697          	auipc	a3,0x9
ffffffffc0203b48:	30c68693          	addi	a3,a3,780 # ffffffffc020ce50 <default_pmm_manager+0x810>
ffffffffc0203b4c:	00008617          	auipc	a2,0x8
ffffffffc0203b50:	00c60613          	addi	a2,a2,12 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203b54:	07400593          	li	a1,116
ffffffffc0203b58:	00009517          	auipc	a0,0x9
ffffffffc0203b5c:	31850513          	addi	a0,a0,792 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203b60:	e406                	sd	ra,8(sp)
ffffffffc0203b62:	93dfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b66 <mm_create>:
ffffffffc0203b66:	1141                	addi	sp,sp,-16
ffffffffc0203b68:	05800513          	li	a0,88
ffffffffc0203b6c:	e022                	sd	s0,0(sp)
ffffffffc0203b6e:	e406                	sd	ra,8(sp)
ffffffffc0203b70:	c1efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203b74:	842a                	mv	s0,a0
ffffffffc0203b76:	c115                	beqz	a0,ffffffffc0203b9a <mm_create+0x34>
ffffffffc0203b78:	e408                	sd	a0,8(s0)
ffffffffc0203b7a:	e008                	sd	a0,0(s0)
ffffffffc0203b7c:	00053823          	sd	zero,16(a0)
ffffffffc0203b80:	00053c23          	sd	zero,24(a0)
ffffffffc0203b84:	02052023          	sw	zero,32(a0)
ffffffffc0203b88:	02053423          	sd	zero,40(a0)
ffffffffc0203b8c:	02052823          	sw	zero,48(a0)
ffffffffc0203b90:	4585                	li	a1,1
ffffffffc0203b92:	03850513          	addi	a0,a0,56
ffffffffc0203b96:	123000ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0203b9a:	60a2                	ld	ra,8(sp)
ffffffffc0203b9c:	8522                	mv	a0,s0
ffffffffc0203b9e:	6402                	ld	s0,0(sp)
ffffffffc0203ba0:	0141                	addi	sp,sp,16
ffffffffc0203ba2:	8082                	ret

ffffffffc0203ba4 <find_vma>:
ffffffffc0203ba4:	86aa                	mv	a3,a0
ffffffffc0203ba6:	c505                	beqz	a0,ffffffffc0203bce <find_vma+0x2a>
ffffffffc0203ba8:	6908                	ld	a0,16(a0)
ffffffffc0203baa:	c501                	beqz	a0,ffffffffc0203bb2 <find_vma+0xe>
ffffffffc0203bac:	651c                	ld	a5,8(a0)
ffffffffc0203bae:	02f5f263          	bgeu	a1,a5,ffffffffc0203bd2 <find_vma+0x2e>
ffffffffc0203bb2:	669c                	ld	a5,8(a3)
ffffffffc0203bb4:	00f68d63          	beq	a3,a5,ffffffffc0203bce <find_vma+0x2a>
ffffffffc0203bb8:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203bbc:	00e5e663          	bltu	a1,a4,ffffffffc0203bc8 <find_vma+0x24>
ffffffffc0203bc0:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203bc4:	00e5ec63          	bltu	a1,a4,ffffffffc0203bdc <find_vma+0x38>
ffffffffc0203bc8:	679c                	ld	a5,8(a5)
ffffffffc0203bca:	fef697e3          	bne	a3,a5,ffffffffc0203bb8 <find_vma+0x14>
ffffffffc0203bce:	4501                	li	a0,0
ffffffffc0203bd0:	8082                	ret
ffffffffc0203bd2:	691c                	ld	a5,16(a0)
ffffffffc0203bd4:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203bb2 <find_vma+0xe>
ffffffffc0203bd8:	ea88                	sd	a0,16(a3)
ffffffffc0203bda:	8082                	ret
ffffffffc0203bdc:	fe078513          	addi	a0,a5,-32
ffffffffc0203be0:	ea88                	sd	a0,16(a3)
ffffffffc0203be2:	8082                	ret

ffffffffc0203be4 <insert_vma_struct>:
ffffffffc0203be4:	6590                	ld	a2,8(a1)
ffffffffc0203be6:	0105b803          	ld	a6,16(a1)
ffffffffc0203bea:	1141                	addi	sp,sp,-16
ffffffffc0203bec:	e406                	sd	ra,8(sp)
ffffffffc0203bee:	87aa                	mv	a5,a0
ffffffffc0203bf0:	01066763          	bltu	a2,a6,ffffffffc0203bfe <insert_vma_struct+0x1a>
ffffffffc0203bf4:	a085                	j	ffffffffc0203c54 <insert_vma_struct+0x70>
ffffffffc0203bf6:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203bfa:	04e66863          	bltu	a2,a4,ffffffffc0203c4a <insert_vma_struct+0x66>
ffffffffc0203bfe:	86be                	mv	a3,a5
ffffffffc0203c00:	679c                	ld	a5,8(a5)
ffffffffc0203c02:	fef51ae3          	bne	a0,a5,ffffffffc0203bf6 <insert_vma_struct+0x12>
ffffffffc0203c06:	02a68463          	beq	a3,a0,ffffffffc0203c2e <insert_vma_struct+0x4a>
ffffffffc0203c0a:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203c0e:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203c12:	08e8f163          	bgeu	a7,a4,ffffffffc0203c94 <insert_vma_struct+0xb0>
ffffffffc0203c16:	04e66f63          	bltu	a2,a4,ffffffffc0203c74 <insert_vma_struct+0x90>
ffffffffc0203c1a:	00f50a63          	beq	a0,a5,ffffffffc0203c2e <insert_vma_struct+0x4a>
ffffffffc0203c1e:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203c22:	05076963          	bltu	a4,a6,ffffffffc0203c74 <insert_vma_struct+0x90>
ffffffffc0203c26:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203c2a:	02c77363          	bgeu	a4,a2,ffffffffc0203c50 <insert_vma_struct+0x6c>
ffffffffc0203c2e:	5118                	lw	a4,32(a0)
ffffffffc0203c30:	e188                	sd	a0,0(a1)
ffffffffc0203c32:	02058613          	addi	a2,a1,32
ffffffffc0203c36:	e390                	sd	a2,0(a5)
ffffffffc0203c38:	e690                	sd	a2,8(a3)
ffffffffc0203c3a:	60a2                	ld	ra,8(sp)
ffffffffc0203c3c:	f59c                	sd	a5,40(a1)
ffffffffc0203c3e:	f194                	sd	a3,32(a1)
ffffffffc0203c40:	0017079b          	addiw	a5,a4,1
ffffffffc0203c44:	d11c                	sw	a5,32(a0)
ffffffffc0203c46:	0141                	addi	sp,sp,16
ffffffffc0203c48:	8082                	ret
ffffffffc0203c4a:	fca690e3          	bne	a3,a0,ffffffffc0203c0a <insert_vma_struct+0x26>
ffffffffc0203c4e:	bfd1                	j	ffffffffc0203c22 <insert_vma_struct+0x3e>
ffffffffc0203c50:	ef3ff0ef          	jal	ra,ffffffffc0203b42 <check_vma_overlap.part.0>
ffffffffc0203c54:	00009697          	auipc	a3,0x9
ffffffffc0203c58:	22c68693          	addi	a3,a3,556 # ffffffffc020ce80 <default_pmm_manager+0x840>
ffffffffc0203c5c:	00008617          	auipc	a2,0x8
ffffffffc0203c60:	efc60613          	addi	a2,a2,-260 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203c64:	07a00593          	li	a1,122
ffffffffc0203c68:	00009517          	auipc	a0,0x9
ffffffffc0203c6c:	20850513          	addi	a0,a0,520 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203c70:	82ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c74:	00009697          	auipc	a3,0x9
ffffffffc0203c78:	24c68693          	addi	a3,a3,588 # ffffffffc020cec0 <default_pmm_manager+0x880>
ffffffffc0203c7c:	00008617          	auipc	a2,0x8
ffffffffc0203c80:	edc60613          	addi	a2,a2,-292 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203c84:	07300593          	li	a1,115
ffffffffc0203c88:	00009517          	auipc	a0,0x9
ffffffffc0203c8c:	1e850513          	addi	a0,a0,488 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203c90:	80ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c94:	00009697          	auipc	a3,0x9
ffffffffc0203c98:	20c68693          	addi	a3,a3,524 # ffffffffc020cea0 <default_pmm_manager+0x860>
ffffffffc0203c9c:	00008617          	auipc	a2,0x8
ffffffffc0203ca0:	ebc60613          	addi	a2,a2,-324 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203ca4:	07200593          	li	a1,114
ffffffffc0203ca8:	00009517          	auipc	a0,0x9
ffffffffc0203cac:	1c850513          	addi	a0,a0,456 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203cb0:	feefc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203cb4 <mm_destroy>:
ffffffffc0203cb4:	591c                	lw	a5,48(a0)
ffffffffc0203cb6:	1141                	addi	sp,sp,-16
ffffffffc0203cb8:	e406                	sd	ra,8(sp)
ffffffffc0203cba:	e022                	sd	s0,0(sp)
ffffffffc0203cbc:	e78d                	bnez	a5,ffffffffc0203ce6 <mm_destroy+0x32>
ffffffffc0203cbe:	842a                	mv	s0,a0
ffffffffc0203cc0:	6508                	ld	a0,8(a0)
ffffffffc0203cc2:	00a40c63          	beq	s0,a0,ffffffffc0203cda <mm_destroy+0x26>
ffffffffc0203cc6:	6118                	ld	a4,0(a0)
ffffffffc0203cc8:	651c                	ld	a5,8(a0)
ffffffffc0203cca:	1501                	addi	a0,a0,-32
ffffffffc0203ccc:	e71c                	sd	a5,8(a4)
ffffffffc0203cce:	e398                	sd	a4,0(a5)
ffffffffc0203cd0:	b6efe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203cd4:	6408                	ld	a0,8(s0)
ffffffffc0203cd6:	fea418e3          	bne	s0,a0,ffffffffc0203cc6 <mm_destroy+0x12>
ffffffffc0203cda:	8522                	mv	a0,s0
ffffffffc0203cdc:	6402                	ld	s0,0(sp)
ffffffffc0203cde:	60a2                	ld	ra,8(sp)
ffffffffc0203ce0:	0141                	addi	sp,sp,16
ffffffffc0203ce2:	b5cfe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203ce6:	00009697          	auipc	a3,0x9
ffffffffc0203cea:	1fa68693          	addi	a3,a3,506 # ffffffffc020cee0 <default_pmm_manager+0x8a0>
ffffffffc0203cee:	00008617          	auipc	a2,0x8
ffffffffc0203cf2:	e6a60613          	addi	a2,a2,-406 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203cf6:	09e00593          	li	a1,158
ffffffffc0203cfa:	00009517          	auipc	a0,0x9
ffffffffc0203cfe:	17650513          	addi	a0,a0,374 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203d02:	f9cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d06 <mm_map>:
ffffffffc0203d06:	7139                	addi	sp,sp,-64
ffffffffc0203d08:	f822                	sd	s0,48(sp)
ffffffffc0203d0a:	6405                	lui	s0,0x1
ffffffffc0203d0c:	147d                	addi	s0,s0,-1
ffffffffc0203d0e:	77fd                	lui	a5,0xfffff
ffffffffc0203d10:	9622                	add	a2,a2,s0
ffffffffc0203d12:	962e                	add	a2,a2,a1
ffffffffc0203d14:	f426                	sd	s1,40(sp)
ffffffffc0203d16:	fc06                	sd	ra,56(sp)
ffffffffc0203d18:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203d1c:	f04a                	sd	s2,32(sp)
ffffffffc0203d1e:	ec4e                	sd	s3,24(sp)
ffffffffc0203d20:	e852                	sd	s4,16(sp)
ffffffffc0203d22:	e456                	sd	s5,8(sp)
ffffffffc0203d24:	002005b7          	lui	a1,0x200
ffffffffc0203d28:	00f67433          	and	s0,a2,a5
ffffffffc0203d2c:	06b4e363          	bltu	s1,a1,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d30:	0684f163          	bgeu	s1,s0,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d34:	4785                	li	a5,1
ffffffffc0203d36:	07fe                	slli	a5,a5,0x1f
ffffffffc0203d38:	0487ed63          	bltu	a5,s0,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d3c:	89aa                	mv	s3,a0
ffffffffc0203d3e:	cd21                	beqz	a0,ffffffffc0203d96 <mm_map+0x90>
ffffffffc0203d40:	85a6                	mv	a1,s1
ffffffffc0203d42:	8ab6                	mv	s5,a3
ffffffffc0203d44:	8a3a                	mv	s4,a4
ffffffffc0203d46:	e5fff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203d4a:	c501                	beqz	a0,ffffffffc0203d52 <mm_map+0x4c>
ffffffffc0203d4c:	651c                	ld	a5,8(a0)
ffffffffc0203d4e:	0487e263          	bltu	a5,s0,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d52:	03000513          	li	a0,48
ffffffffc0203d56:	a38fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203d5a:	892a                	mv	s2,a0
ffffffffc0203d5c:	5571                	li	a0,-4
ffffffffc0203d5e:	02090163          	beqz	s2,ffffffffc0203d80 <mm_map+0x7a>
ffffffffc0203d62:	854e                	mv	a0,s3
ffffffffc0203d64:	00993423          	sd	s1,8(s2)
ffffffffc0203d68:	00893823          	sd	s0,16(s2)
ffffffffc0203d6c:	01592c23          	sw	s5,24(s2)
ffffffffc0203d70:	85ca                	mv	a1,s2
ffffffffc0203d72:	e73ff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203d76:	4501                	li	a0,0
ffffffffc0203d78:	000a0463          	beqz	s4,ffffffffc0203d80 <mm_map+0x7a>
ffffffffc0203d7c:	012a3023          	sd	s2,0(s4)
ffffffffc0203d80:	70e2                	ld	ra,56(sp)
ffffffffc0203d82:	7442                	ld	s0,48(sp)
ffffffffc0203d84:	74a2                	ld	s1,40(sp)
ffffffffc0203d86:	7902                	ld	s2,32(sp)
ffffffffc0203d88:	69e2                	ld	s3,24(sp)
ffffffffc0203d8a:	6a42                	ld	s4,16(sp)
ffffffffc0203d8c:	6aa2                	ld	s5,8(sp)
ffffffffc0203d8e:	6121                	addi	sp,sp,64
ffffffffc0203d90:	8082                	ret
ffffffffc0203d92:	5575                	li	a0,-3
ffffffffc0203d94:	b7f5                	j	ffffffffc0203d80 <mm_map+0x7a>
ffffffffc0203d96:	00009697          	auipc	a3,0x9
ffffffffc0203d9a:	16268693          	addi	a3,a3,354 # ffffffffc020cef8 <default_pmm_manager+0x8b8>
ffffffffc0203d9e:	00008617          	auipc	a2,0x8
ffffffffc0203da2:	dba60613          	addi	a2,a2,-582 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203da6:	0b300593          	li	a1,179
ffffffffc0203daa:	00009517          	auipc	a0,0x9
ffffffffc0203dae:	0c650513          	addi	a0,a0,198 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203db2:	eecfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203db6 <dup_mmap>:
ffffffffc0203db6:	7139                	addi	sp,sp,-64
ffffffffc0203db8:	fc06                	sd	ra,56(sp)
ffffffffc0203dba:	f822                	sd	s0,48(sp)
ffffffffc0203dbc:	f426                	sd	s1,40(sp)
ffffffffc0203dbe:	f04a                	sd	s2,32(sp)
ffffffffc0203dc0:	ec4e                	sd	s3,24(sp)
ffffffffc0203dc2:	e852                	sd	s4,16(sp)
ffffffffc0203dc4:	e456                	sd	s5,8(sp)
ffffffffc0203dc6:	c52d                	beqz	a0,ffffffffc0203e30 <dup_mmap+0x7a>
ffffffffc0203dc8:	892a                	mv	s2,a0
ffffffffc0203dca:	84ae                	mv	s1,a1
ffffffffc0203dcc:	842e                	mv	s0,a1
ffffffffc0203dce:	e595                	bnez	a1,ffffffffc0203dfa <dup_mmap+0x44>
ffffffffc0203dd0:	a085                	j	ffffffffc0203e30 <dup_mmap+0x7a>
ffffffffc0203dd2:	854a                	mv	a0,s2
ffffffffc0203dd4:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203dd8:	0145b823          	sd	s4,16(a1)
ffffffffc0203ddc:	0135ac23          	sw	s3,24(a1)
ffffffffc0203de0:	e05ff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203de4:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203de8:	fe843603          	ld	a2,-24(s0)
ffffffffc0203dec:	6c8c                	ld	a1,24(s1)
ffffffffc0203dee:	01893503          	ld	a0,24(s2)
ffffffffc0203df2:	4701                	li	a4,0
ffffffffc0203df4:	b4bfe0ef          	jal	ra,ffffffffc020293e <copy_range>
ffffffffc0203df8:	e105                	bnez	a0,ffffffffc0203e18 <dup_mmap+0x62>
ffffffffc0203dfa:	6000                	ld	s0,0(s0)
ffffffffc0203dfc:	02848863          	beq	s1,s0,ffffffffc0203e2c <dup_mmap+0x76>
ffffffffc0203e00:	03000513          	li	a0,48
ffffffffc0203e04:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203e08:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203e0c:	ff842983          	lw	s3,-8(s0)
ffffffffc0203e10:	97efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203e14:	85aa                	mv	a1,a0
ffffffffc0203e16:	fd55                	bnez	a0,ffffffffc0203dd2 <dup_mmap+0x1c>
ffffffffc0203e18:	5571                	li	a0,-4
ffffffffc0203e1a:	70e2                	ld	ra,56(sp)
ffffffffc0203e1c:	7442                	ld	s0,48(sp)
ffffffffc0203e1e:	74a2                	ld	s1,40(sp)
ffffffffc0203e20:	7902                	ld	s2,32(sp)
ffffffffc0203e22:	69e2                	ld	s3,24(sp)
ffffffffc0203e24:	6a42                	ld	s4,16(sp)
ffffffffc0203e26:	6aa2                	ld	s5,8(sp)
ffffffffc0203e28:	6121                	addi	sp,sp,64
ffffffffc0203e2a:	8082                	ret
ffffffffc0203e2c:	4501                	li	a0,0
ffffffffc0203e2e:	b7f5                	j	ffffffffc0203e1a <dup_mmap+0x64>
ffffffffc0203e30:	00009697          	auipc	a3,0x9
ffffffffc0203e34:	0d868693          	addi	a3,a3,216 # ffffffffc020cf08 <default_pmm_manager+0x8c8>
ffffffffc0203e38:	00008617          	auipc	a2,0x8
ffffffffc0203e3c:	d2060613          	addi	a2,a2,-736 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203e40:	0cf00593          	li	a1,207
ffffffffc0203e44:	00009517          	auipc	a0,0x9
ffffffffc0203e48:	02c50513          	addi	a0,a0,44 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203e4c:	e52fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e50 <exit_mmap>:
ffffffffc0203e50:	1101                	addi	sp,sp,-32
ffffffffc0203e52:	ec06                	sd	ra,24(sp)
ffffffffc0203e54:	e822                	sd	s0,16(sp)
ffffffffc0203e56:	e426                	sd	s1,8(sp)
ffffffffc0203e58:	e04a                	sd	s2,0(sp)
ffffffffc0203e5a:	c531                	beqz	a0,ffffffffc0203ea6 <exit_mmap+0x56>
ffffffffc0203e5c:	591c                	lw	a5,48(a0)
ffffffffc0203e5e:	84aa                	mv	s1,a0
ffffffffc0203e60:	e3b9                	bnez	a5,ffffffffc0203ea6 <exit_mmap+0x56>
ffffffffc0203e62:	6500                	ld	s0,8(a0)
ffffffffc0203e64:	01853903          	ld	s2,24(a0)
ffffffffc0203e68:	02850663          	beq	a0,s0,ffffffffc0203e94 <exit_mmap+0x44>
ffffffffc0203e6c:	ff043603          	ld	a2,-16(s0)
ffffffffc0203e70:	fe843583          	ld	a1,-24(s0)
ffffffffc0203e74:	854a                	mv	a0,s2
ffffffffc0203e76:	ef0fe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203e7a:	6400                	ld	s0,8(s0)
ffffffffc0203e7c:	fe8498e3          	bne	s1,s0,ffffffffc0203e6c <exit_mmap+0x1c>
ffffffffc0203e80:	6400                	ld	s0,8(s0)
ffffffffc0203e82:	00848c63          	beq	s1,s0,ffffffffc0203e9a <exit_mmap+0x4a>
ffffffffc0203e86:	ff043603          	ld	a2,-16(s0)
ffffffffc0203e8a:	fe843583          	ld	a1,-24(s0)
ffffffffc0203e8e:	854a                	mv	a0,s2
ffffffffc0203e90:	81dfe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203e94:	6400                	ld	s0,8(s0)
ffffffffc0203e96:	fe8498e3          	bne	s1,s0,ffffffffc0203e86 <exit_mmap+0x36>
ffffffffc0203e9a:	60e2                	ld	ra,24(sp)
ffffffffc0203e9c:	6442                	ld	s0,16(sp)
ffffffffc0203e9e:	64a2                	ld	s1,8(sp)
ffffffffc0203ea0:	6902                	ld	s2,0(sp)
ffffffffc0203ea2:	6105                	addi	sp,sp,32
ffffffffc0203ea4:	8082                	ret
ffffffffc0203ea6:	00009697          	auipc	a3,0x9
ffffffffc0203eaa:	08268693          	addi	a3,a3,130 # ffffffffc020cf28 <default_pmm_manager+0x8e8>
ffffffffc0203eae:	00008617          	auipc	a2,0x8
ffffffffc0203eb2:	caa60613          	addi	a2,a2,-854 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203eb6:	0e800593          	li	a1,232
ffffffffc0203eba:	00009517          	auipc	a0,0x9
ffffffffc0203ebe:	fb650513          	addi	a0,a0,-74 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203ec2:	ddcfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ec6 <vmm_init>:
ffffffffc0203ec6:	7139                	addi	sp,sp,-64
ffffffffc0203ec8:	05800513          	li	a0,88
ffffffffc0203ecc:	fc06                	sd	ra,56(sp)
ffffffffc0203ece:	f822                	sd	s0,48(sp)
ffffffffc0203ed0:	f426                	sd	s1,40(sp)
ffffffffc0203ed2:	f04a                	sd	s2,32(sp)
ffffffffc0203ed4:	ec4e                	sd	s3,24(sp)
ffffffffc0203ed6:	e852                	sd	s4,16(sp)
ffffffffc0203ed8:	e456                	sd	s5,8(sp)
ffffffffc0203eda:	8b4fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203ede:	2e050963          	beqz	a0,ffffffffc02041d0 <vmm_init+0x30a>
ffffffffc0203ee2:	e508                	sd	a0,8(a0)
ffffffffc0203ee4:	e108                	sd	a0,0(a0)
ffffffffc0203ee6:	00053823          	sd	zero,16(a0)
ffffffffc0203eea:	00053c23          	sd	zero,24(a0)
ffffffffc0203eee:	02052023          	sw	zero,32(a0)
ffffffffc0203ef2:	02053423          	sd	zero,40(a0)
ffffffffc0203ef6:	02052823          	sw	zero,48(a0)
ffffffffc0203efa:	84aa                	mv	s1,a0
ffffffffc0203efc:	4585                	li	a1,1
ffffffffc0203efe:	03850513          	addi	a0,a0,56
ffffffffc0203f02:	5b6000ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0203f06:	03200413          	li	s0,50
ffffffffc0203f0a:	a811                	j	ffffffffc0203f1e <vmm_init+0x58>
ffffffffc0203f0c:	e500                	sd	s0,8(a0)
ffffffffc0203f0e:	e91c                	sd	a5,16(a0)
ffffffffc0203f10:	00052c23          	sw	zero,24(a0)
ffffffffc0203f14:	146d                	addi	s0,s0,-5
ffffffffc0203f16:	8526                	mv	a0,s1
ffffffffc0203f18:	ccdff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203f1c:	c80d                	beqz	s0,ffffffffc0203f4e <vmm_init+0x88>
ffffffffc0203f1e:	03000513          	li	a0,48
ffffffffc0203f22:	86cfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f26:	85aa                	mv	a1,a0
ffffffffc0203f28:	00240793          	addi	a5,s0,2
ffffffffc0203f2c:	f165                	bnez	a0,ffffffffc0203f0c <vmm_init+0x46>
ffffffffc0203f2e:	00009697          	auipc	a3,0x9
ffffffffc0203f32:	19268693          	addi	a3,a3,402 # ffffffffc020d0c0 <default_pmm_manager+0xa80>
ffffffffc0203f36:	00008617          	auipc	a2,0x8
ffffffffc0203f3a:	c2260613          	addi	a2,a2,-990 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203f3e:	12c00593          	li	a1,300
ffffffffc0203f42:	00009517          	auipc	a0,0x9
ffffffffc0203f46:	f2e50513          	addi	a0,a0,-210 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203f4a:	d54fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203f4e:	03700413          	li	s0,55
ffffffffc0203f52:	1f900913          	li	s2,505
ffffffffc0203f56:	a819                	j	ffffffffc0203f6c <vmm_init+0xa6>
ffffffffc0203f58:	e500                	sd	s0,8(a0)
ffffffffc0203f5a:	e91c                	sd	a5,16(a0)
ffffffffc0203f5c:	00052c23          	sw	zero,24(a0)
ffffffffc0203f60:	0415                	addi	s0,s0,5
ffffffffc0203f62:	8526                	mv	a0,s1
ffffffffc0203f64:	c81ff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203f68:	03240a63          	beq	s0,s2,ffffffffc0203f9c <vmm_init+0xd6>
ffffffffc0203f6c:	03000513          	li	a0,48
ffffffffc0203f70:	81efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f74:	85aa                	mv	a1,a0
ffffffffc0203f76:	00240793          	addi	a5,s0,2
ffffffffc0203f7a:	fd79                	bnez	a0,ffffffffc0203f58 <vmm_init+0x92>
ffffffffc0203f7c:	00009697          	auipc	a3,0x9
ffffffffc0203f80:	14468693          	addi	a3,a3,324 # ffffffffc020d0c0 <default_pmm_manager+0xa80>
ffffffffc0203f84:	00008617          	auipc	a2,0x8
ffffffffc0203f88:	bd460613          	addi	a2,a2,-1068 # ffffffffc020bb58 <commands+0x210>
ffffffffc0203f8c:	13300593          	li	a1,307
ffffffffc0203f90:	00009517          	auipc	a0,0x9
ffffffffc0203f94:	ee050513          	addi	a0,a0,-288 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0203f98:	d06fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203f9c:	649c                	ld	a5,8(s1)
ffffffffc0203f9e:	471d                	li	a4,7
ffffffffc0203fa0:	1fb00593          	li	a1,507
ffffffffc0203fa4:	16f48663          	beq	s1,a5,ffffffffc0204110 <vmm_init+0x24a>
ffffffffc0203fa8:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc0203fac:	ffe70693          	addi	a3,a4,-2 # ffe <_binary_bin_swap_img_size-0x6d02>
ffffffffc0203fb0:	10d61063          	bne	a2,a3,ffffffffc02040b0 <vmm_init+0x1ea>
ffffffffc0203fb4:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203fb8:	0ed71c63          	bne	a4,a3,ffffffffc02040b0 <vmm_init+0x1ea>
ffffffffc0203fbc:	0715                	addi	a4,a4,5
ffffffffc0203fbe:	679c                	ld	a5,8(a5)
ffffffffc0203fc0:	feb712e3          	bne	a4,a1,ffffffffc0203fa4 <vmm_init+0xde>
ffffffffc0203fc4:	4a1d                	li	s4,7
ffffffffc0203fc6:	4415                	li	s0,5
ffffffffc0203fc8:	1f900a93          	li	s5,505
ffffffffc0203fcc:	85a2                	mv	a1,s0
ffffffffc0203fce:	8526                	mv	a0,s1
ffffffffc0203fd0:	bd5ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203fd4:	892a                	mv	s2,a0
ffffffffc0203fd6:	16050d63          	beqz	a0,ffffffffc0204150 <vmm_init+0x28a>
ffffffffc0203fda:	00140593          	addi	a1,s0,1
ffffffffc0203fde:	8526                	mv	a0,s1
ffffffffc0203fe0:	bc5ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203fe4:	89aa                	mv	s3,a0
ffffffffc0203fe6:	14050563          	beqz	a0,ffffffffc0204130 <vmm_init+0x26a>
ffffffffc0203fea:	85d2                	mv	a1,s4
ffffffffc0203fec:	8526                	mv	a0,s1
ffffffffc0203fee:	bb7ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203ff2:	16051f63          	bnez	a0,ffffffffc0204170 <vmm_init+0x2aa>
ffffffffc0203ff6:	00340593          	addi	a1,s0,3
ffffffffc0203ffa:	8526                	mv	a0,s1
ffffffffc0203ffc:	ba9ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0204000:	1a051863          	bnez	a0,ffffffffc02041b0 <vmm_init+0x2ea>
ffffffffc0204004:	00440593          	addi	a1,s0,4
ffffffffc0204008:	8526                	mv	a0,s1
ffffffffc020400a:	b9bff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc020400e:	18051163          	bnez	a0,ffffffffc0204190 <vmm_init+0x2ca>
ffffffffc0204012:	00893783          	ld	a5,8(s2)
ffffffffc0204016:	0a879d63          	bne	a5,s0,ffffffffc02040d0 <vmm_init+0x20a>
ffffffffc020401a:	01093783          	ld	a5,16(s2)
ffffffffc020401e:	0b479963          	bne	a5,s4,ffffffffc02040d0 <vmm_init+0x20a>
ffffffffc0204022:	0089b783          	ld	a5,8(s3)
ffffffffc0204026:	0c879563          	bne	a5,s0,ffffffffc02040f0 <vmm_init+0x22a>
ffffffffc020402a:	0109b783          	ld	a5,16(s3)
ffffffffc020402e:	0d479163          	bne	a5,s4,ffffffffc02040f0 <vmm_init+0x22a>
ffffffffc0204032:	0415                	addi	s0,s0,5
ffffffffc0204034:	0a15                	addi	s4,s4,5
ffffffffc0204036:	f9541be3          	bne	s0,s5,ffffffffc0203fcc <vmm_init+0x106>
ffffffffc020403a:	4411                	li	s0,4
ffffffffc020403c:	597d                	li	s2,-1
ffffffffc020403e:	85a2                	mv	a1,s0
ffffffffc0204040:	8526                	mv	a0,s1
ffffffffc0204042:	b63ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0204046:	0004059b          	sext.w	a1,s0
ffffffffc020404a:	c90d                	beqz	a0,ffffffffc020407c <vmm_init+0x1b6>
ffffffffc020404c:	6914                	ld	a3,16(a0)
ffffffffc020404e:	6510                	ld	a2,8(a0)
ffffffffc0204050:	00009517          	auipc	a0,0x9
ffffffffc0204054:	ff850513          	addi	a0,a0,-8 # ffffffffc020d048 <default_pmm_manager+0xa08>
ffffffffc0204058:	94efc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020405c:	00009697          	auipc	a3,0x9
ffffffffc0204060:	01468693          	addi	a3,a3,20 # ffffffffc020d070 <default_pmm_manager+0xa30>
ffffffffc0204064:	00008617          	auipc	a2,0x8
ffffffffc0204068:	af460613          	addi	a2,a2,-1292 # ffffffffc020bb58 <commands+0x210>
ffffffffc020406c:	15900593          	li	a1,345
ffffffffc0204070:	00009517          	auipc	a0,0x9
ffffffffc0204074:	e0050513          	addi	a0,a0,-512 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc0204078:	c26fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020407c:	147d                	addi	s0,s0,-1
ffffffffc020407e:	fd2410e3          	bne	s0,s2,ffffffffc020403e <vmm_init+0x178>
ffffffffc0204082:	8526                	mv	a0,s1
ffffffffc0204084:	c31ff0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0204088:	00009517          	auipc	a0,0x9
ffffffffc020408c:	00050513          	mv	a0,a0
ffffffffc0204090:	916fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204094:	7442                	ld	s0,48(sp)
ffffffffc0204096:	70e2                	ld	ra,56(sp)
ffffffffc0204098:	74a2                	ld	s1,40(sp)
ffffffffc020409a:	7902                	ld	s2,32(sp)
ffffffffc020409c:	69e2                	ld	s3,24(sp)
ffffffffc020409e:	6a42                	ld	s4,16(sp)
ffffffffc02040a0:	6aa2                	ld	s5,8(sp)
ffffffffc02040a2:	00009517          	auipc	a0,0x9
ffffffffc02040a6:	00650513          	addi	a0,a0,6 # ffffffffc020d0a8 <default_pmm_manager+0xa68>
ffffffffc02040aa:	6121                	addi	sp,sp,64
ffffffffc02040ac:	8fafc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02040b0:	00009697          	auipc	a3,0x9
ffffffffc02040b4:	eb068693          	addi	a3,a3,-336 # ffffffffc020cf60 <default_pmm_manager+0x920>
ffffffffc02040b8:	00008617          	auipc	a2,0x8
ffffffffc02040bc:	aa060613          	addi	a2,a2,-1376 # ffffffffc020bb58 <commands+0x210>
ffffffffc02040c0:	13d00593          	li	a1,317
ffffffffc02040c4:	00009517          	auipc	a0,0x9
ffffffffc02040c8:	dac50513          	addi	a0,a0,-596 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc02040cc:	bd2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040d0:	00009697          	auipc	a3,0x9
ffffffffc02040d4:	f1868693          	addi	a3,a3,-232 # ffffffffc020cfe8 <default_pmm_manager+0x9a8>
ffffffffc02040d8:	00008617          	auipc	a2,0x8
ffffffffc02040dc:	a8060613          	addi	a2,a2,-1408 # ffffffffc020bb58 <commands+0x210>
ffffffffc02040e0:	14e00593          	li	a1,334
ffffffffc02040e4:	00009517          	auipc	a0,0x9
ffffffffc02040e8:	d8c50513          	addi	a0,a0,-628 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc02040ec:	bb2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040f0:	00009697          	auipc	a3,0x9
ffffffffc02040f4:	f2868693          	addi	a3,a3,-216 # ffffffffc020d018 <default_pmm_manager+0x9d8>
ffffffffc02040f8:	00008617          	auipc	a2,0x8
ffffffffc02040fc:	a6060613          	addi	a2,a2,-1440 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204100:	14f00593          	li	a1,335
ffffffffc0204104:	00009517          	auipc	a0,0x9
ffffffffc0204108:	d6c50513          	addi	a0,a0,-660 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc020410c:	b92fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204110:	00009697          	auipc	a3,0x9
ffffffffc0204114:	e3868693          	addi	a3,a3,-456 # ffffffffc020cf48 <default_pmm_manager+0x908>
ffffffffc0204118:	00008617          	auipc	a2,0x8
ffffffffc020411c:	a4060613          	addi	a2,a2,-1472 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204120:	13b00593          	li	a1,315
ffffffffc0204124:	00009517          	auipc	a0,0x9
ffffffffc0204128:	d4c50513          	addi	a0,a0,-692 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc020412c:	b72fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204130:	00009697          	auipc	a3,0x9
ffffffffc0204134:	e7868693          	addi	a3,a3,-392 # ffffffffc020cfa8 <default_pmm_manager+0x968>
ffffffffc0204138:	00008617          	auipc	a2,0x8
ffffffffc020413c:	a2060613          	addi	a2,a2,-1504 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204140:	14600593          	li	a1,326
ffffffffc0204144:	00009517          	auipc	a0,0x9
ffffffffc0204148:	d2c50513          	addi	a0,a0,-724 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc020414c:	b52fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204150:	00009697          	auipc	a3,0x9
ffffffffc0204154:	e4868693          	addi	a3,a3,-440 # ffffffffc020cf98 <default_pmm_manager+0x958>
ffffffffc0204158:	00008617          	auipc	a2,0x8
ffffffffc020415c:	a0060613          	addi	a2,a2,-1536 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204160:	14400593          	li	a1,324
ffffffffc0204164:	00009517          	auipc	a0,0x9
ffffffffc0204168:	d0c50513          	addi	a0,a0,-756 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc020416c:	b32fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204170:	00009697          	auipc	a3,0x9
ffffffffc0204174:	e4868693          	addi	a3,a3,-440 # ffffffffc020cfb8 <default_pmm_manager+0x978>
ffffffffc0204178:	00008617          	auipc	a2,0x8
ffffffffc020417c:	9e060613          	addi	a2,a2,-1568 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204180:	14800593          	li	a1,328
ffffffffc0204184:	00009517          	auipc	a0,0x9
ffffffffc0204188:	cec50513          	addi	a0,a0,-788 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc020418c:	b12fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204190:	00009697          	auipc	a3,0x9
ffffffffc0204194:	e4868693          	addi	a3,a3,-440 # ffffffffc020cfd8 <default_pmm_manager+0x998>
ffffffffc0204198:	00008617          	auipc	a2,0x8
ffffffffc020419c:	9c060613          	addi	a2,a2,-1600 # ffffffffc020bb58 <commands+0x210>
ffffffffc02041a0:	14c00593          	li	a1,332
ffffffffc02041a4:	00009517          	auipc	a0,0x9
ffffffffc02041a8:	ccc50513          	addi	a0,a0,-820 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc02041ac:	af2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b0:	00009697          	auipc	a3,0x9
ffffffffc02041b4:	e1868693          	addi	a3,a3,-488 # ffffffffc020cfc8 <default_pmm_manager+0x988>
ffffffffc02041b8:	00008617          	auipc	a2,0x8
ffffffffc02041bc:	9a060613          	addi	a2,a2,-1632 # ffffffffc020bb58 <commands+0x210>
ffffffffc02041c0:	14a00593          	li	a1,330
ffffffffc02041c4:	00009517          	auipc	a0,0x9
ffffffffc02041c8:	cac50513          	addi	a0,a0,-852 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc02041cc:	ad2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041d0:	00009697          	auipc	a3,0x9
ffffffffc02041d4:	d2868693          	addi	a3,a3,-728 # ffffffffc020cef8 <default_pmm_manager+0x8b8>
ffffffffc02041d8:	00008617          	auipc	a2,0x8
ffffffffc02041dc:	98060613          	addi	a2,a2,-1664 # ffffffffc020bb58 <commands+0x210>
ffffffffc02041e0:	12400593          	li	a1,292
ffffffffc02041e4:	00009517          	auipc	a0,0x9
ffffffffc02041e8:	c8c50513          	addi	a0,a0,-884 # ffffffffc020ce70 <default_pmm_manager+0x830>
ffffffffc02041ec:	ab2fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02041f0 <user_mem_check>:
ffffffffc02041f0:	7179                	addi	sp,sp,-48
ffffffffc02041f2:	f022                	sd	s0,32(sp)
ffffffffc02041f4:	f406                	sd	ra,40(sp)
ffffffffc02041f6:	ec26                	sd	s1,24(sp)
ffffffffc02041f8:	e84a                	sd	s2,16(sp)
ffffffffc02041fa:	e44e                	sd	s3,8(sp)
ffffffffc02041fc:	e052                	sd	s4,0(sp)
ffffffffc02041fe:	842e                	mv	s0,a1
ffffffffc0204200:	c135                	beqz	a0,ffffffffc0204264 <user_mem_check+0x74>
ffffffffc0204202:	002007b7          	lui	a5,0x200
ffffffffc0204206:	04f5e663          	bltu	a1,a5,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc020420a:	00c584b3          	add	s1,a1,a2
ffffffffc020420e:	0495f263          	bgeu	a1,s1,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204212:	4785                	li	a5,1
ffffffffc0204214:	07fe                	slli	a5,a5,0x1f
ffffffffc0204216:	0297ee63          	bltu	a5,s1,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc020421a:	892a                	mv	s2,a0
ffffffffc020421c:	89b6                	mv	s3,a3
ffffffffc020421e:	6a05                	lui	s4,0x1
ffffffffc0204220:	a821                	j	ffffffffc0204238 <user_mem_check+0x48>
ffffffffc0204222:	0027f693          	andi	a3,a5,2
ffffffffc0204226:	9752                	add	a4,a4,s4
ffffffffc0204228:	8ba1                	andi	a5,a5,8
ffffffffc020422a:	c685                	beqz	a3,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc020422c:	c399                	beqz	a5,ffffffffc0204232 <user_mem_check+0x42>
ffffffffc020422e:	02e46263          	bltu	s0,a4,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204232:	6900                	ld	s0,16(a0)
ffffffffc0204234:	04947663          	bgeu	s0,s1,ffffffffc0204280 <user_mem_check+0x90>
ffffffffc0204238:	85a2                	mv	a1,s0
ffffffffc020423a:	854a                	mv	a0,s2
ffffffffc020423c:	969ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0204240:	c909                	beqz	a0,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204242:	6518                	ld	a4,8(a0)
ffffffffc0204244:	00e46763          	bltu	s0,a4,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204248:	4d1c                	lw	a5,24(a0)
ffffffffc020424a:	fc099ce3          	bnez	s3,ffffffffc0204222 <user_mem_check+0x32>
ffffffffc020424e:	8b85                	andi	a5,a5,1
ffffffffc0204250:	f3ed                	bnez	a5,ffffffffc0204232 <user_mem_check+0x42>
ffffffffc0204252:	4501                	li	a0,0
ffffffffc0204254:	70a2                	ld	ra,40(sp)
ffffffffc0204256:	7402                	ld	s0,32(sp)
ffffffffc0204258:	64e2                	ld	s1,24(sp)
ffffffffc020425a:	6942                	ld	s2,16(sp)
ffffffffc020425c:	69a2                	ld	s3,8(sp)
ffffffffc020425e:	6a02                	ld	s4,0(sp)
ffffffffc0204260:	6145                	addi	sp,sp,48
ffffffffc0204262:	8082                	ret
ffffffffc0204264:	c02007b7          	lui	a5,0xc0200
ffffffffc0204268:	4501                	li	a0,0
ffffffffc020426a:	fef5e5e3          	bltu	a1,a5,ffffffffc0204254 <user_mem_check+0x64>
ffffffffc020426e:	962e                	add	a2,a2,a1
ffffffffc0204270:	fec5f2e3          	bgeu	a1,a2,ffffffffc0204254 <user_mem_check+0x64>
ffffffffc0204274:	c8000537          	lui	a0,0xc8000
ffffffffc0204278:	0505                	addi	a0,a0,1
ffffffffc020427a:	00a63533          	sltu	a0,a2,a0
ffffffffc020427e:	bfd9                	j	ffffffffc0204254 <user_mem_check+0x64>
ffffffffc0204280:	4505                	li	a0,1
ffffffffc0204282:	bfc9                	j	ffffffffc0204254 <user_mem_check+0x64>

ffffffffc0204284 <copy_from_user>:
ffffffffc0204284:	1101                	addi	sp,sp,-32
ffffffffc0204286:	e822                	sd	s0,16(sp)
ffffffffc0204288:	e426                	sd	s1,8(sp)
ffffffffc020428a:	8432                	mv	s0,a2
ffffffffc020428c:	84b6                	mv	s1,a3
ffffffffc020428e:	e04a                	sd	s2,0(sp)
ffffffffc0204290:	86ba                	mv	a3,a4
ffffffffc0204292:	892e                	mv	s2,a1
ffffffffc0204294:	8626                	mv	a2,s1
ffffffffc0204296:	85a2                	mv	a1,s0
ffffffffc0204298:	ec06                	sd	ra,24(sp)
ffffffffc020429a:	f57ff0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc020429e:	c519                	beqz	a0,ffffffffc02042ac <copy_from_user+0x28>
ffffffffc02042a0:	8626                	mv	a2,s1
ffffffffc02042a2:	85a2                	mv	a1,s0
ffffffffc02042a4:	854a                	mv	a0,s2
ffffffffc02042a6:	422070ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc02042aa:	4505                	li	a0,1
ffffffffc02042ac:	60e2                	ld	ra,24(sp)
ffffffffc02042ae:	6442                	ld	s0,16(sp)
ffffffffc02042b0:	64a2                	ld	s1,8(sp)
ffffffffc02042b2:	6902                	ld	s2,0(sp)
ffffffffc02042b4:	6105                	addi	sp,sp,32
ffffffffc02042b6:	8082                	ret

ffffffffc02042b8 <copy_to_user>:
ffffffffc02042b8:	1101                	addi	sp,sp,-32
ffffffffc02042ba:	e822                	sd	s0,16(sp)
ffffffffc02042bc:	8436                	mv	s0,a3
ffffffffc02042be:	e04a                	sd	s2,0(sp)
ffffffffc02042c0:	4685                	li	a3,1
ffffffffc02042c2:	8932                	mv	s2,a2
ffffffffc02042c4:	8622                	mv	a2,s0
ffffffffc02042c6:	e426                	sd	s1,8(sp)
ffffffffc02042c8:	ec06                	sd	ra,24(sp)
ffffffffc02042ca:	84ae                	mv	s1,a1
ffffffffc02042cc:	f25ff0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc02042d0:	c519                	beqz	a0,ffffffffc02042de <copy_to_user+0x26>
ffffffffc02042d2:	8622                	mv	a2,s0
ffffffffc02042d4:	85ca                	mv	a1,s2
ffffffffc02042d6:	8526                	mv	a0,s1
ffffffffc02042d8:	3f0070ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc02042dc:	4505                	li	a0,1
ffffffffc02042de:	60e2                	ld	ra,24(sp)
ffffffffc02042e0:	6442                	ld	s0,16(sp)
ffffffffc02042e2:	64a2                	ld	s1,8(sp)
ffffffffc02042e4:	6902                	ld	s2,0(sp)
ffffffffc02042e6:	6105                	addi	sp,sp,32
ffffffffc02042e8:	8082                	ret

ffffffffc02042ea <copy_string>:
ffffffffc02042ea:	7139                	addi	sp,sp,-64
ffffffffc02042ec:	ec4e                	sd	s3,24(sp)
ffffffffc02042ee:	6985                	lui	s3,0x1
ffffffffc02042f0:	99b2                	add	s3,s3,a2
ffffffffc02042f2:	77fd                	lui	a5,0xfffff
ffffffffc02042f4:	00f9f9b3          	and	s3,s3,a5
ffffffffc02042f8:	f426                	sd	s1,40(sp)
ffffffffc02042fa:	f04a                	sd	s2,32(sp)
ffffffffc02042fc:	e852                	sd	s4,16(sp)
ffffffffc02042fe:	e456                	sd	s5,8(sp)
ffffffffc0204300:	fc06                	sd	ra,56(sp)
ffffffffc0204302:	f822                	sd	s0,48(sp)
ffffffffc0204304:	84b2                	mv	s1,a2
ffffffffc0204306:	8aaa                	mv	s5,a0
ffffffffc0204308:	8a2e                	mv	s4,a1
ffffffffc020430a:	8936                	mv	s2,a3
ffffffffc020430c:	40c989b3          	sub	s3,s3,a2
ffffffffc0204310:	a015                	j	ffffffffc0204334 <copy_string+0x4a>
ffffffffc0204312:	2dc070ef          	jal	ra,ffffffffc020b5ee <strnlen>
ffffffffc0204316:	87aa                	mv	a5,a0
ffffffffc0204318:	85a6                	mv	a1,s1
ffffffffc020431a:	8552                	mv	a0,s4
ffffffffc020431c:	8622                	mv	a2,s0
ffffffffc020431e:	0487e363          	bltu	a5,s0,ffffffffc0204364 <copy_string+0x7a>
ffffffffc0204322:	0329f763          	bgeu	s3,s2,ffffffffc0204350 <copy_string+0x66>
ffffffffc0204326:	3a2070ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020432a:	9a22                	add	s4,s4,s0
ffffffffc020432c:	94a2                	add	s1,s1,s0
ffffffffc020432e:	40890933          	sub	s2,s2,s0
ffffffffc0204332:	6985                	lui	s3,0x1
ffffffffc0204334:	4681                	li	a3,0
ffffffffc0204336:	85a6                	mv	a1,s1
ffffffffc0204338:	8556                	mv	a0,s5
ffffffffc020433a:	844a                	mv	s0,s2
ffffffffc020433c:	0129f363          	bgeu	s3,s2,ffffffffc0204342 <copy_string+0x58>
ffffffffc0204340:	844e                	mv	s0,s3
ffffffffc0204342:	8622                	mv	a2,s0
ffffffffc0204344:	eadff0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0204348:	87aa                	mv	a5,a0
ffffffffc020434a:	85a2                	mv	a1,s0
ffffffffc020434c:	8526                	mv	a0,s1
ffffffffc020434e:	f3f1                	bnez	a5,ffffffffc0204312 <copy_string+0x28>
ffffffffc0204350:	4501                	li	a0,0
ffffffffc0204352:	70e2                	ld	ra,56(sp)
ffffffffc0204354:	7442                	ld	s0,48(sp)
ffffffffc0204356:	74a2                	ld	s1,40(sp)
ffffffffc0204358:	7902                	ld	s2,32(sp)
ffffffffc020435a:	69e2                	ld	s3,24(sp)
ffffffffc020435c:	6a42                	ld	s4,16(sp)
ffffffffc020435e:	6aa2                	ld	s5,8(sp)
ffffffffc0204360:	6121                	addi	sp,sp,64
ffffffffc0204362:	8082                	ret
ffffffffc0204364:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc0204368:	360070ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020436c:	4505                	li	a0,1
ffffffffc020436e:	b7d5                	j	ffffffffc0204352 <copy_string+0x68>

ffffffffc0204370 <__down.constprop.0>:
ffffffffc0204370:	715d                	addi	sp,sp,-80
ffffffffc0204372:	e0a2                	sd	s0,64(sp)
ffffffffc0204374:	e486                	sd	ra,72(sp)
ffffffffc0204376:	fc26                	sd	s1,56(sp)
ffffffffc0204378:	842a                	mv	s0,a0
ffffffffc020437a:	100027f3          	csrr	a5,sstatus
ffffffffc020437e:	8b89                	andi	a5,a5,2
ffffffffc0204380:	ebb1                	bnez	a5,ffffffffc02043d4 <__down.constprop.0+0x64>
ffffffffc0204382:	411c                	lw	a5,0(a0)
ffffffffc0204384:	00f05a63          	blez	a5,ffffffffc0204398 <__down.constprop.0+0x28>
ffffffffc0204388:	37fd                	addiw	a5,a5,-1
ffffffffc020438a:	c11c                	sw	a5,0(a0)
ffffffffc020438c:	4501                	li	a0,0
ffffffffc020438e:	60a6                	ld	ra,72(sp)
ffffffffc0204390:	6406                	ld	s0,64(sp)
ffffffffc0204392:	74e2                	ld	s1,56(sp)
ffffffffc0204394:	6161                	addi	sp,sp,80
ffffffffc0204396:	8082                	ret
ffffffffc0204398:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc020439c:	0024                	addi	s1,sp,8
ffffffffc020439e:	10000613          	li	a2,256
ffffffffc02043a2:	85a6                	mv	a1,s1
ffffffffc02043a4:	8522                	mv	a0,s0
ffffffffc02043a6:	2d8000ef          	jal	ra,ffffffffc020467e <wait_current_set>
ffffffffc02043aa:	178030ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc02043ae:	100027f3          	csrr	a5,sstatus
ffffffffc02043b2:	8b89                	andi	a5,a5,2
ffffffffc02043b4:	efb9                	bnez	a5,ffffffffc0204412 <__down.constprop.0+0xa2>
ffffffffc02043b6:	8526                	mv	a0,s1
ffffffffc02043b8:	19c000ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc02043bc:	e531                	bnez	a0,ffffffffc0204408 <__down.constprop.0+0x98>
ffffffffc02043be:	4542                	lw	a0,16(sp)
ffffffffc02043c0:	10000793          	li	a5,256
ffffffffc02043c4:	fcf515e3          	bne	a0,a5,ffffffffc020438e <__down.constprop.0+0x1e>
ffffffffc02043c8:	60a6                	ld	ra,72(sp)
ffffffffc02043ca:	6406                	ld	s0,64(sp)
ffffffffc02043cc:	74e2                	ld	s1,56(sp)
ffffffffc02043ce:	4501                	li	a0,0
ffffffffc02043d0:	6161                	addi	sp,sp,80
ffffffffc02043d2:	8082                	ret
ffffffffc02043d4:	89ffc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02043d8:	401c                	lw	a5,0(s0)
ffffffffc02043da:	00f05c63          	blez	a5,ffffffffc02043f2 <__down.constprop.0+0x82>
ffffffffc02043de:	37fd                	addiw	a5,a5,-1
ffffffffc02043e0:	c01c                	sw	a5,0(s0)
ffffffffc02043e2:	88bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02043e6:	60a6                	ld	ra,72(sp)
ffffffffc02043e8:	6406                	ld	s0,64(sp)
ffffffffc02043ea:	74e2                	ld	s1,56(sp)
ffffffffc02043ec:	4501                	li	a0,0
ffffffffc02043ee:	6161                	addi	sp,sp,80
ffffffffc02043f0:	8082                	ret
ffffffffc02043f2:	0421                	addi	s0,s0,8
ffffffffc02043f4:	0024                	addi	s1,sp,8
ffffffffc02043f6:	10000613          	li	a2,256
ffffffffc02043fa:	85a6                	mv	a1,s1
ffffffffc02043fc:	8522                	mv	a0,s0
ffffffffc02043fe:	280000ef          	jal	ra,ffffffffc020467e <wait_current_set>
ffffffffc0204402:	86bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204406:	b755                	j	ffffffffc02043aa <__down.constprop.0+0x3a>
ffffffffc0204408:	85a6                	mv	a1,s1
ffffffffc020440a:	8522                	mv	a0,s0
ffffffffc020440c:	0ee000ef          	jal	ra,ffffffffc02044fa <wait_queue_del>
ffffffffc0204410:	b77d                	j	ffffffffc02043be <__down.constprop.0+0x4e>
ffffffffc0204412:	861fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204416:	8526                	mv	a0,s1
ffffffffc0204418:	13c000ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc020441c:	e501                	bnez	a0,ffffffffc0204424 <__down.constprop.0+0xb4>
ffffffffc020441e:	84ffc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204422:	bf71                	j	ffffffffc02043be <__down.constprop.0+0x4e>
ffffffffc0204424:	85a6                	mv	a1,s1
ffffffffc0204426:	8522                	mv	a0,s0
ffffffffc0204428:	0d2000ef          	jal	ra,ffffffffc02044fa <wait_queue_del>
ffffffffc020442c:	bfcd                	j	ffffffffc020441e <__down.constprop.0+0xae>

ffffffffc020442e <__up.constprop.0>:
ffffffffc020442e:	1101                	addi	sp,sp,-32
ffffffffc0204430:	e822                	sd	s0,16(sp)
ffffffffc0204432:	ec06                	sd	ra,24(sp)
ffffffffc0204434:	e426                	sd	s1,8(sp)
ffffffffc0204436:	e04a                	sd	s2,0(sp)
ffffffffc0204438:	842a                	mv	s0,a0
ffffffffc020443a:	100027f3          	csrr	a5,sstatus
ffffffffc020443e:	8b89                	andi	a5,a5,2
ffffffffc0204440:	4901                	li	s2,0
ffffffffc0204442:	eba1                	bnez	a5,ffffffffc0204492 <__up.constprop.0+0x64>
ffffffffc0204444:	00840493          	addi	s1,s0,8
ffffffffc0204448:	8526                	mv	a0,s1
ffffffffc020444a:	0ee000ef          	jal	ra,ffffffffc0204538 <wait_queue_first>
ffffffffc020444e:	85aa                	mv	a1,a0
ffffffffc0204450:	cd0d                	beqz	a0,ffffffffc020448a <__up.constprop.0+0x5c>
ffffffffc0204452:	6118                	ld	a4,0(a0)
ffffffffc0204454:	10000793          	li	a5,256
ffffffffc0204458:	0ec72703          	lw	a4,236(a4)
ffffffffc020445c:	02f71f63          	bne	a4,a5,ffffffffc020449a <__up.constprop.0+0x6c>
ffffffffc0204460:	4685                	li	a3,1
ffffffffc0204462:	10000613          	li	a2,256
ffffffffc0204466:	8526                	mv	a0,s1
ffffffffc0204468:	0fa000ef          	jal	ra,ffffffffc0204562 <wakeup_wait>
ffffffffc020446c:	00091863          	bnez	s2,ffffffffc020447c <__up.constprop.0+0x4e>
ffffffffc0204470:	60e2                	ld	ra,24(sp)
ffffffffc0204472:	6442                	ld	s0,16(sp)
ffffffffc0204474:	64a2                	ld	s1,8(sp)
ffffffffc0204476:	6902                	ld	s2,0(sp)
ffffffffc0204478:	6105                	addi	sp,sp,32
ffffffffc020447a:	8082                	ret
ffffffffc020447c:	6442                	ld	s0,16(sp)
ffffffffc020447e:	60e2                	ld	ra,24(sp)
ffffffffc0204480:	64a2                	ld	s1,8(sp)
ffffffffc0204482:	6902                	ld	s2,0(sp)
ffffffffc0204484:	6105                	addi	sp,sp,32
ffffffffc0204486:	fe6fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020448a:	401c                	lw	a5,0(s0)
ffffffffc020448c:	2785                	addiw	a5,a5,1
ffffffffc020448e:	c01c                	sw	a5,0(s0)
ffffffffc0204490:	bff1                	j	ffffffffc020446c <__up.constprop.0+0x3e>
ffffffffc0204492:	fe0fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204496:	4905                	li	s2,1
ffffffffc0204498:	b775                	j	ffffffffc0204444 <__up.constprop.0+0x16>
ffffffffc020449a:	00009697          	auipc	a3,0x9
ffffffffc020449e:	c3668693          	addi	a3,a3,-970 # ffffffffc020d0d0 <default_pmm_manager+0xa90>
ffffffffc02044a2:	00007617          	auipc	a2,0x7
ffffffffc02044a6:	6b660613          	addi	a2,a2,1718 # ffffffffc020bb58 <commands+0x210>
ffffffffc02044aa:	45e5                	li	a1,25
ffffffffc02044ac:	00009517          	auipc	a0,0x9
ffffffffc02044b0:	c4c50513          	addi	a0,a0,-948 # ffffffffc020d0f8 <default_pmm_manager+0xab8>
ffffffffc02044b4:	febfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02044b8 <sem_init>:
ffffffffc02044b8:	c10c                	sw	a1,0(a0)
ffffffffc02044ba:	0521                	addi	a0,a0,8
ffffffffc02044bc:	a825                	j	ffffffffc02044f4 <wait_queue_init>

ffffffffc02044be <up>:
ffffffffc02044be:	f71ff06f          	j	ffffffffc020442e <__up.constprop.0>

ffffffffc02044c2 <down>:
ffffffffc02044c2:	1141                	addi	sp,sp,-16
ffffffffc02044c4:	e406                	sd	ra,8(sp)
ffffffffc02044c6:	eabff0ef          	jal	ra,ffffffffc0204370 <__down.constprop.0>
ffffffffc02044ca:	2501                	sext.w	a0,a0
ffffffffc02044cc:	e501                	bnez	a0,ffffffffc02044d4 <down+0x12>
ffffffffc02044ce:	60a2                	ld	ra,8(sp)
ffffffffc02044d0:	0141                	addi	sp,sp,16
ffffffffc02044d2:	8082                	ret
ffffffffc02044d4:	00009697          	auipc	a3,0x9
ffffffffc02044d8:	c3468693          	addi	a3,a3,-972 # ffffffffc020d108 <default_pmm_manager+0xac8>
ffffffffc02044dc:	00007617          	auipc	a2,0x7
ffffffffc02044e0:	67c60613          	addi	a2,a2,1660 # ffffffffc020bb58 <commands+0x210>
ffffffffc02044e4:	04000593          	li	a1,64
ffffffffc02044e8:	00009517          	auipc	a0,0x9
ffffffffc02044ec:	c1050513          	addi	a0,a0,-1008 # ffffffffc020d0f8 <default_pmm_manager+0xab8>
ffffffffc02044f0:	faffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02044f4 <wait_queue_init>:
ffffffffc02044f4:	e508                	sd	a0,8(a0)
ffffffffc02044f6:	e108                	sd	a0,0(a0)
ffffffffc02044f8:	8082                	ret

ffffffffc02044fa <wait_queue_del>:
ffffffffc02044fa:	7198                	ld	a4,32(a1)
ffffffffc02044fc:	01858793          	addi	a5,a1,24
ffffffffc0204500:	00e78b63          	beq	a5,a4,ffffffffc0204516 <wait_queue_del+0x1c>
ffffffffc0204504:	6994                	ld	a3,16(a1)
ffffffffc0204506:	00a69863          	bne	a3,a0,ffffffffc0204516 <wait_queue_del+0x1c>
ffffffffc020450a:	6d94                	ld	a3,24(a1)
ffffffffc020450c:	e698                	sd	a4,8(a3)
ffffffffc020450e:	e314                	sd	a3,0(a4)
ffffffffc0204510:	f19c                	sd	a5,32(a1)
ffffffffc0204512:	ed9c                	sd	a5,24(a1)
ffffffffc0204514:	8082                	ret
ffffffffc0204516:	1141                	addi	sp,sp,-16
ffffffffc0204518:	00009697          	auipc	a3,0x9
ffffffffc020451c:	c5068693          	addi	a3,a3,-944 # ffffffffc020d168 <default_pmm_manager+0xb28>
ffffffffc0204520:	00007617          	auipc	a2,0x7
ffffffffc0204524:	63860613          	addi	a2,a2,1592 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204528:	45f1                	li	a1,28
ffffffffc020452a:	00009517          	auipc	a0,0x9
ffffffffc020452e:	c2650513          	addi	a0,a0,-986 # ffffffffc020d150 <default_pmm_manager+0xb10>
ffffffffc0204532:	e406                	sd	ra,8(sp)
ffffffffc0204534:	f6bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204538 <wait_queue_first>:
ffffffffc0204538:	651c                	ld	a5,8(a0)
ffffffffc020453a:	00f50563          	beq	a0,a5,ffffffffc0204544 <wait_queue_first+0xc>
ffffffffc020453e:	fe878513          	addi	a0,a5,-24
ffffffffc0204542:	8082                	ret
ffffffffc0204544:	4501                	li	a0,0
ffffffffc0204546:	8082                	ret

ffffffffc0204548 <wait_queue_empty>:
ffffffffc0204548:	651c                	ld	a5,8(a0)
ffffffffc020454a:	40a78533          	sub	a0,a5,a0
ffffffffc020454e:	00153513          	seqz	a0,a0
ffffffffc0204552:	8082                	ret

ffffffffc0204554 <wait_in_queue>:
ffffffffc0204554:	711c                	ld	a5,32(a0)
ffffffffc0204556:	0561                	addi	a0,a0,24
ffffffffc0204558:	40a78533          	sub	a0,a5,a0
ffffffffc020455c:	00a03533          	snez	a0,a0
ffffffffc0204560:	8082                	ret

ffffffffc0204562 <wakeup_wait>:
ffffffffc0204562:	e689                	bnez	a3,ffffffffc020456c <wakeup_wait+0xa>
ffffffffc0204564:	6188                	ld	a0,0(a1)
ffffffffc0204566:	c590                	sw	a2,8(a1)
ffffffffc0204568:	7090206f          	j	ffffffffc0207470 <wakeup_proc>
ffffffffc020456c:	7198                	ld	a4,32(a1)
ffffffffc020456e:	01858793          	addi	a5,a1,24
ffffffffc0204572:	00e78e63          	beq	a5,a4,ffffffffc020458e <wakeup_wait+0x2c>
ffffffffc0204576:	6994                	ld	a3,16(a1)
ffffffffc0204578:	00d51b63          	bne	a0,a3,ffffffffc020458e <wakeup_wait+0x2c>
ffffffffc020457c:	6d94                	ld	a3,24(a1)
ffffffffc020457e:	6188                	ld	a0,0(a1)
ffffffffc0204580:	e698                	sd	a4,8(a3)
ffffffffc0204582:	e314                	sd	a3,0(a4)
ffffffffc0204584:	f19c                	sd	a5,32(a1)
ffffffffc0204586:	ed9c                	sd	a5,24(a1)
ffffffffc0204588:	c590                	sw	a2,8(a1)
ffffffffc020458a:	6e70206f          	j	ffffffffc0207470 <wakeup_proc>
ffffffffc020458e:	1141                	addi	sp,sp,-16
ffffffffc0204590:	00009697          	auipc	a3,0x9
ffffffffc0204594:	bd868693          	addi	a3,a3,-1064 # ffffffffc020d168 <default_pmm_manager+0xb28>
ffffffffc0204598:	00007617          	auipc	a2,0x7
ffffffffc020459c:	5c060613          	addi	a2,a2,1472 # ffffffffc020bb58 <commands+0x210>
ffffffffc02045a0:	45f1                	li	a1,28
ffffffffc02045a2:	00009517          	auipc	a0,0x9
ffffffffc02045a6:	bae50513          	addi	a0,a0,-1106 # ffffffffc020d150 <default_pmm_manager+0xb10>
ffffffffc02045aa:	e406                	sd	ra,8(sp)
ffffffffc02045ac:	ef3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045b0 <wakeup_queue>:
ffffffffc02045b0:	651c                	ld	a5,8(a0)
ffffffffc02045b2:	0ca78563          	beq	a5,a0,ffffffffc020467c <wakeup_queue+0xcc>
ffffffffc02045b6:	1101                	addi	sp,sp,-32
ffffffffc02045b8:	e822                	sd	s0,16(sp)
ffffffffc02045ba:	e426                	sd	s1,8(sp)
ffffffffc02045bc:	e04a                	sd	s2,0(sp)
ffffffffc02045be:	ec06                	sd	ra,24(sp)
ffffffffc02045c0:	84aa                	mv	s1,a0
ffffffffc02045c2:	892e                	mv	s2,a1
ffffffffc02045c4:	fe878413          	addi	s0,a5,-24
ffffffffc02045c8:	e23d                	bnez	a2,ffffffffc020462e <wakeup_queue+0x7e>
ffffffffc02045ca:	6008                	ld	a0,0(s0)
ffffffffc02045cc:	01242423          	sw	s2,8(s0)
ffffffffc02045d0:	6a1020ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc02045d4:	701c                	ld	a5,32(s0)
ffffffffc02045d6:	01840713          	addi	a4,s0,24
ffffffffc02045da:	02e78463          	beq	a5,a4,ffffffffc0204602 <wakeup_queue+0x52>
ffffffffc02045de:	6818                	ld	a4,16(s0)
ffffffffc02045e0:	02e49163          	bne	s1,a4,ffffffffc0204602 <wakeup_queue+0x52>
ffffffffc02045e4:	02f48f63          	beq	s1,a5,ffffffffc0204622 <wakeup_queue+0x72>
ffffffffc02045e8:	fe87b503          	ld	a0,-24(a5)
ffffffffc02045ec:	ff27a823          	sw	s2,-16(a5)
ffffffffc02045f0:	fe878413          	addi	s0,a5,-24
ffffffffc02045f4:	67d020ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc02045f8:	701c                	ld	a5,32(s0)
ffffffffc02045fa:	01840713          	addi	a4,s0,24
ffffffffc02045fe:	fee790e3          	bne	a5,a4,ffffffffc02045de <wakeup_queue+0x2e>
ffffffffc0204602:	00009697          	auipc	a3,0x9
ffffffffc0204606:	b6668693          	addi	a3,a3,-1178 # ffffffffc020d168 <default_pmm_manager+0xb28>
ffffffffc020460a:	00007617          	auipc	a2,0x7
ffffffffc020460e:	54e60613          	addi	a2,a2,1358 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204612:	02200593          	li	a1,34
ffffffffc0204616:	00009517          	auipc	a0,0x9
ffffffffc020461a:	b3a50513          	addi	a0,a0,-1222 # ffffffffc020d150 <default_pmm_manager+0xb10>
ffffffffc020461e:	e81fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204622:	60e2                	ld	ra,24(sp)
ffffffffc0204624:	6442                	ld	s0,16(sp)
ffffffffc0204626:	64a2                	ld	s1,8(sp)
ffffffffc0204628:	6902                	ld	s2,0(sp)
ffffffffc020462a:	6105                	addi	sp,sp,32
ffffffffc020462c:	8082                	ret
ffffffffc020462e:	6798                	ld	a4,8(a5)
ffffffffc0204630:	02f70763          	beq	a4,a5,ffffffffc020465e <wakeup_queue+0xae>
ffffffffc0204634:	6814                	ld	a3,16(s0)
ffffffffc0204636:	02d49463          	bne	s1,a3,ffffffffc020465e <wakeup_queue+0xae>
ffffffffc020463a:	6c14                	ld	a3,24(s0)
ffffffffc020463c:	6008                	ld	a0,0(s0)
ffffffffc020463e:	e698                	sd	a4,8(a3)
ffffffffc0204640:	e314                	sd	a3,0(a4)
ffffffffc0204642:	f01c                	sd	a5,32(s0)
ffffffffc0204644:	ec1c                	sd	a5,24(s0)
ffffffffc0204646:	01242423          	sw	s2,8(s0)
ffffffffc020464a:	627020ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc020464e:	6480                	ld	s0,8(s1)
ffffffffc0204650:	fc8489e3          	beq	s1,s0,ffffffffc0204622 <wakeup_queue+0x72>
ffffffffc0204654:	6418                	ld	a4,8(s0)
ffffffffc0204656:	87a2                	mv	a5,s0
ffffffffc0204658:	1421                	addi	s0,s0,-24
ffffffffc020465a:	fce79de3          	bne	a5,a4,ffffffffc0204634 <wakeup_queue+0x84>
ffffffffc020465e:	00009697          	auipc	a3,0x9
ffffffffc0204662:	b0a68693          	addi	a3,a3,-1270 # ffffffffc020d168 <default_pmm_manager+0xb28>
ffffffffc0204666:	00007617          	auipc	a2,0x7
ffffffffc020466a:	4f260613          	addi	a2,a2,1266 # ffffffffc020bb58 <commands+0x210>
ffffffffc020466e:	45f1                	li	a1,28
ffffffffc0204670:	00009517          	auipc	a0,0x9
ffffffffc0204674:	ae050513          	addi	a0,a0,-1312 # ffffffffc020d150 <default_pmm_manager+0xb10>
ffffffffc0204678:	e27fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020467c:	8082                	ret

ffffffffc020467e <wait_current_set>:
ffffffffc020467e:	00092797          	auipc	a5,0x92
ffffffffc0204682:	2427b783          	ld	a5,578(a5) # ffffffffc02968c0 <current>
ffffffffc0204686:	c39d                	beqz	a5,ffffffffc02046ac <wait_current_set+0x2e>
ffffffffc0204688:	01858713          	addi	a4,a1,24
ffffffffc020468c:	800006b7          	lui	a3,0x80000
ffffffffc0204690:	ed98                	sd	a4,24(a1)
ffffffffc0204692:	e19c                	sd	a5,0(a1)
ffffffffc0204694:	c594                	sw	a3,8(a1)
ffffffffc0204696:	4685                	li	a3,1
ffffffffc0204698:	c394                	sw	a3,0(a5)
ffffffffc020469a:	0ec7a623          	sw	a2,236(a5)
ffffffffc020469e:	611c                	ld	a5,0(a0)
ffffffffc02046a0:	e988                	sd	a0,16(a1)
ffffffffc02046a2:	e118                	sd	a4,0(a0)
ffffffffc02046a4:	e798                	sd	a4,8(a5)
ffffffffc02046a6:	f188                	sd	a0,32(a1)
ffffffffc02046a8:	ed9c                	sd	a5,24(a1)
ffffffffc02046aa:	8082                	ret
ffffffffc02046ac:	1141                	addi	sp,sp,-16
ffffffffc02046ae:	00009697          	auipc	a3,0x9
ffffffffc02046b2:	afa68693          	addi	a3,a3,-1286 # ffffffffc020d1a8 <default_pmm_manager+0xb68>
ffffffffc02046b6:	00007617          	auipc	a2,0x7
ffffffffc02046ba:	4a260613          	addi	a2,a2,1186 # ffffffffc020bb58 <commands+0x210>
ffffffffc02046be:	07400593          	li	a1,116
ffffffffc02046c2:	00009517          	auipc	a0,0x9
ffffffffc02046c6:	a8e50513          	addi	a0,a0,-1394 # ffffffffc020d150 <default_pmm_manager+0xb10>
ffffffffc02046ca:	e406                	sd	ra,8(sp)
ffffffffc02046cc:	dd3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046d0 <get_fd_array.part.0>:
ffffffffc02046d0:	1141                	addi	sp,sp,-16
ffffffffc02046d2:	00009697          	auipc	a3,0x9
ffffffffc02046d6:	ae668693          	addi	a3,a3,-1306 # ffffffffc020d1b8 <default_pmm_manager+0xb78>
ffffffffc02046da:	00007617          	auipc	a2,0x7
ffffffffc02046de:	47e60613          	addi	a2,a2,1150 # ffffffffc020bb58 <commands+0x210>
ffffffffc02046e2:	45d1                	li	a1,20
ffffffffc02046e4:	00009517          	auipc	a0,0x9
ffffffffc02046e8:	b0450513          	addi	a0,a0,-1276 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc02046ec:	e406                	sd	ra,8(sp)
ffffffffc02046ee:	db1fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046f2 <fd_array_alloc>:
ffffffffc02046f2:	00092797          	auipc	a5,0x92
ffffffffc02046f6:	1ce7b783          	ld	a5,462(a5) # ffffffffc02968c0 <current>
ffffffffc02046fa:	1487b783          	ld	a5,328(a5)
ffffffffc02046fe:	1141                	addi	sp,sp,-16
ffffffffc0204700:	e406                	sd	ra,8(sp)
ffffffffc0204702:	c3a5                	beqz	a5,ffffffffc0204762 <fd_array_alloc+0x70>
ffffffffc0204704:	4b98                	lw	a4,16(a5)
ffffffffc0204706:	04e05e63          	blez	a4,ffffffffc0204762 <fd_array_alloc+0x70>
ffffffffc020470a:	775d                	lui	a4,0xffff7
ffffffffc020470c:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204710:	679c                	ld	a5,8(a5)
ffffffffc0204712:	02e50863          	beq	a0,a4,ffffffffc0204742 <fd_array_alloc+0x50>
ffffffffc0204716:	04700713          	li	a4,71
ffffffffc020471a:	04a76263          	bltu	a4,a0,ffffffffc020475e <fd_array_alloc+0x6c>
ffffffffc020471e:	00351713          	slli	a4,a0,0x3
ffffffffc0204722:	40a70533          	sub	a0,a4,a0
ffffffffc0204726:	050e                	slli	a0,a0,0x3
ffffffffc0204728:	97aa                	add	a5,a5,a0
ffffffffc020472a:	4398                	lw	a4,0(a5)
ffffffffc020472c:	e71d                	bnez	a4,ffffffffc020475a <fd_array_alloc+0x68>
ffffffffc020472e:	5b88                	lw	a0,48(a5)
ffffffffc0204730:	e91d                	bnez	a0,ffffffffc0204766 <fd_array_alloc+0x74>
ffffffffc0204732:	4705                	li	a4,1
ffffffffc0204734:	c398                	sw	a4,0(a5)
ffffffffc0204736:	0207b423          	sd	zero,40(a5)
ffffffffc020473a:	e19c                	sd	a5,0(a1)
ffffffffc020473c:	60a2                	ld	ra,8(sp)
ffffffffc020473e:	0141                	addi	sp,sp,16
ffffffffc0204740:	8082                	ret
ffffffffc0204742:	6685                	lui	a3,0x1
ffffffffc0204744:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204748:	96be                	add	a3,a3,a5
ffffffffc020474a:	4398                	lw	a4,0(a5)
ffffffffc020474c:	d36d                	beqz	a4,ffffffffc020472e <fd_array_alloc+0x3c>
ffffffffc020474e:	03878793          	addi	a5,a5,56
ffffffffc0204752:	fef69ce3          	bne	a3,a5,ffffffffc020474a <fd_array_alloc+0x58>
ffffffffc0204756:	5529                	li	a0,-22
ffffffffc0204758:	b7d5                	j	ffffffffc020473c <fd_array_alloc+0x4a>
ffffffffc020475a:	5545                	li	a0,-15
ffffffffc020475c:	b7c5                	j	ffffffffc020473c <fd_array_alloc+0x4a>
ffffffffc020475e:	5575                	li	a0,-3
ffffffffc0204760:	bff1                	j	ffffffffc020473c <fd_array_alloc+0x4a>
ffffffffc0204762:	f6fff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204766:	00009697          	auipc	a3,0x9
ffffffffc020476a:	a9268693          	addi	a3,a3,-1390 # ffffffffc020d1f8 <default_pmm_manager+0xbb8>
ffffffffc020476e:	00007617          	auipc	a2,0x7
ffffffffc0204772:	3ea60613          	addi	a2,a2,1002 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204776:	03b00593          	li	a1,59
ffffffffc020477a:	00009517          	auipc	a0,0x9
ffffffffc020477e:	a6e50513          	addi	a0,a0,-1426 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204782:	d1dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204786 <fd_array_free>:
ffffffffc0204786:	411c                	lw	a5,0(a0)
ffffffffc0204788:	1141                	addi	sp,sp,-16
ffffffffc020478a:	e022                	sd	s0,0(sp)
ffffffffc020478c:	e406                	sd	ra,8(sp)
ffffffffc020478e:	4705                	li	a4,1
ffffffffc0204790:	842a                	mv	s0,a0
ffffffffc0204792:	04e78063          	beq	a5,a4,ffffffffc02047d2 <fd_array_free+0x4c>
ffffffffc0204796:	470d                	li	a4,3
ffffffffc0204798:	04e79563          	bne	a5,a4,ffffffffc02047e2 <fd_array_free+0x5c>
ffffffffc020479c:	591c                	lw	a5,48(a0)
ffffffffc020479e:	c38d                	beqz	a5,ffffffffc02047c0 <fd_array_free+0x3a>
ffffffffc02047a0:	00009697          	auipc	a3,0x9
ffffffffc02047a4:	a5868693          	addi	a3,a3,-1448 # ffffffffc020d1f8 <default_pmm_manager+0xbb8>
ffffffffc02047a8:	00007617          	auipc	a2,0x7
ffffffffc02047ac:	3b060613          	addi	a2,a2,944 # ffffffffc020bb58 <commands+0x210>
ffffffffc02047b0:	04500593          	li	a1,69
ffffffffc02047b4:	00009517          	auipc	a0,0x9
ffffffffc02047b8:	a3450513          	addi	a0,a0,-1484 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc02047bc:	ce3fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02047c0:	7408                	ld	a0,40(s0)
ffffffffc02047c2:	325030ef          	jal	ra,ffffffffc02082e6 <vfs_close>
ffffffffc02047c6:	60a2                	ld	ra,8(sp)
ffffffffc02047c8:	00042023          	sw	zero,0(s0)
ffffffffc02047cc:	6402                	ld	s0,0(sp)
ffffffffc02047ce:	0141                	addi	sp,sp,16
ffffffffc02047d0:	8082                	ret
ffffffffc02047d2:	591c                	lw	a5,48(a0)
ffffffffc02047d4:	f7f1                	bnez	a5,ffffffffc02047a0 <fd_array_free+0x1a>
ffffffffc02047d6:	60a2                	ld	ra,8(sp)
ffffffffc02047d8:	00042023          	sw	zero,0(s0)
ffffffffc02047dc:	6402                	ld	s0,0(sp)
ffffffffc02047de:	0141                	addi	sp,sp,16
ffffffffc02047e0:	8082                	ret
ffffffffc02047e2:	00009697          	auipc	a3,0x9
ffffffffc02047e6:	a4e68693          	addi	a3,a3,-1458 # ffffffffc020d230 <default_pmm_manager+0xbf0>
ffffffffc02047ea:	00007617          	auipc	a2,0x7
ffffffffc02047ee:	36e60613          	addi	a2,a2,878 # ffffffffc020bb58 <commands+0x210>
ffffffffc02047f2:	04400593          	li	a1,68
ffffffffc02047f6:	00009517          	auipc	a0,0x9
ffffffffc02047fa:	9f250513          	addi	a0,a0,-1550 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc02047fe:	ca1fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204802 <fd_array_release>:
ffffffffc0204802:	4118                	lw	a4,0(a0)
ffffffffc0204804:	1141                	addi	sp,sp,-16
ffffffffc0204806:	e406                	sd	ra,8(sp)
ffffffffc0204808:	4685                	li	a3,1
ffffffffc020480a:	3779                	addiw	a4,a4,-2
ffffffffc020480c:	04e6e063          	bltu	a3,a4,ffffffffc020484c <fd_array_release+0x4a>
ffffffffc0204810:	5918                	lw	a4,48(a0)
ffffffffc0204812:	00e05d63          	blez	a4,ffffffffc020482c <fd_array_release+0x2a>
ffffffffc0204816:	fff7069b          	addiw	a3,a4,-1
ffffffffc020481a:	d914                	sw	a3,48(a0)
ffffffffc020481c:	c681                	beqz	a3,ffffffffc0204824 <fd_array_release+0x22>
ffffffffc020481e:	60a2                	ld	ra,8(sp)
ffffffffc0204820:	0141                	addi	sp,sp,16
ffffffffc0204822:	8082                	ret
ffffffffc0204824:	60a2                	ld	ra,8(sp)
ffffffffc0204826:	0141                	addi	sp,sp,16
ffffffffc0204828:	f5fff06f          	j	ffffffffc0204786 <fd_array_free>
ffffffffc020482c:	00009697          	auipc	a3,0x9
ffffffffc0204830:	a7468693          	addi	a3,a3,-1420 # ffffffffc020d2a0 <default_pmm_manager+0xc60>
ffffffffc0204834:	00007617          	auipc	a2,0x7
ffffffffc0204838:	32460613          	addi	a2,a2,804 # ffffffffc020bb58 <commands+0x210>
ffffffffc020483c:	05600593          	li	a1,86
ffffffffc0204840:	00009517          	auipc	a0,0x9
ffffffffc0204844:	9a850513          	addi	a0,a0,-1624 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204848:	c57fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020484c:	00009697          	auipc	a3,0x9
ffffffffc0204850:	a1c68693          	addi	a3,a3,-1508 # ffffffffc020d268 <default_pmm_manager+0xc28>
ffffffffc0204854:	00007617          	auipc	a2,0x7
ffffffffc0204858:	30460613          	addi	a2,a2,772 # ffffffffc020bb58 <commands+0x210>
ffffffffc020485c:	05500593          	li	a1,85
ffffffffc0204860:	00009517          	auipc	a0,0x9
ffffffffc0204864:	98850513          	addi	a0,a0,-1656 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204868:	c37fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020486c <fd_array_open.part.0>:
ffffffffc020486c:	1141                	addi	sp,sp,-16
ffffffffc020486e:	00009697          	auipc	a3,0x9
ffffffffc0204872:	a4a68693          	addi	a3,a3,-1462 # ffffffffc020d2b8 <default_pmm_manager+0xc78>
ffffffffc0204876:	00007617          	auipc	a2,0x7
ffffffffc020487a:	2e260613          	addi	a2,a2,738 # ffffffffc020bb58 <commands+0x210>
ffffffffc020487e:	05f00593          	li	a1,95
ffffffffc0204882:	00009517          	auipc	a0,0x9
ffffffffc0204886:	96650513          	addi	a0,a0,-1690 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc020488a:	e406                	sd	ra,8(sp)
ffffffffc020488c:	c13fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204890 <fd_array_init>:
ffffffffc0204890:	4781                	li	a5,0
ffffffffc0204892:	04800713          	li	a4,72
ffffffffc0204896:	cd1c                	sw	a5,24(a0)
ffffffffc0204898:	02052823          	sw	zero,48(a0)
ffffffffc020489c:	00052023          	sw	zero,0(a0)
ffffffffc02048a0:	2785                	addiw	a5,a5,1
ffffffffc02048a2:	03850513          	addi	a0,a0,56
ffffffffc02048a6:	fee798e3          	bne	a5,a4,ffffffffc0204896 <fd_array_init+0x6>
ffffffffc02048aa:	8082                	ret

ffffffffc02048ac <fd_array_close>:
ffffffffc02048ac:	4118                	lw	a4,0(a0)
ffffffffc02048ae:	1141                	addi	sp,sp,-16
ffffffffc02048b0:	e406                	sd	ra,8(sp)
ffffffffc02048b2:	e022                	sd	s0,0(sp)
ffffffffc02048b4:	4789                	li	a5,2
ffffffffc02048b6:	04f71a63          	bne	a4,a5,ffffffffc020490a <fd_array_close+0x5e>
ffffffffc02048ba:	591c                	lw	a5,48(a0)
ffffffffc02048bc:	842a                	mv	s0,a0
ffffffffc02048be:	02f05663          	blez	a5,ffffffffc02048ea <fd_array_close+0x3e>
ffffffffc02048c2:	37fd                	addiw	a5,a5,-1
ffffffffc02048c4:	470d                	li	a4,3
ffffffffc02048c6:	c118                	sw	a4,0(a0)
ffffffffc02048c8:	d91c                	sw	a5,48(a0)
ffffffffc02048ca:	0007871b          	sext.w	a4,a5
ffffffffc02048ce:	c709                	beqz	a4,ffffffffc02048d8 <fd_array_close+0x2c>
ffffffffc02048d0:	60a2                	ld	ra,8(sp)
ffffffffc02048d2:	6402                	ld	s0,0(sp)
ffffffffc02048d4:	0141                	addi	sp,sp,16
ffffffffc02048d6:	8082                	ret
ffffffffc02048d8:	7508                	ld	a0,40(a0)
ffffffffc02048da:	20d030ef          	jal	ra,ffffffffc02082e6 <vfs_close>
ffffffffc02048de:	60a2                	ld	ra,8(sp)
ffffffffc02048e0:	00042023          	sw	zero,0(s0)
ffffffffc02048e4:	6402                	ld	s0,0(sp)
ffffffffc02048e6:	0141                	addi	sp,sp,16
ffffffffc02048e8:	8082                	ret
ffffffffc02048ea:	00009697          	auipc	a3,0x9
ffffffffc02048ee:	9b668693          	addi	a3,a3,-1610 # ffffffffc020d2a0 <default_pmm_manager+0xc60>
ffffffffc02048f2:	00007617          	auipc	a2,0x7
ffffffffc02048f6:	26660613          	addi	a2,a2,614 # ffffffffc020bb58 <commands+0x210>
ffffffffc02048fa:	06800593          	li	a1,104
ffffffffc02048fe:	00009517          	auipc	a0,0x9
ffffffffc0204902:	8ea50513          	addi	a0,a0,-1814 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204906:	b99fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020490a:	00009697          	auipc	a3,0x9
ffffffffc020490e:	90668693          	addi	a3,a3,-1786 # ffffffffc020d210 <default_pmm_manager+0xbd0>
ffffffffc0204912:	00007617          	auipc	a2,0x7
ffffffffc0204916:	24660613          	addi	a2,a2,582 # ffffffffc020bb58 <commands+0x210>
ffffffffc020491a:	06700593          	li	a1,103
ffffffffc020491e:	00009517          	auipc	a0,0x9
ffffffffc0204922:	8ca50513          	addi	a0,a0,-1846 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204926:	b79fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020492a <fd_array_dup>:
ffffffffc020492a:	7179                	addi	sp,sp,-48
ffffffffc020492c:	e84a                	sd	s2,16(sp)
ffffffffc020492e:	00052903          	lw	s2,0(a0)
ffffffffc0204932:	f406                	sd	ra,40(sp)
ffffffffc0204934:	f022                	sd	s0,32(sp)
ffffffffc0204936:	ec26                	sd	s1,24(sp)
ffffffffc0204938:	e44e                	sd	s3,8(sp)
ffffffffc020493a:	4785                	li	a5,1
ffffffffc020493c:	04f91663          	bne	s2,a5,ffffffffc0204988 <fd_array_dup+0x5e>
ffffffffc0204940:	0005a983          	lw	s3,0(a1)
ffffffffc0204944:	4789                	li	a5,2
ffffffffc0204946:	04f99163          	bne	s3,a5,ffffffffc0204988 <fd_array_dup+0x5e>
ffffffffc020494a:	7584                	ld	s1,40(a1)
ffffffffc020494c:	699c                	ld	a5,16(a1)
ffffffffc020494e:	7194                	ld	a3,32(a1)
ffffffffc0204950:	6598                	ld	a4,8(a1)
ffffffffc0204952:	842a                	mv	s0,a0
ffffffffc0204954:	e91c                	sd	a5,16(a0)
ffffffffc0204956:	f114                	sd	a3,32(a0)
ffffffffc0204958:	e518                	sd	a4,8(a0)
ffffffffc020495a:	8526                	mv	a0,s1
ffffffffc020495c:	0e8030ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc0204960:	8526                	mv	a0,s1
ffffffffc0204962:	0ee030ef          	jal	ra,ffffffffc0207a50 <inode_open_inc>
ffffffffc0204966:	401c                	lw	a5,0(s0)
ffffffffc0204968:	f404                	sd	s1,40(s0)
ffffffffc020496a:	03279f63          	bne	a5,s2,ffffffffc02049a8 <fd_array_dup+0x7e>
ffffffffc020496e:	cc8d                	beqz	s1,ffffffffc02049a8 <fd_array_dup+0x7e>
ffffffffc0204970:	581c                	lw	a5,48(s0)
ffffffffc0204972:	01342023          	sw	s3,0(s0)
ffffffffc0204976:	70a2                	ld	ra,40(sp)
ffffffffc0204978:	2785                	addiw	a5,a5,1
ffffffffc020497a:	d81c                	sw	a5,48(s0)
ffffffffc020497c:	7402                	ld	s0,32(sp)
ffffffffc020497e:	64e2                	ld	s1,24(sp)
ffffffffc0204980:	6942                	ld	s2,16(sp)
ffffffffc0204982:	69a2                	ld	s3,8(sp)
ffffffffc0204984:	6145                	addi	sp,sp,48
ffffffffc0204986:	8082                	ret
ffffffffc0204988:	00009697          	auipc	a3,0x9
ffffffffc020498c:	96068693          	addi	a3,a3,-1696 # ffffffffc020d2e8 <default_pmm_manager+0xca8>
ffffffffc0204990:	00007617          	auipc	a2,0x7
ffffffffc0204994:	1c860613          	addi	a2,a2,456 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204998:	07300593          	li	a1,115
ffffffffc020499c:	00009517          	auipc	a0,0x9
ffffffffc02049a0:	84c50513          	addi	a0,a0,-1972 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc02049a4:	afbfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02049a8:	ec5ff0ef          	jal	ra,ffffffffc020486c <fd_array_open.part.0>

ffffffffc02049ac <file_testfd>:
ffffffffc02049ac:	04700793          	li	a5,71
ffffffffc02049b0:	04a7e263          	bltu	a5,a0,ffffffffc02049f4 <file_testfd+0x48>
ffffffffc02049b4:	00092797          	auipc	a5,0x92
ffffffffc02049b8:	f0c7b783          	ld	a5,-244(a5) # ffffffffc02968c0 <current>
ffffffffc02049bc:	1487b783          	ld	a5,328(a5)
ffffffffc02049c0:	cf85                	beqz	a5,ffffffffc02049f8 <file_testfd+0x4c>
ffffffffc02049c2:	4b98                	lw	a4,16(a5)
ffffffffc02049c4:	02e05a63          	blez	a4,ffffffffc02049f8 <file_testfd+0x4c>
ffffffffc02049c8:	6798                	ld	a4,8(a5)
ffffffffc02049ca:	00351793          	slli	a5,a0,0x3
ffffffffc02049ce:	8f89                	sub	a5,a5,a0
ffffffffc02049d0:	078e                	slli	a5,a5,0x3
ffffffffc02049d2:	97ba                	add	a5,a5,a4
ffffffffc02049d4:	4394                	lw	a3,0(a5)
ffffffffc02049d6:	4709                	li	a4,2
ffffffffc02049d8:	00e69e63          	bne	a3,a4,ffffffffc02049f4 <file_testfd+0x48>
ffffffffc02049dc:	4f98                	lw	a4,24(a5)
ffffffffc02049de:	00a71b63          	bne	a4,a0,ffffffffc02049f4 <file_testfd+0x48>
ffffffffc02049e2:	c199                	beqz	a1,ffffffffc02049e8 <file_testfd+0x3c>
ffffffffc02049e4:	6788                	ld	a0,8(a5)
ffffffffc02049e6:	c901                	beqz	a0,ffffffffc02049f6 <file_testfd+0x4a>
ffffffffc02049e8:	4505                	li	a0,1
ffffffffc02049ea:	c611                	beqz	a2,ffffffffc02049f6 <file_testfd+0x4a>
ffffffffc02049ec:	6b88                	ld	a0,16(a5)
ffffffffc02049ee:	00a03533          	snez	a0,a0
ffffffffc02049f2:	8082                	ret
ffffffffc02049f4:	4501                	li	a0,0
ffffffffc02049f6:	8082                	ret
ffffffffc02049f8:	1141                	addi	sp,sp,-16
ffffffffc02049fa:	e406                	sd	ra,8(sp)
ffffffffc02049fc:	cd5ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204a00 <file_open>:
ffffffffc0204a00:	711d                	addi	sp,sp,-96
ffffffffc0204a02:	ec86                	sd	ra,88(sp)
ffffffffc0204a04:	e8a2                	sd	s0,80(sp)
ffffffffc0204a06:	e4a6                	sd	s1,72(sp)
ffffffffc0204a08:	e0ca                	sd	s2,64(sp)
ffffffffc0204a0a:	fc4e                	sd	s3,56(sp)
ffffffffc0204a0c:	f852                	sd	s4,48(sp)
ffffffffc0204a0e:	0035f793          	andi	a5,a1,3
ffffffffc0204a12:	470d                	li	a4,3
ffffffffc0204a14:	0ce78163          	beq	a5,a4,ffffffffc0204ad6 <file_open+0xd6>
ffffffffc0204a18:	078e                	slli	a5,a5,0x3
ffffffffc0204a1a:	00009717          	auipc	a4,0x9
ffffffffc0204a1e:	b3e70713          	addi	a4,a4,-1218 # ffffffffc020d558 <CSWTCH.79>
ffffffffc0204a22:	892a                	mv	s2,a0
ffffffffc0204a24:	00009697          	auipc	a3,0x9
ffffffffc0204a28:	b1c68693          	addi	a3,a3,-1252 # ffffffffc020d540 <CSWTCH.78>
ffffffffc0204a2c:	755d                	lui	a0,0xffff7
ffffffffc0204a2e:	96be                	add	a3,a3,a5
ffffffffc0204a30:	84ae                	mv	s1,a1
ffffffffc0204a32:	97ba                	add	a5,a5,a4
ffffffffc0204a34:	858a                	mv	a1,sp
ffffffffc0204a36:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204a3a:	0006ba03          	ld	s4,0(a3)
ffffffffc0204a3e:	0007b983          	ld	s3,0(a5)
ffffffffc0204a42:	cb1ff0ef          	jal	ra,ffffffffc02046f2 <fd_array_alloc>
ffffffffc0204a46:	842a                	mv	s0,a0
ffffffffc0204a48:	c911                	beqz	a0,ffffffffc0204a5c <file_open+0x5c>
ffffffffc0204a4a:	60e6                	ld	ra,88(sp)
ffffffffc0204a4c:	8522                	mv	a0,s0
ffffffffc0204a4e:	6446                	ld	s0,80(sp)
ffffffffc0204a50:	64a6                	ld	s1,72(sp)
ffffffffc0204a52:	6906                	ld	s2,64(sp)
ffffffffc0204a54:	79e2                	ld	s3,56(sp)
ffffffffc0204a56:	7a42                	ld	s4,48(sp)
ffffffffc0204a58:	6125                	addi	sp,sp,96
ffffffffc0204a5a:	8082                	ret
ffffffffc0204a5c:	0030                	addi	a2,sp,8
ffffffffc0204a5e:	85a6                	mv	a1,s1
ffffffffc0204a60:	854a                	mv	a0,s2
ffffffffc0204a62:	6de030ef          	jal	ra,ffffffffc0208140 <vfs_open>
ffffffffc0204a66:	842a                	mv	s0,a0
ffffffffc0204a68:	e13d                	bnez	a0,ffffffffc0204ace <file_open+0xce>
ffffffffc0204a6a:	6782                	ld	a5,0(sp)
ffffffffc0204a6c:	0204f493          	andi	s1,s1,32
ffffffffc0204a70:	6422                	ld	s0,8(sp)
ffffffffc0204a72:	0207b023          	sd	zero,32(a5)
ffffffffc0204a76:	c885                	beqz	s1,ffffffffc0204aa6 <file_open+0xa6>
ffffffffc0204a78:	c03d                	beqz	s0,ffffffffc0204ade <file_open+0xde>
ffffffffc0204a7a:	783c                	ld	a5,112(s0)
ffffffffc0204a7c:	c3ad                	beqz	a5,ffffffffc0204ade <file_open+0xde>
ffffffffc0204a7e:	779c                	ld	a5,40(a5)
ffffffffc0204a80:	cfb9                	beqz	a5,ffffffffc0204ade <file_open+0xde>
ffffffffc0204a82:	8522                	mv	a0,s0
ffffffffc0204a84:	00009597          	auipc	a1,0x9
ffffffffc0204a88:	8ec58593          	addi	a1,a1,-1812 # ffffffffc020d370 <default_pmm_manager+0xd30>
ffffffffc0204a8c:	7d1020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204a90:	783c                	ld	a5,112(s0)
ffffffffc0204a92:	6522                	ld	a0,8(sp)
ffffffffc0204a94:	080c                	addi	a1,sp,16
ffffffffc0204a96:	779c                	ld	a5,40(a5)
ffffffffc0204a98:	9782                	jalr	a5
ffffffffc0204a9a:	842a                	mv	s0,a0
ffffffffc0204a9c:	e515                	bnez	a0,ffffffffc0204ac8 <file_open+0xc8>
ffffffffc0204a9e:	6782                	ld	a5,0(sp)
ffffffffc0204aa0:	7722                	ld	a4,40(sp)
ffffffffc0204aa2:	6422                	ld	s0,8(sp)
ffffffffc0204aa4:	f398                	sd	a4,32(a5)
ffffffffc0204aa6:	4394                	lw	a3,0(a5)
ffffffffc0204aa8:	f780                	sd	s0,40(a5)
ffffffffc0204aaa:	0147b423          	sd	s4,8(a5)
ffffffffc0204aae:	0137b823          	sd	s3,16(a5)
ffffffffc0204ab2:	4705                	li	a4,1
ffffffffc0204ab4:	02e69363          	bne	a3,a4,ffffffffc0204ada <file_open+0xda>
ffffffffc0204ab8:	c00d                	beqz	s0,ffffffffc0204ada <file_open+0xda>
ffffffffc0204aba:	5b98                	lw	a4,48(a5)
ffffffffc0204abc:	4689                	li	a3,2
ffffffffc0204abe:	4f80                	lw	s0,24(a5)
ffffffffc0204ac0:	2705                	addiw	a4,a4,1
ffffffffc0204ac2:	c394                	sw	a3,0(a5)
ffffffffc0204ac4:	db98                	sw	a4,48(a5)
ffffffffc0204ac6:	b751                	j	ffffffffc0204a4a <file_open+0x4a>
ffffffffc0204ac8:	6522                	ld	a0,8(sp)
ffffffffc0204aca:	01d030ef          	jal	ra,ffffffffc02082e6 <vfs_close>
ffffffffc0204ace:	6502                	ld	a0,0(sp)
ffffffffc0204ad0:	cb7ff0ef          	jal	ra,ffffffffc0204786 <fd_array_free>
ffffffffc0204ad4:	bf9d                	j	ffffffffc0204a4a <file_open+0x4a>
ffffffffc0204ad6:	5475                	li	s0,-3
ffffffffc0204ad8:	bf8d                	j	ffffffffc0204a4a <file_open+0x4a>
ffffffffc0204ada:	d93ff0ef          	jal	ra,ffffffffc020486c <fd_array_open.part.0>
ffffffffc0204ade:	00009697          	auipc	a3,0x9
ffffffffc0204ae2:	84268693          	addi	a3,a3,-1982 # ffffffffc020d320 <default_pmm_manager+0xce0>
ffffffffc0204ae6:	00007617          	auipc	a2,0x7
ffffffffc0204aea:	07260613          	addi	a2,a2,114 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204aee:	0b500593          	li	a1,181
ffffffffc0204af2:	00008517          	auipc	a0,0x8
ffffffffc0204af6:	6f650513          	addi	a0,a0,1782 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204afa:	9a5fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204afe <file_close>:
ffffffffc0204afe:	04700713          	li	a4,71
ffffffffc0204b02:	04a76563          	bltu	a4,a0,ffffffffc0204b4c <file_close+0x4e>
ffffffffc0204b06:	00092717          	auipc	a4,0x92
ffffffffc0204b0a:	dba73703          	ld	a4,-582(a4) # ffffffffc02968c0 <current>
ffffffffc0204b0e:	14873703          	ld	a4,328(a4)
ffffffffc0204b12:	1141                	addi	sp,sp,-16
ffffffffc0204b14:	e406                	sd	ra,8(sp)
ffffffffc0204b16:	cf0d                	beqz	a4,ffffffffc0204b50 <file_close+0x52>
ffffffffc0204b18:	4b14                	lw	a3,16(a4)
ffffffffc0204b1a:	02d05b63          	blez	a3,ffffffffc0204b50 <file_close+0x52>
ffffffffc0204b1e:	6718                	ld	a4,8(a4)
ffffffffc0204b20:	87aa                	mv	a5,a0
ffffffffc0204b22:	050e                	slli	a0,a0,0x3
ffffffffc0204b24:	8d1d                	sub	a0,a0,a5
ffffffffc0204b26:	050e                	slli	a0,a0,0x3
ffffffffc0204b28:	953a                	add	a0,a0,a4
ffffffffc0204b2a:	4114                	lw	a3,0(a0)
ffffffffc0204b2c:	4709                	li	a4,2
ffffffffc0204b2e:	00e69b63          	bne	a3,a4,ffffffffc0204b44 <file_close+0x46>
ffffffffc0204b32:	4d18                	lw	a4,24(a0)
ffffffffc0204b34:	00f71863          	bne	a4,a5,ffffffffc0204b44 <file_close+0x46>
ffffffffc0204b38:	d75ff0ef          	jal	ra,ffffffffc02048ac <fd_array_close>
ffffffffc0204b3c:	60a2                	ld	ra,8(sp)
ffffffffc0204b3e:	4501                	li	a0,0
ffffffffc0204b40:	0141                	addi	sp,sp,16
ffffffffc0204b42:	8082                	ret
ffffffffc0204b44:	60a2                	ld	ra,8(sp)
ffffffffc0204b46:	5575                	li	a0,-3
ffffffffc0204b48:	0141                	addi	sp,sp,16
ffffffffc0204b4a:	8082                	ret
ffffffffc0204b4c:	5575                	li	a0,-3
ffffffffc0204b4e:	8082                	ret
ffffffffc0204b50:	b81ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204b54 <file_read>:
ffffffffc0204b54:	715d                	addi	sp,sp,-80
ffffffffc0204b56:	e486                	sd	ra,72(sp)
ffffffffc0204b58:	e0a2                	sd	s0,64(sp)
ffffffffc0204b5a:	fc26                	sd	s1,56(sp)
ffffffffc0204b5c:	f84a                	sd	s2,48(sp)
ffffffffc0204b5e:	f44e                	sd	s3,40(sp)
ffffffffc0204b60:	f052                	sd	s4,32(sp)
ffffffffc0204b62:	0006b023          	sd	zero,0(a3)
ffffffffc0204b66:	04700793          	li	a5,71
ffffffffc0204b6a:	0aa7e463          	bltu	a5,a0,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204b6e:	00092797          	auipc	a5,0x92
ffffffffc0204b72:	d527b783          	ld	a5,-686(a5) # ffffffffc02968c0 <current>
ffffffffc0204b76:	1487b783          	ld	a5,328(a5)
ffffffffc0204b7a:	cfd1                	beqz	a5,ffffffffc0204c16 <file_read+0xc2>
ffffffffc0204b7c:	4b98                	lw	a4,16(a5)
ffffffffc0204b7e:	08e05c63          	blez	a4,ffffffffc0204c16 <file_read+0xc2>
ffffffffc0204b82:	6780                	ld	s0,8(a5)
ffffffffc0204b84:	00351793          	slli	a5,a0,0x3
ffffffffc0204b88:	8f89                	sub	a5,a5,a0
ffffffffc0204b8a:	078e                	slli	a5,a5,0x3
ffffffffc0204b8c:	943e                	add	s0,s0,a5
ffffffffc0204b8e:	00042983          	lw	s3,0(s0)
ffffffffc0204b92:	4789                	li	a5,2
ffffffffc0204b94:	06f99f63          	bne	s3,a5,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204b98:	4c1c                	lw	a5,24(s0)
ffffffffc0204b9a:	06a79c63          	bne	a5,a0,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204b9e:	641c                	ld	a5,8(s0)
ffffffffc0204ba0:	cbad                	beqz	a5,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204ba2:	581c                	lw	a5,48(s0)
ffffffffc0204ba4:	8a36                	mv	s4,a3
ffffffffc0204ba6:	7014                	ld	a3,32(s0)
ffffffffc0204ba8:	2785                	addiw	a5,a5,1
ffffffffc0204baa:	850a                	mv	a0,sp
ffffffffc0204bac:	d81c                	sw	a5,48(s0)
ffffffffc0204bae:	792000ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0204bb2:	02843903          	ld	s2,40(s0)
ffffffffc0204bb6:	84aa                	mv	s1,a0
ffffffffc0204bb8:	06090163          	beqz	s2,ffffffffc0204c1a <file_read+0xc6>
ffffffffc0204bbc:	07093783          	ld	a5,112(s2)
ffffffffc0204bc0:	cfa9                	beqz	a5,ffffffffc0204c1a <file_read+0xc6>
ffffffffc0204bc2:	6f9c                	ld	a5,24(a5)
ffffffffc0204bc4:	cbb9                	beqz	a5,ffffffffc0204c1a <file_read+0xc6>
ffffffffc0204bc6:	00009597          	auipc	a1,0x9
ffffffffc0204bca:	80258593          	addi	a1,a1,-2046 # ffffffffc020d3c8 <default_pmm_manager+0xd88>
ffffffffc0204bce:	854a                	mv	a0,s2
ffffffffc0204bd0:	68d020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204bd4:	07093783          	ld	a5,112(s2)
ffffffffc0204bd8:	7408                	ld	a0,40(s0)
ffffffffc0204bda:	85a6                	mv	a1,s1
ffffffffc0204bdc:	6f9c                	ld	a5,24(a5)
ffffffffc0204bde:	9782                	jalr	a5
ffffffffc0204be0:	689c                	ld	a5,16(s1)
ffffffffc0204be2:	6c94                	ld	a3,24(s1)
ffffffffc0204be4:	4018                	lw	a4,0(s0)
ffffffffc0204be6:	84aa                	mv	s1,a0
ffffffffc0204be8:	8f95                	sub	a5,a5,a3
ffffffffc0204bea:	03370063          	beq	a4,s3,ffffffffc0204c0a <file_read+0xb6>
ffffffffc0204bee:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204bf2:	8522                	mv	a0,s0
ffffffffc0204bf4:	c0fff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204bf8:	60a6                	ld	ra,72(sp)
ffffffffc0204bfa:	6406                	ld	s0,64(sp)
ffffffffc0204bfc:	7942                	ld	s2,48(sp)
ffffffffc0204bfe:	79a2                	ld	s3,40(sp)
ffffffffc0204c00:	7a02                	ld	s4,32(sp)
ffffffffc0204c02:	8526                	mv	a0,s1
ffffffffc0204c04:	74e2                	ld	s1,56(sp)
ffffffffc0204c06:	6161                	addi	sp,sp,80
ffffffffc0204c08:	8082                	ret
ffffffffc0204c0a:	7018                	ld	a4,32(s0)
ffffffffc0204c0c:	973e                	add	a4,a4,a5
ffffffffc0204c0e:	f018                	sd	a4,32(s0)
ffffffffc0204c10:	bff9                	j	ffffffffc0204bee <file_read+0x9a>
ffffffffc0204c12:	54f5                	li	s1,-3
ffffffffc0204c14:	b7d5                	j	ffffffffc0204bf8 <file_read+0xa4>
ffffffffc0204c16:	abbff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204c1a:	00008697          	auipc	a3,0x8
ffffffffc0204c1e:	75e68693          	addi	a3,a3,1886 # ffffffffc020d378 <default_pmm_manager+0xd38>
ffffffffc0204c22:	00007617          	auipc	a2,0x7
ffffffffc0204c26:	f3660613          	addi	a2,a2,-202 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204c2a:	0de00593          	li	a1,222
ffffffffc0204c2e:	00008517          	auipc	a0,0x8
ffffffffc0204c32:	5ba50513          	addi	a0,a0,1466 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204c36:	869fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204c3a <file_write>:
ffffffffc0204c3a:	715d                	addi	sp,sp,-80
ffffffffc0204c3c:	e486                	sd	ra,72(sp)
ffffffffc0204c3e:	e0a2                	sd	s0,64(sp)
ffffffffc0204c40:	fc26                	sd	s1,56(sp)
ffffffffc0204c42:	f84a                	sd	s2,48(sp)
ffffffffc0204c44:	f44e                	sd	s3,40(sp)
ffffffffc0204c46:	f052                	sd	s4,32(sp)
ffffffffc0204c48:	0006b023          	sd	zero,0(a3)
ffffffffc0204c4c:	04700793          	li	a5,71
ffffffffc0204c50:	0aa7e463          	bltu	a5,a0,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c54:	00092797          	auipc	a5,0x92
ffffffffc0204c58:	c6c7b783          	ld	a5,-916(a5) # ffffffffc02968c0 <current>
ffffffffc0204c5c:	1487b783          	ld	a5,328(a5)
ffffffffc0204c60:	cfd1                	beqz	a5,ffffffffc0204cfc <file_write+0xc2>
ffffffffc0204c62:	4b98                	lw	a4,16(a5)
ffffffffc0204c64:	08e05c63          	blez	a4,ffffffffc0204cfc <file_write+0xc2>
ffffffffc0204c68:	6780                	ld	s0,8(a5)
ffffffffc0204c6a:	00351793          	slli	a5,a0,0x3
ffffffffc0204c6e:	8f89                	sub	a5,a5,a0
ffffffffc0204c70:	078e                	slli	a5,a5,0x3
ffffffffc0204c72:	943e                	add	s0,s0,a5
ffffffffc0204c74:	00042983          	lw	s3,0(s0)
ffffffffc0204c78:	4789                	li	a5,2
ffffffffc0204c7a:	06f99f63          	bne	s3,a5,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c7e:	4c1c                	lw	a5,24(s0)
ffffffffc0204c80:	06a79c63          	bne	a5,a0,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c84:	681c                	ld	a5,16(s0)
ffffffffc0204c86:	cbad                	beqz	a5,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c88:	581c                	lw	a5,48(s0)
ffffffffc0204c8a:	8a36                	mv	s4,a3
ffffffffc0204c8c:	7014                	ld	a3,32(s0)
ffffffffc0204c8e:	2785                	addiw	a5,a5,1
ffffffffc0204c90:	850a                	mv	a0,sp
ffffffffc0204c92:	d81c                	sw	a5,48(s0)
ffffffffc0204c94:	6ac000ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0204c98:	02843903          	ld	s2,40(s0)
ffffffffc0204c9c:	84aa                	mv	s1,a0
ffffffffc0204c9e:	06090163          	beqz	s2,ffffffffc0204d00 <file_write+0xc6>
ffffffffc0204ca2:	07093783          	ld	a5,112(s2)
ffffffffc0204ca6:	cfa9                	beqz	a5,ffffffffc0204d00 <file_write+0xc6>
ffffffffc0204ca8:	739c                	ld	a5,32(a5)
ffffffffc0204caa:	cbb9                	beqz	a5,ffffffffc0204d00 <file_write+0xc6>
ffffffffc0204cac:	00008597          	auipc	a1,0x8
ffffffffc0204cb0:	77458593          	addi	a1,a1,1908 # ffffffffc020d420 <default_pmm_manager+0xde0>
ffffffffc0204cb4:	854a                	mv	a0,s2
ffffffffc0204cb6:	5a7020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204cba:	07093783          	ld	a5,112(s2)
ffffffffc0204cbe:	7408                	ld	a0,40(s0)
ffffffffc0204cc0:	85a6                	mv	a1,s1
ffffffffc0204cc2:	739c                	ld	a5,32(a5)
ffffffffc0204cc4:	9782                	jalr	a5
ffffffffc0204cc6:	689c                	ld	a5,16(s1)
ffffffffc0204cc8:	6c94                	ld	a3,24(s1)
ffffffffc0204cca:	4018                	lw	a4,0(s0)
ffffffffc0204ccc:	84aa                	mv	s1,a0
ffffffffc0204cce:	8f95                	sub	a5,a5,a3
ffffffffc0204cd0:	03370063          	beq	a4,s3,ffffffffc0204cf0 <file_write+0xb6>
ffffffffc0204cd4:	00fa3023          	sd	a5,0(s4)
ffffffffc0204cd8:	8522                	mv	a0,s0
ffffffffc0204cda:	b29ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204cde:	60a6                	ld	ra,72(sp)
ffffffffc0204ce0:	6406                	ld	s0,64(sp)
ffffffffc0204ce2:	7942                	ld	s2,48(sp)
ffffffffc0204ce4:	79a2                	ld	s3,40(sp)
ffffffffc0204ce6:	7a02                	ld	s4,32(sp)
ffffffffc0204ce8:	8526                	mv	a0,s1
ffffffffc0204cea:	74e2                	ld	s1,56(sp)
ffffffffc0204cec:	6161                	addi	sp,sp,80
ffffffffc0204cee:	8082                	ret
ffffffffc0204cf0:	7018                	ld	a4,32(s0)
ffffffffc0204cf2:	973e                	add	a4,a4,a5
ffffffffc0204cf4:	f018                	sd	a4,32(s0)
ffffffffc0204cf6:	bff9                	j	ffffffffc0204cd4 <file_write+0x9a>
ffffffffc0204cf8:	54f5                	li	s1,-3
ffffffffc0204cfa:	b7d5                	j	ffffffffc0204cde <file_write+0xa4>
ffffffffc0204cfc:	9d5ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204d00:	00008697          	auipc	a3,0x8
ffffffffc0204d04:	6d068693          	addi	a3,a3,1744 # ffffffffc020d3d0 <default_pmm_manager+0xd90>
ffffffffc0204d08:	00007617          	auipc	a2,0x7
ffffffffc0204d0c:	e5060613          	addi	a2,a2,-432 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204d10:	0f800593          	li	a1,248
ffffffffc0204d14:	00008517          	auipc	a0,0x8
ffffffffc0204d18:	4d450513          	addi	a0,a0,1236 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204d1c:	f82fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204d20 <file_seek>:
ffffffffc0204d20:	7139                	addi	sp,sp,-64
ffffffffc0204d22:	fc06                	sd	ra,56(sp)
ffffffffc0204d24:	f822                	sd	s0,48(sp)
ffffffffc0204d26:	f426                	sd	s1,40(sp)
ffffffffc0204d28:	f04a                	sd	s2,32(sp)
ffffffffc0204d2a:	04700793          	li	a5,71
ffffffffc0204d2e:	08a7e863          	bltu	a5,a0,ffffffffc0204dbe <file_seek+0x9e>
ffffffffc0204d32:	00092797          	auipc	a5,0x92
ffffffffc0204d36:	b8e7b783          	ld	a5,-1138(a5) # ffffffffc02968c0 <current>
ffffffffc0204d3a:	1487b783          	ld	a5,328(a5)
ffffffffc0204d3e:	cfdd                	beqz	a5,ffffffffc0204dfc <file_seek+0xdc>
ffffffffc0204d40:	4b98                	lw	a4,16(a5)
ffffffffc0204d42:	0ae05d63          	blez	a4,ffffffffc0204dfc <file_seek+0xdc>
ffffffffc0204d46:	6780                	ld	s0,8(a5)
ffffffffc0204d48:	00351793          	slli	a5,a0,0x3
ffffffffc0204d4c:	8f89                	sub	a5,a5,a0
ffffffffc0204d4e:	078e                	slli	a5,a5,0x3
ffffffffc0204d50:	943e                	add	s0,s0,a5
ffffffffc0204d52:	4018                	lw	a4,0(s0)
ffffffffc0204d54:	4789                	li	a5,2
ffffffffc0204d56:	06f71463          	bne	a4,a5,ffffffffc0204dbe <file_seek+0x9e>
ffffffffc0204d5a:	4c1c                	lw	a5,24(s0)
ffffffffc0204d5c:	06a79163          	bne	a5,a0,ffffffffc0204dbe <file_seek+0x9e>
ffffffffc0204d60:	581c                	lw	a5,48(s0)
ffffffffc0204d62:	4685                	li	a3,1
ffffffffc0204d64:	892e                	mv	s2,a1
ffffffffc0204d66:	2785                	addiw	a5,a5,1
ffffffffc0204d68:	d81c                	sw	a5,48(s0)
ffffffffc0204d6a:	02d60063          	beq	a2,a3,ffffffffc0204d8a <file_seek+0x6a>
ffffffffc0204d6e:	06e60063          	beq	a2,a4,ffffffffc0204dce <file_seek+0xae>
ffffffffc0204d72:	54f5                	li	s1,-3
ffffffffc0204d74:	ce11                	beqz	a2,ffffffffc0204d90 <file_seek+0x70>
ffffffffc0204d76:	8522                	mv	a0,s0
ffffffffc0204d78:	a8bff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204d7c:	70e2                	ld	ra,56(sp)
ffffffffc0204d7e:	7442                	ld	s0,48(sp)
ffffffffc0204d80:	7902                	ld	s2,32(sp)
ffffffffc0204d82:	8526                	mv	a0,s1
ffffffffc0204d84:	74a2                	ld	s1,40(sp)
ffffffffc0204d86:	6121                	addi	sp,sp,64
ffffffffc0204d88:	8082                	ret
ffffffffc0204d8a:	701c                	ld	a5,32(s0)
ffffffffc0204d8c:	00f58933          	add	s2,a1,a5
ffffffffc0204d90:	7404                	ld	s1,40(s0)
ffffffffc0204d92:	c4bd                	beqz	s1,ffffffffc0204e00 <file_seek+0xe0>
ffffffffc0204d94:	78bc                	ld	a5,112(s1)
ffffffffc0204d96:	c7ad                	beqz	a5,ffffffffc0204e00 <file_seek+0xe0>
ffffffffc0204d98:	6fbc                	ld	a5,88(a5)
ffffffffc0204d9a:	c3bd                	beqz	a5,ffffffffc0204e00 <file_seek+0xe0>
ffffffffc0204d9c:	8526                	mv	a0,s1
ffffffffc0204d9e:	00008597          	auipc	a1,0x8
ffffffffc0204da2:	6da58593          	addi	a1,a1,1754 # ffffffffc020d478 <default_pmm_manager+0xe38>
ffffffffc0204da6:	4b7020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204daa:	78bc                	ld	a5,112(s1)
ffffffffc0204dac:	7408                	ld	a0,40(s0)
ffffffffc0204dae:	85ca                	mv	a1,s2
ffffffffc0204db0:	6fbc                	ld	a5,88(a5)
ffffffffc0204db2:	9782                	jalr	a5
ffffffffc0204db4:	84aa                	mv	s1,a0
ffffffffc0204db6:	f161                	bnez	a0,ffffffffc0204d76 <file_seek+0x56>
ffffffffc0204db8:	03243023          	sd	s2,32(s0)
ffffffffc0204dbc:	bf6d                	j	ffffffffc0204d76 <file_seek+0x56>
ffffffffc0204dbe:	70e2                	ld	ra,56(sp)
ffffffffc0204dc0:	7442                	ld	s0,48(sp)
ffffffffc0204dc2:	54f5                	li	s1,-3
ffffffffc0204dc4:	7902                	ld	s2,32(sp)
ffffffffc0204dc6:	8526                	mv	a0,s1
ffffffffc0204dc8:	74a2                	ld	s1,40(sp)
ffffffffc0204dca:	6121                	addi	sp,sp,64
ffffffffc0204dcc:	8082                	ret
ffffffffc0204dce:	7404                	ld	s1,40(s0)
ffffffffc0204dd0:	c8a1                	beqz	s1,ffffffffc0204e20 <file_seek+0x100>
ffffffffc0204dd2:	78bc                	ld	a5,112(s1)
ffffffffc0204dd4:	c7b1                	beqz	a5,ffffffffc0204e20 <file_seek+0x100>
ffffffffc0204dd6:	779c                	ld	a5,40(a5)
ffffffffc0204dd8:	c7a1                	beqz	a5,ffffffffc0204e20 <file_seek+0x100>
ffffffffc0204dda:	8526                	mv	a0,s1
ffffffffc0204ddc:	00008597          	auipc	a1,0x8
ffffffffc0204de0:	59458593          	addi	a1,a1,1428 # ffffffffc020d370 <default_pmm_manager+0xd30>
ffffffffc0204de4:	479020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204de8:	78bc                	ld	a5,112(s1)
ffffffffc0204dea:	7408                	ld	a0,40(s0)
ffffffffc0204dec:	858a                	mv	a1,sp
ffffffffc0204dee:	779c                	ld	a5,40(a5)
ffffffffc0204df0:	9782                	jalr	a5
ffffffffc0204df2:	84aa                	mv	s1,a0
ffffffffc0204df4:	f149                	bnez	a0,ffffffffc0204d76 <file_seek+0x56>
ffffffffc0204df6:	67e2                	ld	a5,24(sp)
ffffffffc0204df8:	993e                	add	s2,s2,a5
ffffffffc0204dfa:	bf59                	j	ffffffffc0204d90 <file_seek+0x70>
ffffffffc0204dfc:	8d5ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204e00:	00008697          	auipc	a3,0x8
ffffffffc0204e04:	62868693          	addi	a3,a3,1576 # ffffffffc020d428 <default_pmm_manager+0xde8>
ffffffffc0204e08:	00007617          	auipc	a2,0x7
ffffffffc0204e0c:	d5060613          	addi	a2,a2,-688 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204e10:	11a00593          	li	a1,282
ffffffffc0204e14:	00008517          	auipc	a0,0x8
ffffffffc0204e18:	3d450513          	addi	a0,a0,980 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204e1c:	e82fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204e20:	00008697          	auipc	a3,0x8
ffffffffc0204e24:	50068693          	addi	a3,a3,1280 # ffffffffc020d320 <default_pmm_manager+0xce0>
ffffffffc0204e28:	00007617          	auipc	a2,0x7
ffffffffc0204e2c:	d3060613          	addi	a2,a2,-720 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204e30:	11200593          	li	a1,274
ffffffffc0204e34:	00008517          	auipc	a0,0x8
ffffffffc0204e38:	3b450513          	addi	a0,a0,948 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204e3c:	e62fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204e40 <file_fstat>:
ffffffffc0204e40:	1101                	addi	sp,sp,-32
ffffffffc0204e42:	ec06                	sd	ra,24(sp)
ffffffffc0204e44:	e822                	sd	s0,16(sp)
ffffffffc0204e46:	e426                	sd	s1,8(sp)
ffffffffc0204e48:	e04a                	sd	s2,0(sp)
ffffffffc0204e4a:	04700793          	li	a5,71
ffffffffc0204e4e:	06a7ef63          	bltu	a5,a0,ffffffffc0204ecc <file_fstat+0x8c>
ffffffffc0204e52:	00092797          	auipc	a5,0x92
ffffffffc0204e56:	a6e7b783          	ld	a5,-1426(a5) # ffffffffc02968c0 <current>
ffffffffc0204e5a:	1487b783          	ld	a5,328(a5)
ffffffffc0204e5e:	cfd9                	beqz	a5,ffffffffc0204efc <file_fstat+0xbc>
ffffffffc0204e60:	4b98                	lw	a4,16(a5)
ffffffffc0204e62:	08e05d63          	blez	a4,ffffffffc0204efc <file_fstat+0xbc>
ffffffffc0204e66:	6780                	ld	s0,8(a5)
ffffffffc0204e68:	00351793          	slli	a5,a0,0x3
ffffffffc0204e6c:	8f89                	sub	a5,a5,a0
ffffffffc0204e6e:	078e                	slli	a5,a5,0x3
ffffffffc0204e70:	943e                	add	s0,s0,a5
ffffffffc0204e72:	4018                	lw	a4,0(s0)
ffffffffc0204e74:	4789                	li	a5,2
ffffffffc0204e76:	04f71b63          	bne	a4,a5,ffffffffc0204ecc <file_fstat+0x8c>
ffffffffc0204e7a:	4c1c                	lw	a5,24(s0)
ffffffffc0204e7c:	04a79863          	bne	a5,a0,ffffffffc0204ecc <file_fstat+0x8c>
ffffffffc0204e80:	581c                	lw	a5,48(s0)
ffffffffc0204e82:	02843903          	ld	s2,40(s0)
ffffffffc0204e86:	2785                	addiw	a5,a5,1
ffffffffc0204e88:	d81c                	sw	a5,48(s0)
ffffffffc0204e8a:	04090963          	beqz	s2,ffffffffc0204edc <file_fstat+0x9c>
ffffffffc0204e8e:	07093783          	ld	a5,112(s2)
ffffffffc0204e92:	c7a9                	beqz	a5,ffffffffc0204edc <file_fstat+0x9c>
ffffffffc0204e94:	779c                	ld	a5,40(a5)
ffffffffc0204e96:	c3b9                	beqz	a5,ffffffffc0204edc <file_fstat+0x9c>
ffffffffc0204e98:	84ae                	mv	s1,a1
ffffffffc0204e9a:	854a                	mv	a0,s2
ffffffffc0204e9c:	00008597          	auipc	a1,0x8
ffffffffc0204ea0:	4d458593          	addi	a1,a1,1236 # ffffffffc020d370 <default_pmm_manager+0xd30>
ffffffffc0204ea4:	3b9020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204ea8:	07093783          	ld	a5,112(s2)
ffffffffc0204eac:	7408                	ld	a0,40(s0)
ffffffffc0204eae:	85a6                	mv	a1,s1
ffffffffc0204eb0:	779c                	ld	a5,40(a5)
ffffffffc0204eb2:	9782                	jalr	a5
ffffffffc0204eb4:	87aa                	mv	a5,a0
ffffffffc0204eb6:	8522                	mv	a0,s0
ffffffffc0204eb8:	843e                	mv	s0,a5
ffffffffc0204eba:	949ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204ebe:	60e2                	ld	ra,24(sp)
ffffffffc0204ec0:	8522                	mv	a0,s0
ffffffffc0204ec2:	6442                	ld	s0,16(sp)
ffffffffc0204ec4:	64a2                	ld	s1,8(sp)
ffffffffc0204ec6:	6902                	ld	s2,0(sp)
ffffffffc0204ec8:	6105                	addi	sp,sp,32
ffffffffc0204eca:	8082                	ret
ffffffffc0204ecc:	5475                	li	s0,-3
ffffffffc0204ece:	60e2                	ld	ra,24(sp)
ffffffffc0204ed0:	8522                	mv	a0,s0
ffffffffc0204ed2:	6442                	ld	s0,16(sp)
ffffffffc0204ed4:	64a2                	ld	s1,8(sp)
ffffffffc0204ed6:	6902                	ld	s2,0(sp)
ffffffffc0204ed8:	6105                	addi	sp,sp,32
ffffffffc0204eda:	8082                	ret
ffffffffc0204edc:	00008697          	auipc	a3,0x8
ffffffffc0204ee0:	44468693          	addi	a3,a3,1092 # ffffffffc020d320 <default_pmm_manager+0xce0>
ffffffffc0204ee4:	00007617          	auipc	a2,0x7
ffffffffc0204ee8:	c7460613          	addi	a2,a2,-908 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204eec:	12c00593          	li	a1,300
ffffffffc0204ef0:	00008517          	auipc	a0,0x8
ffffffffc0204ef4:	2f850513          	addi	a0,a0,760 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204ef8:	da6fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204efc:	fd4ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204f00 <file_fsync>:
ffffffffc0204f00:	1101                	addi	sp,sp,-32
ffffffffc0204f02:	ec06                	sd	ra,24(sp)
ffffffffc0204f04:	e822                	sd	s0,16(sp)
ffffffffc0204f06:	e426                	sd	s1,8(sp)
ffffffffc0204f08:	04700793          	li	a5,71
ffffffffc0204f0c:	06a7e863          	bltu	a5,a0,ffffffffc0204f7c <file_fsync+0x7c>
ffffffffc0204f10:	00092797          	auipc	a5,0x92
ffffffffc0204f14:	9b07b783          	ld	a5,-1616(a5) # ffffffffc02968c0 <current>
ffffffffc0204f18:	1487b783          	ld	a5,328(a5)
ffffffffc0204f1c:	c7d9                	beqz	a5,ffffffffc0204faa <file_fsync+0xaa>
ffffffffc0204f1e:	4b98                	lw	a4,16(a5)
ffffffffc0204f20:	08e05563          	blez	a4,ffffffffc0204faa <file_fsync+0xaa>
ffffffffc0204f24:	6780                	ld	s0,8(a5)
ffffffffc0204f26:	00351793          	slli	a5,a0,0x3
ffffffffc0204f2a:	8f89                	sub	a5,a5,a0
ffffffffc0204f2c:	078e                	slli	a5,a5,0x3
ffffffffc0204f2e:	943e                	add	s0,s0,a5
ffffffffc0204f30:	4018                	lw	a4,0(s0)
ffffffffc0204f32:	4789                	li	a5,2
ffffffffc0204f34:	04f71463          	bne	a4,a5,ffffffffc0204f7c <file_fsync+0x7c>
ffffffffc0204f38:	4c1c                	lw	a5,24(s0)
ffffffffc0204f3a:	04a79163          	bne	a5,a0,ffffffffc0204f7c <file_fsync+0x7c>
ffffffffc0204f3e:	581c                	lw	a5,48(s0)
ffffffffc0204f40:	7404                	ld	s1,40(s0)
ffffffffc0204f42:	2785                	addiw	a5,a5,1
ffffffffc0204f44:	d81c                	sw	a5,48(s0)
ffffffffc0204f46:	c0b1                	beqz	s1,ffffffffc0204f8a <file_fsync+0x8a>
ffffffffc0204f48:	78bc                	ld	a5,112(s1)
ffffffffc0204f4a:	c3a1                	beqz	a5,ffffffffc0204f8a <file_fsync+0x8a>
ffffffffc0204f4c:	7b9c                	ld	a5,48(a5)
ffffffffc0204f4e:	cf95                	beqz	a5,ffffffffc0204f8a <file_fsync+0x8a>
ffffffffc0204f50:	00008597          	auipc	a1,0x8
ffffffffc0204f54:	58058593          	addi	a1,a1,1408 # ffffffffc020d4d0 <default_pmm_manager+0xe90>
ffffffffc0204f58:	8526                	mv	a0,s1
ffffffffc0204f5a:	303020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0204f5e:	78bc                	ld	a5,112(s1)
ffffffffc0204f60:	7408                	ld	a0,40(s0)
ffffffffc0204f62:	7b9c                	ld	a5,48(a5)
ffffffffc0204f64:	9782                	jalr	a5
ffffffffc0204f66:	87aa                	mv	a5,a0
ffffffffc0204f68:	8522                	mv	a0,s0
ffffffffc0204f6a:	843e                	mv	s0,a5
ffffffffc0204f6c:	897ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204f70:	60e2                	ld	ra,24(sp)
ffffffffc0204f72:	8522                	mv	a0,s0
ffffffffc0204f74:	6442                	ld	s0,16(sp)
ffffffffc0204f76:	64a2                	ld	s1,8(sp)
ffffffffc0204f78:	6105                	addi	sp,sp,32
ffffffffc0204f7a:	8082                	ret
ffffffffc0204f7c:	5475                	li	s0,-3
ffffffffc0204f7e:	60e2                	ld	ra,24(sp)
ffffffffc0204f80:	8522                	mv	a0,s0
ffffffffc0204f82:	6442                	ld	s0,16(sp)
ffffffffc0204f84:	64a2                	ld	s1,8(sp)
ffffffffc0204f86:	6105                	addi	sp,sp,32
ffffffffc0204f88:	8082                	ret
ffffffffc0204f8a:	00008697          	auipc	a3,0x8
ffffffffc0204f8e:	4f668693          	addi	a3,a3,1270 # ffffffffc020d480 <default_pmm_manager+0xe40>
ffffffffc0204f92:	00007617          	auipc	a2,0x7
ffffffffc0204f96:	bc660613          	addi	a2,a2,-1082 # ffffffffc020bb58 <commands+0x210>
ffffffffc0204f9a:	13a00593          	li	a1,314
ffffffffc0204f9e:	00008517          	auipc	a0,0x8
ffffffffc0204fa2:	24a50513          	addi	a0,a0,586 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc0204fa6:	cf8fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204faa:	f26ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204fae <file_getdirentry>:
ffffffffc0204fae:	715d                	addi	sp,sp,-80
ffffffffc0204fb0:	e486                	sd	ra,72(sp)
ffffffffc0204fb2:	e0a2                	sd	s0,64(sp)
ffffffffc0204fb4:	fc26                	sd	s1,56(sp)
ffffffffc0204fb6:	f84a                	sd	s2,48(sp)
ffffffffc0204fb8:	f44e                	sd	s3,40(sp)
ffffffffc0204fba:	04700793          	li	a5,71
ffffffffc0204fbe:	0aa7e063          	bltu	a5,a0,ffffffffc020505e <file_getdirentry+0xb0>
ffffffffc0204fc2:	00092797          	auipc	a5,0x92
ffffffffc0204fc6:	8fe7b783          	ld	a5,-1794(a5) # ffffffffc02968c0 <current>
ffffffffc0204fca:	1487b783          	ld	a5,328(a5)
ffffffffc0204fce:	c3e9                	beqz	a5,ffffffffc0205090 <file_getdirentry+0xe2>
ffffffffc0204fd0:	4b98                	lw	a4,16(a5)
ffffffffc0204fd2:	0ae05f63          	blez	a4,ffffffffc0205090 <file_getdirentry+0xe2>
ffffffffc0204fd6:	6780                	ld	s0,8(a5)
ffffffffc0204fd8:	00351793          	slli	a5,a0,0x3
ffffffffc0204fdc:	8f89                	sub	a5,a5,a0
ffffffffc0204fde:	078e                	slli	a5,a5,0x3
ffffffffc0204fe0:	943e                	add	s0,s0,a5
ffffffffc0204fe2:	4018                	lw	a4,0(s0)
ffffffffc0204fe4:	4789                	li	a5,2
ffffffffc0204fe6:	06f71c63          	bne	a4,a5,ffffffffc020505e <file_getdirentry+0xb0>
ffffffffc0204fea:	4c1c                	lw	a5,24(s0)
ffffffffc0204fec:	06a79963          	bne	a5,a0,ffffffffc020505e <file_getdirentry+0xb0>
ffffffffc0204ff0:	581c                	lw	a5,48(s0)
ffffffffc0204ff2:	6194                	ld	a3,0(a1)
ffffffffc0204ff4:	84ae                	mv	s1,a1
ffffffffc0204ff6:	2785                	addiw	a5,a5,1
ffffffffc0204ff8:	10000613          	li	a2,256
ffffffffc0204ffc:	d81c                	sw	a5,48(s0)
ffffffffc0204ffe:	05a1                	addi	a1,a1,8
ffffffffc0205000:	850a                	mv	a0,sp
ffffffffc0205002:	33e000ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0205006:	02843983          	ld	s3,40(s0)
ffffffffc020500a:	892a                	mv	s2,a0
ffffffffc020500c:	06098263          	beqz	s3,ffffffffc0205070 <file_getdirentry+0xc2>
ffffffffc0205010:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc0205014:	cfb1                	beqz	a5,ffffffffc0205070 <file_getdirentry+0xc2>
ffffffffc0205016:	63bc                	ld	a5,64(a5)
ffffffffc0205018:	cfa1                	beqz	a5,ffffffffc0205070 <file_getdirentry+0xc2>
ffffffffc020501a:	854e                	mv	a0,s3
ffffffffc020501c:	00008597          	auipc	a1,0x8
ffffffffc0205020:	51458593          	addi	a1,a1,1300 # ffffffffc020d530 <default_pmm_manager+0xef0>
ffffffffc0205024:	239020ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0205028:	0709b783          	ld	a5,112(s3)
ffffffffc020502c:	7408                	ld	a0,40(s0)
ffffffffc020502e:	85ca                	mv	a1,s2
ffffffffc0205030:	63bc                	ld	a5,64(a5)
ffffffffc0205032:	9782                	jalr	a5
ffffffffc0205034:	89aa                	mv	s3,a0
ffffffffc0205036:	e909                	bnez	a0,ffffffffc0205048 <file_getdirentry+0x9a>
ffffffffc0205038:	609c                	ld	a5,0(s1)
ffffffffc020503a:	01093683          	ld	a3,16(s2)
ffffffffc020503e:	01893703          	ld	a4,24(s2)
ffffffffc0205042:	97b6                	add	a5,a5,a3
ffffffffc0205044:	8f99                	sub	a5,a5,a4
ffffffffc0205046:	e09c                	sd	a5,0(s1)
ffffffffc0205048:	8522                	mv	a0,s0
ffffffffc020504a:	fb8ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc020504e:	60a6                	ld	ra,72(sp)
ffffffffc0205050:	6406                	ld	s0,64(sp)
ffffffffc0205052:	74e2                	ld	s1,56(sp)
ffffffffc0205054:	7942                	ld	s2,48(sp)
ffffffffc0205056:	854e                	mv	a0,s3
ffffffffc0205058:	79a2                	ld	s3,40(sp)
ffffffffc020505a:	6161                	addi	sp,sp,80
ffffffffc020505c:	8082                	ret
ffffffffc020505e:	60a6                	ld	ra,72(sp)
ffffffffc0205060:	6406                	ld	s0,64(sp)
ffffffffc0205062:	59f5                	li	s3,-3
ffffffffc0205064:	74e2                	ld	s1,56(sp)
ffffffffc0205066:	7942                	ld	s2,48(sp)
ffffffffc0205068:	854e                	mv	a0,s3
ffffffffc020506a:	79a2                	ld	s3,40(sp)
ffffffffc020506c:	6161                	addi	sp,sp,80
ffffffffc020506e:	8082                	ret
ffffffffc0205070:	00008697          	auipc	a3,0x8
ffffffffc0205074:	46868693          	addi	a3,a3,1128 # ffffffffc020d4d8 <default_pmm_manager+0xe98>
ffffffffc0205078:	00007617          	auipc	a2,0x7
ffffffffc020507c:	ae060613          	addi	a2,a2,-1312 # ffffffffc020bb58 <commands+0x210>
ffffffffc0205080:	14a00593          	li	a1,330
ffffffffc0205084:	00008517          	auipc	a0,0x8
ffffffffc0205088:	16450513          	addi	a0,a0,356 # ffffffffc020d1e8 <default_pmm_manager+0xba8>
ffffffffc020508c:	c12fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205090:	e40ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0205094 <file_dup>:
ffffffffc0205094:	04700713          	li	a4,71
ffffffffc0205098:	06a76463          	bltu	a4,a0,ffffffffc0205100 <file_dup+0x6c>
ffffffffc020509c:	00092717          	auipc	a4,0x92
ffffffffc02050a0:	82473703          	ld	a4,-2012(a4) # ffffffffc02968c0 <current>
ffffffffc02050a4:	14873703          	ld	a4,328(a4)
ffffffffc02050a8:	1101                	addi	sp,sp,-32
ffffffffc02050aa:	ec06                	sd	ra,24(sp)
ffffffffc02050ac:	e822                	sd	s0,16(sp)
ffffffffc02050ae:	cb39                	beqz	a4,ffffffffc0205104 <file_dup+0x70>
ffffffffc02050b0:	4b14                	lw	a3,16(a4)
ffffffffc02050b2:	04d05963          	blez	a3,ffffffffc0205104 <file_dup+0x70>
ffffffffc02050b6:	6700                	ld	s0,8(a4)
ffffffffc02050b8:	00351713          	slli	a4,a0,0x3
ffffffffc02050bc:	8f09                	sub	a4,a4,a0
ffffffffc02050be:	070e                	slli	a4,a4,0x3
ffffffffc02050c0:	943a                	add	s0,s0,a4
ffffffffc02050c2:	4014                	lw	a3,0(s0)
ffffffffc02050c4:	4709                	li	a4,2
ffffffffc02050c6:	02e69863          	bne	a3,a4,ffffffffc02050f6 <file_dup+0x62>
ffffffffc02050ca:	4c18                	lw	a4,24(s0)
ffffffffc02050cc:	02a71563          	bne	a4,a0,ffffffffc02050f6 <file_dup+0x62>
ffffffffc02050d0:	852e                	mv	a0,a1
ffffffffc02050d2:	002c                	addi	a1,sp,8
ffffffffc02050d4:	e1eff0ef          	jal	ra,ffffffffc02046f2 <fd_array_alloc>
ffffffffc02050d8:	c509                	beqz	a0,ffffffffc02050e2 <file_dup+0x4e>
ffffffffc02050da:	60e2                	ld	ra,24(sp)
ffffffffc02050dc:	6442                	ld	s0,16(sp)
ffffffffc02050de:	6105                	addi	sp,sp,32
ffffffffc02050e0:	8082                	ret
ffffffffc02050e2:	6522                	ld	a0,8(sp)
ffffffffc02050e4:	85a2                	mv	a1,s0
ffffffffc02050e6:	845ff0ef          	jal	ra,ffffffffc020492a <fd_array_dup>
ffffffffc02050ea:	67a2                	ld	a5,8(sp)
ffffffffc02050ec:	60e2                	ld	ra,24(sp)
ffffffffc02050ee:	6442                	ld	s0,16(sp)
ffffffffc02050f0:	4f88                	lw	a0,24(a5)
ffffffffc02050f2:	6105                	addi	sp,sp,32
ffffffffc02050f4:	8082                	ret
ffffffffc02050f6:	60e2                	ld	ra,24(sp)
ffffffffc02050f8:	6442                	ld	s0,16(sp)
ffffffffc02050fa:	5575                	li	a0,-3
ffffffffc02050fc:	6105                	addi	sp,sp,32
ffffffffc02050fe:	8082                	ret
ffffffffc0205100:	5575                	li	a0,-3
ffffffffc0205102:	8082                	ret
ffffffffc0205104:	dccff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0205108 <fs_init>:
ffffffffc0205108:	1141                	addi	sp,sp,-16
ffffffffc020510a:	e406                	sd	ra,8(sp)
ffffffffc020510c:	36f020ef          	jal	ra,ffffffffc0207c7a <vfs_init>
ffffffffc0205110:	047030ef          	jal	ra,ffffffffc0208956 <dev_init>
ffffffffc0205114:	60a2                	ld	ra,8(sp)
ffffffffc0205116:	0141                	addi	sp,sp,16
ffffffffc0205118:	1960406f          	j	ffffffffc02092ae <sfs_init>

ffffffffc020511c <fs_cleanup>:
ffffffffc020511c:	5b10206f          	j	ffffffffc0207ecc <vfs_cleanup>

ffffffffc0205120 <lock_files>:
ffffffffc0205120:	0561                	addi	a0,a0,24
ffffffffc0205122:	ba0ff06f          	j	ffffffffc02044c2 <down>

ffffffffc0205126 <unlock_files>:
ffffffffc0205126:	0561                	addi	a0,a0,24
ffffffffc0205128:	b96ff06f          	j	ffffffffc02044be <up>

ffffffffc020512c <files_create>:
ffffffffc020512c:	1141                	addi	sp,sp,-16
ffffffffc020512e:	6505                	lui	a0,0x1
ffffffffc0205130:	e022                	sd	s0,0(sp)
ffffffffc0205132:	e406                	sd	ra,8(sp)
ffffffffc0205134:	e5bfc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205138:	842a                	mv	s0,a0
ffffffffc020513a:	cd19                	beqz	a0,ffffffffc0205158 <files_create+0x2c>
ffffffffc020513c:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0205140:	00043023          	sd	zero,0(s0)
ffffffffc0205144:	0561                	addi	a0,a0,24
ffffffffc0205146:	e41c                	sd	a5,8(s0)
ffffffffc0205148:	00042823          	sw	zero,16(s0)
ffffffffc020514c:	4585                	li	a1,1
ffffffffc020514e:	b6aff0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0205152:	6408                	ld	a0,8(s0)
ffffffffc0205154:	f3cff0ef          	jal	ra,ffffffffc0204890 <fd_array_init>
ffffffffc0205158:	60a2                	ld	ra,8(sp)
ffffffffc020515a:	8522                	mv	a0,s0
ffffffffc020515c:	6402                	ld	s0,0(sp)
ffffffffc020515e:	0141                	addi	sp,sp,16
ffffffffc0205160:	8082                	ret

ffffffffc0205162 <files_destroy>:
ffffffffc0205162:	7179                	addi	sp,sp,-48
ffffffffc0205164:	f406                	sd	ra,40(sp)
ffffffffc0205166:	f022                	sd	s0,32(sp)
ffffffffc0205168:	ec26                	sd	s1,24(sp)
ffffffffc020516a:	e84a                	sd	s2,16(sp)
ffffffffc020516c:	e44e                	sd	s3,8(sp)
ffffffffc020516e:	c52d                	beqz	a0,ffffffffc02051d8 <files_destroy+0x76>
ffffffffc0205170:	491c                	lw	a5,16(a0)
ffffffffc0205172:	89aa                	mv	s3,a0
ffffffffc0205174:	e3b5                	bnez	a5,ffffffffc02051d8 <files_destroy+0x76>
ffffffffc0205176:	6108                	ld	a0,0(a0)
ffffffffc0205178:	c119                	beqz	a0,ffffffffc020517e <files_destroy+0x1c>
ffffffffc020517a:	199020ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020517e:	0089b403          	ld	s0,8(s3)
ffffffffc0205182:	6485                	lui	s1,0x1
ffffffffc0205184:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205188:	94a2                	add	s1,s1,s0
ffffffffc020518a:	4909                	li	s2,2
ffffffffc020518c:	401c                	lw	a5,0(s0)
ffffffffc020518e:	03278063          	beq	a5,s2,ffffffffc02051ae <files_destroy+0x4c>
ffffffffc0205192:	e39d                	bnez	a5,ffffffffc02051b8 <files_destroy+0x56>
ffffffffc0205194:	03840413          	addi	s0,s0,56
ffffffffc0205198:	fe849ae3          	bne	s1,s0,ffffffffc020518c <files_destroy+0x2a>
ffffffffc020519c:	7402                	ld	s0,32(sp)
ffffffffc020519e:	70a2                	ld	ra,40(sp)
ffffffffc02051a0:	64e2                	ld	s1,24(sp)
ffffffffc02051a2:	6942                	ld	s2,16(sp)
ffffffffc02051a4:	854e                	mv	a0,s3
ffffffffc02051a6:	69a2                	ld	s3,8(sp)
ffffffffc02051a8:	6145                	addi	sp,sp,48
ffffffffc02051aa:	e95fc06f          	j	ffffffffc020203e <kfree>
ffffffffc02051ae:	8522                	mv	a0,s0
ffffffffc02051b0:	efcff0ef          	jal	ra,ffffffffc02048ac <fd_array_close>
ffffffffc02051b4:	401c                	lw	a5,0(s0)
ffffffffc02051b6:	bff1                	j	ffffffffc0205192 <files_destroy+0x30>
ffffffffc02051b8:	00008697          	auipc	a3,0x8
ffffffffc02051bc:	3f868693          	addi	a3,a3,1016 # ffffffffc020d5b0 <CSWTCH.79+0x58>
ffffffffc02051c0:	00007617          	auipc	a2,0x7
ffffffffc02051c4:	99860613          	addi	a2,a2,-1640 # ffffffffc020bb58 <commands+0x210>
ffffffffc02051c8:	03d00593          	li	a1,61
ffffffffc02051cc:	00008517          	auipc	a0,0x8
ffffffffc02051d0:	3d450513          	addi	a0,a0,980 # ffffffffc020d5a0 <CSWTCH.79+0x48>
ffffffffc02051d4:	acafb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02051d8:	00008697          	auipc	a3,0x8
ffffffffc02051dc:	39868693          	addi	a3,a3,920 # ffffffffc020d570 <CSWTCH.79+0x18>
ffffffffc02051e0:	00007617          	auipc	a2,0x7
ffffffffc02051e4:	97860613          	addi	a2,a2,-1672 # ffffffffc020bb58 <commands+0x210>
ffffffffc02051e8:	03300593          	li	a1,51
ffffffffc02051ec:	00008517          	auipc	a0,0x8
ffffffffc02051f0:	3b450513          	addi	a0,a0,948 # ffffffffc020d5a0 <CSWTCH.79+0x48>
ffffffffc02051f4:	aaafb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02051f8 <files_closeall>:
ffffffffc02051f8:	1101                	addi	sp,sp,-32
ffffffffc02051fa:	ec06                	sd	ra,24(sp)
ffffffffc02051fc:	e822                	sd	s0,16(sp)
ffffffffc02051fe:	e426                	sd	s1,8(sp)
ffffffffc0205200:	e04a                	sd	s2,0(sp)
ffffffffc0205202:	c129                	beqz	a0,ffffffffc0205244 <files_closeall+0x4c>
ffffffffc0205204:	491c                	lw	a5,16(a0)
ffffffffc0205206:	02f05f63          	blez	a5,ffffffffc0205244 <files_closeall+0x4c>
ffffffffc020520a:	6504                	ld	s1,8(a0)
ffffffffc020520c:	6785                	lui	a5,0x1
ffffffffc020520e:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205212:	07048413          	addi	s0,s1,112
ffffffffc0205216:	4909                	li	s2,2
ffffffffc0205218:	94be                	add	s1,s1,a5
ffffffffc020521a:	a029                	j	ffffffffc0205224 <files_closeall+0x2c>
ffffffffc020521c:	03840413          	addi	s0,s0,56
ffffffffc0205220:	00848c63          	beq	s1,s0,ffffffffc0205238 <files_closeall+0x40>
ffffffffc0205224:	401c                	lw	a5,0(s0)
ffffffffc0205226:	ff279be3          	bne	a5,s2,ffffffffc020521c <files_closeall+0x24>
ffffffffc020522a:	8522                	mv	a0,s0
ffffffffc020522c:	03840413          	addi	s0,s0,56
ffffffffc0205230:	e7cff0ef          	jal	ra,ffffffffc02048ac <fd_array_close>
ffffffffc0205234:	fe8498e3          	bne	s1,s0,ffffffffc0205224 <files_closeall+0x2c>
ffffffffc0205238:	60e2                	ld	ra,24(sp)
ffffffffc020523a:	6442                	ld	s0,16(sp)
ffffffffc020523c:	64a2                	ld	s1,8(sp)
ffffffffc020523e:	6902                	ld	s2,0(sp)
ffffffffc0205240:	6105                	addi	sp,sp,32
ffffffffc0205242:	8082                	ret
ffffffffc0205244:	00008697          	auipc	a3,0x8
ffffffffc0205248:	f7468693          	addi	a3,a3,-140 # ffffffffc020d1b8 <default_pmm_manager+0xb78>
ffffffffc020524c:	00007617          	auipc	a2,0x7
ffffffffc0205250:	90c60613          	addi	a2,a2,-1780 # ffffffffc020bb58 <commands+0x210>
ffffffffc0205254:	04500593          	li	a1,69
ffffffffc0205258:	00008517          	auipc	a0,0x8
ffffffffc020525c:	34850513          	addi	a0,a0,840 # ffffffffc020d5a0 <CSWTCH.79+0x48>
ffffffffc0205260:	a3efb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205264 <dup_files>:
ffffffffc0205264:	7179                	addi	sp,sp,-48
ffffffffc0205266:	f406                	sd	ra,40(sp)
ffffffffc0205268:	f022                	sd	s0,32(sp)
ffffffffc020526a:	ec26                	sd	s1,24(sp)
ffffffffc020526c:	e84a                	sd	s2,16(sp)
ffffffffc020526e:	e44e                	sd	s3,8(sp)
ffffffffc0205270:	e052                	sd	s4,0(sp)
ffffffffc0205272:	c52d                	beqz	a0,ffffffffc02052dc <dup_files+0x78>
ffffffffc0205274:	842e                	mv	s0,a1
ffffffffc0205276:	c1bd                	beqz	a1,ffffffffc02052dc <dup_files+0x78>
ffffffffc0205278:	491c                	lw	a5,16(a0)
ffffffffc020527a:	84aa                	mv	s1,a0
ffffffffc020527c:	e3c1                	bnez	a5,ffffffffc02052fc <dup_files+0x98>
ffffffffc020527e:	499c                	lw	a5,16(a1)
ffffffffc0205280:	06f05e63          	blez	a5,ffffffffc02052fc <dup_files+0x98>
ffffffffc0205284:	6188                	ld	a0,0(a1)
ffffffffc0205286:	e088                	sd	a0,0(s1)
ffffffffc0205288:	c119                	beqz	a0,ffffffffc020528e <dup_files+0x2a>
ffffffffc020528a:	7ba020ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc020528e:	6400                	ld	s0,8(s0)
ffffffffc0205290:	6905                	lui	s2,0x1
ffffffffc0205292:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205296:	6484                	ld	s1,8(s1)
ffffffffc0205298:	9922                	add	s2,s2,s0
ffffffffc020529a:	4989                	li	s3,2
ffffffffc020529c:	4a05                	li	s4,1
ffffffffc020529e:	a039                	j	ffffffffc02052ac <dup_files+0x48>
ffffffffc02052a0:	03840413          	addi	s0,s0,56
ffffffffc02052a4:	03848493          	addi	s1,s1,56
ffffffffc02052a8:	02890163          	beq	s2,s0,ffffffffc02052ca <dup_files+0x66>
ffffffffc02052ac:	401c                	lw	a5,0(s0)
ffffffffc02052ae:	ff3799e3          	bne	a5,s3,ffffffffc02052a0 <dup_files+0x3c>
ffffffffc02052b2:	0144a023          	sw	s4,0(s1)
ffffffffc02052b6:	85a2                	mv	a1,s0
ffffffffc02052b8:	8526                	mv	a0,s1
ffffffffc02052ba:	03840413          	addi	s0,s0,56
ffffffffc02052be:	e6cff0ef          	jal	ra,ffffffffc020492a <fd_array_dup>
ffffffffc02052c2:	03848493          	addi	s1,s1,56
ffffffffc02052c6:	fe8913e3          	bne	s2,s0,ffffffffc02052ac <dup_files+0x48>
ffffffffc02052ca:	70a2                	ld	ra,40(sp)
ffffffffc02052cc:	7402                	ld	s0,32(sp)
ffffffffc02052ce:	64e2                	ld	s1,24(sp)
ffffffffc02052d0:	6942                	ld	s2,16(sp)
ffffffffc02052d2:	69a2                	ld	s3,8(sp)
ffffffffc02052d4:	6a02                	ld	s4,0(sp)
ffffffffc02052d6:	4501                	li	a0,0
ffffffffc02052d8:	6145                	addi	sp,sp,48
ffffffffc02052da:	8082                	ret
ffffffffc02052dc:	00008697          	auipc	a3,0x8
ffffffffc02052e0:	c2c68693          	addi	a3,a3,-980 # ffffffffc020cf08 <default_pmm_manager+0x8c8>
ffffffffc02052e4:	00007617          	auipc	a2,0x7
ffffffffc02052e8:	87460613          	addi	a2,a2,-1932 # ffffffffc020bb58 <commands+0x210>
ffffffffc02052ec:	05300593          	li	a1,83
ffffffffc02052f0:	00008517          	auipc	a0,0x8
ffffffffc02052f4:	2b050513          	addi	a0,a0,688 # ffffffffc020d5a0 <CSWTCH.79+0x48>
ffffffffc02052f8:	9a6fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02052fc:	00008697          	auipc	a3,0x8
ffffffffc0205300:	2cc68693          	addi	a3,a3,716 # ffffffffc020d5c8 <CSWTCH.79+0x70>
ffffffffc0205304:	00007617          	auipc	a2,0x7
ffffffffc0205308:	85460613          	addi	a2,a2,-1964 # ffffffffc020bb58 <commands+0x210>
ffffffffc020530c:	05400593          	li	a1,84
ffffffffc0205310:	00008517          	auipc	a0,0x8
ffffffffc0205314:	29050513          	addi	a0,a0,656 # ffffffffc020d5a0 <CSWTCH.79+0x48>
ffffffffc0205318:	986fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020531c <iobuf_skip.part.0>:
ffffffffc020531c:	1141                	addi	sp,sp,-16
ffffffffc020531e:	00008697          	auipc	a3,0x8
ffffffffc0205322:	2da68693          	addi	a3,a3,730 # ffffffffc020d5f8 <CSWTCH.79+0xa0>
ffffffffc0205326:	00007617          	auipc	a2,0x7
ffffffffc020532a:	83260613          	addi	a2,a2,-1998 # ffffffffc020bb58 <commands+0x210>
ffffffffc020532e:	04a00593          	li	a1,74
ffffffffc0205332:	00008517          	auipc	a0,0x8
ffffffffc0205336:	2de50513          	addi	a0,a0,734 # ffffffffc020d610 <CSWTCH.79+0xb8>
ffffffffc020533a:	e406                	sd	ra,8(sp)
ffffffffc020533c:	962fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205340 <iobuf_init>:
ffffffffc0205340:	e10c                	sd	a1,0(a0)
ffffffffc0205342:	e514                	sd	a3,8(a0)
ffffffffc0205344:	ed10                	sd	a2,24(a0)
ffffffffc0205346:	e910                	sd	a2,16(a0)
ffffffffc0205348:	8082                	ret

ffffffffc020534a <iobuf_move>:
ffffffffc020534a:	7179                	addi	sp,sp,-48
ffffffffc020534c:	ec26                	sd	s1,24(sp)
ffffffffc020534e:	6d04                	ld	s1,24(a0)
ffffffffc0205350:	f022                	sd	s0,32(sp)
ffffffffc0205352:	e84a                	sd	s2,16(sp)
ffffffffc0205354:	e44e                	sd	s3,8(sp)
ffffffffc0205356:	f406                	sd	ra,40(sp)
ffffffffc0205358:	842a                	mv	s0,a0
ffffffffc020535a:	8932                	mv	s2,a2
ffffffffc020535c:	852e                	mv	a0,a1
ffffffffc020535e:	89ba                	mv	s3,a4
ffffffffc0205360:	00967363          	bgeu	a2,s1,ffffffffc0205366 <iobuf_move+0x1c>
ffffffffc0205364:	84b2                	mv	s1,a2
ffffffffc0205366:	c495                	beqz	s1,ffffffffc0205392 <iobuf_move+0x48>
ffffffffc0205368:	600c                	ld	a1,0(s0)
ffffffffc020536a:	c681                	beqz	a3,ffffffffc0205372 <iobuf_move+0x28>
ffffffffc020536c:	87ae                	mv	a5,a1
ffffffffc020536e:	85aa                	mv	a1,a0
ffffffffc0205370:	853e                	mv	a0,a5
ffffffffc0205372:	8626                	mv	a2,s1
ffffffffc0205374:	314060ef          	jal	ra,ffffffffc020b688 <memmove>
ffffffffc0205378:	6c1c                	ld	a5,24(s0)
ffffffffc020537a:	0297ea63          	bltu	a5,s1,ffffffffc02053ae <iobuf_move+0x64>
ffffffffc020537e:	6014                	ld	a3,0(s0)
ffffffffc0205380:	6418                	ld	a4,8(s0)
ffffffffc0205382:	8f85                	sub	a5,a5,s1
ffffffffc0205384:	96a6                	add	a3,a3,s1
ffffffffc0205386:	9726                	add	a4,a4,s1
ffffffffc0205388:	e014                	sd	a3,0(s0)
ffffffffc020538a:	e418                	sd	a4,8(s0)
ffffffffc020538c:	ec1c                	sd	a5,24(s0)
ffffffffc020538e:	40990933          	sub	s2,s2,s1
ffffffffc0205392:	00098463          	beqz	s3,ffffffffc020539a <iobuf_move+0x50>
ffffffffc0205396:	0099b023          	sd	s1,0(s3)
ffffffffc020539a:	4501                	li	a0,0
ffffffffc020539c:	00091b63          	bnez	s2,ffffffffc02053b2 <iobuf_move+0x68>
ffffffffc02053a0:	70a2                	ld	ra,40(sp)
ffffffffc02053a2:	7402                	ld	s0,32(sp)
ffffffffc02053a4:	64e2                	ld	s1,24(sp)
ffffffffc02053a6:	6942                	ld	s2,16(sp)
ffffffffc02053a8:	69a2                	ld	s3,8(sp)
ffffffffc02053aa:	6145                	addi	sp,sp,48
ffffffffc02053ac:	8082                	ret
ffffffffc02053ae:	f6fff0ef          	jal	ra,ffffffffc020531c <iobuf_skip.part.0>
ffffffffc02053b2:	5571                	li	a0,-4
ffffffffc02053b4:	b7f5                	j	ffffffffc02053a0 <iobuf_move+0x56>

ffffffffc02053b6 <iobuf_skip>:
ffffffffc02053b6:	6d1c                	ld	a5,24(a0)
ffffffffc02053b8:	00b7eb63          	bltu	a5,a1,ffffffffc02053ce <iobuf_skip+0x18>
ffffffffc02053bc:	6114                	ld	a3,0(a0)
ffffffffc02053be:	6518                	ld	a4,8(a0)
ffffffffc02053c0:	8f8d                	sub	a5,a5,a1
ffffffffc02053c2:	96ae                	add	a3,a3,a1
ffffffffc02053c4:	95ba                	add	a1,a1,a4
ffffffffc02053c6:	e114                	sd	a3,0(a0)
ffffffffc02053c8:	e50c                	sd	a1,8(a0)
ffffffffc02053ca:	ed1c                	sd	a5,24(a0)
ffffffffc02053cc:	8082                	ret
ffffffffc02053ce:	1141                	addi	sp,sp,-16
ffffffffc02053d0:	e406                	sd	ra,8(sp)
ffffffffc02053d2:	f4bff0ef          	jal	ra,ffffffffc020531c <iobuf_skip.part.0>

ffffffffc02053d6 <copy_path>:
ffffffffc02053d6:	7139                	addi	sp,sp,-64
ffffffffc02053d8:	f04a                	sd	s2,32(sp)
ffffffffc02053da:	00091917          	auipc	s2,0x91
ffffffffc02053de:	4e690913          	addi	s2,s2,1254 # ffffffffc02968c0 <current>
ffffffffc02053e2:	00093703          	ld	a4,0(s2)
ffffffffc02053e6:	ec4e                	sd	s3,24(sp)
ffffffffc02053e8:	89aa                	mv	s3,a0
ffffffffc02053ea:	6505                	lui	a0,0x1
ffffffffc02053ec:	f426                	sd	s1,40(sp)
ffffffffc02053ee:	e852                	sd	s4,16(sp)
ffffffffc02053f0:	fc06                	sd	ra,56(sp)
ffffffffc02053f2:	f822                	sd	s0,48(sp)
ffffffffc02053f4:	e456                	sd	s5,8(sp)
ffffffffc02053f6:	02873a03          	ld	s4,40(a4)
ffffffffc02053fa:	84ae                	mv	s1,a1
ffffffffc02053fc:	b93fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205400:	c141                	beqz	a0,ffffffffc0205480 <copy_path+0xaa>
ffffffffc0205402:	842a                	mv	s0,a0
ffffffffc0205404:	040a0563          	beqz	s4,ffffffffc020544e <copy_path+0x78>
ffffffffc0205408:	038a0a93          	addi	s5,s4,56
ffffffffc020540c:	8556                	mv	a0,s5
ffffffffc020540e:	8b4ff0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205412:	00093783          	ld	a5,0(s2)
ffffffffc0205416:	cba1                	beqz	a5,ffffffffc0205466 <copy_path+0x90>
ffffffffc0205418:	43dc                	lw	a5,4(a5)
ffffffffc020541a:	6685                	lui	a3,0x1
ffffffffc020541c:	8626                	mv	a2,s1
ffffffffc020541e:	04fa2823          	sw	a5,80(s4)
ffffffffc0205422:	85a2                	mv	a1,s0
ffffffffc0205424:	8552                	mv	a0,s4
ffffffffc0205426:	ec5fe0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc020542a:	c529                	beqz	a0,ffffffffc0205474 <copy_path+0x9e>
ffffffffc020542c:	8556                	mv	a0,s5
ffffffffc020542e:	890ff0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205432:	040a2823          	sw	zero,80(s4)
ffffffffc0205436:	0089b023          	sd	s0,0(s3)
ffffffffc020543a:	4501                	li	a0,0
ffffffffc020543c:	70e2                	ld	ra,56(sp)
ffffffffc020543e:	7442                	ld	s0,48(sp)
ffffffffc0205440:	74a2                	ld	s1,40(sp)
ffffffffc0205442:	7902                	ld	s2,32(sp)
ffffffffc0205444:	69e2                	ld	s3,24(sp)
ffffffffc0205446:	6a42                	ld	s4,16(sp)
ffffffffc0205448:	6aa2                	ld	s5,8(sp)
ffffffffc020544a:	6121                	addi	sp,sp,64
ffffffffc020544c:	8082                	ret
ffffffffc020544e:	85aa                	mv	a1,a0
ffffffffc0205450:	6685                	lui	a3,0x1
ffffffffc0205452:	8626                	mv	a2,s1
ffffffffc0205454:	4501                	li	a0,0
ffffffffc0205456:	e95fe0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc020545a:	fd71                	bnez	a0,ffffffffc0205436 <copy_path+0x60>
ffffffffc020545c:	8522                	mv	a0,s0
ffffffffc020545e:	be1fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205462:	5575                	li	a0,-3
ffffffffc0205464:	bfe1                	j	ffffffffc020543c <copy_path+0x66>
ffffffffc0205466:	6685                	lui	a3,0x1
ffffffffc0205468:	8626                	mv	a2,s1
ffffffffc020546a:	85a2                	mv	a1,s0
ffffffffc020546c:	8552                	mv	a0,s4
ffffffffc020546e:	e7dfe0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc0205472:	fd4d                	bnez	a0,ffffffffc020542c <copy_path+0x56>
ffffffffc0205474:	8556                	mv	a0,s5
ffffffffc0205476:	848ff0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020547a:	040a2823          	sw	zero,80(s4)
ffffffffc020547e:	bff9                	j	ffffffffc020545c <copy_path+0x86>
ffffffffc0205480:	5571                	li	a0,-4
ffffffffc0205482:	bf6d                	j	ffffffffc020543c <copy_path+0x66>

ffffffffc0205484 <sysfile_open>:
ffffffffc0205484:	7179                	addi	sp,sp,-48
ffffffffc0205486:	872a                	mv	a4,a0
ffffffffc0205488:	ec26                	sd	s1,24(sp)
ffffffffc020548a:	0028                	addi	a0,sp,8
ffffffffc020548c:	84ae                	mv	s1,a1
ffffffffc020548e:	85ba                	mv	a1,a4
ffffffffc0205490:	f022                	sd	s0,32(sp)
ffffffffc0205492:	f406                	sd	ra,40(sp)
ffffffffc0205494:	f43ff0ef          	jal	ra,ffffffffc02053d6 <copy_path>
ffffffffc0205498:	842a                	mv	s0,a0
ffffffffc020549a:	e909                	bnez	a0,ffffffffc02054ac <sysfile_open+0x28>
ffffffffc020549c:	6522                	ld	a0,8(sp)
ffffffffc020549e:	85a6                	mv	a1,s1
ffffffffc02054a0:	d60ff0ef          	jal	ra,ffffffffc0204a00 <file_open>
ffffffffc02054a4:	842a                	mv	s0,a0
ffffffffc02054a6:	6522                	ld	a0,8(sp)
ffffffffc02054a8:	b97fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02054ac:	70a2                	ld	ra,40(sp)
ffffffffc02054ae:	8522                	mv	a0,s0
ffffffffc02054b0:	7402                	ld	s0,32(sp)
ffffffffc02054b2:	64e2                	ld	s1,24(sp)
ffffffffc02054b4:	6145                	addi	sp,sp,48
ffffffffc02054b6:	8082                	ret

ffffffffc02054b8 <sysfile_close>:
ffffffffc02054b8:	e46ff06f          	j	ffffffffc0204afe <file_close>

ffffffffc02054bc <sysfile_read>:
ffffffffc02054bc:	7159                	addi	sp,sp,-112
ffffffffc02054be:	f0a2                	sd	s0,96(sp)
ffffffffc02054c0:	f486                	sd	ra,104(sp)
ffffffffc02054c2:	eca6                	sd	s1,88(sp)
ffffffffc02054c4:	e8ca                	sd	s2,80(sp)
ffffffffc02054c6:	e4ce                	sd	s3,72(sp)
ffffffffc02054c8:	e0d2                	sd	s4,64(sp)
ffffffffc02054ca:	fc56                	sd	s5,56(sp)
ffffffffc02054cc:	f85a                	sd	s6,48(sp)
ffffffffc02054ce:	f45e                	sd	s7,40(sp)
ffffffffc02054d0:	f062                	sd	s8,32(sp)
ffffffffc02054d2:	ec66                	sd	s9,24(sp)
ffffffffc02054d4:	4401                	li	s0,0
ffffffffc02054d6:	ee19                	bnez	a2,ffffffffc02054f4 <sysfile_read+0x38>
ffffffffc02054d8:	70a6                	ld	ra,104(sp)
ffffffffc02054da:	8522                	mv	a0,s0
ffffffffc02054dc:	7406                	ld	s0,96(sp)
ffffffffc02054de:	64e6                	ld	s1,88(sp)
ffffffffc02054e0:	6946                	ld	s2,80(sp)
ffffffffc02054e2:	69a6                	ld	s3,72(sp)
ffffffffc02054e4:	6a06                	ld	s4,64(sp)
ffffffffc02054e6:	7ae2                	ld	s5,56(sp)
ffffffffc02054e8:	7b42                	ld	s6,48(sp)
ffffffffc02054ea:	7ba2                	ld	s7,40(sp)
ffffffffc02054ec:	7c02                	ld	s8,32(sp)
ffffffffc02054ee:	6ce2                	ld	s9,24(sp)
ffffffffc02054f0:	6165                	addi	sp,sp,112
ffffffffc02054f2:	8082                	ret
ffffffffc02054f4:	00091c97          	auipc	s9,0x91
ffffffffc02054f8:	3ccc8c93          	addi	s9,s9,972 # ffffffffc02968c0 <current>
ffffffffc02054fc:	000cb783          	ld	a5,0(s9)
ffffffffc0205500:	84b2                	mv	s1,a2
ffffffffc0205502:	8b2e                	mv	s6,a1
ffffffffc0205504:	4601                	li	a2,0
ffffffffc0205506:	4585                	li	a1,1
ffffffffc0205508:	0287b903          	ld	s2,40(a5)
ffffffffc020550c:	8aaa                	mv	s5,a0
ffffffffc020550e:	c9eff0ef          	jal	ra,ffffffffc02049ac <file_testfd>
ffffffffc0205512:	c959                	beqz	a0,ffffffffc02055a8 <sysfile_read+0xec>
ffffffffc0205514:	6505                	lui	a0,0x1
ffffffffc0205516:	a79fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020551a:	89aa                	mv	s3,a0
ffffffffc020551c:	c941                	beqz	a0,ffffffffc02055ac <sysfile_read+0xf0>
ffffffffc020551e:	4b81                	li	s7,0
ffffffffc0205520:	6a05                	lui	s4,0x1
ffffffffc0205522:	03890c13          	addi	s8,s2,56
ffffffffc0205526:	0744ec63          	bltu	s1,s4,ffffffffc020559e <sysfile_read+0xe2>
ffffffffc020552a:	e452                	sd	s4,8(sp)
ffffffffc020552c:	6605                	lui	a2,0x1
ffffffffc020552e:	0034                	addi	a3,sp,8
ffffffffc0205530:	85ce                	mv	a1,s3
ffffffffc0205532:	8556                	mv	a0,s5
ffffffffc0205534:	e20ff0ef          	jal	ra,ffffffffc0204b54 <file_read>
ffffffffc0205538:	66a2                	ld	a3,8(sp)
ffffffffc020553a:	842a                	mv	s0,a0
ffffffffc020553c:	ca9d                	beqz	a3,ffffffffc0205572 <sysfile_read+0xb6>
ffffffffc020553e:	00090c63          	beqz	s2,ffffffffc0205556 <sysfile_read+0x9a>
ffffffffc0205542:	8562                	mv	a0,s8
ffffffffc0205544:	f7ffe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205548:	000cb783          	ld	a5,0(s9)
ffffffffc020554c:	cfa1                	beqz	a5,ffffffffc02055a4 <sysfile_read+0xe8>
ffffffffc020554e:	43dc                	lw	a5,4(a5)
ffffffffc0205550:	66a2                	ld	a3,8(sp)
ffffffffc0205552:	04f92823          	sw	a5,80(s2)
ffffffffc0205556:	864e                	mv	a2,s3
ffffffffc0205558:	85da                	mv	a1,s6
ffffffffc020555a:	854a                	mv	a0,s2
ffffffffc020555c:	d5dfe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc0205560:	c50d                	beqz	a0,ffffffffc020558a <sysfile_read+0xce>
ffffffffc0205562:	67a2                	ld	a5,8(sp)
ffffffffc0205564:	04f4e663          	bltu	s1,a5,ffffffffc02055b0 <sysfile_read+0xf4>
ffffffffc0205568:	9b3e                	add	s6,s6,a5
ffffffffc020556a:	8c9d                	sub	s1,s1,a5
ffffffffc020556c:	9bbe                	add	s7,s7,a5
ffffffffc020556e:	02091263          	bnez	s2,ffffffffc0205592 <sysfile_read+0xd6>
ffffffffc0205572:	e401                	bnez	s0,ffffffffc020557a <sysfile_read+0xbe>
ffffffffc0205574:	67a2                	ld	a5,8(sp)
ffffffffc0205576:	c391                	beqz	a5,ffffffffc020557a <sysfile_read+0xbe>
ffffffffc0205578:	f4dd                	bnez	s1,ffffffffc0205526 <sysfile_read+0x6a>
ffffffffc020557a:	854e                	mv	a0,s3
ffffffffc020557c:	ac3fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205580:	f40b8ce3          	beqz	s7,ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc0205584:	000b841b          	sext.w	s0,s7
ffffffffc0205588:	bf81                	j	ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc020558a:	e011                	bnez	s0,ffffffffc020558e <sysfile_read+0xd2>
ffffffffc020558c:	5475                	li	s0,-3
ffffffffc020558e:	fe0906e3          	beqz	s2,ffffffffc020557a <sysfile_read+0xbe>
ffffffffc0205592:	8562                	mv	a0,s8
ffffffffc0205594:	f2bfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205598:	04092823          	sw	zero,80(s2)
ffffffffc020559c:	bfd9                	j	ffffffffc0205572 <sysfile_read+0xb6>
ffffffffc020559e:	e426                	sd	s1,8(sp)
ffffffffc02055a0:	8626                	mv	a2,s1
ffffffffc02055a2:	b771                	j	ffffffffc020552e <sysfile_read+0x72>
ffffffffc02055a4:	66a2                	ld	a3,8(sp)
ffffffffc02055a6:	bf45                	j	ffffffffc0205556 <sysfile_read+0x9a>
ffffffffc02055a8:	5475                	li	s0,-3
ffffffffc02055aa:	b73d                	j	ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc02055ac:	5471                	li	s0,-4
ffffffffc02055ae:	b72d                	j	ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc02055b0:	00008697          	auipc	a3,0x8
ffffffffc02055b4:	07068693          	addi	a3,a3,112 # ffffffffc020d620 <CSWTCH.79+0xc8>
ffffffffc02055b8:	00006617          	auipc	a2,0x6
ffffffffc02055bc:	5a060613          	addi	a2,a2,1440 # ffffffffc020bb58 <commands+0x210>
ffffffffc02055c0:	05500593          	li	a1,85
ffffffffc02055c4:	00008517          	auipc	a0,0x8
ffffffffc02055c8:	06c50513          	addi	a0,a0,108 # ffffffffc020d630 <CSWTCH.79+0xd8>
ffffffffc02055cc:	ed3fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02055d0 <sysfile_write>:
ffffffffc02055d0:	7159                	addi	sp,sp,-112
ffffffffc02055d2:	e8ca                	sd	s2,80(sp)
ffffffffc02055d4:	f486                	sd	ra,104(sp)
ffffffffc02055d6:	f0a2                	sd	s0,96(sp)
ffffffffc02055d8:	eca6                	sd	s1,88(sp)
ffffffffc02055da:	e4ce                	sd	s3,72(sp)
ffffffffc02055dc:	e0d2                	sd	s4,64(sp)
ffffffffc02055de:	fc56                	sd	s5,56(sp)
ffffffffc02055e0:	f85a                	sd	s6,48(sp)
ffffffffc02055e2:	f45e                	sd	s7,40(sp)
ffffffffc02055e4:	f062                	sd	s8,32(sp)
ffffffffc02055e6:	ec66                	sd	s9,24(sp)
ffffffffc02055e8:	4901                	li	s2,0
ffffffffc02055ea:	ee19                	bnez	a2,ffffffffc0205608 <sysfile_write+0x38>
ffffffffc02055ec:	70a6                	ld	ra,104(sp)
ffffffffc02055ee:	7406                	ld	s0,96(sp)
ffffffffc02055f0:	64e6                	ld	s1,88(sp)
ffffffffc02055f2:	69a6                	ld	s3,72(sp)
ffffffffc02055f4:	6a06                	ld	s4,64(sp)
ffffffffc02055f6:	7ae2                	ld	s5,56(sp)
ffffffffc02055f8:	7b42                	ld	s6,48(sp)
ffffffffc02055fa:	7ba2                	ld	s7,40(sp)
ffffffffc02055fc:	7c02                	ld	s8,32(sp)
ffffffffc02055fe:	6ce2                	ld	s9,24(sp)
ffffffffc0205600:	854a                	mv	a0,s2
ffffffffc0205602:	6946                	ld	s2,80(sp)
ffffffffc0205604:	6165                	addi	sp,sp,112
ffffffffc0205606:	8082                	ret
ffffffffc0205608:	00091c17          	auipc	s8,0x91
ffffffffc020560c:	2b8c0c13          	addi	s8,s8,696 # ffffffffc02968c0 <current>
ffffffffc0205610:	000c3783          	ld	a5,0(s8)
ffffffffc0205614:	8432                	mv	s0,a2
ffffffffc0205616:	89ae                	mv	s3,a1
ffffffffc0205618:	4605                	li	a2,1
ffffffffc020561a:	4581                	li	a1,0
ffffffffc020561c:	7784                	ld	s1,40(a5)
ffffffffc020561e:	8baa                	mv	s7,a0
ffffffffc0205620:	b8cff0ef          	jal	ra,ffffffffc02049ac <file_testfd>
ffffffffc0205624:	cd59                	beqz	a0,ffffffffc02056c2 <sysfile_write+0xf2>
ffffffffc0205626:	6505                	lui	a0,0x1
ffffffffc0205628:	967fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020562c:	8a2a                	mv	s4,a0
ffffffffc020562e:	cd41                	beqz	a0,ffffffffc02056c6 <sysfile_write+0xf6>
ffffffffc0205630:	4c81                	li	s9,0
ffffffffc0205632:	6a85                	lui	s5,0x1
ffffffffc0205634:	03848b13          	addi	s6,s1,56
ffffffffc0205638:	05546a63          	bltu	s0,s5,ffffffffc020568c <sysfile_write+0xbc>
ffffffffc020563c:	e456                	sd	s5,8(sp)
ffffffffc020563e:	c8a9                	beqz	s1,ffffffffc0205690 <sysfile_write+0xc0>
ffffffffc0205640:	855a                	mv	a0,s6
ffffffffc0205642:	e81fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205646:	000c3783          	ld	a5,0(s8)
ffffffffc020564a:	c399                	beqz	a5,ffffffffc0205650 <sysfile_write+0x80>
ffffffffc020564c:	43dc                	lw	a5,4(a5)
ffffffffc020564e:	c8bc                	sw	a5,80(s1)
ffffffffc0205650:	66a2                	ld	a3,8(sp)
ffffffffc0205652:	4701                	li	a4,0
ffffffffc0205654:	864e                	mv	a2,s3
ffffffffc0205656:	85d2                	mv	a1,s4
ffffffffc0205658:	8526                	mv	a0,s1
ffffffffc020565a:	c2bfe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc020565e:	c139                	beqz	a0,ffffffffc02056a4 <sysfile_write+0xd4>
ffffffffc0205660:	855a                	mv	a0,s6
ffffffffc0205662:	e5dfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205666:	0404a823          	sw	zero,80(s1)
ffffffffc020566a:	6622                	ld	a2,8(sp)
ffffffffc020566c:	0034                	addi	a3,sp,8
ffffffffc020566e:	85d2                	mv	a1,s4
ffffffffc0205670:	855e                	mv	a0,s7
ffffffffc0205672:	dc8ff0ef          	jal	ra,ffffffffc0204c3a <file_write>
ffffffffc0205676:	67a2                	ld	a5,8(sp)
ffffffffc0205678:	892a                	mv	s2,a0
ffffffffc020567a:	ef85                	bnez	a5,ffffffffc02056b2 <sysfile_write+0xe2>
ffffffffc020567c:	8552                	mv	a0,s4
ffffffffc020567e:	9c1fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205682:	f60c85e3          	beqz	s9,ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc0205686:	000c891b          	sext.w	s2,s9
ffffffffc020568a:	b78d                	j	ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc020568c:	e422                	sd	s0,8(sp)
ffffffffc020568e:	f8cd                	bnez	s1,ffffffffc0205640 <sysfile_write+0x70>
ffffffffc0205690:	66a2                	ld	a3,8(sp)
ffffffffc0205692:	4701                	li	a4,0
ffffffffc0205694:	864e                	mv	a2,s3
ffffffffc0205696:	85d2                	mv	a1,s4
ffffffffc0205698:	4501                	li	a0,0
ffffffffc020569a:	bebfe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc020569e:	f571                	bnez	a0,ffffffffc020566a <sysfile_write+0x9a>
ffffffffc02056a0:	5975                	li	s2,-3
ffffffffc02056a2:	bfe9                	j	ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056a4:	855a                	mv	a0,s6
ffffffffc02056a6:	e19fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02056aa:	5975                	li	s2,-3
ffffffffc02056ac:	0404a823          	sw	zero,80(s1)
ffffffffc02056b0:	b7f1                	j	ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056b2:	00f46c63          	bltu	s0,a5,ffffffffc02056ca <sysfile_write+0xfa>
ffffffffc02056b6:	99be                	add	s3,s3,a5
ffffffffc02056b8:	8c1d                	sub	s0,s0,a5
ffffffffc02056ba:	9cbe                	add	s9,s9,a5
ffffffffc02056bc:	f161                	bnez	a0,ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056be:	fc2d                	bnez	s0,ffffffffc0205638 <sysfile_write+0x68>
ffffffffc02056c0:	bf75                	j	ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056c2:	5975                	li	s2,-3
ffffffffc02056c4:	b725                	j	ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc02056c6:	5971                	li	s2,-4
ffffffffc02056c8:	b715                	j	ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc02056ca:	00008697          	auipc	a3,0x8
ffffffffc02056ce:	f5668693          	addi	a3,a3,-170 # ffffffffc020d620 <CSWTCH.79+0xc8>
ffffffffc02056d2:	00006617          	auipc	a2,0x6
ffffffffc02056d6:	48660613          	addi	a2,a2,1158 # ffffffffc020bb58 <commands+0x210>
ffffffffc02056da:	08a00593          	li	a1,138
ffffffffc02056de:	00008517          	auipc	a0,0x8
ffffffffc02056e2:	f5250513          	addi	a0,a0,-174 # ffffffffc020d630 <CSWTCH.79+0xd8>
ffffffffc02056e6:	db9fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02056ea <sysfile_seek>:
ffffffffc02056ea:	e36ff06f          	j	ffffffffc0204d20 <file_seek>

ffffffffc02056ee <sysfile_fstat>:
ffffffffc02056ee:	715d                	addi	sp,sp,-80
ffffffffc02056f0:	f44e                	sd	s3,40(sp)
ffffffffc02056f2:	00091997          	auipc	s3,0x91
ffffffffc02056f6:	1ce98993          	addi	s3,s3,462 # ffffffffc02968c0 <current>
ffffffffc02056fa:	0009b703          	ld	a4,0(s3)
ffffffffc02056fe:	fc26                	sd	s1,56(sp)
ffffffffc0205700:	84ae                	mv	s1,a1
ffffffffc0205702:	858a                	mv	a1,sp
ffffffffc0205704:	e0a2                	sd	s0,64(sp)
ffffffffc0205706:	f84a                	sd	s2,48(sp)
ffffffffc0205708:	e486                	sd	ra,72(sp)
ffffffffc020570a:	02873903          	ld	s2,40(a4)
ffffffffc020570e:	f052                	sd	s4,32(sp)
ffffffffc0205710:	f30ff0ef          	jal	ra,ffffffffc0204e40 <file_fstat>
ffffffffc0205714:	842a                	mv	s0,a0
ffffffffc0205716:	e91d                	bnez	a0,ffffffffc020574c <sysfile_fstat+0x5e>
ffffffffc0205718:	04090363          	beqz	s2,ffffffffc020575e <sysfile_fstat+0x70>
ffffffffc020571c:	03890a13          	addi	s4,s2,56
ffffffffc0205720:	8552                	mv	a0,s4
ffffffffc0205722:	da1fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205726:	0009b783          	ld	a5,0(s3)
ffffffffc020572a:	c3b9                	beqz	a5,ffffffffc0205770 <sysfile_fstat+0x82>
ffffffffc020572c:	43dc                	lw	a5,4(a5)
ffffffffc020572e:	02000693          	li	a3,32
ffffffffc0205732:	860a                	mv	a2,sp
ffffffffc0205734:	04f92823          	sw	a5,80(s2)
ffffffffc0205738:	85a6                	mv	a1,s1
ffffffffc020573a:	854a                	mv	a0,s2
ffffffffc020573c:	b7dfe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc0205740:	c121                	beqz	a0,ffffffffc0205780 <sysfile_fstat+0x92>
ffffffffc0205742:	8552                	mv	a0,s4
ffffffffc0205744:	d7bfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205748:	04092823          	sw	zero,80(s2)
ffffffffc020574c:	60a6                	ld	ra,72(sp)
ffffffffc020574e:	8522                	mv	a0,s0
ffffffffc0205750:	6406                	ld	s0,64(sp)
ffffffffc0205752:	74e2                	ld	s1,56(sp)
ffffffffc0205754:	7942                	ld	s2,48(sp)
ffffffffc0205756:	79a2                	ld	s3,40(sp)
ffffffffc0205758:	7a02                	ld	s4,32(sp)
ffffffffc020575a:	6161                	addi	sp,sp,80
ffffffffc020575c:	8082                	ret
ffffffffc020575e:	02000693          	li	a3,32
ffffffffc0205762:	860a                	mv	a2,sp
ffffffffc0205764:	85a6                	mv	a1,s1
ffffffffc0205766:	b53fe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020576a:	f16d                	bnez	a0,ffffffffc020574c <sysfile_fstat+0x5e>
ffffffffc020576c:	5475                	li	s0,-3
ffffffffc020576e:	bff9                	j	ffffffffc020574c <sysfile_fstat+0x5e>
ffffffffc0205770:	02000693          	li	a3,32
ffffffffc0205774:	860a                	mv	a2,sp
ffffffffc0205776:	85a6                	mv	a1,s1
ffffffffc0205778:	854a                	mv	a0,s2
ffffffffc020577a:	b3ffe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020577e:	f171                	bnez	a0,ffffffffc0205742 <sysfile_fstat+0x54>
ffffffffc0205780:	8552                	mv	a0,s4
ffffffffc0205782:	d3dfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205786:	5475                	li	s0,-3
ffffffffc0205788:	04092823          	sw	zero,80(s2)
ffffffffc020578c:	b7c1                	j	ffffffffc020574c <sysfile_fstat+0x5e>

ffffffffc020578e <sysfile_fsync>:
ffffffffc020578e:	f72ff06f          	j	ffffffffc0204f00 <file_fsync>

ffffffffc0205792 <sysfile_getcwd>:
ffffffffc0205792:	715d                	addi	sp,sp,-80
ffffffffc0205794:	f44e                	sd	s3,40(sp)
ffffffffc0205796:	00091997          	auipc	s3,0x91
ffffffffc020579a:	12a98993          	addi	s3,s3,298 # ffffffffc02968c0 <current>
ffffffffc020579e:	0009b783          	ld	a5,0(s3)
ffffffffc02057a2:	f84a                	sd	s2,48(sp)
ffffffffc02057a4:	e486                	sd	ra,72(sp)
ffffffffc02057a6:	e0a2                	sd	s0,64(sp)
ffffffffc02057a8:	fc26                	sd	s1,56(sp)
ffffffffc02057aa:	f052                	sd	s4,32(sp)
ffffffffc02057ac:	0287b903          	ld	s2,40(a5)
ffffffffc02057b0:	cda9                	beqz	a1,ffffffffc020580a <sysfile_getcwd+0x78>
ffffffffc02057b2:	842e                	mv	s0,a1
ffffffffc02057b4:	84aa                	mv	s1,a0
ffffffffc02057b6:	04090363          	beqz	s2,ffffffffc02057fc <sysfile_getcwd+0x6a>
ffffffffc02057ba:	03890a13          	addi	s4,s2,56
ffffffffc02057be:	8552                	mv	a0,s4
ffffffffc02057c0:	d03fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02057c4:	0009b783          	ld	a5,0(s3)
ffffffffc02057c8:	c781                	beqz	a5,ffffffffc02057d0 <sysfile_getcwd+0x3e>
ffffffffc02057ca:	43dc                	lw	a5,4(a5)
ffffffffc02057cc:	04f92823          	sw	a5,80(s2)
ffffffffc02057d0:	4685                	li	a3,1
ffffffffc02057d2:	8622                	mv	a2,s0
ffffffffc02057d4:	85a6                	mv	a1,s1
ffffffffc02057d6:	854a                	mv	a0,s2
ffffffffc02057d8:	a19fe0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc02057dc:	e90d                	bnez	a0,ffffffffc020580e <sysfile_getcwd+0x7c>
ffffffffc02057de:	5475                	li	s0,-3
ffffffffc02057e0:	8552                	mv	a0,s4
ffffffffc02057e2:	cddfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02057e6:	04092823          	sw	zero,80(s2)
ffffffffc02057ea:	60a6                	ld	ra,72(sp)
ffffffffc02057ec:	8522                	mv	a0,s0
ffffffffc02057ee:	6406                	ld	s0,64(sp)
ffffffffc02057f0:	74e2                	ld	s1,56(sp)
ffffffffc02057f2:	7942                	ld	s2,48(sp)
ffffffffc02057f4:	79a2                	ld	s3,40(sp)
ffffffffc02057f6:	7a02                	ld	s4,32(sp)
ffffffffc02057f8:	6161                	addi	sp,sp,80
ffffffffc02057fa:	8082                	ret
ffffffffc02057fc:	862e                	mv	a2,a1
ffffffffc02057fe:	4685                	li	a3,1
ffffffffc0205800:	85aa                	mv	a1,a0
ffffffffc0205802:	4501                	li	a0,0
ffffffffc0205804:	9edfe0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0205808:	ed09                	bnez	a0,ffffffffc0205822 <sysfile_getcwd+0x90>
ffffffffc020580a:	5475                	li	s0,-3
ffffffffc020580c:	bff9                	j	ffffffffc02057ea <sysfile_getcwd+0x58>
ffffffffc020580e:	8622                	mv	a2,s0
ffffffffc0205810:	4681                	li	a3,0
ffffffffc0205812:	85a6                	mv	a1,s1
ffffffffc0205814:	850a                	mv	a0,sp
ffffffffc0205816:	b2bff0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020581a:	5e9020ef          	jal	ra,ffffffffc0208602 <vfs_getcwd>
ffffffffc020581e:	842a                	mv	s0,a0
ffffffffc0205820:	b7c1                	j	ffffffffc02057e0 <sysfile_getcwd+0x4e>
ffffffffc0205822:	8622                	mv	a2,s0
ffffffffc0205824:	4681                	li	a3,0
ffffffffc0205826:	85a6                	mv	a1,s1
ffffffffc0205828:	850a                	mv	a0,sp
ffffffffc020582a:	b17ff0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020582e:	5d5020ef          	jal	ra,ffffffffc0208602 <vfs_getcwd>
ffffffffc0205832:	842a                	mv	s0,a0
ffffffffc0205834:	bf5d                	j	ffffffffc02057ea <sysfile_getcwd+0x58>

ffffffffc0205836 <sysfile_getdirentry>:
ffffffffc0205836:	7139                	addi	sp,sp,-64
ffffffffc0205838:	e852                	sd	s4,16(sp)
ffffffffc020583a:	00091a17          	auipc	s4,0x91
ffffffffc020583e:	086a0a13          	addi	s4,s4,134 # ffffffffc02968c0 <current>
ffffffffc0205842:	000a3703          	ld	a4,0(s4)
ffffffffc0205846:	ec4e                	sd	s3,24(sp)
ffffffffc0205848:	89aa                	mv	s3,a0
ffffffffc020584a:	10800513          	li	a0,264
ffffffffc020584e:	f426                	sd	s1,40(sp)
ffffffffc0205850:	f04a                	sd	s2,32(sp)
ffffffffc0205852:	fc06                	sd	ra,56(sp)
ffffffffc0205854:	f822                	sd	s0,48(sp)
ffffffffc0205856:	e456                	sd	s5,8(sp)
ffffffffc0205858:	7704                	ld	s1,40(a4)
ffffffffc020585a:	892e                	mv	s2,a1
ffffffffc020585c:	f32fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205860:	c169                	beqz	a0,ffffffffc0205922 <sysfile_getdirentry+0xec>
ffffffffc0205862:	842a                	mv	s0,a0
ffffffffc0205864:	c8c1                	beqz	s1,ffffffffc02058f4 <sysfile_getdirentry+0xbe>
ffffffffc0205866:	03848a93          	addi	s5,s1,56
ffffffffc020586a:	8556                	mv	a0,s5
ffffffffc020586c:	c57fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205870:	000a3783          	ld	a5,0(s4)
ffffffffc0205874:	c399                	beqz	a5,ffffffffc020587a <sysfile_getdirentry+0x44>
ffffffffc0205876:	43dc                	lw	a5,4(a5)
ffffffffc0205878:	c8bc                	sw	a5,80(s1)
ffffffffc020587a:	4705                	li	a4,1
ffffffffc020587c:	46a1                	li	a3,8
ffffffffc020587e:	864a                	mv	a2,s2
ffffffffc0205880:	85a2                	mv	a1,s0
ffffffffc0205882:	8526                	mv	a0,s1
ffffffffc0205884:	a01fe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc0205888:	e505                	bnez	a0,ffffffffc02058b0 <sysfile_getdirentry+0x7a>
ffffffffc020588a:	8556                	mv	a0,s5
ffffffffc020588c:	c33fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205890:	59f5                	li	s3,-3
ffffffffc0205892:	0404a823          	sw	zero,80(s1)
ffffffffc0205896:	8522                	mv	a0,s0
ffffffffc0205898:	fa6fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020589c:	70e2                	ld	ra,56(sp)
ffffffffc020589e:	7442                	ld	s0,48(sp)
ffffffffc02058a0:	74a2                	ld	s1,40(sp)
ffffffffc02058a2:	7902                	ld	s2,32(sp)
ffffffffc02058a4:	6a42                	ld	s4,16(sp)
ffffffffc02058a6:	6aa2                	ld	s5,8(sp)
ffffffffc02058a8:	854e                	mv	a0,s3
ffffffffc02058aa:	69e2                	ld	s3,24(sp)
ffffffffc02058ac:	6121                	addi	sp,sp,64
ffffffffc02058ae:	8082                	ret
ffffffffc02058b0:	8556                	mv	a0,s5
ffffffffc02058b2:	c0dfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02058b6:	854e                	mv	a0,s3
ffffffffc02058b8:	85a2                	mv	a1,s0
ffffffffc02058ba:	0404a823          	sw	zero,80(s1)
ffffffffc02058be:	ef0ff0ef          	jal	ra,ffffffffc0204fae <file_getdirentry>
ffffffffc02058c2:	89aa                	mv	s3,a0
ffffffffc02058c4:	f969                	bnez	a0,ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc02058c6:	8556                	mv	a0,s5
ffffffffc02058c8:	bfbfe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02058cc:	000a3783          	ld	a5,0(s4)
ffffffffc02058d0:	c399                	beqz	a5,ffffffffc02058d6 <sysfile_getdirentry+0xa0>
ffffffffc02058d2:	43dc                	lw	a5,4(a5)
ffffffffc02058d4:	c8bc                	sw	a5,80(s1)
ffffffffc02058d6:	10800693          	li	a3,264
ffffffffc02058da:	8622                	mv	a2,s0
ffffffffc02058dc:	85ca                	mv	a1,s2
ffffffffc02058de:	8526                	mv	a0,s1
ffffffffc02058e0:	9d9fe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc02058e4:	e111                	bnez	a0,ffffffffc02058e8 <sysfile_getdirentry+0xb2>
ffffffffc02058e6:	59f5                	li	s3,-3
ffffffffc02058e8:	8556                	mv	a0,s5
ffffffffc02058ea:	bd5fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02058ee:	0404a823          	sw	zero,80(s1)
ffffffffc02058f2:	b755                	j	ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc02058f4:	85aa                	mv	a1,a0
ffffffffc02058f6:	4705                	li	a4,1
ffffffffc02058f8:	46a1                	li	a3,8
ffffffffc02058fa:	864a                	mv	a2,s2
ffffffffc02058fc:	4501                	li	a0,0
ffffffffc02058fe:	987fe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc0205902:	cd11                	beqz	a0,ffffffffc020591e <sysfile_getdirentry+0xe8>
ffffffffc0205904:	854e                	mv	a0,s3
ffffffffc0205906:	85a2                	mv	a1,s0
ffffffffc0205908:	ea6ff0ef          	jal	ra,ffffffffc0204fae <file_getdirentry>
ffffffffc020590c:	89aa                	mv	s3,a0
ffffffffc020590e:	f541                	bnez	a0,ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc0205910:	10800693          	li	a3,264
ffffffffc0205914:	8622                	mv	a2,s0
ffffffffc0205916:	85ca                	mv	a1,s2
ffffffffc0205918:	9a1fe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020591c:	fd2d                	bnez	a0,ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc020591e:	59f5                	li	s3,-3
ffffffffc0205920:	bf9d                	j	ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc0205922:	59f1                	li	s3,-4
ffffffffc0205924:	bfa5                	j	ffffffffc020589c <sysfile_getdirentry+0x66>

ffffffffc0205926 <sysfile_dup>:
ffffffffc0205926:	f6eff06f          	j	ffffffffc0205094 <file_dup>

ffffffffc020592a <kernel_thread_entry>:
ffffffffc020592a:	8526                	mv	a0,s1
ffffffffc020592c:	9402                	jalr	s0
ffffffffc020592e:	792000ef          	jal	ra,ffffffffc02060c0 <do_exit>

ffffffffc0205932 <alloc_proc>:
ffffffffc0205932:	1141                	addi	sp,sp,-16
ffffffffc0205934:	15000513          	li	a0,336
ffffffffc0205938:	e022                	sd	s0,0(sp)
ffffffffc020593a:	e406                	sd	ra,8(sp)
ffffffffc020593c:	e52fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205940:	842a                	mv	s0,a0
ffffffffc0205942:	c141                	beqz	a0,ffffffffc02059c2 <alloc_proc+0x90>
ffffffffc0205944:	57fd                	li	a5,-1
ffffffffc0205946:	1782                	slli	a5,a5,0x20
ffffffffc0205948:	e11c                	sd	a5,0(a0)
ffffffffc020594a:	07000613          	li	a2,112
ffffffffc020594e:	4581                	li	a1,0
ffffffffc0205950:	00052423          	sw	zero,8(a0)
ffffffffc0205954:	00053823          	sd	zero,16(a0)
ffffffffc0205958:	00053c23          	sd	zero,24(a0)
ffffffffc020595c:	02053023          	sd	zero,32(a0)
ffffffffc0205960:	02053423          	sd	zero,40(a0)
ffffffffc0205964:	03050513          	addi	a0,a0,48
ffffffffc0205968:	50f050ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020596c:	00091797          	auipc	a5,0x91
ffffffffc0205970:	f247b783          	ld	a5,-220(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205974:	f45c                	sd	a5,168(s0)
ffffffffc0205976:	0a043023          	sd	zero,160(s0)
ffffffffc020597a:	0a042823          	sw	zero,176(s0)
ffffffffc020597e:	463d                	li	a2,15
ffffffffc0205980:	4581                	li	a1,0
ffffffffc0205982:	0b440513          	addi	a0,s0,180
ffffffffc0205986:	4f1050ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020598a:	11040793          	addi	a5,s0,272
ffffffffc020598e:	0e042623          	sw	zero,236(s0)
ffffffffc0205992:	0e043c23          	sd	zero,248(s0)
ffffffffc0205996:	10043023          	sd	zero,256(s0)
ffffffffc020599a:	0e043823          	sd	zero,240(s0)
ffffffffc020599e:	10043423          	sd	zero,264(s0)
ffffffffc02059a2:	10f43c23          	sd	a5,280(s0)
ffffffffc02059a6:	10f43823          	sd	a5,272(s0)
ffffffffc02059aa:	12042023          	sw	zero,288(s0)
ffffffffc02059ae:	12043423          	sd	zero,296(s0)
ffffffffc02059b2:	12043823          	sd	zero,304(s0)
ffffffffc02059b6:	12043c23          	sd	zero,312(s0)
ffffffffc02059ba:	14043023          	sd	zero,320(s0)
ffffffffc02059be:	14043423          	sd	zero,328(s0)
ffffffffc02059c2:	60a2                	ld	ra,8(sp)
ffffffffc02059c4:	8522                	mv	a0,s0
ffffffffc02059c6:	6402                	ld	s0,0(sp)
ffffffffc02059c8:	0141                	addi	sp,sp,16
ffffffffc02059ca:	8082                	ret

ffffffffc02059cc <forkret>:
ffffffffc02059cc:	00091797          	auipc	a5,0x91
ffffffffc02059d0:	ef47b783          	ld	a5,-268(a5) # ffffffffc02968c0 <current>
ffffffffc02059d4:	73c8                	ld	a0,160(a5)
ffffffffc02059d6:	8d5fb06f          	j	ffffffffc02012aa <forkrets>

ffffffffc02059da <pa2page.part.0>:
ffffffffc02059da:	1141                	addi	sp,sp,-16
ffffffffc02059dc:	00007617          	auipc	a2,0x7
ffffffffc02059e0:	d6c60613          	addi	a2,a2,-660 # ffffffffc020c748 <default_pmm_manager+0x108>
ffffffffc02059e4:	06900593          	li	a1,105
ffffffffc02059e8:	00007517          	auipc	a0,0x7
ffffffffc02059ec:	cb850513          	addi	a0,a0,-840 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc02059f0:	e406                	sd	ra,8(sp)
ffffffffc02059f2:	aadfa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02059f6 <put_pgdir.isra.0>:
ffffffffc02059f6:	1141                	addi	sp,sp,-16
ffffffffc02059f8:	e406                	sd	ra,8(sp)
ffffffffc02059fa:	c02007b7          	lui	a5,0xc0200
ffffffffc02059fe:	02f56e63          	bltu	a0,a5,ffffffffc0205a3a <put_pgdir.isra.0+0x44>
ffffffffc0205a02:	00091697          	auipc	a3,0x91
ffffffffc0205a06:	eb66b683          	ld	a3,-330(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205a0a:	8d15                	sub	a0,a0,a3
ffffffffc0205a0c:	8131                	srli	a0,a0,0xc
ffffffffc0205a0e:	00091797          	auipc	a5,0x91
ffffffffc0205a12:	e927b783          	ld	a5,-366(a5) # ffffffffc02968a0 <npage>
ffffffffc0205a16:	02f57f63          	bgeu	a0,a5,ffffffffc0205a54 <put_pgdir.isra.0+0x5e>
ffffffffc0205a1a:	0000a697          	auipc	a3,0xa
ffffffffc0205a1e:	fae6b683          	ld	a3,-82(a3) # ffffffffc020f9c8 <nbase>
ffffffffc0205a22:	60a2                	ld	ra,8(sp)
ffffffffc0205a24:	8d15                	sub	a0,a0,a3
ffffffffc0205a26:	00091797          	auipc	a5,0x91
ffffffffc0205a2a:	e827b783          	ld	a5,-382(a5) # ffffffffc02968a8 <pages>
ffffffffc0205a2e:	051a                	slli	a0,a0,0x6
ffffffffc0205a30:	4585                	li	a1,1
ffffffffc0205a32:	953e                	add	a0,a0,a5
ffffffffc0205a34:	0141                	addi	sp,sp,16
ffffffffc0205a36:	f74fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc0205a3a:	86aa                	mv	a3,a0
ffffffffc0205a3c:	00007617          	auipc	a2,0x7
ffffffffc0205a40:	ce460613          	addi	a2,a2,-796 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0205a44:	07700593          	li	a1,119
ffffffffc0205a48:	00007517          	auipc	a0,0x7
ffffffffc0205a4c:	c5850513          	addi	a0,a0,-936 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0205a50:	a4ffa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205a54:	f87ff0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>

ffffffffc0205a58 <proc_run>:
ffffffffc0205a58:	7179                	addi	sp,sp,-48
ffffffffc0205a5a:	ec4a                	sd	s2,24(sp)
ffffffffc0205a5c:	00091917          	auipc	s2,0x91
ffffffffc0205a60:	e6490913          	addi	s2,s2,-412 # ffffffffc02968c0 <current>
ffffffffc0205a64:	f026                	sd	s1,32(sp)
ffffffffc0205a66:	00093483          	ld	s1,0(s2)
ffffffffc0205a6a:	f406                	sd	ra,40(sp)
ffffffffc0205a6c:	e84e                	sd	s3,16(sp)
ffffffffc0205a6e:	02a48a63          	beq	s1,a0,ffffffffc0205aa2 <proc_run+0x4a>
ffffffffc0205a72:	100027f3          	csrr	a5,sstatus
ffffffffc0205a76:	8b89                	andi	a5,a5,2
ffffffffc0205a78:	4981                	li	s3,0
ffffffffc0205a7a:	e3a9                	bnez	a5,ffffffffc0205abc <proc_run+0x64>
ffffffffc0205a7c:	755c                	ld	a5,168(a0)
ffffffffc0205a7e:	577d                	li	a4,-1
ffffffffc0205a80:	177e                	slli	a4,a4,0x3f
ffffffffc0205a82:	83b1                	srli	a5,a5,0xc
ffffffffc0205a84:	00a93023          	sd	a0,0(s2)
ffffffffc0205a88:	8fd9                	or	a5,a5,a4
ffffffffc0205a8a:	18079073          	csrw	satp,a5
ffffffffc0205a8e:	12000073          	sfence.vma
ffffffffc0205a92:	03050593          	addi	a1,a0,48
ffffffffc0205a96:	03048513          	addi	a0,s1,48
ffffffffc0205a9a:	033010ef          	jal	ra,ffffffffc02072cc <switch_to>
ffffffffc0205a9e:	00099863          	bnez	s3,ffffffffc0205aae <proc_run+0x56>
ffffffffc0205aa2:	70a2                	ld	ra,40(sp)
ffffffffc0205aa4:	7482                	ld	s1,32(sp)
ffffffffc0205aa6:	6962                	ld	s2,24(sp)
ffffffffc0205aa8:	69c2                	ld	s3,16(sp)
ffffffffc0205aaa:	6145                	addi	sp,sp,48
ffffffffc0205aac:	8082                	ret
ffffffffc0205aae:	70a2                	ld	ra,40(sp)
ffffffffc0205ab0:	7482                	ld	s1,32(sp)
ffffffffc0205ab2:	6962                	ld	s2,24(sp)
ffffffffc0205ab4:	69c2                	ld	s3,16(sp)
ffffffffc0205ab6:	6145                	addi	sp,sp,48
ffffffffc0205ab8:	9b4fb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205abc:	e42a                	sd	a0,8(sp)
ffffffffc0205abe:	9b4fb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205ac2:	6522                	ld	a0,8(sp)
ffffffffc0205ac4:	4985                	li	s3,1
ffffffffc0205ac6:	bf5d                	j	ffffffffc0205a7c <proc_run+0x24>

ffffffffc0205ac8 <do_fork>:
ffffffffc0205ac8:	00091797          	auipc	a5,0x91
ffffffffc0205acc:	e1078793          	addi	a5,a5,-496 # ffffffffc02968d8 <nr_process>
ffffffffc0205ad0:	439c                	lw	a5,0(a5)
ffffffffc0205ad2:	7175                	addi	sp,sp,-144
ffffffffc0205ad4:	e122                	sd	s0,128(sp)
ffffffffc0205ad6:	e506                	sd	ra,136(sp)
ffffffffc0205ad8:	fca6                	sd	s1,120(sp)
ffffffffc0205ada:	f8ca                	sd	s2,112(sp)
ffffffffc0205adc:	f4ce                	sd	s3,104(sp)
ffffffffc0205ade:	f0d2                	sd	s4,96(sp)
ffffffffc0205ae0:	ecd6                	sd	s5,88(sp)
ffffffffc0205ae2:	e8da                	sd	s6,80(sp)
ffffffffc0205ae4:	e4de                	sd	s7,72(sp)
ffffffffc0205ae6:	e0e2                	sd	s8,64(sp)
ffffffffc0205ae8:	fc66                	sd	s9,56(sp)
ffffffffc0205aea:	f86a                	sd	s10,48(sp)
ffffffffc0205aec:	f46e                	sd	s11,40(sp)
ffffffffc0205aee:	6405                	lui	s0,0x1
ffffffffc0205af0:	e82e                	sd	a1,16(sp)
ffffffffc0205af2:	ec32                	sd	a2,24(sp)
ffffffffc0205af4:	4a87dc63          	bge	a5,s0,ffffffffc0205fac <do_fork+0x4e4>
ffffffffc0205af8:	892a                	mv	s2,a0
ffffffffc0205afa:	e39ff0ef          	jal	ra,ffffffffc0205932 <alloc_proc>
ffffffffc0205afe:	8a2a                	mv	s4,a0
ffffffffc0205b00:	3c050d63          	beqz	a0,ffffffffc0205eda <do_fork+0x412>
ffffffffc0205b04:	00091497          	auipc	s1,0x91
ffffffffc0205b08:	dbc48493          	addi	s1,s1,-580 # ffffffffc02968c0 <current>
ffffffffc0205b0c:	609c                	ld	a5,0(s1)
ffffffffc0205b0e:	0ec7a703          	lw	a4,236(a5)
ffffffffc0205b12:	f11c                	sd	a5,32(a0)
ffffffffc0205b14:	50071263          	bnez	a4,ffffffffc0206018 <do_fork+0x550>
ffffffffc0205b18:	4509                	li	a0,2
ffffffffc0205b1a:	e52fc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205b1e:	3a050b63          	beqz	a0,ffffffffc0205ed4 <do_fork+0x40c>
ffffffffc0205b22:	00091b17          	auipc	s6,0x91
ffffffffc0205b26:	d86b0b13          	addi	s6,s6,-634 # ffffffffc02968a8 <pages>
ffffffffc0205b2a:	000b3683          	ld	a3,0(s6)
ffffffffc0205b2e:	0000aa97          	auipc	s5,0xa
ffffffffc0205b32:	e9aaba83          	ld	s5,-358(s5) # ffffffffc020f9c8 <nbase>
ffffffffc0205b36:	00091b97          	auipc	s7,0x91
ffffffffc0205b3a:	d6ab8b93          	addi	s7,s7,-662 # ffffffffc02968a0 <npage>
ffffffffc0205b3e:	40d506b3          	sub	a3,a0,a3
ffffffffc0205b42:	8699                	srai	a3,a3,0x6
ffffffffc0205b44:	96d6                	add	a3,a3,s5
ffffffffc0205b46:	000bb703          	ld	a4,0(s7)
ffffffffc0205b4a:	00c69793          	slli	a5,a3,0xc
ffffffffc0205b4e:	83b1                	srli	a5,a5,0xc
ffffffffc0205b50:	06b2                	slli	a3,a3,0xc
ffffffffc0205b52:	44e7ff63          	bgeu	a5,a4,ffffffffc0205fb0 <do_fork+0x4e8>
ffffffffc0205b56:	6098                	ld	a4,0(s1)
ffffffffc0205b58:	00091797          	auipc	a5,0x91
ffffffffc0205b5c:	d6078793          	addi	a5,a5,-672 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205b60:	639c                	ld	a5,0(a5)
ffffffffc0205b62:	14873983          	ld	s3,328(a4)
ffffffffc0205b66:	96be                	add	a3,a3,a5
ffffffffc0205b68:	00da3823          	sd	a3,16(s4)
ffffffffc0205b6c:	4c098663          	beqz	s3,ffffffffc0206038 <do_fork+0x570>
ffffffffc0205b70:	80040413          	addi	s0,s0,-2048 # 800 <_binary_bin_swap_img_size-0x7500>
ffffffffc0205b74:	00897433          	and	s0,s2,s0
ffffffffc0205b78:	16040a63          	beqz	s0,ffffffffc0205cec <do_fork+0x224>
ffffffffc0205b7c:	0109a783          	lw	a5,16(s3)
ffffffffc0205b80:	02873c03          	ld	s8,40(a4)
ffffffffc0205b84:	10097913          	andi	s2,s2,256
ffffffffc0205b88:	2785                	addiw	a5,a5,1
ffffffffc0205b8a:	00f9a823          	sw	a5,16(s3)
ffffffffc0205b8e:	153a3423          	sd	s3,328(s4)
ffffffffc0205b92:	020c0963          	beqz	s8,ffffffffc0205bc4 <do_fork+0xfc>
ffffffffc0205b96:	16090863          	beqz	s2,ffffffffc0205d06 <do_fork+0x23e>
ffffffffc0205b9a:	030c2783          	lw	a5,48(s8)
ffffffffc0205b9e:	018c3683          	ld	a3,24(s8)
ffffffffc0205ba2:	c0200737          	lui	a4,0xc0200
ffffffffc0205ba6:	2785                	addiw	a5,a5,1
ffffffffc0205ba8:	02fc2823          	sw	a5,48(s8)
ffffffffc0205bac:	038a3423          	sd	s8,40(s4)
ffffffffc0205bb0:	42e6ed63          	bltu	a3,a4,ffffffffc0205fea <do_fork+0x522>
ffffffffc0205bb4:	00091797          	auipc	a5,0x91
ffffffffc0205bb8:	d0478793          	addi	a5,a5,-764 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205bbc:	639c                	ld	a5,0(a5)
ffffffffc0205bbe:	8e9d                	sub	a3,a3,a5
ffffffffc0205bc0:	0ada3423          	sd	a3,168(s4)
ffffffffc0205bc4:	010a3703          	ld	a4,16(s4)
ffffffffc0205bc8:	6662                	ld	a2,24(sp)
ffffffffc0205bca:	6789                	lui	a5,0x2
ffffffffc0205bcc:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205bd0:	973e                	add	a4,a4,a5
ffffffffc0205bd2:	0aea3023          	sd	a4,160(s4)
ffffffffc0205bd6:	87ba                	mv	a5,a4
ffffffffc0205bd8:	12060893          	addi	a7,a2,288
ffffffffc0205bdc:	00063803          	ld	a6,0(a2)
ffffffffc0205be0:	6608                	ld	a0,8(a2)
ffffffffc0205be2:	6a0c                	ld	a1,16(a2)
ffffffffc0205be4:	6e14                	ld	a3,24(a2)
ffffffffc0205be6:	0107b023          	sd	a6,0(a5)
ffffffffc0205bea:	e788                	sd	a0,8(a5)
ffffffffc0205bec:	eb8c                	sd	a1,16(a5)
ffffffffc0205bee:	ef94                	sd	a3,24(a5)
ffffffffc0205bf0:	02060613          	addi	a2,a2,32
ffffffffc0205bf4:	02078793          	addi	a5,a5,32
ffffffffc0205bf8:	ff1612e3          	bne	a2,a7,ffffffffc0205bdc <do_fork+0x114>
ffffffffc0205bfc:	67c2                	ld	a5,16(sp)
ffffffffc0205bfe:	04073823          	sd	zero,80(a4) # ffffffffc0200050 <kern_init+0x6>
ffffffffc0205c02:	e391                	bnez	a5,ffffffffc0205c06 <do_fork+0x13e>
ffffffffc0205c04:	e83a                	sd	a4,16(sp)
ffffffffc0205c06:	67c2                	ld	a5,16(sp)
ffffffffc0205c08:	eb1c                	sd	a5,16(a4)
ffffffffc0205c0a:	00000797          	auipc	a5,0x0
ffffffffc0205c0e:	dc278793          	addi	a5,a5,-574 # ffffffffc02059cc <forkret>
ffffffffc0205c12:	02fa3823          	sd	a5,48(s4)
ffffffffc0205c16:	02ea3c23          	sd	a4,56(s4)
ffffffffc0205c1a:	100027f3          	csrr	a5,sstatus
ffffffffc0205c1e:	8b89                	andi	a5,a5,2
ffffffffc0205c20:	4481                	li	s1,0
ffffffffc0205c22:	32079563          	bnez	a5,ffffffffc0205f4c <do_fork+0x484>
ffffffffc0205c26:	0008b817          	auipc	a6,0x8b
ffffffffc0205c2a:	43280813          	addi	a6,a6,1074 # ffffffffc0291058 <last_pid.1>
ffffffffc0205c2e:	00082783          	lw	a5,0(a6)
ffffffffc0205c32:	6709                	lui	a4,0x2
ffffffffc0205c34:	0017851b          	addiw	a0,a5,1
ffffffffc0205c38:	00a82023          	sw	a0,0(a6)
ffffffffc0205c3c:	2ae55163          	bge	a0,a4,ffffffffc0205ede <do_fork+0x416>
ffffffffc0205c40:	0008b317          	auipc	t1,0x8b
ffffffffc0205c44:	41c30313          	addi	t1,t1,1052 # ffffffffc029105c <next_safe.0>
ffffffffc0205c48:	00032783          	lw	a5,0(t1)
ffffffffc0205c4c:	00090417          	auipc	s0,0x90
ffffffffc0205c50:	b7440413          	addi	s0,s0,-1164 # ffffffffc02957c0 <proc_list>
ffffffffc0205c54:	28f55d63          	bge	a0,a5,ffffffffc0205eee <do_fork+0x426>
ffffffffc0205c58:	00aa2223          	sw	a0,4(s4)
ffffffffc0205c5c:	45a9                	li	a1,10
ffffffffc0205c5e:	2501                	sext.w	a0,a0
ffffffffc0205c60:	4e2050ef          	jal	ra,ffffffffc020b142 <hash32>
ffffffffc0205c64:	02051713          	slli	a4,a0,0x20
ffffffffc0205c68:	01c75793          	srli	a5,a4,0x1c
ffffffffc0205c6c:	0008c717          	auipc	a4,0x8c
ffffffffc0205c70:	b5470713          	addi	a4,a4,-1196 # ffffffffc02917c0 <hash_list>
ffffffffc0205c74:	97ba                	add	a5,a5,a4
ffffffffc0205c76:	6788                	ld	a0,8(a5)
ffffffffc0205c78:	020a3603          	ld	a2,32(s4)
ffffffffc0205c7c:	0d8a0713          	addi	a4,s4,216
ffffffffc0205c80:	e118                	sd	a4,0(a0)
ffffffffc0205c82:	640c                	ld	a1,8(s0)
ffffffffc0205c84:	e798                	sd	a4,8(a5)
ffffffffc0205c86:	7a74                	ld	a3,240(a2)
ffffffffc0205c88:	0c8a0713          	addi	a4,s4,200
ffffffffc0205c8c:	0eaa3023          	sd	a0,224(s4)
ffffffffc0205c90:	0cfa3c23          	sd	a5,216(s4)
ffffffffc0205c94:	e198                	sd	a4,0(a1)
ffffffffc0205c96:	e418                	sd	a4,8(s0)
ffffffffc0205c98:	0cba3823          	sd	a1,208(s4)
ffffffffc0205c9c:	0c8a3423          	sd	s0,200(s4)
ffffffffc0205ca0:	0e0a3c23          	sd	zero,248(s4)
ffffffffc0205ca4:	10da3023          	sd	a3,256(s4)
ffffffffc0205ca8:	c299                	beqz	a3,ffffffffc0205cae <do_fork+0x1e6>
ffffffffc0205caa:	0f46bc23          	sd	s4,248(a3)
ffffffffc0205cae:	00091717          	auipc	a4,0x91
ffffffffc0205cb2:	c2a70713          	addi	a4,a4,-982 # ffffffffc02968d8 <nr_process>
ffffffffc0205cb6:	431c                	lw	a5,0(a4)
ffffffffc0205cb8:	0f463823          	sd	s4,240(a2)
ffffffffc0205cbc:	2785                	addiw	a5,a5,1
ffffffffc0205cbe:	c31c                	sw	a5,0(a4)
ffffffffc0205cc0:	2c049563          	bnez	s1,ffffffffc0205f8a <do_fork+0x4c2>
ffffffffc0205cc4:	8552                	mv	a0,s4
ffffffffc0205cc6:	7aa010ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc0205cca:	004a2503          	lw	a0,4(s4)
ffffffffc0205cce:	60aa                	ld	ra,136(sp)
ffffffffc0205cd0:	640a                	ld	s0,128(sp)
ffffffffc0205cd2:	74e6                	ld	s1,120(sp)
ffffffffc0205cd4:	7946                	ld	s2,112(sp)
ffffffffc0205cd6:	79a6                	ld	s3,104(sp)
ffffffffc0205cd8:	7a06                	ld	s4,96(sp)
ffffffffc0205cda:	6ae6                	ld	s5,88(sp)
ffffffffc0205cdc:	6b46                	ld	s6,80(sp)
ffffffffc0205cde:	6ba6                	ld	s7,72(sp)
ffffffffc0205ce0:	6c06                	ld	s8,64(sp)
ffffffffc0205ce2:	7ce2                	ld	s9,56(sp)
ffffffffc0205ce4:	7d42                	ld	s10,48(sp)
ffffffffc0205ce6:	7da2                	ld	s11,40(sp)
ffffffffc0205ce8:	6149                	addi	sp,sp,144
ffffffffc0205cea:	8082                	ret
ffffffffc0205cec:	c40ff0ef          	jal	ra,ffffffffc020512c <files_create>
ffffffffc0205cf0:	842a                	mv	s0,a0
ffffffffc0205cf2:	1a050763          	beqz	a0,ffffffffc0205ea0 <do_fork+0x3d8>
ffffffffc0205cf6:	85ce                	mv	a1,s3
ffffffffc0205cf8:	d6cff0ef          	jal	ra,ffffffffc0205264 <dup_files>
ffffffffc0205cfc:	28051f63          	bnez	a0,ffffffffc0205f9a <do_fork+0x4d2>
ffffffffc0205d00:	6098                	ld	a4,0(s1)
ffffffffc0205d02:	89a2                	mv	s3,s0
ffffffffc0205d04:	bda5                	j	ffffffffc0205b7c <do_fork+0xb4>
ffffffffc0205d06:	e61fd0ef          	jal	ra,ffffffffc0203b66 <mm_create>
ffffffffc0205d0a:	e02a                	sd	a0,0(sp)
ffffffffc0205d0c:	18050263          	beqz	a0,ffffffffc0205e90 <do_fork+0x3c8>
ffffffffc0205d10:	4505                	li	a0,1
ffffffffc0205d12:	c5afc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205d16:	26050663          	beqz	a0,ffffffffc0205f82 <do_fork+0x4ba>
ffffffffc0205d1a:	000b3783          	ld	a5,0(s6)
ffffffffc0205d1e:	000bb603          	ld	a2,0(s7)
ffffffffc0205d22:	40f507b3          	sub	a5,a0,a5
ffffffffc0205d26:	8799                	srai	a5,a5,0x6
ffffffffc0205d28:	97d6                	add	a5,a5,s5
ffffffffc0205d2a:	00c79713          	slli	a4,a5,0xc
ffffffffc0205d2e:	8331                	srli	a4,a4,0xc
ffffffffc0205d30:	00c79693          	slli	a3,a5,0xc
ffffffffc0205d34:	26c77e63          	bgeu	a4,a2,ffffffffc0205fb0 <do_fork+0x4e8>
ffffffffc0205d38:	00091797          	auipc	a5,0x91
ffffffffc0205d3c:	b8078793          	addi	a5,a5,-1152 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205d40:	6380                	ld	s0,0(a5)
ffffffffc0205d42:	6605                	lui	a2,0x1
ffffffffc0205d44:	00091597          	auipc	a1,0x91
ffffffffc0205d48:	b545b583          	ld	a1,-1196(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205d4c:	9436                	add	s0,s0,a3
ffffffffc0205d4e:	8522                	mv	a0,s0
ffffffffc0205d50:	179050ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0205d54:	6782                	ld	a5,0(sp)
ffffffffc0205d56:	038c0913          	addi	s2,s8,56
ffffffffc0205d5a:	854a                	mv	a0,s2
ffffffffc0205d5c:	ef80                	sd	s0,24(a5)
ffffffffc0205d5e:	f64fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205d62:	609c                	ld	a5,0(s1)
ffffffffc0205d64:	c781                	beqz	a5,ffffffffc0205d6c <do_fork+0x2a4>
ffffffffc0205d66:	43dc                	lw	a5,4(a5)
ffffffffc0205d68:	04fc2823          	sw	a5,80(s8)
ffffffffc0205d6c:	6502                	ld	a0,0(sp)
ffffffffc0205d6e:	85e2                	mv	a1,s8
ffffffffc0205d70:	846fe0ef          	jal	ra,ffffffffc0203db6 <dup_mmap>
ffffffffc0205d74:	842a                	mv	s0,a0
ffffffffc0205d76:	854a                	mv	a0,s2
ffffffffc0205d78:	f46fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205d7c:	040c2823          	sw	zero,80(s8)
ffffffffc0205d80:	28041163          	bnez	s0,ffffffffc0206002 <do_fork+0x53a>
ffffffffc0205d84:	6602                	ld	a2,0(sp)
ffffffffc0205d86:	c0200737          	lui	a4,0xc0200
ffffffffc0205d8a:	5a1c                	lw	a5,48(a2)
ffffffffc0205d8c:	6e14                	ld	a3,24(a2)
ffffffffc0205d8e:	2785                	addiw	a5,a5,1
ffffffffc0205d90:	da1c                	sw	a5,48(a2)
ffffffffc0205d92:	02ca3423          	sd	a2,40(s4)
ffffffffc0205d96:	24e6ea63          	bltu	a3,a4,ffffffffc0205fea <do_fork+0x522>
ffffffffc0205d9a:	6098                	ld	a4,0(s1)
ffffffffc0205d9c:	00091797          	auipc	a5,0x91
ffffffffc0205da0:	b1c78793          	addi	a5,a5,-1252 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205da4:	639c                	ld	a5,0(a5)
ffffffffc0205da6:	02873903          	ld	s2,40(a4) # ffffffffc0200028 <kern_entry+0x28>
ffffffffc0205daa:	8e9d                	sub	a3,a3,a5
ffffffffc0205dac:	0ada3423          	sd	a3,168(s4)
ffffffffc0205db0:	e0090ae3          	beqz	s2,ffffffffc0205bc4 <do_fork+0xfc>
ffffffffc0205db4:	6782                	ld	a5,0(sp)
ffffffffc0205db6:	6798                	ld	a4,8(a5)
ffffffffc0205db8:	e43a                	sd	a4,8(sp)
ffffffffc0205dba:	e0e785e3          	beq	a5,a4,ffffffffc0205bc4 <do_fork+0xfc>
ffffffffc0205dbe:	5c7d                	li	s8,-1
ffffffffc0205dc0:	00cc5c13          	srli	s8,s8,0xc
ffffffffc0205dc4:	6985                	lui	s3,0x1
ffffffffc0205dc6:	67a2                	ld	a5,8(sp)
ffffffffc0205dc8:	fe87bc83          	ld	s9,-24(a5)
ffffffffc0205dcc:	ff07b483          	ld	s1,-16(a5)
ffffffffc0205dd0:	009ce663          	bltu	s9,s1,ffffffffc0205ddc <do_fork+0x314>
ffffffffc0205dd4:	a245                	j	ffffffffc0205f74 <do_fork+0x4ac>
ffffffffc0205dd6:	9cce                	add	s9,s9,s3
ffffffffc0205dd8:	189cfe63          	bgeu	s9,s1,ffffffffc0205f74 <do_fork+0x4ac>
ffffffffc0205ddc:	01893503          	ld	a0,24(s2)
ffffffffc0205de0:	4601                	li	a2,0
ffffffffc0205de2:	85e6                	mv	a1,s9
ffffffffc0205de4:	c40fc0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0205de8:	8d2a                	mv	s10,a0
ffffffffc0205dea:	d575                	beqz	a0,ffffffffc0205dd6 <do_fork+0x30e>
ffffffffc0205dec:	6114                	ld	a3,0(a0)
ffffffffc0205dee:	0016f613          	andi	a2,a3,1
ffffffffc0205df2:	d275                	beqz	a2,ffffffffc0205dd6 <do_fork+0x30e>
ffffffffc0205df4:	000bb603          	ld	a2,0(s7)
ffffffffc0205df8:	068a                	slli	a3,a3,0x2
ffffffffc0205dfa:	82b1                	srli	a3,a3,0xc
ffffffffc0205dfc:	1cc6f963          	bgeu	a3,a2,ffffffffc0205fce <do_fork+0x506>
ffffffffc0205e00:	000b3403          	ld	s0,0(s6)
ffffffffc0205e04:	415686b3          	sub	a3,a3,s5
ffffffffc0205e08:	069a                	slli	a3,a3,0x6
ffffffffc0205e0a:	4505                	li	a0,1
ffffffffc0205e0c:	9436                	add	s0,s0,a3
ffffffffc0205e0e:	b5efc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205e12:	8daa                	mv	s11,a0
ffffffffc0205e14:	c12d                	beqz	a0,ffffffffc0205e76 <do_fork+0x3ae>
ffffffffc0205e16:	000b3603          	ld	a2,0(s6)
ffffffffc0205e1a:	000bb883          	ld	a7,0(s7)
ffffffffc0205e1e:	40c406b3          	sub	a3,s0,a2
ffffffffc0205e22:	8699                	srai	a3,a3,0x6
ffffffffc0205e24:	96d6                	add	a3,a3,s5
ffffffffc0205e26:	0186f5b3          	and	a1,a3,s8
ffffffffc0205e2a:	06b2                	slli	a3,a3,0xc
ffffffffc0205e2c:	1915f263          	bgeu	a1,a7,ffffffffc0205fb0 <do_fork+0x4e8>
ffffffffc0205e30:	40c50633          	sub	a2,a0,a2
ffffffffc0205e34:	00091797          	auipc	a5,0x91
ffffffffc0205e38:	a8478793          	addi	a5,a5,-1404 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205e3c:	6388                	ld	a0,0(a5)
ffffffffc0205e3e:	8619                	srai	a2,a2,0x6
ffffffffc0205e40:	9656                	add	a2,a2,s5
ffffffffc0205e42:	01867333          	and	t1,a2,s8
ffffffffc0205e46:	00a685b3          	add	a1,a3,a0
ffffffffc0205e4a:	00c61693          	slli	a3,a2,0xc
ffffffffc0205e4e:	17137163          	bgeu	t1,a7,ffffffffc0205fb0 <do_fork+0x4e8>
ffffffffc0205e52:	6605                	lui	a2,0x1
ffffffffc0205e54:	9536                	add	a0,a0,a3
ffffffffc0205e56:	073050ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0205e5a:	6782                	ld	a5,0(sp)
ffffffffc0205e5c:	000d3683          	ld	a3,0(s10) # 200000 <_binary_bin_sfs_img_size+0x18ad00>
ffffffffc0205e60:	8666                	mv	a2,s9
ffffffffc0205e62:	6f88                	ld	a0,24(a5)
ffffffffc0205e64:	8afd                	andi	a3,a3,31
ffffffffc0205e66:	85ee                	mv	a1,s11
ffffffffc0205e68:	d31fc0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0205e6c:	d52d                	beqz	a0,ffffffffc0205dd6 <do_fork+0x30e>
ffffffffc0205e6e:	4585                	li	a1,1
ffffffffc0205e70:	856e                	mv	a0,s11
ffffffffc0205e72:	b38fc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205e76:	028a3503          	ld	a0,40(s4)
ffffffffc0205e7a:	fd7fd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc0205e7e:	028a3783          	ld	a5,40(s4)
ffffffffc0205e82:	6f88                	ld	a0,24(a5)
ffffffffc0205e84:	b73ff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0205e88:	028a3503          	ld	a0,40(s4)
ffffffffc0205e8c:	e29fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0205e90:	148a3503          	ld	a0,328(s4)
ffffffffc0205e94:	c511                	beqz	a0,ffffffffc0205ea0 <do_fork+0x3d8>
ffffffffc0205e96:	491c                	lw	a5,16(a0)
ffffffffc0205e98:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205e9c:	c918                	sw	a4,16(a0)
ffffffffc0205e9e:	cb61                	beqz	a4,ffffffffc0205f6e <do_fork+0x4a6>
ffffffffc0205ea0:	010a3683          	ld	a3,16(s4)
ffffffffc0205ea4:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ea8:	1af6e863          	bltu	a3,a5,ffffffffc0206058 <do_fork+0x590>
ffffffffc0205eac:	00091797          	auipc	a5,0x91
ffffffffc0205eb0:	a0c78793          	addi	a5,a5,-1524 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205eb4:	6398                	ld	a4,0(a5)
ffffffffc0205eb6:	000bb783          	ld	a5,0(s7)
ffffffffc0205eba:	8e99                	sub	a3,a3,a4
ffffffffc0205ebc:	82b1                	srli	a3,a3,0xc
ffffffffc0205ebe:	12f6f463          	bgeu	a3,a5,ffffffffc0205fe6 <do_fork+0x51e>
ffffffffc0205ec2:	000b3503          	ld	a0,0(s6)
ffffffffc0205ec6:	415686b3          	sub	a3,a3,s5
ffffffffc0205eca:	069a                	slli	a3,a3,0x6
ffffffffc0205ecc:	4589                	li	a1,2
ffffffffc0205ece:	9536                	add	a0,a0,a3
ffffffffc0205ed0:	adafc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205ed4:	8552                	mv	a0,s4
ffffffffc0205ed6:	968fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205eda:	5571                	li	a0,-4
ffffffffc0205edc:	bbcd                	j	ffffffffc0205cce <do_fork+0x206>
ffffffffc0205ede:	4785                	li	a5,1
ffffffffc0205ee0:	00f82023          	sw	a5,0(a6)
ffffffffc0205ee4:	4505                	li	a0,1
ffffffffc0205ee6:	0008b317          	auipc	t1,0x8b
ffffffffc0205eea:	17630313          	addi	t1,t1,374 # ffffffffc029105c <next_safe.0>
ffffffffc0205eee:	00090417          	auipc	s0,0x90
ffffffffc0205ef2:	8d240413          	addi	s0,s0,-1838 # ffffffffc02957c0 <proc_list>
ffffffffc0205ef6:	00843e03          	ld	t3,8(s0)
ffffffffc0205efa:	6789                	lui	a5,0x2
ffffffffc0205efc:	00f32023          	sw	a5,0(t1)
ffffffffc0205f00:	86aa                	mv	a3,a0
ffffffffc0205f02:	4581                	li	a1,0
ffffffffc0205f04:	6e89                	lui	t4,0x2
ffffffffc0205f06:	088e0e63          	beq	t3,s0,ffffffffc0205fa2 <do_fork+0x4da>
ffffffffc0205f0a:	88ae                	mv	a7,a1
ffffffffc0205f0c:	87f2                	mv	a5,t3
ffffffffc0205f0e:	6609                	lui	a2,0x2
ffffffffc0205f10:	a811                	j	ffffffffc0205f24 <do_fork+0x45c>
ffffffffc0205f12:	00e6d663          	bge	a3,a4,ffffffffc0205f1e <do_fork+0x456>
ffffffffc0205f16:	00c75463          	bge	a4,a2,ffffffffc0205f1e <do_fork+0x456>
ffffffffc0205f1a:	863a                	mv	a2,a4
ffffffffc0205f1c:	4885                	li	a7,1
ffffffffc0205f1e:	679c                	ld	a5,8(a5)
ffffffffc0205f20:	00878d63          	beq	a5,s0,ffffffffc0205f3a <do_fork+0x472>
ffffffffc0205f24:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205f28:	fee695e3          	bne	a3,a4,ffffffffc0205f12 <do_fork+0x44a>
ffffffffc0205f2c:	2685                	addiw	a3,a3,1
ffffffffc0205f2e:	06c6d163          	bge	a3,a2,ffffffffc0205f90 <do_fork+0x4c8>
ffffffffc0205f32:	679c                	ld	a5,8(a5)
ffffffffc0205f34:	4585                	li	a1,1
ffffffffc0205f36:	fe8797e3          	bne	a5,s0,ffffffffc0205f24 <do_fork+0x45c>
ffffffffc0205f3a:	c581                	beqz	a1,ffffffffc0205f42 <do_fork+0x47a>
ffffffffc0205f3c:	00d82023          	sw	a3,0(a6)
ffffffffc0205f40:	8536                	mv	a0,a3
ffffffffc0205f42:	d0088be3          	beqz	a7,ffffffffc0205c58 <do_fork+0x190>
ffffffffc0205f46:	00c32023          	sw	a2,0(t1)
ffffffffc0205f4a:	b339                	j	ffffffffc0205c58 <do_fork+0x190>
ffffffffc0205f4c:	d27fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205f50:	0008b817          	auipc	a6,0x8b
ffffffffc0205f54:	10880813          	addi	a6,a6,264 # ffffffffc0291058 <last_pid.1>
ffffffffc0205f58:	00082783          	lw	a5,0(a6)
ffffffffc0205f5c:	6709                	lui	a4,0x2
ffffffffc0205f5e:	4485                	li	s1,1
ffffffffc0205f60:	0017851b          	addiw	a0,a5,1
ffffffffc0205f64:	00a82023          	sw	a0,0(a6)
ffffffffc0205f68:	cce54ce3          	blt	a0,a4,ffffffffc0205c40 <do_fork+0x178>
ffffffffc0205f6c:	bf8d                	j	ffffffffc0205ede <do_fork+0x416>
ffffffffc0205f6e:	9f4ff0ef          	jal	ra,ffffffffc0205162 <files_destroy>
ffffffffc0205f72:	b73d                	j	ffffffffc0205ea0 <do_fork+0x3d8>
ffffffffc0205f74:	67a2                	ld	a5,8(sp)
ffffffffc0205f76:	6702                	ld	a4,0(sp)
ffffffffc0205f78:	679c                	ld	a5,8(a5)
ffffffffc0205f7a:	e43e                	sd	a5,8(sp)
ffffffffc0205f7c:	e4f715e3          	bne	a4,a5,ffffffffc0205dc6 <do_fork+0x2fe>
ffffffffc0205f80:	b191                	j	ffffffffc0205bc4 <do_fork+0xfc>
ffffffffc0205f82:	6502                	ld	a0,0(sp)
ffffffffc0205f84:	d31fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0205f88:	b721                	j	ffffffffc0205e90 <do_fork+0x3c8>
ffffffffc0205f8a:	ce3fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205f8e:	bb1d                	j	ffffffffc0205cc4 <do_fork+0x1fc>
ffffffffc0205f90:	01d6c363          	blt	a3,t4,ffffffffc0205f96 <do_fork+0x4ce>
ffffffffc0205f94:	4685                	li	a3,1
ffffffffc0205f96:	4585                	li	a1,1
ffffffffc0205f98:	b7bd                	j	ffffffffc0205f06 <do_fork+0x43e>
ffffffffc0205f9a:	8522                	mv	a0,s0
ffffffffc0205f9c:	9c6ff0ef          	jal	ra,ffffffffc0205162 <files_destroy>
ffffffffc0205fa0:	b701                	j	ffffffffc0205ea0 <do_fork+0x3d8>
ffffffffc0205fa2:	c19d                	beqz	a1,ffffffffc0205fc8 <do_fork+0x500>
ffffffffc0205fa4:	00d82023          	sw	a3,0(a6)
ffffffffc0205fa8:	8536                	mv	a0,a3
ffffffffc0205faa:	b17d                	j	ffffffffc0205c58 <do_fork+0x190>
ffffffffc0205fac:	556d                	li	a0,-5
ffffffffc0205fae:	b305                	j	ffffffffc0205cce <do_fork+0x206>
ffffffffc0205fb0:	00006617          	auipc	a2,0x6
ffffffffc0205fb4:	6c860613          	addi	a2,a2,1736 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0205fb8:	07100593          	li	a1,113
ffffffffc0205fbc:	00006517          	auipc	a0,0x6
ffffffffc0205fc0:	6e450513          	addi	a0,a0,1764 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0205fc4:	cdafa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fc8:	00082503          	lw	a0,0(a6)
ffffffffc0205fcc:	b171                	j	ffffffffc0205c58 <do_fork+0x190>
ffffffffc0205fce:	00006617          	auipc	a2,0x6
ffffffffc0205fd2:	77a60613          	addi	a2,a2,1914 # ffffffffc020c748 <default_pmm_manager+0x108>
ffffffffc0205fd6:	06900593          	li	a1,105
ffffffffc0205fda:	00006517          	auipc	a0,0x6
ffffffffc0205fde:	6c650513          	addi	a0,a0,1734 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0205fe2:	cbcfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fe6:	9f5ff0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>
ffffffffc0205fea:	00006617          	auipc	a2,0x6
ffffffffc0205fee:	73660613          	addi	a2,a2,1846 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0205ff2:	19b00593          	li	a1,411
ffffffffc0205ff6:	00007517          	auipc	a0,0x7
ffffffffc0205ffa:	67250513          	addi	a0,a0,1650 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0205ffe:	ca0fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206002:	6402                	ld	s0,0(sp)
ffffffffc0206004:	8522                	mv	a0,s0
ffffffffc0206006:	e4bfd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc020600a:	6c08                	ld	a0,24(s0)
ffffffffc020600c:	9ebff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0206010:	8522                	mv	a0,s0
ffffffffc0206012:	ca3fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0206016:	bdad                	j	ffffffffc0205e90 <do_fork+0x3c8>
ffffffffc0206018:	00007697          	auipc	a3,0x7
ffffffffc020601c:	63068693          	addi	a3,a3,1584 # ffffffffc020d648 <CSWTCH.79+0xf0>
ffffffffc0206020:	00006617          	auipc	a2,0x6
ffffffffc0206024:	b3860613          	addi	a2,a2,-1224 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206028:	21c00593          	li	a1,540
ffffffffc020602c:	00007517          	auipc	a0,0x7
ffffffffc0206030:	63c50513          	addi	a0,a0,1596 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206034:	c6afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206038:	00007697          	auipc	a3,0x7
ffffffffc020603c:	64868693          	addi	a3,a3,1608 # ffffffffc020d680 <CSWTCH.79+0x128>
ffffffffc0206040:	00006617          	auipc	a2,0x6
ffffffffc0206044:	b1860613          	addi	a2,a2,-1256 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206048:	1bb00593          	li	a1,443
ffffffffc020604c:	00007517          	auipc	a0,0x7
ffffffffc0206050:	61c50513          	addi	a0,a0,1564 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206054:	c4afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206058:	00006617          	auipc	a2,0x6
ffffffffc020605c:	6c860613          	addi	a2,a2,1736 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0206060:	07700593          	li	a1,119
ffffffffc0206064:	00006517          	auipc	a0,0x6
ffffffffc0206068:	63c50513          	addi	a0,a0,1596 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc020606c:	c32fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206070 <kernel_thread>:
ffffffffc0206070:	7129                	addi	sp,sp,-320
ffffffffc0206072:	fa22                	sd	s0,304(sp)
ffffffffc0206074:	f626                	sd	s1,296(sp)
ffffffffc0206076:	f24a                	sd	s2,288(sp)
ffffffffc0206078:	84ae                	mv	s1,a1
ffffffffc020607a:	892a                	mv	s2,a0
ffffffffc020607c:	8432                	mv	s0,a2
ffffffffc020607e:	4581                	li	a1,0
ffffffffc0206080:	12000613          	li	a2,288
ffffffffc0206084:	850a                	mv	a0,sp
ffffffffc0206086:	fe06                	sd	ra,312(sp)
ffffffffc0206088:	5ee050ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020608c:	e0ca                	sd	s2,64(sp)
ffffffffc020608e:	e4a6                	sd	s1,72(sp)
ffffffffc0206090:	100027f3          	csrr	a5,sstatus
ffffffffc0206094:	edd7f793          	andi	a5,a5,-291
ffffffffc0206098:	1207e793          	ori	a5,a5,288
ffffffffc020609c:	e23e                	sd	a5,256(sp)
ffffffffc020609e:	860a                	mv	a2,sp
ffffffffc02060a0:	10046513          	ori	a0,s0,256
ffffffffc02060a4:	00000797          	auipc	a5,0x0
ffffffffc02060a8:	88678793          	addi	a5,a5,-1914 # ffffffffc020592a <kernel_thread_entry>
ffffffffc02060ac:	4581                	li	a1,0
ffffffffc02060ae:	e63e                	sd	a5,264(sp)
ffffffffc02060b0:	a19ff0ef          	jal	ra,ffffffffc0205ac8 <do_fork>
ffffffffc02060b4:	70f2                	ld	ra,312(sp)
ffffffffc02060b6:	7452                	ld	s0,304(sp)
ffffffffc02060b8:	74b2                	ld	s1,296(sp)
ffffffffc02060ba:	7912                	ld	s2,288(sp)
ffffffffc02060bc:	6131                	addi	sp,sp,320
ffffffffc02060be:	8082                	ret

ffffffffc02060c0 <do_exit>:
ffffffffc02060c0:	7179                	addi	sp,sp,-48
ffffffffc02060c2:	f022                	sd	s0,32(sp)
ffffffffc02060c4:	00090417          	auipc	s0,0x90
ffffffffc02060c8:	7fc40413          	addi	s0,s0,2044 # ffffffffc02968c0 <current>
ffffffffc02060cc:	601c                	ld	a5,0(s0)
ffffffffc02060ce:	f406                	sd	ra,40(sp)
ffffffffc02060d0:	ec26                	sd	s1,24(sp)
ffffffffc02060d2:	e84a                	sd	s2,16(sp)
ffffffffc02060d4:	e44e                	sd	s3,8(sp)
ffffffffc02060d6:	e052                	sd	s4,0(sp)
ffffffffc02060d8:	00090717          	auipc	a4,0x90
ffffffffc02060dc:	7f073703          	ld	a4,2032(a4) # ffffffffc02968c8 <idleproc>
ffffffffc02060e0:	0ee78763          	beq	a5,a4,ffffffffc02061ce <do_exit+0x10e>
ffffffffc02060e4:	00090497          	auipc	s1,0x90
ffffffffc02060e8:	7ec48493          	addi	s1,s1,2028 # ffffffffc02968d0 <initproc>
ffffffffc02060ec:	6098                	ld	a4,0(s1)
ffffffffc02060ee:	10e78763          	beq	a5,a4,ffffffffc02061fc <do_exit+0x13c>
ffffffffc02060f2:	0287b983          	ld	s3,40(a5)
ffffffffc02060f6:	892a                	mv	s2,a0
ffffffffc02060f8:	02098e63          	beqz	s3,ffffffffc0206134 <do_exit+0x74>
ffffffffc02060fc:	00090797          	auipc	a5,0x90
ffffffffc0206100:	7947b783          	ld	a5,1940(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206104:	577d                	li	a4,-1
ffffffffc0206106:	177e                	slli	a4,a4,0x3f
ffffffffc0206108:	83b1                	srli	a5,a5,0xc
ffffffffc020610a:	8fd9                	or	a5,a5,a4
ffffffffc020610c:	18079073          	csrw	satp,a5
ffffffffc0206110:	0309a783          	lw	a5,48(s3) # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0206114:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206118:	02e9a823          	sw	a4,48(s3)
ffffffffc020611c:	c769                	beqz	a4,ffffffffc02061e6 <do_exit+0x126>
ffffffffc020611e:	601c                	ld	a5,0(s0)
ffffffffc0206120:	1487b503          	ld	a0,328(a5)
ffffffffc0206124:	0207b423          	sd	zero,40(a5)
ffffffffc0206128:	c511                	beqz	a0,ffffffffc0206134 <do_exit+0x74>
ffffffffc020612a:	491c                	lw	a5,16(a0)
ffffffffc020612c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206130:	c918                	sw	a4,16(a0)
ffffffffc0206132:	cb59                	beqz	a4,ffffffffc02061c8 <do_exit+0x108>
ffffffffc0206134:	601c                	ld	a5,0(s0)
ffffffffc0206136:	470d                	li	a4,3
ffffffffc0206138:	c398                	sw	a4,0(a5)
ffffffffc020613a:	0f27a423          	sw	s2,232(a5)
ffffffffc020613e:	100027f3          	csrr	a5,sstatus
ffffffffc0206142:	8b89                	andi	a5,a5,2
ffffffffc0206144:	4a01                	li	s4,0
ffffffffc0206146:	e7f9                	bnez	a5,ffffffffc0206214 <do_exit+0x154>
ffffffffc0206148:	6018                	ld	a4,0(s0)
ffffffffc020614a:	800007b7          	lui	a5,0x80000
ffffffffc020614e:	0785                	addi	a5,a5,1
ffffffffc0206150:	7308                	ld	a0,32(a4)
ffffffffc0206152:	0ec52703          	lw	a4,236(a0)
ffffffffc0206156:	0cf70363          	beq	a4,a5,ffffffffc020621c <do_exit+0x15c>
ffffffffc020615a:	6018                	ld	a4,0(s0)
ffffffffc020615c:	7b7c                	ld	a5,240(a4)
ffffffffc020615e:	c3a1                	beqz	a5,ffffffffc020619e <do_exit+0xde>
ffffffffc0206160:	800009b7          	lui	s3,0x80000
ffffffffc0206164:	490d                	li	s2,3
ffffffffc0206166:	0985                	addi	s3,s3,1
ffffffffc0206168:	a021                	j	ffffffffc0206170 <do_exit+0xb0>
ffffffffc020616a:	6018                	ld	a4,0(s0)
ffffffffc020616c:	7b7c                	ld	a5,240(a4)
ffffffffc020616e:	cb85                	beqz	a5,ffffffffc020619e <do_exit+0xde>
ffffffffc0206170:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc0206174:	6088                	ld	a0,0(s1)
ffffffffc0206176:	fb74                	sd	a3,240(a4)
ffffffffc0206178:	7978                	ld	a4,240(a0)
ffffffffc020617a:	0e07bc23          	sd	zero,248(a5)
ffffffffc020617e:	10e7b023          	sd	a4,256(a5)
ffffffffc0206182:	c311                	beqz	a4,ffffffffc0206186 <do_exit+0xc6>
ffffffffc0206184:	ff7c                	sd	a5,248(a4)
ffffffffc0206186:	4398                	lw	a4,0(a5)
ffffffffc0206188:	f388                	sd	a0,32(a5)
ffffffffc020618a:	f97c                	sd	a5,240(a0)
ffffffffc020618c:	fd271fe3          	bne	a4,s2,ffffffffc020616a <do_exit+0xaa>
ffffffffc0206190:	0ec52783          	lw	a5,236(a0)
ffffffffc0206194:	fd379be3          	bne	a5,s3,ffffffffc020616a <do_exit+0xaa>
ffffffffc0206198:	2d8010ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc020619c:	b7f9                	j	ffffffffc020616a <do_exit+0xaa>
ffffffffc020619e:	020a1263          	bnez	s4,ffffffffc02061c2 <do_exit+0x102>
ffffffffc02061a2:	380010ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc02061a6:	601c                	ld	a5,0(s0)
ffffffffc02061a8:	00007617          	auipc	a2,0x7
ffffffffc02061ac:	51060613          	addi	a2,a2,1296 # ffffffffc020d6b8 <CSWTCH.79+0x160>
ffffffffc02061b0:	2b300593          	li	a1,691
ffffffffc02061b4:	43d4                	lw	a3,4(a5)
ffffffffc02061b6:	00007517          	auipc	a0,0x7
ffffffffc02061ba:	4b250513          	addi	a0,a0,1202 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02061be:	ae0fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02061c2:	aabfa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02061c6:	bff1                	j	ffffffffc02061a2 <do_exit+0xe2>
ffffffffc02061c8:	f9bfe0ef          	jal	ra,ffffffffc0205162 <files_destroy>
ffffffffc02061cc:	b7a5                	j	ffffffffc0206134 <do_exit+0x74>
ffffffffc02061ce:	00007617          	auipc	a2,0x7
ffffffffc02061d2:	4ca60613          	addi	a2,a2,1226 # ffffffffc020d698 <CSWTCH.79+0x140>
ffffffffc02061d6:	27e00593          	li	a1,638
ffffffffc02061da:	00007517          	auipc	a0,0x7
ffffffffc02061de:	48e50513          	addi	a0,a0,1166 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02061e2:	abcfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02061e6:	854e                	mv	a0,s3
ffffffffc02061e8:	c69fd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc02061ec:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc02061f0:	807ff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc02061f4:	854e                	mv	a0,s3
ffffffffc02061f6:	abffd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc02061fa:	b715                	j	ffffffffc020611e <do_exit+0x5e>
ffffffffc02061fc:	00007617          	auipc	a2,0x7
ffffffffc0206200:	4ac60613          	addi	a2,a2,1196 # ffffffffc020d6a8 <CSWTCH.79+0x150>
ffffffffc0206204:	28200593          	li	a1,642
ffffffffc0206208:	00007517          	auipc	a0,0x7
ffffffffc020620c:	46050513          	addi	a0,a0,1120 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206210:	a8efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206214:	a5ffa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206218:	4a05                	li	s4,1
ffffffffc020621a:	b73d                	j	ffffffffc0206148 <do_exit+0x88>
ffffffffc020621c:	254010ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc0206220:	bf2d                	j	ffffffffc020615a <do_exit+0x9a>

ffffffffc0206222 <do_wait.part.0>:
ffffffffc0206222:	715d                	addi	sp,sp,-80
ffffffffc0206224:	f84a                	sd	s2,48(sp)
ffffffffc0206226:	f44e                	sd	s3,40(sp)
ffffffffc0206228:	80000937          	lui	s2,0x80000
ffffffffc020622c:	6989                	lui	s3,0x2
ffffffffc020622e:	fc26                	sd	s1,56(sp)
ffffffffc0206230:	f052                	sd	s4,32(sp)
ffffffffc0206232:	ec56                	sd	s5,24(sp)
ffffffffc0206234:	e85a                	sd	s6,16(sp)
ffffffffc0206236:	e45e                	sd	s7,8(sp)
ffffffffc0206238:	e486                	sd	ra,72(sp)
ffffffffc020623a:	e0a2                	sd	s0,64(sp)
ffffffffc020623c:	84aa                	mv	s1,a0
ffffffffc020623e:	8a2e                	mv	s4,a1
ffffffffc0206240:	00090b97          	auipc	s7,0x90
ffffffffc0206244:	680b8b93          	addi	s7,s7,1664 # ffffffffc02968c0 <current>
ffffffffc0206248:	00050b1b          	sext.w	s6,a0
ffffffffc020624c:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0206250:	19f9                	addi	s3,s3,-2
ffffffffc0206252:	0905                	addi	s2,s2,1
ffffffffc0206254:	ccbd                	beqz	s1,ffffffffc02062d2 <do_wait.part.0+0xb0>
ffffffffc0206256:	0359e863          	bltu	s3,s5,ffffffffc0206286 <do_wait.part.0+0x64>
ffffffffc020625a:	45a9                	li	a1,10
ffffffffc020625c:	855a                	mv	a0,s6
ffffffffc020625e:	6e5040ef          	jal	ra,ffffffffc020b142 <hash32>
ffffffffc0206262:	02051793          	slli	a5,a0,0x20
ffffffffc0206266:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020626a:	0008b797          	auipc	a5,0x8b
ffffffffc020626e:	55678793          	addi	a5,a5,1366 # ffffffffc02917c0 <hash_list>
ffffffffc0206272:	953e                	add	a0,a0,a5
ffffffffc0206274:	842a                	mv	s0,a0
ffffffffc0206276:	a029                	j	ffffffffc0206280 <do_wait.part.0+0x5e>
ffffffffc0206278:	f2c42783          	lw	a5,-212(s0)
ffffffffc020627c:	02978163          	beq	a5,s1,ffffffffc020629e <do_wait.part.0+0x7c>
ffffffffc0206280:	6400                	ld	s0,8(s0)
ffffffffc0206282:	fe851be3          	bne	a0,s0,ffffffffc0206278 <do_wait.part.0+0x56>
ffffffffc0206286:	5579                	li	a0,-2
ffffffffc0206288:	60a6                	ld	ra,72(sp)
ffffffffc020628a:	6406                	ld	s0,64(sp)
ffffffffc020628c:	74e2                	ld	s1,56(sp)
ffffffffc020628e:	7942                	ld	s2,48(sp)
ffffffffc0206290:	79a2                	ld	s3,40(sp)
ffffffffc0206292:	7a02                	ld	s4,32(sp)
ffffffffc0206294:	6ae2                	ld	s5,24(sp)
ffffffffc0206296:	6b42                	ld	s6,16(sp)
ffffffffc0206298:	6ba2                	ld	s7,8(sp)
ffffffffc020629a:	6161                	addi	sp,sp,80
ffffffffc020629c:	8082                	ret
ffffffffc020629e:	000bb683          	ld	a3,0(s7)
ffffffffc02062a2:	f4843783          	ld	a5,-184(s0)
ffffffffc02062a6:	fed790e3          	bne	a5,a3,ffffffffc0206286 <do_wait.part.0+0x64>
ffffffffc02062aa:	f2842703          	lw	a4,-216(s0)
ffffffffc02062ae:	478d                	li	a5,3
ffffffffc02062b0:	0ef70b63          	beq	a4,a5,ffffffffc02063a6 <do_wait.part.0+0x184>
ffffffffc02062b4:	4785                	li	a5,1
ffffffffc02062b6:	c29c                	sw	a5,0(a3)
ffffffffc02062b8:	0f26a623          	sw	s2,236(a3)
ffffffffc02062bc:	266010ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc02062c0:	000bb783          	ld	a5,0(s7)
ffffffffc02062c4:	0b07a783          	lw	a5,176(a5)
ffffffffc02062c8:	8b85                	andi	a5,a5,1
ffffffffc02062ca:	d7c9                	beqz	a5,ffffffffc0206254 <do_wait.part.0+0x32>
ffffffffc02062cc:	555d                	li	a0,-9
ffffffffc02062ce:	df3ff0ef          	jal	ra,ffffffffc02060c0 <do_exit>
ffffffffc02062d2:	000bb683          	ld	a3,0(s7)
ffffffffc02062d6:	7ae0                	ld	s0,240(a3)
ffffffffc02062d8:	d45d                	beqz	s0,ffffffffc0206286 <do_wait.part.0+0x64>
ffffffffc02062da:	470d                	li	a4,3
ffffffffc02062dc:	a021                	j	ffffffffc02062e4 <do_wait.part.0+0xc2>
ffffffffc02062de:	10043403          	ld	s0,256(s0)
ffffffffc02062e2:	d869                	beqz	s0,ffffffffc02062b4 <do_wait.part.0+0x92>
ffffffffc02062e4:	401c                	lw	a5,0(s0)
ffffffffc02062e6:	fee79ce3          	bne	a5,a4,ffffffffc02062de <do_wait.part.0+0xbc>
ffffffffc02062ea:	00090797          	auipc	a5,0x90
ffffffffc02062ee:	5de7b783          	ld	a5,1502(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02062f2:	0c878963          	beq	a5,s0,ffffffffc02063c4 <do_wait.part.0+0x1a2>
ffffffffc02062f6:	00090797          	auipc	a5,0x90
ffffffffc02062fa:	5da7b783          	ld	a5,1498(a5) # ffffffffc02968d0 <initproc>
ffffffffc02062fe:	0cf40363          	beq	s0,a5,ffffffffc02063c4 <do_wait.part.0+0x1a2>
ffffffffc0206302:	000a0663          	beqz	s4,ffffffffc020630e <do_wait.part.0+0xec>
ffffffffc0206306:	0e842783          	lw	a5,232(s0)
ffffffffc020630a:	00fa2023          	sw	a5,0(s4)
ffffffffc020630e:	100027f3          	csrr	a5,sstatus
ffffffffc0206312:	8b89                	andi	a5,a5,2
ffffffffc0206314:	4581                	li	a1,0
ffffffffc0206316:	e7c1                	bnez	a5,ffffffffc020639e <do_wait.part.0+0x17c>
ffffffffc0206318:	6c70                	ld	a2,216(s0)
ffffffffc020631a:	7074                	ld	a3,224(s0)
ffffffffc020631c:	10043703          	ld	a4,256(s0)
ffffffffc0206320:	7c7c                	ld	a5,248(s0)
ffffffffc0206322:	e614                	sd	a3,8(a2)
ffffffffc0206324:	e290                	sd	a2,0(a3)
ffffffffc0206326:	6470                	ld	a2,200(s0)
ffffffffc0206328:	6874                	ld	a3,208(s0)
ffffffffc020632a:	e614                	sd	a3,8(a2)
ffffffffc020632c:	e290                	sd	a2,0(a3)
ffffffffc020632e:	c319                	beqz	a4,ffffffffc0206334 <do_wait.part.0+0x112>
ffffffffc0206330:	ff7c                	sd	a5,248(a4)
ffffffffc0206332:	7c7c                	ld	a5,248(s0)
ffffffffc0206334:	c3b5                	beqz	a5,ffffffffc0206398 <do_wait.part.0+0x176>
ffffffffc0206336:	10e7b023          	sd	a4,256(a5)
ffffffffc020633a:	00090717          	auipc	a4,0x90
ffffffffc020633e:	59e70713          	addi	a4,a4,1438 # ffffffffc02968d8 <nr_process>
ffffffffc0206342:	431c                	lw	a5,0(a4)
ffffffffc0206344:	37fd                	addiw	a5,a5,-1
ffffffffc0206346:	c31c                	sw	a5,0(a4)
ffffffffc0206348:	e5a9                	bnez	a1,ffffffffc0206392 <do_wait.part.0+0x170>
ffffffffc020634a:	6814                	ld	a3,16(s0)
ffffffffc020634c:	c02007b7          	lui	a5,0xc0200
ffffffffc0206350:	04f6ee63          	bltu	a3,a5,ffffffffc02063ac <do_wait.part.0+0x18a>
ffffffffc0206354:	00090797          	auipc	a5,0x90
ffffffffc0206358:	5647b783          	ld	a5,1380(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc020635c:	8e9d                	sub	a3,a3,a5
ffffffffc020635e:	82b1                	srli	a3,a3,0xc
ffffffffc0206360:	00090797          	auipc	a5,0x90
ffffffffc0206364:	5407b783          	ld	a5,1344(a5) # ffffffffc02968a0 <npage>
ffffffffc0206368:	06f6fa63          	bgeu	a3,a5,ffffffffc02063dc <do_wait.part.0+0x1ba>
ffffffffc020636c:	00009517          	auipc	a0,0x9
ffffffffc0206370:	65c53503          	ld	a0,1628(a0) # ffffffffc020f9c8 <nbase>
ffffffffc0206374:	8e89                	sub	a3,a3,a0
ffffffffc0206376:	069a                	slli	a3,a3,0x6
ffffffffc0206378:	00090517          	auipc	a0,0x90
ffffffffc020637c:	53053503          	ld	a0,1328(a0) # ffffffffc02968a8 <pages>
ffffffffc0206380:	9536                	add	a0,a0,a3
ffffffffc0206382:	4589                	li	a1,2
ffffffffc0206384:	e27fb0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0206388:	8522                	mv	a0,s0
ffffffffc020638a:	cb5fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020638e:	4501                	li	a0,0
ffffffffc0206390:	bde5                	j	ffffffffc0206288 <do_wait.part.0+0x66>
ffffffffc0206392:	8dbfa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206396:	bf55                	j	ffffffffc020634a <do_wait.part.0+0x128>
ffffffffc0206398:	701c                	ld	a5,32(s0)
ffffffffc020639a:	fbf8                	sd	a4,240(a5)
ffffffffc020639c:	bf79                	j	ffffffffc020633a <do_wait.part.0+0x118>
ffffffffc020639e:	8d5fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02063a2:	4585                	li	a1,1
ffffffffc02063a4:	bf95                	j	ffffffffc0206318 <do_wait.part.0+0xf6>
ffffffffc02063a6:	f2840413          	addi	s0,s0,-216
ffffffffc02063aa:	b781                	j	ffffffffc02062ea <do_wait.part.0+0xc8>
ffffffffc02063ac:	00006617          	auipc	a2,0x6
ffffffffc02063b0:	37460613          	addi	a2,a2,884 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc02063b4:	07700593          	li	a1,119
ffffffffc02063b8:	00006517          	auipc	a0,0x6
ffffffffc02063bc:	2e850513          	addi	a0,a0,744 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc02063c0:	8defa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02063c4:	00007617          	auipc	a2,0x7
ffffffffc02063c8:	31460613          	addi	a2,a2,788 # ffffffffc020d6d8 <CSWTCH.79+0x180>
ffffffffc02063cc:	44a00593          	li	a1,1098
ffffffffc02063d0:	00007517          	auipc	a0,0x7
ffffffffc02063d4:	29850513          	addi	a0,a0,664 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02063d8:	8c6fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02063dc:	dfeff0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>

ffffffffc02063e0 <init_main>:
ffffffffc02063e0:	1141                	addi	sp,sp,-16
ffffffffc02063e2:	00007517          	auipc	a0,0x7
ffffffffc02063e6:	31650513          	addi	a0,a0,790 # ffffffffc020d6f8 <CSWTCH.79+0x1a0>
ffffffffc02063ea:	e406                	sd	ra,8(sp)
ffffffffc02063ec:	0a7010ef          	jal	ra,ffffffffc0207c92 <vfs_set_bootfs>
ffffffffc02063f0:	e179                	bnez	a0,ffffffffc02064b6 <init_main+0xd6>
ffffffffc02063f2:	df9fb0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc02063f6:	b95fb0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc02063fa:	4601                	li	a2,0
ffffffffc02063fc:	4581                	li	a1,0
ffffffffc02063fe:	00001517          	auipc	a0,0x1
ffffffffc0206402:	acc50513          	addi	a0,a0,-1332 # ffffffffc0206eca <user_main>
ffffffffc0206406:	c6bff0ef          	jal	ra,ffffffffc0206070 <kernel_thread>
ffffffffc020640a:	00a04563          	bgtz	a0,ffffffffc0206414 <init_main+0x34>
ffffffffc020640e:	a841                	j	ffffffffc020649e <init_main+0xbe>
ffffffffc0206410:	112010ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc0206414:	4581                	li	a1,0
ffffffffc0206416:	4501                	li	a0,0
ffffffffc0206418:	e0bff0ef          	jal	ra,ffffffffc0206222 <do_wait.part.0>
ffffffffc020641c:	d975                	beqz	a0,ffffffffc0206410 <init_main+0x30>
ffffffffc020641e:	cfffe0ef          	jal	ra,ffffffffc020511c <fs_cleanup>
ffffffffc0206422:	00007517          	auipc	a0,0x7
ffffffffc0206426:	31e50513          	addi	a0,a0,798 # ffffffffc020d740 <CSWTCH.79+0x1e8>
ffffffffc020642a:	d7df90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020642e:	00090797          	auipc	a5,0x90
ffffffffc0206432:	4a27b783          	ld	a5,1186(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206436:	7bf8                	ld	a4,240(a5)
ffffffffc0206438:	e339                	bnez	a4,ffffffffc020647e <init_main+0x9e>
ffffffffc020643a:	7ff8                	ld	a4,248(a5)
ffffffffc020643c:	e329                	bnez	a4,ffffffffc020647e <init_main+0x9e>
ffffffffc020643e:	1007b703          	ld	a4,256(a5)
ffffffffc0206442:	ef15                	bnez	a4,ffffffffc020647e <init_main+0x9e>
ffffffffc0206444:	00090697          	auipc	a3,0x90
ffffffffc0206448:	4946a683          	lw	a3,1172(a3) # ffffffffc02968d8 <nr_process>
ffffffffc020644c:	4709                	li	a4,2
ffffffffc020644e:	0ce69163          	bne	a3,a4,ffffffffc0206510 <init_main+0x130>
ffffffffc0206452:	0008f717          	auipc	a4,0x8f
ffffffffc0206456:	36e70713          	addi	a4,a4,878 # ffffffffc02957c0 <proc_list>
ffffffffc020645a:	6714                	ld	a3,8(a4)
ffffffffc020645c:	0c878793          	addi	a5,a5,200
ffffffffc0206460:	08d79863          	bne	a5,a3,ffffffffc02064f0 <init_main+0x110>
ffffffffc0206464:	6318                	ld	a4,0(a4)
ffffffffc0206466:	06e79563          	bne	a5,a4,ffffffffc02064d0 <init_main+0xf0>
ffffffffc020646a:	00007517          	auipc	a0,0x7
ffffffffc020646e:	3be50513          	addi	a0,a0,958 # ffffffffc020d828 <CSWTCH.79+0x2d0>
ffffffffc0206472:	d35f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206476:	60a2                	ld	ra,8(sp)
ffffffffc0206478:	4501                	li	a0,0
ffffffffc020647a:	0141                	addi	sp,sp,16
ffffffffc020647c:	8082                	ret
ffffffffc020647e:	00007697          	auipc	a3,0x7
ffffffffc0206482:	2ea68693          	addi	a3,a3,746 # ffffffffc020d768 <CSWTCH.79+0x210>
ffffffffc0206486:	00005617          	auipc	a2,0x5
ffffffffc020648a:	6d260613          	addi	a2,a2,1746 # ffffffffc020bb58 <commands+0x210>
ffffffffc020648e:	4c000593          	li	a1,1216
ffffffffc0206492:	00007517          	auipc	a0,0x7
ffffffffc0206496:	1d650513          	addi	a0,a0,470 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc020649a:	804fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020649e:	00007617          	auipc	a2,0x7
ffffffffc02064a2:	28260613          	addi	a2,a2,642 # ffffffffc020d720 <CSWTCH.79+0x1c8>
ffffffffc02064a6:	4b300593          	li	a1,1203
ffffffffc02064aa:	00007517          	auipc	a0,0x7
ffffffffc02064ae:	1be50513          	addi	a0,a0,446 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02064b2:	fedf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02064b6:	86aa                	mv	a3,a0
ffffffffc02064b8:	00007617          	auipc	a2,0x7
ffffffffc02064bc:	24860613          	addi	a2,a2,584 # ffffffffc020d700 <CSWTCH.79+0x1a8>
ffffffffc02064c0:	4ab00593          	li	a1,1195
ffffffffc02064c4:	00007517          	auipc	a0,0x7
ffffffffc02064c8:	1a450513          	addi	a0,a0,420 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02064cc:	fd3f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02064d0:	00007697          	auipc	a3,0x7
ffffffffc02064d4:	32868693          	addi	a3,a3,808 # ffffffffc020d7f8 <CSWTCH.79+0x2a0>
ffffffffc02064d8:	00005617          	auipc	a2,0x5
ffffffffc02064dc:	68060613          	addi	a2,a2,1664 # ffffffffc020bb58 <commands+0x210>
ffffffffc02064e0:	4c300593          	li	a1,1219
ffffffffc02064e4:	00007517          	auipc	a0,0x7
ffffffffc02064e8:	18450513          	addi	a0,a0,388 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02064ec:	fb3f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02064f0:	00007697          	auipc	a3,0x7
ffffffffc02064f4:	2d868693          	addi	a3,a3,728 # ffffffffc020d7c8 <CSWTCH.79+0x270>
ffffffffc02064f8:	00005617          	auipc	a2,0x5
ffffffffc02064fc:	66060613          	addi	a2,a2,1632 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206500:	4c200593          	li	a1,1218
ffffffffc0206504:	00007517          	auipc	a0,0x7
ffffffffc0206508:	16450513          	addi	a0,a0,356 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc020650c:	f93f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206510:	00007697          	auipc	a3,0x7
ffffffffc0206514:	2a868693          	addi	a3,a3,680 # ffffffffc020d7b8 <CSWTCH.79+0x260>
ffffffffc0206518:	00005617          	auipc	a2,0x5
ffffffffc020651c:	64060613          	addi	a2,a2,1600 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206520:	4c100593          	li	a1,1217
ffffffffc0206524:	00007517          	auipc	a0,0x7
ffffffffc0206528:	14450513          	addi	a0,a0,324 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc020652c:	f73f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206530 <do_execve>:
ffffffffc0206530:	c8010113          	addi	sp,sp,-896
ffffffffc0206534:	35413823          	sd	s4,848(sp)
ffffffffc0206538:	00090a17          	auipc	s4,0x90
ffffffffc020653c:	388a0a13          	addi	s4,s4,904 # ffffffffc02968c0 <current>
ffffffffc0206540:	000a3683          	ld	a3,0(s4)
ffffffffc0206544:	fff5871b          	addiw	a4,a1,-1
ffffffffc0206548:	35613023          	sd	s6,832(sp)
ffffffffc020654c:	36113c23          	sd	ra,888(sp)
ffffffffc0206550:	36813823          	sd	s0,880(sp)
ffffffffc0206554:	36913423          	sd	s1,872(sp)
ffffffffc0206558:	37213023          	sd	s2,864(sp)
ffffffffc020655c:	35313c23          	sd	s3,856(sp)
ffffffffc0206560:	35513423          	sd	s5,840(sp)
ffffffffc0206564:	33713c23          	sd	s7,824(sp)
ffffffffc0206568:	33813823          	sd	s8,816(sp)
ffffffffc020656c:	33913423          	sd	s9,808(sp)
ffffffffc0206570:	33a13023          	sd	s10,800(sp)
ffffffffc0206574:	31b13c23          	sd	s11,792(sp)
ffffffffc0206578:	d03a                	sw	a4,32(sp)
ffffffffc020657a:	47fd                	li	a5,31
ffffffffc020657c:	0286bb03          	ld	s6,40(a3)
ffffffffc0206580:	5ae7e563          	bltu	a5,a4,ffffffffc0206b2a <do_execve+0x5fa>
ffffffffc0206584:	842e                	mv	s0,a1
ffffffffc0206586:	84aa                	mv	s1,a0
ffffffffc0206588:	8bb2                	mv	s7,a2
ffffffffc020658a:	4581                	li	a1,0
ffffffffc020658c:	4641                	li	a2,16
ffffffffc020658e:	0108                	addi	a0,sp,128
ffffffffc0206590:	0e6050ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0206594:	000b0c63          	beqz	s6,ffffffffc02065ac <do_execve+0x7c>
ffffffffc0206598:	038b0513          	addi	a0,s6,56
ffffffffc020659c:	f27fd0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02065a0:	000a3783          	ld	a5,0(s4)
ffffffffc02065a4:	c781                	beqz	a5,ffffffffc02065ac <do_execve+0x7c>
ffffffffc02065a6:	43dc                	lw	a5,4(a5)
ffffffffc02065a8:	04fb2823          	sw	a5,80(s6)
ffffffffc02065ac:	24048363          	beqz	s1,ffffffffc02067f2 <do_execve+0x2c2>
ffffffffc02065b0:	46c1                	li	a3,16
ffffffffc02065b2:	8626                	mv	a2,s1
ffffffffc02065b4:	010c                	addi	a1,sp,128
ffffffffc02065b6:	855a                	mv	a0,s6
ffffffffc02065b8:	d33fd0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc02065bc:	6c050a63          	beqz	a0,ffffffffc0206c90 <do_execve+0x760>
ffffffffc02065c0:	00341793          	slli	a5,s0,0x3
ffffffffc02065c4:	4681                	li	a3,0
ffffffffc02065c6:	863e                	mv	a2,a5
ffffffffc02065c8:	85de                	mv	a1,s7
ffffffffc02065ca:	855a                	mv	a0,s6
ffffffffc02065cc:	f43e                	sd	a5,40(sp)
ffffffffc02065ce:	c23fd0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc02065d2:	89de                	mv	s3,s7
ffffffffc02065d4:	6a050a63          	beqz	a0,ffffffffc0206c88 <do_execve+0x758>
ffffffffc02065d8:	10810a93          	addi	s5,sp,264
ffffffffc02065dc:	4481                	li	s1,0
ffffffffc02065de:	a011                	j	ffffffffc02065e2 <do_execve+0xb2>
ffffffffc02065e0:	84e2                	mv	s1,s8
ffffffffc02065e2:	6505                	lui	a0,0x1
ffffffffc02065e4:	9abfb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02065e8:	892a                	mv	s2,a0
ffffffffc02065ea:	18050163          	beqz	a0,ffffffffc020676c <do_execve+0x23c>
ffffffffc02065ee:	0009b603          	ld	a2,0(s3) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc02065f2:	85aa                	mv	a1,a0
ffffffffc02065f4:	6685                	lui	a3,0x1
ffffffffc02065f6:	855a                	mv	a0,s6
ffffffffc02065f8:	cf3fd0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc02065fc:	1e050663          	beqz	a0,ffffffffc02067e8 <do_execve+0x2b8>
ffffffffc0206600:	012ab023          	sd	s2,0(s5)
ffffffffc0206604:	00148c1b          	addiw	s8,s1,1
ffffffffc0206608:	0aa1                	addi	s5,s5,8
ffffffffc020660a:	09a1                	addi	s3,s3,8
ffffffffc020660c:	fd841ae3          	bne	s0,s8,ffffffffc02065e0 <do_execve+0xb0>
ffffffffc0206610:	000bb903          	ld	s2,0(s7)
ffffffffc0206614:	100b0963          	beqz	s6,ffffffffc0206726 <do_execve+0x1f6>
ffffffffc0206618:	038b0513          	addi	a0,s6,56
ffffffffc020661c:	ea3fd0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0206620:	000a3703          	ld	a4,0(s4)
ffffffffc0206624:	040b2823          	sw	zero,80(s6)
ffffffffc0206628:	14873503          	ld	a0,328(a4)
ffffffffc020662c:	bcdfe0ef          	jal	ra,ffffffffc02051f8 <files_closeall>
ffffffffc0206630:	4581                	li	a1,0
ffffffffc0206632:	854a                	mv	a0,s2
ffffffffc0206634:	e51fe0ef          	jal	ra,ffffffffc0205484 <sysfile_open>
ffffffffc0206638:	8aaa                	mv	s5,a0
ffffffffc020663a:	00054ce3          	bltz	a0,ffffffffc0206e52 <do_execve+0x922>
ffffffffc020663e:	00090717          	auipc	a4,0x90
ffffffffc0206642:	25273703          	ld	a4,594(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206646:	56fd                	li	a3,-1
ffffffffc0206648:	16fe                	slli	a3,a3,0x3f
ffffffffc020664a:	8331                	srli	a4,a4,0xc
ffffffffc020664c:	8f55                	or	a4,a4,a3
ffffffffc020664e:	18071073          	csrw	satp,a4
ffffffffc0206652:	030b2703          	lw	a4,48(s6)
ffffffffc0206656:	fff7069b          	addiw	a3,a4,-1
ffffffffc020665a:	02db2823          	sw	a3,48(s6)
ffffffffc020665e:	1a068663          	beqz	a3,ffffffffc020680a <do_execve+0x2da>
ffffffffc0206662:	000a3703          	ld	a4,0(s4)
ffffffffc0206666:	02073423          	sd	zero,40(a4)
ffffffffc020666a:	cfcfd0ef          	jal	ra,ffffffffc0203b66 <mm_create>
ffffffffc020666e:	892a                	mv	s2,a0
ffffffffc0206670:	0e050c63          	beqz	a0,ffffffffc0206768 <do_execve+0x238>
ffffffffc0206674:	4505                	li	a0,1
ffffffffc0206676:	af7fb0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020667a:	0e050463          	beqz	a0,ffffffffc0206762 <do_execve+0x232>
ffffffffc020667e:	00090c97          	auipc	s9,0x90
ffffffffc0206682:	22ac8c93          	addi	s9,s9,554 # ffffffffc02968a8 <pages>
ffffffffc0206686:	000cb683          	ld	a3,0(s9)
ffffffffc020668a:	00090d97          	auipc	s11,0x90
ffffffffc020668e:	216d8d93          	addi	s11,s11,534 # ffffffffc02968a0 <npage>
ffffffffc0206692:	00009797          	auipc	a5,0x9
ffffffffc0206696:	3367b783          	ld	a5,822(a5) # ffffffffc020f9c8 <nbase>
ffffffffc020669a:	40d506b3          	sub	a3,a0,a3
ffffffffc020669e:	567d                	li	a2,-1
ffffffffc02066a0:	8699                	srai	a3,a3,0x6
ffffffffc02066a2:	000db703          	ld	a4,0(s11)
ffffffffc02066a6:	96be                	add	a3,a3,a5
ffffffffc02066a8:	f83e                	sd	a5,48(sp)
ffffffffc02066aa:	00c65793          	srli	a5,a2,0xc
ffffffffc02066ae:	00f6f633          	and	a2,a3,a5
ffffffffc02066b2:	ec3e                	sd	a5,24(sp)
ffffffffc02066b4:	06b2                	slli	a3,a3,0xc
ffffffffc02066b6:	74e67063          	bgeu	a2,a4,ffffffffc0206df6 <do_execve+0x8c6>
ffffffffc02066ba:	00090b97          	auipc	s7,0x90
ffffffffc02066be:	1feb8b93          	addi	s7,s7,510 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02066c2:	000bb983          	ld	s3,0(s7)
ffffffffc02066c6:	6605                	lui	a2,0x1
ffffffffc02066c8:	00090597          	auipc	a1,0x90
ffffffffc02066cc:	1d05b583          	ld	a1,464(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc02066d0:	99b6                	add	s3,s3,a3
ffffffffc02066d2:	854e                	mv	a0,s3
ffffffffc02066d4:	7f5040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc02066d8:	4601                	li	a2,0
ffffffffc02066da:	01393c23          	sd	s3,24(s2) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc02066de:	4581                	li	a1,0
ffffffffc02066e0:	8556                	mv	a0,s5
ffffffffc02066e2:	808ff0ef          	jal	ra,ffffffffc02056ea <sysfile_seek>
ffffffffc02066e6:	89aa                	mv	s3,a0
ffffffffc02066e8:	12050c63          	beqz	a0,ffffffffc0206820 <do_execve+0x2f0>
ffffffffc02066ec:	01893503          	ld	a0,24(s2)
ffffffffc02066f0:	b06ff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc02066f4:	854a                	mv	a0,s2
ffffffffc02066f6:	dbefd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc02066fa:	77a2                	ld	a5,40(sp)
ffffffffc02066fc:	19a4                	addi	s1,sp,248
ffffffffc02066fe:	147d                	addi	s0,s0,-1
ffffffffc0206700:	94be                	add	s1,s1,a5
ffffffffc0206702:	7782                	ld	a5,32(sp)
ffffffffc0206704:	040e                	slli	s0,s0,0x3
ffffffffc0206706:	02079713          	slli	a4,a5,0x20
ffffffffc020670a:	01d75793          	srli	a5,a4,0x1d
ffffffffc020670e:	0238                	addi	a4,sp,264
ffffffffc0206710:	943a                	add	s0,s0,a4
ffffffffc0206712:	8c9d                	sub	s1,s1,a5
ffffffffc0206714:	6008                	ld	a0,0(s0)
ffffffffc0206716:	1461                	addi	s0,s0,-8
ffffffffc0206718:	927fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020671c:	fe849ce3          	bne	s1,s0,ffffffffc0206714 <do_execve+0x1e4>
ffffffffc0206720:	854e                	mv	a0,s3
ffffffffc0206722:	99fff0ef          	jal	ra,ffffffffc02060c0 <do_exit>
ffffffffc0206726:	000a3703          	ld	a4,0(s4)
ffffffffc020672a:	14873503          	ld	a0,328(a4)
ffffffffc020672e:	acbfe0ef          	jal	ra,ffffffffc02051f8 <files_closeall>
ffffffffc0206732:	4581                	li	a1,0
ffffffffc0206734:	854a                	mv	a0,s2
ffffffffc0206736:	d4ffe0ef          	jal	ra,ffffffffc0205484 <sysfile_open>
ffffffffc020673a:	8aaa                	mv	s5,a0
ffffffffc020673c:	70054863          	bltz	a0,ffffffffc0206e4c <do_execve+0x91c>
ffffffffc0206740:	000a3703          	ld	a4,0(s4)
ffffffffc0206744:	7718                	ld	a4,40(a4)
ffffffffc0206746:	f20702e3          	beqz	a4,ffffffffc020666a <do_execve+0x13a>
ffffffffc020674a:	00007617          	auipc	a2,0x7
ffffffffc020674e:	10e60613          	addi	a2,a2,270 # ffffffffc020d858 <CSWTCH.79+0x300>
ffffffffc0206752:	2cd00593          	li	a1,717
ffffffffc0206756:	00007517          	auipc	a0,0x7
ffffffffc020675a:	f1250513          	addi	a0,a0,-238 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc020675e:	d41f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206762:	854a                	mv	a0,s2
ffffffffc0206764:	d50fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0206768:	59f1                	li	s3,-4
ffffffffc020676a:	bf41                	j	ffffffffc02066fa <do_execve+0x1ca>
ffffffffc020676c:	59f1                	li	s3,-4
ffffffffc020676e:	c49d                	beqz	s1,ffffffffc020679c <do_execve+0x26c>
ffffffffc0206770:	00349713          	slli	a4,s1,0x3
ffffffffc0206774:	fff48413          	addi	s0,s1,-1
ffffffffc0206778:	19bc                	addi	a5,sp,248
ffffffffc020677a:	34fd                	addiw	s1,s1,-1
ffffffffc020677c:	97ba                	add	a5,a5,a4
ffffffffc020677e:	02049713          	slli	a4,s1,0x20
ffffffffc0206782:	01d75493          	srli	s1,a4,0x1d
ffffffffc0206786:	040e                	slli	s0,s0,0x3
ffffffffc0206788:	0238                	addi	a4,sp,264
ffffffffc020678a:	943a                	add	s0,s0,a4
ffffffffc020678c:	409784b3          	sub	s1,a5,s1
ffffffffc0206790:	6008                	ld	a0,0(s0)
ffffffffc0206792:	1461                	addi	s0,s0,-8
ffffffffc0206794:	8abfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206798:	fe849ce3          	bne	s1,s0,ffffffffc0206790 <do_execve+0x260>
ffffffffc020679c:	000b0863          	beqz	s6,ffffffffc02067ac <do_execve+0x27c>
ffffffffc02067a0:	038b0513          	addi	a0,s6,56
ffffffffc02067a4:	d1bfd0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02067a8:	040b2823          	sw	zero,80(s6)
ffffffffc02067ac:	37813083          	ld	ra,888(sp)
ffffffffc02067b0:	37013403          	ld	s0,880(sp)
ffffffffc02067b4:	36813483          	ld	s1,872(sp)
ffffffffc02067b8:	36013903          	ld	s2,864(sp)
ffffffffc02067bc:	35013a03          	ld	s4,848(sp)
ffffffffc02067c0:	34813a83          	ld	s5,840(sp)
ffffffffc02067c4:	34013b03          	ld	s6,832(sp)
ffffffffc02067c8:	33813b83          	ld	s7,824(sp)
ffffffffc02067cc:	33013c03          	ld	s8,816(sp)
ffffffffc02067d0:	32813c83          	ld	s9,808(sp)
ffffffffc02067d4:	32013d03          	ld	s10,800(sp)
ffffffffc02067d8:	31813d83          	ld	s11,792(sp)
ffffffffc02067dc:	854e                	mv	a0,s3
ffffffffc02067de:	35813983          	ld	s3,856(sp)
ffffffffc02067e2:	38010113          	addi	sp,sp,896
ffffffffc02067e6:	8082                	ret
ffffffffc02067e8:	854a                	mv	a0,s2
ffffffffc02067ea:	855fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02067ee:	59f5                	li	s3,-3
ffffffffc02067f0:	bfbd                	j	ffffffffc020676e <do_execve+0x23e>
ffffffffc02067f2:	000a3783          	ld	a5,0(s4)
ffffffffc02067f6:	00007617          	auipc	a2,0x7
ffffffffc02067fa:	05260613          	addi	a2,a2,82 # ffffffffc020d848 <CSWTCH.79+0x2f0>
ffffffffc02067fe:	45c1                	li	a1,16
ffffffffc0206800:	43d4                	lw	a3,4(a5)
ffffffffc0206802:	0108                	addi	a0,sp,128
ffffffffc0206804:	583040ef          	jal	ra,ffffffffc020b586 <snprintf>
ffffffffc0206808:	bb65                	j	ffffffffc02065c0 <do_execve+0x90>
ffffffffc020680a:	855a                	mv	a0,s6
ffffffffc020680c:	e44fd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc0206810:	018b3503          	ld	a0,24(s6)
ffffffffc0206814:	9e2ff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0206818:	855a                	mv	a0,s6
ffffffffc020681a:	c9afd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc020681e:	b591                	j	ffffffffc0206662 <do_execve+0x132>
ffffffffc0206820:	04000613          	li	a2,64
ffffffffc0206824:	01ac                	addi	a1,sp,200
ffffffffc0206826:	8556                	mv	a0,s5
ffffffffc0206828:	c95fe0ef          	jal	ra,ffffffffc02054bc <sysfile_read>
ffffffffc020682c:	04000713          	li	a4,64
ffffffffc0206830:	00e50863          	beq	a0,a4,ffffffffc0206840 <do_execve+0x310>
ffffffffc0206834:	0005099b          	sext.w	s3,a0
ffffffffc0206838:	ea054ae3          	bltz	a0,ffffffffc02066ec <do_execve+0x1bc>
ffffffffc020683c:	59fd                	li	s3,-1
ffffffffc020683e:	b57d                	j	ffffffffc02066ec <do_execve+0x1bc>
ffffffffc0206840:	46ae                	lw	a3,200(sp)
ffffffffc0206842:	464c4737          	lui	a4,0x464c4
ffffffffc0206846:	57f70713          	addi	a4,a4,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc020684a:	00e68b63          	beq	a3,a4,ffffffffc0206860 <do_execve+0x330>
ffffffffc020684e:	01893503          	ld	a0,24(s2)
ffffffffc0206852:	59e1                	li	s3,-8
ffffffffc0206854:	9a2ff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0206858:	854a                	mv	a0,s2
ffffffffc020685a:	c5afd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc020685e:	bd71                	j	ffffffffc02066fa <do_execve+0x1ca>
ffffffffc0206860:	77ae                	ld	a5,232(sp)
ffffffffc0206862:	10015703          	lhu	a4,256(sp)
ffffffffc0206866:	f082                	sd	zero,96(sp)
ffffffffc0206868:	ecbe                	sd	a5,88(sp)
ffffffffc020686a:	16070663          	beqz	a4,ffffffffc02069d6 <do_execve+0x4a6>
ffffffffc020686e:	f8e2                	sd	s8,112(sp)
ffffffffc0206870:	e44a                	sd	s2,8(sp)
ffffffffc0206872:	fca6                	sd	s1,120(sp)
ffffffffc0206874:	f4ce                	sd	s3,104(sp)
ffffffffc0206876:	e8a2                	sd	s0,80(sp)
ffffffffc0206878:	65e6                	ld	a1,88(sp)
ffffffffc020687a:	4601                	li	a2,0
ffffffffc020687c:	8556                	mv	a0,s5
ffffffffc020687e:	e6dfe0ef          	jal	ra,ffffffffc02056ea <sysfile_seek>
ffffffffc0206882:	8d2a                	mv	s10,a0
ffffffffc0206884:	12051263          	bnez	a0,ffffffffc02069a8 <do_execve+0x478>
ffffffffc0206888:	03800613          	li	a2,56
ffffffffc020688c:	090c                	addi	a1,sp,144
ffffffffc020688e:	8556                	mv	a0,s5
ffffffffc0206890:	c2dfe0ef          	jal	ra,ffffffffc02054bc <sysfile_read>
ffffffffc0206894:	03800793          	li	a5,56
ffffffffc0206898:	10f50b63          	beq	a0,a5,ffffffffc02069ae <do_execve+0x47e>
ffffffffc020689c:	6922                	ld	s2,8(sp)
ffffffffc020689e:	6446                	ld	s0,80(sp)
ffffffffc02068a0:	87aa                	mv	a5,a0
ffffffffc02068a2:	00054363          	bltz	a0,ffffffffc02068a8 <do_execve+0x378>
ffffffffc02068a6:	57fd                	li	a5,-1
ffffffffc02068a8:	00078d1b          	sext.w	s10,a5
ffffffffc02068ac:	854a                	mv	a0,s2
ffffffffc02068ae:	da2fd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc02068b2:	01893503          	ld	a0,24(s2)
ffffffffc02068b6:	89ea                	mv	s3,s10
ffffffffc02068b8:	93eff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc02068bc:	854a                	mv	a0,s2
ffffffffc02068be:	bf6fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc02068c2:	bd25                	j	ffffffffc02066fa <do_execve+0x1ca>
ffffffffc02068c4:	766a                	ld	a2,184(sp)
ffffffffc02068c6:	77ca                	ld	a5,176(sp)
ffffffffc02068c8:	3ef66263          	bltu	a2,a5,ffffffffc0206cac <do_execve+0x77c>
ffffffffc02068cc:	47da                	lw	a5,148(sp)
ffffffffc02068ce:	0017f693          	andi	a3,a5,1
ffffffffc02068d2:	c291                	beqz	a3,ffffffffc02068d6 <do_execve+0x3a6>
ffffffffc02068d4:	4691                	li	a3,4
ffffffffc02068d6:	0027f713          	andi	a4,a5,2
ffffffffc02068da:	8b91                	andi	a5,a5,4
ffffffffc02068dc:	24071063          	bnez	a4,ffffffffc0206b1c <do_execve+0x5ec>
ffffffffc02068e0:	4745                	li	a4,17
ffffffffc02068e2:	e4ba                	sd	a4,72(sp)
ffffffffc02068e4:	c789                	beqz	a5,ffffffffc02068ee <do_execve+0x3be>
ffffffffc02068e6:	47cd                	li	a5,19
ffffffffc02068e8:	0016e693          	ori	a3,a3,1
ffffffffc02068ec:	e4be                	sd	a5,72(sp)
ffffffffc02068ee:	0026f793          	andi	a5,a3,2
ffffffffc02068f2:	22079963          	bnez	a5,ffffffffc0206b24 <do_execve+0x5f4>
ffffffffc02068f6:	0046f793          	andi	a5,a3,4
ffffffffc02068fa:	c789                	beqz	a5,ffffffffc0206904 <do_execve+0x3d4>
ffffffffc02068fc:	67a6                	ld	a5,72(sp)
ffffffffc02068fe:	0087e793          	ori	a5,a5,8
ffffffffc0206902:	e4be                	sd	a5,72(sp)
ffffffffc0206904:	758a                	ld	a1,160(sp)
ffffffffc0206906:	6522                	ld	a0,8(sp)
ffffffffc0206908:	4701                	li	a4,0
ffffffffc020690a:	bfcfd0ef          	jal	ra,ffffffffc0203d06 <mm_map>
ffffffffc020690e:	8d2a                	mv	s10,a0
ffffffffc0206910:	ed41                	bnez	a0,ffffffffc02069a8 <do_execve+0x478>
ffffffffc0206912:	7c0a                	ld	s8,160(sp)
ffffffffc0206914:	77fd                	lui	a5,0xfffff
ffffffffc0206916:	6b6a                	ld	s6,152(sp)
ffffffffc0206918:	00fc7933          	and	s2,s8,a5
ffffffffc020691c:	77ca                	ld	a5,176(sp)
ffffffffc020691e:	97e2                	add	a5,a5,s8
ffffffffc0206920:	e83e                	sd	a5,16(sp)
ffffffffc0206922:	38fc7163          	bgeu	s8,a5,ffffffffc0206ca4 <do_execve+0x774>
ffffffffc0206926:	5d71                	li	s10,-4
ffffffffc0206928:	89ca                	mv	s3,s2
ffffffffc020692a:	fc56                	sd	s5,56(sp)
ffffffffc020692c:	a015                	j	ffffffffc0206950 <do_execve+0x420>
ffffffffc020692e:	6786                	ld	a5,64(sp)
ffffffffc0206930:	7562                	ld	a0,56(sp)
ffffffffc0206932:	413c05b3          	sub	a1,s8,s3
ffffffffc0206936:	943e                	add	s0,s0,a5
ffffffffc0206938:	8656                	mv	a2,s5
ffffffffc020693a:	95a2                	add	a1,a1,s0
ffffffffc020693c:	b81fe0ef          	jal	ra,ffffffffc02054bc <sysfile_read>
ffffffffc0206940:	f4aa9ee3          	bne	s5,a0,ffffffffc020689c <do_execve+0x36c>
ffffffffc0206944:	67c2                	ld	a5,16(sp)
ffffffffc0206946:	9c56                	add	s8,s8,s5
ffffffffc0206948:	9b56                	add	s6,s6,s5
ffffffffc020694a:	24fc7363          	bgeu	s8,a5,ffffffffc0206b90 <do_execve+0x660>
ffffffffc020694e:	89ca                	mv	s3,s2
ffffffffc0206950:	67a2                	ld	a5,8(sp)
ffffffffc0206952:	6626                	ld	a2,72(sp)
ffffffffc0206954:	85ce                	mv	a1,s3
ffffffffc0206956:	6f88                	ld	a0,24(a5)
ffffffffc0206958:	928fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc020695c:	84aa                	mv	s1,a0
ffffffffc020695e:	1c050863          	beqz	a0,ffffffffc0206b2e <do_execve+0x5fe>
ffffffffc0206962:	6785                	lui	a5,0x1
ffffffffc0206964:	00f98933          	add	s2,s3,a5
ffffffffc0206968:	67c2                	ld	a5,16(sp)
ffffffffc020696a:	41890ab3          	sub	s5,s2,s8
ffffffffc020696e:	0127f463          	bgeu	a5,s2,ffffffffc0206976 <do_execve+0x446>
ffffffffc0206972:	41878ab3          	sub	s5,a5,s8
ffffffffc0206976:	000cb403          	ld	s0,0(s9)
ffffffffc020697a:	77c2                	ld	a5,48(sp)
ffffffffc020697c:	000db603          	ld	a2,0(s11)
ffffffffc0206980:	40848433          	sub	s0,s1,s0
ffffffffc0206984:	8419                	srai	s0,s0,0x6
ffffffffc0206986:	943e                	add	s0,s0,a5
ffffffffc0206988:	67e2                	ld	a5,24(sp)
ffffffffc020698a:	00f475b3          	and	a1,s0,a5
ffffffffc020698e:	0432                	slli	s0,s0,0xc
ffffffffc0206990:	46c5f263          	bgeu	a1,a2,ffffffffc0206df4 <do_execve+0x8c4>
ffffffffc0206994:	000bb783          	ld	a5,0(s7)
ffffffffc0206998:	7562                	ld	a0,56(sp)
ffffffffc020699a:	4601                	li	a2,0
ffffffffc020699c:	85da                	mv	a1,s6
ffffffffc020699e:	e0be                	sd	a5,64(sp)
ffffffffc02069a0:	d4bfe0ef          	jal	ra,ffffffffc02056ea <sysfile_seek>
ffffffffc02069a4:	8d2a                	mv	s10,a0
ffffffffc02069a6:	d541                	beqz	a0,ffffffffc020692e <do_execve+0x3fe>
ffffffffc02069a8:	6922                	ld	s2,8(sp)
ffffffffc02069aa:	6446                	ld	s0,80(sp)
ffffffffc02069ac:	b701                	j	ffffffffc02068ac <do_execve+0x37c>
ffffffffc02069ae:	47ca                	lw	a5,144(sp)
ffffffffc02069b0:	4705                	li	a4,1
ffffffffc02069b2:	f0e789e3          	beq	a5,a4,ffffffffc02068c4 <do_execve+0x394>
ffffffffc02069b6:	7706                	ld	a4,96(sp)
ffffffffc02069b8:	66e6                	ld	a3,88(sp)
ffffffffc02069ba:	10015783          	lhu	a5,256(sp)
ffffffffc02069be:	2705                	addiw	a4,a4,1
ffffffffc02069c0:	03868693          	addi	a3,a3,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc02069c4:	f0ba                	sd	a4,96(sp)
ffffffffc02069c6:	ecb6                	sd	a3,88(sp)
ffffffffc02069c8:	eaf748e3          	blt	a4,a5,ffffffffc0206878 <do_execve+0x348>
ffffffffc02069cc:	7c46                	ld	s8,112(sp)
ffffffffc02069ce:	6922                	ld	s2,8(sp)
ffffffffc02069d0:	74e6                	ld	s1,120(sp)
ffffffffc02069d2:	79a6                	ld	s3,104(sp)
ffffffffc02069d4:	6446                	ld	s0,80(sp)
ffffffffc02069d6:	4701                	li	a4,0
ffffffffc02069d8:	46ad                	li	a3,11
ffffffffc02069da:	00100637          	lui	a2,0x100
ffffffffc02069de:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02069e2:	854a                	mv	a0,s2
ffffffffc02069e4:	b22fd0ef          	jal	ra,ffffffffc0203d06 <mm_map>
ffffffffc02069e8:	8d2a                	mv	s10,a0
ffffffffc02069ea:	ec0511e3          	bnez	a0,ffffffffc02068ac <do_execve+0x37c>
ffffffffc02069ee:	01893503          	ld	a0,24(s2)
ffffffffc02069f2:	467d                	li	a2,31
ffffffffc02069f4:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02069f8:	888fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc02069fc:	42050863          	beqz	a0,ffffffffc0206e2c <do_execve+0x8fc>
ffffffffc0206a00:	01893503          	ld	a0,24(s2)
ffffffffc0206a04:	467d                	li	a2,31
ffffffffc0206a06:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0206a0a:	876fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc0206a0e:	3c050363          	beqz	a0,ffffffffc0206dd4 <do_execve+0x8a4>
ffffffffc0206a12:	01893503          	ld	a0,24(s2)
ffffffffc0206a16:	467d                	li	a2,31
ffffffffc0206a18:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0206a1c:	864fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc0206a20:	38050a63          	beqz	a0,ffffffffc0206db4 <do_execve+0x884>
ffffffffc0206a24:	01893503          	ld	a0,24(s2)
ffffffffc0206a28:	467d                	li	a2,31
ffffffffc0206a2a:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0206a2e:	852fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc0206a32:	46050c63          	beqz	a0,ffffffffc0206eaa <do_execve+0x97a>
ffffffffc0206a36:	03092703          	lw	a4,48(s2)
ffffffffc0206a3a:	000a3603          	ld	a2,0(s4)
ffffffffc0206a3e:	01893683          	ld	a3,24(s2)
ffffffffc0206a42:	2705                	addiw	a4,a4,1
ffffffffc0206a44:	02e92823          	sw	a4,48(s2)
ffffffffc0206a48:	03263423          	sd	s2,40(a2) # 100028 <_binary_bin_sfs_img_size+0x8ad28>
ffffffffc0206a4c:	c0200737          	lui	a4,0xc0200
ffffffffc0206a50:	44e6e163          	bltu	a3,a4,ffffffffc0206e92 <do_execve+0x962>
ffffffffc0206a54:	000bb703          	ld	a4,0(s7)
ffffffffc0206a58:	5b7d                	li	s6,-1
ffffffffc0206a5a:	03fb1593          	slli	a1,s6,0x3f
ffffffffc0206a5e:	8e99                	sub	a3,a3,a4
ffffffffc0206a60:	00c6d713          	srli	a4,a3,0xc
ffffffffc0206a64:	f654                	sd	a3,168(a2)
ffffffffc0206a66:	8f4d                	or	a4,a4,a1
ffffffffc0206a68:	18071073          	csrw	satp,a4
ffffffffc0206a6c:	043c                	addi	a5,sp,520
ffffffffc0206a6e:	ec3e                	sd	a5,24(sp)
ffffffffc0206a70:	023c                	addi	a5,sp,264
ffffffffc0206a72:	e83e                	sd	a5,16(sp)
ffffffffc0206a74:	e4ce                	sd	s3,72(sp)
ffffffffc0206a76:	4785                	li	a5,1
ffffffffc0206a78:	79c2                	ld	s3,48(sp)
ffffffffc0206a7a:	01f79a93          	slli	s5,a5,0x1f
ffffffffc0206a7e:	00cb5793          	srli	a5,s6,0xc
ffffffffc0206a82:	e43e                	sd	a5,8(sp)
ffffffffc0206a84:	e0e2                	sd	s8,64(sp)
ffffffffc0206a86:	fc26                	sd	s1,56(sp)
ffffffffc0206a88:	e8a2                	sd	s0,80(sp)
ffffffffc0206a8a:	67c2                	ld	a5,16(sp)
ffffffffc0206a8c:	6380                	ld	s0,0(a5)
ffffffffc0206a8e:	8522                	mv	a0,s0
ffffffffc0206a90:	345040ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc0206a94:	0015049b          	addiw	s1,a0,1
ffffffffc0206a98:	409a8ab3          	sub	s5,s5,s1
ffffffffc0206a9c:	8b56                	mv	s6,s5
ffffffffc0206a9e:	06905063          	blez	s1,ffffffffc0206afe <do_execve+0x5ce>
ffffffffc0206aa2:	01893503          	ld	a0,24(s2)
ffffffffc0206aa6:	4601                	li	a2,0
ffffffffc0206aa8:	85da                	mv	a1,s6
ffffffffc0206aaa:	a69fb0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0206aae:	3c050263          	beqz	a0,ffffffffc0206e72 <do_execve+0x942>
ffffffffc0206ab2:	000cb603          	ld	a2,0(s9)
ffffffffc0206ab6:	67a2                	ld	a5,8(sp)
ffffffffc0206ab8:	000db703          	ld	a4,0(s11)
ffffffffc0206abc:	8d11                	sub	a0,a0,a2
ffffffffc0206abe:	8519                	srai	a0,a0,0x6
ffffffffc0206ac0:	954e                	add	a0,a0,s3
ffffffffc0206ac2:	00f57633          	and	a2,a0,a5
ffffffffc0206ac6:	0532                	slli	a0,a0,0xc
ffffffffc0206ac8:	38e67863          	bgeu	a2,a4,ffffffffc0206e58 <do_execve+0x928>
ffffffffc0206acc:	6785                	lui	a5,0x1
ffffffffc0206ace:	fff78713          	addi	a4,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206ad2:	00eb7733          	and	a4,s6,a4
ffffffffc0206ad6:	40e785b3          	sub	a1,a5,a4
ffffffffc0206ada:	8c26                	mv	s8,s1
ffffffffc0206adc:	0095f363          	bgeu	a1,s1,ffffffffc0206ae2 <do_execve+0x5b2>
ffffffffc0206ae0:	8c2e                	mv	s8,a1
ffffffffc0206ae2:	000bb803          	ld	a6,0(s7)
ffffffffc0206ae6:	85a2                	mv	a1,s0
ffffffffc0206ae8:	8662                	mv	a2,s8
ffffffffc0206aea:	9742                	add	a4,a4,a6
ffffffffc0206aec:	953a                	add	a0,a0,a4
ffffffffc0206aee:	418484bb          	subw	s1,s1,s8
ffffffffc0206af2:	3d7040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0206af6:	9b62                	add	s6,s6,s8
ffffffffc0206af8:	9462                	add	s0,s0,s8
ffffffffc0206afa:	fa9044e3          	bgtz	s1,ffffffffc0206aa2 <do_execve+0x572>
ffffffffc0206afe:	6762                	ld	a4,24(sp)
ffffffffc0206b00:	66c2                	ld	a3,16(sp)
ffffffffc0206b02:	001d079b          	addiw	a5,s10,1
ffffffffc0206b06:	01573023          	sd	s5,0(a4) # ffffffffc0200000 <kern_entry>
ffffffffc0206b0a:	0721                	addi	a4,a4,8
ffffffffc0206b0c:	ec3a                	sd	a4,24(sp)
ffffffffc0206b0e:	7762                	ld	a4,56(sp)
ffffffffc0206b10:	06a1                	addi	a3,a3,8
ffffffffc0206b12:	e836                	sd	a3,16(sp)
ffffffffc0206b14:	1aed5063          	bge	s10,a4,ffffffffc0206cb4 <do_execve+0x784>
ffffffffc0206b18:	8d3e                	mv	s10,a5
ffffffffc0206b1a:	bf85                	j	ffffffffc0206a8a <do_execve+0x55a>
ffffffffc0206b1c:	0026e693          	ori	a3,a3,2
ffffffffc0206b20:	dc0793e3          	bnez	a5,ffffffffc02068e6 <do_execve+0x3b6>
ffffffffc0206b24:	47dd                	li	a5,23
ffffffffc0206b26:	e4be                	sd	a5,72(sp)
ffffffffc0206b28:	b3f9                	j	ffffffffc02068f6 <do_execve+0x3c6>
ffffffffc0206b2a:	59f5                	li	s3,-3
ffffffffc0206b2c:	b141                	j	ffffffffc02067ac <do_execve+0x27c>
ffffffffc0206b2e:	6922                	ld	s2,8(sp)
ffffffffc0206b30:	79a6                	ld	s3,104(sp)
ffffffffc0206b32:	6446                	ld	s0,80(sp)
ffffffffc0206b34:	854a                	mv	a0,s2
ffffffffc0206b36:	b1afd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc0206b3a:	01893503          	ld	a0,24(s2)
ffffffffc0206b3e:	eb9fe0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0206b42:	854a                	mv	a0,s2
ffffffffc0206b44:	970fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0206b48:	2e0d1063          	bnez	s10,ffffffffc0206e28 <do_execve+0x8f8>
ffffffffc0206b4c:	77a2                	ld	a5,40(sp)
ffffffffc0206b4e:	19a4                	addi	s1,sp,248
ffffffffc0206b50:	147d                	addi	s0,s0,-1
ffffffffc0206b52:	94be                	add	s1,s1,a5
ffffffffc0206b54:	7782                	ld	a5,32(sp)
ffffffffc0206b56:	040e                	slli	s0,s0,0x3
ffffffffc0206b58:	02079713          	slli	a4,a5,0x20
ffffffffc0206b5c:	01d75793          	srli	a5,a4,0x1d
ffffffffc0206b60:	0238                	addi	a4,sp,264
ffffffffc0206b62:	943a                	add	s0,s0,a4
ffffffffc0206b64:	8c9d                	sub	s1,s1,a5
ffffffffc0206b66:	6008                	ld	a0,0(s0)
ffffffffc0206b68:	1461                	addi	s0,s0,-8
ffffffffc0206b6a:	cd4fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206b6e:	fe941ce3          	bne	s0,s1,ffffffffc0206b66 <do_execve+0x636>
ffffffffc0206b72:	000a3403          	ld	s0,0(s4)
ffffffffc0206b76:	4641                	li	a2,16
ffffffffc0206b78:	4581                	li	a1,0
ffffffffc0206b7a:	0b440413          	addi	s0,s0,180
ffffffffc0206b7e:	8522                	mv	a0,s0
ffffffffc0206b80:	2f7040ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0206b84:	463d                	li	a2,15
ffffffffc0206b86:	010c                	addi	a1,sp,128
ffffffffc0206b88:	8522                	mv	a0,s0
ffffffffc0206b8a:	33f040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0206b8e:	b939                	j	ffffffffc02067ac <do_execve+0x27c>
ffffffffc0206b90:	740a                	ld	s0,160(sp)
ffffffffc0206b92:	7ae2                	ld	s5,56(sp)
ffffffffc0206b94:	fc26                	sd	s1,56(sp)
ffffffffc0206b96:	84ca                	mv	s1,s2
ffffffffc0206b98:	76ea                	ld	a3,184(sp)
ffffffffc0206b9a:	9436                	add	s0,s0,a3
ffffffffc0206b9c:	069c7f63          	bgeu	s8,s1,ffffffffc0206c1a <do_execve+0x6ea>
ffffffffc0206ba0:	e1840be3          	beq	s0,s8,ffffffffc02069b6 <do_execve+0x486>
ffffffffc0206ba4:	6785                	lui	a5,0x1
ffffffffc0206ba6:	00fc0533          	add	a0,s8,a5
ffffffffc0206baa:	8d05                	sub	a0,a0,s1
ffffffffc0206bac:	41840933          	sub	s2,s0,s8
ffffffffc0206bb0:	00946463          	bltu	s0,s1,ffffffffc0206bb8 <do_execve+0x688>
ffffffffc0206bb4:	41848933          	sub	s2,s1,s8
ffffffffc0206bb8:	77e2                	ld	a5,56(sp)
ffffffffc0206bba:	000cb683          	ld	a3,0(s9)
ffffffffc0206bbe:	000db603          	ld	a2,0(s11)
ffffffffc0206bc2:	40d786b3          	sub	a3,a5,a3
ffffffffc0206bc6:	77c2                	ld	a5,48(sp)
ffffffffc0206bc8:	8699                	srai	a3,a3,0x6
ffffffffc0206bca:	96be                	add	a3,a3,a5
ffffffffc0206bcc:	67e2                	ld	a5,24(sp)
ffffffffc0206bce:	00f6f5b3          	and	a1,a3,a5
ffffffffc0206bd2:	06b2                	slli	a3,a3,0xc
ffffffffc0206bd4:	22c5f163          	bgeu	a1,a2,ffffffffc0206df6 <do_execve+0x8c6>
ffffffffc0206bd8:	000bb803          	ld	a6,0(s7)
ffffffffc0206bdc:	864a                	mv	a2,s2
ffffffffc0206bde:	4581                	li	a1,0
ffffffffc0206be0:	96c2                	add	a3,a3,a6
ffffffffc0206be2:	9536                	add	a0,a0,a3
ffffffffc0206be4:	293040ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0206be8:	018907b3          	add	a5,s2,s8
ffffffffc0206bec:	02947463          	bgeu	s0,s1,ffffffffc0206c14 <do_execve+0x6e4>
ffffffffc0206bf0:	dcf403e3          	beq	s0,a5,ffffffffc02069b6 <do_execve+0x486>
ffffffffc0206bf4:	00007697          	auipc	a3,0x7
ffffffffc0206bf8:	c8c68693          	addi	a3,a3,-884 # ffffffffc020d880 <CSWTCH.79+0x328>
ffffffffc0206bfc:	00005617          	auipc	a2,0x5
ffffffffc0206c00:	f5c60613          	addi	a2,a2,-164 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206c04:	32e00593          	li	a1,814
ffffffffc0206c08:	00007517          	auipc	a0,0x7
ffffffffc0206c0c:	a6050513          	addi	a0,a0,-1440 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206c10:	88ff90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206c14:	fe9790e3          	bne	a5,s1,ffffffffc0206bf4 <do_execve+0x6c4>
ffffffffc0206c18:	8c26                	mv	s8,s1
ffffffffc0206c1a:	d88c7ee3          	bgeu	s8,s0,ffffffffc02069b6 <do_execve+0x486>
ffffffffc0206c1e:	6922                	ld	s2,8(sp)
ffffffffc0206c20:	6b26                	ld	s6,72(sp)
ffffffffc0206c22:	79c2                	ld	s3,48(sp)
ffffffffc0206c24:	e856                	sd	s5,16(sp)
ffffffffc0206c26:	a099                	j	ffffffffc0206c6c <do_execve+0x73c>
ffffffffc0206c28:	6785                	lui	a5,0x1
ffffffffc0206c2a:	409c0533          	sub	a0,s8,s1
ffffffffc0206c2e:	94be                	add	s1,s1,a5
ffffffffc0206c30:	41848633          	sub	a2,s1,s8
ffffffffc0206c34:	00947463          	bgeu	s0,s1,ffffffffc0206c3c <do_execve+0x70c>
ffffffffc0206c38:	41840633          	sub	a2,s0,s8
ffffffffc0206c3c:	000cb783          	ld	a5,0(s9)
ffffffffc0206c40:	6762                	ld	a4,24(sp)
ffffffffc0206c42:	000db683          	ld	a3,0(s11)
ffffffffc0206c46:	40fa87b3          	sub	a5,s5,a5
ffffffffc0206c4a:	8799                	srai	a5,a5,0x6
ffffffffc0206c4c:	97ce                	add	a5,a5,s3
ffffffffc0206c4e:	00e7f5b3          	and	a1,a5,a4
ffffffffc0206c52:	07b2                	slli	a5,a5,0xc
ffffffffc0206c54:	1ad5fd63          	bgeu	a1,a3,ffffffffc0206e0e <do_execve+0x8de>
ffffffffc0206c58:	000bb683          	ld	a3,0(s7)
ffffffffc0206c5c:	9c32                	add	s8,s8,a2
ffffffffc0206c5e:	4581                	li	a1,0
ffffffffc0206c60:	97b6                	add	a5,a5,a3
ffffffffc0206c62:	953e                	add	a0,a0,a5
ffffffffc0206c64:	213040ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0206c68:	008c7d63          	bgeu	s8,s0,ffffffffc0206c82 <do_execve+0x752>
ffffffffc0206c6c:	01893503          	ld	a0,24(s2)
ffffffffc0206c70:	865a                	mv	a2,s6
ffffffffc0206c72:	85a6                	mv	a1,s1
ffffffffc0206c74:	e0dfc0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc0206c78:	8aaa                	mv	s5,a0
ffffffffc0206c7a:	f55d                	bnez	a0,ffffffffc0206c28 <do_execve+0x6f8>
ffffffffc0206c7c:	79a6                	ld	s3,104(sp)
ffffffffc0206c7e:	6446                	ld	s0,80(sp)
ffffffffc0206c80:	bd55                	j	ffffffffc0206b34 <do_execve+0x604>
ffffffffc0206c82:	fc56                	sd	s5,56(sp)
ffffffffc0206c84:	6ac2                	ld	s5,16(sp)
ffffffffc0206c86:	bb05                	j	ffffffffc02069b6 <do_execve+0x486>
ffffffffc0206c88:	59f5                	li	s3,-3
ffffffffc0206c8a:	b00b1be3          	bnez	s6,ffffffffc02067a0 <do_execve+0x270>
ffffffffc0206c8e:	be39                	j	ffffffffc02067ac <do_execve+0x27c>
ffffffffc0206c90:	e80b0de3          	beqz	s6,ffffffffc0206b2a <do_execve+0x5fa>
ffffffffc0206c94:	038b0513          	addi	a0,s6,56
ffffffffc0206c98:	827fd0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0206c9c:	59f5                	li	s3,-3
ffffffffc0206c9e:	040b2823          	sw	zero,80(s6)
ffffffffc0206ca2:	b629                	j	ffffffffc02067ac <do_execve+0x27c>
ffffffffc0206ca4:	8462                	mv	s0,s8
ffffffffc0206ca6:	84ca                	mv	s1,s2
ffffffffc0206ca8:	5d71                	li	s10,-4
ffffffffc0206caa:	b5fd                	j	ffffffffc0206b98 <do_execve+0x668>
ffffffffc0206cac:	6922                	ld	s2,8(sp)
ffffffffc0206cae:	6446                	ld	s0,80(sp)
ffffffffc0206cb0:	5d61                	li	s10,-8
ffffffffc0206cb2:	beed                	j	ffffffffc02068ac <do_execve+0x37c>
ffffffffc0206cb4:	74e2                	ld	s1,56(sp)
ffffffffc0206cb6:	6c06                	ld	s8,64(sp)
ffffffffc0206cb8:	69a6                	ld	s3,72(sp)
ffffffffc0206cba:	0024871b          	addiw	a4,s1,2
ffffffffc0206cbe:	0037171b          	slliw	a4,a4,0x3
ffffffffc0206cc2:	6446                	ld	s0,80(sp)
ffffffffc0206cc4:	003c1793          	slli	a5,s8,0x3
ffffffffc0206cc8:	02071693          	slli	a3,a4,0x20
ffffffffc0206ccc:	0e10                	addi	a2,sp,784
ffffffffc0206cce:	ff8af493          	andi	s1,s5,-8
ffffffffc0206cd2:	97b2                	add	a5,a5,a2
ffffffffc0206cd4:	9281                	srli	a3,a3,0x20
ffffffffc0206cd6:	7d42                	ld	s10,48(sp)
ffffffffc0206cd8:	40d48833          	sub	a6,s1,a3
ffffffffc0206cdc:	ee07bc23          	sd	zero,-264(a5) # ef8 <_binary_bin_swap_img_size-0x6e08>
ffffffffc0206ce0:	20810a93          	addi	s5,sp,520
ffffffffc0206ce4:	5b7d                	li	s6,-1
ffffffffc0206ce6:	6785                	lui	a5,0x1
ffffffffc0206ce8:	e84e                	sd	s3,16(sp)
ffffffffc0206cea:	ec22                	sd	s0,24(sp)
ffffffffc0206cec:	e442                	sd	a6,8(sp)
ffffffffc0206cee:	0007049b          	sext.w	s1,a4
ffffffffc0206cf2:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0206cf6:	fff78c13          	addi	s8,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206cfa:	89d6                	mv	s3,s5
ffffffffc0206cfc:	8442                	mv	s0,a6
ffffffffc0206cfe:	01893503          	ld	a0,24(s2)
ffffffffc0206d02:	4601                	li	a2,0
ffffffffc0206d04:	85a2                	mv	a1,s0
ffffffffc0206d06:	80dfb0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0206d0a:	c549                	beqz	a0,ffffffffc0206d94 <do_execve+0x864>
ffffffffc0206d0c:	000cb783          	ld	a5,0(s9)
ffffffffc0206d10:	000db603          	ld	a2,0(s11)
ffffffffc0206d14:	40f507b3          	sub	a5,a0,a5
ffffffffc0206d18:	8799                	srai	a5,a5,0x6
ffffffffc0206d1a:	97ea                	add	a5,a5,s10
ffffffffc0206d1c:	0167f5b3          	and	a1,a5,s6
ffffffffc0206d20:	00c79513          	slli	a0,a5,0xc
ffffffffc0206d24:	12c5fa63          	bgeu	a1,a2,ffffffffc0206e58 <do_execve+0x928>
ffffffffc0206d28:	018477b3          	and	a5,s0,s8
ffffffffc0206d2c:	6705                	lui	a4,0x1
ffffffffc0206d2e:	40f70633          	sub	a2,a4,a5
ffffffffc0206d32:	8aa6                	mv	s5,s1
ffffffffc0206d34:	00967363          	bgeu	a2,s1,ffffffffc0206d3a <do_execve+0x80a>
ffffffffc0206d38:	8ab2                	mv	s5,a2
ffffffffc0206d3a:	000bb703          	ld	a4,0(s7)
ffffffffc0206d3e:	85ce                	mv	a1,s3
ffffffffc0206d40:	8656                	mv	a2,s5
ffffffffc0206d42:	97ba                	add	a5,a5,a4
ffffffffc0206d44:	953e                	add	a0,a0,a5
ffffffffc0206d46:	415484bb          	subw	s1,s1,s5
ffffffffc0206d4a:	17f040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0206d4e:	9456                	add	s0,s0,s5
ffffffffc0206d50:	99d6                	add	s3,s3,s5
ffffffffc0206d52:	fa9046e3          	bgtz	s1,ffffffffc0206cfe <do_execve+0x7ce>
ffffffffc0206d56:	000a3783          	ld	a5,0(s4)
ffffffffc0206d5a:	12000613          	li	a2,288
ffffffffc0206d5e:	4581                	li	a1,0
ffffffffc0206d60:	0a07b903          	ld	s2,160(a5)
ffffffffc0206d64:	6462                	ld	s0,24(sp)
ffffffffc0206d66:	69c2                	ld	s3,16(sp)
ffffffffc0206d68:	854a                	mv	a0,s2
ffffffffc0206d6a:	10d040ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0206d6e:	778e                	ld	a5,224(sp)
ffffffffc0206d70:	6722                	ld	a4,8(sp)
ffffffffc0206d72:	04893823          	sd	s0,80(s2)
ffffffffc0206d76:	10f93423          	sd	a5,264(s2)
ffffffffc0206d7a:	00e93823          	sd	a4,16(s2)
ffffffffc0206d7e:	04e93c23          	sd	a4,88(s2)
ffffffffc0206d82:	100027f3          	csrr	a5,sstatus
ffffffffc0206d86:	eff7f793          	andi	a5,a5,-257
ffffffffc0206d8a:	0207e793          	ori	a5,a5,32
ffffffffc0206d8e:	10f93023          	sd	a5,256(s2)
ffffffffc0206d92:	bb6d                	j	ffffffffc0206b4c <do_execve+0x61c>
ffffffffc0206d94:	00007697          	auipc	a3,0x7
ffffffffc0206d98:	c4c68693          	addi	a3,a3,-948 # ffffffffc020d9e0 <CSWTCH.79+0x488>
ffffffffc0206d9c:	00005617          	auipc	a2,0x5
ffffffffc0206da0:	dbc60613          	addi	a2,a2,-580 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206da4:	37000593          	li	a1,880
ffffffffc0206da8:	00007517          	auipc	a0,0x7
ffffffffc0206dac:	8c050513          	addi	a0,a0,-1856 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206db0:	eeef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206db4:	00007697          	auipc	a3,0x7
ffffffffc0206db8:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020d950 <CSWTCH.79+0x3f8>
ffffffffc0206dbc:	00005617          	auipc	a2,0x5
ffffffffc0206dc0:	d9c60613          	addi	a2,a2,-612 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206dc4:	34400593          	li	a1,836
ffffffffc0206dc8:	00007517          	auipc	a0,0x7
ffffffffc0206dcc:	8a050513          	addi	a0,a0,-1888 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206dd0:	ecef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206dd4:	00007697          	auipc	a3,0x7
ffffffffc0206dd8:	b3468693          	addi	a3,a3,-1228 # ffffffffc020d908 <CSWTCH.79+0x3b0>
ffffffffc0206ddc:	00005617          	auipc	a2,0x5
ffffffffc0206de0:	d7c60613          	addi	a2,a2,-644 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206de4:	34300593          	li	a1,835
ffffffffc0206de8:	00007517          	auipc	a0,0x7
ffffffffc0206dec:	88050513          	addi	a0,a0,-1920 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206df0:	eaef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206df4:	86a2                	mv	a3,s0
ffffffffc0206df6:	00006617          	auipc	a2,0x6
ffffffffc0206dfa:	88260613          	addi	a2,a2,-1918 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0206dfe:	07100593          	li	a1,113
ffffffffc0206e02:	00006517          	auipc	a0,0x6
ffffffffc0206e06:	89e50513          	addi	a0,a0,-1890 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0206e0a:	e94f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e0e:	86be                	mv	a3,a5
ffffffffc0206e10:	00006617          	auipc	a2,0x6
ffffffffc0206e14:	86860613          	addi	a2,a2,-1944 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0206e18:	07100593          	li	a1,113
ffffffffc0206e1c:	00006517          	auipc	a0,0x6
ffffffffc0206e20:	88450513          	addi	a0,a0,-1916 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0206e24:	e7af90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e28:	89ea                	mv	s3,s10
ffffffffc0206e2a:	b8c1                	j	ffffffffc02066fa <do_execve+0x1ca>
ffffffffc0206e2c:	00007697          	auipc	a3,0x7
ffffffffc0206e30:	a9468693          	addi	a3,a3,-1388 # ffffffffc020d8c0 <CSWTCH.79+0x368>
ffffffffc0206e34:	00005617          	auipc	a2,0x5
ffffffffc0206e38:	d2460613          	addi	a2,a2,-732 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206e3c:	34200593          	li	a1,834
ffffffffc0206e40:	00007517          	auipc	a0,0x7
ffffffffc0206e44:	82850513          	addi	a0,a0,-2008 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206e48:	e56f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e4c:	89aa                	mv	s3,a0
ffffffffc0206e4e:	8adff06f          	j	ffffffffc02066fa <do_execve+0x1ca>
ffffffffc0206e52:	89aa                	mv	s3,a0
ffffffffc0206e54:	8a7ff06f          	j	ffffffffc02066fa <do_execve+0x1ca>
ffffffffc0206e58:	86aa                	mv	a3,a0
ffffffffc0206e5a:	00006617          	auipc	a2,0x6
ffffffffc0206e5e:	81e60613          	addi	a2,a2,-2018 # ffffffffc020c678 <default_pmm_manager+0x38>
ffffffffc0206e62:	07100593          	li	a1,113
ffffffffc0206e66:	00006517          	auipc	a0,0x6
ffffffffc0206e6a:	83a50513          	addi	a0,a0,-1990 # ffffffffc020c6a0 <default_pmm_manager+0x60>
ffffffffc0206e6e:	e30f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e72:	00007697          	auipc	a3,0x7
ffffffffc0206e76:	b6e68693          	addi	a3,a3,-1170 # ffffffffc020d9e0 <CSWTCH.79+0x488>
ffffffffc0206e7a:	00005617          	auipc	a2,0x5
ffffffffc0206e7e:	cde60613          	addi	a2,a2,-802 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206e82:	35800593          	li	a1,856
ffffffffc0206e86:	00006517          	auipc	a0,0x6
ffffffffc0206e8a:	7e250513          	addi	a0,a0,2018 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206e8e:	e10f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e92:	00006617          	auipc	a2,0x6
ffffffffc0206e96:	88e60613          	addi	a2,a2,-1906 # ffffffffc020c720 <default_pmm_manager+0xe0>
ffffffffc0206e9a:	34a00593          	li	a1,842
ffffffffc0206e9e:	00006517          	auipc	a0,0x6
ffffffffc0206ea2:	7ca50513          	addi	a0,a0,1994 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206ea6:	df8f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206eaa:	00007697          	auipc	a3,0x7
ffffffffc0206eae:	aee68693          	addi	a3,a3,-1298 # ffffffffc020d998 <CSWTCH.79+0x440>
ffffffffc0206eb2:	00005617          	auipc	a2,0x5
ffffffffc0206eb6:	ca660613          	addi	a2,a2,-858 # ffffffffc020bb58 <commands+0x210>
ffffffffc0206eba:	34500593          	li	a1,837
ffffffffc0206ebe:	00006517          	auipc	a0,0x6
ffffffffc0206ec2:	7aa50513          	addi	a0,a0,1962 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206ec6:	dd8f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206eca <user_main>:
ffffffffc0206eca:	7179                	addi	sp,sp,-48
ffffffffc0206ecc:	e84a                	sd	s2,16(sp)
ffffffffc0206ece:	00090917          	auipc	s2,0x90
ffffffffc0206ed2:	9f290913          	addi	s2,s2,-1550 # ffffffffc02968c0 <current>
ffffffffc0206ed6:	00093783          	ld	a5,0(s2)
ffffffffc0206eda:	00007617          	auipc	a2,0x7
ffffffffc0206ede:	b1660613          	addi	a2,a2,-1258 # ffffffffc020d9f0 <CSWTCH.79+0x498>
ffffffffc0206ee2:	00007517          	auipc	a0,0x7
ffffffffc0206ee6:	b1650513          	addi	a0,a0,-1258 # ffffffffc020d9f8 <CSWTCH.79+0x4a0>
ffffffffc0206eea:	43cc                	lw	a1,4(a5)
ffffffffc0206eec:	f406                	sd	ra,40(sp)
ffffffffc0206eee:	f022                	sd	s0,32(sp)
ffffffffc0206ef0:	ec26                	sd	s1,24(sp)
ffffffffc0206ef2:	e032                	sd	a2,0(sp)
ffffffffc0206ef4:	e402                	sd	zero,8(sp)
ffffffffc0206ef6:	ab0f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206efa:	6782                	ld	a5,0(sp)
ffffffffc0206efc:	cfb9                	beqz	a5,ffffffffc0206f5a <user_main+0x90>
ffffffffc0206efe:	003c                	addi	a5,sp,8
ffffffffc0206f00:	4401                	li	s0,0
ffffffffc0206f02:	6398                	ld	a4,0(a5)
ffffffffc0206f04:	0405                	addi	s0,s0,1
ffffffffc0206f06:	07a1                	addi	a5,a5,8
ffffffffc0206f08:	ff6d                	bnez	a4,ffffffffc0206f02 <user_main+0x38>
ffffffffc0206f0a:	00093783          	ld	a5,0(s2)
ffffffffc0206f0e:	12000613          	li	a2,288
ffffffffc0206f12:	6b84                	ld	s1,16(a5)
ffffffffc0206f14:	73cc                	ld	a1,160(a5)
ffffffffc0206f16:	6789                	lui	a5,0x2
ffffffffc0206f18:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206f1c:	94be                	add	s1,s1,a5
ffffffffc0206f1e:	8526                	mv	a0,s1
ffffffffc0206f20:	7a8040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0206f24:	00093783          	ld	a5,0(s2)
ffffffffc0206f28:	860a                	mv	a2,sp
ffffffffc0206f2a:	0004059b          	sext.w	a1,s0
ffffffffc0206f2e:	f3c4                	sd	s1,160(a5)
ffffffffc0206f30:	00007517          	auipc	a0,0x7
ffffffffc0206f34:	ac050513          	addi	a0,a0,-1344 # ffffffffc020d9f0 <CSWTCH.79+0x498>
ffffffffc0206f38:	df8ff0ef          	jal	ra,ffffffffc0206530 <do_execve>
ffffffffc0206f3c:	8126                	mv	sp,s1
ffffffffc0206f3e:	b12fa06f          	j	ffffffffc0201250 <__trapret>
ffffffffc0206f42:	00007617          	auipc	a2,0x7
ffffffffc0206f46:	ade60613          	addi	a2,a2,-1314 # ffffffffc020da20 <CSWTCH.79+0x4c8>
ffffffffc0206f4a:	4a100593          	li	a1,1185
ffffffffc0206f4e:	00006517          	auipc	a0,0x6
ffffffffc0206f52:	71a50513          	addi	a0,a0,1818 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0206f56:	d48f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206f5a:	4401                	li	s0,0
ffffffffc0206f5c:	b77d                	j	ffffffffc0206f0a <user_main+0x40>

ffffffffc0206f5e <do_yield>:
ffffffffc0206f5e:	00090797          	auipc	a5,0x90
ffffffffc0206f62:	9627b783          	ld	a5,-1694(a5) # ffffffffc02968c0 <current>
ffffffffc0206f66:	4705                	li	a4,1
ffffffffc0206f68:	ef98                	sd	a4,24(a5)
ffffffffc0206f6a:	4501                	li	a0,0
ffffffffc0206f6c:	8082                	ret

ffffffffc0206f6e <do_wait>:
ffffffffc0206f6e:	1101                	addi	sp,sp,-32
ffffffffc0206f70:	e822                	sd	s0,16(sp)
ffffffffc0206f72:	e426                	sd	s1,8(sp)
ffffffffc0206f74:	ec06                	sd	ra,24(sp)
ffffffffc0206f76:	842e                	mv	s0,a1
ffffffffc0206f78:	84aa                	mv	s1,a0
ffffffffc0206f7a:	c999                	beqz	a1,ffffffffc0206f90 <do_wait+0x22>
ffffffffc0206f7c:	00090797          	auipc	a5,0x90
ffffffffc0206f80:	9447b783          	ld	a5,-1724(a5) # ffffffffc02968c0 <current>
ffffffffc0206f84:	7788                	ld	a0,40(a5)
ffffffffc0206f86:	4685                	li	a3,1
ffffffffc0206f88:	4611                	li	a2,4
ffffffffc0206f8a:	a66fd0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0206f8e:	c909                	beqz	a0,ffffffffc0206fa0 <do_wait+0x32>
ffffffffc0206f90:	85a2                	mv	a1,s0
ffffffffc0206f92:	6442                	ld	s0,16(sp)
ffffffffc0206f94:	60e2                	ld	ra,24(sp)
ffffffffc0206f96:	8526                	mv	a0,s1
ffffffffc0206f98:	64a2                	ld	s1,8(sp)
ffffffffc0206f9a:	6105                	addi	sp,sp,32
ffffffffc0206f9c:	a86ff06f          	j	ffffffffc0206222 <do_wait.part.0>
ffffffffc0206fa0:	60e2                	ld	ra,24(sp)
ffffffffc0206fa2:	6442                	ld	s0,16(sp)
ffffffffc0206fa4:	64a2                	ld	s1,8(sp)
ffffffffc0206fa6:	5575                	li	a0,-3
ffffffffc0206fa8:	6105                	addi	sp,sp,32
ffffffffc0206faa:	8082                	ret

ffffffffc0206fac <do_kill>:
ffffffffc0206fac:	1141                	addi	sp,sp,-16
ffffffffc0206fae:	6789                	lui	a5,0x2
ffffffffc0206fb0:	e406                	sd	ra,8(sp)
ffffffffc0206fb2:	e022                	sd	s0,0(sp)
ffffffffc0206fb4:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206fb8:	17f9                	addi	a5,a5,-2
ffffffffc0206fba:	02e7e963          	bltu	a5,a4,ffffffffc0206fec <do_kill+0x40>
ffffffffc0206fbe:	842a                	mv	s0,a0
ffffffffc0206fc0:	45a9                	li	a1,10
ffffffffc0206fc2:	2501                	sext.w	a0,a0
ffffffffc0206fc4:	17e040ef          	jal	ra,ffffffffc020b142 <hash32>
ffffffffc0206fc8:	02051793          	slli	a5,a0,0x20
ffffffffc0206fcc:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206fd0:	0008a797          	auipc	a5,0x8a
ffffffffc0206fd4:	7f078793          	addi	a5,a5,2032 # ffffffffc02917c0 <hash_list>
ffffffffc0206fd8:	953e                	add	a0,a0,a5
ffffffffc0206fda:	87aa                	mv	a5,a0
ffffffffc0206fdc:	a029                	j	ffffffffc0206fe6 <do_kill+0x3a>
ffffffffc0206fde:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206fe2:	00870b63          	beq	a4,s0,ffffffffc0206ff8 <do_kill+0x4c>
ffffffffc0206fe6:	679c                	ld	a5,8(a5)
ffffffffc0206fe8:	fef51be3          	bne	a0,a5,ffffffffc0206fde <do_kill+0x32>
ffffffffc0206fec:	5475                	li	s0,-3
ffffffffc0206fee:	60a2                	ld	ra,8(sp)
ffffffffc0206ff0:	8522                	mv	a0,s0
ffffffffc0206ff2:	6402                	ld	s0,0(sp)
ffffffffc0206ff4:	0141                	addi	sp,sp,16
ffffffffc0206ff6:	8082                	ret
ffffffffc0206ff8:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206ffc:	00177693          	andi	a3,a4,1
ffffffffc0207000:	e295                	bnez	a3,ffffffffc0207024 <do_kill+0x78>
ffffffffc0207002:	4bd4                	lw	a3,20(a5)
ffffffffc0207004:	00176713          	ori	a4,a4,1
ffffffffc0207008:	fce7ac23          	sw	a4,-40(a5)
ffffffffc020700c:	4401                	li	s0,0
ffffffffc020700e:	fe06d0e3          	bgez	a3,ffffffffc0206fee <do_kill+0x42>
ffffffffc0207012:	f2878513          	addi	a0,a5,-216
ffffffffc0207016:	45a000ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc020701a:	60a2                	ld	ra,8(sp)
ffffffffc020701c:	8522                	mv	a0,s0
ffffffffc020701e:	6402                	ld	s0,0(sp)
ffffffffc0207020:	0141                	addi	sp,sp,16
ffffffffc0207022:	8082                	ret
ffffffffc0207024:	545d                	li	s0,-9
ffffffffc0207026:	b7e1                	j	ffffffffc0206fee <do_kill+0x42>

ffffffffc0207028 <proc_init>:
ffffffffc0207028:	1101                	addi	sp,sp,-32
ffffffffc020702a:	e426                	sd	s1,8(sp)
ffffffffc020702c:	0008e797          	auipc	a5,0x8e
ffffffffc0207030:	79478793          	addi	a5,a5,1940 # ffffffffc02957c0 <proc_list>
ffffffffc0207034:	ec06                	sd	ra,24(sp)
ffffffffc0207036:	e822                	sd	s0,16(sp)
ffffffffc0207038:	e04a                	sd	s2,0(sp)
ffffffffc020703a:	0008a497          	auipc	s1,0x8a
ffffffffc020703e:	78648493          	addi	s1,s1,1926 # ffffffffc02917c0 <hash_list>
ffffffffc0207042:	e79c                	sd	a5,8(a5)
ffffffffc0207044:	e39c                	sd	a5,0(a5)
ffffffffc0207046:	0008e717          	auipc	a4,0x8e
ffffffffc020704a:	77a70713          	addi	a4,a4,1914 # ffffffffc02957c0 <proc_list>
ffffffffc020704e:	87a6                	mv	a5,s1
ffffffffc0207050:	e79c                	sd	a5,8(a5)
ffffffffc0207052:	e39c                	sd	a5,0(a5)
ffffffffc0207054:	07c1                	addi	a5,a5,16
ffffffffc0207056:	fef71de3          	bne	a4,a5,ffffffffc0207050 <proc_init+0x28>
ffffffffc020705a:	8d9fe0ef          	jal	ra,ffffffffc0205932 <alloc_proc>
ffffffffc020705e:	00090917          	auipc	s2,0x90
ffffffffc0207062:	86a90913          	addi	s2,s2,-1942 # ffffffffc02968c8 <idleproc>
ffffffffc0207066:	00a93023          	sd	a0,0(s2)
ffffffffc020706a:	842a                	mv	s0,a0
ffffffffc020706c:	12050863          	beqz	a0,ffffffffc020719c <proc_init+0x174>
ffffffffc0207070:	4789                	li	a5,2
ffffffffc0207072:	e11c                	sd	a5,0(a0)
ffffffffc0207074:	0000a797          	auipc	a5,0xa
ffffffffc0207078:	f8c78793          	addi	a5,a5,-116 # ffffffffc0211000 <bootstack>
ffffffffc020707c:	e91c                	sd	a5,16(a0)
ffffffffc020707e:	4785                	li	a5,1
ffffffffc0207080:	ed1c                	sd	a5,24(a0)
ffffffffc0207082:	8aafe0ef          	jal	ra,ffffffffc020512c <files_create>
ffffffffc0207086:	14a43423          	sd	a0,328(s0)
ffffffffc020708a:	0e050d63          	beqz	a0,ffffffffc0207184 <proc_init+0x15c>
ffffffffc020708e:	00093403          	ld	s0,0(s2)
ffffffffc0207092:	4641                	li	a2,16
ffffffffc0207094:	4581                	li	a1,0
ffffffffc0207096:	14843703          	ld	a4,328(s0)
ffffffffc020709a:	0b440413          	addi	s0,s0,180
ffffffffc020709e:	8522                	mv	a0,s0
ffffffffc02070a0:	4b1c                	lw	a5,16(a4)
ffffffffc02070a2:	2785                	addiw	a5,a5,1
ffffffffc02070a4:	cb1c                	sw	a5,16(a4)
ffffffffc02070a6:	5d0040ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc02070aa:	463d                	li	a2,15
ffffffffc02070ac:	00007597          	auipc	a1,0x7
ffffffffc02070b0:	9d458593          	addi	a1,a1,-1580 # ffffffffc020da80 <CSWTCH.79+0x528>
ffffffffc02070b4:	8522                	mv	a0,s0
ffffffffc02070b6:	612040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc02070ba:	00090717          	auipc	a4,0x90
ffffffffc02070be:	81e70713          	addi	a4,a4,-2018 # ffffffffc02968d8 <nr_process>
ffffffffc02070c2:	431c                	lw	a5,0(a4)
ffffffffc02070c4:	00093683          	ld	a3,0(s2)
ffffffffc02070c8:	4601                	li	a2,0
ffffffffc02070ca:	2785                	addiw	a5,a5,1
ffffffffc02070cc:	4581                	li	a1,0
ffffffffc02070ce:	fffff517          	auipc	a0,0xfffff
ffffffffc02070d2:	31250513          	addi	a0,a0,786 # ffffffffc02063e0 <init_main>
ffffffffc02070d6:	c31c                	sw	a5,0(a4)
ffffffffc02070d8:	0008f797          	auipc	a5,0x8f
ffffffffc02070dc:	7ed7b423          	sd	a3,2024(a5) # ffffffffc02968c0 <current>
ffffffffc02070e0:	f91fe0ef          	jal	ra,ffffffffc0206070 <kernel_thread>
ffffffffc02070e4:	842a                	mv	s0,a0
ffffffffc02070e6:	08a05363          	blez	a0,ffffffffc020716c <proc_init+0x144>
ffffffffc02070ea:	6789                	lui	a5,0x2
ffffffffc02070ec:	fff5071b          	addiw	a4,a0,-1
ffffffffc02070f0:	17f9                	addi	a5,a5,-2
ffffffffc02070f2:	2501                	sext.w	a0,a0
ffffffffc02070f4:	02e7e363          	bltu	a5,a4,ffffffffc020711a <proc_init+0xf2>
ffffffffc02070f8:	45a9                	li	a1,10
ffffffffc02070fa:	048040ef          	jal	ra,ffffffffc020b142 <hash32>
ffffffffc02070fe:	02051793          	slli	a5,a0,0x20
ffffffffc0207102:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0207106:	96a6                	add	a3,a3,s1
ffffffffc0207108:	87b6                	mv	a5,a3
ffffffffc020710a:	a029                	j	ffffffffc0207114 <proc_init+0xec>
ffffffffc020710c:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0207110:	04870b63          	beq	a4,s0,ffffffffc0207166 <proc_init+0x13e>
ffffffffc0207114:	679c                	ld	a5,8(a5)
ffffffffc0207116:	fef69be3          	bne	a3,a5,ffffffffc020710c <proc_init+0xe4>
ffffffffc020711a:	4781                	li	a5,0
ffffffffc020711c:	0b478493          	addi	s1,a5,180
ffffffffc0207120:	4641                	li	a2,16
ffffffffc0207122:	4581                	li	a1,0
ffffffffc0207124:	0008f417          	auipc	s0,0x8f
ffffffffc0207128:	7ac40413          	addi	s0,s0,1964 # ffffffffc02968d0 <initproc>
ffffffffc020712c:	8526                	mv	a0,s1
ffffffffc020712e:	e01c                	sd	a5,0(s0)
ffffffffc0207130:	546040ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc0207134:	463d                	li	a2,15
ffffffffc0207136:	00007597          	auipc	a1,0x7
ffffffffc020713a:	97258593          	addi	a1,a1,-1678 # ffffffffc020daa8 <CSWTCH.79+0x550>
ffffffffc020713e:	8526                	mv	a0,s1
ffffffffc0207140:	588040ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc0207144:	00093783          	ld	a5,0(s2)
ffffffffc0207148:	c7d1                	beqz	a5,ffffffffc02071d4 <proc_init+0x1ac>
ffffffffc020714a:	43dc                	lw	a5,4(a5)
ffffffffc020714c:	e7c1                	bnez	a5,ffffffffc02071d4 <proc_init+0x1ac>
ffffffffc020714e:	601c                	ld	a5,0(s0)
ffffffffc0207150:	c3b5                	beqz	a5,ffffffffc02071b4 <proc_init+0x18c>
ffffffffc0207152:	43d8                	lw	a4,4(a5)
ffffffffc0207154:	4785                	li	a5,1
ffffffffc0207156:	04f71f63          	bne	a4,a5,ffffffffc02071b4 <proc_init+0x18c>
ffffffffc020715a:	60e2                	ld	ra,24(sp)
ffffffffc020715c:	6442                	ld	s0,16(sp)
ffffffffc020715e:	64a2                	ld	s1,8(sp)
ffffffffc0207160:	6902                	ld	s2,0(sp)
ffffffffc0207162:	6105                	addi	sp,sp,32
ffffffffc0207164:	8082                	ret
ffffffffc0207166:	f2878793          	addi	a5,a5,-216
ffffffffc020716a:	bf4d                	j	ffffffffc020711c <proc_init+0xf4>
ffffffffc020716c:	00007617          	auipc	a2,0x7
ffffffffc0207170:	91c60613          	addi	a2,a2,-1764 # ffffffffc020da88 <CSWTCH.79+0x530>
ffffffffc0207174:	4ed00593          	li	a1,1261
ffffffffc0207178:	00006517          	auipc	a0,0x6
ffffffffc020717c:	4f050513          	addi	a0,a0,1264 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0207180:	b1ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207184:	00007617          	auipc	a2,0x7
ffffffffc0207188:	8d460613          	addi	a2,a2,-1836 # ffffffffc020da58 <CSWTCH.79+0x500>
ffffffffc020718c:	4e100593          	li	a1,1249
ffffffffc0207190:	00006517          	auipc	a0,0x6
ffffffffc0207194:	4d850513          	addi	a0,a0,1240 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc0207198:	b06f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020719c:	00007617          	auipc	a2,0x7
ffffffffc02071a0:	8a460613          	addi	a2,a2,-1884 # ffffffffc020da40 <CSWTCH.79+0x4e8>
ffffffffc02071a4:	4d700593          	li	a1,1239
ffffffffc02071a8:	00006517          	auipc	a0,0x6
ffffffffc02071ac:	4c050513          	addi	a0,a0,1216 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02071b0:	aeef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02071b4:	00007697          	auipc	a3,0x7
ffffffffc02071b8:	92468693          	addi	a3,a3,-1756 # ffffffffc020dad8 <CSWTCH.79+0x580>
ffffffffc02071bc:	00005617          	auipc	a2,0x5
ffffffffc02071c0:	99c60613          	addi	a2,a2,-1636 # ffffffffc020bb58 <commands+0x210>
ffffffffc02071c4:	4f400593          	li	a1,1268
ffffffffc02071c8:	00006517          	auipc	a0,0x6
ffffffffc02071cc:	4a050513          	addi	a0,a0,1184 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02071d0:	acef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02071d4:	00007697          	auipc	a3,0x7
ffffffffc02071d8:	8dc68693          	addi	a3,a3,-1828 # ffffffffc020dab0 <CSWTCH.79+0x558>
ffffffffc02071dc:	00005617          	auipc	a2,0x5
ffffffffc02071e0:	97c60613          	addi	a2,a2,-1668 # ffffffffc020bb58 <commands+0x210>
ffffffffc02071e4:	4f300593          	li	a1,1267
ffffffffc02071e8:	00006517          	auipc	a0,0x6
ffffffffc02071ec:	48050513          	addi	a0,a0,1152 # ffffffffc020d668 <CSWTCH.79+0x110>
ffffffffc02071f0:	aaef90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02071f4 <cpu_idle>:
ffffffffc02071f4:	1141                	addi	sp,sp,-16
ffffffffc02071f6:	e022                	sd	s0,0(sp)
ffffffffc02071f8:	e406                	sd	ra,8(sp)
ffffffffc02071fa:	0008f417          	auipc	s0,0x8f
ffffffffc02071fe:	6c640413          	addi	s0,s0,1734 # ffffffffc02968c0 <current>
ffffffffc0207202:	6018                	ld	a4,0(s0)
ffffffffc0207204:	6f1c                	ld	a5,24(a4)
ffffffffc0207206:	dffd                	beqz	a5,ffffffffc0207204 <cpu_idle+0x10>
ffffffffc0207208:	31a000ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc020720c:	bfdd                	j	ffffffffc0207202 <cpu_idle+0xe>

ffffffffc020720e <lab6_set_priority>:
ffffffffc020720e:	1141                	addi	sp,sp,-16
ffffffffc0207210:	e022                	sd	s0,0(sp)
ffffffffc0207212:	85aa                	mv	a1,a0
ffffffffc0207214:	842a                	mv	s0,a0
ffffffffc0207216:	00007517          	auipc	a0,0x7
ffffffffc020721a:	8ea50513          	addi	a0,a0,-1814 # ffffffffc020db00 <CSWTCH.79+0x5a8>
ffffffffc020721e:	e406                	sd	ra,8(sp)
ffffffffc0207220:	f87f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207224:	0008f797          	auipc	a5,0x8f
ffffffffc0207228:	69c7b783          	ld	a5,1692(a5) # ffffffffc02968c0 <current>
ffffffffc020722c:	e801                	bnez	s0,ffffffffc020723c <lab6_set_priority+0x2e>
ffffffffc020722e:	60a2                	ld	ra,8(sp)
ffffffffc0207230:	6402                	ld	s0,0(sp)
ffffffffc0207232:	4705                	li	a4,1
ffffffffc0207234:	14e7a223          	sw	a4,324(a5)
ffffffffc0207238:	0141                	addi	sp,sp,16
ffffffffc020723a:	8082                	ret
ffffffffc020723c:	60a2                	ld	ra,8(sp)
ffffffffc020723e:	1487a223          	sw	s0,324(a5)
ffffffffc0207242:	6402                	ld	s0,0(sp)
ffffffffc0207244:	0141                	addi	sp,sp,16
ffffffffc0207246:	8082                	ret

ffffffffc0207248 <do_sleep>:
ffffffffc0207248:	c539                	beqz	a0,ffffffffc0207296 <do_sleep+0x4e>
ffffffffc020724a:	7179                	addi	sp,sp,-48
ffffffffc020724c:	f022                	sd	s0,32(sp)
ffffffffc020724e:	f406                	sd	ra,40(sp)
ffffffffc0207250:	842a                	mv	s0,a0
ffffffffc0207252:	100027f3          	csrr	a5,sstatus
ffffffffc0207256:	8b89                	andi	a5,a5,2
ffffffffc0207258:	e3a9                	bnez	a5,ffffffffc020729a <do_sleep+0x52>
ffffffffc020725a:	0008f797          	auipc	a5,0x8f
ffffffffc020725e:	6667b783          	ld	a5,1638(a5) # ffffffffc02968c0 <current>
ffffffffc0207262:	0818                	addi	a4,sp,16
ffffffffc0207264:	c02a                	sw	a0,0(sp)
ffffffffc0207266:	ec3a                	sd	a4,24(sp)
ffffffffc0207268:	e83a                	sd	a4,16(sp)
ffffffffc020726a:	e43e                	sd	a5,8(sp)
ffffffffc020726c:	4705                	li	a4,1
ffffffffc020726e:	c398                	sw	a4,0(a5)
ffffffffc0207270:	80000737          	lui	a4,0x80000
ffffffffc0207274:	840a                	mv	s0,sp
ffffffffc0207276:	0709                	addi	a4,a4,2
ffffffffc0207278:	0ee7a623          	sw	a4,236(a5)
ffffffffc020727c:	8522                	mv	a0,s0
ffffffffc020727e:	364000ef          	jal	ra,ffffffffc02075e2 <add_timer>
ffffffffc0207282:	2a0000ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc0207286:	8522                	mv	a0,s0
ffffffffc0207288:	422000ef          	jal	ra,ffffffffc02076aa <del_timer>
ffffffffc020728c:	70a2                	ld	ra,40(sp)
ffffffffc020728e:	7402                	ld	s0,32(sp)
ffffffffc0207290:	4501                	li	a0,0
ffffffffc0207292:	6145                	addi	sp,sp,48
ffffffffc0207294:	8082                	ret
ffffffffc0207296:	4501                	li	a0,0
ffffffffc0207298:	8082                	ret
ffffffffc020729a:	9d9f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020729e:	0008f797          	auipc	a5,0x8f
ffffffffc02072a2:	6227b783          	ld	a5,1570(a5) # ffffffffc02968c0 <current>
ffffffffc02072a6:	0818                	addi	a4,sp,16
ffffffffc02072a8:	c022                	sw	s0,0(sp)
ffffffffc02072aa:	e43e                	sd	a5,8(sp)
ffffffffc02072ac:	ec3a                	sd	a4,24(sp)
ffffffffc02072ae:	e83a                	sd	a4,16(sp)
ffffffffc02072b0:	4705                	li	a4,1
ffffffffc02072b2:	c398                	sw	a4,0(a5)
ffffffffc02072b4:	80000737          	lui	a4,0x80000
ffffffffc02072b8:	0709                	addi	a4,a4,2
ffffffffc02072ba:	840a                	mv	s0,sp
ffffffffc02072bc:	8522                	mv	a0,s0
ffffffffc02072be:	0ee7a623          	sw	a4,236(a5)
ffffffffc02072c2:	320000ef          	jal	ra,ffffffffc02075e2 <add_timer>
ffffffffc02072c6:	9a7f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02072ca:	bf65                	j	ffffffffc0207282 <do_sleep+0x3a>

ffffffffc02072cc <switch_to>:
ffffffffc02072cc:	00153023          	sd	ra,0(a0)
ffffffffc02072d0:	00253423          	sd	sp,8(a0)
ffffffffc02072d4:	e900                	sd	s0,16(a0)
ffffffffc02072d6:	ed04                	sd	s1,24(a0)
ffffffffc02072d8:	03253023          	sd	s2,32(a0)
ffffffffc02072dc:	03353423          	sd	s3,40(a0)
ffffffffc02072e0:	03453823          	sd	s4,48(a0)
ffffffffc02072e4:	03553c23          	sd	s5,56(a0)
ffffffffc02072e8:	05653023          	sd	s6,64(a0)
ffffffffc02072ec:	05753423          	sd	s7,72(a0)
ffffffffc02072f0:	05853823          	sd	s8,80(a0)
ffffffffc02072f4:	05953c23          	sd	s9,88(a0)
ffffffffc02072f8:	07a53023          	sd	s10,96(a0)
ffffffffc02072fc:	07b53423          	sd	s11,104(a0)
ffffffffc0207300:	0005b083          	ld	ra,0(a1)
ffffffffc0207304:	0085b103          	ld	sp,8(a1)
ffffffffc0207308:	6980                	ld	s0,16(a1)
ffffffffc020730a:	6d84                	ld	s1,24(a1)
ffffffffc020730c:	0205b903          	ld	s2,32(a1)
ffffffffc0207310:	0285b983          	ld	s3,40(a1)
ffffffffc0207314:	0305ba03          	ld	s4,48(a1)
ffffffffc0207318:	0385ba83          	ld	s5,56(a1)
ffffffffc020731c:	0405bb03          	ld	s6,64(a1)
ffffffffc0207320:	0485bb83          	ld	s7,72(a1)
ffffffffc0207324:	0505bc03          	ld	s8,80(a1)
ffffffffc0207328:	0585bc83          	ld	s9,88(a1)
ffffffffc020732c:	0605bd03          	ld	s10,96(a1)
ffffffffc0207330:	0685bd83          	ld	s11,104(a1)
ffffffffc0207334:	8082                	ret

ffffffffc0207336 <RR_init>:
ffffffffc0207336:	e508                	sd	a0,8(a0)
ffffffffc0207338:	e108                	sd	a0,0(a0)
ffffffffc020733a:	00052823          	sw	zero,16(a0)
ffffffffc020733e:	8082                	ret

ffffffffc0207340 <RR_pick_next>:
ffffffffc0207340:	651c                	ld	a5,8(a0)
ffffffffc0207342:	00f50563          	beq	a0,a5,ffffffffc020734c <RR_pick_next+0xc>
ffffffffc0207346:	ef078513          	addi	a0,a5,-272
ffffffffc020734a:	8082                	ret
ffffffffc020734c:	4501                	li	a0,0
ffffffffc020734e:	8082                	ret

ffffffffc0207350 <RR_proc_tick>:
ffffffffc0207350:	1205a783          	lw	a5,288(a1)
ffffffffc0207354:	00f05563          	blez	a5,ffffffffc020735e <RR_proc_tick+0xe>
ffffffffc0207358:	37fd                	addiw	a5,a5,-1
ffffffffc020735a:	12f5a023          	sw	a5,288(a1)
ffffffffc020735e:	e399                	bnez	a5,ffffffffc0207364 <RR_proc_tick+0x14>
ffffffffc0207360:	4785                	li	a5,1
ffffffffc0207362:	ed9c                	sd	a5,24(a1)
ffffffffc0207364:	8082                	ret

ffffffffc0207366 <RR_dequeue>:
ffffffffc0207366:	1185b703          	ld	a4,280(a1)
ffffffffc020736a:	11058793          	addi	a5,a1,272
ffffffffc020736e:	02e78363          	beq	a5,a4,ffffffffc0207394 <RR_dequeue+0x2e>
ffffffffc0207372:	1085b683          	ld	a3,264(a1)
ffffffffc0207376:	00a69f63          	bne	a3,a0,ffffffffc0207394 <RR_dequeue+0x2e>
ffffffffc020737a:	1105b503          	ld	a0,272(a1)
ffffffffc020737e:	4a90                	lw	a2,16(a3)
ffffffffc0207380:	e518                	sd	a4,8(a0)
ffffffffc0207382:	e308                	sd	a0,0(a4)
ffffffffc0207384:	10f5bc23          	sd	a5,280(a1)
ffffffffc0207388:	10f5b823          	sd	a5,272(a1)
ffffffffc020738c:	fff6079b          	addiw	a5,a2,-1
ffffffffc0207390:	ca9c                	sw	a5,16(a3)
ffffffffc0207392:	8082                	ret
ffffffffc0207394:	1141                	addi	sp,sp,-16
ffffffffc0207396:	00006697          	auipc	a3,0x6
ffffffffc020739a:	78268693          	addi	a3,a3,1922 # ffffffffc020db18 <CSWTCH.79+0x5c0>
ffffffffc020739e:	00004617          	auipc	a2,0x4
ffffffffc02073a2:	7ba60613          	addi	a2,a2,1978 # ffffffffc020bb58 <commands+0x210>
ffffffffc02073a6:	03c00593          	li	a1,60
ffffffffc02073aa:	00006517          	auipc	a0,0x6
ffffffffc02073ae:	7a650513          	addi	a0,a0,1958 # ffffffffc020db50 <CSWTCH.79+0x5f8>
ffffffffc02073b2:	e406                	sd	ra,8(sp)
ffffffffc02073b4:	8eaf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02073b8 <RR_enqueue>:
ffffffffc02073b8:	1185b703          	ld	a4,280(a1)
ffffffffc02073bc:	11058793          	addi	a5,a1,272
ffffffffc02073c0:	02e79d63          	bne	a5,a4,ffffffffc02073fa <RR_enqueue+0x42>
ffffffffc02073c4:	6118                	ld	a4,0(a0)
ffffffffc02073c6:	1205a683          	lw	a3,288(a1)
ffffffffc02073ca:	e11c                	sd	a5,0(a0)
ffffffffc02073cc:	e71c                	sd	a5,8(a4)
ffffffffc02073ce:	10a5bc23          	sd	a0,280(a1)
ffffffffc02073d2:	10e5b823          	sd	a4,272(a1)
ffffffffc02073d6:	495c                	lw	a5,20(a0)
ffffffffc02073d8:	ea89                	bnez	a3,ffffffffc02073ea <RR_enqueue+0x32>
ffffffffc02073da:	12f5a023          	sw	a5,288(a1)
ffffffffc02073de:	491c                	lw	a5,16(a0)
ffffffffc02073e0:	10a5b423          	sd	a0,264(a1)
ffffffffc02073e4:	2785                	addiw	a5,a5,1
ffffffffc02073e6:	c91c                	sw	a5,16(a0)
ffffffffc02073e8:	8082                	ret
ffffffffc02073ea:	fed7c8e3          	blt	a5,a3,ffffffffc02073da <RR_enqueue+0x22>
ffffffffc02073ee:	491c                	lw	a5,16(a0)
ffffffffc02073f0:	10a5b423          	sd	a0,264(a1)
ffffffffc02073f4:	2785                	addiw	a5,a5,1
ffffffffc02073f6:	c91c                	sw	a5,16(a0)
ffffffffc02073f8:	8082                	ret
ffffffffc02073fa:	1141                	addi	sp,sp,-16
ffffffffc02073fc:	00006697          	auipc	a3,0x6
ffffffffc0207400:	77468693          	addi	a3,a3,1908 # ffffffffc020db70 <CSWTCH.79+0x618>
ffffffffc0207404:	00004617          	auipc	a2,0x4
ffffffffc0207408:	75460613          	addi	a2,a2,1876 # ffffffffc020bb58 <commands+0x210>
ffffffffc020740c:	02800593          	li	a1,40
ffffffffc0207410:	00006517          	auipc	a0,0x6
ffffffffc0207414:	74050513          	addi	a0,a0,1856 # ffffffffc020db50 <CSWTCH.79+0x5f8>
ffffffffc0207418:	e406                	sd	ra,8(sp)
ffffffffc020741a:	884f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020741e <sched_init>:
ffffffffc020741e:	1141                	addi	sp,sp,-16
ffffffffc0207420:	0008a717          	auipc	a4,0x8a
ffffffffc0207424:	c0070713          	addi	a4,a4,-1024 # ffffffffc0291020 <default_sched_class>
ffffffffc0207428:	e022                	sd	s0,0(sp)
ffffffffc020742a:	e406                	sd	ra,8(sp)
ffffffffc020742c:	0008e797          	auipc	a5,0x8e
ffffffffc0207430:	3c478793          	addi	a5,a5,964 # ffffffffc02957f0 <timer_list>
ffffffffc0207434:	6714                	ld	a3,8(a4)
ffffffffc0207436:	0008e517          	auipc	a0,0x8e
ffffffffc020743a:	39a50513          	addi	a0,a0,922 # ffffffffc02957d0 <__rq>
ffffffffc020743e:	e79c                	sd	a5,8(a5)
ffffffffc0207440:	e39c                	sd	a5,0(a5)
ffffffffc0207442:	4795                	li	a5,5
ffffffffc0207444:	c95c                	sw	a5,20(a0)
ffffffffc0207446:	0008f417          	auipc	s0,0x8f
ffffffffc020744a:	4a240413          	addi	s0,s0,1186 # ffffffffc02968e8 <sched_class>
ffffffffc020744e:	0008f797          	auipc	a5,0x8f
ffffffffc0207452:	48a7b923          	sd	a0,1170(a5) # ffffffffc02968e0 <rq>
ffffffffc0207456:	e018                	sd	a4,0(s0)
ffffffffc0207458:	9682                	jalr	a3
ffffffffc020745a:	601c                	ld	a5,0(s0)
ffffffffc020745c:	6402                	ld	s0,0(sp)
ffffffffc020745e:	60a2                	ld	ra,8(sp)
ffffffffc0207460:	638c                	ld	a1,0(a5)
ffffffffc0207462:	00006517          	auipc	a0,0x6
ffffffffc0207466:	73e50513          	addi	a0,a0,1854 # ffffffffc020dba0 <CSWTCH.79+0x648>
ffffffffc020746a:	0141                	addi	sp,sp,16
ffffffffc020746c:	d3bf806f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0207470 <wakeup_proc>:
ffffffffc0207470:	4118                	lw	a4,0(a0)
ffffffffc0207472:	1101                	addi	sp,sp,-32
ffffffffc0207474:	ec06                	sd	ra,24(sp)
ffffffffc0207476:	e822                	sd	s0,16(sp)
ffffffffc0207478:	e426                	sd	s1,8(sp)
ffffffffc020747a:	478d                	li	a5,3
ffffffffc020747c:	08f70363          	beq	a4,a5,ffffffffc0207502 <wakeup_proc+0x92>
ffffffffc0207480:	842a                	mv	s0,a0
ffffffffc0207482:	100027f3          	csrr	a5,sstatus
ffffffffc0207486:	8b89                	andi	a5,a5,2
ffffffffc0207488:	4481                	li	s1,0
ffffffffc020748a:	e7bd                	bnez	a5,ffffffffc02074f8 <wakeup_proc+0x88>
ffffffffc020748c:	4789                	li	a5,2
ffffffffc020748e:	04f70863          	beq	a4,a5,ffffffffc02074de <wakeup_proc+0x6e>
ffffffffc0207492:	c01c                	sw	a5,0(s0)
ffffffffc0207494:	0e042623          	sw	zero,236(s0)
ffffffffc0207498:	0008f797          	auipc	a5,0x8f
ffffffffc020749c:	4287b783          	ld	a5,1064(a5) # ffffffffc02968c0 <current>
ffffffffc02074a0:	02878363          	beq	a5,s0,ffffffffc02074c6 <wakeup_proc+0x56>
ffffffffc02074a4:	0008f797          	auipc	a5,0x8f
ffffffffc02074a8:	4247b783          	ld	a5,1060(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02074ac:	00f40d63          	beq	s0,a5,ffffffffc02074c6 <wakeup_proc+0x56>
ffffffffc02074b0:	0008f797          	auipc	a5,0x8f
ffffffffc02074b4:	4387b783          	ld	a5,1080(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02074b8:	6b9c                	ld	a5,16(a5)
ffffffffc02074ba:	85a2                	mv	a1,s0
ffffffffc02074bc:	0008f517          	auipc	a0,0x8f
ffffffffc02074c0:	42453503          	ld	a0,1060(a0) # ffffffffc02968e0 <rq>
ffffffffc02074c4:	9782                	jalr	a5
ffffffffc02074c6:	e491                	bnez	s1,ffffffffc02074d2 <wakeup_proc+0x62>
ffffffffc02074c8:	60e2                	ld	ra,24(sp)
ffffffffc02074ca:	6442                	ld	s0,16(sp)
ffffffffc02074cc:	64a2                	ld	s1,8(sp)
ffffffffc02074ce:	6105                	addi	sp,sp,32
ffffffffc02074d0:	8082                	ret
ffffffffc02074d2:	6442                	ld	s0,16(sp)
ffffffffc02074d4:	60e2                	ld	ra,24(sp)
ffffffffc02074d6:	64a2                	ld	s1,8(sp)
ffffffffc02074d8:	6105                	addi	sp,sp,32
ffffffffc02074da:	f92f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02074de:	00006617          	auipc	a2,0x6
ffffffffc02074e2:	71260613          	addi	a2,a2,1810 # ffffffffc020dbf0 <CSWTCH.79+0x698>
ffffffffc02074e6:	05200593          	li	a1,82
ffffffffc02074ea:	00006517          	auipc	a0,0x6
ffffffffc02074ee:	6ee50513          	addi	a0,a0,1774 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc02074f2:	814f90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02074f6:	bfc1                	j	ffffffffc02074c6 <wakeup_proc+0x56>
ffffffffc02074f8:	f7af90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02074fc:	4018                	lw	a4,0(s0)
ffffffffc02074fe:	4485                	li	s1,1
ffffffffc0207500:	b771                	j	ffffffffc020748c <wakeup_proc+0x1c>
ffffffffc0207502:	00006697          	auipc	a3,0x6
ffffffffc0207506:	6b668693          	addi	a3,a3,1718 # ffffffffc020dbb8 <CSWTCH.79+0x660>
ffffffffc020750a:	00004617          	auipc	a2,0x4
ffffffffc020750e:	64e60613          	addi	a2,a2,1614 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207512:	04300593          	li	a1,67
ffffffffc0207516:	00006517          	auipc	a0,0x6
ffffffffc020751a:	6c250513          	addi	a0,a0,1730 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc020751e:	f81f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207522 <schedule>:
ffffffffc0207522:	7179                	addi	sp,sp,-48
ffffffffc0207524:	f406                	sd	ra,40(sp)
ffffffffc0207526:	f022                	sd	s0,32(sp)
ffffffffc0207528:	ec26                	sd	s1,24(sp)
ffffffffc020752a:	e84a                	sd	s2,16(sp)
ffffffffc020752c:	e44e                	sd	s3,8(sp)
ffffffffc020752e:	e052                	sd	s4,0(sp)
ffffffffc0207530:	100027f3          	csrr	a5,sstatus
ffffffffc0207534:	8b89                	andi	a5,a5,2
ffffffffc0207536:	4a01                	li	s4,0
ffffffffc0207538:	e3cd                	bnez	a5,ffffffffc02075da <schedule+0xb8>
ffffffffc020753a:	0008f497          	auipc	s1,0x8f
ffffffffc020753e:	38648493          	addi	s1,s1,902 # ffffffffc02968c0 <current>
ffffffffc0207542:	608c                	ld	a1,0(s1)
ffffffffc0207544:	0008f997          	auipc	s3,0x8f
ffffffffc0207548:	3a498993          	addi	s3,s3,932 # ffffffffc02968e8 <sched_class>
ffffffffc020754c:	0008f917          	auipc	s2,0x8f
ffffffffc0207550:	39490913          	addi	s2,s2,916 # ffffffffc02968e0 <rq>
ffffffffc0207554:	4194                	lw	a3,0(a1)
ffffffffc0207556:	0005bc23          	sd	zero,24(a1)
ffffffffc020755a:	4709                	li	a4,2
ffffffffc020755c:	0009b783          	ld	a5,0(s3)
ffffffffc0207560:	00093503          	ld	a0,0(s2)
ffffffffc0207564:	04e68e63          	beq	a3,a4,ffffffffc02075c0 <schedule+0x9e>
ffffffffc0207568:	739c                	ld	a5,32(a5)
ffffffffc020756a:	9782                	jalr	a5
ffffffffc020756c:	842a                	mv	s0,a0
ffffffffc020756e:	c521                	beqz	a0,ffffffffc02075b6 <schedule+0x94>
ffffffffc0207570:	0009b783          	ld	a5,0(s3)
ffffffffc0207574:	00093503          	ld	a0,0(s2)
ffffffffc0207578:	85a2                	mv	a1,s0
ffffffffc020757a:	6f9c                	ld	a5,24(a5)
ffffffffc020757c:	9782                	jalr	a5
ffffffffc020757e:	441c                	lw	a5,8(s0)
ffffffffc0207580:	6098                	ld	a4,0(s1)
ffffffffc0207582:	2785                	addiw	a5,a5,1
ffffffffc0207584:	c41c                	sw	a5,8(s0)
ffffffffc0207586:	00870563          	beq	a4,s0,ffffffffc0207590 <schedule+0x6e>
ffffffffc020758a:	8522                	mv	a0,s0
ffffffffc020758c:	cccfe0ef          	jal	ra,ffffffffc0205a58 <proc_run>
ffffffffc0207590:	000a1a63          	bnez	s4,ffffffffc02075a4 <schedule+0x82>
ffffffffc0207594:	70a2                	ld	ra,40(sp)
ffffffffc0207596:	7402                	ld	s0,32(sp)
ffffffffc0207598:	64e2                	ld	s1,24(sp)
ffffffffc020759a:	6942                	ld	s2,16(sp)
ffffffffc020759c:	69a2                	ld	s3,8(sp)
ffffffffc020759e:	6a02                	ld	s4,0(sp)
ffffffffc02075a0:	6145                	addi	sp,sp,48
ffffffffc02075a2:	8082                	ret
ffffffffc02075a4:	7402                	ld	s0,32(sp)
ffffffffc02075a6:	70a2                	ld	ra,40(sp)
ffffffffc02075a8:	64e2                	ld	s1,24(sp)
ffffffffc02075aa:	6942                	ld	s2,16(sp)
ffffffffc02075ac:	69a2                	ld	s3,8(sp)
ffffffffc02075ae:	6a02                	ld	s4,0(sp)
ffffffffc02075b0:	6145                	addi	sp,sp,48
ffffffffc02075b2:	ebaf906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02075b6:	0008f417          	auipc	s0,0x8f
ffffffffc02075ba:	31243403          	ld	s0,786(s0) # ffffffffc02968c8 <idleproc>
ffffffffc02075be:	b7c1                	j	ffffffffc020757e <schedule+0x5c>
ffffffffc02075c0:	0008f717          	auipc	a4,0x8f
ffffffffc02075c4:	30873703          	ld	a4,776(a4) # ffffffffc02968c8 <idleproc>
ffffffffc02075c8:	fae580e3          	beq	a1,a4,ffffffffc0207568 <schedule+0x46>
ffffffffc02075cc:	6b9c                	ld	a5,16(a5)
ffffffffc02075ce:	9782                	jalr	a5
ffffffffc02075d0:	0009b783          	ld	a5,0(s3)
ffffffffc02075d4:	00093503          	ld	a0,0(s2)
ffffffffc02075d8:	bf41                	j	ffffffffc0207568 <schedule+0x46>
ffffffffc02075da:	e98f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02075de:	4a05                	li	s4,1
ffffffffc02075e0:	bfa9                	j	ffffffffc020753a <schedule+0x18>

ffffffffc02075e2 <add_timer>:
ffffffffc02075e2:	1141                	addi	sp,sp,-16
ffffffffc02075e4:	e022                	sd	s0,0(sp)
ffffffffc02075e6:	e406                	sd	ra,8(sp)
ffffffffc02075e8:	842a                	mv	s0,a0
ffffffffc02075ea:	100027f3          	csrr	a5,sstatus
ffffffffc02075ee:	8b89                	andi	a5,a5,2
ffffffffc02075f0:	4501                	li	a0,0
ffffffffc02075f2:	eba5                	bnez	a5,ffffffffc0207662 <add_timer+0x80>
ffffffffc02075f4:	401c                	lw	a5,0(s0)
ffffffffc02075f6:	cbb5                	beqz	a5,ffffffffc020766a <add_timer+0x88>
ffffffffc02075f8:	6418                	ld	a4,8(s0)
ffffffffc02075fa:	cb25                	beqz	a4,ffffffffc020766a <add_timer+0x88>
ffffffffc02075fc:	6c18                	ld	a4,24(s0)
ffffffffc02075fe:	01040593          	addi	a1,s0,16
ffffffffc0207602:	08e59463          	bne	a1,a4,ffffffffc020768a <add_timer+0xa8>
ffffffffc0207606:	0008e617          	auipc	a2,0x8e
ffffffffc020760a:	1ea60613          	addi	a2,a2,490 # ffffffffc02957f0 <timer_list>
ffffffffc020760e:	6618                	ld	a4,8(a2)
ffffffffc0207610:	00c71863          	bne	a4,a2,ffffffffc0207620 <add_timer+0x3e>
ffffffffc0207614:	a80d                	j	ffffffffc0207646 <add_timer+0x64>
ffffffffc0207616:	6718                	ld	a4,8(a4)
ffffffffc0207618:	9f95                	subw	a5,a5,a3
ffffffffc020761a:	c01c                	sw	a5,0(s0)
ffffffffc020761c:	02c70563          	beq	a4,a2,ffffffffc0207646 <add_timer+0x64>
ffffffffc0207620:	ff072683          	lw	a3,-16(a4)
ffffffffc0207624:	fed7f9e3          	bgeu	a5,a3,ffffffffc0207616 <add_timer+0x34>
ffffffffc0207628:	40f687bb          	subw	a5,a3,a5
ffffffffc020762c:	fef72823          	sw	a5,-16(a4)
ffffffffc0207630:	631c                	ld	a5,0(a4)
ffffffffc0207632:	e30c                	sd	a1,0(a4)
ffffffffc0207634:	e78c                	sd	a1,8(a5)
ffffffffc0207636:	ec18                	sd	a4,24(s0)
ffffffffc0207638:	e81c                	sd	a5,16(s0)
ffffffffc020763a:	c105                	beqz	a0,ffffffffc020765a <add_timer+0x78>
ffffffffc020763c:	6402                	ld	s0,0(sp)
ffffffffc020763e:	60a2                	ld	ra,8(sp)
ffffffffc0207640:	0141                	addi	sp,sp,16
ffffffffc0207642:	e2af906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207646:	0008e717          	auipc	a4,0x8e
ffffffffc020764a:	1aa70713          	addi	a4,a4,426 # ffffffffc02957f0 <timer_list>
ffffffffc020764e:	631c                	ld	a5,0(a4)
ffffffffc0207650:	e30c                	sd	a1,0(a4)
ffffffffc0207652:	e78c                	sd	a1,8(a5)
ffffffffc0207654:	ec18                	sd	a4,24(s0)
ffffffffc0207656:	e81c                	sd	a5,16(s0)
ffffffffc0207658:	f175                	bnez	a0,ffffffffc020763c <add_timer+0x5a>
ffffffffc020765a:	60a2                	ld	ra,8(sp)
ffffffffc020765c:	6402                	ld	s0,0(sp)
ffffffffc020765e:	0141                	addi	sp,sp,16
ffffffffc0207660:	8082                	ret
ffffffffc0207662:	e10f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207666:	4505                	li	a0,1
ffffffffc0207668:	b771                	j	ffffffffc02075f4 <add_timer+0x12>
ffffffffc020766a:	00006697          	auipc	a3,0x6
ffffffffc020766e:	5a668693          	addi	a3,a3,1446 # ffffffffc020dc10 <CSWTCH.79+0x6b8>
ffffffffc0207672:	00004617          	auipc	a2,0x4
ffffffffc0207676:	4e660613          	addi	a2,a2,1254 # ffffffffc020bb58 <commands+0x210>
ffffffffc020767a:	07a00593          	li	a1,122
ffffffffc020767e:	00006517          	auipc	a0,0x6
ffffffffc0207682:	55a50513          	addi	a0,a0,1370 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc0207686:	e19f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020768a:	00006697          	auipc	a3,0x6
ffffffffc020768e:	5b668693          	addi	a3,a3,1462 # ffffffffc020dc40 <CSWTCH.79+0x6e8>
ffffffffc0207692:	00004617          	auipc	a2,0x4
ffffffffc0207696:	4c660613          	addi	a2,a2,1222 # ffffffffc020bb58 <commands+0x210>
ffffffffc020769a:	07b00593          	li	a1,123
ffffffffc020769e:	00006517          	auipc	a0,0x6
ffffffffc02076a2:	53a50513          	addi	a0,a0,1338 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc02076a6:	df9f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076aa <del_timer>:
ffffffffc02076aa:	1101                	addi	sp,sp,-32
ffffffffc02076ac:	e822                	sd	s0,16(sp)
ffffffffc02076ae:	ec06                	sd	ra,24(sp)
ffffffffc02076b0:	e426                	sd	s1,8(sp)
ffffffffc02076b2:	842a                	mv	s0,a0
ffffffffc02076b4:	100027f3          	csrr	a5,sstatus
ffffffffc02076b8:	8b89                	andi	a5,a5,2
ffffffffc02076ba:	01050493          	addi	s1,a0,16
ffffffffc02076be:	eb9d                	bnez	a5,ffffffffc02076f4 <del_timer+0x4a>
ffffffffc02076c0:	6d1c                	ld	a5,24(a0)
ffffffffc02076c2:	02978463          	beq	a5,s1,ffffffffc02076ea <del_timer+0x40>
ffffffffc02076c6:	4114                	lw	a3,0(a0)
ffffffffc02076c8:	6918                	ld	a4,16(a0)
ffffffffc02076ca:	ce81                	beqz	a3,ffffffffc02076e2 <del_timer+0x38>
ffffffffc02076cc:	0008e617          	auipc	a2,0x8e
ffffffffc02076d0:	12460613          	addi	a2,a2,292 # ffffffffc02957f0 <timer_list>
ffffffffc02076d4:	00c78763          	beq	a5,a2,ffffffffc02076e2 <del_timer+0x38>
ffffffffc02076d8:	ff07a603          	lw	a2,-16(a5)
ffffffffc02076dc:	9eb1                	addw	a3,a3,a2
ffffffffc02076de:	fed7a823          	sw	a3,-16(a5)
ffffffffc02076e2:	e71c                	sd	a5,8(a4)
ffffffffc02076e4:	e398                	sd	a4,0(a5)
ffffffffc02076e6:	ec04                	sd	s1,24(s0)
ffffffffc02076e8:	e804                	sd	s1,16(s0)
ffffffffc02076ea:	60e2                	ld	ra,24(sp)
ffffffffc02076ec:	6442                	ld	s0,16(sp)
ffffffffc02076ee:	64a2                	ld	s1,8(sp)
ffffffffc02076f0:	6105                	addi	sp,sp,32
ffffffffc02076f2:	8082                	ret
ffffffffc02076f4:	d7ef90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02076f8:	6c1c                	ld	a5,24(s0)
ffffffffc02076fa:	02978463          	beq	a5,s1,ffffffffc0207722 <del_timer+0x78>
ffffffffc02076fe:	4014                	lw	a3,0(s0)
ffffffffc0207700:	6818                	ld	a4,16(s0)
ffffffffc0207702:	ce81                	beqz	a3,ffffffffc020771a <del_timer+0x70>
ffffffffc0207704:	0008e617          	auipc	a2,0x8e
ffffffffc0207708:	0ec60613          	addi	a2,a2,236 # ffffffffc02957f0 <timer_list>
ffffffffc020770c:	00c78763          	beq	a5,a2,ffffffffc020771a <del_timer+0x70>
ffffffffc0207710:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207714:	9eb1                	addw	a3,a3,a2
ffffffffc0207716:	fed7a823          	sw	a3,-16(a5)
ffffffffc020771a:	e71c                	sd	a5,8(a4)
ffffffffc020771c:	e398                	sd	a4,0(a5)
ffffffffc020771e:	ec04                	sd	s1,24(s0)
ffffffffc0207720:	e804                	sd	s1,16(s0)
ffffffffc0207722:	6442                	ld	s0,16(sp)
ffffffffc0207724:	60e2                	ld	ra,24(sp)
ffffffffc0207726:	64a2                	ld	s1,8(sp)
ffffffffc0207728:	6105                	addi	sp,sp,32
ffffffffc020772a:	d42f906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc020772e <run_timer_list>:
ffffffffc020772e:	7139                	addi	sp,sp,-64
ffffffffc0207730:	fc06                	sd	ra,56(sp)
ffffffffc0207732:	f822                	sd	s0,48(sp)
ffffffffc0207734:	f426                	sd	s1,40(sp)
ffffffffc0207736:	f04a                	sd	s2,32(sp)
ffffffffc0207738:	ec4e                	sd	s3,24(sp)
ffffffffc020773a:	e852                	sd	s4,16(sp)
ffffffffc020773c:	e456                	sd	s5,8(sp)
ffffffffc020773e:	e05a                	sd	s6,0(sp)
ffffffffc0207740:	100027f3          	csrr	a5,sstatus
ffffffffc0207744:	8b89                	andi	a5,a5,2
ffffffffc0207746:	4b01                	li	s6,0
ffffffffc0207748:	efe9                	bnez	a5,ffffffffc0207822 <run_timer_list+0xf4>
ffffffffc020774a:	0008e997          	auipc	s3,0x8e
ffffffffc020774e:	0a698993          	addi	s3,s3,166 # ffffffffc02957f0 <timer_list>
ffffffffc0207752:	0089b403          	ld	s0,8(s3)
ffffffffc0207756:	07340a63          	beq	s0,s3,ffffffffc02077ca <run_timer_list+0x9c>
ffffffffc020775a:	ff042783          	lw	a5,-16(s0)
ffffffffc020775e:	ff040913          	addi	s2,s0,-16
ffffffffc0207762:	0e078763          	beqz	a5,ffffffffc0207850 <run_timer_list+0x122>
ffffffffc0207766:	fff7871b          	addiw	a4,a5,-1
ffffffffc020776a:	fee42823          	sw	a4,-16(s0)
ffffffffc020776e:	ef31                	bnez	a4,ffffffffc02077ca <run_timer_list+0x9c>
ffffffffc0207770:	00006a97          	auipc	s5,0x6
ffffffffc0207774:	538a8a93          	addi	s5,s5,1336 # ffffffffc020dca8 <CSWTCH.79+0x750>
ffffffffc0207778:	00006a17          	auipc	s4,0x6
ffffffffc020777c:	460a0a13          	addi	s4,s4,1120 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc0207780:	a005                	j	ffffffffc02077a0 <run_timer_list+0x72>
ffffffffc0207782:	0a07d763          	bgez	a5,ffffffffc0207830 <run_timer_list+0x102>
ffffffffc0207786:	8526                	mv	a0,s1
ffffffffc0207788:	ce9ff0ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc020778c:	854a                	mv	a0,s2
ffffffffc020778e:	f1dff0ef          	jal	ra,ffffffffc02076aa <del_timer>
ffffffffc0207792:	03340c63          	beq	s0,s3,ffffffffc02077ca <run_timer_list+0x9c>
ffffffffc0207796:	ff042783          	lw	a5,-16(s0)
ffffffffc020779a:	ff040913          	addi	s2,s0,-16
ffffffffc020779e:	e795                	bnez	a5,ffffffffc02077ca <run_timer_list+0x9c>
ffffffffc02077a0:	00893483          	ld	s1,8(s2)
ffffffffc02077a4:	6400                	ld	s0,8(s0)
ffffffffc02077a6:	0ec4a783          	lw	a5,236(s1)
ffffffffc02077aa:	ffe1                	bnez	a5,ffffffffc0207782 <run_timer_list+0x54>
ffffffffc02077ac:	40d4                	lw	a3,4(s1)
ffffffffc02077ae:	8656                	mv	a2,s5
ffffffffc02077b0:	0ba00593          	li	a1,186
ffffffffc02077b4:	8552                	mv	a0,s4
ffffffffc02077b6:	d51f80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02077ba:	8526                	mv	a0,s1
ffffffffc02077bc:	cb5ff0ef          	jal	ra,ffffffffc0207470 <wakeup_proc>
ffffffffc02077c0:	854a                	mv	a0,s2
ffffffffc02077c2:	ee9ff0ef          	jal	ra,ffffffffc02076aa <del_timer>
ffffffffc02077c6:	fd3418e3          	bne	s0,s3,ffffffffc0207796 <run_timer_list+0x68>
ffffffffc02077ca:	0008f597          	auipc	a1,0x8f
ffffffffc02077ce:	0f65b583          	ld	a1,246(a1) # ffffffffc02968c0 <current>
ffffffffc02077d2:	c18d                	beqz	a1,ffffffffc02077f4 <run_timer_list+0xc6>
ffffffffc02077d4:	0008f797          	auipc	a5,0x8f
ffffffffc02077d8:	0f47b783          	ld	a5,244(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02077dc:	04f58763          	beq	a1,a5,ffffffffc020782a <run_timer_list+0xfc>
ffffffffc02077e0:	0008f797          	auipc	a5,0x8f
ffffffffc02077e4:	1087b783          	ld	a5,264(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02077e8:	779c                	ld	a5,40(a5)
ffffffffc02077ea:	0008f517          	auipc	a0,0x8f
ffffffffc02077ee:	0f653503          	ld	a0,246(a0) # ffffffffc02968e0 <rq>
ffffffffc02077f2:	9782                	jalr	a5
ffffffffc02077f4:	000b1c63          	bnez	s6,ffffffffc020780c <run_timer_list+0xde>
ffffffffc02077f8:	70e2                	ld	ra,56(sp)
ffffffffc02077fa:	7442                	ld	s0,48(sp)
ffffffffc02077fc:	74a2                	ld	s1,40(sp)
ffffffffc02077fe:	7902                	ld	s2,32(sp)
ffffffffc0207800:	69e2                	ld	s3,24(sp)
ffffffffc0207802:	6a42                	ld	s4,16(sp)
ffffffffc0207804:	6aa2                	ld	s5,8(sp)
ffffffffc0207806:	6b02                	ld	s6,0(sp)
ffffffffc0207808:	6121                	addi	sp,sp,64
ffffffffc020780a:	8082                	ret
ffffffffc020780c:	7442                	ld	s0,48(sp)
ffffffffc020780e:	70e2                	ld	ra,56(sp)
ffffffffc0207810:	74a2                	ld	s1,40(sp)
ffffffffc0207812:	7902                	ld	s2,32(sp)
ffffffffc0207814:	69e2                	ld	s3,24(sp)
ffffffffc0207816:	6a42                	ld	s4,16(sp)
ffffffffc0207818:	6aa2                	ld	s5,8(sp)
ffffffffc020781a:	6b02                	ld	s6,0(sp)
ffffffffc020781c:	6121                	addi	sp,sp,64
ffffffffc020781e:	c4ef906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207822:	c50f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207826:	4b05                	li	s6,1
ffffffffc0207828:	b70d                	j	ffffffffc020774a <run_timer_list+0x1c>
ffffffffc020782a:	4785                	li	a5,1
ffffffffc020782c:	ed9c                	sd	a5,24(a1)
ffffffffc020782e:	b7d9                	j	ffffffffc02077f4 <run_timer_list+0xc6>
ffffffffc0207830:	00006697          	auipc	a3,0x6
ffffffffc0207834:	45068693          	addi	a3,a3,1104 # ffffffffc020dc80 <CSWTCH.79+0x728>
ffffffffc0207838:	00004617          	auipc	a2,0x4
ffffffffc020783c:	32060613          	addi	a2,a2,800 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207840:	0b600593          	li	a1,182
ffffffffc0207844:	00006517          	auipc	a0,0x6
ffffffffc0207848:	39450513          	addi	a0,a0,916 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc020784c:	c53f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207850:	00006697          	auipc	a3,0x6
ffffffffc0207854:	41868693          	addi	a3,a3,1048 # ffffffffc020dc68 <CSWTCH.79+0x710>
ffffffffc0207858:	00004617          	auipc	a2,0x4
ffffffffc020785c:	30060613          	addi	a2,a2,768 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207860:	0ae00593          	li	a1,174
ffffffffc0207864:	00006517          	auipc	a0,0x6
ffffffffc0207868:	37450513          	addi	a0,a0,884 # ffffffffc020dbd8 <CSWTCH.79+0x680>
ffffffffc020786c:	c33f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207870 <sys_getpid>:
ffffffffc0207870:	0008f797          	auipc	a5,0x8f
ffffffffc0207874:	0507b783          	ld	a5,80(a5) # ffffffffc02968c0 <current>
ffffffffc0207878:	43c8                	lw	a0,4(a5)
ffffffffc020787a:	8082                	ret

ffffffffc020787c <sys_pgdir>:
ffffffffc020787c:	4501                	li	a0,0
ffffffffc020787e:	8082                	ret

ffffffffc0207880 <sys_gettime>:
ffffffffc0207880:	0008f797          	auipc	a5,0x8f
ffffffffc0207884:	ff07b783          	ld	a5,-16(a5) # ffffffffc0296870 <ticks>
ffffffffc0207888:	0027951b          	slliw	a0,a5,0x2
ffffffffc020788c:	9d3d                	addw	a0,a0,a5
ffffffffc020788e:	0015151b          	slliw	a0,a0,0x1
ffffffffc0207892:	8082                	ret

ffffffffc0207894 <sys_lab6_set_priority>:
ffffffffc0207894:	4108                	lw	a0,0(a0)
ffffffffc0207896:	1141                	addi	sp,sp,-16
ffffffffc0207898:	e406                	sd	ra,8(sp)
ffffffffc020789a:	975ff0ef          	jal	ra,ffffffffc020720e <lab6_set_priority>
ffffffffc020789e:	60a2                	ld	ra,8(sp)
ffffffffc02078a0:	4501                	li	a0,0
ffffffffc02078a2:	0141                	addi	sp,sp,16
ffffffffc02078a4:	8082                	ret

ffffffffc02078a6 <sys_dup>:
ffffffffc02078a6:	450c                	lw	a1,8(a0)
ffffffffc02078a8:	4108                	lw	a0,0(a0)
ffffffffc02078aa:	87cfe06f          	j	ffffffffc0205926 <sysfile_dup>

ffffffffc02078ae <sys_getdirentry>:
ffffffffc02078ae:	650c                	ld	a1,8(a0)
ffffffffc02078b0:	4108                	lw	a0,0(a0)
ffffffffc02078b2:	f85fd06f          	j	ffffffffc0205836 <sysfile_getdirentry>

ffffffffc02078b6 <sys_getcwd>:
ffffffffc02078b6:	650c                	ld	a1,8(a0)
ffffffffc02078b8:	6108                	ld	a0,0(a0)
ffffffffc02078ba:	ed9fd06f          	j	ffffffffc0205792 <sysfile_getcwd>

ffffffffc02078be <sys_fsync>:
ffffffffc02078be:	4108                	lw	a0,0(a0)
ffffffffc02078c0:	ecffd06f          	j	ffffffffc020578e <sysfile_fsync>

ffffffffc02078c4 <sys_fstat>:
ffffffffc02078c4:	650c                	ld	a1,8(a0)
ffffffffc02078c6:	4108                	lw	a0,0(a0)
ffffffffc02078c8:	e27fd06f          	j	ffffffffc02056ee <sysfile_fstat>

ffffffffc02078cc <sys_seek>:
ffffffffc02078cc:	4910                	lw	a2,16(a0)
ffffffffc02078ce:	650c                	ld	a1,8(a0)
ffffffffc02078d0:	4108                	lw	a0,0(a0)
ffffffffc02078d2:	e19fd06f          	j	ffffffffc02056ea <sysfile_seek>

ffffffffc02078d6 <sys_write>:
ffffffffc02078d6:	6910                	ld	a2,16(a0)
ffffffffc02078d8:	650c                	ld	a1,8(a0)
ffffffffc02078da:	4108                	lw	a0,0(a0)
ffffffffc02078dc:	cf5fd06f          	j	ffffffffc02055d0 <sysfile_write>

ffffffffc02078e0 <sys_read>:
ffffffffc02078e0:	6910                	ld	a2,16(a0)
ffffffffc02078e2:	650c                	ld	a1,8(a0)
ffffffffc02078e4:	4108                	lw	a0,0(a0)
ffffffffc02078e6:	bd7fd06f          	j	ffffffffc02054bc <sysfile_read>

ffffffffc02078ea <sys_close>:
ffffffffc02078ea:	4108                	lw	a0,0(a0)
ffffffffc02078ec:	bcdfd06f          	j	ffffffffc02054b8 <sysfile_close>

ffffffffc02078f0 <sys_open>:
ffffffffc02078f0:	450c                	lw	a1,8(a0)
ffffffffc02078f2:	6108                	ld	a0,0(a0)
ffffffffc02078f4:	b91fd06f          	j	ffffffffc0205484 <sysfile_open>

ffffffffc02078f8 <sys_putc>:
ffffffffc02078f8:	4108                	lw	a0,0(a0)
ffffffffc02078fa:	1141                	addi	sp,sp,-16
ffffffffc02078fc:	e406                	sd	ra,8(sp)
ffffffffc02078fe:	8e5f80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0207902:	60a2                	ld	ra,8(sp)
ffffffffc0207904:	4501                	li	a0,0
ffffffffc0207906:	0141                	addi	sp,sp,16
ffffffffc0207908:	8082                	ret

ffffffffc020790a <sys_kill>:
ffffffffc020790a:	4108                	lw	a0,0(a0)
ffffffffc020790c:	ea0ff06f          	j	ffffffffc0206fac <do_kill>

ffffffffc0207910 <sys_sleep>:
ffffffffc0207910:	4108                	lw	a0,0(a0)
ffffffffc0207912:	937ff06f          	j	ffffffffc0207248 <do_sleep>

ffffffffc0207916 <sys_yield>:
ffffffffc0207916:	e48ff06f          	j	ffffffffc0206f5e <do_yield>

ffffffffc020791a <sys_exec>:
ffffffffc020791a:	6910                	ld	a2,16(a0)
ffffffffc020791c:	450c                	lw	a1,8(a0)
ffffffffc020791e:	6108                	ld	a0,0(a0)
ffffffffc0207920:	c11fe06f          	j	ffffffffc0206530 <do_execve>

ffffffffc0207924 <sys_wait>:
ffffffffc0207924:	650c                	ld	a1,8(a0)
ffffffffc0207926:	4108                	lw	a0,0(a0)
ffffffffc0207928:	e46ff06f          	j	ffffffffc0206f6e <do_wait>

ffffffffc020792c <sys_fork>:
ffffffffc020792c:	0008f797          	auipc	a5,0x8f
ffffffffc0207930:	f947b783          	ld	a5,-108(a5) # ffffffffc02968c0 <current>
ffffffffc0207934:	73d0                	ld	a2,160(a5)
ffffffffc0207936:	4501                	li	a0,0
ffffffffc0207938:	6a0c                	ld	a1,16(a2)
ffffffffc020793a:	98efe06f          	j	ffffffffc0205ac8 <do_fork>

ffffffffc020793e <sys_exit>:
ffffffffc020793e:	4108                	lw	a0,0(a0)
ffffffffc0207940:	f80fe06f          	j	ffffffffc02060c0 <do_exit>

ffffffffc0207944 <syscall>:
ffffffffc0207944:	715d                	addi	sp,sp,-80
ffffffffc0207946:	fc26                	sd	s1,56(sp)
ffffffffc0207948:	0008f497          	auipc	s1,0x8f
ffffffffc020794c:	f7848493          	addi	s1,s1,-136 # ffffffffc02968c0 <current>
ffffffffc0207950:	6098                	ld	a4,0(s1)
ffffffffc0207952:	e0a2                	sd	s0,64(sp)
ffffffffc0207954:	f84a                	sd	s2,48(sp)
ffffffffc0207956:	7340                	ld	s0,160(a4)
ffffffffc0207958:	e486                	sd	ra,72(sp)
ffffffffc020795a:	0ff00793          	li	a5,255
ffffffffc020795e:	05042903          	lw	s2,80(s0)
ffffffffc0207962:	0327ee63          	bltu	a5,s2,ffffffffc020799e <syscall+0x5a>
ffffffffc0207966:	00391713          	slli	a4,s2,0x3
ffffffffc020796a:	00006797          	auipc	a5,0x6
ffffffffc020796e:	3a678793          	addi	a5,a5,934 # ffffffffc020dd10 <syscalls>
ffffffffc0207972:	97ba                	add	a5,a5,a4
ffffffffc0207974:	639c                	ld	a5,0(a5)
ffffffffc0207976:	c785                	beqz	a5,ffffffffc020799e <syscall+0x5a>
ffffffffc0207978:	6c28                	ld	a0,88(s0)
ffffffffc020797a:	702c                	ld	a1,96(s0)
ffffffffc020797c:	7430                	ld	a2,104(s0)
ffffffffc020797e:	7834                	ld	a3,112(s0)
ffffffffc0207980:	7c38                	ld	a4,120(s0)
ffffffffc0207982:	e42a                	sd	a0,8(sp)
ffffffffc0207984:	e82e                	sd	a1,16(sp)
ffffffffc0207986:	ec32                	sd	a2,24(sp)
ffffffffc0207988:	f036                	sd	a3,32(sp)
ffffffffc020798a:	f43a                	sd	a4,40(sp)
ffffffffc020798c:	0028                	addi	a0,sp,8
ffffffffc020798e:	9782                	jalr	a5
ffffffffc0207990:	60a6                	ld	ra,72(sp)
ffffffffc0207992:	e828                	sd	a0,80(s0)
ffffffffc0207994:	6406                	ld	s0,64(sp)
ffffffffc0207996:	74e2                	ld	s1,56(sp)
ffffffffc0207998:	7942                	ld	s2,48(sp)
ffffffffc020799a:	6161                	addi	sp,sp,80
ffffffffc020799c:	8082                	ret
ffffffffc020799e:	8522                	mv	a0,s0
ffffffffc02079a0:	deaf90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc02079a4:	609c                	ld	a5,0(s1)
ffffffffc02079a6:	86ca                	mv	a3,s2
ffffffffc02079a8:	00006617          	auipc	a2,0x6
ffffffffc02079ac:	32060613          	addi	a2,a2,800 # ffffffffc020dcc8 <CSWTCH.79+0x770>
ffffffffc02079b0:	43d8                	lw	a4,4(a5)
ffffffffc02079b2:	0d800593          	li	a1,216
ffffffffc02079b6:	0b478793          	addi	a5,a5,180
ffffffffc02079ba:	00006517          	auipc	a0,0x6
ffffffffc02079be:	33e50513          	addi	a0,a0,830 # ffffffffc020dcf8 <CSWTCH.79+0x7a0>
ffffffffc02079c2:	addf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02079c6 <__alloc_inode>:
ffffffffc02079c6:	1141                	addi	sp,sp,-16
ffffffffc02079c8:	e022                	sd	s0,0(sp)
ffffffffc02079ca:	842a                	mv	s0,a0
ffffffffc02079cc:	07800513          	li	a0,120
ffffffffc02079d0:	e406                	sd	ra,8(sp)
ffffffffc02079d2:	dbcfa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02079d6:	c111                	beqz	a0,ffffffffc02079da <__alloc_inode+0x14>
ffffffffc02079d8:	cd20                	sw	s0,88(a0)
ffffffffc02079da:	60a2                	ld	ra,8(sp)
ffffffffc02079dc:	6402                	ld	s0,0(sp)
ffffffffc02079de:	0141                	addi	sp,sp,16
ffffffffc02079e0:	8082                	ret

ffffffffc02079e2 <inode_init>:
ffffffffc02079e2:	4785                	li	a5,1
ffffffffc02079e4:	06052023          	sw	zero,96(a0)
ffffffffc02079e8:	f92c                	sd	a1,112(a0)
ffffffffc02079ea:	f530                	sd	a2,104(a0)
ffffffffc02079ec:	cd7c                	sw	a5,92(a0)
ffffffffc02079ee:	8082                	ret

ffffffffc02079f0 <inode_kill>:
ffffffffc02079f0:	4d78                	lw	a4,92(a0)
ffffffffc02079f2:	1141                	addi	sp,sp,-16
ffffffffc02079f4:	e406                	sd	ra,8(sp)
ffffffffc02079f6:	e719                	bnez	a4,ffffffffc0207a04 <inode_kill+0x14>
ffffffffc02079f8:	513c                	lw	a5,96(a0)
ffffffffc02079fa:	e78d                	bnez	a5,ffffffffc0207a24 <inode_kill+0x34>
ffffffffc02079fc:	60a2                	ld	ra,8(sp)
ffffffffc02079fe:	0141                	addi	sp,sp,16
ffffffffc0207a00:	e3efa06f          	j	ffffffffc020203e <kfree>
ffffffffc0207a04:	00007697          	auipc	a3,0x7
ffffffffc0207a08:	b0c68693          	addi	a3,a3,-1268 # ffffffffc020e510 <syscalls+0x800>
ffffffffc0207a0c:	00004617          	auipc	a2,0x4
ffffffffc0207a10:	14c60613          	addi	a2,a2,332 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207a14:	02900593          	li	a1,41
ffffffffc0207a18:	00007517          	auipc	a0,0x7
ffffffffc0207a1c:	b1850513          	addi	a0,a0,-1256 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207a20:	a7ff80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a24:	00007697          	auipc	a3,0x7
ffffffffc0207a28:	b2468693          	addi	a3,a3,-1244 # ffffffffc020e548 <syscalls+0x838>
ffffffffc0207a2c:	00004617          	auipc	a2,0x4
ffffffffc0207a30:	12c60613          	addi	a2,a2,300 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207a34:	02a00593          	li	a1,42
ffffffffc0207a38:	00007517          	auipc	a0,0x7
ffffffffc0207a3c:	af850513          	addi	a0,a0,-1288 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207a40:	a5ff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a44 <inode_ref_inc>:
ffffffffc0207a44:	4d7c                	lw	a5,92(a0)
ffffffffc0207a46:	2785                	addiw	a5,a5,1
ffffffffc0207a48:	cd7c                	sw	a5,92(a0)
ffffffffc0207a4a:	0007851b          	sext.w	a0,a5
ffffffffc0207a4e:	8082                	ret

ffffffffc0207a50 <inode_open_inc>:
ffffffffc0207a50:	513c                	lw	a5,96(a0)
ffffffffc0207a52:	2785                	addiw	a5,a5,1
ffffffffc0207a54:	d13c                	sw	a5,96(a0)
ffffffffc0207a56:	0007851b          	sext.w	a0,a5
ffffffffc0207a5a:	8082                	ret

ffffffffc0207a5c <inode_check>:
ffffffffc0207a5c:	1141                	addi	sp,sp,-16
ffffffffc0207a5e:	e406                	sd	ra,8(sp)
ffffffffc0207a60:	c90d                	beqz	a0,ffffffffc0207a92 <inode_check+0x36>
ffffffffc0207a62:	793c                	ld	a5,112(a0)
ffffffffc0207a64:	c79d                	beqz	a5,ffffffffc0207a92 <inode_check+0x36>
ffffffffc0207a66:	6398                	ld	a4,0(a5)
ffffffffc0207a68:	4625d7b7          	lui	a5,0x4625d
ffffffffc0207a6c:	0786                	slli	a5,a5,0x1
ffffffffc0207a6e:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc0207a72:	08f71063          	bne	a4,a5,ffffffffc0207af2 <inode_check+0x96>
ffffffffc0207a76:	4d78                	lw	a4,92(a0)
ffffffffc0207a78:	513c                	lw	a5,96(a0)
ffffffffc0207a7a:	04f74c63          	blt	a4,a5,ffffffffc0207ad2 <inode_check+0x76>
ffffffffc0207a7e:	0407ca63          	bltz	a5,ffffffffc0207ad2 <inode_check+0x76>
ffffffffc0207a82:	66c1                	lui	a3,0x10
ffffffffc0207a84:	02d75763          	bge	a4,a3,ffffffffc0207ab2 <inode_check+0x56>
ffffffffc0207a88:	02d7d563          	bge	a5,a3,ffffffffc0207ab2 <inode_check+0x56>
ffffffffc0207a8c:	60a2                	ld	ra,8(sp)
ffffffffc0207a8e:	0141                	addi	sp,sp,16
ffffffffc0207a90:	8082                	ret
ffffffffc0207a92:	00007697          	auipc	a3,0x7
ffffffffc0207a96:	ad668693          	addi	a3,a3,-1322 # ffffffffc020e568 <syscalls+0x858>
ffffffffc0207a9a:	00004617          	auipc	a2,0x4
ffffffffc0207a9e:	0be60613          	addi	a2,a2,190 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207aa2:	06e00593          	li	a1,110
ffffffffc0207aa6:	00007517          	auipc	a0,0x7
ffffffffc0207aaa:	a8a50513          	addi	a0,a0,-1398 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207aae:	9f1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ab2:	00007697          	auipc	a3,0x7
ffffffffc0207ab6:	b3668693          	addi	a3,a3,-1226 # ffffffffc020e5e8 <syscalls+0x8d8>
ffffffffc0207aba:	00004617          	auipc	a2,0x4
ffffffffc0207abe:	09e60613          	addi	a2,a2,158 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207ac2:	07200593          	li	a1,114
ffffffffc0207ac6:	00007517          	auipc	a0,0x7
ffffffffc0207aca:	a6a50513          	addi	a0,a0,-1430 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207ace:	9d1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ad2:	00007697          	auipc	a3,0x7
ffffffffc0207ad6:	ae668693          	addi	a3,a3,-1306 # ffffffffc020e5b8 <syscalls+0x8a8>
ffffffffc0207ada:	00004617          	auipc	a2,0x4
ffffffffc0207ade:	07e60613          	addi	a2,a2,126 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207ae2:	07100593          	li	a1,113
ffffffffc0207ae6:	00007517          	auipc	a0,0x7
ffffffffc0207aea:	a4a50513          	addi	a0,a0,-1462 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207aee:	9b1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207af2:	00007697          	auipc	a3,0x7
ffffffffc0207af6:	a9e68693          	addi	a3,a3,-1378 # ffffffffc020e590 <syscalls+0x880>
ffffffffc0207afa:	00004617          	auipc	a2,0x4
ffffffffc0207afe:	05e60613          	addi	a2,a2,94 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207b02:	06f00593          	li	a1,111
ffffffffc0207b06:	00007517          	auipc	a0,0x7
ffffffffc0207b0a:	a2a50513          	addi	a0,a0,-1494 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207b0e:	991f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207b12 <inode_ref_dec>:
ffffffffc0207b12:	4d7c                	lw	a5,92(a0)
ffffffffc0207b14:	1101                	addi	sp,sp,-32
ffffffffc0207b16:	ec06                	sd	ra,24(sp)
ffffffffc0207b18:	e822                	sd	s0,16(sp)
ffffffffc0207b1a:	e426                	sd	s1,8(sp)
ffffffffc0207b1c:	e04a                	sd	s2,0(sp)
ffffffffc0207b1e:	06f05e63          	blez	a5,ffffffffc0207b9a <inode_ref_dec+0x88>
ffffffffc0207b22:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207b26:	cd64                	sw	s1,92(a0)
ffffffffc0207b28:	842a                	mv	s0,a0
ffffffffc0207b2a:	e09d                	bnez	s1,ffffffffc0207b50 <inode_ref_dec+0x3e>
ffffffffc0207b2c:	793c                	ld	a5,112(a0)
ffffffffc0207b2e:	c7b1                	beqz	a5,ffffffffc0207b7a <inode_ref_dec+0x68>
ffffffffc0207b30:	0487b903          	ld	s2,72(a5)
ffffffffc0207b34:	04090363          	beqz	s2,ffffffffc0207b7a <inode_ref_dec+0x68>
ffffffffc0207b38:	00007597          	auipc	a1,0x7
ffffffffc0207b3c:	b6058593          	addi	a1,a1,-1184 # ffffffffc020e698 <syscalls+0x988>
ffffffffc0207b40:	f1dff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0207b44:	8522                	mv	a0,s0
ffffffffc0207b46:	9902                	jalr	s2
ffffffffc0207b48:	c501                	beqz	a0,ffffffffc0207b50 <inode_ref_dec+0x3e>
ffffffffc0207b4a:	57c5                	li	a5,-15
ffffffffc0207b4c:	00f51963          	bne	a0,a5,ffffffffc0207b5e <inode_ref_dec+0x4c>
ffffffffc0207b50:	60e2                	ld	ra,24(sp)
ffffffffc0207b52:	6442                	ld	s0,16(sp)
ffffffffc0207b54:	6902                	ld	s2,0(sp)
ffffffffc0207b56:	8526                	mv	a0,s1
ffffffffc0207b58:	64a2                	ld	s1,8(sp)
ffffffffc0207b5a:	6105                	addi	sp,sp,32
ffffffffc0207b5c:	8082                	ret
ffffffffc0207b5e:	85aa                	mv	a1,a0
ffffffffc0207b60:	00007517          	auipc	a0,0x7
ffffffffc0207b64:	b4050513          	addi	a0,a0,-1216 # ffffffffc020e6a0 <syscalls+0x990>
ffffffffc0207b68:	e3ef80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207b6c:	60e2                	ld	ra,24(sp)
ffffffffc0207b6e:	6442                	ld	s0,16(sp)
ffffffffc0207b70:	6902                	ld	s2,0(sp)
ffffffffc0207b72:	8526                	mv	a0,s1
ffffffffc0207b74:	64a2                	ld	s1,8(sp)
ffffffffc0207b76:	6105                	addi	sp,sp,32
ffffffffc0207b78:	8082                	ret
ffffffffc0207b7a:	00007697          	auipc	a3,0x7
ffffffffc0207b7e:	ace68693          	addi	a3,a3,-1330 # ffffffffc020e648 <syscalls+0x938>
ffffffffc0207b82:	00004617          	auipc	a2,0x4
ffffffffc0207b86:	fd660613          	addi	a2,a2,-42 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207b8a:	04400593          	li	a1,68
ffffffffc0207b8e:	00007517          	auipc	a0,0x7
ffffffffc0207b92:	9a250513          	addi	a0,a0,-1630 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207b96:	909f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b9a:	00007697          	auipc	a3,0x7
ffffffffc0207b9e:	a8e68693          	addi	a3,a3,-1394 # ffffffffc020e628 <syscalls+0x918>
ffffffffc0207ba2:	00004617          	auipc	a2,0x4
ffffffffc0207ba6:	fb660613          	addi	a2,a2,-74 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207baa:	03f00593          	li	a1,63
ffffffffc0207bae:	00007517          	auipc	a0,0x7
ffffffffc0207bb2:	98250513          	addi	a0,a0,-1662 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207bb6:	8e9f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207bba <inode_open_dec>:
ffffffffc0207bba:	513c                	lw	a5,96(a0)
ffffffffc0207bbc:	1101                	addi	sp,sp,-32
ffffffffc0207bbe:	ec06                	sd	ra,24(sp)
ffffffffc0207bc0:	e822                	sd	s0,16(sp)
ffffffffc0207bc2:	e426                	sd	s1,8(sp)
ffffffffc0207bc4:	e04a                	sd	s2,0(sp)
ffffffffc0207bc6:	06f05b63          	blez	a5,ffffffffc0207c3c <inode_open_dec+0x82>
ffffffffc0207bca:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207bce:	d124                	sw	s1,96(a0)
ffffffffc0207bd0:	842a                	mv	s0,a0
ffffffffc0207bd2:	e085                	bnez	s1,ffffffffc0207bf2 <inode_open_dec+0x38>
ffffffffc0207bd4:	793c                	ld	a5,112(a0)
ffffffffc0207bd6:	c3b9                	beqz	a5,ffffffffc0207c1c <inode_open_dec+0x62>
ffffffffc0207bd8:	0107b903          	ld	s2,16(a5)
ffffffffc0207bdc:	04090063          	beqz	s2,ffffffffc0207c1c <inode_open_dec+0x62>
ffffffffc0207be0:	00007597          	auipc	a1,0x7
ffffffffc0207be4:	b5058593          	addi	a1,a1,-1200 # ffffffffc020e730 <syscalls+0xa20>
ffffffffc0207be8:	e75ff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0207bec:	8522                	mv	a0,s0
ffffffffc0207bee:	9902                	jalr	s2
ffffffffc0207bf0:	e901                	bnez	a0,ffffffffc0207c00 <inode_open_dec+0x46>
ffffffffc0207bf2:	60e2                	ld	ra,24(sp)
ffffffffc0207bf4:	6442                	ld	s0,16(sp)
ffffffffc0207bf6:	6902                	ld	s2,0(sp)
ffffffffc0207bf8:	8526                	mv	a0,s1
ffffffffc0207bfa:	64a2                	ld	s1,8(sp)
ffffffffc0207bfc:	6105                	addi	sp,sp,32
ffffffffc0207bfe:	8082                	ret
ffffffffc0207c00:	85aa                	mv	a1,a0
ffffffffc0207c02:	00007517          	auipc	a0,0x7
ffffffffc0207c06:	b3650513          	addi	a0,a0,-1226 # ffffffffc020e738 <syscalls+0xa28>
ffffffffc0207c0a:	d9cf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207c0e:	60e2                	ld	ra,24(sp)
ffffffffc0207c10:	6442                	ld	s0,16(sp)
ffffffffc0207c12:	6902                	ld	s2,0(sp)
ffffffffc0207c14:	8526                	mv	a0,s1
ffffffffc0207c16:	64a2                	ld	s1,8(sp)
ffffffffc0207c18:	6105                	addi	sp,sp,32
ffffffffc0207c1a:	8082                	ret
ffffffffc0207c1c:	00007697          	auipc	a3,0x7
ffffffffc0207c20:	ac468693          	addi	a3,a3,-1340 # ffffffffc020e6e0 <syscalls+0x9d0>
ffffffffc0207c24:	00004617          	auipc	a2,0x4
ffffffffc0207c28:	f3460613          	addi	a2,a2,-204 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207c2c:	06100593          	li	a1,97
ffffffffc0207c30:	00007517          	auipc	a0,0x7
ffffffffc0207c34:	90050513          	addi	a0,a0,-1792 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207c38:	867f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207c3c:	00007697          	auipc	a3,0x7
ffffffffc0207c40:	a8468693          	addi	a3,a3,-1404 # ffffffffc020e6c0 <syscalls+0x9b0>
ffffffffc0207c44:	00004617          	auipc	a2,0x4
ffffffffc0207c48:	f1460613          	addi	a2,a2,-236 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207c4c:	05c00593          	li	a1,92
ffffffffc0207c50:	00007517          	auipc	a0,0x7
ffffffffc0207c54:	8e050513          	addi	a0,a0,-1824 # ffffffffc020e530 <syscalls+0x820>
ffffffffc0207c58:	847f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207c5c <__alloc_fs>:
ffffffffc0207c5c:	1141                	addi	sp,sp,-16
ffffffffc0207c5e:	e022                	sd	s0,0(sp)
ffffffffc0207c60:	842a                	mv	s0,a0
ffffffffc0207c62:	0d800513          	li	a0,216
ffffffffc0207c66:	e406                	sd	ra,8(sp)
ffffffffc0207c68:	b26fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207c6c:	c119                	beqz	a0,ffffffffc0207c72 <__alloc_fs+0x16>
ffffffffc0207c6e:	0a852823          	sw	s0,176(a0)
ffffffffc0207c72:	60a2                	ld	ra,8(sp)
ffffffffc0207c74:	6402                	ld	s0,0(sp)
ffffffffc0207c76:	0141                	addi	sp,sp,16
ffffffffc0207c78:	8082                	ret

ffffffffc0207c7a <vfs_init>:
ffffffffc0207c7a:	1141                	addi	sp,sp,-16
ffffffffc0207c7c:	4585                	li	a1,1
ffffffffc0207c7e:	0008e517          	auipc	a0,0x8e
ffffffffc0207c82:	b8250513          	addi	a0,a0,-1150 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207c86:	e406                	sd	ra,8(sp)
ffffffffc0207c88:	831fc0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0207c8c:	60a2                	ld	ra,8(sp)
ffffffffc0207c8e:	0141                	addi	sp,sp,16
ffffffffc0207c90:	a40d                	j	ffffffffc0207eb2 <vfs_devlist_init>

ffffffffc0207c92 <vfs_set_bootfs>:
ffffffffc0207c92:	7179                	addi	sp,sp,-48
ffffffffc0207c94:	f022                	sd	s0,32(sp)
ffffffffc0207c96:	f406                	sd	ra,40(sp)
ffffffffc0207c98:	ec26                	sd	s1,24(sp)
ffffffffc0207c9a:	e402                	sd	zero,8(sp)
ffffffffc0207c9c:	842a                	mv	s0,a0
ffffffffc0207c9e:	c915                	beqz	a0,ffffffffc0207cd2 <vfs_set_bootfs+0x40>
ffffffffc0207ca0:	03a00593          	li	a1,58
ffffffffc0207ca4:	1bd030ef          	jal	ra,ffffffffc020b660 <strchr>
ffffffffc0207ca8:	c135                	beqz	a0,ffffffffc0207d0c <vfs_set_bootfs+0x7a>
ffffffffc0207caa:	00154783          	lbu	a5,1(a0)
ffffffffc0207cae:	efb9                	bnez	a5,ffffffffc0207d0c <vfs_set_bootfs+0x7a>
ffffffffc0207cb0:	8522                	mv	a0,s0
ffffffffc0207cb2:	11f000ef          	jal	ra,ffffffffc02085d0 <vfs_chdir>
ffffffffc0207cb6:	842a                	mv	s0,a0
ffffffffc0207cb8:	c519                	beqz	a0,ffffffffc0207cc6 <vfs_set_bootfs+0x34>
ffffffffc0207cba:	70a2                	ld	ra,40(sp)
ffffffffc0207cbc:	8522                	mv	a0,s0
ffffffffc0207cbe:	7402                	ld	s0,32(sp)
ffffffffc0207cc0:	64e2                	ld	s1,24(sp)
ffffffffc0207cc2:	6145                	addi	sp,sp,48
ffffffffc0207cc4:	8082                	ret
ffffffffc0207cc6:	0028                	addi	a0,sp,8
ffffffffc0207cc8:	013000ef          	jal	ra,ffffffffc02084da <vfs_get_curdir>
ffffffffc0207ccc:	842a                	mv	s0,a0
ffffffffc0207cce:	f575                	bnez	a0,ffffffffc0207cba <vfs_set_bootfs+0x28>
ffffffffc0207cd0:	6422                	ld	s0,8(sp)
ffffffffc0207cd2:	0008e517          	auipc	a0,0x8e
ffffffffc0207cd6:	b2e50513          	addi	a0,a0,-1234 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207cda:	fe8fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207cde:	0008f797          	auipc	a5,0x8f
ffffffffc0207ce2:	c1278793          	addi	a5,a5,-1006 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207ce6:	6384                	ld	s1,0(a5)
ffffffffc0207ce8:	0008e517          	auipc	a0,0x8e
ffffffffc0207cec:	b1850513          	addi	a0,a0,-1256 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207cf0:	e380                	sd	s0,0(a5)
ffffffffc0207cf2:	4401                	li	s0,0
ffffffffc0207cf4:	fcafc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207cf8:	d0e9                	beqz	s1,ffffffffc0207cba <vfs_set_bootfs+0x28>
ffffffffc0207cfa:	8526                	mv	a0,s1
ffffffffc0207cfc:	e17ff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc0207d00:	70a2                	ld	ra,40(sp)
ffffffffc0207d02:	8522                	mv	a0,s0
ffffffffc0207d04:	7402                	ld	s0,32(sp)
ffffffffc0207d06:	64e2                	ld	s1,24(sp)
ffffffffc0207d08:	6145                	addi	sp,sp,48
ffffffffc0207d0a:	8082                	ret
ffffffffc0207d0c:	5475                	li	s0,-3
ffffffffc0207d0e:	b775                	j	ffffffffc0207cba <vfs_set_bootfs+0x28>

ffffffffc0207d10 <vfs_get_bootfs>:
ffffffffc0207d10:	1101                	addi	sp,sp,-32
ffffffffc0207d12:	e426                	sd	s1,8(sp)
ffffffffc0207d14:	0008f497          	auipc	s1,0x8f
ffffffffc0207d18:	bdc48493          	addi	s1,s1,-1060 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207d1c:	609c                	ld	a5,0(s1)
ffffffffc0207d1e:	ec06                	sd	ra,24(sp)
ffffffffc0207d20:	e822                	sd	s0,16(sp)
ffffffffc0207d22:	c3a1                	beqz	a5,ffffffffc0207d62 <vfs_get_bootfs+0x52>
ffffffffc0207d24:	842a                	mv	s0,a0
ffffffffc0207d26:	0008e517          	auipc	a0,0x8e
ffffffffc0207d2a:	ada50513          	addi	a0,a0,-1318 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207d2e:	f94fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207d32:	6084                	ld	s1,0(s1)
ffffffffc0207d34:	c08d                	beqz	s1,ffffffffc0207d56 <vfs_get_bootfs+0x46>
ffffffffc0207d36:	8526                	mv	a0,s1
ffffffffc0207d38:	d0dff0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc0207d3c:	0008e517          	auipc	a0,0x8e
ffffffffc0207d40:	ac450513          	addi	a0,a0,-1340 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207d44:	f7afc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207d48:	4501                	li	a0,0
ffffffffc0207d4a:	e004                	sd	s1,0(s0)
ffffffffc0207d4c:	60e2                	ld	ra,24(sp)
ffffffffc0207d4e:	6442                	ld	s0,16(sp)
ffffffffc0207d50:	64a2                	ld	s1,8(sp)
ffffffffc0207d52:	6105                	addi	sp,sp,32
ffffffffc0207d54:	8082                	ret
ffffffffc0207d56:	0008e517          	auipc	a0,0x8e
ffffffffc0207d5a:	aaa50513          	addi	a0,a0,-1366 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207d5e:	f60fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207d62:	5541                	li	a0,-16
ffffffffc0207d64:	b7e5                	j	ffffffffc0207d4c <vfs_get_bootfs+0x3c>

ffffffffc0207d66 <vfs_do_add>:
ffffffffc0207d66:	7139                	addi	sp,sp,-64
ffffffffc0207d68:	fc06                	sd	ra,56(sp)
ffffffffc0207d6a:	f822                	sd	s0,48(sp)
ffffffffc0207d6c:	f426                	sd	s1,40(sp)
ffffffffc0207d6e:	f04a                	sd	s2,32(sp)
ffffffffc0207d70:	ec4e                	sd	s3,24(sp)
ffffffffc0207d72:	e852                	sd	s4,16(sp)
ffffffffc0207d74:	e456                	sd	s5,8(sp)
ffffffffc0207d76:	e05a                	sd	s6,0(sp)
ffffffffc0207d78:	0e050b63          	beqz	a0,ffffffffc0207e6e <vfs_do_add+0x108>
ffffffffc0207d7c:	842a                	mv	s0,a0
ffffffffc0207d7e:	8a2e                	mv	s4,a1
ffffffffc0207d80:	8b32                	mv	s6,a2
ffffffffc0207d82:	8ab6                	mv	s5,a3
ffffffffc0207d84:	c5cd                	beqz	a1,ffffffffc0207e2e <vfs_do_add+0xc8>
ffffffffc0207d86:	4db8                	lw	a4,88(a1)
ffffffffc0207d88:	6785                	lui	a5,0x1
ffffffffc0207d8a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207d8e:	0af71163          	bne	a4,a5,ffffffffc0207e30 <vfs_do_add+0xca>
ffffffffc0207d92:	8522                	mv	a0,s0
ffffffffc0207d94:	041030ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc0207d98:	47fd                	li	a5,31
ffffffffc0207d9a:	0ca7e663          	bltu	a5,a0,ffffffffc0207e66 <vfs_do_add+0x100>
ffffffffc0207d9e:	8522                	mv	a0,s0
ffffffffc0207da0:	c54f80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207da4:	84aa                	mv	s1,a0
ffffffffc0207da6:	c171                	beqz	a0,ffffffffc0207e6a <vfs_do_add+0x104>
ffffffffc0207da8:	03000513          	li	a0,48
ffffffffc0207dac:	9e2fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207db0:	89aa                	mv	s3,a0
ffffffffc0207db2:	c92d                	beqz	a0,ffffffffc0207e24 <vfs_do_add+0xbe>
ffffffffc0207db4:	0008e517          	auipc	a0,0x8e
ffffffffc0207db8:	a7450513          	addi	a0,a0,-1420 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207dbc:	0008e917          	auipc	s2,0x8e
ffffffffc0207dc0:	a5c90913          	addi	s2,s2,-1444 # ffffffffc0295818 <vdev_list>
ffffffffc0207dc4:	efefc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207dc8:	844a                	mv	s0,s2
ffffffffc0207dca:	a039                	j	ffffffffc0207dd8 <vfs_do_add+0x72>
ffffffffc0207dcc:	fe043503          	ld	a0,-32(s0)
ffffffffc0207dd0:	85a6                	mv	a1,s1
ffffffffc0207dd2:	04b030ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc0207dd6:	cd2d                	beqz	a0,ffffffffc0207e50 <vfs_do_add+0xea>
ffffffffc0207dd8:	6400                	ld	s0,8(s0)
ffffffffc0207dda:	ff2419e3          	bne	s0,s2,ffffffffc0207dcc <vfs_do_add+0x66>
ffffffffc0207dde:	6418                	ld	a4,8(s0)
ffffffffc0207de0:	02098793          	addi	a5,s3,32
ffffffffc0207de4:	0099b023          	sd	s1,0(s3)
ffffffffc0207de8:	0149b423          	sd	s4,8(s3)
ffffffffc0207dec:	0159bc23          	sd	s5,24(s3)
ffffffffc0207df0:	0169b823          	sd	s6,16(s3)
ffffffffc0207df4:	e31c                	sd	a5,0(a4)
ffffffffc0207df6:	0289b023          	sd	s0,32(s3)
ffffffffc0207dfa:	02e9b423          	sd	a4,40(s3)
ffffffffc0207dfe:	0008e517          	auipc	a0,0x8e
ffffffffc0207e02:	a2a50513          	addi	a0,a0,-1494 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207e06:	e41c                	sd	a5,8(s0)
ffffffffc0207e08:	4401                	li	s0,0
ffffffffc0207e0a:	eb4fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207e0e:	70e2                	ld	ra,56(sp)
ffffffffc0207e10:	8522                	mv	a0,s0
ffffffffc0207e12:	7442                	ld	s0,48(sp)
ffffffffc0207e14:	74a2                	ld	s1,40(sp)
ffffffffc0207e16:	7902                	ld	s2,32(sp)
ffffffffc0207e18:	69e2                	ld	s3,24(sp)
ffffffffc0207e1a:	6a42                	ld	s4,16(sp)
ffffffffc0207e1c:	6aa2                	ld	s5,8(sp)
ffffffffc0207e1e:	6b02                	ld	s6,0(sp)
ffffffffc0207e20:	6121                	addi	sp,sp,64
ffffffffc0207e22:	8082                	ret
ffffffffc0207e24:	5471                	li	s0,-4
ffffffffc0207e26:	8526                	mv	a0,s1
ffffffffc0207e28:	a16fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207e2c:	b7cd                	j	ffffffffc0207e0e <vfs_do_add+0xa8>
ffffffffc0207e2e:	d2b5                	beqz	a3,ffffffffc0207d92 <vfs_do_add+0x2c>
ffffffffc0207e30:	00007697          	auipc	a3,0x7
ffffffffc0207e34:	95068693          	addi	a3,a3,-1712 # ffffffffc020e780 <syscalls+0xa70>
ffffffffc0207e38:	00004617          	auipc	a2,0x4
ffffffffc0207e3c:	d2060613          	addi	a2,a2,-736 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207e40:	08f00593          	li	a1,143
ffffffffc0207e44:	00007517          	auipc	a0,0x7
ffffffffc0207e48:	92450513          	addi	a0,a0,-1756 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc0207e4c:	e52f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e50:	0008e517          	auipc	a0,0x8e
ffffffffc0207e54:	9d850513          	addi	a0,a0,-1576 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207e58:	e66fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207e5c:	854e                	mv	a0,s3
ffffffffc0207e5e:	9e0fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207e62:	5425                	li	s0,-23
ffffffffc0207e64:	b7c9                	j	ffffffffc0207e26 <vfs_do_add+0xc0>
ffffffffc0207e66:	5451                	li	s0,-12
ffffffffc0207e68:	b75d                	j	ffffffffc0207e0e <vfs_do_add+0xa8>
ffffffffc0207e6a:	5471                	li	s0,-4
ffffffffc0207e6c:	b74d                	j	ffffffffc0207e0e <vfs_do_add+0xa8>
ffffffffc0207e6e:	00007697          	auipc	a3,0x7
ffffffffc0207e72:	8ea68693          	addi	a3,a3,-1814 # ffffffffc020e758 <syscalls+0xa48>
ffffffffc0207e76:	00004617          	auipc	a2,0x4
ffffffffc0207e7a:	ce260613          	addi	a2,a2,-798 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207e7e:	08e00593          	li	a1,142
ffffffffc0207e82:	00007517          	auipc	a0,0x7
ffffffffc0207e86:	8e650513          	addi	a0,a0,-1818 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc0207e8a:	e14f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e8e <find_mount.part.0>:
ffffffffc0207e8e:	1141                	addi	sp,sp,-16
ffffffffc0207e90:	00007697          	auipc	a3,0x7
ffffffffc0207e94:	8c868693          	addi	a3,a3,-1848 # ffffffffc020e758 <syscalls+0xa48>
ffffffffc0207e98:	00004617          	auipc	a2,0x4
ffffffffc0207e9c:	cc060613          	addi	a2,a2,-832 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207ea0:	0cd00593          	li	a1,205
ffffffffc0207ea4:	00007517          	auipc	a0,0x7
ffffffffc0207ea8:	8c450513          	addi	a0,a0,-1852 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc0207eac:	e406                	sd	ra,8(sp)
ffffffffc0207eae:	df0f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207eb2 <vfs_devlist_init>:
ffffffffc0207eb2:	0008e797          	auipc	a5,0x8e
ffffffffc0207eb6:	96678793          	addi	a5,a5,-1690 # ffffffffc0295818 <vdev_list>
ffffffffc0207eba:	4585                	li	a1,1
ffffffffc0207ebc:	0008e517          	auipc	a0,0x8e
ffffffffc0207ec0:	96c50513          	addi	a0,a0,-1684 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207ec4:	e79c                	sd	a5,8(a5)
ffffffffc0207ec6:	e39c                	sd	a5,0(a5)
ffffffffc0207ec8:	df0fc06f          	j	ffffffffc02044b8 <sem_init>

ffffffffc0207ecc <vfs_cleanup>:
ffffffffc0207ecc:	1101                	addi	sp,sp,-32
ffffffffc0207ece:	e426                	sd	s1,8(sp)
ffffffffc0207ed0:	0008e497          	auipc	s1,0x8e
ffffffffc0207ed4:	94848493          	addi	s1,s1,-1720 # ffffffffc0295818 <vdev_list>
ffffffffc0207ed8:	649c                	ld	a5,8(s1)
ffffffffc0207eda:	ec06                	sd	ra,24(sp)
ffffffffc0207edc:	e822                	sd	s0,16(sp)
ffffffffc0207ede:	02978e63          	beq	a5,s1,ffffffffc0207f1a <vfs_cleanup+0x4e>
ffffffffc0207ee2:	0008e517          	auipc	a0,0x8e
ffffffffc0207ee6:	94650513          	addi	a0,a0,-1722 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207eea:	dd8fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207eee:	6480                	ld	s0,8(s1)
ffffffffc0207ef0:	00940b63          	beq	s0,s1,ffffffffc0207f06 <vfs_cleanup+0x3a>
ffffffffc0207ef4:	ff043783          	ld	a5,-16(s0)
ffffffffc0207ef8:	853e                	mv	a0,a5
ffffffffc0207efa:	c399                	beqz	a5,ffffffffc0207f00 <vfs_cleanup+0x34>
ffffffffc0207efc:	6bfc                	ld	a5,208(a5)
ffffffffc0207efe:	9782                	jalr	a5
ffffffffc0207f00:	6400                	ld	s0,8(s0)
ffffffffc0207f02:	fe9419e3          	bne	s0,s1,ffffffffc0207ef4 <vfs_cleanup+0x28>
ffffffffc0207f06:	6442                	ld	s0,16(sp)
ffffffffc0207f08:	60e2                	ld	ra,24(sp)
ffffffffc0207f0a:	64a2                	ld	s1,8(sp)
ffffffffc0207f0c:	0008e517          	auipc	a0,0x8e
ffffffffc0207f10:	91c50513          	addi	a0,a0,-1764 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207f14:	6105                	addi	sp,sp,32
ffffffffc0207f16:	da8fc06f          	j	ffffffffc02044be <up>
ffffffffc0207f1a:	60e2                	ld	ra,24(sp)
ffffffffc0207f1c:	6442                	ld	s0,16(sp)
ffffffffc0207f1e:	64a2                	ld	s1,8(sp)
ffffffffc0207f20:	6105                	addi	sp,sp,32
ffffffffc0207f22:	8082                	ret

ffffffffc0207f24 <vfs_get_root>:
ffffffffc0207f24:	7179                	addi	sp,sp,-48
ffffffffc0207f26:	f406                	sd	ra,40(sp)
ffffffffc0207f28:	f022                	sd	s0,32(sp)
ffffffffc0207f2a:	ec26                	sd	s1,24(sp)
ffffffffc0207f2c:	e84a                	sd	s2,16(sp)
ffffffffc0207f2e:	e44e                	sd	s3,8(sp)
ffffffffc0207f30:	e052                	sd	s4,0(sp)
ffffffffc0207f32:	c541                	beqz	a0,ffffffffc0207fba <vfs_get_root+0x96>
ffffffffc0207f34:	0008e917          	auipc	s2,0x8e
ffffffffc0207f38:	8e490913          	addi	s2,s2,-1820 # ffffffffc0295818 <vdev_list>
ffffffffc0207f3c:	00893783          	ld	a5,8(s2)
ffffffffc0207f40:	07278b63          	beq	a5,s2,ffffffffc0207fb6 <vfs_get_root+0x92>
ffffffffc0207f44:	89aa                	mv	s3,a0
ffffffffc0207f46:	0008e517          	auipc	a0,0x8e
ffffffffc0207f4a:	8e250513          	addi	a0,a0,-1822 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207f4e:	8a2e                	mv	s4,a1
ffffffffc0207f50:	844a                	mv	s0,s2
ffffffffc0207f52:	d70fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207f56:	a801                	j	ffffffffc0207f66 <vfs_get_root+0x42>
ffffffffc0207f58:	fe043583          	ld	a1,-32(s0)
ffffffffc0207f5c:	854e                	mv	a0,s3
ffffffffc0207f5e:	6be030ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc0207f62:	84aa                	mv	s1,a0
ffffffffc0207f64:	c505                	beqz	a0,ffffffffc0207f8c <vfs_get_root+0x68>
ffffffffc0207f66:	6400                	ld	s0,8(s0)
ffffffffc0207f68:	ff2418e3          	bne	s0,s2,ffffffffc0207f58 <vfs_get_root+0x34>
ffffffffc0207f6c:	54cd                	li	s1,-13
ffffffffc0207f6e:	0008e517          	auipc	a0,0x8e
ffffffffc0207f72:	8ba50513          	addi	a0,a0,-1862 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207f76:	d48fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207f7a:	70a2                	ld	ra,40(sp)
ffffffffc0207f7c:	7402                	ld	s0,32(sp)
ffffffffc0207f7e:	6942                	ld	s2,16(sp)
ffffffffc0207f80:	69a2                	ld	s3,8(sp)
ffffffffc0207f82:	6a02                	ld	s4,0(sp)
ffffffffc0207f84:	8526                	mv	a0,s1
ffffffffc0207f86:	64e2                	ld	s1,24(sp)
ffffffffc0207f88:	6145                	addi	sp,sp,48
ffffffffc0207f8a:	8082                	ret
ffffffffc0207f8c:	ff043503          	ld	a0,-16(s0)
ffffffffc0207f90:	c519                	beqz	a0,ffffffffc0207f9e <vfs_get_root+0x7a>
ffffffffc0207f92:	617c                	ld	a5,192(a0)
ffffffffc0207f94:	9782                	jalr	a5
ffffffffc0207f96:	c519                	beqz	a0,ffffffffc0207fa4 <vfs_get_root+0x80>
ffffffffc0207f98:	00aa3023          	sd	a0,0(s4)
ffffffffc0207f9c:	bfc9                	j	ffffffffc0207f6e <vfs_get_root+0x4a>
ffffffffc0207f9e:	ff843783          	ld	a5,-8(s0)
ffffffffc0207fa2:	c399                	beqz	a5,ffffffffc0207fa8 <vfs_get_root+0x84>
ffffffffc0207fa4:	54c9                	li	s1,-14
ffffffffc0207fa6:	b7e1                	j	ffffffffc0207f6e <vfs_get_root+0x4a>
ffffffffc0207fa8:	fe843503          	ld	a0,-24(s0)
ffffffffc0207fac:	a99ff0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc0207fb0:	fe843503          	ld	a0,-24(s0)
ffffffffc0207fb4:	b7cd                	j	ffffffffc0207f96 <vfs_get_root+0x72>
ffffffffc0207fb6:	54cd                	li	s1,-13
ffffffffc0207fb8:	b7c9                	j	ffffffffc0207f7a <vfs_get_root+0x56>
ffffffffc0207fba:	00006697          	auipc	a3,0x6
ffffffffc0207fbe:	79e68693          	addi	a3,a3,1950 # ffffffffc020e758 <syscalls+0xa48>
ffffffffc0207fc2:	00004617          	auipc	a2,0x4
ffffffffc0207fc6:	b9660613          	addi	a2,a2,-1130 # ffffffffc020bb58 <commands+0x210>
ffffffffc0207fca:	04500593          	li	a1,69
ffffffffc0207fce:	00006517          	auipc	a0,0x6
ffffffffc0207fd2:	79a50513          	addi	a0,a0,1946 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc0207fd6:	cc8f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207fda <vfs_get_devname>:
ffffffffc0207fda:	0008e697          	auipc	a3,0x8e
ffffffffc0207fde:	83e68693          	addi	a3,a3,-1986 # ffffffffc0295818 <vdev_list>
ffffffffc0207fe2:	87b6                	mv	a5,a3
ffffffffc0207fe4:	e511                	bnez	a0,ffffffffc0207ff0 <vfs_get_devname+0x16>
ffffffffc0207fe6:	a829                	j	ffffffffc0208000 <vfs_get_devname+0x26>
ffffffffc0207fe8:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207fec:	00a70763          	beq	a4,a0,ffffffffc0207ffa <vfs_get_devname+0x20>
ffffffffc0207ff0:	679c                	ld	a5,8(a5)
ffffffffc0207ff2:	fed79be3          	bne	a5,a3,ffffffffc0207fe8 <vfs_get_devname+0xe>
ffffffffc0207ff6:	4501                	li	a0,0
ffffffffc0207ff8:	8082                	ret
ffffffffc0207ffa:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207ffe:	8082                	ret
ffffffffc0208000:	1141                	addi	sp,sp,-16
ffffffffc0208002:	00006697          	auipc	a3,0x6
ffffffffc0208006:	7de68693          	addi	a3,a3,2014 # ffffffffc020e7e0 <syscalls+0xad0>
ffffffffc020800a:	00004617          	auipc	a2,0x4
ffffffffc020800e:	b4e60613          	addi	a2,a2,-1202 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208012:	06a00593          	li	a1,106
ffffffffc0208016:	00006517          	auipc	a0,0x6
ffffffffc020801a:	75250513          	addi	a0,a0,1874 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc020801e:	e406                	sd	ra,8(sp)
ffffffffc0208020:	c7ef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208024 <vfs_add_dev>:
ffffffffc0208024:	86b2                	mv	a3,a2
ffffffffc0208026:	4601                	li	a2,0
ffffffffc0208028:	d3fff06f          	j	ffffffffc0207d66 <vfs_do_add>

ffffffffc020802c <vfs_mount>:
ffffffffc020802c:	7179                	addi	sp,sp,-48
ffffffffc020802e:	e84a                	sd	s2,16(sp)
ffffffffc0208030:	892a                	mv	s2,a0
ffffffffc0208032:	0008d517          	auipc	a0,0x8d
ffffffffc0208036:	7f650513          	addi	a0,a0,2038 # ffffffffc0295828 <vdev_list_sem>
ffffffffc020803a:	e44e                	sd	s3,8(sp)
ffffffffc020803c:	f406                	sd	ra,40(sp)
ffffffffc020803e:	f022                	sd	s0,32(sp)
ffffffffc0208040:	ec26                	sd	s1,24(sp)
ffffffffc0208042:	89ae                	mv	s3,a1
ffffffffc0208044:	c7efc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0208048:	08090a63          	beqz	s2,ffffffffc02080dc <vfs_mount+0xb0>
ffffffffc020804c:	0008d497          	auipc	s1,0x8d
ffffffffc0208050:	7cc48493          	addi	s1,s1,1996 # ffffffffc0295818 <vdev_list>
ffffffffc0208054:	6480                	ld	s0,8(s1)
ffffffffc0208056:	00941663          	bne	s0,s1,ffffffffc0208062 <vfs_mount+0x36>
ffffffffc020805a:	a8ad                	j	ffffffffc02080d4 <vfs_mount+0xa8>
ffffffffc020805c:	6400                	ld	s0,8(s0)
ffffffffc020805e:	06940b63          	beq	s0,s1,ffffffffc02080d4 <vfs_mount+0xa8>
ffffffffc0208062:	ff843783          	ld	a5,-8(s0)
ffffffffc0208066:	dbfd                	beqz	a5,ffffffffc020805c <vfs_mount+0x30>
ffffffffc0208068:	fe043503          	ld	a0,-32(s0)
ffffffffc020806c:	85ca                	mv	a1,s2
ffffffffc020806e:	5ae030ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc0208072:	f56d                	bnez	a0,ffffffffc020805c <vfs_mount+0x30>
ffffffffc0208074:	ff043783          	ld	a5,-16(s0)
ffffffffc0208078:	e3a5                	bnez	a5,ffffffffc02080d8 <vfs_mount+0xac>
ffffffffc020807a:	fe043783          	ld	a5,-32(s0)
ffffffffc020807e:	c3c9                	beqz	a5,ffffffffc0208100 <vfs_mount+0xd4>
ffffffffc0208080:	ff843783          	ld	a5,-8(s0)
ffffffffc0208084:	cfb5                	beqz	a5,ffffffffc0208100 <vfs_mount+0xd4>
ffffffffc0208086:	fe843503          	ld	a0,-24(s0)
ffffffffc020808a:	c939                	beqz	a0,ffffffffc02080e0 <vfs_mount+0xb4>
ffffffffc020808c:	4d38                	lw	a4,88(a0)
ffffffffc020808e:	6785                	lui	a5,0x1
ffffffffc0208090:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208094:	04f71663          	bne	a4,a5,ffffffffc02080e0 <vfs_mount+0xb4>
ffffffffc0208098:	ff040593          	addi	a1,s0,-16
ffffffffc020809c:	9982                	jalr	s3
ffffffffc020809e:	84aa                	mv	s1,a0
ffffffffc02080a0:	ed01                	bnez	a0,ffffffffc02080b8 <vfs_mount+0x8c>
ffffffffc02080a2:	ff043783          	ld	a5,-16(s0)
ffffffffc02080a6:	cfad                	beqz	a5,ffffffffc0208120 <vfs_mount+0xf4>
ffffffffc02080a8:	fe043583          	ld	a1,-32(s0)
ffffffffc02080ac:	00006517          	auipc	a0,0x6
ffffffffc02080b0:	7c450513          	addi	a0,a0,1988 # ffffffffc020e870 <syscalls+0xb60>
ffffffffc02080b4:	8f2f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02080b8:	0008d517          	auipc	a0,0x8d
ffffffffc02080bc:	77050513          	addi	a0,a0,1904 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02080c0:	bfefc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02080c4:	70a2                	ld	ra,40(sp)
ffffffffc02080c6:	7402                	ld	s0,32(sp)
ffffffffc02080c8:	6942                	ld	s2,16(sp)
ffffffffc02080ca:	69a2                	ld	s3,8(sp)
ffffffffc02080cc:	8526                	mv	a0,s1
ffffffffc02080ce:	64e2                	ld	s1,24(sp)
ffffffffc02080d0:	6145                	addi	sp,sp,48
ffffffffc02080d2:	8082                	ret
ffffffffc02080d4:	54cd                	li	s1,-13
ffffffffc02080d6:	b7cd                	j	ffffffffc02080b8 <vfs_mount+0x8c>
ffffffffc02080d8:	54c5                	li	s1,-15
ffffffffc02080da:	bff9                	j	ffffffffc02080b8 <vfs_mount+0x8c>
ffffffffc02080dc:	db3ff0ef          	jal	ra,ffffffffc0207e8e <find_mount.part.0>
ffffffffc02080e0:	00006697          	auipc	a3,0x6
ffffffffc02080e4:	74068693          	addi	a3,a3,1856 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc02080e8:	00004617          	auipc	a2,0x4
ffffffffc02080ec:	a7060613          	addi	a2,a2,-1424 # ffffffffc020bb58 <commands+0x210>
ffffffffc02080f0:	0ed00593          	li	a1,237
ffffffffc02080f4:	00006517          	auipc	a0,0x6
ffffffffc02080f8:	67450513          	addi	a0,a0,1652 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc02080fc:	ba2f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208100:	00006697          	auipc	a3,0x6
ffffffffc0208104:	6f068693          	addi	a3,a3,1776 # ffffffffc020e7f0 <syscalls+0xae0>
ffffffffc0208108:	00004617          	auipc	a2,0x4
ffffffffc020810c:	a5060613          	addi	a2,a2,-1456 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208110:	0eb00593          	li	a1,235
ffffffffc0208114:	00006517          	auipc	a0,0x6
ffffffffc0208118:	65450513          	addi	a0,a0,1620 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc020811c:	b82f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208120:	00006697          	auipc	a3,0x6
ffffffffc0208124:	73868693          	addi	a3,a3,1848 # ffffffffc020e858 <syscalls+0xb48>
ffffffffc0208128:	00004617          	auipc	a2,0x4
ffffffffc020812c:	a3060613          	addi	a2,a2,-1488 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208130:	0ef00593          	li	a1,239
ffffffffc0208134:	00006517          	auipc	a0,0x6
ffffffffc0208138:	63450513          	addi	a0,a0,1588 # ffffffffc020e768 <syscalls+0xa58>
ffffffffc020813c:	b62f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208140 <vfs_open>:
ffffffffc0208140:	711d                	addi	sp,sp,-96
ffffffffc0208142:	e4a6                	sd	s1,72(sp)
ffffffffc0208144:	e0ca                	sd	s2,64(sp)
ffffffffc0208146:	fc4e                	sd	s3,56(sp)
ffffffffc0208148:	ec86                	sd	ra,88(sp)
ffffffffc020814a:	e8a2                	sd	s0,80(sp)
ffffffffc020814c:	f852                	sd	s4,48(sp)
ffffffffc020814e:	f456                	sd	s5,40(sp)
ffffffffc0208150:	0035f793          	andi	a5,a1,3
ffffffffc0208154:	84ae                	mv	s1,a1
ffffffffc0208156:	892a                	mv	s2,a0
ffffffffc0208158:	89b2                	mv	s3,a2
ffffffffc020815a:	0e078663          	beqz	a5,ffffffffc0208246 <vfs_open+0x106>
ffffffffc020815e:	470d                	li	a4,3
ffffffffc0208160:	0105fa93          	andi	s5,a1,16
ffffffffc0208164:	0ce78f63          	beq	a5,a4,ffffffffc0208242 <vfs_open+0x102>
ffffffffc0208168:	002c                	addi	a1,sp,8
ffffffffc020816a:	854a                	mv	a0,s2
ffffffffc020816c:	2ae000ef          	jal	ra,ffffffffc020841a <vfs_lookup>
ffffffffc0208170:	842a                	mv	s0,a0
ffffffffc0208172:	0044fa13          	andi	s4,s1,4
ffffffffc0208176:	e159                	bnez	a0,ffffffffc02081fc <vfs_open+0xbc>
ffffffffc0208178:	00c4f793          	andi	a5,s1,12
ffffffffc020817c:	4731                	li	a4,12
ffffffffc020817e:	0ee78263          	beq	a5,a4,ffffffffc0208262 <vfs_open+0x122>
ffffffffc0208182:	6422                	ld	s0,8(sp)
ffffffffc0208184:	12040163          	beqz	s0,ffffffffc02082a6 <vfs_open+0x166>
ffffffffc0208188:	783c                	ld	a5,112(s0)
ffffffffc020818a:	cff1                	beqz	a5,ffffffffc0208266 <vfs_open+0x126>
ffffffffc020818c:	679c                	ld	a5,8(a5)
ffffffffc020818e:	cfe1                	beqz	a5,ffffffffc0208266 <vfs_open+0x126>
ffffffffc0208190:	8522                	mv	a0,s0
ffffffffc0208192:	00006597          	auipc	a1,0x6
ffffffffc0208196:	7be58593          	addi	a1,a1,1982 # ffffffffc020e950 <syscalls+0xc40>
ffffffffc020819a:	8c3ff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc020819e:	783c                	ld	a5,112(s0)
ffffffffc02081a0:	6522                	ld	a0,8(sp)
ffffffffc02081a2:	85a6                	mv	a1,s1
ffffffffc02081a4:	679c                	ld	a5,8(a5)
ffffffffc02081a6:	9782                	jalr	a5
ffffffffc02081a8:	842a                	mv	s0,a0
ffffffffc02081aa:	6522                	ld	a0,8(sp)
ffffffffc02081ac:	e845                	bnez	s0,ffffffffc020825c <vfs_open+0x11c>
ffffffffc02081ae:	015a6a33          	or	s4,s4,s5
ffffffffc02081b2:	89fff0ef          	jal	ra,ffffffffc0207a50 <inode_open_inc>
ffffffffc02081b6:	020a0663          	beqz	s4,ffffffffc02081e2 <vfs_open+0xa2>
ffffffffc02081ba:	64a2                	ld	s1,8(sp)
ffffffffc02081bc:	c4e9                	beqz	s1,ffffffffc0208286 <vfs_open+0x146>
ffffffffc02081be:	78bc                	ld	a5,112(s1)
ffffffffc02081c0:	c3f9                	beqz	a5,ffffffffc0208286 <vfs_open+0x146>
ffffffffc02081c2:	73bc                	ld	a5,96(a5)
ffffffffc02081c4:	c3e9                	beqz	a5,ffffffffc0208286 <vfs_open+0x146>
ffffffffc02081c6:	00006597          	auipc	a1,0x6
ffffffffc02081ca:	7ea58593          	addi	a1,a1,2026 # ffffffffc020e9b0 <syscalls+0xca0>
ffffffffc02081ce:	8526                	mv	a0,s1
ffffffffc02081d0:	88dff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc02081d4:	78bc                	ld	a5,112(s1)
ffffffffc02081d6:	6522                	ld	a0,8(sp)
ffffffffc02081d8:	4581                	li	a1,0
ffffffffc02081da:	73bc                	ld	a5,96(a5)
ffffffffc02081dc:	9782                	jalr	a5
ffffffffc02081de:	87aa                	mv	a5,a0
ffffffffc02081e0:	e92d                	bnez	a0,ffffffffc0208252 <vfs_open+0x112>
ffffffffc02081e2:	67a2                	ld	a5,8(sp)
ffffffffc02081e4:	00f9b023          	sd	a5,0(s3)
ffffffffc02081e8:	60e6                	ld	ra,88(sp)
ffffffffc02081ea:	8522                	mv	a0,s0
ffffffffc02081ec:	6446                	ld	s0,80(sp)
ffffffffc02081ee:	64a6                	ld	s1,72(sp)
ffffffffc02081f0:	6906                	ld	s2,64(sp)
ffffffffc02081f2:	79e2                	ld	s3,56(sp)
ffffffffc02081f4:	7a42                	ld	s4,48(sp)
ffffffffc02081f6:	7aa2                	ld	s5,40(sp)
ffffffffc02081f8:	6125                	addi	sp,sp,96
ffffffffc02081fa:	8082                	ret
ffffffffc02081fc:	57c1                	li	a5,-16
ffffffffc02081fe:	fef515e3          	bne	a0,a5,ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208202:	fe0a03e3          	beqz	s4,ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208206:	0810                	addi	a2,sp,16
ffffffffc0208208:	082c                	addi	a1,sp,24
ffffffffc020820a:	854a                	mv	a0,s2
ffffffffc020820c:	2a4000ef          	jal	ra,ffffffffc02084b0 <vfs_lookup_parent>
ffffffffc0208210:	842a                	mv	s0,a0
ffffffffc0208212:	f979                	bnez	a0,ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208214:	6462                	ld	s0,24(sp)
ffffffffc0208216:	c845                	beqz	s0,ffffffffc02082c6 <vfs_open+0x186>
ffffffffc0208218:	783c                	ld	a5,112(s0)
ffffffffc020821a:	c7d5                	beqz	a5,ffffffffc02082c6 <vfs_open+0x186>
ffffffffc020821c:	77bc                	ld	a5,104(a5)
ffffffffc020821e:	c7c5                	beqz	a5,ffffffffc02082c6 <vfs_open+0x186>
ffffffffc0208220:	8522                	mv	a0,s0
ffffffffc0208222:	00006597          	auipc	a1,0x6
ffffffffc0208226:	6c658593          	addi	a1,a1,1734 # ffffffffc020e8e8 <syscalls+0xbd8>
ffffffffc020822a:	833ff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc020822e:	783c                	ld	a5,112(s0)
ffffffffc0208230:	65c2                	ld	a1,16(sp)
ffffffffc0208232:	6562                	ld	a0,24(sp)
ffffffffc0208234:	77bc                	ld	a5,104(a5)
ffffffffc0208236:	4034d613          	srai	a2,s1,0x3
ffffffffc020823a:	0034                	addi	a3,sp,8
ffffffffc020823c:	8a05                	andi	a2,a2,1
ffffffffc020823e:	9782                	jalr	a5
ffffffffc0208240:	b789                	j	ffffffffc0208182 <vfs_open+0x42>
ffffffffc0208242:	5475                	li	s0,-3
ffffffffc0208244:	b755                	j	ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208246:	0105fa93          	andi	s5,a1,16
ffffffffc020824a:	5475                	li	s0,-3
ffffffffc020824c:	f80a9ee3          	bnez	s5,ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208250:	bf21                	j	ffffffffc0208168 <vfs_open+0x28>
ffffffffc0208252:	6522                	ld	a0,8(sp)
ffffffffc0208254:	843e                	mv	s0,a5
ffffffffc0208256:	965ff0ef          	jal	ra,ffffffffc0207bba <inode_open_dec>
ffffffffc020825a:	6522                	ld	a0,8(sp)
ffffffffc020825c:	8b7ff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc0208260:	b761                	j	ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208262:	5425                	li	s0,-23
ffffffffc0208264:	b751                	j	ffffffffc02081e8 <vfs_open+0xa8>
ffffffffc0208266:	00006697          	auipc	a3,0x6
ffffffffc020826a:	69a68693          	addi	a3,a3,1690 # ffffffffc020e900 <syscalls+0xbf0>
ffffffffc020826e:	00004617          	auipc	a2,0x4
ffffffffc0208272:	8ea60613          	addi	a2,a2,-1814 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208276:	03300593          	li	a1,51
ffffffffc020827a:	00006517          	auipc	a0,0x6
ffffffffc020827e:	65650513          	addi	a0,a0,1622 # ffffffffc020e8d0 <syscalls+0xbc0>
ffffffffc0208282:	a1cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208286:	00006697          	auipc	a3,0x6
ffffffffc020828a:	6d268693          	addi	a3,a3,1746 # ffffffffc020e958 <syscalls+0xc48>
ffffffffc020828e:	00004617          	auipc	a2,0x4
ffffffffc0208292:	8ca60613          	addi	a2,a2,-1846 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208296:	03a00593          	li	a1,58
ffffffffc020829a:	00006517          	auipc	a0,0x6
ffffffffc020829e:	63650513          	addi	a0,a0,1590 # ffffffffc020e8d0 <syscalls+0xbc0>
ffffffffc02082a2:	9fcf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082a6:	00006697          	auipc	a3,0x6
ffffffffc02082aa:	64a68693          	addi	a3,a3,1610 # ffffffffc020e8f0 <syscalls+0xbe0>
ffffffffc02082ae:	00004617          	auipc	a2,0x4
ffffffffc02082b2:	8aa60613          	addi	a2,a2,-1878 # ffffffffc020bb58 <commands+0x210>
ffffffffc02082b6:	03100593          	li	a1,49
ffffffffc02082ba:	00006517          	auipc	a0,0x6
ffffffffc02082be:	61650513          	addi	a0,a0,1558 # ffffffffc020e8d0 <syscalls+0xbc0>
ffffffffc02082c2:	9dcf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082c6:	00006697          	auipc	a3,0x6
ffffffffc02082ca:	5ba68693          	addi	a3,a3,1466 # ffffffffc020e880 <syscalls+0xb70>
ffffffffc02082ce:	00004617          	auipc	a2,0x4
ffffffffc02082d2:	88a60613          	addi	a2,a2,-1910 # ffffffffc020bb58 <commands+0x210>
ffffffffc02082d6:	02c00593          	li	a1,44
ffffffffc02082da:	00006517          	auipc	a0,0x6
ffffffffc02082de:	5f650513          	addi	a0,a0,1526 # ffffffffc020e8d0 <syscalls+0xbc0>
ffffffffc02082e2:	9bcf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02082e6 <vfs_close>:
ffffffffc02082e6:	1141                	addi	sp,sp,-16
ffffffffc02082e8:	e406                	sd	ra,8(sp)
ffffffffc02082ea:	e022                	sd	s0,0(sp)
ffffffffc02082ec:	842a                	mv	s0,a0
ffffffffc02082ee:	8cdff0ef          	jal	ra,ffffffffc0207bba <inode_open_dec>
ffffffffc02082f2:	8522                	mv	a0,s0
ffffffffc02082f4:	81fff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc02082f8:	60a2                	ld	ra,8(sp)
ffffffffc02082fa:	6402                	ld	s0,0(sp)
ffffffffc02082fc:	4501                	li	a0,0
ffffffffc02082fe:	0141                	addi	sp,sp,16
ffffffffc0208300:	8082                	ret

ffffffffc0208302 <get_device>:
ffffffffc0208302:	7179                	addi	sp,sp,-48
ffffffffc0208304:	ec26                	sd	s1,24(sp)
ffffffffc0208306:	e84a                	sd	s2,16(sp)
ffffffffc0208308:	f406                	sd	ra,40(sp)
ffffffffc020830a:	f022                	sd	s0,32(sp)
ffffffffc020830c:	00054303          	lbu	t1,0(a0)
ffffffffc0208310:	892e                	mv	s2,a1
ffffffffc0208312:	84b2                	mv	s1,a2
ffffffffc0208314:	02030463          	beqz	t1,ffffffffc020833c <get_device+0x3a>
ffffffffc0208318:	00150413          	addi	s0,a0,1
ffffffffc020831c:	86a2                	mv	a3,s0
ffffffffc020831e:	879a                	mv	a5,t1
ffffffffc0208320:	4701                	li	a4,0
ffffffffc0208322:	03a00813          	li	a6,58
ffffffffc0208326:	02f00893          	li	a7,47
ffffffffc020832a:	03078263          	beq	a5,a6,ffffffffc020834e <get_device+0x4c>
ffffffffc020832e:	05178963          	beq	a5,a7,ffffffffc0208380 <get_device+0x7e>
ffffffffc0208332:	0006c783          	lbu	a5,0(a3)
ffffffffc0208336:	2705                	addiw	a4,a4,1
ffffffffc0208338:	0685                	addi	a3,a3,1
ffffffffc020833a:	fbe5                	bnez	a5,ffffffffc020832a <get_device+0x28>
ffffffffc020833c:	7402                	ld	s0,32(sp)
ffffffffc020833e:	00a93023          	sd	a0,0(s2)
ffffffffc0208342:	70a2                	ld	ra,40(sp)
ffffffffc0208344:	6942                	ld	s2,16(sp)
ffffffffc0208346:	8526                	mv	a0,s1
ffffffffc0208348:	64e2                	ld	s1,24(sp)
ffffffffc020834a:	6145                	addi	sp,sp,48
ffffffffc020834c:	a279                	j	ffffffffc02084da <vfs_get_curdir>
ffffffffc020834e:	cb15                	beqz	a4,ffffffffc0208382 <get_device+0x80>
ffffffffc0208350:	00e507b3          	add	a5,a0,a4
ffffffffc0208354:	0705                	addi	a4,a4,1
ffffffffc0208356:	00078023          	sb	zero,0(a5)
ffffffffc020835a:	972a                	add	a4,a4,a0
ffffffffc020835c:	02f00613          	li	a2,47
ffffffffc0208360:	00074783          	lbu	a5,0(a4)
ffffffffc0208364:	86ba                	mv	a3,a4
ffffffffc0208366:	0705                	addi	a4,a4,1
ffffffffc0208368:	fec78ce3          	beq	a5,a2,ffffffffc0208360 <get_device+0x5e>
ffffffffc020836c:	7402                	ld	s0,32(sp)
ffffffffc020836e:	70a2                	ld	ra,40(sp)
ffffffffc0208370:	00d93023          	sd	a3,0(s2)
ffffffffc0208374:	85a6                	mv	a1,s1
ffffffffc0208376:	6942                	ld	s2,16(sp)
ffffffffc0208378:	64e2                	ld	s1,24(sp)
ffffffffc020837a:	6145                	addi	sp,sp,48
ffffffffc020837c:	ba9ff06f          	j	ffffffffc0207f24 <vfs_get_root>
ffffffffc0208380:	ff55                	bnez	a4,ffffffffc020833c <get_device+0x3a>
ffffffffc0208382:	02f00793          	li	a5,47
ffffffffc0208386:	04f30563          	beq	t1,a5,ffffffffc02083d0 <get_device+0xce>
ffffffffc020838a:	03a00793          	li	a5,58
ffffffffc020838e:	06f31663          	bne	t1,a5,ffffffffc02083fa <get_device+0xf8>
ffffffffc0208392:	0028                	addi	a0,sp,8
ffffffffc0208394:	146000ef          	jal	ra,ffffffffc02084da <vfs_get_curdir>
ffffffffc0208398:	e515                	bnez	a0,ffffffffc02083c4 <get_device+0xc2>
ffffffffc020839a:	67a2                	ld	a5,8(sp)
ffffffffc020839c:	77a8                	ld	a0,104(a5)
ffffffffc020839e:	cd15                	beqz	a0,ffffffffc02083da <get_device+0xd8>
ffffffffc02083a0:	617c                	ld	a5,192(a0)
ffffffffc02083a2:	9782                	jalr	a5
ffffffffc02083a4:	87aa                	mv	a5,a0
ffffffffc02083a6:	6522                	ld	a0,8(sp)
ffffffffc02083a8:	e09c                	sd	a5,0(s1)
ffffffffc02083aa:	f68ff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc02083ae:	02f00713          	li	a4,47
ffffffffc02083b2:	a011                	j	ffffffffc02083b6 <get_device+0xb4>
ffffffffc02083b4:	0405                	addi	s0,s0,1
ffffffffc02083b6:	00044783          	lbu	a5,0(s0)
ffffffffc02083ba:	fee78de3          	beq	a5,a4,ffffffffc02083b4 <get_device+0xb2>
ffffffffc02083be:	00893023          	sd	s0,0(s2)
ffffffffc02083c2:	4501                	li	a0,0
ffffffffc02083c4:	70a2                	ld	ra,40(sp)
ffffffffc02083c6:	7402                	ld	s0,32(sp)
ffffffffc02083c8:	64e2                	ld	s1,24(sp)
ffffffffc02083ca:	6942                	ld	s2,16(sp)
ffffffffc02083cc:	6145                	addi	sp,sp,48
ffffffffc02083ce:	8082                	ret
ffffffffc02083d0:	8526                	mv	a0,s1
ffffffffc02083d2:	93fff0ef          	jal	ra,ffffffffc0207d10 <vfs_get_bootfs>
ffffffffc02083d6:	dd61                	beqz	a0,ffffffffc02083ae <get_device+0xac>
ffffffffc02083d8:	b7f5                	j	ffffffffc02083c4 <get_device+0xc2>
ffffffffc02083da:	00006697          	auipc	a3,0x6
ffffffffc02083de:	60e68693          	addi	a3,a3,1550 # ffffffffc020e9e8 <syscalls+0xcd8>
ffffffffc02083e2:	00003617          	auipc	a2,0x3
ffffffffc02083e6:	77660613          	addi	a2,a2,1910 # ffffffffc020bb58 <commands+0x210>
ffffffffc02083ea:	03900593          	li	a1,57
ffffffffc02083ee:	00006517          	auipc	a0,0x6
ffffffffc02083f2:	5e250513          	addi	a0,a0,1506 # ffffffffc020e9d0 <syscalls+0xcc0>
ffffffffc02083f6:	8a8f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02083fa:	00006697          	auipc	a3,0x6
ffffffffc02083fe:	5c668693          	addi	a3,a3,1478 # ffffffffc020e9c0 <syscalls+0xcb0>
ffffffffc0208402:	00003617          	auipc	a2,0x3
ffffffffc0208406:	75660613          	addi	a2,a2,1878 # ffffffffc020bb58 <commands+0x210>
ffffffffc020840a:	03300593          	li	a1,51
ffffffffc020840e:	00006517          	auipc	a0,0x6
ffffffffc0208412:	5c250513          	addi	a0,a0,1474 # ffffffffc020e9d0 <syscalls+0xcc0>
ffffffffc0208416:	888f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020841a <vfs_lookup>:
ffffffffc020841a:	7139                	addi	sp,sp,-64
ffffffffc020841c:	f426                	sd	s1,40(sp)
ffffffffc020841e:	0830                	addi	a2,sp,24
ffffffffc0208420:	84ae                	mv	s1,a1
ffffffffc0208422:	002c                	addi	a1,sp,8
ffffffffc0208424:	f822                	sd	s0,48(sp)
ffffffffc0208426:	fc06                	sd	ra,56(sp)
ffffffffc0208428:	f04a                	sd	s2,32(sp)
ffffffffc020842a:	e42a                	sd	a0,8(sp)
ffffffffc020842c:	ed7ff0ef          	jal	ra,ffffffffc0208302 <get_device>
ffffffffc0208430:	842a                	mv	s0,a0
ffffffffc0208432:	ed1d                	bnez	a0,ffffffffc0208470 <vfs_lookup+0x56>
ffffffffc0208434:	67a2                	ld	a5,8(sp)
ffffffffc0208436:	6962                	ld	s2,24(sp)
ffffffffc0208438:	0007c783          	lbu	a5,0(a5)
ffffffffc020843c:	c3a9                	beqz	a5,ffffffffc020847e <vfs_lookup+0x64>
ffffffffc020843e:	04090963          	beqz	s2,ffffffffc0208490 <vfs_lookup+0x76>
ffffffffc0208442:	07093783          	ld	a5,112(s2)
ffffffffc0208446:	c7a9                	beqz	a5,ffffffffc0208490 <vfs_lookup+0x76>
ffffffffc0208448:	7bbc                	ld	a5,112(a5)
ffffffffc020844a:	c3b9                	beqz	a5,ffffffffc0208490 <vfs_lookup+0x76>
ffffffffc020844c:	854a                	mv	a0,s2
ffffffffc020844e:	00006597          	auipc	a1,0x6
ffffffffc0208452:	60258593          	addi	a1,a1,1538 # ffffffffc020ea50 <syscalls+0xd40>
ffffffffc0208456:	e06ff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc020845a:	07093783          	ld	a5,112(s2)
ffffffffc020845e:	65a2                	ld	a1,8(sp)
ffffffffc0208460:	6562                	ld	a0,24(sp)
ffffffffc0208462:	7bbc                	ld	a5,112(a5)
ffffffffc0208464:	8626                	mv	a2,s1
ffffffffc0208466:	9782                	jalr	a5
ffffffffc0208468:	842a                	mv	s0,a0
ffffffffc020846a:	6562                	ld	a0,24(sp)
ffffffffc020846c:	ea6ff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc0208470:	70e2                	ld	ra,56(sp)
ffffffffc0208472:	8522                	mv	a0,s0
ffffffffc0208474:	7442                	ld	s0,48(sp)
ffffffffc0208476:	74a2                	ld	s1,40(sp)
ffffffffc0208478:	7902                	ld	s2,32(sp)
ffffffffc020847a:	6121                	addi	sp,sp,64
ffffffffc020847c:	8082                	ret
ffffffffc020847e:	70e2                	ld	ra,56(sp)
ffffffffc0208480:	8522                	mv	a0,s0
ffffffffc0208482:	7442                	ld	s0,48(sp)
ffffffffc0208484:	0124b023          	sd	s2,0(s1)
ffffffffc0208488:	74a2                	ld	s1,40(sp)
ffffffffc020848a:	7902                	ld	s2,32(sp)
ffffffffc020848c:	6121                	addi	sp,sp,64
ffffffffc020848e:	8082                	ret
ffffffffc0208490:	00006697          	auipc	a3,0x6
ffffffffc0208494:	57068693          	addi	a3,a3,1392 # ffffffffc020ea00 <syscalls+0xcf0>
ffffffffc0208498:	00003617          	auipc	a2,0x3
ffffffffc020849c:	6c060613          	addi	a2,a2,1728 # ffffffffc020bb58 <commands+0x210>
ffffffffc02084a0:	04f00593          	li	a1,79
ffffffffc02084a4:	00006517          	auipc	a0,0x6
ffffffffc02084a8:	52c50513          	addi	a0,a0,1324 # ffffffffc020e9d0 <syscalls+0xcc0>
ffffffffc02084ac:	ff3f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02084b0 <vfs_lookup_parent>:
ffffffffc02084b0:	7139                	addi	sp,sp,-64
ffffffffc02084b2:	f822                	sd	s0,48(sp)
ffffffffc02084b4:	f426                	sd	s1,40(sp)
ffffffffc02084b6:	842e                	mv	s0,a1
ffffffffc02084b8:	84b2                	mv	s1,a2
ffffffffc02084ba:	002c                	addi	a1,sp,8
ffffffffc02084bc:	0830                	addi	a2,sp,24
ffffffffc02084be:	fc06                	sd	ra,56(sp)
ffffffffc02084c0:	e42a                	sd	a0,8(sp)
ffffffffc02084c2:	e41ff0ef          	jal	ra,ffffffffc0208302 <get_device>
ffffffffc02084c6:	e509                	bnez	a0,ffffffffc02084d0 <vfs_lookup_parent+0x20>
ffffffffc02084c8:	67a2                	ld	a5,8(sp)
ffffffffc02084ca:	e09c                	sd	a5,0(s1)
ffffffffc02084cc:	67e2                	ld	a5,24(sp)
ffffffffc02084ce:	e01c                	sd	a5,0(s0)
ffffffffc02084d0:	70e2                	ld	ra,56(sp)
ffffffffc02084d2:	7442                	ld	s0,48(sp)
ffffffffc02084d4:	74a2                	ld	s1,40(sp)
ffffffffc02084d6:	6121                	addi	sp,sp,64
ffffffffc02084d8:	8082                	ret

ffffffffc02084da <vfs_get_curdir>:
ffffffffc02084da:	0008e797          	auipc	a5,0x8e
ffffffffc02084de:	3e67b783          	ld	a5,998(a5) # ffffffffc02968c0 <current>
ffffffffc02084e2:	1487b783          	ld	a5,328(a5)
ffffffffc02084e6:	1101                	addi	sp,sp,-32
ffffffffc02084e8:	e426                	sd	s1,8(sp)
ffffffffc02084ea:	6384                	ld	s1,0(a5)
ffffffffc02084ec:	ec06                	sd	ra,24(sp)
ffffffffc02084ee:	e822                	sd	s0,16(sp)
ffffffffc02084f0:	cc81                	beqz	s1,ffffffffc0208508 <vfs_get_curdir+0x2e>
ffffffffc02084f2:	842a                	mv	s0,a0
ffffffffc02084f4:	8526                	mv	a0,s1
ffffffffc02084f6:	d4eff0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc02084fa:	4501                	li	a0,0
ffffffffc02084fc:	e004                	sd	s1,0(s0)
ffffffffc02084fe:	60e2                	ld	ra,24(sp)
ffffffffc0208500:	6442                	ld	s0,16(sp)
ffffffffc0208502:	64a2                	ld	s1,8(sp)
ffffffffc0208504:	6105                	addi	sp,sp,32
ffffffffc0208506:	8082                	ret
ffffffffc0208508:	5541                	li	a0,-16
ffffffffc020850a:	bfd5                	j	ffffffffc02084fe <vfs_get_curdir+0x24>

ffffffffc020850c <vfs_set_curdir>:
ffffffffc020850c:	7139                	addi	sp,sp,-64
ffffffffc020850e:	f04a                	sd	s2,32(sp)
ffffffffc0208510:	0008e917          	auipc	s2,0x8e
ffffffffc0208514:	3b090913          	addi	s2,s2,944 # ffffffffc02968c0 <current>
ffffffffc0208518:	00093783          	ld	a5,0(s2)
ffffffffc020851c:	f822                	sd	s0,48(sp)
ffffffffc020851e:	842a                	mv	s0,a0
ffffffffc0208520:	1487b503          	ld	a0,328(a5)
ffffffffc0208524:	ec4e                	sd	s3,24(sp)
ffffffffc0208526:	fc06                	sd	ra,56(sp)
ffffffffc0208528:	f426                	sd	s1,40(sp)
ffffffffc020852a:	bf7fc0ef          	jal	ra,ffffffffc0205120 <lock_files>
ffffffffc020852e:	00093783          	ld	a5,0(s2)
ffffffffc0208532:	1487b503          	ld	a0,328(a5)
ffffffffc0208536:	00053983          	ld	s3,0(a0)
ffffffffc020853a:	07340963          	beq	s0,s3,ffffffffc02085ac <vfs_set_curdir+0xa0>
ffffffffc020853e:	cc39                	beqz	s0,ffffffffc020859c <vfs_set_curdir+0x90>
ffffffffc0208540:	783c                	ld	a5,112(s0)
ffffffffc0208542:	c7bd                	beqz	a5,ffffffffc02085b0 <vfs_set_curdir+0xa4>
ffffffffc0208544:	6bbc                	ld	a5,80(a5)
ffffffffc0208546:	c7ad                	beqz	a5,ffffffffc02085b0 <vfs_set_curdir+0xa4>
ffffffffc0208548:	00006597          	auipc	a1,0x6
ffffffffc020854c:	57858593          	addi	a1,a1,1400 # ffffffffc020eac0 <syscalls+0xdb0>
ffffffffc0208550:	8522                	mv	a0,s0
ffffffffc0208552:	d0aff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0208556:	783c                	ld	a5,112(s0)
ffffffffc0208558:	006c                	addi	a1,sp,12
ffffffffc020855a:	8522                	mv	a0,s0
ffffffffc020855c:	6bbc                	ld	a5,80(a5)
ffffffffc020855e:	9782                	jalr	a5
ffffffffc0208560:	84aa                	mv	s1,a0
ffffffffc0208562:	e901                	bnez	a0,ffffffffc0208572 <vfs_set_curdir+0x66>
ffffffffc0208564:	47b2                	lw	a5,12(sp)
ffffffffc0208566:	669d                	lui	a3,0x7
ffffffffc0208568:	6709                	lui	a4,0x2
ffffffffc020856a:	8ff5                	and	a5,a5,a3
ffffffffc020856c:	54b9                	li	s1,-18
ffffffffc020856e:	02e78063          	beq	a5,a4,ffffffffc020858e <vfs_set_curdir+0x82>
ffffffffc0208572:	00093783          	ld	a5,0(s2)
ffffffffc0208576:	1487b503          	ld	a0,328(a5)
ffffffffc020857a:	badfc0ef          	jal	ra,ffffffffc0205126 <unlock_files>
ffffffffc020857e:	70e2                	ld	ra,56(sp)
ffffffffc0208580:	7442                	ld	s0,48(sp)
ffffffffc0208582:	7902                	ld	s2,32(sp)
ffffffffc0208584:	69e2                	ld	s3,24(sp)
ffffffffc0208586:	8526                	mv	a0,s1
ffffffffc0208588:	74a2                	ld	s1,40(sp)
ffffffffc020858a:	6121                	addi	sp,sp,64
ffffffffc020858c:	8082                	ret
ffffffffc020858e:	8522                	mv	a0,s0
ffffffffc0208590:	cb4ff0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc0208594:	00093783          	ld	a5,0(s2)
ffffffffc0208598:	1487b503          	ld	a0,328(a5)
ffffffffc020859c:	e100                	sd	s0,0(a0)
ffffffffc020859e:	4481                	li	s1,0
ffffffffc02085a0:	fc098de3          	beqz	s3,ffffffffc020857a <vfs_set_curdir+0x6e>
ffffffffc02085a4:	854e                	mv	a0,s3
ffffffffc02085a6:	d6cff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc02085aa:	b7e1                	j	ffffffffc0208572 <vfs_set_curdir+0x66>
ffffffffc02085ac:	4481                	li	s1,0
ffffffffc02085ae:	b7f1                	j	ffffffffc020857a <vfs_set_curdir+0x6e>
ffffffffc02085b0:	00006697          	auipc	a3,0x6
ffffffffc02085b4:	4a868693          	addi	a3,a3,1192 # ffffffffc020ea58 <syscalls+0xd48>
ffffffffc02085b8:	00003617          	auipc	a2,0x3
ffffffffc02085bc:	5a060613          	addi	a2,a2,1440 # ffffffffc020bb58 <commands+0x210>
ffffffffc02085c0:	04300593          	li	a1,67
ffffffffc02085c4:	00006517          	auipc	a0,0x6
ffffffffc02085c8:	4e450513          	addi	a0,a0,1252 # ffffffffc020eaa8 <syscalls+0xd98>
ffffffffc02085cc:	ed3f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02085d0 <vfs_chdir>:
ffffffffc02085d0:	1101                	addi	sp,sp,-32
ffffffffc02085d2:	002c                	addi	a1,sp,8
ffffffffc02085d4:	e822                	sd	s0,16(sp)
ffffffffc02085d6:	ec06                	sd	ra,24(sp)
ffffffffc02085d8:	e43ff0ef          	jal	ra,ffffffffc020841a <vfs_lookup>
ffffffffc02085dc:	842a                	mv	s0,a0
ffffffffc02085de:	c511                	beqz	a0,ffffffffc02085ea <vfs_chdir+0x1a>
ffffffffc02085e0:	60e2                	ld	ra,24(sp)
ffffffffc02085e2:	8522                	mv	a0,s0
ffffffffc02085e4:	6442                	ld	s0,16(sp)
ffffffffc02085e6:	6105                	addi	sp,sp,32
ffffffffc02085e8:	8082                	ret
ffffffffc02085ea:	6522                	ld	a0,8(sp)
ffffffffc02085ec:	f21ff0ef          	jal	ra,ffffffffc020850c <vfs_set_curdir>
ffffffffc02085f0:	842a                	mv	s0,a0
ffffffffc02085f2:	6522                	ld	a0,8(sp)
ffffffffc02085f4:	d1eff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc02085f8:	60e2                	ld	ra,24(sp)
ffffffffc02085fa:	8522                	mv	a0,s0
ffffffffc02085fc:	6442                	ld	s0,16(sp)
ffffffffc02085fe:	6105                	addi	sp,sp,32
ffffffffc0208600:	8082                	ret

ffffffffc0208602 <vfs_getcwd>:
ffffffffc0208602:	0008e797          	auipc	a5,0x8e
ffffffffc0208606:	2be7b783          	ld	a5,702(a5) # ffffffffc02968c0 <current>
ffffffffc020860a:	1487b783          	ld	a5,328(a5)
ffffffffc020860e:	7179                	addi	sp,sp,-48
ffffffffc0208610:	ec26                	sd	s1,24(sp)
ffffffffc0208612:	6384                	ld	s1,0(a5)
ffffffffc0208614:	f406                	sd	ra,40(sp)
ffffffffc0208616:	f022                	sd	s0,32(sp)
ffffffffc0208618:	e84a                	sd	s2,16(sp)
ffffffffc020861a:	ccbd                	beqz	s1,ffffffffc0208698 <vfs_getcwd+0x96>
ffffffffc020861c:	892a                	mv	s2,a0
ffffffffc020861e:	8526                	mv	a0,s1
ffffffffc0208620:	c24ff0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc0208624:	74a8                	ld	a0,104(s1)
ffffffffc0208626:	c93d                	beqz	a0,ffffffffc020869c <vfs_getcwd+0x9a>
ffffffffc0208628:	9b3ff0ef          	jal	ra,ffffffffc0207fda <vfs_get_devname>
ffffffffc020862c:	842a                	mv	s0,a0
ffffffffc020862e:	7a7020ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc0208632:	862a                	mv	a2,a0
ffffffffc0208634:	85a2                	mv	a1,s0
ffffffffc0208636:	4701                	li	a4,0
ffffffffc0208638:	4685                	li	a3,1
ffffffffc020863a:	854a                	mv	a0,s2
ffffffffc020863c:	d0ffc0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc0208640:	842a                	mv	s0,a0
ffffffffc0208642:	c919                	beqz	a0,ffffffffc0208658 <vfs_getcwd+0x56>
ffffffffc0208644:	8526                	mv	a0,s1
ffffffffc0208646:	cccff0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020864a:	70a2                	ld	ra,40(sp)
ffffffffc020864c:	8522                	mv	a0,s0
ffffffffc020864e:	7402                	ld	s0,32(sp)
ffffffffc0208650:	64e2                	ld	s1,24(sp)
ffffffffc0208652:	6942                	ld	s2,16(sp)
ffffffffc0208654:	6145                	addi	sp,sp,48
ffffffffc0208656:	8082                	ret
ffffffffc0208658:	03a00793          	li	a5,58
ffffffffc020865c:	4701                	li	a4,0
ffffffffc020865e:	4685                	li	a3,1
ffffffffc0208660:	4605                	li	a2,1
ffffffffc0208662:	00f10593          	addi	a1,sp,15
ffffffffc0208666:	854a                	mv	a0,s2
ffffffffc0208668:	00f107a3          	sb	a5,15(sp)
ffffffffc020866c:	cdffc0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc0208670:	842a                	mv	s0,a0
ffffffffc0208672:	f969                	bnez	a0,ffffffffc0208644 <vfs_getcwd+0x42>
ffffffffc0208674:	78bc                	ld	a5,112(s1)
ffffffffc0208676:	c3b9                	beqz	a5,ffffffffc02086bc <vfs_getcwd+0xba>
ffffffffc0208678:	7f9c                	ld	a5,56(a5)
ffffffffc020867a:	c3a9                	beqz	a5,ffffffffc02086bc <vfs_getcwd+0xba>
ffffffffc020867c:	00006597          	auipc	a1,0x6
ffffffffc0208680:	4a458593          	addi	a1,a1,1188 # ffffffffc020eb20 <syscalls+0xe10>
ffffffffc0208684:	8526                	mv	a0,s1
ffffffffc0208686:	bd6ff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc020868a:	78bc                	ld	a5,112(s1)
ffffffffc020868c:	85ca                	mv	a1,s2
ffffffffc020868e:	8526                	mv	a0,s1
ffffffffc0208690:	7f9c                	ld	a5,56(a5)
ffffffffc0208692:	9782                	jalr	a5
ffffffffc0208694:	842a                	mv	s0,a0
ffffffffc0208696:	b77d                	j	ffffffffc0208644 <vfs_getcwd+0x42>
ffffffffc0208698:	5441                	li	s0,-16
ffffffffc020869a:	bf45                	j	ffffffffc020864a <vfs_getcwd+0x48>
ffffffffc020869c:	00006697          	auipc	a3,0x6
ffffffffc02086a0:	34c68693          	addi	a3,a3,844 # ffffffffc020e9e8 <syscalls+0xcd8>
ffffffffc02086a4:	00003617          	auipc	a2,0x3
ffffffffc02086a8:	4b460613          	addi	a2,a2,1204 # ffffffffc020bb58 <commands+0x210>
ffffffffc02086ac:	06e00593          	li	a1,110
ffffffffc02086b0:	00006517          	auipc	a0,0x6
ffffffffc02086b4:	3f850513          	addi	a0,a0,1016 # ffffffffc020eaa8 <syscalls+0xd98>
ffffffffc02086b8:	de7f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02086bc:	00006697          	auipc	a3,0x6
ffffffffc02086c0:	40c68693          	addi	a3,a3,1036 # ffffffffc020eac8 <syscalls+0xdb8>
ffffffffc02086c4:	00003617          	auipc	a2,0x3
ffffffffc02086c8:	49460613          	addi	a2,a2,1172 # ffffffffc020bb58 <commands+0x210>
ffffffffc02086cc:	07800593          	li	a1,120
ffffffffc02086d0:	00006517          	auipc	a0,0x6
ffffffffc02086d4:	3d850513          	addi	a0,a0,984 # ffffffffc020eaa8 <syscalls+0xd98>
ffffffffc02086d8:	dc7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02086dc <dev_lookup>:
ffffffffc02086dc:	0005c783          	lbu	a5,0(a1)
ffffffffc02086e0:	e385                	bnez	a5,ffffffffc0208700 <dev_lookup+0x24>
ffffffffc02086e2:	1101                	addi	sp,sp,-32
ffffffffc02086e4:	e822                	sd	s0,16(sp)
ffffffffc02086e6:	e426                	sd	s1,8(sp)
ffffffffc02086e8:	ec06                	sd	ra,24(sp)
ffffffffc02086ea:	84aa                	mv	s1,a0
ffffffffc02086ec:	8432                	mv	s0,a2
ffffffffc02086ee:	b56ff0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc02086f2:	60e2                	ld	ra,24(sp)
ffffffffc02086f4:	e004                	sd	s1,0(s0)
ffffffffc02086f6:	6442                	ld	s0,16(sp)
ffffffffc02086f8:	64a2                	ld	s1,8(sp)
ffffffffc02086fa:	4501                	li	a0,0
ffffffffc02086fc:	6105                	addi	sp,sp,32
ffffffffc02086fe:	8082                	ret
ffffffffc0208700:	5541                	li	a0,-16
ffffffffc0208702:	8082                	ret

ffffffffc0208704 <dev_fstat>:
ffffffffc0208704:	1101                	addi	sp,sp,-32
ffffffffc0208706:	e426                	sd	s1,8(sp)
ffffffffc0208708:	84ae                	mv	s1,a1
ffffffffc020870a:	e822                	sd	s0,16(sp)
ffffffffc020870c:	02000613          	li	a2,32
ffffffffc0208710:	842a                	mv	s0,a0
ffffffffc0208712:	4581                	li	a1,0
ffffffffc0208714:	8526                	mv	a0,s1
ffffffffc0208716:	ec06                	sd	ra,24(sp)
ffffffffc0208718:	75f020ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020871c:	c429                	beqz	s0,ffffffffc0208766 <dev_fstat+0x62>
ffffffffc020871e:	783c                	ld	a5,112(s0)
ffffffffc0208720:	c3b9                	beqz	a5,ffffffffc0208766 <dev_fstat+0x62>
ffffffffc0208722:	6bbc                	ld	a5,80(a5)
ffffffffc0208724:	c3a9                	beqz	a5,ffffffffc0208766 <dev_fstat+0x62>
ffffffffc0208726:	00006597          	auipc	a1,0x6
ffffffffc020872a:	39a58593          	addi	a1,a1,922 # ffffffffc020eac0 <syscalls+0xdb0>
ffffffffc020872e:	8522                	mv	a0,s0
ffffffffc0208730:	b2cff0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0208734:	783c                	ld	a5,112(s0)
ffffffffc0208736:	85a6                	mv	a1,s1
ffffffffc0208738:	8522                	mv	a0,s0
ffffffffc020873a:	6bbc                	ld	a5,80(a5)
ffffffffc020873c:	9782                	jalr	a5
ffffffffc020873e:	ed19                	bnez	a0,ffffffffc020875c <dev_fstat+0x58>
ffffffffc0208740:	4c38                	lw	a4,88(s0)
ffffffffc0208742:	6785                	lui	a5,0x1
ffffffffc0208744:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208748:	02f71f63          	bne	a4,a5,ffffffffc0208786 <dev_fstat+0x82>
ffffffffc020874c:	6018                	ld	a4,0(s0)
ffffffffc020874e:	641c                	ld	a5,8(s0)
ffffffffc0208750:	4685                	li	a3,1
ffffffffc0208752:	e494                	sd	a3,8(s1)
ffffffffc0208754:	02e787b3          	mul	a5,a5,a4
ffffffffc0208758:	e898                	sd	a4,16(s1)
ffffffffc020875a:	ec9c                	sd	a5,24(s1)
ffffffffc020875c:	60e2                	ld	ra,24(sp)
ffffffffc020875e:	6442                	ld	s0,16(sp)
ffffffffc0208760:	64a2                	ld	s1,8(sp)
ffffffffc0208762:	6105                	addi	sp,sp,32
ffffffffc0208764:	8082                	ret
ffffffffc0208766:	00006697          	auipc	a3,0x6
ffffffffc020876a:	2f268693          	addi	a3,a3,754 # ffffffffc020ea58 <syscalls+0xd48>
ffffffffc020876e:	00003617          	auipc	a2,0x3
ffffffffc0208772:	3ea60613          	addi	a2,a2,1002 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208776:	04200593          	li	a1,66
ffffffffc020877a:	00006517          	auipc	a0,0x6
ffffffffc020877e:	3b650513          	addi	a0,a0,950 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc0208782:	d1df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208786:	00006697          	auipc	a3,0x6
ffffffffc020878a:	09a68693          	addi	a3,a3,154 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc020878e:	00003617          	auipc	a2,0x3
ffffffffc0208792:	3ca60613          	addi	a2,a2,970 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208796:	04500593          	li	a1,69
ffffffffc020879a:	00006517          	auipc	a0,0x6
ffffffffc020879e:	39650513          	addi	a0,a0,918 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc02087a2:	cfdf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02087a6 <dev_ioctl>:
ffffffffc02087a6:	c909                	beqz	a0,ffffffffc02087b8 <dev_ioctl+0x12>
ffffffffc02087a8:	4d34                	lw	a3,88(a0)
ffffffffc02087aa:	6705                	lui	a4,0x1
ffffffffc02087ac:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02087b0:	00e69463          	bne	a3,a4,ffffffffc02087b8 <dev_ioctl+0x12>
ffffffffc02087b4:	751c                	ld	a5,40(a0)
ffffffffc02087b6:	8782                	jr	a5
ffffffffc02087b8:	1141                	addi	sp,sp,-16
ffffffffc02087ba:	00006697          	auipc	a3,0x6
ffffffffc02087be:	06668693          	addi	a3,a3,102 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc02087c2:	00003617          	auipc	a2,0x3
ffffffffc02087c6:	39660613          	addi	a2,a2,918 # ffffffffc020bb58 <commands+0x210>
ffffffffc02087ca:	03500593          	li	a1,53
ffffffffc02087ce:	00006517          	auipc	a0,0x6
ffffffffc02087d2:	36250513          	addi	a0,a0,866 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc02087d6:	e406                	sd	ra,8(sp)
ffffffffc02087d8:	cc7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02087dc <dev_tryseek>:
ffffffffc02087dc:	c51d                	beqz	a0,ffffffffc020880a <dev_tryseek+0x2e>
ffffffffc02087de:	4d38                	lw	a4,88(a0)
ffffffffc02087e0:	6785                	lui	a5,0x1
ffffffffc02087e2:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02087e6:	02f71263          	bne	a4,a5,ffffffffc020880a <dev_tryseek+0x2e>
ffffffffc02087ea:	611c                	ld	a5,0(a0)
ffffffffc02087ec:	cf89                	beqz	a5,ffffffffc0208806 <dev_tryseek+0x2a>
ffffffffc02087ee:	6518                	ld	a4,8(a0)
ffffffffc02087f0:	02e5f6b3          	remu	a3,a1,a4
ffffffffc02087f4:	ea89                	bnez	a3,ffffffffc0208806 <dev_tryseek+0x2a>
ffffffffc02087f6:	0005c863          	bltz	a1,ffffffffc0208806 <dev_tryseek+0x2a>
ffffffffc02087fa:	02e787b3          	mul	a5,a5,a4
ffffffffc02087fe:	00f5f463          	bgeu	a1,a5,ffffffffc0208806 <dev_tryseek+0x2a>
ffffffffc0208802:	4501                	li	a0,0
ffffffffc0208804:	8082                	ret
ffffffffc0208806:	5575                	li	a0,-3
ffffffffc0208808:	8082                	ret
ffffffffc020880a:	1141                	addi	sp,sp,-16
ffffffffc020880c:	00006697          	auipc	a3,0x6
ffffffffc0208810:	01468693          	addi	a3,a3,20 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc0208814:	00003617          	auipc	a2,0x3
ffffffffc0208818:	34460613          	addi	a2,a2,836 # ffffffffc020bb58 <commands+0x210>
ffffffffc020881c:	05f00593          	li	a1,95
ffffffffc0208820:	00006517          	auipc	a0,0x6
ffffffffc0208824:	31050513          	addi	a0,a0,784 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc0208828:	e406                	sd	ra,8(sp)
ffffffffc020882a:	c75f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020882e <dev_gettype>:
ffffffffc020882e:	c10d                	beqz	a0,ffffffffc0208850 <dev_gettype+0x22>
ffffffffc0208830:	4d38                	lw	a4,88(a0)
ffffffffc0208832:	6785                	lui	a5,0x1
ffffffffc0208834:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208838:	00f71c63          	bne	a4,a5,ffffffffc0208850 <dev_gettype+0x22>
ffffffffc020883c:	6118                	ld	a4,0(a0)
ffffffffc020883e:	6795                	lui	a5,0x5
ffffffffc0208840:	c701                	beqz	a4,ffffffffc0208848 <dev_gettype+0x1a>
ffffffffc0208842:	c19c                	sw	a5,0(a1)
ffffffffc0208844:	4501                	li	a0,0
ffffffffc0208846:	8082                	ret
ffffffffc0208848:	6791                	lui	a5,0x4
ffffffffc020884a:	c19c                	sw	a5,0(a1)
ffffffffc020884c:	4501                	li	a0,0
ffffffffc020884e:	8082                	ret
ffffffffc0208850:	1141                	addi	sp,sp,-16
ffffffffc0208852:	00006697          	auipc	a3,0x6
ffffffffc0208856:	fce68693          	addi	a3,a3,-50 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc020885a:	00003617          	auipc	a2,0x3
ffffffffc020885e:	2fe60613          	addi	a2,a2,766 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208862:	05300593          	li	a1,83
ffffffffc0208866:	00006517          	auipc	a0,0x6
ffffffffc020886a:	2ca50513          	addi	a0,a0,714 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc020886e:	e406                	sd	ra,8(sp)
ffffffffc0208870:	c2ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208874 <dev_write>:
ffffffffc0208874:	c911                	beqz	a0,ffffffffc0208888 <dev_write+0x14>
ffffffffc0208876:	4d34                	lw	a3,88(a0)
ffffffffc0208878:	6705                	lui	a4,0x1
ffffffffc020887a:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020887e:	00e69563          	bne	a3,a4,ffffffffc0208888 <dev_write+0x14>
ffffffffc0208882:	711c                	ld	a5,32(a0)
ffffffffc0208884:	4605                	li	a2,1
ffffffffc0208886:	8782                	jr	a5
ffffffffc0208888:	1141                	addi	sp,sp,-16
ffffffffc020888a:	00006697          	auipc	a3,0x6
ffffffffc020888e:	f9668693          	addi	a3,a3,-106 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc0208892:	00003617          	auipc	a2,0x3
ffffffffc0208896:	2c660613          	addi	a2,a2,710 # ffffffffc020bb58 <commands+0x210>
ffffffffc020889a:	02c00593          	li	a1,44
ffffffffc020889e:	00006517          	auipc	a0,0x6
ffffffffc02088a2:	29250513          	addi	a0,a0,658 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc02088a6:	e406                	sd	ra,8(sp)
ffffffffc02088a8:	bf7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02088ac <dev_read>:
ffffffffc02088ac:	c911                	beqz	a0,ffffffffc02088c0 <dev_read+0x14>
ffffffffc02088ae:	4d34                	lw	a3,88(a0)
ffffffffc02088b0:	6705                	lui	a4,0x1
ffffffffc02088b2:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02088b6:	00e69563          	bne	a3,a4,ffffffffc02088c0 <dev_read+0x14>
ffffffffc02088ba:	711c                	ld	a5,32(a0)
ffffffffc02088bc:	4601                	li	a2,0
ffffffffc02088be:	8782                	jr	a5
ffffffffc02088c0:	1141                	addi	sp,sp,-16
ffffffffc02088c2:	00006697          	auipc	a3,0x6
ffffffffc02088c6:	f5e68693          	addi	a3,a3,-162 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc02088ca:	00003617          	auipc	a2,0x3
ffffffffc02088ce:	28e60613          	addi	a2,a2,654 # ffffffffc020bb58 <commands+0x210>
ffffffffc02088d2:	02300593          	li	a1,35
ffffffffc02088d6:	00006517          	auipc	a0,0x6
ffffffffc02088da:	25a50513          	addi	a0,a0,602 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc02088de:	e406                	sd	ra,8(sp)
ffffffffc02088e0:	bbff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02088e4 <dev_close>:
ffffffffc02088e4:	c909                	beqz	a0,ffffffffc02088f6 <dev_close+0x12>
ffffffffc02088e6:	4d34                	lw	a3,88(a0)
ffffffffc02088e8:	6705                	lui	a4,0x1
ffffffffc02088ea:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02088ee:	00e69463          	bne	a3,a4,ffffffffc02088f6 <dev_close+0x12>
ffffffffc02088f2:	6d1c                	ld	a5,24(a0)
ffffffffc02088f4:	8782                	jr	a5
ffffffffc02088f6:	1141                	addi	sp,sp,-16
ffffffffc02088f8:	00006697          	auipc	a3,0x6
ffffffffc02088fc:	f2868693          	addi	a3,a3,-216 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc0208900:	00003617          	auipc	a2,0x3
ffffffffc0208904:	25860613          	addi	a2,a2,600 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208908:	45e9                	li	a1,26
ffffffffc020890a:	00006517          	auipc	a0,0x6
ffffffffc020890e:	22650513          	addi	a0,a0,550 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc0208912:	e406                	sd	ra,8(sp)
ffffffffc0208914:	b8bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208918 <dev_open>:
ffffffffc0208918:	03c5f713          	andi	a4,a1,60
ffffffffc020891c:	eb11                	bnez	a4,ffffffffc0208930 <dev_open+0x18>
ffffffffc020891e:	c919                	beqz	a0,ffffffffc0208934 <dev_open+0x1c>
ffffffffc0208920:	4d34                	lw	a3,88(a0)
ffffffffc0208922:	6705                	lui	a4,0x1
ffffffffc0208924:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208928:	00e69663          	bne	a3,a4,ffffffffc0208934 <dev_open+0x1c>
ffffffffc020892c:	691c                	ld	a5,16(a0)
ffffffffc020892e:	8782                	jr	a5
ffffffffc0208930:	5575                	li	a0,-3
ffffffffc0208932:	8082                	ret
ffffffffc0208934:	1141                	addi	sp,sp,-16
ffffffffc0208936:	00006697          	auipc	a3,0x6
ffffffffc020893a:	eea68693          	addi	a3,a3,-278 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc020893e:	00003617          	auipc	a2,0x3
ffffffffc0208942:	21a60613          	addi	a2,a2,538 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208946:	45c5                	li	a1,17
ffffffffc0208948:	00006517          	auipc	a0,0x6
ffffffffc020894c:	1e850513          	addi	a0,a0,488 # ffffffffc020eb30 <syscalls+0xe20>
ffffffffc0208950:	e406                	sd	ra,8(sp)
ffffffffc0208952:	b4df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208956 <dev_init>:
ffffffffc0208956:	1141                	addi	sp,sp,-16
ffffffffc0208958:	e406                	sd	ra,8(sp)
ffffffffc020895a:	542000ef          	jal	ra,ffffffffc0208e9c <dev_init_stdin>
ffffffffc020895e:	65a000ef          	jal	ra,ffffffffc0208fb8 <dev_init_stdout>
ffffffffc0208962:	60a2                	ld	ra,8(sp)
ffffffffc0208964:	0141                	addi	sp,sp,16
ffffffffc0208966:	a439                	j	ffffffffc0208b74 <dev_init_disk0>

ffffffffc0208968 <dev_create_inode>:
ffffffffc0208968:	6505                	lui	a0,0x1
ffffffffc020896a:	1141                	addi	sp,sp,-16
ffffffffc020896c:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208970:	e022                	sd	s0,0(sp)
ffffffffc0208972:	e406                	sd	ra,8(sp)
ffffffffc0208974:	852ff0ef          	jal	ra,ffffffffc02079c6 <__alloc_inode>
ffffffffc0208978:	842a                	mv	s0,a0
ffffffffc020897a:	c901                	beqz	a0,ffffffffc020898a <dev_create_inode+0x22>
ffffffffc020897c:	4601                	li	a2,0
ffffffffc020897e:	00006597          	auipc	a1,0x6
ffffffffc0208982:	1ca58593          	addi	a1,a1,458 # ffffffffc020eb48 <dev_node_ops>
ffffffffc0208986:	85cff0ef          	jal	ra,ffffffffc02079e2 <inode_init>
ffffffffc020898a:	60a2                	ld	ra,8(sp)
ffffffffc020898c:	8522                	mv	a0,s0
ffffffffc020898e:	6402                	ld	s0,0(sp)
ffffffffc0208990:	0141                	addi	sp,sp,16
ffffffffc0208992:	8082                	ret

ffffffffc0208994 <disk0_open>:
ffffffffc0208994:	4501                	li	a0,0
ffffffffc0208996:	8082                	ret

ffffffffc0208998 <disk0_close>:
ffffffffc0208998:	4501                	li	a0,0
ffffffffc020899a:	8082                	ret

ffffffffc020899c <disk0_ioctl>:
ffffffffc020899c:	5531                	li	a0,-20
ffffffffc020899e:	8082                	ret

ffffffffc02089a0 <disk0_io>:
ffffffffc02089a0:	659c                	ld	a5,8(a1)
ffffffffc02089a2:	7159                	addi	sp,sp,-112
ffffffffc02089a4:	eca6                	sd	s1,88(sp)
ffffffffc02089a6:	f45e                	sd	s7,40(sp)
ffffffffc02089a8:	6d84                	ld	s1,24(a1)
ffffffffc02089aa:	6b85                	lui	s7,0x1
ffffffffc02089ac:	1bfd                	addi	s7,s7,-1
ffffffffc02089ae:	e4ce                	sd	s3,72(sp)
ffffffffc02089b0:	43f7d993          	srai	s3,a5,0x3f
ffffffffc02089b4:	0179f9b3          	and	s3,s3,s7
ffffffffc02089b8:	99be                	add	s3,s3,a5
ffffffffc02089ba:	8fc5                	or	a5,a5,s1
ffffffffc02089bc:	f486                	sd	ra,104(sp)
ffffffffc02089be:	f0a2                	sd	s0,96(sp)
ffffffffc02089c0:	e8ca                	sd	s2,80(sp)
ffffffffc02089c2:	e0d2                	sd	s4,64(sp)
ffffffffc02089c4:	fc56                	sd	s5,56(sp)
ffffffffc02089c6:	f85a                	sd	s6,48(sp)
ffffffffc02089c8:	f062                	sd	s8,32(sp)
ffffffffc02089ca:	ec66                	sd	s9,24(sp)
ffffffffc02089cc:	e86a                	sd	s10,16(sp)
ffffffffc02089ce:	0177f7b3          	and	a5,a5,s7
ffffffffc02089d2:	10079d63          	bnez	a5,ffffffffc0208aec <disk0_io+0x14c>
ffffffffc02089d6:	40c9d993          	srai	s3,s3,0xc
ffffffffc02089da:	00c4d713          	srli	a4,s1,0xc
ffffffffc02089de:	2981                	sext.w	s3,s3
ffffffffc02089e0:	2701                	sext.w	a4,a4
ffffffffc02089e2:	00e987bb          	addw	a5,s3,a4
ffffffffc02089e6:	6114                	ld	a3,0(a0)
ffffffffc02089e8:	1782                	slli	a5,a5,0x20
ffffffffc02089ea:	9381                	srli	a5,a5,0x20
ffffffffc02089ec:	10f6e063          	bltu	a3,a5,ffffffffc0208aec <disk0_io+0x14c>
ffffffffc02089f0:	4501                	li	a0,0
ffffffffc02089f2:	ef19                	bnez	a4,ffffffffc0208a10 <disk0_io+0x70>
ffffffffc02089f4:	70a6                	ld	ra,104(sp)
ffffffffc02089f6:	7406                	ld	s0,96(sp)
ffffffffc02089f8:	64e6                	ld	s1,88(sp)
ffffffffc02089fa:	6946                	ld	s2,80(sp)
ffffffffc02089fc:	69a6                	ld	s3,72(sp)
ffffffffc02089fe:	6a06                	ld	s4,64(sp)
ffffffffc0208a00:	7ae2                	ld	s5,56(sp)
ffffffffc0208a02:	7b42                	ld	s6,48(sp)
ffffffffc0208a04:	7ba2                	ld	s7,40(sp)
ffffffffc0208a06:	7c02                	ld	s8,32(sp)
ffffffffc0208a08:	6ce2                	ld	s9,24(sp)
ffffffffc0208a0a:	6d42                	ld	s10,16(sp)
ffffffffc0208a0c:	6165                	addi	sp,sp,112
ffffffffc0208a0e:	8082                	ret
ffffffffc0208a10:	0008d517          	auipc	a0,0x8d
ffffffffc0208a14:	e3050513          	addi	a0,a0,-464 # ffffffffc0295840 <disk0_sem>
ffffffffc0208a18:	8b2e                	mv	s6,a1
ffffffffc0208a1a:	8c32                	mv	s8,a2
ffffffffc0208a1c:	0008ea97          	auipc	s5,0x8e
ffffffffc0208a20:	edca8a93          	addi	s5,s5,-292 # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208a24:	a9ffb0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0208a28:	6c91                	lui	s9,0x4
ffffffffc0208a2a:	e4b9                	bnez	s1,ffffffffc0208a78 <disk0_io+0xd8>
ffffffffc0208a2c:	a845                	j	ffffffffc0208adc <disk0_io+0x13c>
ffffffffc0208a2e:	00c4d413          	srli	s0,s1,0xc
ffffffffc0208a32:	0034169b          	slliw	a3,s0,0x3
ffffffffc0208a36:	00068d1b          	sext.w	s10,a3
ffffffffc0208a3a:	1682                	slli	a3,a3,0x20
ffffffffc0208a3c:	2401                	sext.w	s0,s0
ffffffffc0208a3e:	9281                	srli	a3,a3,0x20
ffffffffc0208a40:	8926                	mv	s2,s1
ffffffffc0208a42:	00399a1b          	slliw	s4,s3,0x3
ffffffffc0208a46:	862e                	mv	a2,a1
ffffffffc0208a48:	4509                	li	a0,2
ffffffffc0208a4a:	85d2                	mv	a1,s4
ffffffffc0208a4c:	8f4f80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208a50:	e165                	bnez	a0,ffffffffc0208b30 <disk0_io+0x190>
ffffffffc0208a52:	000ab583          	ld	a1,0(s5)
ffffffffc0208a56:	0038                	addi	a4,sp,8
ffffffffc0208a58:	4685                	li	a3,1
ffffffffc0208a5a:	864a                	mv	a2,s2
ffffffffc0208a5c:	855a                	mv	a0,s6
ffffffffc0208a5e:	8edfc0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc0208a62:	67a2                	ld	a5,8(sp)
ffffffffc0208a64:	09279663          	bne	a5,s2,ffffffffc0208af0 <disk0_io+0x150>
ffffffffc0208a68:	017977b3          	and	a5,s2,s7
ffffffffc0208a6c:	e3d1                	bnez	a5,ffffffffc0208af0 <disk0_io+0x150>
ffffffffc0208a6e:	412484b3          	sub	s1,s1,s2
ffffffffc0208a72:	013409bb          	addw	s3,s0,s3
ffffffffc0208a76:	c0bd                	beqz	s1,ffffffffc0208adc <disk0_io+0x13c>
ffffffffc0208a78:	000ab583          	ld	a1,0(s5)
ffffffffc0208a7c:	000c1b63          	bnez	s8,ffffffffc0208a92 <disk0_io+0xf2>
ffffffffc0208a80:	fb94e7e3          	bltu	s1,s9,ffffffffc0208a2e <disk0_io+0x8e>
ffffffffc0208a84:	02000693          	li	a3,32
ffffffffc0208a88:	02000d13          	li	s10,32
ffffffffc0208a8c:	4411                	li	s0,4
ffffffffc0208a8e:	6911                	lui	s2,0x4
ffffffffc0208a90:	bf4d                	j	ffffffffc0208a42 <disk0_io+0xa2>
ffffffffc0208a92:	0038                	addi	a4,sp,8
ffffffffc0208a94:	4681                	li	a3,0
ffffffffc0208a96:	6611                	lui	a2,0x4
ffffffffc0208a98:	855a                	mv	a0,s6
ffffffffc0208a9a:	8b1fc0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc0208a9e:	6422                	ld	s0,8(sp)
ffffffffc0208aa0:	c825                	beqz	s0,ffffffffc0208b10 <disk0_io+0x170>
ffffffffc0208aa2:	0684e763          	bltu	s1,s0,ffffffffc0208b10 <disk0_io+0x170>
ffffffffc0208aa6:	017477b3          	and	a5,s0,s7
ffffffffc0208aaa:	e3bd                	bnez	a5,ffffffffc0208b10 <disk0_io+0x170>
ffffffffc0208aac:	8031                	srli	s0,s0,0xc
ffffffffc0208aae:	0034179b          	slliw	a5,s0,0x3
ffffffffc0208ab2:	000ab603          	ld	a2,0(s5)
ffffffffc0208ab6:	0039991b          	slliw	s2,s3,0x3
ffffffffc0208aba:	02079693          	slli	a3,a5,0x20
ffffffffc0208abe:	9281                	srli	a3,a3,0x20
ffffffffc0208ac0:	85ca                	mv	a1,s2
ffffffffc0208ac2:	4509                	li	a0,2
ffffffffc0208ac4:	2401                	sext.w	s0,s0
ffffffffc0208ac6:	00078a1b          	sext.w	s4,a5
ffffffffc0208aca:	90cf80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208ace:	e151                	bnez	a0,ffffffffc0208b52 <disk0_io+0x1b2>
ffffffffc0208ad0:	6922                	ld	s2,8(sp)
ffffffffc0208ad2:	013409bb          	addw	s3,s0,s3
ffffffffc0208ad6:	412484b3          	sub	s1,s1,s2
ffffffffc0208ada:	fcd9                	bnez	s1,ffffffffc0208a78 <disk0_io+0xd8>
ffffffffc0208adc:	0008d517          	auipc	a0,0x8d
ffffffffc0208ae0:	d6450513          	addi	a0,a0,-668 # ffffffffc0295840 <disk0_sem>
ffffffffc0208ae4:	9dbfb0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0208ae8:	4501                	li	a0,0
ffffffffc0208aea:	b729                	j	ffffffffc02089f4 <disk0_io+0x54>
ffffffffc0208aec:	5575                	li	a0,-3
ffffffffc0208aee:	b719                	j	ffffffffc02089f4 <disk0_io+0x54>
ffffffffc0208af0:	00006697          	auipc	a3,0x6
ffffffffc0208af4:	1d068693          	addi	a3,a3,464 # ffffffffc020ecc0 <dev_node_ops+0x178>
ffffffffc0208af8:	00003617          	auipc	a2,0x3
ffffffffc0208afc:	06060613          	addi	a2,a2,96 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208b00:	06200593          	li	a1,98
ffffffffc0208b04:	00006517          	auipc	a0,0x6
ffffffffc0208b08:	10450513          	addi	a0,a0,260 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208b0c:	993f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b10:	00006697          	auipc	a3,0x6
ffffffffc0208b14:	0b868693          	addi	a3,a3,184 # ffffffffc020ebc8 <dev_node_ops+0x80>
ffffffffc0208b18:	00003617          	auipc	a2,0x3
ffffffffc0208b1c:	04060613          	addi	a2,a2,64 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208b20:	05700593          	li	a1,87
ffffffffc0208b24:	00006517          	auipc	a0,0x6
ffffffffc0208b28:	0e450513          	addi	a0,a0,228 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208b2c:	973f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b30:	88aa                	mv	a7,a0
ffffffffc0208b32:	886a                	mv	a6,s10
ffffffffc0208b34:	87a2                	mv	a5,s0
ffffffffc0208b36:	8752                	mv	a4,s4
ffffffffc0208b38:	86ce                	mv	a3,s3
ffffffffc0208b3a:	00006617          	auipc	a2,0x6
ffffffffc0208b3e:	13e60613          	addi	a2,a2,318 # ffffffffc020ec78 <dev_node_ops+0x130>
ffffffffc0208b42:	02d00593          	li	a1,45
ffffffffc0208b46:	00006517          	auipc	a0,0x6
ffffffffc0208b4a:	0c250513          	addi	a0,a0,194 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208b4e:	951f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b52:	88aa                	mv	a7,a0
ffffffffc0208b54:	8852                	mv	a6,s4
ffffffffc0208b56:	87a2                	mv	a5,s0
ffffffffc0208b58:	874a                	mv	a4,s2
ffffffffc0208b5a:	86ce                	mv	a3,s3
ffffffffc0208b5c:	00006617          	auipc	a2,0x6
ffffffffc0208b60:	0cc60613          	addi	a2,a2,204 # ffffffffc020ec28 <dev_node_ops+0xe0>
ffffffffc0208b64:	03700593          	li	a1,55
ffffffffc0208b68:	00006517          	auipc	a0,0x6
ffffffffc0208b6c:	0a050513          	addi	a0,a0,160 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208b70:	92ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b74 <dev_init_disk0>:
ffffffffc0208b74:	1101                	addi	sp,sp,-32
ffffffffc0208b76:	ec06                	sd	ra,24(sp)
ffffffffc0208b78:	e822                	sd	s0,16(sp)
ffffffffc0208b7a:	e426                	sd	s1,8(sp)
ffffffffc0208b7c:	dedff0ef          	jal	ra,ffffffffc0208968 <dev_create_inode>
ffffffffc0208b80:	c541                	beqz	a0,ffffffffc0208c08 <dev_init_disk0+0x94>
ffffffffc0208b82:	4d38                	lw	a4,88(a0)
ffffffffc0208b84:	6485                	lui	s1,0x1
ffffffffc0208b86:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208b8a:	842a                	mv	s0,a0
ffffffffc0208b8c:	0cf71f63          	bne	a4,a5,ffffffffc0208c6a <dev_init_disk0+0xf6>
ffffffffc0208b90:	4509                	li	a0,2
ffffffffc0208b92:	f63f70ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0208b96:	cd55                	beqz	a0,ffffffffc0208c52 <dev_init_disk0+0xde>
ffffffffc0208b98:	4509                	li	a0,2
ffffffffc0208b9a:	f7ff70ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc0208b9e:	00355793          	srli	a5,a0,0x3
ffffffffc0208ba2:	e01c                	sd	a5,0(s0)
ffffffffc0208ba4:	00000797          	auipc	a5,0x0
ffffffffc0208ba8:	df078793          	addi	a5,a5,-528 # ffffffffc0208994 <disk0_open>
ffffffffc0208bac:	e81c                	sd	a5,16(s0)
ffffffffc0208bae:	00000797          	auipc	a5,0x0
ffffffffc0208bb2:	dea78793          	addi	a5,a5,-534 # ffffffffc0208998 <disk0_close>
ffffffffc0208bb6:	ec1c                	sd	a5,24(s0)
ffffffffc0208bb8:	00000797          	auipc	a5,0x0
ffffffffc0208bbc:	de878793          	addi	a5,a5,-536 # ffffffffc02089a0 <disk0_io>
ffffffffc0208bc0:	f01c                	sd	a5,32(s0)
ffffffffc0208bc2:	00000797          	auipc	a5,0x0
ffffffffc0208bc6:	dda78793          	addi	a5,a5,-550 # ffffffffc020899c <disk0_ioctl>
ffffffffc0208bca:	f41c                	sd	a5,40(s0)
ffffffffc0208bcc:	4585                	li	a1,1
ffffffffc0208bce:	0008d517          	auipc	a0,0x8d
ffffffffc0208bd2:	c7250513          	addi	a0,a0,-910 # ffffffffc0295840 <disk0_sem>
ffffffffc0208bd6:	e404                	sd	s1,8(s0)
ffffffffc0208bd8:	8e1fb0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0208bdc:	6511                	lui	a0,0x4
ffffffffc0208bde:	bb0f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208be2:	0008e797          	auipc	a5,0x8e
ffffffffc0208be6:	d0a7bb23          	sd	a0,-746(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208bea:	c921                	beqz	a0,ffffffffc0208c3a <dev_init_disk0+0xc6>
ffffffffc0208bec:	4605                	li	a2,1
ffffffffc0208bee:	85a2                	mv	a1,s0
ffffffffc0208bf0:	00006517          	auipc	a0,0x6
ffffffffc0208bf4:	16050513          	addi	a0,a0,352 # ffffffffc020ed50 <dev_node_ops+0x208>
ffffffffc0208bf8:	c2cff0ef          	jal	ra,ffffffffc0208024 <vfs_add_dev>
ffffffffc0208bfc:	e115                	bnez	a0,ffffffffc0208c20 <dev_init_disk0+0xac>
ffffffffc0208bfe:	60e2                	ld	ra,24(sp)
ffffffffc0208c00:	6442                	ld	s0,16(sp)
ffffffffc0208c02:	64a2                	ld	s1,8(sp)
ffffffffc0208c04:	6105                	addi	sp,sp,32
ffffffffc0208c06:	8082                	ret
ffffffffc0208c08:	00006617          	auipc	a2,0x6
ffffffffc0208c0c:	0e860613          	addi	a2,a2,232 # ffffffffc020ecf0 <dev_node_ops+0x1a8>
ffffffffc0208c10:	08700593          	li	a1,135
ffffffffc0208c14:	00006517          	auipc	a0,0x6
ffffffffc0208c18:	ff450513          	addi	a0,a0,-12 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208c1c:	883f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c20:	86aa                	mv	a3,a0
ffffffffc0208c22:	00006617          	auipc	a2,0x6
ffffffffc0208c26:	13660613          	addi	a2,a2,310 # ffffffffc020ed58 <dev_node_ops+0x210>
ffffffffc0208c2a:	08d00593          	li	a1,141
ffffffffc0208c2e:	00006517          	auipc	a0,0x6
ffffffffc0208c32:	fda50513          	addi	a0,a0,-38 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208c36:	869f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c3a:	00006617          	auipc	a2,0x6
ffffffffc0208c3e:	0f660613          	addi	a2,a2,246 # ffffffffc020ed30 <dev_node_ops+0x1e8>
ffffffffc0208c42:	07f00593          	li	a1,127
ffffffffc0208c46:	00006517          	auipc	a0,0x6
ffffffffc0208c4a:	fc250513          	addi	a0,a0,-62 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208c4e:	851f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c52:	00006617          	auipc	a2,0x6
ffffffffc0208c56:	0be60613          	addi	a2,a2,190 # ffffffffc020ed10 <dev_node_ops+0x1c8>
ffffffffc0208c5a:	07300593          	li	a1,115
ffffffffc0208c5e:	00006517          	auipc	a0,0x6
ffffffffc0208c62:	faa50513          	addi	a0,a0,-86 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208c66:	839f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c6a:	00006697          	auipc	a3,0x6
ffffffffc0208c6e:	bb668693          	addi	a3,a3,-1098 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc0208c72:	00003617          	auipc	a2,0x3
ffffffffc0208c76:	ee660613          	addi	a2,a2,-282 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208c7a:	08900593          	li	a1,137
ffffffffc0208c7e:	00006517          	auipc	a0,0x6
ffffffffc0208c82:	f8a50513          	addi	a0,a0,-118 # ffffffffc020ec08 <dev_node_ops+0xc0>
ffffffffc0208c86:	819f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208c8a <stdin_open>:
ffffffffc0208c8a:	4501                	li	a0,0
ffffffffc0208c8c:	e191                	bnez	a1,ffffffffc0208c90 <stdin_open+0x6>
ffffffffc0208c8e:	8082                	ret
ffffffffc0208c90:	5575                	li	a0,-3
ffffffffc0208c92:	8082                	ret

ffffffffc0208c94 <stdin_close>:
ffffffffc0208c94:	4501                	li	a0,0
ffffffffc0208c96:	8082                	ret

ffffffffc0208c98 <stdin_ioctl>:
ffffffffc0208c98:	5575                	li	a0,-3
ffffffffc0208c9a:	8082                	ret

ffffffffc0208c9c <stdin_io>:
ffffffffc0208c9c:	7135                	addi	sp,sp,-160
ffffffffc0208c9e:	ed06                	sd	ra,152(sp)
ffffffffc0208ca0:	e922                	sd	s0,144(sp)
ffffffffc0208ca2:	e526                	sd	s1,136(sp)
ffffffffc0208ca4:	e14a                	sd	s2,128(sp)
ffffffffc0208ca6:	fcce                	sd	s3,120(sp)
ffffffffc0208ca8:	f8d2                	sd	s4,112(sp)
ffffffffc0208caa:	f4d6                	sd	s5,104(sp)
ffffffffc0208cac:	f0da                	sd	s6,96(sp)
ffffffffc0208cae:	ecde                	sd	s7,88(sp)
ffffffffc0208cb0:	e8e2                	sd	s8,80(sp)
ffffffffc0208cb2:	e4e6                	sd	s9,72(sp)
ffffffffc0208cb4:	e0ea                	sd	s10,64(sp)
ffffffffc0208cb6:	fc6e                	sd	s11,56(sp)
ffffffffc0208cb8:	14061163          	bnez	a2,ffffffffc0208dfa <stdin_io+0x15e>
ffffffffc0208cbc:	0005bd83          	ld	s11,0(a1)
ffffffffc0208cc0:	0185bd03          	ld	s10,24(a1)
ffffffffc0208cc4:	8b2e                	mv	s6,a1
ffffffffc0208cc6:	100027f3          	csrr	a5,sstatus
ffffffffc0208cca:	8b89                	andi	a5,a5,2
ffffffffc0208ccc:	10079e63          	bnez	a5,ffffffffc0208de8 <stdin_io+0x14c>
ffffffffc0208cd0:	4401                	li	s0,0
ffffffffc0208cd2:	100d0963          	beqz	s10,ffffffffc0208de4 <stdin_io+0x148>
ffffffffc0208cd6:	0008e997          	auipc	s3,0x8e
ffffffffc0208cda:	c2a98993          	addi	s3,s3,-982 # ffffffffc0296900 <p_rpos>
ffffffffc0208cde:	0009b783          	ld	a5,0(s3)
ffffffffc0208ce2:	800004b7          	lui	s1,0x80000
ffffffffc0208ce6:	6c85                	lui	s9,0x1
ffffffffc0208ce8:	4a81                	li	s5,0
ffffffffc0208cea:	0008ea17          	auipc	s4,0x8e
ffffffffc0208cee:	c1ea0a13          	addi	s4,s4,-994 # ffffffffc0296908 <p_wpos>
ffffffffc0208cf2:	0491                	addi	s1,s1,4
ffffffffc0208cf4:	0008d917          	auipc	s2,0x8d
ffffffffc0208cf8:	b6490913          	addi	s2,s2,-1180 # ffffffffc0295858 <__wait_queue>
ffffffffc0208cfc:	1cfd                	addi	s9,s9,-1
ffffffffc0208cfe:	000a3703          	ld	a4,0(s4)
ffffffffc0208d02:	000a8c1b          	sext.w	s8,s5
ffffffffc0208d06:	8be2                	mv	s7,s8
ffffffffc0208d08:	02e7d763          	bge	a5,a4,ffffffffc0208d36 <stdin_io+0x9a>
ffffffffc0208d0c:	a859                	j	ffffffffc0208da2 <stdin_io+0x106>
ffffffffc0208d0e:	815fe0ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc0208d12:	100027f3          	csrr	a5,sstatus
ffffffffc0208d16:	8b89                	andi	a5,a5,2
ffffffffc0208d18:	4401                	li	s0,0
ffffffffc0208d1a:	ef8d                	bnez	a5,ffffffffc0208d54 <stdin_io+0xb8>
ffffffffc0208d1c:	0028                	addi	a0,sp,8
ffffffffc0208d1e:	837fb0ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc0208d22:	e121                	bnez	a0,ffffffffc0208d62 <stdin_io+0xc6>
ffffffffc0208d24:	47c2                	lw	a5,16(sp)
ffffffffc0208d26:	04979563          	bne	a5,s1,ffffffffc0208d70 <stdin_io+0xd4>
ffffffffc0208d2a:	0009b783          	ld	a5,0(s3)
ffffffffc0208d2e:	000a3703          	ld	a4,0(s4)
ffffffffc0208d32:	06e7c863          	blt	a5,a4,ffffffffc0208da2 <stdin_io+0x106>
ffffffffc0208d36:	8626                	mv	a2,s1
ffffffffc0208d38:	002c                	addi	a1,sp,8
ffffffffc0208d3a:	854a                	mv	a0,s2
ffffffffc0208d3c:	943fb0ef          	jal	ra,ffffffffc020467e <wait_current_set>
ffffffffc0208d40:	d479                	beqz	s0,ffffffffc0208d0e <stdin_io+0x72>
ffffffffc0208d42:	f2bf70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208d46:	fdcfe0ef          	jal	ra,ffffffffc0207522 <schedule>
ffffffffc0208d4a:	100027f3          	csrr	a5,sstatus
ffffffffc0208d4e:	8b89                	andi	a5,a5,2
ffffffffc0208d50:	4401                	li	s0,0
ffffffffc0208d52:	d7e9                	beqz	a5,ffffffffc0208d1c <stdin_io+0x80>
ffffffffc0208d54:	f1ff70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208d58:	0028                	addi	a0,sp,8
ffffffffc0208d5a:	4405                	li	s0,1
ffffffffc0208d5c:	ff8fb0ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc0208d60:	d171                	beqz	a0,ffffffffc0208d24 <stdin_io+0x88>
ffffffffc0208d62:	002c                	addi	a1,sp,8
ffffffffc0208d64:	854a                	mv	a0,s2
ffffffffc0208d66:	f94fb0ef          	jal	ra,ffffffffc02044fa <wait_queue_del>
ffffffffc0208d6a:	47c2                	lw	a5,16(sp)
ffffffffc0208d6c:	fa978fe3          	beq	a5,s1,ffffffffc0208d2a <stdin_io+0x8e>
ffffffffc0208d70:	e435                	bnez	s0,ffffffffc0208ddc <stdin_io+0x140>
ffffffffc0208d72:	060b8963          	beqz	s7,ffffffffc0208de4 <stdin_io+0x148>
ffffffffc0208d76:	018b3783          	ld	a5,24(s6)
ffffffffc0208d7a:	41578ab3          	sub	s5,a5,s5
ffffffffc0208d7e:	015b3c23          	sd	s5,24(s6)
ffffffffc0208d82:	60ea                	ld	ra,152(sp)
ffffffffc0208d84:	644a                	ld	s0,144(sp)
ffffffffc0208d86:	64aa                	ld	s1,136(sp)
ffffffffc0208d88:	690a                	ld	s2,128(sp)
ffffffffc0208d8a:	79e6                	ld	s3,120(sp)
ffffffffc0208d8c:	7a46                	ld	s4,112(sp)
ffffffffc0208d8e:	7aa6                	ld	s5,104(sp)
ffffffffc0208d90:	7b06                	ld	s6,96(sp)
ffffffffc0208d92:	6c46                	ld	s8,80(sp)
ffffffffc0208d94:	6ca6                	ld	s9,72(sp)
ffffffffc0208d96:	6d06                	ld	s10,64(sp)
ffffffffc0208d98:	7de2                	ld	s11,56(sp)
ffffffffc0208d9a:	855e                	mv	a0,s7
ffffffffc0208d9c:	6be6                	ld	s7,88(sp)
ffffffffc0208d9e:	610d                	addi	sp,sp,160
ffffffffc0208da0:	8082                	ret
ffffffffc0208da2:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208da6:	03475693          	srli	a3,a4,0x34
ffffffffc0208daa:	00d78733          	add	a4,a5,a3
ffffffffc0208dae:	01977733          	and	a4,a4,s9
ffffffffc0208db2:	8f15                	sub	a4,a4,a3
ffffffffc0208db4:	0008d697          	auipc	a3,0x8d
ffffffffc0208db8:	ab468693          	addi	a3,a3,-1356 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208dbc:	9736                	add	a4,a4,a3
ffffffffc0208dbe:	00074683          	lbu	a3,0(a4)
ffffffffc0208dc2:	0785                	addi	a5,a5,1
ffffffffc0208dc4:	015d8733          	add	a4,s11,s5
ffffffffc0208dc8:	00d70023          	sb	a3,0(a4)
ffffffffc0208dcc:	00f9b023          	sd	a5,0(s3)
ffffffffc0208dd0:	0a85                	addi	s5,s5,1
ffffffffc0208dd2:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208dd6:	f3aae4e3          	bltu	s5,s10,ffffffffc0208cfe <stdin_io+0x62>
ffffffffc0208dda:	dc51                	beqz	s0,ffffffffc0208d76 <stdin_io+0xda>
ffffffffc0208ddc:	e91f70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208de0:	f80b9be3          	bnez	s7,ffffffffc0208d76 <stdin_io+0xda>
ffffffffc0208de4:	4b81                	li	s7,0
ffffffffc0208de6:	bf71                	j	ffffffffc0208d82 <stdin_io+0xe6>
ffffffffc0208de8:	e8bf70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208dec:	4405                	li	s0,1
ffffffffc0208dee:	ee0d14e3          	bnez	s10,ffffffffc0208cd6 <stdin_io+0x3a>
ffffffffc0208df2:	e7bf70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208df6:	4b81                	li	s7,0
ffffffffc0208df8:	b769                	j	ffffffffc0208d82 <stdin_io+0xe6>
ffffffffc0208dfa:	5bf5                	li	s7,-3
ffffffffc0208dfc:	b759                	j	ffffffffc0208d82 <stdin_io+0xe6>

ffffffffc0208dfe <dev_stdin_write>:
ffffffffc0208dfe:	e111                	bnez	a0,ffffffffc0208e02 <dev_stdin_write+0x4>
ffffffffc0208e00:	8082                	ret
ffffffffc0208e02:	1101                	addi	sp,sp,-32
ffffffffc0208e04:	e822                	sd	s0,16(sp)
ffffffffc0208e06:	ec06                	sd	ra,24(sp)
ffffffffc0208e08:	e426                	sd	s1,8(sp)
ffffffffc0208e0a:	842a                	mv	s0,a0
ffffffffc0208e0c:	100027f3          	csrr	a5,sstatus
ffffffffc0208e10:	8b89                	andi	a5,a5,2
ffffffffc0208e12:	4481                	li	s1,0
ffffffffc0208e14:	e3c1                	bnez	a5,ffffffffc0208e94 <dev_stdin_write+0x96>
ffffffffc0208e16:	0008e597          	auipc	a1,0x8e
ffffffffc0208e1a:	af258593          	addi	a1,a1,-1294 # ffffffffc0296908 <p_wpos>
ffffffffc0208e1e:	6198                	ld	a4,0(a1)
ffffffffc0208e20:	6605                	lui	a2,0x1
ffffffffc0208e22:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0208e26:	43f75693          	srai	a3,a4,0x3f
ffffffffc0208e2a:	92d1                	srli	a3,a3,0x34
ffffffffc0208e2c:	00d707b3          	add	a5,a4,a3
ffffffffc0208e30:	8fe9                	and	a5,a5,a0
ffffffffc0208e32:	8f95                	sub	a5,a5,a3
ffffffffc0208e34:	0008d697          	auipc	a3,0x8d
ffffffffc0208e38:	a3468693          	addi	a3,a3,-1484 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208e3c:	97b6                	add	a5,a5,a3
ffffffffc0208e3e:	00878023          	sb	s0,0(a5)
ffffffffc0208e42:	0008e797          	auipc	a5,0x8e
ffffffffc0208e46:	abe7b783          	ld	a5,-1346(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208e4a:	40f707b3          	sub	a5,a4,a5
ffffffffc0208e4e:	00c7d463          	bge	a5,a2,ffffffffc0208e56 <dev_stdin_write+0x58>
ffffffffc0208e52:	0705                	addi	a4,a4,1
ffffffffc0208e54:	e198                	sd	a4,0(a1)
ffffffffc0208e56:	0008d517          	auipc	a0,0x8d
ffffffffc0208e5a:	a0250513          	addi	a0,a0,-1534 # ffffffffc0295858 <__wait_queue>
ffffffffc0208e5e:	eeafb0ef          	jal	ra,ffffffffc0204548 <wait_queue_empty>
ffffffffc0208e62:	cd09                	beqz	a0,ffffffffc0208e7c <dev_stdin_write+0x7e>
ffffffffc0208e64:	e491                	bnez	s1,ffffffffc0208e70 <dev_stdin_write+0x72>
ffffffffc0208e66:	60e2                	ld	ra,24(sp)
ffffffffc0208e68:	6442                	ld	s0,16(sp)
ffffffffc0208e6a:	64a2                	ld	s1,8(sp)
ffffffffc0208e6c:	6105                	addi	sp,sp,32
ffffffffc0208e6e:	8082                	ret
ffffffffc0208e70:	6442                	ld	s0,16(sp)
ffffffffc0208e72:	60e2                	ld	ra,24(sp)
ffffffffc0208e74:	64a2                	ld	s1,8(sp)
ffffffffc0208e76:	6105                	addi	sp,sp,32
ffffffffc0208e78:	df5f706f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0208e7c:	800005b7          	lui	a1,0x80000
ffffffffc0208e80:	4605                	li	a2,1
ffffffffc0208e82:	0591                	addi	a1,a1,4
ffffffffc0208e84:	0008d517          	auipc	a0,0x8d
ffffffffc0208e88:	9d450513          	addi	a0,a0,-1580 # ffffffffc0295858 <__wait_queue>
ffffffffc0208e8c:	f24fb0ef          	jal	ra,ffffffffc02045b0 <wakeup_queue>
ffffffffc0208e90:	d8f9                	beqz	s1,ffffffffc0208e66 <dev_stdin_write+0x68>
ffffffffc0208e92:	bff9                	j	ffffffffc0208e70 <dev_stdin_write+0x72>
ffffffffc0208e94:	ddff70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208e98:	4485                	li	s1,1
ffffffffc0208e9a:	bfb5                	j	ffffffffc0208e16 <dev_stdin_write+0x18>

ffffffffc0208e9c <dev_init_stdin>:
ffffffffc0208e9c:	1141                	addi	sp,sp,-16
ffffffffc0208e9e:	e406                	sd	ra,8(sp)
ffffffffc0208ea0:	e022                	sd	s0,0(sp)
ffffffffc0208ea2:	ac7ff0ef          	jal	ra,ffffffffc0208968 <dev_create_inode>
ffffffffc0208ea6:	c93d                	beqz	a0,ffffffffc0208f1c <dev_init_stdin+0x80>
ffffffffc0208ea8:	4d38                	lw	a4,88(a0)
ffffffffc0208eaa:	6785                	lui	a5,0x1
ffffffffc0208eac:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208eb0:	842a                	mv	s0,a0
ffffffffc0208eb2:	08f71e63          	bne	a4,a5,ffffffffc0208f4e <dev_init_stdin+0xb2>
ffffffffc0208eb6:	4785                	li	a5,1
ffffffffc0208eb8:	e41c                	sd	a5,8(s0)
ffffffffc0208eba:	00000797          	auipc	a5,0x0
ffffffffc0208ebe:	dd078793          	addi	a5,a5,-560 # ffffffffc0208c8a <stdin_open>
ffffffffc0208ec2:	e81c                	sd	a5,16(s0)
ffffffffc0208ec4:	00000797          	auipc	a5,0x0
ffffffffc0208ec8:	dd078793          	addi	a5,a5,-560 # ffffffffc0208c94 <stdin_close>
ffffffffc0208ecc:	ec1c                	sd	a5,24(s0)
ffffffffc0208ece:	00000797          	auipc	a5,0x0
ffffffffc0208ed2:	dce78793          	addi	a5,a5,-562 # ffffffffc0208c9c <stdin_io>
ffffffffc0208ed6:	f01c                	sd	a5,32(s0)
ffffffffc0208ed8:	00000797          	auipc	a5,0x0
ffffffffc0208edc:	dc078793          	addi	a5,a5,-576 # ffffffffc0208c98 <stdin_ioctl>
ffffffffc0208ee0:	f41c                	sd	a5,40(s0)
ffffffffc0208ee2:	0008d517          	auipc	a0,0x8d
ffffffffc0208ee6:	97650513          	addi	a0,a0,-1674 # ffffffffc0295858 <__wait_queue>
ffffffffc0208eea:	00043023          	sd	zero,0(s0)
ffffffffc0208eee:	0008e797          	auipc	a5,0x8e
ffffffffc0208ef2:	a007bd23          	sd	zero,-1510(a5) # ffffffffc0296908 <p_wpos>
ffffffffc0208ef6:	0008e797          	auipc	a5,0x8e
ffffffffc0208efa:	a007b523          	sd	zero,-1526(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208efe:	df6fb0ef          	jal	ra,ffffffffc02044f4 <wait_queue_init>
ffffffffc0208f02:	4601                	li	a2,0
ffffffffc0208f04:	85a2                	mv	a1,s0
ffffffffc0208f06:	00006517          	auipc	a0,0x6
ffffffffc0208f0a:	eb250513          	addi	a0,a0,-334 # ffffffffc020edb8 <dev_node_ops+0x270>
ffffffffc0208f0e:	916ff0ef          	jal	ra,ffffffffc0208024 <vfs_add_dev>
ffffffffc0208f12:	e10d                	bnez	a0,ffffffffc0208f34 <dev_init_stdin+0x98>
ffffffffc0208f14:	60a2                	ld	ra,8(sp)
ffffffffc0208f16:	6402                	ld	s0,0(sp)
ffffffffc0208f18:	0141                	addi	sp,sp,16
ffffffffc0208f1a:	8082                	ret
ffffffffc0208f1c:	00006617          	auipc	a2,0x6
ffffffffc0208f20:	e5c60613          	addi	a2,a2,-420 # ffffffffc020ed78 <dev_node_ops+0x230>
ffffffffc0208f24:	07500593          	li	a1,117
ffffffffc0208f28:	00006517          	auipc	a0,0x6
ffffffffc0208f2c:	e7050513          	addi	a0,a0,-400 # ffffffffc020ed98 <dev_node_ops+0x250>
ffffffffc0208f30:	d6ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f34:	86aa                	mv	a3,a0
ffffffffc0208f36:	00006617          	auipc	a2,0x6
ffffffffc0208f3a:	e8a60613          	addi	a2,a2,-374 # ffffffffc020edc0 <dev_node_ops+0x278>
ffffffffc0208f3e:	07b00593          	li	a1,123
ffffffffc0208f42:	00006517          	auipc	a0,0x6
ffffffffc0208f46:	e5650513          	addi	a0,a0,-426 # ffffffffc020ed98 <dev_node_ops+0x250>
ffffffffc0208f4a:	d54f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f4e:	00006697          	auipc	a3,0x6
ffffffffc0208f52:	8d268693          	addi	a3,a3,-1838 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc0208f56:	00003617          	auipc	a2,0x3
ffffffffc0208f5a:	c0260613          	addi	a2,a2,-1022 # ffffffffc020bb58 <commands+0x210>
ffffffffc0208f5e:	07700593          	li	a1,119
ffffffffc0208f62:	00006517          	auipc	a0,0x6
ffffffffc0208f66:	e3650513          	addi	a0,a0,-458 # ffffffffc020ed98 <dev_node_ops+0x250>
ffffffffc0208f6a:	d34f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f6e <stdout_open>:
ffffffffc0208f6e:	4785                	li	a5,1
ffffffffc0208f70:	4501                	li	a0,0
ffffffffc0208f72:	00f59363          	bne	a1,a5,ffffffffc0208f78 <stdout_open+0xa>
ffffffffc0208f76:	8082                	ret
ffffffffc0208f78:	5575                	li	a0,-3
ffffffffc0208f7a:	8082                	ret

ffffffffc0208f7c <stdout_close>:
ffffffffc0208f7c:	4501                	li	a0,0
ffffffffc0208f7e:	8082                	ret

ffffffffc0208f80 <stdout_ioctl>:
ffffffffc0208f80:	5575                	li	a0,-3
ffffffffc0208f82:	8082                	ret

ffffffffc0208f84 <stdout_io>:
ffffffffc0208f84:	ca05                	beqz	a2,ffffffffc0208fb4 <stdout_io+0x30>
ffffffffc0208f86:	6d9c                	ld	a5,24(a1)
ffffffffc0208f88:	1101                	addi	sp,sp,-32
ffffffffc0208f8a:	e822                	sd	s0,16(sp)
ffffffffc0208f8c:	e426                	sd	s1,8(sp)
ffffffffc0208f8e:	ec06                	sd	ra,24(sp)
ffffffffc0208f90:	6180                	ld	s0,0(a1)
ffffffffc0208f92:	84ae                	mv	s1,a1
ffffffffc0208f94:	cb91                	beqz	a5,ffffffffc0208fa8 <stdout_io+0x24>
ffffffffc0208f96:	00044503          	lbu	a0,0(s0)
ffffffffc0208f9a:	0405                	addi	s0,s0,1
ffffffffc0208f9c:	a46f70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0208fa0:	6c9c                	ld	a5,24(s1)
ffffffffc0208fa2:	17fd                	addi	a5,a5,-1
ffffffffc0208fa4:	ec9c                	sd	a5,24(s1)
ffffffffc0208fa6:	fbe5                	bnez	a5,ffffffffc0208f96 <stdout_io+0x12>
ffffffffc0208fa8:	60e2                	ld	ra,24(sp)
ffffffffc0208faa:	6442                	ld	s0,16(sp)
ffffffffc0208fac:	64a2                	ld	s1,8(sp)
ffffffffc0208fae:	4501                	li	a0,0
ffffffffc0208fb0:	6105                	addi	sp,sp,32
ffffffffc0208fb2:	8082                	ret
ffffffffc0208fb4:	5575                	li	a0,-3
ffffffffc0208fb6:	8082                	ret

ffffffffc0208fb8 <dev_init_stdout>:
ffffffffc0208fb8:	1141                	addi	sp,sp,-16
ffffffffc0208fba:	e406                	sd	ra,8(sp)
ffffffffc0208fbc:	9adff0ef          	jal	ra,ffffffffc0208968 <dev_create_inode>
ffffffffc0208fc0:	c939                	beqz	a0,ffffffffc0209016 <dev_init_stdout+0x5e>
ffffffffc0208fc2:	4d38                	lw	a4,88(a0)
ffffffffc0208fc4:	6785                	lui	a5,0x1
ffffffffc0208fc6:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208fca:	85aa                	mv	a1,a0
ffffffffc0208fcc:	06f71e63          	bne	a4,a5,ffffffffc0209048 <dev_init_stdout+0x90>
ffffffffc0208fd0:	4785                	li	a5,1
ffffffffc0208fd2:	e51c                	sd	a5,8(a0)
ffffffffc0208fd4:	00000797          	auipc	a5,0x0
ffffffffc0208fd8:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208f6e <stdout_open>
ffffffffc0208fdc:	e91c                	sd	a5,16(a0)
ffffffffc0208fde:	00000797          	auipc	a5,0x0
ffffffffc0208fe2:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208f7c <stdout_close>
ffffffffc0208fe6:	ed1c                	sd	a5,24(a0)
ffffffffc0208fe8:	00000797          	auipc	a5,0x0
ffffffffc0208fec:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208f84 <stdout_io>
ffffffffc0208ff0:	f11c                	sd	a5,32(a0)
ffffffffc0208ff2:	00000797          	auipc	a5,0x0
ffffffffc0208ff6:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208f80 <stdout_ioctl>
ffffffffc0208ffa:	00053023          	sd	zero,0(a0)
ffffffffc0208ffe:	f51c                	sd	a5,40(a0)
ffffffffc0209000:	4601                	li	a2,0
ffffffffc0209002:	00006517          	auipc	a0,0x6
ffffffffc0209006:	e1e50513          	addi	a0,a0,-482 # ffffffffc020ee20 <dev_node_ops+0x2d8>
ffffffffc020900a:	81aff0ef          	jal	ra,ffffffffc0208024 <vfs_add_dev>
ffffffffc020900e:	e105                	bnez	a0,ffffffffc020902e <dev_init_stdout+0x76>
ffffffffc0209010:	60a2                	ld	ra,8(sp)
ffffffffc0209012:	0141                	addi	sp,sp,16
ffffffffc0209014:	8082                	ret
ffffffffc0209016:	00006617          	auipc	a2,0x6
ffffffffc020901a:	dca60613          	addi	a2,a2,-566 # ffffffffc020ede0 <dev_node_ops+0x298>
ffffffffc020901e:	03700593          	li	a1,55
ffffffffc0209022:	00006517          	auipc	a0,0x6
ffffffffc0209026:	dde50513          	addi	a0,a0,-546 # ffffffffc020ee00 <dev_node_ops+0x2b8>
ffffffffc020902a:	c74f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020902e:	86aa                	mv	a3,a0
ffffffffc0209030:	00006617          	auipc	a2,0x6
ffffffffc0209034:	df860613          	addi	a2,a2,-520 # ffffffffc020ee28 <dev_node_ops+0x2e0>
ffffffffc0209038:	03d00593          	li	a1,61
ffffffffc020903c:	00006517          	auipc	a0,0x6
ffffffffc0209040:	dc450513          	addi	a0,a0,-572 # ffffffffc020ee00 <dev_node_ops+0x2b8>
ffffffffc0209044:	c5af70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209048:	00005697          	auipc	a3,0x5
ffffffffc020904c:	7d868693          	addi	a3,a3,2008 # ffffffffc020e820 <syscalls+0xb10>
ffffffffc0209050:	00003617          	auipc	a2,0x3
ffffffffc0209054:	b0860613          	addi	a2,a2,-1272 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209058:	03900593          	li	a1,57
ffffffffc020905c:	00006517          	auipc	a0,0x6
ffffffffc0209060:	da450513          	addi	a0,a0,-604 # ffffffffc020ee00 <dev_node_ops+0x2b8>
ffffffffc0209064:	c3af70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209068 <bitmap_translate.part.0>:
ffffffffc0209068:	1141                	addi	sp,sp,-16
ffffffffc020906a:	00006697          	auipc	a3,0x6
ffffffffc020906e:	dde68693          	addi	a3,a3,-546 # ffffffffc020ee48 <dev_node_ops+0x300>
ffffffffc0209072:	00003617          	auipc	a2,0x3
ffffffffc0209076:	ae660613          	addi	a2,a2,-1306 # ffffffffc020bb58 <commands+0x210>
ffffffffc020907a:	04c00593          	li	a1,76
ffffffffc020907e:	00006517          	auipc	a0,0x6
ffffffffc0209082:	de250513          	addi	a0,a0,-542 # ffffffffc020ee60 <dev_node_ops+0x318>
ffffffffc0209086:	e406                	sd	ra,8(sp)
ffffffffc0209088:	c16f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020908c <bitmap_create>:
ffffffffc020908c:	7139                	addi	sp,sp,-64
ffffffffc020908e:	fc06                	sd	ra,56(sp)
ffffffffc0209090:	f822                	sd	s0,48(sp)
ffffffffc0209092:	f426                	sd	s1,40(sp)
ffffffffc0209094:	f04a                	sd	s2,32(sp)
ffffffffc0209096:	ec4e                	sd	s3,24(sp)
ffffffffc0209098:	e852                	sd	s4,16(sp)
ffffffffc020909a:	e456                	sd	s5,8(sp)
ffffffffc020909c:	c14d                	beqz	a0,ffffffffc020913e <bitmap_create+0xb2>
ffffffffc020909e:	842a                	mv	s0,a0
ffffffffc02090a0:	4541                	li	a0,16
ffffffffc02090a2:	eedf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02090a6:	84aa                	mv	s1,a0
ffffffffc02090a8:	cd25                	beqz	a0,ffffffffc0209120 <bitmap_create+0x94>
ffffffffc02090aa:	02041a13          	slli	s4,s0,0x20
ffffffffc02090ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02090b2:	01fa0793          	addi	a5,s4,31
ffffffffc02090b6:	0057d993          	srli	s3,a5,0x5
ffffffffc02090ba:	00299a93          	slli	s5,s3,0x2
ffffffffc02090be:	8556                	mv	a0,s5
ffffffffc02090c0:	894e                	mv	s2,s3
ffffffffc02090c2:	ecdf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02090c6:	c53d                	beqz	a0,ffffffffc0209134 <bitmap_create+0xa8>
ffffffffc02090c8:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc02090cc:	c080                	sw	s0,0(s1)
ffffffffc02090ce:	8656                	mv	a2,s5
ffffffffc02090d0:	0ff00593          	li	a1,255
ffffffffc02090d4:	5a2020ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc02090d8:	e488                	sd	a0,8(s1)
ffffffffc02090da:	0996                	slli	s3,s3,0x5
ffffffffc02090dc:	053a0263          	beq	s4,s3,ffffffffc0209120 <bitmap_create+0x94>
ffffffffc02090e0:	fff9079b          	addiw	a5,s2,-1
ffffffffc02090e4:	0057969b          	slliw	a3,a5,0x5
ffffffffc02090e8:	0054561b          	srliw	a2,s0,0x5
ffffffffc02090ec:	40d4073b          	subw	a4,s0,a3
ffffffffc02090f0:	0054541b          	srliw	s0,s0,0x5
ffffffffc02090f4:	08f61463          	bne	a2,a5,ffffffffc020917c <bitmap_create+0xf0>
ffffffffc02090f8:	fff7069b          	addiw	a3,a4,-1
ffffffffc02090fc:	47f9                	li	a5,30
ffffffffc02090fe:	04d7ef63          	bltu	a5,a3,ffffffffc020915c <bitmap_create+0xd0>
ffffffffc0209102:	1402                	slli	s0,s0,0x20
ffffffffc0209104:	8079                	srli	s0,s0,0x1e
ffffffffc0209106:	9522                	add	a0,a0,s0
ffffffffc0209108:	411c                	lw	a5,0(a0)
ffffffffc020910a:	4585                	li	a1,1
ffffffffc020910c:	02000613          	li	a2,32
ffffffffc0209110:	00e596bb          	sllw	a3,a1,a4
ffffffffc0209114:	8fb5                	xor	a5,a5,a3
ffffffffc0209116:	2705                	addiw	a4,a4,1
ffffffffc0209118:	2781                	sext.w	a5,a5
ffffffffc020911a:	fec71be3          	bne	a4,a2,ffffffffc0209110 <bitmap_create+0x84>
ffffffffc020911e:	c11c                	sw	a5,0(a0)
ffffffffc0209120:	70e2                	ld	ra,56(sp)
ffffffffc0209122:	7442                	ld	s0,48(sp)
ffffffffc0209124:	7902                	ld	s2,32(sp)
ffffffffc0209126:	69e2                	ld	s3,24(sp)
ffffffffc0209128:	6a42                	ld	s4,16(sp)
ffffffffc020912a:	6aa2                	ld	s5,8(sp)
ffffffffc020912c:	8526                	mv	a0,s1
ffffffffc020912e:	74a2                	ld	s1,40(sp)
ffffffffc0209130:	6121                	addi	sp,sp,64
ffffffffc0209132:	8082                	ret
ffffffffc0209134:	8526                	mv	a0,s1
ffffffffc0209136:	f09f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020913a:	4481                	li	s1,0
ffffffffc020913c:	b7d5                	j	ffffffffc0209120 <bitmap_create+0x94>
ffffffffc020913e:	00006697          	auipc	a3,0x6
ffffffffc0209142:	d3a68693          	addi	a3,a3,-710 # ffffffffc020ee78 <dev_node_ops+0x330>
ffffffffc0209146:	00003617          	auipc	a2,0x3
ffffffffc020914a:	a1260613          	addi	a2,a2,-1518 # ffffffffc020bb58 <commands+0x210>
ffffffffc020914e:	45d5                	li	a1,21
ffffffffc0209150:	00006517          	auipc	a0,0x6
ffffffffc0209154:	d1050513          	addi	a0,a0,-752 # ffffffffc020ee60 <dev_node_ops+0x318>
ffffffffc0209158:	b46f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020915c:	00006697          	auipc	a3,0x6
ffffffffc0209160:	d5c68693          	addi	a3,a3,-676 # ffffffffc020eeb8 <dev_node_ops+0x370>
ffffffffc0209164:	00003617          	auipc	a2,0x3
ffffffffc0209168:	9f460613          	addi	a2,a2,-1548 # ffffffffc020bb58 <commands+0x210>
ffffffffc020916c:	02b00593          	li	a1,43
ffffffffc0209170:	00006517          	auipc	a0,0x6
ffffffffc0209174:	cf050513          	addi	a0,a0,-784 # ffffffffc020ee60 <dev_node_ops+0x318>
ffffffffc0209178:	b26f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020917c:	00006697          	auipc	a3,0x6
ffffffffc0209180:	d2468693          	addi	a3,a3,-732 # ffffffffc020eea0 <dev_node_ops+0x358>
ffffffffc0209184:	00003617          	auipc	a2,0x3
ffffffffc0209188:	9d460613          	addi	a2,a2,-1580 # ffffffffc020bb58 <commands+0x210>
ffffffffc020918c:	02a00593          	li	a1,42
ffffffffc0209190:	00006517          	auipc	a0,0x6
ffffffffc0209194:	cd050513          	addi	a0,a0,-816 # ffffffffc020ee60 <dev_node_ops+0x318>
ffffffffc0209198:	b06f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020919c <bitmap_alloc>:
ffffffffc020919c:	4150                	lw	a2,4(a0)
ffffffffc020919e:	651c                	ld	a5,8(a0)
ffffffffc02091a0:	c231                	beqz	a2,ffffffffc02091e4 <bitmap_alloc+0x48>
ffffffffc02091a2:	4701                	li	a4,0
ffffffffc02091a4:	a029                	j	ffffffffc02091ae <bitmap_alloc+0x12>
ffffffffc02091a6:	2705                	addiw	a4,a4,1
ffffffffc02091a8:	0791                	addi	a5,a5,4
ffffffffc02091aa:	02e60d63          	beq	a2,a4,ffffffffc02091e4 <bitmap_alloc+0x48>
ffffffffc02091ae:	4394                	lw	a3,0(a5)
ffffffffc02091b0:	dafd                	beqz	a3,ffffffffc02091a6 <bitmap_alloc+0xa>
ffffffffc02091b2:	4501                	li	a0,0
ffffffffc02091b4:	4885                	li	a7,1
ffffffffc02091b6:	8e36                	mv	t3,a3
ffffffffc02091b8:	02000313          	li	t1,32
ffffffffc02091bc:	a021                	j	ffffffffc02091c4 <bitmap_alloc+0x28>
ffffffffc02091be:	2505                	addiw	a0,a0,1
ffffffffc02091c0:	02650463          	beq	a0,t1,ffffffffc02091e8 <bitmap_alloc+0x4c>
ffffffffc02091c4:	00a8983b          	sllw	a6,a7,a0
ffffffffc02091c8:	0106f633          	and	a2,a3,a6
ffffffffc02091cc:	2601                	sext.w	a2,a2
ffffffffc02091ce:	da65                	beqz	a2,ffffffffc02091be <bitmap_alloc+0x22>
ffffffffc02091d0:	010e4833          	xor	a6,t3,a6
ffffffffc02091d4:	0057171b          	slliw	a4,a4,0x5
ffffffffc02091d8:	9f29                	addw	a4,a4,a0
ffffffffc02091da:	0107a023          	sw	a6,0(a5)
ffffffffc02091de:	c198                	sw	a4,0(a1)
ffffffffc02091e0:	4501                	li	a0,0
ffffffffc02091e2:	8082                	ret
ffffffffc02091e4:	5571                	li	a0,-4
ffffffffc02091e6:	8082                	ret
ffffffffc02091e8:	1141                	addi	sp,sp,-16
ffffffffc02091ea:	00004697          	auipc	a3,0x4
ffffffffc02091ee:	a0e68693          	addi	a3,a3,-1522 # ffffffffc020cbf8 <default_pmm_manager+0x5b8>
ffffffffc02091f2:	00003617          	auipc	a2,0x3
ffffffffc02091f6:	96660613          	addi	a2,a2,-1690 # ffffffffc020bb58 <commands+0x210>
ffffffffc02091fa:	04300593          	li	a1,67
ffffffffc02091fe:	00006517          	auipc	a0,0x6
ffffffffc0209202:	c6250513          	addi	a0,a0,-926 # ffffffffc020ee60 <dev_node_ops+0x318>
ffffffffc0209206:	e406                	sd	ra,8(sp)
ffffffffc0209208:	a96f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020920c <bitmap_test>:
ffffffffc020920c:	411c                	lw	a5,0(a0)
ffffffffc020920e:	00f5ff63          	bgeu	a1,a5,ffffffffc020922c <bitmap_test+0x20>
ffffffffc0209212:	651c                	ld	a5,8(a0)
ffffffffc0209214:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0209218:	070a                	slli	a4,a4,0x2
ffffffffc020921a:	97ba                	add	a5,a5,a4
ffffffffc020921c:	4388                	lw	a0,0(a5)
ffffffffc020921e:	4785                	li	a5,1
ffffffffc0209220:	00b795bb          	sllw	a1,a5,a1
ffffffffc0209224:	8d6d                	and	a0,a0,a1
ffffffffc0209226:	1502                	slli	a0,a0,0x20
ffffffffc0209228:	9101                	srli	a0,a0,0x20
ffffffffc020922a:	8082                	ret
ffffffffc020922c:	1141                	addi	sp,sp,-16
ffffffffc020922e:	e406                	sd	ra,8(sp)
ffffffffc0209230:	e39ff0ef          	jal	ra,ffffffffc0209068 <bitmap_translate.part.0>

ffffffffc0209234 <bitmap_free>:
ffffffffc0209234:	411c                	lw	a5,0(a0)
ffffffffc0209236:	1141                	addi	sp,sp,-16
ffffffffc0209238:	e406                	sd	ra,8(sp)
ffffffffc020923a:	02f5f463          	bgeu	a1,a5,ffffffffc0209262 <bitmap_free+0x2e>
ffffffffc020923e:	651c                	ld	a5,8(a0)
ffffffffc0209240:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0209244:	070a                	slli	a4,a4,0x2
ffffffffc0209246:	97ba                	add	a5,a5,a4
ffffffffc0209248:	4398                	lw	a4,0(a5)
ffffffffc020924a:	4685                	li	a3,1
ffffffffc020924c:	00b695bb          	sllw	a1,a3,a1
ffffffffc0209250:	00b776b3          	and	a3,a4,a1
ffffffffc0209254:	2681                	sext.w	a3,a3
ffffffffc0209256:	ea81                	bnez	a3,ffffffffc0209266 <bitmap_free+0x32>
ffffffffc0209258:	60a2                	ld	ra,8(sp)
ffffffffc020925a:	8f4d                	or	a4,a4,a1
ffffffffc020925c:	c398                	sw	a4,0(a5)
ffffffffc020925e:	0141                	addi	sp,sp,16
ffffffffc0209260:	8082                	ret
ffffffffc0209262:	e07ff0ef          	jal	ra,ffffffffc0209068 <bitmap_translate.part.0>
ffffffffc0209266:	00006697          	auipc	a3,0x6
ffffffffc020926a:	c7a68693          	addi	a3,a3,-902 # ffffffffc020eee0 <dev_node_ops+0x398>
ffffffffc020926e:	00003617          	auipc	a2,0x3
ffffffffc0209272:	8ea60613          	addi	a2,a2,-1814 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209276:	05f00593          	li	a1,95
ffffffffc020927a:	00006517          	auipc	a0,0x6
ffffffffc020927e:	be650513          	addi	a0,a0,-1050 # ffffffffc020ee60 <dev_node_ops+0x318>
ffffffffc0209282:	a1cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209286 <bitmap_destroy>:
ffffffffc0209286:	1141                	addi	sp,sp,-16
ffffffffc0209288:	e022                	sd	s0,0(sp)
ffffffffc020928a:	842a                	mv	s0,a0
ffffffffc020928c:	6508                	ld	a0,8(a0)
ffffffffc020928e:	e406                	sd	ra,8(sp)
ffffffffc0209290:	daff80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209294:	8522                	mv	a0,s0
ffffffffc0209296:	6402                	ld	s0,0(sp)
ffffffffc0209298:	60a2                	ld	ra,8(sp)
ffffffffc020929a:	0141                	addi	sp,sp,16
ffffffffc020929c:	da3f806f          	j	ffffffffc020203e <kfree>

ffffffffc02092a0 <bitmap_getdata>:
ffffffffc02092a0:	c589                	beqz	a1,ffffffffc02092aa <bitmap_getdata+0xa>
ffffffffc02092a2:	00456783          	lwu	a5,4(a0)
ffffffffc02092a6:	078a                	slli	a5,a5,0x2
ffffffffc02092a8:	e19c                	sd	a5,0(a1)
ffffffffc02092aa:	6508                	ld	a0,8(a0)
ffffffffc02092ac:	8082                	ret

ffffffffc02092ae <sfs_init>:
ffffffffc02092ae:	1141                	addi	sp,sp,-16
ffffffffc02092b0:	00006517          	auipc	a0,0x6
ffffffffc02092b4:	aa050513          	addi	a0,a0,-1376 # ffffffffc020ed50 <dev_node_ops+0x208>
ffffffffc02092b8:	e406                	sd	ra,8(sp)
ffffffffc02092ba:	554000ef          	jal	ra,ffffffffc020980e <sfs_mount>
ffffffffc02092be:	e501                	bnez	a0,ffffffffc02092c6 <sfs_init+0x18>
ffffffffc02092c0:	60a2                	ld	ra,8(sp)
ffffffffc02092c2:	0141                	addi	sp,sp,16
ffffffffc02092c4:	8082                	ret
ffffffffc02092c6:	86aa                	mv	a3,a0
ffffffffc02092c8:	00006617          	auipc	a2,0x6
ffffffffc02092cc:	c2860613          	addi	a2,a2,-984 # ffffffffc020eef0 <dev_node_ops+0x3a8>
ffffffffc02092d0:	45c1                	li	a1,16
ffffffffc02092d2:	00006517          	auipc	a0,0x6
ffffffffc02092d6:	c3e50513          	addi	a0,a0,-962 # ffffffffc020ef10 <dev_node_ops+0x3c8>
ffffffffc02092da:	9c4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02092de <sfs_unmount>:
ffffffffc02092de:	1141                	addi	sp,sp,-16
ffffffffc02092e0:	e406                	sd	ra,8(sp)
ffffffffc02092e2:	e022                	sd	s0,0(sp)
ffffffffc02092e4:	cd1d                	beqz	a0,ffffffffc0209322 <sfs_unmount+0x44>
ffffffffc02092e6:	0b052783          	lw	a5,176(a0)
ffffffffc02092ea:	842a                	mv	s0,a0
ffffffffc02092ec:	eb9d                	bnez	a5,ffffffffc0209322 <sfs_unmount+0x44>
ffffffffc02092ee:	7158                	ld	a4,160(a0)
ffffffffc02092f0:	09850793          	addi	a5,a0,152
ffffffffc02092f4:	02f71563          	bne	a4,a5,ffffffffc020931e <sfs_unmount+0x40>
ffffffffc02092f8:	613c                	ld	a5,64(a0)
ffffffffc02092fa:	e7a1                	bnez	a5,ffffffffc0209342 <sfs_unmount+0x64>
ffffffffc02092fc:	7d08                	ld	a0,56(a0)
ffffffffc02092fe:	f89ff0ef          	jal	ra,ffffffffc0209286 <bitmap_destroy>
ffffffffc0209302:	6428                	ld	a0,72(s0)
ffffffffc0209304:	d3bf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209308:	7448                	ld	a0,168(s0)
ffffffffc020930a:	d35f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020930e:	8522                	mv	a0,s0
ffffffffc0209310:	d2ff80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209314:	4501                	li	a0,0
ffffffffc0209316:	60a2                	ld	ra,8(sp)
ffffffffc0209318:	6402                	ld	s0,0(sp)
ffffffffc020931a:	0141                	addi	sp,sp,16
ffffffffc020931c:	8082                	ret
ffffffffc020931e:	5545                	li	a0,-15
ffffffffc0209320:	bfdd                	j	ffffffffc0209316 <sfs_unmount+0x38>
ffffffffc0209322:	00006697          	auipc	a3,0x6
ffffffffc0209326:	c0668693          	addi	a3,a3,-1018 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020932a:	00003617          	auipc	a2,0x3
ffffffffc020932e:	82e60613          	addi	a2,a2,-2002 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209332:	04100593          	li	a1,65
ffffffffc0209336:	00006517          	auipc	a0,0x6
ffffffffc020933a:	c2250513          	addi	a0,a0,-990 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc020933e:	960f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209342:	00006697          	auipc	a3,0x6
ffffffffc0209346:	c2e68693          	addi	a3,a3,-978 # ffffffffc020ef70 <dev_node_ops+0x428>
ffffffffc020934a:	00003617          	auipc	a2,0x3
ffffffffc020934e:	80e60613          	addi	a2,a2,-2034 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209352:	04500593          	li	a1,69
ffffffffc0209356:	00006517          	auipc	a0,0x6
ffffffffc020935a:	c0250513          	addi	a0,a0,-1022 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc020935e:	940f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209362 <sfs_cleanup>:
ffffffffc0209362:	1101                	addi	sp,sp,-32
ffffffffc0209364:	ec06                	sd	ra,24(sp)
ffffffffc0209366:	e822                	sd	s0,16(sp)
ffffffffc0209368:	e426                	sd	s1,8(sp)
ffffffffc020936a:	e04a                	sd	s2,0(sp)
ffffffffc020936c:	c525                	beqz	a0,ffffffffc02093d4 <sfs_cleanup+0x72>
ffffffffc020936e:	0b052783          	lw	a5,176(a0)
ffffffffc0209372:	84aa                	mv	s1,a0
ffffffffc0209374:	e3a5                	bnez	a5,ffffffffc02093d4 <sfs_cleanup+0x72>
ffffffffc0209376:	4158                	lw	a4,4(a0)
ffffffffc0209378:	4514                	lw	a3,8(a0)
ffffffffc020937a:	00c50913          	addi	s2,a0,12
ffffffffc020937e:	85ca                	mv	a1,s2
ffffffffc0209380:	40d7063b          	subw	a2,a4,a3
ffffffffc0209384:	00006517          	auipc	a0,0x6
ffffffffc0209388:	c0450513          	addi	a0,a0,-1020 # ffffffffc020ef88 <dev_node_ops+0x440>
ffffffffc020938c:	e1bf60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209390:	02000413          	li	s0,32
ffffffffc0209394:	a019                	j	ffffffffc020939a <sfs_cleanup+0x38>
ffffffffc0209396:	347d                	addiw	s0,s0,-1
ffffffffc0209398:	c819                	beqz	s0,ffffffffc02093ae <sfs_cleanup+0x4c>
ffffffffc020939a:	7cdc                	ld	a5,184(s1)
ffffffffc020939c:	8526                	mv	a0,s1
ffffffffc020939e:	9782                	jalr	a5
ffffffffc02093a0:	f97d                	bnez	a0,ffffffffc0209396 <sfs_cleanup+0x34>
ffffffffc02093a2:	60e2                	ld	ra,24(sp)
ffffffffc02093a4:	6442                	ld	s0,16(sp)
ffffffffc02093a6:	64a2                	ld	s1,8(sp)
ffffffffc02093a8:	6902                	ld	s2,0(sp)
ffffffffc02093aa:	6105                	addi	sp,sp,32
ffffffffc02093ac:	8082                	ret
ffffffffc02093ae:	6442                	ld	s0,16(sp)
ffffffffc02093b0:	60e2                	ld	ra,24(sp)
ffffffffc02093b2:	64a2                	ld	s1,8(sp)
ffffffffc02093b4:	86ca                	mv	a3,s2
ffffffffc02093b6:	6902                	ld	s2,0(sp)
ffffffffc02093b8:	872a                	mv	a4,a0
ffffffffc02093ba:	00006617          	auipc	a2,0x6
ffffffffc02093be:	bee60613          	addi	a2,a2,-1042 # ffffffffc020efa8 <dev_node_ops+0x460>
ffffffffc02093c2:	05f00593          	li	a1,95
ffffffffc02093c6:	00006517          	auipc	a0,0x6
ffffffffc02093ca:	b9250513          	addi	a0,a0,-1134 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc02093ce:	6105                	addi	sp,sp,32
ffffffffc02093d0:	936f706f          	j	ffffffffc0200506 <__warn>
ffffffffc02093d4:	00006697          	auipc	a3,0x6
ffffffffc02093d8:	b5468693          	addi	a3,a3,-1196 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc02093dc:	00002617          	auipc	a2,0x2
ffffffffc02093e0:	77c60613          	addi	a2,a2,1916 # ffffffffc020bb58 <commands+0x210>
ffffffffc02093e4:	05400593          	li	a1,84
ffffffffc02093e8:	00006517          	auipc	a0,0x6
ffffffffc02093ec:	b7050513          	addi	a0,a0,-1168 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc02093f0:	8aef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02093f4 <sfs_sync>:
ffffffffc02093f4:	7179                	addi	sp,sp,-48
ffffffffc02093f6:	f406                	sd	ra,40(sp)
ffffffffc02093f8:	f022                	sd	s0,32(sp)
ffffffffc02093fa:	ec26                	sd	s1,24(sp)
ffffffffc02093fc:	e84a                	sd	s2,16(sp)
ffffffffc02093fe:	e44e                	sd	s3,8(sp)
ffffffffc0209400:	e052                	sd	s4,0(sp)
ffffffffc0209402:	cd4d                	beqz	a0,ffffffffc02094bc <sfs_sync+0xc8>
ffffffffc0209404:	0b052783          	lw	a5,176(a0)
ffffffffc0209408:	8a2a                	mv	s4,a0
ffffffffc020940a:	ebcd                	bnez	a5,ffffffffc02094bc <sfs_sync+0xc8>
ffffffffc020940c:	517010ef          	jal	ra,ffffffffc020b122 <lock_sfs_fs>
ffffffffc0209410:	0a0a3403          	ld	s0,160(s4)
ffffffffc0209414:	098a0913          	addi	s2,s4,152
ffffffffc0209418:	02890763          	beq	s2,s0,ffffffffc0209446 <sfs_sync+0x52>
ffffffffc020941c:	00004997          	auipc	s3,0x4
ffffffffc0209420:	0b498993          	addi	s3,s3,180 # ffffffffc020d4d0 <default_pmm_manager+0xe90>
ffffffffc0209424:	7c1c                	ld	a5,56(s0)
ffffffffc0209426:	fc840493          	addi	s1,s0,-56
ffffffffc020942a:	cbb5                	beqz	a5,ffffffffc020949e <sfs_sync+0xaa>
ffffffffc020942c:	7b9c                	ld	a5,48(a5)
ffffffffc020942e:	cba5                	beqz	a5,ffffffffc020949e <sfs_sync+0xaa>
ffffffffc0209430:	85ce                	mv	a1,s3
ffffffffc0209432:	8526                	mv	a0,s1
ffffffffc0209434:	e28fe0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0209438:	7c1c                	ld	a5,56(s0)
ffffffffc020943a:	8526                	mv	a0,s1
ffffffffc020943c:	7b9c                	ld	a5,48(a5)
ffffffffc020943e:	9782                	jalr	a5
ffffffffc0209440:	6400                	ld	s0,8(s0)
ffffffffc0209442:	fe8911e3          	bne	s2,s0,ffffffffc0209424 <sfs_sync+0x30>
ffffffffc0209446:	8552                	mv	a0,s4
ffffffffc0209448:	4eb010ef          	jal	ra,ffffffffc020b132 <unlock_sfs_fs>
ffffffffc020944c:	040a3783          	ld	a5,64(s4)
ffffffffc0209450:	4501                	li	a0,0
ffffffffc0209452:	eb89                	bnez	a5,ffffffffc0209464 <sfs_sync+0x70>
ffffffffc0209454:	70a2                	ld	ra,40(sp)
ffffffffc0209456:	7402                	ld	s0,32(sp)
ffffffffc0209458:	64e2                	ld	s1,24(sp)
ffffffffc020945a:	6942                	ld	s2,16(sp)
ffffffffc020945c:	69a2                	ld	s3,8(sp)
ffffffffc020945e:	6a02                	ld	s4,0(sp)
ffffffffc0209460:	6145                	addi	sp,sp,48
ffffffffc0209462:	8082                	ret
ffffffffc0209464:	040a3023          	sd	zero,64(s4)
ffffffffc0209468:	8552                	mv	a0,s4
ffffffffc020946a:	39d010ef          	jal	ra,ffffffffc020b006 <sfs_sync_super>
ffffffffc020946e:	cd01                	beqz	a0,ffffffffc0209486 <sfs_sync+0x92>
ffffffffc0209470:	70a2                	ld	ra,40(sp)
ffffffffc0209472:	7402                	ld	s0,32(sp)
ffffffffc0209474:	4785                	li	a5,1
ffffffffc0209476:	04fa3023          	sd	a5,64(s4)
ffffffffc020947a:	64e2                	ld	s1,24(sp)
ffffffffc020947c:	6942                	ld	s2,16(sp)
ffffffffc020947e:	69a2                	ld	s3,8(sp)
ffffffffc0209480:	6a02                	ld	s4,0(sp)
ffffffffc0209482:	6145                	addi	sp,sp,48
ffffffffc0209484:	8082                	ret
ffffffffc0209486:	8552                	mv	a0,s4
ffffffffc0209488:	3c5010ef          	jal	ra,ffffffffc020b04c <sfs_sync_freemap>
ffffffffc020948c:	f175                	bnez	a0,ffffffffc0209470 <sfs_sync+0x7c>
ffffffffc020948e:	70a2                	ld	ra,40(sp)
ffffffffc0209490:	7402                	ld	s0,32(sp)
ffffffffc0209492:	64e2                	ld	s1,24(sp)
ffffffffc0209494:	6942                	ld	s2,16(sp)
ffffffffc0209496:	69a2                	ld	s3,8(sp)
ffffffffc0209498:	6a02                	ld	s4,0(sp)
ffffffffc020949a:	6145                	addi	sp,sp,48
ffffffffc020949c:	8082                	ret
ffffffffc020949e:	00004697          	auipc	a3,0x4
ffffffffc02094a2:	fe268693          	addi	a3,a3,-30 # ffffffffc020d480 <default_pmm_manager+0xe40>
ffffffffc02094a6:	00002617          	auipc	a2,0x2
ffffffffc02094aa:	6b260613          	addi	a2,a2,1714 # ffffffffc020bb58 <commands+0x210>
ffffffffc02094ae:	45ed                	li	a1,27
ffffffffc02094b0:	00006517          	auipc	a0,0x6
ffffffffc02094b4:	aa850513          	addi	a0,a0,-1368 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc02094b8:	fe7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02094bc:	00006697          	auipc	a3,0x6
ffffffffc02094c0:	a6c68693          	addi	a3,a3,-1428 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc02094c4:	00002617          	auipc	a2,0x2
ffffffffc02094c8:	69460613          	addi	a2,a2,1684 # ffffffffc020bb58 <commands+0x210>
ffffffffc02094cc:	45d5                	li	a1,21
ffffffffc02094ce:	00006517          	auipc	a0,0x6
ffffffffc02094d2:	a8a50513          	addi	a0,a0,-1398 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc02094d6:	fc9f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02094da <sfs_get_root>:
ffffffffc02094da:	1101                	addi	sp,sp,-32
ffffffffc02094dc:	ec06                	sd	ra,24(sp)
ffffffffc02094de:	cd09                	beqz	a0,ffffffffc02094f8 <sfs_get_root+0x1e>
ffffffffc02094e0:	0b052783          	lw	a5,176(a0)
ffffffffc02094e4:	eb91                	bnez	a5,ffffffffc02094f8 <sfs_get_root+0x1e>
ffffffffc02094e6:	4605                	li	a2,1
ffffffffc02094e8:	002c                	addi	a1,sp,8
ffffffffc02094ea:	34e010ef          	jal	ra,ffffffffc020a838 <sfs_load_inode>
ffffffffc02094ee:	e50d                	bnez	a0,ffffffffc0209518 <sfs_get_root+0x3e>
ffffffffc02094f0:	60e2                	ld	ra,24(sp)
ffffffffc02094f2:	6522                	ld	a0,8(sp)
ffffffffc02094f4:	6105                	addi	sp,sp,32
ffffffffc02094f6:	8082                	ret
ffffffffc02094f8:	00006697          	auipc	a3,0x6
ffffffffc02094fc:	a3068693          	addi	a3,a3,-1488 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc0209500:	00002617          	auipc	a2,0x2
ffffffffc0209504:	65860613          	addi	a2,a2,1624 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209508:	03600593          	li	a1,54
ffffffffc020950c:	00006517          	auipc	a0,0x6
ffffffffc0209510:	a4c50513          	addi	a0,a0,-1460 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc0209514:	f8bf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209518:	86aa                	mv	a3,a0
ffffffffc020951a:	00006617          	auipc	a2,0x6
ffffffffc020951e:	aae60613          	addi	a2,a2,-1362 # ffffffffc020efc8 <dev_node_ops+0x480>
ffffffffc0209522:	03700593          	li	a1,55
ffffffffc0209526:	00006517          	auipc	a0,0x6
ffffffffc020952a:	a3250513          	addi	a0,a0,-1486 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc020952e:	f71f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209532 <sfs_do_mount>:
ffffffffc0209532:	6518                	ld	a4,8(a0)
ffffffffc0209534:	7171                	addi	sp,sp,-176
ffffffffc0209536:	f506                	sd	ra,168(sp)
ffffffffc0209538:	f122                	sd	s0,160(sp)
ffffffffc020953a:	ed26                	sd	s1,152(sp)
ffffffffc020953c:	e94a                	sd	s2,144(sp)
ffffffffc020953e:	e54e                	sd	s3,136(sp)
ffffffffc0209540:	e152                	sd	s4,128(sp)
ffffffffc0209542:	fcd6                	sd	s5,120(sp)
ffffffffc0209544:	f8da                	sd	s6,112(sp)
ffffffffc0209546:	f4de                	sd	s7,104(sp)
ffffffffc0209548:	f0e2                	sd	s8,96(sp)
ffffffffc020954a:	ece6                	sd	s9,88(sp)
ffffffffc020954c:	e8ea                	sd	s10,80(sp)
ffffffffc020954e:	e4ee                	sd	s11,72(sp)
ffffffffc0209550:	6785                	lui	a5,0x1
ffffffffc0209552:	24f71663          	bne	a4,a5,ffffffffc020979e <sfs_do_mount+0x26c>
ffffffffc0209556:	892a                	mv	s2,a0
ffffffffc0209558:	4501                	li	a0,0
ffffffffc020955a:	8aae                	mv	s5,a1
ffffffffc020955c:	f00fe0ef          	jal	ra,ffffffffc0207c5c <__alloc_fs>
ffffffffc0209560:	842a                	mv	s0,a0
ffffffffc0209562:	24050463          	beqz	a0,ffffffffc02097aa <sfs_do_mount+0x278>
ffffffffc0209566:	0b052b03          	lw	s6,176(a0)
ffffffffc020956a:	260b1263          	bnez	s6,ffffffffc02097ce <sfs_do_mount+0x29c>
ffffffffc020956e:	03253823          	sd	s2,48(a0)
ffffffffc0209572:	6505                	lui	a0,0x1
ffffffffc0209574:	a1bf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209578:	e428                	sd	a0,72(s0)
ffffffffc020957a:	84aa                	mv	s1,a0
ffffffffc020957c:	16050363          	beqz	a0,ffffffffc02096e2 <sfs_do_mount+0x1b0>
ffffffffc0209580:	85aa                	mv	a1,a0
ffffffffc0209582:	4681                	li	a3,0
ffffffffc0209584:	6605                	lui	a2,0x1
ffffffffc0209586:	1008                	addi	a0,sp,32
ffffffffc0209588:	db9fb0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020958c:	02093783          	ld	a5,32(s2)
ffffffffc0209590:	85aa                	mv	a1,a0
ffffffffc0209592:	4601                	li	a2,0
ffffffffc0209594:	854a                	mv	a0,s2
ffffffffc0209596:	9782                	jalr	a5
ffffffffc0209598:	8a2a                	mv	s4,a0
ffffffffc020959a:	10051e63          	bnez	a0,ffffffffc02096b6 <sfs_do_mount+0x184>
ffffffffc020959e:	408c                	lw	a1,0(s1)
ffffffffc02095a0:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc02095a4:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc02095a8:	14c59863          	bne	a1,a2,ffffffffc02096f8 <sfs_do_mount+0x1c6>
ffffffffc02095ac:	40dc                	lw	a5,4(s1)
ffffffffc02095ae:	00093603          	ld	a2,0(s2)
ffffffffc02095b2:	02079713          	slli	a4,a5,0x20
ffffffffc02095b6:	9301                	srli	a4,a4,0x20
ffffffffc02095b8:	12e66763          	bltu	a2,a4,ffffffffc02096e6 <sfs_do_mount+0x1b4>
ffffffffc02095bc:	020485a3          	sb	zero,43(s1)
ffffffffc02095c0:	0084af03          	lw	t5,8(s1)
ffffffffc02095c4:	00c4ae83          	lw	t4,12(s1)
ffffffffc02095c8:	0104ae03          	lw	t3,16(s1)
ffffffffc02095cc:	0144a303          	lw	t1,20(s1)
ffffffffc02095d0:	0184a883          	lw	a7,24(s1)
ffffffffc02095d4:	01c4a803          	lw	a6,28(s1)
ffffffffc02095d8:	5090                	lw	a2,32(s1)
ffffffffc02095da:	50d4                	lw	a3,36(s1)
ffffffffc02095dc:	5498                	lw	a4,40(s1)
ffffffffc02095de:	6511                	lui	a0,0x4
ffffffffc02095e0:	c00c                	sw	a1,0(s0)
ffffffffc02095e2:	c05c                	sw	a5,4(s0)
ffffffffc02095e4:	01e42423          	sw	t5,8(s0)
ffffffffc02095e8:	01d42623          	sw	t4,12(s0)
ffffffffc02095ec:	01c42823          	sw	t3,16(s0)
ffffffffc02095f0:	00642a23          	sw	t1,20(s0)
ffffffffc02095f4:	01142c23          	sw	a7,24(s0)
ffffffffc02095f8:	01042e23          	sw	a6,28(s0)
ffffffffc02095fc:	d010                	sw	a2,32(s0)
ffffffffc02095fe:	d054                	sw	a3,36(s0)
ffffffffc0209600:	d418                	sw	a4,40(s0)
ffffffffc0209602:	98df80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209606:	f448                	sd	a0,168(s0)
ffffffffc0209608:	8c2a                	mv	s8,a0
ffffffffc020960a:	18050c63          	beqz	a0,ffffffffc02097a2 <sfs_do_mount+0x270>
ffffffffc020960e:	6711                	lui	a4,0x4
ffffffffc0209610:	87aa                	mv	a5,a0
ffffffffc0209612:	972a                	add	a4,a4,a0
ffffffffc0209614:	e79c                	sd	a5,8(a5)
ffffffffc0209616:	e39c                	sd	a5,0(a5)
ffffffffc0209618:	07c1                	addi	a5,a5,16
ffffffffc020961a:	fee79de3          	bne	a5,a4,ffffffffc0209614 <sfs_do_mount+0xe2>
ffffffffc020961e:	0044eb83          	lwu	s7,4(s1)
ffffffffc0209622:	67a1                	lui	a5,0x8
ffffffffc0209624:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc0209628:	9bce                	add	s7,s7,s3
ffffffffc020962a:	77e1                	lui	a5,0xffff8
ffffffffc020962c:	00fbfbb3          	and	s7,s7,a5
ffffffffc0209630:	2b81                	sext.w	s7,s7
ffffffffc0209632:	855e                	mv	a0,s7
ffffffffc0209634:	a59ff0ef          	jal	ra,ffffffffc020908c <bitmap_create>
ffffffffc0209638:	fc08                	sd	a0,56(s0)
ffffffffc020963a:	8d2a                	mv	s10,a0
ffffffffc020963c:	14050f63          	beqz	a0,ffffffffc020979a <sfs_do_mount+0x268>
ffffffffc0209640:	0044e783          	lwu	a5,4(s1)
ffffffffc0209644:	082c                	addi	a1,sp,24
ffffffffc0209646:	97ce                	add	a5,a5,s3
ffffffffc0209648:	00f7d713          	srli	a4,a5,0xf
ffffffffc020964c:	e43a                	sd	a4,8(sp)
ffffffffc020964e:	40f7d993          	srai	s3,a5,0xf
ffffffffc0209652:	c4fff0ef          	jal	ra,ffffffffc02092a0 <bitmap_getdata>
ffffffffc0209656:	14050c63          	beqz	a0,ffffffffc02097ae <sfs_do_mount+0x27c>
ffffffffc020965a:	00c9979b          	slliw	a5,s3,0xc
ffffffffc020965e:	66e2                	ld	a3,24(sp)
ffffffffc0209660:	1782                	slli	a5,a5,0x20
ffffffffc0209662:	9381                	srli	a5,a5,0x20
ffffffffc0209664:	14d79563          	bne	a5,a3,ffffffffc02097ae <sfs_do_mount+0x27c>
ffffffffc0209668:	6722                	ld	a4,8(sp)
ffffffffc020966a:	6d89                	lui	s11,0x2
ffffffffc020966c:	89aa                	mv	s3,a0
ffffffffc020966e:	00c71c93          	slli	s9,a4,0xc
ffffffffc0209672:	9caa                	add	s9,s9,a0
ffffffffc0209674:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0209678:	e711                	bnez	a4,ffffffffc0209684 <sfs_do_mount+0x152>
ffffffffc020967a:	a079                	j	ffffffffc0209708 <sfs_do_mount+0x1d6>
ffffffffc020967c:	6785                	lui	a5,0x1
ffffffffc020967e:	99be                	add	s3,s3,a5
ffffffffc0209680:	093c8463          	beq	s9,s3,ffffffffc0209708 <sfs_do_mount+0x1d6>
ffffffffc0209684:	013d86bb          	addw	a3,s11,s3
ffffffffc0209688:	1682                	slli	a3,a3,0x20
ffffffffc020968a:	6605                	lui	a2,0x1
ffffffffc020968c:	85ce                	mv	a1,s3
ffffffffc020968e:	9281                	srli	a3,a3,0x20
ffffffffc0209690:	1008                	addi	a0,sp,32
ffffffffc0209692:	caffb0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0209696:	02093783          	ld	a5,32(s2)
ffffffffc020969a:	85aa                	mv	a1,a0
ffffffffc020969c:	4601                	li	a2,0
ffffffffc020969e:	854a                	mv	a0,s2
ffffffffc02096a0:	9782                	jalr	a5
ffffffffc02096a2:	dd69                	beqz	a0,ffffffffc020967c <sfs_do_mount+0x14a>
ffffffffc02096a4:	e42a                	sd	a0,8(sp)
ffffffffc02096a6:	856a                	mv	a0,s10
ffffffffc02096a8:	bdfff0ef          	jal	ra,ffffffffc0209286 <bitmap_destroy>
ffffffffc02096ac:	67a2                	ld	a5,8(sp)
ffffffffc02096ae:	8a3e                	mv	s4,a5
ffffffffc02096b0:	8562                	mv	a0,s8
ffffffffc02096b2:	98df80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02096b6:	8526                	mv	a0,s1
ffffffffc02096b8:	987f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02096bc:	8522                	mv	a0,s0
ffffffffc02096be:	981f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02096c2:	70aa                	ld	ra,168(sp)
ffffffffc02096c4:	740a                	ld	s0,160(sp)
ffffffffc02096c6:	64ea                	ld	s1,152(sp)
ffffffffc02096c8:	694a                	ld	s2,144(sp)
ffffffffc02096ca:	69aa                	ld	s3,136(sp)
ffffffffc02096cc:	7ae6                	ld	s5,120(sp)
ffffffffc02096ce:	7b46                	ld	s6,112(sp)
ffffffffc02096d0:	7ba6                	ld	s7,104(sp)
ffffffffc02096d2:	7c06                	ld	s8,96(sp)
ffffffffc02096d4:	6ce6                	ld	s9,88(sp)
ffffffffc02096d6:	6d46                	ld	s10,80(sp)
ffffffffc02096d8:	6da6                	ld	s11,72(sp)
ffffffffc02096da:	8552                	mv	a0,s4
ffffffffc02096dc:	6a0a                	ld	s4,128(sp)
ffffffffc02096de:	614d                	addi	sp,sp,176
ffffffffc02096e0:	8082                	ret
ffffffffc02096e2:	5a71                	li	s4,-4
ffffffffc02096e4:	bfe1                	j	ffffffffc02096bc <sfs_do_mount+0x18a>
ffffffffc02096e6:	85be                	mv	a1,a5
ffffffffc02096e8:	00006517          	auipc	a0,0x6
ffffffffc02096ec:	93850513          	addi	a0,a0,-1736 # ffffffffc020f020 <dev_node_ops+0x4d8>
ffffffffc02096f0:	ab7f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02096f4:	5a75                	li	s4,-3
ffffffffc02096f6:	b7c1                	j	ffffffffc02096b6 <sfs_do_mount+0x184>
ffffffffc02096f8:	00006517          	auipc	a0,0x6
ffffffffc02096fc:	8f050513          	addi	a0,a0,-1808 # ffffffffc020efe8 <dev_node_ops+0x4a0>
ffffffffc0209700:	aa7f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209704:	5a75                	li	s4,-3
ffffffffc0209706:	bf45                	j	ffffffffc02096b6 <sfs_do_mount+0x184>
ffffffffc0209708:	00442903          	lw	s2,4(s0)
ffffffffc020970c:	4481                	li	s1,0
ffffffffc020970e:	080b8c63          	beqz	s7,ffffffffc02097a6 <sfs_do_mount+0x274>
ffffffffc0209712:	85a6                	mv	a1,s1
ffffffffc0209714:	856a                	mv	a0,s10
ffffffffc0209716:	af7ff0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc020971a:	c111                	beqz	a0,ffffffffc020971e <sfs_do_mount+0x1ec>
ffffffffc020971c:	2b05                	addiw	s6,s6,1
ffffffffc020971e:	2485                	addiw	s1,s1,1
ffffffffc0209720:	fe9b99e3          	bne	s7,s1,ffffffffc0209712 <sfs_do_mount+0x1e0>
ffffffffc0209724:	441c                	lw	a5,8(s0)
ffffffffc0209726:	0d679463          	bne	a5,s6,ffffffffc02097ee <sfs_do_mount+0x2bc>
ffffffffc020972a:	4585                	li	a1,1
ffffffffc020972c:	05040513          	addi	a0,s0,80
ffffffffc0209730:	04043023          	sd	zero,64(s0)
ffffffffc0209734:	d85fa0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0209738:	4585                	li	a1,1
ffffffffc020973a:	06840513          	addi	a0,s0,104
ffffffffc020973e:	d7bfa0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0209742:	4585                	li	a1,1
ffffffffc0209744:	08040513          	addi	a0,s0,128
ffffffffc0209748:	d71fa0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc020974c:	09840793          	addi	a5,s0,152
ffffffffc0209750:	f05c                	sd	a5,160(s0)
ffffffffc0209752:	ec5c                	sd	a5,152(s0)
ffffffffc0209754:	874a                	mv	a4,s2
ffffffffc0209756:	86da                	mv	a3,s6
ffffffffc0209758:	4169063b          	subw	a2,s2,s6
ffffffffc020975c:	00c40593          	addi	a1,s0,12
ffffffffc0209760:	00006517          	auipc	a0,0x6
ffffffffc0209764:	95050513          	addi	a0,a0,-1712 # ffffffffc020f0b0 <dev_node_ops+0x568>
ffffffffc0209768:	a3ff60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020976c:	00000797          	auipc	a5,0x0
ffffffffc0209770:	c8878793          	addi	a5,a5,-888 # ffffffffc02093f4 <sfs_sync>
ffffffffc0209774:	fc5c                	sd	a5,184(s0)
ffffffffc0209776:	00000797          	auipc	a5,0x0
ffffffffc020977a:	d6478793          	addi	a5,a5,-668 # ffffffffc02094da <sfs_get_root>
ffffffffc020977e:	e07c                	sd	a5,192(s0)
ffffffffc0209780:	00000797          	auipc	a5,0x0
ffffffffc0209784:	b5e78793          	addi	a5,a5,-1186 # ffffffffc02092de <sfs_unmount>
ffffffffc0209788:	e47c                	sd	a5,200(s0)
ffffffffc020978a:	00000797          	auipc	a5,0x0
ffffffffc020978e:	bd878793          	addi	a5,a5,-1064 # ffffffffc0209362 <sfs_cleanup>
ffffffffc0209792:	e87c                	sd	a5,208(s0)
ffffffffc0209794:	008ab023          	sd	s0,0(s5)
ffffffffc0209798:	b72d                	j	ffffffffc02096c2 <sfs_do_mount+0x190>
ffffffffc020979a:	5a71                	li	s4,-4
ffffffffc020979c:	bf11                	j	ffffffffc02096b0 <sfs_do_mount+0x17e>
ffffffffc020979e:	5a49                	li	s4,-14
ffffffffc02097a0:	b70d                	j	ffffffffc02096c2 <sfs_do_mount+0x190>
ffffffffc02097a2:	5a71                	li	s4,-4
ffffffffc02097a4:	bf09                	j	ffffffffc02096b6 <sfs_do_mount+0x184>
ffffffffc02097a6:	4b01                	li	s6,0
ffffffffc02097a8:	bfb5                	j	ffffffffc0209724 <sfs_do_mount+0x1f2>
ffffffffc02097aa:	5a71                	li	s4,-4
ffffffffc02097ac:	bf19                	j	ffffffffc02096c2 <sfs_do_mount+0x190>
ffffffffc02097ae:	00006697          	auipc	a3,0x6
ffffffffc02097b2:	8a268693          	addi	a3,a3,-1886 # ffffffffc020f050 <dev_node_ops+0x508>
ffffffffc02097b6:	00002617          	auipc	a2,0x2
ffffffffc02097ba:	3a260613          	addi	a2,a2,930 # ffffffffc020bb58 <commands+0x210>
ffffffffc02097be:	08300593          	li	a1,131
ffffffffc02097c2:	00005517          	auipc	a0,0x5
ffffffffc02097c6:	79650513          	addi	a0,a0,1942 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc02097ca:	cd5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097ce:	00005697          	auipc	a3,0x5
ffffffffc02097d2:	75a68693          	addi	a3,a3,1882 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc02097d6:	00002617          	auipc	a2,0x2
ffffffffc02097da:	38260613          	addi	a2,a2,898 # ffffffffc020bb58 <commands+0x210>
ffffffffc02097de:	0a300593          	li	a1,163
ffffffffc02097e2:	00005517          	auipc	a0,0x5
ffffffffc02097e6:	77650513          	addi	a0,a0,1910 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc02097ea:	cb5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097ee:	00006697          	auipc	a3,0x6
ffffffffc02097f2:	89268693          	addi	a3,a3,-1902 # ffffffffc020f080 <dev_node_ops+0x538>
ffffffffc02097f6:	00002617          	auipc	a2,0x2
ffffffffc02097fa:	36260613          	addi	a2,a2,866 # ffffffffc020bb58 <commands+0x210>
ffffffffc02097fe:	0e000593          	li	a1,224
ffffffffc0209802:	00005517          	auipc	a0,0x5
ffffffffc0209806:	75650513          	addi	a0,a0,1878 # ffffffffc020ef58 <dev_node_ops+0x410>
ffffffffc020980a:	c95f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020980e <sfs_mount>:
ffffffffc020980e:	00000597          	auipc	a1,0x0
ffffffffc0209812:	d2458593          	addi	a1,a1,-732 # ffffffffc0209532 <sfs_do_mount>
ffffffffc0209816:	817fe06f          	j	ffffffffc020802c <vfs_mount>

ffffffffc020981a <sfs_opendir>:
ffffffffc020981a:	0235f593          	andi	a1,a1,35
ffffffffc020981e:	4501                	li	a0,0
ffffffffc0209820:	e191                	bnez	a1,ffffffffc0209824 <sfs_opendir+0xa>
ffffffffc0209822:	8082                	ret
ffffffffc0209824:	553d                	li	a0,-17
ffffffffc0209826:	8082                	ret

ffffffffc0209828 <sfs_openfile>:
ffffffffc0209828:	4501                	li	a0,0
ffffffffc020982a:	8082                	ret

ffffffffc020982c <sfs_gettype>:
ffffffffc020982c:	1141                	addi	sp,sp,-16
ffffffffc020982e:	e406                	sd	ra,8(sp)
ffffffffc0209830:	c939                	beqz	a0,ffffffffc0209886 <sfs_gettype+0x5a>
ffffffffc0209832:	4d34                	lw	a3,88(a0)
ffffffffc0209834:	6785                	lui	a5,0x1
ffffffffc0209836:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020983a:	04e69663          	bne	a3,a4,ffffffffc0209886 <sfs_gettype+0x5a>
ffffffffc020983e:	6114                	ld	a3,0(a0)
ffffffffc0209840:	4709                	li	a4,2
ffffffffc0209842:	0046d683          	lhu	a3,4(a3)
ffffffffc0209846:	02e68a63          	beq	a3,a4,ffffffffc020987a <sfs_gettype+0x4e>
ffffffffc020984a:	470d                	li	a4,3
ffffffffc020984c:	02e68163          	beq	a3,a4,ffffffffc020986e <sfs_gettype+0x42>
ffffffffc0209850:	4705                	li	a4,1
ffffffffc0209852:	00e68f63          	beq	a3,a4,ffffffffc0209870 <sfs_gettype+0x44>
ffffffffc0209856:	00006617          	auipc	a2,0x6
ffffffffc020985a:	8ca60613          	addi	a2,a2,-1846 # ffffffffc020f120 <dev_node_ops+0x5d8>
ffffffffc020985e:	38c00593          	li	a1,908
ffffffffc0209862:	00006517          	auipc	a0,0x6
ffffffffc0209866:	8a650513          	addi	a0,a0,-1882 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020986a:	c35f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020986e:	678d                	lui	a5,0x3
ffffffffc0209870:	60a2                	ld	ra,8(sp)
ffffffffc0209872:	c19c                	sw	a5,0(a1)
ffffffffc0209874:	4501                	li	a0,0
ffffffffc0209876:	0141                	addi	sp,sp,16
ffffffffc0209878:	8082                	ret
ffffffffc020987a:	60a2                	ld	ra,8(sp)
ffffffffc020987c:	6789                	lui	a5,0x2
ffffffffc020987e:	c19c                	sw	a5,0(a1)
ffffffffc0209880:	4501                	li	a0,0
ffffffffc0209882:	0141                	addi	sp,sp,16
ffffffffc0209884:	8082                	ret
ffffffffc0209886:	00006697          	auipc	a3,0x6
ffffffffc020988a:	84a68693          	addi	a3,a3,-1974 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020988e:	00002617          	auipc	a2,0x2
ffffffffc0209892:	2ca60613          	addi	a2,a2,714 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209896:	38000593          	li	a1,896
ffffffffc020989a:	00006517          	auipc	a0,0x6
ffffffffc020989e:	86e50513          	addi	a0,a0,-1938 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc02098a2:	bfdf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02098a6 <sfs_fsync>:
ffffffffc02098a6:	7179                	addi	sp,sp,-48
ffffffffc02098a8:	ec26                	sd	s1,24(sp)
ffffffffc02098aa:	7524                	ld	s1,104(a0)
ffffffffc02098ac:	f406                	sd	ra,40(sp)
ffffffffc02098ae:	f022                	sd	s0,32(sp)
ffffffffc02098b0:	e84a                	sd	s2,16(sp)
ffffffffc02098b2:	e44e                	sd	s3,8(sp)
ffffffffc02098b4:	c4bd                	beqz	s1,ffffffffc0209922 <sfs_fsync+0x7c>
ffffffffc02098b6:	0b04a783          	lw	a5,176(s1)
ffffffffc02098ba:	e7a5                	bnez	a5,ffffffffc0209922 <sfs_fsync+0x7c>
ffffffffc02098bc:	4d38                	lw	a4,88(a0)
ffffffffc02098be:	6785                	lui	a5,0x1
ffffffffc02098c0:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02098c4:	842a                	mv	s0,a0
ffffffffc02098c6:	06f71e63          	bne	a4,a5,ffffffffc0209942 <sfs_fsync+0x9c>
ffffffffc02098ca:	691c                	ld	a5,16(a0)
ffffffffc02098cc:	4901                	li	s2,0
ffffffffc02098ce:	eb89                	bnez	a5,ffffffffc02098e0 <sfs_fsync+0x3a>
ffffffffc02098d0:	70a2                	ld	ra,40(sp)
ffffffffc02098d2:	7402                	ld	s0,32(sp)
ffffffffc02098d4:	64e2                	ld	s1,24(sp)
ffffffffc02098d6:	69a2                	ld	s3,8(sp)
ffffffffc02098d8:	854a                	mv	a0,s2
ffffffffc02098da:	6942                	ld	s2,16(sp)
ffffffffc02098dc:	6145                	addi	sp,sp,48
ffffffffc02098de:	8082                	ret
ffffffffc02098e0:	02050993          	addi	s3,a0,32
ffffffffc02098e4:	854e                	mv	a0,s3
ffffffffc02098e6:	bddfa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02098ea:	681c                	ld	a5,16(s0)
ffffffffc02098ec:	ef81                	bnez	a5,ffffffffc0209904 <sfs_fsync+0x5e>
ffffffffc02098ee:	854e                	mv	a0,s3
ffffffffc02098f0:	bcffa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02098f4:	70a2                	ld	ra,40(sp)
ffffffffc02098f6:	7402                	ld	s0,32(sp)
ffffffffc02098f8:	64e2                	ld	s1,24(sp)
ffffffffc02098fa:	69a2                	ld	s3,8(sp)
ffffffffc02098fc:	854a                	mv	a0,s2
ffffffffc02098fe:	6942                	ld	s2,16(sp)
ffffffffc0209900:	6145                	addi	sp,sp,48
ffffffffc0209902:	8082                	ret
ffffffffc0209904:	4414                	lw	a3,8(s0)
ffffffffc0209906:	600c                	ld	a1,0(s0)
ffffffffc0209908:	00043823          	sd	zero,16(s0)
ffffffffc020990c:	4701                	li	a4,0
ffffffffc020990e:	04000613          	li	a2,64
ffffffffc0209912:	8526                	mv	a0,s1
ffffffffc0209914:	65e010ef          	jal	ra,ffffffffc020af72 <sfs_wbuf>
ffffffffc0209918:	892a                	mv	s2,a0
ffffffffc020991a:	d971                	beqz	a0,ffffffffc02098ee <sfs_fsync+0x48>
ffffffffc020991c:	4785                	li	a5,1
ffffffffc020991e:	e81c                	sd	a5,16(s0)
ffffffffc0209920:	b7f9                	j	ffffffffc02098ee <sfs_fsync+0x48>
ffffffffc0209922:	00005697          	auipc	a3,0x5
ffffffffc0209926:	60668693          	addi	a3,a3,1542 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020992a:	00002617          	auipc	a2,0x2
ffffffffc020992e:	22e60613          	addi	a2,a2,558 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209932:	2c400593          	li	a1,708
ffffffffc0209936:	00005517          	auipc	a0,0x5
ffffffffc020993a:	7d250513          	addi	a0,a0,2002 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020993e:	b61f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209942:	00005697          	auipc	a3,0x5
ffffffffc0209946:	78e68693          	addi	a3,a3,1934 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020994a:	00002617          	auipc	a2,0x2
ffffffffc020994e:	20e60613          	addi	a2,a2,526 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209952:	2c500593          	li	a1,709
ffffffffc0209956:	00005517          	auipc	a0,0x5
ffffffffc020995a:	7b250513          	addi	a0,a0,1970 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020995e:	b41f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209962 <sfs_fstat>:
ffffffffc0209962:	1101                	addi	sp,sp,-32
ffffffffc0209964:	e426                	sd	s1,8(sp)
ffffffffc0209966:	84ae                	mv	s1,a1
ffffffffc0209968:	e822                	sd	s0,16(sp)
ffffffffc020996a:	02000613          	li	a2,32
ffffffffc020996e:	842a                	mv	s0,a0
ffffffffc0209970:	4581                	li	a1,0
ffffffffc0209972:	8526                	mv	a0,s1
ffffffffc0209974:	ec06                	sd	ra,24(sp)
ffffffffc0209976:	501010ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020997a:	c439                	beqz	s0,ffffffffc02099c8 <sfs_fstat+0x66>
ffffffffc020997c:	783c                	ld	a5,112(s0)
ffffffffc020997e:	c7a9                	beqz	a5,ffffffffc02099c8 <sfs_fstat+0x66>
ffffffffc0209980:	6bbc                	ld	a5,80(a5)
ffffffffc0209982:	c3b9                	beqz	a5,ffffffffc02099c8 <sfs_fstat+0x66>
ffffffffc0209984:	00005597          	auipc	a1,0x5
ffffffffc0209988:	13c58593          	addi	a1,a1,316 # ffffffffc020eac0 <syscalls+0xdb0>
ffffffffc020998c:	8522                	mv	a0,s0
ffffffffc020998e:	8cefe0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0209992:	783c                	ld	a5,112(s0)
ffffffffc0209994:	85a6                	mv	a1,s1
ffffffffc0209996:	8522                	mv	a0,s0
ffffffffc0209998:	6bbc                	ld	a5,80(a5)
ffffffffc020999a:	9782                	jalr	a5
ffffffffc020999c:	e10d                	bnez	a0,ffffffffc02099be <sfs_fstat+0x5c>
ffffffffc020999e:	4c38                	lw	a4,88(s0)
ffffffffc02099a0:	6785                	lui	a5,0x1
ffffffffc02099a2:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02099a6:	04f71163          	bne	a4,a5,ffffffffc02099e8 <sfs_fstat+0x86>
ffffffffc02099aa:	601c                	ld	a5,0(s0)
ffffffffc02099ac:	0067d683          	lhu	a3,6(a5)
ffffffffc02099b0:	0087e703          	lwu	a4,8(a5)
ffffffffc02099b4:	0007e783          	lwu	a5,0(a5)
ffffffffc02099b8:	e494                	sd	a3,8(s1)
ffffffffc02099ba:	e898                	sd	a4,16(s1)
ffffffffc02099bc:	ec9c                	sd	a5,24(s1)
ffffffffc02099be:	60e2                	ld	ra,24(sp)
ffffffffc02099c0:	6442                	ld	s0,16(sp)
ffffffffc02099c2:	64a2                	ld	s1,8(sp)
ffffffffc02099c4:	6105                	addi	sp,sp,32
ffffffffc02099c6:	8082                	ret
ffffffffc02099c8:	00005697          	auipc	a3,0x5
ffffffffc02099cc:	09068693          	addi	a3,a3,144 # ffffffffc020ea58 <syscalls+0xd48>
ffffffffc02099d0:	00002617          	auipc	a2,0x2
ffffffffc02099d4:	18860613          	addi	a2,a2,392 # ffffffffc020bb58 <commands+0x210>
ffffffffc02099d8:	2b500593          	li	a1,693
ffffffffc02099dc:	00005517          	auipc	a0,0x5
ffffffffc02099e0:	72c50513          	addi	a0,a0,1836 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc02099e4:	abbf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099e8:	00005697          	auipc	a3,0x5
ffffffffc02099ec:	6e868693          	addi	a3,a3,1768 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc02099f0:	00002617          	auipc	a2,0x2
ffffffffc02099f4:	16860613          	addi	a2,a2,360 # ffffffffc020bb58 <commands+0x210>
ffffffffc02099f8:	2b800593          	li	a1,696
ffffffffc02099fc:	00005517          	auipc	a0,0x5
ffffffffc0209a00:	70c50513          	addi	a0,a0,1804 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209a04:	a9bf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209a08 <sfs_tryseek>:
ffffffffc0209a08:	080007b7          	lui	a5,0x8000
ffffffffc0209a0c:	04f5fd63          	bgeu	a1,a5,ffffffffc0209a66 <sfs_tryseek+0x5e>
ffffffffc0209a10:	1101                	addi	sp,sp,-32
ffffffffc0209a12:	e822                	sd	s0,16(sp)
ffffffffc0209a14:	ec06                	sd	ra,24(sp)
ffffffffc0209a16:	e426                	sd	s1,8(sp)
ffffffffc0209a18:	842a                	mv	s0,a0
ffffffffc0209a1a:	c921                	beqz	a0,ffffffffc0209a6a <sfs_tryseek+0x62>
ffffffffc0209a1c:	4d38                	lw	a4,88(a0)
ffffffffc0209a1e:	6785                	lui	a5,0x1
ffffffffc0209a20:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209a24:	04f71363          	bne	a4,a5,ffffffffc0209a6a <sfs_tryseek+0x62>
ffffffffc0209a28:	611c                	ld	a5,0(a0)
ffffffffc0209a2a:	84ae                	mv	s1,a1
ffffffffc0209a2c:	0007e783          	lwu	a5,0(a5)
ffffffffc0209a30:	02b7d563          	bge	a5,a1,ffffffffc0209a5a <sfs_tryseek+0x52>
ffffffffc0209a34:	793c                	ld	a5,112(a0)
ffffffffc0209a36:	cbb1                	beqz	a5,ffffffffc0209a8a <sfs_tryseek+0x82>
ffffffffc0209a38:	73bc                	ld	a5,96(a5)
ffffffffc0209a3a:	cba1                	beqz	a5,ffffffffc0209a8a <sfs_tryseek+0x82>
ffffffffc0209a3c:	00005597          	auipc	a1,0x5
ffffffffc0209a40:	f7458593          	addi	a1,a1,-140 # ffffffffc020e9b0 <syscalls+0xca0>
ffffffffc0209a44:	818fe0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0209a48:	783c                	ld	a5,112(s0)
ffffffffc0209a4a:	8522                	mv	a0,s0
ffffffffc0209a4c:	6442                	ld	s0,16(sp)
ffffffffc0209a4e:	60e2                	ld	ra,24(sp)
ffffffffc0209a50:	73bc                	ld	a5,96(a5)
ffffffffc0209a52:	85a6                	mv	a1,s1
ffffffffc0209a54:	64a2                	ld	s1,8(sp)
ffffffffc0209a56:	6105                	addi	sp,sp,32
ffffffffc0209a58:	8782                	jr	a5
ffffffffc0209a5a:	60e2                	ld	ra,24(sp)
ffffffffc0209a5c:	6442                	ld	s0,16(sp)
ffffffffc0209a5e:	64a2                	ld	s1,8(sp)
ffffffffc0209a60:	4501                	li	a0,0
ffffffffc0209a62:	6105                	addi	sp,sp,32
ffffffffc0209a64:	8082                	ret
ffffffffc0209a66:	5575                	li	a0,-3
ffffffffc0209a68:	8082                	ret
ffffffffc0209a6a:	00005697          	auipc	a3,0x5
ffffffffc0209a6e:	66668693          	addi	a3,a3,1638 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc0209a72:	00002617          	auipc	a2,0x2
ffffffffc0209a76:	0e660613          	addi	a2,a2,230 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209a7a:	39700593          	li	a1,919
ffffffffc0209a7e:	00005517          	auipc	a0,0x5
ffffffffc0209a82:	68a50513          	addi	a0,a0,1674 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209a86:	a19f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a8a:	00005697          	auipc	a3,0x5
ffffffffc0209a8e:	ece68693          	addi	a3,a3,-306 # ffffffffc020e958 <syscalls+0xc48>
ffffffffc0209a92:	00002617          	auipc	a2,0x2
ffffffffc0209a96:	0c660613          	addi	a2,a2,198 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209a9a:	39900593          	li	a1,921
ffffffffc0209a9e:	00005517          	auipc	a0,0x5
ffffffffc0209aa2:	66a50513          	addi	a0,a0,1642 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209aa6:	9f9f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209aaa <sfs_close>:
ffffffffc0209aaa:	1141                	addi	sp,sp,-16
ffffffffc0209aac:	e406                	sd	ra,8(sp)
ffffffffc0209aae:	e022                	sd	s0,0(sp)
ffffffffc0209ab0:	c11d                	beqz	a0,ffffffffc0209ad6 <sfs_close+0x2c>
ffffffffc0209ab2:	793c                	ld	a5,112(a0)
ffffffffc0209ab4:	842a                	mv	s0,a0
ffffffffc0209ab6:	c385                	beqz	a5,ffffffffc0209ad6 <sfs_close+0x2c>
ffffffffc0209ab8:	7b9c                	ld	a5,48(a5)
ffffffffc0209aba:	cf91                	beqz	a5,ffffffffc0209ad6 <sfs_close+0x2c>
ffffffffc0209abc:	00004597          	auipc	a1,0x4
ffffffffc0209ac0:	a1458593          	addi	a1,a1,-1516 # ffffffffc020d4d0 <default_pmm_manager+0xe90>
ffffffffc0209ac4:	f99fd0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0209ac8:	783c                	ld	a5,112(s0)
ffffffffc0209aca:	8522                	mv	a0,s0
ffffffffc0209acc:	6402                	ld	s0,0(sp)
ffffffffc0209ace:	60a2                	ld	ra,8(sp)
ffffffffc0209ad0:	7b9c                	ld	a5,48(a5)
ffffffffc0209ad2:	0141                	addi	sp,sp,16
ffffffffc0209ad4:	8782                	jr	a5
ffffffffc0209ad6:	00004697          	auipc	a3,0x4
ffffffffc0209ada:	9aa68693          	addi	a3,a3,-1622 # ffffffffc020d480 <default_pmm_manager+0xe40>
ffffffffc0209ade:	00002617          	auipc	a2,0x2
ffffffffc0209ae2:	07a60613          	addi	a2,a2,122 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209ae6:	21c00593          	li	a1,540
ffffffffc0209aea:	00005517          	auipc	a0,0x5
ffffffffc0209aee:	61e50513          	addi	a0,a0,1566 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209af2:	9adf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209af6 <sfs_io.part.0>:
ffffffffc0209af6:	1141                	addi	sp,sp,-16
ffffffffc0209af8:	00005697          	auipc	a3,0x5
ffffffffc0209afc:	5d868693          	addi	a3,a3,1496 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc0209b00:	00002617          	auipc	a2,0x2
ffffffffc0209b04:	05860613          	addi	a2,a2,88 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209b08:	29400593          	li	a1,660
ffffffffc0209b0c:	00005517          	auipc	a0,0x5
ffffffffc0209b10:	5fc50513          	addi	a0,a0,1532 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209b14:	e406                	sd	ra,8(sp)
ffffffffc0209b16:	989f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b1a <sfs_block_free>:
ffffffffc0209b1a:	1101                	addi	sp,sp,-32
ffffffffc0209b1c:	e426                	sd	s1,8(sp)
ffffffffc0209b1e:	ec06                	sd	ra,24(sp)
ffffffffc0209b20:	e822                	sd	s0,16(sp)
ffffffffc0209b22:	4154                	lw	a3,4(a0)
ffffffffc0209b24:	84ae                	mv	s1,a1
ffffffffc0209b26:	c595                	beqz	a1,ffffffffc0209b52 <sfs_block_free+0x38>
ffffffffc0209b28:	02d5f563          	bgeu	a1,a3,ffffffffc0209b52 <sfs_block_free+0x38>
ffffffffc0209b2c:	842a                	mv	s0,a0
ffffffffc0209b2e:	7d08                	ld	a0,56(a0)
ffffffffc0209b30:	edcff0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc0209b34:	ed05                	bnez	a0,ffffffffc0209b6c <sfs_block_free+0x52>
ffffffffc0209b36:	7c08                	ld	a0,56(s0)
ffffffffc0209b38:	85a6                	mv	a1,s1
ffffffffc0209b3a:	efaff0ef          	jal	ra,ffffffffc0209234 <bitmap_free>
ffffffffc0209b3e:	441c                	lw	a5,8(s0)
ffffffffc0209b40:	4705                	li	a4,1
ffffffffc0209b42:	60e2                	ld	ra,24(sp)
ffffffffc0209b44:	2785                	addiw	a5,a5,1
ffffffffc0209b46:	e038                	sd	a4,64(s0)
ffffffffc0209b48:	c41c                	sw	a5,8(s0)
ffffffffc0209b4a:	6442                	ld	s0,16(sp)
ffffffffc0209b4c:	64a2                	ld	s1,8(sp)
ffffffffc0209b4e:	6105                	addi	sp,sp,32
ffffffffc0209b50:	8082                	ret
ffffffffc0209b52:	8726                	mv	a4,s1
ffffffffc0209b54:	00005617          	auipc	a2,0x5
ffffffffc0209b58:	5e460613          	addi	a2,a2,1508 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc0209b5c:	05300593          	li	a1,83
ffffffffc0209b60:	00005517          	auipc	a0,0x5
ffffffffc0209b64:	5a850513          	addi	a0,a0,1448 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209b68:	937f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b6c:	00005697          	auipc	a3,0x5
ffffffffc0209b70:	60468693          	addi	a3,a3,1540 # ffffffffc020f170 <dev_node_ops+0x628>
ffffffffc0209b74:	00002617          	auipc	a2,0x2
ffffffffc0209b78:	fe460613          	addi	a2,a2,-28 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209b7c:	06a00593          	li	a1,106
ffffffffc0209b80:	00005517          	auipc	a0,0x5
ffffffffc0209b84:	58850513          	addi	a0,a0,1416 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209b88:	917f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b8c <sfs_reclaim>:
ffffffffc0209b8c:	1101                	addi	sp,sp,-32
ffffffffc0209b8e:	e426                	sd	s1,8(sp)
ffffffffc0209b90:	7524                	ld	s1,104(a0)
ffffffffc0209b92:	ec06                	sd	ra,24(sp)
ffffffffc0209b94:	e822                	sd	s0,16(sp)
ffffffffc0209b96:	e04a                	sd	s2,0(sp)
ffffffffc0209b98:	0e048a63          	beqz	s1,ffffffffc0209c8c <sfs_reclaim+0x100>
ffffffffc0209b9c:	0b04a783          	lw	a5,176(s1)
ffffffffc0209ba0:	0e079663          	bnez	a5,ffffffffc0209c8c <sfs_reclaim+0x100>
ffffffffc0209ba4:	4d38                	lw	a4,88(a0)
ffffffffc0209ba6:	6785                	lui	a5,0x1
ffffffffc0209ba8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209bac:	842a                	mv	s0,a0
ffffffffc0209bae:	10f71f63          	bne	a4,a5,ffffffffc0209ccc <sfs_reclaim+0x140>
ffffffffc0209bb2:	8526                	mv	a0,s1
ffffffffc0209bb4:	56e010ef          	jal	ra,ffffffffc020b122 <lock_sfs_fs>
ffffffffc0209bb8:	4c1c                	lw	a5,24(s0)
ffffffffc0209bba:	0ef05963          	blez	a5,ffffffffc0209cac <sfs_reclaim+0x120>
ffffffffc0209bbe:	fff7871b          	addiw	a4,a5,-1
ffffffffc0209bc2:	cc18                	sw	a4,24(s0)
ffffffffc0209bc4:	eb59                	bnez	a4,ffffffffc0209c5a <sfs_reclaim+0xce>
ffffffffc0209bc6:	05c42903          	lw	s2,92(s0)
ffffffffc0209bca:	08091863          	bnez	s2,ffffffffc0209c5a <sfs_reclaim+0xce>
ffffffffc0209bce:	601c                	ld	a5,0(s0)
ffffffffc0209bd0:	0067d783          	lhu	a5,6(a5)
ffffffffc0209bd4:	e785                	bnez	a5,ffffffffc0209bfc <sfs_reclaim+0x70>
ffffffffc0209bd6:	783c                	ld	a5,112(s0)
ffffffffc0209bd8:	10078a63          	beqz	a5,ffffffffc0209cec <sfs_reclaim+0x160>
ffffffffc0209bdc:	73bc                	ld	a5,96(a5)
ffffffffc0209bde:	10078763          	beqz	a5,ffffffffc0209cec <sfs_reclaim+0x160>
ffffffffc0209be2:	00005597          	auipc	a1,0x5
ffffffffc0209be6:	dce58593          	addi	a1,a1,-562 # ffffffffc020e9b0 <syscalls+0xca0>
ffffffffc0209bea:	8522                	mv	a0,s0
ffffffffc0209bec:	e71fd0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0209bf0:	783c                	ld	a5,112(s0)
ffffffffc0209bf2:	4581                	li	a1,0
ffffffffc0209bf4:	8522                	mv	a0,s0
ffffffffc0209bf6:	73bc                	ld	a5,96(a5)
ffffffffc0209bf8:	9782                	jalr	a5
ffffffffc0209bfa:	e559                	bnez	a0,ffffffffc0209c88 <sfs_reclaim+0xfc>
ffffffffc0209bfc:	681c                	ld	a5,16(s0)
ffffffffc0209bfe:	c39d                	beqz	a5,ffffffffc0209c24 <sfs_reclaim+0x98>
ffffffffc0209c00:	783c                	ld	a5,112(s0)
ffffffffc0209c02:	10078563          	beqz	a5,ffffffffc0209d0c <sfs_reclaim+0x180>
ffffffffc0209c06:	7b9c                	ld	a5,48(a5)
ffffffffc0209c08:	10078263          	beqz	a5,ffffffffc0209d0c <sfs_reclaim+0x180>
ffffffffc0209c0c:	8522                	mv	a0,s0
ffffffffc0209c0e:	00004597          	auipc	a1,0x4
ffffffffc0209c12:	8c258593          	addi	a1,a1,-1854 # ffffffffc020d4d0 <default_pmm_manager+0xe90>
ffffffffc0209c16:	e47fd0ef          	jal	ra,ffffffffc0207a5c <inode_check>
ffffffffc0209c1a:	783c                	ld	a5,112(s0)
ffffffffc0209c1c:	8522                	mv	a0,s0
ffffffffc0209c1e:	7b9c                	ld	a5,48(a5)
ffffffffc0209c20:	9782                	jalr	a5
ffffffffc0209c22:	e13d                	bnez	a0,ffffffffc0209c88 <sfs_reclaim+0xfc>
ffffffffc0209c24:	7c18                	ld	a4,56(s0)
ffffffffc0209c26:	603c                	ld	a5,64(s0)
ffffffffc0209c28:	8526                	mv	a0,s1
ffffffffc0209c2a:	e71c                	sd	a5,8(a4)
ffffffffc0209c2c:	e398                	sd	a4,0(a5)
ffffffffc0209c2e:	6438                	ld	a4,72(s0)
ffffffffc0209c30:	683c                	ld	a5,80(s0)
ffffffffc0209c32:	e71c                	sd	a5,8(a4)
ffffffffc0209c34:	e398                	sd	a4,0(a5)
ffffffffc0209c36:	4fc010ef          	jal	ra,ffffffffc020b132 <unlock_sfs_fs>
ffffffffc0209c3a:	6008                	ld	a0,0(s0)
ffffffffc0209c3c:	00655783          	lhu	a5,6(a0)
ffffffffc0209c40:	cb85                	beqz	a5,ffffffffc0209c70 <sfs_reclaim+0xe4>
ffffffffc0209c42:	bfcf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209c46:	8522                	mv	a0,s0
ffffffffc0209c48:	da9fd0ef          	jal	ra,ffffffffc02079f0 <inode_kill>
ffffffffc0209c4c:	60e2                	ld	ra,24(sp)
ffffffffc0209c4e:	6442                	ld	s0,16(sp)
ffffffffc0209c50:	64a2                	ld	s1,8(sp)
ffffffffc0209c52:	854a                	mv	a0,s2
ffffffffc0209c54:	6902                	ld	s2,0(sp)
ffffffffc0209c56:	6105                	addi	sp,sp,32
ffffffffc0209c58:	8082                	ret
ffffffffc0209c5a:	5945                	li	s2,-15
ffffffffc0209c5c:	8526                	mv	a0,s1
ffffffffc0209c5e:	4d4010ef          	jal	ra,ffffffffc020b132 <unlock_sfs_fs>
ffffffffc0209c62:	60e2                	ld	ra,24(sp)
ffffffffc0209c64:	6442                	ld	s0,16(sp)
ffffffffc0209c66:	64a2                	ld	s1,8(sp)
ffffffffc0209c68:	854a                	mv	a0,s2
ffffffffc0209c6a:	6902                	ld	s2,0(sp)
ffffffffc0209c6c:	6105                	addi	sp,sp,32
ffffffffc0209c6e:	8082                	ret
ffffffffc0209c70:	440c                	lw	a1,8(s0)
ffffffffc0209c72:	8526                	mv	a0,s1
ffffffffc0209c74:	ea7ff0ef          	jal	ra,ffffffffc0209b1a <sfs_block_free>
ffffffffc0209c78:	6008                	ld	a0,0(s0)
ffffffffc0209c7a:	5d4c                	lw	a1,60(a0)
ffffffffc0209c7c:	d1f9                	beqz	a1,ffffffffc0209c42 <sfs_reclaim+0xb6>
ffffffffc0209c7e:	8526                	mv	a0,s1
ffffffffc0209c80:	e9bff0ef          	jal	ra,ffffffffc0209b1a <sfs_block_free>
ffffffffc0209c84:	6008                	ld	a0,0(s0)
ffffffffc0209c86:	bf75                	j	ffffffffc0209c42 <sfs_reclaim+0xb6>
ffffffffc0209c88:	892a                	mv	s2,a0
ffffffffc0209c8a:	bfc9                	j	ffffffffc0209c5c <sfs_reclaim+0xd0>
ffffffffc0209c8c:	00005697          	auipc	a3,0x5
ffffffffc0209c90:	29c68693          	addi	a3,a3,668 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc0209c94:	00002617          	auipc	a2,0x2
ffffffffc0209c98:	ec460613          	addi	a2,a2,-316 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209c9c:	35500593          	li	a1,853
ffffffffc0209ca0:	00005517          	auipc	a0,0x5
ffffffffc0209ca4:	46850513          	addi	a0,a0,1128 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209ca8:	ff6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cac:	00005697          	auipc	a3,0x5
ffffffffc0209cb0:	4e468693          	addi	a3,a3,1252 # ffffffffc020f190 <dev_node_ops+0x648>
ffffffffc0209cb4:	00002617          	auipc	a2,0x2
ffffffffc0209cb8:	ea460613          	addi	a2,a2,-348 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209cbc:	35b00593          	li	a1,859
ffffffffc0209cc0:	00005517          	auipc	a0,0x5
ffffffffc0209cc4:	44850513          	addi	a0,a0,1096 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209cc8:	fd6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209ccc:	00005697          	auipc	a3,0x5
ffffffffc0209cd0:	40468693          	addi	a3,a3,1028 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc0209cd4:	00002617          	auipc	a2,0x2
ffffffffc0209cd8:	e8460613          	addi	a2,a2,-380 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209cdc:	35600593          	li	a1,854
ffffffffc0209ce0:	00005517          	auipc	a0,0x5
ffffffffc0209ce4:	42850513          	addi	a0,a0,1064 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209ce8:	fb6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cec:	00005697          	auipc	a3,0x5
ffffffffc0209cf0:	c6c68693          	addi	a3,a3,-916 # ffffffffc020e958 <syscalls+0xc48>
ffffffffc0209cf4:	00002617          	auipc	a2,0x2
ffffffffc0209cf8:	e6460613          	addi	a2,a2,-412 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209cfc:	36000593          	li	a1,864
ffffffffc0209d00:	00005517          	auipc	a0,0x5
ffffffffc0209d04:	40850513          	addi	a0,a0,1032 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209d08:	f96f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d0c:	00003697          	auipc	a3,0x3
ffffffffc0209d10:	77468693          	addi	a3,a3,1908 # ffffffffc020d480 <default_pmm_manager+0xe40>
ffffffffc0209d14:	00002617          	auipc	a2,0x2
ffffffffc0209d18:	e4460613          	addi	a2,a2,-444 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209d1c:	36500593          	li	a1,869
ffffffffc0209d20:	00005517          	auipc	a0,0x5
ffffffffc0209d24:	3e850513          	addi	a0,a0,1000 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209d28:	f76f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209d2c <sfs_block_alloc>:
ffffffffc0209d2c:	1101                	addi	sp,sp,-32
ffffffffc0209d2e:	e822                	sd	s0,16(sp)
ffffffffc0209d30:	842a                	mv	s0,a0
ffffffffc0209d32:	7d08                	ld	a0,56(a0)
ffffffffc0209d34:	e426                	sd	s1,8(sp)
ffffffffc0209d36:	ec06                	sd	ra,24(sp)
ffffffffc0209d38:	84ae                	mv	s1,a1
ffffffffc0209d3a:	c62ff0ef          	jal	ra,ffffffffc020919c <bitmap_alloc>
ffffffffc0209d3e:	e90d                	bnez	a0,ffffffffc0209d70 <sfs_block_alloc+0x44>
ffffffffc0209d40:	441c                	lw	a5,8(s0)
ffffffffc0209d42:	cbad                	beqz	a5,ffffffffc0209db4 <sfs_block_alloc+0x88>
ffffffffc0209d44:	37fd                	addiw	a5,a5,-1
ffffffffc0209d46:	c41c                	sw	a5,8(s0)
ffffffffc0209d48:	408c                	lw	a1,0(s1)
ffffffffc0209d4a:	4785                	li	a5,1
ffffffffc0209d4c:	e03c                	sd	a5,64(s0)
ffffffffc0209d4e:	4054                	lw	a3,4(s0)
ffffffffc0209d50:	c58d                	beqz	a1,ffffffffc0209d7a <sfs_block_alloc+0x4e>
ffffffffc0209d52:	02d5f463          	bgeu	a1,a3,ffffffffc0209d7a <sfs_block_alloc+0x4e>
ffffffffc0209d56:	7c08                	ld	a0,56(s0)
ffffffffc0209d58:	cb4ff0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc0209d5c:	ed05                	bnez	a0,ffffffffc0209d94 <sfs_block_alloc+0x68>
ffffffffc0209d5e:	8522                	mv	a0,s0
ffffffffc0209d60:	6442                	ld	s0,16(sp)
ffffffffc0209d62:	408c                	lw	a1,0(s1)
ffffffffc0209d64:	60e2                	ld	ra,24(sp)
ffffffffc0209d66:	64a2                	ld	s1,8(sp)
ffffffffc0209d68:	4605                	li	a2,1
ffffffffc0209d6a:	6105                	addi	sp,sp,32
ffffffffc0209d6c:	3560106f          	j	ffffffffc020b0c2 <sfs_clear_block>
ffffffffc0209d70:	60e2                	ld	ra,24(sp)
ffffffffc0209d72:	6442                	ld	s0,16(sp)
ffffffffc0209d74:	64a2                	ld	s1,8(sp)
ffffffffc0209d76:	6105                	addi	sp,sp,32
ffffffffc0209d78:	8082                	ret
ffffffffc0209d7a:	872e                	mv	a4,a1
ffffffffc0209d7c:	00005617          	auipc	a2,0x5
ffffffffc0209d80:	3bc60613          	addi	a2,a2,956 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc0209d84:	05300593          	li	a1,83
ffffffffc0209d88:	00005517          	auipc	a0,0x5
ffffffffc0209d8c:	38050513          	addi	a0,a0,896 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209d90:	f0ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d94:	00005697          	auipc	a3,0x5
ffffffffc0209d98:	43468693          	addi	a3,a3,1076 # ffffffffc020f1c8 <dev_node_ops+0x680>
ffffffffc0209d9c:	00002617          	auipc	a2,0x2
ffffffffc0209da0:	dbc60613          	addi	a2,a2,-580 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209da4:	06100593          	li	a1,97
ffffffffc0209da8:	00005517          	auipc	a0,0x5
ffffffffc0209dac:	36050513          	addi	a0,a0,864 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209db0:	eeef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209db4:	00005697          	auipc	a3,0x5
ffffffffc0209db8:	3f468693          	addi	a3,a3,1012 # ffffffffc020f1a8 <dev_node_ops+0x660>
ffffffffc0209dbc:	00002617          	auipc	a2,0x2
ffffffffc0209dc0:	d9c60613          	addi	a2,a2,-612 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209dc4:	05f00593          	li	a1,95
ffffffffc0209dc8:	00005517          	auipc	a0,0x5
ffffffffc0209dcc:	34050513          	addi	a0,a0,832 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209dd0:	ecef60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209dd4 <sfs_bmap_load_nolock>:
ffffffffc0209dd4:	7159                	addi	sp,sp,-112
ffffffffc0209dd6:	f85a                	sd	s6,48(sp)
ffffffffc0209dd8:	0005bb03          	ld	s6,0(a1)
ffffffffc0209ddc:	f45e                	sd	s7,40(sp)
ffffffffc0209dde:	f486                	sd	ra,104(sp)
ffffffffc0209de0:	008b2b83          	lw	s7,8(s6)
ffffffffc0209de4:	f0a2                	sd	s0,96(sp)
ffffffffc0209de6:	eca6                	sd	s1,88(sp)
ffffffffc0209de8:	e8ca                	sd	s2,80(sp)
ffffffffc0209dea:	e4ce                	sd	s3,72(sp)
ffffffffc0209dec:	e0d2                	sd	s4,64(sp)
ffffffffc0209dee:	fc56                	sd	s5,56(sp)
ffffffffc0209df0:	f062                	sd	s8,32(sp)
ffffffffc0209df2:	ec66                	sd	s9,24(sp)
ffffffffc0209df4:	18cbe363          	bltu	s7,a2,ffffffffc0209f7a <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209df8:	47ad                	li	a5,11
ffffffffc0209dfa:	8aae                	mv	s5,a1
ffffffffc0209dfc:	8432                	mv	s0,a2
ffffffffc0209dfe:	84aa                	mv	s1,a0
ffffffffc0209e00:	89b6                	mv	s3,a3
ffffffffc0209e02:	04c7f563          	bgeu	a5,a2,ffffffffc0209e4c <sfs_bmap_load_nolock+0x78>
ffffffffc0209e06:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209e0a:	0007069b          	sext.w	a3,a4
ffffffffc0209e0e:	3ff00793          	li	a5,1023
ffffffffc0209e12:	1ad7e163          	bltu	a5,a3,ffffffffc0209fb4 <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209e16:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209e1a:	02071793          	slli	a5,a4,0x20
ffffffffc0209e1e:	c602                	sw	zero,12(sp)
ffffffffc0209e20:	c452                	sw	s4,8(sp)
ffffffffc0209e22:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209e26:	0e0a1e63          	bnez	s4,ffffffffc0209f22 <sfs_bmap_load_nolock+0x14e>
ffffffffc0209e2a:	0acb8663          	beq	s7,a2,ffffffffc0209ed6 <sfs_bmap_load_nolock+0x102>
ffffffffc0209e2e:	4a01                	li	s4,0
ffffffffc0209e30:	40d4                	lw	a3,4(s1)
ffffffffc0209e32:	8752                	mv	a4,s4
ffffffffc0209e34:	00005617          	auipc	a2,0x5
ffffffffc0209e38:	30460613          	addi	a2,a2,772 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc0209e3c:	05300593          	li	a1,83
ffffffffc0209e40:	00005517          	auipc	a0,0x5
ffffffffc0209e44:	2c850513          	addi	a0,a0,712 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209e48:	e56f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e4c:	02061793          	slli	a5,a2,0x20
ffffffffc0209e50:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209e54:	9a5a                	add	s4,s4,s6
ffffffffc0209e56:	00ca2583          	lw	a1,12(s4)
ffffffffc0209e5a:	c22e                	sw	a1,4(sp)
ffffffffc0209e5c:	ed99                	bnez	a1,ffffffffc0209e7a <sfs_bmap_load_nolock+0xa6>
ffffffffc0209e5e:	fccb98e3          	bne	s7,a2,ffffffffc0209e2e <sfs_bmap_load_nolock+0x5a>
ffffffffc0209e62:	004c                	addi	a1,sp,4
ffffffffc0209e64:	ec9ff0ef          	jal	ra,ffffffffc0209d2c <sfs_block_alloc>
ffffffffc0209e68:	892a                	mv	s2,a0
ffffffffc0209e6a:	e921                	bnez	a0,ffffffffc0209eba <sfs_bmap_load_nolock+0xe6>
ffffffffc0209e6c:	4592                	lw	a1,4(sp)
ffffffffc0209e6e:	4705                	li	a4,1
ffffffffc0209e70:	00ba2623          	sw	a1,12(s4)
ffffffffc0209e74:	00eab823          	sd	a4,16(s5)
ffffffffc0209e78:	d9dd                	beqz	a1,ffffffffc0209e2e <sfs_bmap_load_nolock+0x5a>
ffffffffc0209e7a:	40d4                	lw	a3,4(s1)
ffffffffc0209e7c:	10d5ff63          	bgeu	a1,a3,ffffffffc0209f9a <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209e80:	7c88                	ld	a0,56(s1)
ffffffffc0209e82:	b8aff0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc0209e86:	18051363          	bnez	a0,ffffffffc020a00c <sfs_bmap_load_nolock+0x238>
ffffffffc0209e8a:	4a12                	lw	s4,4(sp)
ffffffffc0209e8c:	fa0a02e3          	beqz	s4,ffffffffc0209e30 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209e90:	40dc                	lw	a5,4(s1)
ffffffffc0209e92:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209e30 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209e96:	7c88                	ld	a0,56(s1)
ffffffffc0209e98:	85d2                	mv	a1,s4
ffffffffc0209e9a:	b72ff0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc0209e9e:	12051763          	bnez	a0,ffffffffc0209fcc <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209ea2:	008b9763          	bne	s7,s0,ffffffffc0209eb0 <sfs_bmap_load_nolock+0xdc>
ffffffffc0209ea6:	008b2783          	lw	a5,8(s6)
ffffffffc0209eaa:	2785                	addiw	a5,a5,1
ffffffffc0209eac:	00fb2423          	sw	a5,8(s6)
ffffffffc0209eb0:	4901                	li	s2,0
ffffffffc0209eb2:	00098463          	beqz	s3,ffffffffc0209eba <sfs_bmap_load_nolock+0xe6>
ffffffffc0209eb6:	0149a023          	sw	s4,0(s3)
ffffffffc0209eba:	70a6                	ld	ra,104(sp)
ffffffffc0209ebc:	7406                	ld	s0,96(sp)
ffffffffc0209ebe:	64e6                	ld	s1,88(sp)
ffffffffc0209ec0:	69a6                	ld	s3,72(sp)
ffffffffc0209ec2:	6a06                	ld	s4,64(sp)
ffffffffc0209ec4:	7ae2                	ld	s5,56(sp)
ffffffffc0209ec6:	7b42                	ld	s6,48(sp)
ffffffffc0209ec8:	7ba2                	ld	s7,40(sp)
ffffffffc0209eca:	7c02                	ld	s8,32(sp)
ffffffffc0209ecc:	6ce2                	ld	s9,24(sp)
ffffffffc0209ece:	854a                	mv	a0,s2
ffffffffc0209ed0:	6946                	ld	s2,80(sp)
ffffffffc0209ed2:	6165                	addi	sp,sp,112
ffffffffc0209ed4:	8082                	ret
ffffffffc0209ed6:	002c                	addi	a1,sp,8
ffffffffc0209ed8:	e55ff0ef          	jal	ra,ffffffffc0209d2c <sfs_block_alloc>
ffffffffc0209edc:	892a                	mv	s2,a0
ffffffffc0209ede:	00c10c93          	addi	s9,sp,12
ffffffffc0209ee2:	fd61                	bnez	a0,ffffffffc0209eba <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ee4:	85e6                	mv	a1,s9
ffffffffc0209ee6:	8526                	mv	a0,s1
ffffffffc0209ee8:	e45ff0ef          	jal	ra,ffffffffc0209d2c <sfs_block_alloc>
ffffffffc0209eec:	892a                	mv	s2,a0
ffffffffc0209eee:	e925                	bnez	a0,ffffffffc0209f5e <sfs_bmap_load_nolock+0x18a>
ffffffffc0209ef0:	46a2                	lw	a3,8(sp)
ffffffffc0209ef2:	85e6                	mv	a1,s9
ffffffffc0209ef4:	8762                	mv	a4,s8
ffffffffc0209ef6:	4611                	li	a2,4
ffffffffc0209ef8:	8526                	mv	a0,s1
ffffffffc0209efa:	078010ef          	jal	ra,ffffffffc020af72 <sfs_wbuf>
ffffffffc0209efe:	45b2                	lw	a1,12(sp)
ffffffffc0209f00:	892a                	mv	s2,a0
ffffffffc0209f02:	e939                	bnez	a0,ffffffffc0209f58 <sfs_bmap_load_nolock+0x184>
ffffffffc0209f04:	03cb2683          	lw	a3,60(s6)
ffffffffc0209f08:	4722                	lw	a4,8(sp)
ffffffffc0209f0a:	c22e                	sw	a1,4(sp)
ffffffffc0209f0c:	f6d706e3          	beq	a4,a3,ffffffffc0209e78 <sfs_bmap_load_nolock+0xa4>
ffffffffc0209f10:	eef1                	bnez	a3,ffffffffc0209fec <sfs_bmap_load_nolock+0x218>
ffffffffc0209f12:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209f16:	4705                	li	a4,1
ffffffffc0209f18:	00eab823          	sd	a4,16(s5)
ffffffffc0209f1c:	f00589e3          	beqz	a1,ffffffffc0209e2e <sfs_bmap_load_nolock+0x5a>
ffffffffc0209f20:	bfa9                	j	ffffffffc0209e7a <sfs_bmap_load_nolock+0xa6>
ffffffffc0209f22:	00c10c93          	addi	s9,sp,12
ffffffffc0209f26:	8762                	mv	a4,s8
ffffffffc0209f28:	86d2                	mv	a3,s4
ffffffffc0209f2a:	4611                	li	a2,4
ffffffffc0209f2c:	85e6                	mv	a1,s9
ffffffffc0209f2e:	7c5000ef          	jal	ra,ffffffffc020aef2 <sfs_rbuf>
ffffffffc0209f32:	892a                	mv	s2,a0
ffffffffc0209f34:	f159                	bnez	a0,ffffffffc0209eba <sfs_bmap_load_nolock+0xe6>
ffffffffc0209f36:	45b2                	lw	a1,12(sp)
ffffffffc0209f38:	e995                	bnez	a1,ffffffffc0209f6c <sfs_bmap_load_nolock+0x198>
ffffffffc0209f3a:	fa8b85e3          	beq	s7,s0,ffffffffc0209ee4 <sfs_bmap_load_nolock+0x110>
ffffffffc0209f3e:	03cb2703          	lw	a4,60(s6)
ffffffffc0209f42:	47a2                	lw	a5,8(sp)
ffffffffc0209f44:	c202                	sw	zero,4(sp)
ffffffffc0209f46:	eee784e3          	beq	a5,a4,ffffffffc0209e2e <sfs_bmap_load_nolock+0x5a>
ffffffffc0209f4a:	e34d                	bnez	a4,ffffffffc0209fec <sfs_bmap_load_nolock+0x218>
ffffffffc0209f4c:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209f50:	4785                	li	a5,1
ffffffffc0209f52:	00fab823          	sd	a5,16(s5)
ffffffffc0209f56:	bde1                	j	ffffffffc0209e2e <sfs_bmap_load_nolock+0x5a>
ffffffffc0209f58:	8526                	mv	a0,s1
ffffffffc0209f5a:	bc1ff0ef          	jal	ra,ffffffffc0209b1a <sfs_block_free>
ffffffffc0209f5e:	45a2                	lw	a1,8(sp)
ffffffffc0209f60:	f4ba0de3          	beq	s4,a1,ffffffffc0209eba <sfs_bmap_load_nolock+0xe6>
ffffffffc0209f64:	8526                	mv	a0,s1
ffffffffc0209f66:	bb5ff0ef          	jal	ra,ffffffffc0209b1a <sfs_block_free>
ffffffffc0209f6a:	bf81                	j	ffffffffc0209eba <sfs_bmap_load_nolock+0xe6>
ffffffffc0209f6c:	03cb2683          	lw	a3,60(s6)
ffffffffc0209f70:	4722                	lw	a4,8(sp)
ffffffffc0209f72:	c22e                	sw	a1,4(sp)
ffffffffc0209f74:	f8e69ee3          	bne	a3,a4,ffffffffc0209f10 <sfs_bmap_load_nolock+0x13c>
ffffffffc0209f78:	b709                	j	ffffffffc0209e7a <sfs_bmap_load_nolock+0xa6>
ffffffffc0209f7a:	00005697          	auipc	a3,0x5
ffffffffc0209f7e:	27668693          	addi	a3,a3,630 # ffffffffc020f1f0 <dev_node_ops+0x6a8>
ffffffffc0209f82:	00002617          	auipc	a2,0x2
ffffffffc0209f86:	bd660613          	addi	a2,a2,-1066 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209f8a:	16400593          	li	a1,356
ffffffffc0209f8e:	00005517          	auipc	a0,0x5
ffffffffc0209f92:	17a50513          	addi	a0,a0,378 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209f96:	d08f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f9a:	872e                	mv	a4,a1
ffffffffc0209f9c:	00005617          	auipc	a2,0x5
ffffffffc0209fa0:	19c60613          	addi	a2,a2,412 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc0209fa4:	05300593          	li	a1,83
ffffffffc0209fa8:	00005517          	auipc	a0,0x5
ffffffffc0209fac:	16050513          	addi	a0,a0,352 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209fb0:	ceef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209fb4:	00005617          	auipc	a2,0x5
ffffffffc0209fb8:	26c60613          	addi	a2,a2,620 # ffffffffc020f220 <dev_node_ops+0x6d8>
ffffffffc0209fbc:	11e00593          	li	a1,286
ffffffffc0209fc0:	00005517          	auipc	a0,0x5
ffffffffc0209fc4:	14850513          	addi	a0,a0,328 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209fc8:	cd6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209fcc:	00005697          	auipc	a3,0x5
ffffffffc0209fd0:	1a468693          	addi	a3,a3,420 # ffffffffc020f170 <dev_node_ops+0x628>
ffffffffc0209fd4:	00002617          	auipc	a2,0x2
ffffffffc0209fd8:	b8460613          	addi	a2,a2,-1148 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209fdc:	16b00593          	li	a1,363
ffffffffc0209fe0:	00005517          	auipc	a0,0x5
ffffffffc0209fe4:	12850513          	addi	a0,a0,296 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc0209fe8:	cb6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209fec:	00005697          	auipc	a3,0x5
ffffffffc0209ff0:	21c68693          	addi	a3,a3,540 # ffffffffc020f208 <dev_node_ops+0x6c0>
ffffffffc0209ff4:	00002617          	auipc	a2,0x2
ffffffffc0209ff8:	b6460613          	addi	a2,a2,-1180 # ffffffffc020bb58 <commands+0x210>
ffffffffc0209ffc:	11800593          	li	a1,280
ffffffffc020a000:	00005517          	auipc	a0,0x5
ffffffffc020a004:	10850513          	addi	a0,a0,264 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a008:	c96f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a00c:	00005697          	auipc	a3,0x5
ffffffffc020a010:	24468693          	addi	a3,a3,580 # ffffffffc020f250 <dev_node_ops+0x708>
ffffffffc020a014:	00002617          	auipc	a2,0x2
ffffffffc020a018:	b4460613          	addi	a2,a2,-1212 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a01c:	12100593          	li	a1,289
ffffffffc020a020:	00005517          	auipc	a0,0x5
ffffffffc020a024:	0e850513          	addi	a0,a0,232 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a028:	c76f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a02c <sfs_io_nolock>:
ffffffffc020a02c:	7175                	addi	sp,sp,-144
ffffffffc020a02e:	f4ce                	sd	s3,104(sp)
ffffffffc020a030:	89ae                	mv	s3,a1
ffffffffc020a032:	618c                	ld	a1,0(a1)
ffffffffc020a034:	e506                	sd	ra,136(sp)
ffffffffc020a036:	e122                	sd	s0,128(sp)
ffffffffc020a038:	0045d883          	lhu	a7,4(a1)
ffffffffc020a03c:	fca6                	sd	s1,120(sp)
ffffffffc020a03e:	f8ca                	sd	s2,112(sp)
ffffffffc020a040:	f0d2                	sd	s4,96(sp)
ffffffffc020a042:	ecd6                	sd	s5,88(sp)
ffffffffc020a044:	e8da                	sd	s6,80(sp)
ffffffffc020a046:	e4de                	sd	s7,72(sp)
ffffffffc020a048:	e0e2                	sd	s8,64(sp)
ffffffffc020a04a:	fc66                	sd	s9,56(sp)
ffffffffc020a04c:	f86a                	sd	s10,48(sp)
ffffffffc020a04e:	f46e                	sd	s11,40(sp)
ffffffffc020a050:	4809                	li	a6,2
ffffffffc020a052:	17088b63          	beq	a7,a6,ffffffffc020a1c8 <sfs_io_nolock+0x19c>
ffffffffc020a056:	6304                	ld	s1,0(a4)
ffffffffc020a058:	8a3a                	mv	s4,a4
ffffffffc020a05a:	000a3023          	sd	zero,0(s4)
ffffffffc020a05e:	08000737          	lui	a4,0x8000
ffffffffc020a062:	8436                	mv	s0,a3
ffffffffc020a064:	94b6                	add	s1,s1,a3
ffffffffc020a066:	14e6ff63          	bgeu	a3,a4,ffffffffc020a1c4 <sfs_io_nolock+0x198>
ffffffffc020a06a:	14d4cd63          	blt	s1,a3,ffffffffc020a1c4 <sfs_io_nolock+0x198>
ffffffffc020a06e:	0c968563          	beq	a3,s1,ffffffffc020a138 <sfs_io_nolock+0x10c>
ffffffffc020a072:	892a                	mv	s2,a0
ffffffffc020a074:	8db2                	mv	s11,a2
ffffffffc020a076:	00977463          	bgeu	a4,s1,ffffffffc020a07e <sfs_io_nolock+0x52>
ffffffffc020a07a:	080004b7          	lui	s1,0x8000
ffffffffc020a07e:	cfe9                	beqz	a5,ffffffffc020a158 <sfs_io_nolock+0x12c>
ffffffffc020a080:	00001797          	auipc	a5,0x1
ffffffffc020a084:	ef278793          	addi	a5,a5,-270 # ffffffffc020af72 <sfs_wbuf>
ffffffffc020a088:	00001b17          	auipc	s6,0x1
ffffffffc020a08c:	e0ab0b13          	addi	s6,s6,-502 # ffffffffc020ae92 <sfs_wblock>
ffffffffc020a090:	e43e                	sd	a5,8(sp)
ffffffffc020a092:	6705                	lui	a4,0x1
ffffffffc020a094:	40c45d13          	srai	s10,s0,0xc
ffffffffc020a098:	40c4db93          	srai	s7,s1,0xc
ffffffffc020a09c:	fff70a93          	addi	s5,a4,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc020a0a0:	41ab8cbb          	subw	s9,s7,s10
ffffffffc020a0a4:	01547ab3          	and	s5,s0,s5
ffffffffc020a0a8:	8be6                	mv	s7,s9
ffffffffc020a0aa:	2d01                	sext.w	s10,s10
ffffffffc020a0ac:	8c56                	mv	s8,s5
ffffffffc020a0ae:	020a8b63          	beqz	s5,ffffffffc020a0e4 <sfs_io_nolock+0xb8>
ffffffffc020a0b2:	40848c33          	sub	s8,s1,s0
ffffffffc020a0b6:	0c0c9163          	bnez	s9,ffffffffc020a178 <sfs_io_nolock+0x14c>
ffffffffc020a0ba:	0874                	addi	a3,sp,28
ffffffffc020a0bc:	866a                	mv	a2,s10
ffffffffc020a0be:	85ce                	mv	a1,s3
ffffffffc020a0c0:	854a                	mv	a0,s2
ffffffffc020a0c2:	d13ff0ef          	jal	ra,ffffffffc0209dd4 <sfs_bmap_load_nolock>
ffffffffc020a0c6:	e935                	bnez	a0,ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a0c8:	46f2                	lw	a3,28(sp)
ffffffffc020a0ca:	67a2                	ld	a5,8(sp)
ffffffffc020a0cc:	8756                	mv	a4,s5
ffffffffc020a0ce:	8662                	mv	a2,s8
ffffffffc020a0d0:	85ee                	mv	a1,s11
ffffffffc020a0d2:	854a                	mv	a0,s2
ffffffffc020a0d4:	9782                	jalr	a5
ffffffffc020a0d6:	e135                	bnez	a0,ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a0d8:	040c8663          	beqz	s9,ffffffffc020a124 <sfs_io_nolock+0xf8>
ffffffffc020a0dc:	9de2                	add	s11,s11,s8
ffffffffc020a0de:	2d05                	addiw	s10,s10,1
ffffffffc020a0e0:	fffb8c9b          	addiw	s9,s7,-1
ffffffffc020a0e4:	020c8c63          	beqz	s9,ffffffffc020a11c <sfs_io_nolock+0xf0>
ffffffffc020a0e8:	6b85                	lui	s7,0x1
ffffffffc020a0ea:	9c5e                	add	s8,s8,s7
ffffffffc020a0ec:	019d0abb          	addw	s5,s10,s9
ffffffffc020a0f0:	41bc0c33          	sub	s8,s8,s11
ffffffffc020a0f4:	0874                	addi	a3,sp,28
ffffffffc020a0f6:	866a                	mv	a2,s10
ffffffffc020a0f8:	85ce                	mv	a1,s3
ffffffffc020a0fa:	854a                	mv	a0,s2
ffffffffc020a0fc:	cd9ff0ef          	jal	ra,ffffffffc0209dd4 <sfs_bmap_load_nolock>
ffffffffc020a100:	ed0d                	bnez	a0,ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a102:	4672                	lw	a2,28(sp)
ffffffffc020a104:	4685                	li	a3,1
ffffffffc020a106:	85ee                	mv	a1,s11
ffffffffc020a108:	854a                	mv	a0,s2
ffffffffc020a10a:	9b02                	jalr	s6
ffffffffc020a10c:	e51d                	bnez	a0,ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a10e:	2d05                	addiw	s10,s10,1
ffffffffc020a110:	018d87b3          	add	a5,s11,s8
ffffffffc020a114:	9dde                	add	s11,s11,s7
ffffffffc020a116:	fd5d1fe3          	bne	s10,s5,ffffffffc020a0f4 <sfs_io_nolock+0xc8>
ffffffffc020a11a:	8c3e                	mv	s8,a5
ffffffffc020a11c:	14d2                	slli	s1,s1,0x34
ffffffffc020a11e:	0344da93          	srli	s5,s1,0x34
ffffffffc020a122:	e0c1                	bnez	s1,ffffffffc020a1a2 <sfs_io_nolock+0x176>
ffffffffc020a124:	0009b703          	ld	a4,0(s3)
ffffffffc020a128:	018407b3          	add	a5,s0,s8
ffffffffc020a12c:	018a3023          	sd	s8,0(s4)
ffffffffc020a130:	00076683          	lwu	a3,0(a4)
ffffffffc020a134:	04f6e563          	bltu	a3,a5,ffffffffc020a17e <sfs_io_nolock+0x152>
ffffffffc020a138:	4501                	li	a0,0
ffffffffc020a13a:	60aa                	ld	ra,136(sp)
ffffffffc020a13c:	640a                	ld	s0,128(sp)
ffffffffc020a13e:	74e6                	ld	s1,120(sp)
ffffffffc020a140:	7946                	ld	s2,112(sp)
ffffffffc020a142:	79a6                	ld	s3,104(sp)
ffffffffc020a144:	7a06                	ld	s4,96(sp)
ffffffffc020a146:	6ae6                	ld	s5,88(sp)
ffffffffc020a148:	6b46                	ld	s6,80(sp)
ffffffffc020a14a:	6ba6                	ld	s7,72(sp)
ffffffffc020a14c:	6c06                	ld	s8,64(sp)
ffffffffc020a14e:	7ce2                	ld	s9,56(sp)
ffffffffc020a150:	7d42                	ld	s10,48(sp)
ffffffffc020a152:	7da2                	ld	s11,40(sp)
ffffffffc020a154:	6149                	addi	sp,sp,144
ffffffffc020a156:	8082                	ret
ffffffffc020a158:	0005e783          	lwu	a5,0(a1)
ffffffffc020a15c:	fcf45ee3          	bge	s0,a5,ffffffffc020a138 <sfs_io_nolock+0x10c>
ffffffffc020a160:	0297c663          	blt	a5,s1,ffffffffc020a18c <sfs_io_nolock+0x160>
ffffffffc020a164:	00001797          	auipc	a5,0x1
ffffffffc020a168:	d8e78793          	addi	a5,a5,-626 # ffffffffc020aef2 <sfs_rbuf>
ffffffffc020a16c:	00001b17          	auipc	s6,0x1
ffffffffc020a170:	cc6b0b13          	addi	s6,s6,-826 # ffffffffc020ae32 <sfs_rblock>
ffffffffc020a174:	e43e                	sd	a5,8(sp)
ffffffffc020a176:	bf31                	j	ffffffffc020a092 <sfs_io_nolock+0x66>
ffffffffc020a178:	41570c33          	sub	s8,a4,s5
ffffffffc020a17c:	bf3d                	j	ffffffffc020a0ba <sfs_io_nolock+0x8e>
ffffffffc020a17e:	0184043b          	addw	s0,s0,s8
ffffffffc020a182:	c300                	sw	s0,0(a4)
ffffffffc020a184:	4785                	li	a5,1
ffffffffc020a186:	00f9b823          	sd	a5,16(s3)
ffffffffc020a18a:	b77d                	j	ffffffffc020a138 <sfs_io_nolock+0x10c>
ffffffffc020a18c:	84be                	mv	s1,a5
ffffffffc020a18e:	00001797          	auipc	a5,0x1
ffffffffc020a192:	d6478793          	addi	a5,a5,-668 # ffffffffc020aef2 <sfs_rbuf>
ffffffffc020a196:	00001b17          	auipc	s6,0x1
ffffffffc020a19a:	c9cb0b13          	addi	s6,s6,-868 # ffffffffc020ae32 <sfs_rblock>
ffffffffc020a19e:	e43e                	sd	a5,8(sp)
ffffffffc020a1a0:	bdcd                	j	ffffffffc020a092 <sfs_io_nolock+0x66>
ffffffffc020a1a2:	0874                	addi	a3,sp,28
ffffffffc020a1a4:	866a                	mv	a2,s10
ffffffffc020a1a6:	85ce                	mv	a1,s3
ffffffffc020a1a8:	854a                	mv	a0,s2
ffffffffc020a1aa:	c2bff0ef          	jal	ra,ffffffffc0209dd4 <sfs_bmap_load_nolock>
ffffffffc020a1ae:	f551                	bnez	a0,ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a1b0:	46f2                	lw	a3,28(sp)
ffffffffc020a1b2:	67a2                	ld	a5,8(sp)
ffffffffc020a1b4:	4701                	li	a4,0
ffffffffc020a1b6:	8656                	mv	a2,s5
ffffffffc020a1b8:	85ee                	mv	a1,s11
ffffffffc020a1ba:	854a                	mv	a0,s2
ffffffffc020a1bc:	9782                	jalr	a5
ffffffffc020a1be:	fd35                	bnez	a0,ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a1c0:	9c56                	add	s8,s8,s5
ffffffffc020a1c2:	b78d                	j	ffffffffc020a124 <sfs_io_nolock+0xf8>
ffffffffc020a1c4:	5575                	li	a0,-3
ffffffffc020a1c6:	bf95                	j	ffffffffc020a13a <sfs_io_nolock+0x10e>
ffffffffc020a1c8:	00005697          	auipc	a3,0x5
ffffffffc020a1cc:	0b068693          	addi	a3,a3,176 # ffffffffc020f278 <dev_node_ops+0x730>
ffffffffc020a1d0:	00002617          	auipc	a2,0x2
ffffffffc020a1d4:	98860613          	addi	a2,a2,-1656 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a1d8:	22b00593          	li	a1,555
ffffffffc020a1dc:	00005517          	auipc	a0,0x5
ffffffffc020a1e0:	f2c50513          	addi	a0,a0,-212 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a1e4:	abaf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a1e8 <sfs_read>:
ffffffffc020a1e8:	7139                	addi	sp,sp,-64
ffffffffc020a1ea:	f04a                	sd	s2,32(sp)
ffffffffc020a1ec:	06853903          	ld	s2,104(a0)
ffffffffc020a1f0:	fc06                	sd	ra,56(sp)
ffffffffc020a1f2:	f822                	sd	s0,48(sp)
ffffffffc020a1f4:	f426                	sd	s1,40(sp)
ffffffffc020a1f6:	ec4e                	sd	s3,24(sp)
ffffffffc020a1f8:	04090f63          	beqz	s2,ffffffffc020a256 <sfs_read+0x6e>
ffffffffc020a1fc:	0b092783          	lw	a5,176(s2)
ffffffffc020a200:	ebb9                	bnez	a5,ffffffffc020a256 <sfs_read+0x6e>
ffffffffc020a202:	4d38                	lw	a4,88(a0)
ffffffffc020a204:	6785                	lui	a5,0x1
ffffffffc020a206:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a20a:	842a                	mv	s0,a0
ffffffffc020a20c:	06f71563          	bne	a4,a5,ffffffffc020a276 <sfs_read+0x8e>
ffffffffc020a210:	02050993          	addi	s3,a0,32
ffffffffc020a214:	854e                	mv	a0,s3
ffffffffc020a216:	84ae                	mv	s1,a1
ffffffffc020a218:	aaafa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a21c:	0184b803          	ld	a6,24(s1) # 8000018 <_binary_bin_sfs_img_size+0x7f8ad18>
ffffffffc020a220:	6494                	ld	a3,8(s1)
ffffffffc020a222:	6090                	ld	a2,0(s1)
ffffffffc020a224:	85a2                	mv	a1,s0
ffffffffc020a226:	4781                	li	a5,0
ffffffffc020a228:	0038                	addi	a4,sp,8
ffffffffc020a22a:	854a                	mv	a0,s2
ffffffffc020a22c:	e442                	sd	a6,8(sp)
ffffffffc020a22e:	dffff0ef          	jal	ra,ffffffffc020a02c <sfs_io_nolock>
ffffffffc020a232:	65a2                	ld	a1,8(sp)
ffffffffc020a234:	842a                	mv	s0,a0
ffffffffc020a236:	ed81                	bnez	a1,ffffffffc020a24e <sfs_read+0x66>
ffffffffc020a238:	854e                	mv	a0,s3
ffffffffc020a23a:	a84fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a23e:	70e2                	ld	ra,56(sp)
ffffffffc020a240:	8522                	mv	a0,s0
ffffffffc020a242:	7442                	ld	s0,48(sp)
ffffffffc020a244:	74a2                	ld	s1,40(sp)
ffffffffc020a246:	7902                	ld	s2,32(sp)
ffffffffc020a248:	69e2                	ld	s3,24(sp)
ffffffffc020a24a:	6121                	addi	sp,sp,64
ffffffffc020a24c:	8082                	ret
ffffffffc020a24e:	8526                	mv	a0,s1
ffffffffc020a250:	966fb0ef          	jal	ra,ffffffffc02053b6 <iobuf_skip>
ffffffffc020a254:	b7d5                	j	ffffffffc020a238 <sfs_read+0x50>
ffffffffc020a256:	00005697          	auipc	a3,0x5
ffffffffc020a25a:	cd268693          	addi	a3,a3,-814 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020a25e:	00002617          	auipc	a2,0x2
ffffffffc020a262:	8fa60613          	addi	a2,a2,-1798 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a266:	29300593          	li	a1,659
ffffffffc020a26a:	00005517          	auipc	a0,0x5
ffffffffc020a26e:	e9e50513          	addi	a0,a0,-354 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a272:	a2cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a276:	881ff0ef          	jal	ra,ffffffffc0209af6 <sfs_io.part.0>

ffffffffc020a27a <sfs_write>:
ffffffffc020a27a:	7139                	addi	sp,sp,-64
ffffffffc020a27c:	f04a                	sd	s2,32(sp)
ffffffffc020a27e:	06853903          	ld	s2,104(a0)
ffffffffc020a282:	fc06                	sd	ra,56(sp)
ffffffffc020a284:	f822                	sd	s0,48(sp)
ffffffffc020a286:	f426                	sd	s1,40(sp)
ffffffffc020a288:	ec4e                	sd	s3,24(sp)
ffffffffc020a28a:	04090f63          	beqz	s2,ffffffffc020a2e8 <sfs_write+0x6e>
ffffffffc020a28e:	0b092783          	lw	a5,176(s2)
ffffffffc020a292:	ebb9                	bnez	a5,ffffffffc020a2e8 <sfs_write+0x6e>
ffffffffc020a294:	4d38                	lw	a4,88(a0)
ffffffffc020a296:	6785                	lui	a5,0x1
ffffffffc020a298:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a29c:	842a                	mv	s0,a0
ffffffffc020a29e:	06f71563          	bne	a4,a5,ffffffffc020a308 <sfs_write+0x8e>
ffffffffc020a2a2:	02050993          	addi	s3,a0,32
ffffffffc020a2a6:	854e                	mv	a0,s3
ffffffffc020a2a8:	84ae                	mv	s1,a1
ffffffffc020a2aa:	a18fa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a2ae:	0184b803          	ld	a6,24(s1)
ffffffffc020a2b2:	6494                	ld	a3,8(s1)
ffffffffc020a2b4:	6090                	ld	a2,0(s1)
ffffffffc020a2b6:	85a2                	mv	a1,s0
ffffffffc020a2b8:	4785                	li	a5,1
ffffffffc020a2ba:	0038                	addi	a4,sp,8
ffffffffc020a2bc:	854a                	mv	a0,s2
ffffffffc020a2be:	e442                	sd	a6,8(sp)
ffffffffc020a2c0:	d6dff0ef          	jal	ra,ffffffffc020a02c <sfs_io_nolock>
ffffffffc020a2c4:	65a2                	ld	a1,8(sp)
ffffffffc020a2c6:	842a                	mv	s0,a0
ffffffffc020a2c8:	ed81                	bnez	a1,ffffffffc020a2e0 <sfs_write+0x66>
ffffffffc020a2ca:	854e                	mv	a0,s3
ffffffffc020a2cc:	9f2fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a2d0:	70e2                	ld	ra,56(sp)
ffffffffc020a2d2:	8522                	mv	a0,s0
ffffffffc020a2d4:	7442                	ld	s0,48(sp)
ffffffffc020a2d6:	74a2                	ld	s1,40(sp)
ffffffffc020a2d8:	7902                	ld	s2,32(sp)
ffffffffc020a2da:	69e2                	ld	s3,24(sp)
ffffffffc020a2dc:	6121                	addi	sp,sp,64
ffffffffc020a2de:	8082                	ret
ffffffffc020a2e0:	8526                	mv	a0,s1
ffffffffc020a2e2:	8d4fb0ef          	jal	ra,ffffffffc02053b6 <iobuf_skip>
ffffffffc020a2e6:	b7d5                	j	ffffffffc020a2ca <sfs_write+0x50>
ffffffffc020a2e8:	00005697          	auipc	a3,0x5
ffffffffc020a2ec:	c4068693          	addi	a3,a3,-960 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020a2f0:	00002617          	auipc	a2,0x2
ffffffffc020a2f4:	86860613          	addi	a2,a2,-1944 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a2f8:	29300593          	li	a1,659
ffffffffc020a2fc:	00005517          	auipc	a0,0x5
ffffffffc020a300:	e0c50513          	addi	a0,a0,-500 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a304:	99af60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a308:	feeff0ef          	jal	ra,ffffffffc0209af6 <sfs_io.part.0>

ffffffffc020a30c <sfs_dirent_read_nolock>:
ffffffffc020a30c:	6198                	ld	a4,0(a1)
ffffffffc020a30e:	7179                	addi	sp,sp,-48
ffffffffc020a310:	f406                	sd	ra,40(sp)
ffffffffc020a312:	00475883          	lhu	a7,4(a4)
ffffffffc020a316:	f022                	sd	s0,32(sp)
ffffffffc020a318:	ec26                	sd	s1,24(sp)
ffffffffc020a31a:	4809                	li	a6,2
ffffffffc020a31c:	05089b63          	bne	a7,a6,ffffffffc020a372 <sfs_dirent_read_nolock+0x66>
ffffffffc020a320:	4718                	lw	a4,8(a4)
ffffffffc020a322:	87b2                	mv	a5,a2
ffffffffc020a324:	2601                	sext.w	a2,a2
ffffffffc020a326:	04e7f663          	bgeu	a5,a4,ffffffffc020a372 <sfs_dirent_read_nolock+0x66>
ffffffffc020a32a:	84b6                	mv	s1,a3
ffffffffc020a32c:	0074                	addi	a3,sp,12
ffffffffc020a32e:	842a                	mv	s0,a0
ffffffffc020a330:	aa5ff0ef          	jal	ra,ffffffffc0209dd4 <sfs_bmap_load_nolock>
ffffffffc020a334:	c511                	beqz	a0,ffffffffc020a340 <sfs_dirent_read_nolock+0x34>
ffffffffc020a336:	70a2                	ld	ra,40(sp)
ffffffffc020a338:	7402                	ld	s0,32(sp)
ffffffffc020a33a:	64e2                	ld	s1,24(sp)
ffffffffc020a33c:	6145                	addi	sp,sp,48
ffffffffc020a33e:	8082                	ret
ffffffffc020a340:	45b2                	lw	a1,12(sp)
ffffffffc020a342:	4054                	lw	a3,4(s0)
ffffffffc020a344:	c5b9                	beqz	a1,ffffffffc020a392 <sfs_dirent_read_nolock+0x86>
ffffffffc020a346:	04d5f663          	bgeu	a1,a3,ffffffffc020a392 <sfs_dirent_read_nolock+0x86>
ffffffffc020a34a:	7c08                	ld	a0,56(s0)
ffffffffc020a34c:	ec1fe0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc020a350:	ed31                	bnez	a0,ffffffffc020a3ac <sfs_dirent_read_nolock+0xa0>
ffffffffc020a352:	46b2                	lw	a3,12(sp)
ffffffffc020a354:	4701                	li	a4,0
ffffffffc020a356:	10400613          	li	a2,260
ffffffffc020a35a:	85a6                	mv	a1,s1
ffffffffc020a35c:	8522                	mv	a0,s0
ffffffffc020a35e:	395000ef          	jal	ra,ffffffffc020aef2 <sfs_rbuf>
ffffffffc020a362:	f971                	bnez	a0,ffffffffc020a336 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a364:	100481a3          	sb	zero,259(s1)
ffffffffc020a368:	70a2                	ld	ra,40(sp)
ffffffffc020a36a:	7402                	ld	s0,32(sp)
ffffffffc020a36c:	64e2                	ld	s1,24(sp)
ffffffffc020a36e:	6145                	addi	sp,sp,48
ffffffffc020a370:	8082                	ret
ffffffffc020a372:	00005697          	auipc	a3,0x5
ffffffffc020a376:	f2668693          	addi	a3,a3,-218 # ffffffffc020f298 <dev_node_ops+0x750>
ffffffffc020a37a:	00001617          	auipc	a2,0x1
ffffffffc020a37e:	7de60613          	addi	a2,a2,2014 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a382:	18e00593          	li	a1,398
ffffffffc020a386:	00005517          	auipc	a0,0x5
ffffffffc020a38a:	d8250513          	addi	a0,a0,-638 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a38e:	910f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a392:	872e                	mv	a4,a1
ffffffffc020a394:	00005617          	auipc	a2,0x5
ffffffffc020a398:	da460613          	addi	a2,a2,-604 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc020a39c:	05300593          	li	a1,83
ffffffffc020a3a0:	00005517          	auipc	a0,0x5
ffffffffc020a3a4:	d6850513          	addi	a0,a0,-664 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a3a8:	8f6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3ac:	00005697          	auipc	a3,0x5
ffffffffc020a3b0:	dc468693          	addi	a3,a3,-572 # ffffffffc020f170 <dev_node_ops+0x628>
ffffffffc020a3b4:	00001617          	auipc	a2,0x1
ffffffffc020a3b8:	7a460613          	addi	a2,a2,1956 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a3bc:	19500593          	li	a1,405
ffffffffc020a3c0:	00005517          	auipc	a0,0x5
ffffffffc020a3c4:	d4850513          	addi	a0,a0,-696 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a3c8:	8d6f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a3cc <sfs_getdirentry>:
ffffffffc020a3cc:	715d                	addi	sp,sp,-80
ffffffffc020a3ce:	ec56                	sd	s5,24(sp)
ffffffffc020a3d0:	8aaa                	mv	s5,a0
ffffffffc020a3d2:	10400513          	li	a0,260
ffffffffc020a3d6:	e85a                	sd	s6,16(sp)
ffffffffc020a3d8:	e486                	sd	ra,72(sp)
ffffffffc020a3da:	e0a2                	sd	s0,64(sp)
ffffffffc020a3dc:	fc26                	sd	s1,56(sp)
ffffffffc020a3de:	f84a                	sd	s2,48(sp)
ffffffffc020a3e0:	f44e                	sd	s3,40(sp)
ffffffffc020a3e2:	f052                	sd	s4,32(sp)
ffffffffc020a3e4:	e45e                	sd	s7,8(sp)
ffffffffc020a3e6:	e062                	sd	s8,0(sp)
ffffffffc020a3e8:	8b2e                	mv	s6,a1
ffffffffc020a3ea:	ba5f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a3ee:	cd61                	beqz	a0,ffffffffc020a4c6 <sfs_getdirentry+0xfa>
ffffffffc020a3f0:	068abb83          	ld	s7,104(s5)
ffffffffc020a3f4:	0c0b8b63          	beqz	s7,ffffffffc020a4ca <sfs_getdirentry+0xfe>
ffffffffc020a3f8:	0b0ba783          	lw	a5,176(s7) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a3fc:	e7f9                	bnez	a5,ffffffffc020a4ca <sfs_getdirentry+0xfe>
ffffffffc020a3fe:	058aa703          	lw	a4,88(s5)
ffffffffc020a402:	6785                	lui	a5,0x1
ffffffffc020a404:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a408:	0ef71163          	bne	a4,a5,ffffffffc020a4ea <sfs_getdirentry+0x11e>
ffffffffc020a40c:	008b3983          	ld	s3,8(s6)
ffffffffc020a410:	892a                	mv	s2,a0
ffffffffc020a412:	0a09c163          	bltz	s3,ffffffffc020a4b4 <sfs_getdirentry+0xe8>
ffffffffc020a416:	0ff9f793          	zext.b	a5,s3
ffffffffc020a41a:	efc9                	bnez	a5,ffffffffc020a4b4 <sfs_getdirentry+0xe8>
ffffffffc020a41c:	000ab783          	ld	a5,0(s5)
ffffffffc020a420:	0089d993          	srli	s3,s3,0x8
ffffffffc020a424:	2981                	sext.w	s3,s3
ffffffffc020a426:	479c                	lw	a5,8(a5)
ffffffffc020a428:	0937eb63          	bltu	a5,s3,ffffffffc020a4be <sfs_getdirentry+0xf2>
ffffffffc020a42c:	020a8c13          	addi	s8,s5,32
ffffffffc020a430:	8562                	mv	a0,s8
ffffffffc020a432:	890fa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a436:	000ab783          	ld	a5,0(s5)
ffffffffc020a43a:	0087aa03          	lw	s4,8(a5)
ffffffffc020a43e:	07405663          	blez	s4,ffffffffc020a4aa <sfs_getdirentry+0xde>
ffffffffc020a442:	4481                	li	s1,0
ffffffffc020a444:	a811                	j	ffffffffc020a458 <sfs_getdirentry+0x8c>
ffffffffc020a446:	00092783          	lw	a5,0(s2)
ffffffffc020a44a:	c781                	beqz	a5,ffffffffc020a452 <sfs_getdirentry+0x86>
ffffffffc020a44c:	02098263          	beqz	s3,ffffffffc020a470 <sfs_getdirentry+0xa4>
ffffffffc020a450:	39fd                	addiw	s3,s3,-1
ffffffffc020a452:	2485                	addiw	s1,s1,1
ffffffffc020a454:	049a0b63          	beq	s4,s1,ffffffffc020a4aa <sfs_getdirentry+0xde>
ffffffffc020a458:	86ca                	mv	a3,s2
ffffffffc020a45a:	8626                	mv	a2,s1
ffffffffc020a45c:	85d6                	mv	a1,s5
ffffffffc020a45e:	855e                	mv	a0,s7
ffffffffc020a460:	eadff0ef          	jal	ra,ffffffffc020a30c <sfs_dirent_read_nolock>
ffffffffc020a464:	842a                	mv	s0,a0
ffffffffc020a466:	d165                	beqz	a0,ffffffffc020a446 <sfs_getdirentry+0x7a>
ffffffffc020a468:	8562                	mv	a0,s8
ffffffffc020a46a:	854fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a46e:	a831                	j	ffffffffc020a48a <sfs_getdirentry+0xbe>
ffffffffc020a470:	8562                	mv	a0,s8
ffffffffc020a472:	84cfa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a476:	4701                	li	a4,0
ffffffffc020a478:	4685                	li	a3,1
ffffffffc020a47a:	10000613          	li	a2,256
ffffffffc020a47e:	00490593          	addi	a1,s2,4
ffffffffc020a482:	855a                	mv	a0,s6
ffffffffc020a484:	ec7fa0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc020a488:	842a                	mv	s0,a0
ffffffffc020a48a:	854a                	mv	a0,s2
ffffffffc020a48c:	bb3f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a490:	60a6                	ld	ra,72(sp)
ffffffffc020a492:	8522                	mv	a0,s0
ffffffffc020a494:	6406                	ld	s0,64(sp)
ffffffffc020a496:	74e2                	ld	s1,56(sp)
ffffffffc020a498:	7942                	ld	s2,48(sp)
ffffffffc020a49a:	79a2                	ld	s3,40(sp)
ffffffffc020a49c:	7a02                	ld	s4,32(sp)
ffffffffc020a49e:	6ae2                	ld	s5,24(sp)
ffffffffc020a4a0:	6b42                	ld	s6,16(sp)
ffffffffc020a4a2:	6ba2                	ld	s7,8(sp)
ffffffffc020a4a4:	6c02                	ld	s8,0(sp)
ffffffffc020a4a6:	6161                	addi	sp,sp,80
ffffffffc020a4a8:	8082                	ret
ffffffffc020a4aa:	8562                	mv	a0,s8
ffffffffc020a4ac:	5441                	li	s0,-16
ffffffffc020a4ae:	810fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a4b2:	bfe1                	j	ffffffffc020a48a <sfs_getdirentry+0xbe>
ffffffffc020a4b4:	854a                	mv	a0,s2
ffffffffc020a4b6:	b89f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a4ba:	5475                	li	s0,-3
ffffffffc020a4bc:	bfd1                	j	ffffffffc020a490 <sfs_getdirentry+0xc4>
ffffffffc020a4be:	b81f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a4c2:	5441                	li	s0,-16
ffffffffc020a4c4:	b7f1                	j	ffffffffc020a490 <sfs_getdirentry+0xc4>
ffffffffc020a4c6:	5471                	li	s0,-4
ffffffffc020a4c8:	b7e1                	j	ffffffffc020a490 <sfs_getdirentry+0xc4>
ffffffffc020a4ca:	00005697          	auipc	a3,0x5
ffffffffc020a4ce:	a5e68693          	addi	a3,a3,-1442 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020a4d2:	00001617          	auipc	a2,0x1
ffffffffc020a4d6:	68660613          	addi	a2,a2,1670 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a4da:	33700593          	li	a1,823
ffffffffc020a4de:	00005517          	auipc	a0,0x5
ffffffffc020a4e2:	c2a50513          	addi	a0,a0,-982 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a4e6:	fb9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4ea:	00005697          	auipc	a3,0x5
ffffffffc020a4ee:	be668693          	addi	a3,a3,-1050 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020a4f2:	00001617          	auipc	a2,0x1
ffffffffc020a4f6:	66660613          	addi	a2,a2,1638 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a4fa:	33800593          	li	a1,824
ffffffffc020a4fe:	00005517          	auipc	a0,0x5
ffffffffc020a502:	c0a50513          	addi	a0,a0,-1014 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a506:	f99f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a50a <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a50a:	715d                	addi	sp,sp,-80
ffffffffc020a50c:	f052                	sd	s4,32(sp)
ffffffffc020a50e:	8a2a                	mv	s4,a0
ffffffffc020a510:	8532                	mv	a0,a2
ffffffffc020a512:	f44e                	sd	s3,40(sp)
ffffffffc020a514:	e85a                	sd	s6,16(sp)
ffffffffc020a516:	e45e                	sd	s7,8(sp)
ffffffffc020a518:	e486                	sd	ra,72(sp)
ffffffffc020a51a:	e0a2                	sd	s0,64(sp)
ffffffffc020a51c:	fc26                	sd	s1,56(sp)
ffffffffc020a51e:	f84a                	sd	s2,48(sp)
ffffffffc020a520:	ec56                	sd	s5,24(sp)
ffffffffc020a522:	e062                	sd	s8,0(sp)
ffffffffc020a524:	8b32                	mv	s6,a2
ffffffffc020a526:	89ae                	mv	s3,a1
ffffffffc020a528:	8bb6                	mv	s7,a3
ffffffffc020a52a:	0aa010ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc020a52e:	0ff00793          	li	a5,255
ffffffffc020a532:	06a7ef63          	bltu	a5,a0,ffffffffc020a5b0 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a536:	10400513          	li	a0,260
ffffffffc020a53a:	a55f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a53e:	892a                	mv	s2,a0
ffffffffc020a540:	c535                	beqz	a0,ffffffffc020a5ac <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a542:	0009b783          	ld	a5,0(s3)
ffffffffc020a546:	0087aa83          	lw	s5,8(a5)
ffffffffc020a54a:	05505a63          	blez	s5,ffffffffc020a59e <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a54e:	4481                	li	s1,0
ffffffffc020a550:	00450c13          	addi	s8,a0,4
ffffffffc020a554:	a829                	j	ffffffffc020a56e <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a556:	00092783          	lw	a5,0(s2)
ffffffffc020a55a:	c799                	beqz	a5,ffffffffc020a568 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a55c:	85e2                	mv	a1,s8
ffffffffc020a55e:	855a                	mv	a0,s6
ffffffffc020a560:	0bc010ef          	jal	ra,ffffffffc020b61c <strcmp>
ffffffffc020a564:	842a                	mv	s0,a0
ffffffffc020a566:	cd15                	beqz	a0,ffffffffc020a5a2 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a568:	2485                	addiw	s1,s1,1
ffffffffc020a56a:	029a8a63          	beq	s5,s1,ffffffffc020a59e <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a56e:	86ca                	mv	a3,s2
ffffffffc020a570:	8626                	mv	a2,s1
ffffffffc020a572:	85ce                	mv	a1,s3
ffffffffc020a574:	8552                	mv	a0,s4
ffffffffc020a576:	d97ff0ef          	jal	ra,ffffffffc020a30c <sfs_dirent_read_nolock>
ffffffffc020a57a:	842a                	mv	s0,a0
ffffffffc020a57c:	dd69                	beqz	a0,ffffffffc020a556 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a57e:	854a                	mv	a0,s2
ffffffffc020a580:	abff70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a584:	60a6                	ld	ra,72(sp)
ffffffffc020a586:	8522                	mv	a0,s0
ffffffffc020a588:	6406                	ld	s0,64(sp)
ffffffffc020a58a:	74e2                	ld	s1,56(sp)
ffffffffc020a58c:	7942                	ld	s2,48(sp)
ffffffffc020a58e:	79a2                	ld	s3,40(sp)
ffffffffc020a590:	7a02                	ld	s4,32(sp)
ffffffffc020a592:	6ae2                	ld	s5,24(sp)
ffffffffc020a594:	6b42                	ld	s6,16(sp)
ffffffffc020a596:	6ba2                	ld	s7,8(sp)
ffffffffc020a598:	6c02                	ld	s8,0(sp)
ffffffffc020a59a:	6161                	addi	sp,sp,80
ffffffffc020a59c:	8082                	ret
ffffffffc020a59e:	5441                	li	s0,-16
ffffffffc020a5a0:	bff9                	j	ffffffffc020a57e <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a5a2:	00092783          	lw	a5,0(s2)
ffffffffc020a5a6:	00fba023          	sw	a5,0(s7)
ffffffffc020a5aa:	bfd1                	j	ffffffffc020a57e <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a5ac:	5471                	li	s0,-4
ffffffffc020a5ae:	bfd9                	j	ffffffffc020a584 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a5b0:	00005697          	auipc	a3,0x5
ffffffffc020a5b4:	d3868693          	addi	a3,a3,-712 # ffffffffc020f2e8 <dev_node_ops+0x7a0>
ffffffffc020a5b8:	00001617          	auipc	a2,0x1
ffffffffc020a5bc:	5a060613          	addi	a2,a2,1440 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a5c0:	1ba00593          	li	a1,442
ffffffffc020a5c4:	00005517          	auipc	a0,0x5
ffffffffc020a5c8:	b4450513          	addi	a0,a0,-1212 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a5cc:	ed3f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a5d0 <sfs_truncfile>:
ffffffffc020a5d0:	7175                	addi	sp,sp,-144
ffffffffc020a5d2:	e506                	sd	ra,136(sp)
ffffffffc020a5d4:	e122                	sd	s0,128(sp)
ffffffffc020a5d6:	fca6                	sd	s1,120(sp)
ffffffffc020a5d8:	f8ca                	sd	s2,112(sp)
ffffffffc020a5da:	f4ce                	sd	s3,104(sp)
ffffffffc020a5dc:	f0d2                	sd	s4,96(sp)
ffffffffc020a5de:	ecd6                	sd	s5,88(sp)
ffffffffc020a5e0:	e8da                	sd	s6,80(sp)
ffffffffc020a5e2:	e4de                	sd	s7,72(sp)
ffffffffc020a5e4:	e0e2                	sd	s8,64(sp)
ffffffffc020a5e6:	fc66                	sd	s9,56(sp)
ffffffffc020a5e8:	f86a                	sd	s10,48(sp)
ffffffffc020a5ea:	f46e                	sd	s11,40(sp)
ffffffffc020a5ec:	080007b7          	lui	a5,0x8000
ffffffffc020a5f0:	16b7e463          	bltu	a5,a1,ffffffffc020a758 <sfs_truncfile+0x188>
ffffffffc020a5f4:	06853c83          	ld	s9,104(a0)
ffffffffc020a5f8:	89aa                	mv	s3,a0
ffffffffc020a5fa:	160c8163          	beqz	s9,ffffffffc020a75c <sfs_truncfile+0x18c>
ffffffffc020a5fe:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a602:	14079d63          	bnez	a5,ffffffffc020a75c <sfs_truncfile+0x18c>
ffffffffc020a606:	4d38                	lw	a4,88(a0)
ffffffffc020a608:	6405                	lui	s0,0x1
ffffffffc020a60a:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a60e:	16f71763          	bne	a4,a5,ffffffffc020a77c <sfs_truncfile+0x1ac>
ffffffffc020a612:	00053a83          	ld	s5,0(a0)
ffffffffc020a616:	147d                	addi	s0,s0,-1
ffffffffc020a618:	942e                	add	s0,s0,a1
ffffffffc020a61a:	000ae783          	lwu	a5,0(s5)
ffffffffc020a61e:	8031                	srli	s0,s0,0xc
ffffffffc020a620:	8a2e                	mv	s4,a1
ffffffffc020a622:	2401                	sext.w	s0,s0
ffffffffc020a624:	02b79763          	bne	a5,a1,ffffffffc020a652 <sfs_truncfile+0x82>
ffffffffc020a628:	008aa783          	lw	a5,8(s5)
ffffffffc020a62c:	4901                	li	s2,0
ffffffffc020a62e:	18879763          	bne	a5,s0,ffffffffc020a7bc <sfs_truncfile+0x1ec>
ffffffffc020a632:	60aa                	ld	ra,136(sp)
ffffffffc020a634:	640a                	ld	s0,128(sp)
ffffffffc020a636:	74e6                	ld	s1,120(sp)
ffffffffc020a638:	79a6                	ld	s3,104(sp)
ffffffffc020a63a:	7a06                	ld	s4,96(sp)
ffffffffc020a63c:	6ae6                	ld	s5,88(sp)
ffffffffc020a63e:	6b46                	ld	s6,80(sp)
ffffffffc020a640:	6ba6                	ld	s7,72(sp)
ffffffffc020a642:	6c06                	ld	s8,64(sp)
ffffffffc020a644:	7ce2                	ld	s9,56(sp)
ffffffffc020a646:	7d42                	ld	s10,48(sp)
ffffffffc020a648:	7da2                	ld	s11,40(sp)
ffffffffc020a64a:	854a                	mv	a0,s2
ffffffffc020a64c:	7946                	ld	s2,112(sp)
ffffffffc020a64e:	6149                	addi	sp,sp,144
ffffffffc020a650:	8082                	ret
ffffffffc020a652:	02050b13          	addi	s6,a0,32
ffffffffc020a656:	855a                	mv	a0,s6
ffffffffc020a658:	e6bf90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a65c:	008aa483          	lw	s1,8(s5)
ffffffffc020a660:	0a84e663          	bltu	s1,s0,ffffffffc020a70c <sfs_truncfile+0x13c>
ffffffffc020a664:	0c947163          	bgeu	s0,s1,ffffffffc020a726 <sfs_truncfile+0x156>
ffffffffc020a668:	4dad                	li	s11,11
ffffffffc020a66a:	4b85                	li	s7,1
ffffffffc020a66c:	a09d                	j	ffffffffc020a6d2 <sfs_truncfile+0x102>
ffffffffc020a66e:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a672:	0009079b          	sext.w	a5,s2
ffffffffc020a676:	3ff00713          	li	a4,1023
ffffffffc020a67a:	04f76563          	bltu	a4,a5,ffffffffc020a6c4 <sfs_truncfile+0xf4>
ffffffffc020a67e:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a682:	040c0163          	beqz	s8,ffffffffc020a6c4 <sfs_truncfile+0xf4>
ffffffffc020a686:	004ca783          	lw	a5,4(s9)
ffffffffc020a68a:	18fc7963          	bgeu	s8,a5,ffffffffc020a81c <sfs_truncfile+0x24c>
ffffffffc020a68e:	038cb503          	ld	a0,56(s9)
ffffffffc020a692:	85e2                	mv	a1,s8
ffffffffc020a694:	b79fe0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc020a698:	16051263          	bnez	a0,ffffffffc020a7fc <sfs_truncfile+0x22c>
ffffffffc020a69c:	02091793          	slli	a5,s2,0x20
ffffffffc020a6a0:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a6a4:	86e2                	mv	a3,s8
ffffffffc020a6a6:	4611                	li	a2,4
ffffffffc020a6a8:	082c                	addi	a1,sp,24
ffffffffc020a6aa:	8566                	mv	a0,s9
ffffffffc020a6ac:	e43a                	sd	a4,8(sp)
ffffffffc020a6ae:	ce02                	sw	zero,28(sp)
ffffffffc020a6b0:	043000ef          	jal	ra,ffffffffc020aef2 <sfs_rbuf>
ffffffffc020a6b4:	892a                	mv	s2,a0
ffffffffc020a6b6:	e141                	bnez	a0,ffffffffc020a736 <sfs_truncfile+0x166>
ffffffffc020a6b8:	47e2                	lw	a5,24(sp)
ffffffffc020a6ba:	6722                	ld	a4,8(sp)
ffffffffc020a6bc:	e3c9                	bnez	a5,ffffffffc020a73e <sfs_truncfile+0x16e>
ffffffffc020a6be:	008d2603          	lw	a2,8(s10)
ffffffffc020a6c2:	367d                	addiw	a2,a2,-1
ffffffffc020a6c4:	00cd2423          	sw	a2,8(s10)
ffffffffc020a6c8:	0179b823          	sd	s7,16(s3)
ffffffffc020a6cc:	34fd                	addiw	s1,s1,-1
ffffffffc020a6ce:	04940a63          	beq	s0,s1,ffffffffc020a722 <sfs_truncfile+0x152>
ffffffffc020a6d2:	0009bd03          	ld	s10,0(s3)
ffffffffc020a6d6:	008d2703          	lw	a4,8(s10)
ffffffffc020a6da:	c369                	beqz	a4,ffffffffc020a79c <sfs_truncfile+0x1cc>
ffffffffc020a6dc:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a6e0:	0007861b          	sext.w	a2,a5
ffffffffc020a6e4:	f8cde5e3          	bltu	s11,a2,ffffffffc020a66e <sfs_truncfile+0x9e>
ffffffffc020a6e8:	02079713          	slli	a4,a5,0x20
ffffffffc020a6ec:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a6f0:	00fd0933          	add	s2,s10,a5
ffffffffc020a6f4:	00c92583          	lw	a1,12(s2)
ffffffffc020a6f8:	d5f1                	beqz	a1,ffffffffc020a6c4 <sfs_truncfile+0xf4>
ffffffffc020a6fa:	8566                	mv	a0,s9
ffffffffc020a6fc:	c1eff0ef          	jal	ra,ffffffffc0209b1a <sfs_block_free>
ffffffffc020a700:	00092623          	sw	zero,12(s2)
ffffffffc020a704:	008d2603          	lw	a2,8(s10)
ffffffffc020a708:	367d                	addiw	a2,a2,-1
ffffffffc020a70a:	bf6d                	j	ffffffffc020a6c4 <sfs_truncfile+0xf4>
ffffffffc020a70c:	4681                	li	a3,0
ffffffffc020a70e:	8626                	mv	a2,s1
ffffffffc020a710:	85ce                	mv	a1,s3
ffffffffc020a712:	8566                	mv	a0,s9
ffffffffc020a714:	ec0ff0ef          	jal	ra,ffffffffc0209dd4 <sfs_bmap_load_nolock>
ffffffffc020a718:	892a                	mv	s2,a0
ffffffffc020a71a:	ed11                	bnez	a0,ffffffffc020a736 <sfs_truncfile+0x166>
ffffffffc020a71c:	2485                	addiw	s1,s1,1
ffffffffc020a71e:	fe9417e3          	bne	s0,s1,ffffffffc020a70c <sfs_truncfile+0x13c>
ffffffffc020a722:	008aa483          	lw	s1,8(s5)
ffffffffc020a726:	0a941b63          	bne	s0,s1,ffffffffc020a7dc <sfs_truncfile+0x20c>
ffffffffc020a72a:	014aa023          	sw	s4,0(s5)
ffffffffc020a72e:	4785                	li	a5,1
ffffffffc020a730:	00f9b823          	sd	a5,16(s3)
ffffffffc020a734:	4901                	li	s2,0
ffffffffc020a736:	855a                	mv	a0,s6
ffffffffc020a738:	d87f90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a73c:	bddd                	j	ffffffffc020a632 <sfs_truncfile+0x62>
ffffffffc020a73e:	86e2                	mv	a3,s8
ffffffffc020a740:	4611                	li	a2,4
ffffffffc020a742:	086c                	addi	a1,sp,28
ffffffffc020a744:	8566                	mv	a0,s9
ffffffffc020a746:	02d000ef          	jal	ra,ffffffffc020af72 <sfs_wbuf>
ffffffffc020a74a:	892a                	mv	s2,a0
ffffffffc020a74c:	f56d                	bnez	a0,ffffffffc020a736 <sfs_truncfile+0x166>
ffffffffc020a74e:	45e2                	lw	a1,24(sp)
ffffffffc020a750:	8566                	mv	a0,s9
ffffffffc020a752:	bc8ff0ef          	jal	ra,ffffffffc0209b1a <sfs_block_free>
ffffffffc020a756:	b7a5                	j	ffffffffc020a6be <sfs_truncfile+0xee>
ffffffffc020a758:	5975                	li	s2,-3
ffffffffc020a75a:	bde1                	j	ffffffffc020a632 <sfs_truncfile+0x62>
ffffffffc020a75c:	00004697          	auipc	a3,0x4
ffffffffc020a760:	7cc68693          	addi	a3,a3,1996 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020a764:	00001617          	auipc	a2,0x1
ffffffffc020a768:	3f460613          	addi	a2,a2,1012 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a76c:	3a600593          	li	a1,934
ffffffffc020a770:	00005517          	auipc	a0,0x5
ffffffffc020a774:	99850513          	addi	a0,a0,-1640 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a778:	d27f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a77c:	00005697          	auipc	a3,0x5
ffffffffc020a780:	95468693          	addi	a3,a3,-1708 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020a784:	00001617          	auipc	a2,0x1
ffffffffc020a788:	3d460613          	addi	a2,a2,980 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a78c:	3a700593          	li	a1,935
ffffffffc020a790:	00005517          	auipc	a0,0x5
ffffffffc020a794:	97850513          	addi	a0,a0,-1672 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a798:	d07f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a79c:	00005697          	auipc	a3,0x5
ffffffffc020a7a0:	b8c68693          	addi	a3,a3,-1140 # ffffffffc020f328 <dev_node_ops+0x7e0>
ffffffffc020a7a4:	00001617          	auipc	a2,0x1
ffffffffc020a7a8:	3b460613          	addi	a2,a2,948 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a7ac:	17b00593          	li	a1,379
ffffffffc020a7b0:	00005517          	auipc	a0,0x5
ffffffffc020a7b4:	95850513          	addi	a0,a0,-1704 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a7b8:	ce7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a7bc:	00005697          	auipc	a3,0x5
ffffffffc020a7c0:	b5468693          	addi	a3,a3,-1196 # ffffffffc020f310 <dev_node_ops+0x7c8>
ffffffffc020a7c4:	00001617          	auipc	a2,0x1
ffffffffc020a7c8:	39460613          	addi	a2,a2,916 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a7cc:	3ae00593          	li	a1,942
ffffffffc020a7d0:	00005517          	auipc	a0,0x5
ffffffffc020a7d4:	93850513          	addi	a0,a0,-1736 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a7d8:	cc7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a7dc:	00005697          	auipc	a3,0x5
ffffffffc020a7e0:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020f378 <dev_node_ops+0x830>
ffffffffc020a7e4:	00001617          	auipc	a2,0x1
ffffffffc020a7e8:	37460613          	addi	a2,a2,884 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a7ec:	3c700593          	li	a1,967
ffffffffc020a7f0:	00005517          	auipc	a0,0x5
ffffffffc020a7f4:	91850513          	addi	a0,a0,-1768 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a7f8:	ca7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a7fc:	00005697          	auipc	a3,0x5
ffffffffc020a800:	b4468693          	addi	a3,a3,-1212 # ffffffffc020f340 <dev_node_ops+0x7f8>
ffffffffc020a804:	00001617          	auipc	a2,0x1
ffffffffc020a808:	35460613          	addi	a2,a2,852 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a80c:	12b00593          	li	a1,299
ffffffffc020a810:	00005517          	auipc	a0,0x5
ffffffffc020a814:	8f850513          	addi	a0,a0,-1800 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a818:	c87f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a81c:	8762                	mv	a4,s8
ffffffffc020a81e:	86be                	mv	a3,a5
ffffffffc020a820:	00005617          	auipc	a2,0x5
ffffffffc020a824:	91860613          	addi	a2,a2,-1768 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc020a828:	05300593          	li	a1,83
ffffffffc020a82c:	00005517          	auipc	a0,0x5
ffffffffc020a830:	8dc50513          	addi	a0,a0,-1828 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a834:	c6bf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a838 <sfs_load_inode>:
ffffffffc020a838:	7139                	addi	sp,sp,-64
ffffffffc020a83a:	fc06                	sd	ra,56(sp)
ffffffffc020a83c:	f822                	sd	s0,48(sp)
ffffffffc020a83e:	f426                	sd	s1,40(sp)
ffffffffc020a840:	f04a                	sd	s2,32(sp)
ffffffffc020a842:	84b2                	mv	s1,a2
ffffffffc020a844:	892a                	mv	s2,a0
ffffffffc020a846:	ec4e                	sd	s3,24(sp)
ffffffffc020a848:	e852                	sd	s4,16(sp)
ffffffffc020a84a:	89ae                	mv	s3,a1
ffffffffc020a84c:	e456                	sd	s5,8(sp)
ffffffffc020a84e:	0d5000ef          	jal	ra,ffffffffc020b122 <lock_sfs_fs>
ffffffffc020a852:	45a9                	li	a1,10
ffffffffc020a854:	8526                	mv	a0,s1
ffffffffc020a856:	0a893403          	ld	s0,168(s2)
ffffffffc020a85a:	0e9000ef          	jal	ra,ffffffffc020b142 <hash32>
ffffffffc020a85e:	02051793          	slli	a5,a0,0x20
ffffffffc020a862:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a866:	9722                	add	a4,a4,s0
ffffffffc020a868:	843a                	mv	s0,a4
ffffffffc020a86a:	a029                	j	ffffffffc020a874 <sfs_load_inode+0x3c>
ffffffffc020a86c:	fc042783          	lw	a5,-64(s0)
ffffffffc020a870:	10978863          	beq	a5,s1,ffffffffc020a980 <sfs_load_inode+0x148>
ffffffffc020a874:	6400                	ld	s0,8(s0)
ffffffffc020a876:	fe871be3          	bne	a4,s0,ffffffffc020a86c <sfs_load_inode+0x34>
ffffffffc020a87a:	04000513          	li	a0,64
ffffffffc020a87e:	f10f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a882:	8aaa                	mv	s5,a0
ffffffffc020a884:	16050563          	beqz	a0,ffffffffc020a9ee <sfs_load_inode+0x1b6>
ffffffffc020a888:	00492683          	lw	a3,4(s2)
ffffffffc020a88c:	18048363          	beqz	s1,ffffffffc020aa12 <sfs_load_inode+0x1da>
ffffffffc020a890:	18d4f163          	bgeu	s1,a3,ffffffffc020aa12 <sfs_load_inode+0x1da>
ffffffffc020a894:	03893503          	ld	a0,56(s2)
ffffffffc020a898:	85a6                	mv	a1,s1
ffffffffc020a89a:	973fe0ef          	jal	ra,ffffffffc020920c <bitmap_test>
ffffffffc020a89e:	18051763          	bnez	a0,ffffffffc020aa2c <sfs_load_inode+0x1f4>
ffffffffc020a8a2:	4701                	li	a4,0
ffffffffc020a8a4:	86a6                	mv	a3,s1
ffffffffc020a8a6:	04000613          	li	a2,64
ffffffffc020a8aa:	85d6                	mv	a1,s5
ffffffffc020a8ac:	854a                	mv	a0,s2
ffffffffc020a8ae:	644000ef          	jal	ra,ffffffffc020aef2 <sfs_rbuf>
ffffffffc020a8b2:	842a                	mv	s0,a0
ffffffffc020a8b4:	0e051563          	bnez	a0,ffffffffc020a99e <sfs_load_inode+0x166>
ffffffffc020a8b8:	006ad783          	lhu	a5,6(s5)
ffffffffc020a8bc:	12078b63          	beqz	a5,ffffffffc020a9f2 <sfs_load_inode+0x1ba>
ffffffffc020a8c0:	6405                	lui	s0,0x1
ffffffffc020a8c2:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a8c6:	900fd0ef          	jal	ra,ffffffffc02079c6 <__alloc_inode>
ffffffffc020a8ca:	8a2a                	mv	s4,a0
ffffffffc020a8cc:	c961                	beqz	a0,ffffffffc020a99c <sfs_load_inode+0x164>
ffffffffc020a8ce:	004ad683          	lhu	a3,4(s5)
ffffffffc020a8d2:	4785                	li	a5,1
ffffffffc020a8d4:	0cf69c63          	bne	a3,a5,ffffffffc020a9ac <sfs_load_inode+0x174>
ffffffffc020a8d8:	864a                	mv	a2,s2
ffffffffc020a8da:	00005597          	auipc	a1,0x5
ffffffffc020a8de:	bae58593          	addi	a1,a1,-1106 # ffffffffc020f488 <sfs_node_fileops>
ffffffffc020a8e2:	900fd0ef          	jal	ra,ffffffffc02079e2 <inode_init>
ffffffffc020a8e6:	058a2783          	lw	a5,88(s4)
ffffffffc020a8ea:	23540413          	addi	s0,s0,565
ffffffffc020a8ee:	0e879063          	bne	a5,s0,ffffffffc020a9ce <sfs_load_inode+0x196>
ffffffffc020a8f2:	4785                	li	a5,1
ffffffffc020a8f4:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a8f8:	015a3023          	sd	s5,0(s4)
ffffffffc020a8fc:	009a2423          	sw	s1,8(s4)
ffffffffc020a900:	000a3823          	sd	zero,16(s4)
ffffffffc020a904:	4585                	li	a1,1
ffffffffc020a906:	020a0513          	addi	a0,s4,32
ffffffffc020a90a:	baff90ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc020a90e:	058a2703          	lw	a4,88(s4)
ffffffffc020a912:	6785                	lui	a5,0x1
ffffffffc020a914:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a918:	14f71663          	bne	a4,a5,ffffffffc020aa64 <sfs_load_inode+0x22c>
ffffffffc020a91c:	0a093703          	ld	a4,160(s2)
ffffffffc020a920:	038a0793          	addi	a5,s4,56
ffffffffc020a924:	008a2503          	lw	a0,8(s4)
ffffffffc020a928:	e31c                	sd	a5,0(a4)
ffffffffc020a92a:	0af93023          	sd	a5,160(s2)
ffffffffc020a92e:	09890793          	addi	a5,s2,152
ffffffffc020a932:	0a893403          	ld	s0,168(s2)
ffffffffc020a936:	45a9                	li	a1,10
ffffffffc020a938:	04ea3023          	sd	a4,64(s4)
ffffffffc020a93c:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a940:	003000ef          	jal	ra,ffffffffc020b142 <hash32>
ffffffffc020a944:	02051713          	slli	a4,a0,0x20
ffffffffc020a948:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a94c:	97a2                	add	a5,a5,s0
ffffffffc020a94e:	6798                	ld	a4,8(a5)
ffffffffc020a950:	048a0693          	addi	a3,s4,72
ffffffffc020a954:	e314                	sd	a3,0(a4)
ffffffffc020a956:	e794                	sd	a3,8(a5)
ffffffffc020a958:	04ea3823          	sd	a4,80(s4)
ffffffffc020a95c:	04fa3423          	sd	a5,72(s4)
ffffffffc020a960:	854a                	mv	a0,s2
ffffffffc020a962:	7d0000ef          	jal	ra,ffffffffc020b132 <unlock_sfs_fs>
ffffffffc020a966:	4401                	li	s0,0
ffffffffc020a968:	0149b023          	sd	s4,0(s3)
ffffffffc020a96c:	70e2                	ld	ra,56(sp)
ffffffffc020a96e:	8522                	mv	a0,s0
ffffffffc020a970:	7442                	ld	s0,48(sp)
ffffffffc020a972:	74a2                	ld	s1,40(sp)
ffffffffc020a974:	7902                	ld	s2,32(sp)
ffffffffc020a976:	69e2                	ld	s3,24(sp)
ffffffffc020a978:	6a42                	ld	s4,16(sp)
ffffffffc020a97a:	6aa2                	ld	s5,8(sp)
ffffffffc020a97c:	6121                	addi	sp,sp,64
ffffffffc020a97e:	8082                	ret
ffffffffc020a980:	fb840a13          	addi	s4,s0,-72
ffffffffc020a984:	8552                	mv	a0,s4
ffffffffc020a986:	8befd0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc020a98a:	4785                	li	a5,1
ffffffffc020a98c:	fcf51ae3          	bne	a0,a5,ffffffffc020a960 <sfs_load_inode+0x128>
ffffffffc020a990:	fd042783          	lw	a5,-48(s0)
ffffffffc020a994:	2785                	addiw	a5,a5,1
ffffffffc020a996:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a99a:	b7d9                	j	ffffffffc020a960 <sfs_load_inode+0x128>
ffffffffc020a99c:	5471                	li	s0,-4
ffffffffc020a99e:	8556                	mv	a0,s5
ffffffffc020a9a0:	e9ef70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a9a4:	854a                	mv	a0,s2
ffffffffc020a9a6:	78c000ef          	jal	ra,ffffffffc020b132 <unlock_sfs_fs>
ffffffffc020a9aa:	b7c9                	j	ffffffffc020a96c <sfs_load_inode+0x134>
ffffffffc020a9ac:	4789                	li	a5,2
ffffffffc020a9ae:	08f69f63          	bne	a3,a5,ffffffffc020aa4c <sfs_load_inode+0x214>
ffffffffc020a9b2:	864a                	mv	a2,s2
ffffffffc020a9b4:	00005597          	auipc	a1,0x5
ffffffffc020a9b8:	a5458593          	addi	a1,a1,-1452 # ffffffffc020f408 <sfs_node_dirops>
ffffffffc020a9bc:	826fd0ef          	jal	ra,ffffffffc02079e2 <inode_init>
ffffffffc020a9c0:	058a2703          	lw	a4,88(s4)
ffffffffc020a9c4:	6785                	lui	a5,0x1
ffffffffc020a9c6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a9ca:	f2f704e3          	beq	a4,a5,ffffffffc020a8f2 <sfs_load_inode+0xba>
ffffffffc020a9ce:	00004697          	auipc	a3,0x4
ffffffffc020a9d2:	70268693          	addi	a3,a3,1794 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020a9d6:	00001617          	auipc	a2,0x1
ffffffffc020a9da:	18260613          	addi	a2,a2,386 # ffffffffc020bb58 <commands+0x210>
ffffffffc020a9de:	07700593          	li	a1,119
ffffffffc020a9e2:	00004517          	auipc	a0,0x4
ffffffffc020a9e6:	72650513          	addi	a0,a0,1830 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020a9ea:	ab5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a9ee:	5471                	li	s0,-4
ffffffffc020a9f0:	bf55                	j	ffffffffc020a9a4 <sfs_load_inode+0x16c>
ffffffffc020a9f2:	00005697          	auipc	a3,0x5
ffffffffc020a9f6:	99e68693          	addi	a3,a3,-1634 # ffffffffc020f390 <dev_node_ops+0x848>
ffffffffc020a9fa:	00001617          	auipc	a2,0x1
ffffffffc020a9fe:	15e60613          	addi	a2,a2,350 # ffffffffc020bb58 <commands+0x210>
ffffffffc020aa02:	0ad00593          	li	a1,173
ffffffffc020aa06:	00004517          	auipc	a0,0x4
ffffffffc020aa0a:	70250513          	addi	a0,a0,1794 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020aa0e:	a91f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa12:	8726                	mv	a4,s1
ffffffffc020aa14:	00004617          	auipc	a2,0x4
ffffffffc020aa18:	72460613          	addi	a2,a2,1828 # ffffffffc020f138 <dev_node_ops+0x5f0>
ffffffffc020aa1c:	05300593          	li	a1,83
ffffffffc020aa20:	00004517          	auipc	a0,0x4
ffffffffc020aa24:	6e850513          	addi	a0,a0,1768 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020aa28:	a77f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa2c:	00004697          	auipc	a3,0x4
ffffffffc020aa30:	74468693          	addi	a3,a3,1860 # ffffffffc020f170 <dev_node_ops+0x628>
ffffffffc020aa34:	00001617          	auipc	a2,0x1
ffffffffc020aa38:	12460613          	addi	a2,a2,292 # ffffffffc020bb58 <commands+0x210>
ffffffffc020aa3c:	0a800593          	li	a1,168
ffffffffc020aa40:	00004517          	auipc	a0,0x4
ffffffffc020aa44:	6c850513          	addi	a0,a0,1736 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020aa48:	a57f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa4c:	00004617          	auipc	a2,0x4
ffffffffc020aa50:	6d460613          	addi	a2,a2,1748 # ffffffffc020f120 <dev_node_ops+0x5d8>
ffffffffc020aa54:	02e00593          	li	a1,46
ffffffffc020aa58:	00004517          	auipc	a0,0x4
ffffffffc020aa5c:	6b050513          	addi	a0,a0,1712 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020aa60:	a3ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa64:	00004697          	auipc	a3,0x4
ffffffffc020aa68:	66c68693          	addi	a3,a3,1644 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020aa6c:	00001617          	auipc	a2,0x1
ffffffffc020aa70:	0ec60613          	addi	a2,a2,236 # ffffffffc020bb58 <commands+0x210>
ffffffffc020aa74:	0b100593          	li	a1,177
ffffffffc020aa78:	00004517          	auipc	a0,0x4
ffffffffc020aa7c:	69050513          	addi	a0,a0,1680 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020aa80:	a1ff50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aa84 <sfs_lookup>:
ffffffffc020aa84:	7139                	addi	sp,sp,-64
ffffffffc020aa86:	ec4e                	sd	s3,24(sp)
ffffffffc020aa88:	06853983          	ld	s3,104(a0)
ffffffffc020aa8c:	fc06                	sd	ra,56(sp)
ffffffffc020aa8e:	f822                	sd	s0,48(sp)
ffffffffc020aa90:	f426                	sd	s1,40(sp)
ffffffffc020aa92:	f04a                	sd	s2,32(sp)
ffffffffc020aa94:	e852                	sd	s4,16(sp)
ffffffffc020aa96:	0a098c63          	beqz	s3,ffffffffc020ab4e <sfs_lookup+0xca>
ffffffffc020aa9a:	0b09a783          	lw	a5,176(s3)
ffffffffc020aa9e:	ebc5                	bnez	a5,ffffffffc020ab4e <sfs_lookup+0xca>
ffffffffc020aaa0:	0005c783          	lbu	a5,0(a1)
ffffffffc020aaa4:	84ae                	mv	s1,a1
ffffffffc020aaa6:	c7c1                	beqz	a5,ffffffffc020ab2e <sfs_lookup+0xaa>
ffffffffc020aaa8:	02f00713          	li	a4,47
ffffffffc020aaac:	08e78163          	beq	a5,a4,ffffffffc020ab2e <sfs_lookup+0xaa>
ffffffffc020aab0:	842a                	mv	s0,a0
ffffffffc020aab2:	8a32                	mv	s4,a2
ffffffffc020aab4:	f91fc0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc020aab8:	4c38                	lw	a4,88(s0)
ffffffffc020aaba:	6785                	lui	a5,0x1
ffffffffc020aabc:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020aac0:	0af71763          	bne	a4,a5,ffffffffc020ab6e <sfs_lookup+0xea>
ffffffffc020aac4:	6018                	ld	a4,0(s0)
ffffffffc020aac6:	4789                	li	a5,2
ffffffffc020aac8:	00475703          	lhu	a4,4(a4)
ffffffffc020aacc:	04f71c63          	bne	a4,a5,ffffffffc020ab24 <sfs_lookup+0xa0>
ffffffffc020aad0:	02040913          	addi	s2,s0,32
ffffffffc020aad4:	854a                	mv	a0,s2
ffffffffc020aad6:	9edf90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020aada:	8626                	mv	a2,s1
ffffffffc020aadc:	0054                	addi	a3,sp,4
ffffffffc020aade:	85a2                	mv	a1,s0
ffffffffc020aae0:	854e                	mv	a0,s3
ffffffffc020aae2:	a29ff0ef          	jal	ra,ffffffffc020a50a <sfs_dirent_search_nolock.constprop.0>
ffffffffc020aae6:	84aa                	mv	s1,a0
ffffffffc020aae8:	854a                	mv	a0,s2
ffffffffc020aaea:	9d5f90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020aaee:	cc89                	beqz	s1,ffffffffc020ab08 <sfs_lookup+0x84>
ffffffffc020aaf0:	8522                	mv	a0,s0
ffffffffc020aaf2:	820fd0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020aaf6:	70e2                	ld	ra,56(sp)
ffffffffc020aaf8:	7442                	ld	s0,48(sp)
ffffffffc020aafa:	7902                	ld	s2,32(sp)
ffffffffc020aafc:	69e2                	ld	s3,24(sp)
ffffffffc020aafe:	6a42                	ld	s4,16(sp)
ffffffffc020ab00:	8526                	mv	a0,s1
ffffffffc020ab02:	74a2                	ld	s1,40(sp)
ffffffffc020ab04:	6121                	addi	sp,sp,64
ffffffffc020ab06:	8082                	ret
ffffffffc020ab08:	4612                	lw	a2,4(sp)
ffffffffc020ab0a:	002c                	addi	a1,sp,8
ffffffffc020ab0c:	854e                	mv	a0,s3
ffffffffc020ab0e:	d2bff0ef          	jal	ra,ffffffffc020a838 <sfs_load_inode>
ffffffffc020ab12:	84aa                	mv	s1,a0
ffffffffc020ab14:	8522                	mv	a0,s0
ffffffffc020ab16:	ffdfc0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020ab1a:	fcf1                	bnez	s1,ffffffffc020aaf6 <sfs_lookup+0x72>
ffffffffc020ab1c:	67a2                	ld	a5,8(sp)
ffffffffc020ab1e:	00fa3023          	sd	a5,0(s4)
ffffffffc020ab22:	bfd1                	j	ffffffffc020aaf6 <sfs_lookup+0x72>
ffffffffc020ab24:	8522                	mv	a0,s0
ffffffffc020ab26:	fedfc0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020ab2a:	54b9                	li	s1,-18
ffffffffc020ab2c:	b7e9                	j	ffffffffc020aaf6 <sfs_lookup+0x72>
ffffffffc020ab2e:	00005697          	auipc	a3,0x5
ffffffffc020ab32:	87a68693          	addi	a3,a3,-1926 # ffffffffc020f3a8 <dev_node_ops+0x860>
ffffffffc020ab36:	00001617          	auipc	a2,0x1
ffffffffc020ab3a:	02260613          	addi	a2,a2,34 # ffffffffc020bb58 <commands+0x210>
ffffffffc020ab3e:	3d800593          	li	a1,984
ffffffffc020ab42:	00004517          	auipc	a0,0x4
ffffffffc020ab46:	5c650513          	addi	a0,a0,1478 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020ab4a:	955f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ab4e:	00004697          	auipc	a3,0x4
ffffffffc020ab52:	3da68693          	addi	a3,a3,986 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020ab56:	00001617          	auipc	a2,0x1
ffffffffc020ab5a:	00260613          	addi	a2,a2,2 # ffffffffc020bb58 <commands+0x210>
ffffffffc020ab5e:	3d700593          	li	a1,983
ffffffffc020ab62:	00004517          	auipc	a0,0x4
ffffffffc020ab66:	5a650513          	addi	a0,a0,1446 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020ab6a:	935f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ab6e:	00004697          	auipc	a3,0x4
ffffffffc020ab72:	56268693          	addi	a3,a3,1378 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020ab76:	00001617          	auipc	a2,0x1
ffffffffc020ab7a:	fe260613          	addi	a2,a2,-30 # ffffffffc020bb58 <commands+0x210>
ffffffffc020ab7e:	3da00593          	li	a1,986
ffffffffc020ab82:	00004517          	auipc	a0,0x4
ffffffffc020ab86:	58650513          	addi	a0,a0,1414 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020ab8a:	915f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ab8e <sfs_namefile>:
ffffffffc020ab8e:	6d98                	ld	a4,24(a1)
ffffffffc020ab90:	7175                	addi	sp,sp,-144
ffffffffc020ab92:	e506                	sd	ra,136(sp)
ffffffffc020ab94:	e122                	sd	s0,128(sp)
ffffffffc020ab96:	fca6                	sd	s1,120(sp)
ffffffffc020ab98:	f8ca                	sd	s2,112(sp)
ffffffffc020ab9a:	f4ce                	sd	s3,104(sp)
ffffffffc020ab9c:	f0d2                	sd	s4,96(sp)
ffffffffc020ab9e:	ecd6                	sd	s5,88(sp)
ffffffffc020aba0:	e8da                	sd	s6,80(sp)
ffffffffc020aba2:	e4de                	sd	s7,72(sp)
ffffffffc020aba4:	e0e2                	sd	s8,64(sp)
ffffffffc020aba6:	fc66                	sd	s9,56(sp)
ffffffffc020aba8:	f86a                	sd	s10,48(sp)
ffffffffc020abaa:	f46e                	sd	s11,40(sp)
ffffffffc020abac:	e42e                	sd	a1,8(sp)
ffffffffc020abae:	4789                	li	a5,2
ffffffffc020abb0:	1ae7f363          	bgeu	a5,a4,ffffffffc020ad56 <sfs_namefile+0x1c8>
ffffffffc020abb4:	89aa                	mv	s3,a0
ffffffffc020abb6:	10400513          	li	a0,260
ffffffffc020abba:	bd4f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020abbe:	842a                	mv	s0,a0
ffffffffc020abc0:	18050b63          	beqz	a0,ffffffffc020ad56 <sfs_namefile+0x1c8>
ffffffffc020abc4:	0689b483          	ld	s1,104(s3)
ffffffffc020abc8:	1e048963          	beqz	s1,ffffffffc020adba <sfs_namefile+0x22c>
ffffffffc020abcc:	0b04a783          	lw	a5,176(s1)
ffffffffc020abd0:	1e079563          	bnez	a5,ffffffffc020adba <sfs_namefile+0x22c>
ffffffffc020abd4:	0589ac83          	lw	s9,88(s3)
ffffffffc020abd8:	6785                	lui	a5,0x1
ffffffffc020abda:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020abde:	1afc9e63          	bne	s9,a5,ffffffffc020ad9a <sfs_namefile+0x20c>
ffffffffc020abe2:	6722                	ld	a4,8(sp)
ffffffffc020abe4:	854e                	mv	a0,s3
ffffffffc020abe6:	8ace                	mv	s5,s3
ffffffffc020abe8:	6f1c                	ld	a5,24(a4)
ffffffffc020abea:	00073b03          	ld	s6,0(a4)
ffffffffc020abee:	02098a13          	addi	s4,s3,32
ffffffffc020abf2:	ffe78b93          	addi	s7,a5,-2
ffffffffc020abf6:	9b3e                	add	s6,s6,a5
ffffffffc020abf8:	00004d17          	auipc	s10,0x4
ffffffffc020abfc:	7d0d0d13          	addi	s10,s10,2000 # ffffffffc020f3c8 <dev_node_ops+0x880>
ffffffffc020ac00:	e45fc0ef          	jal	ra,ffffffffc0207a44 <inode_ref_inc>
ffffffffc020ac04:	00440c13          	addi	s8,s0,4
ffffffffc020ac08:	e066                	sd	s9,0(sp)
ffffffffc020ac0a:	8552                	mv	a0,s4
ffffffffc020ac0c:	8b7f90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020ac10:	0854                	addi	a3,sp,20
ffffffffc020ac12:	866a                	mv	a2,s10
ffffffffc020ac14:	85d6                	mv	a1,s5
ffffffffc020ac16:	8526                	mv	a0,s1
ffffffffc020ac18:	8f3ff0ef          	jal	ra,ffffffffc020a50a <sfs_dirent_search_nolock.constprop.0>
ffffffffc020ac1c:	8daa                	mv	s11,a0
ffffffffc020ac1e:	8552                	mv	a0,s4
ffffffffc020ac20:	89ff90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020ac24:	020d8863          	beqz	s11,ffffffffc020ac54 <sfs_namefile+0xc6>
ffffffffc020ac28:	854e                	mv	a0,s3
ffffffffc020ac2a:	ee9fc0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020ac2e:	8522                	mv	a0,s0
ffffffffc020ac30:	c0ef70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020ac34:	60aa                	ld	ra,136(sp)
ffffffffc020ac36:	640a                	ld	s0,128(sp)
ffffffffc020ac38:	74e6                	ld	s1,120(sp)
ffffffffc020ac3a:	7946                	ld	s2,112(sp)
ffffffffc020ac3c:	79a6                	ld	s3,104(sp)
ffffffffc020ac3e:	7a06                	ld	s4,96(sp)
ffffffffc020ac40:	6ae6                	ld	s5,88(sp)
ffffffffc020ac42:	6b46                	ld	s6,80(sp)
ffffffffc020ac44:	6ba6                	ld	s7,72(sp)
ffffffffc020ac46:	6c06                	ld	s8,64(sp)
ffffffffc020ac48:	7ce2                	ld	s9,56(sp)
ffffffffc020ac4a:	7d42                	ld	s10,48(sp)
ffffffffc020ac4c:	856e                	mv	a0,s11
ffffffffc020ac4e:	7da2                	ld	s11,40(sp)
ffffffffc020ac50:	6149                	addi	sp,sp,144
ffffffffc020ac52:	8082                	ret
ffffffffc020ac54:	4652                	lw	a2,20(sp)
ffffffffc020ac56:	082c                	addi	a1,sp,24
ffffffffc020ac58:	8526                	mv	a0,s1
ffffffffc020ac5a:	bdfff0ef          	jal	ra,ffffffffc020a838 <sfs_load_inode>
ffffffffc020ac5e:	8daa                	mv	s11,a0
ffffffffc020ac60:	f561                	bnez	a0,ffffffffc020ac28 <sfs_namefile+0x9a>
ffffffffc020ac62:	854e                	mv	a0,s3
ffffffffc020ac64:	008aa903          	lw	s2,8(s5)
ffffffffc020ac68:	eabfc0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020ac6c:	6ce2                	ld	s9,24(sp)
ffffffffc020ac6e:	0b3c8463          	beq	s9,s3,ffffffffc020ad16 <sfs_namefile+0x188>
ffffffffc020ac72:	100c8463          	beqz	s9,ffffffffc020ad7a <sfs_namefile+0x1ec>
ffffffffc020ac76:	058ca703          	lw	a4,88(s9)
ffffffffc020ac7a:	6782                	ld	a5,0(sp)
ffffffffc020ac7c:	0ef71f63          	bne	a4,a5,ffffffffc020ad7a <sfs_namefile+0x1ec>
ffffffffc020ac80:	008ca703          	lw	a4,8(s9)
ffffffffc020ac84:	8ae6                	mv	s5,s9
ffffffffc020ac86:	0d270a63          	beq	a4,s2,ffffffffc020ad5a <sfs_namefile+0x1cc>
ffffffffc020ac8a:	000cb703          	ld	a4,0(s9)
ffffffffc020ac8e:	4789                	li	a5,2
ffffffffc020ac90:	00475703          	lhu	a4,4(a4)
ffffffffc020ac94:	0cf71363          	bne	a4,a5,ffffffffc020ad5a <sfs_namefile+0x1cc>
ffffffffc020ac98:	020c8a13          	addi	s4,s9,32
ffffffffc020ac9c:	8552                	mv	a0,s4
ffffffffc020ac9e:	825f90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020aca2:	000cb703          	ld	a4,0(s9)
ffffffffc020aca6:	00872983          	lw	s3,8(a4)
ffffffffc020acaa:	01304963          	bgtz	s3,ffffffffc020acbc <sfs_namefile+0x12e>
ffffffffc020acae:	a899                	j	ffffffffc020ad04 <sfs_namefile+0x176>
ffffffffc020acb0:	4018                	lw	a4,0(s0)
ffffffffc020acb2:	01270e63          	beq	a4,s2,ffffffffc020acce <sfs_namefile+0x140>
ffffffffc020acb6:	2d85                	addiw	s11,s11,1
ffffffffc020acb8:	05b98663          	beq	s3,s11,ffffffffc020ad04 <sfs_namefile+0x176>
ffffffffc020acbc:	86a2                	mv	a3,s0
ffffffffc020acbe:	866e                	mv	a2,s11
ffffffffc020acc0:	85e6                	mv	a1,s9
ffffffffc020acc2:	8526                	mv	a0,s1
ffffffffc020acc4:	e48ff0ef          	jal	ra,ffffffffc020a30c <sfs_dirent_read_nolock>
ffffffffc020acc8:	872a                	mv	a4,a0
ffffffffc020acca:	d17d                	beqz	a0,ffffffffc020acb0 <sfs_namefile+0x122>
ffffffffc020accc:	a82d                	j	ffffffffc020ad06 <sfs_namefile+0x178>
ffffffffc020acce:	8552                	mv	a0,s4
ffffffffc020acd0:	feef90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020acd4:	8562                	mv	a0,s8
ffffffffc020acd6:	0ff000ef          	jal	ra,ffffffffc020b5d4 <strlen>
ffffffffc020acda:	00150793          	addi	a5,a0,1
ffffffffc020acde:	862a                	mv	a2,a0
ffffffffc020ace0:	06fbe863          	bltu	s7,a5,ffffffffc020ad50 <sfs_namefile+0x1c2>
ffffffffc020ace4:	fff64913          	not	s2,a2
ffffffffc020ace8:	995a                	add	s2,s2,s6
ffffffffc020acea:	85e2                	mv	a1,s8
ffffffffc020acec:	854a                	mv	a0,s2
ffffffffc020acee:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020acf2:	1d7000ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020acf6:	02f00793          	li	a5,47
ffffffffc020acfa:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020acfe:	89e6                	mv	s3,s9
ffffffffc020ad00:	8b4a                	mv	s6,s2
ffffffffc020ad02:	b721                	j	ffffffffc020ac0a <sfs_namefile+0x7c>
ffffffffc020ad04:	5741                	li	a4,-16
ffffffffc020ad06:	8552                	mv	a0,s4
ffffffffc020ad08:	e03a                	sd	a4,0(sp)
ffffffffc020ad0a:	fb4f90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020ad0e:	6702                	ld	a4,0(sp)
ffffffffc020ad10:	89e6                	mv	s3,s9
ffffffffc020ad12:	8dba                	mv	s11,a4
ffffffffc020ad14:	bf11                	j	ffffffffc020ac28 <sfs_namefile+0x9a>
ffffffffc020ad16:	854e                	mv	a0,s3
ffffffffc020ad18:	dfbfc0ef          	jal	ra,ffffffffc0207b12 <inode_ref_dec>
ffffffffc020ad1c:	64a2                	ld	s1,8(sp)
ffffffffc020ad1e:	85da                	mv	a1,s6
ffffffffc020ad20:	6c98                	ld	a4,24(s1)
ffffffffc020ad22:	6088                	ld	a0,0(s1)
ffffffffc020ad24:	1779                	addi	a4,a4,-2
ffffffffc020ad26:	41770bb3          	sub	s7,a4,s7
ffffffffc020ad2a:	865e                	mv	a2,s7
ffffffffc020ad2c:	0505                	addi	a0,a0,1
ffffffffc020ad2e:	15b000ef          	jal	ra,ffffffffc020b688 <memmove>
ffffffffc020ad32:	02f00713          	li	a4,47
ffffffffc020ad36:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020ad3a:	955e                	add	a0,a0,s7
ffffffffc020ad3c:	00050023          	sb	zero,0(a0)
ffffffffc020ad40:	85de                	mv	a1,s7
ffffffffc020ad42:	8526                	mv	a0,s1
ffffffffc020ad44:	e72fa0ef          	jal	ra,ffffffffc02053b6 <iobuf_skip>
ffffffffc020ad48:	8522                	mv	a0,s0
ffffffffc020ad4a:	af4f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020ad4e:	b5dd                	j	ffffffffc020ac34 <sfs_namefile+0xa6>
ffffffffc020ad50:	89e6                	mv	s3,s9
ffffffffc020ad52:	5df1                	li	s11,-4
ffffffffc020ad54:	bdd1                	j	ffffffffc020ac28 <sfs_namefile+0x9a>
ffffffffc020ad56:	5df1                	li	s11,-4
ffffffffc020ad58:	bdf1                	j	ffffffffc020ac34 <sfs_namefile+0xa6>
ffffffffc020ad5a:	00004697          	auipc	a3,0x4
ffffffffc020ad5e:	67668693          	addi	a3,a3,1654 # ffffffffc020f3d0 <dev_node_ops+0x888>
ffffffffc020ad62:	00001617          	auipc	a2,0x1
ffffffffc020ad66:	df660613          	addi	a2,a2,-522 # ffffffffc020bb58 <commands+0x210>
ffffffffc020ad6a:	2f600593          	li	a1,758
ffffffffc020ad6e:	00004517          	auipc	a0,0x4
ffffffffc020ad72:	39a50513          	addi	a0,a0,922 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020ad76:	f28f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ad7a:	00004697          	auipc	a3,0x4
ffffffffc020ad7e:	35668693          	addi	a3,a3,854 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020ad82:	00001617          	auipc	a2,0x1
ffffffffc020ad86:	dd660613          	addi	a2,a2,-554 # ffffffffc020bb58 <commands+0x210>
ffffffffc020ad8a:	2f500593          	li	a1,757
ffffffffc020ad8e:	00004517          	auipc	a0,0x4
ffffffffc020ad92:	37a50513          	addi	a0,a0,890 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020ad96:	f08f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ad9a:	00004697          	auipc	a3,0x4
ffffffffc020ad9e:	33668693          	addi	a3,a3,822 # ffffffffc020f0d0 <dev_node_ops+0x588>
ffffffffc020ada2:	00001617          	auipc	a2,0x1
ffffffffc020ada6:	db660613          	addi	a2,a2,-586 # ffffffffc020bb58 <commands+0x210>
ffffffffc020adaa:	2e200593          	li	a1,738
ffffffffc020adae:	00004517          	auipc	a0,0x4
ffffffffc020adb2:	35a50513          	addi	a0,a0,858 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020adb6:	ee8f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020adba:	00004697          	auipc	a3,0x4
ffffffffc020adbe:	16e68693          	addi	a3,a3,366 # ffffffffc020ef28 <dev_node_ops+0x3e0>
ffffffffc020adc2:	00001617          	auipc	a2,0x1
ffffffffc020adc6:	d9660613          	addi	a2,a2,-618 # ffffffffc020bb58 <commands+0x210>
ffffffffc020adca:	2e100593          	li	a1,737
ffffffffc020adce:	00004517          	auipc	a0,0x4
ffffffffc020add2:	33a50513          	addi	a0,a0,826 # ffffffffc020f108 <dev_node_ops+0x5c0>
ffffffffc020add6:	ec8f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020adda <sfs_rwblock_nolock>:
ffffffffc020adda:	7139                	addi	sp,sp,-64
ffffffffc020addc:	f822                	sd	s0,48(sp)
ffffffffc020adde:	f426                	sd	s1,40(sp)
ffffffffc020ade0:	fc06                	sd	ra,56(sp)
ffffffffc020ade2:	842a                	mv	s0,a0
ffffffffc020ade4:	84b6                	mv	s1,a3
ffffffffc020ade6:	e211                	bnez	a2,ffffffffc020adea <sfs_rwblock_nolock+0x10>
ffffffffc020ade8:	e715                	bnez	a4,ffffffffc020ae14 <sfs_rwblock_nolock+0x3a>
ffffffffc020adea:	405c                	lw	a5,4(s0)
ffffffffc020adec:	02f67463          	bgeu	a2,a5,ffffffffc020ae14 <sfs_rwblock_nolock+0x3a>
ffffffffc020adf0:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020adf4:	1682                	slli	a3,a3,0x20
ffffffffc020adf6:	6605                	lui	a2,0x1
ffffffffc020adf8:	9281                	srli	a3,a3,0x20
ffffffffc020adfa:	850a                	mv	a0,sp
ffffffffc020adfc:	d44fa0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020ae00:	85aa                	mv	a1,a0
ffffffffc020ae02:	7808                	ld	a0,48(s0)
ffffffffc020ae04:	8626                	mv	a2,s1
ffffffffc020ae06:	7118                	ld	a4,32(a0)
ffffffffc020ae08:	9702                	jalr	a4
ffffffffc020ae0a:	70e2                	ld	ra,56(sp)
ffffffffc020ae0c:	7442                	ld	s0,48(sp)
ffffffffc020ae0e:	74a2                	ld	s1,40(sp)
ffffffffc020ae10:	6121                	addi	sp,sp,64
ffffffffc020ae12:	8082                	ret
ffffffffc020ae14:	00004697          	auipc	a3,0x4
ffffffffc020ae18:	6f468693          	addi	a3,a3,1780 # ffffffffc020f508 <sfs_node_fileops+0x80>
ffffffffc020ae1c:	00001617          	auipc	a2,0x1
ffffffffc020ae20:	d3c60613          	addi	a2,a2,-708 # ffffffffc020bb58 <commands+0x210>
ffffffffc020ae24:	45d5                	li	a1,21
ffffffffc020ae26:	00004517          	auipc	a0,0x4
ffffffffc020ae2a:	71a50513          	addi	a0,a0,1818 # ffffffffc020f540 <sfs_node_fileops+0xb8>
ffffffffc020ae2e:	e70f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ae32 <sfs_rblock>:
ffffffffc020ae32:	7139                	addi	sp,sp,-64
ffffffffc020ae34:	ec4e                	sd	s3,24(sp)
ffffffffc020ae36:	89b6                	mv	s3,a3
ffffffffc020ae38:	f822                	sd	s0,48(sp)
ffffffffc020ae3a:	f04a                	sd	s2,32(sp)
ffffffffc020ae3c:	e852                	sd	s4,16(sp)
ffffffffc020ae3e:	fc06                	sd	ra,56(sp)
ffffffffc020ae40:	f426                	sd	s1,40(sp)
ffffffffc020ae42:	e456                	sd	s5,8(sp)
ffffffffc020ae44:	8a2a                	mv	s4,a0
ffffffffc020ae46:	892e                	mv	s2,a1
ffffffffc020ae48:	8432                	mv	s0,a2
ffffffffc020ae4a:	2e0000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020ae4e:	04098063          	beqz	s3,ffffffffc020ae8e <sfs_rblock+0x5c>
ffffffffc020ae52:	013409bb          	addw	s3,s0,s3
ffffffffc020ae56:	6a85                	lui	s5,0x1
ffffffffc020ae58:	a021                	j	ffffffffc020ae60 <sfs_rblock+0x2e>
ffffffffc020ae5a:	9956                	add	s2,s2,s5
ffffffffc020ae5c:	02898963          	beq	s3,s0,ffffffffc020ae8e <sfs_rblock+0x5c>
ffffffffc020ae60:	8622                	mv	a2,s0
ffffffffc020ae62:	85ca                	mv	a1,s2
ffffffffc020ae64:	4705                	li	a4,1
ffffffffc020ae66:	4681                	li	a3,0
ffffffffc020ae68:	8552                	mv	a0,s4
ffffffffc020ae6a:	f71ff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020ae6e:	84aa                	mv	s1,a0
ffffffffc020ae70:	2405                	addiw	s0,s0,1
ffffffffc020ae72:	d565                	beqz	a0,ffffffffc020ae5a <sfs_rblock+0x28>
ffffffffc020ae74:	8552                	mv	a0,s4
ffffffffc020ae76:	2c4000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020ae7a:	70e2                	ld	ra,56(sp)
ffffffffc020ae7c:	7442                	ld	s0,48(sp)
ffffffffc020ae7e:	7902                	ld	s2,32(sp)
ffffffffc020ae80:	69e2                	ld	s3,24(sp)
ffffffffc020ae82:	6a42                	ld	s4,16(sp)
ffffffffc020ae84:	6aa2                	ld	s5,8(sp)
ffffffffc020ae86:	8526                	mv	a0,s1
ffffffffc020ae88:	74a2                	ld	s1,40(sp)
ffffffffc020ae8a:	6121                	addi	sp,sp,64
ffffffffc020ae8c:	8082                	ret
ffffffffc020ae8e:	4481                	li	s1,0
ffffffffc020ae90:	b7d5                	j	ffffffffc020ae74 <sfs_rblock+0x42>

ffffffffc020ae92 <sfs_wblock>:
ffffffffc020ae92:	7139                	addi	sp,sp,-64
ffffffffc020ae94:	ec4e                	sd	s3,24(sp)
ffffffffc020ae96:	89b6                	mv	s3,a3
ffffffffc020ae98:	f822                	sd	s0,48(sp)
ffffffffc020ae9a:	f04a                	sd	s2,32(sp)
ffffffffc020ae9c:	e852                	sd	s4,16(sp)
ffffffffc020ae9e:	fc06                	sd	ra,56(sp)
ffffffffc020aea0:	f426                	sd	s1,40(sp)
ffffffffc020aea2:	e456                	sd	s5,8(sp)
ffffffffc020aea4:	8a2a                	mv	s4,a0
ffffffffc020aea6:	892e                	mv	s2,a1
ffffffffc020aea8:	8432                	mv	s0,a2
ffffffffc020aeaa:	280000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020aeae:	04098063          	beqz	s3,ffffffffc020aeee <sfs_wblock+0x5c>
ffffffffc020aeb2:	013409bb          	addw	s3,s0,s3
ffffffffc020aeb6:	6a85                	lui	s5,0x1
ffffffffc020aeb8:	a021                	j	ffffffffc020aec0 <sfs_wblock+0x2e>
ffffffffc020aeba:	9956                	add	s2,s2,s5
ffffffffc020aebc:	02898963          	beq	s3,s0,ffffffffc020aeee <sfs_wblock+0x5c>
ffffffffc020aec0:	8622                	mv	a2,s0
ffffffffc020aec2:	85ca                	mv	a1,s2
ffffffffc020aec4:	4705                	li	a4,1
ffffffffc020aec6:	4685                	li	a3,1
ffffffffc020aec8:	8552                	mv	a0,s4
ffffffffc020aeca:	f11ff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020aece:	84aa                	mv	s1,a0
ffffffffc020aed0:	2405                	addiw	s0,s0,1
ffffffffc020aed2:	d565                	beqz	a0,ffffffffc020aeba <sfs_wblock+0x28>
ffffffffc020aed4:	8552                	mv	a0,s4
ffffffffc020aed6:	264000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020aeda:	70e2                	ld	ra,56(sp)
ffffffffc020aedc:	7442                	ld	s0,48(sp)
ffffffffc020aede:	7902                	ld	s2,32(sp)
ffffffffc020aee0:	69e2                	ld	s3,24(sp)
ffffffffc020aee2:	6a42                	ld	s4,16(sp)
ffffffffc020aee4:	6aa2                	ld	s5,8(sp)
ffffffffc020aee6:	8526                	mv	a0,s1
ffffffffc020aee8:	74a2                	ld	s1,40(sp)
ffffffffc020aeea:	6121                	addi	sp,sp,64
ffffffffc020aeec:	8082                	ret
ffffffffc020aeee:	4481                	li	s1,0
ffffffffc020aef0:	b7d5                	j	ffffffffc020aed4 <sfs_wblock+0x42>

ffffffffc020aef2 <sfs_rbuf>:
ffffffffc020aef2:	7179                	addi	sp,sp,-48
ffffffffc020aef4:	f406                	sd	ra,40(sp)
ffffffffc020aef6:	f022                	sd	s0,32(sp)
ffffffffc020aef8:	ec26                	sd	s1,24(sp)
ffffffffc020aefa:	e84a                	sd	s2,16(sp)
ffffffffc020aefc:	e44e                	sd	s3,8(sp)
ffffffffc020aefe:	e052                	sd	s4,0(sp)
ffffffffc020af00:	6785                	lui	a5,0x1
ffffffffc020af02:	04f77863          	bgeu	a4,a5,ffffffffc020af52 <sfs_rbuf+0x60>
ffffffffc020af06:	84ba                	mv	s1,a4
ffffffffc020af08:	9732                	add	a4,a4,a2
ffffffffc020af0a:	89b2                	mv	s3,a2
ffffffffc020af0c:	04e7e363          	bltu	a5,a4,ffffffffc020af52 <sfs_rbuf+0x60>
ffffffffc020af10:	8936                	mv	s2,a3
ffffffffc020af12:	842a                	mv	s0,a0
ffffffffc020af14:	8a2e                	mv	s4,a1
ffffffffc020af16:	214000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020af1a:	642c                	ld	a1,72(s0)
ffffffffc020af1c:	864a                	mv	a2,s2
ffffffffc020af1e:	4705                	li	a4,1
ffffffffc020af20:	4681                	li	a3,0
ffffffffc020af22:	8522                	mv	a0,s0
ffffffffc020af24:	eb7ff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020af28:	892a                	mv	s2,a0
ffffffffc020af2a:	cd09                	beqz	a0,ffffffffc020af44 <sfs_rbuf+0x52>
ffffffffc020af2c:	8522                	mv	a0,s0
ffffffffc020af2e:	20c000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020af32:	70a2                	ld	ra,40(sp)
ffffffffc020af34:	7402                	ld	s0,32(sp)
ffffffffc020af36:	64e2                	ld	s1,24(sp)
ffffffffc020af38:	69a2                	ld	s3,8(sp)
ffffffffc020af3a:	6a02                	ld	s4,0(sp)
ffffffffc020af3c:	854a                	mv	a0,s2
ffffffffc020af3e:	6942                	ld	s2,16(sp)
ffffffffc020af40:	6145                	addi	sp,sp,48
ffffffffc020af42:	8082                	ret
ffffffffc020af44:	642c                	ld	a1,72(s0)
ffffffffc020af46:	864e                	mv	a2,s3
ffffffffc020af48:	8552                	mv	a0,s4
ffffffffc020af4a:	95a6                	add	a1,a1,s1
ffffffffc020af4c:	77c000ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020af50:	bff1                	j	ffffffffc020af2c <sfs_rbuf+0x3a>
ffffffffc020af52:	00004697          	auipc	a3,0x4
ffffffffc020af56:	60668693          	addi	a3,a3,1542 # ffffffffc020f558 <sfs_node_fileops+0xd0>
ffffffffc020af5a:	00001617          	auipc	a2,0x1
ffffffffc020af5e:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020bb58 <commands+0x210>
ffffffffc020af62:	05500593          	li	a1,85
ffffffffc020af66:	00004517          	auipc	a0,0x4
ffffffffc020af6a:	5da50513          	addi	a0,a0,1498 # ffffffffc020f540 <sfs_node_fileops+0xb8>
ffffffffc020af6e:	d30f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020af72 <sfs_wbuf>:
ffffffffc020af72:	7139                	addi	sp,sp,-64
ffffffffc020af74:	fc06                	sd	ra,56(sp)
ffffffffc020af76:	f822                	sd	s0,48(sp)
ffffffffc020af78:	f426                	sd	s1,40(sp)
ffffffffc020af7a:	f04a                	sd	s2,32(sp)
ffffffffc020af7c:	ec4e                	sd	s3,24(sp)
ffffffffc020af7e:	e852                	sd	s4,16(sp)
ffffffffc020af80:	e456                	sd	s5,8(sp)
ffffffffc020af82:	6785                	lui	a5,0x1
ffffffffc020af84:	06f77163          	bgeu	a4,a5,ffffffffc020afe6 <sfs_wbuf+0x74>
ffffffffc020af88:	893a                	mv	s2,a4
ffffffffc020af8a:	9732                	add	a4,a4,a2
ffffffffc020af8c:	8a32                	mv	s4,a2
ffffffffc020af8e:	04e7ec63          	bltu	a5,a4,ffffffffc020afe6 <sfs_wbuf+0x74>
ffffffffc020af92:	842a                	mv	s0,a0
ffffffffc020af94:	89b6                	mv	s3,a3
ffffffffc020af96:	8aae                	mv	s5,a1
ffffffffc020af98:	192000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020af9c:	642c                	ld	a1,72(s0)
ffffffffc020af9e:	4705                	li	a4,1
ffffffffc020afa0:	4681                	li	a3,0
ffffffffc020afa2:	864e                	mv	a2,s3
ffffffffc020afa4:	8522                	mv	a0,s0
ffffffffc020afa6:	e35ff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020afaa:	84aa                	mv	s1,a0
ffffffffc020afac:	cd11                	beqz	a0,ffffffffc020afc8 <sfs_wbuf+0x56>
ffffffffc020afae:	8522                	mv	a0,s0
ffffffffc020afb0:	18a000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020afb4:	70e2                	ld	ra,56(sp)
ffffffffc020afb6:	7442                	ld	s0,48(sp)
ffffffffc020afb8:	7902                	ld	s2,32(sp)
ffffffffc020afba:	69e2                	ld	s3,24(sp)
ffffffffc020afbc:	6a42                	ld	s4,16(sp)
ffffffffc020afbe:	6aa2                	ld	s5,8(sp)
ffffffffc020afc0:	8526                	mv	a0,s1
ffffffffc020afc2:	74a2                	ld	s1,40(sp)
ffffffffc020afc4:	6121                	addi	sp,sp,64
ffffffffc020afc6:	8082                	ret
ffffffffc020afc8:	6428                	ld	a0,72(s0)
ffffffffc020afca:	8652                	mv	a2,s4
ffffffffc020afcc:	85d6                	mv	a1,s5
ffffffffc020afce:	954a                	add	a0,a0,s2
ffffffffc020afd0:	6f8000ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020afd4:	642c                	ld	a1,72(s0)
ffffffffc020afd6:	4705                	li	a4,1
ffffffffc020afd8:	4685                	li	a3,1
ffffffffc020afda:	864e                	mv	a2,s3
ffffffffc020afdc:	8522                	mv	a0,s0
ffffffffc020afde:	dfdff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020afe2:	84aa                	mv	s1,a0
ffffffffc020afe4:	b7e9                	j	ffffffffc020afae <sfs_wbuf+0x3c>
ffffffffc020afe6:	00004697          	auipc	a3,0x4
ffffffffc020afea:	57268693          	addi	a3,a3,1394 # ffffffffc020f558 <sfs_node_fileops+0xd0>
ffffffffc020afee:	00001617          	auipc	a2,0x1
ffffffffc020aff2:	b6a60613          	addi	a2,a2,-1174 # ffffffffc020bb58 <commands+0x210>
ffffffffc020aff6:	06b00593          	li	a1,107
ffffffffc020affa:	00004517          	auipc	a0,0x4
ffffffffc020affe:	54650513          	addi	a0,a0,1350 # ffffffffc020f540 <sfs_node_fileops+0xb8>
ffffffffc020b002:	c9cf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020b006 <sfs_sync_super>:
ffffffffc020b006:	1101                	addi	sp,sp,-32
ffffffffc020b008:	ec06                	sd	ra,24(sp)
ffffffffc020b00a:	e822                	sd	s0,16(sp)
ffffffffc020b00c:	e426                	sd	s1,8(sp)
ffffffffc020b00e:	842a                	mv	s0,a0
ffffffffc020b010:	11a000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020b014:	6428                	ld	a0,72(s0)
ffffffffc020b016:	6605                	lui	a2,0x1
ffffffffc020b018:	4581                	li	a1,0
ffffffffc020b01a:	65c000ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020b01e:	6428                	ld	a0,72(s0)
ffffffffc020b020:	85a2                	mv	a1,s0
ffffffffc020b022:	02c00613          	li	a2,44
ffffffffc020b026:	6a2000ef          	jal	ra,ffffffffc020b6c8 <memcpy>
ffffffffc020b02a:	642c                	ld	a1,72(s0)
ffffffffc020b02c:	4701                	li	a4,0
ffffffffc020b02e:	4685                	li	a3,1
ffffffffc020b030:	4601                	li	a2,0
ffffffffc020b032:	8522                	mv	a0,s0
ffffffffc020b034:	da7ff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020b038:	84aa                	mv	s1,a0
ffffffffc020b03a:	8522                	mv	a0,s0
ffffffffc020b03c:	0fe000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020b040:	60e2                	ld	ra,24(sp)
ffffffffc020b042:	6442                	ld	s0,16(sp)
ffffffffc020b044:	8526                	mv	a0,s1
ffffffffc020b046:	64a2                	ld	s1,8(sp)
ffffffffc020b048:	6105                	addi	sp,sp,32
ffffffffc020b04a:	8082                	ret

ffffffffc020b04c <sfs_sync_freemap>:
ffffffffc020b04c:	7139                	addi	sp,sp,-64
ffffffffc020b04e:	ec4e                	sd	s3,24(sp)
ffffffffc020b050:	e852                	sd	s4,16(sp)
ffffffffc020b052:	00456983          	lwu	s3,4(a0)
ffffffffc020b056:	8a2a                	mv	s4,a0
ffffffffc020b058:	7d08                	ld	a0,56(a0)
ffffffffc020b05a:	67a1                	lui	a5,0x8
ffffffffc020b05c:	17fd                	addi	a5,a5,-1
ffffffffc020b05e:	4581                	li	a1,0
ffffffffc020b060:	f822                	sd	s0,48(sp)
ffffffffc020b062:	fc06                	sd	ra,56(sp)
ffffffffc020b064:	f426                	sd	s1,40(sp)
ffffffffc020b066:	f04a                	sd	s2,32(sp)
ffffffffc020b068:	e456                	sd	s5,8(sp)
ffffffffc020b06a:	99be                	add	s3,s3,a5
ffffffffc020b06c:	a34fe0ef          	jal	ra,ffffffffc02092a0 <bitmap_getdata>
ffffffffc020b070:	00f9d993          	srli	s3,s3,0xf
ffffffffc020b074:	842a                	mv	s0,a0
ffffffffc020b076:	8552                	mv	a0,s4
ffffffffc020b078:	0b2000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020b07c:	04098163          	beqz	s3,ffffffffc020b0be <sfs_sync_freemap+0x72>
ffffffffc020b080:	09b2                	slli	s3,s3,0xc
ffffffffc020b082:	99a2                	add	s3,s3,s0
ffffffffc020b084:	4909                	li	s2,2
ffffffffc020b086:	6a85                	lui	s5,0x1
ffffffffc020b088:	a021                	j	ffffffffc020b090 <sfs_sync_freemap+0x44>
ffffffffc020b08a:	2905                	addiw	s2,s2,1
ffffffffc020b08c:	02898963          	beq	s3,s0,ffffffffc020b0be <sfs_sync_freemap+0x72>
ffffffffc020b090:	85a2                	mv	a1,s0
ffffffffc020b092:	864a                	mv	a2,s2
ffffffffc020b094:	4705                	li	a4,1
ffffffffc020b096:	4685                	li	a3,1
ffffffffc020b098:	8552                	mv	a0,s4
ffffffffc020b09a:	d41ff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020b09e:	84aa                	mv	s1,a0
ffffffffc020b0a0:	9456                	add	s0,s0,s5
ffffffffc020b0a2:	d565                	beqz	a0,ffffffffc020b08a <sfs_sync_freemap+0x3e>
ffffffffc020b0a4:	8552                	mv	a0,s4
ffffffffc020b0a6:	094000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020b0aa:	70e2                	ld	ra,56(sp)
ffffffffc020b0ac:	7442                	ld	s0,48(sp)
ffffffffc020b0ae:	7902                	ld	s2,32(sp)
ffffffffc020b0b0:	69e2                	ld	s3,24(sp)
ffffffffc020b0b2:	6a42                	ld	s4,16(sp)
ffffffffc020b0b4:	6aa2                	ld	s5,8(sp)
ffffffffc020b0b6:	8526                	mv	a0,s1
ffffffffc020b0b8:	74a2                	ld	s1,40(sp)
ffffffffc020b0ba:	6121                	addi	sp,sp,64
ffffffffc020b0bc:	8082                	ret
ffffffffc020b0be:	4481                	li	s1,0
ffffffffc020b0c0:	b7d5                	j	ffffffffc020b0a4 <sfs_sync_freemap+0x58>

ffffffffc020b0c2 <sfs_clear_block>:
ffffffffc020b0c2:	7179                	addi	sp,sp,-48
ffffffffc020b0c4:	f022                	sd	s0,32(sp)
ffffffffc020b0c6:	e84a                	sd	s2,16(sp)
ffffffffc020b0c8:	e44e                	sd	s3,8(sp)
ffffffffc020b0ca:	f406                	sd	ra,40(sp)
ffffffffc020b0cc:	89b2                	mv	s3,a2
ffffffffc020b0ce:	ec26                	sd	s1,24(sp)
ffffffffc020b0d0:	892a                	mv	s2,a0
ffffffffc020b0d2:	842e                	mv	s0,a1
ffffffffc020b0d4:	056000ef          	jal	ra,ffffffffc020b12a <lock_sfs_io>
ffffffffc020b0d8:	04893503          	ld	a0,72(s2)
ffffffffc020b0dc:	6605                	lui	a2,0x1
ffffffffc020b0de:	4581                	li	a1,0
ffffffffc020b0e0:	596000ef          	jal	ra,ffffffffc020b676 <memset>
ffffffffc020b0e4:	02098d63          	beqz	s3,ffffffffc020b11e <sfs_clear_block+0x5c>
ffffffffc020b0e8:	013409bb          	addw	s3,s0,s3
ffffffffc020b0ec:	a019                	j	ffffffffc020b0f2 <sfs_clear_block+0x30>
ffffffffc020b0ee:	02898863          	beq	s3,s0,ffffffffc020b11e <sfs_clear_block+0x5c>
ffffffffc020b0f2:	04893583          	ld	a1,72(s2)
ffffffffc020b0f6:	8622                	mv	a2,s0
ffffffffc020b0f8:	4705                	li	a4,1
ffffffffc020b0fa:	4685                	li	a3,1
ffffffffc020b0fc:	854a                	mv	a0,s2
ffffffffc020b0fe:	cddff0ef          	jal	ra,ffffffffc020adda <sfs_rwblock_nolock>
ffffffffc020b102:	84aa                	mv	s1,a0
ffffffffc020b104:	2405                	addiw	s0,s0,1
ffffffffc020b106:	d565                	beqz	a0,ffffffffc020b0ee <sfs_clear_block+0x2c>
ffffffffc020b108:	854a                	mv	a0,s2
ffffffffc020b10a:	030000ef          	jal	ra,ffffffffc020b13a <unlock_sfs_io>
ffffffffc020b10e:	70a2                	ld	ra,40(sp)
ffffffffc020b110:	7402                	ld	s0,32(sp)
ffffffffc020b112:	6942                	ld	s2,16(sp)
ffffffffc020b114:	69a2                	ld	s3,8(sp)
ffffffffc020b116:	8526                	mv	a0,s1
ffffffffc020b118:	64e2                	ld	s1,24(sp)
ffffffffc020b11a:	6145                	addi	sp,sp,48
ffffffffc020b11c:	8082                	ret
ffffffffc020b11e:	4481                	li	s1,0
ffffffffc020b120:	b7e5                	j	ffffffffc020b108 <sfs_clear_block+0x46>

ffffffffc020b122 <lock_sfs_fs>:
ffffffffc020b122:	05050513          	addi	a0,a0,80
ffffffffc020b126:	b9cf906f          	j	ffffffffc02044c2 <down>

ffffffffc020b12a <lock_sfs_io>:
ffffffffc020b12a:	06850513          	addi	a0,a0,104
ffffffffc020b12e:	b94f906f          	j	ffffffffc02044c2 <down>

ffffffffc020b132 <unlock_sfs_fs>:
ffffffffc020b132:	05050513          	addi	a0,a0,80
ffffffffc020b136:	b88f906f          	j	ffffffffc02044be <up>

ffffffffc020b13a <unlock_sfs_io>:
ffffffffc020b13a:	06850513          	addi	a0,a0,104
ffffffffc020b13e:	b80f906f          	j	ffffffffc02044be <up>

ffffffffc020b142 <hash32>:
ffffffffc020b142:	9e3707b7          	lui	a5,0x9e370
ffffffffc020b146:	2785                	addiw	a5,a5,1
ffffffffc020b148:	02a7853b          	mulw	a0,a5,a0
ffffffffc020b14c:	02000793          	li	a5,32
ffffffffc020b150:	9f8d                	subw	a5,a5,a1
ffffffffc020b152:	00f5553b          	srlw	a0,a0,a5
ffffffffc020b156:	8082                	ret

ffffffffc020b158 <printnum>:
ffffffffc020b158:	02071893          	slli	a7,a4,0x20
ffffffffc020b15c:	7139                	addi	sp,sp,-64
ffffffffc020b15e:	0208d893          	srli	a7,a7,0x20
ffffffffc020b162:	e456                	sd	s5,8(sp)
ffffffffc020b164:	0316fab3          	remu	s5,a3,a7
ffffffffc020b168:	f822                	sd	s0,48(sp)
ffffffffc020b16a:	f426                	sd	s1,40(sp)
ffffffffc020b16c:	f04a                	sd	s2,32(sp)
ffffffffc020b16e:	ec4e                	sd	s3,24(sp)
ffffffffc020b170:	fc06                	sd	ra,56(sp)
ffffffffc020b172:	e852                	sd	s4,16(sp)
ffffffffc020b174:	84aa                	mv	s1,a0
ffffffffc020b176:	89ae                	mv	s3,a1
ffffffffc020b178:	8932                	mv	s2,a2
ffffffffc020b17a:	fff7841b          	addiw	s0,a5,-1
ffffffffc020b17e:	2a81                	sext.w	s5,s5
ffffffffc020b180:	0516f163          	bgeu	a3,a7,ffffffffc020b1c2 <printnum+0x6a>
ffffffffc020b184:	8a42                	mv	s4,a6
ffffffffc020b186:	00805863          	blez	s0,ffffffffc020b196 <printnum+0x3e>
ffffffffc020b18a:	347d                	addiw	s0,s0,-1
ffffffffc020b18c:	864e                	mv	a2,s3
ffffffffc020b18e:	85ca                	mv	a1,s2
ffffffffc020b190:	8552                	mv	a0,s4
ffffffffc020b192:	9482                	jalr	s1
ffffffffc020b194:	f87d                	bnez	s0,ffffffffc020b18a <printnum+0x32>
ffffffffc020b196:	1a82                	slli	s5,s5,0x20
ffffffffc020b198:	00004797          	auipc	a5,0x4
ffffffffc020b19c:	40878793          	addi	a5,a5,1032 # ffffffffc020f5a0 <sfs_node_fileops+0x118>
ffffffffc020b1a0:	020ada93          	srli	s5,s5,0x20
ffffffffc020b1a4:	9abe                	add	s5,s5,a5
ffffffffc020b1a6:	7442                	ld	s0,48(sp)
ffffffffc020b1a8:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020b1ac:	70e2                	ld	ra,56(sp)
ffffffffc020b1ae:	6a42                	ld	s4,16(sp)
ffffffffc020b1b0:	6aa2                	ld	s5,8(sp)
ffffffffc020b1b2:	864e                	mv	a2,s3
ffffffffc020b1b4:	85ca                	mv	a1,s2
ffffffffc020b1b6:	69e2                	ld	s3,24(sp)
ffffffffc020b1b8:	7902                	ld	s2,32(sp)
ffffffffc020b1ba:	87a6                	mv	a5,s1
ffffffffc020b1bc:	74a2                	ld	s1,40(sp)
ffffffffc020b1be:	6121                	addi	sp,sp,64
ffffffffc020b1c0:	8782                	jr	a5
ffffffffc020b1c2:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b1c6:	87a2                	mv	a5,s0
ffffffffc020b1c8:	f91ff0ef          	jal	ra,ffffffffc020b158 <printnum>
ffffffffc020b1cc:	b7e9                	j	ffffffffc020b196 <printnum+0x3e>

ffffffffc020b1ce <sprintputch>:
ffffffffc020b1ce:	499c                	lw	a5,16(a1)
ffffffffc020b1d0:	6198                	ld	a4,0(a1)
ffffffffc020b1d2:	6594                	ld	a3,8(a1)
ffffffffc020b1d4:	2785                	addiw	a5,a5,1
ffffffffc020b1d6:	c99c                	sw	a5,16(a1)
ffffffffc020b1d8:	00d77763          	bgeu	a4,a3,ffffffffc020b1e6 <sprintputch+0x18>
ffffffffc020b1dc:	00170793          	addi	a5,a4,1
ffffffffc020b1e0:	e19c                	sd	a5,0(a1)
ffffffffc020b1e2:	00a70023          	sb	a0,0(a4)
ffffffffc020b1e6:	8082                	ret

ffffffffc020b1e8 <vprintfmt>:
ffffffffc020b1e8:	7119                	addi	sp,sp,-128
ffffffffc020b1ea:	f4a6                	sd	s1,104(sp)
ffffffffc020b1ec:	f0ca                	sd	s2,96(sp)
ffffffffc020b1ee:	ecce                	sd	s3,88(sp)
ffffffffc020b1f0:	e8d2                	sd	s4,80(sp)
ffffffffc020b1f2:	e4d6                	sd	s5,72(sp)
ffffffffc020b1f4:	e0da                	sd	s6,64(sp)
ffffffffc020b1f6:	fc5e                	sd	s7,56(sp)
ffffffffc020b1f8:	ec6e                	sd	s11,24(sp)
ffffffffc020b1fa:	fc86                	sd	ra,120(sp)
ffffffffc020b1fc:	f8a2                	sd	s0,112(sp)
ffffffffc020b1fe:	f862                	sd	s8,48(sp)
ffffffffc020b200:	f466                	sd	s9,40(sp)
ffffffffc020b202:	f06a                	sd	s10,32(sp)
ffffffffc020b204:	89aa                	mv	s3,a0
ffffffffc020b206:	892e                	mv	s2,a1
ffffffffc020b208:	84b2                	mv	s1,a2
ffffffffc020b20a:	8db6                	mv	s11,a3
ffffffffc020b20c:	8aba                	mv	s5,a4
ffffffffc020b20e:	02500a13          	li	s4,37
ffffffffc020b212:	5bfd                	li	s7,-1
ffffffffc020b214:	00004b17          	auipc	s6,0x4
ffffffffc020b218:	3b8b0b13          	addi	s6,s6,952 # ffffffffc020f5cc <sfs_node_fileops+0x144>
ffffffffc020b21c:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b220:	001d8413          	addi	s0,s11,1
ffffffffc020b224:	01450b63          	beq	a0,s4,ffffffffc020b23a <vprintfmt+0x52>
ffffffffc020b228:	c129                	beqz	a0,ffffffffc020b26a <vprintfmt+0x82>
ffffffffc020b22a:	864a                	mv	a2,s2
ffffffffc020b22c:	85a6                	mv	a1,s1
ffffffffc020b22e:	0405                	addi	s0,s0,1
ffffffffc020b230:	9982                	jalr	s3
ffffffffc020b232:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b236:	ff4519e3          	bne	a0,s4,ffffffffc020b228 <vprintfmt+0x40>
ffffffffc020b23a:	00044583          	lbu	a1,0(s0)
ffffffffc020b23e:	02000813          	li	a6,32
ffffffffc020b242:	4d01                	li	s10,0
ffffffffc020b244:	4301                	li	t1,0
ffffffffc020b246:	5cfd                	li	s9,-1
ffffffffc020b248:	5c7d                	li	s8,-1
ffffffffc020b24a:	05500513          	li	a0,85
ffffffffc020b24e:	48a5                	li	a7,9
ffffffffc020b250:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b254:	0ff67613          	zext.b	a2,a2
ffffffffc020b258:	00140d93          	addi	s11,s0,1
ffffffffc020b25c:	04c56263          	bltu	a0,a2,ffffffffc020b2a0 <vprintfmt+0xb8>
ffffffffc020b260:	060a                	slli	a2,a2,0x2
ffffffffc020b262:	965a                	add	a2,a2,s6
ffffffffc020b264:	4214                	lw	a3,0(a2)
ffffffffc020b266:	96da                	add	a3,a3,s6
ffffffffc020b268:	8682                	jr	a3
ffffffffc020b26a:	70e6                	ld	ra,120(sp)
ffffffffc020b26c:	7446                	ld	s0,112(sp)
ffffffffc020b26e:	74a6                	ld	s1,104(sp)
ffffffffc020b270:	7906                	ld	s2,96(sp)
ffffffffc020b272:	69e6                	ld	s3,88(sp)
ffffffffc020b274:	6a46                	ld	s4,80(sp)
ffffffffc020b276:	6aa6                	ld	s5,72(sp)
ffffffffc020b278:	6b06                	ld	s6,64(sp)
ffffffffc020b27a:	7be2                	ld	s7,56(sp)
ffffffffc020b27c:	7c42                	ld	s8,48(sp)
ffffffffc020b27e:	7ca2                	ld	s9,40(sp)
ffffffffc020b280:	7d02                	ld	s10,32(sp)
ffffffffc020b282:	6de2                	ld	s11,24(sp)
ffffffffc020b284:	6109                	addi	sp,sp,128
ffffffffc020b286:	8082                	ret
ffffffffc020b288:	882e                	mv	a6,a1
ffffffffc020b28a:	00144583          	lbu	a1,1(s0)
ffffffffc020b28e:	846e                	mv	s0,s11
ffffffffc020b290:	00140d93          	addi	s11,s0,1
ffffffffc020b294:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b298:	0ff67613          	zext.b	a2,a2
ffffffffc020b29c:	fcc572e3          	bgeu	a0,a2,ffffffffc020b260 <vprintfmt+0x78>
ffffffffc020b2a0:	864a                	mv	a2,s2
ffffffffc020b2a2:	85a6                	mv	a1,s1
ffffffffc020b2a4:	02500513          	li	a0,37
ffffffffc020b2a8:	9982                	jalr	s3
ffffffffc020b2aa:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b2ae:	8da2                	mv	s11,s0
ffffffffc020b2b0:	f74786e3          	beq	a5,s4,ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b2b4:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b2b8:	1dfd                	addi	s11,s11,-1
ffffffffc020b2ba:	ff479de3          	bne	a5,s4,ffffffffc020b2b4 <vprintfmt+0xcc>
ffffffffc020b2be:	bfb9                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b2c0:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b2c4:	00144583          	lbu	a1,1(s0)
ffffffffc020b2c8:	846e                	mv	s0,s11
ffffffffc020b2ca:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b2ce:	0005861b          	sext.w	a2,a1
ffffffffc020b2d2:	02d8e463          	bltu	a7,a3,ffffffffc020b2fa <vprintfmt+0x112>
ffffffffc020b2d6:	00144583          	lbu	a1,1(s0)
ffffffffc020b2da:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b2de:	0196873b          	addw	a4,a3,s9
ffffffffc020b2e2:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b2e6:	9f31                	addw	a4,a4,a2
ffffffffc020b2e8:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b2ec:	0405                	addi	s0,s0,1
ffffffffc020b2ee:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b2f2:	0005861b          	sext.w	a2,a1
ffffffffc020b2f6:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b2d6 <vprintfmt+0xee>
ffffffffc020b2fa:	f40c5be3          	bgez	s8,ffffffffc020b250 <vprintfmt+0x68>
ffffffffc020b2fe:	8c66                	mv	s8,s9
ffffffffc020b300:	5cfd                	li	s9,-1
ffffffffc020b302:	b7b9                	j	ffffffffc020b250 <vprintfmt+0x68>
ffffffffc020b304:	fffc4693          	not	a3,s8
ffffffffc020b308:	96fd                	srai	a3,a3,0x3f
ffffffffc020b30a:	00dc77b3          	and	a5,s8,a3
ffffffffc020b30e:	00144583          	lbu	a1,1(s0)
ffffffffc020b312:	00078c1b          	sext.w	s8,a5
ffffffffc020b316:	846e                	mv	s0,s11
ffffffffc020b318:	bf25                	j	ffffffffc020b250 <vprintfmt+0x68>
ffffffffc020b31a:	000aac83          	lw	s9,0(s5)
ffffffffc020b31e:	00144583          	lbu	a1,1(s0)
ffffffffc020b322:	0aa1                	addi	s5,s5,8
ffffffffc020b324:	846e                	mv	s0,s11
ffffffffc020b326:	bfd1                	j	ffffffffc020b2fa <vprintfmt+0x112>
ffffffffc020b328:	4705                	li	a4,1
ffffffffc020b32a:	008a8613          	addi	a2,s5,8
ffffffffc020b32e:	00674463          	blt	a4,t1,ffffffffc020b336 <vprintfmt+0x14e>
ffffffffc020b332:	1c030c63          	beqz	t1,ffffffffc020b50a <vprintfmt+0x322>
ffffffffc020b336:	000ab683          	ld	a3,0(s5)
ffffffffc020b33a:	4741                	li	a4,16
ffffffffc020b33c:	8ab2                	mv	s5,a2
ffffffffc020b33e:	2801                	sext.w	a6,a6
ffffffffc020b340:	87e2                	mv	a5,s8
ffffffffc020b342:	8626                	mv	a2,s1
ffffffffc020b344:	85ca                	mv	a1,s2
ffffffffc020b346:	854e                	mv	a0,s3
ffffffffc020b348:	e11ff0ef          	jal	ra,ffffffffc020b158 <printnum>
ffffffffc020b34c:	bdc1                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b34e:	000aa503          	lw	a0,0(s5)
ffffffffc020b352:	864a                	mv	a2,s2
ffffffffc020b354:	85a6                	mv	a1,s1
ffffffffc020b356:	0aa1                	addi	s5,s5,8
ffffffffc020b358:	9982                	jalr	s3
ffffffffc020b35a:	b5c9                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b35c:	4705                	li	a4,1
ffffffffc020b35e:	008a8613          	addi	a2,s5,8
ffffffffc020b362:	00674463          	blt	a4,t1,ffffffffc020b36a <vprintfmt+0x182>
ffffffffc020b366:	18030d63          	beqz	t1,ffffffffc020b500 <vprintfmt+0x318>
ffffffffc020b36a:	000ab683          	ld	a3,0(s5)
ffffffffc020b36e:	4729                	li	a4,10
ffffffffc020b370:	8ab2                	mv	s5,a2
ffffffffc020b372:	b7f1                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b374:	00144583          	lbu	a1,1(s0)
ffffffffc020b378:	4d05                	li	s10,1
ffffffffc020b37a:	846e                	mv	s0,s11
ffffffffc020b37c:	bdd1                	j	ffffffffc020b250 <vprintfmt+0x68>
ffffffffc020b37e:	864a                	mv	a2,s2
ffffffffc020b380:	85a6                	mv	a1,s1
ffffffffc020b382:	02500513          	li	a0,37
ffffffffc020b386:	9982                	jalr	s3
ffffffffc020b388:	bd51                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b38a:	00144583          	lbu	a1,1(s0)
ffffffffc020b38e:	2305                	addiw	t1,t1,1
ffffffffc020b390:	846e                	mv	s0,s11
ffffffffc020b392:	bd7d                	j	ffffffffc020b250 <vprintfmt+0x68>
ffffffffc020b394:	4705                	li	a4,1
ffffffffc020b396:	008a8613          	addi	a2,s5,8
ffffffffc020b39a:	00674463          	blt	a4,t1,ffffffffc020b3a2 <vprintfmt+0x1ba>
ffffffffc020b39e:	14030c63          	beqz	t1,ffffffffc020b4f6 <vprintfmt+0x30e>
ffffffffc020b3a2:	000ab683          	ld	a3,0(s5)
ffffffffc020b3a6:	4721                	li	a4,8
ffffffffc020b3a8:	8ab2                	mv	s5,a2
ffffffffc020b3aa:	bf51                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b3ac:	03000513          	li	a0,48
ffffffffc020b3b0:	864a                	mv	a2,s2
ffffffffc020b3b2:	85a6                	mv	a1,s1
ffffffffc020b3b4:	e042                	sd	a6,0(sp)
ffffffffc020b3b6:	9982                	jalr	s3
ffffffffc020b3b8:	864a                	mv	a2,s2
ffffffffc020b3ba:	85a6                	mv	a1,s1
ffffffffc020b3bc:	07800513          	li	a0,120
ffffffffc020b3c0:	9982                	jalr	s3
ffffffffc020b3c2:	0aa1                	addi	s5,s5,8
ffffffffc020b3c4:	6802                	ld	a6,0(sp)
ffffffffc020b3c6:	4741                	li	a4,16
ffffffffc020b3c8:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b3cc:	bf8d                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b3ce:	000ab403          	ld	s0,0(s5)
ffffffffc020b3d2:	008a8793          	addi	a5,s5,8
ffffffffc020b3d6:	e03e                	sd	a5,0(sp)
ffffffffc020b3d8:	14040c63          	beqz	s0,ffffffffc020b530 <vprintfmt+0x348>
ffffffffc020b3dc:	11805063          	blez	s8,ffffffffc020b4dc <vprintfmt+0x2f4>
ffffffffc020b3e0:	02d00693          	li	a3,45
ffffffffc020b3e4:	0cd81963          	bne	a6,a3,ffffffffc020b4b6 <vprintfmt+0x2ce>
ffffffffc020b3e8:	00044683          	lbu	a3,0(s0)
ffffffffc020b3ec:	0006851b          	sext.w	a0,a3
ffffffffc020b3f0:	ce8d                	beqz	a3,ffffffffc020b42a <vprintfmt+0x242>
ffffffffc020b3f2:	00140a93          	addi	s5,s0,1
ffffffffc020b3f6:	05e00413          	li	s0,94
ffffffffc020b3fa:	000cc563          	bltz	s9,ffffffffc020b404 <vprintfmt+0x21c>
ffffffffc020b3fe:	3cfd                	addiw	s9,s9,-1
ffffffffc020b400:	037c8363          	beq	s9,s7,ffffffffc020b426 <vprintfmt+0x23e>
ffffffffc020b404:	864a                	mv	a2,s2
ffffffffc020b406:	85a6                	mv	a1,s1
ffffffffc020b408:	100d0663          	beqz	s10,ffffffffc020b514 <vprintfmt+0x32c>
ffffffffc020b40c:	3681                	addiw	a3,a3,-32
ffffffffc020b40e:	10d47363          	bgeu	s0,a3,ffffffffc020b514 <vprintfmt+0x32c>
ffffffffc020b412:	03f00513          	li	a0,63
ffffffffc020b416:	9982                	jalr	s3
ffffffffc020b418:	000ac683          	lbu	a3,0(s5)
ffffffffc020b41c:	3c7d                	addiw	s8,s8,-1
ffffffffc020b41e:	0a85                	addi	s5,s5,1
ffffffffc020b420:	0006851b          	sext.w	a0,a3
ffffffffc020b424:	faf9                	bnez	a3,ffffffffc020b3fa <vprintfmt+0x212>
ffffffffc020b426:	01805a63          	blez	s8,ffffffffc020b43a <vprintfmt+0x252>
ffffffffc020b42a:	3c7d                	addiw	s8,s8,-1
ffffffffc020b42c:	864a                	mv	a2,s2
ffffffffc020b42e:	85a6                	mv	a1,s1
ffffffffc020b430:	02000513          	li	a0,32
ffffffffc020b434:	9982                	jalr	s3
ffffffffc020b436:	fe0c1ae3          	bnez	s8,ffffffffc020b42a <vprintfmt+0x242>
ffffffffc020b43a:	6a82                	ld	s5,0(sp)
ffffffffc020b43c:	b3c5                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b43e:	4705                	li	a4,1
ffffffffc020b440:	008a8d13          	addi	s10,s5,8
ffffffffc020b444:	00674463          	blt	a4,t1,ffffffffc020b44c <vprintfmt+0x264>
ffffffffc020b448:	0a030463          	beqz	t1,ffffffffc020b4f0 <vprintfmt+0x308>
ffffffffc020b44c:	000ab403          	ld	s0,0(s5)
ffffffffc020b450:	0c044463          	bltz	s0,ffffffffc020b518 <vprintfmt+0x330>
ffffffffc020b454:	86a2                	mv	a3,s0
ffffffffc020b456:	8aea                	mv	s5,s10
ffffffffc020b458:	4729                	li	a4,10
ffffffffc020b45a:	b5d5                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b45c:	000aa783          	lw	a5,0(s5)
ffffffffc020b460:	46e1                	li	a3,24
ffffffffc020b462:	0aa1                	addi	s5,s5,8
ffffffffc020b464:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b468:	8fb9                	xor	a5,a5,a4
ffffffffc020b46a:	40e7873b          	subw	a4,a5,a4
ffffffffc020b46e:	02e6c663          	blt	a3,a4,ffffffffc020b49a <vprintfmt+0x2b2>
ffffffffc020b472:	00371793          	slli	a5,a4,0x3
ffffffffc020b476:	00004697          	auipc	a3,0x4
ffffffffc020b47a:	48a68693          	addi	a3,a3,1162 # ffffffffc020f900 <error_string>
ffffffffc020b47e:	97b6                	add	a5,a5,a3
ffffffffc020b480:	639c                	ld	a5,0(a5)
ffffffffc020b482:	cf81                	beqz	a5,ffffffffc020b49a <vprintfmt+0x2b2>
ffffffffc020b484:	873e                	mv	a4,a5
ffffffffc020b486:	00000697          	auipc	a3,0x0
ffffffffc020b48a:	28268693          	addi	a3,a3,642 # ffffffffc020b708 <etext+0x28>
ffffffffc020b48e:	8626                	mv	a2,s1
ffffffffc020b490:	85ca                	mv	a1,s2
ffffffffc020b492:	854e                	mv	a0,s3
ffffffffc020b494:	0d4000ef          	jal	ra,ffffffffc020b568 <printfmt>
ffffffffc020b498:	b351                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b49a:	00004697          	auipc	a3,0x4
ffffffffc020b49e:	12668693          	addi	a3,a3,294 # ffffffffc020f5c0 <sfs_node_fileops+0x138>
ffffffffc020b4a2:	8626                	mv	a2,s1
ffffffffc020b4a4:	85ca                	mv	a1,s2
ffffffffc020b4a6:	854e                	mv	a0,s3
ffffffffc020b4a8:	0c0000ef          	jal	ra,ffffffffc020b568 <printfmt>
ffffffffc020b4ac:	bb85                	j	ffffffffc020b21c <vprintfmt+0x34>
ffffffffc020b4ae:	00004417          	auipc	s0,0x4
ffffffffc020b4b2:	10a40413          	addi	s0,s0,266 # ffffffffc020f5b8 <sfs_node_fileops+0x130>
ffffffffc020b4b6:	85e6                	mv	a1,s9
ffffffffc020b4b8:	8522                	mv	a0,s0
ffffffffc020b4ba:	e442                	sd	a6,8(sp)
ffffffffc020b4bc:	132000ef          	jal	ra,ffffffffc020b5ee <strnlen>
ffffffffc020b4c0:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b4c4:	01805c63          	blez	s8,ffffffffc020b4dc <vprintfmt+0x2f4>
ffffffffc020b4c8:	6822                	ld	a6,8(sp)
ffffffffc020b4ca:	00080a9b          	sext.w	s5,a6
ffffffffc020b4ce:	3c7d                	addiw	s8,s8,-1
ffffffffc020b4d0:	864a                	mv	a2,s2
ffffffffc020b4d2:	85a6                	mv	a1,s1
ffffffffc020b4d4:	8556                	mv	a0,s5
ffffffffc020b4d6:	9982                	jalr	s3
ffffffffc020b4d8:	fe0c1be3          	bnez	s8,ffffffffc020b4ce <vprintfmt+0x2e6>
ffffffffc020b4dc:	00044683          	lbu	a3,0(s0)
ffffffffc020b4e0:	00140a93          	addi	s5,s0,1
ffffffffc020b4e4:	0006851b          	sext.w	a0,a3
ffffffffc020b4e8:	daa9                	beqz	a3,ffffffffc020b43a <vprintfmt+0x252>
ffffffffc020b4ea:	05e00413          	li	s0,94
ffffffffc020b4ee:	b731                	j	ffffffffc020b3fa <vprintfmt+0x212>
ffffffffc020b4f0:	000aa403          	lw	s0,0(s5)
ffffffffc020b4f4:	bfb1                	j	ffffffffc020b450 <vprintfmt+0x268>
ffffffffc020b4f6:	000ae683          	lwu	a3,0(s5)
ffffffffc020b4fa:	4721                	li	a4,8
ffffffffc020b4fc:	8ab2                	mv	s5,a2
ffffffffc020b4fe:	b581                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b500:	000ae683          	lwu	a3,0(s5)
ffffffffc020b504:	4729                	li	a4,10
ffffffffc020b506:	8ab2                	mv	s5,a2
ffffffffc020b508:	bd1d                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b50a:	000ae683          	lwu	a3,0(s5)
ffffffffc020b50e:	4741                	li	a4,16
ffffffffc020b510:	8ab2                	mv	s5,a2
ffffffffc020b512:	b535                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b514:	9982                	jalr	s3
ffffffffc020b516:	b709                	j	ffffffffc020b418 <vprintfmt+0x230>
ffffffffc020b518:	864a                	mv	a2,s2
ffffffffc020b51a:	85a6                	mv	a1,s1
ffffffffc020b51c:	02d00513          	li	a0,45
ffffffffc020b520:	e042                	sd	a6,0(sp)
ffffffffc020b522:	9982                	jalr	s3
ffffffffc020b524:	6802                	ld	a6,0(sp)
ffffffffc020b526:	8aea                	mv	s5,s10
ffffffffc020b528:	408006b3          	neg	a3,s0
ffffffffc020b52c:	4729                	li	a4,10
ffffffffc020b52e:	bd01                	j	ffffffffc020b33e <vprintfmt+0x156>
ffffffffc020b530:	03805163          	blez	s8,ffffffffc020b552 <vprintfmt+0x36a>
ffffffffc020b534:	02d00693          	li	a3,45
ffffffffc020b538:	f6d81be3          	bne	a6,a3,ffffffffc020b4ae <vprintfmt+0x2c6>
ffffffffc020b53c:	00004417          	auipc	s0,0x4
ffffffffc020b540:	07c40413          	addi	s0,s0,124 # ffffffffc020f5b8 <sfs_node_fileops+0x130>
ffffffffc020b544:	02800693          	li	a3,40
ffffffffc020b548:	02800513          	li	a0,40
ffffffffc020b54c:	00140a93          	addi	s5,s0,1
ffffffffc020b550:	b55d                	j	ffffffffc020b3f6 <vprintfmt+0x20e>
ffffffffc020b552:	00004a97          	auipc	s5,0x4
ffffffffc020b556:	067a8a93          	addi	s5,s5,103 # ffffffffc020f5b9 <sfs_node_fileops+0x131>
ffffffffc020b55a:	02800513          	li	a0,40
ffffffffc020b55e:	02800693          	li	a3,40
ffffffffc020b562:	05e00413          	li	s0,94
ffffffffc020b566:	bd51                	j	ffffffffc020b3fa <vprintfmt+0x212>

ffffffffc020b568 <printfmt>:
ffffffffc020b568:	7139                	addi	sp,sp,-64
ffffffffc020b56a:	02010313          	addi	t1,sp,32
ffffffffc020b56e:	f03a                	sd	a4,32(sp)
ffffffffc020b570:	871a                	mv	a4,t1
ffffffffc020b572:	ec06                	sd	ra,24(sp)
ffffffffc020b574:	f43e                	sd	a5,40(sp)
ffffffffc020b576:	f842                	sd	a6,48(sp)
ffffffffc020b578:	fc46                	sd	a7,56(sp)
ffffffffc020b57a:	e41a                	sd	t1,8(sp)
ffffffffc020b57c:	c6dff0ef          	jal	ra,ffffffffc020b1e8 <vprintfmt>
ffffffffc020b580:	60e2                	ld	ra,24(sp)
ffffffffc020b582:	6121                	addi	sp,sp,64
ffffffffc020b584:	8082                	ret

ffffffffc020b586 <snprintf>:
ffffffffc020b586:	711d                	addi	sp,sp,-96
ffffffffc020b588:	15fd                	addi	a1,a1,-1
ffffffffc020b58a:	03810313          	addi	t1,sp,56
ffffffffc020b58e:	95aa                	add	a1,a1,a0
ffffffffc020b590:	f406                	sd	ra,40(sp)
ffffffffc020b592:	fc36                	sd	a3,56(sp)
ffffffffc020b594:	e0ba                	sd	a4,64(sp)
ffffffffc020b596:	e4be                	sd	a5,72(sp)
ffffffffc020b598:	e8c2                	sd	a6,80(sp)
ffffffffc020b59a:	ecc6                	sd	a7,88(sp)
ffffffffc020b59c:	e01a                	sd	t1,0(sp)
ffffffffc020b59e:	e42a                	sd	a0,8(sp)
ffffffffc020b5a0:	e82e                	sd	a1,16(sp)
ffffffffc020b5a2:	cc02                	sw	zero,24(sp)
ffffffffc020b5a4:	c515                	beqz	a0,ffffffffc020b5d0 <snprintf+0x4a>
ffffffffc020b5a6:	02a5e563          	bltu	a1,a0,ffffffffc020b5d0 <snprintf+0x4a>
ffffffffc020b5aa:	75dd                	lui	a1,0xffff7
ffffffffc020b5ac:	86b2                	mv	a3,a2
ffffffffc020b5ae:	00000517          	auipc	a0,0x0
ffffffffc020b5b2:	c2050513          	addi	a0,a0,-992 # ffffffffc020b1ce <sprintputch>
ffffffffc020b5b6:	871a                	mv	a4,t1
ffffffffc020b5b8:	0030                	addi	a2,sp,8
ffffffffc020b5ba:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b5be:	c2bff0ef          	jal	ra,ffffffffc020b1e8 <vprintfmt>
ffffffffc020b5c2:	67a2                	ld	a5,8(sp)
ffffffffc020b5c4:	00078023          	sb	zero,0(a5)
ffffffffc020b5c8:	4562                	lw	a0,24(sp)
ffffffffc020b5ca:	70a2                	ld	ra,40(sp)
ffffffffc020b5cc:	6125                	addi	sp,sp,96
ffffffffc020b5ce:	8082                	ret
ffffffffc020b5d0:	5575                	li	a0,-3
ffffffffc020b5d2:	bfe5                	j	ffffffffc020b5ca <snprintf+0x44>

ffffffffc020b5d4 <strlen>:
ffffffffc020b5d4:	00054783          	lbu	a5,0(a0)
ffffffffc020b5d8:	872a                	mv	a4,a0
ffffffffc020b5da:	4501                	li	a0,0
ffffffffc020b5dc:	cb81                	beqz	a5,ffffffffc020b5ec <strlen+0x18>
ffffffffc020b5de:	0505                	addi	a0,a0,1
ffffffffc020b5e0:	00a707b3          	add	a5,a4,a0
ffffffffc020b5e4:	0007c783          	lbu	a5,0(a5)
ffffffffc020b5e8:	fbfd                	bnez	a5,ffffffffc020b5de <strlen+0xa>
ffffffffc020b5ea:	8082                	ret
ffffffffc020b5ec:	8082                	ret

ffffffffc020b5ee <strnlen>:
ffffffffc020b5ee:	4781                	li	a5,0
ffffffffc020b5f0:	e589                	bnez	a1,ffffffffc020b5fa <strnlen+0xc>
ffffffffc020b5f2:	a811                	j	ffffffffc020b606 <strnlen+0x18>
ffffffffc020b5f4:	0785                	addi	a5,a5,1
ffffffffc020b5f6:	00f58863          	beq	a1,a5,ffffffffc020b606 <strnlen+0x18>
ffffffffc020b5fa:	00f50733          	add	a4,a0,a5
ffffffffc020b5fe:	00074703          	lbu	a4,0(a4)
ffffffffc020b602:	fb6d                	bnez	a4,ffffffffc020b5f4 <strnlen+0x6>
ffffffffc020b604:	85be                	mv	a1,a5
ffffffffc020b606:	852e                	mv	a0,a1
ffffffffc020b608:	8082                	ret

ffffffffc020b60a <strcpy>:
ffffffffc020b60a:	87aa                	mv	a5,a0
ffffffffc020b60c:	0005c703          	lbu	a4,0(a1)
ffffffffc020b610:	0785                	addi	a5,a5,1
ffffffffc020b612:	0585                	addi	a1,a1,1
ffffffffc020b614:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b618:	fb75                	bnez	a4,ffffffffc020b60c <strcpy+0x2>
ffffffffc020b61a:	8082                	ret

ffffffffc020b61c <strcmp>:
ffffffffc020b61c:	00054783          	lbu	a5,0(a0)
ffffffffc020b620:	0005c703          	lbu	a4,0(a1)
ffffffffc020b624:	cb89                	beqz	a5,ffffffffc020b636 <strcmp+0x1a>
ffffffffc020b626:	0505                	addi	a0,a0,1
ffffffffc020b628:	0585                	addi	a1,a1,1
ffffffffc020b62a:	fee789e3          	beq	a5,a4,ffffffffc020b61c <strcmp>
ffffffffc020b62e:	0007851b          	sext.w	a0,a5
ffffffffc020b632:	9d19                	subw	a0,a0,a4
ffffffffc020b634:	8082                	ret
ffffffffc020b636:	4501                	li	a0,0
ffffffffc020b638:	bfed                	j	ffffffffc020b632 <strcmp+0x16>

ffffffffc020b63a <strncmp>:
ffffffffc020b63a:	c20d                	beqz	a2,ffffffffc020b65c <strncmp+0x22>
ffffffffc020b63c:	962e                	add	a2,a2,a1
ffffffffc020b63e:	a031                	j	ffffffffc020b64a <strncmp+0x10>
ffffffffc020b640:	0505                	addi	a0,a0,1
ffffffffc020b642:	00e79a63          	bne	a5,a4,ffffffffc020b656 <strncmp+0x1c>
ffffffffc020b646:	00b60b63          	beq	a2,a1,ffffffffc020b65c <strncmp+0x22>
ffffffffc020b64a:	00054783          	lbu	a5,0(a0)
ffffffffc020b64e:	0585                	addi	a1,a1,1
ffffffffc020b650:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b654:	f7f5                	bnez	a5,ffffffffc020b640 <strncmp+0x6>
ffffffffc020b656:	40e7853b          	subw	a0,a5,a4
ffffffffc020b65a:	8082                	ret
ffffffffc020b65c:	4501                	li	a0,0
ffffffffc020b65e:	8082                	ret

ffffffffc020b660 <strchr>:
ffffffffc020b660:	00054783          	lbu	a5,0(a0)
ffffffffc020b664:	c799                	beqz	a5,ffffffffc020b672 <strchr+0x12>
ffffffffc020b666:	00f58763          	beq	a1,a5,ffffffffc020b674 <strchr+0x14>
ffffffffc020b66a:	00154783          	lbu	a5,1(a0)
ffffffffc020b66e:	0505                	addi	a0,a0,1
ffffffffc020b670:	fbfd                	bnez	a5,ffffffffc020b666 <strchr+0x6>
ffffffffc020b672:	4501                	li	a0,0
ffffffffc020b674:	8082                	ret

ffffffffc020b676 <memset>:
ffffffffc020b676:	ca01                	beqz	a2,ffffffffc020b686 <memset+0x10>
ffffffffc020b678:	962a                	add	a2,a2,a0
ffffffffc020b67a:	87aa                	mv	a5,a0
ffffffffc020b67c:	0785                	addi	a5,a5,1
ffffffffc020b67e:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b682:	fec79de3          	bne	a5,a2,ffffffffc020b67c <memset+0x6>
ffffffffc020b686:	8082                	ret

ffffffffc020b688 <memmove>:
ffffffffc020b688:	02a5f263          	bgeu	a1,a0,ffffffffc020b6ac <memmove+0x24>
ffffffffc020b68c:	00c587b3          	add	a5,a1,a2
ffffffffc020b690:	00f57e63          	bgeu	a0,a5,ffffffffc020b6ac <memmove+0x24>
ffffffffc020b694:	00c50733          	add	a4,a0,a2
ffffffffc020b698:	c615                	beqz	a2,ffffffffc020b6c4 <memmove+0x3c>
ffffffffc020b69a:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b69e:	17fd                	addi	a5,a5,-1
ffffffffc020b6a0:	177d                	addi	a4,a4,-1
ffffffffc020b6a2:	00d70023          	sb	a3,0(a4)
ffffffffc020b6a6:	fef59ae3          	bne	a1,a5,ffffffffc020b69a <memmove+0x12>
ffffffffc020b6aa:	8082                	ret
ffffffffc020b6ac:	00c586b3          	add	a3,a1,a2
ffffffffc020b6b0:	87aa                	mv	a5,a0
ffffffffc020b6b2:	ca11                	beqz	a2,ffffffffc020b6c6 <memmove+0x3e>
ffffffffc020b6b4:	0005c703          	lbu	a4,0(a1)
ffffffffc020b6b8:	0585                	addi	a1,a1,1
ffffffffc020b6ba:	0785                	addi	a5,a5,1
ffffffffc020b6bc:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b6c0:	fed59ae3          	bne	a1,a3,ffffffffc020b6b4 <memmove+0x2c>
ffffffffc020b6c4:	8082                	ret
ffffffffc020b6c6:	8082                	ret

ffffffffc020b6c8 <memcpy>:
ffffffffc020b6c8:	ca19                	beqz	a2,ffffffffc020b6de <memcpy+0x16>
ffffffffc020b6ca:	962e                	add	a2,a2,a1
ffffffffc020b6cc:	87aa                	mv	a5,a0
ffffffffc020b6ce:	0005c703          	lbu	a4,0(a1)
ffffffffc020b6d2:	0585                	addi	a1,a1,1
ffffffffc020b6d4:	0785                	addi	a5,a5,1
ffffffffc020b6d6:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b6da:	fec59ae3          	bne	a1,a2,ffffffffc020b6ce <memcpy+0x6>
ffffffffc020b6de:	8082                	ret
