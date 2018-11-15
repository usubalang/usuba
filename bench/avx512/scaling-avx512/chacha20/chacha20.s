# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 18.0.2.199 Build 20180210";
# mark_description "-I ../../../../../arch -Wall -Wextra -O3 -msse3 -xSSE3 -S";
	.file "chacha20.c"
	.text
..TXTST0:
.L_2__routine_start_Chacha20___0:
# -- Begin  Chacha20__
	.text
# mark_begin;
       .align    16,0x90
	.globl Chacha20__
# --- Chacha20__(__m256i *, __m256i *)
Chacha20__:
# parameter 1: %rdi
# parameter 2: %rsi
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_Chacha20__.1:
..L2:
                                                          #19.86
        pushq     %rbp                                          #19.86
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #19.86
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-32, %rsp                                    #19.86
        subq      $608, %rsp                                    #19.86
        xorb      %al, %al                                      #82.3
        vmovdqa   320(%rdi), %ymm7                              #77.17
        vmovdqa   352(%rdi), %ymm15                             #81.17
        vmovdqa   480(%rdi), %ymm6                              #80.17
        vmovdqa   416(%rdi), %ymm3                              #72.17
        vmovdqa   384(%rdi), %ymm2                              #68.17
        vmovdqa   448(%rdi), %ymm10                             #76.17
        vmovdqa   (%rdi), %ymm5                                 #66.16
        vmovdqa   32(%rdi), %ymm0                               #70.16
        vmovdqa   64(%rdi), %ymm12                              #74.16
        vmovdqa   128(%rdi), %ymm1                              #67.16
        vmovdqa   160(%rdi), %ymm14                             #71.16
        vmovdqa   192(%rdi), %ymm11                             #75.16
        vmovdqa   256(%rdi), %ymm8                              #69.16
        vmovdqa   288(%rdi), %ymm13                             #73.16
        vmovdqa   224(%rdi), %ymm4                              #79.16
        vmovdqa   96(%rdi), %ymm9                               #78.16
        vmovdqa   %ymm15, 576(%rsp)                             #82.3[spill]
        vmovdqa   %ymm6, 512(%rsp)                              #82.3[spill]
        vmovdqa   %ymm7, 544(%rsp)                              #82.3[spill]
                                # LOE rbx rsi r12 r13 r14 r15 al ymm0 ymm1 ymm2 ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13 ymm14
..B1.2:                         # Preds ..B1.2 ..B1.1
                                # Execution count [1.00e+01]
        vpaddd    %ymm1, %ymm5, %ymm5                           #83.44
        incb      %al                                           #82.3
        vmovdqa   .L_2il0floatpacket.0(%rip), %ymm6             #85.44
        vpxor     %ymm5, %ymm2, %ymm2                           #84.54
        vpshufb   %ymm6, %ymm2, %ymm7                           #85.44
        cmpb      $10, %al                                      #82.3
        vpaddd    %ymm7, %ymm8, %ymm8                           #86.44
        vpxor     %ymm8, %ymm1, %ymm2                           #87.54
        vpaddd    %ymm14, %ymm0, %ymm1                          #95.44
        vpslld    $12, %ymm2, %ymm15                            #88.44
        vpxor     %ymm1, %ymm3, %ymm0                           #96.54
        vpsrld    $20, %ymm2, %ymm2                             #88.44
        vpshufb   %ymm6, %ymm0, %ymm0                           #97.44
        vpor      %ymm2, %ymm15, %ymm15                         #88.44
        vpaddd    %ymm0, %ymm13, %ymm13                         #98.44
        vpaddd    %ymm15, %ymm5, %ymm2                          #89.24
        vpxor     %ymm13, %ymm14, %ymm3                         #99.54
        vpaddd    %ymm11, %ymm12, %ymm14                        #107.44
        vpxor     %ymm2, %ymm7, %ymm5                           #90.52
        vpxor     %ymm14, %ymm10, %ymm10                        #108.54
        vpshufb   %ymm6, %ymm10, %ymm10                         #109.44
        vpaddd    544(%rsp), %ymm10, %ymm12                     #110.44[spill]
        vmovdqa   %ymm12, (%rsp)                                #110.44[spill]
        vpxor     %ymm12, %ymm11, %ymm12                        #111.54
        vpaddd    %ymm4, %ymm9, %ymm11                          #119.44
        vpxor     512(%rsp), %ymm11, %ymm9                      #120.54[spill]
        vpshufb   %ymm6, %ymm9, %ymm6                           #121.44
        vpaddd    576(%rsp), %ymm6, %ymm9                       #122.44[spill]
        vmovdqa   %ymm6, 32(%rsp)                               #121.44[spill]
        vpslld    $12, %ymm3, %ymm6                             #100.44
        vpxor     %ymm9, %ymm4, %ymm4                           #123.54
        vpsrld    $20, %ymm3, %ymm3                             #100.44
        vmovdqa   %ymm9, 64(%rsp)                               #122.44[spill]
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm5, %ymm9      #91.25
        vpor      %ymm3, %ymm6, %ymm3                           #100.44
        vpaddd    %ymm9, %ymm8, %ymm5                           #92.24
        vpxor     %ymm5, %ymm15, %ymm8                          #93.52
        vmovdqa   %ymm5, 96(%rsp)                               #92.24[spill]
        vpslld    $7, %ymm8, %ymm15                             #94.24
        vpsrld    $25, %ymm8, %ymm7                             #94.24
        vpaddd    %ymm3, %ymm1, %ymm8                           #101.24
        vpor      %ymm7, %ymm15, %ymm5                          #94.24
        vpxor     %ymm8, %ymm0, %ymm1                           #102.52
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm1, %ymm0      #103.25
        vpaddd    %ymm0, %ymm13, %ymm1                          #104.24
        vmovdqa   %ymm0, 128(%rsp)                              #103.25[spill]
        vpxor     %ymm1, %ymm3, %ymm13                          #105.52
        vpslld    $7, %ymm13, %ymm0                             #106.24
        vpsrld    $25, %ymm13, %ymm3                            #106.24
        vpor      %ymm3, %ymm0, %ymm15                          #106.24
        vpaddd    %ymm15, %ymm2, %ymm13                         #131.42
        vpslld    $12, %ymm12, %ymm2                            #112.44
        vpsrld    $20, %ymm12, %ymm12                           #112.44
        vpor      %ymm12, %ymm2, %ymm6                          #112.44
        vpaddd    %ymm6, %ymm14, %ymm14                         #113.24
        vpxor     %ymm14, %ymm10, %ymm10                        #114.52
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm10, %ymm12    #115.25
        vpslld    $12, %ymm4, %ymm10                            #124.44
        vpsrld    $20, %ymm4, %ymm4                             #124.44
        vpaddd    (%rsp), %ymm12, %ymm7                         #116.25[spill]
        vpxor     %ymm7, %ymm6, %ymm0                           #117.52
        vpslld    $7, %ymm0, %ymm2                              #118.24
        vpsrld    $25, %ymm0, %ymm3                             #118.24
        vpor      %ymm3, %ymm2, %ymm0                           #118.24
        vpaddd    %ymm0, %ymm8, %ymm8                           #143.42
        vmovdqa   %ymm8, 160(%rsp)                              #143.42[spill]
        vpxor     %ymm8, %ymm9, %ymm9                           #144.52
        vpor      %ymm4, %ymm10, %ymm8                          #124.44
        vpshufb   .L_2il0floatpacket.0(%rip), %ymm9, %ymm2      #145.42
        vpaddd    %ymm8, %ymm11, %ymm4                          #125.24
        vpxor     32(%rsp), %ymm4, %ymm11                       #126.52[spill]
        vpaddd    %ymm5, %ymm4, %ymm4                           #167.42
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm11, %ymm9     #127.25
        vpxor     %ymm4, %ymm12, %ymm12                         #168.52
        vmovdqa   %ymm4, 192(%rsp)                              #167.42[spill]
        vpxor     %ymm13, %ymm9, %ymm10                         #132.52
        vpaddd    64(%rsp), %ymm9, %ymm11                       #128.25[spill]
        vpshufb   .L_2il0floatpacket.0(%rip), %ymm10, %ymm10    #133.42
        vpxor     %ymm11, %ymm8, %ymm3                          #129.52
        vpaddd    %ymm2, %ymm11, %ymm11                         #146.42
        vpaddd    %ymm10, %ymm7, %ymm7                          #134.42
        vpxor     %ymm11, %ymm0, %ymm0                          #147.52
        vpxor     %ymm7, %ymm15, %ymm6                          #135.52
        vpshufb   .L_2il0floatpacket.0(%rip), %ymm12, %ymm15    #169.42
        vpsrld    $25, %ymm3, %ymm12                            #130.24
        vpaddd    %ymm15, %ymm1, %ymm1                          #170.42
        vpxor     %ymm1, %ymm5, %ymm9                           #171.52
        vpslld    $7, %ymm3, %ymm5                              #130.24
        vmovdqa   %ymm1, 224(%rsp)                              #170.42[spill]
        vpsrld    $20, %ymm6, %ymm1                             #136.42
        vpor      %ymm12, %ymm5, %ymm5                          #130.24
        vpaddd    %ymm5, %ymm14, %ymm12                         #155.42
        vpxor     128(%rsp), %ymm12, %ymm14                     #156.52[spill]
        vpshufb   .L_2il0floatpacket.0(%rip), %ymm14, %ymm8     #157.42
        vpslld    $12, %ymm6, %ymm14                            #136.42
        vpaddd    96(%rsp), %ymm8, %ymm4                        #158.42[spill]
        vpor      %ymm1, %ymm14, %ymm14                         #136.42
        vpslld    $12, %ymm0, %ymm1                             #148.42
        vpxor     %ymm4, %ymm5, %ymm3                           #159.52
        vpsrld    $20, %ymm0, %ymm0                             #148.42
        vpaddd    %ymm14, %ymm13, %ymm5                         #137.18
        vpor      %ymm0, %ymm1, %ymm6                           #148.42
        vpxor     %ymm5, %ymm10, %ymm13                         #138.50
        vpaddd    160(%rsp), %ymm6, %ymm0                       #149.18[spill]
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm13, %ymm10    #139.19
        vpxor     %ymm0, %ymm2, %ymm2                           #150.50
        vpaddd    %ymm10, %ymm7, %ymm7                          #140.19
        vmovdqa   %ymm10, 512(%rsp)                             #139.19[spill]
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm2, %ymm2      #151.19
        vpxor     %ymm7, %ymm14, %ymm14                         #141.50
        vmovdqa   %ymm7, 544(%rsp)                              #140.19[spill]
        vpaddd    %ymm2, %ymm11, %ymm11                         #152.19
        vpslld    $7, %ymm14, %ymm10                            #142.18
        vpsrld    $25, %ymm14, %ymm13                           #142.18
        vpxor     %ymm11, %ymm6, %ymm7                          #153.50
        vpslld    $12, %ymm9, %ymm6                             #172.42
        vpor      %ymm13, %ymm10, %ymm14                        #142.18
        vpslld    $12, %ymm3, %ymm13                            #160.42
        vpsrld    $20, %ymm3, %ymm3                             #160.42
        vpsrld    $20, %ymm9, %ymm9                             #172.42
        vpsrld    $25, %ymm7, %ymm10                            #154.18
        vmovdqa   %ymm11, 576(%rsp)                             #152.19[spill]
        vpor      %ymm3, %ymm13, %ymm1                          #160.42
        vpslld    $7, %ymm7, %ymm11                             #154.18
        vpor      %ymm9, %ymm6, %ymm7                           #172.42
        vpaddd    %ymm1, %ymm12, %ymm12                         #161.18
        vpor      %ymm10, %ymm11, %ymm11                        #154.18
        vpaddd    192(%rsp), %ymm7, %ymm9                       #173.18[spill]
        vpxor     %ymm12, %ymm8, %ymm8                          #162.50
        vpxor     %ymm9, %ymm15, %ymm15                         #174.50
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm8, %ymm3      #163.19
        vpaddd    %ymm3, %ymm4, %ymm8                           #164.18
        vpxor     %ymm8, %ymm1, %ymm4                           #165.50
        vpslld    $7, %ymm4, %ymm10                             #166.18
        vpsrld    $25, %ymm4, %ymm4                             #166.18
        vpor      %ymm4, %ymm10, %ymm4                          #166.18
        vpshufb   .L_2il0floatpacket.1(%rip), %ymm15, %ymm10    #175.19
        vpaddd    224(%rsp), %ymm10, %ymm13                     #176.18[spill]
        vpxor     %ymm13, %ymm7, %ymm1                          #177.50
        vpslld    $7, %ymm1, %ymm6                              #178.18
        vpsrld    $25, %ymm1, %ymm15                            #178.18
        vpor      %ymm15, %ymm6, %ymm1                          #178.18
        jb        ..B1.2        # Prob 90%                      #82.3
                                # LOE rbx rsi r12 r13 r14 r15 al ymm0 ymm1 ymm2 ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13 ymm14
..B1.3:                         # Preds ..B1.2
                                # Execution count [5.00e-03]
        vmovdqa   576(%rsp), %ymm15                             #[spill]
        movl      $512, %r8d                                    #180.17
        vmovdqa   512(%rsp), %ymm6                              #[spill]
        vmovdqa   544(%rsp), %ymm7                              #[spill]
        vmovdqa   %ymm5, (%rsp)                                 #137.5
        vmovdqa   %ymm14, 160(%rsp)                             #142.5
        vmovdqa   %ymm0, 32(%rsp)                               #149.5
        vmovdqa   %ymm6, 480(%rsp)                              #139.5
        vmovdqa   %ymm7, 320(%rsp)                              #140.5
        vmovdqa   %ymm2, 384(%rsp)                              #151.5
        vmovdqa   %ymm15, 352(%rsp)                             #152.5
        vmovdqa   %ymm11, 192(%rsp)                             #154.5
        vmovdqa   %ymm12, 64(%rsp)                              #161.5
        vmovdqa   %ymm3, 416(%rsp)                              #163.5
        vmovdqa   %ymm8, 256(%rsp)                              #164.5
        vmovdqa   %ymm4, 224(%rsp)                              #166.5
        vmovdqa   %ymm9, 96(%rsp)                               #173.5
        vmovdqa   %ymm10, 448(%rsp)                             #175.5
        vmovdqa   %ymm13, 288(%rsp)                             #176.5
        vmovdqa   %ymm1, 128(%rsp)                              #178.5
                                # LOE rbx rsi r8 r12 r13 r14 r15
..B1.7:                         # Preds ..B1.7 ..B1.3
                                # Execution count [8.00e-02]
        movq      -8(%rsp,%r8), %rax                            #180.17
        movq      %rax, -8(%rsi,%r8)                            #180.17
        movq      -16(%rsp,%r8), %rdx                           #180.17
        movq      %rdx, -16(%rsi,%r8)                           #180.17
        movq      -24(%rsp,%r8), %rcx                           #180.17
        movq      %rcx, -24(%rsi,%r8)                           #180.17
        movq      -32(%rsp,%r8), %rdi                           #180.17
        movq      %rdi, -32(%rsi,%r8)                           #180.17
        subq      $32, %r8                                      #180.17
        jne       ..B1.7        # Prob 93%                      #180.17
                                # LOE rbx rsi r8 r12 r13 r14 r15
..B1.4:                         # Preds ..B1.7
                                # Execution count [1.00e+00]
        vzeroupper                                              #197.1
        movq      %rbp, %rsp                                    #197.1
        popq      %rbp                                          #197.1
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #197.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	Chacha20__,@function
	.size	Chacha20__,.-Chacha20__
..LNChacha20__.0:
	.data
# -- End  Chacha20__
	.section .rodata, "a"
	.align 32
	.align 32
.L_2il0floatpacket.0:
	.long	0x01000302,0x05040706,0x09080b0a,0x0d0c0f0e,0x01000302,0x05040706,0x09080b0a,0x0d0c0f0e
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,32
	.align 32
.L_2il0floatpacket.1:
	.long	0x02010003,0x06050407,0x0a09080b,0x0e0d0c0f,0x02010003,0x06050407,0x0a09080b,0x0e0d0c0f
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,32
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
# End
