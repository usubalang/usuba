	.text
	.file	"add_16.c"
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
	.quad	4593671619917905920     # double 0.125
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
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	addl	$-5, %eax
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
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
	paddw	%xmm0, %xmm1
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
	subq	$528, %rsp              # imm = 0x210
	.cfi_def_cfa_offset 560
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
	movdqa	%xmm0, (%rsp)           # 16-byte Spill
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
	movdqa	%xmm0, 272(%rsp)        # 16-byte Spill
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
	movdqa	%xmm0, 512(%rsp)        # 16-byte Spill
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
	movdqa	112(%rsp), %xmm3        # 16-byte Reload
	movdqa	128(%rsp), %xmm6        # 16-byte Reload
	movdqa	224(%rsp), %xmm14       # 16-byte Reload
	movdqa	240(%rsp), %xmm12       # 16-byte Reload
	movdqa	144(%rsp), %xmm9        # 16-byte Reload
	movdqa	256(%rsp), %xmm10       # 16-byte Reload
	movdqa	(%rsp), %xmm11          # 16-byte Reload
	movdqa	16(%rsp), %xmm8         # 16-byte Reload
	movdqa	32(%rsp), %xmm15        # 16-byte Reload
	movd	%eax, %xmm5
	pinsrd	$1, %ebx, %xmm5
	pinsrd	$2, %ebp, %xmm5
	pinsrd	$3, %r14d, %xmm5
	movdqa	208(%rsp), %xmm2        # 16-byte Reload
	movdqa	%xmm2, %xmm1
	movdqa	272(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm1
	movdqa	%xmm1, 288(%rsp)        # 16-byte Spill
	pand	%xmm0, %xmm2
	movdqa	%xmm2, 208(%rsp)        # 16-byte Spill
	movl	$1000, %eax             # imm = 0x3E8
	movdqa	%xmm5, 304(%rsp)        # 16-byte Spill
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movdqa	%xmm3, 32(%rsp)         # 16-byte Spill
	movdqa	%xmm6, 16(%rsp)         # 16-byte Spill
	movdqa	%xmm14, (%rsp)          # 16-byte Spill
	movdqa	192(%rsp), %xmm13       # 16-byte Reload
	movdqa	%xmm12, %xmm14
	movdqa	48(%rsp), %xmm7         # 16-byte Reload
	movdqa	%xmm9, %xmm0
	movdqa	%xmm10, %xmm9
	movdqa	%xmm11, %xmm2
	movdqa	%xmm8, %xmm3
	movdqa	96(%rsp), %xmm6         # 16-byte Reload
	movdqa	%xmm15, %xmm8
	pand	80(%rsp), %xmm8         # 16-byte Folded Reload
	movdqa	%xmm6, %xmm4
	movdqa	512(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm4
	movdqa	%xmm8, %xmm5
	pxor	%xmm4, %xmm5
	movdqa	%xmm5, 96(%rsp)         # 16-byte Spill
	pand	%xmm1, %xmm6
	pand	%xmm8, %xmm4
	pxor	%xmm6, %xmm4
	movdqa	%xmm3, %xmm5
	movdqa	496(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm5
	movdqa	%xmm4, %xmm8
	pxor	%xmm5, %xmm8
	pand	%xmm1, %xmm3
	pand	%xmm4, %xmm5
	pxor	%xmm3, %xmm5
	movdqa	%xmm11, %xmm3
	movdqa	480(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm3
	movdqa	%xmm5, %xmm11
	pxor	%xmm3, %xmm11
	pand	%xmm1, %xmm2
	pand	%xmm5, %xmm3
	movdqa	304(%rsp), %xmm5        # 16-byte Reload
	pxor	%xmm2, %xmm3
	movdqa	%xmm10, %xmm2
	movdqa	464(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm2
	movdqa	%xmm3, %xmm10
	pxor	%xmm2, %xmm10
	pand	%xmm1, %xmm9
	pand	%xmm3, %xmm2
	pxor	%xmm9, %xmm2
	movdqa	%xmm0, %xmm1
	movdqa	448(%rsp), %xmm3        # 16-byte Reload
	pxor	%xmm3, %xmm1
	movdqa	%xmm2, %xmm9
	pxor	%xmm1, %xmm9
	pand	%xmm3, %xmm0
	pand	%xmm2, %xmm1
	pxor	%xmm0, %xmm1
	movdqa	%xmm7, %xmm0
	movdqa	432(%rsp), %xmm3        # 16-byte Reload
	pxor	%xmm3, %xmm0
	movdqa	%xmm1, %xmm2
	pxor	%xmm0, %xmm2
	movdqa	%xmm2, 48(%rsp)         # 16-byte Spill
	pand	%xmm3, %xmm7
	pand	%xmm1, %xmm0
	pxor	%xmm7, %xmm0
	movdqa	%xmm12, %xmm1
	movdqa	416(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm1
	movdqa	%xmm0, %xmm12
	pxor	%xmm1, %xmm12
	pand	%xmm2, %xmm14
	pand	%xmm0, %xmm1
	pxor	%xmm14, %xmm1
	movdqa	%xmm1, %xmm0
	movdqa	288(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm0
	pand	%xmm2, %xmm1
	pxor	208(%rsp), %xmm1        # 16-byte Folded Reload
	movdqa	%xmm0, %xmm2
	movdqa	400(%rsp), %xmm3        # 16-byte Reload
	pxor	%xmm3, %xmm2
	pand	%xmm1, %xmm2
	pand	%xmm3, %xmm0
	pxor	%xmm2, %xmm0
	movdqa	%xmm13, %xmm1
	movdqa	384(%rsp), %xmm3        # 16-byte Reload
	pxor	%xmm3, %xmm1
	movdqa	%xmm0, %xmm2
	pxor	%xmm1, %xmm2
	movdqa	%xmm2, 192(%rsp)        # 16-byte Spill
	pand	%xmm3, %xmm13
	pand	%xmm0, %xmm1
	pxor	%xmm13, %xmm1
	movdqa	(%rsp), %xmm3           # 16-byte Reload
	movdqa	%xmm3, %xmm0
	movdqa	368(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm0
	movdqa	%xmm1, %xmm14
	pxor	%xmm0, %xmm14
	pand	%xmm2, %xmm3
	pand	%xmm1, %xmm0
	pxor	%xmm3, %xmm0
	movdqa	16(%rsp), %xmm3         # 16-byte Reload
	movdqa	%xmm3, %xmm1
	movdqa	352(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm1
	movdqa	%xmm0, %xmm6
	pxor	%xmm1, %xmm6
	pand	%xmm2, %xmm3
	pand	%xmm0, %xmm1
	pxor	%xmm3, %xmm1
	movdqa	32(%rsp), %xmm4         # 16-byte Reload
	movdqa	%xmm4, %xmm0
	movdqa	336(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm0
	movdqa	%xmm1, %xmm3
	pxor	%xmm0, %xmm3
	pand	%xmm1, %xmm0
	movdqa	176(%rsp), %xmm1        # 16-byte Reload
	pand	%xmm2, %xmm4
	pxor	%xmm4, %xmm0
	movdqa	%xmm1, %xmm2
	movdqa	320(%rsp), %xmm4        # 16-byte Reload
	pxor	%xmm4, %xmm2
	pand	%xmm4, %xmm1
	movdqa	160(%rsp), %xmm4        # 16-byte Reload
	pxor	%xmm5, %xmm4
	pxor	%xmm1, %xmm4
	movdqa	%xmm0, %xmm1
	pxor	%xmm2, %xmm1
	movdqa	%xmm1, 176(%rsp)        # 16-byte Spill
	pand	%xmm0, %xmm2
	pxor	%xmm2, %xmm4
	movdqa	%xmm4, 160(%rsp)        # 16-byte Spill
	pxor	80(%rsp), %xmm15        # 16-byte Folded Reload
	addl	$-1, %eax
	jne	.LBB1_1
# %bb.2:
	rdtscp
	movq	%rdx, %rsi
	movl	%ecx, 76(%rsp)
	shlq	$32, %rsi
	orq	%rax, %rsi
	movl	$100000000, %eax        # imm = 0x5F5E100
	movdqa	96(%rsp), %xmm2         # 16-byte Reload
	movdqa	%xmm8, 16(%rsp)         # 16-byte Spill
	movdqa	%xmm11, (%rsp)          # 16-byte Spill
	movdqa	%xmm9, 144(%rsp)        # 16-byte Spill
	movdqa	48(%rsp), %xmm9         # 16-byte Reload
	movdqa	%xmm6, 128(%rsp)        # 16-byte Spill
	movdqa	160(%rsp), %xmm8        # 16-byte Reload
	movdqa	176(%rsp), %xmm13       # 16-byte Reload
	movdqa	192(%rsp), %xmm6        # 16-byte Reload
	movdqa	%xmm3, 112(%rsp)        # 16-byte Spill
	.p2align	4, 0x90
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	movdqa	%xmm6, 48(%rsp)         # 16-byte Spill
	movdqa	%xmm12, %xmm11
	movdqa	%xmm9, %xmm3
	movdqa	144(%rsp), %xmm9        # 16-byte Reload
	movdqa	%xmm10, %xmm1
	movdqa	(%rsp), %xmm5           # 16-byte Reload
	movdqa	16(%rsp), %xmm6         # 16-byte Reload
	movdqa	%xmm2, %xmm7
	movdqa	%xmm15, 32(%rsp)        # 16-byte Spill
	movdqa	%xmm15, %xmm2
	pand	80(%rsp), %xmm2         # 16-byte Folded Reload
	movdqa	%xmm7, %xmm4
	movdqa	512(%rsp), %xmm15       # 16-byte Reload
	pxor	%xmm15, %xmm4
	movdqa	%xmm2, %xmm0
	pxor	%xmm4, %xmm0
	movdqa	%xmm0, 96(%rsp)         # 16-byte Spill
	pand	%xmm15, %xmm7
	pand	%xmm2, %xmm4
	pxor	%xmm7, %xmm4
	movdqa	%xmm6, %xmm2
	movdqa	496(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm2
	movdqa	%xmm4, %xmm7
	pxor	%xmm2, %xmm7
	movdqa	%xmm7, 16(%rsp)         # 16-byte Spill
	pand	%xmm0, %xmm6
	pand	%xmm4, %xmm2
	pxor	%xmm6, %xmm2
	movdqa	%xmm5, %xmm4
	movdqa	480(%rsp), %xmm6        # 16-byte Reload
	pxor	%xmm6, %xmm4
	movdqa	%xmm2, %xmm0
	pxor	%xmm4, %xmm0
	movdqa	%xmm0, (%rsp)           # 16-byte Spill
	pand	%xmm6, %xmm5
	pand	%xmm2, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm10, %xmm2
	movdqa	464(%rsp), %xmm6        # 16-byte Reload
	pxor	%xmm6, %xmm2
	movdqa	%xmm4, %xmm10
	pxor	%xmm2, %xmm10
	pand	%xmm6, %xmm1
	pand	%xmm4, %xmm2
	pxor	%xmm1, %xmm2
	movdqa	%xmm9, %xmm1
	movdqa	448(%rsp), %xmm4        # 16-byte Reload
	pxor	%xmm4, %xmm1
	movdqa	%xmm2, %xmm0
	pxor	%xmm1, %xmm0
	movdqa	%xmm0, 144(%rsp)        # 16-byte Spill
	pand	%xmm4, %xmm9
	pand	%xmm2, %xmm1
	pxor	%xmm9, %xmm1
	movdqa	%xmm3, %xmm0
	movdqa	432(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm0
	movdqa	%xmm1, %xmm9
	pxor	%xmm0, %xmm9
	pand	%xmm2, %xmm3
	pand	%xmm1, %xmm0
	pxor	%xmm3, %xmm0
	movdqa	%xmm12, %xmm3
	movdqa	416(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm3
	movdqa	%xmm0, %xmm12
	pxor	%xmm3, %xmm12
	pand	%xmm1, %xmm11
	pand	%xmm0, %xmm3
	pxor	%xmm11, %xmm3
	movdqa	%xmm3, %xmm0
	movdqa	288(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm0
	pand	%xmm1, %xmm3
	pxor	208(%rsp), %xmm3        # 16-byte Folded Reload
	movdqa	%xmm0, %xmm7
	movdqa	400(%rsp), %xmm1        # 16-byte Reload
	pxor	%xmm1, %xmm7
	pand	%xmm1, %xmm0
	movdqa	%xmm3, %xmm1
	pand	%xmm7, %xmm1
	pxor	%xmm0, %xmm1
	movdqa	48(%rsp), %xmm4         # 16-byte Reload
	movdqa	%xmm4, %xmm0
	movdqa	384(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm0
	movdqa	%xmm1, %xmm6
	pxor	%xmm0, %xmm6
	pand	%xmm1, %xmm0
	movdqa	%xmm14, %xmm1
	pand	%xmm2, %xmm4
	pxor	%xmm4, %xmm0
	movdqa	%xmm14, %xmm4
	movdqa	368(%rsp), %xmm5        # 16-byte Reload
	pxor	%xmm5, %xmm4
	movdqa	%xmm0, %xmm14
	pxor	%xmm4, %xmm14
	pand	%xmm0, %xmm4
	movdqa	128(%rsp), %xmm0        # 16-byte Reload
	pand	%xmm5, %xmm1
	pxor	%xmm1, %xmm4
	movdqa	%xmm0, %xmm1
	movdqa	352(%rsp), %xmm5        # 16-byte Reload
	pxor	%xmm5, %xmm1
	movdqa	%xmm4, %xmm2
	pxor	%xmm1, %xmm2
	movdqa	%xmm2, 128(%rsp)        # 16-byte Spill
	pand	%xmm4, %xmm1
	movdqa	112(%rsp), %xmm2        # 16-byte Reload
	pand	%xmm5, %xmm0
	pxor	%xmm0, %xmm1
	movdqa	%xmm2, %xmm0
	movdqa	336(%rsp), %xmm5        # 16-byte Reload
	pxor	%xmm5, %xmm0
	movdqa	%xmm1, %xmm4
	pxor	%xmm0, %xmm4
	movdqa	%xmm4, 112(%rsp)        # 16-byte Spill
	pand	%xmm1, %xmm0
	movdqa	%xmm13, %xmm1
	pand	%xmm5, %xmm2
	pxor	%xmm2, %xmm0
	movdqa	%xmm13, %xmm2
	movdqa	320(%rsp), %xmm5        # 16-byte Reload
	pxor	%xmm5, %xmm2
	pand	%xmm5, %xmm1
	pxor	304(%rsp), %xmm8        # 16-byte Folded Reload
	pxor	%xmm1, %xmm8
	movdqa	%xmm0, %xmm13
	pxor	%xmm2, %xmm13
	pand	%xmm0, %xmm2
	pxor	%xmm2, %xmm8
	movdqa	96(%rsp), %xmm2         # 16-byte Reload
	movdqa	32(%rsp), %xmm0         # 16-byte Reload
	pxor	80(%rsp), %xmm0         # 16-byte Folded Reload
	movdqa	%xmm0, %xmm15
	addl	$-1, %eax
	jne	.LBB1_3
# %bb.4:
	pxor	%xmm3, %xmm7
	movdqa	%xmm7, 80(%rsp)         # 16-byte Spill
	rdtscp
	shlq	$32, %rdx
	orq	%rax, %rdx
	subq	%rsi, %rdx
	movq	%rdx, %xmm0
	punpckldq	.LCPI1_0(%rip), %xmm0 # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
	subpd	.LCPI1_1(%rip), %xmm0
	movl	%ecx, 76(%rsp)
	haddpd	%xmm0, %xmm0
	divsd	.LCPI1_2(%rip), %xmm0
	mulsd	.LCPI1_3(%rip), %xmm0
	movl	$.L.str.1, %edi
	movb	$1, %al
	movdqa	%xmm15, 32(%rsp)        # 16-byte Spill
	movdqa	%xmm10, 256(%rsp)       # 16-byte Spill
	movdqa	%xmm9, 48(%rsp)         # 16-byte Spill
	movdqa	%xmm12, 240(%rsp)       # 16-byte Spill
	movdqa	%xmm8, 160(%rsp)        # 16-byte Spill
	movdqa	%xmm13, 176(%rsp)       # 16-byte Spill
	movdqa	%xmm14, 224(%rsp)       # 16-byte Spill
	movdqa	%xmm6, 192(%rsp)        # 16-byte Spill
	callq	printf
	movaps	272(%rsp), %xmm0        # 16-byte Reload
	movaps	128(%rsp), %xmm1        # 16-byte Reload
	movaps	112(%rsp), %xmm2        # 16-byte Reload
	movaps	16(%rsp), %xmm3         # 16-byte Reload
	movaps	(%rsp), %xmm4           # 16-byte Reload
	movaps	144(%rsp), %xmm5        # 16-byte Reload
	movaps	32(%rsp), %xmm6         # 16-byte Reload
	movaps	96(%rsp), %xmm7         # 16-byte Reload
	movaps	256(%rsp), %xmm8        # 16-byte Reload
	movaps	48(%rsp), %xmm9         # 16-byte Reload
	movaps	240(%rsp), %xmm10       # 16-byte Reload
	movaps	160(%rsp), %xmm11       # 16-byte Reload
	movaps	176(%rsp), %xmm12       # 16-byte Reload
	movaps	224(%rsp), %xmm13       # 16-byte Reload
	movaps	192(%rsp), %xmm14       # 16-byte Reload
	movaps	80(%rsp), %xmm15        # 16-byte Reload
	#APP
	#NO_APP
	addq	$528, %rsp              # imm = 0x210
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
	.asciz	"16-bit packed add:   %.2f\n"
	.size	.L.str, 27

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"16-bit bitslice add: %.2f\n"
	.size	.L.str.1, 27


	.ident	"clang version 7.0.0-svn345401-1~exp1~20181026173340.32 (branches/release_70)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
