	.text
	.file	"add_32.c"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function speed_packed
.LCPI0_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI0_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI0_2:
	.quad	4741671816366391296     # double 1.0E+9
.LCPI0_3:
	.quad	4598175219545276416     # double 0.25
	.text
	.globl	speed_packed
	.p2align	4, 0x90
	.type	speed_packed,@function
speed_packed:                           # @speed_packed
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 16(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movdqa	16(%rsp), %xmm1         # 16-byte Reload
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movl	$1000, %eax             # imm = 0x3E8
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	addl	$-10, %eax
	jne	.LBB0_1
# %bb.2:
	rdtscp
	movq	%rdx, %rsi
	movl	%ecx, 12(%rsp)
	shlq	$32, %rsi
	orq	%rax, %rsi
	movl	$1000000000, %eax       # imm = 0x3B9ACA00
	.p2align	4, 0x90
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	paddd	%xmm0, %xmm1
	addl	$-10, %eax
	jne	.LBB0_3
# %bb.4:
	rdtscp
	shlq	$32, %rdx
	orq	%rax, %rdx
	subq	%rsi, %rdx
	movq	%rdx, %xmm0
	punpckldq	.LCPI0_0(%rip), %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI0_1(%rip), %xmm0
	movl	%ecx, 12(%rsp)
	haddpd	%xmm0, %xmm0
	divsd	.LCPI0_2(%rip), %xmm0
	mulsd	.LCPI0_3(%rip), %xmm0
	movl	$.L.str, %edi
	movb	$1, %al
	movdqa	%xmm1, 16(%rsp)         # 16-byte Spill
	callq	printf
	movaps	16(%rsp), %xmm0         # 16-byte Reload
	#APP
	#NO_APP
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	speed_packed, .Lfunc_end0-speed_packed
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function speed_bitslice
.LCPI1_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI1_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI1_2:
	.quad	4726483295884279808     # double 1.0E+8
.LCPI1_3:
	.quad	4575657221408423936     # double 0.0078125
	.text
	.globl	speed_bitslice
	.p2align	4, 0x90
	.type	speed_bitslice,@function
speed_bitslice:                         # @speed_bitslice
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$1056, %rsp             # imm = 0x420
	.cfi_def_cfa_offset 1088
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 48(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 496(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 480(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 464(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 448(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 432(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 416(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 96(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 544(%rsp)        # 16-byte Spill
	callq	rand
	callq	rand
	callq	rand
	callq	rand
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 400(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 80(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 32(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 368(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 16(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 64(%rsp)         # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 352(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 336(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 320(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 304(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 288(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 272(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 256(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 240(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 224(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 208(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 192(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 176(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 160(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 144(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 112(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 128(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 528(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 1040(%rsp)       # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 1024(%rsp)       # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 1008(%rsp)       # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 992(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 976(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 960(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 944(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 384(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 928(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 912(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 896(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 880(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 864(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 848(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 832(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 816(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 800(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 784(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 768(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 752(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 736(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 720(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 704(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 688(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 672(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 656(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 640(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 624(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 608(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movdqa	%xmm0, 592(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movaps	528(%rsp), %xmm0        # 16-byte Reload
	movaps	16(%rsp), %xmm15        # 16-byte Reload
	movaps	32(%rsp), %xmm5         # 16-byte Reload
	movaps	400(%rsp), %xmm14       # 16-byte Reload
	movaps	416(%rsp), %xmm12       # 16-byte Reload
	movaps	432(%rsp), %xmm11       # 16-byte Reload
	movaps	448(%rsp), %xmm10       # 16-byte Reload
	movaps	464(%rsp), %xmm9        # 16-byte Reload
	movaps	480(%rsp), %xmm13       # 16-byte Reload
	movaps	496(%rsp), %xmm7        # 16-byte Reload
	movaps	48(%rsp), %xmm3         # 16-byte Reload
	movd	%eax, %xmm1
	pinsrd	$1, %ebx, %xmm1
	pinsrd	$2, %ebp, %xmm1
	pinsrd	$3, %r14d, %xmm1
	movdqa	%xmm1, 576(%rsp)        # 16-byte Spill
	movaps	384(%rsp), %xmm4        # 16-byte Reload
	movaps	%xmm4, %xmm1
	movaps	544(%rsp), %xmm2        # 16-byte Reload
	xorps	%xmm2, %xmm1
	movaps	%xmm1, 560(%rsp)        # 16-byte Spill
	andps	%xmm2, %xmm4
	movaps	%xmm4, 384(%rsp)        # 16-byte Spill
	movl	$1000, %eax             # imm = 0x3E8
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movaps	%xmm7, %xmm2
	movaps	%xmm3, 48(%rsp)         # 16-byte Spill
	andps	%xmm0, %xmm3
	movaps	%xmm7, %xmm4
	movaps	1040(%rsp), %xmm0       # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm7
	xorps	%xmm4, %xmm7
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm13, %xmm2
	movaps	%xmm13, %xmm3
	movaps	1024(%rsp), %xmm0       # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm13
	xorps	%xmm3, %xmm13
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	%xmm9, %xmm2
	movaps	%xmm9, %xmm4
	movaps	1008(%rsp), %xmm0       # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm9
	xorps	%xmm4, %xmm9
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm10, %xmm2
	movaps	%xmm10, %xmm3
	movaps	992(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm10
	xorps	%xmm3, %xmm10
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	%xmm11, %xmm2
	movaps	%xmm11, %xmm4
	movaps	976(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm11
	xorps	%xmm4, %xmm11
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm12, %xmm2
	movaps	%xmm12, %xmm3
	movaps	960(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm12
	xorps	%xmm3, %xmm12
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	96(%rsp), %xmm2         # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	944(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm1
	xorps	%xmm4, %xmm1
	movaps	%xmm1, 96(%rsp)         # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm4, %xmm2
	movaps	560(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm2
	andps	%xmm0, %xmm4
	xorps	384(%rsp), %xmm4        # 16-byte Folded Reload
	movaps	%xmm2, %xmm3
	movaps	928(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm3, %xmm2
	movaps	%xmm14, %xmm3
	movaps	%xmm14, %xmm6
	movaps	912(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm6
	movaps	%xmm2, %xmm14
	xorps	%xmm6, %xmm14
	andps	%xmm2, %xmm6
	andps	%xmm0, %xmm3
	xorps	%xmm3, %xmm6
	movaps	80(%rsp), %xmm2         # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	896(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm6, %xmm4
	xorps	%xmm3, %xmm4
	movaps	%xmm4, 80(%rsp)         # 16-byte Spill
	andps	%xmm6, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	%xmm5, %xmm4
	movaps	%xmm5, %xmm2
	movaps	880(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm2
	movaps	%xmm3, %xmm5
	xorps	%xmm2, %xmm5
	andps	%xmm3, %xmm2
	andps	%xmm0, %xmm4
	xorps	%xmm4, %xmm2
	movaps	368(%rsp), %xmm8        # 16-byte Reload
	movaps	%xmm8, %xmm3
	movaps	864(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm2, %xmm4
	xorps	%xmm3, %xmm4
	movaps	%xmm4, 368(%rsp)        # 16-byte Spill
	andps	%xmm2, %xmm3
	andps	%xmm0, %xmm8
	xorps	%xmm8, %xmm3
	movaps	%xmm15, %xmm2
	movaps	%xmm15, %xmm4
	movaps	848(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm15
	xorps	%xmm4, %xmm15
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	64(%rsp), %xmm3         # 16-byte Reload
	movaps	%xmm3, %xmm2
	movaps	832(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm2
	movaps	%xmm4, %xmm0
	xorps	%xmm2, %xmm0
	movaps	%xmm0, 64(%rsp)         # 16-byte Spill
	andps	%xmm4, %xmm2
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm2
	movaps	352(%rsp), %xmm0        # 16-byte Reload
	movaps	%xmm0, %xmm4
	movaps	816(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm2, %xmm3
	xorps	%xmm4, %xmm3
	movaps	%xmm3, 352(%rsp)        # 16-byte Spill
	andps	%xmm2, %xmm4
	andps	%xmm1, %xmm0
	xorps	%xmm0, %xmm4
	movaps	336(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	800(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 336(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	320(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	784(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 320(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm4
	movaps	304(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	768(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 304(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	288(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	752(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 288(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm4
	movaps	272(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	736(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 272(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	256(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	720(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 256(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm4
	movaps	240(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	704(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 240(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	224(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	688(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 224(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm4
	movaps	208(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	672(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 208(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	192(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	656(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 192(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm4
	movaps	176(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	640(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 176(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	160(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	624(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 160(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm4
	movaps	144(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm3
	movaps	608(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm3
	movaps	%xmm4, %xmm0
	xorps	%xmm3, %xmm0
	movaps	%xmm0, 144(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm1, %xmm2
	xorps	%xmm2, %xmm3
	movaps	112(%rsp), %xmm2        # 16-byte Reload
	movaps	%xmm2, %xmm4
	movaps	592(%rsp), %xmm1        # 16-byte Reload
	andps	%xmm1, %xmm2
	movaps	128(%rsp), %xmm0        # 16-byte Reload
	xorps	576(%rsp), %xmm0        # 16-byte Folded Reload
	xorps	%xmm2, %xmm0
	xorps	%xmm1, %xmm4
	movaps	%xmm3, %xmm2
	xorps	%xmm4, %xmm2
	movaps	%xmm2, 112(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 128(%rsp)        # 16-byte Spill
	movaps	528(%rsp), %xmm0        # 16-byte Reload
	movaps	48(%rsp), %xmm1         # 16-byte Reload
	xorps	%xmm0, %xmm1
	movaps	%xmm1, %xmm3
	addl	$-1, %eax
	jne	.LBB1_1
# %bb.2:
	rdtscp
	movq	%rdx, %rsi
	movl	%ecx, 12(%rsp)
	shlq	$32, %rsi
	orq	%rax, %rsi
	movl	$100000000, %eax        # imm = 0x5F5E100
	movaps	%xmm5, 32(%rsp)         # 16-byte Spill
	movaps	%xmm15, 16(%rsp)        # 16-byte Spill
	movaps	64(%rsp), %xmm6         # 16-byte Reload
	movaps	864(%rsp), %xmm15       # 16-byte Reload
	.p2align	4, 0x90
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	movaps	%xmm7, %xmm2
	movaps	%xmm3, %xmm8
	andps	%xmm0, %xmm3
	movaps	%xmm7, %xmm4
	movaps	1040(%rsp), %xmm0       # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm7
	xorps	%xmm4, %xmm7
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm13, %xmm2
	movaps	%xmm13, %xmm3
	movaps	1024(%rsp), %xmm0       # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm13
	xorps	%xmm3, %xmm13
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	%xmm9, %xmm2
	movaps	%xmm9, %xmm4
	movaps	1008(%rsp), %xmm0       # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm9
	xorps	%xmm4, %xmm9
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm10, %xmm2
	movaps	%xmm10, %xmm3
	movaps	992(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm10
	xorps	%xmm3, %xmm10
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	%xmm11, %xmm2
	movaps	%xmm11, %xmm4
	movaps	976(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm11
	xorps	%xmm4, %xmm11
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm4
	movaps	%xmm12, %xmm2
	movaps	%xmm12, %xmm3
	movaps	960(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm12
	xorps	%xmm3, %xmm12
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm2
	xorps	%xmm2, %xmm3
	movaps	96(%rsp), %xmm4         # 16-byte Reload
	movaps	%xmm4, %xmm2
	movaps	944(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm2
	movaps	%xmm3, %xmm1
	xorps	%xmm2, %xmm1
	movaps	%xmm1, 96(%rsp)         # 16-byte Spill
	andps	%xmm3, %xmm2
	andps	%xmm0, %xmm4
	xorps	%xmm4, %xmm2
	movaps	%xmm2, %xmm3
	movaps	560(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	andps	%xmm0, %xmm2
	xorps	384(%rsp), %xmm2        # 16-byte Folded Reload
	movaps	%xmm3, %xmm1
	movaps	928(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm1
	andps	%xmm0, %xmm3
	movaps	%xmm2, %xmm4
	movaps	%xmm1, 512(%rsp)        # 16-byte Spill
	andps	%xmm1, %xmm4
	xorps	%xmm3, %xmm4
	movaps	%xmm14, %xmm5
	movaps	%xmm14, %xmm3
	movaps	912(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm14
	xorps	%xmm3, %xmm14
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm5
	xorps	%xmm5, %xmm3
	movaps	80(%rsp), %xmm1         # 16-byte Reload
	movaps	%xmm1, %xmm4
	movaps	896(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm3, %xmm5
	xorps	%xmm4, %xmm5
	movaps	%xmm5, 80(%rsp)         # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm0, %xmm1
	xorps	%xmm1, %xmm4
	movaps	32(%rsp), %xmm5         # 16-byte Reload
	movaps	%xmm5, %xmm3
	movaps	880(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm3
	movaps	%xmm4, %xmm1
	xorps	%xmm3, %xmm1
	movaps	%xmm1, 32(%rsp)         # 16-byte Spill
	andps	%xmm4, %xmm3
	andps	%xmm0, %xmm5
	xorps	%xmm5, %xmm3
	movaps	368(%rsp), %xmm0        # 16-byte Reload
	movaps	%xmm0, %xmm4
	xorps	%xmm15, %xmm4
	movaps	%xmm3, %xmm5
	xorps	%xmm4, %xmm5
	movaps	%xmm5, 368(%rsp)        # 16-byte Spill
	andps	%xmm3, %xmm4
	andps	%xmm15, %xmm0
	xorps	%xmm0, %xmm4
	movaps	16(%rsp), %xmm3         # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	848(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm5
	movaps	%xmm4, %xmm1
	xorps	%xmm5, %xmm1
	movaps	%xmm1, 16(%rsp)         # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm0, %xmm3
	xorps	%xmm3, %xmm5
	movaps	%xmm6, %xmm3
	movaps	%xmm6, %xmm4
	movaps	832(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm4
	movaps	%xmm5, %xmm6
	xorps	%xmm4, %xmm6
	andps	%xmm5, %xmm4
	andps	%xmm0, %xmm3
	xorps	%xmm3, %xmm4
	movaps	352(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	816(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 352(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	336(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	800(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 336(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	320(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	784(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 320(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	304(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	768(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 304(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	288(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	752(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 288(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	272(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	736(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 272(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	256(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	720(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 256(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	240(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	704(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 240(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	224(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	688(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 224(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	208(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	672(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 208(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	192(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	656(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 192(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	176(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	640(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 176(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	160(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	624(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm0
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 160(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm5
	movaps	144(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm4
	movaps	608(%rsp), %xmm1        # 16-byte Reload
	xorps	%xmm1, %xmm4
	movaps	%xmm5, %xmm0
	xorps	%xmm4, %xmm0
	movaps	%xmm0, 144(%rsp)        # 16-byte Spill
	andps	%xmm5, %xmm4
	andps	%xmm1, %xmm3
	xorps	%xmm3, %xmm4
	movaps	112(%rsp), %xmm3        # 16-byte Reload
	movaps	%xmm3, %xmm5
	movaps	592(%rsp), %xmm1        # 16-byte Reload
	andps	%xmm1, %xmm3
	movaps	128(%rsp), %xmm0        # 16-byte Reload
	xorps	576(%rsp), %xmm0        # 16-byte Folded Reload
	xorps	%xmm3, %xmm0
	xorps	%xmm1, %xmm5
	movaps	%xmm4, %xmm3
	xorps	%xmm5, %xmm3
	movaps	%xmm3, 112(%rsp)        # 16-byte Spill
	andps	%xmm4, %xmm5
	xorps	%xmm5, %xmm0
	movaps	%xmm0, 128(%rsp)        # 16-byte Spill
	movaps	528(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm0, %xmm8
	movaps	%xmm8, %xmm3
	addl	$-1, %eax
	jne	.LBB1_3
# %bb.4:
	movaps	512(%rsp), %xmm0        # 16-byte Reload
	xorps	%xmm2, %xmm0
	movaps	%xmm0, 512(%rsp)        # 16-byte Spill
	rdtscp
	shlq	$32, %rdx
	orq	%rax, %rdx
	subq	%rsi, %rdx
	movq	%rdx, %xmm0
	punpckldq	.LCPI1_0(%rip), %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI1_1(%rip), %xmm0
	movl	%ecx, 12(%rsp)
	haddpd	%xmm0, %xmm0
	divsd	.LCPI1_2(%rip), %xmm0
	mulsd	.LCPI1_3(%rip), %xmm0
	movl	$.L.str.1, %edi
	movb	$1, %al
	movaps	%xmm3, 48(%rsp)         # 16-byte Spill
	movaps	%xmm7, 496(%rsp)        # 16-byte Spill
	movaps	%xmm13, 480(%rsp)       # 16-byte Spill
	movaps	%xmm9, 464(%rsp)        # 16-byte Spill
	movaps	%xmm10, 448(%rsp)       # 16-byte Spill
	movaps	%xmm11, 432(%rsp)       # 16-byte Spill
	movaps	%xmm12, 416(%rsp)       # 16-byte Spill
	movaps	%xmm14, 400(%rsp)       # 16-byte Spill
	movaps	%xmm6, 64(%rsp)         # 16-byte Spill
	callq	printf
	movaps	96(%rsp), %xmm0         # 16-byte Reload
	movaps	48(%rsp), %xmm1         # 16-byte Reload
	movaps	496(%rsp), %xmm2        # 16-byte Reload
	movaps	480(%rsp), %xmm3        # 16-byte Reload
	movaps	464(%rsp), %xmm4        # 16-byte Reload
	movaps	448(%rsp), %xmm5        # 16-byte Reload
	movaps	432(%rsp), %xmm6        # 16-byte Reload
	movaps	416(%rsp), %xmm7        # 16-byte Reload
	#APP
	#NO_APP
	movaps	544(%rsp), %xmm0        # 16-byte Reload
	movaps	368(%rsp), %xmm1        # 16-byte Reload
	movaps	80(%rsp), %xmm2         # 16-byte Reload
	movaps	32(%rsp), %xmm3         # 16-byte Reload
	movaps	16(%rsp), %xmm4         # 16-byte Reload
	movaps	512(%rsp), %xmm5        # 16-byte Reload
	movaps	400(%rsp), %xmm6        # 16-byte Reload
	movaps	64(%rsp), %xmm7         # 16-byte Reload
	#APP
	#NO_APP
	movaps	352(%rsp), %xmm0        # 16-byte Reload
	movaps	336(%rsp), %xmm1        # 16-byte Reload
	movaps	320(%rsp), %xmm2        # 16-byte Reload
	movaps	304(%rsp), %xmm3        # 16-byte Reload
	movaps	288(%rsp), %xmm4        # 16-byte Reload
	movaps	272(%rsp), %xmm5        # 16-byte Reload
	movaps	256(%rsp), %xmm6        # 16-byte Reload
	movaps	240(%rsp), %xmm7        # 16-byte Reload
	#APP
	#NO_APP
	movaps	224(%rsp), %xmm0        # 16-byte Reload
	movaps	208(%rsp), %xmm1        # 16-byte Reload
	movaps	192(%rsp), %xmm2        # 16-byte Reload
	movaps	176(%rsp), %xmm3        # 16-byte Reload
	movaps	160(%rsp), %xmm4        # 16-byte Reload
	movaps	144(%rsp), %xmm5        # 16-byte Reload
	movaps	128(%rsp), %xmm6        # 16-byte Reload
	movaps	112(%rsp), %xmm7        # 16-byte Reload
	#APP
	#NO_APP
	addq	$1056, %rsp             # imm = 0x420
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	speed_bitslice, .Lfunc_end1-speed_bitslice
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	speed_bitslice
	callq	speed_packed
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"32-bit packed add:   %.2f\n"
	.size	.L.str, 27

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"32-bit bitslice add: %.2f\n"
	.size	.L.str.1, 27


	.ident	"clang version 7.0.0-svn345401-1~exp1~20181026173340.32 (branches/release_70)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
