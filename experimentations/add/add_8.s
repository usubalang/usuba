	.text
	.file	"add_8.c"
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
	.quad	4589168020290535424     # double 0.0625
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
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
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
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
	paddb	%xmm0, %xmm1
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
	subq	$256, %rsp              # imm = 0x100
	.cfi_def_cfa_offset 288
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
	movdqa	%xmm0, 176(%rsp)        # 16-byte Spill
	callq	rand
	movl	%eax, %r14d
	callq	rand
	movl	%eax, %ebp
	callq	rand
	movl	%eax, %ebx
	callq	rand
	movdqa	224(%rsp), %xmm14       # 16-byte Reload
	movdqa	240(%rsp), %xmm13       # 16-byte Reload
	movdqa	48(%rsp), %xmm4         # 16-byte Reload
	movdqa	64(%rsp), %xmm5         # 16-byte Reload
	movdqa	32(%rsp), %xmm11        # 16-byte Reload
	movdqa	16(%rsp), %xmm10        # 16-byte Reload
	movdqa	80(%rsp), %xmm7         # 16-byte Reload
	movdqa	96(%rsp), %xmm6         # 16-byte Reload
	movdqa	112(%rsp), %xmm9        # 16-byte Reload
	movdqa	128(%rsp), %xmm8        # 16-byte Reload
	movd	%eax, %xmm0
	pinsrd	$1, %ebx, %xmm0
	pinsrd	$2, %ebp, %xmm0
	pinsrd	$3, %r14d, %xmm0
	movl	$1000, %eax             # imm = 0x3E8
	movdqa	208(%rsp), %xmm12       # 16-byte Reload
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movdqa	%xmm4, %xmm1
	movdqa	%xmm5, %xmm2
	movdqa	%xmm7, %xmm3
	movdqa	%xmm6, %xmm4
	movdqa	%xmm9, %xmm5
	movdqa	%xmm8, %xmm6
	pand	%xmm13, %xmm6
	movdqa	%xmm9, %xmm7
	movdqa	%xmm0, %xmm15
	movdqa	192(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm7
	movdqa	%xmm6, %xmm9
	pxor	%xmm7, %xmm9
	pand	%xmm0, %xmm5
	pand	%xmm6, %xmm7
	pxor	%xmm5, %xmm7
	movdqa	%xmm4, %xmm5
	pxor	%xmm14, %xmm5
	movdqa	%xmm7, %xmm6
	pxor	%xmm5, %xmm6
	pand	%xmm14, %xmm4
	pand	%xmm7, %xmm5
	pxor	%xmm4, %xmm5
	movdqa	%xmm3, %xmm4
	movdqa	160(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm4
	movdqa	%xmm5, %xmm7
	pxor	%xmm4, %xmm7
	pand	%xmm0, %xmm3
	pand	%xmm5, %xmm4
	pxor	%xmm3, %xmm4
	movdqa	%xmm2, %xmm3
	pxor	%xmm12, %xmm3
	movdqa	%xmm4, %xmm5
	pxor	%xmm3, %xmm5
	pand	%xmm12, %xmm2
	pand	%xmm4, %xmm3
	pxor	%xmm2, %xmm3
	movdqa	%xmm1, %xmm2
	movdqa	144(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm2
	movdqa	%xmm3, %xmm4
	pxor	%xmm2, %xmm4
	pand	%xmm3, %xmm2
	movdqa	%xmm11, %xmm3
	pand	%xmm0, %xmm1
	pxor	%xmm1, %xmm2
	movdqa	%xmm11, %xmm1
	movdqa	176(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm1
	pand	%xmm0, %xmm3
	movdqa	%xmm15, %xmm0
	pxor	%xmm15, %xmm10
	pxor	%xmm3, %xmm10
	movdqa	%xmm2, %xmm11
	pxor	%xmm1, %xmm11
	pand	%xmm2, %xmm1
	pxor	%xmm1, %xmm10
	pxor	%xmm13, %xmm8
	addl	$-1, %eax
	jne	.LBB1_1
# %bb.2:
	rdtscp
	movq	%rdx, %rsi
	movl	%ecx, 12(%rsp)
	shlq	$32, %rsi
	orq	%rax, %rsi
	movl	$100000000, %eax        # imm = 0x5F5E100
	movdqa	144(%rsp), %xmm12       # 16-byte Reload
	.p2align	4, 0x90
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	movdqa	%xmm4, %xmm1
	movdqa	%xmm5, %xmm2
	movdqa	%xmm7, %xmm3
	movdqa	%xmm6, %xmm4
	movdqa	%xmm9, %xmm5
	movdqa	%xmm8, %xmm6
	pand	%xmm13, %xmm6
	movdqa	%xmm9, %xmm7
	movdqa	192(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm7
	movdqa	%xmm6, %xmm9
	pxor	%xmm7, %xmm9
	pand	%xmm0, %xmm5
	pand	%xmm6, %xmm7
	pxor	%xmm5, %xmm7
	movdqa	%xmm4, %xmm5
	pxor	%xmm14, %xmm5
	movdqa	%xmm7, %xmm6
	pxor	%xmm5, %xmm6
	pand	%xmm14, %xmm4
	pand	%xmm7, %xmm5
	pxor	%xmm4, %xmm5
	movdqa	%xmm3, %xmm4
	movdqa	160(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm4
	movdqa	%xmm5, %xmm7
	pxor	%xmm4, %xmm7
	pand	%xmm0, %xmm3
	pand	%xmm5, %xmm4
	pxor	%xmm3, %xmm4
	movdqa	%xmm2, %xmm3
	movdqa	208(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm3
	movdqa	%xmm4, %xmm5
	pxor	%xmm3, %xmm5
	pand	%xmm0, %xmm2
	pand	%xmm4, %xmm3
	pxor	%xmm2, %xmm3
	movdqa	%xmm1, %xmm2
	pxor	%xmm12, %xmm2
	movdqa	%xmm3, %xmm4
	pxor	%xmm2, %xmm4
	pand	%xmm3, %xmm2
	movdqa	%xmm11, %xmm3
	pand	%xmm12, %xmm1
	pxor	%xmm1, %xmm2
	movdqa	%xmm11, %xmm1
	movdqa	176(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm0, %xmm1
	pand	%xmm0, %xmm3
	movdqa	%xmm15, %xmm0
	pxor	%xmm15, %xmm10
	pxor	%xmm3, %xmm10
	movdqa	%xmm2, %xmm11
	pxor	%xmm1, %xmm11
	pand	%xmm2, %xmm1
	pxor	%xmm1, %xmm10
	pxor	%xmm13, %xmm8
	addl	$-1, %eax
	jne	.LBB1_3
# %bb.4:
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
	movdqa	%xmm8, 128(%rsp)        # 16-byte Spill
	movdqa	%xmm9, 112(%rsp)        # 16-byte Spill
	movdqa	%xmm6, 96(%rsp)         # 16-byte Spill
	movdqa	%xmm7, 80(%rsp)         # 16-byte Spill
	movdqa	%xmm10, 16(%rsp)        # 16-byte Spill
	movdqa	%xmm11, 32(%rsp)        # 16-byte Spill
	movdqa	%xmm5, 64(%rsp)         # 16-byte Spill
	movdqa	%xmm4, 48(%rsp)         # 16-byte Spill
	callq	printf
	movaps	128(%rsp), %xmm0        # 16-byte Reload
	movaps	112(%rsp), %xmm1        # 16-byte Reload
	movaps	96(%rsp), %xmm2         # 16-byte Reload
	movaps	80(%rsp), %xmm3         # 16-byte Reload
	movaps	16(%rsp), %xmm4         # 16-byte Reload
	movaps	32(%rsp), %xmm5         # 16-byte Reload
	movaps	64(%rsp), %xmm6         # 16-byte Reload
	movaps	48(%rsp), %xmm7         # 16-byte Reload
	#APP
	#NO_APP
	addq	$256, %rsp              # imm = 0x100
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
	.asciz	" 8-bit packed add:   %.2f\n"
	.size	.L.str, 27

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	" 8-bit bitslice add: %.2f\n"
	.size	.L.str.1, 27


	.ident	"clang version 7.0.0-svn345401-1~exp1~20181026173340.32 (branches/release_70)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
