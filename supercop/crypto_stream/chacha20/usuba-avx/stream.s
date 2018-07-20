	.text
	.file	"stream.c"
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5               # -- Begin function Chacha20__
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
# BB#0:
	subq	$24, %rsp
.Lcfi0:
	.cfi_def_cfa_offset 32
	vmovdqa	(%rdi), %ymm7
	vmovdqa	32(%rdi), %ymm8
	vmovdqa	64(%rdi), %ymm9
	vmovdqa	96(%rdi), %ymm10
	vmovdqa	128(%rdi), %ymm14
	vmovdqa	160(%rdi), %ymm4
	vmovdqa	192(%rdi), %ymm5
	vmovdqa	224(%rdi), %ymm6
	vmovdqa	256(%rdi), %ymm15
	vmovdqa	288(%rdi), %ymm0
	vmovaps	320(%rdi), %ymm1
	vmovups	%ymm1, -128(%rsp)       # 32-byte Spill
	vmovdqa	352(%rdi), %ymm3
	vmovdqa	384(%rdi), %ymm11
	vmovdqa	416(%rdi), %ymm12
	vmovdqa	448(%rdi), %ymm13
	vmovdqa	480(%rdi), %ymm1
	vmovdqu	%ymm1, -96(%rsp)        # 32-byte Spill
	movl	$10, %eax
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	vpaddd	%ymm14, %ymm7, %ymm7
	vpxor	%ymm7, %ymm11, %ymm11
	vpshuflw	$177, %ymm11, %ymm11 # ymm11 = ymm11[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm11, %ymm11 # ymm11 = ymm11[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm11, %ymm15, %ymm15
	vpxor	%ymm14, %ymm15, %ymm14
	vpslld	$12, %ymm14, %ymm1
	vpsrld	$20, %ymm14, %ymm14
	vpor	%ymm1, %ymm14, %ymm1
	vpaddd	%ymm7, %ymm1, %ymm7
	vpxor	%ymm7, %ymm11, %ymm11
	vmovdqa	.LCPI0_0(%rip), %ymm2   # ymm2 = [3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14,3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14]
	vpshufb	%ymm2, %ymm11, %ymm11
	vpaddd	%ymm11, %ymm15, %ymm15
	vpxor	%ymm1, %ymm15, %ymm1
	vpslld	$7, %ymm1, %ymm14
	vpsrld	$25, %ymm1, %ymm1
	vpor	%ymm14, %ymm1, %ymm1
	vmovdqu	%ymm1, -32(%rsp)        # 32-byte Spill
	vpaddd	%ymm4, %ymm8, %ymm1
	vpxor	%ymm1, %ymm12, %ymm8
	vpshuflw	$177, %ymm8, %ymm8 # ymm8 = ymm8[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm8, %ymm12 # ymm12 = ymm8[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm12, %ymm0, %ymm0
	vpxor	%ymm4, %ymm0, %ymm4
	vpslld	$12, %ymm4, %ymm8
	vpsrld	$20, %ymm4, %ymm4
	vpor	%ymm8, %ymm4, %ymm4
	vpaddd	%ymm1, %ymm4, %ymm8
	vpxor	%ymm8, %ymm12, %ymm1
	vpshufb	%ymm2, %ymm1, %ymm12
	vmovdqa	%ymm2, %ymm14
	vpaddd	%ymm12, %ymm0, %ymm0
	vmovdqu	%ymm0, -64(%rsp)        # 32-byte Spill
	vpxor	%ymm4, %ymm0, %ymm1
	vpslld	$7, %ymm1, %ymm4
	vpsrld	$25, %ymm1, %ymm1
	vpor	%ymm4, %ymm1, %ymm4
	vpaddd	%ymm5, %ymm9, %ymm1
	vpxor	%ymm1, %ymm13, %ymm9
	vpshuflw	$177, %ymm9, %ymm9 # ymm9 = ymm9[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm9, %ymm13 # ymm13 = ymm9[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	-128(%rsp), %ymm13, %ymm2 # 32-byte Folded Reload
	vpxor	%ymm5, %ymm2, %ymm5
	vpslld	$12, %ymm5, %ymm9
	vpsrld	$20, %ymm5, %ymm5
	vpor	%ymm9, %ymm5, %ymm5
	vpaddd	%ymm1, %ymm5, %ymm9
	vpxor	%ymm9, %ymm13, %ymm1
	vpshufb	%ymm14, %ymm1, %ymm13
	vpaddd	%ymm13, %ymm2, %ymm1
	vpxor	%ymm5, %ymm1, %ymm2
	vpslld	$7, %ymm2, %ymm5
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm5, %ymm2, %ymm5
	vpaddd	%ymm6, %ymm10, %ymm2
	vpxor	-96(%rsp), %ymm2, %ymm10 # 32-byte Folded Reload
	vpshuflw	$177, %ymm10, %ymm10 # ymm10 = ymm10[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm10, %ymm0 # ymm0 = ymm10[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm0, %ymm3, %ymm3
	vpxor	%ymm6, %ymm3, %ymm6
	vpslld	$12, %ymm6, %ymm10
	vpsrld	$20, %ymm6, %ymm6
	vpor	%ymm10, %ymm6, %ymm6
	vpaddd	%ymm2, %ymm6, %ymm10
	vpxor	%ymm10, %ymm0, %ymm0
	vpshufb	%ymm14, %ymm0, %ymm0
	vpaddd	%ymm0, %ymm3, %ymm3
	vpxor	%ymm6, %ymm3, %ymm2
	vpslld	$7, %ymm2, %ymm6
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm6, %ymm2, %ymm6
	vpaddd	%ymm7, %ymm4, %ymm2
	vpxor	%ymm2, %ymm0, %ymm0
	vpshuflw	$177, %ymm0, %ymm0 # ymm0 = ymm0[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm0, %ymm0 # ymm0 = ymm0[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm0, %ymm1, %ymm1
	vpxor	%ymm4, %ymm1, %ymm4
	vpslld	$12, %ymm4, %ymm7
	vpsrld	$20, %ymm4, %ymm4
	vpor	%ymm7, %ymm4, %ymm4
	vpaddd	%ymm2, %ymm4, %ymm7
	vpxor	%ymm7, %ymm0, %ymm0
	vpshufb	%ymm14, %ymm0, %ymm0
	vmovdqu	%ymm0, -96(%rsp)        # 32-byte Spill
	vpaddd	%ymm0, %ymm1, %ymm0
	vmovdqu	%ymm0, -128(%rsp)       # 32-byte Spill
	vpxor	%ymm4, %ymm0, %ymm0
	vpslld	$7, %ymm0, %ymm1
	vpsrld	$25, %ymm0, %ymm0
	vpor	%ymm1, %ymm0, %ymm4
	vpaddd	%ymm8, %ymm5, %ymm0
	vpxor	%ymm0, %ymm11, %ymm1
	vpshuflw	$177, %ymm1, %ymm1 # ymm1 = ymm1[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm1, %ymm1 # ymm1 = ymm1[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm1, %ymm3, %ymm3
	vpxor	%ymm5, %ymm3, %ymm5
	vpslld	$12, %ymm5, %ymm8
	vpsrld	$20, %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpaddd	%ymm0, %ymm5, %ymm8
	vpxor	%ymm8, %ymm1, %ymm0
	vpshufb	%ymm14, %ymm0, %ymm11
	vpaddd	%ymm11, %ymm3, %ymm3
	vpxor	%ymm5, %ymm3, %ymm0
	vpslld	$7, %ymm0, %ymm1
	vpsrld	$25, %ymm0, %ymm0
	vpor	%ymm1, %ymm0, %ymm5
	vpaddd	%ymm9, %ymm6, %ymm0
	vpxor	%ymm0, %ymm12, %ymm1
	vpshuflw	$177, %ymm1, %ymm1 # ymm1 = ymm1[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm1, %ymm1 # ymm1 = ymm1[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm1, %ymm15, %ymm15
	vpxor	%ymm6, %ymm15, %ymm6
	vpslld	$12, %ymm6, %ymm9
	vpsrld	$20, %ymm6, %ymm6
	vpor	%ymm9, %ymm6, %ymm6
	vpaddd	%ymm0, %ymm6, %ymm9
	vpxor	%ymm9, %ymm1, %ymm0
	vpshufb	%ymm14, %ymm0, %ymm12
	vpaddd	%ymm12, %ymm15, %ymm15
	vpxor	%ymm6, %ymm15, %ymm0
	vpslld	$7, %ymm0, %ymm1
	vpsrld	$25, %ymm0, %ymm0
	vpor	%ymm1, %ymm0, %ymm6
	vmovdqu	-32(%rsp), %ymm2        # 32-byte Reload
	vpaddd	%ymm10, %ymm2, %ymm0
	vpxor	%ymm0, %ymm13, %ymm1
	vpshuflw	$177, %ymm1, %ymm1 # ymm1 = ymm1[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm1, %ymm1 # ymm1 = ymm1[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	-64(%rsp), %ymm1, %ymm14 # 32-byte Folded Reload
	vpxor	%ymm2, %ymm14, %ymm10
	vpslld	$12, %ymm10, %ymm13
	vpsrld	$20, %ymm10, %ymm10
	vpor	%ymm13, %ymm10, %ymm2
	vpaddd	%ymm0, %ymm2, %ymm10
	vpxor	%ymm10, %ymm1, %ymm0
	vpshufb	.LCPI0_0(%rip), %ymm0, %ymm13 # ymm13 = ymm0[3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14,19,16,17,18,23,20,21,22,27,24,25,26,31,28,29,30]
	vpaddd	%ymm13, %ymm14, %ymm0
	vpxor	%ymm2, %ymm0, %ymm1
	vpslld	$7, %ymm1, %ymm2
	vpsrld	$25, %ymm1, %ymm1
	vpor	%ymm2, %ymm1, %ymm14
	addl	$-1, %eax
	jne	.LBB0_1
# BB#2:
	vmovdqa	%ymm7, (%rsi)
	vmovdqa	%ymm8, 32(%rsi)
	vmovdqa	%ymm9, 64(%rsi)
	vmovdqa	%ymm10, 96(%rsi)
	vmovdqa	%ymm14, 128(%rsi)
	vmovdqa	%ymm4, 160(%rsi)
	vmovdqa	%ymm5, 192(%rsi)
	vmovdqa	%ymm6, 224(%rsi)
	vmovdqa	%ymm15, 256(%rsi)
	vmovdqa	%ymm0, 288(%rsi)
	vmovups	-128(%rsp), %ymm0       # 32-byte Reload
	vmovaps	%ymm0, 320(%rsi)
	vmovdqa	%ymm3, 352(%rsi)
	vmovdqa	%ymm11, 384(%rsi)
	vmovdqa	%ymm12, 416(%rsi)
	vmovdqa	%ymm13, 448(%rsi)
	vmovups	-96(%rsp), %ymm0        # 32-byte Reload
	vmovaps	%ymm0, 480(%rsi)
	addq	$24, %rsp
	vzeroupper
	retq
.Lfunc_end0:
	.size	Chacha20__, .Lfunc_end0-Chacha20__
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function crypto_stream_xor
.LCPI1_0:
	.long	7                       # 0x7
	.long	6                       # 0x6
	.long	5                       # 0x5
	.long	4                       # 0x4
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI1_1:
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
	.globl	crypto_stream_xor
	.p2align	4, 0x90
	.type	crypto_stream_xor,@function
crypto_stream_xor:                      # @crypto_stream_xor
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Lcfi1:
	.cfi_def_cfa_offset 16
.Lcfi2:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi3:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$1888, %rsp             # imm = 0x760
.Lcfi4:
	.cfi_offset %rbx, -56
.Lcfi5:
	.cfi_offset %r12, -48
.Lcfi6:
	.cfi_offset %r13, -40
.Lcfi7:
	.cfi_offset %r14, -32
.Lcfi8:
	.cfi_offset %r15, -24
	vpbroadcastd	chacha_const(%rip), %ymm8
	vmovdqa	%ymm8, 224(%rsp)
	vpbroadcastd	chacha_const+4(%rip), %ymm0
	vmovdqa	%ymm0, %ymm5
	vmovdqa	%ymm0, 256(%rsp)
	vpbroadcastd	chacha_const+8(%rip), %ymm10
	vmovdqa	%ymm10, 288(%rsp)
	vpbroadcastd	chacha_const+12(%rip), %ymm11
	vmovdqa	%ymm11, 320(%rsp)
	vpbroadcastd	(%r8), %ymm15
	vmovdqa	%ymm15, 352(%rsp)
	vpbroadcastd	4(%r8), %ymm13
	vmovdqa	%ymm13, 384(%rsp)
	vpbroadcastd	8(%r8), %ymm6
	vmovdqa	%ymm6, 416(%rsp)
	vpbroadcastd	12(%r8), %ymm1
	vmovdqa	%ymm1, 448(%rsp)
	vpbroadcastd	16(%r8), %ymm9
	vmovdqa	%ymm9, 480(%rsp)
	vpbroadcastd	20(%r8), %ymm3
	vmovdqa	%ymm3, 512(%rsp)
	vbroadcastss	24(%r8), %ymm0
	vmovaps	%ymm0, 32(%rsp)         # 32-byte Spill
	vmovaps	%ymm0, 544(%rsp)
	vpbroadcastd	28(%r8), %ymm7
	vmovdqa	%ymm7, 576(%rsp)
	vpbroadcastd	(%rcx), %ymm12
	vmovdqa	%ymm12, 672(%rsp)
	movl	4(%rcx), %eax
	vmovd	%eax, %xmm0
	vpbroadcastd	%xmm0, %ymm2
	vmovdqa	%ymm2, 704(%rsp)
	vpxor	%ymm0, %ymm0, %ymm0
	vmovdqa	%ymm0, 640(%rsp)
	vmovdqa	%ymm0, 608(%rsp)
	testq	%rdx, %rdx
	jle	.LBB1_57
# BB#1:
	vmovdqa	%ymm1, 64(%rsp)         # 32-byte Spill
	vmovdqa	%ymm7, %ymm1
	vmovdqa	%ymm2, %ymm0
	movl	$511, %r14d             # imm = 0x1FF
	movq	%rdx, 16(%rsp)          # 8-byte Spill
	subq	%rdx, %r14
	xorl	%r15d, %r15d
	movq	%r14, 176(%rsp)         # 8-byte Spill
	xorl	%r13d, %r13d
	movl	$0, 28(%rsp)            # 4-byte Folded Spill
	vmovdqa	%ymm5, %ymm7
	jmp	.LBB1_3
	.p2align	4, 0x90
.LBB1_2:                                #   in Loop: Header=BB1_3 Depth=1
	addq	$512, %r14              # imm = 0x200
	vmovdqa	224(%rsp), %ymm8
	vmovdqa	256(%rsp), %ymm7
	vmovdqa	288(%rsp), %ymm10
	vmovdqa	320(%rsp), %ymm11
	vmovdqa	352(%rsp), %ymm15
	vmovdqa	384(%rsp), %ymm13
	vmovdqa	416(%rsp), %ymm6
	vmovaps	448(%rsp), %ymm0
	vmovaps	%ymm0, 64(%rsp)         # 32-byte Spill
	vmovdqa	480(%rsp), %ymm9
	vmovdqa	512(%rsp), %ymm3
	vmovaps	544(%rsp), %ymm0
	vmovaps	%ymm0, 32(%rsp)         # 32-byte Spill
	vmovdqa	576(%rsp), %ymm1
	vmovdqa	672(%rsp), %ymm12
	vmovdqa	704(%rsp), %ymm0
	addq	$1, %r15
	movq	%rax, 16(%rsp)          # 8-byte Spill
.LBB1_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_4 Depth 2
                                        #     Child Loop BB1_39 Depth 2
                                        #     Child Loop BB1_11 Depth 2
                                        #     Child Loop BB1_13 Depth 2
                                        #     Child Loop BB1_44 Depth 2
                                        #     Child Loop BB1_50 Depth 2
                                        #     Child Loop BB1_52 Depth 2
                                        #     Child Loop BB1_31 Depth 2
                                        #     Child Loop BB1_20 Depth 2
                                        #     Child Loop BB1_22 Depth 2
	vmovdqa	%ymm1, 96(%rsp)         # 32-byte Spill
	vmovdqa	%ymm0, 128(%rsp)        # 32-byte Spill
	movl	%r13d, %eax
	cmpq	$-2, %r14
	movq	$-1, %rcx
	cmovgq	%r14, %rcx
	movl	$503, %r10d             # imm = 0x1F7
	subq	%rcx, %r10
	movq	%r10, %rcx
	shrq	$3, %rcx
	leaq	1(%rcx), %rdx
	andl	$15, %edx
	negq	%rdx
	leaq	(%rcx,%rdx), %r9
	addq	$1, %r9
	movq	%r15, %r13
	shlq	$9, %r13
	addq	176(%rsp), %r13         # 8-byte Folded Reload
	cmpq	$-2, %r13
	movq	$-1, %rdx
	cmovleq	%rdx, %r13
	movl	$503, %r12d             # imm = 0x1F7
	subq	%r13, %r12
	movq	%r12, %r8
	andq	$-8, %r8
	shrq	$3, %r12
	leaq	1352(%rsp), %rdx
	leaq	(%rdx,%r12,8), %rbx
	movq	%rbx, 184(%rsp)         # 8-byte Spill
	addq	$1, %r12
	andq	$-8, %r10
	leaq	(%rdx,%rcx,8), %r11
	movl	28(%rsp), %edx          # 4-byte Reload
	movl	%edx, %ecx
	orl	$3, %ecx
	vmovd	%ecx, %xmm0
	movl	%edx, %ecx
	orl	$2, %ecx
	vpinsrd	$1, %ecx, %xmm0, %xmm0
	movl	%edx, %ecx
	orl	$1, %ecx
	vmovd	%edx, %xmm1
	vpbroadcastd	%xmm1, %xmm1
	vpor	.LCPI1_0(%rip), %xmm1, %xmm1
	vpinsrd	$2, %ecx, %xmm0, %xmm0
	vpinsrd	$3, %edx, %xmm0, %xmm0
	vinserti128	$1, %xmm0, %ymm1, %ymm0
	vmovdqa	%ymm0, 608(%rsp)
	xorl	%ecx, %ecx
	addl	$8, %edx
	movl	%edx, 28(%rsp)          # 4-byte Spill
	sete	%cl
	addl	%eax, %ecx
	movl	%ecx, 12(%rsp)          # 4-byte Spill
	vmovd	%eax, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vmovdqa	%ymm1, 640(%rsp)
	movl	$10, %eax
	vmovdqa	%ymm13, %ymm5
	.p2align	4, 0x90
.LBB1_4:                                #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vpaddd	%ymm8, %ymm15, %ymm8
	vpxor	%ymm8, %ymm0, %ymm0
	vpshuflw	$177, %ymm0, %ymm0 # ymm0 = ymm0[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm0, %ymm0 # ymm0 = ymm0[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm0, %ymm9, %ymm13
	vpxor	%ymm15, %ymm13, %ymm15
	vpslld	$12, %ymm15, %ymm2
	vpsrld	$20, %ymm15, %ymm15
	vpor	%ymm2, %ymm15, %ymm2
	vpaddd	%ymm8, %ymm2, %ymm8
	vpxor	%ymm8, %ymm0, %ymm0
	vmovdqa	.LCPI1_1(%rip), %ymm4   # ymm4 = [3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14,3,0,1,2,7,4,5,6,11,8,9,10,15,12,13,14]
	vpshufb	%ymm4, %ymm0, %ymm0
	vmovdqa	%ymm0, 1248(%rsp)       # 32-byte Spill
	vpaddd	%ymm0, %ymm13, %ymm0
	vmovdqa	%ymm0, 1312(%rsp)       # 32-byte Spill
	vpxor	%ymm2, %ymm0, %ymm2
	vpslld	$7, %ymm2, %ymm15
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm15, %ymm2, %ymm0
	vmovdqa	%ymm0, 192(%rsp)        # 32-byte Spill
	vpaddd	%ymm7, %ymm5, %ymm2
	vpxor	%ymm2, %ymm1, %ymm1
	vpshuflw	$177, %ymm1, %ymm1 # ymm1 = ymm1[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm1, %ymm1 # ymm1 = ymm1[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm1, %ymm3, %ymm14
	vpxor	%ymm5, %ymm14, %ymm5
	vpslld	$12, %ymm5, %ymm9
	vpsrld	$20, %ymm5, %ymm5
	vpor	%ymm9, %ymm5, %ymm5
	vpaddd	%ymm2, %ymm5, %ymm9
	vpxor	%ymm9, %ymm1, %ymm1
	vpshufb	%ymm4, %ymm1, %ymm1
	vpaddd	%ymm1, %ymm14, %ymm0
	vmovdqa	%ymm0, 1280(%rsp)       # 32-byte Spill
	vpxor	%ymm5, %ymm0, %ymm2
	vpslld	$7, %ymm2, %ymm5
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm5, %ymm2, %ymm5
	vpaddd	%ymm10, %ymm6, %ymm2
	vpxor	%ymm2, %ymm12, %ymm10
	vpshuflw	$177, %ymm10, %ymm10 # ymm10 = ymm10[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm10, %ymm12 # ymm12 = ymm10[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	32(%rsp), %ymm12, %ymm3 # 32-byte Folded Reload
	vpxor	%ymm6, %ymm3, %ymm6
	vpslld	$12, %ymm6, %ymm10
	vpsrld	$20, %ymm6, %ymm6
	vpor	%ymm10, %ymm6, %ymm6
	vpaddd	%ymm2, %ymm6, %ymm10
	vpxor	%ymm10, %ymm12, %ymm2
	vmovdqa	%ymm4, %ymm15
	vpshufb	%ymm15, %ymm2, %ymm12
	vpaddd	%ymm12, %ymm3, %ymm2
	vpxor	%ymm6, %ymm2, %ymm3
	vpslld	$7, %ymm3, %ymm6
	vpsrld	$25, %ymm3, %ymm3
	vpor	%ymm6, %ymm3, %ymm6
	vmovdqa	64(%rsp), %ymm0         # 32-byte Reload
	vpaddd	%ymm11, %ymm0, %ymm3
	vpxor	128(%rsp), %ymm3, %ymm11 # 32-byte Folded Reload
	vpshuflw	$177, %ymm11, %ymm11 # ymm11 = ymm11[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm11, %ymm4 # ymm4 = ymm11[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	96(%rsp), %ymm4, %ymm7  # 32-byte Folded Reload
	vpxor	%ymm0, %ymm7, %ymm11
	vpslld	$12, %ymm11, %ymm0
	vpsrld	$20, %ymm11, %ymm11
	vpor	%ymm0, %ymm11, %ymm0
	vpaddd	%ymm3, %ymm0, %ymm11
	vpxor	%ymm11, %ymm4, %ymm3
	vpshufb	%ymm15, %ymm3, %ymm3
	vpaddd	%ymm3, %ymm7, %ymm4
	vpxor	%ymm0, %ymm4, %ymm0
	vpslld	$7, %ymm0, %ymm7
	vpsrld	$25, %ymm0, %ymm0
	vpor	%ymm7, %ymm0, %ymm7
	vpaddd	%ymm8, %ymm5, %ymm0
	vpxor	%ymm0, %ymm3, %ymm3
	vpshuflw	$177, %ymm3, %ymm3 # ymm3 = ymm3[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm3, %ymm3 # ymm3 = ymm3[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm3, %ymm2, %ymm2
	vpxor	%ymm5, %ymm2, %ymm5
	vpslld	$12, %ymm5, %ymm8
	vpsrld	$20, %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpaddd	%ymm0, %ymm5, %ymm13
	vpxor	%ymm13, %ymm3, %ymm0
	vpshufb	%ymm15, %ymm0, %ymm0
	vmovdqa	%ymm0, 128(%rsp)        # 32-byte Spill
	vpaddd	%ymm0, %ymm2, %ymm0
	vmovdqa	%ymm0, 32(%rsp)         # 32-byte Spill
	vpxor	%ymm5, %ymm0, %ymm0
	vpslld	$7, %ymm0, %ymm2
	vpsrld	$25, %ymm0, %ymm0
	vpor	%ymm2, %ymm0, %ymm14
	vpaddd	%ymm9, %ymm6, %ymm0
	vpxor	1248(%rsp), %ymm0, %ymm2 # 32-byte Folded Reload
	vpshuflw	$177, %ymm2, %ymm2 # ymm2 = ymm2[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm2, %ymm2 # ymm2 = ymm2[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	%ymm2, %ymm4, %ymm4
	vpxor	%ymm6, %ymm4, %ymm6
	vpslld	$12, %ymm6, %ymm9
	vpsrld	$20, %ymm6, %ymm6
	vpor	%ymm9, %ymm6, %ymm6
	vpaddd	%ymm0, %ymm6, %ymm5
	vpxor	%ymm5, %ymm2, %ymm0
	vpshufb	%ymm15, %ymm0, %ymm0
	vpaddd	%ymm0, %ymm4, %ymm2
	vmovdqa	%ymm2, 96(%rsp)         # 32-byte Spill
	vpxor	%ymm6, %ymm2, %ymm2
	vpslld	$7, %ymm2, %ymm4
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm4, %ymm2, %ymm6
	vpaddd	%ymm10, %ymm7, %ymm2
	vpxor	%ymm2, %ymm1, %ymm1
	vpshuflw	$177, %ymm1, %ymm1 # ymm1 = ymm1[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm1, %ymm1 # ymm1 = ymm1[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	1312(%rsp), %ymm1, %ymm4 # 32-byte Folded Reload
	vpxor	%ymm7, %ymm4, %ymm7
	vpslld	$12, %ymm7, %ymm10
	vpsrld	$20, %ymm7, %ymm7
	vpor	%ymm10, %ymm7, %ymm7
	vpaddd	%ymm2, %ymm7, %ymm10
	vpxor	%ymm10, %ymm1, %ymm1
	vpshufb	%ymm15, %ymm1, %ymm1
	vmovdqa	%ymm15, %ymm3
	vpaddd	%ymm1, %ymm4, %ymm9
	vpxor	%ymm7, %ymm9, %ymm2
	vpslld	$7, %ymm2, %ymm4
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm4, %ymm2, %ymm2
	vmovdqa	%ymm2, 64(%rsp)         # 32-byte Spill
	vmovdqa	192(%rsp), %ymm8        # 32-byte Reload
	vpaddd	%ymm11, %ymm8, %ymm2
	vpxor	%ymm2, %ymm12, %ymm4
	vpshuflw	$177, %ymm4, %ymm4 # ymm4 = ymm4[1,0,3,2,4,5,6,7,9,8,11,10,12,13,14,15]
	vpshufhw	$177, %ymm4, %ymm4 # ymm4 = ymm4[0,1,2,3,5,4,7,6,8,9,10,11,13,12,15,14]
	vpaddd	1280(%rsp), %ymm4, %ymm7 # 32-byte Folded Reload
	vpxor	%ymm8, %ymm7, %ymm11
	vpslld	$12, %ymm11, %ymm12
	vpsrld	$20, %ymm11, %ymm11
	vpor	%ymm12, %ymm11, %ymm15
	vpaddd	%ymm2, %ymm15, %ymm11
	vpxor	%ymm11, %ymm4, %ymm2
	vpshufb	%ymm3, %ymm2, %ymm12
	vmovdqa	%ymm13, %ymm8
	vpaddd	%ymm12, %ymm7, %ymm3
	vmovdqa	%ymm5, %ymm7
	vmovdqa	%ymm14, %ymm5
	vpxor	%ymm15, %ymm3, %ymm2
	vpslld	$7, %ymm2, %ymm4
	vpsrld	$25, %ymm2, %ymm2
	vpor	%ymm4, %ymm2, %ymm15
	addl	$-1, %eax
	jne	.LBB1_4
# BB#5:                                 #   in Loop: Header=BB1_3 Depth=1
	vpaddd	224(%rsp), %ymm8, %ymm14
	vmovdqa	%ymm14, 736(%rsp)
	vpaddd	256(%rsp), %ymm7, %ymm8
	vmovdqa	%ymm8, 768(%rsp)
	vpaddd	288(%rsp), %ymm10, %ymm2
	vmovdqa	%ymm2, 800(%rsp)
	vpaddd	320(%rsp), %ymm11, %ymm7
	vmovdqa	%ymm7, 832(%rsp)
	vpaddd	352(%rsp), %ymm15, %ymm4
	vmovdqa	%ymm4, 864(%rsp)
	vpaddd	384(%rsp), %ymm5, %ymm13
	vmovdqa	%ymm13, 896(%rsp)
	vpaddd	416(%rsp), %ymm6, %ymm15
	vmovdqa	%ymm15, 928(%rsp)
	vmovdqa	64(%rsp), %ymm10        # 32-byte Reload
	vpaddd	448(%rsp), %ymm10, %ymm10
	vmovdqa	%ymm10, 960(%rsp)
	vpaddd	480(%rsp), %ymm9, %ymm11
	vmovdqa	%ymm11, 992(%rsp)
	vpaddd	512(%rsp), %ymm3, %ymm11
	vmovdqa	%ymm11, 1024(%rsp)
	vmovdqa	32(%rsp), %ymm3         # 32-byte Reload
	vpaddd	544(%rsp), %ymm3, %ymm3
	vmovdqa	%ymm3, 1056(%rsp)
	vmovdqa	96(%rsp), %ymm3         # 32-byte Reload
	vpaddd	576(%rsp), %ymm3, %ymm3
	vmovdqa	%ymm3, 1088(%rsp)
	vpaddd	608(%rsp), %ymm0, %ymm0
	vmovdqa	%ymm0, 1120(%rsp)
	vpaddd	640(%rsp), %ymm1, %ymm0
	vmovdqa	%ymm0, 1152(%rsp)
	vpaddd	672(%rsp), %ymm12, %ymm0
	vmovdqa	%ymm0, 1184(%rsp)
	vmovdqa	128(%rsp), %ymm0        # 32-byte Reload
	vpaddd	704(%rsp), %ymm0, %ymm0
	vmovdqa	%ymm0, 1216(%rsp)
	vpermq	$216, %ymm14, %ymm0     # ymm0 = ymm14[0,2,1,3]
	vpermq	$216, %ymm8, %ymm1      # ymm1 = ymm8[0,2,1,3]
	vpermq	$216, %ymm2, %ymm2      # ymm2 = ymm2[0,2,1,3]
	vpermq	$216, %ymm7, %ymm3      # ymm3 = ymm7[0,2,1,3]
	vpermq	$216, %ymm4, %ymm4      # ymm4 = ymm4[0,2,1,3]
	vpermq	$216, %ymm13, %ymm5     # ymm5 = ymm13[0,2,1,3]
	vpermq	$216, %ymm15, %ymm6     # ymm6 = ymm15[0,2,1,3]
	vpermq	$216, %ymm10, %ymm7     # ymm7 = ymm10[0,2,1,3]
	vpunpckldq	%ymm1, %ymm0, %ymm8 # ymm8 = ymm0[0],ymm1[0],ymm0[1],ymm1[1],ymm0[4],ymm1[4],ymm0[5],ymm1[5]
	vpermq	$216, %ymm8, %ymm8      # ymm8 = ymm8[0,2,1,3]
	vpunpckldq	%ymm3, %ymm2, %ymm9 # ymm9 = ymm2[0],ymm3[0],ymm2[1],ymm3[1],ymm2[4],ymm3[4],ymm2[5],ymm3[5]
	vpermq	$216, %ymm9, %ymm9      # ymm9 = ymm9[0,2,1,3]
	vpunpcklqdq	%ymm9, %ymm8, %ymm10 # ymm10 = ymm8[0],ymm9[0],ymm8[2],ymm9[2]
	vpunpckhqdq	%ymm9, %ymm8, %ymm8 # ymm8 = ymm8[1],ymm9[1],ymm8[3],ymm9[3]
	vpunpckhdq	%ymm1, %ymm0, %ymm0 # ymm0 = ymm0[2],ymm1[2],ymm0[3],ymm1[3],ymm0[6],ymm1[6],ymm0[7],ymm1[7]
	vpermq	$216, %ymm0, %ymm0      # ymm0 = ymm0[0,2,1,3]
	vpunpckhdq	%ymm3, %ymm2, %ymm1 # ymm1 = ymm2[2],ymm3[2],ymm2[3],ymm3[3],ymm2[6],ymm3[6],ymm2[7],ymm3[7]
	vpermq	$216, %ymm1, %ymm1      # ymm1 = ymm1[0,2,1,3]
	vpunpcklqdq	%ymm1, %ymm0, %ymm9 # ymm9 = ymm0[0],ymm1[0],ymm0[2],ymm1[2]
	vpunpckhqdq	%ymm1, %ymm0, %ymm11 # ymm11 = ymm0[1],ymm1[1],ymm0[3],ymm1[3]
	vpunpckldq	%ymm5, %ymm4, %ymm0 # ymm0 = ymm4[0],ymm5[0],ymm4[1],ymm5[1],ymm4[4],ymm5[4],ymm4[5],ymm5[5]
	vpermq	$216, %ymm0, %ymm0      # ymm0 = ymm0[0,2,1,3]
	vpunpckldq	%ymm7, %ymm6, %ymm1 # ymm1 = ymm6[0],ymm7[0],ymm6[1],ymm7[1],ymm6[4],ymm7[4],ymm6[5],ymm7[5]
	vpermq	$216, %ymm1, %ymm1      # ymm1 = ymm1[0,2,1,3]
	vpunpcklqdq	%ymm1, %ymm0, %ymm2 # ymm2 = ymm0[0],ymm1[0],ymm0[2],ymm1[2]
	vpunpckhqdq	%ymm1, %ymm0, %ymm3 # ymm3 = ymm0[1],ymm1[1],ymm0[3],ymm1[3]
	vpunpckhdq	%ymm5, %ymm4, %ymm0 # ymm0 = ymm4[2],ymm5[2],ymm4[3],ymm5[3],ymm4[6],ymm5[6],ymm4[7],ymm5[7]
	vpermq	$216, %ymm0, %ymm0      # ymm0 = ymm0[0,2,1,3]
	vpunpckhdq	%ymm7, %ymm6, %ymm1 # ymm1 = ymm6[2],ymm7[2],ymm6[3],ymm7[3],ymm6[6],ymm7[6],ymm6[7],ymm7[7]
	vpermq	$216, %ymm1, %ymm1      # ymm1 = ymm1[0,2,1,3]
	vpunpcklqdq	%ymm1, %ymm0, %ymm5 # ymm5 = ymm0[0],ymm1[0],ymm0[2],ymm1[2]
	vpunpckhqdq	%ymm1, %ymm0, %ymm7 # ymm7 = ymm0[1],ymm1[1],ymm0[3],ymm1[3]
	vinserti128	$1, %xmm2, %ymm10, %ymm0
	vmovdqa	%ymm0, 32(%rsp)         # 32-byte Spill
	vmovdqa	%ymm0, 736(%rsp)
	vperm2i128	$49, %ymm2, %ymm10, %ymm0 # ymm0 = ymm10[2,3],ymm2[2,3]
	vmovdqa	%ymm0, 64(%rsp)         # 32-byte Spill
	vmovdqa	%ymm0, 768(%rsp)
	vinserti128	$1, %xmm3, %ymm8, %ymm0
	vmovdqa	%ymm0, 128(%rsp)        # 32-byte Spill
	vmovdqa	%ymm0, 800(%rsp)
	vperm2i128	$49, %ymm3, %ymm8, %ymm3 # ymm3 = ymm8[2,3],ymm3[2,3]
	vmovdqa	%ymm3, 832(%rsp)
	vinserti128	$1, %xmm5, %ymm9, %ymm4
	vmovdqa	%ymm4, 864(%rsp)
	vperm2i128	$49, %ymm5, %ymm9, %ymm5 # ymm5 = ymm9[2,3],ymm5[2,3]
	vmovdqa	%ymm5, 896(%rsp)
	vinserti128	$1, %xmm7, %ymm11, %ymm6
	vmovdqa	%ymm6, 928(%rsp)
	vperm2i128	$49, %ymm7, %ymm11, %ymm7 # ymm7 = ymm11[2,3],ymm7[2,3]
	vmovdqa	%ymm7, 960(%rsp)
	vpermq	$216, 992(%rsp), %ymm8  # ymm8 = mem[0,2,1,3]
	vpermq	$216, 1024(%rsp), %ymm9 # ymm9 = mem[0,2,1,3]
	vpermq	$216, 1056(%rsp), %ymm10 # ymm10 = mem[0,2,1,3]
	vpermq	$216, 1088(%rsp), %ymm11 # ymm11 = mem[0,2,1,3]
	vpermq	$216, 1120(%rsp), %ymm12 # ymm12 = mem[0,2,1,3]
	vpunpckldq	%ymm9, %ymm8, %ymm13 # ymm13 = ymm8[0],ymm9[0],ymm8[1],ymm9[1],ymm8[4],ymm9[4],ymm8[5],ymm9[5]
	vpermq	$216, %ymm13, %ymm13    # ymm13 = ymm13[0,2,1,3]
	vpunpckldq	%ymm11, %ymm10, %ymm14 # ymm14 = ymm10[0],ymm11[0],ymm10[1],ymm11[1],ymm10[4],ymm11[4],ymm10[5],ymm11[5]
	vpermq	$216, %ymm14, %ymm14    # ymm14 = ymm14[0,2,1,3]
	vpunpcklqdq	%ymm14, %ymm13, %ymm15 # ymm15 = ymm13[0],ymm14[0],ymm13[2],ymm14[2]
	vpunpckhqdq	%ymm14, %ymm13, %ymm13 # ymm13 = ymm13[1],ymm14[1],ymm13[3],ymm14[3]
	vpermq	$216, 1152(%rsp), %ymm14 # ymm14 = mem[0,2,1,3]
	vpunpckhdq	%ymm9, %ymm8, %ymm8 # ymm8 = ymm8[2],ymm9[2],ymm8[3],ymm9[3],ymm8[6],ymm9[6],ymm8[7],ymm9[7]
	vpermq	$216, 1184(%rsp), %ymm9 # ymm9 = mem[0,2,1,3]
	vpermq	$216, %ymm8, %ymm8      # ymm8 = ymm8[0,2,1,3]
	vpunpckhdq	%ymm11, %ymm10, %ymm10 # ymm10 = ymm10[2],ymm11[2],ymm10[3],ymm11[3],ymm10[6],ymm11[6],ymm10[7],ymm11[7]
	vpermq	$216, %ymm10, %ymm10    # ymm10 = ymm10[0,2,1,3]
	vpunpcklqdq	%ymm10, %ymm8, %ymm11 # ymm11 = ymm8[0],ymm10[0],ymm8[2],ymm10[2]
	vpunpckhqdq	%ymm10, %ymm8, %ymm8 # ymm8 = ymm8[1],ymm10[1],ymm8[3],ymm10[3]
	vpunpckldq	%ymm14, %ymm12, %ymm10 # ymm10 = ymm12[0],ymm14[0],ymm12[1],ymm14[1],ymm12[4],ymm14[4],ymm12[5],ymm14[5]
	vpermq	$216, %ymm10, %ymm10    # ymm10 = ymm10[0,2,1,3]
	vpermq	$216, 1216(%rsp), %ymm0 # ymm0 = mem[0,2,1,3]
	vpunpckldq	%ymm0, %ymm9, %ymm1 # ymm1 = ymm9[0],ymm0[0],ymm9[1],ymm0[1],ymm9[4],ymm0[4],ymm9[5],ymm0[5]
	vpermq	$216, %ymm1, %ymm1      # ymm1 = ymm1[0,2,1,3]
	vpunpcklqdq	%ymm1, %ymm10, %ymm2 # ymm2 = ymm10[0],ymm1[0],ymm10[2],ymm1[2]
	vpunpckhqdq	%ymm1, %ymm10, %ymm1 # ymm1 = ymm10[1],ymm1[1],ymm10[3],ymm1[3]
	vpunpckhdq	%ymm14, %ymm12, %ymm10 # ymm10 = ymm12[2],ymm14[2],ymm12[3],ymm14[3],ymm12[6],ymm14[6],ymm12[7],ymm14[7]
	vpunpckhdq	%ymm0, %ymm9, %ymm0 # ymm0 = ymm9[2],ymm0[2],ymm9[3],ymm0[3],ymm9[6],ymm0[6],ymm9[7],ymm0[7]
	vpermq	$216, %ymm10, %ymm9     # ymm9 = ymm10[0,2,1,3]
	vpermq	$216, %ymm0, %ymm0      # ymm0 = ymm0[0,2,1,3]
	vpunpcklqdq	%ymm0, %ymm9, %ymm10 # ymm10 = ymm9[0],ymm0[0],ymm9[2],ymm0[2]
	vpunpckhqdq	%ymm0, %ymm9, %ymm0 # ymm0 = ymm9[1],ymm0[1],ymm9[3],ymm0[3]
	vinserti128	$1, %xmm2, %ymm15, %ymm9
	vperm2i128	$49, %ymm2, %ymm15, %ymm2 # ymm2 = ymm15[2,3],ymm2[2,3]
	vinserti128	$1, %xmm1, %ymm13, %ymm12
	vperm2i128	$49, %ymm1, %ymm13, %ymm1 # ymm1 = ymm13[2,3],ymm1[2,3]
	vinserti128	$1, %xmm10, %ymm11, %ymm13
	vperm2i128	$49, %ymm10, %ymm11, %ymm10 # ymm10 = ymm11[2,3],ymm10[2,3]
	vinserti128	$1, %xmm0, %ymm8, %ymm11
	vperm2i128	$49, %ymm0, %ymm8, %ymm0 # ymm0 = ymm8[2,3],ymm0[2,3]
	vmovaps	32(%rsp), %ymm8         # 32-byte Reload
	vmovaps	%ymm8, 1792(%rsp)
	vmovdqa	%ymm9, 992(%rsp)
	vmovdqa	%ymm9, 1824(%rsp)
	vmovdqa	64(%rsp), %ymm8         # 32-byte Reload
	vmovdqa	%ymm8, 1728(%rsp)
	vmovdqa	%ymm2, 1024(%rsp)
	vmovdqa	%ymm2, 1760(%rsp)
	vmovdqa	128(%rsp), %ymm2        # 32-byte Reload
	vmovdqa	%ymm2, 1664(%rsp)
	vmovdqa	%ymm12, 1056(%rsp)
	vmovdqa	%ymm12, 1696(%rsp)
	vmovdqa	%ymm3, 1600(%rsp)
	vmovdqa	%ymm1, 1088(%rsp)
	vmovdqa	%ymm1, 1632(%rsp)
	vmovdqa	%ymm4, 1536(%rsp)
	vmovdqa	%ymm13, 1120(%rsp)
	vmovdqa	%ymm13, 1568(%rsp)
	vmovdqa	%ymm5, 1472(%rsp)
	vmovdqa	%ymm10, 1152(%rsp)
	vmovdqa	%ymm10, 1504(%rsp)
	vmovdqa	%ymm6, 1408(%rsp)
	vmovdqa	%ymm11, 1184(%rsp)
	vmovdqa	%ymm11, 1440(%rsp)
	vmovdqa	%ymm7, 1344(%rsp)
	vmovdqa	%ymm0, 1216(%rsp)
	vmovdqa	%ymm0, 1376(%rsp)
	movq	16(%rsp), %rcx          # 8-byte Reload
	leaq	-512(%rcx), %rax
	testq	%rsi, %rsi
	je	.LBB1_23
# BB#6:                                 #   in Loop: Header=BB1_3 Depth=1
	movq	%r14, 128(%rsp)         # 8-byte Spill
	movq	%r15, 64(%rsp)          # 8-byte Spill
	movq	%rax, %r15
	sarq	$63, %r15
	andq	%rax, %r15
	addq	$512, %r15              # imm = 0x200
	cmpq	$8, %r15
	movq	%rax, 32(%rsp)          # 8-byte Spill
	jb	.LBB1_24
# BB#7:                                 #   in Loop: Header=BB1_3 Depth=1
	leaq	8(%rdi), %r14
	leaq	8(%rsi), %rax
	movq	%rax, 96(%rsp)          # 8-byte Spill
	cmpq	$16, %r12
	jae	.LBB1_36
.LBB1_8:                                #   in Loop: Header=BB1_3 Depth=1
	leaq	1344(%rsp), %rcx
	movq	%rdi, %rax
	movq	%rsi, %rbx
	movq	96(%rsp), %r8           # 8-byte Reload
.LBB1_9:                                #   in Loop: Header=BB1_3 Depth=1
	movl	$7, %esi
	subq	%r15, %rsi
	cmpq	$-8, %rsi
	movq	$-8, %rdx
	cmovbeq	%rdx, %rsi
	addq	%r15, %rsi
	movl	%esi, %edi
	shrl	$3, %edi
	addl	$1, %edi
	andq	$7, %rdi
	je	.LBB1_12
# BB#10:                                #   in Loop: Header=BB1_3 Depth=1
	negq	%rdi
	.p2align	4, 0x90
.LBB1_11:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rbx), %rdx
	xorq	(%rcx), %rdx
	movq	%rdx, (%rax)
	addq	$8, %rax
	addq	$8, %rcx
	addq	$8, %rbx
	addq	$-8, %r15
	addq	$1, %rdi
	jne	.LBB1_11
.LBB1_12:                               #   in Loop: Header=BB1_3 Depth=1
	cmpq	$56, %rsi
	jb	.LBB1_14
	.p2align	4, 0x90
.LBB1_13:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rbx), %rdx
	xorq	(%rcx), %rdx
	movq	%rdx, (%rax)
	movq	8(%rbx), %rdx
	xorq	8(%rcx), %rdx
	movq	%rdx, 8(%rax)
	movq	16(%rbx), %rdx
	xorq	16(%rcx), %rdx
	movq	%rdx, 16(%rax)
	movq	24(%rbx), %rdx
	xorq	24(%rcx), %rdx
	movq	%rdx, 24(%rax)
	movq	32(%rbx), %rdx
	xorq	32(%rcx), %rdx
	movq	%rdx, 32(%rax)
	movq	40(%rbx), %rdx
	xorq	40(%rcx), %rdx
	movq	%rdx, 40(%rax)
	movq	48(%rbx), %rdx
	xorq	48(%rcx), %rdx
	movq	%rdx, 48(%rax)
	movq	56(%rbx), %rdx
	xorq	56(%rcx), %rdx
	movq	%rdx, 56(%rax)
	addq	$-64, %r15
	addq	$64, %rcx
	addq	$64, %rbx
	addq	$64, %rax
	cmpq	$7, %r15
	ja	.LBB1_13
.LBB1_14:                               #   in Loop: Header=BB1_3 Depth=1
	addq	%r10, %r14
	addq	%r10, %r8
	movq	%r8, %rsi
	movq	%r14, %rdi
	movq	32(%rsp), %rax          # 8-byte Reload
	movq	16(%rsp), %rcx          # 8-byte Reload
	cmpq	$4, %r15
	jae	.LBB1_25
.LBB1_15:                               #   in Loop: Header=BB1_3 Depth=1
	movl	12(%rsp), %r13d         # 4-byte Reload
	testq	%r15, %r15
	je	.LBB1_54
.LBB1_16:                               #   in Loop: Header=BB1_3 Depth=1
	movq	%rcx, %r10
	cmpq	$128, %r15
	jae	.LBB1_27
.LBB1_17:                               #   in Loop: Header=BB1_3 Depth=1
	movq	%r15, %r9
	movq	%rdi, %rbx
	movq	%rsi, %rax
.LBB1_18:                               #   in Loop: Header=BB1_3 Depth=1
	leaq	-1(%r9), %r8
	movq	%r9, %rcx
	andq	$7, %rcx
	je	.LBB1_21
# BB#19:                                #   in Loop: Header=BB1_3 Depth=1
	negq	%rcx
	.p2align	4, 0x90
.LBB1_20:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rax), %edx
	xorb	(%r11), %dl
	movb	%dl, (%rbx)
	addq	$1, %rbx
	addq	$1, %r11
	addq	$1, %rax
	addq	$-1, %r9
	addq	$1, %rcx
	jne	.LBB1_20
.LBB1_21:                               #   in Loop: Header=BB1_3 Depth=1
	cmpq	$7, %r8
	jb	.LBB1_35
	.p2align	4, 0x90
.LBB1_22:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rax), %ecx
	xorb	(%r11), %cl
	movb	%cl, (%rbx)
	movzbl	1(%rax), %ecx
	xorb	1(%r11), %cl
	movb	%cl, 1(%rbx)
	movzbl	2(%rax), %ecx
	xorb	2(%r11), %cl
	movb	%cl, 2(%rbx)
	movzbl	3(%rax), %ecx
	xorb	3(%r11), %cl
	movb	%cl, 3(%rbx)
	movzbl	4(%rax), %ecx
	xorb	4(%r11), %cl
	movb	%cl, 4(%rbx)
	movzbl	5(%rax), %ecx
	xorb	5(%r11), %cl
	movb	%cl, 5(%rbx)
	movzbl	6(%rax), %ecx
	xorb	6(%r11), %cl
	movb	%cl, 6(%rbx)
	movzbl	7(%rax), %ecx
	xorb	7(%r11), %cl
	movb	%cl, 7(%rbx)
	addq	$8, %r11
	addq	$8, %rax
	addq	$8, %rbx
	addq	$-8, %r9
	jne	.LBB1_22
	jmp	.LBB1_35
	.p2align	4, 0x90
.LBB1_23:                               #   in Loop: Header=BB1_3 Depth=1
	xorl	%esi, %esi
	leaq	1344(%rsp), %rdi
	movl	12(%rsp), %r13d         # 4-byte Reload
	cmpq	$513, %rcx              # imm = 0x201
	jge	.LBB1_2
	jmp	.LBB1_57
	.p2align	4, 0x90
.LBB1_24:                               #   in Loop: Header=BB1_3 Depth=1
	leaq	1344(%rsp), %r11
	cmpq	$4, %r15
	jb	.LBB1_15
.LBB1_25:                               #   in Loop: Header=BB1_3 Depth=1
	leaq	-4(%r15), %r10
	movq	%r10, %r12
	andq	$-4, %r12
	leaq	4(%r11), %r8
	leaq	4(%rsi), %r9
	movq	%r10, %r13
	shrq	$2, %r13
	addq	$1, %r13
	cmpq	$32, %r13
	jae	.LBB1_41
# BB#26:                                #   in Loop: Header=BB1_3 Depth=1
	movq	%rcx, %r14
	movq	%r11, %rbx
	movq	%rdi, %rcx
	movq	%rsi, %rax
	jmp	.LBB1_47
.LBB1_27:                               #   in Loop: Header=BB1_3 Depth=1
	leaq	(%rdi,%r15), %rcx
	leaq	(%r11,%r15), %rax
	leaq	(%rsi,%r15), %rdx
	cmpq	%rax, %rdi
	setb	%r8b
	cmpq	%rcx, %r11
	setb	%bl
	cmpq	%rdx, %rdi
	setb	%al
	cmpq	%rcx, %rsi
	setb	%cl
	testb	%bl, %r8b
	jne	.LBB1_17
# BB#28:                                #   in Loop: Header=BB1_3 Depth=1
	andb	%cl, %al
	jne	.LBB1_17
# BB#29:                                #   in Loop: Header=BB1_3 Depth=1
	movq	%r15, %rax
	andq	$-128, %rax
	leaq	-128(%rax), %rbx
	shrq	$7, %rbx
	leal	1(%rbx), %ecx
	andl	$1, %ecx
	testq	%rbx, %rbx
	je	.LBB1_56
# BB#30:                                #   in Loop: Header=BB1_3 Depth=1
	leaq	-1(%rcx), %rdx
	subq	%rbx, %rdx
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB1_31:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	(%rsi,%rbx), %ymm0
	vmovups	32(%rsi,%rbx), %ymm1
	vmovups	64(%rsi,%rbx), %ymm2
	vmovups	96(%rsi,%rbx), %ymm3
	vxorps	(%r11,%rbx), %ymm0, %ymm0
	vxorps	32(%r11,%rbx), %ymm1, %ymm1
	vxorps	64(%r11,%rbx), %ymm2, %ymm2
	vxorps	96(%r11,%rbx), %ymm3, %ymm3
	vmovups	%ymm0, (%rdi,%rbx)
	vmovups	%ymm1, 32(%rdi,%rbx)
	vmovups	%ymm2, 64(%rdi,%rbx)
	vmovups	%ymm3, 96(%rdi,%rbx)
	vmovdqu	128(%rsi,%rbx), %ymm0
	vmovdqu	160(%rsi,%rbx), %ymm1
	vmovdqu	192(%rsi,%rbx), %ymm2
	vmovdqu	224(%rsi,%rbx), %ymm3
	vpxor	128(%r11,%rbx), %ymm0, %ymm0
	vpxor	160(%r11,%rbx), %ymm1, %ymm1
	vpxor	192(%r11,%rbx), %ymm2, %ymm2
	vpxor	224(%r11,%rbx), %ymm3, %ymm3
	vmovdqu	%ymm0, 128(%rdi,%rbx)
	vmovdqu	%ymm1, 160(%rdi,%rbx)
	vmovdqu	%ymm2, 192(%rdi,%rbx)
	vmovdqu	%ymm3, 224(%rdi,%rbx)
	addq	$256, %rbx              # imm = 0x100
	addq	$2, %rdx
	jne	.LBB1_31
# BB#32:                                #   in Loop: Header=BB1_3 Depth=1
	testq	%rcx, %rcx
	je	.LBB1_34
.LBB1_33:                               #   in Loop: Header=BB1_3 Depth=1
	vmovdqu	(%rsi,%rbx), %ymm0
	vmovdqu	32(%rsi,%rbx), %ymm1
	vmovdqu	64(%rsi,%rbx), %ymm2
	vmovdqu	96(%rsi,%rbx), %ymm3
	vpxor	(%r11,%rbx), %ymm0, %ymm0
	vpxor	32(%r11,%rbx), %ymm1, %ymm1
	vpxor	64(%r11,%rbx), %ymm2, %ymm2
	vpxor	96(%r11,%rbx), %ymm3, %ymm3
	vmovdqu	%ymm0, (%rdi,%rbx)
	vmovdqu	%ymm1, 32(%rdi,%rbx)
	vmovdqu	%ymm2, 64(%rdi,%rbx)
	vmovdqu	%ymm3, 96(%rdi,%rbx)
.LBB1_34:                               #   in Loop: Header=BB1_3 Depth=1
	cmpq	%rax, %r15
	jne	.LBB1_55
	.p2align	4, 0x90
.LBB1_35:                               #   in Loop: Header=BB1_3 Depth=1
	addq	%r15, %rdi
	addq	%r15, %rsi
	movq	64(%rsp), %r15          # 8-byte Reload
	movq	128(%rsp), %r14         # 8-byte Reload
	movq	32(%rsp), %rax          # 8-byte Reload
	movq	%r10, %rcx
	cmpq	$513, %rcx              # imm = 0x201
	jge	.LBB1_2
	jmp	.LBB1_57
.LBB1_36:                               #   in Loop: Header=BB1_3 Depth=1
	leaq	(%rdi,%r8), %rcx
	addq	$8, %rcx
	leaq	(%rsi,%r8), %rax
	addq	$8, %rax
	cmpq	184(%rsp), %rdi         # 8-byte Folded Reload
	setb	%dl
	leaq	1344(%rsp), %rbx
	cmpq	%rbx, %rcx
	seta	%bl
	cmpq	%rax, %rdi
	setb	%al
	cmpq	%rcx, %rsi
	setb	%cl
	testb	%bl, %dl
	jne	.LBB1_8
# BB#37:                                #   in Loop: Header=BB1_3 Depth=1
	andb	%cl, %al
	jne	.LBB1_8
# BB#38:                                #   in Loop: Header=BB1_3 Depth=1
	movq	%r14, 192(%rsp)         # 8-byte Spill
	movl	%r12d, %r14d
	andl	$15, %r14d
	subq	%r14, %r12
	leaq	503(,%r14,8), %r15
	subq	%r13, %r15
	subq	%r8, %r15
	leaq	(%rsp,%r12,8), %rcx
	addq	$1344, %rcx             # imm = 0x540
	leaq	(%rdi,%r12,8), %rax
	leaq	(%rsi,%r12,8), %rbx
	addq	$96, %rsi
	addq	$96, %rdi
	leaq	1440(%rsp), %rdx
	.p2align	4, 0x90
.LBB1_39:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu	-96(%rsi), %ymm0
	vmovdqu	-64(%rsi), %ymm1
	vmovdqu	-32(%rsi), %ymm2
	vmovdqu	(%rsi), %ymm3
	vpxor	-96(%rdx), %ymm0, %ymm0
	vpxor	-64(%rdx), %ymm1, %ymm1
	vpxor	-32(%rdx), %ymm2, %ymm2
	vpxor	(%rdx), %ymm3, %ymm3
	vmovdqu	%ymm0, -96(%rdi)
	vmovdqu	%ymm1, -64(%rdi)
	vmovdqu	%ymm2, -32(%rdi)
	vmovdqu	%ymm3, (%rdi)
	subq	$-128, %rsi
	subq	$-128, %rdi
	subq	$-128, %rdx
	addq	$-16, %r9
	jne	.LBB1_39
# BB#40:                                #   in Loop: Header=BB1_3 Depth=1
	testq	%r14, %r14
	movq	192(%rsp), %r14         # 8-byte Reload
	movq	96(%rsp), %r8           # 8-byte Reload
	jne	.LBB1_9
	jmp	.LBB1_14
.LBB1_41:                               #   in Loop: Header=BB1_3 Depth=1
	movq	%rcx, 16(%rsp)          # 8-byte Spill
	leaq	(%rdi,%r12), %rcx
	addq	$4, %rcx
	leaq	(%r11,%r12), %rax
	addq	$4, %rax
	leaq	(%rsi,%r12), %rdx
	addq	$4, %rdx
	cmpq	%rax, %rdi
	setb	%r14b
	cmpq	%rcx, %r11
	setb	%bl
	cmpq	%rdx, %rdi
	setb	%al
	cmpq	%rcx, %rsi
	setb	%cl
	testb	%bl, %r14b
	jne	.LBB1_46
# BB#42:                                #   in Loop: Header=BB1_3 Depth=1
	andb	%cl, %al
	jne	.LBB1_46
# BB#43:                                #   in Loop: Header=BB1_3 Depth=1
	movl	%r13d, %r14d
	andl	$31, %r14d
	subq	%r14, %r13
	leaq	(%r15,%r14,4), %r15
	addq	$-4, %r15
	subq	%r12, %r15
	leaq	(%r11,%r13,4), %rbx
	leaq	(%rdi,%r13,4), %rcx
	leaq	(%rsi,%r13,4), %rax
	addq	$96, %rsi
	leaq	96(%rdi), %rdx
	addq	$96, %r11
	.p2align	4, 0x90
.LBB1_44:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu	-96(%rsi), %ymm0
	vmovdqu	-64(%rsi), %ymm1
	vmovdqu	-32(%rsi), %ymm2
	vmovdqu	(%rsi), %ymm3
	vpxor	-96(%r11), %ymm0, %ymm0
	vpxor	-64(%r11), %ymm1, %ymm1
	vpxor	-32(%r11), %ymm2, %ymm2
	vpxor	(%r11), %ymm3, %ymm3
	vmovdqu	%ymm0, -96(%rdx)
	vmovdqu	%ymm1, -64(%rdx)
	vmovdqu	%ymm2, -32(%rdx)
	vmovdqu	%ymm3, (%rdx)
	subq	$-128, %rsi
	subq	$-128, %rdx
	subq	$-128, %r11
	addq	$-32, %r13
	jne	.LBB1_44
# BB#45:                                #   in Loop: Header=BB1_3 Depth=1
	testq	%r14, %r14
	movq	16(%rsp), %r14          # 8-byte Reload
	movl	12(%rsp), %r13d         # 4-byte Reload
	jne	.LBB1_48
	jmp	.LBB1_53
.LBB1_46:                               #   in Loop: Header=BB1_3 Depth=1
	movq	%r11, %rbx
	movq	%rdi, %rcx
	movq	%rsi, %rax
	movq	16(%rsp), %r14          # 8-byte Reload
.LBB1_47:                               #   in Loop: Header=BB1_3 Depth=1
	movl	12(%rsp), %r13d         # 4-byte Reload
.LBB1_48:                               #   in Loop: Header=BB1_3 Depth=1
	movl	$3, %r11d
	subq	%r15, %r11
	cmpq	$-4, %r11
	movq	$-4, %rdx
	cmovbeq	%rdx, %r11
	addq	%r15, %r11
	movl	%r11d, %esi
	shrl	$2, %esi
	addl	$1, %esi
	andq	$7, %rsi
	je	.LBB1_51
# BB#49:                                #   in Loop: Header=BB1_3 Depth=1
	negq	%rsi
	.p2align	4, 0x90
.LBB1_50:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rax), %edx
	xorl	(%rbx), %edx
	movl	%edx, (%rcx)
	addq	$4, %rcx
	addq	$4, %rbx
	addq	$4, %rax
	addq	$-4, %r15
	addq	$1, %rsi
	jne	.LBB1_50
.LBB1_51:                               #   in Loop: Header=BB1_3 Depth=1
	cmpq	$28, %r11
	jb	.LBB1_53
	.p2align	4, 0x90
.LBB1_52:                               #   Parent Loop BB1_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rax), %edx
	xorl	(%rbx), %edx
	movl	%edx, (%rcx)
	movl	4(%rax), %edx
	xorl	4(%rbx), %edx
	movl	%edx, 4(%rcx)
	movl	8(%rax), %edx
	xorl	8(%rbx), %edx
	movl	%edx, 8(%rcx)
	movl	12(%rax), %edx
	xorl	12(%rbx), %edx
	movl	%edx, 12(%rcx)
	movl	16(%rax), %edx
	xorl	16(%rbx), %edx
	movl	%edx, 16(%rcx)
	movl	20(%rax), %edx
	xorl	20(%rbx), %edx
	movl	%edx, 20(%rcx)
	movl	24(%rax), %edx
	xorl	24(%rbx), %edx
	movl	%edx, 24(%rcx)
	movl	28(%rax), %edx
	xorl	28(%rbx), %edx
	movl	%edx, 28(%rcx)
	addq	$-32, %r15
	addq	$32, %rbx
	addq	$32, %rax
	addq	$32, %rcx
	cmpq	$3, %r15
	ja	.LBB1_52
.LBB1_53:                               #   in Loop: Header=BB1_3 Depth=1
	addq	%r12, %rdi
	addq	$4, %rdi
	addq	%r12, %r8
	addq	%r12, %r9
	subq	%r12, %r10
	movq	%r9, %rsi
	movq	%r8, %r11
	movq	%r10, %r15
	movq	32(%rsp), %rax          # 8-byte Reload
	movq	%r14, %rcx
	testq	%r15, %r15
	jne	.LBB1_16
.LBB1_54:                               #   in Loop: Header=BB1_3 Depth=1
	movq	64(%rsp), %r15          # 8-byte Reload
	movq	128(%rsp), %r14         # 8-byte Reload
	cmpq	$513, %rcx              # imm = 0x201
	jge	.LBB1_2
	jmp	.LBB1_57
.LBB1_55:                               #   in Loop: Header=BB1_3 Depth=1
	movq	%r15, %r9
	subq	%rax, %r9
	addq	%rax, %r11
	leaq	(%rdi,%rax), %rbx
	addq	%rsi, %rax
	jmp	.LBB1_18
.LBB1_56:                               #   in Loop: Header=BB1_3 Depth=1
	xorl	%ebx, %ebx
	testq	%rcx, %rcx
	jne	.LBB1_33
	jmp	.LBB1_34
.LBB1_57:
	xorl	%eax, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end1:
	.size	crypto_stream_xor, .Lfunc_end1-crypto_stream_xor
	.cfi_endproc
                                        # -- End function
	.globl	crypto_stream           # -- Begin function crypto_stream
	.p2align	4, 0x90
	.type	crypto_stream,@function
crypto_stream:                          # @crypto_stream
	.cfi_startproc
# BB#0:
	pushq	%rax
.Lcfi9:
	.cfi_def_cfa_offset 16
	movq	%rcx, %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	xorl	%esi, %esi
	movq	%rax, %r8
	callq	crypto_stream_xor
	xorl	%eax, %eax
	popq	%rcx
	retq
.Lfunc_end2:
	.size	crypto_stream, .Lfunc_end2-crypto_stream
	.cfi_endproc
                                        # -- End function
	.type	chacha_const,@object    # @chacha_const
	.data
	.globl	chacha_const
	.p2align	4
chacha_const:
	.long	1634760805              # 0x61707865
	.long	857760878               # 0x3320646e
	.long	2036477234              # 0x79622d32
	.long	1797285236              # 0x6b206574
	.size	chacha_const, 16


	.ident	"clang version 5.0.0-3~16.04.1 (tags/RELEASE_500/final)"
	.section	".note.GNU-stack","",@progbits
