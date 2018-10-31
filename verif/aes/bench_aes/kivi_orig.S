.data
.align 16


.Lshiftrow_shuf:
 .byte 0x00, 0x05, 0x0a, 0x0f, 0x04, 0x09, 0x0e, 0x03
 .byte 0x08, 0x0d, 0x02, 0x07, 0x0c, 0x01, 0x06, 0x0b

.Lror_byte_1_shuf:
 .byte 0x01, 0x02, 0x03, 0x00, 0x05, 0x06, 0x07, 0x04
 .byte 0x09, 0x0a, 0x0b, 0x08, 0x0d, 0x0e, 0x0f, 0x0c

.Lror_byte_2_shuf:
 .byte 0x02, 0x03, 0x00, 0x01, 0x06, 0x07, 0x04, 0x05
 .byte 0x0a, 0x0b, 0x08, 0x09, 0x0e, 0x0f, 0x0c, 0x0d


.text
.align 8
.global AES__
.type AES__,@function;
AES__:



 movl $10, %eax;
 decl %eax;
 leaq 0(%rdi), %r8;

.Lenc_loop:

 vpxor 0*16(%r8), %xmm0, %xmm0; vpxor 1*16(%r8), %xmm1, %xmm1; vpxor 2*16(%r8), %xmm2, %xmm2; vpxor 3*16(%r8), %xmm3, %xmm3; vpxor 4*16(%r8), %xmm4, %xmm4; vpxor 5*16(%r8), %xmm5, %xmm5; vpxor 6*16(%r8), %xmm6, %xmm6; vpxor 7*16(%r8), %xmm7, %xmm7;;

 addq $(8*16), %r8;

 vmovdqa .Lshiftrow_shuf, %xmm8; vpshufb %xmm8, %xmm0, %xmm0; vpshufb %xmm8, %xmm1, %xmm1; vpshufb %xmm8, %xmm2, %xmm2; vpshufb %xmm8, %xmm3, %xmm3; vpshufb %xmm8, %xmm4, %xmm4; vpshufb %xmm8, %xmm5, %xmm5; vpshufb %xmm8, %xmm6, %xmm6; vpshufb %xmm8, %xmm7, %xmm7;;

 vpxor %xmm6, %xmm5, %xmm5; vpxor %xmm1, %xmm2, %xmm2; vpxor %xmm0, %xmm5, %xmm8; vpxor %xmm2, %xmm6, %xmm6; vpxor %xmm0, %xmm3, %xmm3; vpxor %xmm3, %xmm6, %xmm6; vpxor %xmm7, %xmm3, %xmm3; vpxor %xmm8, %xmm7, %xmm7; vpxor %xmm4, %xmm3, %xmm3; vpxor %xmm8, %xmm4, %xmm4; vpxor %xmm1, %xmm3, %xmm3; vpxor %xmm7, %xmm2, %xmm2; vpxor %xmm8, %xmm1, %xmm1;; vpxor %xmm7, %xmm4, %xmm11; vpxor %xmm1, %xmm2, %xmm10; vpxor %xmm8, %xmm3, %xmm9; vpxor %xmm2, %xmm4, %xmm13; vpxor %xmm6, %xmm0, %xmm12; vpxor %xmm11, %xmm10, %xmm15; vpand %xmm10, %xmm9, %xmm5; vpor %xmm9, %xmm10, %xmm10; vpand %xmm11, %xmm12, %xmm14; vpor %xmm12, %xmm11, %xmm11; vpxor %xmm9, %xmm12, %xmm12; vpand %xmm12, %xmm15, %xmm15; vpxor %xmm3, %xmm0, %xmm12; vpand %xmm12, %xmm13, %xmm13; vpxor %xmm13, %xmm11, %xmm11; vpxor %xmm13, %xmm10, %xmm10; vpxor %xmm7, %xmm1, %xmm13; vpxor %xmm8, %xmm6, %xmm12; vpor %xmm13, %xmm12, %xmm9; vpand %xmm12, %xmm13, %xmm13; vpxor %xmm13, %xmm5, %xmm5; vpxor %xmm15, %xmm11, %xmm11; vpxor %xmm14, %xmm10, %xmm10; vpxor %xmm15, %xmm9, %xmm9; vpxor %xmm14, %xmm5, %xmm5; vpxor %xmm14, %xmm9, %xmm9; vpand %xmm2, %xmm3, %xmm12; vpand %xmm4, %xmm0, %xmm13; vpand %xmm1, %xmm8, %xmm14; vpor %xmm7, %xmm6, %xmm15; vpxor %xmm12, %xmm11, %xmm11; vpxor %xmm13, %xmm10, %xmm10; vpxor %xmm14, %xmm9, %xmm9; vpxor %xmm15, %xmm5, %xmm5; vpxor %xmm11, %xmm10, %xmm12; vpand %xmm9, %xmm11, %xmm11; vpxor %xmm5, %xmm11, %xmm14; vpand %xmm12, %xmm14, %xmm15; vpxor %xmm10, %xmm15, %xmm15; vpxor %xmm9, %xmm5, %xmm13; vpxor %xmm10, %xmm11, %xmm11; vpand %xmm11, %xmm13, %xmm13; vpxor %xmm5, %xmm13, %xmm13; vpxor %xmm13, %xmm9, %xmm9; vpxor %xmm14, %xmm13, %xmm10; vpand %xmm5, %xmm10, %xmm10; vpxor %xmm10, %xmm9, %xmm9; vpxor %xmm10, %xmm14, %xmm14; vpand %xmm15, %xmm14, %xmm14; vpxor %xmm12, %xmm14, %xmm14; vpxor %xmm15, %xmm14, %xmm10; vpand %xmm6, %xmm10, %xmm10; vpxor %xmm6, %xmm8, %xmm12; vpand %xmm14, %xmm12, %xmm12; vpand %xmm8, %xmm15, %xmm5; vpxor %xmm5, %xmm12, %xmm12; vpxor %xmm10, %xmm5, %xmm5;; vpxor %xmm0, %xmm6, %xmm6; vpxor %xmm3, %xmm8, %xmm8; vpxor %xmm13, %xmm15, %xmm15; vpxor %xmm9, %xmm14, %xmm14; vpxor %xmm15, %xmm14, %xmm11; vpand %xmm6, %xmm11, %xmm11; vpxor %xmm8, %xmm6, %xmm6; vpand %xmm14, %xmm6, %xmm6; vpand %xmm15, %xmm8, %xmm8; vpxor %xmm6, %xmm8, %xmm8; vpxor %xmm11, %xmm6, %xmm6;; vpxor %xmm13, %xmm9, %xmm10; vpand %xmm0, %xmm10, %xmm10; vpxor %xmm0, %xmm3, %xmm0; vpand %xmm9, %xmm0, %xmm0; vpand %xmm3, %xmm13, %xmm3; vpxor %xmm3, %xmm0, %xmm0; vpxor %xmm10, %xmm3, %xmm3;; vpxor %xmm6, %xmm0, %xmm0; vpxor %xmm12, %xmm6, %xmm6; vpxor %xmm8, %xmm3, %xmm3; vpxor %xmm5, %xmm8, %xmm8; vpxor %xmm7, %xmm4, %xmm12; vpxor %xmm1, %xmm2, %xmm5; vpxor %xmm15, %xmm14, %xmm11; vpand %xmm12, %xmm11, %xmm11; vpxor %xmm5, %xmm12, %xmm12; vpand %xmm14, %xmm12, %xmm12; vpand %xmm15, %xmm5, %xmm5; vpxor %xmm12, %xmm5, %xmm5; vpxor %xmm11, %xmm12, %xmm12;; vpxor %xmm13, %xmm9, %xmm10; vpand %xmm4, %xmm10, %xmm10; vpxor %xmm4, %xmm2, %xmm4; vpand %xmm9, %xmm4, %xmm4; vpand %xmm2, %xmm13, %xmm2; vpxor %xmm2, %xmm4, %xmm4; vpxor %xmm10, %xmm2, %xmm2;; vpxor %xmm13, %xmm15, %xmm15; vpxor %xmm9, %xmm14, %xmm14; vpxor %xmm15, %xmm14, %xmm11; vpand %xmm7, %xmm11, %xmm11; vpxor %xmm7, %xmm1, %xmm7; vpand %xmm14, %xmm7, %xmm7; vpand %xmm1, %xmm15, %xmm1; vpxor %xmm1, %xmm7, %xmm7; vpxor %xmm11, %xmm1, %xmm1;; vpxor %xmm12, %xmm7, %xmm7; vpxor %xmm12, %xmm4, %xmm4; vpxor %xmm5, %xmm1, %xmm1; vpxor %xmm5, %xmm2, %xmm2;;; vpxor %xmm7, %xmm0, %xmm5; vpxor %xmm1, %xmm6, %xmm9; vpxor %xmm4, %xmm5, %xmm10; vpxor %xmm6, %xmm0, %xmm12; vpxor %xmm0, %xmm9, %xmm0; vpxor %xmm8, %xmm9, %xmm1; vpxor %xmm8, %xmm2, %xmm7; vpxor %xmm2, %xmm3, %xmm6; vpxor %xmm10, %xmm7, %xmm2; vpxor %xmm3, %xmm7, %xmm4; vpxor %xmm12, %xmm4, %xmm3;;;


 vmovdqa .Lror_byte_1_shuf, %xmm14; vmovdqa .Lror_byte_2_shuf, %xmm15; vpshufb %xmm14, %xmm0, %xmm8; vpxor %xmm0, %xmm8, %xmm0; vpshufb %xmm14, %xmm1, %xmm9; vpxor %xmm1, %xmm9, %xmm1; vpshufb %xmm14, %xmm2, %xmm10; vpxor %xmm2, %xmm10, %xmm2; vpshufb %xmm14, %xmm3, %xmm11; vpxor %xmm3, %xmm11, %xmm3; vpxor %xmm0, %xmm9, %xmm9; vpshufb %xmm15, %xmm0, %xmm0; vpxor %xmm1, %xmm10, %xmm10; vpshufb %xmm15, %xmm1, %xmm1; vpxor %xmm2, %xmm11, %xmm11; vpshufb %xmm15, %xmm2, %xmm2; vpxor %xmm2, %xmm10, %xmm2; vpshufb %xmm14, %xmm7, %xmm10; vpxor %xmm7, %xmm10, %xmm7; vpshufb %xmm14, %xmm4, %xmm12; vpxor %xmm4, %xmm12, %xmm4; vpshufb %xmm14, %xmm5, %xmm13; vpxor %xmm5, %xmm13, %xmm5; vpshufb %xmm14, %xmm6, %xmm14; vpxor %xmm6, %xmm14, %xmm6; vpxor %xmm3, %xmm12, %xmm12; vpshufb %xmm15, %xmm3, %xmm3; vpxor %xmm4, %xmm13, %xmm13; vpshufb %xmm15, %xmm4, %xmm4; vpxor %xmm5, %xmm14, %xmm14; vpshufb %xmm15, %xmm5, %xmm5; vpxor %xmm5, %xmm13, %xmm5; vpxor %xmm6, %xmm10, %xmm10; vpshufb %xmm15, %xmm6, %xmm6; vpxor %xmm6, %xmm14, %xmm6; vpxor %xmm7, %xmm8, %xmm8; vpxor %xmm0, %xmm8, %xmm0; vpxor %xmm7, %xmm9, %xmm9; vpxor %xmm1, %xmm9, %xmm1; vpxor %xmm7, %xmm11, %xmm11; vpxor %xmm3, %xmm11, %xmm3; vpxor %xmm7, %xmm12, %xmm12; vpxor %xmm4, %xmm12, %xmm4; vpshufb %xmm15, %xmm7, %xmm7; vpxor %xmm7, %xmm10, %xmm7;;


 decl %eax;
 jnz .Lenc_loop;


 vpxor 0*16(%r8), %xmm0, %xmm0; vpxor 1*16(%r8), %xmm1, %xmm1; vpxor 2*16(%r8), %xmm2, %xmm2; vpxor 3*16(%r8), %xmm3, %xmm3; vpxor 4*16(%r8), %xmm4, %xmm4; vpxor 5*16(%r8), %xmm5, %xmm5; vpxor 6*16(%r8), %xmm6, %xmm6; vpxor 7*16(%r8), %xmm7, %xmm7;;

 addq $(8*16), %r8;

 vmovdqa .Lshiftrow_shuf, %xmm8; vpshufb %xmm8, %xmm0, %xmm0; vpshufb %xmm8, %xmm1, %xmm1; vpshufb %xmm8, %xmm2, %xmm2; vpshufb %xmm8, %xmm3, %xmm3; vpshufb %xmm8, %xmm4, %xmm4; vpshufb %xmm8, %xmm5, %xmm5; vpshufb %xmm8, %xmm6, %xmm6; vpshufb %xmm8, %xmm7, %xmm7;;

 vpxor %xmm6, %xmm5, %xmm5; vpxor %xmm1, %xmm2, %xmm2; vpxor %xmm0, %xmm5, %xmm8; vpxor %xmm2, %xmm6, %xmm6; vpxor %xmm0, %xmm3, %xmm3; vpxor %xmm3, %xmm6, %xmm6; vpxor %xmm7, %xmm3, %xmm3; vpxor %xmm8, %xmm7, %xmm7; vpxor %xmm4, %xmm3, %xmm3; vpxor %xmm8, %xmm4, %xmm4; vpxor %xmm1, %xmm3, %xmm3; vpxor %xmm7, %xmm2, %xmm2; vpxor %xmm8, %xmm1, %xmm1;; vpxor %xmm7, %xmm4, %xmm11; vpxor %xmm1, %xmm2, %xmm10; vpxor %xmm8, %xmm3, %xmm9; vpxor %xmm2, %xmm4, %xmm13; vpxor %xmm6, %xmm0, %xmm12; vpxor %xmm11, %xmm10, %xmm15; vpand %xmm10, %xmm9, %xmm5; vpor %xmm9, %xmm10, %xmm10; vpand %xmm11, %xmm12, %xmm14; vpor %xmm12, %xmm11, %xmm11; vpxor %xmm9, %xmm12, %xmm12; vpand %xmm12, %xmm15, %xmm15; vpxor %xmm3, %xmm0, %xmm12; vpand %xmm12, %xmm13, %xmm13; vpxor %xmm13, %xmm11, %xmm11; vpxor %xmm13, %xmm10, %xmm10; vpxor %xmm7, %xmm1, %xmm13; vpxor %xmm8, %xmm6, %xmm12; vpor %xmm13, %xmm12, %xmm9; vpand %xmm12, %xmm13, %xmm13; vpxor %xmm13, %xmm5, %xmm5; vpxor %xmm15, %xmm11, %xmm11; vpxor %xmm14, %xmm10, %xmm10; vpxor %xmm15, %xmm9, %xmm9; vpxor %xmm14, %xmm5, %xmm5; vpxor %xmm14, %xmm9, %xmm9; vpand %xmm2, %xmm3, %xmm12; vpand %xmm4, %xmm0, %xmm13; vpand %xmm1, %xmm8, %xmm14; vpor %xmm7, %xmm6, %xmm15; vpxor %xmm12, %xmm11, %xmm11; vpxor %xmm13, %xmm10, %xmm10; vpxor %xmm14, %xmm9, %xmm9; vpxor %xmm15, %xmm5, %xmm5; vpxor %xmm11, %xmm10, %xmm12; vpand %xmm9, %xmm11, %xmm11; vpxor %xmm5, %xmm11, %xmm14; vpand %xmm12, %xmm14, %xmm15; vpxor %xmm10, %xmm15, %xmm15; vpxor %xmm9, %xmm5, %xmm13; vpxor %xmm10, %xmm11, %xmm11; vpand %xmm11, %xmm13, %xmm13; vpxor %xmm5, %xmm13, %xmm13; vpxor %xmm13, %xmm9, %xmm9; vpxor %xmm14, %xmm13, %xmm10; vpand %xmm5, %xmm10, %xmm10; vpxor %xmm10, %xmm9, %xmm9; vpxor %xmm10, %xmm14, %xmm14; vpand %xmm15, %xmm14, %xmm14; vpxor %xmm12, %xmm14, %xmm14; vpxor %xmm15, %xmm14, %xmm10; vpand %xmm6, %xmm10, %xmm10; vpxor %xmm6, %xmm8, %xmm12; vpand %xmm14, %xmm12, %xmm12; vpand %xmm8, %xmm15, %xmm5; vpxor %xmm5, %xmm12, %xmm12; vpxor %xmm10, %xmm5, %xmm5;; vpxor %xmm0, %xmm6, %xmm6; vpxor %xmm3, %xmm8, %xmm8; vpxor %xmm13, %xmm15, %xmm15; vpxor %xmm9, %xmm14, %xmm14; vpxor %xmm15, %xmm14, %xmm11; vpand %xmm6, %xmm11, %xmm11; vpxor %xmm8, %xmm6, %xmm6; vpand %xmm14, %xmm6, %xmm6; vpand %xmm15, %xmm8, %xmm8; vpxor %xmm6, %xmm8, %xmm8; vpxor %xmm11, %xmm6, %xmm6;; vpxor %xmm13, %xmm9, %xmm10; vpand %xmm0, %xmm10, %xmm10; vpxor %xmm0, %xmm3, %xmm0; vpand %xmm9, %xmm0, %xmm0; vpand %xmm3, %xmm13, %xmm3; vpxor %xmm3, %xmm0, %xmm0; vpxor %xmm10, %xmm3, %xmm3;; vpxor %xmm6, %xmm0, %xmm0; vpxor %xmm12, %xmm6, %xmm6; vpxor %xmm8, %xmm3, %xmm3; vpxor %xmm5, %xmm8, %xmm8; vpxor %xmm7, %xmm4, %xmm12; vpxor %xmm1, %xmm2, %xmm5; vpxor %xmm15, %xmm14, %xmm11; vpand %xmm12, %xmm11, %xmm11; vpxor %xmm5, %xmm12, %xmm12; vpand %xmm14, %xmm12, %xmm12; vpand %xmm15, %xmm5, %xmm5; vpxor %xmm12, %xmm5, %xmm5; vpxor %xmm11, %xmm12, %xmm12;; vpxor %xmm13, %xmm9, %xmm10; vpand %xmm4, %xmm10, %xmm10; vpxor %xmm4, %xmm2, %xmm4; vpand %xmm9, %xmm4, %xmm4; vpand %xmm2, %xmm13, %xmm2; vpxor %xmm2, %xmm4, %xmm4; vpxor %xmm10, %xmm2, %xmm2;; vpxor %xmm13, %xmm15, %xmm15; vpxor %xmm9, %xmm14, %xmm14; vpxor %xmm15, %xmm14, %xmm11; vpand %xmm7, %xmm11, %xmm11; vpxor %xmm7, %xmm1, %xmm7; vpand %xmm14, %xmm7, %xmm7; vpand %xmm1, %xmm15, %xmm1; vpxor %xmm1, %xmm7, %xmm7; vpxor %xmm11, %xmm1, %xmm1;; vpxor %xmm12, %xmm7, %xmm7; vpxor %xmm12, %xmm4, %xmm4; vpxor %xmm5, %xmm1, %xmm1; vpxor %xmm5, %xmm2, %xmm2;;; vpxor %xmm7, %xmm0, %xmm5; vpxor %xmm1, %xmm6, %xmm9; vpxor %xmm4, %xmm5, %xmm10; vpxor %xmm6, %xmm0, %xmm12; vpxor %xmm0, %xmm9, %xmm0; vpxor %xmm8, %xmm9, %xmm1; vpxor %xmm8, %xmm2, %xmm7; vpxor %xmm2, %xmm3, %xmm6; vpxor %xmm10, %xmm7, %xmm2; vpxor %xmm3, %xmm7, %xmm4; vpxor %xmm12, %xmm4, %xmm3;;;


 vpxor 0*16(%r8), %xmm0, %xmm0; vpxor 1*16(%r8), %xmm1, %xmm1; vpxor 2*16(%r8), %xmm2, %xmm2; vpxor 3*16(%r8), %xmm3, %xmm3; vpxor 4*16(%r8), %xmm4, %xmm4; vpxor 5*16(%r8), %xmm5, %xmm5; vpxor 6*16(%r8), %xmm6, %xmm6; vpxor 7*16(%r8), %xmm7, %xmm7;;



 ret;
