	.text
	.file	"sbox_ua.c"
	.globl	SubBytes__              # -- Begin function SubBytes__
	.p2align	4, 0x90
	.type	SubBytes__,@function
SubBytes__:                             # @SubBytes__
	.cfi_startproc
# %bb.0:
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	vmovdqa	%xmm6, -112(%rsp)       # 16-byte Spill
	vmovdqa	%xmm0, %xmm8
	vmovdqa	%xmm3, -128(%rsp)       # 16-byte Spill
	vpxor	%xmm3, %xmm5, %xmm9
	vpxor	%xmm8, %xmm6, %xmm0
	vmovdqa	%xmm0, -64(%rsp)        # 16-byte Spill
	vpxor	%xmm8, %xmm3, %xmm12
	vpxor	%xmm8, %xmm5, %xmm10
	vpxor	%xmm1, %xmm2, %xmm15
	vpxor	%xmm9, %xmm0, %xmm3
	vmovdqa	%xmm9, %xmm13
	vmovdqa	%xmm13, 32(%rsp)        # 16-byte Spill
	vpxor	%xmm4, %xmm3, %xmm2
	vmovdqa	%xmm3, %xmm9
	vmovdqa	%xmm9, -80(%rsp)        # 16-byte Spill
	vpxor	%xmm5, %xmm2, %xmm5
	vpxor	%xmm1, %xmm2, %xmm3
	vpxor	%xmm15, %xmm5, %xmm4
	vmovdqa	%xmm5, %xmm1
	vmovdqa	%xmm12, %xmm2
	vmovdqa	%xmm2, 48(%rsp)         # 16-byte Spill
	vpxor	%xmm2, %xmm3, %xmm14
	vpand	%xmm10, %xmm4, %xmm12
	vpand	%xmm2, %xmm14, %xmm2
	vpxor	%xmm12, %xmm2, %xmm11
	vpxor	%xmm4, %xmm14, %xmm0
	vmovdqa	%xmm0, 16(%rsp)         # 16-byte Spill
	vmovdqa	%xmm4, (%rsp)           # 16-byte Spill
	vpand	%xmm13, %xmm0, %xmm5
	vpxor	%xmm2, %xmm5, %xmm6
	vmovdqa	%xmm7, %xmm13
	vpxor	%xmm13, %xmm15, %xmm7
	vpxor	-112(%rsp), %xmm7, %xmm12 # 16-byte Folded Reload
	vmovdqa	%xmm1, -96(%rsp)        # 16-byte Spill
	vpand	%xmm9, %xmm1, %xmm2
	vpxor	%xmm3, %xmm2, %xmm9
	vmovdqa	%xmm10, 64(%rsp)        # 16-byte Spill
	vpxor	%xmm10, %xmm12, %xmm0
	vmovdqa	%xmm0, -112(%rsp)       # 16-byte Spill
	vmovdqa	%xmm12, %xmm3
	vmovdqa	%xmm3, -16(%rsp)        # 16-byte Spill
	vpxor	%xmm13, %xmm1, %xmm1
	vmovdqa	%xmm1, -32(%rsp)        # 16-byte Spill
	vpand	%xmm0, %xmm1, %xmm12
	vpxor	%xmm12, %xmm9, %xmm9
	vpxor	-128(%rsp), %xmm7, %xmm0 # 16-byte Folded Reload
	vmovdqa	%xmm0, -128(%rsp)       # 16-byte Spill
	vpand	%xmm13, %xmm0, %xmm5
	vpxor	%xmm10, %xmm5, %xmm5
	vpxor	%xmm4, %xmm5, %xmm5
	vpxor	%xmm2, %xmm5, %xmm12
	vpxor	%xmm15, %xmm14, %xmm1
	vmovdqa	%xmm1, -48(%rsp)        # 16-byte Spill
	vpxor	%xmm6, %xmm9, %xmm2
	vpand	%xmm7, %xmm3, %xmm0
	vmovdqa	-64(%rsp), %xmm3        # 16-byte Reload
	vpxor	%xmm0, %xmm3, %xmm0
	vpandn	%xmm1, %xmm3, %xmm5
	vpxor	%xmm0, %xmm5, %xmm0
	vpxor	%xmm6, %xmm0, %xmm4
	vpxor	%xmm8, %xmm5, %xmm5
	vpxor	%xmm8, %xmm7, %xmm0
	vpxor	%xmm11, %xmm12, %xmm1
	vpxor	%xmm13, %xmm14, %xmm12
	vpand	%xmm0, %xmm12, %xmm15
	vpxor	%xmm11, %xmm15, %xmm6
	vpxor	%xmm6, %xmm5, %xmm5
	vpand	%xmm2, %xmm4, %xmm6
	vpxor	%xmm5, %xmm4, %xmm15
	vpxor	%xmm1, %xmm6, %xmm9
	vpand	%xmm15, %xmm9, %xmm9
	vpxor	%xmm1, %xmm2, %xmm15
	vpxor	%xmm5, %xmm6, %xmm2
	vpand	%xmm15, %xmm2, %xmm8
	vpxor	%xmm1, %xmm8, %xmm1
	vpxor	%xmm6, %xmm9, %xmm8
	vpxor	%xmm5, %xmm9, %xmm6
	vpand	%xmm5, %xmm8, %xmm5
	vpxor	%xmm4, %xmm5, %xmm3
	vpxor	%xmm2, %xmm5, %xmm4
	vpand	%xmm1, %xmm4, %xmm4
	vpxor	%xmm15, %xmm4, %xmm4
	vpand	%xmm13, %xmm6, %xmm8
	vpand	-96(%rsp), %xmm3, %xmm5 # 16-byte Folded Reload
	vpand	-80(%rsp), %xmm3, %xmm2 # 16-byte Folded Reload
	vmovdqa	%xmm2, -96(%rsp)        # 16-byte Spill
	vpxor	%xmm6, %xmm3, %xmm3
	vpand	-32(%rsp), %xmm3, %xmm10 # 16-byte Folded Reload
	vpxor	%xmm8, %xmm5, %xmm8
	vpxor	%xmm10, %xmm5, %xmm5
	vpand	%xmm12, %xmm1, %xmm11
	vpand	%xmm0, %xmm1, %xmm0
	vmovdqa	%xmm0, -80(%rsp)        # 16-byte Spill
	vpand	-128(%rsp), %xmm6, %xmm0 # 16-byte Folded Reload
	vmovdqa	%xmm0, -128(%rsp)       # 16-byte Spill
	vpxor	%xmm1, %xmm6, %xmm6
	vpand	-112(%rsp), %xmm3, %xmm15 # 16-byte Folded Reload
	vpxor	%xmm3, %xmm4, %xmm3
	vpxor	%xmm1, %xmm4, %xmm1
	vpand	%xmm7, %xmm4, %xmm2
	vpand	-16(%rsp), %xmm4, %xmm0 # 16-byte Folded Reload
	vmovdqa	%xmm0, -112(%rsp)       # 16-byte Spill
	vpand	-48(%rsp), %xmm1, %xmm4 # 16-byte Folded Reload
	vpand	-64(%rsp), %xmm1, %xmm9 # 16-byte Folded Reload
	vpand	%xmm14, %xmm6, %xmm7
	vpand	48(%rsp), %xmm6, %xmm10 # 16-byte Folded Reload
	vpxor	%xmm6, %xmm3, %xmm6
	vpand	16(%rsp), %xmm6, %xmm0  # 16-byte Folded Reload
	vpand	32(%rsp), %xmm6, %xmm6  # 16-byte Folded Reload
	vpand	(%rsp), %xmm3, %xmm13   # 16-byte Folded Reload
	vpxor	%xmm8, %xmm9, %xmm12
	vpxor	%xmm13, %xmm12, %xmm12
	vpxor	%xmm2, %xmm4, %xmm2
	vpxor	%xmm0, %xmm2, %xmm0
	vpxor	%xmm2, %xmm5, %xmm1
	vpxor	%xmm11, %xmm8, %xmm5
	vpxor	%xmm4, %xmm5, %xmm4
	vpxor	%xmm7, %xmm0, %xmm5
	vpxor	%xmm0, %xmm12, %xmm0
	vpxor	%xmm10, %xmm6, %xmm6
	vpxor	%xmm15, %xmm6, %xmm7
	vpxor	-96(%rsp), %xmm7, %xmm2 # 16-byte Folded Reload
	vpxor	-128(%rsp), %xmm7, %xmm7 # 16-byte Folded Reload
	vpxor	%xmm2, %xmm1, %xmm1
	vmovdqa	%xmm1, (%rcx)
	vpxor	%xmm5, %xmm2, %xmm1
	vmovdqa	%xmm1, (%rdi)
	vpxor	-112(%rsp), %xmm4, %xmm1 # 16-byte Folded Reload
	vpxor	%xmm1, %xmm6, %xmm1
	vpxor	-80(%rsp), %xmm0, %xmm2 # 16-byte Folded Reload
	vpxor	%xmm2, %xmm7, %xmm6
	vmovdqa	%xmm6, (%r9)
	movq	104(%rsp), %rax
	vpxor	(%rcx), %xmm4, %xmm4
	vmovdqa	%xmm4, (%r8)
	vpcmpeqd	%xmm4, %xmm4, %xmm4
	vpxor	%xmm4, %xmm1, %xmm1
	vpxor	%xmm1, %xmm9, %xmm6
	vpxor	%xmm4, %xmm5, %xmm4
	vpxor	(%rcx), %xmm4, %xmm5
	vmovdqa	%xmm6, (%rax)
	vpxor	%xmm1, %xmm0, %xmm0
	movq	96(%rsp), %rax
	vmovdqa	%xmm0, (%rax)
	vmovdqa	%xmm5, (%rsi)
	vpand	64(%rsp), %xmm3, %xmm0  # 16-byte Folded Reload
	vpxor	%xmm0, %xmm10, %xmm0
	vpxor	%xmm0, %xmm4, %xmm0
	vpxor	%xmm2, %xmm0, %xmm0
	vmovdqa	%xmm0, (%rdx)
	addq	$88, %rsp
	retq
.Lfunc_end0:
	.size	SubBytes__, .Lfunc_end0-SubBytes__
	.cfi_endproc
                                        # -- End function

	.ident	"clang version 6.0.1-svn334776-1~exp1~20180830175819.98 (branches/release_60)"
	.section	".note.GNU-stack","",@progbits
