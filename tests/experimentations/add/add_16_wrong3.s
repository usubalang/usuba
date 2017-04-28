# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "-Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -i";
# mark_description "nline-max-total-size=10000 -O3 -funroll-loops -unroll-agressive -S -o add_16_wrong3.s";
	.file "add_16_wrong3.c"
	.text
..TXTST0:
# -- Begin  main
	.text
# mark_begin;
       .align    16,0x90
	.globl main
# --- main()
main:
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_main.1:
..L2:
                                                          #73.13
        pushq     %rbp                                          #73.13
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #73.13
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-128, %rsp                                   #73.13
        pushq     %r12                                          #73.13
        pushq     %r13                                          #73.13
        pushq     %r14                                          #73.13
        pushq     %r15                                          #73.13
        pushq     %rbx                                          #73.13
        subq      $600, %rsp                                    #73.13
        movl      $10330110, %esi                               #73.13
        movl      $3, %edi                                      #73.13
        call      __intel_new_feature_proc_init                 #73.13
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.156:                       # Preds ..B1.1
                                # Execution count [1.00e+00]
        vstmxcsr  (%rsp)                                        #73.13
        movl      $.L_2__STRING.0, %edi                         #76.13
        movl      $.L_2__STRING.1, %esi                         #76.13
        orl       $32832, (%rsp)                                #73.13
        vldmxcsr  (%rsp)                                        #73.13
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #76.13
                                # LOE rax
..B1.155:                       # Preds ..B1.156
                                # Execution count [1.00e+00]
        movq      %rax, %r12                                    #76.13
                                # LOE r12
..B1.2:                         # Preds ..B1.155
                                # Execution count [1.00e+00]
        xorl      %edi, %edi                                    #82.9
#       time(time_t *)
        call      time                                          #82.9
                                # LOE rax r12
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movl      %eax, %edi                                    #82.3
#       srand(unsigned int)
        call      srand                                         #82.3
                                # LOE r12
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
        movl      $32, %edi                                     #83.30
        movl      $256000000, %esi                              #83.30
..___tag_value_main.11:
#       aligned_alloc(size_t, size_t)
        call      aligned_alloc                                 #83.30
..___tag_value_main.12:
                                # LOE rax r12
..B1.158:                       # Preds ..B1.4
                                # Execution count [1.00e+00]
        movq      %rax, %rbx                                    #83.30
                                # LOE rbx r12
..B1.5:                         # Preds ..B1.158
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #85.22
                                # LOE rbx r12 eax
..B1.159:                       # Preds ..B1.5
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #85.22
                                # LOE rbx r12 r14d
..B1.6:                         # Preds ..B1.159
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #85.29
                                # LOE rbx r12 eax r14d
..B1.160:                       # Preds ..B1.6
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #85.29
                                # LOE rbx r12 r13d r14d
..B1.7:                         # Preds ..B1.160
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #85.36
                                # LOE rbx r12 eax r13d r14d
..B1.161:                       # Preds ..B1.7
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #85.36
                                # LOE rbx r12 r13d r14d r15d
..B1.8:                         # Preds ..B1.161
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #85.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.9:                         # Preds ..B1.8
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #85.8
        vmovd     %r15d, %xmm1                                  #85.8
        vmovd     %r13d, %xmm2                                  #85.8
        vmovd     %r14d, %xmm3                                  #85.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #85.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #85.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #85.8
        vmovups   %xmm6, 496(%rsp)                              #85.8[spill]
#       rand(void)
        call      rand                                          #86.22
                                # LOE rbx r12 eax
..B1.163:                       # Preds ..B1.9
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #86.22
                                # LOE rbx r12 r14d
..B1.10:                        # Preds ..B1.163
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #86.29
                                # LOE rbx r12 eax r14d
..B1.164:                       # Preds ..B1.10
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #86.29
                                # LOE rbx r12 r13d r14d
..B1.11:                        # Preds ..B1.164
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #86.36
                                # LOE rbx r12 eax r13d r14d
..B1.165:                       # Preds ..B1.11
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #86.36
                                # LOE rbx r12 r13d r14d r15d
..B1.12:                        # Preds ..B1.165
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #86.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #86.8
        vmovd     %r15d, %xmm1                                  #86.8
        vmovd     %r13d, %xmm2                                  #86.8
        vmovd     %r14d, %xmm3                                  #86.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #86.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #86.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #86.8
        vmovups   %xmm6, 480(%rsp)                              #86.8[spill]
#       rand(void)
        call      rand                                          #87.22
                                # LOE rbx r12 eax
..B1.167:                       # Preds ..B1.13
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #87.22
                                # LOE rbx r12 r14d
..B1.14:                        # Preds ..B1.167
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #87.29
                                # LOE rbx r12 eax r14d
..B1.168:                       # Preds ..B1.14
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #87.29
                                # LOE rbx r12 r13d r14d
..B1.15:                        # Preds ..B1.168
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #87.36
                                # LOE rbx r12 eax r13d r14d
..B1.169:                       # Preds ..B1.15
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #87.36
                                # LOE rbx r12 r13d r14d r15d
..B1.16:                        # Preds ..B1.169
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #87.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.17:                        # Preds ..B1.16
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #87.8
        vmovd     %r15d, %xmm1                                  #87.8
        vmovd     %r13d, %xmm2                                  #87.8
        vmovd     %r14d, %xmm3                                  #87.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #87.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #87.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #87.8
        vmovups   %xmm6, 336(%rsp)                              #87.8[spill]
#       rand(void)
        call      rand                                          #88.22
                                # LOE rbx r12 eax
..B1.171:                       # Preds ..B1.17
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #88.22
                                # LOE rbx r12 r14d
..B1.18:                        # Preds ..B1.171
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #88.29
                                # LOE rbx r12 eax r14d
..B1.172:                       # Preds ..B1.18
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #88.29
                                # LOE rbx r12 r13d r14d
..B1.19:                        # Preds ..B1.172
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #88.36
                                # LOE rbx r12 eax r13d r14d
..B1.173:                       # Preds ..B1.19
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #88.36
                                # LOE rbx r12 r13d r14d r15d
..B1.20:                        # Preds ..B1.173
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #88.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #88.8
        vmovd     %r15d, %xmm1                                  #88.8
        vmovd     %r13d, %xmm2                                  #88.8
        vmovd     %r14d, %xmm3                                  #88.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #88.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #88.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #88.8
        vmovups   %xmm6, 320(%rsp)                              #88.8[spill]
#       rand(void)
        call      rand                                          #89.22
                                # LOE rbx r12 eax
..B1.175:                       # Preds ..B1.21
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #89.22
                                # LOE rbx r12 r14d
..B1.22:                        # Preds ..B1.175
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #89.29
                                # LOE rbx r12 eax r14d
..B1.176:                       # Preds ..B1.22
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #89.29
                                # LOE rbx r12 r13d r14d
..B1.23:                        # Preds ..B1.176
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #89.36
                                # LOE rbx r12 eax r13d r14d
..B1.177:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #89.36
                                # LOE rbx r12 r13d r14d r15d
..B1.24:                        # Preds ..B1.177
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #89.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.25:                        # Preds ..B1.24
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #89.8
        vmovd     %r15d, %xmm1                                  #89.8
        vmovd     %r13d, %xmm2                                  #89.8
        vmovd     %r14d, %xmm3                                  #89.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #89.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #89.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #89.8
        vmovups   %xmm6, 448(%rsp)                              #89.8[spill]
#       rand(void)
        call      rand                                          #90.22
                                # LOE rbx r12 eax
..B1.179:                       # Preds ..B1.25
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #90.22
                                # LOE rbx r12 r14d
..B1.26:                        # Preds ..B1.179
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #90.29
                                # LOE rbx r12 eax r14d
..B1.180:                       # Preds ..B1.26
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #90.29
                                # LOE rbx r12 r13d r14d
..B1.27:                        # Preds ..B1.180
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #90.36
                                # LOE rbx r12 eax r13d r14d
..B1.181:                       # Preds ..B1.27
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #90.36
                                # LOE rbx r12 r13d r14d r15d
..B1.28:                        # Preds ..B1.181
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #90.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #90.8
        vmovd     %r15d, %xmm1                                  #90.8
        vmovd     %r13d, %xmm2                                  #90.8
        vmovd     %r14d, %xmm3                                  #90.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #90.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #90.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #90.8
        vmovups   %xmm6, 432(%rsp)                              #90.8[spill]
#       rand(void)
        call      rand                                          #91.22
                                # LOE rbx r12 eax
..B1.183:                       # Preds ..B1.29
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #91.22
                                # LOE rbx r12 r14d
..B1.30:                        # Preds ..B1.183
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #91.29
                                # LOE rbx r12 eax r14d
..B1.184:                       # Preds ..B1.30
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #91.29
                                # LOE rbx r12 r13d r14d
..B1.31:                        # Preds ..B1.184
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #91.36
                                # LOE rbx r12 eax r13d r14d
..B1.185:                       # Preds ..B1.31
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #91.36
                                # LOE rbx r12 r13d r14d r15d
..B1.32:                        # Preds ..B1.185
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #91.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.33:                        # Preds ..B1.32
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #91.8
        vmovd     %r15d, %xmm1                                  #91.8
        vmovd     %r13d, %xmm2                                  #91.8
        vmovd     %r14d, %xmm3                                  #91.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #91.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #91.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #91.8
        vmovups   %xmm6, 400(%rsp)                              #91.8[spill]
#       rand(void)
        call      rand                                          #92.22
                                # LOE rbx r12 eax
..B1.187:                       # Preds ..B1.33
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #92.22
                                # LOE rbx r12 r14d
..B1.34:                        # Preds ..B1.187
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #92.29
                                # LOE rbx r12 eax r14d
..B1.188:                       # Preds ..B1.34
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #92.29
                                # LOE rbx r12 r13d r14d
..B1.35:                        # Preds ..B1.188
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #92.36
                                # LOE rbx r12 eax r13d r14d
..B1.189:                       # Preds ..B1.35
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #92.36
                                # LOE rbx r12 r13d r14d r15d
..B1.36:                        # Preds ..B1.189
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #92.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.37:                        # Preds ..B1.36
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #92.8
        vmovd     %r15d, %xmm1                                  #92.8
        vmovd     %r13d, %xmm2                                  #92.8
        vmovd     %r14d, %xmm3                                  #92.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #92.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #92.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #92.8
        vmovups   %xmm6, 416(%rsp)                              #92.8[spill]
#       rand(void)
        call      rand                                          #93.22
                                # LOE rbx r12 eax
..B1.191:                       # Preds ..B1.37
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #93.22
                                # LOE rbx r12 r14d
..B1.38:                        # Preds ..B1.191
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #93.29
                                # LOE rbx r12 eax r14d
..B1.192:                       # Preds ..B1.38
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #93.29
                                # LOE rbx r12 r13d r14d
..B1.39:                        # Preds ..B1.192
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #93.36
                                # LOE rbx r12 eax r13d r14d
..B1.193:                       # Preds ..B1.39
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #93.36
                                # LOE rbx r12 r13d r14d r15d
..B1.40:                        # Preds ..B1.193
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #93.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.41:                        # Preds ..B1.40
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #93.8
        vmovd     %r15d, %xmm1                                  #93.8
        vmovd     %r13d, %xmm2                                  #93.8
        vmovd     %r14d, %xmm3                                  #93.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #93.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #93.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #93.8
        vmovups   %xmm6, 352(%rsp)                              #93.8[spill]
#       rand(void)
        call      rand                                          #94.23
                                # LOE rbx r12 eax
..B1.195:                       # Preds ..B1.41
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #94.23
                                # LOE rbx r12 r14d
..B1.42:                        # Preds ..B1.195
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #94.30
                                # LOE rbx r12 eax r14d
..B1.196:                       # Preds ..B1.42
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #94.30
                                # LOE rbx r12 r13d r14d
..B1.43:                        # Preds ..B1.196
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #94.37
                                # LOE rbx r12 eax r13d r14d
..B1.197:                       # Preds ..B1.43
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #94.37
                                # LOE rbx r12 r13d r14d r15d
..B1.44:                        # Preds ..B1.197
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #94.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #94.9
        vmovd     %r15d, %xmm1                                  #94.9
        vmovd     %r13d, %xmm2                                  #94.9
        vmovd     %r14d, %xmm3                                  #94.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #94.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #94.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #94.9
        vmovups   %xmm6, 384(%rsp)                              #94.9[spill]
#       rand(void)
        call      rand                                          #95.23
                                # LOE rbx r12 eax
..B1.199:                       # Preds ..B1.45
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #95.23
                                # LOE rbx r12 r14d
..B1.46:                        # Preds ..B1.199
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #95.30
                                # LOE rbx r12 eax r14d
..B1.200:                       # Preds ..B1.46
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #95.30
                                # LOE rbx r12 r13d r14d
..B1.47:                        # Preds ..B1.200
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #95.37
                                # LOE rbx r12 eax r13d r14d
..B1.201:                       # Preds ..B1.47
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #95.37
                                # LOE rbx r12 r13d r14d r15d
..B1.48:                        # Preds ..B1.201
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #95.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.49:                        # Preds ..B1.48
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #95.9
        vmovd     %r15d, %xmm1                                  #95.9
        vmovd     %r13d, %xmm2                                  #95.9
        vmovd     %r14d, %xmm3                                  #95.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #95.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #95.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #95.9
        vmovups   %xmm6, 368(%rsp)                              #95.9[spill]
#       rand(void)
        call      rand                                          #96.23
                                # LOE rbx r12 eax
..B1.203:                       # Preds ..B1.49
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #96.23
                                # LOE rbx r12 r14d
..B1.50:                        # Preds ..B1.203
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #96.30
                                # LOE rbx r12 eax r14d
..B1.204:                       # Preds ..B1.50
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #96.30
                                # LOE rbx r12 r13d r14d
..B1.51:                        # Preds ..B1.204
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #96.37
                                # LOE rbx r12 eax r13d r14d
..B1.205:                       # Preds ..B1.51
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #96.37
                                # LOE rbx r12 r13d r14d r15d
..B1.52:                        # Preds ..B1.205
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #96.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.53:                        # Preds ..B1.52
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #96.9
        vmovd     %r15d, %xmm1                                  #96.9
        vmovd     %r13d, %xmm2                                  #96.9
        vmovd     %r14d, %xmm3                                  #96.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #96.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #96.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #96.9
        vmovups   %xmm6, 304(%rsp)                              #96.9[spill]
#       rand(void)
        call      rand                                          #97.23
                                # LOE rbx r12 eax
..B1.207:                       # Preds ..B1.53
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #97.23
                                # LOE rbx r12 r14d
..B1.54:                        # Preds ..B1.207
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #97.30
                                # LOE rbx r12 eax r14d
..B1.208:                       # Preds ..B1.54
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #97.30
                                # LOE rbx r12 r13d r14d
..B1.55:                        # Preds ..B1.208
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #97.37
                                # LOE rbx r12 eax r13d r14d
..B1.209:                       # Preds ..B1.55
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #97.37
                                # LOE rbx r12 r13d r14d r15d
..B1.56:                        # Preds ..B1.209
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #97.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.57:                        # Preds ..B1.56
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #97.9
        vmovd     %r15d, %xmm1                                  #97.9
        vmovd     %r13d, %xmm2                                  #97.9
        vmovd     %r14d, %xmm3                                  #97.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #97.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #97.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #97.9
        vmovups   %xmm6, 464(%rsp)                              #97.9[spill]
#       rand(void)
        call      rand                                          #98.23
                                # LOE rbx r12 eax
..B1.211:                       # Preds ..B1.57
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #98.23
                                # LOE rbx r12 r14d
..B1.58:                        # Preds ..B1.211
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #98.30
                                # LOE rbx r12 eax r14d
..B1.212:                       # Preds ..B1.58
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #98.30
                                # LOE rbx r12 r13d r14d
..B1.59:                        # Preds ..B1.212
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #98.37
                                # LOE rbx r12 eax r13d r14d
..B1.213:                       # Preds ..B1.59
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #98.37
                                # LOE rbx r12 r13d r14d r15d
..B1.60:                        # Preds ..B1.213
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #98.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.61:                        # Preds ..B1.60
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #98.9
        vmovd     %r15d, %xmm1                                  #98.9
        vmovd     %r13d, %xmm2                                  #98.9
        vmovd     %r14d, %xmm3                                  #98.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #98.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #98.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #98.9
        vmovups   %xmm6, 64(%rsp)                               #98.9[spill]
#       rand(void)
        call      rand                                          #99.23
                                # LOE rbx r12 eax
..B1.215:                       # Preds ..B1.61
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #99.23
                                # LOE rbx r12 r14d
..B1.62:                        # Preds ..B1.215
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #99.30
                                # LOE rbx r12 eax r14d
..B1.216:                       # Preds ..B1.62
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #99.30
                                # LOE rbx r12 r13d r14d
..B1.63:                        # Preds ..B1.216
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #99.37
                                # LOE rbx r12 eax r13d r14d
..B1.217:                       # Preds ..B1.63
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #99.37
                                # LOE rbx r12 r13d r14d r15d
..B1.64:                        # Preds ..B1.217
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #99.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.65:                        # Preds ..B1.64
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #99.9
        vmovd     %r15d, %xmm1                                  #99.9
        vmovd     %r13d, %xmm2                                  #99.9
        vmovd     %r14d, %xmm3                                  #99.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #99.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #99.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #99.9
        vmovups   %xmm6, 96(%rsp)                               #99.9[spill]
#       rand(void)
        call      rand                                          #100.23
                                # LOE rbx r12 eax
..B1.219:                       # Preds ..B1.65
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #100.23
                                # LOE rbx r12 r14d
..B1.66:                        # Preds ..B1.219
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #100.30
                                # LOE rbx r12 eax r14d
..B1.220:                       # Preds ..B1.66
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #100.30
                                # LOE rbx r12 r13d r14d
..B1.67:                        # Preds ..B1.220
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #100.37
                                # LOE rbx r12 eax r13d r14d
..B1.221:                       # Preds ..B1.67
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #100.37
                                # LOE rbx r12 r13d r14d r15d
..B1.68:                        # Preds ..B1.221
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #100.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.69:                        # Preds ..B1.68
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #100.9
        vmovd     %r15d, %xmm1                                  #100.9
        vmovd     %r13d, %xmm2                                  #100.9
        vmovd     %r14d, %xmm3                                  #100.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #100.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #100.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #100.9
        vmovups   %xmm6, 160(%rsp)                              #100.9[spill]
#       rand(void)
        call      rand                                          #102.22
                                # LOE rbx r12 eax
..B1.223:                       # Preds ..B1.69
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #102.22
                                # LOE rbx r12 r14d
..B1.70:                        # Preds ..B1.223
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #102.29
                                # LOE rbx r12 eax r14d
..B1.224:                       # Preds ..B1.70
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #102.29
                                # LOE rbx r12 r13d r14d
..B1.71:                        # Preds ..B1.224
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #102.36
                                # LOE rbx r12 eax r13d r14d
..B1.225:                       # Preds ..B1.71
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #102.36
                                # LOE rbx r12 r13d r14d r15d
..B1.72:                        # Preds ..B1.225
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #102.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.73:                        # Preds ..B1.72
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #102.8
        vmovd     %r15d, %xmm1                                  #102.8
        vmovd     %r13d, %xmm2                                  #102.8
        vmovd     %r14d, %xmm3                                  #102.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #102.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #102.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #102.8
        vmovups   %xmm6, 16(%rsp)                               #102.8[spill]
#       rand(void)
        call      rand                                          #103.22
                                # LOE rbx r12 eax
..B1.227:                       # Preds ..B1.73
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #103.22
                                # LOE rbx r12 r14d
..B1.74:                        # Preds ..B1.227
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #103.29
                                # LOE rbx r12 eax r14d
..B1.228:                       # Preds ..B1.74
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #103.29
                                # LOE rbx r12 r13d r14d
..B1.75:                        # Preds ..B1.228
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #103.36
                                # LOE rbx r12 eax r13d r14d
..B1.229:                       # Preds ..B1.75
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #103.36
                                # LOE rbx r12 r13d r14d r15d
..B1.76:                        # Preds ..B1.229
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #103.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.77:                        # Preds ..B1.76
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #103.8
        vmovd     %r15d, %xmm1                                  #103.8
        vmovd     %r13d, %xmm2                                  #103.8
        vmovd     %r14d, %xmm3                                  #103.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #103.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #103.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #103.8
        vmovups   %xmm6, 32(%rsp)                               #103.8[spill]
#       rand(void)
        call      rand                                          #104.22
                                # LOE rbx r12 eax
..B1.231:                       # Preds ..B1.77
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #104.22
                                # LOE rbx r12 r14d
..B1.78:                        # Preds ..B1.231
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #104.29
                                # LOE rbx r12 eax r14d
..B1.232:                       # Preds ..B1.78
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #104.29
                                # LOE rbx r12 r13d r14d
..B1.79:                        # Preds ..B1.232
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #104.36
                                # LOE rbx r12 eax r13d r14d
..B1.233:                       # Preds ..B1.79
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #104.36
                                # LOE rbx r12 r13d r14d r15d
..B1.80:                        # Preds ..B1.233
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #104.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.81:                        # Preds ..B1.80
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #104.8
        vmovd     %r15d, %xmm1                                  #104.8
        vmovd     %r13d, %xmm2                                  #104.8
        vmovd     %r14d, %xmm3                                  #104.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #104.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #104.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #104.8
        vmovups   %xmm6, 48(%rsp)                               #104.8[spill]
#       rand(void)
        call      rand                                          #105.22
                                # LOE rbx r12 eax
..B1.235:                       # Preds ..B1.81
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #105.22
                                # LOE rbx r12 r14d
..B1.82:                        # Preds ..B1.235
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #105.29
                                # LOE rbx r12 eax r14d
..B1.236:                       # Preds ..B1.82
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #105.29
                                # LOE rbx r12 r13d r14d
..B1.83:                        # Preds ..B1.236
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #105.36
                                # LOE rbx r12 eax r13d r14d
..B1.237:                       # Preds ..B1.83
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #105.36
                                # LOE rbx r12 r13d r14d r15d
..B1.84:                        # Preds ..B1.237
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #105.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.85:                        # Preds ..B1.84
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #105.8
        vmovd     %r15d, %xmm1                                  #105.8
        vmovd     %r13d, %xmm2                                  #105.8
        vmovd     %r14d, %xmm3                                  #105.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #105.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #105.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #105.8
        vmovups   %xmm6, 80(%rsp)                               #105.8[spill]
#       rand(void)
        call      rand                                          #106.22
                                # LOE rbx r12 eax
..B1.239:                       # Preds ..B1.85
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #106.22
                                # LOE rbx r12 r14d
..B1.86:                        # Preds ..B1.239
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #106.29
                                # LOE rbx r12 eax r14d
..B1.240:                       # Preds ..B1.86
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #106.29
                                # LOE rbx r12 r13d r14d
..B1.87:                        # Preds ..B1.240
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #106.36
                                # LOE rbx r12 eax r13d r14d
..B1.241:                       # Preds ..B1.87
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #106.36
                                # LOE rbx r12 r13d r14d r15d
..B1.88:                        # Preds ..B1.241
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #106.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.89:                        # Preds ..B1.88
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #106.8
        vmovd     %r15d, %xmm1                                  #106.8
        vmovd     %r13d, %xmm2                                  #106.8
        vmovd     %r14d, %xmm3                                  #106.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #106.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #106.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #106.8
        vmovups   %xmm6, 112(%rsp)                              #106.8[spill]
#       rand(void)
        call      rand                                          #107.22
                                # LOE rbx r12 eax
..B1.243:                       # Preds ..B1.89
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #107.22
                                # LOE rbx r12 r14d
..B1.90:                        # Preds ..B1.243
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #107.29
                                # LOE rbx r12 eax r14d
..B1.244:                       # Preds ..B1.90
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #107.29
                                # LOE rbx r12 r13d r14d
..B1.91:                        # Preds ..B1.244
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #107.36
                                # LOE rbx r12 eax r13d r14d
..B1.245:                       # Preds ..B1.91
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #107.36
                                # LOE rbx r12 r13d r14d r15d
..B1.92:                        # Preds ..B1.245
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #107.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.93:                        # Preds ..B1.92
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #107.8
        vmovd     %r15d, %xmm1                                  #107.8
        vmovd     %r13d, %xmm2                                  #107.8
        vmovd     %r14d, %xmm3                                  #107.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #107.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #107.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #107.8
        vmovups   %xmm6, 128(%rsp)                              #107.8[spill]
#       rand(void)
        call      rand                                          #108.22
                                # LOE rbx r12 eax
..B1.247:                       # Preds ..B1.93
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #108.22
                                # LOE rbx r12 r14d
..B1.94:                        # Preds ..B1.247
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #108.29
                                # LOE rbx r12 eax r14d
..B1.248:                       # Preds ..B1.94
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #108.29
                                # LOE rbx r12 r13d r14d
..B1.95:                        # Preds ..B1.248
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #108.36
                                # LOE rbx r12 eax r13d r14d
..B1.249:                       # Preds ..B1.95
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #108.36
                                # LOE rbx r12 r13d r14d r15d
..B1.96:                        # Preds ..B1.249
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #108.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.97:                        # Preds ..B1.96
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #108.8
        vmovd     %r15d, %xmm1                                  #108.8
        vmovd     %r13d, %xmm2                                  #108.8
        vmovd     %r14d, %xmm3                                  #108.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #108.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #108.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #108.8
        vmovups   %xmm6, 144(%rsp)                              #108.8[spill]
#       rand(void)
        call      rand                                          #109.22
                                # LOE rbx r12 eax
..B1.251:                       # Preds ..B1.97
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #109.22
                                # LOE rbx r12 r14d
..B1.98:                        # Preds ..B1.251
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #109.29
                                # LOE rbx r12 eax r14d
..B1.252:                       # Preds ..B1.98
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #109.29
                                # LOE rbx r12 r13d r14d
..B1.99:                        # Preds ..B1.252
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #109.36
                                # LOE rbx r12 eax r13d r14d
..B1.253:                       # Preds ..B1.99
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #109.36
                                # LOE rbx r12 r13d r14d r15d
..B1.100:                       # Preds ..B1.253
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #109.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.101:                       # Preds ..B1.100
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #109.8
        vmovd     %r15d, %xmm1                                  #109.8
        vmovd     %r13d, %xmm2                                  #109.8
        vmovd     %r14d, %xmm3                                  #109.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #109.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #109.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #109.8
        vmovups   %xmm6, 176(%rsp)                              #109.8[spill]
#       rand(void)
        call      rand                                          #110.22
                                # LOE rbx r12 eax
..B1.255:                       # Preds ..B1.101
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #110.22
                                # LOE rbx r12 r14d
..B1.102:                       # Preds ..B1.255
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #110.29
                                # LOE rbx r12 eax r14d
..B1.256:                       # Preds ..B1.102
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #110.29
                                # LOE rbx r12 r13d r14d
..B1.103:                       # Preds ..B1.256
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #110.36
                                # LOE rbx r12 eax r13d r14d
..B1.257:                       # Preds ..B1.103
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #110.36
                                # LOE rbx r12 r13d r14d r15d
..B1.104:                       # Preds ..B1.257
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #110.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.105:                       # Preds ..B1.104
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #110.8
        vmovd     %r15d, %xmm1                                  #110.8
        vmovd     %r13d, %xmm2                                  #110.8
        vmovd     %r14d, %xmm3                                  #110.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #110.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #110.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #110.8
        vmovups   %xmm6, 192(%rsp)                              #110.8[spill]
#       rand(void)
        call      rand                                          #111.23
                                # LOE rbx r12 eax
..B1.259:                       # Preds ..B1.105
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #111.23
                                # LOE rbx r12 r14d
..B1.106:                       # Preds ..B1.259
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #111.30
                                # LOE rbx r12 eax r14d
..B1.260:                       # Preds ..B1.106
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #111.30
                                # LOE rbx r12 r13d r14d
..B1.107:                       # Preds ..B1.260
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #111.37
                                # LOE rbx r12 eax r13d r14d
..B1.261:                       # Preds ..B1.107
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #111.37
                                # LOE rbx r12 r13d r14d r15d
..B1.108:                       # Preds ..B1.261
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #111.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.109:                       # Preds ..B1.108
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #111.9
        vmovd     %r15d, %xmm1                                  #111.9
        vmovd     %r13d, %xmm2                                  #111.9
        vmovd     %r14d, %xmm3                                  #111.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #111.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #111.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #111.9
        vmovups   %xmm6, 208(%rsp)                              #111.9[spill]
#       rand(void)
        call      rand                                          #112.23
                                # LOE rbx r12 eax
..B1.263:                       # Preds ..B1.109
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #112.23
                                # LOE rbx r12 r14d
..B1.110:                       # Preds ..B1.263
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #112.30
                                # LOE rbx r12 eax r14d
..B1.264:                       # Preds ..B1.110
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #112.30
                                # LOE rbx r12 r13d r14d
..B1.111:                       # Preds ..B1.264
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #112.37
                                # LOE rbx r12 eax r13d r14d
..B1.265:                       # Preds ..B1.111
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #112.37
                                # LOE rbx r12 r13d r14d r15d
..B1.112:                       # Preds ..B1.265
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #112.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.113:                       # Preds ..B1.112
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #112.9
        vmovd     %r15d, %xmm1                                  #112.9
        vmovd     %r13d, %xmm2                                  #112.9
        vmovd     %r14d, %xmm3                                  #112.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #112.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #112.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #112.9
        vmovups   %xmm6, 224(%rsp)                              #112.9[spill]
#       rand(void)
        call      rand                                          #113.23
                                # LOE rbx r12 eax
..B1.267:                       # Preds ..B1.113
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #113.23
                                # LOE rbx r12 r14d
..B1.114:                       # Preds ..B1.267
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #113.30
                                # LOE rbx r12 eax r14d
..B1.268:                       # Preds ..B1.114
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #113.30
                                # LOE rbx r12 r13d r14d
..B1.115:                       # Preds ..B1.268
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #113.37
                                # LOE rbx r12 eax r13d r14d
..B1.269:                       # Preds ..B1.115
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #113.37
                                # LOE rbx r12 r13d r14d r15d
..B1.116:                       # Preds ..B1.269
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #113.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.117:                       # Preds ..B1.116
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #113.9
        vmovd     %r15d, %xmm1                                  #113.9
        vmovd     %r13d, %xmm2                                  #113.9
        vmovd     %r14d, %xmm3                                  #113.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #113.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #113.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #113.9
        vmovups   %xmm6, 240(%rsp)                              #113.9[spill]
#       rand(void)
        call      rand                                          #114.23
                                # LOE rbx r12 eax
..B1.271:                       # Preds ..B1.117
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #114.23
                                # LOE rbx r12 r14d
..B1.118:                       # Preds ..B1.271
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #114.30
                                # LOE rbx r12 eax r14d
..B1.272:                       # Preds ..B1.118
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #114.30
                                # LOE rbx r12 r13d r14d
..B1.119:                       # Preds ..B1.272
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #114.37
                                # LOE rbx r12 eax r13d r14d
..B1.273:                       # Preds ..B1.119
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #114.37
                                # LOE rbx r12 r13d r14d r15d
..B1.120:                       # Preds ..B1.273
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #114.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.121:                       # Preds ..B1.120
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #114.9
        vmovd     %r15d, %xmm1                                  #114.9
        vmovd     %r13d, %xmm2                                  #114.9
        vmovd     %r14d, %xmm3                                  #114.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #114.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #114.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #114.9
        vmovups   %xmm6, 256(%rsp)                              #114.9[spill]
#       rand(void)
        call      rand                                          #115.23
                                # LOE rbx r12 eax
..B1.275:                       # Preds ..B1.121
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #115.23
                                # LOE rbx r12 r14d
..B1.122:                       # Preds ..B1.275
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #115.30
                                # LOE rbx r12 eax r14d
..B1.276:                       # Preds ..B1.122
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #115.30
                                # LOE rbx r12 r13d r14d
..B1.123:                       # Preds ..B1.276
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #115.37
                                # LOE rbx r12 eax r13d r14d
..B1.277:                       # Preds ..B1.123
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #115.37
                                # LOE rbx r12 r13d r14d r15d
..B1.124:                       # Preds ..B1.277
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #115.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.125:                       # Preds ..B1.124
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #115.9
        vmovd     %r15d, %xmm1                                  #115.9
        vmovd     %r13d, %xmm2                                  #115.9
        vmovd     %r14d, %xmm3                                  #115.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #115.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #115.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #115.9
        vmovups   %xmm6, 272(%rsp)                              #115.9[spill]
#       rand(void)
        call      rand                                          #116.23
                                # LOE rbx r12 eax
..B1.279:                       # Preds ..B1.125
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #116.23
                                # LOE rbx r12 r14d
..B1.126:                       # Preds ..B1.279
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #116.30
                                # LOE rbx r12 eax r14d
..B1.280:                       # Preds ..B1.126
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #116.30
                                # LOE rbx r12 r13d r14d
..B1.127:                       # Preds ..B1.280
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #116.37
                                # LOE rbx r12 eax r13d r14d
..B1.281:                       # Preds ..B1.127
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #116.37
                                # LOE rbx r12 r13d r14d r15d
..B1.128:                       # Preds ..B1.281
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #116.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.129:                       # Preds ..B1.128
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #116.9
        vmovd     %r15d, %xmm1                                  #116.9
        vmovd     %r13d, %xmm2                                  #116.9
        vmovd     %r14d, %xmm3                                  #116.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #116.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #116.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #116.9
        vmovups   %xmm6, 288(%rsp)                              #116.9[spill]
#       rand(void)
        call      rand                                          #117.23
                                # LOE rbx r12 eax
..B1.283:                       # Preds ..B1.129
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #117.23
                                # LOE rbx r12 r15d
..B1.130:                       # Preds ..B1.283
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #117.30
                                # LOE rbx r12 eax r15d
..B1.284:                       # Preds ..B1.130
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #117.30
                                # LOE rbx r12 r14d r15d
..B1.131:                       # Preds ..B1.284
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #117.37
                                # LOE rbx r12 eax r14d r15d
..B1.285:                       # Preds ..B1.131
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #117.37
                                # LOE rbx r12 r13d r14d r15d
..B1.132:                       # Preds ..B1.285
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #117.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.286:                       # Preds ..B1.132
                                # Execution count [1.00e+00]
        movl      %eax, %edx                                    #117.44
                                # LOE rbx r12 edx r13d r14d r15d
..B1.133:                       # Preds ..B1.286
                                # Execution count [9.00e-01]
        vmovd     %edx, %xmm0                                   #117.9
        vmovd     %r13d, %xmm1                                  #117.9
        vmovd     %r14d, %xmm2                                  #117.9
        vmovd     %r15d, %xmm3                                  #117.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #117.9
        xorl      %eax, %eax                                    #119.3
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #117.9
        vmovups   496(%rsp), %xmm7                              #121.17[spill]
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #117.9
        vxorps    480(%rsp), %xmm7, %xmm0                       #121.17[spill]
        vmovups   %xmm6, (%rsp)                                 #117.9[spill]
                                # LOE rbx r12 eax xmm0
..B1.134:                       # Preds ..B1.134 ..B1.133
                                # Execution count [2.50e+00]
        lea       (%rax,%rax), %edx                             #121.5
        incl      %eax                                          #119.3
        shlq      $4, %rdx                                      #121.5
        vmovups   %xmm0, (%rbx,%rdx)                            #121.5
        vmovups   %xmm0, 16(%rbx,%rdx)                          #121.5
        cmpl      $8000000, %eax                                #119.3
        jb        ..B1.134      # Prob 63%                      #119.3
                                # LOE rbx r12 eax xmm0
..B1.135:                       # Preds ..B1.134
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #123.3
        movl      $16, %esi                                     #123.3
        movl      $16000000, %edx                               #123.3
        movq      %r12, %rcx                                    #123.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #123.3
                                # LOE rbx r12
..B1.136:                       # Preds ..B1.135
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #126.3
        xorl      %eax, %eax                                    #126.3
..___tag_value_main.13:
#       printf(const char *__restrict__, ...)
        call      printf                                        #126.3
..___tag_value_main.14:
                                # LOE rbx r12
..B1.137:                       # Preds ..B1.136
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #126.27
#       fflush(FILE *)
        call      fflush                                        #126.27
                                # LOE rbx r12
..B1.138:                       # Preds ..B1.137
                                # Execution count [1.00e+00]
        rdtscp                                                   #127.11
        shlq      $32, %rdx                                     #127.11
        orq       %rdx, %rax                                    #127.11
                                # LOE rax rbx r12
..B1.287:                       # Preds ..B1.138
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #127.11
        xorl      %edx, %edx                                    #128.3
        xorl      %eax, %eax                                    #128.3
                                # LOE rbx r8 r12
..B1.139:                       # Preds ..B1.287
                                # Execution count [9.00e-01]
        vmovups   496(%rsp), %xmm14                             #129.5[spill]
        vmovups   480(%rsp), %xmm13                             #129.5[spill]
        vmovups   336(%rsp), %xmm12                             #129.5[spill]
        vmovups   320(%rsp), %xmm11                             #129.5[spill]
        vmovups   448(%rsp), %xmm10                             #129.5[spill]
        vmovups   432(%rsp), %xmm9                              #129.5[spill]
        vmovups   400(%rsp), %xmm8                              #129.5[spill]
        vmovups   416(%rsp), %xmm7                              #129.5[spill]
        vmovups   352(%rsp), %xmm6                              #129.5[spill]
        vmovups   384(%rsp), %xmm5                              #129.5[spill]
        vmovups   368(%rsp), %xmm4                              #129.5[spill]
        vmovups   304(%rsp), %xmm3                              #129.5[spill]
        vmovups   464(%rsp), %xmm2                              #129.5[spill]
        vmovups   272(%rsp), %xmm1                              #129.5[spill]
        vmovups   288(%rsp), %xmm0                              #129.5[spill]
        vmovups   (%rsp), %xmm15                                #129.5[spill]
        vpaddb    16(%rsp), %xmm14, %xmm14                      #129.5[spill]
        vpaddb    32(%rsp), %xmm13, %xmm13                      #129.5[spill]
        vpaddb    48(%rsp), %xmm12, %xmm12                      #129.5[spill]
        vpaddb    80(%rsp), %xmm11, %xmm11                      #129.5[spill]
        vpaddb    112(%rsp), %xmm10, %xmm10                     #129.5[spill]
        vpaddb    128(%rsp), %xmm9, %xmm9                       #129.5[spill]
        vpaddb    144(%rsp), %xmm8, %xmm8                       #129.5[spill]
        vpaddb    176(%rsp), %xmm7, %xmm7                       #129.5[spill]
        vpaddb    192(%rsp), %xmm6, %xmm6                       #129.5[spill]
        vpaddb    208(%rsp), %xmm5, %xmm5                       #129.5[spill]
        vpaddb    224(%rsp), %xmm4, %xmm4                       #129.5[spill]
        vpaddb    240(%rsp), %xmm3, %xmm3                       #129.5[spill]
        vpaddb    256(%rsp), %xmm2, %xmm2                       #129.5[spill]
        vpaddb    64(%rsp), %xmm1, %xmm1                        #129.5[spill]
        vpaddb    96(%rsp), %xmm0, %xmm0                        #129.5[spill]
        vpaddb    160(%rsp), %xmm15, %xmm15                     #129.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.140:                       # Preds ..B1.140 ..B1.139
                                # Execution count [5.00e+00]
        incl      %edx                                          #128.3
        lea       (%rax,%rbx), %rsi                             #129.5
        vmovdqu   %xmm9, 80(%rsi)                               #129.5
        vmovdqu   %xmm8, 96(%rsi)                               #129.5
        vmovdqu   %xmm7, 112(%rsi)                              #129.5
        vmovdqu   %xmm6, 128(%rsi)                              #129.5
        vmovdqu   %xmm5, 144(%rsi)                              #129.5
        vmovdqu   %xmm4, 160(%rsi)                              #129.5
        vmovdqu   %xmm3, 176(%rsi)                              #129.5
        vmovdqu   %xmm2, 192(%rsi)                              #129.5
        vmovdqu   %xmm1, 208(%rsi)                              #129.5
        vmovdqu   %xmm0, 224(%rsi)                              #129.5
        vmovdqu   %xmm15, 240(%rsi)                             #129.5
        addq      $256, %rax                                    #128.3
        vmovdqu   %xmm14, (%rsi)                                #129.5
        vmovdqu   %xmm13, 16(%rsi)                              #129.5
        vmovdqu   %xmm12, 32(%rsi)                              #129.5
        vmovdqu   %xmm11, 48(%rsi)                              #129.5
        vmovdqu   %xmm10, 64(%rsi)                              #129.5
        cmpl      $1000000, %edx                                #128.3
        jb        ..B1.139      # Prob 82%                      #128.3
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.141:                       # Preds ..B1.140
                                # Execution count [1.00e+00]
        rdtscp                                                   #132.9
        shlq      $32, %rdx                                     #132.9
        orq       %rdx, %rax                                    #132.9
                                # LOE rax rbx r8 r12
..B1.142:                       # Preds ..B1.141
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #133.3
        movl      $.L_2__STRING.3, %edi                         #133.3
        movq      %rax, %rsi                                    #133.3
        xorl      %eax, %eax                                    #133.3
..___tag_value_main.15:
#       printf(const char *__restrict__, ...)
        call      printf                                        #133.3
..___tag_value_main.16:
                                # LOE rbx r12
..B1.143:                       # Preds ..B1.142
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #134.3
        movl      $16, %esi                                     #134.3
        movl      $16000000, %edx                               #134.3
        movq      %r12, %rcx                                    #134.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #134.3
                                # LOE rbx r12
..B1.144:                       # Preds ..B1.143
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.4, %edi                         #136.3
        xorl      %eax, %eax                                    #136.3
..___tag_value_main.17:
#       printf(const char *__restrict__, ...)
        call      printf                                        #136.3
..___tag_value_main.18:
                                # LOE rbx r12
..B1.145:                       # Preds ..B1.144
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #136.27
#       fflush(FILE *)
        call      fflush                                        #136.27
                                # LOE rbx r12
..B1.146:                       # Preds ..B1.145
                                # Execution count [1.00e+00]
        rdtscp                                                   #137.11
        shlq      $32, %rdx                                     #137.11
        orq       %rdx, %rax                                    #137.11
                                # LOE rax rbx r12
..B1.289:                       # Preds ..B1.146
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #137.11
        xorl      %edx, %edx                                    #138.3
        xorl      %eax, %eax                                    #138.3
                                # LOE rbx r8 r12
..B1.147:                       # Preds ..B1.289
                                # Execution count [9.00e-01]
        vmovups   496(%rsp), %xmm14                             #139.5[spill]
        vmovups   480(%rsp), %xmm13                             #139.5[spill]
        vmovups   336(%rsp), %xmm12                             #139.5[spill]
        vmovups   320(%rsp), %xmm11                             #139.5[spill]
        vmovups   448(%rsp), %xmm10                             #139.5[spill]
        vmovups   432(%rsp), %xmm9                              #139.5[spill]
        vmovups   400(%rsp), %xmm8                              #139.5[spill]
        vmovups   416(%rsp), %xmm7                              #139.5[spill]
        vmovups   352(%rsp), %xmm6                              #139.5[spill]
        vmovups   384(%rsp), %xmm5                              #139.5[spill]
        vmovups   368(%rsp), %xmm4                              #139.5[spill]
        vmovups   304(%rsp), %xmm3                              #139.5[spill]
        vmovups   464(%rsp), %xmm2                              #139.5[spill]
        vmovups   272(%rsp), %xmm1                              #139.5[spill]
        vmovups   288(%rsp), %xmm0                              #139.5[spill]
        vmovups   (%rsp), %xmm15                                #139.5[spill]
        vxorps    16(%rsp), %xmm14, %xmm14                      #139.5[spill]
        vxorps    32(%rsp), %xmm13, %xmm13                      #139.5[spill]
        vxorps    48(%rsp), %xmm12, %xmm12                      #139.5[spill]
        vxorps    80(%rsp), %xmm11, %xmm11                      #139.5[spill]
        vxorps    112(%rsp), %xmm10, %xmm10                     #139.5[spill]
        vxorps    128(%rsp), %xmm9, %xmm9                       #139.5[spill]
        vxorps    144(%rsp), %xmm8, %xmm8                       #139.5[spill]
        vxorps    176(%rsp), %xmm7, %xmm7                       #139.5[spill]
        vxorps    192(%rsp), %xmm6, %xmm6                       #139.5[spill]
        vxorps    208(%rsp), %xmm5, %xmm5                       #139.5[spill]
        vxorps    224(%rsp), %xmm4, %xmm4                       #139.5[spill]
        vxorps    240(%rsp), %xmm3, %xmm3                       #139.5[spill]
        vxorps    256(%rsp), %xmm2, %xmm2                       #139.5[spill]
        vxorps    64(%rsp), %xmm1, %xmm1                        #139.5[spill]
        vxorps    96(%rsp), %xmm0, %xmm0                        #139.5[spill]
        vxorps    160(%rsp), %xmm15, %xmm15                     #139.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.148:                       # Preds ..B1.148 ..B1.147
                                # Execution count [5.00e+00]
        incl      %edx                                          #138.3
        lea       (%rax,%rbx), %rsi                             #139.5
        vmovups   %xmm9, 80(%rsi)                               #139.5
        vmovups   %xmm8, 96(%rsi)                               #139.5
        vmovups   %xmm7, 112(%rsi)                              #139.5
        vmovups   %xmm6, 128(%rsi)                              #139.5
        vmovups   %xmm5, 144(%rsi)                              #139.5
        vmovups   %xmm4, 160(%rsi)                              #139.5
        vmovups   %xmm3, 176(%rsi)                              #139.5
        vmovups   %xmm2, 192(%rsi)                              #139.5
        vmovups   %xmm1, 208(%rsi)                              #139.5
        vmovups   %xmm0, 224(%rsi)                              #139.5
        vmovups   %xmm15, 240(%rsi)                             #139.5
        addq      $256, %rax                                    #138.3
        vmovups   %xmm14, (%rsi)                                #139.5
        vmovups   %xmm13, 16(%rsi)                              #139.5
        vmovups   %xmm12, 32(%rsi)                              #139.5
        vmovups   %xmm11, 48(%rsi)                              #139.5
        vmovups   %xmm10, 64(%rsi)                              #139.5
        cmpl      $1000000, %edx                                #138.3
        jb        ..B1.147      # Prob 82%                      #138.3
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.149:                       # Preds ..B1.148
                                # Execution count [1.00e+00]
        rdtscp                                                   #142.9
        shlq      $32, %rdx                                     #142.9
        orq       %rdx, %rax                                    #142.9
                                # LOE rax rbx r8 r12
..B1.150:                       # Preds ..B1.149
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #143.3
        movl      $.L_2__STRING.3, %edi                         #143.3
        movq      %rax, %rsi                                    #143.3
        xorl      %eax, %eax                                    #143.3
..___tag_value_main.19:
#       printf(const char *__restrict__, ...)
        call      printf                                        #143.3
..___tag_value_main.20:
                                # LOE rbx r12
..B1.151:                       # Preds ..B1.150
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #144.3
        movl      $16, %esi                                     #144.3
        movl      $16000000, %edx                               #144.3
        movq      %r12, %rcx                                    #144.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #144.3
                                # LOE
..B1.152:                       # Preds ..B1.151
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #146.10
        addq      $600, %rsp                                    #146.10
	.cfi_restore 3
        popq      %rbx                                          #146.10
	.cfi_restore 15
        popq      %r15                                          #146.10
	.cfi_restore 14
        popq      %r14                                          #146.10
	.cfi_restore 13
        popq      %r13                                          #146.10
	.cfi_restore 12
        popq      %r12                                          #146.10
        movq      %rbp, %rsp                                    #146.10
        popq      %rbp                                          #146.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #146.10
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
	.data
# -- End  main
	.text
# -- Begin  add_pack
	.text
# mark_begin;
       .align    16,0x90
	.globl add_pack
# --- add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
add_pack:
# parameter 1: %xmm0
# parameter 2: %xmm1
# parameter 3: %xmm2
# parameter 4: %xmm3
# parameter 5: %xmm4
# parameter 6: %xmm5
# parameter 7: %xmm6
# parameter 8: %xmm7
# parameter 9: 8 + %rsp
# parameter 10: 24 + %rsp
# parameter 11: 40 + %rsp
# parameter 12: 56 + %rsp
# parameter 13: 72 + %rsp
# parameter 14: 88 + %rsp
# parameter 15: 104 + %rsp
# parameter 16: 120 + %rsp
# parameter 17: 136 + %rsp
# parameter 18: 152 + %rsp
# parameter 19: 168 + %rsp
# parameter 20: 184 + %rsp
# parameter 21: 200 + %rsp
# parameter 22: 216 + %rsp
# parameter 23: 232 + %rsp
# parameter 24: 248 + %rsp
# parameter 25: 264 + %rsp
# parameter 26: 280 + %rsp
# parameter 27: 296 + %rsp
# parameter 28: 312 + %rsp
# parameter 29: 328 + %rsp
# parameter 30: 344 + %rsp
# parameter 31: 360 + %rsp
# parameter 32: 376 + %rsp
# parameter 33: %rdi
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_pack.29:
..L30:
                                                         #19.31
        vpaddb    136(%rsp), %xmm0, %xmm0                       #20.12
        vmovdqu   72(%rsp), %xmm12                              #19.31
        vmovdqu   8(%rsp), %xmm8                                #19.31
        vmovdqu   24(%rsp), %xmm9                               #19.31
        vmovdqu   40(%rsp), %xmm10                              #19.31
        vmovdqu   56(%rsp), %xmm11                              #19.31
        vmovdqu   88(%rsp), %xmm13                              #19.31
        vmovdqu   104(%rsp), %xmm14                             #19.31
        vmovdqu   120(%rsp), %xmm15                             #19.31
        vmovdqu   %xmm0, (%rdi)                                 #20.3
        vpaddb    152(%rsp), %xmm1, %xmm1                       #21.12
        vpaddb    168(%rsp), %xmm2, %xmm2                       #22.12
        vpaddb    184(%rsp), %xmm3, %xmm3                       #23.12
        vpaddb    200(%rsp), %xmm4, %xmm4                       #24.12
        vpaddb    216(%rsp), %xmm5, %xmm5                       #25.12
        vpaddb    232(%rsp), %xmm6, %xmm6                       #26.12
        vpaddb    248(%rsp), %xmm7, %xmm0                       #27.12
        vpaddb    264(%rsp), %xmm8, %xmm8                       #28.12
        vpaddb    280(%rsp), %xmm9, %xmm9                       #29.12
        vpaddb    296(%rsp), %xmm10, %xmm10                     #30.13
        vpaddb    312(%rsp), %xmm11, %xmm11                     #31.13
        vpaddb    328(%rsp), %xmm12, %xmm12                     #32.13
        vpaddb    344(%rsp), %xmm13, %xmm13                     #33.13
        vpaddb    360(%rsp), %xmm14, %xmm14                     #34.13
        vpaddb    376(%rsp), %xmm15, %xmm15                     #35.13
        vmovdqu   %xmm1, 16(%rdi)                               #21.3
        vmovdqu   %xmm2, 32(%rdi)                               #22.3
        vmovdqu   %xmm3, 48(%rdi)                               #23.3
        vmovdqu   %xmm4, 64(%rdi)                               #24.3
        vmovdqu   %xmm5, 80(%rdi)                               #25.3
        vmovdqu   %xmm6, 96(%rdi)                               #26.3
        vmovdqu   %xmm0, 112(%rdi)                              #27.3
        vmovdqu   %xmm8, 128(%rdi)                              #28.3
        vmovdqu   %xmm9, 144(%rdi)                              #29.3
        vmovdqu   %xmm10, 160(%rdi)                             #30.3
        vmovdqu   %xmm11, 176(%rdi)                             #31.3
        vmovdqu   %xmm12, 192(%rdi)                             #32.3
        vmovdqu   %xmm13, 208(%rdi)                             #33.3
        vmovdqu   %xmm14, 224(%rdi)                             #34.3
        vmovdqu   %xmm15, 240(%rdi)                             #35.3
        ret                                                     #36.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_pack,@function
	.size	add_pack,.-add_pack
	.data
# -- End  add_pack
	.text
# -- Begin  add
	.text
# mark_begin;
       .align    16,0x90
	.globl add
# --- add(__m128i, __m128i, __m128i *)
add:
# parameter 1: %xmm0
# parameter 2: %xmm1
# parameter 3: %rdi
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add.32:
..L33:
                                                         #39.47
        vpxor     %xmm1, %xmm0, %xmm0                           #40.17
        ret                                                     #41.10
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add,@function
	.size	add,.-add
	.data
# -- End  add
	.text
# -- Begin  add_bitslice
	.text
# mark_begin;
       .align    16,0x90
	.globl add_bitslice
# --- add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
add_bitslice:
# parameter 1: %xmm0
# parameter 2: %xmm1
# parameter 3: %xmm2
# parameter 4: %xmm3
# parameter 5: %xmm4
# parameter 6: %xmm5
# parameter 7: %xmm6
# parameter 8: %xmm7
# parameter 9: 8 + %rsp
# parameter 10: 24 + %rsp
# parameter 11: 40 + %rsp
# parameter 12: 56 + %rsp
# parameter 13: 72 + %rsp
# parameter 14: 88 + %rsp
# parameter 15: 104 + %rsp
# parameter 16: 120 + %rsp
# parameter 17: 136 + %rsp
# parameter 18: 152 + %rsp
# parameter 19: 168 + %rsp
# parameter 20: 184 + %rsp
# parameter 21: 200 + %rsp
# parameter 22: 216 + %rsp
# parameter 23: 232 + %rsp
# parameter 24: 248 + %rsp
# parameter 25: 264 + %rsp
# parameter 26: 280 + %rsp
# parameter 27: 296 + %rsp
# parameter 28: 312 + %rsp
# parameter 29: 328 + %rsp
# parameter 30: 344 + %rsp
# parameter 31: 360 + %rsp
# parameter 32: 376 + %rsp
# parameter 33: %rdi
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bitslice.35:
..L36:
                                                         #52.34
        vpxor     136(%rsp), %xmm0, %xmm0                       #54.12
        vmovdqu   72(%rsp), %xmm12                              #52.34
        vmovdqu   8(%rsp), %xmm8                                #52.34
        vmovdqu   24(%rsp), %xmm9                               #52.34
        vmovdqu   40(%rsp), %xmm10                              #52.34
        vmovdqu   56(%rsp), %xmm11                              #52.34
        vmovdqu   88(%rsp), %xmm13                              #52.34
        vmovdqu   104(%rsp), %xmm14                             #52.34
        vmovdqu   120(%rsp), %xmm15                             #52.34
        vmovdqu   %xmm0, (%rdi)                                 #54.3
        vpxor     152(%rsp), %xmm1, %xmm1                       #55.12
        vpxor     168(%rsp), %xmm2, %xmm2                       #56.12
        vpxor     184(%rsp), %xmm3, %xmm3                       #57.12
        vpxor     200(%rsp), %xmm4, %xmm4                       #58.12
        vpxor     216(%rsp), %xmm5, %xmm5                       #59.12
        vpxor     232(%rsp), %xmm6, %xmm6                       #60.12
        vpxor     248(%rsp), %xmm7, %xmm0                       #61.12
        vpxor     264(%rsp), %xmm8, %xmm8                       #62.12
        vpxor     280(%rsp), %xmm9, %xmm9                       #63.12
        vpxor     296(%rsp), %xmm10, %xmm10                     #64.13
        vpxor     312(%rsp), %xmm11, %xmm11                     #65.13
        vpxor     328(%rsp), %xmm12, %xmm12                     #66.13
        vpxor     344(%rsp), %xmm13, %xmm13                     #67.13
        vpxor     360(%rsp), %xmm14, %xmm14                     #68.13
        vpxor     376(%rsp), %xmm15, %xmm15                     #69.13
        vmovdqu   %xmm1, 16(%rdi)                               #55.3
        vmovdqu   %xmm2, 32(%rdi)                               #56.3
        vmovdqu   %xmm3, 48(%rdi)                               #57.3
        vmovdqu   %xmm4, 64(%rdi)                               #58.3
        vmovdqu   %xmm5, 80(%rdi)                               #59.3
        vmovdqu   %xmm6, 96(%rdi)                               #60.3
        vmovdqu   %xmm0, 112(%rdi)                              #61.3
        vmovdqu   %xmm8, 128(%rdi)                              #62.3
        vmovdqu   %xmm9, 144(%rdi)                              #63.3
        vmovdqu   %xmm10, 160(%rdi)                             #64.3
        vmovdqu   %xmm11, 176(%rdi)                             #65.3
        vmovdqu   %xmm12, 192(%rdi)                             #66.3
        vmovdqu   %xmm13, 208(%rdi)                             #67.3
        vmovdqu   %xmm14, 224(%rdi)                             #68.3
        vmovdqu   %xmm15, 240(%rdi)                             #69.3
        ret                                                     #70.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_bitslice,@function
	.size	add_bitslice,.-add_bitslice
	.data
# -- End  add_bitslice
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.0:
	.long	1986356271
	.long	1819635247
	.word	108
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,10
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.word	119
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,2
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	1801675088
	.long	774792293
	.long	774778414
	.word	32
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	175467557
	.byte	0
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,5
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.4:
	.long	1937008962
	.long	1701013868
	.long	774778468
	.word	32
	.type	.L_2__STRING.4,@object
	.size	.L_2__STRING.4,14
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
# End
