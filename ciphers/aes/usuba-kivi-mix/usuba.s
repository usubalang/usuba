
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
	subq	$80, %rsp
	.cfi_def_cfa_offset 80
	vpxor	(%rdi), %xmm0, %xmm11
	vpxor	16(%rdi), %xmm1, %xmm8
	vpxor	32(%rdi), %xmm2, %xmm10
	vpxor	48(%rdi), %xmm3, %xmm9
	vpxor	64(%rdi), %xmm4, %xmm2
	vpxor	80(%rdi), %xmm5, %xmm5
	vpxor	96(%rdi), %xmm6, %xmm4
	vpxor	112(%rdi), %xmm7, %xmm15
	movl	$240, %eax
	jmp	.LBB0_1
	.p2align	4, 0x90
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
	vmovdqa	.LCPI0_1(%rip), %xmm13  # xmm13 = [1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12]
	vpshufb	%xmm13, %xmm4, %xmm9
	vpxor	%xmm4, %xmm9, %xmm4
	vpshufb	%xmm13, %xmm3, %xmm0
	vpxor	%xmm4, %xmm0, %xmm1
	vpxor	%xmm3, %xmm0, %xmm0
	vmovdqa	.LCPI0_2(%rip), %xmm14  # xmm14 = [2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13]
	vpshufb	%xmm14, %xmm0, %xmm3
	vpxor	%xmm3, %xmm1, %xmm8
	vpshufb	%xmm13, %xmm5, %xmm1
	vpxor	%xmm5, %xmm1, %xmm3
	vpshufb	%xmm14, %xmm3, %xmm5
	vpxor	%xmm4, %xmm1, %xmm1
	vpxor	%xmm0, %xmm1, %xmm0
	vpxor	%xmm5, %xmm0, %xmm12
	vpshufb	%xmm13, %xmm7, %xmm1
	vpxor	%xmm3, %xmm1, %xmm3
	vpxor	%xmm7, %xmm1, %xmm1
	vpshufb	%xmm14, %xmm1, %xmm5
	vpxor	%xmm5, %xmm3, %xmm3
	vpshufb	%xmm13, %xmm6, %xmm5
	vpxor	%xmm6, %xmm5, %xmm6
	vpshufb	%xmm14, %xmm6, %xmm7
	vpxor	%xmm4, %xmm5, %xmm5
	vpxor	%xmm1, %xmm5, %xmm1
	vpxor	%xmm7, %xmm1, %xmm1
	vpshufb	%xmm13, %xmm2, %xmm5
	vpxor	%xmm2, %xmm5, %xmm2
	vpshufb	%xmm14, %xmm2, %xmm7
	vpxor	%xmm4, %xmm5, %xmm5
	vpxor	%xmm6, %xmm5, %xmm5
	vpxor	%xmm7, %xmm5, %xmm5
	vpshufb	%xmm13, %xmm11, %xmm6
	vpxor	%xmm6, %xmm2, %xmm2
	vpxor	%xmm11, %xmm6, %xmm6
	vpshufb	%xmm14, %xmm6, %xmm7
	vpxor	%xmm7, %xmm2, %xmm7
	vpshufb	%xmm13, %xmm10, %xmm2
	vpxor	%xmm2, %xmm6, %xmm6
	vpxor	%xmm10, %xmm2, %xmm2
	vpshufb	%xmm14, %xmm2, %xmm0
	vpxor	%xmm0, %xmm6, %xmm6
	vpxor	%xmm9, %xmm2, %xmm0
	vpshufb	%xmm14, %xmm4, %xmm4
	vpxor	-112(%rdi,%rax), %xmm8, %xmm11
	vpxor	-96(%rdi,%rax), %xmm12, %xmm8
	vpxor	-80(%rdi,%rax), %xmm3, %xmm10
	vpxor	-64(%rdi,%rax), %xmm1, %xmm9
	vpxor	-48(%rdi,%rax), %xmm5, %xmm2
	vpxor	-32(%rdi,%rax), %xmm7, %xmm5
	vpxor	%xmm4, %xmm0, %xmm0
	vpxor	-16(%rdi,%rax), %xmm6, %xmm4
	vpxor	(%rdi,%rax), %xmm0, %xmm15
	subq	$-128, %rax
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	vpxor	%xmm4, %xmm5, %xmm5
	vpxor	%xmm10, %xmm8, %xmm7
	vpxor	%xmm11, %xmm5, %xmm5
	vpxor	%xmm4, %xmm7, %xmm4
	vpxor	%xmm9, %xmm11, %xmm0
	vpxor	%xmm0, %xmm4, %xmm1
	vmovdqa	%xmm1, -128(%rsp)       # 16-byte Spill
	vpxor	%xmm15, %xmm5, %xmm1
	vpxor	%xmm2, %xmm5, %xmm6
	vpxor	%xmm15, %xmm2, %xmm14
	vpxor	%xmm8, %xmm14, %xmm3
	vpxor	%xmm0, %xmm3, %xmm12
	vpxor	%xmm7, %xmm1, %xmm0
	vmovdqa	%xmm1, %xmm2
	vmovdqa	%xmm1, -16(%rsp)        # 16-byte Spill
	vpxor	%xmm6, %xmm0, %xmm10
	vmovdqa	%xmm10, 48(%rsp)        # 16-byte Spill
	vmovdqa	%xmm0, %xmm7
	vmovdqa	%xmm6, 16(%rsp)         # 16-byte Spill
	vpxor	%xmm9, %xmm4, %xmm1
	vmovdqa	%xmm11, %xmm0
	vmovdqa	%xmm11, -64(%rsp)       # 16-byte Spill
	vpand	%xmm14, %xmm1, %xmm11
	vpor	%xmm14, %xmm1, %xmm13
	vpxor	%xmm9, %xmm3, %xmm9
	vmovdqa	%xmm9, -48(%rsp)        # 16-byte Spill
	vmovdqa	%xmm7, (%rsp)           # 16-byte Spill
	vmovdqa	%xmm12, %xmm4
	vmovdqa	%xmm12, -96(%rsp)       # 16-byte Spill
	vpand	%xmm7, %xmm12, %xmm3
	vpxor	%xmm13, %xmm3, %xmm12
	vpand	%xmm10, %xmm9, %xmm3
	vpxor	%xmm3, %xmm12, %xmm9
	vpand	%xmm0, %xmm6, %xmm0
	vpxor	%xmm11, %xmm0, %xmm0
	vpxor	%xmm3, %xmm0, %xmm10
	vpxor	%xmm15, %xmm8, %xmm12
	vpxor	%xmm8, %xmm5, %xmm3
	vmovdqa	%xmm3, 32(%rsp)         # 16-byte Spill
	vpxor	%xmm3, %xmm7, %xmm13
	vpxor	%xmm5, %xmm4, %xmm0
	vpor	%xmm13, %xmm0, %xmm7
	vpxor	%xmm7, %xmm10, %xmm7
	vpand	%xmm5, %xmm3, %xmm6
	vpxor	%xmm11, %xmm6, %xmm6
	vmovdqa	-128(%rsp), %xmm4       # 16-byte Reload
	vpxor	%xmm5, %xmm4, %xmm10
	vpor	%xmm12, %xmm10, %xmm3
	vmovdqa	%xmm12, %xmm8
	vmovdqa	%xmm12, -32(%rsp)       # 16-byte Spill
	vpxor	%xmm3, %xmm6, %xmm12
	vpxor	%xmm14, %xmm13, %xmm3
	vmovdqa	%xmm3, -80(%rsp)        # 16-byte Spill
	vpxor	%xmm1, %xmm0, %xmm15
	vpand	%xmm3, %xmm15, %xmm3
	vpxor	%xmm3, %xmm9, %xmm9
	vpxor	%xmm3, %xmm12, %xmm3
	vpor	%xmm2, %xmm4, %xmm6
	vpxor	%xmm11, %xmm6, %xmm6
	vpand	%xmm8, %xmm10, %xmm2
	vpxor	%xmm2, %xmm6, %xmm2
	vpand	%xmm13, %xmm0, %xmm6
	vpxor	%xmm6, %xmm2, %xmm2
	vpxor	%xmm9, %xmm7, %xmm11
	vpand	%xmm9, %xmm3, %xmm6
	vpxor	%xmm2, %xmm6, %xmm12
	vpand	%xmm11, %xmm12, %xmm4
	vpxor	%xmm7, %xmm4, %xmm9
	vpxor	%xmm7, %xmm6, %xmm4
	vpxor	%xmm2, %xmm3, %xmm7
	vpand	%xmm7, %xmm4, %xmm4
	vpxor	%xmm6, %xmm4, %xmm7
	vpxor	%xmm2, %xmm4, %xmm6
	vpand	%xmm2, %xmm7, %xmm2
	vpxor	%xmm3, %xmm2, %xmm8
	vpxor	%xmm12, %xmm2, %xmm2
	vpand	%xmm9, %xmm2, %xmm2
	vpxor	%xmm11, %xmm2, %xmm11
	vpxor	%xmm9, %xmm11, %xmm12
	vpand	-128(%rsp), %xmm12, %xmm4 # 16-byte Folded Reload
	vpand	%xmm10, %xmm11, %xmm7
	vpand	%xmm5, %xmm9, %xmm5
	vpxor	%xmm5, %xmm7, %xmm2
	vmovdqa	%xmm2, -128(%rsp)       # 16-byte Spill
	vpxor	%xmm5, %xmm4, %xmm2
	vmovdqa	%xmm2, -112(%rsp)       # 16-byte Spill
	vpxor	%xmm6, %xmm8, %xmm5
	vpxor	%xmm6, %xmm9, %xmm7
	vpxor	%xmm5, %xmm11, %xmm4
	vpxor	%xmm7, %xmm4, %xmm2
	vpand	%xmm1, %xmm2, %xmm3
	vpand	%xmm15, %xmm4, %xmm15
	vpand	%xmm0, %xmm7, %xmm0
	vpxor	%xmm0, %xmm15, %xmm1
	vpxor	%xmm15, %xmm3, %xmm10
	vpand	-64(%rsp), %xmm8, %xmm15 # 16-byte Folded Reload
	vpand	-48(%rsp), %xmm5, %xmm3 # 16-byte Folded Reload
	vpand	-96(%rsp), %xmm6, %xmm0 # 16-byte Folded Reload
	vpxor	%xmm0, %xmm3, %xmm3
	vpxor	%xmm0, %xmm15, %xmm0
	vpxor	%xmm1, %xmm0, %xmm15
	vpxor	-112(%rsp), %xmm1, %xmm1 # 16-byte Folded Reload
	vpand	%xmm14, %xmm2, %xmm2
	vpand	-80(%rsp), %xmm4, %xmm4 # 16-byte Folded Reload
	vpand	%xmm13, %xmm7, %xmm7
	vpxor	%xmm7, %xmm4, %xmm7
	vpxor	%xmm4, %xmm2, %xmm2
	vpand	16(%rsp), %xmm8, %xmm4  # 16-byte Folded Reload
	vpand	48(%rsp), %xmm5, %xmm5  # 16-byte Folded Reload
	vpand	(%rsp), %xmm6, %xmm6    # 16-byte Folded Reload
	vpxor	%xmm6, %xmm5, %xmm13
	vpxor	%xmm6, %xmm4, %xmm8
	vpand	-16(%rsp), %xmm12, %xmm6 # 16-byte Folded Reload
	vpand	-32(%rsp), %xmm11, %xmm0 # 16-byte Folded Reload
	vpand	32(%rsp), %xmm9, %xmm4  # 16-byte Folded Reload
	vpxor	%xmm3, %xmm10, %xmm5
	vpxor	%xmm4, %xmm0, %xmm0
	vpxor	%xmm2, %xmm0, %xmm0
	vpxor	%xmm5, %xmm0, %xmm5
	vpxor	%xmm2, %xmm13, %xmm0
	vpxor	%xmm4, %xmm6, %xmm2
	vpxor	%xmm7, %xmm8, %xmm4
	vmovdqa	-128(%rsp), %xmm6       # 16-byte Reload
	vpxor	%xmm6, %xmm2, %xmm2
	vpxor	%xmm7, %xmm2, %xmm2
	vpxor	%xmm3, %xmm6, %xmm6
	vpxor	%xmm3, %xmm2, %xmm8
	vpxor	%xmm1, %xmm10, %xmm7
	vpxor	%xmm7, %xmm2, %xmm9
	vpxor	%xmm1, %xmm4, %xmm1
	vpxor	%xmm4, %xmm15, %xmm2
	vpxor	%xmm1, %xmm0, %xmm0
	vpxor	%xmm5, %xmm0, %xmm7
	vpxor	%xmm15, %xmm1, %xmm3
	vpxor	%xmm3, %xmm6, %xmm6
	vmovdqa	.LCPI0_0(%rip), %xmm0   # xmm0 = [0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11]
	vpshufb	%xmm0, %xmm1, %xmm4
	vpshufb	%xmm0, %xmm2, %xmm10
	vpshufb	%xmm0, %xmm5, %xmm11
	vpshufb	%xmm0, %xmm3, %xmm2
	vpshufb	%xmm0, %xmm6, %xmm6
	vpshufb	%xmm0, %xmm7, %xmm7
	vpshufb	%xmm0, %xmm9, %xmm5
	vpshufb	%xmm0, %xmm8, %xmm3
	cmpq	$1392, %rax             # imm = 0x570
	jne	.LBB0_3
# %bb.2:
   
//	vpxor	1280(%rdi), %xmm3, %xmm0
//	vpxor	1296(%rdi), %xmm5, %xmm1
//	vpxor	1312(%rdi), %xmm7, %xmm8
//	vpxor	1392(%rdi), %xmm4, %xmm7
//	vpxor	1344(%rdi), %xmm2, %xmm4
//    vmovdqa %xmm8, %xmm2
//	vpxor	1328(%rdi), %xmm6, %xmm3
//	vpxor	1360(%rdi), %xmm11, %xmm5
//	vpxor	1376(%rdi), %xmm10, %xmm6
    
    
    
	vpxor	1280(%rdi), %xmm3, %xmm3
	vmovdqa	%xmm3, (%rsi)
	vpxor	1296(%rdi), %xmm5, %xmm3
	vmovdqa	%xmm3, 16(%rsi)
	vpxor	1312(%rdi), %xmm7, %xmm3
	vmovdqa	%xmm3, 32(%rsi)
	vpxor	1328(%rdi), %xmm6, %xmm3
	vmovdqa	%xmm3, 48(%rsi)
	vpxor	1344(%rdi), %xmm2, %xmm2
	vmovdqa	%xmm2, 64(%rsi)
	vpxor	1360(%rdi), %xmm11, %xmm1
	vmovdqa	%xmm1, 80(%rsi)
	vpxor	1376(%rdi), %xmm10, %xmm0
	vmovdqa	%xmm0, 96(%rsi)
	vpxor	1392(%rdi), %xmm4, %xmm0
	vmovdqa	%xmm0, 112(%rsi)
    
	addq	$80, %rsp
	retq
.Lfunc_end0:
	.size	AES__, .Lfunc_end0-AES__
	.cfi_endproc
                                        # -- End function

//	vpxor	1280(%rdi), %xmm3, %xmm0 // 0
//	vpxor	1296(%rdi), %xmm5, %xmm1 // 1
//	vpxor	1392(%rdi), %xmm4, %xmm7 // 7
//	vpxor	1344(%rdi), %xmm2, %xmm4 // 4
//	vpxor	1312(%rdi), %xmm12, %xmm2 // 2 (replace xmm7 by xmm12)
//	vpxor	1328(%rdi), %xmm6, %xmm3 // 3
//	vpxor	1360(%rdi), %xmm11, %xmm5 // 5
//	vpxor	1376(%rdi), %xmm10, %xmm6 // 6
