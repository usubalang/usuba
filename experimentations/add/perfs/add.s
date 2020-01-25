	.text
	.file	"test_loop.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc

	movl	$2000000000, %esi
	.p2align	7, 0x90
.LBB0_1:
	addl	%edi, %edx
	addl	%edi, %ecx
	addl	%edi, %eax
    addl	%edi, %edx
	addl	%edi, %ecx
	addl	%edi, %eax
	addq	$-2, %rsi
	jne	.LBB0_1

	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.ident	"clang version 7.0.0-svn345401-1~exp1~20181026173340.32 (branches/release_70)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
