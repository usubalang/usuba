
	.globl	AES__                   # -- Begin function AES__
	.p2align	4, 0x90
	.type	AES__,@function
AES__:                                  # @AES__
	.cfi_startproc
# %bb.0:
	vxorps	(%rdi), %xmm0, %xmm0
	vxorps	16(%rdi), %xmm1, %xmm1
	vxorps	32(%rdi), %xmm2, %xmm2
	vxorps	48(%rdi), %xmm3, %xmm3
	vxorps	64(%rdi), %xmm4, %xmm4
	vxorps	80(%rdi), %xmm5, %xmm8
	vxorps	96(%rdi), %xmm6, %xmm5
	vxorps	112(%rdi), %xmm7, %xmm6
	vmovaps	%xmm8, %xmm7
	movl	$240, %eax
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	#APP
	vmovdqa	Lshiftrow_shuf(%rip), %xmm8
	vpshufb	%xmm8, %xmm0, %xmm0
	vpshufb	%xmm8, %xmm1, %xmm1
	vpshufb	%xmm8, %xmm2, %xmm2
	vpshufb	%xmm8, %xmm3, %xmm3
	vpshufb	%xmm8, %xmm4, %xmm4
	vpshufb	%xmm8, %xmm7, %xmm7
	vpshufb	%xmm8, %xmm5, %xmm5
	vpshufb	%xmm8, %xmm6, %xmm6
	vpxor	%xmm5, %xmm7, %xmm7
	vpxor	%xmm1, %xmm2, %xmm2
	vpxor	%xmm0, %xmm7, %xmm8
	vpxor	%xmm2, %xmm5, %xmm5
	vpxor	%xmm0, %xmm3, %xmm3
	vpxor	%xmm3, %xmm5, %xmm5
	vpxor	%xmm6, %xmm3, %xmm3
	vpxor	%xmm8, %xmm6, %xmm6
	vpxor	%xmm4, %xmm3, %xmm3
	vpxor	%xmm8, %xmm4, %xmm4
	vpxor	%xmm1, %xmm3, %xmm3
	vpxor	%xmm6, %xmm2, %xmm2
	vpxor	%xmm8, %xmm1, %xmm1
	vpxor	%xmm6, %xmm4, %xmm11
	vpxor	%xmm1, %xmm2, %xmm10
	vpxor	%xmm8, %xmm3, %xmm9
	vpxor	%xmm2, %xmm4, %xmm13
	vpxor	%xmm5, %xmm0, %xmm12
	vpxor	%xmm11, %xmm10, %xmm15
	vpand	%xmm10, %xmm9, %xmm7
	vpor	%xmm9, %xmm10, %xmm10
	vpand	%xmm11, %xmm12, %xmm14
	vpor	%xmm12, %xmm11, %xmm11
	vpxor	%xmm9, %xmm12, %xmm12
	vpand	%xmm12, %xmm15, %xmm15
	vpxor	%xmm3, %xmm0, %xmm12
	vpand	%xmm12, %xmm13, %xmm13
	vpxor	%xmm13, %xmm11, %xmm11
	vpxor	%xmm13, %xmm10, %xmm10
	vpxor	%xmm6, %xmm1, %xmm13
	vpxor	%xmm8, %xmm5, %xmm12
	vpor	%xmm13, %xmm12, %xmm9
	vpand	%xmm12, %xmm13, %xmm13
	vpxor	%xmm13, %xmm7, %xmm7
	vpxor	%xmm15, %xmm11, %xmm11
	vpxor	%xmm14, %xmm10, %xmm10
	vpxor	%xmm15, %xmm9, %xmm9
	vpxor	%xmm14, %xmm7, %xmm7
	vpxor	%xmm14, %xmm9, %xmm9
	vpand	%xmm2, %xmm3, %xmm12
	vpand	%xmm4, %xmm0, %xmm13
	vpand	%xmm1, %xmm8, %xmm14
	vpor	%xmm6, %xmm5, %xmm15
	vpxor	%xmm12, %xmm11, %xmm11
	vpxor	%xmm13, %xmm10, %xmm10
	vpxor	%xmm14, %xmm9, %xmm9
	vpxor	%xmm15, %xmm7, %xmm7
	vpxor	%xmm11, %xmm10, %xmm12
	vpand	%xmm9, %xmm11, %xmm11
	vpxor	%xmm7, %xmm11, %xmm14
	vpand	%xmm12, %xmm14, %xmm15
	vpxor	%xmm10, %xmm15, %xmm15
	vpxor	%xmm9, %xmm7, %xmm13
	vpxor	%xmm10, %xmm11, %xmm11
	vpand	%xmm11, %xmm13, %xmm13
	vpxor	%xmm7, %xmm13, %xmm13
	vpxor	%xmm13, %xmm9, %xmm9
	vpxor	%xmm14, %xmm13, %xmm10
	vpand	%xmm7, %xmm10, %xmm10
	vpxor	%xmm10, %xmm9, %xmm9
	vpxor	%xmm10, %xmm14, %xmm14
	vpand	%xmm15, %xmm14, %xmm14
	vpxor	%xmm12, %xmm14, %xmm14
	vpxor	%xmm15, %xmm14, %xmm10
	vpand	%xmm5, %xmm10, %xmm10
	vpxor	%xmm5, %xmm8, %xmm12
	vpand	%xmm14, %xmm12, %xmm12
	vpand	%xmm8, %xmm15, %xmm7
	vpxor	%xmm7, %xmm12, %xmm12
	vpxor	%xmm10, %xmm7, %xmm7
	vpxor	%xmm0, %xmm5, %xmm5
	vpxor	%xmm3, %xmm8, %xmm8
	vpxor	%xmm13, %xmm15, %xmm15
	vpxor	%xmm9, %xmm14, %xmm14
	vpxor	%xmm15, %xmm14, %xmm11
	vpand	%xmm5, %xmm11, %xmm11
	vpxor	%xmm8, %xmm5, %xmm5
	vpand	%xmm14, %xmm5, %xmm5
	vpand	%xmm15, %xmm8, %xmm8
	vpxor	%xmm5, %xmm8, %xmm8
	vpxor	%xmm11, %xmm5, %xmm5
	vpxor	%xmm13, %xmm9, %xmm10
	vpand	%xmm0, %xmm10, %xmm10
	vpxor	%xmm0, %xmm3, %xmm0
	vpand	%xmm9, %xmm0, %xmm0
	vpand	%xmm3, %xmm13, %xmm3
	vpxor	%xmm3, %xmm0, %xmm0
	vpxor	%xmm10, %xmm3, %xmm3
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm12, %xmm5, %xmm5
	vpxor	%xmm8, %xmm3, %xmm3
	vpxor	%xmm7, %xmm8, %xmm8
	vpxor	%xmm6, %xmm4, %xmm12
	vpxor	%xmm1, %xmm2, %xmm7
	vpxor	%xmm15, %xmm14, %xmm11
	vpand	%xmm12, %xmm11, %xmm11
	vpxor	%xmm7, %xmm12, %xmm12
	vpand	%xmm14, %xmm12, %xmm12
	vpand	%xmm15, %xmm7, %xmm7
	vpxor	%xmm12, %xmm7, %xmm7
	vpxor	%xmm11, %xmm12, %xmm12
	vpxor	%xmm13, %xmm9, %xmm10
	vpand	%xmm4, %xmm10, %xmm10
	vpxor	%xmm4, %xmm2, %xmm4
	vpand	%xmm9, %xmm4, %xmm4
	vpand	%xmm2, %xmm13, %xmm2
	vpxor	%xmm2, %xmm4, %xmm4
	vpxor	%xmm10, %xmm2, %xmm2
	vpxor	%xmm13, %xmm15, %xmm15
	vpxor	%xmm9, %xmm14, %xmm14
	vpxor	%xmm15, %xmm14, %xmm11
	vpand	%xmm6, %xmm11, %xmm11
	vpxor	%xmm6, %xmm1, %xmm6
	vpand	%xmm14, %xmm6, %xmm6
	vpand	%xmm1, %xmm15, %xmm1
	vpxor	%xmm1, %xmm6, %xmm6
	vpxor	%xmm11, %xmm1, %xmm1
	vpxor	%xmm12, %xmm6, %xmm6
	vpxor	%xmm12, %xmm4, %xmm4
	vpxor	%xmm7, %xmm1, %xmm1
	vpxor	%xmm7, %xmm2, %xmm2
	vpxor	%xmm6, %xmm0, %xmm7
	vpxor	%xmm1, %xmm5, %xmm9
	vpxor	%xmm4, %xmm7, %xmm10
	vpxor	%xmm5, %xmm0, %xmm12
	vpxor	%xmm0, %xmm9, %xmm0
	vpxor	%xmm8, %xmm9, %xmm1
	vpxor	%xmm8, %xmm2, %xmm6
	vpxor	%xmm2, %xmm3, %xmm5
	vpxor	%xmm10, %xmm6, %xmm2
	vpxor	%xmm3, %xmm6, %xmm4
	vpxor	%xmm12, %xmm4, %xmm3
	vmovdqa	Lror_byte_1_shuf, %xmm14
	vmovdqa	Lror_byte_2_shuf, %xmm15
	vpshufb	%xmm14, %xmm0, %xmm8
	vpxor	%xmm0, %xmm8, %xmm0
	vpshufb	%xmm14, %xmm1, %xmm9
	vpxor	%xmm1, %xmm9, %xmm1
	vpshufb	%xmm14, %xmm2, %xmm10
	vpxor	%xmm2, %xmm10, %xmm2
	vpshufb	%xmm14, %xmm3, %xmm11
	vpxor	%xmm3, %xmm11, %xmm3
	vpxor	%xmm0, %xmm9, %xmm9
	vpshufb	%xmm15, %xmm0, %xmm0
	vpxor	%xmm1, %xmm10, %xmm10
	vpshufb	%xmm15, %xmm1, %xmm1
	vpxor	%xmm2, %xmm11, %xmm11
	vpshufb	%xmm15, %xmm2, %xmm2
	vpxor	%xmm2, %xmm10, %xmm2
	vpshufb	%xmm14, %xmm6, %xmm10
	vpxor	%xmm6, %xmm10, %xmm6
	vpshufb	%xmm14, %xmm4, %xmm12
	vpxor	%xmm4, %xmm12, %xmm4
	vpshufb	%xmm14, %xmm7, %xmm13
	vpxor	%xmm7, %xmm13, %xmm7
	vpshufb	%xmm14, %xmm5, %xmm14
	vpxor	%xmm5, %xmm14, %xmm5
	vpxor	%xmm3, %xmm12, %xmm12
	vpshufb	%xmm15, %xmm3, %xmm3
	vpxor	%xmm4, %xmm13, %xmm13
	vpshufb	%xmm15, %xmm4, %xmm4
	vpxor	%xmm7, %xmm14, %xmm14
	vpshufb	%xmm15, %xmm7, %xmm7
	vpxor	%xmm7, %xmm13, %xmm7
	vpxor	%xmm5, %xmm10, %xmm10
	vpshufb	%xmm15, %xmm5, %xmm5
	vpxor	%xmm5, %xmm14, %xmm5
	vpxor	%xmm6, %xmm8, %xmm8
	vpxor	%xmm0, %xmm8, %xmm0
	vpxor	%xmm6, %xmm9, %xmm9
	vpxor	%xmm1, %xmm9, %xmm1
	vpxor	%xmm6, %xmm11, %xmm11
	vpxor	%xmm3, %xmm11, %xmm3
	vpxor	%xmm6, %xmm12, %xmm12
	vpxor	%xmm4, %xmm12, %xmm4
	vpshufb	%xmm15, %xmm6, %xmm6
	vpxor	%xmm6, %xmm10, %xmm6

	#NO_APP
	vxorps	-112(%rdi,%rax), %xmm0, %xmm0
	vxorps	-96(%rdi,%rax), %xmm1, %xmm1
	vxorps	-80(%rdi,%rax), %xmm2, %xmm2
	vxorps	-64(%rdi,%rax), %xmm3, %xmm3
	vxorps	-48(%rdi,%rax), %xmm4, %xmm4
	vxorps	-32(%rdi,%rax), %xmm7, %xmm7
	vxorps	-16(%rdi,%rax), %xmm5, %xmm5
	vxorps	(%rdi,%rax), %xmm6, %xmm6
	subq	$-128, %rax
	cmpq	$1392, %rax             # imm = 0x570
	jne	.LBB1_1
# %bb.2:
	#APP
	vmovdqa	Lshiftrow_shuf(%rip), %xmm8
	vpshufb	%xmm8, %xmm0, %xmm0
	vpshufb	%xmm8, %xmm1, %xmm1
	vpshufb	%xmm8, %xmm2, %xmm2
	vpshufb	%xmm8, %xmm3, %xmm3
	vpshufb	%xmm8, %xmm4, %xmm4
	vpshufb	%xmm8, %xmm7, %xmm7
	vpshufb	%xmm8, %xmm5, %xmm5
	vpshufb	%xmm8, %xmm6, %xmm6
	vpxor	%xmm5, %xmm7, %xmm7
	vpxor	%xmm1, %xmm2, %xmm2
	vpxor	%xmm0, %xmm7, %xmm8
	vpxor	%xmm2, %xmm5, %xmm5
	vpxor	%xmm0, %xmm3, %xmm3
	vpxor	%xmm3, %xmm5, %xmm5
	vpxor	%xmm6, %xmm3, %xmm3
	vpxor	%xmm8, %xmm6, %xmm6
	vpxor	%xmm4, %xmm3, %xmm3
	vpxor	%xmm8, %xmm4, %xmm4
	vpxor	%xmm1, %xmm3, %xmm3
	vpxor	%xmm6, %xmm2, %xmm2
	vpxor	%xmm8, %xmm1, %xmm1
	vpxor	%xmm6, %xmm4, %xmm11
	vpxor	%xmm1, %xmm2, %xmm10
	vpxor	%xmm8, %xmm3, %xmm9
	vpxor	%xmm2, %xmm4, %xmm13
	vpxor	%xmm5, %xmm0, %xmm12
	vpxor	%xmm11, %xmm10, %xmm15
	vpand	%xmm10, %xmm9, %xmm7
	vpor	%xmm9, %xmm10, %xmm10
	vpand	%xmm11, %xmm12, %xmm14
	vpor	%xmm12, %xmm11, %xmm11
	vpxor	%xmm9, %xmm12, %xmm12
	vpand	%xmm12, %xmm15, %xmm15
	vpxor	%xmm3, %xmm0, %xmm12
	vpand	%xmm12, %xmm13, %xmm13
	vpxor	%xmm13, %xmm11, %xmm11
	vpxor	%xmm13, %xmm10, %xmm10
	vpxor	%xmm6, %xmm1, %xmm13
	vpxor	%xmm8, %xmm5, %xmm12
	vpor	%xmm13, %xmm12, %xmm9
	vpand	%xmm12, %xmm13, %xmm13
	vpxor	%xmm13, %xmm7, %xmm7
	vpxor	%xmm15, %xmm11, %xmm11
	vpxor	%xmm14, %xmm10, %xmm10
	vpxor	%xmm15, %xmm9, %xmm9
	vpxor	%xmm14, %xmm7, %xmm7
	vpxor	%xmm14, %xmm9, %xmm9
	vpand	%xmm2, %xmm3, %xmm12
	vpand	%xmm4, %xmm0, %xmm13
	vpand	%xmm1, %xmm8, %xmm14
	vpor	%xmm6, %xmm5, %xmm15
	vpxor	%xmm12, %xmm11, %xmm11
	vpxor	%xmm13, %xmm10, %xmm10
	vpxor	%xmm14, %xmm9, %xmm9
	vpxor	%xmm15, %xmm7, %xmm7
	vpxor	%xmm11, %xmm10, %xmm12
	vpand	%xmm9, %xmm11, %xmm11
	vpxor	%xmm7, %xmm11, %xmm14
	vpand	%xmm12, %xmm14, %xmm15
	vpxor	%xmm10, %xmm15, %xmm15
	vpxor	%xmm9, %xmm7, %xmm13
	vpxor	%xmm10, %xmm11, %xmm11
	vpand	%xmm11, %xmm13, %xmm13
	vpxor	%xmm7, %xmm13, %xmm13
	vpxor	%xmm13, %xmm9, %xmm9
	vpxor	%xmm14, %xmm13, %xmm10
	vpand	%xmm7, %xmm10, %xmm10
	vpxor	%xmm10, %xmm9, %xmm9
	vpxor	%xmm10, %xmm14, %xmm14
	vpand	%xmm15, %xmm14, %xmm14
	vpxor	%xmm12, %xmm14, %xmm14
	vpxor	%xmm15, %xmm14, %xmm10
	vpand	%xmm5, %xmm10, %xmm10
	vpxor	%xmm5, %xmm8, %xmm12
	vpand	%xmm14, %xmm12, %xmm12
	vpand	%xmm8, %xmm15, %xmm7
	vpxor	%xmm7, %xmm12, %xmm12
	vpxor	%xmm10, %xmm7, %xmm7
	vpxor	%xmm0, %xmm5, %xmm5
	vpxor	%xmm3, %xmm8, %xmm8
	vpxor	%xmm13, %xmm15, %xmm15
	vpxor	%xmm9, %xmm14, %xmm14
	vpxor	%xmm15, %xmm14, %xmm11
	vpand	%xmm5, %xmm11, %xmm11
	vpxor	%xmm8, %xmm5, %xmm5
	vpand	%xmm14, %xmm5, %xmm5
	vpand	%xmm15, %xmm8, %xmm8
	vpxor	%xmm5, %xmm8, %xmm8
	vpxor	%xmm11, %xmm5, %xmm5
	vpxor	%xmm13, %xmm9, %xmm10
	vpand	%xmm0, %xmm10, %xmm10
	vpxor	%xmm0, %xmm3, %xmm0
	vpand	%xmm9, %xmm0, %xmm0
	vpand	%xmm3, %xmm13, %xmm3
	vpxor	%xmm3, %xmm0, %xmm0
	vpxor	%xmm10, %xmm3, %xmm3
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm12, %xmm5, %xmm5
	vpxor	%xmm8, %xmm3, %xmm3
	vpxor	%xmm7, %xmm8, %xmm8
	vpxor	%xmm6, %xmm4, %xmm12
	vpxor	%xmm1, %xmm2, %xmm7
	vpxor	%xmm15, %xmm14, %xmm11
	vpand	%xmm12, %xmm11, %xmm11
	vpxor	%xmm7, %xmm12, %xmm12
	vpand	%xmm14, %xmm12, %xmm12
	vpand	%xmm15, %xmm7, %xmm7
	vpxor	%xmm12, %xmm7, %xmm7
	vpxor	%xmm11, %xmm12, %xmm12
	vpxor	%xmm13, %xmm9, %xmm10
	vpand	%xmm4, %xmm10, %xmm10
	vpxor	%xmm4, %xmm2, %xmm4
	vpand	%xmm9, %xmm4, %xmm4
	vpand	%xmm2, %xmm13, %xmm2
	vpxor	%xmm2, %xmm4, %xmm4
	vpxor	%xmm10, %xmm2, %xmm2
	vpxor	%xmm13, %xmm15, %xmm15
	vpxor	%xmm9, %xmm14, %xmm14
	vpxor	%xmm15, %xmm14, %xmm11
	vpand	%xmm6, %xmm11, %xmm11
	vpxor	%xmm6, %xmm1, %xmm6
	vpand	%xmm14, %xmm6, %xmm6
	vpand	%xmm1, %xmm15, %xmm1
	vpxor	%xmm1, %xmm6, %xmm6
	vpxor	%xmm11, %xmm1, %xmm1
	vpxor	%xmm12, %xmm6, %xmm6
	vpxor	%xmm12, %xmm4, %xmm4
	vpxor	%xmm7, %xmm1, %xmm1
	vpxor	%xmm7, %xmm2, %xmm2
	vpxor	%xmm6, %xmm0, %xmm7
	vpxor	%xmm1, %xmm5, %xmm9
	vpxor	%xmm4, %xmm7, %xmm10
	vpxor	%xmm5, %xmm0, %xmm12
	vpxor	%xmm0, %xmm9, %xmm0
	vpxor	%xmm8, %xmm9, %xmm1
	vpxor	%xmm8, %xmm2, %xmm6
	vpxor	%xmm2, %xmm3, %xmm8
	vpxor	%xmm10, %xmm6, %xmm2
	vpxor	%xmm3, %xmm6, %xmm4
	vpxor	%xmm12, %xmm4, %xmm3

	#NO_APP
    
	vxorps	1280(%rdi), %xmm0, %xmm0
	vxorps	1296(%rdi), %xmm1, %xmm1
	vxorps	1312(%rdi), %xmm2, %xmm2
	vxorps	1328(%rdi), %xmm3, %xmm3
	vxorps	1344(%rdi), %xmm4, %xmm4
	vxorps	1360(%rdi), %xmm7, %xmm5
	vxorps	1392(%rdi), %xmm6, %xmm7
	vxorps	1376(%rdi), %xmm8, %xmm6
    
//	vxorps	1280(%rdi), %xmm0, %xmm0
//	vmovaps	%xmm0, (%rsi)
//	vxorps	1296(%rdi), %xmm1, %xmm0
//	vmovaps	%xmm0, 16(%rsi)
//	vxorps	1312(%rdi), %xmm2, %xmm0
//	vmovaps	%xmm0, 32(%rsi)
//	vxorps	1328(%rdi), %xmm3, %xmm0
//	vmovaps	%xmm0, 48(%rsi)
//	vxorps	1344(%rdi), %xmm4, %xmm0
//	vmovaps	%xmm0, 64(%rsi)
//	vxorps	1360(%rdi), %xmm7, %xmm0
//	vmovaps	%xmm0, 80(%rsi)
//	vxorps	1376(%rdi), %xmm5, %xmm0
//	vmovaps	%xmm0, 96(%rsi)
//	vxorps	1392(%rdi), %xmm6, %xmm0
//	vmovaps	%xmm0, 112(%rsi)
	retq
.Lfunc_end1:
	.size	AES__, .Lfunc_end1-AES__
	.cfi_endproc
                                        # -- End function
	.type	Lshiftrow_shuf,@object  # @Lshiftrow_shuf
	.data
	.globl	Lshiftrow_shuf
	.p2align	4
Lshiftrow_shuf:
	.quad	220123344824567040      # 0x30e09040f0a0500
	.quad	794323535446281480      # 0xb06010c07020d08
	.size	Lshiftrow_shuf, 16

	.type	Lror_byte_1_shuf,@object # @Lror_byte_1_shuf
	.globl	Lror_byte_1_shuf
	.p2align	4
Lror_byte_1_shuf:
	.quad	290207319533486593      # 0x407060500030201
	.quad	868928702238099977      # 0xc0f0e0d080b0a09
	.size	Lror_byte_1_shuf, 16

	.type	Lror_byte_2_shuf,@object # @Lror_byte_2_shuf
	.globl	Lror_byte_2_shuf
	.p2align	4
Lror_byte_2_shuf:
	.quad	361421592464458498      # 0x504070601000302
	.quad	940142975169071882      # 0xd0c0f0e09080b0a
	.size	Lror_byte_2_shuf, 16

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%02hhx"
	.size	.L.str, 7


	.ident	"clang version 7.0.0-svn345401-1~exp1~20181026173340.32 (branches/release_70)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym Lshiftrow_shuf
	.addrsig_sym Lror_byte_1_shuf
	.addrsig_sym Lror_byte_2_shuf

