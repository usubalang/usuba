	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "-Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -fno-inline -O3 -g -S";
	.file "add_16.c"
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
                                                          #156.13
..LN0:
	.file   1 "add_16.c"
	.loc    1  156  is_stmt 1
        pushq     %rbp                                          #156.13
	.cfi_def_cfa_offset 16
..LN1:
        movq      %rsp, %rbp                                    #156.13
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN2:
        andq      $-128, %rsp                                   #156.13
..LN3:
        pushq     %r12                                          #156.13
..LN4:
        pushq     %r13                                          #156.13
..LN5:
        pushq     %r14                                          #156.13
..LN6:
        pushq     %r15                                          #156.13
..LN7:
        pushq     %rbx                                          #156.13
..LN8:
        subq      $600, %rsp                                    #156.13
..LN9:
        movl      $10330110, %esi                               #156.13
..LN10:
        movl      $3, %edi                                      #156.13
..LN11:
        call      __intel_new_feature_proc_init                 #156.13
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
..LN12:
                                # LOE
..B1.174:                       # Preds ..B1.1
                                # Execution count [1.00e+00]
..LN13:
        vstmxcsr  (%rsp)                                        #156.13
..LN14:
	.loc    1  159  prologue_end  is_stmt 1
        movl      $.L_2__STRING.0, %edi                         #159.13
..LN15:
        movl      $.L_2__STRING.1, %esi                         #159.13
..LN16:
	.loc    1  156  is_stmt 1
        orl       $32832, (%rsp)                                #156.13
..LN17:
        vldmxcsr  (%rsp)                                        #156.13
..LN18:
	.loc    1  159  is_stmt 1
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #159.13
..LN19:
                                # LOE rax
..B1.173:                       # Preds ..B1.174
                                # Execution count [1.00e+00]
..LN20:
        movq      %rax, %rbx                                    #159.13
..LN21:
                                # LOE rbx
..B1.2:                         # Preds ..B1.173
                                # Execution count [1.00e+00]
..LN22:
	.loc    1  165  is_stmt 1
        xorl      %edi, %edi                                    #165.9
..LN23:
#       time(time_t *)
        call      time                                          #165.9
..LN24:
                                # LOE rax rbx
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
..LN25:
        movl      %eax, %edi                                    #165.3
..LN26:
#       srand(unsigned int)
        call      srand                                         #165.3
..LN27:
                                # LOE rbx
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
..LN28:
	.loc    1  166  is_stmt 1
        movl      $32, %edi                                     #166.30
..LN29:
        movl      $256000000, %esi                              #166.30
..___tag_value_main.13:
..LN30:
#       aligned_alloc(size_t, size_t)
        call      aligned_alloc                                 #166.30
..___tag_value_main.14:
..LN31:
                                # LOE rax rbx
..B1.176:                       # Preds ..B1.4
                                # Execution count [1.00e+00]
..LN32:
        movq      %rax, %r12                                    #166.30
..LN33:
                                # LOE rbx r12
..B1.5:                         # Preds ..B1.176
                                # Execution count [1.00e+00]
..LN34:
	.loc    1  168  is_stmt 1
#       rand(void)
        call      rand                                          #168.22
..LN35:
                                # LOE rbx r12 eax
..B1.177:                       # Preds ..B1.5
                                # Execution count [1.00e+00]
..LN36:
        movl      %eax, %r15d                                   #168.22
..LN37:
                                # LOE rbx r12 r15d
..B1.6:                         # Preds ..B1.177
                                # Execution count [1.00e+00]
..LN38:
#       rand(void)
        call      rand                                          #168.29
..LN39:
                                # LOE rbx r12 eax r15d
..B1.178:                       # Preds ..B1.6
                                # Execution count [1.00e+00]
..LN40:
        movl      %eax, %r14d                                   #168.29
..LN41:
                                # LOE rbx r12 r14d r15d
..B1.7:                         # Preds ..B1.178
                                # Execution count [1.00e+00]
..LN42:
#       rand(void)
        call      rand                                          #168.36
..LN43:
                                # LOE rbx r12 eax r14d r15d
..B1.179:                       # Preds ..B1.7
                                # Execution count [1.00e+00]
..LN44:
        movl      %eax, %r13d                                   #168.36
..LN45:
                                # LOE rbx r12 r13d r14d r15d
..B1.8:                         # Preds ..B1.179
                                # Execution count [1.00e+00]
..LN46:
#       rand(void)
        call      rand                                          #168.43
..LN47:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.9:                         # Preds ..B1.8
                                # Execution count [1.00e+00]
..LN48:
        vmovd     %eax, %xmm0                                   #168.8
..LN49:
        vmovd     %r13d, %xmm1                                  #168.8
..LN50:
        vmovd     %r14d, %xmm2                                  #168.8
..LN51:
        vmovd     %r15d, %xmm3                                  #168.8
..LN52:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #168.8
..LN53:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #168.8
..LN54:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #168.8
..LN55:
        vmovups   %xmm6, 32(%rsp)                               #168.8[spill]
..LN56:
	.loc    1  169  is_stmt 1
#       rand(void)
        call      rand                                          #169.22
..LN57:
                                # LOE rbx r12 eax
..B1.181:                       # Preds ..B1.9
                                # Execution count [1.00e+00]
..LN58:
        movl      %eax, %r15d                                   #169.22
..LN59:
                                # LOE rbx r12 r15d
..B1.10:                        # Preds ..B1.181
                                # Execution count [1.00e+00]
..LN60:
#       rand(void)
        call      rand                                          #169.29
..LN61:
                                # LOE rbx r12 eax r15d
..B1.182:                       # Preds ..B1.10
                                # Execution count [1.00e+00]
..LN62:
        movl      %eax, %r14d                                   #169.29
..LN63:
                                # LOE rbx r12 r14d r15d
..B1.11:                        # Preds ..B1.182
                                # Execution count [1.00e+00]
..LN64:
#       rand(void)
        call      rand                                          #169.36
..LN65:
                                # LOE rbx r12 eax r14d r15d
..B1.183:                       # Preds ..B1.11
                                # Execution count [1.00e+00]
..LN66:
        movl      %eax, %r13d                                   #169.36
..LN67:
                                # LOE rbx r12 r13d r14d r15d
..B1.12:                        # Preds ..B1.183
                                # Execution count [1.00e+00]
..LN68:
#       rand(void)
        call      rand                                          #169.43
..LN69:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.13:                        # Preds ..B1.12
                                # Execution count [1.00e+00]
..LN70:
        vmovd     %eax, %xmm0                                   #169.8
..LN71:
        vmovd     %r13d, %xmm1                                  #169.8
..LN72:
        vmovd     %r14d, %xmm2                                  #169.8
..LN73:
        vmovd     %r15d, %xmm3                                  #169.8
..LN74:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #169.8
..LN75:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #169.8
..LN76:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #169.8
..LN77:
        vmovups   %xmm6, 48(%rsp)                               #169.8[spill]
..LN78:
	.loc    1  170  is_stmt 1
#       rand(void)
        call      rand                                          #170.22
..LN79:
                                # LOE rbx r12 eax
..B1.185:                       # Preds ..B1.13
                                # Execution count [1.00e+00]
..LN80:
        movl      %eax, %r15d                                   #170.22
..LN81:
                                # LOE rbx r12 r15d
..B1.14:                        # Preds ..B1.185
                                # Execution count [1.00e+00]
..LN82:
#       rand(void)
        call      rand                                          #170.29
..LN83:
                                # LOE rbx r12 eax r15d
..B1.186:                       # Preds ..B1.14
                                # Execution count [1.00e+00]
..LN84:
        movl      %eax, %r14d                                   #170.29
..LN85:
                                # LOE rbx r12 r14d r15d
..B1.15:                        # Preds ..B1.186
                                # Execution count [1.00e+00]
..LN86:
#       rand(void)
        call      rand                                          #170.36
..LN87:
                                # LOE rbx r12 eax r14d r15d
..B1.187:                       # Preds ..B1.15
                                # Execution count [1.00e+00]
..LN88:
        movl      %eax, %r13d                                   #170.36
..LN89:
                                # LOE rbx r12 r13d r14d r15d
..B1.16:                        # Preds ..B1.187
                                # Execution count [1.00e+00]
..LN90:
#       rand(void)
        call      rand                                          #170.43
..LN91:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.17:                        # Preds ..B1.16
                                # Execution count [1.00e+00]
..LN92:
        vmovd     %eax, %xmm0                                   #170.8
..LN93:
        vmovd     %r13d, %xmm1                                  #170.8
..LN94:
        vmovd     %r14d, %xmm2                                  #170.8
..LN95:
        vmovd     %r15d, %xmm3                                  #170.8
..LN96:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #170.8
..LN97:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #170.8
..LN98:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #170.8
..LN99:
        vmovups   %xmm6, 64(%rsp)                               #170.8[spill]
..LN100:
	.loc    1  171  is_stmt 1
#       rand(void)
        call      rand                                          #171.22
..LN101:
                                # LOE rbx r12 eax
..B1.189:                       # Preds ..B1.17
                                # Execution count [1.00e+00]
..LN102:
        movl      %eax, %r15d                                   #171.22
..LN103:
                                # LOE rbx r12 r15d
..B1.18:                        # Preds ..B1.189
                                # Execution count [1.00e+00]
..LN104:
#       rand(void)
        call      rand                                          #171.29
..LN105:
                                # LOE rbx r12 eax r15d
..B1.190:                       # Preds ..B1.18
                                # Execution count [1.00e+00]
..LN106:
        movl      %eax, %r14d                                   #171.29
..LN107:
                                # LOE rbx r12 r14d r15d
..B1.19:                        # Preds ..B1.190
                                # Execution count [1.00e+00]
..LN108:
#       rand(void)
        call      rand                                          #171.36
..LN109:
                                # LOE rbx r12 eax r14d r15d
..B1.191:                       # Preds ..B1.19
                                # Execution count [1.00e+00]
..LN110:
        movl      %eax, %r13d                                   #171.36
..LN111:
                                # LOE rbx r12 r13d r14d r15d
..B1.20:                        # Preds ..B1.191
                                # Execution count [1.00e+00]
..LN112:
#       rand(void)
        call      rand                                          #171.43
..LN113:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.21:                        # Preds ..B1.20
                                # Execution count [1.00e+00]
..LN114:
        vmovd     %eax, %xmm0                                   #171.8
..LN115:
        vmovd     %r13d, %xmm1                                  #171.8
..LN116:
        vmovd     %r14d, %xmm2                                  #171.8
..LN117:
        vmovd     %r15d, %xmm3                                  #171.8
..LN118:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #171.8
..LN119:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #171.8
..LN120:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #171.8
..LN121:
        vmovups   %xmm6, 80(%rsp)                               #171.8[spill]
..LN122:
	.loc    1  172  is_stmt 1
#       rand(void)
        call      rand                                          #172.22
..LN123:
                                # LOE rbx r12 eax
..B1.193:                       # Preds ..B1.21
                                # Execution count [1.00e+00]
..LN124:
        movl      %eax, %r15d                                   #172.22
..LN125:
                                # LOE rbx r12 r15d
..B1.22:                        # Preds ..B1.193
                                # Execution count [1.00e+00]
..LN126:
#       rand(void)
        call      rand                                          #172.29
..LN127:
                                # LOE rbx r12 eax r15d
..B1.194:                       # Preds ..B1.22
                                # Execution count [1.00e+00]
..LN128:
        movl      %eax, %r14d                                   #172.29
..LN129:
                                # LOE rbx r12 r14d r15d
..B1.23:                        # Preds ..B1.194
                                # Execution count [1.00e+00]
..LN130:
#       rand(void)
        call      rand                                          #172.36
..LN131:
                                # LOE rbx r12 eax r14d r15d
..B1.195:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
..LN132:
        movl      %eax, %r13d                                   #172.36
..LN133:
                                # LOE rbx r12 r13d r14d r15d
..B1.24:                        # Preds ..B1.195
                                # Execution count [1.00e+00]
..LN134:
#       rand(void)
        call      rand                                          #172.43
..LN135:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.25:                        # Preds ..B1.24
                                # Execution count [1.00e+00]
..LN136:
        vmovd     %eax, %xmm0                                   #172.8
..LN137:
        vmovd     %r13d, %xmm1                                  #172.8
..LN138:
        vmovd     %r14d, %xmm2                                  #172.8
..LN139:
        vmovd     %r15d, %xmm3                                  #172.8
..LN140:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #172.8
..LN141:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #172.8
..LN142:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #172.8
..LN143:
        vmovups   %xmm6, 96(%rsp)                               #172.8[spill]
..LN144:
	.loc    1  173  is_stmt 1
#       rand(void)
        call      rand                                          #173.22
..LN145:
                                # LOE rbx r12 eax
..B1.197:                       # Preds ..B1.25
                                # Execution count [1.00e+00]
..LN146:
        movl      %eax, %r15d                                   #173.22
..LN147:
                                # LOE rbx r12 r15d
..B1.26:                        # Preds ..B1.197
                                # Execution count [1.00e+00]
..LN148:
#       rand(void)
        call      rand                                          #173.29
..LN149:
                                # LOE rbx r12 eax r15d
..B1.198:                       # Preds ..B1.26
                                # Execution count [1.00e+00]
..LN150:
        movl      %eax, %r14d                                   #173.29
..LN151:
                                # LOE rbx r12 r14d r15d
..B1.27:                        # Preds ..B1.198
                                # Execution count [1.00e+00]
..LN152:
#       rand(void)
        call      rand                                          #173.36
..LN153:
                                # LOE rbx r12 eax r14d r15d
..B1.199:                       # Preds ..B1.27
                                # Execution count [1.00e+00]
..LN154:
        movl      %eax, %r13d                                   #173.36
..LN155:
                                # LOE rbx r12 r13d r14d r15d
..B1.28:                        # Preds ..B1.199
                                # Execution count [1.00e+00]
..LN156:
#       rand(void)
        call      rand                                          #173.43
..LN157:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.00e+00]
..LN158:
        vmovd     %eax, %xmm0                                   #173.8
..LN159:
        vmovd     %r13d, %xmm1                                  #173.8
..LN160:
        vmovd     %r14d, %xmm2                                  #173.8
..LN161:
        vmovd     %r15d, %xmm3                                  #173.8
..LN162:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #173.8
..LN163:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #173.8
..LN164:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #173.8
..LN165:
        vmovups   %xmm6, 112(%rsp)                              #173.8[spill]
..LN166:
	.loc    1  174  is_stmt 1
#       rand(void)
        call      rand                                          #174.22
..LN167:
                                # LOE rbx r12 eax
..B1.201:                       # Preds ..B1.29
                                # Execution count [1.00e+00]
..LN168:
        movl      %eax, %r15d                                   #174.22
..LN169:
                                # LOE rbx r12 r15d
..B1.30:                        # Preds ..B1.201
                                # Execution count [1.00e+00]
..LN170:
#       rand(void)
        call      rand                                          #174.29
..LN171:
                                # LOE rbx r12 eax r15d
..B1.202:                       # Preds ..B1.30
                                # Execution count [1.00e+00]
..LN172:
        movl      %eax, %r14d                                   #174.29
..LN173:
                                # LOE rbx r12 r14d r15d
..B1.31:                        # Preds ..B1.202
                                # Execution count [1.00e+00]
..LN174:
#       rand(void)
        call      rand                                          #174.36
..LN175:
                                # LOE rbx r12 eax r14d r15d
..B1.203:                       # Preds ..B1.31
                                # Execution count [1.00e+00]
..LN176:
        movl      %eax, %r13d                                   #174.36
..LN177:
                                # LOE rbx r12 r13d r14d r15d
..B1.32:                        # Preds ..B1.203
                                # Execution count [1.00e+00]
..LN178:
#       rand(void)
        call      rand                                          #174.43
..LN179:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.33:                        # Preds ..B1.32
                                # Execution count [1.00e+00]
..LN180:
        vmovd     %eax, %xmm0                                   #174.8
..LN181:
        vmovd     %r13d, %xmm1                                  #174.8
..LN182:
        vmovd     %r14d, %xmm2                                  #174.8
..LN183:
        vmovd     %r15d, %xmm3                                  #174.8
..LN184:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #174.8
..LN185:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #174.8
..LN186:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #174.8
..LN187:
        vmovups   %xmm6, 128(%rsp)                              #174.8[spill]
..LN188:
	.loc    1  175  is_stmt 1
#       rand(void)
        call      rand                                          #175.22
..LN189:
                                # LOE rbx r12 eax
..B1.205:                       # Preds ..B1.33
                                # Execution count [1.00e+00]
..LN190:
        movl      %eax, %r15d                                   #175.22
..LN191:
                                # LOE rbx r12 r15d
..B1.34:                        # Preds ..B1.205
                                # Execution count [1.00e+00]
..LN192:
#       rand(void)
        call      rand                                          #175.29
..LN193:
                                # LOE rbx r12 eax r15d
..B1.206:                       # Preds ..B1.34
                                # Execution count [1.00e+00]
..LN194:
        movl      %eax, %r14d                                   #175.29
..LN195:
                                # LOE rbx r12 r14d r15d
..B1.35:                        # Preds ..B1.206
                                # Execution count [1.00e+00]
..LN196:
#       rand(void)
        call      rand                                          #175.36
..LN197:
                                # LOE rbx r12 eax r14d r15d
..B1.207:                       # Preds ..B1.35
                                # Execution count [1.00e+00]
..LN198:
        movl      %eax, %r13d                                   #175.36
..LN199:
                                # LOE rbx r12 r13d r14d r15d
..B1.36:                        # Preds ..B1.207
                                # Execution count [1.00e+00]
..LN200:
#       rand(void)
        call      rand                                          #175.43
..LN201:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.37:                        # Preds ..B1.36
                                # Execution count [1.00e+00]
..LN202:
        vmovd     %eax, %xmm0                                   #175.8
..LN203:
        vmovd     %r13d, %xmm1                                  #175.8
..LN204:
        vmovd     %r14d, %xmm2                                  #175.8
..LN205:
        vmovd     %r15d, %xmm3                                  #175.8
..LN206:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #175.8
..LN207:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #175.8
..LN208:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #175.8
..LN209:
        vmovups   %xmm6, 144(%rsp)                              #175.8[spill]
..LN210:
	.loc    1  176  is_stmt 1
#       rand(void)
        call      rand                                          #176.22
..LN211:
                                # LOE rbx r12 eax
..B1.209:                       # Preds ..B1.37
                                # Execution count [1.00e+00]
..LN212:
        movl      %eax, %r15d                                   #176.22
..LN213:
                                # LOE rbx r12 r15d
..B1.38:                        # Preds ..B1.209
                                # Execution count [1.00e+00]
..LN214:
#       rand(void)
        call      rand                                          #176.29
..LN215:
                                # LOE rbx r12 eax r15d
..B1.210:                       # Preds ..B1.38
                                # Execution count [1.00e+00]
..LN216:
        movl      %eax, %r14d                                   #176.29
..LN217:
                                # LOE rbx r12 r14d r15d
..B1.39:                        # Preds ..B1.210
                                # Execution count [1.00e+00]
..LN218:
#       rand(void)
        call      rand                                          #176.36
..LN219:
                                # LOE rbx r12 eax r14d r15d
..B1.211:                       # Preds ..B1.39
                                # Execution count [1.00e+00]
..LN220:
        movl      %eax, %r13d                                   #176.36
..LN221:
                                # LOE rbx r12 r13d r14d r15d
..B1.40:                        # Preds ..B1.211
                                # Execution count [1.00e+00]
..LN222:
#       rand(void)
        call      rand                                          #176.43
..LN223:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.41:                        # Preds ..B1.40
                                # Execution count [1.00e+00]
..LN224:
        vmovd     %eax, %xmm0                                   #176.8
..LN225:
        vmovd     %r13d, %xmm1                                  #176.8
..LN226:
        vmovd     %r14d, %xmm2                                  #176.8
..LN227:
        vmovd     %r15d, %xmm3                                  #176.8
..LN228:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #176.8
..LN229:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #176.8
..LN230:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #176.8
..LN231:
        vmovups   %xmm6, 160(%rsp)                              #176.8[spill]
..LN232:
	.loc    1  177  is_stmt 1
#       rand(void)
        call      rand                                          #177.23
..LN233:
                                # LOE rbx r12 eax
..B1.213:                       # Preds ..B1.41
                                # Execution count [1.00e+00]
..LN234:
        movl      %eax, %r15d                                   #177.23
..LN235:
                                # LOE rbx r12 r15d
..B1.42:                        # Preds ..B1.213
                                # Execution count [1.00e+00]
..LN236:
#       rand(void)
        call      rand                                          #177.30
..LN237:
                                # LOE rbx r12 eax r15d
..B1.214:                       # Preds ..B1.42
                                # Execution count [1.00e+00]
..LN238:
        movl      %eax, %r14d                                   #177.30
..LN239:
                                # LOE rbx r12 r14d r15d
..B1.43:                        # Preds ..B1.214
                                # Execution count [1.00e+00]
..LN240:
#       rand(void)
        call      rand                                          #177.37
..LN241:
                                # LOE rbx r12 eax r14d r15d
..B1.215:                       # Preds ..B1.43
                                # Execution count [1.00e+00]
..LN242:
        movl      %eax, %r13d                                   #177.37
..LN243:
                                # LOE rbx r12 r13d r14d r15d
..B1.44:                        # Preds ..B1.215
                                # Execution count [1.00e+00]
..LN244:
#       rand(void)
        call      rand                                          #177.44
..LN245:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.00e+00]
..LN246:
        vmovd     %eax, %xmm0                                   #177.9
..LN247:
        vmovd     %r13d, %xmm1                                  #177.9
..LN248:
        vmovd     %r14d, %xmm2                                  #177.9
..LN249:
        vmovd     %r15d, %xmm3                                  #177.9
..LN250:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #177.9
..LN251:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #177.9
..LN252:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #177.9
..LN253:
        vmovups   %xmm6, 176(%rsp)                              #177.9[spill]
..LN254:
	.loc    1  178  is_stmt 1
#       rand(void)
        call      rand                                          #178.23
..LN255:
                                # LOE rbx r12 eax
..B1.217:                       # Preds ..B1.45
                                # Execution count [1.00e+00]
..LN256:
        movl      %eax, %r15d                                   #178.23
..LN257:
                                # LOE rbx r12 r15d
..B1.46:                        # Preds ..B1.217
                                # Execution count [1.00e+00]
..LN258:
#       rand(void)
        call      rand                                          #178.30
..LN259:
                                # LOE rbx r12 eax r15d
..B1.218:                       # Preds ..B1.46
                                # Execution count [1.00e+00]
..LN260:
        movl      %eax, %r14d                                   #178.30
..LN261:
                                # LOE rbx r12 r14d r15d
..B1.47:                        # Preds ..B1.218
                                # Execution count [1.00e+00]
..LN262:
#       rand(void)
        call      rand                                          #178.37
..LN263:
                                # LOE rbx r12 eax r14d r15d
..B1.219:                       # Preds ..B1.47
                                # Execution count [1.00e+00]
..LN264:
        movl      %eax, %r13d                                   #178.37
..LN265:
                                # LOE rbx r12 r13d r14d r15d
..B1.48:                        # Preds ..B1.219
                                # Execution count [1.00e+00]
..LN266:
#       rand(void)
        call      rand                                          #178.44
..LN267:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.49:                        # Preds ..B1.48
                                # Execution count [1.00e+00]
..LN268:
        vmovd     %eax, %xmm0                                   #178.9
..LN269:
        vmovd     %r13d, %xmm1                                  #178.9
..LN270:
        vmovd     %r14d, %xmm2                                  #178.9
..LN271:
        vmovd     %r15d, %xmm3                                  #178.9
..LN272:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #178.9
..LN273:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #178.9
..LN274:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #178.9
..LN275:
        vmovups   %xmm6, 192(%rsp)                              #178.9[spill]
..LN276:
	.loc    1  179  is_stmt 1
#       rand(void)
        call      rand                                          #179.23
..LN277:
                                # LOE rbx r12 eax
..B1.221:                       # Preds ..B1.49
                                # Execution count [1.00e+00]
..LN278:
        movl      %eax, %r15d                                   #179.23
..LN279:
                                # LOE rbx r12 r15d
..B1.50:                        # Preds ..B1.221
                                # Execution count [1.00e+00]
..LN280:
#       rand(void)
        call      rand                                          #179.30
..LN281:
                                # LOE rbx r12 eax r15d
..B1.222:                       # Preds ..B1.50
                                # Execution count [1.00e+00]
..LN282:
        movl      %eax, %r14d                                   #179.30
..LN283:
                                # LOE rbx r12 r14d r15d
..B1.51:                        # Preds ..B1.222
                                # Execution count [1.00e+00]
..LN284:
#       rand(void)
        call      rand                                          #179.37
..LN285:
                                # LOE rbx r12 eax r14d r15d
..B1.223:                       # Preds ..B1.51
                                # Execution count [1.00e+00]
..LN286:
        movl      %eax, %r13d                                   #179.37
..LN287:
                                # LOE rbx r12 r13d r14d r15d
..B1.52:                        # Preds ..B1.223
                                # Execution count [1.00e+00]
..LN288:
#       rand(void)
        call      rand                                          #179.44
..LN289:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.53:                        # Preds ..B1.52
                                # Execution count [1.00e+00]
..LN290:
        vmovd     %eax, %xmm0                                   #179.9
..LN291:
        vmovd     %r13d, %xmm1                                  #179.9
..LN292:
        vmovd     %r14d, %xmm2                                  #179.9
..LN293:
        vmovd     %r15d, %xmm3                                  #179.9
..LN294:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #179.9
..LN295:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #179.9
..LN296:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #179.9
..LN297:
        vmovups   %xmm6, 208(%rsp)                              #179.9[spill]
..LN298:
	.loc    1  180  is_stmt 1
#       rand(void)
        call      rand                                          #180.23
..LN299:
                                # LOE rbx r12 eax
..B1.225:                       # Preds ..B1.53
                                # Execution count [1.00e+00]
..LN300:
        movl      %eax, %r15d                                   #180.23
..LN301:
                                # LOE rbx r12 r15d
..B1.54:                        # Preds ..B1.225
                                # Execution count [1.00e+00]
..LN302:
#       rand(void)
        call      rand                                          #180.30
..LN303:
                                # LOE rbx r12 eax r15d
..B1.226:                       # Preds ..B1.54
                                # Execution count [1.00e+00]
..LN304:
        movl      %eax, %r14d                                   #180.30
..LN305:
                                # LOE rbx r12 r14d r15d
..B1.55:                        # Preds ..B1.226
                                # Execution count [1.00e+00]
..LN306:
#       rand(void)
        call      rand                                          #180.37
..LN307:
                                # LOE rbx r12 eax r14d r15d
..B1.227:                       # Preds ..B1.55
                                # Execution count [1.00e+00]
..LN308:
        movl      %eax, %r13d                                   #180.37
..LN309:
                                # LOE rbx r12 r13d r14d r15d
..B1.56:                        # Preds ..B1.227
                                # Execution count [1.00e+00]
..LN310:
#       rand(void)
        call      rand                                          #180.44
..LN311:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.57:                        # Preds ..B1.56
                                # Execution count [1.00e+00]
..LN312:
        vmovd     %eax, %xmm0                                   #180.9
..LN313:
        vmovd     %r13d, %xmm1                                  #180.9
..LN314:
        vmovd     %r14d, %xmm2                                  #180.9
..LN315:
        vmovd     %r15d, %xmm3                                  #180.9
..LN316:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #180.9
..LN317:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #180.9
..LN318:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #180.9
..LN319:
        vmovups   %xmm6, 224(%rsp)                              #180.9[spill]
..LN320:
	.loc    1  181  is_stmt 1
#       rand(void)
        call      rand                                          #181.23
..LN321:
                                # LOE rbx r12 eax
..B1.229:                       # Preds ..B1.57
                                # Execution count [1.00e+00]
..LN322:
        movl      %eax, %r15d                                   #181.23
..LN323:
                                # LOE rbx r12 r15d
..B1.58:                        # Preds ..B1.229
                                # Execution count [1.00e+00]
..LN324:
#       rand(void)
        call      rand                                          #181.30
..LN325:
                                # LOE rbx r12 eax r15d
..B1.230:                       # Preds ..B1.58
                                # Execution count [1.00e+00]
..LN326:
        movl      %eax, %r14d                                   #181.30
..LN327:
                                # LOE rbx r12 r14d r15d
..B1.59:                        # Preds ..B1.230
                                # Execution count [1.00e+00]
..LN328:
#       rand(void)
        call      rand                                          #181.37
..LN329:
                                # LOE rbx r12 eax r14d r15d
..B1.231:                       # Preds ..B1.59
                                # Execution count [1.00e+00]
..LN330:
        movl      %eax, %r13d                                   #181.37
..LN331:
                                # LOE rbx r12 r13d r14d r15d
..B1.60:                        # Preds ..B1.231
                                # Execution count [1.00e+00]
..LN332:
#       rand(void)
        call      rand                                          #181.44
..LN333:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.61:                        # Preds ..B1.60
                                # Execution count [1.00e+00]
..LN334:
        vmovd     %eax, %xmm0                                   #181.9
..LN335:
        vmovd     %r13d, %xmm1                                  #181.9
..LN336:
        vmovd     %r14d, %xmm2                                  #181.9
..LN337:
        vmovd     %r15d, %xmm3                                  #181.9
..LN338:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #181.9
..LN339:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #181.9
..LN340:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #181.9
..LN341:
        vmovups   %xmm6, 240(%rsp)                              #181.9[spill]
..LN342:
	.loc    1  182  is_stmt 1
#       rand(void)
        call      rand                                          #182.23
..LN343:
                                # LOE rbx r12 eax
..B1.233:                       # Preds ..B1.61
                                # Execution count [1.00e+00]
..LN344:
        movl      %eax, %r15d                                   #182.23
..LN345:
                                # LOE rbx r12 r15d
..B1.62:                        # Preds ..B1.233
                                # Execution count [1.00e+00]
..LN346:
#       rand(void)
        call      rand                                          #182.30
..LN347:
                                # LOE rbx r12 eax r15d
..B1.234:                       # Preds ..B1.62
                                # Execution count [1.00e+00]
..LN348:
        movl      %eax, %r14d                                   #182.30
..LN349:
                                # LOE rbx r12 r14d r15d
..B1.63:                        # Preds ..B1.234
                                # Execution count [1.00e+00]
..LN350:
#       rand(void)
        call      rand                                          #182.37
..LN351:
                                # LOE rbx r12 eax r14d r15d
..B1.235:                       # Preds ..B1.63
                                # Execution count [1.00e+00]
..LN352:
        movl      %eax, %r13d                                   #182.37
..LN353:
                                # LOE rbx r12 r13d r14d r15d
..B1.64:                        # Preds ..B1.235
                                # Execution count [1.00e+00]
..LN354:
#       rand(void)
        call      rand                                          #182.44
..LN355:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.65:                        # Preds ..B1.64
                                # Execution count [1.00e+00]
..LN356:
        vmovd     %eax, %xmm0                                   #182.9
..LN357:
        vmovd     %r13d, %xmm1                                  #182.9
..LN358:
        vmovd     %r14d, %xmm2                                  #182.9
..LN359:
        vmovd     %r15d, %xmm3                                  #182.9
..LN360:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #182.9
..LN361:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #182.9
..LN362:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #182.9
..LN363:
        vmovups   %xmm6, 256(%rsp)                              #182.9[spill]
..LN364:
	.loc    1  183  is_stmt 1
#       rand(void)
        call      rand                                          #183.23
..LN365:
                                # LOE rbx r12 eax
..B1.237:                       # Preds ..B1.65
                                # Execution count [1.00e+00]
..LN366:
        movl      %eax, %r15d                                   #183.23
..LN367:
                                # LOE rbx r12 r15d
..B1.66:                        # Preds ..B1.237
                                # Execution count [1.00e+00]
..LN368:
#       rand(void)
        call      rand                                          #183.30
..LN369:
                                # LOE rbx r12 eax r15d
..B1.238:                       # Preds ..B1.66
                                # Execution count [1.00e+00]
..LN370:
        movl      %eax, %r14d                                   #183.30
..LN371:
                                # LOE rbx r12 r14d r15d
..B1.67:                        # Preds ..B1.238
                                # Execution count [1.00e+00]
..LN372:
#       rand(void)
        call      rand                                          #183.37
..LN373:
                                # LOE rbx r12 eax r14d r15d
..B1.239:                       # Preds ..B1.67
                                # Execution count [1.00e+00]
..LN374:
        movl      %eax, %r13d                                   #183.37
..LN375:
                                # LOE rbx r12 r13d r14d r15d
..B1.68:                        # Preds ..B1.239
                                # Execution count [1.00e+00]
..LN376:
#       rand(void)
        call      rand                                          #183.44
..LN377:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.69:                        # Preds ..B1.68
                                # Execution count [1.00e+00]
..LN378:
        vmovd     %eax, %xmm0                                   #183.9
..LN379:
        vmovd     %r13d, %xmm1                                  #183.9
..LN380:
        vmovd     %r14d, %xmm2                                  #183.9
..LN381:
        vmovd     %r15d, %xmm3                                  #183.9
..LN382:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #183.9
..LN383:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #183.9
..LN384:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #183.9
..LN385:
        vmovups   %xmm6, 272(%rsp)                              #183.9[spill]
..LN386:
	.loc    1  185  is_stmt 1
#       rand(void)
        call      rand                                          #185.22
..LN387:
                                # LOE rbx r12 eax
..B1.241:                       # Preds ..B1.69
                                # Execution count [1.00e+00]
..LN388:
        movl      %eax, %r15d                                   #185.22
..LN389:
                                # LOE rbx r12 r15d
..B1.70:                        # Preds ..B1.241
                                # Execution count [1.00e+00]
..LN390:
#       rand(void)
        call      rand                                          #185.29
..LN391:
                                # LOE rbx r12 eax r15d
..B1.242:                       # Preds ..B1.70
                                # Execution count [1.00e+00]
..LN392:
        movl      %eax, %r14d                                   #185.29
..LN393:
                                # LOE rbx r12 r14d r15d
..B1.71:                        # Preds ..B1.242
                                # Execution count [1.00e+00]
..LN394:
#       rand(void)
        call      rand                                          #185.36
..LN395:
                                # LOE rbx r12 eax r14d r15d
..B1.243:                       # Preds ..B1.71
                                # Execution count [1.00e+00]
..LN396:
        movl      %eax, %r13d                                   #185.36
..LN397:
                                # LOE rbx r12 r13d r14d r15d
..B1.72:                        # Preds ..B1.243
                                # Execution count [1.00e+00]
..LN398:
#       rand(void)
        call      rand                                          #185.43
..LN399:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.73:                        # Preds ..B1.72
                                # Execution count [1.00e+00]
..LN400:
        vmovd     %eax, %xmm0                                   #185.8
..LN401:
        vmovd     %r13d, %xmm1                                  #185.8
..LN402:
        vmovd     %r14d, %xmm2                                  #185.8
..LN403:
        vmovd     %r15d, %xmm3                                  #185.8
..LN404:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #185.8
..LN405:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #185.8
..LN406:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #185.8
..LN407:
        vmovups   %xmm6, 288(%rsp)                              #185.8[spill]
..LN408:
	.loc    1  186  is_stmt 1
#       rand(void)
        call      rand                                          #186.22
..LN409:
                                # LOE rbx r12 eax
..B1.245:                       # Preds ..B1.73
                                # Execution count [1.00e+00]
..LN410:
        movl      %eax, %r15d                                   #186.22
..LN411:
                                # LOE rbx r12 r15d
..B1.74:                        # Preds ..B1.245
                                # Execution count [1.00e+00]
..LN412:
#       rand(void)
        call      rand                                          #186.29
..LN413:
                                # LOE rbx r12 eax r15d
..B1.246:                       # Preds ..B1.74
                                # Execution count [1.00e+00]
..LN414:
        movl      %eax, %r14d                                   #186.29
..LN415:
                                # LOE rbx r12 r14d r15d
..B1.75:                        # Preds ..B1.246
                                # Execution count [1.00e+00]
..LN416:
#       rand(void)
        call      rand                                          #186.36
..LN417:
                                # LOE rbx r12 eax r14d r15d
..B1.247:                       # Preds ..B1.75
                                # Execution count [1.00e+00]
..LN418:
        movl      %eax, %r13d                                   #186.36
..LN419:
                                # LOE rbx r12 r13d r14d r15d
..B1.76:                        # Preds ..B1.247
                                # Execution count [1.00e+00]
..LN420:
#       rand(void)
        call      rand                                          #186.43
..LN421:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.77:                        # Preds ..B1.76
                                # Execution count [1.00e+00]
..LN422:
        vmovd     %eax, %xmm0                                   #186.8
..LN423:
        vmovd     %r13d, %xmm1                                  #186.8
..LN424:
        vmovd     %r14d, %xmm2                                  #186.8
..LN425:
        vmovd     %r15d, %xmm3                                  #186.8
..LN426:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #186.8
..LN427:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #186.8
..LN428:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #186.8
..LN429:
        vmovups   %xmm6, 304(%rsp)                              #186.8[spill]
..LN430:
	.loc    1  187  is_stmt 1
#       rand(void)
        call      rand                                          #187.22
..LN431:
                                # LOE rbx r12 eax
..B1.249:                       # Preds ..B1.77
                                # Execution count [1.00e+00]
..LN432:
        movl      %eax, %r15d                                   #187.22
..LN433:
                                # LOE rbx r12 r15d
..B1.78:                        # Preds ..B1.249
                                # Execution count [1.00e+00]
..LN434:
#       rand(void)
        call      rand                                          #187.29
..LN435:
                                # LOE rbx r12 eax r15d
..B1.250:                       # Preds ..B1.78
                                # Execution count [1.00e+00]
..LN436:
        movl      %eax, %r14d                                   #187.29
..LN437:
                                # LOE rbx r12 r14d r15d
..B1.79:                        # Preds ..B1.250
                                # Execution count [1.00e+00]
..LN438:
#       rand(void)
        call      rand                                          #187.36
..LN439:
                                # LOE rbx r12 eax r14d r15d
..B1.251:                       # Preds ..B1.79
                                # Execution count [1.00e+00]
..LN440:
        movl      %eax, %r13d                                   #187.36
..LN441:
                                # LOE rbx r12 r13d r14d r15d
..B1.80:                        # Preds ..B1.251
                                # Execution count [1.00e+00]
..LN442:
#       rand(void)
        call      rand                                          #187.43
..LN443:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.81:                        # Preds ..B1.80
                                # Execution count [1.00e+00]
..LN444:
        vmovd     %eax, %xmm0                                   #187.8
..LN445:
        vmovd     %r13d, %xmm1                                  #187.8
..LN446:
        vmovd     %r14d, %xmm2                                  #187.8
..LN447:
        vmovd     %r15d, %xmm3                                  #187.8
..LN448:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #187.8
..LN449:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #187.8
..LN450:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #187.8
..LN451:
        vmovups   %xmm6, 320(%rsp)                              #187.8[spill]
..LN452:
	.loc    1  188  is_stmt 1
#       rand(void)
        call      rand                                          #188.22
..LN453:
                                # LOE rbx r12 eax
..B1.253:                       # Preds ..B1.81
                                # Execution count [1.00e+00]
..LN454:
        movl      %eax, %r15d                                   #188.22
..LN455:
                                # LOE rbx r12 r15d
..B1.82:                        # Preds ..B1.253
                                # Execution count [1.00e+00]
..LN456:
#       rand(void)
        call      rand                                          #188.29
..LN457:
                                # LOE rbx r12 eax r15d
..B1.254:                       # Preds ..B1.82
                                # Execution count [1.00e+00]
..LN458:
        movl      %eax, %r14d                                   #188.29
..LN459:
                                # LOE rbx r12 r14d r15d
..B1.83:                        # Preds ..B1.254
                                # Execution count [1.00e+00]
..LN460:
#       rand(void)
        call      rand                                          #188.36
..LN461:
                                # LOE rbx r12 eax r14d r15d
..B1.255:                       # Preds ..B1.83
                                # Execution count [1.00e+00]
..LN462:
        movl      %eax, %r13d                                   #188.36
..LN463:
                                # LOE rbx r12 r13d r14d r15d
..B1.84:                        # Preds ..B1.255
                                # Execution count [1.00e+00]
..LN464:
#       rand(void)
        call      rand                                          #188.43
..LN465:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.85:                        # Preds ..B1.84
                                # Execution count [1.00e+00]
..LN466:
        vmovd     %eax, %xmm0                                   #188.8
..LN467:
        vmovd     %r13d, %xmm1                                  #188.8
..LN468:
        vmovd     %r14d, %xmm2                                  #188.8
..LN469:
        vmovd     %r15d, %xmm3                                  #188.8
..LN470:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #188.8
..LN471:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #188.8
..LN472:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #188.8
..LN473:
        vmovups   %xmm6, 336(%rsp)                              #188.8[spill]
..LN474:
	.loc    1  189  is_stmt 1
#       rand(void)
        call      rand                                          #189.22
..LN475:
                                # LOE rbx r12 eax
..B1.257:                       # Preds ..B1.85
                                # Execution count [1.00e+00]
..LN476:
        movl      %eax, %r15d                                   #189.22
..LN477:
                                # LOE rbx r12 r15d
..B1.86:                        # Preds ..B1.257
                                # Execution count [1.00e+00]
..LN478:
#       rand(void)
        call      rand                                          #189.29
..LN479:
                                # LOE rbx r12 eax r15d
..B1.258:                       # Preds ..B1.86
                                # Execution count [1.00e+00]
..LN480:
        movl      %eax, %r14d                                   #189.29
..LN481:
                                # LOE rbx r12 r14d r15d
..B1.87:                        # Preds ..B1.258
                                # Execution count [1.00e+00]
..LN482:
#       rand(void)
        call      rand                                          #189.36
..LN483:
                                # LOE rbx r12 eax r14d r15d
..B1.259:                       # Preds ..B1.87
                                # Execution count [1.00e+00]
..LN484:
        movl      %eax, %r13d                                   #189.36
..LN485:
                                # LOE rbx r12 r13d r14d r15d
..B1.88:                        # Preds ..B1.259
                                # Execution count [1.00e+00]
..LN486:
#       rand(void)
        call      rand                                          #189.43
..LN487:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.89:                        # Preds ..B1.88
                                # Execution count [1.00e+00]
..LN488:
        vmovd     %eax, %xmm0                                   #189.8
..LN489:
        vmovd     %r13d, %xmm1                                  #189.8
..LN490:
        vmovd     %r14d, %xmm2                                  #189.8
..LN491:
        vmovd     %r15d, %xmm3                                  #189.8
..LN492:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #189.8
..LN493:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #189.8
..LN494:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #189.8
..LN495:
        vmovups   %xmm6, 352(%rsp)                              #189.8[spill]
..LN496:
	.loc    1  190  is_stmt 1
#       rand(void)
        call      rand                                          #190.22
..LN497:
                                # LOE rbx r12 eax
..B1.261:                       # Preds ..B1.89
                                # Execution count [1.00e+00]
..LN498:
        movl      %eax, %r15d                                   #190.22
..LN499:
                                # LOE rbx r12 r15d
..B1.90:                        # Preds ..B1.261
                                # Execution count [1.00e+00]
..LN500:
#       rand(void)
        call      rand                                          #190.29
..LN501:
                                # LOE rbx r12 eax r15d
..B1.262:                       # Preds ..B1.90
                                # Execution count [1.00e+00]
..LN502:
        movl      %eax, %r14d                                   #190.29
..LN503:
                                # LOE rbx r12 r14d r15d
..B1.91:                        # Preds ..B1.262
                                # Execution count [1.00e+00]
..LN504:
#       rand(void)
        call      rand                                          #190.36
..LN505:
                                # LOE rbx r12 eax r14d r15d
..B1.263:                       # Preds ..B1.91
                                # Execution count [1.00e+00]
..LN506:
        movl      %eax, %r13d                                   #190.36
..LN507:
                                # LOE rbx r12 r13d r14d r15d
..B1.92:                        # Preds ..B1.263
                                # Execution count [1.00e+00]
..LN508:
#       rand(void)
        call      rand                                          #190.43
..LN509:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.93:                        # Preds ..B1.92
                                # Execution count [1.00e+00]
..LN510:
        vmovd     %eax, %xmm0                                   #190.8
..LN511:
        vmovd     %r13d, %xmm1                                  #190.8
..LN512:
        vmovd     %r14d, %xmm2                                  #190.8
..LN513:
        vmovd     %r15d, %xmm3                                  #190.8
..LN514:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #190.8
..LN515:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #190.8
..LN516:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #190.8
..LN517:
        vmovups   %xmm6, 368(%rsp)                              #190.8[spill]
..LN518:
	.loc    1  191  is_stmt 1
#       rand(void)
        call      rand                                          #191.22
..LN519:
                                # LOE rbx r12 eax
..B1.265:                       # Preds ..B1.93
                                # Execution count [1.00e+00]
..LN520:
        movl      %eax, %r15d                                   #191.22
..LN521:
                                # LOE rbx r12 r15d
..B1.94:                        # Preds ..B1.265
                                # Execution count [1.00e+00]
..LN522:
#       rand(void)
        call      rand                                          #191.29
..LN523:
                                # LOE rbx r12 eax r15d
..B1.266:                       # Preds ..B1.94
                                # Execution count [1.00e+00]
..LN524:
        movl      %eax, %r14d                                   #191.29
..LN525:
                                # LOE rbx r12 r14d r15d
..B1.95:                        # Preds ..B1.266
                                # Execution count [1.00e+00]
..LN526:
#       rand(void)
        call      rand                                          #191.36
..LN527:
                                # LOE rbx r12 eax r14d r15d
..B1.267:                       # Preds ..B1.95
                                # Execution count [1.00e+00]
..LN528:
        movl      %eax, %r13d                                   #191.36
..LN529:
                                # LOE rbx r12 r13d r14d r15d
..B1.96:                        # Preds ..B1.267
                                # Execution count [1.00e+00]
..LN530:
#       rand(void)
        call      rand                                          #191.43
..LN531:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.97:                        # Preds ..B1.96
                                # Execution count [1.00e+00]
..LN532:
        vmovd     %eax, %xmm0                                   #191.8
..LN533:
        vmovd     %r13d, %xmm1                                  #191.8
..LN534:
        vmovd     %r14d, %xmm2                                  #191.8
..LN535:
        vmovd     %r15d, %xmm3                                  #191.8
..LN536:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #191.8
..LN537:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #191.8
..LN538:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #191.8
..LN539:
        vmovups   %xmm6, 384(%rsp)                              #191.8[spill]
..LN540:
	.loc    1  192  is_stmt 1
#       rand(void)
        call      rand                                          #192.22
..LN541:
                                # LOE rbx r12 eax
..B1.269:                       # Preds ..B1.97
                                # Execution count [1.00e+00]
..LN542:
        movl      %eax, %r15d                                   #192.22
..LN543:
                                # LOE rbx r12 r15d
..B1.98:                        # Preds ..B1.269
                                # Execution count [1.00e+00]
..LN544:
#       rand(void)
        call      rand                                          #192.29
..LN545:
                                # LOE rbx r12 eax r15d
..B1.270:                       # Preds ..B1.98
                                # Execution count [1.00e+00]
..LN546:
        movl      %eax, %r14d                                   #192.29
..LN547:
                                # LOE rbx r12 r14d r15d
..B1.99:                        # Preds ..B1.270
                                # Execution count [1.00e+00]
..LN548:
#       rand(void)
        call      rand                                          #192.36
..LN549:
                                # LOE rbx r12 eax r14d r15d
..B1.271:                       # Preds ..B1.99
                                # Execution count [1.00e+00]
..LN550:
        movl      %eax, %r13d                                   #192.36
..LN551:
                                # LOE rbx r12 r13d r14d r15d
..B1.100:                       # Preds ..B1.271
                                # Execution count [1.00e+00]
..LN552:
#       rand(void)
        call      rand                                          #192.43
..LN553:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.101:                       # Preds ..B1.100
                                # Execution count [1.00e+00]
..LN554:
        vmovd     %eax, %xmm0                                   #192.8
..LN555:
        vmovd     %r13d, %xmm1                                  #192.8
..LN556:
        vmovd     %r14d, %xmm2                                  #192.8
..LN557:
        vmovd     %r15d, %xmm3                                  #192.8
..LN558:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #192.8
..LN559:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #192.8
..LN560:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #192.8
..LN561:
        vmovups   %xmm6, 400(%rsp)                              #192.8[spill]
..LN562:
	.loc    1  193  is_stmt 1
#       rand(void)
        call      rand                                          #193.22
..LN563:
                                # LOE rbx r12 eax
..B1.273:                       # Preds ..B1.101
                                # Execution count [1.00e+00]
..LN564:
        movl      %eax, %r15d                                   #193.22
..LN565:
                                # LOE rbx r12 r15d
..B1.102:                       # Preds ..B1.273
                                # Execution count [1.00e+00]
..LN566:
#       rand(void)
        call      rand                                          #193.29
..LN567:
                                # LOE rbx r12 eax r15d
..B1.274:                       # Preds ..B1.102
                                # Execution count [1.00e+00]
..LN568:
        movl      %eax, %r14d                                   #193.29
..LN569:
                                # LOE rbx r12 r14d r15d
..B1.103:                       # Preds ..B1.274
                                # Execution count [1.00e+00]
..LN570:
#       rand(void)
        call      rand                                          #193.36
..LN571:
                                # LOE rbx r12 eax r14d r15d
..B1.275:                       # Preds ..B1.103
                                # Execution count [1.00e+00]
..LN572:
        movl      %eax, %r13d                                   #193.36
..LN573:
                                # LOE rbx r12 r13d r14d r15d
..B1.104:                       # Preds ..B1.275
                                # Execution count [1.00e+00]
..LN574:
#       rand(void)
        call      rand                                          #193.43
..LN575:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.105:                       # Preds ..B1.104
                                # Execution count [1.00e+00]
..LN576:
        vmovd     %eax, %xmm0                                   #193.8
..LN577:
        vmovd     %r13d, %xmm1                                  #193.8
..LN578:
        vmovd     %r14d, %xmm2                                  #193.8
..LN579:
        vmovd     %r15d, %xmm3                                  #193.8
..LN580:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #193.8
..LN581:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #193.8
..LN582:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #193.8
..LN583:
        vmovups   %xmm6, 416(%rsp)                              #193.8[spill]
..LN584:
	.loc    1  194  is_stmt 1
#       rand(void)
        call      rand                                          #194.23
..LN585:
                                # LOE rbx r12 eax
..B1.277:                       # Preds ..B1.105
                                # Execution count [1.00e+00]
..LN586:
        movl      %eax, %r15d                                   #194.23
..LN587:
                                # LOE rbx r12 r15d
..B1.106:                       # Preds ..B1.277
                                # Execution count [1.00e+00]
..LN588:
#       rand(void)
        call      rand                                          #194.30
..LN589:
                                # LOE rbx r12 eax r15d
..B1.278:                       # Preds ..B1.106
                                # Execution count [1.00e+00]
..LN590:
        movl      %eax, %r14d                                   #194.30
..LN591:
                                # LOE rbx r12 r14d r15d
..B1.107:                       # Preds ..B1.278
                                # Execution count [1.00e+00]
..LN592:
#       rand(void)
        call      rand                                          #194.37
..LN593:
                                # LOE rbx r12 eax r14d r15d
..B1.279:                       # Preds ..B1.107
                                # Execution count [1.00e+00]
..LN594:
        movl      %eax, %r13d                                   #194.37
..LN595:
                                # LOE rbx r12 r13d r14d r15d
..B1.108:                       # Preds ..B1.279
                                # Execution count [1.00e+00]
..LN596:
#       rand(void)
        call      rand                                          #194.44
..LN597:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.109:                       # Preds ..B1.108
                                # Execution count [1.00e+00]
..LN598:
        vmovd     %eax, %xmm0                                   #194.9
..LN599:
        vmovd     %r13d, %xmm1                                  #194.9
..LN600:
        vmovd     %r14d, %xmm2                                  #194.9
..LN601:
        vmovd     %r15d, %xmm3                                  #194.9
..LN602:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #194.9
..LN603:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #194.9
..LN604:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #194.9
..LN605:
        vmovups   %xmm6, 432(%rsp)                              #194.9[spill]
..LN606:
	.loc    1  195  is_stmt 1
#       rand(void)
        call      rand                                          #195.23
..LN607:
                                # LOE rbx r12 eax
..B1.281:                       # Preds ..B1.109
                                # Execution count [1.00e+00]
..LN608:
        movl      %eax, %r15d                                   #195.23
..LN609:
                                # LOE rbx r12 r15d
..B1.110:                       # Preds ..B1.281
                                # Execution count [1.00e+00]
..LN610:
#       rand(void)
        call      rand                                          #195.30
..LN611:
                                # LOE rbx r12 eax r15d
..B1.282:                       # Preds ..B1.110
                                # Execution count [1.00e+00]
..LN612:
        movl      %eax, %r14d                                   #195.30
..LN613:
                                # LOE rbx r12 r14d r15d
..B1.111:                       # Preds ..B1.282
                                # Execution count [1.00e+00]
..LN614:
#       rand(void)
        call      rand                                          #195.37
..LN615:
                                # LOE rbx r12 eax r14d r15d
..B1.283:                       # Preds ..B1.111
                                # Execution count [1.00e+00]
..LN616:
        movl      %eax, %r13d                                   #195.37
..LN617:
                                # LOE rbx r12 r13d r14d r15d
..B1.112:                       # Preds ..B1.283
                                # Execution count [1.00e+00]
..LN618:
#       rand(void)
        call      rand                                          #195.44
..LN619:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.113:                       # Preds ..B1.112
                                # Execution count [1.00e+00]
..LN620:
        vmovd     %eax, %xmm0                                   #195.9
..LN621:
        vmovd     %r13d, %xmm1                                  #195.9
..LN622:
        vmovd     %r14d, %xmm2                                  #195.9
..LN623:
        vmovd     %r15d, %xmm3                                  #195.9
..LN624:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #195.9
..LN625:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #195.9
..LN626:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #195.9
..LN627:
        vmovups   %xmm6, 448(%rsp)                              #195.9[spill]
..LN628:
	.loc    1  196  is_stmt 1
#       rand(void)
        call      rand                                          #196.23
..LN629:
                                # LOE rbx r12 eax
..B1.285:                       # Preds ..B1.113
                                # Execution count [1.00e+00]
..LN630:
        movl      %eax, %r15d                                   #196.23
..LN631:
                                # LOE rbx r12 r15d
..B1.114:                       # Preds ..B1.285
                                # Execution count [1.00e+00]
..LN632:
#       rand(void)
        call      rand                                          #196.30
..LN633:
                                # LOE rbx r12 eax r15d
..B1.286:                       # Preds ..B1.114
                                # Execution count [1.00e+00]
..LN634:
        movl      %eax, %r14d                                   #196.30
..LN635:
                                # LOE rbx r12 r14d r15d
..B1.115:                       # Preds ..B1.286
                                # Execution count [1.00e+00]
..LN636:
#       rand(void)
        call      rand                                          #196.37
..LN637:
                                # LOE rbx r12 eax r14d r15d
..B1.287:                       # Preds ..B1.115
                                # Execution count [1.00e+00]
..LN638:
        movl      %eax, %r13d                                   #196.37
..LN639:
                                # LOE rbx r12 r13d r14d r15d
..B1.116:                       # Preds ..B1.287
                                # Execution count [1.00e+00]
..LN640:
#       rand(void)
        call      rand                                          #196.44
..LN641:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.117:                       # Preds ..B1.116
                                # Execution count [1.00e+00]
..LN642:
        vmovd     %eax, %xmm0                                   #196.9
..LN643:
        vmovd     %r13d, %xmm1                                  #196.9
..LN644:
        vmovd     %r14d, %xmm2                                  #196.9
..LN645:
        vmovd     %r15d, %xmm3                                  #196.9
..LN646:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #196.9
..LN647:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #196.9
..LN648:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #196.9
..LN649:
        vmovups   %xmm6, 464(%rsp)                              #196.9[spill]
..LN650:
	.loc    1  197  is_stmt 1
#       rand(void)
        call      rand                                          #197.23
..LN651:
                                # LOE rbx r12 eax
..B1.289:                       # Preds ..B1.117
                                # Execution count [1.00e+00]
..LN652:
        movl      %eax, %r15d                                   #197.23
..LN653:
                                # LOE rbx r12 r15d
..B1.118:                       # Preds ..B1.289
                                # Execution count [1.00e+00]
..LN654:
#       rand(void)
        call      rand                                          #197.30
..LN655:
                                # LOE rbx r12 eax r15d
..B1.290:                       # Preds ..B1.118
                                # Execution count [1.00e+00]
..LN656:
        movl      %eax, %r14d                                   #197.30
..LN657:
                                # LOE rbx r12 r14d r15d
..B1.119:                       # Preds ..B1.290
                                # Execution count [1.00e+00]
..LN658:
#       rand(void)
        call      rand                                          #197.37
..LN659:
                                # LOE rbx r12 eax r14d r15d
..B1.291:                       # Preds ..B1.119
                                # Execution count [1.00e+00]
..LN660:
        movl      %eax, %r13d                                   #197.37
..LN661:
                                # LOE rbx r12 r13d r14d r15d
..B1.120:                       # Preds ..B1.291
                                # Execution count [1.00e+00]
..LN662:
#       rand(void)
        call      rand                                          #197.44
..LN663:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.121:                       # Preds ..B1.120
                                # Execution count [1.00e+00]
..LN664:
        vmovd     %eax, %xmm0                                   #197.9
..LN665:
        vmovd     %r13d, %xmm1                                  #197.9
..LN666:
        vmovd     %r14d, %xmm2                                  #197.9
..LN667:
        vmovd     %r15d, %xmm3                                  #197.9
..LN668:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #197.9
..LN669:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #197.9
..LN670:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #197.9
..LN671:
        vmovups   %xmm6, 480(%rsp)                              #197.9[spill]
..LN672:
	.loc    1  198  is_stmt 1
#       rand(void)
        call      rand                                          #198.23
..LN673:
                                # LOE rbx r12 eax
..B1.293:                       # Preds ..B1.121
                                # Execution count [1.00e+00]
..LN674:
        movl      %eax, %r15d                                   #198.23
..LN675:
                                # LOE rbx r12 r15d
..B1.122:                       # Preds ..B1.293
                                # Execution count [1.00e+00]
..LN676:
#       rand(void)
        call      rand                                          #198.30
..LN677:
                                # LOE rbx r12 eax r15d
..B1.294:                       # Preds ..B1.122
                                # Execution count [1.00e+00]
..LN678:
        movl      %eax, %r14d                                   #198.30
..LN679:
                                # LOE rbx r12 r14d r15d
..B1.123:                       # Preds ..B1.294
                                # Execution count [1.00e+00]
..LN680:
#       rand(void)
        call      rand                                          #198.37
..LN681:
                                # LOE rbx r12 eax r14d r15d
..B1.295:                       # Preds ..B1.123
                                # Execution count [1.00e+00]
..LN682:
        movl      %eax, %r13d                                   #198.37
..LN683:
                                # LOE rbx r12 r13d r14d r15d
..B1.124:                       # Preds ..B1.295
                                # Execution count [1.00e+00]
..LN684:
#       rand(void)
        call      rand                                          #198.44
..LN685:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.125:                       # Preds ..B1.124
                                # Execution count [1.00e+00]
..LN686:
        vmovd     %eax, %xmm0                                   #198.9
..LN687:
        vmovd     %r13d, %xmm1                                  #198.9
..LN688:
        vmovd     %r14d, %xmm2                                  #198.9
..LN689:
        vmovd     %r15d, %xmm3                                  #198.9
..LN690:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #198.9
..LN691:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #198.9
..LN692:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #198.9
..LN693:
        vmovups   %xmm6, 496(%rsp)                              #198.9[spill]
..LN694:
	.loc    1  199  is_stmt 1
#       rand(void)
        call      rand                                          #199.23
..LN695:
                                # LOE rbx r12 eax
..B1.297:                       # Preds ..B1.125
                                # Execution count [1.00e+00]
..LN696:
        movl      %eax, %r15d                                   #199.23
..LN697:
                                # LOE rbx r12 r15d
..B1.126:                       # Preds ..B1.297
                                # Execution count [1.00e+00]
..LN698:
#       rand(void)
        call      rand                                          #199.30
..LN699:
                                # LOE rbx r12 eax r15d
..B1.298:                       # Preds ..B1.126
                                # Execution count [1.00e+00]
..LN700:
        movl      %eax, %r14d                                   #199.30
..LN701:
                                # LOE rbx r12 r14d r15d
..B1.127:                       # Preds ..B1.298
                                # Execution count [1.00e+00]
..LN702:
#       rand(void)
        call      rand                                          #199.37
..LN703:
                                # LOE rbx r12 eax r14d r15d
..B1.299:                       # Preds ..B1.127
                                # Execution count [1.00e+00]
..LN704:
        movl      %eax, %r13d                                   #199.37
..LN705:
                                # LOE rbx r12 r13d r14d r15d
..B1.128:                       # Preds ..B1.299
                                # Execution count [1.00e+00]
..LN706:
#       rand(void)
        call      rand                                          #199.44
..LN707:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.129:                       # Preds ..B1.128
                                # Execution count [1.00e+00]
..LN708:
        vmovd     %eax, %xmm0                                   #199.9
..LN709:
        vmovd     %r13d, %xmm1                                  #199.9
..LN710:
        vmovd     %r14d, %xmm2                                  #199.9
..LN711:
        vmovd     %r15d, %xmm3                                  #199.9
..LN712:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #199.9
..LN713:
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #199.9
..LN714:
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #199.9
..LN715:
        vmovups   %xmm6, 512(%rsp)                              #199.9[spill]
..LN716:
	.loc    1  200  is_stmt 1
#       rand(void)
        call      rand                                          #200.23
..LN717:
                                # LOE rbx r12 eax
..B1.301:                       # Preds ..B1.129
                                # Execution count [1.00e+00]
..LN718:
        movl      %eax, %r15d                                   #200.23
..LN719:
                                # LOE rbx r12 r15d
..B1.130:                       # Preds ..B1.301
                                # Execution count [1.00e+00]
..LN720:
#       rand(void)
        call      rand                                          #200.30
..LN721:
                                # LOE rbx r12 eax r15d
..B1.302:                       # Preds ..B1.130
                                # Execution count [1.00e+00]
..LN722:
        movl      %eax, %r14d                                   #200.30
..LN723:
                                # LOE rbx r12 r14d r15d
..B1.131:                       # Preds ..B1.302
                                # Execution count [1.00e+00]
..LN724:
#       rand(void)
        call      rand                                          #200.37
..LN725:
                                # LOE rbx r12 eax r14d r15d
..B1.303:                       # Preds ..B1.131
                                # Execution count [1.00e+00]
..LN726:
        movl      %eax, %r13d                                   #200.37
..LN727:
                                # LOE rbx r12 r13d r14d r15d
..B1.132:                       # Preds ..B1.303
                                # Execution count [1.00e+00]
..LN728:
#       rand(void)
        call      rand                                          #200.44
..LN729:
                                # LOE rbx r12 eax r13d r14d r15d
..B1.304:                       # Preds ..B1.132
                                # Execution count [1.00e+00]
..LN730:
        movl      %eax, %esi                                    #200.44
..LN731:
                                # LOE rbx r12 esi r13d r14d r15d
..B1.133:                       # Preds ..B1.304
                                # Execution count [9.00e-01]
..LN732:
        vmovd     %esi, %xmm0                                   #200.9
..LN733:
        vmovd     %r13d, %xmm1                                  #200.9
..LN734:
        vmovd     %r14d, %xmm2                                  #200.9
..LN735:
        vmovd     %r15d, %xmm3                                  #200.9
..LN736:
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #200.9
..LN737:
	.loc    1  202  is_stmt 1
        xorl      %edx, %edx                                    #202.14
..LN738:
	.loc    1  200  is_stmt 1
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #200.9
..LN739:
	.loc    1  202  is_stmt 1
        xorl      %eax, %eax                                    #202.14
..LN740:
	.loc    1  200  is_stmt 1
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #200.9
..LN741:
        movq      %rax, %r13                                    #200.9
..LN742:
        vmovups   %xmm6, 528(%rsp)                              #200.9[spill]
..LN743:
        movl      %edx, %r14d                                   #200.9
..LN744:
                                # LOE rbx r12 r13 r14d
..B1.134:                       # Preds ..B1.135 ..B1.133
                                # Execution count [5.00e+00]
..L15:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN745:
	.loc    1  202  is_stmt 1
..LN746:
	.loc    1  204  is_stmt 1
        vmovups   32(%rsp), %xmm0                               #204.17[spill]
..LN747:
        lea       (%rsp), %rdi                                  #204.17
..LN748:
        vmovups   48(%rdi), %xmm1                               #204.17[spill]
..___tag_value_main.16:
..LN749:
#       add_bis(__m128i, __m128i, __m128i *__restrict__)
        call      add_bis                                       #204.17
..___tag_value_main.17:
..LN750:
                                # LOE rbx r12 r13 r14d xmm0
..B1.135:                       # Preds ..B1.134
                                # Execution count [5.00e+00]
..LN751:
	.loc    1  202  is_stmt 1
        incl      %r14d                                         #202.32
..LN752:
	.loc    1  204  is_stmt 1
        vmovdqu   %xmm0, (%r13,%r12)                            #204.5
..LN753:
	.loc    1  202  is_stmt 1
        addq      $16, %r13                                     #202.32
..LN754:
        cmpl      $16000000, %r14d                              #202.28
..LN755:
        jl        ..B1.134      # Prob 82%                      #202.28
..LN756:
                                # LOE rbx r12 r13 r14d
..B1.136:                       # Preds ..B1.135
                                # Execution count [1.00e+00]
..LN757:
	.loc    1  206  is_stmt 1
        movq      %r12, %rdi                                    #206.3
..LN758:
        movl      $16, %esi                                     #206.3
..LN759:
        movl      $16000000, %edx                               #206.3
..LN760:
        movq      %rbx, %rcx                                    #206.3
..LN761:
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #206.3
..LN762:
                                # LOE rbx r12
..B1.137:                       # Preds ..B1.136
                                # Execution count [1.00e+00]
..LN763:
	.loc    1  208  is_stmt 1
        movl      $.L_2__STRING.2, %edi                         #208.3
..LN764:
        xorl      %eax, %eax                                    #208.3
..___tag_value_main.18:
..LN765:
#       printf(const char *__restrict__, ...)
        call      printf                                        #208.3
..___tag_value_main.19:
..LN766:
                                # LOE rbx r12
..B1.138:                       # Preds ..B1.137
                                # Execution count [1.00e+00]
..LN767:
        movq      stdout(%rip), %rdi                            #208.27
..LN768:
#       fflush(FILE *)
        call      fflush                                        #208.27
..LN769:
                                # LOE rbx r12
..B1.139:                       # Preds ..B1.138
                                # Execution count [1.00e+00]
..LN770:
	.loc    1  209  is_stmt 1
        xorl      %r13d, %r13d                                  #209.3
..LN771:
	.loc    1  210  is_stmt 1
        xorb      %r15b, %r15b                                  #210.14
..LN772:
                                # LOE rbx r12 r13 r15b
..B1.140:                       # Preds ..B1.146 ..B1.139
                                # Execution count [5.00e+01]
..L20:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN773:
..LN774:
	.loc    1  211  is_stmt 1
        rdtscp                                                   #211.13
..LN775:
        shlq      $32, %rdx                                     #211.13
..LN776:
        orq       %rdx, %rax                                    #211.13
..LN777:
                                # LOE rax rbx r12 r13 r15b
..B1.306:                       # Preds ..B1.140
                                # Execution count [5.00e+01]
..LN778:
        movq      %rax, %r14                                    #211.13
..LN779:
                                # LOE rbx r12 r13 r14 r15b
..B1.141:                       # Preds ..B1.306
                                # Execution count [4.50e+01]
..LN780:
	.loc    1  212  is_stmt 1
        xorl      %eax, %eax                                    #212.16
..LN781:
        movq      %r12, %rdi                                    #212.16
..LN782:
        movq      %r13, 24(%rsp)                                #212.16[spill]
..LN783:
        movl      %eax, %r13d                                   #212.16
..LN784:
        movq      %rbx, 16(%rsp)                                #212.16[spill]
..LN785:
        movq      %rdi, %rbx                                    #212.16
..LN786:
                                # LOE rbx r12 r14 r13d r15b
..B1.142:                       # Preds ..B1.143 ..B1.141
                                # Execution count [2.50e+02]
..L21:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN787:
..LN788:
	.loc    1  213  is_stmt 1
        addq      $-384, %rsp                                   #213.7
..LN789:
        movq      %rbx, %rdi                                    #213.7
..LN790:
        vmovups   544(%rsp), %xmm0                              #213.7[spill]
..LN791:
        vmovups   %xmm0, (%rsp)                                 #213.7
..LN792:
        vmovups   560(%rsp), %xmm1                              #213.7[spill]
..LN793:
        vmovups   %xmm1, 16(%rsp)                               #213.7
..LN794:
        vmovups   576(%rsp), %xmm2                              #213.7[spill]
..LN795:
        vmovups   %xmm2, 32(%rsp)                               #213.7
..LN796:
        vmovups   592(%rsp), %xmm3                              #213.7[spill]
..LN797:
        vmovups   %xmm3, 48(%rsp)                               #213.7
..LN798:
        vmovups   608(%rsp), %xmm4                              #213.7[spill]
..LN799:
        vmovups   %xmm4, 64(%rsp)                               #213.7
..LN800:
        vmovups   624(%rsp), %xmm5                              #213.7[spill]
..LN801:
        vmovups   %xmm5, 80(%rsp)                               #213.7
..LN802:
        vmovups   640(%rsp), %xmm6                              #213.7[spill]
..LN803:
        vmovups   %xmm6, 96(%rsp)                               #213.7
..LN804:
        vmovups   656(%rsp), %xmm7                              #213.7[spill]
..LN805:
        vmovups   %xmm7, 112(%rsp)                              #213.7
..LN806:
        vmovups   672(%rsp), %xmm8                              #213.7[spill]
..LN807:
        vmovups   %xmm8, 128(%rsp)                              #213.7
..LN808:
        vmovups   688(%rsp), %xmm9                              #213.7[spill]
..LN809:
        vmovups   %xmm9, 144(%rsp)                              #213.7
..LN810:
        vmovups   704(%rsp), %xmm10                             #213.7[spill]
..LN811:
        vmovups   %xmm10, 160(%rsp)                             #213.7
..LN812:
        vmovups   720(%rsp), %xmm11                             #213.7[spill]
..LN813:
        vmovups   %xmm11, 176(%rsp)                             #213.7
..LN814:
        vmovups   736(%rsp), %xmm12                             #213.7[spill]
..LN815:
        vmovups   %xmm12, 192(%rsp)                             #213.7
..LN816:
        vmovups   752(%rsp), %xmm13                             #213.7[spill]
..LN817:
        vmovups   %xmm13, 208(%rsp)                             #213.7
..LN818:
        vmovups   768(%rsp), %xmm14                             #213.7[spill]
..LN819:
        vmovups   %xmm14, 224(%rsp)                             #213.7
..LN820:
        vmovups   784(%rsp), %xmm15                             #213.7[spill]
..LN821:
        vmovups   %xmm15, 240(%rsp)                             #213.7
..LN822:
        vmovups   800(%rsp), %xmm0                              #213.7[spill]
..LN823:
        vmovups   %xmm0, 256(%rsp)                              #213.7
..LN824:
        vmovups   816(%rsp), %xmm1                              #213.7[spill]
..LN825:
        vmovups   %xmm1, 272(%rsp)                              #213.7
..LN826:
        vmovups   832(%rsp), %xmm2                              #213.7[spill]
..LN827:
        vmovups   %xmm2, 288(%rsp)                              #213.7
..LN828:
        vmovups   848(%rsp), %xmm3                              #213.7[spill]
..LN829:
        vmovups   %xmm3, 304(%rsp)                              #213.7
..LN830:
        vmovups   864(%rsp), %xmm4                              #213.7[spill]
..LN831:
        vmovups   %xmm4, 320(%rsp)                              #213.7
..LN832:
        vmovups   880(%rsp), %xmm5                              #213.7[spill]
..LN833:
        vmovups   %xmm5, 336(%rsp)                              #213.7
..LN834:
        vmovups   896(%rsp), %xmm6                              #213.7[spill]
..LN835:
        vmovups   %xmm6, 352(%rsp)                              #213.7
..LN836:
        vmovups   912(%rsp), %xmm7                              #213.7[spill]
..LN837:
        vmovups   %xmm7, 368(%rsp)                              #213.7
..LN838:
        vmovups   416(%rsp), %xmm0                              #213.7[spill]
..LN839:
        vmovups   432(%rsp), %xmm1                              #213.7[spill]
..LN840:
        vmovups   448(%rsp), %xmm2                              #213.7[spill]
..LN841:
        vmovups   464(%rsp), %xmm3                              #213.7[spill]
..LN842:
        vmovups   480(%rsp), %xmm4                              #213.7[spill]
..LN843:
        vmovups   496(%rsp), %xmm5                              #213.7[spill]
..LN844:
        vmovups   512(%rsp), %xmm6                              #213.7[spill]
..LN845:
        vmovups   528(%rsp), %xmm7                              #213.7[spill]
..___tag_value_main.22:
..LN846:
#       add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
        call      add_pack                                      #213.7
..___tag_value_main.23:
..LN847:
                                # LOE rbx r12 r14 r13d r15b
..B1.307:                       # Preds ..B1.142
                                # Execution count [2.50e+02]
..LN848:
        addq      $384, %rsp                                    #213.7
..LN849:
                                # LOE rbx r12 r14 r13d r15b
..B1.143:                       # Preds ..B1.307
                                # Execution count [2.50e+02]
..LN850:
	.loc    1  212  is_stmt 1
        incl      %r13d                                         #212.31
..LN851:
        addq      $256, %rbx                                    #212.31
..LN852:
        cmpl      $1000000, %r13d                               #212.25
..LN853:
        jl        ..B1.142      # Prob 82%                      #212.25
..LN854:
                                # LOE rbx r12 r14 r13d r15b
..B1.144:                       # Preds ..B1.143
                                # Execution count [5.00e+01]
..LN855:
        movq      24(%rsp), %r13                                #[spill]
..LN856:
        movq      16(%rsp), %rbx                                #[spill]
..LN857:
	.loc    1  216  is_stmt 1
        rdtscp                                                   #216.12
..LN858:
        shlq      $32, %rdx                                     #216.12
..LN859:
        orq       %rdx, %rax                                    #216.12
..LN860:
                                # LOE rax rbx r12 r13 r14 r15b
..B1.145:                       # Preds ..B1.144
                                # Execution count [5.00e+01]
..LN861:
        subq      %r14, %rax                                    #216.12
..LN862:
	.loc    1  217  is_stmt 1
        movq      %r12, %rdi                                    #217.5
..LN863:
        movl      $16, %esi                                     #217.5
..LN864:
        movl      $16000000, %edx                               #217.5
..LN865:
        movq      %rbx, %rcx                                    #217.5
..LN866:
	.loc    1  216  is_stmt 1
        addq      %rax, %r13                                    #216.5
..LN867:
	.loc    1  217  is_stmt 1
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #217.5
..LN868:
                                # LOE rbx r12 r13 r15b
..B1.146:                       # Preds ..B1.145
                                # Execution count [5.00e+01]
..LN869:
	.loc    1  210  is_stmt 1
        incb      %r15b                                         #210.27
..LN870:
        cmpb      $50, %r15b                                    #210.23
..LN871:
        jl        ..B1.140      # Prob 98%                      #210.23
..LN872:
                                # LOE rbx r12 r13 r15b
..B1.147:                       # Preds ..B1.146
                                # Execution count [1.00e+00]
..LN873:
	.loc    1  219  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #219.3
..LN874:
        movq      %r13, %rsi                                    #219.3
..LN875:
        xorl      %eax, %eax                                    #219.3
..___tag_value_main.24:
..LN876:
#       printf(const char *__restrict__, ...)
        call      printf                                        #219.3
..___tag_value_main.25:
..LN877:
                                # LOE rbx r12
..B1.148:                       # Preds ..B1.147
                                # Execution count [1.00e+00]
..LN878:
	.loc    1  221  is_stmt 1
        movl      $.L_2__STRING.4, %edi                         #221.3
..LN879:
        xorl      %eax, %eax                                    #221.3
..___tag_value_main.26:
..LN880:
#       printf(const char *__restrict__, ...)
        call      printf                                        #221.3
..___tag_value_main.27:
..LN881:
                                # LOE rbx r12
..B1.149:                       # Preds ..B1.148
                                # Execution count [1.00e+00]
..LN882:
        movq      stdout(%rip), %rdi                            #221.27
..LN883:
#       fflush(FILE *)
        call      fflush                                        #221.27
..LN884:
                                # LOE rbx r12
..B1.150:                       # Preds ..B1.149
                                # Execution count [1.00e+00]
..LN885:
	.loc    1  222  is_stmt 1
        xorl      %r14d, %r14d                                  #222.3
..LN886:
	.loc    1  223  is_stmt 1
        xorb      %r13b, %r13b                                  #223.14
..LN887:
                                # LOE rbx r12 r14 r13b
..B1.151:                       # Preds ..B1.157 ..B1.150
                                # Execution count [5.00e+01]
..L28:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN888:
..LN889:
	.loc    1  224  is_stmt 1
        rdtscp                                                   #224.13
..LN890:
        shlq      $32, %rdx                                     #224.13
..LN891:
        orq       %rdx, %rax                                    #224.13
..LN892:
                                # LOE rax rbx r12 r14 r13b
..B1.309:                       # Preds ..B1.151
                                # Execution count [5.00e+01]
..LN893:
        movq      %rax, %r15                                    #224.13
..LN894:
                                # LOE rbx r12 r14 r15 r13b
..B1.152:                       # Preds ..B1.309
                                # Execution count [4.50e+01]
..LN895:
	.loc    1  225  is_stmt 1
        xorl      %eax, %eax                                    #225.16
..LN896:
        movq      %r12, %rdi                                    #225.16
..LN897:
        movq      %r12, 24(%rsp)                                #225.16[spill]
..LN898:
        movl      %eax, %r12d                                   #225.16
..LN899:
        movq      %rbx, 16(%rsp)                                #225.16[spill]
..LN900:
        movq      %rdi, %rbx                                    #225.16
..LN901:
                                # LOE rbx r14 r15 r12d r13b
..B1.153:                       # Preds ..B1.154 ..B1.152
                                # Execution count [2.50e+02]
..L29:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN902:
..LN903:
	.loc    1  226  is_stmt 1
        addq      $-384, %rsp                                   #226.7
..LN904:
        movq      %rbx, %rdi                                    #226.7
..LN905:
        vmovups   544(%rsp), %xmm0                              #226.7[spill]
..LN906:
        vmovups   %xmm0, (%rsp)                                 #226.7
..LN907:
        vmovups   560(%rsp), %xmm1                              #226.7[spill]
..LN908:
        vmovups   %xmm1, 16(%rsp)                               #226.7
..LN909:
        vmovups   576(%rsp), %xmm2                              #226.7[spill]
..LN910:
        vmovups   %xmm2, 32(%rsp)                               #226.7
..LN911:
        vmovups   592(%rsp), %xmm3                              #226.7[spill]
..LN912:
        vmovups   %xmm3, 48(%rsp)                               #226.7
..LN913:
        vmovups   608(%rsp), %xmm4                              #226.7[spill]
..LN914:
        vmovups   %xmm4, 64(%rsp)                               #226.7
..LN915:
        vmovups   624(%rsp), %xmm5                              #226.7[spill]
..LN916:
        vmovups   %xmm5, 80(%rsp)                               #226.7
..LN917:
        vmovups   640(%rsp), %xmm6                              #226.7[spill]
..LN918:
        vmovups   %xmm6, 96(%rsp)                               #226.7
..LN919:
        vmovups   656(%rsp), %xmm7                              #226.7[spill]
..LN920:
        vmovups   %xmm7, 112(%rsp)                              #226.7
..LN921:
        vmovups   672(%rsp), %xmm8                              #226.7[spill]
..LN922:
        vmovups   %xmm8, 128(%rsp)                              #226.7
..LN923:
        vmovups   688(%rsp), %xmm9                              #226.7[spill]
..LN924:
        vmovups   %xmm9, 144(%rsp)                              #226.7
..LN925:
        vmovups   704(%rsp), %xmm10                             #226.7[spill]
..LN926:
        vmovups   %xmm10, 160(%rsp)                             #226.7
..LN927:
        vmovups   720(%rsp), %xmm11                             #226.7[spill]
..LN928:
        vmovups   %xmm11, 176(%rsp)                             #226.7
..LN929:
        vmovups   736(%rsp), %xmm12                             #226.7[spill]
..LN930:
        vmovups   %xmm12, 192(%rsp)                             #226.7
..LN931:
        vmovups   752(%rsp), %xmm13                             #226.7[spill]
..LN932:
        vmovups   %xmm13, 208(%rsp)                             #226.7
..LN933:
        vmovups   768(%rsp), %xmm14                             #226.7[spill]
..LN934:
        vmovups   %xmm14, 224(%rsp)                             #226.7
..LN935:
        vmovups   784(%rsp), %xmm15                             #226.7[spill]
..LN936:
        vmovups   %xmm15, 240(%rsp)                             #226.7
..LN937:
        vmovups   800(%rsp), %xmm0                              #226.7[spill]
..LN938:
        vmovups   %xmm0, 256(%rsp)                              #226.7
..LN939:
        vmovups   816(%rsp), %xmm1                              #226.7[spill]
..LN940:
        vmovups   %xmm1, 272(%rsp)                              #226.7
..LN941:
        vmovups   832(%rsp), %xmm2                              #226.7[spill]
..LN942:
        vmovups   %xmm2, 288(%rsp)                              #226.7
..LN943:
        vmovups   848(%rsp), %xmm3                              #226.7[spill]
..LN944:
        vmovups   %xmm3, 304(%rsp)                              #226.7
..LN945:
        vmovups   864(%rsp), %xmm4                              #226.7[spill]
..LN946:
        vmovups   %xmm4, 320(%rsp)                              #226.7
..LN947:
        vmovups   880(%rsp), %xmm5                              #226.7[spill]
..LN948:
        vmovups   %xmm5, 336(%rsp)                              #226.7
..LN949:
        vmovups   896(%rsp), %xmm6                              #226.7[spill]
..LN950:
        vmovups   %xmm6, 352(%rsp)                              #226.7
..LN951:
        vmovups   912(%rsp), %xmm7                              #226.7[spill]
..LN952:
        vmovups   %xmm7, 368(%rsp)                              #226.7
..LN953:
        vmovups   416(%rsp), %xmm0                              #226.7[spill]
..LN954:
        vmovups   432(%rsp), %xmm1                              #226.7[spill]
..LN955:
        vmovups   448(%rsp), %xmm2                              #226.7[spill]
..LN956:
        vmovups   464(%rsp), %xmm3                              #226.7[spill]
..LN957:
        vmovups   480(%rsp), %xmm4                              #226.7[spill]
..LN958:
        vmovups   496(%rsp), %xmm5                              #226.7[spill]
..LN959:
        vmovups   512(%rsp), %xmm6                              #226.7[spill]
..LN960:
        vmovups   528(%rsp), %xmm7                              #226.7[spill]
..___tag_value_main.30:
..LN961:
#       add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
        call      add_bitslice                                  #226.7
..___tag_value_main.31:
..LN962:
                                # LOE rbx r14 r15 r12d r13b
..B1.310:                       # Preds ..B1.153
                                # Execution count [2.50e+02]
..LN963:
        addq      $384, %rsp                                    #226.7
..LN964:
                                # LOE rbx r14 r15 r12d r13b
..B1.154:                       # Preds ..B1.310
                                # Execution count [2.50e+02]
..LN965:
	.loc    1  225  is_stmt 1
        incl      %r12d                                         #225.31
..LN966:
        addq      $256, %rbx                                    #225.31
..LN967:
        cmpl      $1000000, %r12d                               #225.25
..LN968:
        jl        ..B1.153      # Prob 82%                      #225.25
..LN969:
                                # LOE rbx r14 r15 r12d r13b
..B1.155:                       # Preds ..B1.154
                                # Execution count [5.00e+01]
..LN970:
        movq      24(%rsp), %r12                                #[spill]
..LN971:
        movq      16(%rsp), %rbx                                #[spill]
..LN972:
	.loc    1  229  is_stmt 1
        rdtscp                                                   #229.12
..LN973:
        shlq      $32, %rdx                                     #229.12
..LN974:
        orq       %rdx, %rax                                    #229.12
..LN975:
                                # LOE rax rbx r12 r14 r15 r13b
..B1.156:                       # Preds ..B1.155
                                # Execution count [5.00e+01]
..LN976:
        subq      %r15, %rax                                    #229.12
..LN977:
	.loc    1  230  is_stmt 1
        movq      %r12, %rdi                                    #230.5
..LN978:
        movl      $16, %esi                                     #230.5
..LN979:
        movl      $16000000, %edx                               #230.5
..LN980:
        movq      %rbx, %rcx                                    #230.5
..LN981:
	.loc    1  229  is_stmt 1
        addq      %rax, %r14                                    #229.5
..LN982:
	.loc    1  230  is_stmt 1
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #230.5
..LN983:
                                # LOE rbx r12 r14 r13b
..B1.157:                       # Preds ..B1.156
                                # Execution count [5.00e+01]
..LN984:
	.loc    1  223  is_stmt 1
        incb      %r13b                                         #223.27
..LN985:
        cmpb      $50, %r13b                                    #223.23
..LN986:
        jl        ..B1.151      # Prob 98%                      #223.23
..LN987:
                                # LOE rbx r12 r14 r13b
..B1.158:                       # Preds ..B1.157
                                # Execution count [1.00e+00]
..LN988:
	.loc    1  232  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #232.3
..LN989:
        movq      %r14, %rsi                                    #232.3
..LN990:
        xorl      %eax, %eax                                    #232.3
..___tag_value_main.32:
..LN991:
#       printf(const char *__restrict__, ...)
        call      printf                                        #232.3
..___tag_value_main.33:
..LN992:
                                # LOE rbx r12
..B1.159:                       # Preds ..B1.158
                                # Execution count [1.00e+00]
..LN993:
	.loc    1  234  is_stmt 1
        movl      $.L_2__STRING.5, %edi                         #234.3
..LN994:
        xorl      %eax, %eax                                    #234.3
..___tag_value_main.34:
..LN995:
#       printf(const char *__restrict__, ...)
        call      printf                                        #234.3
..___tag_value_main.35:
..LN996:
                                # LOE rbx r12
..B1.160:                       # Preds ..B1.159
                                # Execution count [1.00e+00]
..LN997:
        movq      stdout(%rip), %rdi                            #234.27
..LN998:
#       fflush(FILE *)
        call      fflush                                        #234.27
..LN999:
                                # LOE rbx r12
..B1.161:                       # Preds ..B1.160
                                # Execution count [1.00e+00]
..LN1000:
	.loc    1  235  is_stmt 1
        xorl      %r14d, %r14d                                  #235.3
..LN1001:
	.loc    1  236  is_stmt 1
        xorb      %r13b, %r13b                                  #236.14
..LN1002:
                                # LOE rbx r12 r14 r13b
..B1.162:                       # Preds ..B1.168 ..B1.161
                                # Execution count [5.00e+01]
..L36:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN1003:
..LN1004:
	.loc    1  237  is_stmt 1
        rdtscp                                                   #237.13
..LN1005:
        shlq      $32, %rdx                                     #237.13
..LN1006:
        orq       %rdx, %rax                                    #237.13
..LN1007:
                                # LOE rax rbx r12 r14 r13b
..B1.312:                       # Preds ..B1.162
                                # Execution count [5.00e+01]
..LN1008:
        movq      %rax, %r15                                    #237.13
..LN1009:
                                # LOE rbx r12 r14 r15 r13b
..B1.163:                       # Preds ..B1.312
                                # Execution count [4.50e+01]
..LN1010:
	.loc    1  238  is_stmt 1
        xorl      %eax, %eax                                    #238.16
..LN1011:
        movq      %r12, %rdi                                    #238.16
..LN1012:
        movq      %r12, 24(%rsp)                                #238.16[spill]
..LN1013:
        movl      %eax, %r12d                                   #238.16
..LN1014:
        movq      %rbx, 16(%rsp)                                #238.16[spill]
..LN1015:
        movq      %rdi, %rbx                                    #238.16
..LN1016:
                                # LOE rbx r14 r15 r12d r13b
..B1.164:                       # Preds ..B1.165 ..B1.163
                                # Execution count [2.50e+02]
..L37:
                # optimization report
                # %s was not vectorized: vector dependence prevents vectorization%s
                # VECTOR TRIP COUNT IS KNOWN CONSTANT
..LN1017:
..LN1018:
	.loc    1  239  is_stmt 1
        addq      $-384, %rsp                                   #239.7
..LN1019:
        movq      %rbx, %rdi                                    #239.7
..LN1020:
        vmovups   544(%rsp), %xmm0                              #239.7[spill]
..LN1021:
        vmovups   %xmm0, (%rsp)                                 #239.7
..LN1022:
        vmovups   560(%rsp), %xmm1                              #239.7[spill]
..LN1023:
        vmovups   %xmm1, 16(%rsp)                               #239.7
..LN1024:
        vmovups   576(%rsp), %xmm2                              #239.7[spill]
..LN1025:
        vmovups   %xmm2, 32(%rsp)                               #239.7
..LN1026:
        vmovups   592(%rsp), %xmm3                              #239.7[spill]
..LN1027:
        vmovups   %xmm3, 48(%rsp)                               #239.7
..LN1028:
        vmovups   608(%rsp), %xmm4                              #239.7[spill]
..LN1029:
        vmovups   %xmm4, 64(%rsp)                               #239.7
..LN1030:
        vmovups   624(%rsp), %xmm5                              #239.7[spill]
..LN1031:
        vmovups   %xmm5, 80(%rsp)                               #239.7
..LN1032:
        vmovups   640(%rsp), %xmm6                              #239.7[spill]
..LN1033:
        vmovups   %xmm6, 96(%rsp)                               #239.7
..LN1034:
        vmovups   656(%rsp), %xmm7                              #239.7[spill]
..LN1035:
        vmovups   %xmm7, 112(%rsp)                              #239.7
..LN1036:
        vmovups   672(%rsp), %xmm8                              #239.7[spill]
..LN1037:
        vmovups   %xmm8, 128(%rsp)                              #239.7
..LN1038:
        vmovups   688(%rsp), %xmm9                              #239.7[spill]
..LN1039:
        vmovups   %xmm9, 144(%rsp)                              #239.7
..LN1040:
        vmovups   704(%rsp), %xmm10                             #239.7[spill]
..LN1041:
        vmovups   %xmm10, 160(%rsp)                             #239.7
..LN1042:
        vmovups   720(%rsp), %xmm11                             #239.7[spill]
..LN1043:
        vmovups   %xmm11, 176(%rsp)                             #239.7
..LN1044:
        vmovups   736(%rsp), %xmm12                             #239.7[spill]
..LN1045:
        vmovups   %xmm12, 192(%rsp)                             #239.7
..LN1046:
        vmovups   752(%rsp), %xmm13                             #239.7[spill]
..LN1047:
        vmovups   %xmm13, 208(%rsp)                             #239.7
..LN1048:
        vmovups   768(%rsp), %xmm14                             #239.7[spill]
..LN1049:
        vmovups   %xmm14, 224(%rsp)                             #239.7
..LN1050:
        vmovups   784(%rsp), %xmm15                             #239.7[spill]
..LN1051:
        vmovups   %xmm15, 240(%rsp)                             #239.7
..LN1052:
        vmovups   800(%rsp), %xmm0                              #239.7[spill]
..LN1053:
        vmovups   %xmm0, 256(%rsp)                              #239.7
..LN1054:
        vmovups   816(%rsp), %xmm1                              #239.7[spill]
..LN1055:
        vmovups   %xmm1, 272(%rsp)                              #239.7
..LN1056:
        vmovups   832(%rsp), %xmm2                              #239.7[spill]
..LN1057:
        vmovups   %xmm2, 288(%rsp)                              #239.7
..LN1058:
        vmovups   848(%rsp), %xmm3                              #239.7[spill]
..LN1059:
        vmovups   %xmm3, 304(%rsp)                              #239.7
..LN1060:
        vmovups   864(%rsp), %xmm4                              #239.7[spill]
..LN1061:
        vmovups   %xmm4, 320(%rsp)                              #239.7
..LN1062:
        vmovups   880(%rsp), %xmm5                              #239.7[spill]
..LN1063:
        vmovups   %xmm5, 336(%rsp)                              #239.7
..LN1064:
        vmovups   896(%rsp), %xmm6                              #239.7[spill]
..LN1065:
        vmovups   %xmm6, 352(%rsp)                              #239.7
..LN1066:
        vmovups   912(%rsp), %xmm7                              #239.7[spill]
..LN1067:
        vmovups   %xmm7, 368(%rsp)                              #239.7
..LN1068:
        vmovups   416(%rsp), %xmm0                              #239.7[spill]
..LN1069:
        vmovups   432(%rsp), %xmm1                              #239.7[spill]
..LN1070:
        vmovups   448(%rsp), %xmm2                              #239.7[spill]
..LN1071:
        vmovups   464(%rsp), %xmm3                              #239.7[spill]
..LN1072:
        vmovups   480(%rsp), %xmm4                              #239.7[spill]
..LN1073:
        vmovups   496(%rsp), %xmm5                              #239.7[spill]
..LN1074:
        vmovups   512(%rsp), %xmm6                              #239.7[spill]
..LN1075:
        vmovups   528(%rsp), %xmm7                              #239.7[spill]
..___tag_value_main.38:
..LN1076:
#       add_lookahead(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
        call      add_lookahead                                 #239.7
..___tag_value_main.39:
..LN1077:
                                # LOE rbx r14 r15 r12d r13b
..B1.313:                       # Preds ..B1.164
                                # Execution count [2.50e+02]
..LN1078:
        addq      $384, %rsp                                    #239.7
..LN1079:
                                # LOE rbx r14 r15 r12d r13b
..B1.165:                       # Preds ..B1.313
                                # Execution count [2.50e+02]
..LN1080:
	.loc    1  238  is_stmt 1
        incl      %r12d                                         #238.31
..LN1081:
        addq      $256, %rbx                                    #238.31
..LN1082:
        cmpl      $1000000, %r12d                               #238.25
..LN1083:
        jl        ..B1.164      # Prob 82%                      #238.25
..LN1084:
                                # LOE rbx r14 r15 r12d r13b
..B1.166:                       # Preds ..B1.165
                                # Execution count [5.00e+01]
..LN1085:
        movq      24(%rsp), %r12                                #[spill]
..LN1086:
        movq      16(%rsp), %rbx                                #[spill]
..LN1087:
	.loc    1  242  is_stmt 1
        rdtscp                                                   #242.12
..LN1088:
        shlq      $32, %rdx                                     #242.12
..LN1089:
        orq       %rdx, %rax                                    #242.12
..LN1090:
                                # LOE rax rbx r12 r14 r15 r13b
..B1.167:                       # Preds ..B1.166
                                # Execution count [5.00e+01]
..LN1091:
        subq      %r15, %rax                                    #242.12
..LN1092:
	.loc    1  243  is_stmt 1
        movq      %r12, %rdi                                    #243.5
..LN1093:
        movl      $16, %esi                                     #243.5
..LN1094:
        movl      $16000000, %edx                               #243.5
..LN1095:
        movq      %rbx, %rcx                                    #243.5
..LN1096:
	.loc    1  242  is_stmt 1
        addq      %rax, %r14                                    #242.5
..LN1097:
	.loc    1  243  is_stmt 1
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #243.5
..LN1098:
                                # LOE rbx r12 r14 r13b
..B1.168:                       # Preds ..B1.167
                                # Execution count [5.00e+01]
..LN1099:
	.loc    1  236  is_stmt 1
        incb      %r13b                                         #236.27
..LN1100:
        cmpb      $50, %r13b                                    #236.23
..LN1101:
        jl        ..B1.162      # Prob 98%                      #236.23
..LN1102:
                                # LOE rbx r12 r14 r13b
..B1.169:                       # Preds ..B1.168
                                # Execution count [1.00e+00]
..LN1103:
	.loc    1  245  is_stmt 1
        movl      $.L_2__STRING.3, %edi                         #245.3
..LN1104:
        movq      %r14, %rsi                                    #245.3
..LN1105:
        xorl      %eax, %eax                                    #245.3
..___tag_value_main.40:
..LN1106:
#       printf(const char *__restrict__, ...)
        call      printf                                        #245.3
..___tag_value_main.41:
..LN1107:
                                # LOE
..B1.170:                       # Preds ..B1.169
                                # Execution count [1.00e+00]
..LN1108:
	.loc    1  247  is_stmt 1
        xorl      %eax, %eax                                    #247.10
..LN1109:
	.loc    1  247  epilogue_begin  is_stmt 1
        addq      $600, %rsp                                    #247.10
	.cfi_restore 3
..LN1110:
        popq      %rbx                                          #247.10
	.cfi_restore 15
..LN1111:
        popq      %r15                                          #247.10
	.cfi_restore 14
..LN1112:
        popq      %r14                                          #247.10
	.cfi_restore 13
..LN1113:
        popq      %r13                                          #247.10
	.cfi_restore 12
..LN1114:
        popq      %r12                                          #247.10
..LN1115:
        movq      %rbp, %rsp                                    #247.10
..LN1116:
        popq      %rbp                                          #247.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
..LN1117:
        ret                                                     #247.10
        .align    16,0x90
..LN1118:
                                # LOE
..LN1119:
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
..LNmain.1120:
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
                                                         #45.60
..LN1121:
	.loc    1  45  prologue_end  is_stmt 1
..LN1122:
	.loc    1  46  is_stmt 1
        vpxor     %xmm1, %xmm0, %xmm5                           #46.17
..LN1123:
	.loc    1  47  is_stmt 1
        vmovdqu   (%rdi), %xmm6                                 #47.36
..LN1124:
	.loc    1  48  is_stmt 1
        vpand     %xmm1, %xmm0, %xmm2                           #48.21
..LN1125:
        vpand     %xmm5, %xmm6, %xmm3                           #48.40
..LN1126:
	.loc    1  47  is_stmt 1
        vpxor     %xmm6, %xmm5, %xmm0                           #47.17
..LN1127:
	.loc    1  48  is_stmt 1
        vpxor     %xmm3, %xmm2, %xmm4                           #48.7
..LN1128:
        vmovdqu   %xmm4, (%rdi)                                 #48.4
..LN1129:
	.loc    1  49  epilogue_begin  is_stmt 1
        ret                                                     #49.10
        .align    16,0x90
..LN1130:
                                # LOE
..LN1131:
	.cfi_endproc
# mark_end;
	.type	add_bis,@function
	.size	add_bis,.-add_bis
..LNadd_bis.1132:
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
# --- add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_pack:
# parameter 1(x1): %xmm0
# parameter 2(x2): %xmm1
# parameter 3(x3): %xmm2
# parameter 4(x4): %xmm3
# parameter 5(x5): %xmm4
# parameter 6(x6): %xmm5
# parameter 7(x7): %xmm6
# parameter 8(x8): %xmm7
# parameter 9(x9): 8 + %rsp
# parameter 10(x10): 24 + %rsp
# parameter 11(x11): 40 + %rsp
# parameter 12(x12): 56 + %rsp
# parameter 13(x13): 72 + %rsp
# parameter 14(x14): 88 + %rsp
# parameter 15(x15): 104 + %rsp
# parameter 16(x16): 120 + %rsp
# parameter 17(y1): 136 + %rsp
# parameter 18(y2): 152 + %rsp
# parameter 19(y3): 168 + %rsp
# parameter 20(y4): 184 + %rsp
# parameter 21(y5): 200 + %rsp
# parameter 22(y6): 216 + %rsp
# parameter 23(y7): 232 + %rsp
# parameter 24(y8): 248 + %rsp
# parameter 25(y9): 264 + %rsp
# parameter 26(y10): 280 + %rsp
# parameter 27(y11): 296 + %rsp
# parameter 28(y12): 312 + %rsp
# parameter 29(y13): 328 + %rsp
# parameter 30(y14): 344 + %rsp
# parameter 31(y15): 360 + %rsp
# parameter 32(y16): 376 + %rsp
# parameter 33(out): %rdi
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_pack.61:
..L62:
                                                         #19.40
..LN1133:
	.loc    1  19  prologue_end  is_stmt 1
..LN1134:
	.loc    1  20  is_stmt 1
        vpaddw    136(%rsp), %xmm0, %xmm15                      #20.12
..LN1135:
	.loc    1  21  is_stmt 1
        vpaddw    152(%rsp), %xmm1, %xmm0                       #21.12
..LN1136:
	.loc    1  19  is_stmt 1
        vmovdqu   88(%rsp), %xmm12                              #19.40
..LN1137:
        vmovdqu   24(%rsp), %xmm8                               #19.40
..LN1138:
        vmovdqu   8(%rsp), %xmm14                               #19.40
..LN1139:
        vmovdqu   40(%rsp), %xmm9                               #19.40
..LN1140:
        vmovdqu   56(%rsp), %xmm10                              #19.40
..LN1141:
        vmovdqu   72(%rsp), %xmm11                              #19.40
..LN1142:
        vmovdqu   104(%rsp), %xmm13                             #19.40
..LN1143:
        vmovdqu   120(%rsp), %xmm7                              #19.40
..LN1144:
	.loc    1  22  is_stmt 1
        vpaddw    168(%rsp), %xmm2, %xmm1                       #22.12
..LN1145:
	.loc    1  23  is_stmt 1
        vpaddw    184(%rsp), %xmm3, %xmm2                       #23.12
..LN1146:
	.loc    1  24  is_stmt 1
        vpaddw    200(%rsp), %xmm4, %xmm3                       #24.12
..LN1147:
	.loc    1  25  is_stmt 1
        vpaddw    216(%rsp), %xmm5, %xmm4                       #25.12
..LN1148:
	.loc    1  26  is_stmt 1
        vpaddw    232(%rsp), %xmm6, %xmm5                       #26.12
..LN1149:
	.loc    1  28  is_stmt 1
        vpaddw    264(%rsp), %xmm14, %xmm14                     #28.12
..LN1150:
	.loc    1  29  is_stmt 1
        vpaddw    280(%rsp), %xmm8, %xmm8                       #29.12
..LN1151:
	.loc    1  30  is_stmt 1
        vpaddw    296(%rsp), %xmm9, %xmm9                       #30.13
..LN1152:
	.loc    1  31  is_stmt 1
        vpaddw    312(%rsp), %xmm10, %xmm10                     #31.13
..LN1153:
	.loc    1  27  is_stmt 1
        vpaddw    376(%rsp), %xmm7, %xmm6                       #27.12
..LN1154:
	.loc    1  32  is_stmt 1
        vpaddw    328(%rsp), %xmm11, %xmm11                     #32.13
..LN1155:
	.loc    1  33  is_stmt 1
        vpaddw    344(%rsp), %xmm12, %xmm12                     #33.13
..LN1156:
	.loc    1  34  is_stmt 1
        vpaddw    360(%rsp), %xmm13, %xmm13                     #34.13
..LN1157:
	.loc    1  20  is_stmt 1
        vmovdqu   %xmm15, (%rdi)                                #20.3
..LN1158:
	.loc    1  21  is_stmt 1
        vmovdqu   %xmm0, 16(%rdi)                               #21.3
..LN1159:
	.loc    1  22  is_stmt 1
        vmovdqu   %xmm1, 32(%rdi)                               #22.3
..LN1160:
	.loc    1  23  is_stmt 1
        vmovdqu   %xmm2, 48(%rdi)                               #23.3
..LN1161:
	.loc    1  24  is_stmt 1
        vmovdqu   %xmm3, 64(%rdi)                               #24.3
..LN1162:
	.loc    1  25  is_stmt 1
        vmovdqu   %xmm4, 80(%rdi)                               #25.3
..LN1163:
	.loc    1  26  is_stmt 1
        vmovdqu   %xmm5, 96(%rdi)                               #26.3
..LN1164:
	.loc    1  27  is_stmt 1
        vmovdqu   %xmm6, 112(%rdi)                              #27.3
..LN1165:
	.loc    1  28  is_stmt 1
        vmovdqu   %xmm14, 128(%rdi)                             #28.3
..LN1166:
	.loc    1  29  is_stmt 1
        vmovdqu   %xmm8, 144(%rdi)                              #29.3
..LN1167:
	.loc    1  30  is_stmt 1
        vmovdqu   %xmm9, 160(%rdi)                              #30.3
..LN1168:
	.loc    1  31  is_stmt 1
        vmovdqu   %xmm10, 176(%rdi)                             #31.3
..LN1169:
	.loc    1  32  is_stmt 1
        vmovdqu   %xmm11, 192(%rdi)                             #32.3
..LN1170:
	.loc    1  33  is_stmt 1
        vmovdqu   %xmm12, 208(%rdi)                             #33.3
..LN1171:
	.loc    1  34  is_stmt 1
        vmovdqu   %xmm13, 224(%rdi)                             #34.3
..LN1172:
	.loc    1  35  is_stmt 1
        vmovdqu   %xmm6, 240(%rdi)                              #35.3
..LN1173:
	.loc    1  36  epilogue_begin  is_stmt 1
        ret                                                     #36.1
        .align    16,0x90
..LN1174:
                                # LOE
..LN1175:
	.cfi_endproc
# mark_end;
	.type	add_pack,@function
	.size	add_pack,.-add_pack
..LNadd_pack.1176:
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
# --- add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_bitslice:
# parameter 1(x1): %xmm0
# parameter 2(x2): %xmm1
# parameter 3(x3): %xmm2
# parameter 4(x4): %xmm3
# parameter 5(x5): %xmm4
# parameter 6(x6): %xmm5
# parameter 7(x7): %xmm6
# parameter 8(x8): %xmm7
# parameter 9(x9): 144 + %rsp
# parameter 10(x10): 160 + %rsp
# parameter 11(x11): 176 + %rsp
# parameter 12(x12): 192 + %rsp
# parameter 13(x13): 208 + %rsp
# parameter 14(x14): 224 + %rsp
# parameter 15(x15): 240 + %rsp
# parameter 16(x16): 256 + %rsp
# parameter 17(y1): 272 + %rsp
# parameter 18(y2): 288 + %rsp
# parameter 19(y3): 304 + %rsp
# parameter 20(y4): 320 + %rsp
# parameter 21(y5): 336 + %rsp
# parameter 22(y6): 352 + %rsp
# parameter 23(y7): 368 + %rsp
# parameter 24(y8): 384 + %rsp
# parameter 25(y9): 400 + %rsp
# parameter 26(y10): 416 + %rsp
# parameter 27(y11): 432 + %rsp
# parameter 28(y12): 448 + %rsp
# parameter 29(y13): 464 + %rsp
# parameter 30(y14): 480 + %rsp
# parameter 31(y15): 496 + %rsp
# parameter 32(y16): 512 + %rsp
# parameter 33(out): %rdi
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bitslice.68:
..L69:
                                                         #60.43
..LN1177:
	.loc    1  60  is_stmt 1
        pushq     %rbp                                          #60.43
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
..LN1178:
        subq      $128, %rsp                                    #60.43
	.cfi_def_cfa_offset 144
..LN1179:
        movq      %rdi, %rbp                                    #60.43
..LN1180:
        vmovdqu   %xmm1, 80(%rsp)                               #60.43[spill]
..LN1181:
	.loc    1  62  prologue_end  is_stmt 1
        lea       (%rsp), %rdi                                  #62.12
..LN1182:
        vmovdqu   272(%rsp), %xmm1                              #62.12
..LN1183:
	.loc    1  61  is_stmt 1
        vpxor     %xmm8, %xmm8, %xmm8                           #61.15
..LN1184:
	.loc    1  60  is_stmt 1
        vmovdqu   %xmm7, 48(%rdi)                               #60.43[spill]
..LN1185:
        vmovdqu   %xmm6, 96(%rdi)                               #60.43[spill]
..LN1186:
        vmovdqu   %xmm5, 16(%rdi)                               #60.43[spill]
..LN1187:
        vmovdqu   %xmm4, 32(%rdi)                               #60.43[spill]
..LN1188:
        vmovdqu   %xmm3, 64(%rdi)                               #60.43[spill]
..LN1189:
        vmovdqu   %xmm2, 112(%rdi)                              #60.43[spill]
..LN1190:
	.loc    1  61  is_stmt 1
        vmovdqu   %xmm8, (%rdi)                                 #61.13
..___tag_value_add_bitslice.74:
..LN1191:
	.loc    1  62  is_stmt 1
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #62.12
..___tag_value_add_bitslice.75:
..LN1192:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.2:                         # Preds ..B4.1
                                # Execution count [1.00e+00]
..LN1193:
        vmovdqu   %xmm0, (%rbp)                                 #62.3
..LN1194:
	.loc    1  63  is_stmt 1
        lea       (%rsp), %rdi                                  #63.12
..LN1195:
        vmovdqu   80(%rdi), %xmm0                               #63.12[spill]
..LN1196:
        vmovdqu   288(%rsp), %xmm1                              #63.12
..___tag_value_add_bitslice.76:
..LN1197:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #63.12
..___tag_value_add_bitslice.77:
..LN1198:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.3:                         # Preds ..B4.2
                                # Execution count [1.00e+00]
..LN1199:
        vmovdqu   %xmm0, 16(%rbp)                               #63.3
..LN1200:
	.loc    1  64  is_stmt 1
        lea       (%rsp), %rdi                                  #64.12
..LN1201:
        vmovdqu   112(%rdi), %xmm0                              #64.12[spill]
..LN1202:
        vmovdqu   304(%rsp), %xmm1                              #64.12
..___tag_value_add_bitslice.78:
..LN1203:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #64.12
..___tag_value_add_bitslice.79:
..LN1204:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.4:                         # Preds ..B4.3
                                # Execution count [1.00e+00]
..LN1205:
        vmovdqu   %xmm0, 32(%rbp)                               #64.3
..LN1206:
	.loc    1  65  is_stmt 1
        lea       (%rsp), %rdi                                  #65.12
..LN1207:
        vmovdqu   64(%rdi), %xmm0                               #65.12[spill]
..LN1208:
        vmovdqu   320(%rsp), %xmm1                              #65.12
..___tag_value_add_bitslice.80:
..LN1209:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #65.12
..___tag_value_add_bitslice.81:
..LN1210:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.5:                         # Preds ..B4.4
                                # Execution count [1.00e+00]
..LN1211:
        vmovdqu   %xmm0, 48(%rbp)                               #65.3
..LN1212:
	.loc    1  66  is_stmt 1
        lea       (%rsp), %rdi                                  #66.12
..LN1213:
        vmovdqu   32(%rdi), %xmm0                               #66.12[spill]
..LN1214:
        vmovdqu   336(%rsp), %xmm1                              #66.12
..___tag_value_add_bitslice.82:
..LN1215:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #66.12
..___tag_value_add_bitslice.83:
..LN1216:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.6:                         # Preds ..B4.5
                                # Execution count [1.00e+00]
..LN1217:
        vmovdqu   %xmm0, 64(%rbp)                               #66.3
..LN1218:
	.loc    1  67  is_stmt 1
        lea       (%rsp), %rdi                                  #67.12
..LN1219:
        vmovdqu   16(%rdi), %xmm0                               #67.12[spill]
..LN1220:
        vmovdqu   352(%rsp), %xmm1                              #67.12
..___tag_value_add_bitslice.84:
..LN1221:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #67.12
..___tag_value_add_bitslice.85:
..LN1222:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.7:                         # Preds ..B4.6
                                # Execution count [1.00e+00]
..LN1223:
        vmovdqu   %xmm0, 80(%rbp)                               #67.3
..LN1224:
	.loc    1  68  is_stmt 1
        lea       (%rsp), %rdi                                  #68.12
..LN1225:
        vmovdqu   96(%rdi), %xmm0                               #68.12[spill]
..LN1226:
        vmovdqu   368(%rsp), %xmm1                              #68.12
..___tag_value_add_bitslice.86:
..LN1227:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #68.12
..___tag_value_add_bitslice.87:
..LN1228:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.8:                         # Preds ..B4.7
                                # Execution count [1.00e+00]
..LN1229:
        vmovdqu   %xmm0, 96(%rbp)                               #68.3
..LN1230:
	.loc    1  69  is_stmt 1
        lea       (%rsp), %rdi                                  #69.12
..LN1231:
        vmovdqu   48(%rdi), %xmm0                               #69.12[spill]
..LN1232:
        vmovdqu   384(%rsp), %xmm1                              #69.12
..___tag_value_add_bitslice.88:
..LN1233:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #69.12
..___tag_value_add_bitslice.89:
..LN1234:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.9:                         # Preds ..B4.8
                                # Execution count [1.00e+00]
..LN1235:
        vmovdqu   %xmm0, 112(%rbp)                              #69.3
..LN1236:
	.loc    1  70  is_stmt 1
        lea       (%rsp), %rdi                                  #70.12
..LN1237:
        vmovdqu   144(%rsp), %xmm0                              #70.12
..LN1238:
        vmovdqu   400(%rsp), %xmm1                              #70.12
..___tag_value_add_bitslice.90:
..LN1239:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #70.12
..___tag_value_add_bitslice.91:
..LN1240:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.10:                        # Preds ..B4.9
                                # Execution count [1.00e+00]
..LN1241:
        vmovdqu   %xmm0, 128(%rbp)                              #70.3
..LN1242:
	.loc    1  71  is_stmt 1
        lea       (%rsp), %rdi                                  #71.12
..LN1243:
        vmovdqu   160(%rsp), %xmm0                              #71.12
..LN1244:
        vmovdqu   416(%rsp), %xmm1                              #71.12
..___tag_value_add_bitslice.92:
..LN1245:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #71.12
..___tag_value_add_bitslice.93:
..LN1246:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.11:                        # Preds ..B4.10
                                # Execution count [1.00e+00]
..LN1247:
        vmovdqu   %xmm0, 144(%rbp)                              #71.3
..LN1248:
	.loc    1  72  is_stmt 1
        lea       (%rsp), %rdi                                  #72.13
..LN1249:
        vmovdqu   176(%rsp), %xmm0                              #72.13
..LN1250:
        vmovdqu   432(%rsp), %xmm1                              #72.13
..___tag_value_add_bitslice.94:
..LN1251:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #72.13
..___tag_value_add_bitslice.95:
..LN1252:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.12:                        # Preds ..B4.11
                                # Execution count [1.00e+00]
..LN1253:
        vmovdqu   %xmm0, 160(%rbp)                              #72.3
..LN1254:
	.loc    1  73  is_stmt 1
        lea       (%rsp), %rdi                                  #73.13
..LN1255:
        vmovdqu   192(%rsp), %xmm0                              #73.13
..LN1256:
        vmovdqu   448(%rsp), %xmm1                              #73.13
..___tag_value_add_bitslice.96:
..LN1257:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #73.13
..___tag_value_add_bitslice.97:
..LN1258:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.13:                        # Preds ..B4.12
                                # Execution count [1.00e+00]
..LN1259:
        vmovdqu   %xmm0, 176(%rbp)                              #73.3
..LN1260:
	.loc    1  74  is_stmt 1
        lea       (%rsp), %rdi                                  #74.13
..LN1261:
        vmovdqu   208(%rsp), %xmm0                              #74.13
..LN1262:
        vmovdqu   464(%rsp), %xmm1                              #74.13
..___tag_value_add_bitslice.98:
..LN1263:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #74.13
..___tag_value_add_bitslice.99:
..LN1264:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.14:                        # Preds ..B4.13
                                # Execution count [1.00e+00]
..LN1265:
        vmovdqu   %xmm0, 192(%rbp)                              #74.3
..LN1266:
	.loc    1  75  is_stmt 1
        lea       (%rsp), %rdi                                  #75.13
..LN1267:
        vmovdqu   224(%rsp), %xmm0                              #75.13
..LN1268:
        vmovdqu   480(%rsp), %xmm1                              #75.13
..___tag_value_add_bitslice.100:
..LN1269:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #75.13
..___tag_value_add_bitslice.101:
..LN1270:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.15:                        # Preds ..B4.14
                                # Execution count [1.00e+00]
..LN1271:
        vmovdqu   %xmm0, 208(%rbp)                              #75.3
..LN1272:
	.loc    1  76  is_stmt 1
        lea       (%rsp), %rdi                                  #76.13
..LN1273:
        vmovdqu   240(%rsp), %xmm0                              #76.13
..LN1274:
        vmovdqu   496(%rsp), %xmm1                              #76.13
..___tag_value_add_bitslice.102:
..LN1275:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #76.13
..___tag_value_add_bitslice.103:
..LN1276:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.16:                        # Preds ..B4.15
                                # Execution count [1.00e+00]
..LN1277:
        vmovdqu   %xmm0, 224(%rbp)                              #76.3
..LN1278:
	.loc    1  77  is_stmt 1
        lea       (%rsp), %rdi                                  #77.13
..LN1279:
        vmovdqu   256(%rsp), %xmm0                              #77.13
..LN1280:
        vmovdqu   512(%rsp), %xmm1                              #77.13
..___tag_value_add_bitslice.104:
..LN1281:
#       add(__m128i, __m128i, __m128i *__restrict__)
        call      add                                           #77.13
..___tag_value_add_bitslice.105:
..LN1282:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B4.17:                        # Preds ..B4.16
                                # Execution count [1.00e+00]
..LN1283:
        vmovdqu   %xmm0, 240(%rbp)                              #77.3
..LN1284:
	.loc    1  78  epilogue_begin  is_stmt 1
        addq      $128, %rsp                                    #78.1
	.cfi_def_cfa_offset 16
	.cfi_restore 6
..LN1285:
        popq      %rbp                                          #78.1
	.cfi_def_cfa_offset 8
..LN1286:
        ret                                                     #78.1
        .align    16,0x90
..LN1287:
                                # LOE
..LN1288:
	.cfi_endproc
# mark_end;
	.type	add_bitslice,@function
	.size	add_bitslice,.-add_bitslice
..LNadd_bitslice.1289:
.LNadd_bitslice:
	.data
# -- End  add_bitslice
	.text
.L_2__routine_start_add_4:
# -- Begin  add
	.text
# mark_begin;
       .align    16,0x90
	.globl add
# --- add(__m128i, __m128i, __m128i *__restrict__)
add:
# parameter 1(a): %xmm0
# parameter 2(b): %xmm1
# parameter 3(c): %rdi
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add.114:
..L115:
                                                        #39.56
..LN1290:
	.loc    1  39  prologue_end  is_stmt 1
..LN1291:
	.loc    1  40  is_stmt 1
        vpxor     %xmm1, %xmm0, %xmm5                           #40.17
..LN1292:
	.loc    1  41  is_stmt 1
        vmovdqu   (%rdi), %xmm6                                 #41.36
..LN1293:
	.loc    1  42  is_stmt 1
        vpand     %xmm1, %xmm0, %xmm2                           #42.21
..LN1294:
        vpand     %xmm5, %xmm6, %xmm3                           #42.40
..LN1295:
	.loc    1  41  is_stmt 1
        vpxor     %xmm6, %xmm5, %xmm0                           #41.17
..LN1296:
	.loc    1  42  is_stmt 1
        vpxor     %xmm3, %xmm2, %xmm4                           #42.7
..LN1297:
        vmovdqu   %xmm4, (%rdi)                                 #42.4
..LN1298:
	.loc    1  43  epilogue_begin  is_stmt 1
        ret                                                     #43.10
        .align    16,0x90
..LN1299:
                                # LOE
..LN1300:
	.cfi_endproc
# mark_end;
	.type	add,@function
	.size	add,.-add
..LNadd.1301:
.LNadd:
	.data
# -- End  add
	.text
.L_2__routine_start_add_lookahead_5:
# -- Begin  add_lookahead
	.text
# mark_begin;
       .align    16,0x90
	.globl add_lookahead
# --- add_lookahead(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_lookahead:
# parameter 1(a0): %xmm0
# parameter 2(a1): %xmm1
# parameter 3(a2): %xmm2
# parameter 4(a3): %xmm3
# parameter 5(a4): %xmm4
# parameter 6(a5): %xmm5
# parameter 7(a6): %xmm6
# parameter 8(a7): %xmm7
# parameter 9(a8): 16 + %rbp
# parameter 10(a9): 32 + %rbp
# parameter 11(a10): 48 + %rbp
# parameter 12(a11): 64 + %rbp
# parameter 13(a12): 80 + %rbp
# parameter 14(a13): 96 + %rbp
# parameter 15(a14): 112 + %rbp
# parameter 16(a15): 128 + %rbp
# parameter 17(b0): 144 + %rbp
# parameter 18(b1): 160 + %rbp
# parameter 19(b2): 176 + %rbp
# parameter 20(b3): 192 + %rbp
# parameter 21(b4): 208 + %rbp
# parameter 22(b5): 224 + %rbp
# parameter 23(b6): 240 + %rbp
# parameter 24(b7): 256 + %rbp
# parameter 25(b8): 272 + %rbp
# parameter 26(b9): 288 + %rbp
# parameter 27(b10): 304 + %rbp
# parameter 28(b11): 320 + %rbp
# parameter 29(b12): 336 + %rbp
# parameter 30(b13): 352 + %rbp
# parameter 31(b14): 368 + %rbp
# parameter 32(b15): 384 + %rbp
# parameter 33(out): %rdi
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_lookahead.121:
..L122:
                                                        #88.44
..LN1302:
	.loc    1  88  is_stmt 1
        pushq     %rbp                                          #88.44
	.cfi_def_cfa_offset 16
..LN1303:
        movq      %rsp, %rbp                                    #88.44
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
..LN1304:
        subq      $496, %rsp                                    #88.44
..LN1305:
        vmovdqa   %xmm0, %xmm12                                 #88.44
..LN1306:
        vmovdqu   128(%rbp), %xmm14                             #88.44
..LN1307:
        vmovdqa   %xmm3, %xmm11                                 #88.44
..LN1308:
	.loc    1  104  prologue_end  is_stmt 1
        vpxor     384(%rbp), %xmm14, %xmm13                     #104.23
..LN1309:
	.loc    1  88  is_stmt 1
        vmovdqu   144(%rbp), %xmm14                             #88.44
..LN1310:
        vmovdqu   160(%rbp), %xmm8                              #88.44
..LN1311:
	.loc    1  89  is_stmt 1
        vpxor     %xmm14, %xmm12, %xmm10                        #89.21
..LN1312:
	.loc    1  88  is_stmt 1
        vmovdqu   176(%rbp), %xmm15                             #88.44
..LN1313:
	.loc    1  106  is_stmt 1
        vpand     %xmm14, %xmm12, %xmm14                        #106.21
..LN1314:
	.loc    1  88  is_stmt 1
        vmovdqu   192(%rbp), %xmm9                              #88.44
..LN1315:
	.loc    1  107  is_stmt 1
        vpand     %xmm8, %xmm1, %xmm12                          #107.21
..LN1316:
	.loc    1  88  is_stmt 1
        vmovdqu   208(%rbp), %xmm3                              #88.44
..LN1317:
        vmovdqu   224(%rbp), %xmm0                              #88.44
..LN1318:
	.loc    1  104  is_stmt 1
        vmovdqu   %xmm13, -496(%rbp)                            #104.23[spill]
..LN1319:
	.loc    1  90  is_stmt 1
        vpxor     %xmm8, %xmm1, %xmm13                          #90.21
..LN1320:
	.loc    1  138  is_stmt 1
        vmovdqu   %xmm10, (%rdi)                                #138.3
..LN1321:
	.loc    1  91  is_stmt 1
        vpxor     %xmm15, %xmm2, %xmm8                          #91.21
..LN1322:
	.loc    1  108  is_stmt 1
        vpand     %xmm15, %xmm2, %xmm10                         #108.21
..LN1323:
	.loc    1  92  is_stmt 1
        vpxor     %xmm9, %xmm11, %xmm15                         #92.21
..LN1324:
	.loc    1  109  is_stmt 1
        vpand     %xmm9, %xmm11, %xmm9                          #109.21
..LN1325:
	.loc    1  93  is_stmt 1
        vpxor     %xmm3, %xmm4, %xmm11                          #93.21
..LN1326:
	.loc    1  110  is_stmt 1
        vpand     %xmm3, %xmm4, %xmm2                           #110.21
..LN1327:
	.loc    1  94  is_stmt 1
        vpxor     %xmm0, %xmm5, %xmm3                           #94.21
..LN1328:
	.loc    1  95  is_stmt 1
        vmovdqu   240(%rbp), %xmm4                              #95.21
..LN1329:
	.loc    1  111  is_stmt 1
        vpand     %xmm0, %xmm5, %xmm5                           #111.21
..LN1330:
	.loc    1  95  is_stmt 1
        vpxor     %xmm4, %xmm6, %xmm1                           #95.21
..LN1331:
	.loc    1  112  is_stmt 1
        vpand     %xmm4, %xmm6, %xmm0                           #112.21
..LN1332:
	.loc    1  96  is_stmt 1
        vmovdqu   256(%rbp), %xmm4                              #96.21
..LN1333:
        vpxor     %xmm4, %xmm7, %xmm6                           #96.21
..LN1334:
	.loc    1  113  is_stmt 1
        vpand     %xmm4, %xmm7, %xmm7                           #113.21
..LN1335:
	.loc    1  96  is_stmt 1
        vmovdqu   %xmm6, -272(%rbp)                             #96.21[spill]
..LN1336:
	.loc    1  113  is_stmt 1
        vmovdqu   %xmm7, -256(%rbp)                             #113.21[spill]
..LN1337:
	.loc    1  97  is_stmt 1
        vmovdqu   16(%rbp), %xmm6                               #97.21
..LN1338:
        vmovdqu   272(%rbp), %xmm7                              #97.21
..LN1339:
	.loc    1  112  is_stmt 1
        vmovdqu   %xmm0, -288(%rbp)                             #112.21[spill]
..LN1340:
	.loc    1  97  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #97.21
..LN1341:
	.loc    1  114  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #114.21
..LN1342:
	.loc    1  98  is_stmt 1
        vmovdqu   32(%rbp), %xmm6                               #98.21
..LN1343:
        vmovdqu   288(%rbp), %xmm7                              #98.21
..LN1344:
	.loc    1  97  is_stmt 1
        vmovdqu   %xmm0, -240(%rbp)                             #97.21[spill]
..LN1345:
	.loc    1  98  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #98.21
..LN1346:
	.loc    1  114  is_stmt 1
        vmovdqu   %xmm4, -224(%rbp)                             #114.21[spill]
..LN1347:
	.loc    1  115  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #115.21
..LN1348:
	.loc    1  99  is_stmt 1
        vmovdqu   48(%rbp), %xmm6                               #99.23
..LN1349:
        vmovdqu   304(%rbp), %xmm7                              #99.23
..LN1350:
	.loc    1  98  is_stmt 1
        vmovdqu   %xmm0, -208(%rbp)                             #98.21[spill]
..LN1351:
	.loc    1  99  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #99.23
..LN1352:
	.loc    1  115  is_stmt 1
        vmovdqu   %xmm4, -192(%rbp)                             #115.21[spill]
..LN1353:
	.loc    1  116  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #116.23
..LN1354:
	.loc    1  100  is_stmt 1
        vmovdqu   64(%rbp), %xmm6                               #100.23
..LN1355:
        vmovdqu   320(%rbp), %xmm7                              #100.23
..LN1356:
	.loc    1  99  is_stmt 1
        vmovdqu   %xmm0, -176(%rbp)                             #99.23[spill]
..LN1357:
	.loc    1  100  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #100.23
..LN1358:
	.loc    1  116  is_stmt 1
        vmovdqu   %xmm4, -160(%rbp)                             #116.23[spill]
..LN1359:
	.loc    1  117  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #117.23
..LN1360:
	.loc    1  101  is_stmt 1
        vmovdqu   80(%rbp), %xmm6                               #101.23
..LN1361:
        vmovdqu   336(%rbp), %xmm7                              #101.23
..LN1362:
	.loc    1  100  is_stmt 1
        vmovdqu   %xmm0, -144(%rbp)                             #100.23[spill]
..LN1363:
	.loc    1  101  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #101.23
..LN1364:
	.loc    1  117  is_stmt 1
        vmovdqu   %xmm4, -128(%rbp)                             #117.23[spill]
..LN1365:
	.loc    1  118  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #118.23
..LN1366:
	.loc    1  102  is_stmt 1
        vmovdqu   96(%rbp), %xmm6                               #102.23
..LN1367:
        vmovdqu   352(%rbp), %xmm7                              #102.23
..LN1368:
	.loc    1  101  is_stmt 1
        vmovdqu   %xmm0, -112(%rbp)                             #101.23[spill]
..LN1369:
	.loc    1  102  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #102.23
..LN1370:
	.loc    1  118  is_stmt 1
        vmovdqu   %xmm4, -96(%rbp)                              #118.23[spill]
..LN1371:
	.loc    1  119  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #119.23
..LN1372:
	.loc    1  103  is_stmt 1
        vmovdqu   112(%rbp), %xmm6                              #103.23
..LN1373:
        vmovdqu   368(%rbp), %xmm7                              #103.23
..LN1374:
	.loc    1  102  is_stmt 1
        vmovdqu   %xmm0, -80(%rbp)                              #102.23[spill]
..LN1375:
	.loc    1  103  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm0                           #103.23
..LN1376:
	.loc    1  119  is_stmt 1
        vmovdqu   %xmm4, -64(%rbp)                              #119.23[spill]
..LN1377:
	.loc    1  120  is_stmt 1
        vpand     %xmm7, %xmm6, %xmm4                           #120.23
..LN1378:
	.loc    1  123  is_stmt 1
        vpand     %xmm14, %xmm13, %xmm6                         #123.24
..LN1379:
	.loc    1  103  is_stmt 1
        vmovdqu   %xmm0, -48(%rbp)                              #103.23[spill]
..LN1380:
	.loc    1  139  is_stmt 1
        vpxor     %xmm14, %xmm13, %xmm0                         #139.17
..LN1381:
	.loc    1  123  is_stmt 1
        vpor      %xmm6, %xmm12, %xmm7                          #123.24
..LN1382:
	.loc    1  124  is_stmt 1
        vpand     %xmm13, %xmm8, %xmm6                          #124.32
..LN1383:
	.loc    1  139  is_stmt 1
        vmovdqu   %xmm0, 16(%rdi)                               #139.3
..LN1384:
	.loc    1  124  is_stmt 1
        vpand     %xmm12, %xmm8, %xmm0                          #124.24
..LN1385:
	.loc    1  120  is_stmt 1
        vmovdqu   %xmm4, -32(%rbp)                              #120.23[spill]
..LN1386:
	.loc    1  140  is_stmt 1
        vpxor     %xmm7, %xmm8, %xmm4                           #140.17
..LN1387:
        vmovdqu   %xmm4, 32(%rdi)                               #140.3
..LN1388:
	.loc    1  124  is_stmt 1
        vpor      %xmm0, %xmm10, %xmm7                          #124.24
..LN1389:
        vpand     %xmm14, %xmm6, %xmm4                          #124.35
..LN1390:
        vpor      %xmm4, %xmm7, %xmm0                           #124.35
..LN1391:
	.loc    1  125  is_stmt 1
        vpand     %xmm10, %xmm15, %xmm7                         #125.24
..LN1392:
	.loc    1  141  is_stmt 1
        vpxor     %xmm0, %xmm15, %xmm6                          #141.17
..LN1393:
	.loc    1  125  is_stmt 1
        vpor      %xmm7, %xmm9, %xmm4                           #125.24
..LN1394:
	.loc    1  141  is_stmt 1
        vmovdqu   %xmm6, 48(%rdi)                               #141.3
..LN1395:
	.loc    1  125  is_stmt 1
        vpand     %xmm8, %xmm15, %xmm6                          #125.32
..LN1396:
        vpand     %xmm12, %xmm6, %xmm0                          #125.35
..LN1397:
        vpand     %xmm13, %xmm6, %xmm6                          #125.46
..LN1398:
        vpor      %xmm0, %xmm4, %xmm7                           #125.35
..LN1399:
        vpand     %xmm14, %xmm6, %xmm4                          #125.49
..LN1400:
        vpor      %xmm4, %xmm7, %xmm0                           #125.49
..LN1401:
	.loc    1  126  is_stmt 1
        vpand     %xmm15, %xmm11, %xmm7                         #126.32
..LN1402:
        vpand     %xmm9, %xmm11, %xmm4                          #126.24
..LN1403:
	.loc    1  142  is_stmt 1
        vpxor     %xmm0, %xmm11, %xmm6                          #142.17
..LN1404:
        vmovdqu   %xmm6, 64(%rdi)                               #142.3
..LN1405:
	.loc    1  126  is_stmt 1
        vpand     %xmm8, %xmm7, %xmm0                           #126.60
..LN1406:
        vpand     %xmm10, %xmm7, %xmm7                          #126.35
..LN1407:
        vpor      %xmm4, %xmm2, %xmm6                           #126.24
..LN1408:
        vpor      %xmm7, %xmm6, %xmm4                           #126.35
..LN1409:
        vpand     %xmm12, %xmm0, %xmm6                          #126.49
..LN1410:
        vpand     %xmm13, %xmm0, %xmm0                          #126.63
..LN1411:
        vpor      %xmm6, %xmm4, %xmm7                           #126.49
..LN1412:
        vpand     %xmm14, %xmm0, %xmm0                          #126.66
..LN1413:
        vpor      %xmm0, %xmm7, %xmm6                           #126.66
..LN1414:
	.loc    1  127  is_stmt 1
        vpand     %xmm11, %xmm3, %xmm0                          #127.32
..LN1415:
	.loc    1  143  is_stmt 1
        vpxor     %xmm6, %xmm3, %xmm4                           #143.17
..LN1416:
	.loc    1  127  is_stmt 1
        vpand     %xmm15, %xmm0, %xmm6                          #127.77
..LN1417:
        vpand     %xmm9, %xmm0, %xmm7                           #127.35
..LN1418:
        vpand     %xmm2, %xmm3, %xmm0                           #127.24
..LN1419:
        vpor      %xmm0, %xmm5, %xmm0                           #127.24
..LN1420:
	.loc    1  143  is_stmt 1
        vmovdqu   %xmm4, 80(%rdi)                               #143.3
..LN1421:
	.loc    1  127  is_stmt 1
        vpand     %xmm8, %xmm6, %xmm4                           #127.63
..LN1422:
        vpand     %xmm10, %xmm6, %xmm6                          #127.49
..LN1423:
        vpor      %xmm7, %xmm0, %xmm7                           #127.35
..LN1424:
        vpor      %xmm6, %xmm7, %xmm0                           #127.49
..LN1425:
        vpand     %xmm12, %xmm4, %xmm6                          #127.66
..LN1426:
        vpand     %xmm13, %xmm4, %xmm4                          #127.83
..LN1427:
        vpor      %xmm6, %xmm0, %xmm7                           #127.66
..LN1428:
        vpand     %xmm14, %xmm4, %xmm0                          #127.86
..LN1429:
        vpor      %xmm0, %xmm7, %xmm6                           #127.86
..LN1430:
	.loc    1  128  is_stmt 1
        vpand     %xmm3, %xmm1, %xmm0                           #128.32
..LN1431:
        vpand     %xmm11, %xmm0, %xmm7                          #128.97
..LN1432:
	.loc    1  144  is_stmt 1
        vpxor     %xmm6, %xmm1, %xmm4                           #144.17
..LN1433:
        vmovdqu   %xmm4, 96(%rdi)                               #144.3
..LN1434:
	.loc    1  128  is_stmt 1
        vpand     %xmm2, %xmm0, %xmm4                           #128.35
..LN1435:
        vpand     %xmm15, %xmm7, %xmm0                          #128.63
..LN1436:
        vpand     %xmm9, %xmm7, %xmm6                           #128.49
..LN1437:
	.loc    1  91  is_stmt 1
        vmovdqu   %xmm8, -432(%rbp)                             #91.21[spill]
..LN1438:
	.loc    1  128  is_stmt 1
        vpand     %xmm8, %xmm0, %xmm7                           #128.103
..LN1439:
	.loc    1  108  is_stmt 1
        vmovdqu   %xmm10, -416(%rbp)                            #108.21[spill]
..LN1440:
	.loc    1  128  is_stmt 1
        vpand     %xmm10, %xmm0, %xmm10                         #128.66
..LN1441:
        vmovdqu   -288(%rbp), %xmm8                             #128.24[spill]
..LN1442:
        vpand     %xmm5, %xmm1, %xmm0                           #128.24
..LN1443:
        vpor      %xmm0, %xmm8, %xmm0                           #128.24
..LN1444:
        vpor      %xmm4, %xmm0, %xmm4                           #128.35
..LN1445:
        vpand     %xmm12, %xmm7, %xmm0                          #128.86
..LN1446:
        vpor      %xmm6, %xmm4, %xmm6                           #128.49
..LN1447:
        vpor      %xmm10, %xmm6, %xmm10                         #128.66
..LN1448:
        vpor      %xmm0, %xmm10, %xmm6                          #128.86
..LN1449:
        vpand     %xmm13, %xmm7, %xmm10                         #128.106
..LN1450:
        vpand     %xmm14, %xmm10, %xmm7                         #128.109
..LN1451:
	.loc    1  145  is_stmt 1
        vmovdqu   -272(%rbp), %xmm10                            #145.17[spill]
..LN1452:
	.loc    1  128  is_stmt 1
        vpor      %xmm7, %xmm6, %xmm4                           #128.109
..LN1453:
	.loc    1  129  is_stmt 1
        vpand     %xmm1, %xmm10, %xmm6                          #129.32
..LN1454:
	.loc    1  145  is_stmt 1
        vpxor     %xmm4, %xmm10, %xmm0                          #145.17
..LN1455:
	.loc    1  129  is_stmt 1
        vpand     %xmm3, %xmm6, %xmm4                           #129.120
..LN1456:
        vpand     %xmm5, %xmm6, %xmm7                           #129.35
..LN1457:
	.loc    1  145  is_stmt 1
        vmovdqu   %xmm0, 112(%rdi)                              #145.3
..LN1458:
	.loc    1  129  is_stmt 1
        vpand     %xmm11, %xmm4, %xmm0                          #129.63
..LN1459:
	.loc    1  92  is_stmt 1
        vmovdqu   %xmm15, -400(%rbp)                            #92.21[spill]
..LN1460:
	.loc    1  129  is_stmt 1
        vpand     %xmm15, %xmm0, %xmm15                         #129.126
..LN1461:
	.loc    1  109  is_stmt 1
        vmovdqu   %xmm9, -384(%rbp)                             #109.21[spill]
..LN1462:
	.loc    1  129  is_stmt 1
        vpand     %xmm9, %xmm0, %xmm6                           #129.66
..LN1463:
	.loc    1  110  is_stmt 1
        vmovdqu   %xmm2, -352(%rbp)                             #110.21[spill]
..LN1464:
	.loc    1  129  is_stmt 1
        vpand     %xmm2, %xmm4, %xmm2                           #129.49
..LN1465:
        vpand     -432(%rbp), %xmm15, %xmm4                     #129.106[spill]
..LN1466:
        vpand     %xmm8, %xmm10, %xmm0                          #129.24
..LN1467:
        vpand     -416(%rbp), %xmm15, %xmm9                     #129.86[spill]
..LN1468:
        vmovdqu   -256(%rbp), %xmm15                            #129.24[spill]
..LN1469:
        vpor      %xmm0, %xmm15, %xmm0                          #129.24
..LN1470:
        vpor      %xmm7, %xmm0, %xmm7                           #129.35
..LN1471:
        vpor      %xmm2, %xmm7, %xmm2                           #129.49
..LN1472:
        vpor      %xmm6, %xmm2, %xmm0                           #129.66
..LN1473:
        vpor      %xmm9, %xmm0, %xmm9                           #129.86
..LN1474:
        vpand     %xmm12, %xmm4, %xmm0                          #129.109
..LN1475:
        vpor      %xmm0, %xmm9, %xmm6                           #129.109
..LN1476:
        vpand     %xmm13, %xmm4, %xmm9                          #129.132
..LN1477:
        vpand     %xmm14, %xmm9, %xmm2                          #129.135
..LN1478:
	.loc    1  146  is_stmt 1
        vmovdqu   -240(%rbp), %xmm9                             #146.17[spill]
..LN1479:
	.loc    1  129  is_stmt 1
        vpor      %xmm2, %xmm6, %xmm7                           #129.135
..LN1480:
	.loc    1  130  is_stmt 1
        vpand     %xmm10, %xmm9, %xmm0                          #130.32
..LN1481:
	.loc    1  146  is_stmt 1
        vpxor     %xmm7, %xmm9, %xmm4                           #146.17
..LN1482:
	.loc    1  130  is_stmt 1
        vpand     %xmm1, %xmm0, %xmm6                           #130.146
..LN1483:
        vpand     %xmm8, %xmm0, %xmm8                           #130.35
..LN1484:
        vpand     %xmm3, %xmm6, %xmm2                           #130.63
..LN1485:
        vpand     %xmm5, %xmm6, %xmm7                           #130.49
..LN1486:
	.loc    1  111  is_stmt 1
        vmovdqu   %xmm5, -320(%rbp)                             #111.21[spill]
..LN1487:
	.loc    1  130  is_stmt 1
        vpand     %xmm11, %xmm2, %xmm5                          #130.152
..LN1488:
	.loc    1  93  is_stmt 1
        vmovdqu   %xmm11, -368(%rbp)                            #93.21[spill]
..LN1489:
	.loc    1  130  is_stmt 1
        vpand     -400(%rbp), %xmm5, %xmm6                      #130.106[spill]
..LN1490:
        vpand     -384(%rbp), %xmm5, %xmm11                     #130.86[spill]
..LN1491:
        vmovdqu   -224(%rbp), %xmm5                             #130.24[spill]
..LN1492:
	.loc    1  146  is_stmt 1
        vmovdqu   %xmm4, 128(%rdi)                              #146.3
..LN1493:
	.loc    1  130  is_stmt 1
        vpand     %xmm15, %xmm9, %xmm4                          #130.24
..LN1494:
        vpor      %xmm4, %xmm5, %xmm4                           #130.24
..LN1495:
        vpor      %xmm8, %xmm4, %xmm8                           #130.35
..LN1496:
        vpand     -352(%rbp), %xmm2, %xmm2                      #130.66[spill]
..LN1497:
        vpor      %xmm7, %xmm8, %xmm8                           #130.49
..LN1498:
        vpor      %xmm2, %xmm8, %xmm2                           #130.66
..LN1499:
        vpand     -432(%rbp), %xmm6, %xmm0                      #130.158[spill]
..LN1500:
        vpor      %xmm11, %xmm2, %xmm11                         #130.86
..LN1501:
        vpand     -416(%rbp), %xmm6, %xmm6                      #130.109[spill]
..LN1502:
        vpand     %xmm12, %xmm0, %xmm8                          #130.135
..LN1503:
        vpor      %xmm6, %xmm11, %xmm11                         #130.109
..LN1504:
        vpand     %xmm13, %xmm0, %xmm0                          #130.161
..LN1505:
        vpor      %xmm8, %xmm11, %xmm6                          #130.135
..LN1506:
        vpand     %xmm14, %xmm0, %xmm2                          #130.164
..LN1507:
        vpor      %xmm2, %xmm6, %xmm7                           #130.164
..LN1508:
	.loc    1  147  is_stmt 1
        vmovdqu   -208(%rbp), %xmm6                             #147.17[spill]
..LN1509:
	.loc    1  131  is_stmt 1
        vpand     %xmm9, %xmm6, %xmm11                          #131.32
..LN1510:
	.loc    1  147  is_stmt 1
        vpxor     %xmm7, %xmm6, %xmm4                           #147.17
..LN1511:
	.loc    1  131  is_stmt 1
        vpand     %xmm10, %xmm11, %xmm8                         #131.175
..LN1512:
        vpand     %xmm15, %xmm11, %xmm11                        #131.35
..LN1513:
	.loc    1  95  is_stmt 1
        vmovdqu   %xmm1, -304(%rbp)                             #95.21[spill]
..LN1514:
	.loc    1  131  is_stmt 1
        vpand     %xmm1, %xmm8, %xmm1                           #131.63
..LN1515:
	.loc    1  94  is_stmt 1
        vmovdqu   %xmm3, -336(%rbp)                             #94.21[spill]
..LN1516:
	.loc    1  131  is_stmt 1
        vpand     %xmm3, %xmm1, %xmm3                           #131.181
..LN1517:
        vpand     -320(%rbp), %xmm1, %xmm15                     #131.66[spill]
..LN1518:
        vpand     %xmm5, %xmm6, %xmm7                           #131.24
..LN1519:
        vpand     -368(%rbp), %xmm3, %xmm1                      #131.106[spill]
..LN1520:
        vpand     -288(%rbp), %xmm8, %xmm2                      #131.49[spill]
..LN1521:
        vpand     -352(%rbp), %xmm3, %xmm8                      #131.86[spill]
..LN1522:
        vpand     -400(%rbp), %xmm1, %xmm3                      #131.187[spill]
..LN1523:
        vpand     -384(%rbp), %xmm1, %xmm0                      #131.109[spill]
..LN1524:
	.loc    1  147  is_stmt 1
        vmovdqu   %xmm4, 144(%rdi)                              #147.3
..LN1525:
	.loc    1  131  is_stmt 1
        vpand     -432(%rbp), %xmm3, %xmm4                      #131.161[spill]
..LN1526:
        vpand     -416(%rbp), %xmm3, %xmm1                      #131.135[spill]
..LN1527:
        vmovdqu   -192(%rbp), %xmm3                             #131.24[spill]
..LN1528:
        vpor      %xmm7, %xmm3, %xmm7                           #131.24
..LN1529:
        vpor      %xmm11, %xmm7, %xmm11                         #131.35
..LN1530:
        vpor      %xmm2, %xmm11, %xmm2                          #131.49
..LN1531:
        vpor      %xmm15, %xmm2, %xmm15                         #131.66
..LN1532:
        vpor      %xmm8, %xmm15, %xmm11                         #131.86
..LN1533:
        vpor      %xmm0, %xmm11, %xmm8                          #131.109
..LN1534:
        vpand     %xmm12, %xmm4, %xmm11                         #131.164
..LN1535:
        vpor      %xmm1, %xmm8, %xmm0                           #131.135
..LN1536:
        vpand     %xmm13, %xmm4, %xmm4                          #131.193
..LN1537:
	.loc    1  148  is_stmt 1
        vmovdqu   -176(%rbp), %xmm1                             #148.19[spill]
..LN1538:
	.loc    1  131  is_stmt 1
        vpor      %xmm11, %xmm0, %xmm8                          #131.164
..LN1539:
	.loc    1  132  is_stmt 1
        vpand     %xmm6, %xmm1, %xmm7                           #132.36
..LN1540:
	.loc    1  131  is_stmt 1
        vpand     %xmm14, %xmm4, %xmm11                         #131.196
..LN1541:
	.loc    1  132  is_stmt 1
        vpand     %xmm9, %xmm7, %xmm9                           #132.219
..LN1542:
	.loc    1  131  is_stmt 1
        vpor      %xmm11, %xmm8, %xmm15                         #131.196
..LN1543:
	.loc    1  132  is_stmt 1
        vpand     %xmm10, %xmm9, %xmm10                         #132.69
..LN1544:
	.loc    1  148  is_stmt 1
        vpxor     %xmm15, %xmm1, %xmm2                          #148.19
..LN1545:
        vmovdqu   %xmm2, 160(%rdi)                              #148.3
..LN1546:
	.loc    1  132  is_stmt 1
        vpand     %xmm5, %xmm7, %xmm7                           #132.39
..LN1547:
        vpand     -256(%rbp), %xmm9, %xmm2                      #132.54[spill]
..LN1548:
        vpand     %xmm3, %xmm1, %xmm4                           #132.27
..LN1549:
        vpand     -304(%rbp), %xmm10, %xmm9                     #132.225[spill]
..LN1550:
        vpand     -336(%rbp), %xmm9, %xmm11                     #132.114[spill]
..LN1551:
        vpand     -288(%rbp), %xmm10, %xmm5                     #132.72[spill]
..LN1552:
        vpand     -368(%rbp), %xmm11, %xmm10                    #132.231[spill]
..LN1553:
        vpand     -320(%rbp), %xmm9, %xmm15                     #132.93[spill]
..LN1554:
        vpand     -400(%rbp), %xmm10, %xmm0                     #132.171[spill]
..LN1555:
        vpand     -384(%rbp), %xmm10, %xmm9                     #132.144[spill]
..LN1556:
        vmovdqu   -160(%rbp), %xmm10                            #132.27[spill]
..LN1557:
        vpor      %xmm4, %xmm10, %xmm4                          #132.27
..LN1558:
        vpor      %xmm7, %xmm4, %xmm7                           #132.39
..LN1559:
        vpor      %xmm2, %xmm7, %xmm2                           #132.54
..LN1560:
        vpor      %xmm5, %xmm2, %xmm5                           #132.72
..LN1561:
        vpand     -352(%rbp), %xmm11, %xmm8                     #132.117[spill]
..LN1562:
        vpor      %xmm15, %xmm5, %xmm15                         #132.93
..LN1563:
        vpor      %xmm8, %xmm15, %xmm8                          #132.117
..LN1564:
        vpand     -432(%rbp), %xmm0, %xmm11                     #132.237[spill]
..LN1565:
        vpor      %xmm9, %xmm8, %xmm9                           #132.144
..LN1566:
        vpand     -416(%rbp), %xmm0, %xmm0                      #132.174[spill]
..LN1567:
        vpand     %xmm12, %xmm11, %xmm5                         #132.207
..LN1568:
        vpor      %xmm0, %xmm9, %xmm0                           #132.174
..LN1569:
        vpand     %xmm13, %xmm11, %xmm11                        #132.240
..LN1570:
	.loc    1  149  is_stmt 1
        vmovdqu   -144(%rbp), %xmm9                             #149.19[spill]
..LN1571:
	.loc    1  132  is_stmt 1
        vpor      %xmm5, %xmm0, %xmm2                           #132.207
..LN1572:
        vpand     %xmm14, %xmm11, %xmm7                         #132.243
..LN1573:
	.loc    1  133  is_stmt 1
        vpand     %xmm1, %xmm9, %xmm8                           #133.37
..LN1574:
	.loc    1  132  is_stmt 1
        vpor      %xmm7, %xmm2, %xmm4                           #132.243
..LN1575:
	.loc    1  133  is_stmt 1
        vpand     %xmm6, %xmm8, %xmm6                           #133.266
..LN1576:
	.loc    1  149  is_stmt 1
        vpxor     %xmm4, %xmm9, %xmm11                          #149.19
..LN1577:
	.loc    1  133  is_stmt 1
        vpand     %xmm3, %xmm8, %xmm4                           #133.41
..LN1578:
	.loc    1  149  is_stmt 1
        vmovdqu   %xmm11, 176(%rdi)                             #149.3
..LN1579:
	.loc    1  133  is_stmt 1
        vpand     %xmm10, %xmm9, %xmm10                         #133.27
..LN1580:
        vpand     -240(%rbp), %xmm6, %xmm11                     #133.73[spill]
..LN1581:
        vpand     -272(%rbp), %xmm11, %xmm8                     #133.272[spill]
..LN1582:
        vpand     -304(%rbp), %xmm8, %xmm3                      #133.120[spill]
..LN1583:
        vpand     -256(%rbp), %xmm11, %xmm2                     #133.76[spill]
..LN1584:
        vpand     -336(%rbp), %xmm3, %xmm11                     #133.278[spill]
..LN1585:
        vpand     -224(%rbp), %xmm6, %xmm7                      #133.57[spill]
..LN1586:
        vpand     -288(%rbp), %xmm8, %xmm6                      #133.98[spill]
..LN1587:
        vpand     -368(%rbp), %xmm11, %xmm8                     #133.179[spill]
..LN1588:
        vpand     -400(%rbp), %xmm8, %xmm0                      #133.284[spill]
..LN1589:
        vpand     -320(%rbp), %xmm3, %xmm5                      #133.123[spill]
..LN1590:
        vpand     -352(%rbp), %xmm11, %xmm15                    #133.151[spill]
..LN1591:
        vpand     -432(%rbp), %xmm0, %xmm3                      #133.250[spill]
..LN1592:
        vpand     -416(%rbp), %xmm0, %xmm11                     #133.216[spill]
..LN1593:
        vmovdqu   -128(%rbp), %xmm0                             #133.27[spill]
..LN1594:
        vpor      %xmm10, %xmm0, %xmm10                         #133.27
..LN1595:
        vpor      %xmm4, %xmm10, %xmm4                          #133.41
..LN1596:
        vpor      %xmm7, %xmm4, %xmm7                           #133.57
..LN1597:
        vpor      %xmm2, %xmm7, %xmm2                           #133.76
..LN1598:
        vpor      %xmm6, %xmm2, %xmm6                           #133.98
..LN1599:
        vpor      %xmm5, %xmm6, %xmm5                           #133.123
..LN1600:
        vpand     -384(%rbp), %xmm8, %xmm8                      #133.182[spill]
..LN1601:
        vpor      %xmm15, %xmm5, %xmm15                         #133.151
..LN1602:
        vpor      %xmm8, %xmm15, %xmm8                          #133.182
..LN1603:
        vpor      %xmm11, %xmm8, %xmm11                         #133.216
..LN1604:
        vpand     %xmm12, %xmm3, %xmm8                          #133.253
..LN1605:
        vpand     %xmm13, %xmm3, %xmm3                          #133.290
..LN1606:
        vpor      %xmm8, %xmm11, %xmm11                         #133.253
..LN1607:
        vpand     %xmm14, %xmm3, %xmm10                         #133.293
..LN1608:
        vpor      %xmm10, %xmm11, %xmm15                        #133.293
..LN1609:
	.loc    1  150  is_stmt 1
        vmovdqu   -112(%rbp), %xmm10                            #150.19[spill]
..LN1610:
	.loc    1  134  is_stmt 1
        vpand     %xmm9, %xmm10, %xmm9                          #134.37
..LN1611:
	.loc    1  150  is_stmt 1
        vpxor     %xmm15, %xmm10, %xmm5                         #150.19
..LN1612:
	.loc    1  134  is_stmt 1
        vpand     %xmm1, %xmm9, %xmm1                           #134.316
..LN1613:
        vpand     -160(%rbp), %xmm9, %xmm4                      #134.41[spill]
..LN1614:
        vpand     -208(%rbp), %xmm1, %xmm9                      #134.76[spill]
..LN1615:
        vpand     -240(%rbp), %xmm9, %xmm11                     #134.323[spill]
..LN1616:
        vpand     -272(%rbp), %xmm11, %xmm8                     #134.125[spill]
..LN1617:
        vpand     -304(%rbp), %xmm8, %xmm3                      #134.329[spill]
..LN1618:
        vpand     -192(%rbp), %xmm1, %xmm7                      #134.59[spill]
..LN1619:
        vpand     -336(%rbp), %xmm3, %xmm1                      #134.186[spill]
..LN1620:
        vpand     -224(%rbp), %xmm9, %xmm2                      #134.79[spill]
..LN1621:
        vpand     -368(%rbp), %xmm1, %xmm9                      #134.335[spill]
..LN1622:
        vpand     -256(%rbp), %xmm11, %xmm6                     #134.102[spill]
..LN1623:
        vpand     -400(%rbp), %xmm9, %xmm11                     #134.259[spill]
..LN1624:
	.loc    1  150  is_stmt 1
        vmovdqu   %xmm5, 192(%rdi)                              #150.3
..LN1625:
	.loc    1  134  is_stmt 1
        vpand     -288(%rbp), %xmm8, %xmm5                      #134.128[spill]
..LN1626:
        vpand     -320(%rbp), %xmm3, %xmm15                     #134.157[spill]
..LN1627:
        vpand     -384(%rbp), %xmm9, %xmm8                      #134.224[spill]
..LN1628:
        vpand     -432(%rbp), %xmm11, %xmm3                     #134.341[spill]
..LN1629:
        vpand     -416(%rbp), %xmm11, %xmm9                     #134.262[spill]
..LN1630:
        vpand     %xmm0, %xmm10, %xmm11                         #134.27
..LN1631:
        vmovdqu   -96(%rbp), %xmm0                              #134.27[spill]
..LN1632:
        vpor      %xmm11, %xmm0, %xmm11                         #134.27
..LN1633:
        vpor      %xmm4, %xmm11, %xmm4                          #134.41
..LN1634:
        vpor      %xmm7, %xmm4, %xmm7                           #134.59
..LN1635:
        vpor      %xmm2, %xmm7, %xmm2                           #134.79
..LN1636:
        vpor      %xmm6, %xmm2, %xmm6                           #134.102
..LN1637:
        vpor      %xmm5, %xmm6, %xmm11                          #134.128
..LN1638:
        vpand     -352(%rbp), %xmm1, %xmm1                      #134.189[spill]
..LN1639:
        vpor      %xmm15, %xmm11, %xmm15                        #134.157
..LN1640:
        vpor      %xmm1, %xmm15, %xmm5                          #134.189
..LN1641:
        vpor      %xmm8, %xmm5, %xmm11                          #134.224
..LN1642:
	.loc    1  90  is_stmt 1
        vmovdqu   %xmm13, -464(%rbp)                            #90.21[spill]
..LN1643:
	.loc    1  134  is_stmt 1
        vpor      %xmm9, %xmm11, %xmm9                          #134.262
..LN1644:
	.loc    1  107  is_stmt 1
        vmovdqu   %xmm12, -448(%rbp)                            #107.21[spill]
..LN1645:
	.loc    1  134  is_stmt 1
        vpand     %xmm12, %xmm3, %xmm12                         #134.303
..LN1646:
        vpand     %xmm13, %xmm3, %xmm13                         #134.344
..LN1647:
        vpor      %xmm12, %xmm9, %xmm12                         #134.303
..LN1648:
	.loc    1  106  is_stmt 1
        vmovdqu   %xmm14, -480(%rbp)                            #106.21[spill]
..LN1649:
	.loc    1  134  is_stmt 1
        vpand     %xmm14, %xmm13, %xmm9                         #134.347
..LN1650:
	.loc    1  151  is_stmt 1
        vmovdqu   -80(%rbp), %xmm14                             #151.19[spill]
..LN1651:
	.loc    1  134  is_stmt 1
        vpor      %xmm9, %xmm12, %xmm11                         #134.347
..LN1652:
	.loc    1  135  is_stmt 1
        vmovdqu   -144(%rbp), %xmm13                            #135.370[spill]
..LN1653:
        vpand     %xmm10, %xmm14, %xmm3                         #135.37
..LN1654:
        vpand     %xmm13, %xmm3, %xmm1                          #135.370
..LN1655:
	.loc    1  151  is_stmt 1
        vpxor     %xmm11, %xmm14, %xmm8                         #151.19
..LN1656:
	.loc    1  135  is_stmt 1
        vpand     -176(%rbp), %xmm1, %xmm15                     #135.77[spill]
..LN1657:
        vpand     -208(%rbp), %xmm15, %xmm5                     #135.378[spill]
..LN1658:
        vpand     -240(%rbp), %xmm5, %xmm6                      #135.129[spill]
..LN1659:
        vpand     -272(%rbp), %xmm6, %xmm12                     #135.384[spill]
..LN1660:
        vpand     -304(%rbp), %xmm12, %xmm9                     #135.192[spill]
..LN1661:
	.loc    1  151  is_stmt 1
        vmovdqu   %xmm8, 208(%rdi)                              #151.3
..LN1662:
	.loc    1  135  is_stmt 1
        vpand     -336(%rbp), %xmm9, %xmm8                      #135.390[spill]
..LN1663:
        vpand     -128(%rbp), %xmm3, %xmm11                     #135.41[spill]
..LN1664:
        vpand     -368(%rbp), %xmm8, %xmm3                      #135.267[spill]
..LN1665:
        vpand     -192(%rbp), %xmm15, %xmm7                     #135.81[spill]
..LN1666:
        vpand     -320(%rbp), %xmm9, %xmm15                     #135.195[spill]
..LN1667:
        vpand     -400(%rbp), %xmm3, %xmm9                      #135.396[spill]
..LN1668:
        vpand     -224(%rbp), %xmm5, %xmm2                      #135.105[spill]
..LN1669:
        vpand     -288(%rbp), %xmm12, %xmm5                     #135.162[spill]
..LN1670:
        vpand     -432(%rbp), %xmm9, %xmm12                     #135.354[spill]
..LN1671:
        vpand     -160(%rbp), %xmm1, %xmm4                      #135.59[spill]
..LN1672:
        vmovdqu   %xmm12, -16(%rbp)                             #135.354[spill]
..LN1673:
        vpand     -352(%rbp), %xmm8, %xmm1                      #135.231[spill]
..LN1674:
        vpand     %xmm0, %xmm14, %xmm8                          #135.27
..LN1675:
        vmovdqu   -64(%rbp), %xmm12                             #135.27[spill]
..LN1676:
        vpor      %xmm8, %xmm12, %xmm8                          #135.27
..LN1677:
        vpor      %xmm11, %xmm8, %xmm11                         #135.41
..LN1678:
        vpor      %xmm4, %xmm11, %xmm4                          #135.59
..LN1679:
        vpor      %xmm7, %xmm4, %xmm7                           #135.81
..LN1680:
        vpand     -256(%rbp), %xmm6, %xmm6                      #135.132[spill]
..LN1681:
        vpor      %xmm2, %xmm7, %xmm2                           #135.105
..LN1682:
        vpor      %xmm6, %xmm2, %xmm11                          #135.132
..LN1683:
        vpor      %xmm5, %xmm11, %xmm8                          #135.162
..LN1684:
        vpor      %xmm15, %xmm8, %xmm15                         #135.195
..LN1685:
        vpand     -384(%rbp), %xmm3, %xmm3                      #135.270[spill]
..LN1686:
        vpor      %xmm1, %xmm15, %xmm1                          #135.231
..LN1687:
	.loc    1  136  is_stmt 1
        vmovdqu   -48(%rbp), %xmm5                              #136.37[spill]
..LN1688:
	.loc    1  135  is_stmt 1
        vpor      %xmm3, %xmm1, %xmm3                           #135.270
..LN1689:
        vpand     -416(%rbp), %xmm9, %xmm9                      #135.312[spill]
..LN1690:
	.loc    1  136  is_stmt 1
        vpand     %xmm14, %xmm5, %xmm14                         #136.37
..LN1691:
	.loc    1  135  is_stmt 1
        vpor      %xmm9, %xmm3, %xmm6                           #135.312
..LN1692:
	.loc    1  136  is_stmt 1
        vpand     %xmm10, %xmm14, %xmm9                         #136.428
..LN1693:
        vpand     %xmm13, %xmm9, %xmm10                         #136.77
..LN1694:
        vpand     %xmm0, %xmm14, %xmm8                          #136.41
..LN1695:
        vpand     -176(%rbp), %xmm10, %xmm0                     #136.436[spill]
..LN1696:
        vpand     %xmm12, %xmm5, %xmm12                         #136.27
..LN1697:
        vpand     -208(%rbp), %xmm0, %xmm13                     #136.132[spill]
..LN1698:
        vpand     -128(%rbp), %xmm9, %xmm11                     #136.59[spill]
..LN1699:
        vpand     -240(%rbp), %xmm13, %xmm9                     #136.443[spill]
..LN1700:
        vpor      -32(%rbp), %xmm12, %xmm12                     #136.27[spill]
..LN1701:
        vpand     -272(%rbp), %xmm9, %xmm3                      #136.197[spill]
..LN1702:
        vpor      %xmm8, %xmm12, %xmm8                          #136.41
..LN1703:
        vpand     -160(%rbp), %xmm10, %xmm4                     #136.81[spill]
..LN1704:
        vpor      %xmm11, %xmm8, %xmm11                         #136.59
..LN1705:
        vpand     -304(%rbp), %xmm3, %xmm1                      #136.449[spill]
..LN1706:
        vpor      %xmm4, %xmm11, %xmm4                          #136.81
..LN1707:
        vpand     -192(%rbp), %xmm0, %xmm7                      #136.107[spill]
..LN1708:
        vpand     -336(%rbp), %xmm1, %xmm14                     #136.274[spill]
..LN1709:
        vpor      %xmm7, %xmm4, %xmm7                           #136.107
..LN1710:
        vpand     -224(%rbp), %xmm13, %xmm2                     #136.135[spill]
..LN1711:
        vpand     -368(%rbp), %xmm14, %xmm15                    #136.455[spill]
..LN1712:
        vpand     -288(%rbp), %xmm3, %xmm0                      #136.200[spill]
..LN1713:
        vpand     -320(%rbp), %xmm1, %xmm10                     #136.237[spill]
..LN1714:
        vpand     -256(%rbp), %xmm9, %xmm13                     #136.166[spill]
..LN1715:
        vpand     -400(%rbp), %xmm15, %xmm3                     #136.363[spill]
..LN1716:
        vpand     -384(%rbp), %xmm15, %xmm1                     #136.320[spill]
..LN1717:
        vpor      %xmm2, %xmm7, %xmm15                          #136.135
..LN1718:
        vpor      %xmm13, %xmm15, %xmm13                        #136.166
..LN1719:
	.loc    1  135  is_stmt 1
        vmovdqu   -448(%rbp), %xmm8                             #135.357[spill]
..LN1720:
	.loc    1  136  is_stmt 1
        vpor      %xmm0, %xmm13, %xmm0                          #136.200
..LN1721:
	.loc    1  135  is_stmt 1
        vmovdqu   -16(%rbp), %xmm12                             #135.357[spill]
..LN1722:
	.loc    1  136  is_stmt 1
        vpor      %xmm10, %xmm0, %xmm10                         #136.237
..LN1723:
	.loc    1  135  is_stmt 1
        vmovdqu   -464(%rbp), %xmm11                            #135.402[spill]
..LN1724:
        vpand     %xmm8, %xmm12, %xmm2                          #135.357
..LN1725:
	.loc    1  136  is_stmt 1
        vpand     -352(%rbp), %xmm14, %xmm14                    #136.277[spill]
..LN1726:
	.loc    1  135  is_stmt 1
        vpor      %xmm2, %xmm6, %xmm2                           #135.357
..LN1727:
        vpand     %xmm11, %xmm12, %xmm6                         #135.402
..LN1728:
	.loc    1  136  is_stmt 1
        vpor      %xmm14, %xmm10, %xmm0                         #136.277
..LN1729:
	.loc    1  135  is_stmt 1
        vmovdqu   -480(%rbp), %xmm12                            #135.405[spill]
..LN1730:
	.loc    1  136  is_stmt 1
        vpor      %xmm1, %xmm0, %xmm1                           #136.320
..LN1731:
        vpand     -432(%rbp), %xmm3, %xmm9                      #136.461[spill]
..LN1732:
	.loc    1  135  is_stmt 1
        vpand     %xmm12, %xmm6, %xmm4                          #135.405
..LN1733:
	.loc    1  136  is_stmt 1
        vpand     -416(%rbp), %xmm3, %xmm3                      #136.366[spill]
..LN1734:
	.loc    1  135  is_stmt 1
        vpor      %xmm4, %xmm2, %xmm6                           #135.405
..LN1735:
	.loc    1  136  is_stmt 1
        vpor      %xmm3, %xmm1, %xmm2                           #136.366
..LN1736:
        vpand     %xmm8, %xmm9, %xmm3                           #136.415
..LN1737:
        vpand     %xmm11, %xmm9, %xmm9                          #136.464
..LN1738:
	.loc    1  152  is_stmt 1
        vpxor     %xmm6, %xmm5, %xmm5                           #152.19
..LN1739:
        vmovdqu   %xmm5, 224(%rdi)                              #152.3
..LN1740:
	.loc    1  136  is_stmt 1
        vpor      %xmm3, %xmm2, %xmm4                           #136.415
..LN1741:
        vpand     %xmm12, %xmm9, %xmm5                          #136.467
..LN1742:
        vpor      %xmm5, %xmm4, %xmm6                           #136.467
..LN1743:
	.loc    1  153  is_stmt 1
        vpxor     -496(%rbp), %xmm6, %xmm0                      #153.19[spill]
..LN1744:
                                # LOE rbx rdi r12 r13 r14 r15 xmm0
..B6.4:                         # Preds ..B6.1
                                # Execution count [1.00e+00]
..LN1745:
        vmovdqu   %xmm0, 240(%rdi)                              #153.3
..LN1746:
	.loc    1  154  epilogue_begin  is_stmt 1
        movq      %rbp, %rsp                                    #154.1
..LN1747:
        popq      %rbp                                          #154.1
	.cfi_restore 6
..LN1748:
        ret                                                     #154.1
        .align    16,0x90
..LN1749:
                                # LOE
..LN1750:
	.cfi_endproc
# mark_end;
	.type	add_lookahead,@function
	.size	add_lookahead,.-add_lookahead
..LNadd_lookahead.1751:
.LNadd_lookahead:
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
	.section .debug_opt_report, ""
..L132:
	.ascii ".itt_notify_tab\0"
	.word	258
	.word	48
	.long	8
	.long	..L133 - ..L132
	.long	48
	.long	..L134 - ..L132
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
..L133:
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
..L134:
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
	.4byte 0x00000f44
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
	.4byte .debug_str+0x42
	.4byte .debug_str+0xae
//	DW_AT_language:
	.byte 0x01
//	DW_AT_use_UTF8:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN0
//	DW_AT_high_pc:
	.8byte ..LNadd_lookahead.1751-..LN0
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
	.4byte .debug_str+0x36f
	.4byte .debug_str+0x36f
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L62
//	DW_AT_high_pc:
	.8byte ..LNadd_pack.1176-..L62
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
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
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3978
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
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00303178
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
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00313178
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
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00323178
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
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00333178
//	DW_AT_location:
	.4byte 0x00c89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00343178
//	DW_AT_location:
	.4byte 0x00d89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00353178
//	DW_AT_location:
	.4byte 0x00e89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00363178
//	DW_AT_location:
	.4byte 0x00f89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3179
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01889103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3279
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01989103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3379
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01a89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3479
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01b89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x10
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3579
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01c89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x10
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3679
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01d89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x10
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3779
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01e89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x10
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3879
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01f89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x11
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3979
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02889103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x11
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00303179
//	DW_AT_location:
	.4byte 0x02989103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x11
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00313179
//	DW_AT_location:
	.4byte 0x02a89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x11
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00323179
//	DW_AT_location:
	.4byte 0x02b89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x12
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00333179
//	DW_AT_location:
	.4byte 0x02c89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x12
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00343179
//	DW_AT_location:
	.4byte 0x02d89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x12
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00353179
//	DW_AT_location:
	.4byte 0x02e89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x12
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00363179
//	DW_AT_location:
	.4byte 0x02f89103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x13
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000f35
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00646461
	.4byte 0x00646461
//	DW_AT_low_pc:
	.8byte ..L115
//	DW_AT_high_pc:
	.8byte ..LNadd.1301-..L115
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x0061
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x0062
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x27
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000f35
//	DW_AT_name:
	.2byte 0x0063
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x28
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x29
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00736572
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x07
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x367
	.4byte .debug_str+0x367
//	DW_AT_low_pc:
	.8byte ..L55
//	DW_AT_high_pc:
	.8byte ..LNadd_bis.1132-..L55
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x0061
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x0062
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x2d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000f35
//	DW_AT_name:
	.2byte 0x0063
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x2e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x2f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00736572
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x34
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x378
	.4byte .debug_str+0x378
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L69
//	DW_AT_high_pc:
	.8byte ..LNadd_bitslice.1289-..L69
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x34
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3178
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x34
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3278
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x34
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3378
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x34
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3478
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x35
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3578
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x35
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3678
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x35
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3778
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x35
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3878
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x36
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3978
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01909103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x36
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00303178
//	DW_AT_location:
	.4byte 0x01a09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x36
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00313178
//	DW_AT_location:
	.4byte 0x01b09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x36
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00323178
//	DW_AT_location:
	.4byte 0x01c09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00333178
//	DW_AT_location:
	.4byte 0x01d09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00343178
//	DW_AT_location:
	.4byte 0x01e09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00353178
//	DW_AT_location:
	.4byte 0x01f09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00363178
//	DW_AT_location:
	.4byte 0x02809103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x38
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3179
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02909103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x38
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3279
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02a09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x38
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3379
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02b09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x38
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3479
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02c09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x39
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3579
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02d09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x39
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3679
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02e09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x39
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3779
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02f09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x39
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3879
	.byte 0x00
//	DW_AT_location:
	.4byte 0x03809103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3979
	.byte 0x00
//	DW_AT_location:
	.4byte 0x03909103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00303179
//	DW_AT_location:
	.4byte 0x03a09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00313179
//	DW_AT_location:
	.4byte 0x03b09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00323179
//	DW_AT_location:
	.4byte 0x03c09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00333179
//	DW_AT_location:
	.4byte 0x03d09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00343179
//	DW_AT_location:
	.4byte 0x03e09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00353179
//	DW_AT_location:
	.4byte 0x03f09103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00363179
//	DW_AT_location:
	.4byte 0x04809103
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000f35
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x3d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0063
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x50
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x385
	.4byte .debug_str+0x385
//	DW_AT_low_pc:
	.8byte ..L122
//	DW_AT_high_pc:
	.8byte ..LNadd_lookahead.1751-..L122
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x50
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3061
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x50
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3161
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x50
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3261
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x50
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3361
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x51
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3461
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x51
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3561
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x51
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3661
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x51
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3761
	.byte 0x00
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x52
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3861
	.byte 0x00
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x10
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x52
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3961
	.byte 0x00
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x20
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x52
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00303161
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x30
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x52
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00313161
//	DW_AT_location:
	.4byte 0x00c07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x53
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00323161
//	DW_AT_location:
	.4byte 0x00d07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x53
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00333161
//	DW_AT_location:
	.4byte 0x00e07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x53
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00343161
//	DW_AT_location:
	.4byte 0x00f07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x53
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00353161
//	DW_AT_location:
	.4byte 0x01807603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3062
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01907603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3162
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01a07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3262
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01b07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3362
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01c07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x55
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3462
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01d07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x55
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3562
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01e07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x55
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3662
	.byte 0x00
//	DW_AT_location:
	.4byte 0x01f07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x55
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3762
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02807603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x56
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3862
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02907603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x56
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.2byte 0x3962
	.byte 0x00
//	DW_AT_location:
	.4byte 0x02a07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x56
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00303162
//	DW_AT_location:
	.4byte 0x02b07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x56
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00313162
//	DW_AT_location:
	.4byte 0x02c07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00323162
//	DW_AT_location:
	.4byte 0x02d07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00333162
//	DW_AT_location:
	.4byte 0x02e07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00343162
//	DW_AT_location:
	.4byte 0x02f07603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_name:
	.4byte 0x00353162
//	DW_AT_location:
	.4byte 0x03807603
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x58
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000f35
//	DW_AT_name:
	.4byte 0x0074756f
//	DW_AT_location:
	.2byte 0x5501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x59
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3070
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6b01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3170
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6e01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3270
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6901
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3370
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x9002
	.byte 0x20
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3470
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6c01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3570
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6401
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x5f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3670
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6201
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x60
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3770
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x61
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3870
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x62
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3970
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x63
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00303170
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x64
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00313170
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x65
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00323170
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x66
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00333170
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x67
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00343170
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x68
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00353170
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3067
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6f01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3167
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6d01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3267
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6b01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3367
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6a01
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3467
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6301
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x6f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3567
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6601
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x70
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3667
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6101
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x71
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3767
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6801
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x72
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3867
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x73
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3967
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x74
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00303167
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x75
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00313167
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x76
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00323167
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x77
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00333167
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6501
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00343167
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x7a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3063
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x7b
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3163
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x7c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3263
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x7d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3363
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x7e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3463
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x7f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3563
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x80
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3663
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x81
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3763
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x82
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3863
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x83
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3963
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x84
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00303163
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x85
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00313163
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x86
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00323163
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x87
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00333163
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x88
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00343163
//	DW_AT_type:
	.4byte 0x00000ba5
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x9c
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_name:
	.4byte .debug_str+0x117
	.4byte .debug_str+0x117
//	DW_AT_frame_base:
	.2byte 0x7702
	.byte 0x00
//	DW_AT_low_pc:
	.8byte ..L3
//	DW_AT_high_pc:
	.8byte ..LNmain.1120-..L3
	.byte 0x01
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0x9e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1de
//	DW_AT_type:
	.4byte 0x00000cdc
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x9e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00646e65
//	DW_AT_type:
	.4byte 0x00000cdc
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x9f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0066
//	DW_AT_type:
	.4byte 0x00000ce7
//	DW_AT_location:
	.2byte 0x5301
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3178
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3278
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3378
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3478
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3578
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3678
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3778
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3878
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3978
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00303178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00313178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00323178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00333178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00343178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00353178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00363178
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3179
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3279
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3379
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3479
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3579
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3679
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3779
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3879
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x3979
	.byte 0x00
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00303179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00313179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00323179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00333179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00343179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00353179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x6701
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00363179
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_variable:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0xa4
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x35b
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_variable:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0xa6
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x360
//	DW_AT_type:
	.4byte 0x00000f35
//	DW_AT_location:
	.2byte 0x5c01
//	DW_TAG_lexical_block:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xca
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN737
//	DW_AT_high_pc:
	.8byte ..LN763
//	DW_TAG_variable:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0xca
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_lexical_block:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xca
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN746
//	DW_AT_high_pc:
	.8byte ..LN753
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xcb
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00706d74
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_AT_location:
	.2byte 0x9102
	.byte 0x00
	.byte 0x00
	.byte 0x00
//	DW_TAG_lexical_block:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xd2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN771
//	DW_AT_high_pc:
	.8byte ..LN878
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xd2
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5f01
//	DW_TAG_lexical_block:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xd4
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN780
//	DW_AT_high_pc:
	.8byte ..LN867
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xd4
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
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xdf
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN886
//	DW_AT_high_pc:
	.8byte ..LN993
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xdf
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5d01
//	DW_TAG_lexical_block:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xe1
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN895
//	DW_AT_high_pc:
	.8byte ..LN982
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xe1
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
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xec
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN1001
//	DW_AT_high_pc:
	.8byte ..LN1108
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xec
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_location:
	.2byte 0x5d01
//	DW_TAG_lexical_block:
	.byte 0x0d
//	DW_AT_decl_line:
	.byte 0xee
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN1010
//	DW_AT_high_pc:
	.8byte ..LN1097
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0xee
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
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000b8d
//	DW_TAG_const_type:
	.byte 0x0f
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x01
//	DW_AT_encoding:
	.byte 0x06
//	DW_AT_name:
	.4byte .debug_str+0x11c
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x121
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000ba5
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x4a
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_name:
	.4byte .debug_str+0x12e
//	DW_AT_type:
	.4byte 0x00000bb0
//	DW_TAG_union_type:
	.byte 0x12
//	DW_AT_decl_line:
	.byte 0x30
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x12e
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x36
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x136
//	DW_AT_type:
	.4byte 0x00000c43
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x3c
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x153
//	DW_AT_type:
	.4byte 0x00000c53
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x3d
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x15c
//	DW_AT_type:
	.4byte 0x00000c5c
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x3e
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x16c
//	DW_AT_type:
	.4byte 0x00000c6c
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x3f
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x176
//	DW_AT_type:
	.4byte 0x00000c75
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x40
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x180
//	DW_AT_type:
	.4byte 0x00000c7e
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x41
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x197
//	DW_AT_type:
	.4byte 0x00000c8e
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x42
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1b0
//	DW_AT_type:
	.4byte 0x00000c9e
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x43
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1ba
//	DW_AT_type:
	.4byte 0x00000ca7
//	DW_TAG_member:
	.byte 0x14
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
	.4byte 0x00000cb7
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000c4c
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x01
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x14e
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000c65
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x07
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x02
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x166
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000033
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x03
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000c4c
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x01
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000c87
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x01
//	DW_AT_encoding:
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x189
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000c97
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x07
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x02
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x1a1
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000b99
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x03
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000cb0
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x01
	.byte 0x00
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x1c4
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_AT_byte_size:
	.byte 0x10
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000cc5
//	DW_TAG_const_type:
	.byte 0x0f
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_TAG_base_type:
	.byte 0x10
//	DW_AT_byte_size:
	.byte 0x00
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x1d2
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x2c
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_name:
	.4byte .debug_str+0x1d7
//	DW_AT_type:
	.4byte 0x00000cb0
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x37
//	DW_AT_decl_file:
	.byte 0x04
//	DW_AT_name:
	.4byte .debug_str+0x1e4
//	DW_AT_type:
	.4byte 0x00000cb0
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000cec
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x30
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x1ed
//	DW_AT_type:
	.4byte 0x00000cf7
//	DW_TAG_structure_type:
	.byte 0x17
//	DW_AT_decl_line:
	.byte 0xf1
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_byte_size:
	.byte 0xd8
//	DW_AT_name:
	.4byte .debug_str+0x1f2
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xf2
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1fb
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xf7
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x202
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xf8
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x20f
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xf9
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x18
//	DW_AT_name:
	.4byte .debug_str+0x21c
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xfa
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x20
//	DW_AT_name:
	.4byte .debug_str+0x22a
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xfb
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x28
//	DW_AT_name:
	.4byte .debug_str+0x239
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xfc
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x30
//	DW_AT_name:
	.4byte .debug_str+0x247
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xfd
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x38
//	DW_AT_name:
	.4byte .debug_str+0x255
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xfe
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x40
//	DW_AT_name:
	.4byte .debug_str+0x262
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0100
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x48
//	DW_AT_name:
	.4byte .debug_str+0x26e
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0101
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x50
//	DW_AT_name:
	.4byte .debug_str+0x27c
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0102
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x58
//	DW_AT_name:
	.4byte .debug_str+0x28c
//	DW_AT_type:
	.4byte 0x00000eb6
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0104
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x60
//	DW_AT_name:
	.4byte .debug_str+0x299
//	DW_AT_type:
	.4byte 0x00000ebb
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0106
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x68
//	DW_AT_name:
	.4byte .debug_str+0x2be
//	DW_AT_type:
	.4byte 0x00000ef3
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0108
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x70
//	DW_AT_name:
	.4byte .debug_str+0x2c5
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x010c
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x74
//	DW_AT_name:
	.4byte .debug_str+0x2cd
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x010e
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x78
//	DW_AT_name:
	.4byte .debug_str+0x2d5
//	DW_AT_type:
	.4byte 0x00000ef8
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0112
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01802303
//	DW_AT_name:
	.4byte .debug_str+0x2e9
//	DW_AT_type:
	.4byte 0x00000c97
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0113
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01822303
//	DW_AT_name:
	.4byte .debug_str+0x2f5
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0114
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01832303
//	DW_AT_name:
	.4byte .debug_str+0x304
//	DW_AT_type:
	.4byte 0x00000f03
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0118
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01882303
//	DW_AT_name:
	.4byte .debug_str+0x30e
//	DW_AT_type:
	.4byte 0x00000f0c
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0121
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01902303
//	DW_AT_name:
	.4byte .debug_str+0x2d9
//	DW_AT_type:
	.4byte 0x00000f1c
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0129
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01982303
//	DW_AT_name:
	.4byte .debug_str+0x329
//	DW_AT_type:
	.4byte 0x00000f27
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x012a
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01a02303
//	DW_AT_name:
	.4byte .debug_str+0x330
//	DW_AT_type:
	.4byte 0x00000f27
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x012b
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01a82303
//	DW_AT_name:
	.4byte .debug_str+0x337
//	DW_AT_type:
	.4byte 0x00000f27
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x012c
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01b02303
//	DW_AT_name:
	.4byte .debug_str+0x33e
//	DW_AT_type:
	.4byte 0x00000f27
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x012e
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01b82303
//	DW_AT_name:
	.4byte .debug_str+0x345
//	DW_AT_type:
	.4byte 0x00000cd1
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x012f
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01c02303
//	DW_AT_name:
	.4byte .debug_str+0x34c
//	DW_AT_type:
	.4byte 0x00000033
//	DW_TAG_member:
	.byte 0x18
//	DW_AT_decl_line:
	.2byte 0x0131
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.4byte 0x01c42303
//	DW_AT_name:
	.4byte .debug_str+0x352
//	DW_AT_type:
	.4byte 0x00000f2c
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000ec0
//	DW_TAG_structure_type:
	.byte 0x17
//	DW_AT_decl_line:
	.byte 0x9c
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_byte_size:
	.byte 0x18
//	DW_AT_name:
	.4byte .debug_str+0x2a2
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x9d
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x2ad
//	DW_AT_type:
	.4byte 0x00000ebb
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x9e
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x2b3
//	DW_AT_type:
	.4byte 0x00000ef3
//	DW_TAG_member:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0xa2
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x2b9
//	DW_AT_type:
	.4byte 0x00000033
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000cf7
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x83
//	DW_AT_decl_file:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x2e1
//	DW_AT_type:
	.4byte 0x00000c4c
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_AT_byte_size:
	.byte 0x01
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x00
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000f11
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x96
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_name:
	.4byte .debug_str+0x314
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_TAG_typedef:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x84
//	DW_AT_decl_file:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0x31f
//	DW_AT_type:
	.4byte 0x00000c4c
//	DW_TAG_pointer_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x00000cca
//	DW_TAG_array_type:
	.byte 0x15
//	DW_AT_type:
	.4byte 0x00000b92
//	DW_AT_byte_size:
	.byte 0x14
//	DW_TAG_subrange_type:
	.byte 0x16
//	DW_AT_upper_bound:
	.byte 0x13
	.byte 0x00
//	DW_TAG_restrict_type:
	.byte 0x19
//	DW_AT_type:
	.4byte 0x00000ba0
//	DW_TAG_variable:
	.byte 0x1a
//	DW_AT_decl_line:
	.byte 0xa9
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0x393
//	DW_AT_type:
	.4byte 0x00000ef3
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
	.byte 0x08
	.2byte 0x4087
	.byte 0x08
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
	.byte 0x08
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
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x07
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x09
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
	.byte 0x0e
	.byte 0x0f
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0f
	.byte 0x26
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x10
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x11
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
	.byte 0x12
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
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x14
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
	.byte 0x15
	.byte 0x01
	.byte 0x01
	.byte 0x49
	.byte 0x13
	.byte 0x0b
	.byte 0x0b
	.2byte 0x0000
	.byte 0x16
	.byte 0x21
	.byte 0x00
	.byte 0x2f
	.byte 0x0b
	.2byte 0x0000
	.byte 0x17
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
	.byte 0x18
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
	.byte 0x19
	.byte 0x37
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x1a
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
	.8byte 0x632e36315f646461
	.byte 0x00
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
