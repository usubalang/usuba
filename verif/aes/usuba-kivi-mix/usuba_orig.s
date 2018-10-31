	.p2align	4               # -- Begin function AES__
.LCPI0_0:
	.byte	0                       # 0x0
	.byte	5                       # 0x5
	.byte	10                      # 0xa
	.byte	15                      # 0xf
	.byte	4                       # 0x4
	.byte	9                       # 0x9
	.byte	14                      # 0xe
	.byte	3                       # 0x3
	.byte	8                       # 0x8
	.byte	13                      # 0xd
	.byte	2                       # 0x2
	.byte	7                       # 0x7
	.byte	12                      # 0xc
	.byte	1                       # 0x1
	.byte	6                       # 0x6
	.byte	11                      # 0xb
.LCPI0_1:
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	0                       # 0x0
	.byte	5                       # 0x5
	.byte	6                       # 0x6
	.byte	7                       # 0x7
	.byte	4                       # 0x4
	.byte	9                       # 0x9
	.byte	10                      # 0xa
	.byte	11                      # 0xb
	.byte	8                       # 0x8
	.byte	13                      # 0xd
	.byte	14                      # 0xe
	.byte	15                      # 0xf
	.byte	12                      # 0xc
.LCPI0_2:
	.byte	2                       # 0x2
	.byte	3                       # 0x3
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	6                       # 0x6
	.byte	7                       # 0x7
	.byte	4                       # 0x4
	.byte	5                       # 0x5
	.byte	10                      # 0xa
	.byte	11                      # 0xb
	.byte	8                       # 0x8
	.byte	9                       # 0x9
	.byte	14                      # 0xe
	.byte	15                      # 0xf
	.byte	12                      # 0xc
	.byte	13                      # 0xd
	.text
	.globl	AES__
	.p2align	4, 0x90
	.type	AES__,@function
AES__:                                  # @AES__
	.cfi_startproc
# %bb.0:
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	vpxor	(%rdi), %xmm0, %xmm12
	vpxor	16(%rdi), %xmm1, %xmm8
	vpxor	32(%rdi), %xmm2, %xmm9
	vpxor	48(%rdi), %xmm3, %xmm15
	vpxor	64(%rdi), %xmm4, %xmm13
	vpxor	80(%rdi), %xmm5, %xmm0
	vpxor	96(%rdi), %xmm6, %xmm14
	vpxor	112(%rdi), %xmm7, %xmm3
	movq	$-1152, %rax            # imm = 0xFB80
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
	vmovdqa	.LCPI0_1(%rip), %xmm9   # xmm9 = [1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12]
	vpshufb	%xmm9, %xmm5, %xmm8
	vpxor	%xmm5, %xmm8, %xmm5
	vpshufb	%xmm9, %xmm4, %xmm0
	vpxor	%xmm5, %xmm0, %xmm1
	vpxor	%xmm4, %xmm0, %xmm0
	vmovdqa	.LCPI0_2(%rip), %xmm15  # xmm15 = [2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13]
	vpshufb	%xmm15, %xmm0, %xmm4
	vpxor	%xmm4, %xmm1, %xmm10
	vpshufb	%xmm9, %xmm7, %xmm1
	vpxor	%xmm7, %xmm1, %xmm4
	vpshufb	%xmm15, %xmm4, %xmm11
	vpxor	%xmm5, %xmm1, %xmm1
	vpxor	%xmm0, %xmm1, %xmm14
	vpshufb	%xmm9, %xmm6, %xmm0
	vpxor	%xmm4, %xmm0, %xmm1
	vpxor	%xmm6, %xmm0, %xmm0
	vpshufb	%xmm15, %xmm0, %xmm4
	vpxor	%xmm4, %xmm1, %xmm1
	vpshufb	%xmm9, %xmm3, %xmm4
	vpxor	%xmm3, %xmm4, %xmm3
	vpxor	%xmm5, %xmm4, %xmm4
	vpxor	%xmm0, %xmm4, %xmm0
	vpshufb	%xmm15, %xmm3, %xmm4
	vpxor	%xmm4, %xmm0, %xmm0
	vpshufb	%xmm9, %xmm2, %xmm4
	vpxor	%xmm2, %xmm4, %xmm2
	vpxor	%xmm5, %xmm4, %xmm4
	vpxor	%xmm3, %xmm4, %xmm3
	vpshufb	%xmm15, %xmm2, %xmm4
	vpxor	%xmm4, %xmm3, %xmm3
	vpshufb	%xmm9, %xmm13, %xmm4
	vpxor	%xmm4, %xmm2, %xmm2
	vpxor	%xmm13, %xmm4, %xmm4
	vpshufb	%xmm15, %xmm4, %xmm6
	vpxor	%xmm6, %xmm2, %xmm2
	vpshufb	%xmm9, %xmm12, %xmm6
	vpxor	%xmm6, %xmm4, %xmm4
	vpxor	%xmm12, %xmm6, %xmm6
	vpshufb	%xmm15, %xmm6, %xmm7
	vpxor	%xmm7, %xmm4, %xmm4
	vpxor	%xmm8, %xmm6, %xmm6
	vpshufb	%xmm15, %xmm5, %xmm5
	vpxor	%xmm5, %xmm6, %xmm5
	vpxor	1280(%rdi,%rax), %xmm5, %xmm12
	vpxor	1296(%rdi,%rax), %xmm4, %xmm8
	vpxor	1312(%rdi,%rax), %xmm2, %xmm9
	vpxor	1328(%rdi,%rax), %xmm3, %xmm15
	vpxor	1344(%rdi,%rax), %xmm0, %xmm13
	vpxor	1360(%rdi,%rax), %xmm1, %xmm0
	vpxor	%xmm11, %xmm14, %xmm1
	vpxor	1376(%rdi,%rax), %xmm1, %xmm14
	vpxor	1392(%rdi,%rax), %xmm10, %xmm3
	subq	$-128, %rax
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	vpxor	%xmm14, %xmm0, %xmm6
	vmovdqa	%xmm3, %xmm1
	vpxor	%xmm1, %xmm9, %xmm3
	vpxor	%xmm8, %xmm3, %xmm5
	vpxor	%xmm6, %xmm8, %xmm0
	vpxor	%xmm1, %xmm13, %xmm7
	vmovdqa	%xmm1, %xmm8
	vmovdqa	%xmm8, -48(%rsp)        # 16-byte Spill
	vpxor	%xmm7, %xmm0, %xmm1
	vmovdqa	%xmm1, -128(%rsp)       # 16-byte Spill
	vpxor	%xmm12, %xmm5, %xmm2
	vmovdqa	%xmm2, -112(%rsp)       # 16-byte Spill
	vpxor	%xmm15, %xmm5, %xmm1
	vpxor	%xmm15, %xmm12, %xmm10
	vpxor	%xmm14, %xmm10, %xmm4
	vpxor	%xmm7, %xmm4, %xmm11
	vpxor	%xmm6, %xmm2, %xmm6
	vpxor	%xmm1, %xmm6, %xmm7
	vmovdqa	%xmm7, 48(%rsp)         # 16-byte Spill
	vmovdqa	%xmm6, %xmm3
	vmovdqa	%xmm1, 16(%rsp)         # 16-byte Spill
	vpxor	%xmm13, %xmm0, %xmm9
	vpand	%xmm10, %xmm9, %xmm0
	vpor	%xmm9, %xmm10, %xmm6
	vpxor	%xmm13, %xmm4, %xmm2
	vmovdqa	%xmm2, -32(%rsp)        # 16-byte Spill
	vmovdqa	%xmm3, (%rsp)           # 16-byte Spill
	vpand	%xmm3, %xmm11, %xmm4
	vmovdqa	%xmm11, -80(%rsp)       # 16-byte Spill
	vpxor	%xmm6, %xmm4, %xmm4
	vpand	%xmm2, %xmm7, %xmm6
	vpxor	%xmm6, %xmm4, %xmm15
	vpand	%xmm8, %xmm1, %xmm7
	vpxor	%xmm0, %xmm7, %xmm7
	vpxor	%xmm6, %xmm7, %xmm7
	vpxor	%xmm14, %xmm12, %xmm2
	vmovdqa	%xmm2, -16(%rsp)        # 16-byte Spill
	vpxor	%xmm14, %xmm5, %xmm1
	vmovdqa	%xmm1, 32(%rsp)         # 16-byte Spill
	vpxor	%xmm1, %xmm3, %xmm8
	vpxor	%xmm5, %xmm11, %xmm13
	vpor	%xmm13, %xmm8, %xmm3
	vpxor	%xmm3, %xmm7, %xmm3
	vpand	%xmm5, %xmm1, %xmm7
	vpxor	%xmm7, %xmm0, %xmm7
	vmovdqa	-128(%rsp), %xmm1       # 16-byte Reload
	vpxor	%xmm5, %xmm1, %xmm4
	vpor	%xmm2, %xmm4, %xmm6
	vpxor	%xmm7, %xmm6, %xmm14
	vpxor	%xmm10, %xmm8, %xmm6
	vmovdqa	%xmm6, -64(%rsp)        # 16-byte Spill
	vpxor	%xmm9, %xmm13, %xmm12
	vpand	%xmm12, %xmm6, %xmm6
	vpxor	%xmm6, %xmm15, %xmm11
	vpxor	%xmm6, %xmm14, %xmm6
	vpor	-112(%rsp), %xmm1, %xmm7 # 16-byte Folded Reload
	vpxor	%xmm7, %xmm0, %xmm0
	vpand	%xmm2, %xmm4, %xmm7
	vpxor	%xmm0, %xmm7, %xmm0
	vpand	%xmm8, %xmm13, %xmm7
	vpxor	%xmm7, %xmm0, %xmm7
	vpxor	%xmm11, %xmm3, %xmm2
	vpand	%xmm11, %xmm6, %xmm11
	vpxor	%xmm7, %xmm11, %xmm0
	vpand	%xmm2, %xmm0, %xmm1
	vpxor	%xmm3, %xmm1, %xmm1
	vpxor	%xmm3, %xmm11, %xmm14
	vpxor	%xmm7, %xmm6, %xmm3
	vpand	%xmm3, %xmm14, %xmm3
	vpxor	%xmm11, %xmm3, %xmm11
	vpxor	%xmm7, %xmm3, %xmm14
	vpand	%xmm7, %xmm11, %xmm3
	vpxor	%xmm6, %xmm3, %xmm6
	vpxor	%xmm0, %xmm3, %xmm0
	vpand	%xmm1, %xmm0, %xmm0
	vpxor	%xmm2, %xmm0, %xmm11
	vpxor	%xmm1, %xmm11, %xmm15
	vpand	-128(%rsp), %xmm15, %xmm2 # 16-byte Folded Reload
	vpand	%xmm4, %xmm11, %xmm3
	vpand	%xmm5, %xmm1, %xmm4
	vpxor	%xmm4, %xmm3, %xmm0
	vmovdqa	%xmm0, -128(%rsp)       # 16-byte Spill
	vpxor	%xmm4, %xmm2, %xmm0
	vmovdqa	%xmm0, -96(%rsp)        # 16-byte Spill
	vpxor	%xmm14, %xmm6, %xmm4
	vpxor	%xmm14, %xmm1, %xmm5
	vpxor	%xmm4, %xmm11, %xmm7
	vpxor	%xmm5, %xmm7, %xmm2
	vpand	%xmm9, %xmm2, %xmm9
	vpand	%xmm12, %xmm7, %xmm12
	vpand	%xmm13, %xmm5, %xmm3
	vpxor	%xmm3, %xmm12, %xmm3
	vpxor	%xmm12, %xmm9, %xmm9
	vpand	-48(%rsp), %xmm6, %xmm12 # 16-byte Folded Reload
	vpand	-32(%rsp), %xmm4, %xmm13 # 16-byte Folded Reload
	vpand	-80(%rsp), %xmm14, %xmm0 # 16-byte Folded Reload
	vpxor	%xmm0, %xmm13, %xmm13
	vpxor	%xmm0, %xmm12, %xmm0
	vpxor	%xmm3, %xmm0, %xmm12
	vpxor	-96(%rsp), %xmm3, %xmm3 # 16-byte Folded Reload
	vpand	%xmm10, %xmm2, %xmm2
	vpand	-64(%rsp), %xmm7, %xmm7 # 16-byte Folded Reload
	vpand	%xmm8, %xmm5, %xmm5
	vpxor	%xmm5, %xmm7, %xmm5
	vpxor	%xmm7, %xmm2, %xmm2
	vpand	16(%rsp), %xmm6, %xmm6  # 16-byte Folded Reload
	vpand	48(%rsp), %xmm4, %xmm4  # 16-byte Folded Reload
	vpand	(%rsp), %xmm14, %xmm7   # 16-byte Folded Reload
	vpxor	%xmm7, %xmm4, %xmm4
	vpxor	%xmm7, %xmm6, %xmm8
	vpand	-112(%rsp), %xmm15, %xmm7 # 16-byte Folded Reload
	vpand	-16(%rsp), %xmm11, %xmm0 # 16-byte Folded Reload
	vpand	32(%rsp), %xmm1, %xmm1  # 16-byte Folded Reload
	vpxor	%xmm13, %xmm9, %xmm6
	vpxor	%xmm1, %xmm0, %xmm0
	vpxor	%xmm2, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm6
	vpxor	%xmm2, %xmm4, %xmm0
	vpxor	%xmm1, %xmm7, %xmm1
	vpxor	%xmm5, %xmm8, %xmm2
	vmovdqa	-128(%rsp), %xmm4       # 16-byte Reload
	vpxor	%xmm4, %xmm1, %xmm1
	vpxor	%xmm5, %xmm1, %xmm1
	vpxor	%xmm13, %xmm4, %xmm4
	vpxor	%xmm13, %xmm1, %xmm8
	vpxor	%xmm3, %xmm9, %xmm5
	vpxor	%xmm5, %xmm1, %xmm9
	vpxor	%xmm3, %xmm2, %xmm1
	vpxor	%xmm2, %xmm12, %xmm2
	vpxor	%xmm1, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm7
	vpxor	%xmm12, %xmm1, %xmm3
	vpxor	%xmm3, %xmm4, %xmm4
	vmovdqa	.LCPI0_0(%rip), %xmm0   # xmm0 = [0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]
	vpshufb	%xmm0, %xmm1, %xmm5
	vpshufb	%xmm0, %xmm2, %xmm12
	vpshufb	%xmm0, %xmm6, %xmm13
	vpshufb	%xmm0, %xmm3, %xmm2
	vpshufb	%xmm0, %xmm4, %xmm3
	vpshufb	%xmm0, %xmm7, %xmm6
	vpshufb	%xmm0, %xmm9, %xmm7
	vpshufb	%xmm0, %xmm8, %xmm4
	testq	%rax, %rax
	jne	.LBB0_3
# %bb.2:
	vpxor	1280(%rdi), %xmm5, %xmm5
	vmovdqa	%xmm5, (%rsi)
	vpxor	1296(%rdi), %xmm12, %xmm0
	vmovdqa	%xmm0, 16(%rsi)
	vpxor	1312(%rdi), %xmm13, %xmm0
	vmovdqa	%xmm0, 32(%rsi)
	vpxor	1328(%rdi), %xmm2, %xmm0
	vmovdqa	%xmm0, 48(%rsi)
	vpxor	1344(%rdi), %xmm3, %xmm0
	vmovdqa	%xmm0, 64(%rsi)
	vpxor	1360(%rdi), %xmm6, %xmm0
	vmovdqa	%xmm0, 80(%rsi)
	vpxor	1376(%rdi), %xmm7, %xmm0
	vmovdqa	%xmm0, 96(%rsi)
	vpxor	1392(%rdi), %xmm4, %xmm0
	vmovdqa	%xmm0, 112(%rsi)
	addq	$72, %rsp
	retq
.Lfunc_end0:
	.size	AES__, .Lfunc_end0-AES__
	.cfi_endproc
                                        # -- End function
