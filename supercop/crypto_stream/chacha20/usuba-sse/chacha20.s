	.text
	.file	"chacha20.c"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function Chacha20__
.LCPI0_0:
	.byte	3                       # 0x3
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	2                       # 0x2
	.byte	7                       # 0x7
	.byte	4                       # 0x4
	.byte	5                       # 0x5
	.byte	6                       # 0x6
	.byte	11                      # 0xb
	.byte	8                       # 0x8
	.byte	9                       # 0x9
	.byte	10                      # 0xa
	.byte	15                      # 0xf
	.byte	12                      # 0xc
	.byte	13                      # 0xd
	.byte	14                      # 0xe
	.text
	.globl	Chacha20__
	.p2align	4, 0x90
	.type	Chacha20__,@function
Chacha20__:                             # @Chacha20__
	.cfi_startproc
# %bb.0:
	movaps	(%rdi), %xmm0
	movaps	%xmm0, -72(%rsp)        # 16-byte Spill
	movdqa	16(%rdi), %xmm10
	movdqa	32(%rdi), %xmm2
	movdqa	48(%rdi), %xmm14
	movdqa	64(%rdi), %xmm5
	movdqa	192(%rdi), %xmm4
	movdqa	128(%rdi), %xmm13
	movdqa	80(%rdi), %xmm7
	movdqa	208(%rdi), %xmm6
	movdqa	144(%rdi), %xmm15
	movdqa	96(%rdi), %xmm1
	movdqa	224(%rdi), %xmm12
	movdqa	160(%rdi), %xmm8
	movdqa	112(%rdi), %xmm3
	movdqa	240(%rdi), %xmm0
	movdqa	%xmm0, -56(%rsp)        # 16-byte Spill
	movdqa	176(%rdi), %xmm11
	movl	$10, %eax
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	paddd	%xmm3, %xmm14
	paddd	%xmm1, %xmm2
	paddd	%xmm7, %xmm10
	movdqa	%xmm10, -40(%rsp)       # 16-byte Spill
	movdqa	-72(%rsp), %xmm10       # 16-byte Reload
	paddd	%xmm5, %xmm10
	pxor	%xmm10, %xmm4
	pshuflw	$177, %xmm4, %xmm4      # xmm4 = xmm4[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm4, %xmm4      # xmm4 = xmm4[0,1,2,3,5,4,7,6]
	movdqa	%xmm13, %xmm9
	paddd	%xmm4, %xmm9
	pxor	%xmm9, %xmm5
	movdqa	%xmm5, %xmm13
	psrld	$20, %xmm13
	pslld	$12, %xmm5
	por	%xmm13, %xmm5
	paddd	%xmm5, %xmm10
	pxor	%xmm10, %xmm4
	movdqa	.LCPI0_0(%rip), %xmm0   # xmm0 = [3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14]
	pshufb	%xmm0, %xmm4
	paddd	%xmm4, %xmm9
	movdqa	%xmm9, -24(%rsp)        # 16-byte Spill
	pxor	%xmm9, %xmm5
	movdqa	%xmm5, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm5
	por	%xmm0, %xmm5
	movdqa	%xmm2, %xmm9
	movdqa	-40(%rsp), %xmm2        # 16-byte Reload
	pxor	%xmm2, %xmm6
	pshuflw	$177, %xmm6, %xmm0      # xmm0 = xmm6[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm13     # xmm13 = xmm0[0,1,2,3,5,4,7,6]
	paddd	%xmm13, %xmm15
	pxor	%xmm15, %xmm7
	movdqa	%xmm7, %xmm0
	psrld	$20, %xmm0
	pslld	$12, %xmm7
	por	%xmm0, %xmm7
	movdqa	%xmm2, %xmm0
	movdqa	%xmm9, %xmm2
	paddd	%xmm7, %xmm0
	movdqa	%xmm0, -40(%rsp)        # 16-byte Spill
	pxor	%xmm0, %xmm13
	movdqa	.LCPI0_0(%rip), %xmm9   # xmm9 = [3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14]
	pshufb	%xmm9, %xmm13
	paddd	%xmm13, %xmm15
	pxor	%xmm15, %xmm7
	movdqa	%xmm7, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm7
	por	%xmm0, %xmm7
	pxor	%xmm2, %xmm12
	pshuflw	$177, %xmm12, %xmm0     # xmm0 = xmm12[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm12     # xmm12 = xmm0[0,1,2,3,5,4,7,6]
	paddd	%xmm12, %xmm8
	pxor	%xmm8, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$20, %xmm0
	pslld	$12, %xmm1
	por	%xmm0, %xmm1
	paddd	%xmm1, %xmm2
	pxor	%xmm2, %xmm12
	pshufb	%xmm9, %xmm12
	paddd	%xmm12, %xmm8
	pxor	%xmm8, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm1
	por	%xmm0, %xmm1
	movdqa	-56(%rsp), %xmm0        # 16-byte Reload
	pxor	%xmm14, %xmm0
	pshuflw	$177, %xmm0, %xmm0      # xmm0 = xmm0[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,4,7,6]
	paddd	%xmm0, %xmm11
	pxor	%xmm11, %xmm3
	movdqa	%xmm3, %xmm6
	psrld	$20, %xmm6
	pslld	$12, %xmm3
	por	%xmm6, %xmm3
	paddd	%xmm3, %xmm14
	pxor	%xmm14, %xmm0
	pshufb	%xmm9, %xmm0
	paddd	%xmm0, %xmm11
	pxor	%xmm11, %xmm3
	movdqa	%xmm3, %xmm6
	psrld	$25, %xmm6
	pslld	$7, %xmm3
	por	%xmm6, %xmm3
	paddd	%xmm7, %xmm10
	pxor	%xmm10, %xmm0
	pshuflw	$177, %xmm0, %xmm0      # xmm0 = xmm0[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm6      # xmm6 = xmm0[0,1,2,3,5,4,7,6]
	paddd	%xmm6, %xmm8
	pxor	%xmm8, %xmm7
	movdqa	%xmm7, %xmm0
	psrld	$20, %xmm0
	pslld	$12, %xmm7
	por	%xmm0, %xmm7
	paddd	%xmm7, %xmm10
	movdqa	%xmm10, -72(%rsp)       # 16-byte Spill
	pxor	%xmm10, %xmm6
	pshufb	%xmm9, %xmm6
	movdqa	%xmm6, -56(%rsp)        # 16-byte Spill
	paddd	%xmm6, %xmm8
	pxor	%xmm8, %xmm7
	movdqa	%xmm7, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm7
	por	%xmm0, %xmm7
	movdqa	-40(%rsp), %xmm0        # 16-byte Reload
	paddd	%xmm1, %xmm0
	pxor	%xmm0, %xmm4
	movdqa	%xmm0, %xmm6
	pshuflw	$177, %xmm4, %xmm0      # xmm0 = xmm4[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm4      # xmm4 = xmm0[0,1,2,3,5,4,7,6]
	paddd	%xmm4, %xmm11
	pxor	%xmm11, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$20, %xmm0
	pslld	$12, %xmm1
	por	%xmm0, %xmm1
	movdqa	%xmm6, %xmm0
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm10
	pxor	%xmm0, %xmm4
	pshufb	%xmm9, %xmm4
	paddd	%xmm4, %xmm11
	pxor	%xmm11, %xmm1
	movdqa	%xmm1, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm1
	por	%xmm0, %xmm1
	paddd	%xmm3, %xmm2
	pxor	%xmm2, %xmm13
	pshuflw	$177, %xmm13, %xmm0     # xmm0 = xmm13[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm6      # xmm6 = xmm0[0,1,2,3,5,4,7,6]
	movdqa	-24(%rsp), %xmm0        # 16-byte Reload
	paddd	%xmm6, %xmm0
	pxor	%xmm0, %xmm3
	movdqa	%xmm0, %xmm13
	movdqa	%xmm3, %xmm0
	psrld	$20, %xmm0
	pslld	$12, %xmm3
	por	%xmm0, %xmm3
	paddd	%xmm3, %xmm2
	pxor	%xmm2, %xmm6
	pshufb	%xmm9, %xmm6
	movdqa	%xmm13, %xmm0
	paddd	%xmm6, %xmm0
	movdqa	%xmm0, %xmm13
	pxor	%xmm0, %xmm3
	movdqa	%xmm3, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm3
	por	%xmm0, %xmm3
	paddd	%xmm5, %xmm14
	pxor	%xmm14, %xmm12
	pshuflw	$177, %xmm12, %xmm0     # xmm0 = xmm12[1,0,3,2,4,5,6,7]
	pshufhw	$177, %xmm0, %xmm12     # xmm12 = xmm0[0,1,2,3,5,4,7,6]
	paddd	%xmm12, %xmm15
	pxor	%xmm15, %xmm5
	movdqa	%xmm5, %xmm0
	psrld	$20, %xmm0
	pslld	$12, %xmm5
	por	%xmm0, %xmm5
	paddd	%xmm5, %xmm14
	pxor	%xmm14, %xmm12
	pshufb	%xmm9, %xmm12
	paddd	%xmm12, %xmm15
	pxor	%xmm15, %xmm5
	movdqa	%xmm5, %xmm0
	psrld	$25, %xmm0
	pslld	$7, %xmm5
	por	%xmm0, %xmm5
	addl	$-1, %eax
	jne	.LBB0_1
# %bb.2:
	movaps	-72(%rsp), %xmm0        # 16-byte Reload
	movaps	%xmm0, (%rsi)
	movdqa	%xmm10, 16(%rsi)
	movdqa	%xmm2, 32(%rsi)
	movdqa	%xmm14, 48(%rsi)
	movdqa	%xmm5, 64(%rsi)
	movdqa	%xmm7, 80(%rsi)
	movdqa	%xmm1, 96(%rsi)
	movdqa	%xmm3, 112(%rsi)
	movdqa	%xmm13, 128(%rsi)
	movdqa	%xmm15, 144(%rsi)
	movdqa	%xmm8, 160(%rsi)
	movdqa	%xmm11, 176(%rsi)
	movdqa	%xmm4, 192(%rsi)
	movdqa	%xmm6, 208(%rsi)
	movdqa	%xmm12, 224(%rsi)
	movaps	-56(%rsp), %xmm0        # 16-byte Reload
	movaps	%xmm0, 240(%rsi)
	retq
.Lfunc_end0:
	.size	Chacha20__, .Lfunc_end0-Chacha20__
	.cfi_endproc
                                        # -- End function

	.ident	"clang version 7.0.0-svn345401-1~exp1~20181026173340.32 (branches/release_70)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
