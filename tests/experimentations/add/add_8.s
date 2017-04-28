# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "-Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -i";
# mark_description "nline-max-total-size=10000 -O3 -S -o cmp.s";
	.file "cmp_add_AVX.c"
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
                                                          #170.13
        pushq     %rbp                                          #170.13
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #170.13
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-128, %rsp                                   #170.13
        pushq     %r12                                          #170.13
        pushq     %r13                                          #170.13
        pushq     %r14                                          #170.13
        pushq     %r15                                          #170.13
        pushq     %rbx                                          #170.13
        subq      $600, %rsp                                    #170.13
        movl      $10330110, %esi                               #170.13
        movl      $3, %edi                                      #170.13
        call      __intel_new_feature_proc_init                 #170.13
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.100:                       # Preds ..B1.1
                                # Execution count [1.00e+00]
        vstmxcsr  (%rsp)                                        #170.13
        movl      $.L_2__STRING.1, %edi                         #174.13
        movl      $.L_2__STRING.2, %esi                         #174.13
        orl       $32832, (%rsp)                                #170.13
        vldmxcsr  (%rsp)                                        #170.13
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #174.13
                                # LOE rax
..B1.99:                        # Preds ..B1.100
                                # Execution count [1.00e+00]
        movq      %rax, %r12                                    #174.13
                                # LOE r12
..B1.2:                         # Preds ..B1.99
                                # Execution count [1.00e+00]
        xorl      %edi, %edi                                    #180.9
#       time(time_t *)
        call      time                                          #180.9
                                # LOE rax r12
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movl      %eax, %edi                                    #180.3
#       srand(unsigned int)
        call      srand                                         #180.3
                                # LOE r12
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
        movl      $32, %edi                                     #181.30
        movl      $128000000, %esi                              #181.30
..___tag_value_main.11:
#       aligned_alloc(size_t, size_t)
        call      aligned_alloc                                 #181.30
..___tag_value_main.12:
                                # LOE rax r12
..B1.102:                       # Preds ..B1.4
                                # Execution count [1.00e+00]
        movq      %rax, %rbx                                    #181.30
                                # LOE rbx r12
..B1.5:                         # Preds ..B1.102
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.22
                                # LOE rbx r12 eax
..B1.103:                       # Preds ..B1.5
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #183.22
                                # LOE rbx r12 r14d
..B1.6:                         # Preds ..B1.103
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.29
                                # LOE rbx r12 eax r14d
..B1.104:                       # Preds ..B1.6
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #183.29
                                # LOE rbx r12 r13d r14d
..B1.7:                         # Preds ..B1.104
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.36
                                # LOE rbx r12 eax r13d r14d
..B1.105:                       # Preds ..B1.7
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #183.36
                                # LOE rbx r12 r13d r14d r15d
..B1.8:                         # Preds ..B1.105
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.9:                         # Preds ..B1.8
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #183.8
        vmovd     %r15d, %xmm1                                  #183.8
        vmovd     %r13d, %xmm2                                  #183.8
        vmovd     %r14d, %xmm3                                  #183.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #183.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #183.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #183.8
        vmovups   %xmm6, 480(%rsp)                              #183.8[spill]
#       rand(void)
        call      rand                                          #184.22
                                # LOE rbx r12 eax
..B1.107:                       # Preds ..B1.9
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #184.22
                                # LOE rbx r12 r14d
..B1.10:                        # Preds ..B1.107
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.29
                                # LOE rbx r12 eax r14d
..B1.108:                       # Preds ..B1.10
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #184.29
                                # LOE rbx r12 r13d r14d
..B1.11:                        # Preds ..B1.108
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.36
                                # LOE rbx r12 eax r13d r14d
..B1.109:                       # Preds ..B1.11
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #184.36
                                # LOE rbx r12 r13d r14d r15d
..B1.12:                        # Preds ..B1.109
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #184.8
        vmovd     %r15d, %xmm1                                  #184.8
        vmovd     %r13d, %xmm2                                  #184.8
        vmovd     %r14d, %xmm3                                  #184.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #184.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #184.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #184.8
        vmovups   %xmm6, 448(%rsp)                              #184.8[spill]
#       rand(void)
        call      rand                                          #185.22
                                # LOE rbx r12 eax
..B1.111:                       # Preds ..B1.13
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #185.22
                                # LOE rbx r12 r14d
..B1.14:                        # Preds ..B1.111
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.29
                                # LOE rbx r12 eax r14d
..B1.112:                       # Preds ..B1.14
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #185.29
                                # LOE rbx r12 r13d r14d
..B1.15:                        # Preds ..B1.112
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.36
                                # LOE rbx r12 eax r13d r14d
..B1.113:                       # Preds ..B1.15
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #185.36
                                # LOE rbx r12 r13d r14d r15d
..B1.16:                        # Preds ..B1.113
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.17:                        # Preds ..B1.16
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #185.8
        vmovd     %r15d, %xmm1                                  #185.8
        vmovd     %r13d, %xmm2                                  #185.8
        vmovd     %r14d, %xmm3                                  #185.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #185.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #185.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #185.8
        vmovups   %xmm6, 416(%rsp)                              #185.8[spill]
#       rand(void)
        call      rand                                          #186.22
                                # LOE rbx r12 eax
..B1.115:                       # Preds ..B1.17
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #186.22
                                # LOE rbx r12 r14d
..B1.18:                        # Preds ..B1.115
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.29
                                # LOE rbx r12 eax r14d
..B1.116:                       # Preds ..B1.18
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #186.29
                                # LOE rbx r12 r13d r14d
..B1.19:                        # Preds ..B1.116
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.36
                                # LOE rbx r12 eax r13d r14d
..B1.117:                       # Preds ..B1.19
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #186.36
                                # LOE rbx r12 r13d r14d r15d
..B1.20:                        # Preds ..B1.117
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #186.8
        vmovd     %r15d, %xmm1                                  #186.8
        vmovd     %r13d, %xmm2                                  #186.8
        vmovd     %r14d, %xmm3                                  #186.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #186.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #186.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #186.8
        vmovups   %xmm6, 384(%rsp)                              #186.8[spill]
#       rand(void)
        call      rand                                          #187.22
                                # LOE rbx r12 eax
..B1.119:                       # Preds ..B1.21
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #187.22
                                # LOE rbx r12 r14d
..B1.22:                        # Preds ..B1.119
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.29
                                # LOE rbx r12 eax r14d
..B1.120:                       # Preds ..B1.22
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #187.29
                                # LOE rbx r12 r13d r14d
..B1.23:                        # Preds ..B1.120
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.36
                                # LOE rbx r12 eax r13d r14d
..B1.121:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #187.36
                                # LOE rbx r12 r13d r14d r15d
..B1.24:                        # Preds ..B1.121
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.25:                        # Preds ..B1.24
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #187.8
        vmovd     %r15d, %xmm1                                  #187.8
        vmovd     %r13d, %xmm2                                  #187.8
        vmovd     %r14d, %xmm3                                  #187.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #187.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #187.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #187.8
        vmovups   %xmm6, 368(%rsp)                              #187.8[spill]
#       rand(void)
        call      rand                                          #188.22
                                # LOE rbx r12 eax
..B1.123:                       # Preds ..B1.25
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #188.22
                                # LOE rbx r12 r14d
..B1.26:                        # Preds ..B1.123
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #188.29
                                # LOE rbx r12 eax r14d
..B1.124:                       # Preds ..B1.26
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #188.29
                                # LOE rbx r12 r13d r14d
..B1.27:                        # Preds ..B1.124
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #188.36
                                # LOE rbx r12 eax r13d r14d
..B1.125:                       # Preds ..B1.27
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #188.36
                                # LOE rbx r12 r13d r14d r15d
..B1.28:                        # Preds ..B1.125
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #188.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #188.8
        vmovd     %r15d, %xmm1                                  #188.8
        vmovd     %r13d, %xmm2                                  #188.8
        vmovd     %r14d, %xmm3                                  #188.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #188.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #188.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #188.8
        vmovups   %xmm6, 352(%rsp)                              #188.8[spill]
#       rand(void)
        call      rand                                          #189.22
                                # LOE rbx r12 eax
..B1.127:                       # Preds ..B1.29
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #189.22
                                # LOE rbx r12 r14d
..B1.30:                        # Preds ..B1.127
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.29
                                # LOE rbx r12 eax r14d
..B1.128:                       # Preds ..B1.30
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #189.29
                                # LOE rbx r12 r13d r14d
..B1.31:                        # Preds ..B1.128
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.36
                                # LOE rbx r12 eax r13d r14d
..B1.129:                       # Preds ..B1.31
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #189.36
                                # LOE rbx r12 r13d r14d r15d
..B1.32:                        # Preds ..B1.129
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.33:                        # Preds ..B1.32
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #189.8
        vmovd     %r15d, %xmm1                                  #189.8
        vmovd     %r13d, %xmm2                                  #189.8
        vmovd     %r14d, %xmm3                                  #189.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #189.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #189.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #189.8
        vmovups   %xmm6, 320(%rsp)                              #189.8[spill]
#       rand(void)
        call      rand                                          #190.22
                                # LOE rbx r12 eax
..B1.131:                       # Preds ..B1.33
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #190.22
                                # LOE rbx r12 r14d
..B1.34:                        # Preds ..B1.131
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.29
                                # LOE rbx r12 eax r14d
..B1.132:                       # Preds ..B1.34
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #190.29
                                # LOE rbx r12 r13d r14d
..B1.35:                        # Preds ..B1.132
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.36
                                # LOE rbx r12 eax r13d r14d
..B1.133:                       # Preds ..B1.35
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #190.36
                                # LOE rbx r12 r13d r14d r15d
..B1.36:                        # Preds ..B1.133
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.37:                        # Preds ..B1.36
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #190.8
        vmovd     %r15d, %xmm1                                  #190.8
        vmovd     %r13d, %xmm2                                  #190.8
        vmovd     %r14d, %xmm3                                  #190.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #190.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #190.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #190.8
        vmovups   %xmm6, 464(%rsp)                              #190.8[spill]
#       rand(void)
        call      rand                                          #192.22
                                # LOE rbx r12 eax
..B1.135:                       # Preds ..B1.37
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #192.22
                                # LOE rbx r12 r14d
..B1.38:                        # Preds ..B1.135
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.29
                                # LOE rbx r12 eax r14d
..B1.136:                       # Preds ..B1.38
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #192.29
                                # LOE rbx r12 r13d r14d
..B1.39:                        # Preds ..B1.136
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.36
                                # LOE rbx r12 eax r13d r14d
..B1.137:                       # Preds ..B1.39
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #192.36
                                # LOE rbx r12 r13d r14d r15d
..B1.40:                        # Preds ..B1.137
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.41:                        # Preds ..B1.40
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #192.8
        vmovd     %r15d, %xmm1                                  #192.8
        vmovd     %r13d, %xmm2                                  #192.8
        vmovd     %r14d, %xmm3                                  #192.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #192.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #192.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #192.8
        vmovups   %xmm6, 432(%rsp)                              #192.8[spill]
#       rand(void)
        call      rand                                          #193.22
                                # LOE rbx r12 eax
..B1.139:                       # Preds ..B1.41
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #193.22
                                # LOE rbx r12 r14d
..B1.42:                        # Preds ..B1.139
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.29
                                # LOE rbx r12 eax r14d
..B1.140:                       # Preds ..B1.42
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #193.29
                                # LOE rbx r12 r13d r14d
..B1.43:                        # Preds ..B1.140
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.36
                                # LOE rbx r12 eax r13d r14d
..B1.141:                       # Preds ..B1.43
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #193.36
                                # LOE rbx r12 r13d r14d r15d
..B1.44:                        # Preds ..B1.141
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #193.8
        vmovd     %r15d, %xmm1                                  #193.8
        vmovd     %r13d, %xmm2                                  #193.8
        vmovd     %r14d, %xmm3                                  #193.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #193.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #193.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #193.8
        vmovups   %xmm6, 400(%rsp)                              #193.8[spill]
#       rand(void)
        call      rand                                          #194.22
                                # LOE rbx r12 eax
..B1.143:                       # Preds ..B1.45
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #194.22
                                # LOE rbx r12 r14d
..B1.46:                        # Preds ..B1.143
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.29
                                # LOE rbx r12 eax r14d
..B1.144:                       # Preds ..B1.46
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #194.29
                                # LOE rbx r12 r13d r14d
..B1.47:                        # Preds ..B1.144
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.36
                                # LOE rbx r12 eax r13d r14d
..B1.145:                       # Preds ..B1.47
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #194.36
                                # LOE rbx r12 r13d r14d r15d
..B1.48:                        # Preds ..B1.145
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.49:                        # Preds ..B1.48
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #194.8
        vmovd     %r15d, %xmm1                                  #194.8
        vmovd     %r13d, %xmm2                                  #194.8
        vmovd     %r14d, %xmm3                                  #194.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #194.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #194.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #194.8
        vmovups   %xmm6, 336(%rsp)                              #194.8[spill]
#       rand(void)
        call      rand                                          #195.22
                                # LOE rbx r12 eax
..B1.147:                       # Preds ..B1.49
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #195.22
                                # LOE rbx r12 r14d
..B1.50:                        # Preds ..B1.147
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #195.29
                                # LOE rbx r12 eax r14d
..B1.148:                       # Preds ..B1.50
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #195.29
                                # LOE rbx r12 r13d r14d
..B1.51:                        # Preds ..B1.148
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #195.36
                                # LOE rbx r12 eax r13d r14d
..B1.149:                       # Preds ..B1.51
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #195.36
                                # LOE rbx r12 r13d r14d r15d
..B1.52:                        # Preds ..B1.149
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #195.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.53:                        # Preds ..B1.52
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #195.8
        vmovd     %r15d, %xmm1                                  #195.8
        vmovd     %r13d, %xmm2                                  #195.8
        vmovd     %r14d, %xmm3                                  #195.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #195.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #195.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #195.8
        vmovups   %xmm6, 304(%rsp)                              #195.8[spill]
#       rand(void)
        call      rand                                          #196.22
                                # LOE rbx r12 eax
..B1.151:                       # Preds ..B1.53
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #196.22
                                # LOE rbx r12 r14d
..B1.54:                        # Preds ..B1.151
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #196.29
                                # LOE rbx r12 eax r14d
..B1.152:                       # Preds ..B1.54
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #196.29
                                # LOE rbx r12 r13d r14d
..B1.55:                        # Preds ..B1.152
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #196.36
                                # LOE rbx r12 eax r13d r14d
..B1.153:                       # Preds ..B1.55
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #196.36
                                # LOE rbx r12 r13d r14d r15d
..B1.56:                        # Preds ..B1.153
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #196.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.57:                        # Preds ..B1.56
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #196.8
        vmovd     %r15d, %xmm1                                  #196.8
        vmovd     %r13d, %xmm2                                  #196.8
        vmovd     %r14d, %xmm3                                  #196.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #196.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #196.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #196.8
        vmovups   %xmm6, 288(%rsp)                              #196.8[spill]
#       rand(void)
        call      rand                                          #197.22
                                # LOE rbx r12 eax
..B1.155:                       # Preds ..B1.57
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #197.22
                                # LOE rbx r12 r14d
..B1.58:                        # Preds ..B1.155
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #197.29
                                # LOE rbx r12 eax r14d
..B1.156:                       # Preds ..B1.58
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #197.29
                                # LOE rbx r12 r13d r14d
..B1.59:                        # Preds ..B1.156
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #197.36
                                # LOE rbx r12 eax r13d r14d
..B1.157:                       # Preds ..B1.59
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #197.36
                                # LOE rbx r12 r13d r14d r15d
..B1.60:                        # Preds ..B1.157
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #197.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.61:                        # Preds ..B1.60
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #197.8
        vmovd     %r15d, %xmm1                                  #197.8
        vmovd     %r13d, %xmm2                                  #197.8
        vmovd     %r14d, %xmm3                                  #197.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #197.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #197.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #197.8
        vmovups   %xmm6, 256(%rsp)                              #197.8[spill]
#       rand(void)
        call      rand                                          #198.22
                                # LOE rbx r12 eax
..B1.159:                       # Preds ..B1.61
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #198.22
                                # LOE rbx r12 r14d
..B1.62:                        # Preds ..B1.159
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #198.29
                                # LOE rbx r12 eax r14d
..B1.160:                       # Preds ..B1.62
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #198.29
                                # LOE rbx r12 r13d r14d
..B1.63:                        # Preds ..B1.160
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #198.36
                                # LOE rbx r12 eax r13d r14d
..B1.161:                       # Preds ..B1.63
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #198.36
                                # LOE rbx r12 r13d r14d r15d
..B1.64:                        # Preds ..B1.161
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #198.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.65:                        # Preds ..B1.64
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #198.8
        vmovd     %r15d, %xmm1                                  #198.8
        vmovd     %r13d, %xmm2                                  #198.8
        vmovd     %r14d, %xmm3                                  #198.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #198.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #198.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #198.8
        vmovups   %xmm6, 272(%rsp)                              #198.8[spill]
#       rand(void)
        call      rand                                          #199.22
                                # LOE rbx r12 eax
..B1.163:                       # Preds ..B1.65
                                # Execution count [1.00e+00]
        movl      %eax, %r14d                                   #199.22
                                # LOE rbx r12 r14d
..B1.66:                        # Preds ..B1.163
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #199.29
                                # LOE rbx r12 eax r14d
..B1.164:                       # Preds ..B1.66
                                # Execution count [1.00e+00]
        movl      %eax, %r13d                                   #199.29
                                # LOE rbx r12 r13d r14d
..B1.67:                        # Preds ..B1.164
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #199.36
                                # LOE rbx r12 eax r13d r14d
..B1.165:                       # Preds ..B1.67
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #199.36
                                # LOE rbx r12 r13d r14d r15d
..B1.68:                        # Preds ..B1.165
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #199.43
                                # LOE rbx r12 eax r13d r14d r15d
..B1.69:                        # Preds ..B1.68
                                # Execution count [9.00e-01]
        vmovd     %eax, %xmm0                                   #199.8
        vmovd     %r15d, %xmm1                                  #199.8
        vmovd     %r13d, %xmm2                                  #199.8
        vmovd     %r14d, %xmm3                                  #199.8
        vmovups   480(%rsp), %xmm7                              #203.17[spill]
        xorl      %eax, %eax                                    #201.3
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #199.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #199.8
        vpxor     448(%rsp), %xmm7, %xmm8                       #203.17[spill]
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #199.8
        vpxor     %xmm9, %xmm8, %xmm0                           #203.17
        vmovups   %xmm6, 240(%rsp)                              #199.8[spill]
                                # LOE rbx r12 eax xmm0
..B1.70:                        # Preds ..B1.70 ..B1.69
                                # Execution count [2.50e+00]
        lea       (%rax,%rax), %edx                             #203.5
        incl      %eax                                          #201.3
        shlq      $4, %rdx                                      #203.5
        vmovdqu   %xmm0, (%rbx,%rdx)                            #203.5
        vmovdqu   %xmm0, 16(%rbx,%rdx)                          #203.5
        cmpl      $4000000, %eax                                #201.3
        jb        ..B1.70       # Prob 63%                      #201.3
                                # LOE rbx r12 eax xmm0
..B1.71:                        # Preds ..B1.70
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #205.3
        movl      $16, %esi                                     #205.3
        movl      $8000000, %edx                                #205.3
        movq      %r12, %rcx                                    #205.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #205.3
                                # LOE rbx r12
..B1.72:                        # Preds ..B1.71
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.3, %edi                         #208.3
        xorl      %eax, %eax                                    #208.3
..___tag_value_main.13:
#       printf(const char *__restrict__, ...)
        call      printf                                        #208.3
..___tag_value_main.14:
                                # LOE rbx r12
..B1.73:                        # Preds ..B1.72
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #208.27
#       fflush(FILE *)
        call      fflush                                        #208.27
                                # LOE rbx r12
..B1.74:                        # Preds ..B1.73
                                # Execution count [1.00e+00]
        rdtscp                                                   #209.11
        shlq      $32, %rdx                                     #209.11
        orq       %rdx, %rax                                    #209.11
                                # LOE rax rbx r12
..B1.167:                       # Preds ..B1.74
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #209.11
        xorl      %edx, %edx                                    #210.3
        xorl      %eax, %eax                                    #210.3
                                # LOE rbx r8 r12
..B1.75:                        # Preds ..B1.167
                                # Execution count [9.00e-01]
        vmovups   480(%rsp), %xmm7                              #211.5[spill]
        vmovups   448(%rsp), %xmm6                              #211.5[spill]
        vmovups   416(%rsp), %xmm5                              #211.5[spill]
        vmovups   384(%rsp), %xmm4                              #211.5[spill]
        vmovups   368(%rsp), %xmm3                              #211.5[spill]
        vmovups   352(%rsp), %xmm2                              #211.5[spill]
        vmovups   320(%rsp), %xmm1                              #211.5[spill]
        vmovups   464(%rsp), %xmm0                              #211.5[spill]
        vpaddb    432(%rsp), %xmm7, %xmm7                       #211.5[spill]
        vpaddb    400(%rsp), %xmm6, %xmm6                       #211.5[spill]
        vpaddb    336(%rsp), %xmm5, %xmm5                       #211.5[spill]
        vpaddb    304(%rsp), %xmm4, %xmm4                       #211.5[spill]
        vpaddb    288(%rsp), %xmm3, %xmm3                       #211.5[spill]
        vpaddb    256(%rsp), %xmm2, %xmm2                       #211.5[spill]
        vpaddb    272(%rsp), %xmm1, %xmm1                       #211.5[spill]
        vpaddb    240(%rsp), %xmm0, %xmm0                       #211.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7
..B1.76:                        # Preds ..B1.76 ..B1.75
                                # Execution count [5.00e+00]
        incl      %edx                                          #210.3
        lea       (%rax,%rbx), %rsi                             #211.5
        vmovdqu   %xmm5, 32(%rsi)                               #211.5
        vmovdqu   %xmm4, 48(%rsi)                               #211.5
        vmovdqu   %xmm3, 64(%rsi)                               #211.5
        vmovdqu   %xmm2, 80(%rsi)                               #211.5
        vmovdqu   %xmm1, 96(%rsi)                               #211.5
        vmovdqu   %xmm0, 112(%rsi)                              #211.5
        addq      $128, %rax                                    #210.3
        vmovdqu   %xmm7, (%rsi)                                 #211.5
        vmovdqu   %xmm6, 16(%rsi)                               #211.5
        cmpl      $1000000, %edx                                #210.3
        jb        ..B1.75       # Prob 82%                      #210.3
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7
..B1.77:                        # Preds ..B1.76
                                # Execution count [1.00e+00]
        rdtscp                                                   #212.9
        shlq      $32, %rdx                                     #212.9
        orq       %rdx, %rax                                    #212.9
                                # LOE rax rbx r8 r12
..B1.78:                        # Preds ..B1.77
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #213.3
        movl      $.L_2__STRING.4, %edi                         #213.3
        movq      %rax, %rsi                                    #213.3
        xorl      %eax, %eax                                    #213.3
..___tag_value_main.15:
#       printf(const char *__restrict__, ...)
        call      printf                                        #213.3
..___tag_value_main.16:
                                # LOE rbx r12
..B1.79:                        # Preds ..B1.78
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #214.3
        movl      $16, %esi                                     #214.3
        movl      $8000000, %edx                                #214.3
        movq      %r12, %rcx                                    #214.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #214.3
                                # LOE rbx r12
..B1.80:                        # Preds ..B1.79
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.5, %edi                         #216.3
        xorl      %eax, %eax                                    #216.3
..___tag_value_main.17:
#       printf(const char *__restrict__, ...)
        call      printf                                        #216.3
..___tag_value_main.18:
                                # LOE rbx r12
..B1.81:                        # Preds ..B1.80
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #216.27
#       fflush(FILE *)
        call      fflush                                        #216.27
                                # LOE rbx r12
..B1.82:                        # Preds ..B1.81
                                # Execution count [1.00e+00]
        rdtscp                                                   #217.11
        shlq      $32, %rdx                                     #217.11
        orq       %rdx, %rax                                    #217.11
                                # LOE rax rbx r12
..B1.169:                       # Preds ..B1.82
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #217.11
        xorl      %edx, %edx                                    #218.3
        xorl      %eax, %eax                                    #218.3
                                # LOE rbx r8 r12
..B1.83:                        # Preds ..B1.169
                                # Execution count [9.00e-01]
        vmovups   464(%rsp), %xmm2                              #219.5[spill]
        vmovups   432(%rsp), %xmm0                              #219.5[spill]
        vmovups   480(%rsp), %xmm14                             #219.5[spill]
        vmovups   400(%rsp), %xmm3                              #219.5[spill]
        vmovups   448(%rsp), %xmm13                             #219.5[spill]
        vmovups   336(%rsp), %xmm7                              #219.5[spill]
        vpand     %xmm3, %xmm13, %xmm1                          #219.5
        vmovups   416(%rsp), %xmm5                              #219.5[spill]
        vmovups   304(%rsp), %xmm6                              #219.5[spill]
        vmovups   384(%rsp), %xmm9                              #219.5[spill]
        vpxor     240(%rsp), %xmm2, %xmm8                       #219.5[spill]
        vpxor     %xmm0, %xmm14, %xmm2                          #219.5
        vmovups   288(%rsp), %xmm15                             #219.5[spill]
        vpand     %xmm0, %xmm14, %xmm14                         #219.5
        vmovups   368(%rsp), %xmm10                             #219.5[spill]
        vpxor     %xmm3, %xmm13, %xmm0                          #219.5
        vpxor     %xmm7, %xmm5, %xmm13                          #219.5
        vpand     %xmm7, %xmm5, %xmm3                           #219.5
        vmovups   352(%rsp), %xmm7                              #219.5[spill]
        vpxor     %xmm6, %xmm9, %xmm12                          #219.5
        vpand     %xmm6, %xmm9, %xmm4                           #219.5
        vpxor     %xmm15, %xmm10, %xmm11                        #219.5
        vmovups   256(%rsp), %xmm9                              #219.5[spill]
        vpand     %xmm15, %xmm10, %xmm5                         #219.5
        vmovups   320(%rsp), %xmm15                             #219.5[spill]
        vpxor     %xmm9, %xmm7, %xmm10                          #219.5
        vpand     %xmm9, %xmm7, %xmm6                           #219.5
        vmovups   272(%rsp), %xmm7                              #219.5[spill]
        vpxor     %xmm7, %xmm15, %xmm9                          #219.5
        vpand     %xmm7, %xmm15, %xmm7                          #219.5
        vmovdqu   %xmm2, (%rsp)                                 #219.5[spill]
        vpxor     %xmm15, %xmm15, %xmm15                        #219.5
        vpxor     %xmm15, %xmm2, %xmm2                          #219.5
        vpxor     %xmm15, %xmm14, %xmm15                        #219.5
        vmovdqu   %xmm14, 160(%rsp)                             #219.5[spill]
        vpxor     %xmm15, %xmm0, %xmm14                         #219.5
        vmovdqu   %xmm0, 192(%rsp)                              #219.5[spill]
        vpand     %xmm0, %xmm15, %xmm0                          #219.5
        vmovdqu   %xmm1, 144(%rsp)                              #219.5[spill]
        vpxor     %xmm0, %xmm1, %xmm1                           #219.5
        vmovdqu   %xmm13, 224(%rsp)                             #219.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #219.5
        vpand     %xmm13, %xmm1, %xmm13                         #219.5
        vmovdqu   %xmm3, 96(%rsp)                               #219.5[spill]
        vpxor     %xmm13, %xmm3, %xmm3                          #219.5
        vmovdqu   %xmm12, 128(%rsp)                             #219.5[spill]
        vpxor     %xmm3, %xmm12, %xmm13                         #219.5
        vpand     %xmm12, %xmm3, %xmm12                         #219.5
        vmovdqu   %xmm4, 80(%rsp)                               #219.5[spill]
        vpxor     %xmm12, %xmm4, %xmm4                          #219.5
        vmovdqu   %xmm11, 208(%rsp)                             #219.5[spill]
        vpxor     %xmm4, %xmm11, %xmm3                          #219.5
        vpand     %xmm11, %xmm4, %xmm11                         #219.5
        vmovdqu   %xmm5, 64(%rsp)                               #219.5[spill]
        vpxor     %xmm11, %xmm5, %xmm5                          #219.5
        vpand     %xmm10, %xmm5, %xmm4                          #219.5
        vpxor     %xmm5, %xmm10, %xmm1                          #219.5
        vmovdqu   %xmm6, 48(%rsp)                               #219.5[spill]
        vpxor     %xmm4, %xmm6, %xmm6                           #219.5
        vmovdqu   %xmm9, 112(%rsp)                              #219.5[spill]
        vpxor     %xmm6, %xmm9, %xmm5                           #219.5
        vpand     %xmm9, %xmm6, %xmm9                           #219.5
        vmovdqu   %xmm7, 32(%rsp)                               #219.5[spill]
        vpxor     %xmm9, %xmm7, %xmm7                           #219.5
        vmovdqu   %xmm8, 16(%rsp)                               #219.5[spill]
        vpxor     %xmm7, %xmm8, %xmm4                           #219.5
        vmovdqu   %xmm10, 176(%rsp)                             #219.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm13 xmm14
..B1.84:                        # Preds ..B1.84 ..B1.83
                                # Execution count [5.00e+00]
        incl      %edx                                          #218.3
        lea       (%rax,%rbx), %rsi                             #219.5
        vmovdqu   %xmm0, 32(%rsi)                               #219.5
        vmovdqu   %xmm13, 48(%rsi)                              #219.5
        vmovdqu   %xmm3, 64(%rsi)                               #219.5
        vmovdqu   %xmm1, 80(%rsi)                               #219.5
        vmovdqu   %xmm5, 96(%rsi)                               #219.5
        vmovdqu   %xmm4, 112(%rsi)                              #219.5
        addq      $128, %rax                                    #218.3
        vmovdqu   %xmm2, (%rsi)                                 #219.5
        vmovdqu   %xmm14, 16(%rsi)                              #219.5
        cmpl      $1000000, %edx                                #218.3
        jb        ..B1.83       # Prob 82%                      #218.3
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm13 xmm14
..B1.85:                        # Preds ..B1.84
                                # Execution count [1.00e+00]
        rdtscp                                                   #220.9
        shlq      $32, %rdx                                     #220.9
        orq       %rdx, %rax                                    #220.9
                                # LOE rax rbx r8 r12
..B1.86:                        # Preds ..B1.85
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #221.3
        movl      $.L_2__STRING.4, %edi                         #221.3
        movq      %rax, %rsi                                    #221.3
        xorl      %eax, %eax                                    #221.3
..___tag_value_main.19:
#       printf(const char *__restrict__, ...)
        call      printf                                        #221.3
..___tag_value_main.20:
                                # LOE rbx r12
..B1.87:                        # Preds ..B1.86
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #222.3
        movl      $16, %esi                                     #222.3
        movl      $8000000, %edx                                #222.3
        movq      %r12, %rcx                                    #222.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #222.3
                                # LOE rbx r12
..B1.88:                        # Preds ..B1.87
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.6, %edi                         #224.3
        xorl      %eax, %eax                                    #224.3
..___tag_value_main.21:
#       printf(const char *__restrict__, ...)
        call      printf                                        #224.3
..___tag_value_main.22:
                                # LOE rbx r12
..B1.89:                        # Preds ..B1.88
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #224.27
#       fflush(FILE *)
        call      fflush                                        #224.27
                                # LOE rbx r12
..B1.90:                        # Preds ..B1.89
                                # Execution count [1.00e+00]
        rdtscp                                                   #225.11
        shlq      $32, %rdx                                     #225.11
        orq       %rdx, %rax                                    #225.11
                                # LOE rax rbx r12
..B1.171:                       # Preds ..B1.90
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #225.11
        xorl      %edx, %edx                                    #226.14
        xorl      %eax, %eax                                    #226.14
                                # LOE rbx r8 r12
..B1.91:                        # Preds ..B1.171
                                # Execution count [9.00e-01]
        vmovdqu   128(%rsp), %xmm14                             #227.5[spill]
        vmovdqu   208(%rsp), %xmm6                              #227.5[spill]
        vmovdqu   224(%rsp), %xmm15                             #227.5[spill]
        vpand     %xmm14, %xmm6, %xmm0                          #227.5
        vmovdqu   176(%rsp), %xmm7                              #227.5[spill]
        vpand     %xmm15, %xmm0, %xmm1                          #227.5
        vmovdqu   112(%rsp), %xmm8                              #227.5[spill]
        vpand     %xmm6, %xmm7, %xmm10                          #227.5
        vmovdqu   %xmm1, 304(%rsp)                              #227.5[spill]
        vpand     %xmm7, %xmm8, %xmm5                           #227.5
        vmovdqu   80(%rsp), %xmm1                               #227.5[spill]
        vpand     %xmm15, %xmm14, %xmm2                         #227.5
        vmovdqu   96(%rsp), %xmm13                              #227.5[spill]
        vpand     %xmm14, %xmm10, %xmm11                        #227.5
        vmovdqu   %xmm2, 288(%rsp)                              #227.5[spill]
        vpand     %xmm1, %xmm10, %xmm2                          #227.5
        vpand     %xmm6, %xmm5, %xmm10                          #227.5
        vpand     %xmm15, %xmm11, %xmm9                         #227.5
        vpand     %xmm13, %xmm11, %xmm3                         #227.5
        vpand     %xmm14, %xmm10, %xmm11                        #227.5
        vmovdqu   %xmm9, 320(%rsp)                              #227.5[spill]
        vpand     %xmm1, %xmm10, %xmm9                          #227.5
        vpand     %xmm13, %xmm11, %xmm10                        #227.5
        vpand     %xmm15, %xmm11, %xmm12                        #227.5
        vmovdqu   %xmm9, 336(%rsp)                              #227.5[spill]
        vpand     %xmm13, %xmm0, %xmm0                          #227.5
        vmovdqu   %xmm10, 368(%rsp)                             #227.5[spill]
        vmovdqu   160(%rsp), %xmm10                             #227.5[spill]
        vmovdqu   192(%rsp), %xmm9                              #227.5[spill]
        vmovdqu   %xmm12, 352(%rsp)                             #227.5[spill]
        vpxor     %xmm10, %xmm9, %xmm12                         #227.5
        vmovdqu   %xmm12, 240(%rsp)                             #227.5[spill]
        vpand     %xmm10, %xmm9, %xmm12                         #227.5
        vmovdqu   144(%rsp), %xmm11                             #227.5[spill]
        vpor      %xmm12, %xmm11, %xmm12                        #227.5
        vpxor     %xmm12, %xmm15, %xmm12                        #227.5
        vmovdqu   %xmm12, 256(%rsp)                             #227.5[spill]
        vpand     %xmm11, %xmm15, %xmm12                        #227.5
        vpand     %xmm9, %xmm15, %xmm15                         #227.5
        vpor      %xmm12, %xmm13, %xmm12                        #227.5
        vpand     %xmm10, %xmm15, %xmm15                        #227.5
        vpand     %xmm13, %xmm14, %xmm13                        #227.5
        vmovdqu   64(%rsp), %xmm4                               #227.5[spill]
        vpor      %xmm15, %xmm12, %xmm12                        #227.5
        vpor      %xmm13, %xmm1, %xmm15                         #227.5
        vpand     %xmm1, %xmm6, %xmm1                           #227.5
        vpxor     %xmm12, %xmm14, %xmm12                        #227.5
        vpor      %xmm1, %xmm4, %xmm14                          #227.5
        vpand     %xmm4, %xmm5, %xmm5                           #227.5
        vpor      %xmm0, %xmm14, %xmm14                         #227.5
        vmovdqu   48(%rsp), %xmm0                               #227.5[spill]
        vpand     %xmm4, %xmm7, %xmm4                           #227.5
        vpor      %xmm4, %xmm0, %xmm1                           #227.5
        vpor      %xmm2, %xmm1, %xmm2                           #227.5
        vpor      %xmm3, %xmm2, %xmm13                          #227.5
        vpand     %xmm0, %xmm8, %xmm3                           #227.5
        vpor      32(%rsp), %xmm3, %xmm2                        #227.5[spill]
        vmovdqu   288(%rsp), %xmm4                              #227.5[spill]
        vpor      %xmm5, %xmm2, %xmm1                           #227.5
        vpand     %xmm11, %xmm4, %xmm3                          #227.5
        vpand     %xmm9, %xmm4, %xmm5                           #227.5
        vpor      %xmm3, %xmm15, %xmm15                         #227.5
        vpand     %xmm10, %xmm5, %xmm2                          #227.5
        vpor      336(%rsp), %xmm1, %xmm0                       #227.5[spill]
        vpor      %xmm2, %xmm15, %xmm1                          #227.5
        vpxor     %xmm1, %xmm6, %xmm2                           #227.5
        vmovdqu   304(%rsp), %xmm1                              #227.5[spill]
        vmovdqu   %xmm12, 272(%rsp)                             #227.5[spill]
        vpand     %xmm11, %xmm1, %xmm6                          #227.5
        vpor      368(%rsp), %xmm0, %xmm12                      #227.5[spill]
        vpand     %xmm9, %xmm1, %xmm0                           #227.5
        vpor      %xmm6, %xmm14, %xmm3                          #227.5
        vpand     %xmm10, %xmm0, %xmm4                          #227.5
        vmovdqu   320(%rsp), %xmm0                              #227.5[spill]
        vpor      %xmm4, %xmm3, %xmm5                           #227.5
        vpxor     %xmm5, %xmm7, %xmm1                           #227.5
        vpand     %xmm11, %xmm0, %xmm7                          #227.5
        vpand     %xmm9, %xmm0, %xmm3                           #227.5
        vpor      %xmm7, %xmm13, %xmm4                          #227.5
        vpand     %xmm10, %xmm3, %xmm5                          #227.5
        vmovdqu   352(%rsp), %xmm3                              #227.5[spill]
        vpor      %xmm5, %xmm4, %xmm6                           #227.5
        vpxor     %xmm6, %xmm8, %xmm0                           #227.5
        vpand     %xmm11, %xmm3, %xmm8                          #227.5
        vpand     %xmm9, %xmm3, %xmm9                           #227.5
        vpor      %xmm8, %xmm12, %xmm4                          #227.5
        vpand     %xmm10, %xmm9, %xmm5                          #227.5
        vpor      %xmm5, %xmm4, %xmm6                           #227.5
        vpxor     16(%rsp), %xmm6, %xmm3                        #227.5[spill]
        vmovdqu   272(%rsp), %xmm4                              #227.5[spill]
        vmovdqu   256(%rsp), %xmm5                              #227.5[spill]
        vmovdqu   240(%rsp), %xmm6                              #227.5[spill]
        vmovdqu   (%rsp), %xmm7                                 #227.5[spill]
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7
..B1.92:                        # Preds ..B1.92 ..B1.91
                                # Execution count [5.00e+00]
        incl      %edx                                          #226.29
        lea       (%rax,%rbx), %rsi                             #227.5
        vmovdqu   %xmm5, 32(%rsi)                               #227.5
        vmovdqu   %xmm4, 48(%rsi)                               #227.5
        vmovdqu   %xmm2, 64(%rsi)                               #227.5
        vmovdqu   %xmm1, 80(%rsi)                               #227.5
        vmovdqu   %xmm0, 96(%rsi)                               #227.5
        vmovdqu   %xmm3, 112(%rsi)                              #227.5
        addq      $128, %rax                                    #226.29
        vmovdqu   %xmm7, (%rsi)                                 #227.5
        vmovdqu   %xmm6, 16(%rsi)                               #227.5
        cmpl      $1000000, %edx                                #226.23
        jl        ..B1.91       # Prob 82%                      #226.23
                                # LOE rax rbx r8 r12 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7
..B1.93:                        # Preds ..B1.92
                                # Execution count [1.00e+00]
        rdtscp                                                   #228.9
        shlq      $32, %rdx                                     #228.9
        orq       %rdx, %rax                                    #228.9
                                # LOE rax rbx r8 r12
..B1.94:                        # Preds ..B1.93
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #229.3
        movl      $.L_2__STRING.4, %edi                         #229.3
        movq      %rax, %rsi                                    #229.3
        xorl      %eax, %eax                                    #229.3
..___tag_value_main.23:
#       printf(const char *__restrict__, ...)
        call      printf                                        #229.3
..___tag_value_main.24:
                                # LOE rbx r12
..B1.95:                        # Preds ..B1.94
                                # Execution count [1.00e+00]
        movq      %rbx, %rdi                                    #230.3
        movl      $16, %esi                                     #230.3
        movl      $8000000, %edx                                #230.3
        movq      %r12, %rcx                                    #230.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #230.3
                                # LOE
..B1.96:                        # Preds ..B1.95
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #241.10
        addq      $600, %rsp                                    #241.10
	.cfi_restore 3
        popq      %rbx                                          #241.10
	.cfi_restore 15
        popq      %r15                                          #241.10
	.cfi_restore 14
        popq      %r14                                          #241.10
	.cfi_restore 13
        popq      %r13                                          #241.10
	.cfi_restore 12
        popq      %r12                                          #241.10
        movq      %rbp, %rsp                                    #241.10
        popq      %rbp                                          #241.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #241.10
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
# --- add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
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
# parameter 17: %rdi
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_pack.33:
..L34:
                                                         #15.30
        vpaddb    8(%rsp), %xmm0, %xmm8                         #16.12
        vpaddb    24(%rsp), %xmm1, %xmm9                        #17.12
        vpaddb    40(%rsp), %xmm2, %xmm10                       #18.12
        vpaddb    56(%rsp), %xmm3, %xmm11                       #19.12
        vpaddb    72(%rsp), %xmm4, %xmm12                       #20.12
        vpaddb    88(%rsp), %xmm5, %xmm13                       #21.12
        vpaddb    104(%rsp), %xmm6, %xmm14                      #22.12
        vpaddb    120(%rsp), %xmm7, %xmm15                      #23.12
        vmovdqu   %xmm8, (%rdi)                                 #16.3
        vmovdqu   %xmm9, 16(%rdi)                               #17.3
        vmovdqu   %xmm10, 32(%rdi)                              #18.3
        vmovdqu   %xmm11, 48(%rdi)                              #19.3
        vmovdqu   %xmm12, 64(%rdi)                              #20.3
        vmovdqu   %xmm13, 80(%rdi)                              #21.3
        vmovdqu   %xmm14, 96(%rdi)                              #22.3
        vmovdqu   %xmm15, 112(%rdi)                             #23.3
        ret                                                     #24.1
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
                                                         #27.47
        vpxor     %xmm1, %xmm0, %xmm5                           #28.21
        vmovdqu   (%rdi), %xmm6                                 #29.24
        vpand     %xmm1, %xmm0, %xmm2                           #30.10
        vpand     %xmm5, %xmm6, %xmm3                           #30.17
        vpxor     %xmm6, %xmm5, %xmm0                           #29.24
        vpxor     %xmm3, %xmm2, %xmm4                           #30.17
        vmovdqu   %xmm4, (%rdi)                                 #30.4
        ret                                                     #31.10
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
# --- add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
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
# parameter 17: %rdi
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bitslice.39:
..L40:
                                                         #38.34
        vmovdqu   8(%rsp), %xmm8                                #38.34
        vpxor     %xmm9, %xmm9, %xmm9                           #39.15
        vmovdqu   24(%rsp), %xmm11                              #38.34
        vpxor     120(%rsp), %xmm7, %xmm10                      #47.12
        vpxor     %xmm8, %xmm0, %xmm7                           #40.12
        vpand     %xmm8, %xmm0, %xmm8                           #40.12
        vpxor     %xmm9, %xmm7, %xmm7                           #40.12
        vpxor     %xmm9, %xmm8, %xmm0                           #40.12
        vpxor     %xmm11, %xmm1, %xmm8                          #41.12
        vmovdqu   40(%rsp), %xmm12                              #38.34
        vpand     %xmm11, %xmm1, %xmm1                          #41.12
        vpand     %xmm8, %xmm0, %xmm11                          #41.12
        vpxor     %xmm0, %xmm8, %xmm9                           #41.12
        vpxor     %xmm11, %xmm1, %xmm0                          #41.12
        vpxor     %xmm12, %xmm2, %xmm1                          #42.12
        vmovdqu   56(%rsp), %xmm13                              #38.34
        vpand     %xmm12, %xmm2, %xmm2                          #42.12
        vpand     %xmm1, %xmm0, %xmm12                          #42.12
        vmovdqu   %xmm7, (%rdi)                                 #40.3
        vpxor     %xmm0, %xmm1, %xmm7                           #42.12
        vpxor     %xmm12, %xmm2, %xmm0                          #42.12
        vpxor     %xmm13, %xmm3, %xmm1                          #43.12
        vmovdqu   72(%rsp), %xmm14                              #38.34
        vpand     %xmm13, %xmm3, %xmm3                          #43.12
        vpand     %xmm1, %xmm0, %xmm13                          #43.12
        vpxor     %xmm0, %xmm1, %xmm2                           #43.12
        vpxor     %xmm13, %xmm3, %xmm0                          #43.12
        vpxor     %xmm14, %xmm4, %xmm1                          #44.12
        vmovdqu   88(%rsp), %xmm15                              #38.34
        vpand     %xmm14, %xmm4, %xmm4                          #44.12
        vpand     %xmm1, %xmm0, %xmm14                          #44.12
        vpxor     %xmm0, %xmm1, %xmm3                           #44.12
        vpxor     %xmm14, %xmm4, %xmm0                          #44.12
        vpxor     %xmm15, %xmm5, %xmm1                          #45.12
        vmovdqu   %xmm2, 48(%rdi)                               #43.3
        vpxor     %xmm0, %xmm1, %xmm2                           #45.12
        vpand     %xmm15, %xmm5, %xmm5                          #45.12
        vpand     %xmm1, %xmm0, %xmm15                          #45.12
        vmovdqu   104(%rsp), %xmm1                              #46.12
        vmovdqu   %xmm3, 64(%rdi)                               #44.3
        vpxor     %xmm15, %xmm5, %xmm3                          #45.12
        vpxor     %xmm1, %xmm6, %xmm4                           #46.12
        vpand     %xmm1, %xmm6, %xmm6                           #46.12
        vpxor     %xmm3, %xmm4, %xmm0                           #46.12
        vmovdqu   %xmm0, 96(%rdi)                               #46.3
        vpand     %xmm4, %xmm3, %xmm0                           #46.12
        vpxor     %xmm0, %xmm6, %xmm1                           #46.12
        vpxor     %xmm1, %xmm10, %xmm10                         #47.12
        vmovdqu   %xmm9, 16(%rdi)                               #41.3
        vmovdqu   %xmm7, 32(%rdi)                               #42.3
        vmovdqu   %xmm2, 80(%rdi)                               #45.3
        vmovdqu   %xmm10, 112(%rdi)                             #47.3
        ret                                                     #48.1
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
# --- add_lookahead(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
add_lookahead:
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
# parameter 17: %rdi
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_lookahead.42:
..L43:
                                                         #54.35
        vmovdqa   %xmm1, %xmm13                                 #54.35
        vmovdqu   8(%rsp), %xmm14                               #54.35
        vmovdqa   %xmm0, %xmm15                                 #54.35
        vmovdqu   24(%rsp), %xmm12                              #54.35
        vpxor     %xmm14, %xmm15, %xmm0                         #55.21
        vpand     %xmm14, %xmm15, %xmm15                        #64.21
        vpxor     %xmm12, %xmm13, %xmm14                        #56.21
        vmovdqu   40(%rsp), %xmm1                               #54.35
        vpand     %xmm12, %xmm13, %xmm13                        #65.21
        vmovdqu   %xmm0, (%rdi)                                 #80.3
        vpxor     %xmm15, %xmm14, %xmm0                         #81.17
        vmovdqu   56(%rsp), %xmm8                               #54.35
        vpxor     %xmm1, %xmm2, %xmm12                          #57.21
        vmovdqu   72(%rsp), %xmm11                              #54.35
        vpand     %xmm1, %xmm2, %xmm2                           #66.21
        vmovdqu   88(%rsp), %xmm9                               #54.35
        vpxor     %xmm8, %xmm3, %xmm1                           #58.21
        vmovdqu   104(%rsp), %xmm10                             #54.35
        vpand     %xmm8, %xmm3, %xmm3                           #67.21
        vmovdqu   %xmm0, 16(%rdi)                               #81.3
        vpand     %xmm15, %xmm14, %xmm0                         #73.24
        vpxor     %xmm11, %xmm4, %xmm8                          #59.21
        vpand     %xmm11, %xmm4, %xmm4                          #68.21
        vpxor     %xmm9, %xmm5, %xmm11                          #60.21
        vpand     %xmm9, %xmm5, %xmm5                           #69.21
        vpxor     %xmm10, %xmm6, %xmm9                          #61.21
        vpand     %xmm10, %xmm6, %xmm6                          #70.21
        vpor      %xmm0, %xmm13, %xmm10                         #73.24
        vpand     %xmm13, %xmm12, %xmm0                         #74.24
        vpxor     %xmm10, %xmm12, %xmm10                        #82.17
        vmovdqu   %xmm10, 32(%rdi)                              #82.3
        vpor      %xmm0, %xmm2, %xmm10                          #74.24
        vpand     %xmm14, %xmm12, %xmm0                         #74.32
        vpand     %xmm15, %xmm0, %xmm0                          #74.35
        vpor      %xmm0, %xmm10, %xmm10                         #74.35
        vpand     %xmm2, %xmm1, %xmm0                           #75.24
        vpxor     %xmm10, %xmm1, %xmm10                         #83.17
        vpor      %xmm0, %xmm3, %xmm0                           #75.24
        vmovdqu   %xmm10, 48(%rdi)                              #83.3
        vpand     %xmm12, %xmm1, %xmm10                         #75.32
        vpxor     120(%rsp), %xmm7, %xmm7                       #62.21
        vmovdqu   %xmm7, -24(%rsp)                              #62.21[spill]
        vpand     %xmm13, %xmm10, %xmm7                         #75.35
        vpand     %xmm14, %xmm10, %xmm10                        #75.46
        vpor      %xmm7, %xmm0, %xmm7                           #75.35
        vpand     %xmm15, %xmm10, %xmm0                         #75.49
        vpor      %xmm0, %xmm7, %xmm10                          #75.49
        vpxor     %xmm10, %xmm8, %xmm7                          #84.17
        vpand     %xmm1, %xmm8, %xmm10                          #76.32
        vmovdqu   %xmm7, 64(%rdi)                               #84.3
        vpand     %xmm12, %xmm10, %xmm0                         #76.60
        vpand     %xmm2, %xmm10, %xmm7                          #76.35
        vpand     %xmm3, %xmm8, %xmm10                          #76.24
        vpor      %xmm10, %xmm4, %xmm10                         #76.24
        vpor      %xmm7, %xmm10, %xmm7                          #76.35
        vpand     %xmm13, %xmm0, %xmm10                         #76.49
        vpand     %xmm14, %xmm0, %xmm0                          #76.63
        vpor      %xmm10, %xmm7, %xmm10                         #76.49
        vpand     %xmm15, %xmm0, %xmm7                          #76.66
        vpor      %xmm7, %xmm10, %xmm10                         #76.66
        vpand     %xmm8, %xmm11, %xmm7                          #77.32
        vpxor     %xmm10, %xmm11, %xmm0                         #85.17
        vmovdqu   %xmm0, 80(%rdi)                               #85.3
        vpand     %xmm1, %xmm7, %xmm0                           #77.77
        vmovdqu   %xmm2, -40(%rsp)                              #66.21[spill]
        vpand     %xmm12, %xmm0, %xmm10                         #77.63
        vpand     %xmm2, %xmm0, %xmm2                           #77.49
        vpand     %xmm4, %xmm11, %xmm0                          #77.24
        vpand     %xmm3, %xmm7, %xmm7                           #77.35
        vpor      %xmm0, %xmm5, %xmm0                           #77.24
        vpor      %xmm7, %xmm0, %xmm7                           #77.35
        vpand     %xmm13, %xmm10, %xmm0                         #77.66
        vpor      %xmm2, %xmm7, %xmm7                           #77.49
        vpand     %xmm14, %xmm10, %xmm10                        #77.83
        vpand     %xmm11, %xmm9, %xmm11                         #78.32
        vpor      %xmm0, %xmm7, %xmm2                           #77.66
        vpand     %xmm15, %xmm10, %xmm7                         #77.86
        vpand     %xmm5, %xmm9, %xmm5                           #78.24
        vpand     %xmm8, %xmm11, %xmm8                          #78.97
        vpand     %xmm4, %xmm11, %xmm4                          #78.35
        vpor      %xmm7, %xmm2, %xmm11                          #77.86
        vpor      %xmm5, %xmm6, %xmm6                           #78.24
        vpxor     %xmm11, %xmm9, %xmm0                          #86.17
        vpand     %xmm1, %xmm8, %xmm1                           #78.63
        vpor      %xmm4, %xmm6, %xmm9                           #78.35
        vpand     %xmm3, %xmm8, %xmm3                           #78.49
        vmovdqu   %xmm0, 96(%rdi)                               #86.3
        vpand     %xmm12, %xmm1, %xmm12                         #78.103
        vpand     -40(%rsp), %xmm1, %xmm1                       #78.66[spill]
        vpor      %xmm3, %xmm9, %xmm0                           #78.49
        vpor      %xmm1, %xmm0, %xmm2                           #78.66
        vpand     %xmm13, %xmm12, %xmm13                        #78.86
        vpand     %xmm14, %xmm12, %xmm12                        #78.106
        vpor      %xmm13, %xmm2, %xmm0                          #78.86
        vpand     %xmm15, %xmm12, %xmm4                         #78.109
        vpor      %xmm4, %xmm0, %xmm8                           #78.109
        vpxor     -24(%rsp), %xmm8, %xmm14                      #87.17[spill]
        vmovdqu   %xmm14, 112(%rdi)                             #87.3
        ret                                                     #88.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_lookahead,@function
	.size	add_lookahead,.-add_lookahead
	.data
# -- End  add_lookahead
	.text
# -- Begin  add_lookahead_reschedul
	.text
# mark_begin;
       .align    16,0x90
	.globl add_lookahead_reschedul
# --- add_lookahead_reschedul(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *)
add_lookahead_reschedul:
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
# parameter 17: %rdi
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_lookahead_reschedul.45:
..L46:
                                                         #95.35
        vmovdqa   %xmm1, %xmm13                                 #95.35
        vmovdqu   8(%rsp), %xmm12                               #95.35
        vmovdqu   24(%rsp), %xmm14                              #95.35
        vpxor     %xmm12, %xmm0, %xmm15                         #96.21
        vmovdqu   %xmm15, (%rdi)                                #97.3
        vpand     %xmm12, %xmm0, %xmm0                          #100.21
        vpxor     %xmm14, %xmm13, %xmm15                        #101.21
        vpand     %xmm14, %xmm13, %xmm14                        #105.21
        vmovdqu   40(%rsp), %xmm9                               #95.35
        vpand     %xmm0, %xmm15, %xmm12                         #106.24
        vpxor     %xmm0, %xmm15, %xmm10                         #103.17
        vpxor     %xmm9, %xmm2, %xmm13                          #107.21
        vmovdqu   56(%rsp), %xmm11                              #95.35
        vmovdqu   %xmm10, 16(%rdi)                              #103.3
        vpand     %xmm9, %xmm2, %xmm10                          #110.21
        vpor      %xmm12, %xmm14, %xmm9                         #106.24
        vpand     %xmm14, %xmm13, %xmm12                        #111.24
        vpxor     %xmm9, %xmm13, %xmm2                          #108.17
        vpxor     %xmm11, %xmm3, %xmm9                          #112.21
        vpand     %xmm11, %xmm3, %xmm11                         #115.21
        vpand     %xmm15, %xmm13, %xmm3                         #111.32
        vmovdqu   %xmm2, 32(%rdi)                               #108.3
        vpor      %xmm12, %xmm10, %xmm12                        #111.24
        vpand     %xmm0, %xmm3, %xmm2                           #111.35
        vpor      %xmm2, %xmm12, %xmm3                          #111.35
        vmovdqu   72(%rsp), %xmm1                               #95.35
        vpxor     %xmm3, %xmm9, %xmm12                          #113.17
        vpxor     120(%rsp), %xmm7, %xmm7                       #131.21
        vpand     %xmm13, %xmm9, %xmm3                          #116.32
        vmovdqu   %xmm12, 48(%rdi)                              #113.3
        vpxor     %xmm1, %xmm4, %xmm12                          #117.21
        vpand     %xmm1, %xmm4, %xmm4                           #120.21
        vpand     %xmm10, %xmm9, %xmm1                          #116.24
        vmovdqu   %xmm7, -24(%rsp)                              #131.21[spill]
        vpor      %xmm1, %xmm11, %xmm2                          #116.24
        vpand     %xmm14, %xmm3, %xmm7                          #116.35
        vpor      %xmm7, %xmm2, %xmm1                           #116.35
        vpand     %xmm15, %xmm3, %xmm2                          #116.46
        vpand     %xmm0, %xmm2, %xmm3                           #116.49
        vpor      %xmm3, %xmm1, %xmm7                           #116.49
        vpand     %xmm9, %xmm12, %xmm1                          #121.32
        vmovdqu   88(%rsp), %xmm8                               #95.35
        vpand     %xmm11, %xmm12, %xmm3                         #121.24
        vpxor     %xmm7, %xmm12, %xmm2                          #118.17
        vpxor     %xmm8, %xmm5, %xmm7                           #122.21
        vmovdqu   %xmm2, 64(%rdi)                               #118.3
        vpand     %xmm8, %xmm5, %xmm5                           #125.21
        vpand     %xmm13, %xmm1, %xmm8                          #121.60
        vpand     %xmm10, %xmm1, %xmm1                          #121.35
        vpor      %xmm3, %xmm4, %xmm2                           #121.24
        vpor      %xmm1, %xmm2, %xmm3                           #121.35
        vpand     %xmm14, %xmm8, %xmm2                          #121.49
        vpand     %xmm15, %xmm8, %xmm8                          #121.63
        vpor      %xmm2, %xmm3, %xmm1                           #121.49
        vpand     %xmm0, %xmm8, %xmm2                           #121.66
        vpor      %xmm2, %xmm1, %xmm8                           #121.66
        vpand     %xmm12, %xmm7, %xmm1                          #126.32
        vmovdqu   104(%rsp), %xmm2                              #127.21
        vpxor     %xmm8, %xmm7, %xmm3                           #123.17
        vpxor     %xmm2, %xmm6, %xmm8                           #127.21
        vpand     %xmm2, %xmm6, %xmm2                           #130.21
        vpand     %xmm9, %xmm1, %xmm6                           #126.77
        vmovdqu   %xmm10, -40(%rsp)                             #110.21[spill]
        vpand     %xmm10, %xmm6, %xmm10                         #126.49
        vmovdqu   %xmm3, 80(%rdi)                               #123.3
        vpand     %xmm11, %xmm1, %xmm3                          #126.35
        vpand     %xmm13, %xmm6, %xmm1                          #126.63
        vpand     %xmm4, %xmm7, %xmm6                           #126.24
        vpor      %xmm6, %xmm5, %xmm6                           #126.24
        vpand     %xmm5, %xmm8, %xmm5                           #132.24
        vpor      %xmm3, %xmm6, %xmm3                           #126.35
        vpor      %xmm10, %xmm3, %xmm10                         #126.49
        vpand     %xmm7, %xmm8, %xmm3                           #132.32
        vpand     %xmm12, %xmm3, %xmm7                          #132.97
        vpand     %xmm4, %xmm3, %xmm12                          #132.35
        vpand     %xmm14, %xmm1, %xmm4                          #126.66
        vpand     %xmm15, %xmm1, %xmm1                          #126.83
        vpor      %xmm4, %xmm10, %xmm3                          #126.66
        vpand     %xmm0, %xmm1, %xmm4                           #126.86
        vpor      %xmm5, %xmm2, %xmm1                           #132.24
        vpand     %xmm9, %xmm7, %xmm9                           #132.63
        vpor      %xmm12, %xmm1, %xmm2                          #132.35
        vpand     %xmm11, %xmm7, %xmm11                         #132.49
        vpand     %xmm13, %xmm9, %xmm13                         #132.103
        vpor      %xmm11, %xmm2, %xmm1                          #132.49
        vpand     -40(%rsp), %xmm9, %xmm2                       #132.66[spill]
        vpor      %xmm4, %xmm3, %xmm6                           #126.86
        vpor      %xmm2, %xmm1, %xmm3                           #132.66
        vpand     %xmm14, %xmm13, %xmm14                        #132.86
        vpand     %xmm15, %xmm13, %xmm13                        #132.106
        vpor      %xmm14, %xmm3, %xmm1                          #132.86
        vpand     %xmm0, %xmm13, %xmm15                         #132.109
        vpxor     %xmm6, %xmm8, %xmm10                          #128.17
        vpor      %xmm15, %xmm1, %xmm0                          #132.109
        vpxor     -24(%rsp), %xmm0, %xmm1                       #133.17[spill]
        vmovdqu   %xmm10, 96(%rdi)                              #128.3
        vmovdqu   %xmm1, 112(%rdi)                              #133.3
        ret                                                     #134.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_lookahead_reschedul,@function
	.size	add_lookahead_reschedul,.-add_lookahead_reschedul
	.data
# -- End  add_lookahead_reschedul
	.text
# -- Begin  lookahead_sound
	.text
# mark_begin;
       .align    16,0x90
	.globl lookahead_sound
# --- lookahead_sound()
lookahead_sound:
..B7.1:                         # Preds ..B7.0
                                # Execution count [4.17e-01]
	.cfi_startproc
..___tag_value_lookahead_sound.48:
..L49:
                                                         #136.24
        pushq     %rsi                                          #136.24
	.cfi_def_cfa_offset 16
        vpxor     %xmm8, %xmm8, %xmm8                           #160.3
        vpxor     %xmm8, %xmm8, %xmm7                           #160.3
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm14            #141.8
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm13            #142.8
        vpxor     %xmm8, %xmm14, %xmm6                          #160.3
        vmovdqu   .L_2il0floatpacket.2(%rip), %xmm12            #143.8
        vpxor     %xmm8, %xmm13, %xmm5                          #160.3
        vmovdqu   .L_2il0floatpacket.3(%rip), %xmm11            #144.8
        vpxor     %xmm8, %xmm12, %xmm4                          #160.3
        vmovdqu   .L_2il0floatpacket.5(%rip), %xmm10            #146.8
        vpxor     %xmm8, %xmm11, %xmm3                          #160.3
        vmovdqu   .L_2il0floatpacket.6(%rip), %xmm9             #147.8
        vpxor     %xmm8, %xmm10, %xmm1                          #160.3
        vpcmpeqq  %xmm8, %xmm7, %xmm15                          #163.9
        vpxor     %xmm8, %xmm9, %xmm0                           #160.3
        vpcmpeqd  %xmm7, %xmm7, %xmm7                           #163.9
        vpxor     %xmm6, %xmm8, %xmm6                           #160.3
        vpxor     .L_2il0floatpacket.4(%rip), %xmm8, %xmm2      #160.3
        vpxor     %xmm5, %xmm8, %xmm5                           #160.3
        vpxor     %xmm4, %xmm8, %xmm4                           #160.3
        vpxor     %xmm3, %xmm8, %xmm3                           #160.3
        vpxor     %xmm2, %xmm8, %xmm2                           #160.3
        vpxor     %xmm1, %xmm8, %xmm1                           #160.3
        vpxor     %xmm0, %xmm8, %xmm0                           #160.3
        vptest    %xmm7, %xmm15                                 #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B7.2:                         # Preds ..B7.1
                                # Execution count [4.17e-01]
        vpxor     %xmm14, %xmm8, %xmm7                          #161.3
        vpcmpeqq  %xmm7, %xmm6, %xmm6                           #163.9
        vpcmpeqd  %xmm14, %xmm14, %xmm14                        #163.9
        vptest    %xmm14, %xmm6                                 #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B7.3:                         # Preds ..B7.2
                                # Execution count [4.17e-01]
        vpxor     %xmm13, %xmm8, %xmm6                          #161.3
        vpcmpeqq  %xmm6, %xmm5, %xmm5                           #163.9
        vpcmpeqd  %xmm7, %xmm7, %xmm7                           #163.9
        vptest    %xmm7, %xmm5                                  #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm8 xmm9 xmm10 xmm11 xmm12
..B7.4:                         # Preds ..B7.3
                                # Execution count [4.17e-01]
        vpxor     %xmm12, %xmm8, %xmm5                          #161.3
        vpcmpeqq  %xmm5, %xmm4, %xmm4                           #163.9
        vpcmpeqd  %xmm6, %xmm6, %xmm6                           #163.9
        vptest    %xmm6, %xmm4                                  #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm8 xmm9 xmm10 xmm11
..B7.5:                         # Preds ..B7.4
                                # Execution count [4.17e-01]
        vpxor     %xmm11, %xmm8, %xmm4                          #161.3
        vpcmpeqq  %xmm4, %xmm3, %xmm3                           #163.9
        vpcmpeqd  %xmm5, %xmm5, %xmm5                           #163.9
        vptest    %xmm5, %xmm3                                  #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm8 xmm9 xmm10
..B7.6:                         # Preds ..B7.5
                                # Execution count [4.17e-01]
        vpxor     .L_2il0floatpacket.4(%rip), %xmm8, %xmm3      #161.3
        vpcmpeqq  %xmm3, %xmm2, %xmm2                           #163.9
        vpcmpeqd  %xmm4, %xmm4, %xmm4                           #163.9
        vptest    %xmm4, %xmm2                                  #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm1 xmm8 xmm9 xmm10
..B7.7:                         # Preds ..B7.6
                                # Execution count [4.17e-01]
        vpxor     %xmm10, %xmm8, %xmm2                          #161.3
        vpcmpeqq  %xmm2, %xmm1, %xmm1                           #163.9
        vpcmpeqd  %xmm3, %xmm3, %xmm3                           #163.9
        vptest    %xmm3, %xmm1                                  #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15 xmm0 xmm8 xmm9
..B7.8:                         # Preds ..B7.7
                                # Execution count [4.17e-01]
        vpxor     %xmm9, %xmm8, %xmm1                           #161.3
        vpcmpeqq  %xmm1, %xmm0, %xmm0                           #163.9
        vpcmpeqd  %xmm2, %xmm2, %xmm2                           #163.9
        vptest    %xmm2, %xmm0                                  #163.9
        je        ..B7.10       # Prob 20%                      #163.9
                                # LOE rbx rbp r12 r13 r14 r15
..B7.9:                         # Preds ..B7.8
                                # Execution count [3.33e-01]
        popq      %rcx                                          #168.1
	.cfi_def_cfa_offset 8
        ret                                                     #168.1
	.cfi_def_cfa_offset 16
                                # LOE
..B7.10:                        # Preds ..B7.1 ..B7.2 ..B7.3 ..B7.4 ..B7.5
                                #       ..B7.6 ..B7.7 ..B7.8
                                # Execution count [8.33e-02]: Infreq
        movl      $.L_2__STRING.0, %edi                         #165.7
        xorl      %eax, %eax                                    #165.7
..___tag_value_lookahead_sound.53:
#       printf(const char *__restrict__, ...)
        call      printf                                        #165.7
..___tag_value_lookahead_sound.54:
                                # LOE
..B7.11:                        # Preds ..B7.10
                                # Execution count [8.33e-02]: Infreq
        movl      $1, %edi                                      #166.7
#       exit(int)
        call      exit                                          #166.7
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	lookahead_sound,@function
	.size	lookahead_sound,.-lookahead_sound
	.data
# -- End  lookahead_sound
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.0:
	.long	0xaaaaaaaa,0xaaaaaaaa,0xaaaaaaaa,0xaaaaaaaa
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,16
	.align 16
.L_2il0floatpacket.1:
	.long	0xcccccccc,0xcccccccc,0xcccccccc,0xcccccccc
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,16
	.align 16
.L_2il0floatpacket.2:
	.long	0xe38e38e3,0x38e38e38,0x8e38e38e,0xe38e38e3
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,16
	.align 16
.L_2il0floatpacket.3:
	.long	0xf0f0f0f0,0xf0f0f0f0,0xf0f0f0f0,0xf0f0f0f0
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,16
	.align 16
.L_2il0floatpacket.4:
	.long	0x0f83e0f8,0x83e0f83e,0xe0f83e0f,0xf83e0f83
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,16
	.align 16
.L_2il0floatpacket.5:
	.long	0xfc0fc0fc,0xc0fc0fc0,0x0fc0fc0f,0xfc0fc0fc
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,16
	.align 16
.L_2il0floatpacket.6:
	.long	0x3f80fe03,0x03f80fe0,0xe03f80fe,0xfe03f80f
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,16
	.align 16
.L_2il0floatpacket.7:
	.long	0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,16
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.1:
	.long	1986356271
	.long	1819635247
	.word	108
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,10
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.word	119
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,2
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	1801675088
	.long	774792293
	.long	774778414
	.word	32
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.4:
	.long	175467557
	.byte	0
	.type	.L_2__STRING.4,@object
	.size	.L_2__STRING.4,5
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.5:
	.long	1937008962
	.long	1701013868
	.long	774778468
	.word	32
	.type	.L_2__STRING.5,@object
	.size	.L_2__STRING.5,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.6:
	.long	1802465100
	.long	1634035809
	.long	774778468
	.word	32
	.type	.L_2__STRING.6,@object
	.size	.L_2__STRING.6,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.0:
	.long	1869835861
	.long	778333813
	.byte	0
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,9
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
# End
