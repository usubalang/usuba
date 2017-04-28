# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "-Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -i";
# mark_description "nline-max-total-size=10000 -O3 -funroll-loops -unroll-agressive -S -o add_16_wrong.s";
	.file "add_16_wrong.c"
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
                                                          #150.13
        pushq     %rbp                                          #150.13
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #150.13
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-128, %rsp                                   #150.13
        pushq     %r12                                          #150.13
        pushq     %r13                                          #150.13
        pushq     %r14                                          #150.13
        pushq     %r15                                          #150.13
        pushq     %rbx                                          #150.13
        subq      $2392, %rsp                                   #150.13
        movl      $10330110, %esi                               #150.13
        movl      $3, %edi                                      #150.13
        call      __intel_new_feature_proc_init                 #150.13
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.164:                       # Preds ..B1.1
                                # Execution count [1.00e+00]
        vstmxcsr  (%rsp)                                        #150.13
        movl      $.L_2__STRING.0, %edi                         #153.13
        movl      $.L_2__STRING.1, %esi                         #153.13
        orl       $32832, (%rsp)                                #150.13
        vldmxcsr  (%rsp)                                        #150.13
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #153.13
                                # LOE rax
..B1.163:                       # Preds ..B1.164
                                # Execution count [1.00e+00]
        movq      %rax, %r12                                    #153.13
                                # LOE r12
..B1.2:                         # Preds ..B1.163
                                # Execution count [1.00e+00]
        xorl      %edi, %edi                                    #159.9
#       time(time_t *)
        call      time                                          #159.9
                                # LOE rax r12
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movl      %eax, %edi                                    #159.3
#       srand(unsigned int)
        call      srand                                         #159.3
                                # LOE r12
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
        movl      $32, %edi                                     #160.30
        movl      $256000000, %esi                              #160.30
..___tag_value_main.11:
#       aligned_alloc(size_t, size_t)
        call      aligned_alloc                                 #160.30
..___tag_value_main.12:
                                # LOE rax r12
..B1.166:                       # Preds ..B1.4
                                # Execution count [1.00e+00]
        movq      %rax, %rbx                                    #160.30
                                # LOE rbx r12
..B1.5:                         # Preds ..B1.166
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.22
                                # LOE rbx r12 eax
..B1.167:                       # Preds ..B1.5
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #162.22
                                # LOE rbx r12 r14d
..B1.6:                         # Preds ..B1.167
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.29
                                # LOE rbx r12 eax r14d
..B1.168:                       # Preds ..B1.6
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #162.29
                                # LOE rbx r12 r13d r14d
..B1.7:                         # Preds ..B1.168
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.36
                                # LOE rbx r12 eax r13d r14d
..B1.169:                       # Preds ..B1.7
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #162.36
                                # LOE rbx r12 r13d r14d r15d
..B1.8:                         # Preds ..B1.169
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.9:                         # Preds ..B1.8
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #162.8
        vmovd     %r15d, %xmm1                                  #162.8
        vmovd     %r13d, %xmm2                                  #162.8
        vmovd     %r14d, %xmm3                                  #162.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #162.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #162.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #162.8
        vmovups   %xmm6, 2272(%rsp)                             #162.8[spill]
#       rand(void)
        call      rand                                          #163.22
                                # LOE rbx r12 eax
..B1.171:                       # Preds ..B1.9
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #163.22
                                # LOE rbx r12 r14d
..B1.10:                        # Preds ..B1.171
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #163.29
                                # LOE rbx r12 eax r14d
..B1.172:                       # Preds ..B1.10
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #163.29
                                # LOE rbx r12 r13d r14d
..B1.11:                        # Preds ..B1.172
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #163.36
                                # LOE rbx r12 eax r13d r14d
..B1.173:                       # Preds ..B1.11
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #163.36
                                # LOE rbx r12 r13d r14d r15d
..B1.12:                        # Preds ..B1.173
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #163.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #163.8
        vmovd     %r15d, %xmm1                                  #163.8
        vmovd     %r13d, %xmm2                                  #163.8
        vmovd     %r14d, %xmm3                                  #163.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #163.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #163.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #163.8
        vmovups   %xmm6, 2256(%rsp)                             #163.8[spill]
#       rand(void)
        call      rand                                          #164.22
                                # LOE rbx r12 eax
..B1.175:                       # Preds ..B1.13
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #164.22
                                # LOE rbx r12 r14d
..B1.14:                        # Preds ..B1.175
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #164.29
                                # LOE rbx r12 eax r14d
..B1.176:                       # Preds ..B1.14
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #164.29
                                # LOE rbx r12 r13d r14d
..B1.15:                        # Preds ..B1.176
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #164.36
                                # LOE rbx r12 eax r13d r14d
..B1.177:                       # Preds ..B1.15
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #164.36
                                # LOE rbx r12 r13d r14d r15d
..B1.16:                        # Preds ..B1.177
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #164.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.17:                        # Preds ..B1.16
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #164.8
        vmovd     %r15d, %xmm1                                  #164.8
        vmovd     %r13d, %xmm2                                  #164.8
        vmovd     %r14d, %xmm3                                  #164.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #164.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #164.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #164.8
        vmovups   %xmm6, 2224(%rsp)                             #164.8[spill]
#       rand(void)
        call      rand                                          #165.22
                                # LOE rbx r12 eax
..B1.179:                       # Preds ..B1.17
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #165.22
                                # LOE rbx r12 r14d
..B1.18:                        # Preds ..B1.179
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #165.29
                                # LOE rbx r12 eax r14d
..B1.180:                       # Preds ..B1.18
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #165.29
                                # LOE rbx r12 r13d r14d
..B1.19:                        # Preds ..B1.180
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #165.36
                                # LOE rbx r12 eax r13d r14d
..B1.181:                       # Preds ..B1.19
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #165.36
                                # LOE rbx r12 r13d r14d r15d
..B1.20:                        # Preds ..B1.181
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #165.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #165.8
        vmovd     %r15d, %xmm1                                  #165.8
        vmovd     %r13d, %xmm2                                  #165.8
        vmovd     %r14d, %xmm3                                  #165.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #165.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #165.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #165.8
        vmovups   %xmm6, 2240(%rsp)                             #165.8[spill]
#       rand(void)
        call      rand                                          #166.22
                                # LOE rbx r12 eax
..B1.183:                       # Preds ..B1.21
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #166.22
                                # LOE rbx r12 r14d
..B1.22:                        # Preds ..B1.183
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #166.29
                                # LOE rbx r12 eax r14d
..B1.184:                       # Preds ..B1.22
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #166.29
                                # LOE rbx r12 r13d r14d
..B1.23:                        # Preds ..B1.184
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #166.36
                                # LOE rbx r12 eax r13d r14d
..B1.185:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #166.36
                                # LOE rbx r12 r13d r14d r15d
..B1.24:                        # Preds ..B1.185
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #166.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.25:                        # Preds ..B1.24
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #166.8
        vmovd     %r15d, %xmm1                                  #166.8
        vmovd     %r13d, %xmm2                                  #166.8
        vmovd     %r14d, %xmm3                                  #166.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #166.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #166.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #166.8
        vmovups   %xmm6, 2208(%rsp)                             #166.8[spill]
#       rand(void)
        call      rand                                          #167.22
                                # LOE rbx r12 eax
..B1.187:                       # Preds ..B1.25
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #167.22
                                # LOE rbx r12 r14d
..B1.26:                        # Preds ..B1.187
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #167.29
                                # LOE rbx r12 eax r14d
..B1.188:                       # Preds ..B1.26
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #167.29
                                # LOE rbx r12 r13d r14d
..B1.27:                        # Preds ..B1.188
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #167.36
                                # LOE rbx r12 eax r13d r14d
..B1.189:                       # Preds ..B1.27
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #167.36
                                # LOE rbx r12 r13d r14d r15d
..B1.28:                        # Preds ..B1.189
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #167.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #167.8
        vmovd     %r15d, %xmm1                                  #167.8
        vmovd     %r13d, %xmm2                                  #167.8
        vmovd     %r14d, %xmm3                                  #167.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #167.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #167.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #167.8
        vmovups   %xmm6, 2192(%rsp)                             #167.8[spill]
#       rand(void)
        call      rand                                          #168.22
                                # LOE rbx r12 eax
..B1.191:                       # Preds ..B1.29
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #168.22
                                # LOE rbx r12 r14d
..B1.30:                        # Preds ..B1.191
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #168.29
                                # LOE rbx r12 eax r14d
..B1.192:                       # Preds ..B1.30
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #168.29
                                # LOE rbx r12 r13d r14d
..B1.31:                        # Preds ..B1.192
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #168.36
                                # LOE rbx r12 eax r13d r14d
..B1.193:                       # Preds ..B1.31
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #168.36
                                # LOE rbx r12 r13d r14d r15d
..B1.32:                        # Preds ..B1.193
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #168.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.33:                        # Preds ..B1.32
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #168.8
        vmovd     %r15d, %xmm1                                  #168.8
        vmovd     %r13d, %xmm2                                  #168.8
        vmovd     %r14d, %xmm3                                  #168.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #168.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #168.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #168.8
        vmovups   %xmm6, 2176(%rsp)                             #168.8[spill]
#       rand(void)
        call      rand                                          #169.22
                                # LOE rbx r12 eax
..B1.195:                       # Preds ..B1.33
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #169.22
                                # LOE rbx r12 r14d
..B1.34:                        # Preds ..B1.195
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #169.29
                                # LOE rbx r12 eax r14d
..B1.196:                       # Preds ..B1.34
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #169.29
                                # LOE rbx r12 r13d r14d
..B1.35:                        # Preds ..B1.196
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #169.36
                                # LOE rbx r12 eax r13d r14d
..B1.197:                       # Preds ..B1.35
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #169.36
                                # LOE rbx r12 r13d r14d r15d
..B1.36:                        # Preds ..B1.197
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #169.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.37:                        # Preds ..B1.36
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #169.8
        vmovd     %r15d, %xmm1                                  #169.8
        vmovd     %r13d, %xmm2                                  #169.8
        vmovd     %r14d, %xmm3                                  #169.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #169.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #169.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #169.8
        vmovups   %xmm6, 2160(%rsp)                             #169.8[spill]
#       rand(void)
        call      rand                                          #170.22
                                # LOE rbx r12 eax
..B1.199:                       # Preds ..B1.37
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #170.22
                                # LOE rbx r12 r14d
..B1.38:                        # Preds ..B1.199
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #170.29
                                # LOE rbx r12 eax r14d
..B1.200:                       # Preds ..B1.38
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #170.29
                                # LOE rbx r12 r13d r14d
..B1.39:                        # Preds ..B1.200
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #170.36
                                # LOE rbx r12 eax r13d r14d
..B1.201:                       # Preds ..B1.39
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #170.36
                                # LOE rbx r12 r13d r14d r15d
..B1.40:                        # Preds ..B1.201
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #170.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.41:                        # Preds ..B1.40
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #170.8
        vmovd     %r15d, %xmm1                                  #170.8
        vmovd     %r13d, %xmm2                                  #170.8
        vmovd     %r14d, %xmm3                                  #170.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #170.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #170.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #170.8
        vmovups   %xmm6, 2144(%rsp)                             #170.8[spill]
#       rand(void)
        call      rand                                          #171.23
                                # LOE rbx r12 eax
..B1.203:                       # Preds ..B1.41
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #171.23
                                # LOE rbx r12 r14d
..B1.42:                        # Preds ..B1.203
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #171.30
                                # LOE rbx r12 eax r14d
..B1.204:                       # Preds ..B1.42
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #171.30
                                # LOE rbx r12 r13d r14d
..B1.43:                        # Preds ..B1.204
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #171.37
                                # LOE rbx r12 eax r13d r14d
..B1.205:                       # Preds ..B1.43
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #171.37
                                # LOE rbx r12 r13d r14d r15d
..B1.44:                        # Preds ..B1.205
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #171.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #171.9
        vmovd     %r15d, %xmm1                                  #171.9
        vmovd     %r13d, %xmm2                                  #171.9
        vmovd     %r14d, %xmm3                                  #171.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #171.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #171.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #171.9
        vmovups   %xmm6, 2128(%rsp)                             #171.9[spill]
#       rand(void)
        call      rand                                          #172.23
                                # LOE rbx r12 eax
..B1.207:                       # Preds ..B1.45
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #172.23
                                # LOE rbx r12 r14d
..B1.46:                        # Preds ..B1.207
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #172.30
                                # LOE rbx r12 eax r14d
..B1.208:                       # Preds ..B1.46
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #172.30
                                # LOE rbx r12 r13d r14d
..B1.47:                        # Preds ..B1.208
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #172.37
                                # LOE rbx r12 eax r13d r14d
..B1.209:                       # Preds ..B1.47
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #172.37
                                # LOE rbx r12 r13d r14d r15d
..B1.48:                        # Preds ..B1.209
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #172.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.49:                        # Preds ..B1.48
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #172.9
        vmovd     %r15d, %xmm1                                  #172.9
        vmovd     %r13d, %xmm2                                  #172.9
        vmovd     %r14d, %xmm3                                  #172.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #172.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #172.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #172.9
        vmovups   %xmm6, 2112(%rsp)                             #172.9[spill]
#       rand(void)
        call      rand                                          #173.23
                                # LOE rbx r12 eax
..B1.211:                       # Preds ..B1.49
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #173.23
                                # LOE rbx r12 r14d
..B1.50:                        # Preds ..B1.211
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #173.30
                                # LOE rbx r12 eax r14d
..B1.212:                       # Preds ..B1.50
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #173.30
                                # LOE rbx r12 r13d r14d
..B1.51:                        # Preds ..B1.212
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #173.37
                                # LOE rbx r12 eax r13d r14d
..B1.213:                       # Preds ..B1.51
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #173.37
                                # LOE rbx r12 r13d r14d r15d
..B1.52:                        # Preds ..B1.213
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #173.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.53:                        # Preds ..B1.52
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #173.9
        vmovd     %r15d, %xmm1                                  #173.9
        vmovd     %r13d, %xmm2                                  #173.9
        vmovd     %r14d, %xmm3                                  #173.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #173.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #173.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #173.9
        vmovups   %xmm6, 2096(%rsp)                             #173.9[spill]
#       rand(void)
        call      rand                                          #174.23
                                # LOE rbx r12 eax
..B1.215:                       # Preds ..B1.53
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #174.23
                                # LOE rbx r12 r14d
..B1.54:                        # Preds ..B1.215
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #174.30
                                # LOE rbx r12 eax r14d
..B1.216:                       # Preds ..B1.54
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #174.30
                                # LOE rbx r12 r13d r14d
..B1.55:                        # Preds ..B1.216
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #174.37
                                # LOE rbx r12 eax r13d r14d
..B1.217:                       # Preds ..B1.55
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #174.37
                                # LOE rbx r12 r13d r14d r15d
..B1.56:                        # Preds ..B1.217
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #174.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.57:                        # Preds ..B1.56
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #174.9
        vmovd     %r15d, %xmm1                                  #174.9
        vmovd     %r13d, %xmm2                                  #174.9
        vmovd     %r14d, %xmm3                                  #174.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #174.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #174.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #174.9
        vmovups   %xmm6, 2048(%rsp)                             #174.9[spill]
#       rand(void)
        call      rand                                          #175.23
                                # LOE rbx r12 eax
..B1.219:                       # Preds ..B1.57
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #175.23
                                # LOE rbx r12 r14d
..B1.58:                        # Preds ..B1.219
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #175.30
                                # LOE rbx r12 eax r14d
..B1.220:                       # Preds ..B1.58
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #175.30
                                # LOE rbx r12 r13d r14d
..B1.59:                        # Preds ..B1.220
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #175.37
                                # LOE rbx r12 eax r13d r14d
..B1.221:                       # Preds ..B1.59
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #175.37
                                # LOE rbx r12 r13d r14d r15d
..B1.60:                        # Preds ..B1.221
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #175.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.61:                        # Preds ..B1.60
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #175.9
        vmovd     %r15d, %xmm1                                  #175.9
        vmovd     %r13d, %xmm2                                  #175.9
        vmovd     %r14d, %xmm3                                  #175.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #175.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #175.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #175.9
        vmovups   %xmm6, 1904(%rsp)                             #175.9[spill]
#       rand(void)
        call      rand                                          #176.23
                                # LOE rbx r12 eax
..B1.223:                       # Preds ..B1.61
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #176.23
                                # LOE rbx r12 r14d
..B1.62:                        # Preds ..B1.223
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #176.30
                                # LOE rbx r12 eax r14d
..B1.224:                       # Preds ..B1.62
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #176.30
                                # LOE rbx r12 r13d r14d
..B1.63:                        # Preds ..B1.224
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #176.37
                                # LOE rbx r12 eax r13d r14d
..B1.225:                       # Preds ..B1.63
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #176.37
                                # LOE rbx r12 r13d r14d r15d
..B1.64:                        # Preds ..B1.225
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #176.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.65:                        # Preds ..B1.64
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #176.9
        vmovd     %r15d, %xmm1                                  #176.9
        vmovd     %r13d, %xmm2                                  #176.9
        vmovd     %r14d, %xmm3                                  #176.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #176.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #176.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #176.9
        vmovups   %xmm6, 1936(%rsp)                             #176.9[spill]
#       rand(void)
        call      rand                                          #177.23
                                # LOE rbx r12 eax
..B1.227:                       # Preds ..B1.65
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #177.23
                                # LOE rbx r12 r14d
..B1.66:                        # Preds ..B1.227
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #177.30
                                # LOE rbx r12 eax r14d
..B1.228:                       # Preds ..B1.66
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #177.30
                                # LOE rbx r12 r13d r14d
..B1.67:                        # Preds ..B1.228
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #177.37
                                # LOE rbx r12 eax r13d r14d
..B1.229:                       # Preds ..B1.67
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #177.37
                                # LOE rbx r12 r13d r14d r15d
..B1.68:                        # Preds ..B1.229
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #177.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.69:                        # Preds ..B1.68
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #177.9
        vmovd     %r15d, %xmm1                                  #177.9
        vmovd     %r13d, %xmm2                                  #177.9
        vmovd     %r14d, %xmm3                                  #177.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #177.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #177.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #177.9
        vmovups   %xmm6, 272(%rsp)                              #177.9[spill]
#       rand(void)
        call      rand                                          #179.22
                                # LOE rbx r12 eax
..B1.231:                       # Preds ..B1.69
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #179.22
                                # LOE rbx r12 r14d
..B1.70:                        # Preds ..B1.231
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #179.29
                                # LOE rbx r12 eax r14d
..B1.232:                       # Preds ..B1.70
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #179.29
                                # LOE rbx r12 r13d r14d
..B1.71:                        # Preds ..B1.232
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #179.36
                                # LOE rbx r12 eax r13d r14d
..B1.233:                       # Preds ..B1.71
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #179.36
                                # LOE rbx r12 r13d r14d r15d
..B1.72:                        # Preds ..B1.233
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #179.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.73:                        # Preds ..B1.72
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #179.8
        vmovd     %r15d, %xmm1                                  #179.8
        vmovd     %r13d, %xmm2                                  #179.8
        vmovd     %r14d, %xmm3                                  #179.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #179.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #179.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #179.8
        vmovups   %xmm6, 1808(%rsp)                             #179.8[spill]
#       rand(void)
        call      rand                                          #180.22
                                # LOE rbx r12 eax
..B1.235:                       # Preds ..B1.73
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #180.22
                                # LOE rbx r12 r14d
..B1.74:                        # Preds ..B1.235
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #180.29
                                # LOE rbx r12 eax r14d
..B1.236:                       # Preds ..B1.74
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #180.29
                                # LOE rbx r12 r13d r14d
..B1.75:                        # Preds ..B1.236
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #180.36
                                # LOE rbx r12 eax r13d r14d
..B1.237:                       # Preds ..B1.75
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #180.36
                                # LOE rbx r12 r13d r14d r15d
..B1.76:                        # Preds ..B1.237
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #180.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.77:                        # Preds ..B1.76
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #180.8
        vmovd     %r15d, %xmm1                                  #180.8
        vmovd     %r13d, %xmm2                                  #180.8
        vmovd     %r14d, %xmm3                                  #180.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #180.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #180.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #180.8
        vmovups   %xmm6, 1824(%rsp)                             #180.8[spill]
#       rand(void)
        call      rand                                          #181.22
                                # LOE rbx r12 eax
..B1.239:                       # Preds ..B1.77
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #181.22
                                # LOE rbx r12 r14d
..B1.78:                        # Preds ..B1.239
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #181.29
                                # LOE rbx r12 eax r14d
..B1.240:                       # Preds ..B1.78
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #181.29
                                # LOE rbx r12 r13d r14d
..B1.79:                        # Preds ..B1.240
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #181.36
                                # LOE rbx r12 eax r13d r14d
..B1.241:                       # Preds ..B1.79
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #181.36
                                # LOE rbx r12 r13d r14d r15d
..B1.80:                        # Preds ..B1.241
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #181.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.81:                        # Preds ..B1.80
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #181.8
        vmovd     %r15d, %xmm1                                  #181.8
        vmovd     %r13d, %xmm2                                  #181.8
        vmovd     %r14d, %xmm3                                  #181.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #181.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #181.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #181.8
        vmovups   %xmm6, 1840(%rsp)                             #181.8[spill]
#       rand(void)
        call      rand                                          #182.22
                                # LOE rbx r12 eax
..B1.243:                       # Preds ..B1.81
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #182.22
                                # LOE rbx r12 r14d
..B1.82:                        # Preds ..B1.243
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #182.29
                                # LOE rbx r12 eax r14d
..B1.244:                       # Preds ..B1.82
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #182.29
                                # LOE rbx r12 r13d r14d
..B1.83:                        # Preds ..B1.244
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #182.36
                                # LOE rbx r12 eax r13d r14d
..B1.245:                       # Preds ..B1.83
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #182.36
                                # LOE rbx r12 r13d r14d r15d
..B1.84:                        # Preds ..B1.245
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #182.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.85:                        # Preds ..B1.84
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #182.8
        vmovd     %r15d, %xmm1                                  #182.8
        vmovd     %r13d, %xmm2                                  #182.8
        vmovd     %r14d, %xmm3                                  #182.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #182.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #182.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #182.8
        vmovups   %xmm6, 1856(%rsp)                             #182.8[spill]
#       rand(void)
        call      rand                                          #183.22
                                # LOE rbx r12 eax
..B1.247:                       # Preds ..B1.85
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #183.22
                                # LOE rbx r12 r14d
..B1.86:                        # Preds ..B1.247
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.29
                                # LOE rbx r12 eax r14d
..B1.248:                       # Preds ..B1.86
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #183.29
                                # LOE rbx r12 r13d r14d
..B1.87:                        # Preds ..B1.248
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.36
                                # LOE rbx r12 eax r13d r14d
..B1.249:                       # Preds ..B1.87
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #183.36
                                # LOE rbx r12 r13d r14d r15d
..B1.88:                        # Preds ..B1.249
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.89:                        # Preds ..B1.88
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #183.8
        vmovd     %r15d, %xmm1                                  #183.8
        vmovd     %r13d, %xmm2                                  #183.8
        vmovd     %r14d, %xmm3                                  #183.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #183.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #183.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #183.8
        vmovups   %xmm6, 1872(%rsp)                             #183.8[spill]
#       rand(void)
        call      rand                                          #184.22
                                # LOE rbx r12 eax
..B1.251:                       # Preds ..B1.89
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #184.22
                                # LOE rbx r12 r14d
..B1.90:                        # Preds ..B1.251
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.29
                                # LOE rbx r12 eax r14d
..B1.252:                       # Preds ..B1.90
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #184.29
                                # LOE rbx r12 r13d r14d
..B1.91:                        # Preds ..B1.252
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.36
                                # LOE rbx r12 eax r13d r14d
..B1.253:                       # Preds ..B1.91
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #184.36
                                # LOE rbx r12 r13d r14d r15d
..B1.92:                        # Preds ..B1.253
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.93:                        # Preds ..B1.92
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #184.8
        vmovd     %r15d, %xmm1                                  #184.8
        vmovd     %r13d, %xmm2                                  #184.8
        vmovd     %r14d, %xmm3                                  #184.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #184.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #184.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #184.8
        vmovups   %xmm6, 1888(%rsp)                             #184.8[spill]
#       rand(void)
        call      rand                                          #185.22
                                # LOE rbx r12 eax
..B1.255:                       # Preds ..B1.93
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #185.22
                                # LOE rbx r12 r14d
..B1.94:                        # Preds ..B1.255
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.29
                                # LOE rbx r12 eax r14d
..B1.256:                       # Preds ..B1.94
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #185.29
                                # LOE rbx r12 r13d r14d
..B1.95:                        # Preds ..B1.256
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.36
                                # LOE rbx r12 eax r13d r14d
..B1.257:                       # Preds ..B1.95
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #185.36
                                # LOE rbx r12 r13d r14d r15d
..B1.96:                        # Preds ..B1.257
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.97:                        # Preds ..B1.96
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #185.8
        vmovd     %r15d, %xmm1                                  #185.8
        vmovd     %r13d, %xmm2                                  #185.8
        vmovd     %r14d, %xmm3                                  #185.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #185.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #185.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #185.8
        vmovups   %xmm6, 1920(%rsp)                             #185.8[spill]
#       rand(void)
        call      rand                                          #186.22
                                # LOE rbx r12 eax
..B1.259:                       # Preds ..B1.97
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #186.22
                                # LOE rbx r12 r14d
..B1.98:                        # Preds ..B1.259
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.29
                                # LOE rbx r12 eax r14d
..B1.260:                       # Preds ..B1.98
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #186.29
                                # LOE rbx r12 r13d r14d
..B1.99:                        # Preds ..B1.260
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.36
                                # LOE rbx r12 eax r13d r14d
..B1.261:                       # Preds ..B1.99
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #186.36
                                # LOE rbx r12 r13d r14d r15d
..B1.100:                       # Preds ..B1.261
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.101:                       # Preds ..B1.100
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #186.8
        vmovd     %r15d, %xmm1                                  #186.8
        vmovd     %r13d, %xmm2                                  #186.8
        vmovd     %r14d, %xmm3                                  #186.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #186.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #186.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #186.8
        vmovups   %xmm6, 1952(%rsp)                             #186.8[spill]
#       rand(void)
        call      rand                                          #187.22
                                # LOE rbx r12 eax
..B1.263:                       # Preds ..B1.101
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #187.22
                                # LOE rbx r12 r14d
..B1.102:                       # Preds ..B1.263
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.29
                                # LOE rbx r12 eax r14d
..B1.264:                       # Preds ..B1.102
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #187.29
                                # LOE rbx r12 r13d r14d
..B1.103:                       # Preds ..B1.264
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.36
                                # LOE rbx r12 eax r13d r14d
..B1.265:                       # Preds ..B1.103
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #187.36
                                # LOE rbx r12 r13d r14d r15d
..B1.104:                       # Preds ..B1.265
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.105:                       # Preds ..B1.104
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #187.8
        vmovd     %r15d, %xmm1                                  #187.8
        vmovd     %r13d, %xmm2                                  #187.8
        vmovd     %r14d, %xmm3                                  #187.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #187.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #187.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #187.8
        vmovups   %xmm6, 1968(%rsp)                             #187.8[spill]
#       rand(void)
        call      rand                                          #188.23
                                # LOE rbx r12 eax
..B1.267:                       # Preds ..B1.105
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #188.23
                                # LOE rbx r12 r14d
..B1.106:                       # Preds ..B1.267
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #188.30
                                # LOE rbx r12 eax r14d
..B1.268:                       # Preds ..B1.106
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #188.30
                                # LOE rbx r12 r13d r14d
..B1.107:                       # Preds ..B1.268
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #188.37
                                # LOE rbx r12 eax r13d r14d
..B1.269:                       # Preds ..B1.107
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #188.37
                                # LOE rbx r12 r13d r14d r15d
..B1.108:                       # Preds ..B1.269
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #188.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.109:                       # Preds ..B1.108
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #188.9
        vmovd     %r15d, %xmm1                                  #188.9
        vmovd     %r13d, %xmm2                                  #188.9
        vmovd     %r14d, %xmm3                                  #188.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #188.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #188.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #188.9
        vmovups   %xmm6, 1984(%rsp)                             #188.9[spill]
#       rand(void)
        call      rand                                          #189.23
                                # LOE rbx r12 eax
..B1.271:                       # Preds ..B1.109
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #189.23
                                # LOE rbx r12 r14d
..B1.110:                       # Preds ..B1.271
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.30
                                # LOE rbx r12 eax r14d
..B1.272:                       # Preds ..B1.110
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #189.30
                                # LOE rbx r12 r13d r14d
..B1.111:                       # Preds ..B1.272
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.37
                                # LOE rbx r12 eax r13d r14d
..B1.273:                       # Preds ..B1.111
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #189.37
                                # LOE rbx r12 r13d r14d r15d
..B1.112:                       # Preds ..B1.273
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.113:                       # Preds ..B1.112
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #189.9
        vmovd     %r15d, %xmm1                                  #189.9
        vmovd     %r13d, %xmm2                                  #189.9
        vmovd     %r14d, %xmm3                                  #189.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #189.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #189.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #189.9
        vmovups   %xmm6, 2000(%rsp)                             #189.9[spill]
#       rand(void)
        call      rand                                          #190.23
                                # LOE rbx r12 eax
..B1.275:                       # Preds ..B1.113
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #190.23
                                # LOE rbx r12 r14d
..B1.114:                       # Preds ..B1.275
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.30
                                # LOE rbx r12 eax r14d
..B1.276:                       # Preds ..B1.114
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #190.30
                                # LOE rbx r12 r13d r14d
..B1.115:                       # Preds ..B1.276
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.37
                                # LOE rbx r12 eax r13d r14d
..B1.277:                       # Preds ..B1.115
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #190.37
                                # LOE rbx r12 r13d r14d r15d
..B1.116:                       # Preds ..B1.277
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.117:                       # Preds ..B1.116
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #190.9
        vmovd     %r15d, %xmm1                                  #190.9
        vmovd     %r13d, %xmm2                                  #190.9
        vmovd     %r14d, %xmm3                                  #190.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #190.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #190.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #190.9
        vmovups   %xmm6, 2016(%rsp)                             #190.9[spill]
#       rand(void)
        call      rand                                          #191.23
                                # LOE rbx r12 eax
..B1.279:                       # Preds ..B1.117
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #191.23
                                # LOE rbx r12 r14d
..B1.118:                       # Preds ..B1.279
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #191.30
                                # LOE rbx r12 eax r14d
..B1.280:                       # Preds ..B1.118
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #191.30
                                # LOE rbx r12 r13d r14d
..B1.119:                       # Preds ..B1.280
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #191.37
                                # LOE rbx r12 eax r13d r14d
..B1.281:                       # Preds ..B1.119
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #191.37
                                # LOE rbx r12 r13d r14d r15d
..B1.120:                       # Preds ..B1.281
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #191.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.121:                       # Preds ..B1.120
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #191.9
        vmovd     %r15d, %xmm1                                  #191.9
        vmovd     %r13d, %xmm2                                  #191.9
        vmovd     %r14d, %xmm3                                  #191.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #191.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #191.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #191.9
        vmovups   %xmm6, 2032(%rsp)                             #191.9[spill]
#       rand(void)
        call      rand                                          #192.23
                                # LOE rbx r12 eax
..B1.283:                       # Preds ..B1.121
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #192.23
                                # LOE rbx r12 r14d
..B1.122:                       # Preds ..B1.283
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.30
                                # LOE rbx r12 eax r14d
..B1.284:                       # Preds ..B1.122
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #192.30
                                # LOE rbx r12 r13d r14d
..B1.123:                       # Preds ..B1.284
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.37
                                # LOE rbx r12 eax r13d r14d
..B1.285:                       # Preds ..B1.123
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #192.37
                                # LOE rbx r12 r13d r14d r15d
..B1.124:                       # Preds ..B1.285
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.125:                       # Preds ..B1.124
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #192.9
        vmovd     %r15d, %xmm1                                  #192.9
        vmovd     %r13d, %xmm2                                  #192.9
        vmovd     %r14d, %xmm3                                  #192.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #192.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #192.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #192.9
        vmovups   %xmm6, 2064(%rsp)                             #192.9[spill]
#       rand(void)
        call      rand                                          #193.23
                                # LOE rbx r12 eax
..B1.287:                       # Preds ..B1.125
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #193.23
                                # LOE rbx r12 r14d
..B1.126:                       # Preds ..B1.287
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.30
                                # LOE rbx r12 eax r14d
..B1.288:                       # Preds ..B1.126
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #193.30
                                # LOE rbx r12 r13d r14d
..B1.127:                       # Preds ..B1.288
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.37
                                # LOE rbx r12 eax r13d r14d
..B1.289:                       # Preds ..B1.127
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #193.37
                                # LOE rbx r12 r13d r14d r15d
..B1.128:                       # Preds ..B1.289
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.129:                       # Preds ..B1.128
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #193.9
        vmovd     %r15d, %xmm1                                  #193.9
        vmovd     %r13d, %xmm2                                  #193.9
        vmovd     %r14d, %xmm3                                  #193.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #193.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #193.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #193.9
        vmovups   %xmm6, 2080(%rsp)                             #193.9[spill]
#       rand(void)
        call      rand                                          #194.23
                                # LOE rbx r12 eax
..B1.291:                       # Preds ..B1.129
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #194.23
                                # LOE rbx r12 r15d
..B1.130:                       # Preds ..B1.291
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.30
                                # LOE rbx r12 eax r15d
..B1.292:                       # Preds ..B1.130
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #194.30
                                # LOE rbx r12 r14d r15d
..B1.131:                       # Preds ..B1.292
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.37
                                # LOE rbx r12 eax r14d r15d
..B1.293:                       # Preds ..B1.131
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #194.37
                                # LOE rbx r12 r13d r14d r15d
..B1.132:                       # Preds ..B1.293
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.44
                                # LOE rbx r12 eax r13d r14d r15d
..B1.294:                       # Preds ..B1.132
                                # Execution count [1.00e+00]
        movl      %eax, %edx                                    #194.44
                                # LOE rbx r12 edx r13d r14d r15d
..B1.133:                       # Preds ..B1.294
                                # Execution count [9.00e-01]
        vmovd     %edx, %xmm0                                   #194.9
        vmovd     %r13d, %xmm1                                  #194.9
        vmovd     %r14d, %xmm2                                  #194.9
        vmovd     %r15d, %xmm3                                  #194.9
        vmovups   2272(%rsp), %xmm7                             #198.17[spill]
        xorl      %eax, %eax                                    #196.3
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #194.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #194.9
        vpxor     2256(%rsp), %xmm7, %xmm8                      #198.17[spill]
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #194.9
        vpxor     %xmm9, %xmm8, %xmm0                           #198.17
        vmovups   %xmm6, 256(%rsp)                              #194.9[spill]
                                # LOE rbx r12 eax xmm0
..B1.134:                       # Preds ..B1.134 ..B1.133
                                # Execution count [2.50e+00]
        lea       (%rax,%rax), %edx                             #198.5
        incl      %eax                                          #196.3
        shlq      $4, %rdx                                      #198.5
        vmovdqu   %xmm0, (%rbx,%rdx)                            #198.5
        vmovdqu   %xmm0, 16(%rbx,%rdx)                          #198.5
        cmpl      $8000000, %eax                                #196.3
        jb        ..B1.134      # Prob 63%                      #196.3
                                # LOE rbx r12 eax xmm0
..B1.135:                       # Preds ..B1.134
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #200.3
        movl      $16, %esi                                     #200.3
        movl      $16000000, %edx                               #200.3
        movq      %r12, %rcx                                    #200.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #200.3
                                # LOE rbx r12
..B1.136:                       # Preds ..B1.135
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #203.3
        xorl      %eax, %eax                                    #203.3
..___tag_value_main.13:
#       printf(const char *__restrict__, ...)
        call      printf                                        #203.3
..___tag_value_main.14:
                                # LOE rbx r12
..B1.137:                       # Preds ..B1.136
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #203.27
#       fflush(FILE *)
        call      fflush                                        #203.27
                                # LOE rbx r12
..B1.138:                       # Preds ..B1.137
                                # Execution count [1.00e+00]
        rdtscp                                                   #204.11
        shlq      $32, %rdx                                     #204.11
        orq       %rdx, %rax                                    #204.11
                                # LOE rax rbx r12
..B1.295:                       # Preds ..B1.138
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #204.11
        xorl      %edx, %edx                                    #205.3
        xorl      %eax, %eax                                    #205.3
                                # LOE rbx r8 r12
..B1.139:                       # Preds ..B1.295
                                # Execution count [9.00e-01]
        vmovups   2272(%rsp), %xmm14                            #206.5[spill]
        vmovups   2256(%rsp), %xmm13                            #206.5[spill]
        vmovups   2224(%rsp), %xmm12                            #206.5[spill]
        vmovups   2240(%rsp), %xmm11                            #206.5[spill]
        vmovups   2208(%rsp), %xmm10                            #206.5[spill]
        vmovups   2192(%rsp), %xmm9                             #206.5[spill]
        vmovups   2176(%rsp), %xmm8                             #206.5[spill]
        vmovups   2160(%rsp), %xmm7                             #206.5[spill]
        vmovups   2144(%rsp), %xmm6                             #206.5[spill]
        vmovups   2128(%rsp), %xmm5                             #206.5[spill]
        vmovups   2112(%rsp), %xmm4                             #206.5[spill]
        vmovups   2096(%rsp), %xmm3                             #206.5[spill]
        vmovups   2048(%rsp), %xmm2                             #206.5[spill]
        vmovups   2064(%rsp), %xmm1                             #206.5[spill]
        vmovups   2080(%rsp), %xmm0                             #206.5[spill]
        vmovups   272(%rsp), %xmm15                             #206.5[spill]
        vpaddb    1808(%rsp), %xmm14, %xmm14                    #206.5[spill]
        vpaddb    1824(%rsp), %xmm13, %xmm13                    #206.5[spill]
        vpaddb    1840(%rsp), %xmm12, %xmm12                    #206.5[spill]
        vpaddb    1856(%rsp), %xmm11, %xmm11                    #206.5[spill]
        vpaddb    1872(%rsp), %xmm10, %xmm10                    #206.5[spill]
        vpaddb    1888(%rsp), %xmm9, %xmm9                      #206.5[spill]
        vpaddb    1920(%rsp), %xmm8, %xmm8                      #206.5[spill]
        vpaddb    1952(%rsp), %xmm7, %xmm7                      #206.5[spill]
        vpaddb    1968(%rsp), %xmm6, %xmm6                      #206.5[spill]
        vpaddb    1984(%rsp), %xmm5, %xmm5                      #206.5[spill]
        vpaddb    2000(%rsp), %xmm4, %xmm4                      #206.5[spill]
        vpaddb    2016(%rsp), %xmm3, %xmm3                      #206.5[spill]
        vpaddb    2032(%rsp), %xmm2, %xmm2                      #206.5[spill]
        vpaddb    1904(%rsp), %xmm1, %xmm1                      #206.5[spill]
        vpaddb    1936(%rsp), %xmm0, %xmm0                      #206.5[spill]
        vpaddb    256(%rsp), %xmm15, %xmm15                     #206.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.140:                       # Preds ..B1.140 ..B1.139
                                # Execution count [5.00e+00]
        incl      %edx                                          #205.3
        lea       (%rax,%rbx), %rsi                             #206.5
        vmovdqu   %xmm9, 80(%rsi)                               #206.5
        vmovdqu   %xmm8, 96(%rsi)                               #206.5
        vmovdqu   %xmm7, 112(%rsi)                              #206.5
        vmovdqu   %xmm6, 128(%rsi)                              #206.5
        vmovdqu   %xmm5, 144(%rsi)                              #206.5
        vmovdqu   %xmm4, 160(%rsi)                              #206.5
        vmovdqu   %xmm3, 176(%rsi)                              #206.5
        vmovdqu   %xmm2, 192(%rsi)                              #206.5
        vmovdqu   %xmm1, 208(%rsi)                              #206.5
        vmovdqu   %xmm0, 224(%rsi)                              #206.5
        vmovdqu   %xmm15, 240(%rsi)                             #206.5
        addq      $256, %rax                                    #205.3
        vmovdqu   %xmm14, (%rsi)                                #206.5
        vmovdqu   %xmm13, 16(%rsi)                              #206.5
        vmovdqu   %xmm12, 32(%rsi)                              #206.5
        vmovdqu   %xmm11, 48(%rsi)                              #206.5
        vmovdqu   %xmm10, 64(%rsi)                              #206.5
        cmpl      $1000000, %edx                                #205.3
        jb        ..B1.139      # Prob 82%                      #205.3
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.141:                       # Preds ..B1.140
                                # Execution count [1.00e+00]
        rdtscp                                                   #209.9
        shlq      $32, %rdx                                     #209.9
        orq       %rdx, %rax                                    #209.9
                                # LOE rax rbx r8 r12
..B1.142:                       # Preds ..B1.141
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #210.3
        movl      $.L_2__STRING.3, %edi                         #210.3
        movq      %rax, %rsi                                    #210.3
        xorl      %eax, %eax                                    #210.3
..___tag_value_main.15:
#       printf(const char *__restrict__, ...)
        call      printf                                        #210.3
..___tag_value_main.16:
                                # LOE rbx r12
..B1.143:                       # Preds ..B1.142
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #211.3
        movl      $16, %esi                                     #211.3
        movl      $16000000, %edx                               #211.3
        movq      %r12, %rcx                                    #211.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #211.3
                                # LOE rbx r12
..B1.144:                       # Preds ..B1.143
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.4, %edi                         #213.3
        xorl      %eax, %eax                                    #213.3
..___tag_value_main.17:
#       printf(const char *__restrict__, ...)
        call      printf                                        #213.3
..___tag_value_main.18:
                                # LOE rbx r12
..B1.145:                       # Preds ..B1.144
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #213.27
#       fflush(FILE *)
        call      fflush                                        #213.27
                                # LOE rbx r12
..B1.146:                       # Preds ..B1.145
                                # Execution count [1.00e+00]
        rdtscp                                                   #214.11
        shlq      $32, %rdx                                     #214.11
        orq       %rdx, %rax                                    #214.11
                                # LOE rax rbx r12
..B1.297:                       # Preds ..B1.146
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #214.11
        xorl      %edx, %edx                                    #215.3
        xorl      %eax, %eax                                    #215.3
                                # LOE rbx r8 r12
..B1.147:                       # Preds ..B1.297
                                # Execution count [9.00e-01]
        vmovups   272(%rsp), %xmm15                             #216.5[spill]
        vpxor     256(%rsp), %xmm15, %xmm7                      #216.5[spill]
        vmovups   2272(%rsp), %xmm8                             #216.5[spill]
        vmovups   2256(%rsp), %xmm9                             #216.5[spill]
        vmovups   2224(%rsp), %xmm10                            #216.5[spill]
        vmovups   2240(%rsp), %xmm11                            #216.5[spill]
        vmovups   2208(%rsp), %xmm12                            #216.5[spill]
        vmovdqu   %xmm7, 16(%rsp)                               #216.5[spill]
        vpxor     1808(%rsp), %xmm8, %xmm7                      #216.5[spill]
        vmovups   2192(%rsp), %xmm14                            #216.5[spill]
        vpxor     1824(%rsp), %xmm9, %xmm8                      #216.5[spill]
        vmovups   2176(%rsp), %xmm13                            #216.5[spill]
        vpxor     1840(%rsp), %xmm10, %xmm9                     #216.5[spill]
        vmovups   2160(%rsp), %xmm0                             #216.5[spill]
        vpxor     1856(%rsp), %xmm11, %xmm10                    #216.5[spill]
        vmovups   2144(%rsp), %xmm1                             #216.5[spill]
        vpxor     1872(%rsp), %xmm12, %xmm11                    #216.5[spill]
        vmovups   2128(%rsp), %xmm2                             #216.5[spill]
        vpxor     1888(%rsp), %xmm14, %xmm12                    #216.5[spill]
        vmovups   2112(%rsp), %xmm3                             #216.5[spill]
        vpxor     1920(%rsp), %xmm13, %xmm14                    #216.5[spill]
        vmovups   2096(%rsp), %xmm4                             #216.5[spill]
        vpxor     1952(%rsp), %xmm0, %xmm13                     #216.5[spill]
        vmovups   2048(%rsp), %xmm5                             #216.5[spill]
        vpxor     1968(%rsp), %xmm1, %xmm0                      #216.5[spill]
        vmovups   2064(%rsp), %xmm6                             #216.5[spill]
        vpxor     1984(%rsp), %xmm2, %xmm1                      #216.5[spill]
        vmovups   2080(%rsp), %xmm15                            #216.5[spill]
        vpxor     2000(%rsp), %xmm3, %xmm2                      #216.5[spill]
        vpxor     2016(%rsp), %xmm4, %xmm3                      #216.5[spill]
        vpxor     2032(%rsp), %xmm5, %xmm4                      #216.5[spill]
        vpxor     1904(%rsp), %xmm6, %xmm5                      #216.5[spill]
        vpxor     1936(%rsp), %xmm15, %xmm6                     #216.5[spill]
        vpxor     %xmm15, %xmm15, %xmm15                        #216.5
        vmovdqu   %xmm7, (%rsp)                                 #216.5[spill]
        vpxor     %xmm15, %xmm7, %xmm7                          #216.5
        vmovdqu   %xmm8, 192(%rsp)                              #216.5[spill]
        vpxor     %xmm7, %xmm8, %xmm8                           #216.5
        vmovdqu   %xmm9, 240(%rsp)                              #216.5[spill]
        vpxor     %xmm8, %xmm9, %xmm9                           #216.5
        vmovdqu   %xmm10, 176(%rsp)                             #216.5[spill]
        vpxor     %xmm9, %xmm10, %xmm10                         #216.5
        vmovdqu   %xmm11, 224(%rsp)                             #216.5[spill]
        vpxor     %xmm10, %xmm11, %xmm11                        #216.5
        vmovdqu   %xmm12, 208(%rsp)                             #216.5[spill]
        vpxor     %xmm11, %xmm12, %xmm12                        #216.5
        vmovdqu   %xmm14, 160(%rsp)                             #216.5[spill]
        vpxor     %xmm12, %xmm14, %xmm14                        #216.5
        vmovdqu   %xmm13, 144(%rsp)                             #216.5[spill]
        vpxor     %xmm14, %xmm13, %xmm13                        #216.5
        vpxor     %xmm13, %xmm0, %xmm15                         #216.5
        vmovdqu   %xmm0, 128(%rsp)                              #216.5[spill]
        vpxor     %xmm15, %xmm1, %xmm0                          #216.5
        vmovdqu   %xmm2, 96(%rsp)                               #216.5[spill]
        vpxor     %xmm0, %xmm2, %xmm2                           #216.5
        vmovdqu   %xmm1, 112(%rsp)                              #216.5[spill]
        vpxor     %xmm2, %xmm3, %xmm1                           #216.5
        vmovdqu   %xmm4, 64(%rsp)                               #216.5[spill]
        vpxor     %xmm1, %xmm4, %xmm4                           #216.5
        vmovdqu   %xmm3, 80(%rsp)                               #216.5[spill]
        vpxor     %xmm4, %xmm5, %xmm3                           #216.5
        vmovdqu   %xmm6, 32(%rsp)                               #216.5[spill]
        vpxor     %xmm3, %xmm6, %xmm6                           #216.5
        vmovdqu   %xmm5, 48(%rsp)                               #216.5[spill]
        vpxor     16(%rsp), %xmm6, %xmm5                        #216.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.148:                       # Preds ..B1.148 ..B1.147
                                # Execution count [5.00e+00]
        incl      %edx                                          #215.3
        lea       (%rax,%rbx), %rsi                             #216.5
        vmovdqu   %xmm12, 80(%rsi)                              #216.5
        vmovdqu   %xmm14, 96(%rsi)                              #216.5
        vmovdqu   %xmm13, 112(%rsi)                             #216.5
        vmovdqu   %xmm15, 128(%rsi)                             #216.5
        vmovdqu   %xmm0, 144(%rsi)                              #216.5
        vmovdqu   %xmm2, 160(%rsi)                              #216.5
        vmovdqu   %xmm1, 176(%rsi)                              #216.5
        vmovdqu   %xmm4, 192(%rsi)                              #216.5
        vmovdqu   %xmm3, 208(%rsi)                              #216.5
        vmovdqu   %xmm6, 224(%rsi)                              #216.5
        vmovdqu   %xmm5, 240(%rsi)                              #216.5
        addq      $256, %rax                                    #215.3
        vmovdqu   %xmm7, (%rsi)                                 #216.5
        vmovdqu   %xmm8, 16(%rsi)                               #216.5
        vmovdqu   %xmm9, 32(%rsi)                               #216.5
        vmovdqu   %xmm10, 48(%rsi)                              #216.5
        vmovdqu   %xmm11, 64(%rsi)                              #216.5
        cmpl      $1000000, %edx                                #215.3
        jb        ..B1.147      # Prob 82%                      #215.3
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.149:                       # Preds ..B1.148
                                # Execution count [1.00e+00]
        rdtscp                                                   #219.9
        shlq      $32, %rdx                                     #219.9
        orq       %rdx, %rax                                    #219.9
                                # LOE rax rbx r8 r12
..B1.150:                       # Preds ..B1.149
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #220.3
        movl      $.L_2__STRING.3, %edi                         #220.3
        movq      %rax, %rsi                                    #220.3
        xorl      %eax, %eax                                    #220.3
..___tag_value_main.19:
#       printf(const char *__restrict__, ...)
        call      printf                                        #220.3
..___tag_value_main.20:
                                # LOE rbx r12
..B1.151:                       # Preds ..B1.150
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #221.3
        movl      $16, %esi                                     #221.3
        movl      $16000000, %edx                               #221.3
        movq      %r12, %rcx                                    #221.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #221.3
                                # LOE rbx r12
..B1.152:                       # Preds ..B1.151
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.5, %edi                         #223.3
        xorl      %eax, %eax                                    #223.3
..___tag_value_main.21:
#       printf(const char *__restrict__, ...)
        call      printf                                        #223.3
..___tag_value_main.22:
                                # LOE rbx r12
..B1.153:                       # Preds ..B1.152
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #223.27
#       fflush(FILE *)
        call      fflush                                        #223.27
                                # LOE rbx r12
..B1.154:                       # Preds ..B1.153
                                # Execution count [1.00e+00]
        rdtscp                                                   #224.11
        shlq      $32, %rdx                                     #224.11
        orq       %rdx, %rax                                    #224.11
                                # LOE rax rbx r12
..B1.299:                       # Preds ..B1.154
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #224.11
        xorl      %edx, %edx                                    #225.14
        xorl      %eax, %eax                                    #225.14
                                # LOE rbx r8 r12
..B1.155:                       # Preds ..B1.299
                                # Execution count [9.00e-01]
        vmovups   2272(%rsp), %xmm11                            #226.5[spill]
        vmovups   2256(%rsp), %xmm5                             #226.5[spill]
        vpand     1808(%rsp), %xmm11, %xmm9                     #226.5[spill]
        vpand     1824(%rsp), %xmm5, %xmm7                      #226.5[spill]
        vmovups   2176(%rsp), %xmm6                             #226.5[spill]
        vmovups   2208(%rsp), %xmm11                            #226.5[spill]
        vmovups   2160(%rsp), %xmm5                             #226.5[spill]
        vmovups   2112(%rsp), %xmm0                             #226.5[spill]
        vpand     1920(%rsp), %xmm6, %xmm12                     #226.5[spill]
        vmovdqu   %xmm9, 304(%rsp)                              #226.5[spill]
        vmovdqu   %xmm7, 320(%rsp)                              #226.5[spill]
        vpand     1872(%rsp), %xmm11, %xmm14                    #226.5[spill]
        vmovups   2192(%rsp), %xmm9                             #226.5[spill]
        vpand     1952(%rsp), %xmm5, %xmm6                      #226.5[spill]
        vmovups   2128(%rsp), %xmm3                             #226.5[spill]
        vmovups   2224(%rsp), %xmm2                             #226.5[spill]
        vpand     2000(%rsp), %xmm0, %xmm7                      #226.5[spill]
        vmovups   2048(%rsp), %xmm11                            #226.5[spill]
        vmovups   2064(%rsp), %xmm5                             #226.5[spill]
        vpand     1888(%rsp), %xmm9, %xmm13                     #226.5[spill]
        vpand     1984(%rsp), %xmm3, %xmm15                     #226.5[spill]
        vpand     1840(%rsp), %xmm2, %xmm8                      #226.5[spill]
        vmovups   2240(%rsp), %xmm1                             #226.5[spill]
        vpand     2032(%rsp), %xmm11, %xmm9                     #226.5[spill]
        vpand     1904(%rsp), %xmm5, %xmm3                      #226.5[spill]
        vmovdqu   %xmm7, 384(%rsp)                              #226.5[spill]
        vmovups   2096(%rsp), %xmm2                             #226.5[spill]
        vmovdqu   176(%rsp), %xmm7                              #226.5[spill]
        vmovdqu   224(%rsp), %xmm11                             #226.5[spill]
        vpand     1856(%rsp), %xmm1, %xmm10                     #226.5[spill]
        vmovdqu   %xmm3, 432(%rsp)                              #226.5[spill]
        vpand     2016(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vmovdqu   240(%rsp), %xmm3                              #226.5[spill]
        vmovdqu   %xmm9, 416(%rsp)                              #226.5[spill]
        vpand     %xmm7, %xmm11, %xmm9                          #226.5
        vmovdqu   %xmm15, 368(%rsp)                             #226.5[spill]
        vpand     %xmm8, %xmm9, %xmm5                           #226.5
        vmovdqu   %xmm1, 400(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm9, %xmm1                           #226.5
        vmovups   2080(%rsp), %xmm15                            #226.5[spill]
        vpand     %xmm3, %xmm7, %xmm2                           #226.5
        vmovdqu   208(%rsp), %xmm9                              #226.5[spill]
        vpand     1936(%rsp), %xmm15, %xmm0                     #226.5[spill]
        vpand     %xmm11, %xmm9, %xmm15                         #226.5
        vmovdqu   %xmm1, 480(%rsp)                              #226.5[spill]
        vpand     %xmm7, %xmm15, %xmm1                          #226.5
        vmovdqu   %xmm5, 496(%rsp)                              #226.5[spill]
        vpand     %xmm8, %xmm1, %xmm5                           #226.5
        vmovdqu   %xmm5, 544(%rsp)                              #226.5[spill]
        vmovdqu   160(%rsp), %xmm5                              #226.5[spill]
        vmovdqu   %xmm0, 448(%rsp)                              #226.5[spill]
        vpand     %xmm10, %xmm15, %xmm0                         #226.5
        vpand     %xmm9, %xmm5, %xmm15                          #226.5
        vmovdqu   %xmm2, 464(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm1, %xmm2                           #226.5
        vpand     %xmm11, %xmm15, %xmm1                         #226.5
        vmovdqu   %xmm2, 528(%rsp)                              #226.5[spill]
        vpand     %xmm14, %xmm15, %xmm2                         #226.5
        vpand     %xmm10, %xmm1, %xmm15                         #226.5
        vmovdqu   %xmm2, 560(%rsp)                              #226.5[spill]
        vpand     %xmm7, %xmm1, %xmm2                           #226.5
        vmovdqu   %xmm15, 576(%rsp)                             #226.5[spill]
        vpand     %xmm8, %xmm2, %xmm1                           #226.5
        vmovdqu   144(%rsp), %xmm15                             #226.5[spill]
        vmovdqu   %xmm0, 512(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm2, %xmm0                           #226.5
        vmovdqu   %xmm0, 592(%rsp)                              #226.5[spill]
        vpand     %xmm5, %xmm15, %xmm0                          #226.5
        vpand     %xmm9, %xmm0, %xmm2                           #226.5
        vmovdqu   %xmm1, 608(%rsp)                              #226.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #226.5
        vpand     %xmm11, %xmm2, %xmm0                          #226.5
        vpand     %xmm14, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm1, 624(%rsp)                              #226.5[spill]
        vpand     %xmm7, %xmm0, %xmm1                           #226.5
        vmovdqu   %xmm2, 640(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm1, %xmm2                           #226.5
        vpand     %xmm8, %xmm1, %xmm1                           #226.5
        vpand     %xmm10, %xmm0, %xmm0                          #226.5
        vmovdqu   %xmm1, 688(%rsp)                              #226.5[spill]
        vmovdqu   128(%rsp), %xmm1                              #226.5[spill]
        vmovdqu   %xmm0, 656(%rsp)                              #226.5[spill]
        vpand     %xmm15, %xmm1, %xmm0                          #226.5
        vmovdqu   %xmm2, 672(%rsp)                              #226.5[spill]
        vpand     %xmm5, %xmm0, %xmm2                           #226.5
        vpand     %xmm12, %xmm0, %xmm0                          #226.5
        vmovdqu   %xmm0, 704(%rsp)                              #226.5[spill]
        vpand     %xmm9, %xmm2, %xmm0                           #226.5
        vpand     %xmm13, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 720(%rsp)                              #226.5[spill]
        vpand     %xmm11, %xmm0, %xmm2                          #226.5
        vpand     %xmm14, %xmm0, %xmm0                          #226.5
        vmovdqu   %xmm0, 736(%rsp)                              #226.5[spill]
        vpand     %xmm7, %xmm2, %xmm0                           #226.5
        vpand     %xmm10, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 752(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm0, %xmm2                           #226.5
        vpand     %xmm8, %xmm0, %xmm0                           #226.5
        vmovdqu   %xmm0, 784(%rsp)                              #226.5[spill]
        vmovdqu   112(%rsp), %xmm0                              #226.5[spill]
        vmovdqu   %xmm2, 768(%rsp)                              #226.5[spill]
        vpand     %xmm1, %xmm0, %xmm2                           #226.5
        vpand     %xmm15, %xmm2, %xmm15                         #226.5
        vpand     %xmm6, %xmm2, %xmm2                           #226.5
        vmovdqu   %xmm2, 800(%rsp)                              #226.5[spill]
        vpand     %xmm5, %xmm15, %xmm2                          #226.5
        vpand     %xmm12, %xmm15, %xmm15                        #226.5
        vmovdqu   %xmm15, 816(%rsp)                             #226.5[spill]
        vpand     %xmm9, %xmm2, %xmm15                          #226.5
        vpand     %xmm13, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 832(%rsp)                              #226.5[spill]
        vpand     %xmm11, %xmm15, %xmm2                         #226.5
        vpand     %xmm14, %xmm15, %xmm15                        #226.5
        vmovdqu   %xmm15, 848(%rsp)                             #226.5[spill]
        vpand     %xmm7, %xmm2, %xmm15                          #226.5
        vpand     %xmm10, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 864(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm15, %xmm2                          #226.5
        vpand     %xmm8, %xmm15, %xmm15                         #226.5
        vmovdqu   %xmm15, 896(%rsp)                             #226.5[spill]
        vmovdqu   96(%rsp), %xmm15                              #226.5[spill]
        vmovups   2144(%rsp), %xmm4                             #226.5[spill]
        vmovdqu   %xmm2, 880(%rsp)                              #226.5[spill]
        vpand     %xmm0, %xmm15, %xmm2                          #226.5
        vpand     1968(%rsp), %xmm4, %xmm4                      #226.5[spill]
        vpand     %xmm1, %xmm2, %xmm1                           #226.5
        vpand     %xmm4, %xmm2, %xmm2                           #226.5
        vmovdqu   %xmm2, 912(%rsp)                              #226.5[spill]
        vpand     144(%rsp), %xmm1, %xmm2                       #226.5[spill]
        vpand     %xmm6, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 928(%rsp)                              #226.5[spill]
        vpand     %xmm5, %xmm2, %xmm1                           #226.5
        vpand     %xmm12, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 944(%rsp)                              #226.5[spill]
        vpand     %xmm9, %xmm1, %xmm2                           #226.5
        vpand     %xmm13, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 960(%rsp)                              #226.5[spill]
        vpand     %xmm11, %xmm2, %xmm1                          #226.5
        vpand     %xmm14, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 976(%rsp)                              #226.5[spill]
        vpand     %xmm7, %xmm1, %xmm2                           #226.5
        vpand     %xmm10, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 992(%rsp)                              #226.5[spill]
        vpand     %xmm3, %xmm2, %xmm1                           #226.5
        vpand     %xmm8, %xmm2, %xmm2                           #226.5
        vmovdqu   %xmm2, 1024(%rsp)                             #226.5[spill]
        vmovdqu   80(%rsp), %xmm2                               #226.5[spill]
        vmovdqu   %xmm1, 1008(%rsp)                             #226.5[spill]
        vpand     %xmm15, %xmm2, %xmm1                          #226.5
        vpand     %xmm0, %xmm1, %xmm15                          #226.5
        vmovdqu   368(%rsp), %xmm0                              #226.5[spill]
        vpand     %xmm0, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1040(%rsp)                             #226.5[spill]
        vpand     128(%rsp), %xmm15, %xmm1                      #226.5[spill]
        vpand     %xmm4, %xmm15, %xmm15                         #226.5
        vmovdqu   %xmm15, 1056(%rsp)                            #226.5[spill]
        vpand     144(%rsp), %xmm1, %xmm15                      #226.5[spill]
        vpand     %xmm6, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1072(%rsp)                             #226.5[spill]
        vpand     %xmm5, %xmm15, %xmm1                          #226.5
        vpand     %xmm12, %xmm15, %xmm15                        #226.5
        vmovdqu   %xmm15, 1088(%rsp)                            #226.5[spill]
        vpand     %xmm9, %xmm1, %xmm15                          #226.5
        vpand     %xmm13, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 1104(%rsp)                             #226.5[spill]
        vpand     %xmm11, %xmm15, %xmm1                         #226.5
        vpand     %xmm14, %xmm15, %xmm15                        #226.5
        vmovdqu   %xmm15, 1120(%rsp)                            #226.5[spill]
        vpand     %xmm7, %xmm1, %xmm15                          #226.5
        vpand     64(%rsp), %xmm2, %xmm2                        #226.5[spill]
        vpand     %xmm10, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 1136(%rsp)                             #226.5[spill]
        vpand     %xmm3, %xmm15, %xmm1                          #226.5
        vpand     %xmm8, %xmm15, %xmm15                         #226.5
        vmovdqu   %xmm15, 1168(%rsp)                            #226.5[spill]
        vmovdqu   384(%rsp), %xmm15                             #226.5[spill]
        vmovdqu   %xmm1, 1152(%rsp)                             #226.5[spill]
        vpand     96(%rsp), %xmm2, %xmm1                        #226.5[spill]
        vpand     %xmm15, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 1184(%rsp)                             #226.5[spill]
        vpand     112(%rsp), %xmm1, %xmm2                       #226.5[spill]
        vpand     %xmm0, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1200(%rsp)                             #226.5[spill]
        vpand     128(%rsp), %xmm2, %xmm1                       #226.5[spill]
        vpand     %xmm4, %xmm2, %xmm2                           #226.5
        vmovdqu   %xmm2, 1216(%rsp)                             #226.5[spill]
        vpand     144(%rsp), %xmm1, %xmm2                       #226.5[spill]
        vpand     %xmm6, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1232(%rsp)                             #226.5[spill]
        vpand     %xmm5, %xmm2, %xmm1                           #226.5
        vpand     %xmm12, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 1248(%rsp)                             #226.5[spill]
        vpand     %xmm9, %xmm1, %xmm2                           #226.5
        vpand     %xmm13, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 1264(%rsp)                             #226.5[spill]
        vpand     %xmm11, %xmm2, %xmm1                          #226.5
        vpand     %xmm14, %xmm2, %xmm2                          #226.5
        vmovdqu   %xmm2, 1280(%rsp)                             #226.5[spill]
        vpand     %xmm7, %xmm1, %xmm2                           #226.5
        vpand     %xmm10, %xmm1, %xmm1                          #226.5
        vpand     %xmm3, %xmm2, %xmm3                           #226.5
        vmovdqu   %xmm1, 1296(%rsp)                             #226.5[spill]
        vpand     %xmm8, %xmm2, %xmm2                           #226.5
        vmovdqu   48(%rsp), %xmm1                               #226.5[spill]
        vpand     64(%rsp), %xmm1, %xmm1                        #226.5[spill]
        vmovdqu   %xmm2, 1328(%rsp)                             #226.5[spill]
        vmovdqu   400(%rsp), %xmm2                              #226.5[spill]
        vmovdqu   %xmm3, 1312(%rsp)                             #226.5[spill]
        vpand     80(%rsp), %xmm1, %xmm3                        #226.5[spill]
        vpand     %xmm2, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1344(%rsp)                             #226.5[spill]
        vpand     96(%rsp), %xmm3, %xmm1                        #226.5[spill]
        vpand     %xmm15, %xmm3, %xmm3                          #226.5
        vmovdqu   %xmm3, 1360(%rsp)                             #226.5[spill]
        vpand     112(%rsp), %xmm1, %xmm3                       #226.5[spill]
        vpand     %xmm0, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1376(%rsp)                             #226.5[spill]
        vpand     128(%rsp), %xmm3, %xmm1                       #226.5[spill]
        vpand     %xmm4, %xmm3, %xmm3                           #226.5
        vmovdqu   %xmm3, 1392(%rsp)                             #226.5[spill]
        vpand     144(%rsp), %xmm1, %xmm3                       #226.5[spill]
        vpand     %xmm6, %xmm1, %xmm1                           #226.5
        vmovdqu   %xmm1, 1408(%rsp)                             #226.5[spill]
        vpand     %xmm5, %xmm3, %xmm1                           #226.5
        vpand     %xmm12, %xmm3, %xmm3                          #226.5
        vmovdqu   %xmm3, 1424(%rsp)                             #226.5[spill]
        vpand     %xmm9, %xmm1, %xmm3                           #226.5
        vpand     %xmm13, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 1440(%rsp)                             #226.5[spill]
        vpand     %xmm11, %xmm3, %xmm1                          #226.5
        vpand     %xmm14, %xmm3, %xmm3                          #226.5
        vmovdqu   %xmm3, 1456(%rsp)                             #226.5[spill]
        vpand     %xmm7, %xmm1, %xmm3                           #226.5
        vpand     %xmm10, %xmm1, %xmm1                          #226.5
        vmovdqu   %xmm1, 1472(%rsp)                             #226.5[spill]
        vpand     240(%rsp), %xmm3, %xmm1                       #226.5[spill]
        vmovdqu   %xmm1, 1488(%rsp)                             #226.5[spill]
        vmovdqu   32(%rsp), %xmm1                               #226.5[spill]
        vmovdqu   %xmm8, 336(%rsp)                              #226.5[spill]
        vpand     %xmm8, %xmm3, %xmm8                           #226.5
        vpand     48(%rsp), %xmm1, %xmm3                        #226.5[spill]
        vmovdqu   %xmm8, 1504(%rsp)                             #226.5[spill]
        vpand     416(%rsp), %xmm3, %xmm8                       #226.5[spill]
        vpand     64(%rsp), %xmm3, %xmm1                        #226.5[spill]
        vmovdqu   %xmm8, 1520(%rsp)                             #226.5[spill]
        vpand     %xmm2, %xmm1, %xmm2                           #226.5
        vpand     80(%rsp), %xmm1, %xmm8                        #226.5[spill]
        vmovdqu   %xmm2, 1536(%rsp)                             #226.5[spill]
        vpand     %xmm15, %xmm8, %xmm15                         #226.5
        vpand     96(%rsp), %xmm8, %xmm2                        #226.5[spill]
        vpand     112(%rsp), %xmm2, %xmm1                       #226.5[spill]
        vpand     %xmm0, %xmm2, %xmm0                           #226.5
        vmovdqu   %xmm4, 352(%rsp)                              #226.5[spill]
        vpand     %xmm4, %xmm1, %xmm4                           #226.5
        vmovdqu   %xmm4, 1584(%rsp)                             #226.5[spill]
        vpand     128(%rsp), %xmm1, %xmm2                       #226.5[spill]
        vmovdqu   144(%rsp), %xmm4                              #226.5[spill]
        vpand     %xmm6, %xmm2, %xmm3                           #226.5
        vmovdqu   %xmm15, 1552(%rsp)                            #226.5[spill]
        vpand     %xmm4, %xmm2, %xmm15                          #226.5
        vpand     %xmm5, %xmm15, %xmm8                          #226.5
        vpand     %xmm9, %xmm8, %xmm1                           #226.5
        vpand     %xmm13, %xmm8, %xmm2                          #226.5
        vmovdqu   %xmm0, 1568(%rsp)                             #226.5[spill]
        vpand     %xmm12, %xmm15, %xmm0                         #226.5
        vpand     %xmm11, %xmm1, %xmm15                         #226.5
        vmovdqu   %xmm3, 1600(%rsp)                             #226.5[spill]
        vpand     %xmm14, %xmm1, %xmm3                          #226.5
        vmovdqu   %xmm3, 1648(%rsp)                             #226.5[spill]
        vpand     %xmm7, %xmm15, %xmm3                          #226.5
        vmovdqu   240(%rsp), %xmm1                              #226.5[spill]
        vmovdqu   %xmm0, 1616(%rsp)                             #226.5[spill]
        vpand     %xmm10, %xmm15, %xmm0                         #226.5
        vmovdqu   %xmm2, 1632(%rsp)                             #226.5[spill]
        vpand     %xmm1, %xmm3, %xmm8                           #226.5
        vmovdqu   %xmm0, 1664(%rsp)                             #226.5[spill]
        vmovdqu   %xmm8, 1680(%rsp)                             #226.5[spill]
        vmovdqu   336(%rsp), %xmm2                              #226.5[spill]
        vmovdqu   304(%rsp), %xmm0                              #226.5[spill]
        vpand     %xmm2, %xmm3, %xmm15                          #226.5
        vmovdqu   192(%rsp), %xmm8                              #226.5[spill]
        vmovdqu   %xmm15, 1696(%rsp)                            #226.5[spill]
        vpxor     %xmm0, %xmm8, %xmm3                           #226.5
        vmovdqu   %xmm3, 256(%rsp)                              #226.5[spill]
        vpand     %xmm0, %xmm8, %xmm3                           #226.5
        vmovdqu   320(%rsp), %xmm15                             #226.5[spill]
        vpor      %xmm3, %xmm15, %xmm3                          #226.5
        vpxor     %xmm3, %xmm1, %xmm3                           #226.5
        vmovdqu   %xmm3, 272(%rsp)                              #226.5[spill]
        vpand     %xmm15, %xmm1, %xmm3                          #226.5
        vpand     %xmm8, %xmm1, %xmm1                           #226.5
        vpor      %xmm3, %xmm2, %xmm3                           #226.5
        vpand     %xmm0, %xmm1, %xmm1                           #226.5
        vpor      %xmm1, %xmm3, %xmm3                           #226.5
        vpxor     %xmm3, %xmm7, %xmm1                           #226.5
        vpand     %xmm2, %xmm7, %xmm7                           #226.5
        vpor      %xmm7, %xmm10, %xmm7                          #226.5
        vpand     %xmm10, %xmm11, %xmm10                        #226.5
        vpor      %xmm10, %xmm14, %xmm2                         #226.5
        vpand     %xmm14, %xmm9, %xmm14                         #226.5
        vpor      496(%rsp), %xmm2, %xmm10                      #226.5[spill]
        vpor      %xmm14, %xmm13, %xmm2                         #226.5
        vpand     %xmm13, %xmm5, %xmm13                         #226.5
        vmovdqu   %xmm1, 288(%rsp)                              #226.5[spill]
        vpor      512(%rsp), %xmm2, %xmm1                       #226.5[spill]
        vpor      %xmm13, %xmm12, %xmm2                         #226.5
        vpand     %xmm12, %xmm4, %xmm12                         #226.5
        vpor      544(%rsp), %xmm1, %xmm14                      #226.5[spill]
        vpor      560(%rsp), %xmm2, %xmm1                       #226.5[spill]
        vpor      %xmm12, %xmm6, %xmm2                          #226.5
        vpor      576(%rsp), %xmm1, %xmm3                       #226.5[spill]
        vpor      624(%rsp), %xmm2, %xmm1                       #226.5[spill]
        vpor      640(%rsp), %xmm1, %xmm13                      #226.5[spill]
        vpor      656(%rsp), %xmm13, %xmm12                     #226.5[spill]
        vpor      688(%rsp), %xmm12, %xmm13                     #226.5[spill]
        vmovdqu   128(%rsp), %xmm12                             #226.5[spill]
        vmovdqu   352(%rsp), %xmm1                              #226.5[spill]
        vpand     %xmm6, %xmm12, %xmm6                          #226.5
        vpor      %xmm6, %xmm1, %xmm2                           #226.5
        vpor      704(%rsp), %xmm2, %xmm6                       #226.5[spill]
        vpor      720(%rsp), %xmm6, %xmm2                       #226.5[spill]
        vpor      736(%rsp), %xmm2, %xmm6                       #226.5[spill]
        vpor      752(%rsp), %xmm6, %xmm2                       #226.5[spill]
        vpor      784(%rsp), %xmm2, %xmm6                       #226.5[spill]
        vpand     112(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vmovdqu   368(%rsp), %xmm2                              #226.5[spill]
        vpor      %xmm1, %xmm2, %xmm1                           #226.5
        vpor      800(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vpor      816(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vpor      832(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vpor      848(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vpor      864(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vpor      896(%rsp), %xmm1, %xmm1                       #226.5[spill]
        vmovdqu   %xmm1, 1712(%rsp)                             #226.5[spill]
        vpand     96(%rsp), %xmm2, %xmm2                        #226.5[spill]
        vmovdqu   384(%rsp), %xmm1                              #226.5[spill]
        vpor      %xmm2, %xmm1, %xmm2                           #226.5
        vpor      912(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vpor      928(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vpor      944(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vpor      960(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vpor      976(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vpor      992(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vpor      1024(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vmovdqu   %xmm2, 1728(%rsp)                             #226.5[spill]
        vpand     80(%rsp), %xmm1, %xmm1                        #226.5[spill]
        vmovdqu   400(%rsp), %xmm2                              #226.5[spill]
        vpor      %xmm1, %xmm2, %xmm1                           #226.5
        vpor      1040(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1056(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1072(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1088(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1104(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1120(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1136(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1168(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vmovdqu   %xmm1, 1744(%rsp)                             #226.5[spill]
        vpand     64(%rsp), %xmm2, %xmm2                        #226.5[spill]
        vmovdqu   416(%rsp), %xmm1                              #226.5[spill]
        vpor      %xmm2, %xmm1, %xmm2                           #226.5
        vpor      1184(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1200(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1216(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1232(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1248(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1264(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1280(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1296(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vpor      1328(%rsp), %xmm2, %xmm2                      #226.5[spill]
        vmovdqu   %xmm2, 1760(%rsp)                             #226.5[spill]
        vpand     48(%rsp), %xmm1, %xmm1                        #226.5[spill]
        vmovdqu   432(%rsp), %xmm2                              #226.5[spill]
        vpor      %xmm1, %xmm2, %xmm1                           #226.5
        vpor      1344(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1360(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1376(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1392(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1408(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1424(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1440(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1456(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      1472(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpand     32(%rsp), %xmm2, %xmm2                        #226.5[spill]
        vpor      1504(%rsp), %xmm1, %xmm1                      #226.5[spill]
        vpor      448(%rsp), %xmm2, %xmm2                       #226.5[spill]
        vmovdqu   %xmm1, 1776(%rsp)                             #226.5[spill]
        vpor      1520(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vpor      1536(%rsp), %xmm1, %xmm2                      #226.5[spill]
        vpor      1552(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vpor      1568(%rsp), %xmm1, %xmm2                      #226.5[spill]
        vpor      1584(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vpor      1600(%rsp), %xmm1, %xmm2                      #226.5[spill]
        vpor      1616(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vpor      1632(%rsp), %xmm1, %xmm2                      #226.5[spill]
        vpor      1648(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vpor      1664(%rsp), %xmm1, %xmm2                      #226.5[spill]
        vpor      1696(%rsp), %xmm2, %xmm1                      #226.5[spill]
        vmovdqu   464(%rsp), %xmm2                              #226.5[spill]
        vmovdqu   %xmm1, 1792(%rsp)                             #226.5[spill]
        vpand     %xmm15, %xmm2, %xmm1                          #226.5
        vpand     %xmm8, %xmm2, %xmm2                           #226.5
        vpor      %xmm1, %xmm7, %xmm7                           #226.5
        vpand     %xmm0, %xmm2, %xmm2                           #226.5
        vpor      %xmm2, %xmm7, %xmm7                           #226.5
        vmovdqu   480(%rsp), %xmm2                              #226.5[spill]
        vpxor     %xmm7, %xmm11, %xmm7                          #226.5
        vpand     %xmm15, %xmm2, %xmm11                         #226.5
        vpor      %xmm11, %xmm10, %xmm1                         #226.5
        vpand     %xmm8, %xmm2, %xmm10                          #226.5
        vpand     %xmm0, %xmm10, %xmm2                          #226.5
        vpor      %xmm2, %xmm1, %xmm11                          #226.5
        vmovdqu   528(%rsp), %xmm1                              #226.5[spill]
        vpxor     %xmm11, %xmm9, %xmm2                          #226.5
        vpand     %xmm15, %xmm1, %xmm9                          #226.5
        vpor      %xmm9, %xmm14, %xmm11                         #226.5
        vpand     %xmm8, %xmm1, %xmm14                          #226.5
        vpand     %xmm0, %xmm14, %xmm1                          #226.5
        vpor      %xmm1, %xmm11, %xmm10                         #226.5
        vmovdqu   592(%rsp), %xmm11                             #226.5[spill]
        vpxor     %xmm10, %xmm5, %xmm1                          #226.5
        vpor      608(%rsp), %xmm3, %xmm3                       #226.5[spill]
        vpand     %xmm15, %xmm11, %xmm5                         #226.5
        vpand     %xmm8, %xmm11, %xmm10                         #226.5
        vpor      %xmm5, %xmm3, %xmm9                           #226.5
        vpand     %xmm0, %xmm10, %xmm5                          #226.5
        vmovdqu   672(%rsp), %xmm10                             #226.5[spill]
        vpor      %xmm5, %xmm9, %xmm3                           #226.5
        vpxor     %xmm3, %xmm4, %xmm11                          #226.5
        vpand     %xmm15, %xmm10, %xmm4                         #226.5
        vpand     %xmm8, %xmm10, %xmm9                          #226.5
        vpor      %xmm4, %xmm13, %xmm5                          #226.5
        vpand     %xmm0, %xmm9, %xmm4                           #226.5
        vpor      %xmm4, %xmm5, %xmm3                           #226.5
        vpxor     %xmm3, %xmm12, %xmm10                         #226.5
        vmovdqu   768(%rsp), %xmm12                             #226.5[spill]
        vpand     %xmm15, %xmm12, %xmm13                        #226.5
        vmovdqu   880(%rsp), %xmm4                              #226.5[spill]
        vpor      %xmm13, %xmm6, %xmm14                         #226.5
        vpand     %xmm8, %xmm12, %xmm6                          #226.5
        vpand     %xmm15, %xmm4, %xmm5                          #226.5
        vpand     %xmm8, %xmm4, %xmm3                           #226.5
        vpand     %xmm0, %xmm6, %xmm9                           #226.5
        vmovdqu   1008(%rsp), %xmm4                             #226.5[spill]
        vpand     %xmm0, %xmm3, %xmm12                          #226.5
        vpor      1712(%rsp), %xmm5, %xmm13                     #226.5[spill]
        vpand     %xmm15, %xmm4, %xmm5                          #226.5
        vpand     %xmm8, %xmm4, %xmm3                           #226.5
        vpor      %xmm9, %xmm14, %xmm6                          #226.5
        vpor      %xmm12, %xmm13, %xmm14                        #226.5
        vpand     %xmm0, %xmm3, %xmm12                          #226.5
        vpor      1728(%rsp), %xmm5, %xmm13                     #226.5[spill]
        vmovdqu   1152(%rsp), %xmm3                             #226.5[spill]
        vpxor     112(%rsp), %xmm6, %xmm9                       #226.5[spill]
        vpand     %xmm15, %xmm3, %xmm4                          #226.5
        vpxor     96(%rsp), %xmm14, %xmm6                       #226.5[spill]
        vpor      %xmm12, %xmm13, %xmm14                        #226.5
        vpand     %xmm8, %xmm3, %xmm13                          #226.5
        vpxor     80(%rsp), %xmm14, %xmm5                       #226.5[spill]
        vpand     %xmm0, %xmm13, %xmm14                         #226.5
        vpor      1744(%rsp), %xmm4, %xmm12                     #226.5[spill]
        vmovdqu   1312(%rsp), %xmm13                            #226.5[spill]
        vpor      %xmm14, %xmm12, %xmm4                         #226.5
        vpand     %xmm15, %xmm13, %xmm3                         #226.5
        vpand     %xmm8, %xmm13, %xmm12                         #226.5
        vpor      1760(%rsp), %xmm3, %xmm14                     #226.5[spill]
        vpand     %xmm0, %xmm12, %xmm3                          #226.5
        vpor      %xmm3, %xmm14, %xmm13                         #226.5
        vmovdqu   1488(%rsp), %xmm14                            #226.5[spill]
        vpand     %xmm15, %xmm14, %xmm12                        #226.5
        vpxor     48(%rsp), %xmm13, %xmm3                       #226.5[spill]
        vpor      1776(%rsp), %xmm12, %xmm13                    #226.5[spill]
        vpand     %xmm8, %xmm14, %xmm12                         #226.5
        vpand     %xmm0, %xmm12, %xmm14                         #226.5
        vmovdqu   1680(%rsp), %xmm12                            #226.5[spill]
        vpor      %xmm14, %xmm13, %xmm13                        #226.5
        vpand     %xmm15, %xmm12, %xmm15                        #226.5
        vpand     %xmm8, %xmm12, %xmm8                          #226.5
        vpor      1792(%rsp), %xmm15, %xmm15                    #226.5[spill]
        vpand     %xmm0, %xmm8, %xmm0                           #226.5
        vpor      %xmm0, %xmm15, %xmm0                          #226.5
        vpxor     64(%rsp), %xmm4, %xmm4                        #226.5[spill]
        vpxor     32(%rsp), %xmm13, %xmm13                      #226.5[spill]
        vpxor     16(%rsp), %xmm0, %xmm0                        #226.5[spill]
        vmovdqu   288(%rsp), %xmm8                              #226.5[spill]
        vmovdqu   272(%rsp), %xmm12                             #226.5[spill]
        vmovdqu   256(%rsp), %xmm14                             #226.5[spill]
        vmovdqu   (%rsp), %xmm15                                #226.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.156:                       # Preds ..B1.156 ..B1.155
                                # Execution count [5.00e+00]
        incl      %edx                                          #225.29
        lea       (%rax,%rbx), %rsi                             #226.5
        vmovdqu   %xmm2, 80(%rsi)                               #226.5
        vmovdqu   %xmm1, 96(%rsi)                               #226.5
        vmovdqu   %xmm11, 112(%rsi)                             #226.5
        vmovdqu   %xmm10, 128(%rsi)                             #226.5
        vmovdqu   %xmm9, 144(%rsi)                              #226.5
        vmovdqu   %xmm6, 160(%rsi)                              #226.5
        vmovdqu   %xmm5, 176(%rsi)                              #226.5
        vmovdqu   %xmm4, 192(%rsi)                              #226.5
        vmovdqu   %xmm3, 208(%rsi)                              #226.5
        vmovdqu   %xmm13, 224(%rsi)                             #226.5
        vmovdqu   %xmm0, 240(%rsi)                              #226.5
        addq      $256, %rax                                    #225.29
        vmovdqu   %xmm15, (%rsi)                                #226.5
        vmovdqu   %xmm14, 16(%rsi)                              #226.5
        vmovdqu   %xmm12, 32(%rsi)                              #226.5
        vmovdqu   %xmm8, 48(%rsi)                               #226.5
        vmovdqu   %xmm7, 64(%rsi)                               #226.5
        cmpl      $1000000, %edx                                #225.23
        jl        ..B1.155      # Prob 82%                      #225.23
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.157:                       # Preds ..B1.156
                                # Execution count [1.00e+00]
        rdtscp                                                   #229.9
        shlq      $32, %rdx                                     #229.9
        orq       %rdx, %rax                                    #229.9
                                # LOE rax rbx r8 r12
..B1.158:                       # Preds ..B1.157
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #230.3
        movl      $.L_2__STRING.3, %edi                         #230.3
        movq      %rax, %rsi                                    #230.3
        xorl      %eax, %eax                                    #230.3
..___tag_value_main.23:
#       printf(const char *__restrict__, ...)
        call      printf                                        #230.3
..___tag_value_main.24:
                                # LOE rbx r12
..B1.159:                       # Preds ..B1.158
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #231.3
        movl      $16, %esi                                     #231.3
        movl      $16000000, %edx                               #231.3
        movq      %r12, %rcx                                    #231.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #231.3
                                # LOE
..B1.160:                       # Preds ..B1.159
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #233.10
        addq      $2392, %rsp                                   #233.10
	.cfi_restore 3
        popq      %rbx                                          #233.10
	.cfi_restore 15
        popq      %r15                                          #233.10
	.cfi_restore 14
        popq      %r14                                          #233.10
	.cfi_restore 13
        popq      %r13                                          #233.10
	.cfi_restore 12
        popq      %r12                                          #233.10
        movq      %rbp, %rsp                                    #233.10
        popq      %rbp                                          #233.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #233.10
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
..___tag_value_add_pack.33:
..L34:
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
..___tag_value_add.36:
..L37:
                                                         #39.47
        vpxor     %xmm1, %xmm0, %xmm2                           #40.21
        vpxor     (%rdi), %xmm2, %xmm0                          #41.24
        vmovdqu   %xmm0, (%rdi)                                 #42.4
        ret                                                     #43.10
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
..___tag_value_add_bitslice.39:
..L40:
                                                         #54.34
        vmovdqa   %xmm0, %xmm8                                  #54.34
        vmovdqu   120(%rsp), %xmm0                              #54.34
        vpxor     376(%rsp), %xmm0, %xmm0                       #71.13
        vmovdqu   %xmm0, -24(%rsp)                              #71.13[spill]
        vpxor     136(%rsp), %xmm8, %xmm8                       #56.12
        vpxor     %xmm0, %xmm0, %xmm0                           #56.12
        vpxor     152(%rsp), %xmm1, %xmm1                       #57.12
        vpxor     %xmm0, %xmm8, %xmm8                           #56.12
        vpxor     168(%rsp), %xmm2, %xmm2                       #58.12
        vpxor     %xmm8, %xmm1, %xmm1                           #57.12
        vpxor     184(%rsp), %xmm3, %xmm3                       #59.12
        vpxor     %xmm1, %xmm2, %xmm2                           #58.12
        vpxor     200(%rsp), %xmm4, %xmm4                       #60.12
        vpxor     %xmm2, %xmm3, %xmm3                           #59.12
        vpxor     216(%rsp), %xmm5, %xmm5                       #61.12
        vpxor     %xmm3, %xmm4, %xmm4                           #60.12
        vpxor     232(%rsp), %xmm6, %xmm6                       #62.12
        vpxor     %xmm4, %xmm5, %xmm5                           #61.12
        vpxor     248(%rsp), %xmm7, %xmm7                       #63.12
        vpxor     %xmm5, %xmm6, %xmm6                           #62.12
        vmovdqu   8(%rsp), %xmm9                                #54.34
        vpxor     %xmm6, %xmm7, %xmm7                           #63.12
        vmovdqu   24(%rsp), %xmm10                              #54.34
        vpxor     264(%rsp), %xmm9, %xmm9                       #64.12
        vpxor     280(%rsp), %xmm10, %xmm10                     #65.12
        vpxor     %xmm7, %xmm9, %xmm9                           #64.12
        vmovdqu   40(%rsp), %xmm11                              #54.34
        vpxor     %xmm9, %xmm10, %xmm10                         #65.12
        vmovdqu   56(%rsp), %xmm12                              #54.34
        vpxor     296(%rsp), %xmm11, %xmm11                     #66.13
        vpxor     312(%rsp), %xmm12, %xmm12                     #67.13
        vpxor     %xmm10, %xmm11, %xmm11                        #66.13
        vmovdqu   72(%rsp), %xmm13                              #54.34
        vpxor     %xmm11, %xmm12, %xmm12                        #67.13
        vmovdqu   88(%rsp), %xmm14                              #54.34
        vpxor     328(%rsp), %xmm13, %xmm13                     #68.13
        vpxor     344(%rsp), %xmm14, %xmm14                     #69.13
        vpxor     %xmm12, %xmm13, %xmm13                        #68.13
        vmovdqu   104(%rsp), %xmm15                             #54.34
        vpxor     %xmm13, %xmm14, %xmm14                        #69.13
        vpxor     360(%rsp), %xmm15, %xmm15                     #70.13
        vpxor     %xmm14, %xmm15, %xmm15                        #70.13
        vpxor     -24(%rsp), %xmm15, %xmm0                      #71.13[spill]
        vmovdqu   %xmm8, (%rdi)                                 #56.3
        vmovdqu   %xmm1, 16(%rdi)                               #57.3
        vmovdqu   %xmm2, 32(%rdi)                               #58.3
        vmovdqu   %xmm3, 48(%rdi)                               #59.3
        vmovdqu   %xmm4, 64(%rdi)                               #60.3
        vmovdqu   %xmm5, 80(%rdi)                               #61.3
        vmovdqu   %xmm6, 96(%rdi)                               #62.3
        vmovdqu   %xmm7, 112(%rdi)                              #63.3
        vmovdqu   %xmm9, 128(%rdi)                              #64.3
        vmovdqu   %xmm10, 144(%rdi)                             #65.3
        vmovdqu   %xmm11, 160(%rdi)                             #66.3
        vmovdqu   %xmm12, 176(%rdi)                             #67.3
        vmovdqu   %xmm13, 192(%rdi)                             #68.3
        vmovdqu   %xmm14, 208(%rdi)                             #69.3
        vmovdqu   %xmm15, 224(%rdi)                             #70.3
        vmovdqu   %xmm0, 240(%rdi)                              #71.3
        ret                                                     #72.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_bitslice,@function
	.size	add_bitslice,.-add_bitslice
	.data
# -- End  add_bitslice
	.text
# -- Begin  add_lookahead
	.text
# mark_begin;
       .align    16,0x90
	.globl add_lookahead
# --- add_lookahead(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
add_lookahead:
# parameter 1: %xmm0
# parameter 2: %xmm1
# parameter 3: %xmm2
# parameter 4: %xmm3
# parameter 5: %xmm4
# parameter 6: %xmm5
# parameter 7: %xmm6
# parameter 8: %xmm7
# parameter 9: 16 + %rbp
# parameter 10: 32 + %rbp
# parameter 11: 48 + %rbp
# parameter 12: 64 + %rbp
# parameter 13: 80 + %rbp
# parameter 14: 96 + %rbp
# parameter 15: 112 + %rbp
# parameter 16: 128 + %rbp
# parameter 17: 144 + %rbp
# parameter 18: 160 + %rbp
# parameter 19: 176 + %rbp
# parameter 20: 192 + %rbp
# parameter 21: 208 + %rbp
# parameter 22: 224 + %rbp
# parameter 23: 240 + %rbp
# parameter 24: 256 + %rbp
# parameter 25: 272 + %rbp
# parameter 26: 288 + %rbp
# parameter 27: 304 + %rbp
# parameter 28: 320 + %rbp
# parameter 29: 336 + %rbp
# parameter 30: 352 + %rbp
# parameter 31: 368 + %rbp
# parameter 32: 384 + %rbp
# parameter 33: %rdi
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_lookahead.42:
..L43:
                                                         #82.35
        pushq     %rbp                                          #82.35
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #82.35
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $496, %rsp                                    #82.35
        vmovdqa   %xmm0, %xmm12                                 #82.35
        vmovdqu   128(%rbp), %xmm14                             #82.35
        vmovdqa   %xmm3, %xmm11                                 #82.35
        vpxor     384(%rbp), %xmm14, %xmm13                     #98.23
        vmovdqu   144(%rbp), %xmm14                             #82.35
        vmovdqu   160(%rbp), %xmm8                              #82.35
        vpxor     %xmm14, %xmm12, %xmm10                        #83.21
        vmovdqu   176(%rbp), %xmm15                             #82.35
        vpand     %xmm14, %xmm12, %xmm14                        #100.21
        vmovdqu   192(%rbp), %xmm9                              #82.35
        vpand     %xmm8, %xmm1, %xmm12                          #101.21
        vmovdqu   208(%rbp), %xmm3                              #82.35
        vmovdqu   224(%rbp), %xmm0                              #82.35
        vmovdqu   %xmm13, -496(%rbp)                            #98.23[spill]
        vpxor     %xmm8, %xmm1, %xmm13                          #84.21
        vmovdqu   %xmm10, (%rdi)                                #132.3
        vpxor     %xmm15, %xmm2, %xmm8                          #85.21
        vpand     %xmm15, %xmm2, %xmm10                         #102.21
        vpxor     %xmm9, %xmm11, %xmm15                         #86.21
        vpand     %xmm9, %xmm11, %xmm9                          #103.21
        vpxor     %xmm3, %xmm4, %xmm11                          #87.21
        vpand     %xmm3, %xmm4, %xmm2                           #104.21
        vpxor     %xmm0, %xmm5, %xmm3                           #88.21
        vmovdqu   240(%rbp), %xmm4                              #89.21
        vpand     %xmm0, %xmm5, %xmm5                           #105.21
        vpxor     %xmm4, %xmm6, %xmm1                           #89.21
        vpand     %xmm4, %xmm6, %xmm0                           #106.21
        vmovdqu   256(%rbp), %xmm4                              #90.21
        vpxor     %xmm4, %xmm7, %xmm6                           #90.21
        vpand     %xmm4, %xmm7, %xmm7                           #107.21
        vmovdqu   %xmm6, -272(%rbp)                             #90.21[spill]
        vmovdqu   %xmm7, -256(%rbp)                             #107.21[spill]
        vmovdqu   16(%rbp), %xmm6                               #91.21
        vmovdqu   272(%rbp), %xmm7                              #91.21
        vmovdqu   %xmm0, -288(%rbp)                             #106.21[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #91.21
        vpand     %xmm7, %xmm6, %xmm4                           #108.21
        vmovdqu   32(%rbp), %xmm6                               #92.21
        vmovdqu   288(%rbp), %xmm7                              #92.21
        vmovdqu   %xmm0, -240(%rbp)                             #91.21[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #92.21
        vmovdqu   %xmm4, -224(%rbp)                             #108.21[spill]
        vpand     %xmm7, %xmm6, %xmm4                           #109.21
        vmovdqu   48(%rbp), %xmm6                               #93.23
        vmovdqu   304(%rbp), %xmm7                              #93.23
        vmovdqu   %xmm0, -208(%rbp)                             #92.21[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #93.23
        vmovdqu   %xmm4, -192(%rbp)                             #109.21[spill]
        vpand     %xmm7, %xmm6, %xmm4                           #110.23
        vmovdqu   64(%rbp), %xmm6                               #94.23
        vmovdqu   320(%rbp), %xmm7                              #94.23
        vmovdqu   %xmm0, -176(%rbp)                             #93.23[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #94.23
        vmovdqu   %xmm4, -160(%rbp)                             #110.23[spill]
        vpand     %xmm7, %xmm6, %xmm4                           #111.23
        vmovdqu   80(%rbp), %xmm6                               #95.23
        vmovdqu   336(%rbp), %xmm7                              #95.23
        vmovdqu   %xmm0, -144(%rbp)                             #94.23[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #95.23
        vmovdqu   %xmm4, -128(%rbp)                             #111.23[spill]
        vpand     %xmm7, %xmm6, %xmm4                           #112.23
        vmovdqu   96(%rbp), %xmm6                               #96.23
        vmovdqu   352(%rbp), %xmm7                              #96.23
        vmovdqu   %xmm0, -112(%rbp)                             #95.23[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #96.23
        vmovdqu   %xmm4, -96(%rbp)                              #112.23[spill]
        vpand     %xmm7, %xmm6, %xmm4                           #113.23
        vmovdqu   112(%rbp), %xmm6                              #97.23
        vmovdqu   368(%rbp), %xmm7                              #97.23
        vmovdqu   %xmm0, -80(%rbp)                              #96.23[spill]
        vpxor     %xmm7, %xmm6, %xmm0                           #97.23
        vmovdqu   %xmm4, -64(%rbp)                              #113.23[spill]
        vpand     %xmm7, %xmm6, %xmm4                           #114.23
        vpand     %xmm14, %xmm13, %xmm6                         #117.24
        vmovdqu   %xmm0, -48(%rbp)                              #97.23[spill]
        vpxor     %xmm14, %xmm13, %xmm0                         #133.17
        vpor      %xmm6, %xmm12, %xmm7                          #117.24
        vpand     %xmm13, %xmm8, %xmm6                          #118.32
        vmovdqu   %xmm0, 16(%rdi)                               #133.3
        vpand     %xmm12, %xmm8, %xmm0                          #118.24
        vmovdqu   %xmm4, -32(%rbp)                              #114.23[spill]
        vpxor     %xmm7, %xmm8, %xmm4                           #134.17
        vmovdqu   %xmm4, 32(%rdi)                               #134.3
        vpor      %xmm0, %xmm10, %xmm7                          #118.24
        vpand     %xmm14, %xmm6, %xmm4                          #118.35
        vpor      %xmm4, %xmm7, %xmm0                           #118.35
        vpand     %xmm10, %xmm15, %xmm7                         #119.24
        vpxor     %xmm0, %xmm15, %xmm6                          #135.17
        vpor      %xmm7, %xmm9, %xmm4                           #119.24
        vmovdqu   %xmm6, 48(%rdi)                               #135.3
        vpand     %xmm8, %xmm15, %xmm6                          #119.32
        vpand     %xmm12, %xmm6, %xmm0                          #119.35
        vpand     %xmm13, %xmm6, %xmm6                          #119.46
        vpor      %xmm0, %xmm4, %xmm7                           #119.35
        vpand     %xmm14, %xmm6, %xmm4                          #119.49
        vpor      %xmm4, %xmm7, %xmm0                           #119.49
        vpand     %xmm15, %xmm11, %xmm7                         #120.32
        vpand     %xmm9, %xmm11, %xmm4                          #120.24
        vpxor     %xmm0, %xmm11, %xmm6                          #136.17
        vmovdqu   %xmm6, 64(%rdi)                               #136.3
        vpand     %xmm8, %xmm7, %xmm0                           #120.60
        vpand     %xmm10, %xmm7, %xmm7                          #120.35
        vpor      %xmm4, %xmm2, %xmm6                           #120.24
        vpor      %xmm7, %xmm6, %xmm4                           #120.35
        vpand     %xmm12, %xmm0, %xmm6                          #120.49
        vpand     %xmm13, %xmm0, %xmm0                          #120.63
        vpor      %xmm6, %xmm4, %xmm7                           #120.49
        vpand     %xmm14, %xmm0, %xmm0                          #120.66
        vpor      %xmm0, %xmm7, %xmm6                           #120.66
        vpand     %xmm11, %xmm3, %xmm0                          #121.32
        vpxor     %xmm6, %xmm3, %xmm4                           #137.17
        vpand     %xmm15, %xmm0, %xmm6                          #121.77
        vpand     %xmm9, %xmm0, %xmm7                           #121.35
        vpand     %xmm2, %xmm3, %xmm0                           #121.24
        vpor      %xmm0, %xmm5, %xmm0                           #121.24
        vmovdqu   %xmm4, 80(%rdi)                               #137.3
        vpand     %xmm8, %xmm6, %xmm4                           #121.63
        vpand     %xmm10, %xmm6, %xmm6                          #121.49
        vpor      %xmm7, %xmm0, %xmm7                           #121.35
        vpor      %xmm6, %xmm7, %xmm0                           #121.49
        vpand     %xmm12, %xmm4, %xmm6                          #121.66
        vpand     %xmm13, %xmm4, %xmm4                          #121.83
        vpor      %xmm6, %xmm0, %xmm7                           #121.66
        vpand     %xmm14, %xmm4, %xmm0                          #121.86
        vpor      %xmm0, %xmm7, %xmm6                           #121.86
        vpand     %xmm3, %xmm1, %xmm0                           #122.32
        vpand     %xmm11, %xmm0, %xmm7                          #122.97
        vpxor     %xmm6, %xmm1, %xmm4                           #138.17
        vmovdqu   %xmm4, 96(%rdi)                               #138.3
        vpand     %xmm2, %xmm0, %xmm4                           #122.35
        vpand     %xmm15, %xmm7, %xmm0                          #122.63
        vpand     %xmm9, %xmm7, %xmm6                           #122.49
        vmovdqu   %xmm8, -432(%rbp)                             #85.21[spill]
        vpand     %xmm8, %xmm0, %xmm7                           #122.103
        vmovdqu   %xmm10, -416(%rbp)                            #102.21[spill]
        vpand     %xmm10, %xmm0, %xmm10                         #122.66
        vmovdqu   -288(%rbp), %xmm8                             #122.24[spill]
        vpand     %xmm5, %xmm1, %xmm0                           #122.24
        vpor      %xmm0, %xmm8, %xmm0                           #122.24
        vpor      %xmm4, %xmm0, %xmm4                           #122.35
        vpand     %xmm12, %xmm7, %xmm0                          #122.86
        vpor      %xmm6, %xmm4, %xmm6                           #122.49
        vpor      %xmm10, %xmm6, %xmm10                         #122.66
        vpor      %xmm0, %xmm10, %xmm6                          #122.86
        vpand     %xmm13, %xmm7, %xmm10                         #122.106
        vpand     %xmm14, %xmm10, %xmm7                         #122.109
        vmovdqu   -272(%rbp), %xmm10                            #139.17[spill]
        vpor      %xmm7, %xmm6, %xmm4                           #122.109
        vpand     %xmm1, %xmm10, %xmm6                          #123.32
        vpxor     %xmm4, %xmm10, %xmm0                          #139.17
        vpand     %xmm3, %xmm6, %xmm4                           #123.120
        vpand     %xmm5, %xmm6, %xmm7                           #123.35
        vmovdqu   %xmm0, 112(%rdi)                              #139.3
        vpand     %xmm11, %xmm4, %xmm0                          #123.63
        vmovdqu   %xmm15, -400(%rbp)                            #86.21[spill]
        vpand     %xmm15, %xmm0, %xmm15                         #123.126
        vmovdqu   %xmm9, -384(%rbp)                             #103.21[spill]
        vpand     %xmm9, %xmm0, %xmm6                           #123.66
        vmovdqu   %xmm2, -352(%rbp)                             #104.21[spill]
        vpand     %xmm2, %xmm4, %xmm2                           #123.49
        vpand     -432(%rbp), %xmm15, %xmm4                     #123.106[spill]
        vpand     %xmm8, %xmm10, %xmm0                          #123.24
        vpand     -416(%rbp), %xmm15, %xmm9                     #123.86[spill]
        vmovdqu   -256(%rbp), %xmm15                            #123.24[spill]
        vpor      %xmm0, %xmm15, %xmm0                          #123.24
        vpor      %xmm7, %xmm0, %xmm7                           #123.35
        vpor      %xmm2, %xmm7, %xmm2                           #123.49
        vpor      %xmm6, %xmm2, %xmm0                           #123.66
        vpor      %xmm9, %xmm0, %xmm9                           #123.86
        vpand     %xmm12, %xmm4, %xmm0                          #123.109
        vpor      %xmm0, %xmm9, %xmm6                           #123.109
        vpand     %xmm13, %xmm4, %xmm9                          #123.132
        vpand     %xmm14, %xmm9, %xmm2                          #123.135
        vmovdqu   -240(%rbp), %xmm9                             #140.17[spill]
        vpor      %xmm2, %xmm6, %xmm7                           #123.135
        vpand     %xmm10, %xmm9, %xmm0                          #124.32
        vpxor     %xmm7, %xmm9, %xmm4                           #140.17
        vpand     %xmm1, %xmm0, %xmm6                           #124.146
        vpand     %xmm8, %xmm0, %xmm8                           #124.35
        vpand     %xmm3, %xmm6, %xmm2                           #124.63
        vpand     %xmm5, %xmm6, %xmm7                           #124.49
        vmovdqu   %xmm5, -320(%rbp)                             #105.21[spill]
        vpand     %xmm11, %xmm2, %xmm5                          #124.152
        vmovdqu   %xmm11, -368(%rbp)                            #87.21[spill]
        vpand     -400(%rbp), %xmm5, %xmm6                      #124.106[spill]
        vpand     -384(%rbp), %xmm5, %xmm11                     #124.86[spill]
        vmovdqu   -224(%rbp), %xmm5                             #124.24[spill]
        vmovdqu   %xmm4, 128(%rdi)                              #140.3
        vpand     %xmm15, %xmm9, %xmm4                          #124.24
        vpor      %xmm4, %xmm5, %xmm4                           #124.24
        vpor      %xmm8, %xmm4, %xmm8                           #124.35
        vpand     -352(%rbp), %xmm2, %xmm2                      #124.66[spill]
        vpor      %xmm7, %xmm8, %xmm8                           #124.49
        vpor      %xmm2, %xmm8, %xmm2                           #124.66
        vpand     -432(%rbp), %xmm6, %xmm0                      #124.158[spill]
        vpor      %xmm11, %xmm2, %xmm11                         #124.86
        vpand     -416(%rbp), %xmm6, %xmm6                      #124.109[spill]
        vpand     %xmm12, %xmm0, %xmm8                          #124.135
        vpor      %xmm6, %xmm11, %xmm11                         #124.109
        vpand     %xmm13, %xmm0, %xmm0                          #124.161
        vpor      %xmm8, %xmm11, %xmm6                          #124.135
        vpand     %xmm14, %xmm0, %xmm2                          #124.164
        vpor      %xmm2, %xmm6, %xmm7                           #124.164
        vmovdqu   -208(%rbp), %xmm6                             #141.17[spill]
        vpand     %xmm9, %xmm6, %xmm11                          #125.32
        vpxor     %xmm7, %xmm6, %xmm4                           #141.17
        vpand     %xmm10, %xmm11, %xmm8                         #125.175
        vpand     %xmm15, %xmm11, %xmm11                        #125.35
        vmovdqu   %xmm1, -304(%rbp)                             #89.21[spill]
        vpand     %xmm1, %xmm8, %xmm1                           #125.63
        vmovdqu   %xmm3, -336(%rbp)                             #88.21[spill]
        vpand     %xmm3, %xmm1, %xmm3                           #125.181
        vpand     -320(%rbp), %xmm1, %xmm15                     #125.66[spill]
        vpand     %xmm5, %xmm6, %xmm7                           #125.24
        vpand     -368(%rbp), %xmm3, %xmm1                      #125.106[spill]
        vpand     -288(%rbp), %xmm8, %xmm2                      #125.49[spill]
        vpand     -352(%rbp), %xmm3, %xmm8                      #125.86[spill]
        vpand     -400(%rbp), %xmm1, %xmm3                      #125.187[spill]
        vpand     -384(%rbp), %xmm1, %xmm0                      #125.109[spill]
        vmovdqu   %xmm4, 144(%rdi)                              #141.3
        vpand     -432(%rbp), %xmm3, %xmm4                      #125.161[spill]
        vpand     -416(%rbp), %xmm3, %xmm1                      #125.135[spill]
        vmovdqu   -192(%rbp), %xmm3                             #125.24[spill]
        vpor      %xmm7, %xmm3, %xmm7                           #125.24
        vpor      %xmm11, %xmm7, %xmm11                         #125.35
        vpor      %xmm2, %xmm11, %xmm2                          #125.49
        vpor      %xmm15, %xmm2, %xmm15                         #125.66
        vpor      %xmm8, %xmm15, %xmm11                         #125.86
        vpor      %xmm0, %xmm11, %xmm8                          #125.109
        vpand     %xmm12, %xmm4, %xmm11                         #125.164
        vpor      %xmm1, %xmm8, %xmm0                           #125.135
        vpand     %xmm13, %xmm4, %xmm4                          #125.193
        vmovdqu   -176(%rbp), %xmm1                             #142.19[spill]
        vpor      %xmm11, %xmm0, %xmm8                          #125.164
        vpand     %xmm6, %xmm1, %xmm7                           #126.36
        vpand     %xmm14, %xmm4, %xmm11                         #125.196
        vpand     %xmm9, %xmm7, %xmm9                           #126.219
        vpor      %xmm11, %xmm8, %xmm15                         #125.196
        vpand     %xmm10, %xmm9, %xmm10                         #126.69
        vpxor     %xmm15, %xmm1, %xmm2                          #142.19
        vmovdqu   %xmm2, 160(%rdi)                              #142.3
        vpand     %xmm5, %xmm7, %xmm7                           #126.39
        vpand     -256(%rbp), %xmm9, %xmm2                      #126.54[spill]
        vpand     %xmm3, %xmm1, %xmm4                           #126.27
        vpand     -304(%rbp), %xmm10, %xmm9                     #126.225[spill]
        vpand     -336(%rbp), %xmm9, %xmm11                     #126.114[spill]
        vpand     -288(%rbp), %xmm10, %xmm5                     #126.72[spill]
        vpand     -368(%rbp), %xmm11, %xmm10                    #126.231[spill]
        vpand     -320(%rbp), %xmm9, %xmm15                     #126.93[spill]
        vpand     -400(%rbp), %xmm10, %xmm0                     #126.171[spill]
        vpand     -384(%rbp), %xmm10, %xmm9                     #126.144[spill]
        vmovdqu   -160(%rbp), %xmm10                            #126.27[spill]
        vpor      %xmm4, %xmm10, %xmm4                          #126.27
        vpor      %xmm7, %xmm4, %xmm7                           #126.39
        vpor      %xmm2, %xmm7, %xmm2                           #126.54
        vpor      %xmm5, %xmm2, %xmm5                           #126.72
        vpand     -352(%rbp), %xmm11, %xmm8                     #126.117[spill]
        vpor      %xmm15, %xmm5, %xmm15                         #126.93
        vpor      %xmm8, %xmm15, %xmm8                          #126.117
        vpand     -432(%rbp), %xmm0, %xmm11                     #126.237[spill]
        vpor      %xmm9, %xmm8, %xmm9                           #126.144
        vpand     -416(%rbp), %xmm0, %xmm0                      #126.174[spill]
        vpand     %xmm12, %xmm11, %xmm5                         #126.207
        vpor      %xmm0, %xmm9, %xmm0                           #126.174
        vpand     %xmm13, %xmm11, %xmm11                        #126.240
        vmovdqu   -144(%rbp), %xmm9                             #143.19[spill]
        vpor      %xmm5, %xmm0, %xmm2                           #126.207
        vpand     %xmm14, %xmm11, %xmm7                         #126.243
        vpand     %xmm1, %xmm9, %xmm8                           #127.37
        vpor      %xmm7, %xmm2, %xmm4                           #126.243
        vpand     %xmm6, %xmm8, %xmm6                           #127.266
        vpxor     %xmm4, %xmm9, %xmm11                          #143.19
        vpand     %xmm3, %xmm8, %xmm4                           #127.41
        vmovdqu   %xmm11, 176(%rdi)                             #143.3
        vpand     %xmm10, %xmm9, %xmm10                         #127.27
        vpand     -240(%rbp), %xmm6, %xmm11                     #127.73[spill]
        vpand     -272(%rbp), %xmm11, %xmm8                     #127.272[spill]
        vpand     -304(%rbp), %xmm8, %xmm3                      #127.120[spill]
        vpand     -256(%rbp), %xmm11, %xmm2                     #127.76[spill]
        vpand     -336(%rbp), %xmm3, %xmm11                     #127.278[spill]
        vpand     -224(%rbp), %xmm6, %xmm7                      #127.57[spill]
        vpand     -288(%rbp), %xmm8, %xmm6                      #127.98[spill]
        vpand     -368(%rbp), %xmm11, %xmm8                     #127.179[spill]
        vpand     -400(%rbp), %xmm8, %xmm0                      #127.284[spill]
        vpand     -320(%rbp), %xmm3, %xmm5                      #127.123[spill]
        vpand     -352(%rbp), %xmm11, %xmm15                    #127.151[spill]
        vpand     -432(%rbp), %xmm0, %xmm3                      #127.250[spill]
        vpand     -416(%rbp), %xmm0, %xmm11                     #127.216[spill]
        vmovdqu   -128(%rbp), %xmm0                             #127.27[spill]
        vpor      %xmm10, %xmm0, %xmm10                         #127.27
        vpor      %xmm4, %xmm10, %xmm4                          #127.41
        vpor      %xmm7, %xmm4, %xmm7                           #127.57
        vpor      %xmm2, %xmm7, %xmm2                           #127.76
        vpor      %xmm6, %xmm2, %xmm6                           #127.98
        vpor      %xmm5, %xmm6, %xmm5                           #127.123
        vpand     -384(%rbp), %xmm8, %xmm8                      #127.182[spill]
        vpor      %xmm15, %xmm5, %xmm15                         #127.151
        vpor      %xmm8, %xmm15, %xmm8                          #127.182
        vpor      %xmm11, %xmm8, %xmm11                         #127.216
        vpand     %xmm12, %xmm3, %xmm8                          #127.253
        vpand     %xmm13, %xmm3, %xmm3                          #127.290
        vpor      %xmm8, %xmm11, %xmm11                         #127.253
        vpand     %xmm14, %xmm3, %xmm10                         #127.293
        vpor      %xmm10, %xmm11, %xmm15                        #127.293
        vmovdqu   -112(%rbp), %xmm10                            #144.19[spill]
        vpand     %xmm9, %xmm10, %xmm9                          #128.37
        vpxor     %xmm15, %xmm10, %xmm5                         #144.19
        vpand     %xmm1, %xmm9, %xmm1                           #128.316
        vpand     -160(%rbp), %xmm9, %xmm4                      #128.41[spill]
        vpand     -208(%rbp), %xmm1, %xmm9                      #128.76[spill]
        vpand     -240(%rbp), %xmm9, %xmm11                     #128.323[spill]
        vpand     -272(%rbp), %xmm11, %xmm8                     #128.125[spill]
        vpand     -304(%rbp), %xmm8, %xmm3                      #128.329[spill]
        vpand     -192(%rbp), %xmm1, %xmm7                      #128.59[spill]
        vpand     -336(%rbp), %xmm3, %xmm1                      #128.186[spill]
        vpand     -224(%rbp), %xmm9, %xmm2                      #128.79[spill]
        vpand     -368(%rbp), %xmm1, %xmm9                      #128.335[spill]
        vpand     -256(%rbp), %xmm11, %xmm6                     #128.102[spill]
        vpand     -400(%rbp), %xmm9, %xmm11                     #128.259[spill]
        vmovdqu   %xmm5, 192(%rdi)                              #144.3
        vpand     -288(%rbp), %xmm8, %xmm5                      #128.128[spill]
        vpand     -320(%rbp), %xmm3, %xmm15                     #128.157[spill]
        vpand     -384(%rbp), %xmm9, %xmm8                      #128.224[spill]
        vpand     -432(%rbp), %xmm11, %xmm3                     #128.341[spill]
        vpand     -416(%rbp), %xmm11, %xmm9                     #128.262[spill]
        vpand     %xmm0, %xmm10, %xmm11                         #128.27
        vmovdqu   -96(%rbp), %xmm0                              #128.27[spill]
        vpor      %xmm11, %xmm0, %xmm11                         #128.27
        vpor      %xmm4, %xmm11, %xmm4                          #128.41
        vpor      %xmm7, %xmm4, %xmm7                           #128.59
        vpor      %xmm2, %xmm7, %xmm2                           #128.79
        vpor      %xmm6, %xmm2, %xmm6                           #128.102
        vpor      %xmm5, %xmm6, %xmm11                          #128.128
        vpand     -352(%rbp), %xmm1, %xmm1                      #128.189[spill]
        vpor      %xmm15, %xmm11, %xmm15                        #128.157
        vpor      %xmm1, %xmm15, %xmm5                          #128.189
        vpor      %xmm8, %xmm5, %xmm11                          #128.224
        vmovdqu   %xmm13, -464(%rbp)                            #84.21[spill]
        vpor      %xmm9, %xmm11, %xmm9                          #128.262
        vmovdqu   %xmm12, -448(%rbp)                            #101.21[spill]
        vpand     %xmm12, %xmm3, %xmm12                         #128.303
        vpand     %xmm13, %xmm3, %xmm13                         #128.344
        vpor      %xmm12, %xmm9, %xmm12                         #128.303
        vmovdqu   %xmm14, -480(%rbp)                            #100.21[spill]
        vpand     %xmm14, %xmm13, %xmm9                         #128.347
        vmovdqu   -80(%rbp), %xmm14                             #145.19[spill]
        vpor      %xmm9, %xmm12, %xmm11                         #128.347
        vmovdqu   -144(%rbp), %xmm13                            #129.370[spill]
        vpand     %xmm10, %xmm14, %xmm3                         #129.37
        vpand     %xmm13, %xmm3, %xmm1                          #129.370
        vpxor     %xmm11, %xmm14, %xmm8                         #145.19
        vpand     -176(%rbp), %xmm1, %xmm15                     #129.77[spill]
        vpand     -208(%rbp), %xmm15, %xmm5                     #129.378[spill]
        vpand     -240(%rbp), %xmm5, %xmm6                      #129.129[spill]
        vpand     -272(%rbp), %xmm6, %xmm12                     #129.384[spill]
        vpand     -304(%rbp), %xmm12, %xmm9                     #129.192[spill]
        vmovdqu   %xmm8, 208(%rdi)                              #145.3
        vpand     -336(%rbp), %xmm9, %xmm8                      #129.390[spill]
        vpand     -128(%rbp), %xmm3, %xmm11                     #129.41[spill]
        vpand     -368(%rbp), %xmm8, %xmm3                      #129.267[spill]
        vpand     -192(%rbp), %xmm15, %xmm7                     #129.81[spill]
        vpand     -320(%rbp), %xmm9, %xmm15                     #129.195[spill]
        vpand     -400(%rbp), %xmm3, %xmm9                      #129.396[spill]
        vpand     -224(%rbp), %xmm5, %xmm2                      #129.105[spill]
        vpand     -288(%rbp), %xmm12, %xmm5                     #129.162[spill]
        vpand     -432(%rbp), %xmm9, %xmm12                     #129.354[spill]
        vpand     -160(%rbp), %xmm1, %xmm4                      #129.59[spill]
        vmovdqu   %xmm12, -16(%rbp)                             #129.354[spill]
        vpand     -352(%rbp), %xmm8, %xmm1                      #129.231[spill]
        vpand     %xmm0, %xmm14, %xmm8                          #129.27
        vmovdqu   -64(%rbp), %xmm12                             #129.27[spill]
        vpor      %xmm8, %xmm12, %xmm8                          #129.27
        vpor      %xmm11, %xmm8, %xmm11                         #129.41
        vpor      %xmm4, %xmm11, %xmm4                          #129.59
        vpor      %xmm7, %xmm4, %xmm7                           #129.81
        vpand     -256(%rbp), %xmm6, %xmm6                      #129.132[spill]
        vpor      %xmm2, %xmm7, %xmm2                           #129.105
        vpor      %xmm6, %xmm2, %xmm11                          #129.132
        vpor      %xmm5, %xmm11, %xmm8                          #129.162
        vpor      %xmm15, %xmm8, %xmm15                         #129.195
        vpand     -384(%rbp), %xmm3, %xmm3                      #129.270[spill]
        vpor      %xmm1, %xmm15, %xmm1                          #129.231
        vmovdqu   -48(%rbp), %xmm5                              #130.37[spill]
        vpor      %xmm3, %xmm1, %xmm3                           #129.270
        vpand     -416(%rbp), %xmm9, %xmm9                      #129.312[spill]
        vpand     %xmm14, %xmm5, %xmm14                         #130.37
        vpor      %xmm9, %xmm3, %xmm6                           #129.312
        vpand     %xmm10, %xmm14, %xmm9                         #130.428
        vpand     %xmm13, %xmm9, %xmm10                         #130.77
        vpand     %xmm0, %xmm14, %xmm8                          #130.41
        vpand     -176(%rbp), %xmm10, %xmm0                     #130.436[spill]
        vpand     %xmm12, %xmm5, %xmm12                         #130.27
        vpand     -208(%rbp), %xmm0, %xmm13                     #130.132[spill]
        vpand     -128(%rbp), %xmm9, %xmm11                     #130.59[spill]
        vpand     -240(%rbp), %xmm13, %xmm9                     #130.443[spill]
        vpor      -32(%rbp), %xmm12, %xmm12                     #130.27[spill]
        vpand     -272(%rbp), %xmm9, %xmm3                      #130.197[spill]
        vpor      %xmm8, %xmm12, %xmm8                          #130.41
        vpand     -160(%rbp), %xmm10, %xmm4                     #130.81[spill]
        vpor      %xmm11, %xmm8, %xmm11                         #130.59
        vpand     -304(%rbp), %xmm3, %xmm1                      #130.449[spill]
        vpor      %xmm4, %xmm11, %xmm4                          #130.81
        vpand     -192(%rbp), %xmm0, %xmm7                      #130.107[spill]
        vpand     -336(%rbp), %xmm1, %xmm14                     #130.274[spill]
        vpor      %xmm7, %xmm4, %xmm7                           #130.107
        vpand     -224(%rbp), %xmm13, %xmm2                     #130.135[spill]
        vpand     -368(%rbp), %xmm14, %xmm15                    #130.455[spill]
        vpand     -288(%rbp), %xmm3, %xmm0                      #130.200[spill]
        vpand     -320(%rbp), %xmm1, %xmm10                     #130.237[spill]
        vpand     -256(%rbp), %xmm9, %xmm13                     #130.166[spill]
        vpand     -400(%rbp), %xmm15, %xmm3                     #130.363[spill]
        vpand     -384(%rbp), %xmm15, %xmm1                     #130.320[spill]
        vpor      %xmm2, %xmm7, %xmm15                          #130.135
        vpor      %xmm13, %xmm15, %xmm13                        #130.166
        vmovdqu   -448(%rbp), %xmm8                             #129.357[spill]
        vpor      %xmm0, %xmm13, %xmm0                          #130.200
        vmovdqu   -16(%rbp), %xmm12                             #129.357[spill]
        vpor      %xmm10, %xmm0, %xmm10                         #130.237
        vmovdqu   -464(%rbp), %xmm11                            #129.402[spill]
        vpand     %xmm8, %xmm12, %xmm2                          #129.357
        vpand     -352(%rbp), %xmm14, %xmm14                    #130.277[spill]
        vpor      %xmm2, %xmm6, %xmm2                           #129.357
        vpand     %xmm11, %xmm12, %xmm6                         #129.402
        vpor      %xmm14, %xmm10, %xmm0                         #130.277
        vmovdqu   -480(%rbp), %xmm12                            #129.405[spill]
        vpor      %xmm1, %xmm0, %xmm1                           #130.320
        vpand     -432(%rbp), %xmm3, %xmm9                      #130.461[spill]
        vpand     %xmm12, %xmm6, %xmm4                          #129.405
        vpand     -416(%rbp), %xmm3, %xmm3                      #130.366[spill]
        vpor      %xmm4, %xmm2, %xmm6                           #129.405
        vpor      %xmm3, %xmm1, %xmm2                           #130.366
        vpand     %xmm8, %xmm9, %xmm3                           #130.415
        vpand     %xmm11, %xmm9, %xmm9                          #130.464
        vpxor     %xmm6, %xmm5, %xmm5                           #146.19
        vmovdqu   %xmm5, 224(%rdi)                              #146.3
        vpor      %xmm3, %xmm2, %xmm4                           #130.415
        vpand     %xmm12, %xmm9, %xmm5                          #130.467
        vpor      %xmm5, %xmm4, %xmm6                           #130.467
        vpxor     -496(%rbp), %xmm6, %xmm0                      #147.19[spill]
                                # LOE rbx rdi r12 r13 r14 r15 xmm0
..B5.4:                         # Preds ..B5.1
                                # Execution count [1.00e+00]
        vmovdqu   %xmm0, 240(%rdi)                              #147.3
        movq      %rbp, %rsp                                    #148.1
        popq      %rbp                                          #148.1
	.cfi_restore 6
        ret                                                     #148.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_lookahead,@function
	.size	add_lookahead,.-add_lookahead
	.data
# -- End  add_lookahead
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
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.5:
	.long	1802465100
	.long	1634035809
	.long	774778468
	.word	32
	.type	.L_2__STRING.5,@object
	.size	.L_2__STRING.5,14
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
# End
