# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 18.0.2.199 Build 20180210";
# mark_description "-I ../../../../../arch -O3 -mavx -xAVX -S -o t2.s";
	.file "chacha20.c"
	.text
..TXTST0:
.L_2__routine_start_Chacha20___0:
# -- Begin  Chacha20__
	.text
# mark_begin;
       .align    16,0x90
	.globl Chacha20__
# --- Chacha20__(__m128i *, __m128i *)
Chacha20__:
# parameter 1: %rdi
# parameter 2: %rsi
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_Chacha20__.1:
..L2:
                                                          #19.86
        subq      $312, %rsp                                    #19.86
	.cfi_def_cfa_offset 320
        xorb      %al, %al                                      #82.3
        vmovdqu   160(%rdi), %xmm9                              #77.17
        vmovdqu   176(%rdi), %xmm15                             #81.17
        vmovdqu   240(%rdi), %xmm7                              #80.17
        vmovdqu   192(%rdi), %xmm8                              #68.17
        vmovdqu   128(%rdi), %xmm1                              #69.16
        vmovdqu   64(%rdi), %xmm0                               #67.16
        vmovdqu   (%rdi), %xmm4                                 #66.16
        vmovdqu   16(%rdi), %xmm14                              #70.16
        vmovdqu   80(%rdi), %xmm5                               #71.16
        vmovdqu   144(%rdi), %xmm2                              #73.16
        vmovdqu   208(%rdi), %xmm3                              #72.17
        vmovdqu   224(%rdi), %xmm12                             #76.17
        vmovdqu   32(%rdi), %xmm10                              #74.16
        vmovdqu   96(%rdi), %xmm13                              #75.16
        vmovdqu   48(%rdi), %xmm11                              #78.16
        vmovdqu   112(%rdi), %xmm6                              #79.16
        vmovdqu   %xmm15, 272(%rsp)                             #82.3[spill]
        vmovdqu   %xmm7, 288(%rsp)                              #82.3[spill]
        vmovdqu   %xmm9, 256(%rsp)                              #82.3[spill]
                                # LOE rbx rbp rsi r12 r13 r14 r15 al xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.2:                         # Preds ..B1.2 ..B1.1
                                # Execution count [1.00e+01]
        vpaddd    %xmm0, %xmm4, %xmm7                           #83.44
        vpaddd    %xmm6, %xmm11, %xmm11                         #119.44
        vpxor     %xmm7, %xmm8, %xmm4                           #84.54
        incb      %al                                           #82.3
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm8             #85.44
        vpshufb   %xmm8, %xmm4, %xmm9                           #85.44
        vpaddd    %xmm1, %xmm9, %xmm4                           #86.44
        vpxor     %xmm4, %xmm0, %xmm1                           #87.54
        vpaddd    %xmm5, %xmm14, %xmm0                          #95.44
        vpxor     %xmm0, %xmm3, %xmm14                          #96.54
        vpshufb   %xmm8, %xmm14, %xmm14                         #97.44
        vpaddd    %xmm2, %xmm14, %xmm3                          #98.44
        vpaddd    %xmm13, %xmm10, %xmm2                         #107.44
        vpxor     %xmm2, %xmm12, %xmm15                         #108.54
        vpxor     %xmm3, %xmm5, %xmm5                           #99.54
        vpshufb   %xmm8, %xmm15, %xmm10                         #109.44
        vpxor     288(%rsp), %xmm11, %xmm15                     #120.54[spill]
        vpshufb   %xmm8, %xmm15, %xmm8                          #121.44
        vmovdqu   %xmm8, 32(%rsp)                               #121.44[spill]
        vpaddd    272(%rsp), %xmm8, %xmm8                       #122.44[spill]
        vmovdqu   %xmm11, 16(%rsp)                              #119.44[spill]
        vpxor     %xmm8, %xmm6, %xmm11                          #123.54
        vpslld    $12, %xmm1, %xmm6                             #88.44
        vpsrld    $20, %xmm1, %xmm1                             #88.44
        vpor      %xmm1, %xmm6, %xmm6                           #88.44
        vpaddd    %xmm7, %xmm6, %xmm15                          #89.24
        vpaddd    256(%rsp), %xmm10, %xmm12                     #110.44[spill]
        vmovdqu   %xmm8, 48(%rsp)                               #122.44[spill]
        vpxor     %xmm15, %xmm9, %xmm8                          #90.52
        vmovdqu   %xmm12, (%rsp)                                #110.44[spill]
        vpxor     %xmm12, %xmm13, %xmm13                        #111.54
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm8, %xmm12     #91.25
        vpaddd    %xmm4, %xmm12, %xmm4                          #92.24
        vpslld    $12, %xmm5, %xmm8                             #100.44
        vpxor     %xmm4, %xmm6, %xmm7                           #93.52
        vpsrld    $20, %xmm5, %xmm5                             #100.44
        vpslld    $7, %xmm7, %xmm9                              #94.24
        vpsrld    $25, %xmm7, %xmm1                             #94.24
        vmovdqu   %xmm4, 64(%rsp)                               #92.24[spill]
        vpor      %xmm1, %xmm9, %xmm4                           #94.24
        vpor      %xmm5, %xmm8, %xmm1                           #100.44
        vpaddd    %xmm0, %xmm1, %xmm8                           #101.24
        vpxor     %xmm8, %xmm14, %xmm14                         #102.52
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm14, %xmm6     #103.25
        vpaddd    %xmm3, %xmm6, %xmm14                          #104.24
        vpslld    $12, %xmm13, %xmm3                            #112.44
        vpsrld    $20, %xmm13, %xmm13                           #112.44
        vpxor     %xmm14, %xmm1, %xmm0                          #105.52
        vpor      %xmm13, %xmm3, %xmm13                         #112.44
        vpslld    $7, %xmm0, %xmm1                              #106.24
        vpsrld    $25, %xmm0, %xmm5                             #106.24
        vpaddd    %xmm2, %xmm13, %xmm9                          #113.24
        vpor      %xmm5, %xmm1, %xmm7                           #106.24
        vpxor     %xmm9, %xmm10, %xmm1                          #114.52
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm1, %xmm1      #115.25
        vpaddd    (%rsp), %xmm1, %xmm2                          #116.25[spill]
        vpaddd    %xmm15, %xmm7, %xmm5                          #131.42
        vpxor     %xmm2, %xmm13, %xmm10                         #117.52
        vpslld    $12, %xmm11, %xmm0                            #124.44
        vpslld    $7, %xmm10, %xmm3                             #118.24
        vpsrld    $25, %xmm10, %xmm15                           #118.24
        vpsrld    $20, %xmm11, %xmm11                           #124.44
        vpor      %xmm15, %xmm3, %xmm10                         #118.24
        vpor      %xmm11, %xmm0, %xmm3                          #124.44
        vpaddd    %xmm8, %xmm10, %xmm8                          #143.42
        vpaddd    16(%rsp), %xmm3, %xmm11                       #125.24[spill]
        vpxor     %xmm8, %xmm12, %xmm12                         #144.52
        vpxor     32(%rsp), %xmm11, %xmm13                      #126.52[spill]
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm13, %xmm15    #127.25
        vmovdqu   %xmm8, 80(%rsp)                               #143.42[spill]
        vpxor     %xmm5, %xmm15, %xmm0                          #132.52
        vpshufb   .L_2il0floatpacket.0(%rip), %xmm12, %xmm8     #145.42
        vpshufb   .L_2il0floatpacket.0(%rip), %xmm0, %xmm13     #133.42
        vpaddd    48(%rsp), %xmm15, %xmm12                      #128.25[spill]
        vpaddd    %xmm2, %xmm13, %xmm2                          #134.42
        vpxor     %xmm12, %xmm3, %xmm3                          #129.52
        vpaddd    %xmm12, %xmm8, %xmm12                         #146.42
        vpxor     %xmm12, %xmm10, %xmm0                         #147.52
        vpaddd    %xmm11, %xmm4, %xmm10                         #167.42
        vpxor     %xmm10, %xmm1, %xmm1                          #168.52
        vpxor     %xmm2, %xmm7, %xmm7                           #135.52
        vmovdqu   %xmm12, 96(%rsp)                              #146.42[spill]
        vpshufb   .L_2il0floatpacket.0(%rip), %xmm1, %xmm12     #169.42
        vpaddd    %xmm14, %xmm12, %xmm14                        #170.42
        vpsrld    $25, %xmm3, %xmm1                             #130.24
        vpxor     %xmm14, %xmm4, %xmm11                         #171.52
        vpslld    $7, %xmm3, %xmm4                              #130.24
        vpor      %xmm1, %xmm4, %xmm4                           #130.24
        vpaddd    %xmm9, %xmm4, %xmm15                          #155.42
        vpslld    $12, %xmm7, %xmm9                             #136.42
        vpxor     %xmm15, %xmm6, %xmm6                          #156.52
        vpsrld    $20, %xmm7, %xmm7                             #136.42
        vpshufb   .L_2il0floatpacket.0(%rip), %xmm6, %xmm3      #157.42
        vmovdqu   %xmm14, 128(%rsp)                             #170.42[spill]
        vpor      %xmm7, %xmm9, %xmm14                          #136.42
        vpaddd    64(%rsp), %xmm3, %xmm1                        #158.42[spill]
        vpslld    $12, %xmm0, %xmm6                             #148.42
        vmovdqu   %xmm10, 112(%rsp)                             #167.42[spill]
        vpxor     %xmm1, %xmm4, %xmm10                          #159.52
        vpaddd    %xmm5, %xmm14, %xmm4                          #137.18
        vpxor     %xmm4, %xmm13, %xmm5                          #138.50
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm5, %xmm5      #139.19
        vpaddd    %xmm2, %xmm5, %xmm2                           #140.19
        vmovdqu   %xmm5, 288(%rsp)                              #139.19[spill]
        vpxor     %xmm2, %xmm14, %xmm5                          #141.50
        vmovdqu   %xmm2, 256(%rsp)                              #140.19[spill]
        vpsrld    $20, %xmm0, %xmm2                             #148.42
        vpslld    $7, %xmm5, %xmm14                             #142.18
        vpsrld    $25, %xmm5, %xmm13                            #142.18
        vpor      %xmm2, %xmm6, %xmm0                           #148.42
        vpor      %xmm13, %xmm14, %xmm5                         #142.18
        vpaddd    80(%rsp), %xmm0, %xmm14                       #149.18[spill]
        vpslld    $12, %xmm10, %xmm2                            #160.42
        vpxor     %xmm14, %xmm8, %xmm8                          #150.50
        vpsrld    $20, %xmm10, %xmm10                           #160.42
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm8, %xmm8      #151.19
        vpaddd    96(%rsp), %xmm8, %xmm7                        #152.19[spill]
        vpxor     %xmm7, %xmm0, %xmm9                           #153.50
        vpor      %xmm10, %xmm2, %xmm0                          #160.42
        vpaddd    %xmm15, %xmm0, %xmm10                         #161.18
        vpslld    $7, %xmm9, %xmm13                             #154.18
        vpxor     %xmm10, %xmm3, %xmm3                          #162.50
        vpsrld    $25, %xmm9, %xmm6                             #154.18
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm3, %xmm3      #163.19
        vpaddd    %xmm1, %xmm3, %xmm1                           #164.18
        vpor      %xmm6, %xmm13, %xmm13                         #154.18
        vpxor     %xmm1, %xmm0, %xmm15                          #165.50
        vpslld    $12, %xmm11, %xmm0                            #172.42
        vpsrld    $20, %xmm11, %xmm11                           #172.42
        vpslld    $7, %xmm15, %xmm6                             #166.18
        vmovdqu   %xmm7, 272(%rsp)                              #152.19[spill]
        vpor      %xmm11, %xmm0, %xmm7                          #172.42
        vpaddd    112(%rsp), %xmm7, %xmm11                      #173.18[spill]
        vpsrld    $25, %xmm15, %xmm2                            #166.18
        vpxor     %xmm11, %xmm12, %xmm12                        #174.50
        vpor      %xmm2, %xmm6, %xmm6                           #166.18
        vpshufb   .L_2il0floatpacket.1(%rip), %xmm12, %xmm12    #175.19
        vpaddd    128(%rsp), %xmm12, %xmm2                      #176.18[spill]
        vpxor     %xmm2, %xmm7, %xmm9                           #177.50
        vpslld    $7, %xmm9, %xmm15                             #178.18
        vpsrld    $25, %xmm9, %xmm0                             #178.18
        vpor      %xmm0, %xmm15, %xmm0                          #178.18
        cmpb      $10, %al                                      #82.3
        jb        ..B1.2        # Prob 90%                      #82.3
                                # LOE rbx rbp rsi r12 r13 r14 r15 al xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.3:                         # Preds ..B1.2
                                # Execution count [5.00e-03]
        vmovdqu   272(%rsp), %xmm15                             #[spill]
        movl      $256, %eax                                    #180.17
        vmovdqu   288(%rsp), %xmm7                              #[spill]
        vmovdqu   256(%rsp), %xmm9                              #[spill]
        vmovdqu   %xmm4, (%rsp)                                 #137.5
        vmovdqu   %xmm7, 240(%rsp)                              #139.5
        vmovdqu   %xmm9, 160(%rsp)                              #140.5
        vmovdqu   %xmm5, 80(%rsp)                               #142.5
        vmovdqu   %xmm14, 16(%rsp)                              #149.5
        vmovdqu   %xmm8, 192(%rsp)                              #151.5
        vmovdqu   %xmm15, 176(%rsp)                             #152.5
        vmovdqu   %xmm13, 96(%rsp)                              #154.5
        vmovdqu   %xmm10, 32(%rsp)                              #161.5
        vmovdqu   %xmm3, 208(%rsp)                              #163.5
        vmovdqu   %xmm1, 128(%rsp)                              #164.5
        vmovdqu   %xmm6, 112(%rsp)                              #166.5
        vmovdqu   %xmm11, 48(%rsp)                              #173.5
        vmovdqu   %xmm12, 224(%rsp)                             #175.5
        vmovdqu   %xmm2, 144(%rsp)                              #176.5
        vmovdqu   %xmm0, 64(%rsp)                               #178.5
                                # LOE rax rbx rbp rsi r12 r13 r14 r15
..B1.7:                         # Preds ..B1.7 ..B1.3
                                # Execution count [2.00e-02]
        vmovups   -16(%rsp,%rax), %xmm0                         #180.17
        vmovups   %xmm0, -16(%rsi,%rax)                         #180.17
        vmovups   -32(%rsp,%rax), %xmm1                         #180.17
        vmovups   %xmm1, -32(%rsi,%rax)                         #180.17
        vmovups   -48(%rsp,%rax), %xmm2                         #180.17
        vmovups   %xmm2, -48(%rsi,%rax)                         #180.17
        vmovups   -64(%rsp,%rax), %xmm3                         #180.17
        vmovups   %xmm3, -64(%rsi,%rax)                         #180.17
        subq      $64, %rax                                     #180.17
        jne       ..B1.7        # Prob 75%                      #180.17
                                # LOE rax rbx rbp rsi r12 r13 r14 r15
..B1.4:                         # Preds ..B1.7
                                # Execution count [1.00e+00]
        addq      $312, %rsp                                    #197.1
	.cfi_def_cfa_offset 8
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
	.align 16
	.align 16
.L_2il0floatpacket.0:
	.long	0x01000302,0x05040706,0x09080b0a,0x0d0c0f0e
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,16
	.align 16
.L_2il0floatpacket.1:
	.long	0x02010003,0x06050407,0x0a09080b,0x0e0d0c0f
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,16
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
# End
