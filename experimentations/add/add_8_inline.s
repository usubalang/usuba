	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "-Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -fno-inline -O3 -g -S -o ";
# mark_description "add_8_inline.s";
	.file "add_8.c"
	.text
..TXTST0:
.L_2__routine_start_main_0:
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
..___tag_value_main.2:
..L3:
                                                          #162.13
..LN0:
	.file   1 "add_8.c"
	.loc    1  162  is_stmt 1
        pushq     %rbp                                          #162.13
	.cfi_def_cfa_offset 16
..LN1:
        movq      %rsp, %rbp                                    #162.13
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN2:
        andq      $-128, %rsp                                   #162.13
..LN3:
        pushq     %r12                                          #162.13
..LN4:
        pushq     %r13                                          #162.13
..LN5:
        pushq     %r14                                          #162.13
..LN6:
        pushq     %r15                                          #162.13
..LN7:
        pushq     %rbx                                          #162.13
..LN8:
        subq      $344, %rsp                                    #162.13
..LN9:
        movl      $10330110, %esi                               #162.13
..LN10:
        movl      $3, %edi                                      #162.13
..LN11:
        call      __intel_new_feature_proc_init                 #162.13
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
..LN12:
                                # LOE
..B1.110:                       # Preds ..B1.1
                                # Execution count [1.00e+00]
..LN13:
        vstmxcsr  (%rsp)                                        #162.13
..LN14:
	.loc    1  166  prologue_end  is_stmt 1
        movl      $.L_2__STRING.0, %edi                         #166.13
..LN15:
        movl      $.L_2__STRING.1, %esi                         #166.13
..LN16:
	.loc    1  162  is_stmt 1
        orl       $32832, (%rsp)                                #162.13
..LN17:
        vldmxcsr  (%rsp)                                        #162.13
..LN18:
	.loc    1  166  is_stmt 1
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #166.13
..LN19:
                                # LOE rax
..B1.109:                       # Preds ..B1.110
                                # Execution count [1.00e+00]
..LN20:
        movq      %rax, %rbx                                    #166.13
..LN21:
                                # LOE rbx
..B1.2:                         # Preds ..B1.109
                                # Execution count [1.00e+00]
..LN22:
	.loc    1  172  is_stmt 1
        xorl      %edi, %edi                                    #172.9
..LN23:
#       time(time_t *)
        call      time                                          #172.9
..LN24:
                                # LOE rax rbx
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
..LN25:
        movl      %eax, %edi                                    #172.3
..LN26:
#       srand(unsigned int)
        call      srand                                         #172.3
..LN27:
                                # LOE rbx
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
..LN28:
	.loc    1  173  is_stmt 1
        movl      $32, %edi                                     #173.30
..LN29:
        movl      $12800000, %esi                               #173.30
..___tag_value_main.13:
..LN30:
#       aligned_alloc(size_t, size_t)
        call      aligned_alloc                                 #173.30
..___tag_value_main.14:
..LN31:
                                # LOE rax rbx
..B1.112:                       # Preds ..B1.4
                                # Execution count [1.00e+00]
..LN32:
        movq      %rax, %r12                                    #173.30
..LN33:
                                # LOE rbx r12
..B1.5:                         # Preds ..B1.112
                                # Execution count [1.00e+00]
..LN34:
	.loc    1  175  is_stmt 1
#       rand(void)
        call      rand                                          #175.22
..LN35:
                                # LOE rbx r12 eax
..B1.113:                       # Preds ..B1.5
                                # Execution count [1.00e+00]
..LN36:
        movl      %eax, %r15d                                   #175.22
..LN37:
                                # LOE rbx r12 r15d
..B1.6:                         # Preds ..B1.113
                                # Execution count [1.00e+00]
..LN38:
#       rand(void)
        call      rand                                          #175.29
..LN39:
                                # LOE rbx r12 eax r15d
..B1.114:                       # Preds ..B1.6
                                # Execution count [1.00e+00]
..LN40:
        movl      %eax, %r14d                                   #175.29
..LN41:
                                # LOE rbx r12 r14d r15d
..B1.7:                         # Preds ..B1.114
                                # Execution count [1.00e+00]
..LN42:
#       rand(void)
        call      rand                                          #175.36
..LN43:
                                # LOE rbx r12 eax r14d r15d
..B1.115:                       # Preds ..B1.7
                                # Execution count [1.00e+00]
..LN44:
        movl      %eax, %r13d                                   #175.36
..LN45:
                                # LOE rbx r12 r13d r14d r15d
..B1.8:                         # Preds ..B1.115
                                # Execution count [1.00e+00]
..LN46:
#       rand(void)
        call      rand                                          #175.43
..LN47:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.9:                         # Preds ..B1.8
                                # Execution count [1.00e+00]
..LN48:
        vmovd     %eax, %xmm0                                   #175.8
..LN49:
        vmovd     %r13d, %xmm1                                  #175.8
..LN50:
        vmovd     %r14d, %xmm2                                  #175.8
..LN51:
        vmovd     %r15d, %xmm3                                  #175.8
..LN52:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #175.8
..LN53:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #175.8
..LN54:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #175.8
..LN55:
        vmovups   %xmm6, 32(%rsp)                               #175.8[spill]
..LN56:
	.loc    1  176  is_stmt 1
#       rand(void)
        call      rand                                          #176.22
..LN57:
                                # LOE rbx r12 eax
..B1.117:                       # Preds ..B1.9
                                # Execution count [1.00e+00]
..LN58:
        movl      %eax, %r15d                                   #176.22
..LN59:
                                # LOE rbx r12 r15d
..B1.10:                        # Preds ..B1.117
                                # Execution count [1.00e+00]
..LN60:
#       rand(void)
        call      rand                                          #176.29
..LN61:
                                # LOE rbx r12 eax r15d
..B1.118:                       # Preds ..B1.10
                                # Execution count [1.00e+00]
..LN62:
        movl      %eax, %r14d                                   #176.29
..LN63:
                                # LOE rbx r12 r14d r15d
..B1.11:                        # Preds ..B1.118
                                # Execution count [1.00e+00]
..LN64:
#       rand(void)
        call      rand                                          #176.36
..LN65:
                                # LOE rbx r12 eax r14d r15d
..B1.119:                       # Preds ..B1.11
                                # Execution count [1.00e+00]
..LN66:
        movl      %eax, %r13d                                   #176.36
..LN67:
                                # LOE rbx r12 r13d r14d r15d
..B1.12:                        # Preds ..B1.119
                                # Execution count [1.00e+00]
..LN68:
#       rand(void)
        call      rand                                          #176.43
..LN69:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
..LN70:
        vmovd     %eax, %xmm0                                   #176.8
..LN71:
        vmovd     %r13d, %xmm1                                  #176.8
..LN72:
        vmovd     %r14d, %xmm2                                  #176.8
..LN73:
        vmovd     %r15d, %xmm3                                  #176.8
..LN74:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #176.8
..LN75:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #176.8
..LN76:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #176.8
..LN77:
        vmovups   %xmm6, 48(%rsp)                               #176.8[spill]
..LN78:
	.loc    1  177  is_stmt 1
#       rand(void)
        call      rand                                          #177.22
..LN79:
                                # LOE rbx r12 eax
..B1.121:                       # Preds ..B1.13
                                # Execution count [1.00e+00]
..LN80:
        movl      %eax, %r15d                                   #177.22
..LN81:
                                # LOE rbx r12 r15d
..B1.14:                        # Preds ..B1.121
                                # Execution count [1.00e+00]
..LN82:
#       rand(void)
        call      rand                                          #177.29
..LN83:
                                # LOE rbx r12 eax r15d
..B1.122:                       # Preds ..B1.14
                                # Execution count [1.00e+00]
..LN84:
        movl      %eax, %r14d                                   #177.29
..LN85:
                                # LOE rbx r12 r14d r15d
..B1.15:                        # Preds ..B1.122
                                # Execution count [1.00e+00]
..LN86:
#       rand(void)
        call      rand                                          #177.36
..LN87:
                                # LOE rbx r12 eax r14d r15d
..B1.123:                       # Preds ..B1.15
                                # Execution count [1.00e+00]
..LN88:
        movl      %eax, %r13d                                   #177.36
..LN89:
                                # LOE rbx r12 r13d r14d r15d
..B1.16:                        # Preds ..B1.123
                                # Execution count [1.00e+00]
..LN90:
#       rand(void)
        call      rand                                          #177.43
..LN91:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.17:                        # Preds ..B1.16
                                # Execution count [1.00e+00]
..LN92:
        vmovd     %eax, %xmm0                                   #177.8
..LN93:
        vmovd     %r13d, %xmm1                                  #177.8
..LN94:
        vmovd     %r14d, %xmm2                                  #177.8
..LN95:
        vmovd     %r15d, %xmm3                                  #177.8
..LN96:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #177.8
..LN97:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #177.8
..LN98:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #177.8
..LN99:
        vmovups   %xmm6, 64(%rsp)                               #177.8[spill]
..LN100:
	.loc    1  178  is_stmt 1
#       rand(void)
        call      rand                                          #178.22
..LN101:
                                # LOE rbx r12 eax
..B1.125:                       # Preds ..B1.17
                                # Execution count [1.00e+00]
..LN102:
        movl      %eax, %r15d                                   #178.22
..LN103:
                                # LOE rbx r12 r15d
..B1.18:                        # Preds ..B1.125
                                # Execution count [1.00e+00]
..LN104:
#       rand(void)
        call      rand                                          #178.29
..LN105:
                                # LOE rbx r12 eax r15d
..B1.126:                       # Preds ..B1.18
                                # Execution count [1.00e+00]
..LN106:
        movl      %eax, %r14d                                   #178.29
..LN107:
                                # LOE rbx r12 r14d r15d
..B1.19:                        # Preds ..B1.126
                                # Execution count [1.00e+00]
..LN108:
#       rand(void)
        call      rand                                          #178.36
..LN109:
                                # LOE rbx r12 eax r14d r15d
..B1.127:                       # Preds ..B1.19
                                # Execution count [1.00e+00]
..LN110:
        movl      %eax, %r13d                                   #178.36
..LN111:
                                # LOE rbx r12 r13d r14d r15d
..B1.20:                        # Preds ..B1.127
                                # Execution count [1.00e+00]
..LN112:
#       rand(void)
        call      rand                                          #178.43
..LN113:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
..LN114:
        vmovd     %eax, %xmm0                                   #178.8
..LN115:
        vmovd     %r13d, %xmm1                                  #178.8
..LN116:
        vmovd     %r14d, %xmm2                                  #178.8
..LN117:
        vmovd     %r15d, %xmm3                                  #178.8
..LN118:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #178.8
..LN119:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #178.8
..LN120:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #178.8
..LN121:
        vmovups   %xmm6, 80(%rsp)                               #178.8[spill]
..LN122:
	.loc    1  179  is_stmt 1
#       rand(void)
        call      rand                                          #179.22
..LN123:
                                # LOE rbx r12 eax
..B1.129:                       # Preds ..B1.21
                                # Execution count [1.00e+00]
..LN124:
        movl      %eax, %r15d                                   #179.22
..LN125:
                                # LOE rbx r12 r15d
..B1.22:                        # Preds ..B1.129
                                # Execution count [1.00e+00]
..LN126:
#       rand(void)
        call      rand                                          #179.29
..LN127:
                                # LOE rbx r12 eax r15d
..B1.130:                       # Preds ..B1.22
                                # Execution count [1.00e+00]
..LN128:
        movl      %eax, %r14d                                   #179.29
..LN129:
                                # LOE rbx r12 r14d r15d
..B1.23:                        # Preds ..B1.130
                                # Execution count [1.00e+00]
..LN130:
#       rand(void)
        call      rand                                          #179.36
..LN131:
                                # LOE rbx r12 eax r14d r15d
..B1.131:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
..LN132:
        movl      %eax, %r13d                                   #179.36
..LN133:
                                # LOE rbx r12 r13d r14d r15d
..B1.24:                        # Preds ..B1.131
                                # Execution count [1.00e+00]
..LN134:
#       rand(void)
        call      rand                                          #179.43
..LN135:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.25:                        # Preds ..B1.24
                                # Execution count [1.00e+00]
..LN136:
        vmovd     %eax, %xmm0                                   #179.8
..LN137:
        vmovd     %r13d, %xmm1                                  #179.8
..LN138:
        vmovd     %r14d, %xmm2                                  #179.8
..LN139:
        vmovd     %r15d, %xmm3                                  #179.8
..LN140:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #179.8
..LN141:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #179.8
..LN142:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #179.8
..LN143:
        vmovups   %xmm6, 96(%rsp)                               #179.8[spill]
..LN144:
	.loc    1  180  is_stmt 1
#       rand(void)
        call      rand                                          #180.22
..LN145:
                                # LOE rbx r12 eax
..B1.133:                       # Preds ..B1.25
                                # Execution count [1.00e+00]
..LN146:
        movl      %eax, %r15d                                   #180.22
..LN147:
                                # LOE rbx r12 r15d
..B1.26:                        # Preds ..B1.133
                                # Execution count [1.00e+00]
..LN148:
#       rand(void)
        call      rand                                          #180.29
..LN149:
                                # LOE rbx r12 eax r15d
..B1.134:                       # Preds ..B1.26
                                # Execution count [1.00e+00]
..LN150:
        movl      %eax, %r14d                                   #180.29
..LN151:
                                # LOE rbx r12 r14d r15d
..B1.27:                        # Preds ..B1.134
                                # Execution count [1.00e+00]
..LN152:
#       rand(void)
        call      rand                                          #180.36
..LN153:
                                # LOE rbx r12 eax r14d r15d
..B1.135:                       # Preds ..B1.27
                                # Execution count [1.00e+00]
..LN154:
        movl      %eax, %r13d                                   #180.36
..LN155:
                                # LOE rbx r12 r13d r14d r15d
..B1.28:                        # Preds ..B1.135
                                # Execution count [1.00e+00]
..LN156:
#       rand(void)
        call      rand                                          #180.43
..LN157:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.00e+00]
..LN158:
        vmovd     %eax, %xmm0                                   #180.8
..LN159:
        vmovd     %r13d, %xmm1                                  #180.8
..LN160:
        vmovd     %r14d, %xmm2                                  #180.8
..LN161:
        vmovd     %r15d, %xmm3                                  #180.8
..LN162:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #180.8
..LN163:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #180.8
..LN164:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #180.8
..LN165:
        vmovups   %xmm6, 112(%rsp)                              #180.8[spill]
..LN166:
	.loc    1  181  is_stmt 1
#       rand(void)
        call      rand                                          #181.22
..LN167:
                                # LOE rbx r12 eax
..B1.137:                       # Preds ..B1.29
                                # Execution count [1.00e+00]
..LN168:
        movl      %eax, %r15d                                   #181.22
..LN169:
                                # LOE rbx r12 r15d
..B1.30:                        # Preds ..B1.137
                                # Execution count [1.00e+00]
..LN170:
#       rand(void)
        call      rand                                          #181.29
..LN171:
                                # LOE rbx r12 eax r15d
..B1.138:                       # Preds ..B1.30
                                # Execution count [1.00e+00]
..LN172:
        movl      %eax, %r14d                                   #181.29
..LN173:
                                # LOE rbx r12 r14d r15d
..B1.31:                        # Preds ..B1.138
                                # Execution count [1.00e+00]
..LN174:
#       rand(void)
        call      rand                                          #181.36
..LN175:
                                # LOE rbx r12 eax r14d r15d
..B1.139:                       # Preds ..B1.31
                                # Execution count [1.00e+00]
..LN176:
        movl      %eax, %r13d                                   #181.36
..LN177:
                                # LOE rbx r12 r13d r14d r15d
..B1.32:                        # Preds ..B1.139
                                # Execution count [1.00e+00]
..LN178:
#       rand(void)
        call      rand                                          #181.43
..LN179:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.33:                        # Preds ..B1.32
                                # Execution count [1.00e+00]
..LN180:
        vmovd     %eax, %xmm0                                   #181.8
..LN181:
        vmovd     %r13d, %xmm1                                  #181.8
..LN182:
        vmovd     %r14d, %xmm2                                  #181.8
..LN183:
        vmovd     %r15d, %xmm3                                  #181.8
..LN184:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #181.8
..LN185:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #181.8
..LN186:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #181.8
..LN187:
        vmovups   %xmm6, 128(%rsp)                              #181.8[spill]
..LN188:
	.loc    1  182  is_stmt 1
#       rand(void)
        call      rand                                          #182.22
..LN189:
                                # LOE rbx r12 eax
..B1.141:                       # Preds ..B1.33
                                # Execution count [1.00e+00]
..LN190:
        movl      %eax, %r15d                                   #182.22
..LN191:
                                # LOE rbx r12 r15d
..B1.34:                        # Preds ..B1.141
                                # Execution count [1.00e+00]
..LN192:
#       rand(void)
        call      rand                                          #182.29
..LN193:
                                # LOE rbx r12 eax r15d
..B1.142:                       # Preds ..B1.34
                                # Execution count [1.00e+00]
..LN194:
        movl      %eax, %r14d                                   #182.29
..LN195:
                                # LOE rbx r12 r14d r15d
..B1.35:                        # Preds ..B1.142
                                # Execution count [1.00e+00]
..LN196:
#       rand(void)
        call      rand                                          #182.36
..LN197:
                                # LOE rbx r12 eax r14d r15d
..B1.143:                       # Preds ..B1.35
                                # Execution count [1.00e+00]
..LN198:
        movl      %eax, %r13d                                   #182.36
..LN199:
                                # LOE rbx r12 r13d r14d r15d
..B1.36:                        # Preds ..B1.143
                                # Execution count [1.00e+00]
..LN200:
#       rand(void)
        call      rand                                          #182.43
..LN201:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.37:                        # Preds ..B1.36
                                # Execution count [1.00e+00]
..LN202:
        vmovd     %eax, %xmm0                                   #182.8
..LN203:
        vmovd     %r13d, %xmm1                                  #182.8
..LN204:
        vmovd     %r14d, %xmm2                                  #182.8
..LN205:
        vmovd     %r15d, %xmm3                                  #182.8
..LN206:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #182.8
..LN207:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #182.8
..LN208:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #182.8
..LN209:
        vmovups   %xmm6, 144(%rsp)                              #182.8[spill]
..LN210:
	.loc    1  184  is_stmt 1
#       rand(void)
        call      rand                                          #184.22
..LN211:
                                # LOE rbx r12 eax
..B1.145:                       # Preds ..B1.37
                                # Execution count [1.00e+00]
..LN212:
        movl      %eax, %r15d                                   #184.22
..LN213:
                                # LOE rbx r12 r15d
..B1.38:                        # Preds ..B1.145
                                # Execution count [1.00e+00]
..LN214:
#       rand(void)
        call      rand                                          #184.29
..LN215:
                                # LOE rbx r12 eax r15d
..B1.146:                       # Preds ..B1.38
                                # Execution count [1.00e+00]
..LN216:
        movl      %eax, %r14d                                   #184.29
..LN217:
                                # LOE rbx r12 r14d r15d
..B1.39:                        # Preds ..B1.146
                                # Execution count [1.00e+00]
..LN218:
#       rand(void)
        call      rand                                          #184.36
..LN219:
                                # LOE rbx r12 eax r14d r15d
..B1.147:                       # Preds ..B1.39
                                # Execution count [1.00e+00]
..LN220:
        movl      %eax, %r13d                                   #184.36
..LN221:
                                # LOE rbx r12 r13d r14d r15d
..B1.40:                        # Preds ..B1.147
                                # Execution count [1.00e+00]
..LN222:
#       rand(void)
        call      rand                                          #184.43
..LN223:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.41:                        # Preds ..B1.40
                                # Execution count [1.00e+00]
..LN224:
        vmovd     %eax, %xmm0                                   #184.8
..LN225:
        vmovd     %r13d, %xmm1                                  #184.8
..LN226:
        vmovd     %r14d, %xmm2                                  #184.8
..LN227:
        vmovd     %r15d, %xmm3                                  #184.8
..LN228:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #184.8
..LN229:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #184.8
..LN230:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #184.8
..LN231:
        vmovups   %xmm6, 160(%rsp)                              #184.8[spill]
..LN232:
	.loc    1  185  is_stmt 1
#       rand(void)
        call      rand                                          #185.22
..LN233:
                                # LOE rbx r12 eax
..B1.149:                       # Preds ..B1.41
                                # Execution count [1.00e+00]
..LN234:
        movl      %eax, %r15d                                   #185.22
..LN235:
                                # LOE rbx r12 r15d
..B1.42:                        # Preds ..B1.149
                                # Execution count [1.00e+00]
..LN236:
#       rand(void)
        call      rand                                          #185.29
..LN237:
                                # LOE rbx r12 eax r15d
..B1.150:                       # Preds ..B1.42
                                # Execution count [1.00e+00]
..LN238:
        movl      %eax, %r14d                                   #185.29
..LN239:
                                # LOE rbx r12 r14d r15d
..B1.43:                        # Preds ..B1.150
                                # Execution count [1.00e+00]
..LN240:
#       rand(void)
        call      rand                                          #185.36
..LN241:
                                # LOE rbx r12 eax r14d r15d
..B1.151:                       # Preds ..B1.43
                                # Execution count [1.00e+00]
..LN242:
        movl      %eax, %r13d                                   #185.36
..LN243:
                                # LOE rbx r12 r13d r14d r15d
..B1.44:                        # Preds ..B1.151
                                # Execution count [1.00e+00]
..LN244:
#       rand(void)
        call      rand                                          #185.43
..LN245:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.00e+00]
..LN246:
        vmovd     %eax, %xmm0                                   #185.8
..LN247:
        vmovd     %r13d, %xmm1                                  #185.8
..LN248:
        vmovd     %r14d, %xmm2                                  #185.8
..LN249:
        vmovd     %r15d, %xmm3                                  #185.8
..LN250:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #185.8
..LN251:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #185.8
..LN252:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #185.8
..LN253:
        vmovups   %xmm6, 176(%rsp)                              #185.8[spill]
..LN254:
	.loc    1  186  is_stmt 1
#       rand(void)
        call      rand                                          #186.22
..LN255:
                                # LOE rbx r12 eax
..B1.153:                       # Preds ..B1.45
                                # Execution count [1.00e+00]
..LN256:
        movl      %eax, %r15d                                   #186.22
..LN257:
                                # LOE rbx r12 r15d
..B1.46:                        # Preds ..B1.153
                                # Execution count [1.00e+00]
..LN258:
#       rand(void)
        call      rand                                          #186.29
..LN259:
                                # LOE rbx r12 eax r15d
..B1.154:                       # Preds ..B1.46
                                # Execution count [1.00e+00]
..LN260:
        movl      %eax, %r14d                                   #186.29
..LN261:
                                # LOE rbx r12 r14d r15d
..B1.47:                        # Preds ..B1.154
                                # Execution count [1.00e+00]
..LN262:
#       rand(void)
        call      rand                                          #186.36
..LN263:
                                # LOE rbx r12 eax r14d r15d
..B1.155:                       # Preds ..B1.47
                                # Execution count [1.00e+00]
..LN264:
        movl      %eax, %r13d                                   #186.36
..LN265:
                                # LOE rbx r12 r13d r14d r15d
..B1.48:                        # Preds ..B1.155
                                # Execution count [1.00e+00]
..LN266:
#       rand(void)
        call      rand                                          #186.43
..LN267:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.49:                        # Preds ..B1.48
                                # Execution count [1.00e+00]
..LN268:
        vmovd     %eax, %xmm0                                   #186.8
..LN269:
        vmovd     %r13d, %xmm1                                  #186.8
..LN270:
        vmovd     %r14d, %xmm2                                  #186.8
..LN271:
        vmovd     %r15d, %xmm3                                  #186.8
..LN272:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #186.8
..LN273:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #186.8
..LN274:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #186.8
..LN275:
        vmovups   %xmm6, 192(%rsp)                              #186.8[spill]
..LN276:
	.loc    1  187  is_stmt 1
#       rand(void)
        call      rand                                          #187.22
..LN277:
                                # LOE rbx r12 eax
..B1.157:                       # Preds ..B1.49
                                # Execution count [1.00e+00]
..LN278:
        movl      %eax, %r15d                                   #187.22
..LN279:
                                # LOE rbx r12 r15d
..B1.50:                        # Preds ..B1.157
                                # Execution count [1.00e+00]
..LN280:
#       rand(void)
        call      rand                                          #187.29
..LN281:
                                # LOE rbx r12 eax r15d
..B1.158:                       # Preds ..B1.50
                                # Execution count [1.00e+00]
..LN282:
        movl      %eax, %r14d                                   #187.29
..LN283:
                                # LOE rbx r12 r14d r15d
..B1.51:                        # Preds ..B1.158
                                # Execution count [1.00e+00]
..LN284:
#       rand(void)
        call      rand                                          #187.36
..LN285:
                                # LOE rbx r12 eax r14d r15d
..B1.159:                       # Preds ..B1.51
                                # Execution count [1.00e+00]
..LN286:
        movl      %eax, %r13d                                   #187.36
..LN287:
                                # LOE rbx r12 r13d r14d r15d
..B1.52:                        # Preds ..B1.159
                                # Execution count [1.00e+00]
..LN288:
#       rand(void)
        call      rand                                          #187.43
..LN289:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.53:                        # Preds ..B1.52
                                # Execution count [1.00e+00]
..LN290:
        vmovd     %eax, %xmm0                                   #187.8
..LN291:
        vmovd     %r13d, %xmm1                                  #187.8
..LN292:
        vmovd     %r14d, %xmm2                                  #187.8
..LN293:
        vmovd     %r15d, %xmm3                                  #187.8
..LN294:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #187.8
..LN295:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #187.8
..LN296:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #187.8
..LN297:
        vmovups   %xmm6, 208(%rsp)                              #187.8[spill]
..LN298:
	.loc    1  188  is_stmt 1
#       rand(void)
        call      rand                                          #188.22
..LN299:
                                # LOE rbx r12 eax
..B1.161:                       # Preds ..B1.53
                                # Execution count [1.00e+00]
..LN300:
        movl      %eax, %r15d                                   #188.22
..LN301:
                                # LOE rbx r12 r15d
..B1.54:                        # Preds ..B1.161
                                # Execution count [1.00e+00]
..LN302:
#       rand(void)
        call      rand                                          #188.29
..LN303:
                                # LOE rbx r12 eax r15d
..B1.162:                       # Preds ..B1.54
                                # Execution count [1.00e+00]
..LN304:
        movl      %eax, %r14d                                   #188.29
..LN305:
                                # LOE rbx r12 r14d r15d
..B1.55:                        # Preds ..B1.162
                                # Execution count [1.00e+00]
..LN306:
#       rand(void)
        call      rand                                          #188.36
..LN307:
                                # LOE rbx r12 eax r14d r15d
..B1.163:                       # Preds ..B1.55
                                # Execution count [1.00e+00]
..LN308:
        movl      %eax, %r13d                                   #188.36
..LN309:
                                # LOE rbx r12 r13d r14d r15d
..B1.56:                        # Preds ..B1.163
                                # Execution count [1.00e+00]
..LN310:
#       rand(void)
        call      rand                                          #188.43
..LN311:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.57:                        # Preds ..B1.56
                                # Execution count [1.00e+00]
..LN312:
        vmovd     %eax, %xmm0                                   #188.8
..LN313:
        vmovd     %r13d, %xmm1                                  #188.8
..LN314:
        vmovd     %r14d, %xmm2                                  #188.8
..LN315:
        vmovd     %r15d, %xmm3                                  #188.8
..LN316:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #188.8
..LN317:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #188.8
..LN318:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #188.8
..LN319:
        vmovups   %xmm6, 224(%rsp)                              #188.8[spill]
..LN320:
	.loc    1  189  is_stmt 1
#       rand(void)
        call      rand                                          #189.22
..LN321:
                                # LOE rbx r12 eax
..B1.165:                       # Preds ..B1.57
                                # Execution count [1.00e+00]
..LN322:
        movl      %eax, %r15d                                   #189.22
..LN323:
                                # LOE rbx r12 r15d
..B1.58:                        # Preds ..B1.165
                                # Execution count [1.00e+00]
..LN324:
#       rand(void)
        call      rand                                          #189.29
..LN325:
                                # LOE rbx r12 eax r15d
..B1.166:                       # Preds ..B1.58
                                # Execution count [1.00e+00]
..LN326:
        movl      %eax, %r14d                                   #189.29
..LN327:
                                # LOE rbx r12 r14d r15d
..B1.59:                        # Preds ..B1.166
                                # Execution count [1.00e+00]
..LN328:
#       rand(void)
        call      rand                                          #189.36
..LN329:
                                # LOE rbx r12 eax r14d r15d
..B1.167:                       # Preds ..B1.59
                                # Execution count [1.00e+00]
..LN330:
        movl      %eax, %r13d                                   #189.36
..LN331:
                                # LOE rbx r12 r13d r14d r15d
..B1.60:                        # Preds ..B1.167
                                # Execution count [1.00e+00]
..LN332:
#       rand(void)
        call      rand                                          #189.43
..LN333:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.61:                        # Preds ..B1.60
                                # Execution count [1.00e+00]
..LN334:
        vmovd     %eax, %xmm0                                   #189.8
..LN335:
        vmovd     %r13d, %xmm1                                  #189.8
..LN336:
        vmovd     %r14d, %xmm2                                  #189.8
..LN337:
        vmovd     %r15d, %xmm3                                  #189.8
..LN338:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #189.8
..LN339:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #189.8
..LN340:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #189.8
..LN341:
        vmovups   %xmm6, 240(%rsp)                              #189.8[spill]
..LN342:
	.loc    1  190  is_stmt 1
#       rand(void)
        call      rand                                          #190.22
..LN343:
                                # LOE rbx r12 eax
..B1.169:                       # Preds ..B1.61
                                # Execution count [1.00e+00]
..LN344:
        movl      %eax, %r15d                                   #190.22
..LN345:
                                # LOE rbx r12 r15d
..B1.62:                        # Preds ..B1.169
                                # Execution count [1.00e+00]
..LN346:
#       rand(void)
        call      rand                                          #190.29
..LN347:
                                # LOE rbx r12 eax r15d
..B1.170:                       # Preds ..B1.62
                                # Execution count [1.00e+00]
..LN348:
        movl      %eax, %r14d                                   #190.29
..LN349:
                                # LOE rbx r12 r14d r15d
..B1.63:                        # Preds ..B1.170
                                # Execution count [1.00e+00]
..LN350:
#       rand(void)
        call      rand                                          #190.36
..LN351:
                                # LOE rbx r12 eax r14d r15d
..B1.171:                       # Preds ..B1.63
                                # Execution count [1.00e+00]
..LN352:
        movl      %eax, %r13d                                   #190.36
..LN353:
                                # LOE rbx r12 r13d r14d r15d
..B1.64:                        # Preds ..B1.171
                                # Execution count [1.00e+00]
..LN354:
#       rand(void)
        call      rand                                          #190.43
..LN355:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.65:                        # Preds ..B1.64
                                # Execution count [1.00e+00]
..LN356:
        vmovd     %eax, %xmm0                                   #190.8
..LN357:
        vmovd     %r13d, %xmm1                                  #190.8
..LN358:
        vmovd     %r14d, %xmm2                                  #190.8
..LN359:
        vmovd     %r15d, %xmm3                                  #190.8
..LN360:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #190.8
..LN361:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #190.8
..LN362:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #190.8
..LN363:
        vmovups   %xmm6, 256(%rsp)                              #190.8[spill]
..LN364:
	.loc    1  191  is_stmt 1
#       rand(void)
        call      rand                                          #191.22
..LN365:
                                # LOE rbx r12 eax
..B1.173:                       # Preds ..B1.65
                                # Execution count [1.00e+00]
..LN366:
        movl      %eax, %r14d                                   #191.22
..LN367:
                                # LOE rbx r12 r14d
..B1.66:                        # Preds ..B1.173
                                # Execution count [1.00e+00]
..LN368:
#       rand(void)
        call      rand                                          #191.29
..LN369:
                                # LOE rbx r12 eax r14d
..B1.174:                       # Preds ..B1.66
                                # Execution count [1.00e+00]
..LN370:
        movl      %eax, %r13d                                   #191.29
..LN371:
                                # LOE rbx r12 r13d r14d
..B1.67:                        # Preds ..B1.174
                                # Execution count [1.00e+00]
..LN372:
#       rand(void)
        call      rand                                          #191.36
..LN373:
                                # LOE rbx r12 eax r13d r14d
..B1.175:                       # Preds ..B1.67
                                # Execution count [1.00e+00]
..LN374:
        movl      %eax, %r15d                                   #191.36
..LN375:
                                # LOE rbx r12 r13d r14d r15d
..B1.68:                        # Preds ..B1.175
                                # Execution count [1.00e+00]
..LN376:
#       rand(void)
        call      rand                                          #191.43
..LN377:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.69:                        # Preds ..B1.68
                                # Execution count [9.00e-01]
..LN378:
        vmovd     %eax, %xmm0                                   #191.8
..LN379:
        vmovd     %r15d, %xmm1                                  #191.8
..LN380:
        vmovd     %r13d, %xmm2                                  #191.8
..LN381:
        vmovd     %r14d, %xmm3                                  #191.8
..LN382:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #191.8
..LN383:
	.loc    1  193  is_stmt 1
        xorl      %edx, %edx                                    #193.14
..LN384:
	.loc    1  191  is_stmt 1
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #191.8
..LN385:
	.loc    1  193  is_stmt 1
        xorl      %eax, %eax                                    #193.14
..LN386:
	.loc    1  191  is_stmt 1
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #191.8
..LN387:
        movq      %rax, %r13                                    #191.8
..LN388:
        vmovups   %xmm6, 272(%rsp)                              #191.8[spill]
..LN389:
        movl      %edx, %r14d                                   #191.8
..LN390:
                                # LOE rbx r12 r13 r14d
..B1.70:                        # Preds ..B1.71 ..B1.69
                                # Execution count [5.00e+00]
..L15:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN391:
	.loc    1  193  is_stmt 1
..LN392:
	.loc    1  195  is_stmt 1
        vmovups   32(%rsp), %xmm0                               #195.17[spill]
..LN393:
        lea       (%rsp), %rdi                                  #195.17
..LN394:
        vmovups   48(%rdi), %xmm1                               #195.17[spill]
..___tag_value_main.16:
..LN395:
#       add_bis(__m128i, __m128i, __m128i *__restrict__)
        call      add_bis                                       #195.17
..___tag_value_main.17:
..LN396:
                                # LOE rbx r12 r13 r14d xmm0
..B1.71:                        # Preds ..B1.70
                                # Execution count [5.00e+00]
..LN397:
	.loc    1  193  is_stmt 1
        incl      %r14d                                         #193.31
..LN398:
	.loc    1  195  is_stmt 1
        vmovdqu   %xmm0, (%r13,%r12)                            #195.5
..LN399:
	.loc    1  193  is_stmt 1
        addq      $16, %r13                                     #193.31
..LN400:
        cmpl      $800000, %r14d                                #193.28
..LN401:
        jl        ..B1.70       # Prob 82%                      #193.28
..LN402:
                                # LOE rbx r12 r13 r14d
..B1.72:                        # Preds ..B1.71
                                # Execution count [1.00e+00]
..LN403:
	.loc    1  197  is_stmt 1
        movq      %r12, %rdi                                    #197.3
..LN404:
        movl      $16, %esi                                     #197.3
..LN405:
        movl      $800000, %edx                                 #197.3
..LN406:
        movq      %rbx, %rcx                                    #197.3
..LN407:
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #197.3
..LN408:
                                # LOE rbx r12
..B1.73:                        # Preds ..B1.72
                                # Execution count [1.00e+00]
..LN409:
	.loc    1  200  is_stmt 1
        movl      $.L_2__STRING.2, %edi                         #200.3
..LN410:
        xorl      %eax, %eax                                    #200.3
..___tag_value_main.18:
..LN411:
#       printf(const char *__restrict__, ...)
        call      printf                                        #200.3
..___tag_value_main.19:
..LN412:
                                # LOE rbx r12
..B1.74:                        # Preds ..B1.73
                                # Execution count [1.00e+00]
..LN413:
        movq      stdout(%rip), %rdi                            #200.27
..LN414:
#       fflush(FILE *)
        call      fflush                                        #200.27
..LN415:
                                # LOE rbx r12
..B1.75:                        # Preds ..B1.74
                                # Execution count [1.00e+00]
..LN416:
	.loc    1  201  is_stmt 1
        xorl      %r13d, %r13d                                  #201.3
..LN417:
	.loc    1  202  is_stmt 1
        xorb      %r15b, %r15b                                  #202.14
..LN418:
                                # LOE rbx r12 r13 r15b
..B1.76:                        # Preds ..B1.82 ..B1.75
                                # Execution count [1.00e+02]
..L20:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN419:
..LN420:
	.loc    1  203  is_stmt 1
        rdtsc                                                   #203.13
..LN421:
        shlq      $32, %rdx                                     #203.13
..LN422:
        orq       %rdx, %rax                                    #203.13
..LN423:
                                # LOE rax rbx r12 r13 r15b
..B1.178:                       # Preds ..B1.76
                                # Execution count [1.00e+02]
..LN424:
        movq      %rax, %r14                                    #203.13
..LN425:
                                # LOE rbx r12 r13 r14 r15b
..B1.77:                        # Preds ..B1.178
                                # Execution count [9.00e+01]
..LN426:
	.loc    1  204  is_stmt 1
        xorl      %eax, %eax                                    #204.16
..LN427:
        movq      %r12, %rdi                                    #204.16
..LN428:
        movq      %r13, 24(%rsp)                                #204.16[spill]
..LN429:
        movl      %eax, %r13d                                   #204.16
..LN430:
        movq      %rbx, 16(%rsp)                                #204.16[spill]
..LN431:
        movq      %rdi, %rbx                                    #204.16
..LN432:
                                # LOE rbx r12 r14 r13d r15b
..B1.78:                        # Preds ..B1.79 ..B1.77
                                # Execution count [5.00e+02]
..L21:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN433:
..LN434:
	.loc    1  205  is_stmt 1
        addq      $-128, %rsp                                   #205.7
..LN435:
        movq      %rbx, %rdi                                    #205.7
..LN436:
        vmovups   288(%rsp), %xmm0                              #205.7[spill]
..LN437:
        vmovups   %xmm0, (%rsp)                                 #205.7
..LN438:
        vmovups   304(%rsp), %xmm1                              #205.7[spill]
..LN439:
        vmovups   %xmm1, 16(%rsp)                               #205.7
..LN440:
        vmovups   320(%rsp), %xmm2                              #205.7[spill]
..LN441:
        vmovups   %xmm2, 32(%rsp)                               #205.7
..LN442:
        vmovups   336(%rsp), %xmm3                              #205.7[spill]
..LN443:
        vmovups   %xmm3, 48(%rsp)                               #205.7
..LN444:
        vmovups   352(%rsp), %xmm4                              #205.7[spill]
..LN445:
        vmovups   %xmm4, 64(%rsp)                               #205.7
..LN446:
        vmovups   368(%rsp), %xmm5                              #205.7[spill]
..LN447:
        vmovups   %xmm5, 80(%rsp)                               #205.7
..LN448:
        vmovups   384(%rsp), %xmm6                              #205.7[spill]
..LN449:
        vmovups   %xmm6, 96(%rsp)                               #205.7
..LN450:
        vmovups   400(%rsp), %xmm7                              #205.7[spill]
..LN451:
        vmovups   %xmm7, 112(%rsp)                              #205.7
..LN452:
        vmovups   160(%rsp), %xmm0                              #205.7[spill]
..LN453:
        vmovups   176(%rsp), %xmm1                              #205.7[spill]
..LN454:
        vmovups   192(%rsp), %xmm2                              #205.7[spill]
..LN455:
        vmovups   208(%rsp), %xmm3                              #205.7[spill]
..LN456:
        vmovups   224(%rsp), %xmm4                              #205.7[spill]
..LN457:
        vmovups   240(%rsp), %xmm5                              #205.7[spill]
..LN458:
        vmovups   256(%rsp), %xmm6                              #205.7[spill]
..LN459:
        vmovups   272(%rsp), %xmm7                              #205.7[spill]
..___tag_value_main.22:
..LN460:
#       add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
        call      add_pack                                      #205.7
..___tag_value_main.23:
..LN461:
                                # LOE rbx r12 r14 r13d r15b
..B1.179:                       # Preds ..B1.78
                                # Execution count [5.00e+02]
..LN462:
        addq      $128, %rsp                                    #205.7
..LN463:
                                # LOE rbx r12 r14 r13d r15b
..B1.79:                        # Preds ..B1.179
                                # Execution count [5.00e+02]
..LN464:
	.loc    1  204  is_stmt 1
        incl      %r13d                                         #204.31
..LN465:
        addq      $128, %rbx                                    #204.31
..LN466:
        cmpl      $100000, %r13d                                #204.25
..LN467:
        jl        ..B1.78       # Prob 82%                      #204.25
..LN468:
                                # LOE rbx r12 r14 r13d r15b
..B1.80:                        # Preds ..B1.79
                                # Execution count [1.00e+02]
..LN469:
        movq      24(%rsp), %r13                                #[spill]
..LN470:
        movq      16(%rsp), %rbx                                #[spill]
..LN471:
	.loc    1  206  is_stmt 1
        rdtsc                                                   #206.12
..LN472:
        shlq      $32, %rdx                                     #206.12
..LN473:
        orq       %rdx, %rax                                    #206.12
..LN474:
                                # LOE rax rbx r12 r13 r14 r15b
..B1.81:                        # Preds ..B1.80
                                # Execution count [1.00e+02]
..LN475:
        subq      %r14, %rax                                    #206.12
..LN476:
	.loc    1  207  is_stmt 1
        movq      %r12, %rdi                                    #207.5
..LN477:
        movl      $16, %esi                                     #207.5
..LN478:
        movl      $800000, %edx                                 #207.5
..LN479:
        movq      %rbx, %rcx                                    #207.5
..LN480:
	.loc    1  206  is_stmt 1
        addq      %rax, %r13                                    #206.5
..LN481:
	.loc    1  207  is_stmt 1
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #207.5
..LN482:
                                # LOE rbx r12 r13 r15b
..B1.82:                        # Preds ..B1.81
                                # Execution count [1.00e+02]
..LN483:
	.loc    1  202  is_stmt 1
        incb      %r15b                                         #202.28
..LN484:
        cmpb      $100, %r15b                                   #202.23
..LN485:
        jl        ..B1.76       # Prob 99%                      #202.23
..LN486:
                                # LOE rbx r12 r13 r15b
..B1.83:                        # Preds ..B1.82
                                # Execution count [1.00e+00]
..LN487:
	.loc    1  209  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #209.3
..LN488:
        movq      %r13, %rsi                                    #209.3
..LN489:
        xorl      %eax, %eax                                    #209.3
..___tag_value_main.24:
..LN490:
#       printf(const char *__restrict__, ...)
        call      printf                                        #209.3
..___tag_value_main.25:
..LN491:
                                # LOE rbx r12
..B1.84:                        # Preds ..B1.83
                                # Execution count [1.00e+00]
..LN492:
	.loc    1  211  is_stmt 1
        movl      $.L_2__STRING.4, %edi                         #211.3
..LN493:
        xorl      %eax, %eax                                    #211.3
..___tag_value_main.26:
..LN494:
#       printf(const char *__restrict__, ...)
        call      printf                                        #211.3
..___tag_value_main.27:
..LN495:
                                # LOE rbx r12
..B1.85:                        # Preds ..B1.84
                                # Execution count [1.00e+00]
..LN496:
        movq      stdout(%rip), %rdi                            #211.27
..LN497:
#       fflush(FILE *)
        call      fflush                                        #211.27
..LN498:
                                # LOE rbx r12
..B1.86:                        # Preds ..B1.85
                                # Execution count [1.00e+00]
..LN499:
	.loc    1  212  is_stmt 1
        xorl      %r14d, %r14d                                  #212.3
..LN500:
	.loc    1  213  is_stmt 1
        xorb      %r13b, %r13b                                  #213.14
..LN501:
                                # LOE rbx r12 r14 r13b
..B1.87:                        # Preds ..B1.93 ..B1.86
                                # Execution count [1.00e+02]
..L28:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN502:
..LN503:
	.loc    1  214  is_stmt 1
        rdtsc                                                   #214.13
..LN504:
        shlq      $32, %rdx                                     #214.13
..LN505:
        orq       %rdx, %rax                                    #214.13
..LN506:
                                # LOE rax rbx r12 r14 r13b
..B1.181:                       # Preds ..B1.87
                                # Execution count [1.00e+02]
..LN507:
        movq      %rax, %r15                                    #214.13
..LN508:
                                # LOE rbx r12 r14 r15 r13b
..B1.88:                        # Preds ..B1.181
                                # Execution count [9.00e+01]
..LN509:
	.loc    1  215  is_stmt 1
        xorl      %eax, %eax                                    #215.16
..LN510:
        movq      %r12, %rdi                                    #215.16
..LN511:
        movq      %r12, 24(%rsp)                                #215.16[spill]
..LN512:
        movl      %eax, %r12d                                   #215.16
..LN513:
        movq      %rbx, 16(%rsp)                                #215.16[spill]
..LN514:
        movq      %rdi, %rbx                                    #215.16
..LN515:
                                # LOE rbx r14 r15 r12d r13b
..B1.89:                        # Preds ..B1.90 ..B1.88
                                # Execution count [5.00e+02]
..L29:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN516:
..LN517:
	.loc    1  216  is_stmt 1
        addq      $-128, %rsp                                   #216.7
..LN518:
        movq      %rbx, %rdi                                    #216.7
..LN519:
        vmovups   288(%rsp), %xmm0                              #216.7[spill]
..LN520:
        vmovups   %xmm0, (%rsp)                                 #216.7
..LN521:
        vmovups   304(%rsp), %xmm1                              #216.7[spill]
..LN522:
        vmovups   %xmm1, 16(%rsp)                               #216.7
..LN523:
        vmovups   320(%rsp), %xmm2                              #216.7[spill]
..LN524:
        vmovups   %xmm2, 32(%rsp)                               #216.7
..LN525:
        vmovups   336(%rsp), %xmm3                              #216.7[spill]
..LN526:
        vmovups   %xmm3, 48(%rsp)                               #216.7
..LN527:
        vmovups   352(%rsp), %xmm4                              #216.7[spill]
..LN528:
        vmovups   %xmm4, 64(%rsp)                               #216.7
..LN529:
        vmovups   368(%rsp), %xmm5                              #216.7[spill]
..LN530:
        vmovups   %xmm5, 80(%rsp)                               #216.7
..LN531:
        vmovups   384(%rsp), %xmm6                              #216.7[spill]
..LN532:
        vmovups   %xmm6, 96(%rsp)                               #216.7
..LN533:
        vmovups   400(%rsp), %xmm7                              #216.7[spill]
..LN534:
        vmovups   %xmm7, 112(%rsp)                              #216.7
..LN535:
        vmovups   160(%rsp), %xmm0                              #216.7[spill]
..LN536:
        vmovups   176(%rsp), %xmm1                              #216.7[spill]
..LN537:
        vmovups   192(%rsp), %xmm2                              #216.7[spill]
..LN538:
        vmovups   208(%rsp), %xmm3                              #216.7[spill]
..LN539:
        vmovups   224(%rsp), %xmm4                              #216.7[spill]
..LN540:
        vmovups   240(%rsp), %xmm5                              #216.7[spill]
..LN541:
        vmovups   256(%rsp), %xmm6                              #216.7[spill]
..LN542:
        vmovups   272(%rsp), %xmm7                              #216.7[spill]
..___tag_value_main.30:
..LN543:
#       add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
        call      add_bitslice                                  #216.7
..___tag_value_main.31:
..LN544:
                                # LOE rbx r14 r15 r12d r13b
..B1.182:                       # Preds ..B1.89
                                # Execution count [5.00e+02]
..LN545:
        addq      $128, %rsp                                    #216.7
..LN546:
                                # LOE rbx r14 r15 r12d r13b
..B1.90:                        # Preds ..B1.182
                                # Execution count [5.00e+02]
..LN547:
	.loc    1  215  is_stmt 1
        incl      %r12d                                         #215.31
..LN548:
        addq      $128, %rbx                                    #215.31
..LN549:
        cmpl      $100000, %r12d                                #215.25
..LN550:
        jl        ..B1.89       # Prob 82%                      #215.25
..LN551:
                                # LOE rbx r14 r15 r12d r13b
..B1.91:                        # Preds ..B1.90
                                # Execution count [1.00e+02]
..LN552:
        movq      24(%rsp), %r12                                #[spill]
..LN553:
        movq      16(%rsp), %rbx                                #[spill]
..LN554:
	.loc    1  217  is_stmt 1
        rdtsc                                                   #217.12
..LN555:
        shlq      $32, %rdx                                     #217.12
..LN556:
        orq       %rdx, %rax                                    #217.12
..LN557:
                                # LOE rax rbx r12 r14 r15 r13b
..B1.92:                        # Preds ..B1.91
                                # Execution count [1.00e+02]
..LN558:
        subq      %r15, %rax                                    #217.12
..LN559:
	.loc    1  218  is_stmt 1
        movq      %r12, %rdi                                    #218.5
..LN560:
        movl      $16, %esi                                     #218.5
..LN561:
        movl      $800000, %edx                                 #218.5
..LN562:
        movq      %rbx, %rcx                                    #218.5
..LN563:
	.loc    1  217  is_stmt 1
        addq      %rax, %r14                                    #217.5
..LN564:
	.loc    1  218  is_stmt 1
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #218.5
..LN565:
                                # LOE rbx r12 r14 r13b
..B1.93:                        # Preds ..B1.92
                                # Execution count [1.00e+02]
..LN566:
	.loc    1  213  is_stmt 1
        incb      %r13b                                         #213.28
..LN567:
        cmpb      $100, %r13b                                   #213.23
..LN568:
        jl        ..B1.87       # Prob 99%                      #213.23
..LN569:
                                # LOE rbx r12 r14 r13b
..B1.94:                        # Preds ..B1.93
                                # Execution count [1.00e+00]
..LN570:
	.loc    1  220  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #220.3
..LN571:
        movq      %r14, %rsi                                    #220.3
..LN572:
        xorl      %eax, %eax                                    #220.3
..___tag_value_main.32:
..LN573:
#       printf(const char *__restrict__, ...)
        call      printf                                        #220.3
..___tag_value_main.33:
..LN574:
                                # LOE rbx r12
..B1.95:                        # Preds ..B1.94
                                # Execution count [1.00e+00]
..LN575:
	.loc    1  222  is_stmt 1
        movl      $.L_2__STRING.5, %edi                         #222.3
..LN576:
        xorl      %eax, %eax                                    #222.3
..___tag_value_main.34:
..LN577:
#       printf(const char *__restrict__, ...)
        call      printf                                        #222.3
..___tag_value_main.35:
..LN578:
                                # LOE rbx r12
..B1.96:                        # Preds ..B1.95
                                # Execution count [1.00e+00]
..LN579:
        movq      stdout(%rip), %rdi                            #222.27
..LN580:
#       fflush(FILE *)
        call      fflush                                        #222.27
..LN581:
                                # LOE rbx r12
..B1.97:                        # Preds ..B1.96
                                # Execution count [1.00e+00]
..LN582:
	.loc    1  223  is_stmt 1
        xorl      %r14d, %r14d                                  #223.3
..LN583:
	.loc    1  224  is_stmt 1
        xorb      %r13b, %r13b                                  #224.14
..LN584:
                                # LOE rbx r12 r14 r13b
..B1.98:                        # Preds ..B1.104 ..B1.97
                                # Execution count [1.00e+02]
..L36:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN585:
..LN586:
	.loc    1  225  is_stmt 1
        rdtsc                                                   #225.13
..LN587:
        shlq      $32, %rdx                                     #225.13
..LN588:
        orq       %rdx, %rax                                    #225.13
..LN589:
                                # LOE rax rbx r12 r14 r13b
..B1.184:                       # Preds ..B1.98
                                # Execution count [1.00e+02]
..LN590:
        movq      %rax, %r15                                    #225.13
..LN591:
                                # LOE rbx r12 r14 r15 r13b
..B1.99:                        # Preds ..B1.184
                                # Execution count [9.00e+01]
..LN592:
	.loc    1  226  is_stmt 1
        xorl      %eax, %eax                                    #226.16
..LN593:
        movq      %r12, %rdi                                    #226.16
..LN594:
        movq      %r12, 24(%rsp)                                #226.16[spill]
..LN595:
        movl      %eax, %r12d                                   #226.16
..LN596:
        movq      %rbx, 16(%rsp)                                #226.16[spill]
..LN597:
        movq      %rdi, %rbx                                    #226.16
..LN598:
                                # LOE rbx r14 r15 r12d r13b
..B1.100:                       # Preds ..B1.101 ..B1.99
                                # Execution count [5.00e+02]
..L37:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN599:
..LN600:
	.loc    1  227  is_stmt 1
        addq      $-128, %rsp                                   #227.7
..LN601:
        movq      %rbx, %rdi                                    #227.7
..LN602:
        vmovups   288(%rsp), %xmm0                              #227.7[spill]
..LN603:
        vmovups   %xmm0, (%rsp)                                 #227.7
..LN604:
        vmovups   304(%rsp), %xmm1                              #227.7[spill]
..LN605:
        vmovups   %xmm1, 16(%rsp)                               #227.7
..LN606:
        vmovups   320(%rsp), %xmm2                              #227.7[spill]
..LN607:
        vmovups   %xmm2, 32(%rsp)                               #227.7
..LN608:
        vmovups   336(%rsp), %xmm3                              #227.7[spill]
..LN609:
        vmovups   %xmm3, 48(%rsp)                               #227.7
..LN610:
        vmovups   352(%rsp), %xmm4                              #227.7[spill]
..LN611:
        vmovups   %xmm4, 64(%rsp)                               #227.7
..LN612:
        vmovups   368(%rsp), %xmm5                              #227.7[spill]
..LN613:
        vmovups   %xmm5, 80(%rsp)                               #227.7
..LN614:
        vmovups   384(%rsp), %xmm6                              #227.7[spill]
..LN615:
        vmovups   %xmm6, 96(%rsp)                               #227.7
..LN616:
        vmovups   400(%rsp), %xmm7                              #227.7[spill]
..LN617:
        vmovups   %xmm7, 112(%rsp)                              #227.7
..LN618:
        vmovups   160(%rsp), %xmm0                              #227.7[spill]
..LN619:
        vmovups   176(%rsp), %xmm1                              #227.7[spill]
..LN620:
        vmovups   192(%rsp), %xmm2                              #227.7[spill]
..LN621:
        vmovups   208(%rsp), %xmm3                              #227.7[spill]
..LN622:
        vmovups   224(%rsp), %xmm4                              #227.7[spill]
..LN623:
        vmovups   240(%rsp), %xmm5                              #227.7[spill]
..LN624:
        vmovups   256(%rsp), %xmm6                              #227.7[spill]
..LN625:
        vmovups   272(%rsp), %xmm7                              #227.7[spill]
..___tag_value_main.38:
..LN626:
#       add_lookahead(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
        call      add_lookahead                                 #227.7
..___tag_value_main.39:
..LN627:
                                # LOE rbx r14 r15 r12d r13b
..B1.185:                       # Preds ..B1.100
                                # Execution count [5.00e+02]
..LN628:
        addq      $128, %rsp                                    #227.7
..LN629:
                                # LOE rbx r14 r15 r12d r13b
..B1.101:                       # Preds ..B1.185
                                # Execution count [5.00e+02]
..LN630:
	.loc    1  226  is_stmt 1
        incl      %r12d                                         #226.31
..LN631:
        addq      $128, %rbx                                    #226.31
..LN632:
        cmpl      $100000, %r12d                                #226.25
..LN633:
        jl        ..B1.100      # Prob 82%                      #226.25
..LN634:
                                # LOE rbx r14 r15 r12d r13b
..B1.102:                       # Preds ..B1.101
                                # Execution count [1.00e+02]
..LN635:
        movq      24(%rsp), %r12                                #[spill]
..LN636:
        movq      16(%rsp), %rbx                                #[spill]
..LN637:
	.loc    1  228  is_stmt 1
        rdtsc                                                   #228.12
..LN638:
        shlq      $32, %rdx                                     #228.12
..LN639:
        orq       %rdx, %rax                                    #228.12
..LN640:
                                # LOE rax rbx r12 r14 r15 r13b
..B1.103:                       # Preds ..B1.102
                                # Execution count [1.00e+02]
..LN641:
        subq      %r15, %rax                                    #228.12
..LN642:
	.loc    1  229  is_stmt 1
        movq      %r12, %rdi                                    #229.5
..LN643:
        movl      $16, %esi                                     #229.5
..LN644:
        movl      $800000, %edx                                 #229.5
..LN645:
        movq      %rbx, %rcx                                    #229.5
..LN646:
	.loc    1  228  is_stmt 1
        addq      %rax, %r14                                    #228.5
..LN647:
	.loc    1  229  is_stmt 1
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #229.5
..LN648:
                                # LOE rbx r12 r14 r13b
..B1.104:                       # Preds ..B1.103
                                # Execution count [1.00e+02]
..LN649:
	.loc    1  224  is_stmt 1
        incb      %r13b                                         #224.28
..LN650:
        cmpb      $100, %r13b                                   #224.23
..LN651:
        jl        ..B1.98       # Prob 99%                      #224.23
..LN652:
                                # LOE rbx r12 r14 r13b
..B1.105:                       # Preds ..B1.104
                                # Execution count [1.00e+00]
..LN653:
	.loc    1  231  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #231.3
..LN654:
        movq      %r14, %rsi                                    #231.3
..LN655:
        xorl      %eax, %eax                                    #231.3
..___tag_value_main.40:
..LN656:
#       printf(const char *__restrict__, ...)
        call      printf                                        #231.3
..___tag_value_main.41:
..LN657:
                                # LOE
..B1.106:                       # Preds ..B1.105
                                # Execution count [1.00e+00]
..LN658:
	.loc    1  233  is_stmt 1
        xorl      %eax, %eax                                    #233.10
..LN659:
	.loc    1  233  epilogue_begin  is_stmt 1
        addq      $344, %rsp                                    #233.10
	.cfi_restore 3
..LN660:
        popq      %rbx                                          #233.10
	.cfi_restore 15
..LN661:
        popq      %r15                                          #233.10
	.cfi_restore 14
..LN662:
        popq      %r14                                          #233.10
	.cfi_restore 13
..LN663:
        popq      %r13                                          #233.10
	.cfi_restore 12
..LN664:
        popq      %r12                                          #233.10
..LN665:
        movq      %rbp, %rsp                                    #233.10
..LN666:
        popq      %rbp                                          #233.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN667:
        ret                                                     #233.10
        .align    16,0x90
..LN668:
                                # LOE
..LN669:
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
..LNmain.670:
.LNmain:
	.data
	.file   2 "/opt/intel/compilers_and_libraries_2017.2.174/linux/compiler/include/icc/emmintrin.h"
	.file   3 "/opt/intel/compilers_and_libraries_2017.2.174/linux/compiler/include/stddef.h"
	.file   4 "/usr/include/stdint.h"
	.file   5 "/usr/include/stdio.h"
	.file   6 "/usr/include/libio.h"
	.file   7 "/usr/include/x86_64-linux-gnu/bits/types.h"
# -- End  main
	.text
.L_2__routine_start_add_bis_1:
# -- Begin  add_bis
	.text
# mark_begin;
       .align    16,0x90
	.globl add_bis
# --- add_bis(__m128i, __m128i, __m128i *__restrict__)
add_bis:
# parameter 1(a): %xmm0
# parameter 2(b): %xmm1
# parameter 3(c): %rdi
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bis.54:
..L55:
                                                         #26.60
..LN671:
	.loc    1  26  prologue_end  is_stmt 1
..LN672:
	.loc    1  27  is_stmt 1
        vpxor     %xmm1, %xmm0, %xmm5                           #27.21
..LN673:
	.loc    1  28  is_stmt 1
        vmovdqu   (%rdi), %xmm6                                 #28.24
..LN674:
	.loc    1  29  is_stmt 1
        vpand     %xmm1, %xmm0, %xmm2                           #29.10
..LN675:
        vpand     %xmm5, %xmm6, %xmm3                           #29.17
..LN676:
	.loc    1  28  is_stmt 1
        vpxor     %xmm6, %xmm5, %xmm0                           #28.24
..LN677:
	.loc    1  29  is_stmt 1
        vpxor     %xmm3, %xmm2, %xmm4                           #29.17
..LN678:
        vmovdqu   %xmm4, (%rdi)                                 #29.4
..LN679:
	.loc    1  30  epilogue_begin  is_stmt 1
        ret                                                     #30.10
        .align    16,0x90
..LN680:
                                # LOE
..LN681:
	.cfi_endproc
# mark_end;
	.type	add_bis,@function
	.size	add_bis,.-add_bis
..LNadd_bis.682:
.LNadd_bis:
	.data
# -- End  add_bis
	.text
.L_2__routine_start_add_pack_2:
# -- Begin  add_pack
	.text
# mark_begin;
       .align    16,0x90
	.globl add_pack
# --- add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_pack:
# parameter 1(x1): %xmm0
# parameter 2(x2): %xmm1
# parameter 3(x3): %xmm2
# parameter 4(x4): %xmm3
# parameter 5(x5): %xmm4
# parameter 6(x6): %xmm5
# parameter 7(x7): %xmm6
# parameter 8(x8): %xmm7
# parameter 9(y1): 8 + %rsp
# parameter 10(y2): 24 + %rsp
# parameter 11(y3): 40 + %rsp
# parameter 12(y4): 56 + %rsp
# parameter 13(y5): 72 + %rsp
# parameter 14(y6): 88 + %rsp
# parameter 15(y7): 104 + %rsp
# parameter 16(y8): 120 + %rsp
# parameter 17(out): %rdi
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_pack.61:
..L62:
                                                         #15.39
..LN683:
	.loc    1  15  prologue_end  is_stmt 1
..LN684:
	.loc    1  16  is_stmt 1
        vpaddb    8(%rsp), %xmm0, %xmm8                         #16.12
..LN685:
	.loc    1  17  is_stmt 1
        vpaddb    24(%rsp), %xmm1, %xmm9                        #17.12
..LN686:
	.loc    1  18  is_stmt 1
        vpaddb    40(%rsp), %xmm2, %xmm10                       #18.12
..LN687:
	.loc    1  19  is_stmt 1
        vpaddb    56(%rsp), %xmm3, %xmm11                       #19.12
..LN688:
	.loc    1  20  is_stmt 1
        vpaddb    72(%rsp), %xmm4, %xmm12                       #20.12
..LN689:
	.loc    1  21  is_stmt 1
        vpaddb    88(%rsp), %xmm5, %xmm13                       #21.12
..LN690:
	.loc    1  22  is_stmt 1
        vpaddb    104(%rsp), %xmm6, %xmm14                      #22.12
..LN691:
	.loc    1  23  is_stmt 1
        vpaddb    120(%rsp), %xmm7, %xmm15                      #23.12
..LN692:
	.loc    1  16  is_stmt 1
        vmovdqu   %xmm8, (%rdi)                                 #16.3
..LN693:
	.loc    1  17  is_stmt 1
        vmovdqu   %xmm9, 16(%rdi)                               #17.3
..LN694:
	.loc    1  18  is_stmt 1
        vmovdqu   %xmm10, 32(%rdi)                              #18.3
..LN695:
	.loc    1  19  is_stmt 1
        vmovdqu   %xmm11, 48(%rdi)                              #19.3
..LN696:
	.loc    1  20  is_stmt 1
        vmovdqu   %xmm12, 64(%rdi)                              #20.3
..LN697:
	.loc    1  21  is_stmt 1
        vmovdqu   %xmm13, 80(%rdi)                              #21.3
..LN698:
	.loc    1  22  is_stmt 1
        vmovdqu   %xmm14, 96(%rdi)                              #22.3
..LN699:
	.loc    1  23  is_stmt 1
        vmovdqu   %xmm15, 112(%rdi)                             #23.3
..LN700:
	.loc    1  24  epilogue_begin  is_stmt 1
        ret                                                     #24.1
        .align    16,0x90
..LN701:
                                # LOE
..LN702:
	.cfi_endproc
# mark_end;
	.type	add_pack,@function
	.size	add_pack,.-add_pack
..LNadd_pack.703:
.LNadd_pack:
	.data
# -- End  add_pack
	.text
.L_2__routine_start_add_bitslice_3:
# -- Begin  add_bitslice
	.text
# mark_begin;
       .align    16,0x90
	.globl add_bitslice
# --- add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_bitslice:
# parameter 1(x1): %xmm0
# parameter 2(x2): %xmm1
# parameter 3(x3): %xmm2
# parameter 4(x4): %xmm3
# parameter 5(x5): %xmm4
# parameter 6(x6): %xmm5
# parameter 7(x7): %xmm6
# parameter 8(x8): %xmm7
# parameter 9(y1): 8 + %rsp
# parameter 10(y2): 24 + %rsp
# parameter 11(y3): 40 + %rsp
# parameter 12(y4): 56 + %rsp
# parameter 13(y5): 72 + %rsp
# parameter 14(y6): 88 + %rsp
# parameter 15(y7): 104 + %rsp
# parameter 16(y8): 120 + %rsp
# parameter 17(out): %rdi
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bitslice.68:
..L69:
                                                         #42.43
..LN704:
	.loc    1  42  is_stmt 1
        vmovdqu   8(%rsp), %xmm8                                #42.43
..LN705:
	.loc    1  43  prologue_end  is_stmt 1
        vpxor     %xmm9, %xmm9, %xmm9                           #43.15
..LN706:
	.loc    1  42  is_stmt 1
        vmovdqu   24(%rsp), %xmm10                              #42.43
..LN707:
	.loc    1  44  is_stmt 1
        vpxor     %xmm8, %xmm0, %xmm15                          #44.3
..LN708:
        vpand     %xmm8, %xmm0, %xmm0                           #44.3
..LN709:
        vpxor     %xmm9, %xmm15, %xmm15                         #44.3
..LN710:
        vpxor     %xmm9, %xmm0, %xmm9                           #44.3
..LN711:
	.loc    1  45  is_stmt 1
        vpxor     %xmm10, %xmm1, %xmm0                          #45.3
..LN712:
	.loc    1  42  is_stmt 1
        vmovdqu   40(%rsp), %xmm11                              #42.43
..LN713:
	.loc    1  45  is_stmt 1
        vpand     %xmm10, %xmm1, %xmm1                          #45.3
..LN714:
        vpand     %xmm0, %xmm9, %xmm10                          #45.3
..LN715:
        vpxor     %xmm9, %xmm0, %xmm8                           #45.3
..LN716:
        vmovdqu   %xmm8, 16(%rdi)                               #45.3
..LN717:
        vpxor     %xmm10, %xmm1, %xmm1                          #45.3
..LN718:
	.loc    1  46  is_stmt 1
        vpxor     %xmm11, %xmm2, %xmm8                          #46.3
..LN719:
        vpand     %xmm11, %xmm2, %xmm2                          #46.3
..LN720:
	.loc    1  42  is_stmt 1
        vmovdqu   56(%rsp), %xmm12                              #42.43
..LN721:
	.loc    1  46  is_stmt 1
        vpand     %xmm8, %xmm1, %xmm11                          #46.3
..LN722:
        vpxor     %xmm1, %xmm8, %xmm0                           #46.3
..LN723:
        vpxor     %xmm11, %xmm2, %xmm1                          #46.3
..LN724:
	.loc    1  47  is_stmt 1
        vpxor     %xmm12, %xmm3, %xmm2                          #47.3
..LN725:
        vpand     %xmm12, %xmm3, %xmm3                          #47.3
..LN726:
	.loc    1  42  is_stmt 1
        vmovdqu   72(%rsp), %xmm13                              #42.43
..LN727:
	.loc    1  47  is_stmt 1
        vpand     %xmm2, %xmm1, %xmm12                          #47.3
..LN728:
	.loc    1  46  is_stmt 1
        vmovdqu   %xmm0, 32(%rdi)                               #46.3
..LN729:
	.loc    1  47  is_stmt 1
        vpxor     %xmm1, %xmm2, %xmm0                           #47.3
..LN730:
        vpxor     %xmm12, %xmm3, %xmm1                          #47.3
..LN731:
	.loc    1  48  is_stmt 1
        vpxor     %xmm13, %xmm4, %xmm2                          #48.3
..LN732:
	.loc    1  42  is_stmt 1
        vmovdqu   88(%rsp), %xmm14                              #42.43
..LN733:
	.loc    1  48  is_stmt 1
        vpand     %xmm13, %xmm4, %xmm4                          #48.3
..LN734:
        vpand     %xmm2, %xmm1, %xmm13                          #48.3
..LN735:
	.loc    1  47  is_stmt 1
        vmovdqu   %xmm0, 48(%rdi)                               #47.3
..LN736:
	.loc    1  48  is_stmt 1
        vpxor     %xmm1, %xmm2, %xmm0                           #48.3
..LN737:
        vpxor     %xmm13, %xmm4, %xmm1                          #48.3
..LN738:
	.loc    1  49  is_stmt 1
        vpxor     %xmm14, %xmm5, %xmm2                          #49.3
..LN739:
	.loc    1  48  is_stmt 1
        vmovdqu   %xmm0, 64(%rdi)                               #48.3
..LN740:
	.loc    1  49  is_stmt 1
        vpxor     %xmm1, %xmm2, %xmm0                           #49.3
..LN741:
        vpand     %xmm14, %xmm5, %xmm5                          #49.3
..LN742:
        vpand     %xmm2, %xmm1, %xmm14                          #49.3
..LN743:
	.loc    1  50  is_stmt 1
        vmovdqu   104(%rsp), %xmm1                              #50.3
..LN744:
	.loc    1  49  is_stmt 1
        vpxor     %xmm14, %xmm5, %xmm2                          #49.3
..LN745:
	.loc    1  50  is_stmt 1
        vpxor     %xmm1, %xmm6, %xmm3                           #50.3
..LN746:
        vpand     %xmm1, %xmm6, %xmm6                           #50.3
..LN747:
	.loc    1  49  is_stmt 1
        vmovdqu   %xmm0, 80(%rdi)                               #49.3
..LN748:
	.loc    1  50  is_stmt 1
        vpxor     %xmm2, %xmm3, %xmm0                           #50.3
..LN749:
        vmovdqu   %xmm0, 96(%rdi)                               #50.3
..LN750:
        vpand     %xmm3, %xmm2, %xmm0                           #50.3
..LN751:
	.loc    1  51  is_stmt 1
        vpxor     120(%rsp), %xmm7, %xmm7                       #51.3
..LN752:
	.loc    1  50  is_stmt 1
        vpxor     %xmm0, %xmm6, %xmm1                           #50.3
..LN753:
	.loc    1  51  is_stmt 1
        vpxor     %xmm1, %xmm7, %xmm2                           #51.3
..LN754:
	.loc    1  44  is_stmt 1
        vmovdqu   %xmm15, (%rdi)                                #44.3
..LN755:
	.loc    1  51  is_stmt 1
        vmovdqu   %xmm2, 112(%rdi)                              #51.3
..LN756:
	.loc    1  52  epilogue_begin  is_stmt 1
        ret                                                     #52.1
        .align    16,0x90
..LN757:
                                # LOE
..LN758:
	.cfi_endproc
# mark_end;
	.type	add_bitslice,@function
	.size	add_bitslice,.-add_bitslice
..LNadd_bitslice.759:
.LNadd_bitslice:
	.data
# -- End  add_bitslice
	.text
.L_2__routine_start_add_lookahead_4:
# -- Begin  add_lookahead
	.text
# mark_begin;
       .align    16,0x90
	.globl add_lookahead
# --- add_lookahead(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_lookahead:
# parameter 1(a0): %xmm0
# parameter 2(a1): %xmm1
# parameter 3(a2): %xmm2
# parameter 4(a3): %xmm3
# parameter 5(a4): %xmm4
# parameter 6(a5): %xmm5
# parameter 7(a6): %xmm6
# parameter 8(a7): %xmm7
# parameter 9(b0): 8 + %rsp
# parameter 10(b1): 24 + %rsp
# parameter 11(b2): 40 + %rsp
# parameter 12(b3): 56 + %rsp
# parameter 13(b4): 72 + %rsp
# parameter 14(b5): 88 + %rsp
# parameter 15(b6): 104 + %rsp
# parameter 16(b7): 120 + %rsp
# parameter 17(out): %rdi
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_lookahead.76:
..L77:
                                                         #80.44
..LN760:
	.loc    1  80  prologue_end  is_stmt 1
        vmovdqa   %xmm1, %xmm13                                 #80.44
..LN761:
        vmovdqu   8(%rsp), %xmm14                               #80.44
..LN762:
        vmovdqa   %xmm0, %xmm15                                 #80.44
..LN763:
        vmovdqu   24(%rsp), %xmm12                              #80.44
..LN764:
	.loc    1  81  is_stmt 1
        vpxor     %xmm14, %xmm15, %xmm0                         #81.21
..LN765:
	.loc    1  90  is_stmt 1
        vpand     %xmm14, %xmm15, %xmm15                        #90.21
..LN766:
	.loc    1  82  is_stmt 1
        vpxor     %xmm12, %xmm13, %xmm14                        #82.21
..LN767:
	.loc    1  80  is_stmt 1
        vmovdqu   40(%rsp), %xmm1                               #80.44
..LN768:
	.loc    1  91  is_stmt 1
        vpand     %xmm12, %xmm13, %xmm13                        #91.21
..LN769:
	.loc    1  106  is_stmt 1
        vmovdqu   %xmm0, (%rdi)                                 #106.3
..LN770:
	.loc    1  107  is_stmt 1
        vpxor     %xmm15, %xmm14, %xmm0                         #107.17
..LN771:
	.loc    1  80  is_stmt 1
        vmovdqu   56(%rsp), %xmm8                               #80.44
..LN772:
	.loc    1  83  is_stmt 1
        vpxor     %xmm1, %xmm2, %xmm12                          #83.21
..LN773:
	.loc    1  80  is_stmt 1
        vmovdqu   72(%rsp), %xmm11                              #80.44
..LN774:
	.loc    1  92  is_stmt 1
        vpand     %xmm1, %xmm2, %xmm2                           #92.21
..LN775:
	.loc    1  80  is_stmt 1
        vmovdqu   88(%rsp), %xmm9                               #80.44
..LN776:
	.loc    1  84  is_stmt 1
        vpxor     %xmm8, %xmm3, %xmm1                           #84.21
..LN777:
	.loc    1  80  is_stmt 1
        vmovdqu   104(%rsp), %xmm10                             #80.44
..LN778:
	.loc    1  93  is_stmt 1
        vpand     %xmm8, %xmm3, %xmm3                           #93.21
..LN779:
	.loc    1  107  is_stmt 1
        vmovdqu   %xmm0, 16(%rdi)                               #107.3
..LN780:
	.loc    1  99  is_stmt 1
        vpand     %xmm15, %xmm14, %xmm0                         #99.24
..LN781:
	.loc    1  85  is_stmt 1
        vpxor     %xmm11, %xmm4, %xmm8                          #85.21
..LN782:
	.loc    1  94  is_stmt 1
        vpand     %xmm11, %xmm4, %xmm4                          #94.21
..LN783:
	.loc    1  86  is_stmt 1
        vpxor     %xmm9, %xmm5, %xmm11                          #86.21
..LN784:
	.loc    1  95  is_stmt 1
        vpand     %xmm9, %xmm5, %xmm5                           #95.21
..LN785:
	.loc    1  87  is_stmt 1
        vpxor     %xmm10, %xmm6, %xmm9                          #87.21
..LN786:
	.loc    1  96  is_stmt 1
        vpand     %xmm10, %xmm6, %xmm6                          #96.21
..LN787:
	.loc    1  99  is_stmt 1
        vpor      %xmm0, %xmm13, %xmm10                         #99.24
..LN788:
	.loc    1  100  is_stmt 1
        vpand     %xmm13, %xmm12, %xmm0                         #100.24
..LN789:
	.loc    1  108  is_stmt 1
        vpxor     %xmm10, %xmm12, %xmm10                        #108.17
..LN790:
        vmovdqu   %xmm10, 32(%rdi)                              #108.3
..LN791:
	.loc    1  100  is_stmt 1
        vpor      %xmm0, %xmm2, %xmm10                          #100.24
..LN792:
        vpand     %xmm14, %xmm12, %xmm0                         #100.32
..LN793:
        vpand     %xmm15, %xmm0, %xmm0                          #100.35
..LN794:
        vpor      %xmm0, %xmm10, %xmm10                         #100.35
..LN795:
	.loc    1  101  is_stmt 1
        vpand     %xmm2, %xmm1, %xmm0                           #101.24
..LN796:
	.loc    1  109  is_stmt 1
        vpxor     %xmm10, %xmm1, %xmm10                         #109.17
..LN797:
	.loc    1  101  is_stmt 1
        vpor      %xmm0, %xmm3, %xmm0                           #101.24
..LN798:
	.loc    1  109  is_stmt 1
        vmovdqu   %xmm10, 48(%rdi)                              #109.3
..LN799:
	.loc    1  101  is_stmt 1
        vpand     %xmm12, %xmm1, %xmm10                         #101.32
..LN800:
	.loc    1  88  is_stmt 1
        vpxor     120(%rsp), %xmm7, %xmm7                       #88.21
..LN801:
        vmovdqu   %xmm7, -24(%rsp)                              #88.21[spill]
..LN802:
	.loc    1  101  is_stmt 1
        vpand     %xmm13, %xmm10, %xmm7                         #101.35
..LN803:
        vpand     %xmm14, %xmm10, %xmm10                        #101.46
..LN804:
        vpor      %xmm7, %xmm0, %xmm7                           #101.35
..LN805:
        vpand     %xmm15, %xmm10, %xmm0                         #101.49
..LN806:
        vpor      %xmm0, %xmm7, %xmm10                          #101.49
..LN807:
	.loc    1  110  is_stmt 1
        vpxor     %xmm10, %xmm8, %xmm7                          #110.17
..LN808:
	.loc    1  102  is_stmt 1
        vpand     %xmm1, %xmm8, %xmm10                          #102.32
..LN809:
	.loc    1  110  is_stmt 1
        vmovdqu   %xmm7, 64(%rdi)                               #110.3
..LN810:
	.loc    1  102  is_stmt 1
        vpand     %xmm12, %xmm10, %xmm0                         #102.60
..LN811:
        vpand     %xmm2, %xmm10, %xmm7                          #102.35
..LN812:
        vpand     %xmm3, %xmm8, %xmm10                          #102.24
..LN813:
        vpor      %xmm10, %xmm4, %xmm10                         #102.24
..LN814:
        vpor      %xmm7, %xmm10, %xmm7                          #102.35
..LN815:
        vpand     %xmm13, %xmm0, %xmm10                         #102.49
..LN816:
        vpand     %xmm14, %xmm0, %xmm0                          #102.63
..LN817:
        vpor      %xmm10, %xmm7, %xmm10                         #102.49
..LN818:
        vpand     %xmm15, %xmm0, %xmm7                          #102.66
..LN819:
        vpor      %xmm7, %xmm10, %xmm10                         #102.66
..LN820:
	.loc    1  103  is_stmt 1
        vpand     %xmm8, %xmm11, %xmm7                          #103.32
..LN821:
	.loc    1  111  is_stmt 1
        vpxor     %xmm10, %xmm11, %xmm0                         #111.17
..LN822:
        vmovdqu   %xmm0, 80(%rdi)                               #111.3
..LN823:
	.loc    1  103  is_stmt 1
        vpand     %xmm1, %xmm7, %xmm0                           #103.77
..LN824:
	.loc    1  92  is_stmt 1
        vmovdqu   %xmm2, -40(%rsp)                              #92.21[spill]
..LN825:
	.loc    1  103  is_stmt 1
        vpand     %xmm12, %xmm0, %xmm10                         #103.63
..LN826:
        vpand     %xmm2, %xmm0, %xmm2                           #103.49
..LN827:
        vpand     %xmm4, %xmm11, %xmm0                          #103.24
..LN828:
        vpand     %xmm3, %xmm7, %xmm7                           #103.35
..LN829:
        vpor      %xmm0, %xmm5, %xmm0                           #103.24
..LN830:
        vpor      %xmm7, %xmm0, %xmm7                           #103.35
..LN831:
        vpand     %xmm13, %xmm10, %xmm0                         #103.66
..LN832:
        vpor      %xmm2, %xmm7, %xmm7                           #103.49
..LN833:
        vpand     %xmm14, %xmm10, %xmm10                        #103.83
..LN834:
	.loc    1  104  is_stmt 1
        vpand     %xmm11, %xmm9, %xmm11                         #104.32
..LN835:
	.loc    1  103  is_stmt 1
        vpor      %xmm0, %xmm7, %xmm2                           #103.66
..LN836:
        vpand     %xmm15, %xmm10, %xmm7                         #103.86
..LN837:
	.loc    1  104  is_stmt 1
        vpand     %xmm5, %xmm9, %xmm5                           #104.24
..LN838:
        vpand     %xmm8, %xmm11, %xmm8                          #104.97
..LN839:
        vpand     %xmm4, %xmm11, %xmm4                          #104.35
..LN840:
	.loc    1  103  is_stmt 1
        vpor      %xmm7, %xmm2, %xmm11                          #103.86
..LN841:
	.loc    1  104  is_stmt 1
        vpor      %xmm5, %xmm6, %xmm6                           #104.24
..LN842:
	.loc    1  112  is_stmt 1
        vpxor     %xmm11, %xmm9, %xmm0                          #112.17
..LN843:
	.loc    1  104  is_stmt 1
        vpand     %xmm1, %xmm8, %xmm1                           #104.63
..LN844:
        vpor      %xmm4, %xmm6, %xmm9                           #104.35
..LN845:
        vpand     %xmm3, %xmm8, %xmm3                           #104.49
..LN846:
	.loc    1  112  is_stmt 1
        vmovdqu   %xmm0, 96(%rdi)                               #112.3
..LN847:
	.loc    1  104  is_stmt 1
        vpand     %xmm12, %xmm1, %xmm12                         #104.103
..LN848:
        vpand     -40(%rsp), %xmm1, %xmm1                       #104.66[spill]
..LN849:
        vpor      %xmm3, %xmm9, %xmm0                           #104.49
..LN850:
        vpor      %xmm1, %xmm0, %xmm2                           #104.66
..LN851:
        vpand     %xmm13, %xmm12, %xmm13                        #104.86
..LN852:
        vpand     %xmm14, %xmm12, %xmm12                        #104.106
..LN853:
        vpor      %xmm13, %xmm2, %xmm0                          #104.86
..LN854:
        vpand     %xmm15, %xmm12, %xmm4                         #104.109
..LN855:
        vpor      %xmm4, %xmm0, %xmm8                           #104.109
..LN856:
	.loc    1  113  is_stmt 1
        vpxor     -24(%rsp), %xmm8, %xmm14                      #113.17[spill]
..LN857:
        vmovdqu   %xmm14, 112(%rdi)                             #113.3
..LN858:
	.loc    1  114  epilogue_begin  is_stmt 1
        ret                                                     #114.1
        .align    16,0x90
..LN859:
                                # LOE
..LN860:
	.cfi_endproc
# mark_end;
	.type	add_lookahead,@function
	.size	add_lookahead,.-add_lookahead
..LNadd_lookahead.861:
.LNadd_lookahead:
	.data
# -- End  add_lookahead
	.text
.L_2__routine_start_add_lookahead_reschedul_5:
# -- Begin  add_lookahead_reschedul
	.text
# mark_begin;
       .align    16,0x90
	.globl add_lookahead_reschedul
# --- add_lookahead_reschedul(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_lookahead_reschedul:
# parameter 1(a0): %xmm0
# parameter 2(a1): %xmm1
# parameter 3(a2): %xmm2
# parameter 4(a3): %xmm3
# parameter 5(a4): %xmm4
# parameter 6(a5): %xmm5
# parameter 7(a6): %xmm6
# parameter 8(a7): %xmm7
# parameter 9(b0): 8 + %rsp
# parameter 10(b1): 24 + %rsp
# parameter 11(b2): 40 + %rsp
# parameter 12(b3): 56 + %rsp
# parameter 13(b4): 72 + %rsp
# parameter 14(b5): 88 + %rsp
# parameter 15(b6): 104 + %rsp
# parameter 16(b7): 120 + %rsp
# parameter 17(out): %rdi
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_lookahead_reschedul.83:
..L84:
                                                         #121.44
..LN862:
	.loc    1  121  prologue_end  is_stmt 1
        vmovdqa   %xmm1, %xmm13                                 #121.44
..LN863:
        vmovdqu   8(%rsp), %xmm12                               #121.44
..LN864:
        vmovdqu   24(%rsp), %xmm14                              #121.44
..LN865:
	.loc    1  122  is_stmt 1
        vpxor     %xmm12, %xmm0, %xmm15                         #122.21
..LN866:
	.loc    1  123  is_stmt 1
        vmovdqu   %xmm15, (%rdi)                                #123.3
..LN867:
	.loc    1  126  is_stmt 1
        vpand     %xmm12, %xmm0, %xmm0                          #126.21
..LN868:
	.loc    1  127  is_stmt 1
        vpxor     %xmm14, %xmm13, %xmm15                        #127.21
..LN869:
	.loc    1  131  is_stmt 1
        vpand     %xmm14, %xmm13, %xmm14                        #131.21
..LN870:
	.loc    1  121  is_stmt 1
        vmovdqu   40(%rsp), %xmm9                               #121.44
..LN871:
	.loc    1  132  is_stmt 1
        vpand     %xmm0, %xmm15, %xmm12                         #132.24
..LN872:
	.loc    1  129  is_stmt 1
        vpxor     %xmm0, %xmm15, %xmm10                         #129.17
..LN873:
	.loc    1  133  is_stmt 1
        vpxor     %xmm9, %xmm2, %xmm13                          #133.21
..LN874:
	.loc    1  121  is_stmt 1
        vmovdqu   56(%rsp), %xmm11                              #121.44
..LN875:
	.loc    1  129  is_stmt 1
        vmovdqu   %xmm10, 16(%rdi)                              #129.3
..LN876:
	.loc    1  136  is_stmt 1
        vpand     %xmm9, %xmm2, %xmm10                          #136.21
..LN877:
	.loc    1  132  is_stmt 1
        vpor      %xmm12, %xmm14, %xmm9                         #132.24
..LN878:
	.loc    1  137  is_stmt 1
        vpand     %xmm14, %xmm13, %xmm12                        #137.24
..LN879:
	.loc    1  134  is_stmt 1
        vpxor     %xmm9, %xmm13, %xmm2                          #134.17
..LN880:
	.loc    1  138  is_stmt 1
        vpxor     %xmm11, %xmm3, %xmm9                          #138.21
..LN881:
	.loc    1  141  is_stmt 1
        vpand     %xmm11, %xmm3, %xmm11                         #141.21
..LN882:
	.loc    1  137  is_stmt 1
        vpand     %xmm15, %xmm13, %xmm3                         #137.32
..LN883:
	.loc    1  134  is_stmt 1
        vmovdqu   %xmm2, 32(%rdi)                               #134.3
..LN884:
	.loc    1  137  is_stmt 1
        vpor      %xmm12, %xmm10, %xmm12                        #137.24
..LN885:
        vpand     %xmm0, %xmm3, %xmm2                           #137.35
..LN886:
        vpor      %xmm2, %xmm12, %xmm3                          #137.35
..LN887:
	.loc    1  121  is_stmt 1
        vmovdqu   72(%rsp), %xmm1                               #121.44
..LN888:
	.loc    1  139  is_stmt 1
        vpxor     %xmm3, %xmm9, %xmm12                          #139.17
..LN889:
	.loc    1  157  is_stmt 1
        vpxor     120(%rsp), %xmm7, %xmm7                       #157.21
..LN890:
	.loc    1  142  is_stmt 1
        vpand     %xmm13, %xmm9, %xmm3                          #142.32
..LN891:
	.loc    1  139  is_stmt 1
        vmovdqu   %xmm12, 48(%rdi)                              #139.3
..LN892:
	.loc    1  143  is_stmt 1
        vpxor     %xmm1, %xmm4, %xmm12                          #143.21
..LN893:
	.loc    1  146  is_stmt 1
        vpand     %xmm1, %xmm4, %xmm4                           #146.21
..LN894:
	.loc    1  142  is_stmt 1
        vpand     %xmm10, %xmm9, %xmm1                          #142.24
..LN895:
	.loc    1  157  is_stmt 1
        vmovdqu   %xmm7, -24(%rsp)                              #157.21[spill]
..LN896:
	.loc    1  142  is_stmt 1
        vpor      %xmm1, %xmm11, %xmm2                          #142.24
..LN897:
        vpand     %xmm14, %xmm3, %xmm7                          #142.35
..LN898:
        vpor      %xmm7, %xmm2, %xmm1                           #142.35
..LN899:
        vpand     %xmm15, %xmm3, %xmm2                          #142.46
..LN900:
        vpand     %xmm0, %xmm2, %xmm3                           #142.49
..LN901:
        vpor      %xmm3, %xmm1, %xmm7                           #142.49
..LN902:
	.loc    1  147  is_stmt 1
        vpand     %xmm9, %xmm12, %xmm1                          #147.32
..LN903:
	.loc    1  121  is_stmt 1
        vmovdqu   88(%rsp), %xmm8                               #121.44
..LN904:
	.loc    1  147  is_stmt 1
        vpand     %xmm11, %xmm12, %xmm3                         #147.24
..LN905:
	.loc    1  144  is_stmt 1
        vpxor     %xmm7, %xmm12, %xmm2                          #144.17
..LN906:
	.loc    1  148  is_stmt 1
        vpxor     %xmm8, %xmm5, %xmm7                           #148.21
..LN907:
	.loc    1  144  is_stmt 1
        vmovdqu   %xmm2, 64(%rdi)                               #144.3
..LN908:
	.loc    1  151  is_stmt 1
        vpand     %xmm8, %xmm5, %xmm5                           #151.21
..LN909:
	.loc    1  147  is_stmt 1
        vpand     %xmm13, %xmm1, %xmm8                          #147.60
..LN910:
        vpand     %xmm10, %xmm1, %xmm1                          #147.35
..LN911:
        vpor      %xmm3, %xmm4, %xmm2                           #147.24
..LN912:
        vpor      %xmm1, %xmm2, %xmm3                           #147.35
..LN913:
        vpand     %xmm14, %xmm8, %xmm2                          #147.49
..LN914:
        vpand     %xmm15, %xmm8, %xmm8                          #147.63
..LN915:
        vpor      %xmm2, %xmm3, %xmm1                           #147.49
..LN916:
        vpand     %xmm0, %xmm8, %xmm2                           #147.66
..LN917:
        vpor      %xmm2, %xmm1, %xmm8                           #147.66
..LN918:
	.loc    1  152  is_stmt 1
        vpand     %xmm12, %xmm7, %xmm1                          #152.32
..LN919:
	.loc    1  153  is_stmt 1
        vmovdqu   104(%rsp), %xmm2                              #153.21
..LN920:
	.loc    1  149  is_stmt 1
        vpxor     %xmm8, %xmm7, %xmm3                           #149.17
..LN921:
	.loc    1  153  is_stmt 1
        vpxor     %xmm2, %xmm6, %xmm8                           #153.21
..LN922:
	.loc    1  156  is_stmt 1
        vpand     %xmm2, %xmm6, %xmm2                           #156.21
..LN923:
	.loc    1  152  is_stmt 1
        vpand     %xmm9, %xmm1, %xmm6                           #152.77
..LN924:
	.loc    1  136  is_stmt 1
        vmovdqu   %xmm10, -40(%rsp)                             #136.21[spill]
..LN925:
	.loc    1  152  is_stmt 1
        vpand     %xmm10, %xmm6, %xmm10                         #152.49
..LN926:
	.loc    1  149  is_stmt 1
        vmovdqu   %xmm3, 80(%rdi)                               #149.3
..LN927:
	.loc    1  152  is_stmt 1
        vpand     %xmm11, %xmm1, %xmm3                          #152.35
..LN928:
        vpand     %xmm13, %xmm6, %xmm1                          #152.63
..LN929:
        vpand     %xmm4, %xmm7, %xmm6                           #152.24
..LN930:
        vpor      %xmm6, %xmm5, %xmm6                           #152.24
..LN931:
	.loc    1  158  is_stmt 1
        vpand     %xmm5, %xmm8, %xmm5                           #158.24
..LN932:
	.loc    1  152  is_stmt 1
        vpor      %xmm3, %xmm6, %xmm3                           #152.35
..LN933:
        vpor      %xmm10, %xmm3, %xmm10                         #152.49
..LN934:
	.loc    1  158  is_stmt 1
        vpand     %xmm7, %xmm8, %xmm3                           #158.32
..LN935:
        vpand     %xmm12, %xmm3, %xmm7                          #158.97
..LN936:
        vpand     %xmm4, %xmm3, %xmm12                          #158.35
..LN937:
	.loc    1  152  is_stmt 1
        vpand     %xmm14, %xmm1, %xmm4                          #152.66
..LN938:
        vpand     %xmm15, %xmm1, %xmm1                          #152.83
..LN939:
        vpor      %xmm4, %xmm10, %xmm3                          #152.66
..LN940:
        vpand     %xmm0, %xmm1, %xmm4                           #152.86
..LN941:
	.loc    1  158  is_stmt 1
        vpor      %xmm5, %xmm2, %xmm1                           #158.24
..LN942:
        vpand     %xmm9, %xmm7, %xmm9                           #158.63
..LN943:
        vpor      %xmm12, %xmm1, %xmm2                          #158.35
..LN944:
        vpand     %xmm11, %xmm7, %xmm11                         #158.49
..LN945:
        vpand     %xmm13, %xmm9, %xmm13                         #158.103
..LN946:
        vpor      %xmm11, %xmm2, %xmm1                          #158.49
..LN947:
        vpand     -40(%rsp), %xmm9, %xmm2                       #158.66[spill]
..LN948:
	.loc    1  152  is_stmt 1
        vpor      %xmm4, %xmm3, %xmm6                           #152.86
..LN949:
	.loc    1  158  is_stmt 1
        vpor      %xmm2, %xmm1, %xmm3                           #158.66
..LN950:
        vpand     %xmm14, %xmm13, %xmm14                        #158.86
..LN951:
        vpand     %xmm15, %xmm13, %xmm13                        #158.106
..LN952:
        vpor      %xmm14, %xmm3, %xmm1                          #158.86
..LN953:
        vpand     %xmm0, %xmm13, %xmm15                         #158.109
..LN954:
	.loc    1  154  is_stmt 1
        vpxor     %xmm6, %xmm8, %xmm10                          #154.17
..LN955:
	.loc    1  158  is_stmt 1
        vpor      %xmm15, %xmm1, %xmm0                          #158.109
..LN956:
	.loc    1  159  is_stmt 1
        vpxor     -24(%rsp), %xmm0, %xmm1                       #159.17[spill]
..LN957:
	.loc    1  154  is_stmt 1
        vmovdqu   %xmm10, 96(%rdi)                              #154.3
..LN958:
	.loc    1  159  is_stmt 1
        vmovdqu   %xmm1, 112(%rdi)                              #159.3
..LN959:
	.loc    1  160  epilogue_begin  is_stmt 1
        ret                                                     #160.1
        .align    16,0x90
..LN960:
                                # LOE
..LN961:
	.cfi_endproc
# mark_end;
	.type	add_lookahead_reschedul,@function
	.size	add_lookahead_reschedul,.-add_lookahead_reschedul
..LNadd_lookahead_reschedul.962:
.LNadd_lookahead_reschedul:
	.data
# -- End  add_lookahead_reschedul
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
	.section .debug_opt_report, ""
..L89:
	.ascii ".itt_notify_tab\0"
	.word	258
	.word	48
	.long	8
	.long	..L90 - ..L89
	.long	48
	.long	..L91 - ..L89
	.long	123
	.long	0x00000008,0x00000000
	.long	0
	.long	0
	.long	0
	.long	0
	.quad	..L15
	.long	28
	.long	4
	.quad	..L20
	.long	28
	.long	21
	.quad	..L21
	.long	28
	.long	38
	.quad	..L28
	.long	28
	.long	55
	.quad	..L29
	.long	28
	.long	72
	.quad	..L36
	.long	28
	.long	89
	.quad	..L37
	.long	28
	.long	106
..L90:
	.long	1769238639
	.long	1635412333
	.long	1852795252
	.long	1885696607
	.long	1601466991
	.long	1936876918
	.long	7237481
	.long	1769238639
	.long	1635412333
	.long	1852795252
	.long	1885696607
	.long	7631471
..L91:
	.long	42209283
	.long	-2139090928
	.long	-2139062144
	.long	-2139062144
	.long	-2139061840
	.long	-2146430975
	.long	-2139062144
	.long	-2139062144
	.long	-2138984320
	.long	269484416
	.long	-2139062144
	.long	-2139062144
	.long	-2119139200
	.long	268533888
	.long	-2139062256
	.long	-2139062144
	.long	-1333755776
	.long	25198721
	.long	-2139090928
	.long	-2139062144
	.long	-2139062144
	.long	-2139061840
	.long	-2146430975
	.long	-2139062144
	.long	-2139062144
	.long	-2138984320
	.long	269484416
	.long	-2139062144
	.long	-2139062144
	.long	-2119139200
	.word	32896
	.byte	1
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .debug_info
	.section .debug_info
.debug_info_seg:
	.align 1
	.4byte 0x00000cd9
	.2byte 0x0004
	.4byte .debug_abbrev_seg
	.byte 0x08
//	DW_TAG_compile_unit:
	.byte 0x01
//	DW_AT_comp_dir:
	.4byte .debug_str
//	DW_AT_name:
	.4byte .debug_str+0x39
//	DW_AT_producer:
	.4byte .debug_str+0x41
	.4byte .debug_str+0xad
//	DW_AT_language:
	.byte 0x01
//	DW_AT_use_UTF8:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN0
//	DW_AT_high_pc:
	.8byte ..LNadd_lookahead_reschedul.962-..LN0
	.byte 0x01
//	DW_AT_stmt_list:
	.4byte .debug_line_seg
//	DW_TAG_base_type:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte 0x00746e69
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x380
	.4byte .debug_str+0x380
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L62
//	DW_AT_high_pc:
	.8byte ..LNadd_pack.703-..L62
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3178
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3278
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3378
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3478
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3578
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3678
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3778
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3878
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3179
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x08
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3279
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x18
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3379
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x28
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3479
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x38
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3579
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00c89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3679
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00d89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3779
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00e89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3879
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00f89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x1a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x378
	.4byte .debug_str+0x378
//	DW_AT_low_pc:
	.8byte ..L55
//	DW_AT_high_pc:
	.8byte ..LNadd_bis.682-..L55
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x1a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x0061
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x1a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x0062
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x1a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_AT_name:
	.2byte 0x0063
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x1b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x1c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00736572
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x26
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x389
	.4byte .debug_str+0x389
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L69
//	DW_AT_high_pc:
	.8byte ..LNadd_bitslice.759-..L69
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x26
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3178
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x26
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3278
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x26
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3378
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x26
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3478
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3578
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3678
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3778
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3878
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x28
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3179
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x08
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x28
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3279
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x18
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x28
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3379
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x28
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x28
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3479
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x38
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x29
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3579
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00c89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x29
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3679
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00d89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x29
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3779
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00e89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x29
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3879
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00f89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x2a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x2b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0063
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x2c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN707
//	DW_AT_high_pc:
	.8byte ..LN755
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x2c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x9002
	.byte 0x20
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6101
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x2e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x2e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6901
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x2f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x2f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6301
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x30
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x30
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6301
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x31
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x31
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6301
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x32
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x32
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6401
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x33
//	DW_AT_decl_file:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x33
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x396
	.4byte .debug_str+0x396
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L77
//	DW_AT_high_pc:
	.8byte ..LNadd_lookahead.861-..L77
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3061
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3161
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3261
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3361
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3461
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3561
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3661
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3761
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3062
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x30
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3162
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00c09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3262
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00d09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3362
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00e09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3462
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00f09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3562
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01809103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3662
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01909103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x4f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3762
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01a09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x50
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x51
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3070
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x52
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3170
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6f01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x53
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3270
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6d01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3370
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x55
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3470
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6901
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x56
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3570
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6c01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3670
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6a01
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x58
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3770
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3067
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x9002
	.byte 0x20
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3167
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6e01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3267
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3367
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3467
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3567
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x60
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3667
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x62
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3063
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x63
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3163
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x64
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3263
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x65
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3363
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x66
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3463
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x67
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3563
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x68
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3663
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x75
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x3a4
	.4byte .debug_str+0x3a4
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L84
//	DW_AT_high_pc:
	.8byte ..LNadd_lookahead_reschedul.962-..L84
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x75
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3061
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x75
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3161
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x75
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3261
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x75
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3361
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x76
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3461
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x76
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3561
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x76
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3661
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x76
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3761
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3062
	.byte 0x00
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x30
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3162
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00c09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3262
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00d09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3362
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00e09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3462
	.byte 0x00
//	DW_AT_location:
	.4byte 0x00f09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3562
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01809103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3662
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01909103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_name:
	.2byte 0x3762
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01a09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x79
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x7a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3070
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x9002
	.byte 0x20
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x7e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3067
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x7f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3170
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x9002
	.byte 0x20
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x80
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3063
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x83
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3167
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6f01
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x84
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3163
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3270
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6e01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x88
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3267
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6b01
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x89
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3263
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x8a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3370
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6a01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x8d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3367
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6c01
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x8e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3363
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x8f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3470
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6d01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x92
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3467
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x93
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3463
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x94
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3570
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x97
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3567
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x98
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3563
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x99
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3670
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6901
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x9c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3667
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x9d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3770
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x9e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3663
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_name:
	.4byte .debug_str+0x128
	.4byte .debug_str+0x128
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L3
//	DW_AT_high_pc:
	.8byte ..LNmain.670-..L3
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0xa5
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1ef
//	DW_AT_type:
	.4byte 0x00000a71
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa5
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00646e65
//	DW_AT_type:
	.4byte 0x00000a71
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa6
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0066
//	DW_AT_type:
	.4byte 0x00000a7c
//	DW_AT_location:
	.2byte 0x5301
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3178
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3278
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3378
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3478
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3578
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3678
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3778
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa8
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3878
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3179
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3279
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3379
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3479
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3579
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3679
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3779
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3879
	.byte 0x00
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_variable:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0xab
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x36c
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_variable:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0xad
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x371
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_AT_location:
	.2byte 0x5c01
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xc1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN383
//	DW_AT_high_pc:
	.8byte ..LN409
//	DW_TAG_variable:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0xc1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xc1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN392
//	DW_AT_high_pc:
	.8byte ..LN399
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xc2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x00
	.byte 0x00
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xca
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN417
//	DW_AT_high_pc:
	.8byte ..LN492
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xca
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5f01
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xcc
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN426
//	DW_AT_high_pc:
	.8byte ..LN481
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xcc
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x006a
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5d01
	.byte 0x00
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xd5
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN500
//	DW_AT_high_pc:
	.8byte ..LN575
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xd5
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5d01
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xd7
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN509
//	DW_AT_high_pc:
	.8byte ..LN564
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xd7
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x006a
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5c01
	.byte 0x00
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xe0
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN583
//	DW_AT_high_pc:
	.8byte ..LN658
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xe0
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5d01
//	DW_TAG_lexical_block:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xe2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN592
//	DW_AT_high_pc:
	.8byte ..LN647
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xe2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x006a
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5c01
	.byte 0x00
	.byte 0x00
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000922
//	DW_TAG_const_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000927
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x01
//	DW_AT_encoding:
	.byte 0x06
//	DW_AT_name:
	.4byte .debug_str+0x12d
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x132
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x0000093a
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x4a
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_name:
	.4byte .debug_str+0x13f
//	DW_AT_type:
	.4byte 0x00000945
//	DW_TAG_union_type:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x30
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x13f
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x36
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x147
//	DW_AT_type:
	.4byte 0x000009d8
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x3c
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x164
//	DW_AT_type:
	.4byte 0x000009e8
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x3d
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x16d
//	DW_AT_type:
	.4byte 0x000009f1
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x3e
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x17d
//	DW_AT_type:
	.4byte 0x00000a01
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x3f
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x187
//	DW_AT_type:
	.4byte 0x00000a0a
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x40
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x191
//	DW_AT_type:
	.4byte 0x00000a13
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x41
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1a8
//	DW_AT_type:
	.4byte 0x00000a23
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x42
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1c1
//	DW_AT_type:
	.4byte 0x00000a33
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x43
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1cb
//	DW_AT_type:
	.4byte 0x00000a3c
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x49
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.2byte 0x0063
//	DW_AT_type:
	.4byte 0x00000a4c
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x000009e1
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x01
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x15f
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000927
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x000009fa
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x07
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x02
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x177
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x03
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x000009e1
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x01
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000a1c
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x01
//	DW_AT_encoding:
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x19a
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000a2c
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x07
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x02
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x1b2
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x0000092e
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x03
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000a45
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x01
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x1d5
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000927
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000a5a
//	DW_TAG_const_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000a5f
//	DW_TAG_base_type:
	.byte 0x0f
//	DW_AT_byte_size:
	.byte 0x00
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x1e3
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x2c
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_name:
	.4byte .debug_str+0x1e8
//	DW_AT_type:
	.4byte 0x00000a45
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x04
//	DW_AT_name:
	.4byte .debug_str+0x1f5
//	DW_AT_type:
	.4byte 0x00000a45
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000a81
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x30
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x1fe
//	DW_AT_type:
	.4byte 0x00000a8c
//	DW_TAG_structure_type:
	.byte 0x16
//	DW_AT_decl_line:
	.byte 0xf1
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_byte_size:
	.byte 0xd8
//	DW_AT_name:
	.4byte .debug_str+0x203
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xf2
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x20c
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xf7
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x213
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xf8
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x220
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xf9
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x18
//	DW_AT_name:
	.4byte .debug_str+0x22d
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xfa
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x20
//	DW_AT_name:
	.4byte .debug_str+0x23b
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xfb
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x28
//	DW_AT_name:
	.4byte .debug_str+0x24a
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xfc
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x30
//	DW_AT_name:
	.4byte .debug_str+0x258
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xfd
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x38
//	DW_AT_name:
	.4byte .debug_str+0x266
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xfe
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x40
//	DW_AT_name:
	.4byte .debug_str+0x273
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0100
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x48
//	DW_AT_name:
	.4byte .debug_str+0x27f
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0101
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x50
//	DW_AT_name:
	.4byte .debug_str+0x28d
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0102
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x58
//	DW_AT_name:
	.4byte .debug_str+0x29d
//	DW_AT_type:
	.4byte 0x00000c4b
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0104
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x60
//	DW_AT_name:
	.4byte .debug_str+0x2aa
//	DW_AT_type:
	.4byte 0x00000c50
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0106
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x68
//	DW_AT_name:
	.4byte .debug_str+0x2cf
//	DW_AT_type:
	.4byte 0x00000c88
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0108
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x70
//	DW_AT_name:
	.4byte .debug_str+0x2d6
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x010c
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x74
//	DW_AT_name:
	.4byte .debug_str+0x2de
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x010e
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x78
//	DW_AT_name:
	.4byte .debug_str+0x2e6
//	DW_AT_type:
	.4byte 0x00000c8d
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0112
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01802303
//	DW_AT_name:
	.4byte .debug_str+0x2fa
//	DW_AT_type:
	.4byte 0x00000a2c
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0113
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01822303
//	DW_AT_name:
	.4byte .debug_str+0x306
//	DW_AT_type:
	.4byte 0x00000927
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0114
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01832303
//	DW_AT_name:
	.4byte .debug_str+0x315
//	DW_AT_type:
	.4byte 0x00000c98
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0118
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01882303
//	DW_AT_name:
	.4byte .debug_str+0x31f
//	DW_AT_type:
	.4byte 0x00000ca1
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0121
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01902303
//	DW_AT_name:
	.4byte .debug_str+0x2ea
//	DW_AT_type:
	.4byte 0x00000cb1
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0129
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01982303
//	DW_AT_name:
	.4byte .debug_str+0x33a
//	DW_AT_type:
	.4byte 0x00000cbc
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x012a
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01a02303
//	DW_AT_name:
	.4byte .debug_str+0x341
//	DW_AT_type:
	.4byte 0x00000cbc
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x012b
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01a82303
//	DW_AT_name:
	.4byte .debug_str+0x348
//	DW_AT_type:
	.4byte 0x00000cbc
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x012c
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01b02303
//	DW_AT_name:
	.4byte .debug_str+0x34f
//	DW_AT_type:
	.4byte 0x00000cbc
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x012e
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01b82303
//	DW_AT_name:
	.4byte .debug_str+0x356
//	DW_AT_type:
	.4byte 0x00000a66
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x012f
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01c02303
//	DW_AT_name:
	.4byte .debug_str+0x35d
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x17
//	DW_AT_decl_line:
	.2byte 0x0131
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01c42303
//	DW_AT_name:
	.4byte .debug_str+0x363
//	DW_AT_type:
	.4byte 0x00000cc1
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000927
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000c55
//	DW_TAG_structure_type:
	.byte 0x16
//	DW_AT_decl_line:
	.byte 0x9c
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_byte_size:
	.byte 0x18
//	DW_AT_name:
	.4byte .debug_str+0x2b3
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x9d
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x2be
//	DW_AT_type:
	.4byte 0x00000c50
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x9e
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x2c4
//	DW_AT_type:
	.4byte 0x00000c88
//	DW_TAG_member:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x2ca
//	DW_AT_type:
	.4byte 0x00000033
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000a8c
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x83
//	DW_AT_decl_file:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x2f2
//	DW_AT_type:
	.4byte 0x000009e1
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000927
//	DW_AT_byte_size:
	.byte 0x01
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x00
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000ca6
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x96
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_name:
	.4byte .debug_str+0x325
//	DW_AT_type:
	.4byte 0x00000a5f
//	DW_TAG_typedef:
	.byte 0x10
//	DW_AT_decl_line:
	.byte 0x84
//	DW_AT_decl_file:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x330
//	DW_AT_type:
	.4byte 0x000009e1
//	DW_TAG_pointer_type:
	.byte 0x0d
//	DW_AT_type:
	.4byte 0x00000a5f
//	DW_TAG_array_type:
	.byte 0x14
//	DW_AT_type:
	.4byte 0x00000927
//	DW_AT_byte_size:
	.byte 0x14
//	DW_TAG_subrange_type:
	.byte 0x15
//	DW_AT_upper_bound:
	.byte 0x13
	.byte 0x00
//	DW_TAG_restrict_type:
	.byte 0x18
//	DW_AT_type:
	.4byte 0x00000935
//	DW_TAG_variable:
	.byte 0x19
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x3bc
//	DW_AT_type:
	.4byte 0x00000c88
//	DW_AT_declaration:
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_line
	.section .debug_line
.debug_line_seg:
	.align 1
// -- Begin DWARF2 SEGMENT .debug_abbrev
	.section .debug_abbrev
.debug_abbrev_seg:
	.align 1
	.byte 0x01
	.byte 0x11
	.byte 0x01
	.byte 0x1b
	.byte 0x0e
	.byte 0x03
	.byte 0x0e
	.byte 0x25
	.byte 0x0e
	.2byte 0x7681
	.byte 0x0e
	.byte 0x13
	.byte 0x0b
	.byte 0x53
	.byte 0x0c
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x6a
	.byte 0x0c
	.byte 0x10
	.byte 0x17
	.2byte 0x0000
	.byte 0x02
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.2byte 0x0000
	.byte 0x03
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x27
	.byte 0x0c
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x40
	.byte 0x18
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x04
	.byte 0x05
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x08
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x05
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x27
	.byte 0x0c
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x06
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x07
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x08
	.byte 0x0b
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x01
	.2byte 0x0000
	.byte 0x09
	.byte 0x0b
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.2byte 0x0000
	.byte 0x0a
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x40
	.byte 0x18
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x6a
	.byte 0x0c
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x0b
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0c
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x18
	.2byte 0x0000
	.byte 0x0d
	.byte 0x0f
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0e
	.byte 0x26
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0f
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x10
	.byte 0x16
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x11
	.byte 0x17
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x0b
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x12
	.byte 0x0d
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x38
	.byte 0x18
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x13
	.byte 0x0d
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x38
	.byte 0x18
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x14
	.byte 0x01
	.byte 0x01
	.byte 0x49
	.byte 0x13
	.byte 0x0b
	.byte 0x0b
	.2byte 0x0000
	.byte 0x15
	.byte 0x21
	.byte 0x00
	.byte 0x2f
	.byte 0x0b
	.2byte 0x0000
	.byte 0x16
	.byte 0x13
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x0b
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x17
	.byte 0x0d
	.byte 0x00
	.byte 0x3b
	.byte 0x05
	.byte 0x3a
	.byte 0x0b
	.byte 0x38
	.byte 0x18
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x18
	.byte 0x37
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x19
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.byte 0x3c
	.byte 0x0c
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_frame
	.section .debug_frame
.debug_frame_seg:
	.align 1
// -- Begin DWARF2 SEGMENT .debug_str
	.section .debug_str,"MS",@progbits,1
.debug_str_seg:
	.align 1
	.8byte 0x61642f656d6f682f
	.8byte 0x736b726f572f6164
	.8byte 0x7573752f65636170
	.8byte 0x73747365742f6162
	.8byte 0x6d6972657078652f
	.8byte 0x6e6f697461746e65
	.8byte 0x32765f6464612f73
	.byte 0x00
	.8byte 0x00632e385f646461
	.8byte 0x2952286c65746e49
	.8byte 0x6c65746e49204320
	.8byte 0x4320343620295228
	.8byte 0x2072656c69706d6f
	.8byte 0x6c70706120726f66
	.8byte 0x736e6f6974616369
	.8byte 0x676e696e6e757220
	.8byte 0x65746e49206e6f20
	.8byte 0x2c3436202952286c
	.8byte 0x6e6f697372655620
	.8byte 0x2e322e302e373120
	.8byte 0x6c69754220343731
	.8byte 0x3230373130322064
	.4byte 0x000a3331
	.8byte 0x572d206c6c61572d
	.8byte 0x6d2d206172747865
	.8byte 0x74616e3d68637261
	.8byte 0x6f6e572d20657669
	.8byte 0x68746e657261702d
	.8byte 0x6e662d2073657365
	.8byte 0x762d656572742d6f
	.8byte 0x657a69726f746365
	.8byte 0x6369727473662d20
	.8byte 0x697361696c612d74
	.8byte 0x2d6f6e662d20676e
	.8byte 0x2d20656e696c6e69
	.8byte 0x532d20672d20334f
	.8byte 0x5f646461206f2d20
	.8byte 0x656e696c6e695f38
	.2byte 0x732e
	.byte 0x00
	.4byte 0x6e69616d
	.byte 0x00
	.4byte 0x72616863
	.byte 0x00
	.8byte 0x64656e6769736e75
	.4byte 0x746e6920
	.byte 0x00
	.8byte 0x00693832316d5f5f
	.8byte 0x63675f693832316d
	.8byte 0x7461706d6f635f63
	.8byte 0x007974696c696269
	.4byte 0x676e6f6c
	.byte 0x00
	.8byte 0x38695f693832316d
	.byte 0x00
	.8byte 0x31695f693832316d
	.2byte 0x0036
	.4byte 0x726f6873
	.2byte 0x0074
	.8byte 0x33695f693832316d
	.2byte 0x0032
	.8byte 0x36695f693832316d
	.2byte 0x0034
	.8byte 0x38755f693832316d
	.byte 0x00
	.8byte 0x64656e6769736e75
	.4byte 0x61686320
	.2byte 0x0072
	.8byte 0x31755f693832316d
	.2byte 0x0036
	.8byte 0x64656e6769736e75
	.4byte 0x6f687320
	.2byte 0x7472
	.byte 0x00
	.8byte 0x33755f693832316d
	.2byte 0x0032
	.8byte 0x36755f693832316d
	.2byte 0x0034
	.8byte 0x64656e6769736e75
	.4byte 0x6e6f6c20
	.2byte 0x0067
	.4byte 0x64696f76
	.byte 0x00
	.4byte 0x657a6973
	.2byte 0x745f
	.byte 0x00
	.4byte 0x69676562
	.2byte 0x006e
	.8byte 0x745f3436746e6975
	.byte 0x00
	.4byte 0x454c4946
	.byte 0x00
	.8byte 0x454c49465f4f495f
	.byte 0x00
	.4byte 0x616c665f
	.2byte 0x7367
	.byte 0x00
	.8byte 0x646165725f4f495f
	.4byte 0x7274705f
	.byte 0x00
	.8byte 0x646165725f4f495f
	.4byte 0x646e655f
	.byte 0x00
	.8byte 0x646165725f4f495f
	.4byte 0x7361625f
	.2byte 0x0065
	.8byte 0x746972775f4f495f
	.4byte 0x61625f65
	.2byte 0x6573
	.byte 0x00
	.8byte 0x746972775f4f495f
	.4byte 0x74705f65
	.2byte 0x0072
	.8byte 0x746972775f4f495f
	.4byte 0x6e655f65
	.2byte 0x0064
	.8byte 0x5f6675625f4f495f
	.4byte 0x65736162
	.byte 0x00
	.8byte 0x5f6675625f4f495f
	.4byte 0x00646e65
	.8byte 0x657661735f4f495f
	.4byte 0x7361625f
	.2byte 0x0065
	.8byte 0x6b6361625f4f495f
	.8byte 0x00657361625f7075
	.8byte 0x657661735f4f495f
	.4byte 0x646e655f
	.byte 0x00
	.8byte 0x7372656b72616d5f
	.byte 0x00
	.8byte 0x6b72616d5f4f495f
	.2byte 0x7265
	.byte 0x00
	.4byte 0x78656e5f
	.2byte 0x0074
	.4byte 0x7562735f
	.2byte 0x0066
	.4byte 0x736f705f
	.byte 0x00
	.4byte 0x6168635f
	.2byte 0x6e69
	.byte 0x00
	.8byte 0x006f6e656c69665f
	.8byte 0x00327367616c665f
	.8byte 0x66666f5f646c6f5f
	.4byte 0x00746573
	.8byte 0x00745f66666f5f5f
	.8byte 0x6c6f635f7275635f
	.4byte 0x006e6d75
	.8byte 0x5f656c626174765f
	.4byte 0x7366666f
	.2byte 0x7465
	.byte 0x00
	.8byte 0x756274726f68735f
	.2byte 0x0066
	.4byte 0x636f6c5f
	.2byte 0x006b
	.8byte 0x6b636f6c5f4f495f
	.2byte 0x745f
	.byte 0x00
	.8byte 0x5f343666666f5f5f
	.2byte 0x0074
	.4byte 0x61705f5f
	.2byte 0x3164
	.byte 0x00
	.4byte 0x61705f5f
	.2byte 0x3264
	.byte 0x00
	.4byte 0x61705f5f
	.2byte 0x3364
	.byte 0x00
	.4byte 0x61705f5f
	.2byte 0x3464
	.byte 0x00
	.4byte 0x61705f5f
	.2byte 0x3564
	.byte 0x00
	.4byte 0x646f6d5f
	.2byte 0x0065
	.8byte 0x32646573756e755f
	.byte 0x00
	.4byte 0x657a6973
	.byte 0x00
	.4byte 0x66667562
	.2byte 0x7265
	.byte 0x00
	.8byte 0x007369625f646461
	.8byte 0x6b6361705f646461
	.byte 0x00
	.8byte 0x737469625f646461
	.4byte 0x6563696c
	.byte 0x00
	.8byte 0x6b6f6f6c5f646461
	.4byte 0x61656861
	.2byte 0x0064
	.8byte 0x6b6f6f6c5f646461
	.8byte 0x65725f6461656861
	.8byte 0x006c756465686373
	.4byte 0x6f647473
	.2byte 0x7475
	.byte 0x00
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
	.section .text
.LNDBG_TXe:
# End
