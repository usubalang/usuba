	.text
	.file	"masked_pyjamask_ua_vslice.c"
	.globl	SubBytes__V32           # -- Begin function SubBytes__V32
	.p2align	4, 0x90
	.type	SubBytes__V32,@function
SubBytes__V32:                          # @SubBytes__V32
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$200, %rsp
	.cfi_def_cfa_offset 240
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%r8, %r15
	movq	%rcx, %rbx
	movq	%rdx, %r14
	movq	%rsi, %r12
	vmovups	(%rcx), %xmm0
	vxorps	(%rdi), %xmm0, %xmm0
	vmovaps	%xmm0, 32(%rsp)         # 16-byte Spill
	vmovaps	%xmm0, 176(%rsp)
	leaq	128(%rsp), %rdi
	leaq	176(%rsp), %rsi
	movq	%r12, %rdx
	callq	isw_mult
	vmovaps	128(%rsp), %xmm0
	vxorps	(%rbx), %xmm0, %xmm0
	vmovaps	%xmm0, 16(%rsp)
	leaq	112(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	isw_mult
	vmovaps	32(%rsp), %xmm0         # 16-byte Reload
	vxorps	112(%rsp), %xmm0, %xmm0
	vmovaps	%xmm0, 32(%rsp)         # 16-byte Spill
	vmovaps	%xmm0, 48(%rsp)
	leaq	96(%rsp), %rdi
	leaq	16(%rsp), %rbx
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	isw_mult
	vmovaps	96(%rsp), %xmm0
	vxorps	(%r12), %xmm0, %xmm0
	vmovaps	%xmm0, 64(%rsp)         # 16-byte Spill
	leaq	80(%rsp), %rdi
	leaq	48(%rsp), %rsi
	movq	%rbx, %rdx
	callq	isw_mult
	vmovaps	80(%rsp), %xmm0
	vxorps	(%r14), %xmm0, %xmm0
	vmovaps	64(%rsp), %xmm1         # 16-byte Reload
	vxorps	%xmm0, %xmm1, %xmm0
	vmovaps	%xmm0, 144(%rsp)
	vxorps	32(%rsp), %xmm1, %xmm0  # 16-byte Folded Reload
	vmovaps	%xmm0, 160(%rsp)
	movl	16(%rsp), %eax
	notl	%eax
	movl	%eax, (%rsp)
	movl	28(%rsp), %eax
	movl	%eax, 12(%rsp)
	movq	20(%rsp), %rax
	movq	%rax, 4(%rsp)
	vmovaps	48(%rsp), %xmm0
	vmovups	%xmm0, (%r15)
	vmovaps	160(%rsp), %xmm0
	vmovups	%xmm0, 16(%r15)
	movl	(%rsp), %eax
	movl	%eax, 32(%r15)
	movq	4(%rsp), %rax
	movq	%rax, 36(%r15)
	movl	12(%rsp), %eax
	movl	%eax, 44(%r15)
	vmovaps	144(%rsp), %xmm0
	vmovups	%xmm0, 48(%r15)
	addq	$200, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	SubBytes__V32, .Lfunc_end0-SubBytes__V32
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90         # -- Begin function isw_mult
	.type	isw_mult,@function
isw_mult:                               # @isw_mult
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %r15
	movq	%rsi, %r14
	movq	%rdi, %rbx
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, (%rdi)
	movl	(%rdx), %eax
	andl	(%rsi), %eax
	movl	%eax, (%rdi)
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	callq	rand
	xorl	%eax, (%rbx)
	movl	4(%r15), %ecx
	andl	(%r14), %ecx
	movl	(%r15), %edx
	xorl	%eax, %ecx
	andl	4(%r14), %edx
	xorl	%ecx, %edx
	xorl	%edx, 4(%rbx)
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	callq	rand
	xorl	%eax, (%rbx)
	movl	8(%r15), %ecx
	andl	(%r14), %ecx
	movl	(%r15), %edx
	xorl	%eax, %ecx
	andl	8(%r14), %edx
	xorl	%ecx, %edx
	xorl	%edx, 8(%rbx)
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	callq	rand
	xorl	%eax, (%rbx)
	movl	12(%r15), %ecx
	andl	(%r14), %ecx
	movl	(%r15), %edx
	xorl	%eax, %ecx
	andl	12(%r14), %edx
	xorl	%ecx, %edx
	xorl	%edx, 12(%rbx)
	movl	4(%r15), %eax
	andl	4(%r14), %eax
	xorl	%eax, 4(%rbx)
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	callq	rand
	xorl	%eax, 4(%rbx)
	movl	8(%r15), %ecx
	andl	4(%r14), %ecx
	movl	4(%r15), %edx
	xorl	%eax, %ecx
	andl	8(%r14), %edx
	xorl	%ecx, %edx
	xorl	%edx, 8(%rbx)
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	callq	rand
	xorl	%eax, 4(%rbx)
	movl	12(%r15), %ecx
	andl	4(%r14), %ecx
	movl	4(%r15), %edx
	xorl	%eax, %ecx
	andl	12(%r14), %edx
	xorl	%ecx, %edx
	xorl	%edx, 12(%rbx)
	movl	8(%r15), %eax
	andl	8(%r14), %eax
	xorl	%eax, 8(%rbx)
	xorl	%edi, %edi
	callq	time
	movl	%eax, %edi
	callq	srand
	callq	rand
	xorl	%eax, 8(%rbx)
	movl	8(%r15), %ecx
	movl	12(%r15), %edx
	andl	8(%r14), %edx
	xorl	%eax, %edx
	andl	12(%r14), %ecx
	xorl	%edx, %ecx
	xorl	12(%rbx), %ecx
	movl	%ecx, 12(%rbx)
	movl	12(%r15), %eax
	andl	12(%r14), %eax
	xorl	%ecx, %eax
	movl	%eax, 12(%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	isw_mult, .Lfunc_end1-isw_mult
	.cfi_endproc
                                        # -- End function
	.globl	AddRoundKey__V32        # -- Begin function AddRoundKey__V32
	.p2align	4, 0x90
	.type	AddRoundKey__V32,@function
AddRoundKey__V32:                       # @AddRoundKey__V32
	.cfi_startproc
# %bb.0:
	movl	(%rsi), %eax
	xorl	(%rdi), %eax
	movl	%eax, (%rdx)
	movl	4(%rsi), %eax
	xorl	4(%rdi), %eax
	movl	%eax, 4(%rdx)
	movl	8(%rsi), %eax
	xorl	8(%rdi), %eax
	movl	%eax, 8(%rdx)
	movl	12(%rsi), %eax
	xorl	12(%rdi), %eax
	movl	%eax, 12(%rdx)
	movl	16(%rsi), %eax
	xorl	16(%rdi), %eax
	movl	%eax, 16(%rdx)
	movl	20(%rsi), %eax
	xorl	20(%rdi), %eax
	movl	%eax, 20(%rdx)
	movl	24(%rsi), %eax
	xorl	24(%rdi), %eax
	movl	%eax, 24(%rdx)
	movl	28(%rsi), %eax
	xorl	28(%rdi), %eax
	movl	%eax, 28(%rdx)
	movl	32(%rsi), %eax
	xorl	32(%rdi), %eax
	movl	%eax, 32(%rdx)
	movl	36(%rsi), %eax
	xorl	36(%rdi), %eax
	movl	%eax, 36(%rdx)
	movl	40(%rsi), %eax
	xorl	40(%rdi), %eax
	movl	%eax, 40(%rdx)
	movl	44(%rsi), %eax
	xorl	44(%rdi), %eax
	movl	%eax, 44(%rdx)
	movl	48(%rsi), %eax
	xorl	48(%rdi), %eax
	movl	%eax, 48(%rdx)
	movl	52(%rsi), %eax
	xorl	52(%rdi), %eax
	movl	%eax, 52(%rdx)
	movl	56(%rsi), %eax
	xorl	56(%rdi), %eax
	movl	%eax, 56(%rdx)
	movl	60(%rsi), %eax
	xorl	60(%rdi), %eax
	movl	%eax, 60(%rdx)
	retq
.Lfunc_end2:
	.size	AddRoundKey__V32, .Lfunc_end2-AddRoundKey__V32
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function mat_mult__V32
.LCPI3_0:
	.long	2147483648              # 0x80000000
	.text
	.globl	mat_mult__V32
	.p2align	4, 0x90
	.type	mat_mult__V32,@function
mat_mult__V32:                          # @mat_mult__V32
	.cfi_startproc
# %bb.0:
	vmovups	(%rdi), %xmm0
	vmovaps	%xmm0, -24(%rsp)
	vpxor	%xmm3, %xmm3, %xmm3
	vmovdqa	%xmm3, -40(%rsp)
	vmovdqa	-24(%rsp), %xmm2
	vmovdqu	(%rsi), %xmm0
	xorl	%eax, %eax
	vpbroadcastd	.LCPI3_0(%rip), %xmm1 # xmm1 = [2147483648,2147483648,2147483648,2147483648]
	.p2align	4, 0x90
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	vmovd	%eax, %xmm4
	vpslld	%xmm4, %xmm0, %xmm4
	vpsrad	$31, %xmm4, %xmm4
	vpand	%xmm4, %xmm2, %xmm4
	vpxor	%xmm3, %xmm4, %xmm3
	vpslld	$30, %xmm2, %xmm4
	vpsrld	$1, %xmm2, %xmm5
	vpslld	$31, %xmm2, %xmm2
	vpor	%xmm5, %xmm2, %xmm2
	leal	1(%rax), %ecx
	vmovd	%ecx, %xmm5
	vpslld	%xmm5, %xmm0, %xmm5
	vpand	%xmm1, %xmm4, %xmm4
	vpsrad	$31, %xmm5, %xmm5
	vpand	%xmm5, %xmm2, %xmm5
	vpxor	%xmm3, %xmm5, %xmm3
	vpsrld	$1, %xmm2, %xmm2
	vpor	%xmm4, %xmm2, %xmm4
	leal	2(%rax), %ecx
	vmovd	%ecx, %xmm5
	vpslld	%xmm5, %xmm0, %xmm5
	vpsrad	$31, %xmm5, %xmm5
	vpand	%xmm5, %xmm4, %xmm5
	vpxor	%xmm3, %xmm5, %xmm3
	vpsrld	$1, %xmm4, %xmm4
	vpslld	$31, %xmm2, %xmm2
	vpor	%xmm2, %xmm4, %xmm2
	leal	3(%rax), %ecx
	vmovd	%ecx, %xmm5
	vpslld	%xmm5, %xmm0, %xmm5
	vpsrad	$31, %xmm5, %xmm5
	vpand	%xmm5, %xmm2, %xmm5
	vpxor	%xmm3, %xmm5, %xmm3
	vpsrld	$1, %xmm2, %xmm2
	vpslld	$31, %xmm4, %xmm4
	vpor	%xmm4, %xmm2, %xmm2
	addl	$4, %eax
	cmpl	$32, %eax
	jne	.LBB3_1
# %bb.2:
	vmovdqa	%xmm3, -40(%rsp)
	vmovdqa	%xmm2, -24(%rsp)
	vmovaps	-40(%rsp), %xmm0
	vmovups	%xmm0, (%rdx)
	retq
.Lfunc_end3:
	.size	mat_mult__V32, .Lfunc_end3-mat_mult__V32
	.cfi_endproc
                                        # -- End function
	.globl	MixRows__V32            # -- Begin function MixRows__V32
	.p2align	4, 0x90
	.type	MixRows__V32,@function
MixRows__V32:                           # @MixRows__V32
	.cfi_startproc
# %bb.0:
	movl	(%rdi), %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	andl	$-1551495035, %ecx      # imm = 0xA3861085
	leal	(%r8,%r8), %edx
	sarl	$31, %edx
	andl	$-775747518, %edx       # imm = 0xD1C30842
	xorl	%ecx, %edx
	leal	(,%r8,4), %ecx
	sarl	$31, %ecx
	andl	$1759609889, %ecx       # imm = 0x68E18421
	leal	(,%r8,8), %r9d
	sarl	$31, %r9d
	andl	$-1267678704, %r9d      # imm = 0xB470C210
	xorl	%ecx, %r9d
	xorl	%edx, %r9d
	movl	%r8d, %ecx
	shll	$4, %ecx
	sarl	$31, %ecx
	andl	$1513644296, %ecx       # imm = 0x5A386108
	movl	%r8d, %eax
	shll	$5, %eax
	sarl	$31, %eax
	andl	$756822148, %eax        # imm = 0x2D1C3084
	xorl	%ecx, %eax
	movl	%r8d, %edx
	shll	$6, %edx
	sarl	$31, %edx
	andl	$378411074, %edx        # imm = 0x168E1842
	xorl	%eax, %edx
	xorl	%r9d, %edx
	movl	%r8d, %eax
	shll	$7, %eax
	sarl	$31, %eax
	andl	$189205537, %eax        # imm = 0xB470C21
	movl	%r8d, %ecx
	shll	$8, %ecx
	sarl	$31, %ecx
	andl	$-2052880880, %ecx      # imm = 0x85A38610
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$9, %eax
	sarl	$31, %eax
	andl	$1121043208, %eax       # imm = 0x42D1C308
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$10, %ecx
	sarl	$31, %ecx
	andl	$560521604, %ecx        # imm = 0x2168E184
	xorl	%eax, %ecx
	xorl	%edx, %ecx
	movl	%r8d, %eax
	shll	$11, %eax
	sarl	$31, %eax
	andl	$280260802, %eax        # imm = 0x10B470C2
	movl	%r8d, %edx
	shll	$12, %edx
	sarl	$31, %edx
	andl	$140130401, %edx        # imm = 0x85A3861
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$13, %eax
	sarl	$31, %eax
	andl	$-2077418448, %eax      # imm = 0x842D1C30
	xorl	%edx, %eax
	movl	%r8d, %edx
	shll	$14, %edx
	sarl	$31, %edx
	andl	$1108774424, %edx       # imm = 0x42168E18
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$15, %eax
	sarl	$31, %eax
	andl	$554387212, %eax        # imm = 0x210B470C
	xorl	%edx, %eax
	xorl	%ecx, %eax
	movswl	%r8w, %ecx
	sarl	$15, %ecx
	andl	$277193606, %ecx        # imm = 0x1085A386
	movl	%r8d, %edx
	shll	$17, %edx
	sarl	$31, %edx
	andl	$138596803, %edx        # imm = 0x842D1C3
	xorl	%ecx, %edx
	movl	%r8d, %ecx
	shll	$18, %ecx
	sarl	$31, %ecx
	andl	$-2078185247, %ecx      # imm = 0x842168E1
	xorl	%edx, %ecx
	movl	%r8d, %edx
	shll	$19, %edx
	sarl	$31, %edx
	andl	$-1039092624, %edx      # imm = 0xC210B470
	xorl	%ecx, %edx
	movl	%r8d, %ecx
	shll	$20, %ecx
	sarl	$31, %ecx
	andl	$1627937336, %ecx       # imm = 0x61085A38
	xorl	%edx, %ecx
	movl	%r8d, %r9d
	shll	$21, %r9d
	sarl	$31, %r9d
	andl	$813968668, %r9d        # imm = 0x30842D1C
	xorl	%ecx, %r9d
	xorl	%eax, %r9d
	movl	%r8d, %eax
	shll	$22, %eax
	sarl	$31, %eax
	andl	$406984334, %eax        # imm = 0x1842168E
	movl	%r8d, %ecx
	shll	$23, %ecx
	sarl	$31, %ecx
	andl	$203492167, %ecx        # imm = 0xC210B47
	xorl	%eax, %ecx
	movsbl	%r8b, %eax
	sarl	$7, %eax
	andl	$-2045737565, %eax      # imm = 0x861085A3
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$25, %ecx
	sarl	$31, %ecx
	andl	$-1022868783, %ecx      # imm = 0xC30842D1
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$26, %eax
	sarl	$31, %eax
	andl	$-511434392, %eax       # imm = 0xE1842168
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$27, %ecx
	sarl	$31, %ecx
	andl	$1891766452, %ecx       # imm = 0x70C210B4
	xorl	%eax, %ecx
	movl	%r8d, %edx
	shll	$28, %edx
	sarl	$31, %edx
	andl	$945883226, %edx        # imm = 0x3861085A
	xorl	%ecx, %edx
	xorl	%r9d, %edx
	movl	%r8d, %eax
	shll	$29, %eax
	sarl	$31, %eax
	andl	$472941613, %eax        # imm = 0x1C30842D
	movl	%r8d, %ecx
	shll	$30, %ecx
	sarl	$31, %ecx
	andl	$-1911012842, %ecx      # imm = 0x8E184216
	xorl	%eax, %ecx
	andl	$1, %r8d
	negl	%r8d
	andl	$1191977227, %r8d       # imm = 0x470C210B
	xorl	%ecx, %r8d
	xorl	%edx, %r8d
	movl	%r8d, (%rsi)
	movq	$0, 4(%rsi)
	movl	$0, 12(%rsi)
	movl	16(%rdi), %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	andl	$1665232929, %ecx       # imm = 0x63417021
	leal	(%r8,%r8), %edx
	sarl	$31, %edx
	andl	$-1314867184, %edx      # imm = 0xB1A0B810
	xorl	%ecx, %edx
	leal	(,%r8,4), %ecx
	sarl	$31, %ecx
	andl	$1490050056, %ecx       # imm = 0x58D05C08
	leal	(,%r8,8), %r9d
	sarl	$31, %r9d
	andl	$745025028, %r9d        # imm = 0x2C682E04
	xorl	%ecx, %r9d
	xorl	%edx, %r9d
	movl	%r8d, %ecx
	shll	$4, %ecx
	sarl	$31, %ecx
	andl	$372512514, %ecx        # imm = 0x16341702
	movl	%r8d, %eax
	shll	$5, %eax
	sarl	$31, %eax
	andl	$186256257, %eax        # imm = 0xB1A0B81
	xorl	%ecx, %eax
	movl	%r8d, %edx
	shll	$6, %edx
	sarl	$31, %edx
	andl	$-2054355520, %edx      # imm = 0x858D05C0
	xorl	%eax, %edx
	xorl	%r9d, %edx
	movl	%r8d, %eax
	shll	$7, %eax
	sarl	$31, %eax
	andl	$1120305888, %eax       # imm = 0x42C682E0
	movl	%r8d, %ecx
	shll	$8, %ecx
	sarl	$31, %ecx
	andl	$560152944, %ecx        # imm = 0x21634170
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$9, %eax
	sarl	$31, %eax
	andl	$280076472, %eax        # imm = 0x10B1A0B8
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$10, %ecx
	sarl	$31, %ecx
	andl	$140038236, %ecx        # imm = 0x858D05C
	xorl	%eax, %ecx
	xorl	%edx, %ecx
	movl	%r8d, %eax
	shll	$11, %eax
	sarl	$31, %eax
	andl	$70019118, %eax         # imm = 0x42C682E
	movl	%r8d, %edx
	shll	$12, %edx
	sarl	$31, %edx
	andl	$35009559, %edx         # imm = 0x2163417
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$13, %eax
	sarl	$31, %eax
	andl	$-2129978869, %eax      # imm = 0x810B1A0B
	xorl	%edx, %eax
	movl	%r8d, %edx
	shll	$14, %edx
	sarl	$31, %edx
	andl	$-1064989435, %edx      # imm = 0xC0858D05
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$15, %eax
	sarl	$31, %eax
	andl	$-532494718, %eax       # imm = 0xE042C682
	xorl	%edx, %eax
	xorl	%ecx, %eax
	movswl	%r8w, %ecx
	sarl	$15, %ecx
	andl	$1881236289, %ecx       # imm = 0x70216341
	movl	%r8d, %edx
	shll	$17, %edx
	sarl	$31, %edx
	andl	$-1206865504, %edx      # imm = 0xB810B1A0
	xorl	%ecx, %edx
	movl	%r8d, %ecx
	shll	$18, %ecx
	sarl	$31, %ecx
	andl	$1544050896, %ecx       # imm = 0x5C0858D0
	xorl	%edx, %ecx
	movl	%r8d, %edx
	shll	$19, %edx
	sarl	$31, %edx
	andl	$772025448, %edx        # imm = 0x2E042C68
	xorl	%ecx, %edx
	movl	%r8d, %ecx
	shll	$20, %ecx
	sarl	$31, %ecx
	andl	$386012724, %ecx        # imm = 0x17021634
	xorl	%edx, %ecx
	movl	%r8d, %r9d
	shll	$21, %r9d
	sarl	$31, %r9d
	andl	$193006362, %r9d        # imm = 0xB810B1A
	xorl	%ecx, %r9d
	xorl	%eax, %r9d
	movl	%r8d, %eax
	shll	$22, %eax
	sarl	$31, %eax
	andl	$96503181, %eax         # imm = 0x5C0858D
	movl	%r8d, %ecx
	shll	$23, %ecx
	sarl	$31, %ecx
	andl	$-2099232058, %ecx      # imm = 0x82E042C6
	xorl	%eax, %ecx
	movsbl	%r8b, %eax
	sarl	$7, %eax
	andl	$1097867619, %eax       # imm = 0x41702163
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$25, %ecx
	sarl	$31, %ecx
	andl	$-1598549839, %ecx      # imm = 0xA0B810B1
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$26, %eax
	sarl	$31, %eax
	andl	$-799274920, %eax       # imm = 0xD05C0858
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$27, %ecx
	sarl	$31, %ecx
	andl	$1747846188, %ecx       # imm = 0x682E042C
	xorl	%eax, %ecx
	movl	%r8d, %edx
	shll	$28, %edx
	sarl	$31, %edx
	andl	$873923094, %edx        # imm = 0x34170216
	xorl	%ecx, %edx
	xorl	%r9d, %edx
	movl	%r8d, %eax
	shll	$29, %eax
	sarl	$31, %eax
	andl	$436961547, %eax        # imm = 0x1A0B810B
	movl	%r8d, %ecx
	shll	$30, %ecx
	sarl	$31, %ecx
	andl	$-1929002875, %ecx      # imm = 0x8D05C085
	xorl	%eax, %ecx
	andl	$1, %r8d
	negl	%r8d
	andl	$-964501438, %r8d       # imm = 0xC682E042
	xorl	%ecx, %r8d
	xorl	%edx, %r8d
	movl	%r8d, 16(%rsi)
	movq	$0, 20(%rsi)
	movl	$0, 28(%rsi)
	movl	32(%rdi), %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	andl	$1764553344, %ecx       # imm = 0x692CF280
	leal	(%r8,%r8), %edx
	sarl	$31, %edx
	andl	$882276672, %edx        # imm = 0x34967940
	xorl	%ecx, %edx
	leal	(,%r8,4), %ecx
	sarl	$31, %ecx
	andl	$441138336, %ecx        # imm = 0x1A4B3CA0
	leal	(,%r8,8), %r9d
	sarl	$31, %r9d
	andl	$220569168, %r9d        # imm = 0xD259E50
	xorl	%ecx, %r9d
	xorl	%edx, %r9d
	movl	%r8d, %ecx
	shll	$4, %ecx
	sarl	$31, %ecx
	andl	$110284584, %ecx        # imm = 0x692CF28
	movl	%r8d, %eax
	shll	$5, %eax
	sarl	$31, %eax
	andl	$55142292, %eax         # imm = 0x3496794
	xorl	%ecx, %eax
	movl	%r8d, %edx
	shll	$6, %edx
	sarl	$31, %edx
	andl	$27571146, %edx         # imm = 0x1A4B3CA
	xorl	%eax, %edx
	xorl	%r9d, %edx
	movl	%r8d, %eax
	shll	$7, %eax
	sarl	$31, %eax
	andl	$13785573, %eax         # imm = 0xD259E5
	movl	%r8d, %ecx
	shll	$8, %ecx
	sarl	$31, %ecx
	andl	$-2140590862, %ecx      # imm = 0x80692CF2
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$9, %eax
	sarl	$31, %eax
	andl	$1077188217, %eax       # imm = 0x40349679
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$10, %ecx
	sarl	$31, %ecx
	andl	$-1608889540, %ecx      # imm = 0xA01A4B3C
	xorl	%eax, %ecx
	xorl	%edx, %ecx
	movl	%r8d, %eax
	shll	$11, %eax
	sarl	$31, %eax
	andl	$1343038878, %eax       # imm = 0x500D259E
	movl	%r8d, %edx
	shll	$12, %edx
	sarl	$31, %edx
	andl	$671519439, %edx        # imm = 0x280692CF
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$13, %eax
	sarl	$31, %eax
	andl	$-1811723929, %eax      # imm = 0x94034967
	xorl	%edx, %eax
	movl	%r8d, %edx
	shll	$14, %edx
	sarl	$31, %edx
	andl	$-905861965, %edx       # imm = 0xCA01A4B3
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$15, %eax
	sarl	$31, %eax
	andl	$-452930983, %eax       # imm = 0xE500D259
	xorl	%edx, %eax
	xorl	%ecx, %eax
	movswl	%r8w, %ecx
	sarl	$15, %ecx
	andl	$-226465492, %ecx       # imm = 0xF280692C
	movl	%r8d, %edx
	shll	$17, %edx
	sarl	$31, %edx
	andl	$2034250902, %edx       # imm = 0x79403496
	xorl	%ecx, %edx
	movl	%r8d, %ecx
	shll	$18, %ecx
	sarl	$31, %ecx
	andl	$1017125451, %ecx       # imm = 0x3CA01A4B
	xorl	%edx, %ecx
	movl	%r8d, %edx
	shll	$19, %edx
	sarl	$31, %edx
	andl	$-1638920923, %edx      # imm = 0x9E500D25
	xorl	%ecx, %edx
	movl	%r8d, %ecx
	shll	$20, %ecx
	sarl	$31, %ecx
	andl	$-819460462, %ecx       # imm = 0xCF280692
	xorl	%edx, %ecx
	movl	%r8d, %r9d
	shll	$21, %r9d
	sarl	$31, %r9d
	andl	$1737753417, %r9d       # imm = 0x67940349
	xorl	%ecx, %r9d
	xorl	%eax, %r9d
	movl	%r8d, %eax
	shll	$22, %eax
	sarl	$31, %eax
	andl	$-1278606940, %eax      # imm = 0xB3CA01A4
	movl	%r8d, %ecx
	shll	$23, %ecx
	sarl	$31, %ecx
	andl	$1508180178, %ecx       # imm = 0x59E500D2
	xorl	%eax, %ecx
	movsbl	%r8b, %eax
	sarl	$7, %eax
	andl	$754090089, %eax        # imm = 0x2CF28069
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$25, %ecx
	sarl	$31, %ecx
	andl	$-1770438604, %ecx      # imm = 0x96794034
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$26, %eax
	sarl	$31, %eax
	andl	$1262264346, %eax       # imm = 0x4B3CA01A
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$27, %ecx
	sarl	$31, %ecx
	andl	$631132173, %ecx        # imm = 0x259E500D
	xorl	%eax, %ecx
	movl	%r8d, %edx
	shll	$28, %edx
	sarl	$31, %edx
	andl	$-1831917562, %edx      # imm = 0x92CF2806
	xorl	%ecx, %edx
	xorl	%r9d, %edx
	movl	%r8d, %eax
	shll	$29, %eax
	sarl	$31, %eax
	andl	$1231524867, %eax       # imm = 0x49679403
	movl	%r8d, %ecx
	shll	$30, %ecx
	sarl	$31, %ecx
	andl	$-1531721215, %ecx      # imm = 0xA4B3CA01
	xorl	%eax, %ecx
	andl	$1, %r8d
	negl	%r8d
	andl	$-765860608, %r8d       # imm = 0xD259E500
	xorl	%ecx, %r8d
	xorl	%edx, %r8d
	movl	%r8d, 32(%rsi)
	movq	$0, 36(%rsi)
	movl	$0, 44(%rsi)
	movl	48(%rdi), %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	andl	$1218791443, %ecx       # imm = 0x48A54813
	leal	(%r8,%r8), %edx
	sarl	$31, %edx
	andl	$-1538087927, %edx      # imm = 0xA452A409
	xorl	%ecx, %edx
	leal	(,%r8,4), %ecx
	sarl	$31, %ecx
	andl	$-769043964, %ecx       # imm = 0xD2295204
	leal	(,%r8,8), %edi
	sarl	$31, %edi
	andl	$1762961666, %edi       # imm = 0x6914A902
	xorl	%ecx, %edi
	xorl	%edx, %edi
	movl	%r8d, %ecx
	shll	$4, %ecx
	sarl	$31, %ecx
	andl	$881480833, %ecx        # imm = 0x348A5481
	movl	%r8d, %eax
	shll	$5, %eax
	sarl	$31, %eax
	andl	$-1706743232, %eax      # imm = 0x9A452A40
	xorl	%ecx, %eax
	movl	%r8d, %edx
	shll	$6, %edx
	sarl	$31, %edx
	andl	$1294112032, %edx       # imm = 0x4D229520
	xorl	%eax, %edx
	xorl	%edi, %edx
	movl	%r8d, %eax
	shll	$7, %eax
	sarl	$31, %eax
	andl	$647056016, %eax        # imm = 0x26914A90
	movl	%r8d, %ecx
	shll	$8, %ecx
	sarl	$31, %ecx
	andl	$323528008, %ecx        # imm = 0x1348A548
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$9, %eax
	sarl	$31, %eax
	andl	$161764004, %eax        # imm = 0x9A452A4
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$10, %ecx
	sarl	$31, %ecx
	andl	$80882002, %ecx         # imm = 0x4D22952
	xorl	%eax, %ecx
	xorl	%edx, %ecx
	movl	%r8d, %eax
	shll	$11, %eax
	sarl	$31, %eax
	andl	$40441001, %eax         # imm = 0x26914A9
	movl	%r8d, %edx
	shll	$12, %edx
	sarl	$31, %edx
	andl	$-2127263148, %edx      # imm = 0x81348A54
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$13, %eax
	sarl	$31, %eax
	andl	$1083852074, %eax       # imm = 0x409A452A
	xorl	%edx, %eax
	movl	%r8d, %edi
	shll	$14, %edi
	sarl	$31, %edi
	andl	$541926037, %edi        # imm = 0x204D2295
	xorl	%eax, %edi
	movl	%r8d, %edx
	shll	$15, %edx
	sarl	$31, %edx
	andl	$-1876520630, %edx      # imm = 0x9026914A
	xorl	%edi, %edx
	xorl	%ecx, %edx
	movswl	%r8w, %eax
	sarl	$15, %eax
	andl	$1209223333, %eax       # imm = 0x481348A5
	movl	%r8d, %ecx
	shll	$17, %ecx
	sarl	$31, %ecx
	andl	$-1542871982, %ecx      # imm = 0xA409A452
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$18, %eax
	sarl	$31, %eax
	andl	$1376047657, %eax       # imm = 0x5204D229
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$19, %ecx
	sarl	$31, %ecx
	andl	$-1459459820, %ecx      # imm = 0xA9026914
	xorl	%eax, %ecx
	movl	%r8d, %eax
	shll	$20, %eax
	sarl	$31, %eax
	andl	$1417753738, %eax       # imm = 0x5481348A
	xorl	%ecx, %eax
	movl	%r8d, %ecx
	shll	$21, %ecx
	sarl	$31, %ecx
	andl	$708876869, %ecx        # imm = 0x2A409A45
	xorl	%eax, %ecx
	xorl	%edx, %ecx
	movl	%r8d, %eax
	shll	$22, %eax
	sarl	$31, %eax
	andl	$-1793045214, %eax      # imm = 0x95204D22
	movl	%r8d, %edx
	shll	$23, %edx
	sarl	$31, %edx
	andl	$1250961041, %edx       # imm = 0x4A902691
	xorl	%eax, %edx
	movsbl	%r8b, %eax
	sarl	$7, %eax
	andl	$-1522003128, %eax      # imm = 0xA5481348
	xorl	%edx, %eax
	movl	%r8d, %edx
	shll	$25, %edx
	sarl	$31, %edx
	andl	$1386482084, %edx       # imm = 0x52A409A4
	xorl	%eax, %edx
	movl	%r8d, %eax
	shll	$26, %eax
	sarl	$31, %eax
	andl	$693241042, %eax        # imm = 0x295204D2
	xorl	%edx, %eax
	movl	%r8d, %edi
	shll	$27, %edi
	sarl	$31, %edi
	andl	$346620521, %edi        # imm = 0x14A90269
	xorl	%eax, %edi
	movl	%r8d, %edx
	shll	$28, %edx
	sarl	$31, %edx
	andl	$-1974173388, %edx      # imm = 0x8A548134
	xorl	%edi, %edx
	xorl	%ecx, %edx
	movl	%r8d, %eax
	shll	$29, %eax
	sarl	$31, %eax
	andl	$1160396954, %eax       # imm = 0x452A409A
	movl	%r8d, %ecx
	shll	$30, %ecx
	sarl	$31, %ecx
	andl	$580198477, %ecx        # imm = 0x2295204D
	xorl	%eax, %ecx
	andl	$1, %r8d
	negl	%r8d
	andl	$-1857384410, %r8d      # imm = 0x914A9026
	xorl	%ecx, %r8d
	xorl	%edx, %r8d
	movl	%r8d, 48(%rsi)
	movq	$0, 52(%rsi)
	movl	$0, 60(%rsi)
	retq
.Lfunc_end4:
	.size	MixRows__V32, .Lfunc_end4-MixRows__V32
	.cfi_endproc
                                        # -- End function
	.globl	pyjamask__              # -- Begin function pyjamask__
	.p2align	4, 0x90
	.type	pyjamask__,@function
pyjamask__:                             # @pyjamask__
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	vmovups	(%rdi), %xmm0
	vmovaps	%xmm0, (%rsp)
	vmovups	16(%rdi), %xmm0
	vmovaps	%xmm0, 16(%rsp)
	movq	%rdx, 72(%rsp)          # 8-byte Spill
	vmovups	32(%rdi), %xmm0
	vmovaps	%xmm0, 32(%rsp)
	movq	%rsi, %r13
	vmovups	48(%rdi), %xmm0
	vmovaps	%xmm0, 48(%rsp)
	vmovdqu	(%rsp), %ymm0
	movl	$32, %r15d
	vmovdqu	32(%rsp), %ymm1
	leaq	80(%rsp), %r12
	leaq	144(%rsp), %r14
	.p2align	4, 0x90
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	vpxor	-32(%r13,%r15), %ymm0, %ymm0
	vmovdqu	%ymm0, 80(%rsp)
	vpxor	(%r13,%r15), %ymm1, %ymm0
	vmovdqu	%ymm0, 112(%rsp)
	movq	%r12, %rdi
	leaq	96(%rsp), %rsi
	leaq	112(%rsp), %rdx
	leaq	128(%rsp), %rcx
	movq	%r14, %r8
	vzeroupper
	callq	SubBytes__V32
	movl	144(%rsp), %r8d
	movl	160(%rsp), %ecx
	movl	%r8d, %edx
	sarl	$31, %edx
	andl	$-1551495035, %edx      # imm = 0xA3861085
	leal	(%r8,%r8), %esi
	sarl	$31, %esi
	andl	$-775747518, %esi       # imm = 0xD1C30842
	xorl	%edx, %esi
	leal	(,%r8,4), %edx
	sarl	$31, %edx
	andl	$1759609889, %edx       # imm = 0x68E18421
	leal	(,%r8,8), %edi
	sarl	$31, %edi
	andl	$-1267678704, %edi      # imm = 0xB470C210
	xorl	%edx, %edi
	xorl	%esi, %edi
	movl	%r8d, %edx
	shll	$4, %edx
	sarl	$31, %edx
	andl	$1513644296, %edx       # imm = 0x5A386108
	movl	%r8d, %ebp
	shll	$5, %ebp
	sarl	$31, %ebp
	andl	$756822148, %ebp        # imm = 0x2D1C3084
	xorl	%edx, %ebp
	movl	%r8d, %esi
	shll	$6, %esi
	sarl	$31, %esi
	andl	$378411074, %esi        # imm = 0x168E1842
	xorl	%ebp, %esi
	xorl	%edi, %esi
	movl	%r8d, %edx
	shll	$7, %edx
	sarl	$31, %edx
	andl	$189205537, %edx        # imm = 0xB470C21
	movl	%r8d, %edi
	shll	$8, %edi
	sarl	$31, %edi
	andl	$-2052880880, %edi      # imm = 0x85A38610
	xorl	%edx, %edi
	movl	%r8d, %ebp
	shll	$9, %ebp
	sarl	$31, %ebp
	andl	$1121043208, %ebp       # imm = 0x42D1C308
	xorl	%edi, %ebp
	movl	%r8d, %edx
	shll	$10, %edx
	sarl	$31, %edx
	andl	$560521604, %edx        # imm = 0x2168E184
	xorl	%ebp, %edx
	xorl	%esi, %edx
	movl	%r8d, %esi
	shll	$11, %esi
	sarl	$31, %esi
	andl	$280260802, %esi        # imm = 0x10B470C2
	movl	%r8d, %edi
	shll	$12, %edi
	sarl	$31, %edi
	andl	$140130401, %edi        # imm = 0x85A3861
	xorl	%esi, %edi
	movl	%r8d, %esi
	shll	$13, %esi
	sarl	$31, %esi
	andl	$-2077418448, %esi      # imm = 0x842D1C30
	xorl	%edi, %esi
	movl	%r8d, %edi
	shll	$14, %edi
	sarl	$31, %edi
	andl	$1108774424, %edi       # imm = 0x42168E18
	xorl	%esi, %edi
	movl	%r8d, %esi
	shll	$15, %esi
	sarl	$31, %esi
	andl	$554387212, %esi        # imm = 0x210B470C
	xorl	%edi, %esi
	xorl	%edx, %esi
	movswl	%r8w, %edx
	sarl	$15, %edx
	andl	$277193606, %edx        # imm = 0x1085A386
	movl	%r8d, %edi
	shll	$17, %edi
	sarl	$31, %edi
	andl	$138596803, %edi        # imm = 0x842D1C3
	xorl	%edx, %edi
	movl	%r8d, %edx
	shll	$18, %edx
	sarl	$31, %edx
	andl	$-2078185247, %edx      # imm = 0x842168E1
	xorl	%edi, %edx
	movl	%r8d, %edi
	shll	$19, %edi
	sarl	$31, %edi
	andl	$-1039092624, %edi      # imm = 0xC210B470
	xorl	%edx, %edi
	movl	%r8d, %ebp
	shll	$20, %ebp
	sarl	$31, %ebp
	andl	$1627937336, %ebp       # imm = 0x61085A38
	xorl	%edi, %ebp
	movl	%r8d, %edx
	shll	$21, %edx
	sarl	$31, %edx
	andl	$813968668, %edx        # imm = 0x30842D1C
	xorl	%ebp, %edx
	xorl	%esi, %edx
	movl	%r8d, %esi
	shll	$22, %esi
	sarl	$31, %esi
	andl	$406984334, %esi        # imm = 0x1842168E
	movl	%r8d, %edi
	shll	$23, %edi
	sarl	$31, %edi
	andl	$203492167, %edi        # imm = 0xC210B47
	xorl	%esi, %edi
	movsbl	%r8b, %esi
	sarl	$7, %esi
	andl	$-2045737565, %esi      # imm = 0x861085A3
	xorl	%edi, %esi
	movl	%r8d, %edi
	shll	$25, %edi
	sarl	$31, %edi
	andl	$-1022868783, %edi      # imm = 0xC30842D1
	xorl	%esi, %edi
	movl	%r8d, %esi
	shll	$26, %esi
	sarl	$31, %esi
	andl	$-511434392, %esi       # imm = 0xE1842168
	xorl	%edi, %esi
	movl	%r8d, %edi
	shll	$27, %edi
	sarl	$31, %edi
	andl	$1891766452, %edi       # imm = 0x70C210B4
	xorl	%esi, %edi
	movl	%r8d, %esi
	shll	$28, %esi
	sarl	$31, %esi
	andl	$945883226, %esi        # imm = 0x3861085A
	xorl	%edi, %esi
	xorl	%edx, %esi
	movl	%r8d, %edx
	shll	$29, %edx
	sarl	$31, %edx
	andl	$472941613, %edx        # imm = 0x1C30842D
	movl	%r8d, %edi
	shll	$30, %edi
	sarl	$31, %edi
	andl	$-1911012842, %edi      # imm = 0x8E184216
	xorl	%edx, %edi
	andl	$1, %r8d
	negl	%r8d
	andl	$1191977227, %r8d       # imm = 0x470C210B
	xorl	%edi, %r8d
	xorl	%esi, %r8d
	movl	%ecx, %edx
	sarl	$31, %edx
	andl	$1665232929, %edx       # imm = 0x63417021
	leal	(%rcx,%rcx), %esi
	sarl	$31, %esi
	andl	$-1314867184, %esi      # imm = 0xB1A0B810
	xorl	%edx, %esi
	leal	(,%rcx,4), %edx
	sarl	$31, %edx
	andl	$1490050056, %edx       # imm = 0x58D05C08
	leal	(,%rcx,8), %edi
	sarl	$31, %edi
	andl	$745025028, %edi        # imm = 0x2C682E04
	xorl	%edx, %edi
	xorl	%esi, %edi
	movl	%ecx, %edx
	shll	$4, %edx
	sarl	$31, %edx
	andl	$372512514, %edx        # imm = 0x16341702
	movl	%ecx, %ebp
	shll	$5, %ebp
	sarl	$31, %ebp
	andl	$186256257, %ebp        # imm = 0xB1A0B81
	xorl	%edx, %ebp
	movl	%ecx, %esi
	shll	$6, %esi
	sarl	$31, %esi
	andl	$-2054355520, %esi      # imm = 0x858D05C0
	xorl	%ebp, %esi
	xorl	%edi, %esi
	movl	%ecx, %edx
	shll	$7, %edx
	sarl	$31, %edx
	andl	$1120305888, %edx       # imm = 0x42C682E0
	movl	%ecx, %edi
	shll	$8, %edi
	sarl	$31, %edi
	andl	$560152944, %edi        # imm = 0x21634170
	xorl	%edx, %edi
	movl	%ecx, %ebp
	shll	$9, %ebp
	sarl	$31, %ebp
	andl	$280076472, %ebp        # imm = 0x10B1A0B8
	xorl	%edi, %ebp
	movl	%ecx, %edx
	shll	$10, %edx
	sarl	$31, %edx
	andl	$140038236, %edx        # imm = 0x858D05C
	xorl	%ebp, %edx
	xorl	%esi, %edx
	movl	%ecx, %esi
	shll	$11, %esi
	sarl	$31, %esi
	andl	$70019118, %esi         # imm = 0x42C682E
	movl	%ecx, %edi
	shll	$12, %edi
	sarl	$31, %edi
	andl	$35009559, %edi         # imm = 0x2163417
	xorl	%esi, %edi
	movl	%ecx, %esi
	shll	$13, %esi
	sarl	$31, %esi
	andl	$-2129978869, %esi      # imm = 0x810B1A0B
	xorl	%edi, %esi
	movl	%ecx, %edi
	shll	$14, %edi
	sarl	$31, %edi
	andl	$-1064989435, %edi      # imm = 0xC0858D05
	xorl	%esi, %edi
	movl	%ecx, %esi
	shll	$15, %esi
	sarl	$31, %esi
	andl	$-532494718, %esi       # imm = 0xE042C682
	xorl	%edi, %esi
	xorl	%edx, %esi
	movswl	%cx, %edx
	sarl	$15, %edx
	andl	$1881236289, %edx       # imm = 0x70216341
	movl	%ecx, %edi
	shll	$17, %edi
	sarl	$31, %edi
	andl	$-1206865504, %edi      # imm = 0xB810B1A0
	xorl	%edx, %edi
	movl	%ecx, %edx
	shll	$18, %edx
	sarl	$31, %edx
	andl	$1544050896, %edx       # imm = 0x5C0858D0
	xorl	%edi, %edx
	movl	%ecx, %edi
	shll	$19, %edi
	sarl	$31, %edi
	andl	$772025448, %edi        # imm = 0x2E042C68
	xorl	%edx, %edi
	movl	%ecx, %ebp
	shll	$20, %ebp
	sarl	$31, %ebp
	andl	$386012724, %ebp        # imm = 0x17021634
	xorl	%edi, %ebp
	movl	%ecx, %edx
	shll	$21, %edx
	sarl	$31, %edx
	andl	$193006362, %edx        # imm = 0xB810B1A
	xorl	%ebp, %edx
	xorl	%esi, %edx
	movl	%ecx, %esi
	shll	$22, %esi
	sarl	$31, %esi
	andl	$96503181, %esi         # imm = 0x5C0858D
	movl	%ecx, %edi
	shll	$23, %edi
	sarl	$31, %edi
	andl	$-2099232058, %edi      # imm = 0x82E042C6
	xorl	%esi, %edi
	movsbl	%cl, %esi
	sarl	$7, %esi
	andl	$1097867619, %esi       # imm = 0x41702163
	xorl	%edi, %esi
	movl	%ecx, %edi
	shll	$25, %edi
	sarl	$31, %edi
	andl	$-1598549839, %edi      # imm = 0xA0B810B1
	xorl	%esi, %edi
	movl	%ecx, %esi
	shll	$26, %esi
	sarl	$31, %esi
	andl	$-799274920, %esi       # imm = 0xD05C0858
	xorl	%edi, %esi
	movl	%ecx, %edi
	shll	$27, %edi
	sarl	$31, %edi
	andl	$1747846188, %edi       # imm = 0x682E042C
	xorl	%esi, %edi
	movl	%ecx, %esi
	shll	$28, %esi
	sarl	$31, %esi
	andl	$873923094, %esi        # imm = 0x34170216
	xorl	%edi, %esi
	xorl	%edx, %esi
	movl	%ecx, %edx
	shll	$29, %edx
	sarl	$31, %edx
	andl	$436961547, %edx        # imm = 0x1A0B810B
	movl	%ecx, %edi
	shll	$30, %edi
	sarl	$31, %edi
	andl	$-1929002875, %edi      # imm = 0x8D05C085
	xorl	%edx, %edi
	andl	$1, %ecx
	negl	%ecx
	andl	$-964501438, %ecx       # imm = 0xC682E042
	xorl	%edi, %ecx
	xorl	%esi, %ecx
	movl	176(%rsp), %edx
	movl	%edx, %esi
	sarl	$31, %esi
	andl	$1764553344, %esi       # imm = 0x692CF280
	leal	(%rdx,%rdx), %edi
	sarl	$31, %edi
	andl	$882276672, %edi        # imm = 0x34967940
	xorl	%esi, %edi
	leal	(,%rdx,4), %esi
	sarl	$31, %esi
	andl	$441138336, %esi        # imm = 0x1A4B3CA0
	leal	(,%rdx,8), %ebp
	sarl	$31, %ebp
	andl	$220569168, %ebp        # imm = 0xD259E50
	xorl	%esi, %ebp
	xorl	%edi, %ebp
	movl	%edx, %esi
	shll	$4, %esi
	sarl	$31, %esi
	andl	$110284584, %esi        # imm = 0x692CF28
	movl	%edx, %ebx
	shll	$5, %ebx
	sarl	$31, %ebx
	andl	$55142292, %ebx         # imm = 0x3496794
	xorl	%esi, %ebx
	movl	%edx, %edi
	shll	$6, %edi
	sarl	$31, %edi
	andl	$27571146, %edi         # imm = 0x1A4B3CA
	xorl	%ebx, %edi
	xorl	%ebp, %edi
	movl	%edx, %esi
	shll	$7, %esi
	sarl	$31, %esi
	andl	$13785573, %esi         # imm = 0xD259E5
	movl	%edx, %ebp
	shll	$8, %ebp
	sarl	$31, %ebp
	andl	$-2140590862, %ebp      # imm = 0x80692CF2
	xorl	%esi, %ebp
	movl	%edx, %ebx
	shll	$9, %ebx
	sarl	$31, %ebx
	andl	$1077188217, %ebx       # imm = 0x40349679
	xorl	%ebp, %ebx
	movl	%edx, %esi
	shll	$10, %esi
	sarl	$31, %esi
	andl	$-1608889540, %esi      # imm = 0xA01A4B3C
	xorl	%ebx, %esi
	xorl	%edi, %esi
	movl	%edx, %edi
	shll	$11, %edi
	sarl	$31, %edi
	andl	$1343038878, %edi       # imm = 0x500D259E
	movl	%edx, %ebp
	shll	$12, %ebp
	sarl	$31, %ebp
	andl	$671519439, %ebp        # imm = 0x280692CF
	xorl	%edi, %ebp
	movl	%edx, %edi
	shll	$13, %edi
	sarl	$31, %edi
	andl	$-1811723929, %edi      # imm = 0x94034967
	xorl	%ebp, %edi
	movl	%edx, %ebp
	shll	$14, %ebp
	sarl	$31, %ebp
	andl	$-905861965, %ebp       # imm = 0xCA01A4B3
	xorl	%edi, %ebp
	movl	%edx, %edi
	shll	$15, %edi
	sarl	$31, %edi
	andl	$-452930983, %edi       # imm = 0xE500D259
	xorl	%ebp, %edi
	xorl	%esi, %edi
	movswl	%dx, %esi
	sarl	$15, %esi
	andl	$-226465492, %esi       # imm = 0xF280692C
	movl	%edx, %ebp
	shll	$17, %ebp
	sarl	$31, %ebp
	andl	$2034250902, %ebp       # imm = 0x79403496
	xorl	%esi, %ebp
	movl	%edx, %esi
	shll	$18, %esi
	sarl	$31, %esi
	andl	$1017125451, %esi       # imm = 0x3CA01A4B
	xorl	%ebp, %esi
	movl	%edx, %ebp
	shll	$19, %ebp
	sarl	$31, %ebp
	andl	$-1638920923, %ebp      # imm = 0x9E500D25
	xorl	%esi, %ebp
	movl	%edx, %ebx
	shll	$20, %ebx
	sarl	$31, %ebx
	andl	$-819460462, %ebx       # imm = 0xCF280692
	xorl	%ebp, %ebx
	movl	%edx, %esi
	shll	$21, %esi
	sarl	$31, %esi
	andl	$1737753417, %esi       # imm = 0x67940349
	xorl	%ebx, %esi
	xorl	%edi, %esi
	movl	%edx, %edi
	shll	$22, %edi
	sarl	$31, %edi
	andl	$-1278606940, %edi      # imm = 0xB3CA01A4
	movl	%edx, %ebp
	shll	$23, %ebp
	sarl	$31, %ebp
	andl	$1508180178, %ebp       # imm = 0x59E500D2
	xorl	%edi, %ebp
	movsbl	%dl, %edi
	sarl	$7, %edi
	andl	$754090089, %edi        # imm = 0x2CF28069
	xorl	%ebp, %edi
	movl	%edx, %ebp
	shll	$25, %ebp
	sarl	$31, %ebp
	andl	$-1770438604, %ebp      # imm = 0x96794034
	xorl	%edi, %ebp
	movl	%edx, %edi
	shll	$26, %edi
	sarl	$31, %edi
	andl	$1262264346, %edi       # imm = 0x4B3CA01A
	xorl	%ebp, %edi
	movl	%edx, %ebp
	shll	$27, %ebp
	sarl	$31, %ebp
	andl	$631132173, %ebp        # imm = 0x259E500D
	xorl	%edi, %ebp
	movl	%edx, %edi
	shll	$28, %edi
	sarl	$31, %edi
	andl	$-1831917562, %edi      # imm = 0x92CF2806
	xorl	%ebp, %edi
	xorl	%esi, %edi
	movl	%edx, %esi
	shll	$29, %esi
	sarl	$31, %esi
	andl	$1231524867, %esi       # imm = 0x49679403
	movl	%edx, %ebp
	shll	$30, %ebp
	sarl	$31, %ebp
	andl	$-1531721215, %ebp      # imm = 0xA4B3CA01
	xorl	%esi, %ebp
	andl	$1, %edx
	negl	%edx
	andl	$-765860608, %edx       # imm = 0xD259E500
	xorl	%ebp, %edx
	xorl	%edi, %edx
	movl	192(%rsp), %esi
	movl	%esi, %edi
	sarl	$31, %edi
	andl	$1218791443, %edi       # imm = 0x48A54813
	leal	(%rsi,%rsi), %ebp
	sarl	$31, %ebp
	andl	$-1538087927, %ebp      # imm = 0xA452A409
	xorl	%edi, %ebp
	leal	(,%rsi,4), %edi
	sarl	$31, %edi
	andl	$-769043964, %edi       # imm = 0xD2295204
	leal	(,%rsi,8), %ebx
	sarl	$31, %ebx
	andl	$1762961666, %ebx       # imm = 0x6914A902
	xorl	%edi, %ebx
	xorl	%ebp, %ebx
	movl	%esi, %edi
	shll	$4, %edi
	sarl	$31, %edi
	andl	$881480833, %edi        # imm = 0x348A5481
	movl	%esi, %eax
	shll	$5, %eax
	sarl	$31, %eax
	andl	$-1706743232, %eax      # imm = 0x9A452A40
	xorl	%edi, %eax
	movl	%esi, %ebp
	shll	$6, %ebp
	sarl	$31, %ebp
	andl	$1294112032, %ebp       # imm = 0x4D229520
	xorl	%eax, %ebp
	xorl	%ebx, %ebp
	movl	%esi, %eax
	shll	$7, %eax
	sarl	$31, %eax
	andl	$647056016, %eax        # imm = 0x26914A90
	movl	%esi, %edi
	shll	$8, %edi
	sarl	$31, %edi
	andl	$323528008, %edi        # imm = 0x1348A548
	xorl	%eax, %edi
	movl	%esi, %eax
	shll	$9, %eax
	sarl	$31, %eax
	andl	$161764004, %eax        # imm = 0x9A452A4
	xorl	%edi, %eax
	movl	%esi, %edi
	shll	$10, %edi
	sarl	$31, %edi
	andl	$80882002, %edi         # imm = 0x4D22952
	xorl	%eax, %edi
	xorl	%ebp, %edi
	movl	%esi, %eax
	shll	$11, %eax
	sarl	$31, %eax
	andl	$40441001, %eax         # imm = 0x26914A9
	movl	%esi, %ebp
	shll	$12, %ebp
	sarl	$31, %ebp
	andl	$-2127263148, %ebp      # imm = 0x81348A54
	xorl	%eax, %ebp
	movl	%esi, %eax
	shll	$13, %eax
	sarl	$31, %eax
	andl	$1083852074, %eax       # imm = 0x409A452A
	xorl	%ebp, %eax
	movl	%esi, %ebx
	shll	$14, %ebx
	sarl	$31, %ebx
	andl	$541926037, %ebx        # imm = 0x204D2295
	xorl	%eax, %ebx
	movl	%esi, %ebp
	shll	$15, %ebp
	sarl	$31, %ebp
	andl	$-1876520630, %ebp      # imm = 0x9026914A
	xorl	%ebx, %ebp
	xorl	%edi, %ebp
	movswl	%si, %eax
	sarl	$15, %eax
	andl	$1209223333, %eax       # imm = 0x481348A5
	movl	%esi, %edi
	shll	$17, %edi
	sarl	$31, %edi
	andl	$-1542871982, %edi      # imm = 0xA409A452
	xorl	%eax, %edi
	movl	%esi, %eax
	shll	$18, %eax
	sarl	$31, %eax
	andl	$1376047657, %eax       # imm = 0x5204D229
	xorl	%edi, %eax
	movl	%esi, %edi
	shll	$19, %edi
	sarl	$31, %edi
	andl	$-1459459820, %edi      # imm = 0xA9026914
	xorl	%eax, %edi
	movl	%esi, %eax
	shll	$20, %eax
	sarl	$31, %eax
	andl	$1417753738, %eax       # imm = 0x5481348A
	xorl	%edi, %eax
	movl	%esi, %edi
	shll	$21, %edi
	sarl	$31, %edi
	andl	$708876869, %edi        # imm = 0x2A409A45
	xorl	%eax, %edi
	xorl	%ebp, %edi
	movl	%esi, %eax
	shll	$22, %eax
	sarl	$31, %eax
	andl	$-1793045214, %eax      # imm = 0x95204D22
	movl	%esi, %ebp
	shll	$23, %ebp
	sarl	$31, %ebp
	andl	$1250961041, %ebp       # imm = 0x4A902691
	xorl	%eax, %ebp
	movsbl	%sil, %eax
	sarl	$7, %eax
	andl	$-1522003128, %eax      # imm = 0xA5481348
	xorl	%ebp, %eax
	movl	%esi, %ebp
	shll	$25, %ebp
	sarl	$31, %ebp
	andl	$1386482084, %ebp       # imm = 0x52A409A4
	xorl	%eax, %ebp
	movl	%esi, %eax
	shll	$26, %eax
	sarl	$31, %eax
	andl	$693241042, %eax        # imm = 0x295204D2
	xorl	%ebp, %eax
	movl	%esi, %ebx
	shll	$27, %ebx
	sarl	$31, %ebx
	andl	$346620521, %ebx        # imm = 0x14A90269
	xorl	%eax, %ebx
	movl	%esi, %ebp
	shll	$28, %ebp
	sarl	$31, %ebp
	andl	$-1974173388, %ebp      # imm = 0x8A548134
	xorl	%ebx, %ebp
	xorl	%edi, %ebp
	movl	%esi, %eax
	shll	$29, %eax
	sarl	$31, %eax
	andl	$1160396954, %eax       # imm = 0x452A409A
	movl	%esi, %edi
	shll	$30, %edi
	sarl	$31, %edi
	andl	$580198477, %edi        # imm = 0x2295204D
	xorl	%eax, %edi
	andl	$1, %esi
	negl	%esi
	andl	$-1857384410, %esi      # imm = 0x914A9026
	xorl	%edi, %esi
	xorl	%ebp, %esi
	vmovd	%r8d, %xmm0
	vextracti128	$1, %ymm0, %xmm1
	vpinsrd	$0, %ecx, %xmm1, %xmm1
	vmovd	%edx, %xmm2
	vextracti128	$1, %ymm2, %xmm3
	vpinsrd	$0, %esi, %xmm3, %xmm3
	vinserti128	$1, %xmm1, %ymm0, %ymm0
	vinserti128	$1, %xmm3, %ymm2, %ymm1
	addq	$64, %r15
	cmpq	$928, %r15              # imm = 0x3A0
	jne	.LBB5_1
# %bb.2:
	movl	%r8d, (%rsp)
	movq	$0, 4(%rsp)
	movl	$0, 12(%rsp)
	movl	%ecx, 16(%rsp)
	movq	$0, 20(%rsp)
	movl	$0, 28(%rsp)
	movl	%edx, 32(%rsp)
	movq	$0, 36(%rsp)
	movl	$0, 44(%rsp)
	movl	%esi, 48(%rsp)
	movq	$0, 52(%rsp)
	movl	$0, 60(%rsp)
	xorl	896(%r13), %r8d
	movq	72(%rsp), %rcx          # 8-byte Reload
	movl	%r8d, (%rcx)
	movl	900(%r13), %eax
	xorl	4(%rsp), %eax
	movl	%eax, 4(%rcx)
	movl	904(%r13), %eax
	xorl	8(%rsp), %eax
	movl	%eax, 8(%rcx)
	movl	908(%r13), %eax
	xorl	12(%rsp), %eax
	movl	%eax, 12(%rcx)
	movl	912(%r13), %eax
	xorl	16(%rsp), %eax
	movl	%eax, 16(%rcx)
	movl	916(%r13), %eax
	xorl	20(%rsp), %eax
	movl	%eax, 20(%rcx)
	movl	920(%r13), %eax
	xorl	24(%rsp), %eax
	movl	%eax, 24(%rcx)
	movl	924(%r13), %eax
	xorl	28(%rsp), %eax
	movl	%eax, 28(%rcx)
	movl	928(%r13), %eax
	xorl	32(%rsp), %eax
	movl	%eax, 32(%rcx)
	movl	932(%r13), %eax
	xorl	36(%rsp), %eax
	movl	%eax, 36(%rcx)
	movl	936(%r13), %eax
	xorl	40(%rsp), %eax
	movl	%eax, 40(%rcx)
	movl	940(%r13), %eax
	xorl	44(%rsp), %eax
	movl	%eax, 44(%rcx)
	xorl	944(%r13), %esi
	movl	%esi, 48(%rcx)
	movl	948(%r13), %eax
	movl	%eax, 52(%rcx)
	movl	952(%r13), %eax
	movl	%eax, 56(%rcx)
	movl	956(%r13), %eax
	movl	%eax, 60(%rcx)
	addq	$216, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	vzeroupper
	retq
.Lfunc_end5:
	.size	pyjamask__, .Lfunc_end5-pyjamask__
	.cfi_endproc
                                        # -- End function
	.globl	bench_speed             # -- Begin function bench_speed
	.p2align	4, 0x90
	.type	bench_speed,@function
bench_speed:                            # @bench_speed
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	andq	$-32, %rsp
	subq	$1120, %rsp             # imm = 0x460
	.cfi_offset %rbx, -24
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, 96(%rsp)
	vmovaps	%ymm0, 64(%rsp)
	leaq	128(%rsp), %rbx
	xorl	%esi, %esi
	movl	$960, %edx              # imm = 0x3C0
	movq	%rbx, %rdi
	vzeroupper
	callq	memset
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, 32(%rsp)
	vmovaps	%ymm0, (%rsp)
	leaq	64(%rsp), %rdi
	movq	%rsp, %rdx
	movq	%rbx, %rsi
	vzeroupper
	callq	pyjamask__
	movl	$16, %eax
	leaq	-8(%rbp), %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	bench_speed, .Lfunc_end6-bench_speed
	.cfi_endproc
                                        # -- End function

	.ident	"clang version 7.0.0- (trunk)"
	.section	".note.GNU-stack","",@progbits
