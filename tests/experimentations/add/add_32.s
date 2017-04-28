# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 17.0.2.174 Build 20170213";
# mark_description "-Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -i";
# mark_description "nline-max-total-size=10000 -O3 -funroll-loops -unroll-agressive -S -o add_32.s";
	.file "add_32.c"
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
                                                          #135.13
        pushq     %rbp                                          #135.13
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #135.13
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-128, %rsp                                   #135.13
        pushq     %r12                                          #135.13
        pushq     %r13                                          #135.13
        pushq     %r14                                          #135.13
        pushq     %r15                                          #135.13
        pushq     %rbx                                          #135.13
        subq      $3160, %rsp                                   #135.13
        movl      $10330110, %esi                               #135.13
        movl      $3, %edi                                      #135.13
        call      __intel_new_feature_proc_init                 #135.13
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.314:                       # Preds ..B1.1
                                # Execution count [1.00e+00]
        vstmxcsr  (%rsp)                                        #135.13
        movl      $.L_2__STRING.0, %edi                         #138.13
        movl      $.L_2__STRING.1, %esi                         #138.13
        orl       $32832, (%rsp)                                #135.13
        vldmxcsr  (%rsp)                                        #135.13
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #138.13
                                # LOE rax
..B1.313:                       # Preds ..B1.314
                                # Execution count [1.00e+00]
        movq      %rax, %r14                                    #138.13
                                # LOE r14
..B1.2:                         # Preds ..B1.313
                                # Execution count [1.00e+00]
        xorl      %edi, %edi                                    #148.9
#       time(time_t *)
        call      time                                          #148.9
                                # LOE rax r14
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movl      %eax, %edi                                    #148.3
#       srand(unsigned int)
        call      srand                                         #148.3
                                # LOE r14
..B1.4:                         # Preds ..B1.3
                                # Execution count [1.00e+00]
        movl      $32, %edi                                     #149.30
        movl      $512000000, %esi                              #149.30
..___tag_value_main.11:
#       aligned_alloc(size_t, size_t)
        call      aligned_alloc                                 #149.30
..___tag_value_main.12:
                                # LOE rax r14
..B1.316:                       # Preds ..B1.4
                                # Execution count [1.00e+00]
        movq      %rax, %r13                                    #149.30
                                # LOE r13 r14
..B1.5:                         # Preds ..B1.316
                                # Execution count [1.00e+00]
        movq      %r13, 8(%rsp)                                 #151.14[spill]
        xorb      %r12b, %r12b                                  #151.14
        movq      %r14, (%rsp)                                  #151.14[spill]
        xorl      %ebx, %ebx                                    #151.14
                                # LOE rbx r12b
..B1.6:                         # Preds ..B1.14 ..B1.5
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #152.26
                                # LOE rbx eax r12b
..B1.317:                       # Preds ..B1.6
                                # Execution count [3.20e+01]
        movl      %eax, %r13d                                   #152.26
                                # LOE rbx r13d r12b
..B1.7:                         # Preds ..B1.317
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #152.33
                                # LOE rbx eax r13d r12b
..B1.318:                       # Preds ..B1.7
                                # Execution count [3.20e+01]
        movl      %eax, %r14d                                   #152.33
                                # LOE rbx r13d r14d r12b
..B1.8:                         # Preds ..B1.318
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #152.40
                                # LOE rbx eax r13d r14d r12b
..B1.319:                       # Preds ..B1.8
                                # Execution count [3.20e+01]
        movl      %eax, %r15d                                   #152.40
                                # LOE rbx r13d r14d r15d r12b
..B1.9:                         # Preds ..B1.319
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #152.47
                                # LOE rbx eax r13d r14d r15d r12b
..B1.10:                        # Preds ..B1.9
                                # Execution count [3.20e+01]
        vmovd     %eax, %xmm0                                   #152.12
        vmovd     %r15d, %xmm1                                  #152.12
        vmovd     %r14d, %xmm2                                  #152.12
        vmovd     %r13d, %xmm3                                  #152.12
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #152.12
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #152.12
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #152.12
        vmovups   %xmm6, 2112(%rsp,%rbx)                        #152.5
#       rand(void)
        call      rand                                          #153.26
                                # LOE rbx eax r12b
..B1.321:                       # Preds ..B1.10
                                # Execution count [3.20e+01]
        movl      %eax, %r13d                                   #153.26
                                # LOE rbx r13d r12b
..B1.11:                        # Preds ..B1.321
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #153.33
                                # LOE rbx eax r13d r12b
..B1.322:                       # Preds ..B1.11
                                # Execution count [3.20e+01]
        movl      %eax, %r14d                                   #153.33
                                # LOE rbx r13d r14d r12b
..B1.12:                        # Preds ..B1.322
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #153.40
                                # LOE rbx eax r13d r14d r12b
..B1.323:                       # Preds ..B1.12
                                # Execution count [3.20e+01]
        movl      %eax, %r15d                                   #153.40
                                # LOE rbx r13d r14d r15d r12b
..B1.13:                        # Preds ..B1.323
                                # Execution count [3.20e+01]
#       rand(void)
        call      rand                                          #153.47
                                # LOE rbx eax r13d r14d r15d r12b
..B1.14:                        # Preds ..B1.13
                                # Execution count [3.20e+01]
        vmovd     %eax, %xmm0                                   #153.12
        vmovd     %r15d, %xmm1                                  #153.12
        vmovd     %r14d, %xmm2                                  #153.12
        vmovd     %r13d, %xmm3                                  #153.12
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #153.12
        incb      %r12b                                         #151.27
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #153.12
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #153.12
        vmovups   %xmm6, 2624(%rsp,%rbx)                        #153.5
        addq      $16, %rbx                                     #151.27
        cmpb      $32, %r12b                                    #151.23
        jl        ..B1.6        # Prob 96%                      #151.23
                                # LOE rbx r12b
..B1.15:                        # Preds ..B1.14
                                # Execution count [1.00e+00]
        movq      8(%rsp), %r13                                 #[spill]
        movq      (%rsp), %r14                                  #[spill]
#       rand(void)
        call      rand                                          #156.22
                                # LOE r13 r14 eax
..B1.325:                       # Preds ..B1.15
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #156.22
                                # LOE r13 r14 r12d
..B1.16:                        # Preds ..B1.325
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #156.29
                                # LOE r13 r14 eax r12d
..B1.326:                       # Preds ..B1.16
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #156.29
                                # LOE r13 r14 ebx r12d
..B1.17:                        # Preds ..B1.326
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #156.36
                                # LOE r13 r14 eax ebx r12d
..B1.327:                       # Preds ..B1.17
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #156.36
                                # LOE r13 r14 ebx r12d r15d
..B1.18:                        # Preds ..B1.327
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #156.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.19:                        # Preds ..B1.18
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #156.8
        vmovd     %r15d, %xmm1                                  #156.8
        vmovd     %ebx, %xmm2                                   #156.8
        vmovd     %r12d, %xmm3                                  #156.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #156.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #156.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #156.8
        vmovups   %xmm6, 1824(%rsp)                             #156.8[spill]
#       rand(void)
        call      rand                                          #157.22
                                # LOE r13 r14 eax
..B1.329:                       # Preds ..B1.19
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #157.22
                                # LOE r13 r14 r12d
..B1.20:                        # Preds ..B1.329
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #157.29
                                # LOE r13 r14 eax r12d
..B1.330:                       # Preds ..B1.20
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #157.29
                                # LOE r13 r14 ebx r12d
..B1.21:                        # Preds ..B1.330
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #157.36
                                # LOE r13 r14 eax ebx r12d
..B1.331:                       # Preds ..B1.21
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #157.36
                                # LOE r13 r14 ebx r12d r15d
..B1.22:                        # Preds ..B1.331
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #157.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #157.8
        vmovd     %r15d, %xmm1                                  #157.8
        vmovd     %ebx, %xmm2                                   #157.8
        vmovd     %r12d, %xmm3                                  #157.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #157.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #157.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #157.8
        vmovups   %xmm6, 1808(%rsp)                             #157.8[spill]
#       rand(void)
        call      rand                                          #158.22
                                # LOE r13 r14 eax
..B1.333:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #158.22
                                # LOE r13 r14 r12d
..B1.24:                        # Preds ..B1.333
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #158.29
                                # LOE r13 r14 eax r12d
..B1.334:                       # Preds ..B1.24
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #158.29
                                # LOE r13 r14 ebx r12d
..B1.25:                        # Preds ..B1.334
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #158.36
                                # LOE r13 r14 eax ebx r12d
..B1.335:                       # Preds ..B1.25
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #158.36
                                # LOE r13 r14 ebx r12d r15d
..B1.26:                        # Preds ..B1.335
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #158.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.27:                        # Preds ..B1.26
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #158.8
        vmovd     %r15d, %xmm1                                  #158.8
        vmovd     %ebx, %xmm2                                   #158.8
        vmovd     %r12d, %xmm3                                  #158.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #158.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #158.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #158.8
        vmovups   %xmm6, 1776(%rsp)                             #158.8[spill]
#       rand(void)
        call      rand                                          #159.22
                                # LOE r13 r14 eax
..B1.337:                       # Preds ..B1.27
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #159.22
                                # LOE r13 r14 r12d
..B1.28:                        # Preds ..B1.337
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #159.29
                                # LOE r13 r14 eax r12d
..B1.338:                       # Preds ..B1.28
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #159.29
                                # LOE r13 r14 ebx r12d
..B1.29:                        # Preds ..B1.338
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #159.36
                                # LOE r13 r14 eax ebx r12d
..B1.339:                       # Preds ..B1.29
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #159.36
                                # LOE r13 r14 ebx r12d r15d
..B1.30:                        # Preds ..B1.339
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #159.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #159.8
        vmovd     %r15d, %xmm1                                  #159.8
        vmovd     %ebx, %xmm2                                   #159.8
        vmovd     %r12d, %xmm3                                  #159.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #159.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #159.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #159.8
        vmovups   %xmm6, 1760(%rsp)                             #159.8[spill]
#       rand(void)
        call      rand                                          #160.22
                                # LOE r13 r14 eax
..B1.341:                       # Preds ..B1.31
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #160.22
                                # LOE r13 r14 r12d
..B1.32:                        # Preds ..B1.341
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #160.29
                                # LOE r13 r14 eax r12d
..B1.342:                       # Preds ..B1.32
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #160.29
                                # LOE r13 r14 ebx r12d
..B1.33:                        # Preds ..B1.342
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #160.36
                                # LOE r13 r14 eax ebx r12d
..B1.343:                       # Preds ..B1.33
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #160.36
                                # LOE r13 r14 ebx r12d r15d
..B1.34:                        # Preds ..B1.343
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #160.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.35:                        # Preds ..B1.34
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #160.8
        vmovd     %r15d, %xmm1                                  #160.8
        vmovd     %ebx, %xmm2                                   #160.8
        vmovd     %r12d, %xmm3                                  #160.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #160.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #160.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #160.8
        vmovups   %xmm6, 1744(%rsp)                             #160.8[spill]
#       rand(void)
        call      rand                                          #161.22
                                # LOE r13 r14 eax
..B1.345:                       # Preds ..B1.35
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #161.22
                                # LOE r13 r14 r12d
..B1.36:                        # Preds ..B1.345
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #161.29
                                # LOE r13 r14 eax r12d
..B1.346:                       # Preds ..B1.36
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #161.29
                                # LOE r13 r14 ebx r12d
..B1.37:                        # Preds ..B1.346
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #161.36
                                # LOE r13 r14 eax ebx r12d
..B1.347:                       # Preds ..B1.37
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #161.36
                                # LOE r13 r14 ebx r12d r15d
..B1.38:                        # Preds ..B1.347
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #161.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.39:                        # Preds ..B1.38
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #161.8
        vmovd     %r15d, %xmm1                                  #161.8
        vmovd     %ebx, %xmm2                                   #161.8
        vmovd     %r12d, %xmm3                                  #161.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #161.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #161.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #161.8
        vmovups   %xmm6, 1728(%rsp)                             #161.8[spill]
#       rand(void)
        call      rand                                          #162.22
                                # LOE r13 r14 eax
..B1.349:                       # Preds ..B1.39
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #162.22
                                # LOE r13 r14 r12d
..B1.40:                        # Preds ..B1.349
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.29
                                # LOE r13 r14 eax r12d
..B1.350:                       # Preds ..B1.40
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #162.29
                                # LOE r13 r14 ebx r12d
..B1.41:                        # Preds ..B1.350
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.36
                                # LOE r13 r14 eax ebx r12d
..B1.351:                       # Preds ..B1.41
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #162.36
                                # LOE r13 r14 ebx r12d r15d
..B1.42:                        # Preds ..B1.351
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #162.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.43:                        # Preds ..B1.42
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #162.8
        vmovd     %r15d, %xmm1                                  #162.8
        vmovd     %ebx, %xmm2                                   #162.8
        vmovd     %r12d, %xmm3                                  #162.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #162.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #162.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #162.8
        vmovups   %xmm6, 1712(%rsp)                             #162.8[spill]
#       rand(void)
        call      rand                                          #163.22
                                # LOE r13 r14 eax
..B1.353:                       # Preds ..B1.43
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #163.22
                                # LOE r13 r14 r12d
..B1.44:                        # Preds ..B1.353
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #163.29
                                # LOE r13 r14 eax r12d
..B1.354:                       # Preds ..B1.44
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #163.29
                                # LOE r13 r14 ebx r12d
..B1.45:                        # Preds ..B1.354
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #163.36
                                # LOE r13 r14 eax ebx r12d
..B1.355:                       # Preds ..B1.45
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #163.36
                                # LOE r13 r14 ebx r12d r15d
..B1.46:                        # Preds ..B1.355
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #163.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.47:                        # Preds ..B1.46
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #163.8
        vmovd     %r15d, %xmm1                                  #163.8
        vmovd     %ebx, %xmm2                                   #163.8
        vmovd     %r12d, %xmm3                                  #163.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #163.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #163.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #163.8
        vmovups   %xmm6, 1696(%rsp)                             #163.8[spill]
#       rand(void)
        call      rand                                          #164.22
                                # LOE r13 r14 eax
..B1.357:                       # Preds ..B1.47
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #164.22
                                # LOE r13 r14 r12d
..B1.48:                        # Preds ..B1.357
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #164.29
                                # LOE r13 r14 eax r12d
..B1.358:                       # Preds ..B1.48
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #164.29
                                # LOE r13 r14 ebx r12d
..B1.49:                        # Preds ..B1.358
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #164.36
                                # LOE r13 r14 eax ebx r12d
..B1.359:                       # Preds ..B1.49
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #164.36
                                # LOE r13 r14 ebx r12d r15d
..B1.50:                        # Preds ..B1.359
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #164.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.51:                        # Preds ..B1.50
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #164.8
        vmovd     %r15d, %xmm1                                  #164.8
        vmovd     %ebx, %xmm2                                   #164.8
        vmovd     %r12d, %xmm3                                  #164.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #164.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #164.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #164.8
        vmovups   %xmm6, 1680(%rsp)                             #164.8[spill]
#       rand(void)
        call      rand                                          #165.23
                                # LOE r13 r14 eax
..B1.361:                       # Preds ..B1.51
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #165.23
                                # LOE r13 r14 r12d
..B1.52:                        # Preds ..B1.361
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #165.30
                                # LOE r13 r14 eax r12d
..B1.362:                       # Preds ..B1.52
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #165.30
                                # LOE r13 r14 ebx r12d
..B1.53:                        # Preds ..B1.362
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #165.37
                                # LOE r13 r14 eax ebx r12d
..B1.363:                       # Preds ..B1.53
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #165.37
                                # LOE r13 r14 ebx r12d r15d
..B1.54:                        # Preds ..B1.363
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #165.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.55:                        # Preds ..B1.54
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #165.9
        vmovd     %r15d, %xmm1                                  #165.9
        vmovd     %ebx, %xmm2                                   #165.9
        vmovd     %r12d, %xmm3                                  #165.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #165.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #165.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #165.9
        vmovups   %xmm6, 1664(%rsp)                             #165.9[spill]
#       rand(void)
        call      rand                                          #166.23
                                # LOE r13 r14 eax
..B1.365:                       # Preds ..B1.55
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #166.23
                                # LOE r13 r14 r12d
..B1.56:                        # Preds ..B1.365
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #166.30
                                # LOE r13 r14 eax r12d
..B1.366:                       # Preds ..B1.56
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #166.30
                                # LOE r13 r14 ebx r12d
..B1.57:                        # Preds ..B1.366
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #166.37
                                # LOE r13 r14 eax ebx r12d
..B1.367:                       # Preds ..B1.57
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #166.37
                                # LOE r13 r14 ebx r12d r15d
..B1.58:                        # Preds ..B1.367
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #166.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.59:                        # Preds ..B1.58
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #166.9
        vmovd     %r15d, %xmm1                                  #166.9
        vmovd     %ebx, %xmm2                                   #166.9
        vmovd     %r12d, %xmm3                                  #166.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #166.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #166.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #166.9
        vmovups   %xmm6, 1648(%rsp)                             #166.9[spill]
#       rand(void)
        call      rand                                          #167.23
                                # LOE r13 r14 eax
..B1.369:                       # Preds ..B1.59
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #167.23
                                # LOE r13 r14 r12d
..B1.60:                        # Preds ..B1.369
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #167.30
                                # LOE r13 r14 eax r12d
..B1.370:                       # Preds ..B1.60
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #167.30
                                # LOE r13 r14 ebx r12d
..B1.61:                        # Preds ..B1.370
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #167.37
                                # LOE r13 r14 eax ebx r12d
..B1.371:                       # Preds ..B1.61
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #167.37
                                # LOE r13 r14 ebx r12d r15d
..B1.62:                        # Preds ..B1.371
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #167.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.63:                        # Preds ..B1.62
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #167.9
        vmovd     %r15d, %xmm1                                  #167.9
        vmovd     %ebx, %xmm2                                   #167.9
        vmovd     %r12d, %xmm3                                  #167.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #167.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #167.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #167.9
        vmovups   %xmm6, 1632(%rsp)                             #167.9[spill]
#       rand(void)
        call      rand                                          #168.23
                                # LOE r13 r14 eax
..B1.373:                       # Preds ..B1.63
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #168.23
                                # LOE r13 r14 r12d
..B1.64:                        # Preds ..B1.373
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #168.30
                                # LOE r13 r14 eax r12d
..B1.374:                       # Preds ..B1.64
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #168.30
                                # LOE r13 r14 ebx r12d
..B1.65:                        # Preds ..B1.374
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #168.37
                                # LOE r13 r14 eax ebx r12d
..B1.375:                       # Preds ..B1.65
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #168.37
                                # LOE r13 r14 ebx r12d r15d
..B1.66:                        # Preds ..B1.375
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #168.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.67:                        # Preds ..B1.66
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #168.9
        vmovd     %r15d, %xmm1                                  #168.9
        vmovd     %ebx, %xmm2                                   #168.9
        vmovd     %r12d, %xmm3                                  #168.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #168.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #168.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #168.9
        vmovups   %xmm6, 1216(%rsp)                             #168.9[spill]
#       rand(void)
        call      rand                                          #169.23
                                # LOE r13 r14 eax
..B1.377:                       # Preds ..B1.67
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #169.23
                                # LOE r13 r14 r12d
..B1.68:                        # Preds ..B1.377
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #169.30
                                # LOE r13 r14 eax r12d
..B1.378:                       # Preds ..B1.68
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #169.30
                                # LOE r13 r14 ebx r12d
..B1.69:                        # Preds ..B1.378
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #169.37
                                # LOE r13 r14 eax ebx r12d
..B1.379:                       # Preds ..B1.69
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #169.37
                                # LOE r13 r14 ebx r12d r15d
..B1.70:                        # Preds ..B1.379
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #169.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.71:                        # Preds ..B1.70
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #169.9
        vmovd     %r15d, %xmm1                                  #169.9
        vmovd     %ebx, %xmm2                                   #169.9
        vmovd     %r12d, %xmm3                                  #169.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #169.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #169.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #169.9
        vmovups   %xmm6, 832(%rsp)                              #169.9[spill]
#       rand(void)
        call      rand                                          #170.23
                                # LOE r13 r14 eax
..B1.381:                       # Preds ..B1.71
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #170.23
                                # LOE r13 r14 r12d
..B1.72:                        # Preds ..B1.381
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #170.30
                                # LOE r13 r14 eax r12d
..B1.382:                       # Preds ..B1.72
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #170.30
                                # LOE r13 r14 ebx r12d
..B1.73:                        # Preds ..B1.382
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #170.37
                                # LOE r13 r14 eax ebx r12d
..B1.383:                       # Preds ..B1.73
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #170.37
                                # LOE r13 r14 ebx r12d r15d
..B1.74:                        # Preds ..B1.383
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #170.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.75:                        # Preds ..B1.74
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #170.9
        vmovd     %r15d, %xmm1                                  #170.9
        vmovd     %ebx, %xmm2                                   #170.9
        vmovd     %r12d, %xmm3                                  #170.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #170.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #170.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #170.9
        vmovups   %xmm6, 848(%rsp)                              #170.9[spill]
#       rand(void)
        call      rand                                          #171.23
                                # LOE r13 r14 eax
..B1.385:                       # Preds ..B1.75
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #171.23
                                # LOE r13 r14 r12d
..B1.76:                        # Preds ..B1.385
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #171.30
                                # LOE r13 r14 eax r12d
..B1.386:                       # Preds ..B1.76
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #171.30
                                # LOE r13 r14 ebx r12d
..B1.77:                        # Preds ..B1.386
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #171.37
                                # LOE r13 r14 eax ebx r12d
..B1.387:                       # Preds ..B1.77
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #171.37
                                # LOE r13 r14 ebx r12d r15d
..B1.78:                        # Preds ..B1.387
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #171.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.79:                        # Preds ..B1.78
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #171.9
        vmovd     %r15d, %xmm1                                  #171.9
        vmovd     %ebx, %xmm2                                   #171.9
        vmovd     %r12d, %xmm3                                  #171.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #171.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #171.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #171.9
        vmovups   %xmm6, 864(%rsp)                              #171.9[spill]
#       rand(void)
        call      rand                                          #172.23
                                # LOE r13 r14 eax
..B1.389:                       # Preds ..B1.79
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #172.23
                                # LOE r13 r14 r12d
..B1.80:                        # Preds ..B1.389
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #172.30
                                # LOE r13 r14 eax r12d
..B1.390:                       # Preds ..B1.80
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #172.30
                                # LOE r13 r14 ebx r12d
..B1.81:                        # Preds ..B1.390
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #172.37
                                # LOE r13 r14 eax ebx r12d
..B1.391:                       # Preds ..B1.81
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #172.37
                                # LOE r13 r14 ebx r12d r15d
..B1.82:                        # Preds ..B1.391
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #172.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.83:                        # Preds ..B1.82
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #172.9
        vmovd     %r15d, %xmm1                                  #172.9
        vmovd     %ebx, %xmm2                                   #172.9
        vmovd     %r12d, %xmm3                                  #172.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #172.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #172.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #172.9
        vmovups   %xmm6, 880(%rsp)                              #172.9[spill]
#       rand(void)
        call      rand                                          #173.23
                                # LOE r13 r14 eax
..B1.393:                       # Preds ..B1.83
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #173.23
                                # LOE r13 r14 r12d
..B1.84:                        # Preds ..B1.393
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #173.30
                                # LOE r13 r14 eax r12d
..B1.394:                       # Preds ..B1.84
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #173.30
                                # LOE r13 r14 ebx r12d
..B1.85:                        # Preds ..B1.394
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #173.37
                                # LOE r13 r14 eax ebx r12d
..B1.395:                       # Preds ..B1.85
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #173.37
                                # LOE r13 r14 ebx r12d r15d
..B1.86:                        # Preds ..B1.395
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #173.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.87:                        # Preds ..B1.86
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #173.9
        vmovd     %r15d, %xmm1                                  #173.9
        vmovd     %ebx, %xmm2                                   #173.9
        vmovd     %r12d, %xmm3                                  #173.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #173.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #173.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #173.9
        vmovups   %xmm6, 896(%rsp)                              #173.9[spill]
#       rand(void)
        call      rand                                          #174.23
                                # LOE r13 r14 eax
..B1.397:                       # Preds ..B1.87
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #174.23
                                # LOE r13 r14 r12d
..B1.88:                        # Preds ..B1.397
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #174.30
                                # LOE r13 r14 eax r12d
..B1.398:                       # Preds ..B1.88
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #174.30
                                # LOE r13 r14 ebx r12d
..B1.89:                        # Preds ..B1.398
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #174.37
                                # LOE r13 r14 eax ebx r12d
..B1.399:                       # Preds ..B1.89
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #174.37
                                # LOE r13 r14 ebx r12d r15d
..B1.90:                        # Preds ..B1.399
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #174.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.91:                        # Preds ..B1.90
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #174.9
        vmovd     %r15d, %xmm1                                  #174.9
        vmovd     %ebx, %xmm2                                   #174.9
        vmovd     %r12d, %xmm3                                  #174.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #174.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #174.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #174.9
        vmovups   %xmm6, 912(%rsp)                              #174.9[spill]
#       rand(void)
        call      rand                                          #175.23
                                # LOE r13 r14 eax
..B1.401:                       # Preds ..B1.91
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #175.23
                                # LOE r13 r14 r12d
..B1.92:                        # Preds ..B1.401
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #175.30
                                # LOE r13 r14 eax r12d
..B1.402:                       # Preds ..B1.92
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #175.30
                                # LOE r13 r14 ebx r12d
..B1.93:                        # Preds ..B1.402
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #175.37
                                # LOE r13 r14 eax ebx r12d
..B1.403:                       # Preds ..B1.93
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #175.37
                                # LOE r13 r14 ebx r12d r15d
..B1.94:                        # Preds ..B1.403
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #175.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.95:                        # Preds ..B1.94
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #175.9
        vmovd     %r15d, %xmm1                                  #175.9
        vmovd     %ebx, %xmm2                                   #175.9
        vmovd     %r12d, %xmm3                                  #175.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #175.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #175.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #175.9
        vmovups   %xmm6, 928(%rsp)                              #175.9[spill]
#       rand(void)
        call      rand                                          #176.23
                                # LOE r13 r14 eax
..B1.405:                       # Preds ..B1.95
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #176.23
                                # LOE r13 r14 r12d
..B1.96:                        # Preds ..B1.405
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #176.30
                                # LOE r13 r14 eax r12d
..B1.406:                       # Preds ..B1.96
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #176.30
                                # LOE r13 r14 ebx r12d
..B1.97:                        # Preds ..B1.406
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #176.37
                                # LOE r13 r14 eax ebx r12d
..B1.407:                       # Preds ..B1.97
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #176.37
                                # LOE r13 r14 ebx r12d r15d
..B1.98:                        # Preds ..B1.407
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #176.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.99:                        # Preds ..B1.98
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #176.9
        vmovd     %r15d, %xmm1                                  #176.9
        vmovd     %ebx, %xmm2                                   #176.9
        vmovd     %r12d, %xmm3                                  #176.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #176.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #176.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #176.9
        vmovups   %xmm6, 944(%rsp)                              #176.9[spill]
#       rand(void)
        call      rand                                          #177.23
                                # LOE r13 r14 eax
..B1.409:                       # Preds ..B1.99
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #177.23
                                # LOE r13 r14 r12d
..B1.100:                       # Preds ..B1.409
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #177.30
                                # LOE r13 r14 eax r12d
..B1.410:                       # Preds ..B1.100
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #177.30
                                # LOE r13 r14 ebx r12d
..B1.101:                       # Preds ..B1.410
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #177.37
                                # LOE r13 r14 eax ebx r12d
..B1.411:                       # Preds ..B1.101
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #177.37
                                # LOE r13 r14 ebx r12d r15d
..B1.102:                       # Preds ..B1.411
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #177.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.103:                       # Preds ..B1.102
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #177.9
        vmovd     %r15d, %xmm1                                  #177.9
        vmovd     %ebx, %xmm2                                   #177.9
        vmovd     %r12d, %xmm3                                  #177.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #177.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #177.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #177.9
        vmovups   %xmm6, 960(%rsp)                              #177.9[spill]
#       rand(void)
        call      rand                                          #178.23
                                # LOE r13 r14 eax
..B1.413:                       # Preds ..B1.103
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #178.23
                                # LOE r13 r14 r12d
..B1.104:                       # Preds ..B1.413
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #178.30
                                # LOE r13 r14 eax r12d
..B1.414:                       # Preds ..B1.104
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #178.30
                                # LOE r13 r14 ebx r12d
..B1.105:                       # Preds ..B1.414
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #178.37
                                # LOE r13 r14 eax ebx r12d
..B1.415:                       # Preds ..B1.105
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #178.37
                                # LOE r13 r14 ebx r12d r15d
..B1.106:                       # Preds ..B1.415
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #178.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.107:                       # Preds ..B1.106
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #178.9
        vmovd     %r15d, %xmm1                                  #178.9
        vmovd     %ebx, %xmm2                                   #178.9
        vmovd     %r12d, %xmm3                                  #178.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #178.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #178.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #178.9
        vmovups   %xmm6, 976(%rsp)                              #178.9[spill]
#       rand(void)
        call      rand                                          #179.23
                                # LOE r13 r14 eax
..B1.417:                       # Preds ..B1.107
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #179.23
                                # LOE r13 r14 r12d
..B1.108:                       # Preds ..B1.417
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #179.30
                                # LOE r13 r14 eax r12d
..B1.418:                       # Preds ..B1.108
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #179.30
                                # LOE r13 r14 ebx r12d
..B1.109:                       # Preds ..B1.418
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #179.37
                                # LOE r13 r14 eax ebx r12d
..B1.419:                       # Preds ..B1.109
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #179.37
                                # LOE r13 r14 ebx r12d r15d
..B1.110:                       # Preds ..B1.419
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #179.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.111:                       # Preds ..B1.110
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #179.9
        vmovd     %r15d, %xmm1                                  #179.9
        vmovd     %ebx, %xmm2                                   #179.9
        vmovd     %r12d, %xmm3                                  #179.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #179.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #179.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #179.9
        vmovups   %xmm6, 992(%rsp)                              #179.9[spill]
#       rand(void)
        call      rand                                          #180.23
                                # LOE r13 r14 eax
..B1.421:                       # Preds ..B1.111
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #180.23
                                # LOE r13 r14 r12d
..B1.112:                       # Preds ..B1.421
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #180.30
                                # LOE r13 r14 eax r12d
..B1.422:                       # Preds ..B1.112
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #180.30
                                # LOE r13 r14 ebx r12d
..B1.113:                       # Preds ..B1.422
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #180.37
                                # LOE r13 r14 eax ebx r12d
..B1.423:                       # Preds ..B1.113
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #180.37
                                # LOE r13 r14 ebx r12d r15d
..B1.114:                       # Preds ..B1.423
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #180.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.115:                       # Preds ..B1.114
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #180.9
        vmovd     %r15d, %xmm1                                  #180.9
        vmovd     %ebx, %xmm2                                   #180.9
        vmovd     %r12d, %xmm3                                  #180.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #180.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #180.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #180.9
        vmovups   %xmm6, 1008(%rsp)                             #180.9[spill]
#       rand(void)
        call      rand                                          #181.23
                                # LOE r13 r14 eax
..B1.425:                       # Preds ..B1.115
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #181.23
                                # LOE r13 r14 r12d
..B1.116:                       # Preds ..B1.425
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #181.30
                                # LOE r13 r14 eax r12d
..B1.426:                       # Preds ..B1.116
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #181.30
                                # LOE r13 r14 ebx r12d
..B1.117:                       # Preds ..B1.426
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #181.37
                                # LOE r13 r14 eax ebx r12d
..B1.427:                       # Preds ..B1.117
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #181.37
                                # LOE r13 r14 ebx r12d r15d
..B1.118:                       # Preds ..B1.427
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #181.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.119:                       # Preds ..B1.118
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #181.9
        vmovd     %r15d, %xmm1                                  #181.9
        vmovd     %ebx, %xmm2                                   #181.9
        vmovd     %r12d, %xmm3                                  #181.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #181.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #181.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #181.9
        vmovups   %xmm6, 1024(%rsp)                             #181.9[spill]
#       rand(void)
        call      rand                                          #182.23
                                # LOE r13 r14 eax
..B1.429:                       # Preds ..B1.119
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #182.23
                                # LOE r13 r14 r12d
..B1.120:                       # Preds ..B1.429
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #182.30
                                # LOE r13 r14 eax r12d
..B1.430:                       # Preds ..B1.120
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #182.30
                                # LOE r13 r14 ebx r12d
..B1.121:                       # Preds ..B1.430
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #182.37
                                # LOE r13 r14 eax ebx r12d
..B1.431:                       # Preds ..B1.121
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #182.37
                                # LOE r13 r14 ebx r12d r15d
..B1.122:                       # Preds ..B1.431
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #182.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.123:                       # Preds ..B1.122
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #182.9
        vmovd     %r15d, %xmm1                                  #182.9
        vmovd     %ebx, %xmm2                                   #182.9
        vmovd     %r12d, %xmm3                                  #182.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #182.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #182.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #182.9
        vmovups   %xmm6, 1040(%rsp)                             #182.9[spill]
#       rand(void)
        call      rand                                          #183.23
                                # LOE r13 r14 eax
..B1.433:                       # Preds ..B1.123
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #183.23
                                # LOE r13 r14 r12d
..B1.124:                       # Preds ..B1.433
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.30
                                # LOE r13 r14 eax r12d
..B1.434:                       # Preds ..B1.124
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #183.30
                                # LOE r13 r14 ebx r12d
..B1.125:                       # Preds ..B1.434
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.37
                                # LOE r13 r14 eax ebx r12d
..B1.435:                       # Preds ..B1.125
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #183.37
                                # LOE r13 r14 ebx r12d r15d
..B1.126:                       # Preds ..B1.435
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #183.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.127:                       # Preds ..B1.126
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #183.9
        vmovd     %r15d, %xmm1                                  #183.9
        vmovd     %ebx, %xmm2                                   #183.9
        vmovd     %r12d, %xmm3                                  #183.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #183.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #183.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #183.9
        vmovups   %xmm6, 1056(%rsp)                             #183.9[spill]
#       rand(void)
        call      rand                                          #184.23
                                # LOE r13 r14 eax
..B1.437:                       # Preds ..B1.127
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #184.23
                                # LOE r13 r14 r12d
..B1.128:                       # Preds ..B1.437
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.30
                                # LOE r13 r14 eax r12d
..B1.438:                       # Preds ..B1.128
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #184.30
                                # LOE r13 r14 ebx r12d
..B1.129:                       # Preds ..B1.438
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.37
                                # LOE r13 r14 eax ebx r12d
..B1.439:                       # Preds ..B1.129
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #184.37
                                # LOE r13 r14 ebx r12d r15d
..B1.130:                       # Preds ..B1.439
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #184.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.131:                       # Preds ..B1.130
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #184.9
        vmovd     %r15d, %xmm1                                  #184.9
        vmovd     %ebx, %xmm2                                   #184.9
        vmovd     %r12d, %xmm3                                  #184.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #184.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #184.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #184.9
        vmovups   %xmm6, 1072(%rsp)                             #184.9[spill]
#       rand(void)
        call      rand                                          #185.23
                                # LOE r13 r14 eax
..B1.441:                       # Preds ..B1.131
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #185.23
                                # LOE r13 r14 r12d
..B1.132:                       # Preds ..B1.441
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.30
                                # LOE r13 r14 eax r12d
..B1.442:                       # Preds ..B1.132
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #185.30
                                # LOE r13 r14 ebx r12d
..B1.133:                       # Preds ..B1.442
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.37
                                # LOE r13 r14 eax ebx r12d
..B1.443:                       # Preds ..B1.133
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #185.37
                                # LOE r13 r14 ebx r12d r15d
..B1.134:                       # Preds ..B1.443
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #185.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.135:                       # Preds ..B1.134
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #185.9
        vmovd     %r15d, %xmm1                                  #185.9
        vmovd     %ebx, %xmm2                                   #185.9
        vmovd     %r12d, %xmm3                                  #185.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #185.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #185.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #185.9
        vmovups   %xmm6, 1088(%rsp)                             #185.9[spill]
#       rand(void)
        call      rand                                          #186.23
                                # LOE r13 r14 eax
..B1.445:                       # Preds ..B1.135
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #186.23
                                # LOE r13 r14 r12d
..B1.136:                       # Preds ..B1.445
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.30
                                # LOE r13 r14 eax r12d
..B1.446:                       # Preds ..B1.136
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #186.30
                                # LOE r13 r14 ebx r12d
..B1.137:                       # Preds ..B1.446
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.37
                                # LOE r13 r14 eax ebx r12d
..B1.447:                       # Preds ..B1.137
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #186.37
                                # LOE r13 r14 ebx r12d r15d
..B1.138:                       # Preds ..B1.447
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #186.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.139:                       # Preds ..B1.138
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #186.9
        vmovd     %r15d, %xmm1                                  #186.9
        vmovd     %ebx, %xmm2                                   #186.9
        vmovd     %r12d, %xmm3                                  #186.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #186.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #186.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #186.9
        vmovups   %xmm6, 1104(%rsp)                             #186.9[spill]
#       rand(void)
        call      rand                                          #187.23
                                # LOE r13 r14 eax
..B1.449:                       # Preds ..B1.139
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #187.23
                                # LOE r13 r14 r12d
..B1.140:                       # Preds ..B1.449
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.30
                                # LOE r13 r14 eax r12d
..B1.450:                       # Preds ..B1.140
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #187.30
                                # LOE r13 r14 ebx r12d
..B1.141:                       # Preds ..B1.450
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.37
                                # LOE r13 r14 eax ebx r12d
..B1.451:                       # Preds ..B1.141
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #187.37
                                # LOE r13 r14 ebx r12d r15d
..B1.142:                       # Preds ..B1.451
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #187.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.143:                       # Preds ..B1.142
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #187.9
        vmovd     %r15d, %xmm1                                  #187.9
        vmovd     %ebx, %xmm2                                   #187.9
        vmovd     %r12d, %xmm3                                  #187.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #187.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #187.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #187.9
        vmovups   %xmm6, 1792(%rsp)                             #187.9[spill]
#       rand(void)
        call      rand                                          #189.22
                                # LOE r13 r14 eax
..B1.453:                       # Preds ..B1.143
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #189.22
                                # LOE r13 r14 r12d
..B1.144:                       # Preds ..B1.453
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.29
                                # LOE r13 r14 eax r12d
..B1.454:                       # Preds ..B1.144
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #189.29
                                # LOE r13 r14 ebx r12d
..B1.145:                       # Preds ..B1.454
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.36
                                # LOE r13 r14 eax ebx r12d
..B1.455:                       # Preds ..B1.145
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #189.36
                                # LOE r13 r14 ebx r12d r15d
..B1.146:                       # Preds ..B1.455
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #189.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.147:                       # Preds ..B1.146
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #189.8
        vmovd     %r15d, %xmm1                                  #189.8
        vmovd     %ebx, %xmm2                                   #189.8
        vmovd     %r12d, %xmm3                                  #189.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #189.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #189.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #189.8
        vmovups   %xmm6, 1120(%rsp)                             #189.8[spill]
#       rand(void)
        call      rand                                          #190.22
                                # LOE r13 r14 eax
..B1.457:                       # Preds ..B1.147
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #190.22
                                # LOE r13 r14 r12d
..B1.148:                       # Preds ..B1.457
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.29
                                # LOE r13 r14 eax r12d
..B1.458:                       # Preds ..B1.148
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #190.29
                                # LOE r13 r14 ebx r12d
..B1.149:                       # Preds ..B1.458
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.36
                                # LOE r13 r14 eax ebx r12d
..B1.459:                       # Preds ..B1.149
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #190.36
                                # LOE r13 r14 ebx r12d r15d
..B1.150:                       # Preds ..B1.459
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #190.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.151:                       # Preds ..B1.150
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #190.8
        vmovd     %r15d, %xmm1                                  #190.8
        vmovd     %ebx, %xmm2                                   #190.8
        vmovd     %r12d, %xmm3                                  #190.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #190.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #190.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #190.8
        vmovups   %xmm6, 1136(%rsp)                             #190.8[spill]
#       rand(void)
        call      rand                                          #191.22
                                # LOE r13 r14 eax
..B1.461:                       # Preds ..B1.151
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #191.22
                                # LOE r13 r14 r12d
..B1.152:                       # Preds ..B1.461
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #191.29
                                # LOE r13 r14 eax r12d
..B1.462:                       # Preds ..B1.152
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #191.29
                                # LOE r13 r14 ebx r12d
..B1.153:                       # Preds ..B1.462
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #191.36
                                # LOE r13 r14 eax ebx r12d
..B1.463:                       # Preds ..B1.153
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #191.36
                                # LOE r13 r14 ebx r12d r15d
..B1.154:                       # Preds ..B1.463
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #191.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.155:                       # Preds ..B1.154
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #191.8
        vmovd     %r15d, %xmm1                                  #191.8
        vmovd     %ebx, %xmm2                                   #191.8
        vmovd     %r12d, %xmm3                                  #191.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #191.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #191.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #191.8
        vmovups   %xmm6, 1152(%rsp)                             #191.8[spill]
#       rand(void)
        call      rand                                          #192.22
                                # LOE r13 r14 eax
..B1.465:                       # Preds ..B1.155
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #192.22
                                # LOE r13 r14 r12d
..B1.156:                       # Preds ..B1.465
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.29
                                # LOE r13 r14 eax r12d
..B1.466:                       # Preds ..B1.156
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #192.29
                                # LOE r13 r14 ebx r12d
..B1.157:                       # Preds ..B1.466
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.36
                                # LOE r13 r14 eax ebx r12d
..B1.467:                       # Preds ..B1.157
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #192.36
                                # LOE r13 r14 ebx r12d r15d
..B1.158:                       # Preds ..B1.467
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #192.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.159:                       # Preds ..B1.158
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #192.8
        vmovd     %r15d, %xmm1                                  #192.8
        vmovd     %ebx, %xmm2                                   #192.8
        vmovd     %r12d, %xmm3                                  #192.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #192.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #192.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #192.8
        vmovups   %xmm6, 1168(%rsp)                             #192.8[spill]
#       rand(void)
        call      rand                                          #193.22
                                # LOE r13 r14 eax
..B1.469:                       # Preds ..B1.159
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #193.22
                                # LOE r13 r14 r12d
..B1.160:                       # Preds ..B1.469
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.29
                                # LOE r13 r14 eax r12d
..B1.470:                       # Preds ..B1.160
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #193.29
                                # LOE r13 r14 ebx r12d
..B1.161:                       # Preds ..B1.470
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.36
                                # LOE r13 r14 eax ebx r12d
..B1.471:                       # Preds ..B1.161
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #193.36
                                # LOE r13 r14 ebx r12d r15d
..B1.162:                       # Preds ..B1.471
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #193.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.163:                       # Preds ..B1.162
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #193.8
        vmovd     %r15d, %xmm1                                  #193.8
        vmovd     %ebx, %xmm2                                   #193.8
        vmovd     %r12d, %xmm3                                  #193.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #193.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #193.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #193.8
        vmovups   %xmm6, 1184(%rsp)                             #193.8[spill]
#       rand(void)
        call      rand                                          #194.22
                                # LOE r13 r14 eax
..B1.473:                       # Preds ..B1.163
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #194.22
                                # LOE r13 r14 r12d
..B1.164:                       # Preds ..B1.473
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.29
                                # LOE r13 r14 eax r12d
..B1.474:                       # Preds ..B1.164
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #194.29
                                # LOE r13 r14 ebx r12d
..B1.165:                       # Preds ..B1.474
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.36
                                # LOE r13 r14 eax ebx r12d
..B1.475:                       # Preds ..B1.165
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #194.36
                                # LOE r13 r14 ebx r12d r15d
..B1.166:                       # Preds ..B1.475
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #194.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.167:                       # Preds ..B1.166
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #194.8
        vmovd     %r15d, %xmm1                                  #194.8
        vmovd     %ebx, %xmm2                                   #194.8
        vmovd     %r12d, %xmm3                                  #194.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #194.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #194.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #194.8
        vmovups   %xmm6, 1200(%rsp)                             #194.8[spill]
#       rand(void)
        call      rand                                          #195.22
                                # LOE r13 r14 eax
..B1.477:                       # Preds ..B1.167
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #195.22
                                # LOE r13 r14 r12d
..B1.168:                       # Preds ..B1.477
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #195.29
                                # LOE r13 r14 eax r12d
..B1.478:                       # Preds ..B1.168
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #195.29
                                # LOE r13 r14 ebx r12d
..B1.169:                       # Preds ..B1.478
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #195.36
                                # LOE r13 r14 eax ebx r12d
..B1.479:                       # Preds ..B1.169
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #195.36
                                # LOE r13 r14 ebx r12d r15d
..B1.170:                       # Preds ..B1.479
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #195.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.171:                       # Preds ..B1.170
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #195.8
        vmovd     %r15d, %xmm1                                  #195.8
        vmovd     %ebx, %xmm2                                   #195.8
        vmovd     %r12d, %xmm3                                  #195.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #195.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #195.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #195.8
        vmovups   %xmm6, 1232(%rsp)                             #195.8[spill]
#       rand(void)
        call      rand                                          #196.22
                                # LOE r13 r14 eax
..B1.481:                       # Preds ..B1.171
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #196.22
                                # LOE r13 r14 r12d
..B1.172:                       # Preds ..B1.481
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #196.29
                                # LOE r13 r14 eax r12d
..B1.482:                       # Preds ..B1.172
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #196.29
                                # LOE r13 r14 ebx r12d
..B1.173:                       # Preds ..B1.482
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #196.36
                                # LOE r13 r14 eax ebx r12d
..B1.483:                       # Preds ..B1.173
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #196.36
                                # LOE r13 r14 ebx r12d r15d
..B1.174:                       # Preds ..B1.483
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #196.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.175:                       # Preds ..B1.174
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #196.8
        vmovd     %r15d, %xmm1                                  #196.8
        vmovd     %ebx, %xmm2                                   #196.8
        vmovd     %r12d, %xmm3                                  #196.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #196.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #196.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #196.8
        vmovups   %xmm6, 1248(%rsp)                             #196.8[spill]
#       rand(void)
        call      rand                                          #197.22
                                # LOE r13 r14 eax
..B1.485:                       # Preds ..B1.175
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #197.22
                                # LOE r13 r14 r12d
..B1.176:                       # Preds ..B1.485
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #197.29
                                # LOE r13 r14 eax r12d
..B1.486:                       # Preds ..B1.176
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #197.29
                                # LOE r13 r14 ebx r12d
..B1.177:                       # Preds ..B1.486
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #197.36
                                # LOE r13 r14 eax ebx r12d
..B1.487:                       # Preds ..B1.177
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #197.36
                                # LOE r13 r14 ebx r12d r15d
..B1.178:                       # Preds ..B1.487
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #197.43
                                # LOE r13 r14 eax ebx r12d r15d
..B1.179:                       # Preds ..B1.178
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #197.8
        vmovd     %r15d, %xmm1                                  #197.8
        vmovd     %ebx, %xmm2                                   #197.8
        vmovd     %r12d, %xmm3                                  #197.8
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #197.8
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #197.8
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #197.8
        vmovups   %xmm6, 1264(%rsp)                             #197.8[spill]
#       rand(void)
        call      rand                                          #198.23
                                # LOE r13 r14 eax
..B1.489:                       # Preds ..B1.179
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #198.23
                                # LOE r13 r14 r12d
..B1.180:                       # Preds ..B1.489
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #198.30
                                # LOE r13 r14 eax r12d
..B1.490:                       # Preds ..B1.180
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #198.30
                                # LOE r13 r14 ebx r12d
..B1.181:                       # Preds ..B1.490
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #198.37
                                # LOE r13 r14 eax ebx r12d
..B1.491:                       # Preds ..B1.181
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #198.37
                                # LOE r13 r14 ebx r12d r15d
..B1.182:                       # Preds ..B1.491
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #198.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.183:                       # Preds ..B1.182
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #198.9
        vmovd     %r15d, %xmm1                                  #198.9
        vmovd     %ebx, %xmm2                                   #198.9
        vmovd     %r12d, %xmm3                                  #198.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #198.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #198.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #198.9
        vmovups   %xmm6, 1280(%rsp)                             #198.9[spill]
#       rand(void)
        call      rand                                          #199.23
                                # LOE r13 r14 eax
..B1.493:                       # Preds ..B1.183
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #199.23
                                # LOE r13 r14 r12d
..B1.184:                       # Preds ..B1.493
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #199.30
                                # LOE r13 r14 eax r12d
..B1.494:                       # Preds ..B1.184
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #199.30
                                # LOE r13 r14 ebx r12d
..B1.185:                       # Preds ..B1.494
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #199.37
                                # LOE r13 r14 eax ebx r12d
..B1.495:                       # Preds ..B1.185
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #199.37
                                # LOE r13 r14 ebx r12d r15d
..B1.186:                       # Preds ..B1.495
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #199.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.187:                       # Preds ..B1.186
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #199.9
        vmovd     %r15d, %xmm1                                  #199.9
        vmovd     %ebx, %xmm2                                   #199.9
        vmovd     %r12d, %xmm3                                  #199.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #199.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #199.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #199.9
        vmovups   %xmm6, 1296(%rsp)                             #199.9[spill]
#       rand(void)
        call      rand                                          #200.23
                                # LOE r13 r14 eax
..B1.497:                       # Preds ..B1.187
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #200.23
                                # LOE r13 r14 r12d
..B1.188:                       # Preds ..B1.497
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #200.30
                                # LOE r13 r14 eax r12d
..B1.498:                       # Preds ..B1.188
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #200.30
                                # LOE r13 r14 ebx r12d
..B1.189:                       # Preds ..B1.498
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #200.37
                                # LOE r13 r14 eax ebx r12d
..B1.499:                       # Preds ..B1.189
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #200.37
                                # LOE r13 r14 ebx r12d r15d
..B1.190:                       # Preds ..B1.499
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #200.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.191:                       # Preds ..B1.190
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #200.9
        vmovd     %r15d, %xmm1                                  #200.9
        vmovd     %ebx, %xmm2                                   #200.9
        vmovd     %r12d, %xmm3                                  #200.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #200.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #200.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #200.9
        vmovups   %xmm6, 1312(%rsp)                             #200.9[spill]
#       rand(void)
        call      rand                                          #201.23
                                # LOE r13 r14 eax
..B1.501:                       # Preds ..B1.191
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #201.23
                                # LOE r13 r14 r12d
..B1.192:                       # Preds ..B1.501
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #201.30
                                # LOE r13 r14 eax r12d
..B1.502:                       # Preds ..B1.192
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #201.30
                                # LOE r13 r14 ebx r12d
..B1.193:                       # Preds ..B1.502
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #201.37
                                # LOE r13 r14 eax ebx r12d
..B1.503:                       # Preds ..B1.193
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #201.37
                                # LOE r13 r14 ebx r12d r15d
..B1.194:                       # Preds ..B1.503
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #201.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.195:                       # Preds ..B1.194
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #201.9
        vmovd     %r15d, %xmm1                                  #201.9
        vmovd     %ebx, %xmm2                                   #201.9
        vmovd     %r12d, %xmm3                                  #201.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #201.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #201.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #201.9
        vmovups   %xmm6, 1344(%rsp)                             #201.9[spill]
#       rand(void)
        call      rand                                          #202.23
                                # LOE r13 r14 eax
..B1.505:                       # Preds ..B1.195
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #202.23
                                # LOE r13 r14 r12d
..B1.196:                       # Preds ..B1.505
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #202.30
                                # LOE r13 r14 eax r12d
..B1.506:                       # Preds ..B1.196
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #202.30
                                # LOE r13 r14 ebx r12d
..B1.197:                       # Preds ..B1.506
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #202.37
                                # LOE r13 r14 eax ebx r12d
..B1.507:                       # Preds ..B1.197
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #202.37
                                # LOE r13 r14 ebx r12d r15d
..B1.198:                       # Preds ..B1.507
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #202.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.199:                       # Preds ..B1.198
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #202.9
        vmovd     %r15d, %xmm1                                  #202.9
        vmovd     %ebx, %xmm2                                   #202.9
        vmovd     %r12d, %xmm3                                  #202.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #202.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #202.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #202.9
        vmovups   %xmm6, 1328(%rsp)                             #202.9[spill]
#       rand(void)
        call      rand                                          #203.23
                                # LOE r13 r14 eax
..B1.509:                       # Preds ..B1.199
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #203.23
                                # LOE r13 r14 r12d
..B1.200:                       # Preds ..B1.509
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #203.30
                                # LOE r13 r14 eax r12d
..B1.510:                       # Preds ..B1.200
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #203.30
                                # LOE r13 r14 ebx r12d
..B1.201:                       # Preds ..B1.510
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #203.37
                                # LOE r13 r14 eax ebx r12d
..B1.511:                       # Preds ..B1.201
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #203.37
                                # LOE r13 r14 ebx r12d r15d
..B1.202:                       # Preds ..B1.511
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #203.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.203:                       # Preds ..B1.202
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #203.9
        vmovd     %r15d, %xmm1                                  #203.9
        vmovd     %ebx, %xmm2                                   #203.9
        vmovd     %r12d, %xmm3                                  #203.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #203.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #203.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #203.9
        vmovups   %xmm6, 1360(%rsp)                             #203.9[spill]
#       rand(void)
        call      rand                                          #204.23
                                # LOE r13 r14 eax
..B1.513:                       # Preds ..B1.203
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #204.23
                                # LOE r13 r14 r12d
..B1.204:                       # Preds ..B1.513
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #204.30
                                # LOE r13 r14 eax r12d
..B1.514:                       # Preds ..B1.204
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #204.30
                                # LOE r13 r14 ebx r12d
..B1.205:                       # Preds ..B1.514
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #204.37
                                # LOE r13 r14 eax ebx r12d
..B1.515:                       # Preds ..B1.205
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #204.37
                                # LOE r13 r14 ebx r12d r15d
..B1.206:                       # Preds ..B1.515
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #204.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.207:                       # Preds ..B1.206
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #204.9
        vmovd     %r15d, %xmm1                                  #204.9
        vmovd     %ebx, %xmm2                                   #204.9
        vmovd     %r12d, %xmm3                                  #204.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #204.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #204.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #204.9
        vmovups   %xmm6, 1376(%rsp)                             #204.9[spill]
#       rand(void)
        call      rand                                          #205.23
                                # LOE r13 r14 eax
..B1.517:                       # Preds ..B1.207
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #205.23
                                # LOE r13 r14 r12d
..B1.208:                       # Preds ..B1.517
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #205.30
                                # LOE r13 r14 eax r12d
..B1.518:                       # Preds ..B1.208
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #205.30
                                # LOE r13 r14 ebx r12d
..B1.209:                       # Preds ..B1.518
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #205.37
                                # LOE r13 r14 eax ebx r12d
..B1.519:                       # Preds ..B1.209
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #205.37
                                # LOE r13 r14 ebx r12d r15d
..B1.210:                       # Preds ..B1.519
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #205.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.211:                       # Preds ..B1.210
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #205.9
        vmovd     %r15d, %xmm1                                  #205.9
        vmovd     %ebx, %xmm2                                   #205.9
        vmovd     %r12d, %xmm3                                  #205.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #205.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #205.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #205.9
        vmovups   %xmm6, 1408(%rsp)                             #205.9[spill]
#       rand(void)
        call      rand                                          #206.23
                                # LOE r13 r14 eax
..B1.521:                       # Preds ..B1.211
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #206.23
                                # LOE r13 r14 r12d
..B1.212:                       # Preds ..B1.521
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #206.30
                                # LOE r13 r14 eax r12d
..B1.522:                       # Preds ..B1.212
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #206.30
                                # LOE r13 r14 ebx r12d
..B1.213:                       # Preds ..B1.522
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #206.37
                                # LOE r13 r14 eax ebx r12d
..B1.523:                       # Preds ..B1.213
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #206.37
                                # LOE r13 r14 ebx r12d r15d
..B1.214:                       # Preds ..B1.523
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #206.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.215:                       # Preds ..B1.214
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #206.9
        vmovd     %r15d, %xmm1                                  #206.9
        vmovd     %ebx, %xmm2                                   #206.9
        vmovd     %r12d, %xmm3                                  #206.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #206.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #206.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #206.9
        vmovups   %xmm6, 1392(%rsp)                             #206.9[spill]
#       rand(void)
        call      rand                                          #207.23
                                # LOE r13 r14 eax
..B1.525:                       # Preds ..B1.215
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #207.23
                                # LOE r13 r14 r12d
..B1.216:                       # Preds ..B1.525
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #207.30
                                # LOE r13 r14 eax r12d
..B1.526:                       # Preds ..B1.216
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #207.30
                                # LOE r13 r14 ebx r12d
..B1.217:                       # Preds ..B1.526
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #207.37
                                # LOE r13 r14 eax ebx r12d
..B1.527:                       # Preds ..B1.217
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #207.37
                                # LOE r13 r14 ebx r12d r15d
..B1.218:                       # Preds ..B1.527
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #207.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.219:                       # Preds ..B1.218
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #207.9
        vmovd     %r15d, %xmm1                                  #207.9
        vmovd     %ebx, %xmm2                                   #207.9
        vmovd     %r12d, %xmm3                                  #207.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #207.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #207.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #207.9
        vmovups   %xmm6, 1424(%rsp)                             #207.9[spill]
#       rand(void)
        call      rand                                          #208.23
                                # LOE r13 r14 eax
..B1.529:                       # Preds ..B1.219
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #208.23
                                # LOE r13 r14 r12d
..B1.220:                       # Preds ..B1.529
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #208.30
                                # LOE r13 r14 eax r12d
..B1.530:                       # Preds ..B1.220
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #208.30
                                # LOE r13 r14 ebx r12d
..B1.221:                       # Preds ..B1.530
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #208.37
                                # LOE r13 r14 eax ebx r12d
..B1.531:                       # Preds ..B1.221
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #208.37
                                # LOE r13 r14 ebx r12d r15d
..B1.222:                       # Preds ..B1.531
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #208.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.223:                       # Preds ..B1.222
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #208.9
        vmovd     %r15d, %xmm1                                  #208.9
        vmovd     %ebx, %xmm2                                   #208.9
        vmovd     %r12d, %xmm3                                  #208.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #208.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #208.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #208.9
        vmovups   %xmm6, 1440(%rsp)                             #208.9[spill]
#       rand(void)
        call      rand                                          #209.23
                                # LOE r13 r14 eax
..B1.533:                       # Preds ..B1.223
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #209.23
                                # LOE r13 r14 r12d
..B1.224:                       # Preds ..B1.533
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #209.30
                                # LOE r13 r14 eax r12d
..B1.534:                       # Preds ..B1.224
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #209.30
                                # LOE r13 r14 ebx r12d
..B1.225:                       # Preds ..B1.534
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #209.37
                                # LOE r13 r14 eax ebx r12d
..B1.535:                       # Preds ..B1.225
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #209.37
                                # LOE r13 r14 ebx r12d r15d
..B1.226:                       # Preds ..B1.535
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #209.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.227:                       # Preds ..B1.226
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #209.9
        vmovd     %r15d, %xmm1                                  #209.9
        vmovd     %ebx, %xmm2                                   #209.9
        vmovd     %r12d, %xmm3                                  #209.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #209.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #209.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #209.9
        vmovups   %xmm6, 1472(%rsp)                             #209.9[spill]
#       rand(void)
        call      rand                                          #210.23
                                # LOE r13 r14 eax
..B1.537:                       # Preds ..B1.227
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #210.23
                                # LOE r13 r14 r12d
..B1.228:                       # Preds ..B1.537
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #210.30
                                # LOE r13 r14 eax r12d
..B1.538:                       # Preds ..B1.228
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #210.30
                                # LOE r13 r14 ebx r12d
..B1.229:                       # Preds ..B1.538
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #210.37
                                # LOE r13 r14 eax ebx r12d
..B1.539:                       # Preds ..B1.229
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #210.37
                                # LOE r13 r14 ebx r12d r15d
..B1.230:                       # Preds ..B1.539
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #210.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.231:                       # Preds ..B1.230
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #210.9
        vmovd     %r15d, %xmm1                                  #210.9
        vmovd     %ebx, %xmm2                                   #210.9
        vmovd     %r12d, %xmm3                                  #210.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #210.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #210.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #210.9
        vmovups   %xmm6, 1456(%rsp)                             #210.9[spill]
#       rand(void)
        call      rand                                          #211.23
                                # LOE r13 r14 eax
..B1.541:                       # Preds ..B1.231
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #211.23
                                # LOE r13 r14 r12d
..B1.232:                       # Preds ..B1.541
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #211.30
                                # LOE r13 r14 eax r12d
..B1.542:                       # Preds ..B1.232
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #211.30
                                # LOE r13 r14 ebx r12d
..B1.233:                       # Preds ..B1.542
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #211.37
                                # LOE r13 r14 eax ebx r12d
..B1.543:                       # Preds ..B1.233
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #211.37
                                # LOE r13 r14 ebx r12d r15d
..B1.234:                       # Preds ..B1.543
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #211.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.235:                       # Preds ..B1.234
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #211.9
        vmovd     %r15d, %xmm1                                  #211.9
        vmovd     %ebx, %xmm2                                   #211.9
        vmovd     %r12d, %xmm3                                  #211.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #211.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #211.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #211.9
        vmovups   %xmm6, 1488(%rsp)                             #211.9[spill]
#       rand(void)
        call      rand                                          #212.23
                                # LOE r13 r14 eax
..B1.545:                       # Preds ..B1.235
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #212.23
                                # LOE r13 r14 r12d
..B1.236:                       # Preds ..B1.545
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #212.30
                                # LOE r13 r14 eax r12d
..B1.546:                       # Preds ..B1.236
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #212.30
                                # LOE r13 r14 ebx r12d
..B1.237:                       # Preds ..B1.546
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #212.37
                                # LOE r13 r14 eax ebx r12d
..B1.547:                       # Preds ..B1.237
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #212.37
                                # LOE r13 r14 ebx r12d r15d
..B1.238:                       # Preds ..B1.547
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #212.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.239:                       # Preds ..B1.238
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #212.9
        vmovd     %r15d, %xmm1                                  #212.9
        vmovd     %ebx, %xmm2                                   #212.9
        vmovd     %r12d, %xmm3                                  #212.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #212.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #212.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #212.9
        vmovups   %xmm6, 1504(%rsp)                             #212.9[spill]
#       rand(void)
        call      rand                                          #213.23
                                # LOE r13 r14 eax
..B1.549:                       # Preds ..B1.239
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #213.23
                                # LOE r13 r14 r12d
..B1.240:                       # Preds ..B1.549
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #213.30
                                # LOE r13 r14 eax r12d
..B1.550:                       # Preds ..B1.240
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #213.30
                                # LOE r13 r14 ebx r12d
..B1.241:                       # Preds ..B1.550
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #213.37
                                # LOE r13 r14 eax ebx r12d
..B1.551:                       # Preds ..B1.241
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #213.37
                                # LOE r13 r14 ebx r12d r15d
..B1.242:                       # Preds ..B1.551
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #213.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.243:                       # Preds ..B1.242
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #213.9
        vmovd     %r15d, %xmm1                                  #213.9
        vmovd     %ebx, %xmm2                                   #213.9
        vmovd     %r12d, %xmm3                                  #213.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #213.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #213.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #213.9
        vmovups   %xmm6, 1520(%rsp)                             #213.9[spill]
#       rand(void)
        call      rand                                          #214.23
                                # LOE r13 r14 eax
..B1.553:                       # Preds ..B1.243
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #214.23
                                # LOE r13 r14 r12d
..B1.244:                       # Preds ..B1.553
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #214.30
                                # LOE r13 r14 eax r12d
..B1.554:                       # Preds ..B1.244
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #214.30
                                # LOE r13 r14 ebx r12d
..B1.245:                       # Preds ..B1.554
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #214.37
                                # LOE r13 r14 eax ebx r12d
..B1.555:                       # Preds ..B1.245
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #214.37
                                # LOE r13 r14 ebx r12d r15d
..B1.246:                       # Preds ..B1.555
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #214.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.247:                       # Preds ..B1.246
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #214.9
        vmovd     %r15d, %xmm1                                  #214.9
        vmovd     %ebx, %xmm2                                   #214.9
        vmovd     %r12d, %xmm3                                  #214.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #214.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #214.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #214.9
        vmovups   %xmm6, 1552(%rsp)                             #214.9[spill]
#       rand(void)
        call      rand                                          #215.23
                                # LOE r13 r14 eax
..B1.557:                       # Preds ..B1.247
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #215.23
                                # LOE r13 r14 r12d
..B1.248:                       # Preds ..B1.557
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #215.30
                                # LOE r13 r14 eax r12d
..B1.558:                       # Preds ..B1.248
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #215.30
                                # LOE r13 r14 ebx r12d
..B1.249:                       # Preds ..B1.558
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #215.37
                                # LOE r13 r14 eax ebx r12d
..B1.559:                       # Preds ..B1.249
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #215.37
                                # LOE r13 r14 ebx r12d r15d
..B1.250:                       # Preds ..B1.559
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #215.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.251:                       # Preds ..B1.250
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #215.9
        vmovd     %r15d, %xmm1                                  #215.9
        vmovd     %ebx, %xmm2                                   #215.9
        vmovd     %r12d, %xmm3                                  #215.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #215.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #215.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #215.9
        vmovups   %xmm6, 1536(%rsp)                             #215.9[spill]
#       rand(void)
        call      rand                                          #216.23
                                # LOE r13 r14 eax
..B1.561:                       # Preds ..B1.251
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #216.23
                                # LOE r13 r14 r12d
..B1.252:                       # Preds ..B1.561
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #216.30
                                # LOE r13 r14 eax r12d
..B1.562:                       # Preds ..B1.252
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #216.30
                                # LOE r13 r14 ebx r12d
..B1.253:                       # Preds ..B1.562
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #216.37
                                # LOE r13 r14 eax ebx r12d
..B1.563:                       # Preds ..B1.253
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #216.37
                                # LOE r13 r14 ebx r12d r15d
..B1.254:                       # Preds ..B1.563
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #216.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.255:                       # Preds ..B1.254
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #216.9
        vmovd     %r15d, %xmm1                                  #216.9
        vmovd     %ebx, %xmm2                                   #216.9
        vmovd     %r12d, %xmm3                                  #216.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #216.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #216.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #216.9
        vmovups   %xmm6, 1568(%rsp)                             #216.9[spill]
#       rand(void)
        call      rand                                          #217.23
                                # LOE r13 r14 eax
..B1.565:                       # Preds ..B1.255
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #217.23
                                # LOE r13 r14 r12d
..B1.256:                       # Preds ..B1.565
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #217.30
                                # LOE r13 r14 eax r12d
..B1.566:                       # Preds ..B1.256
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #217.30
                                # LOE r13 r14 ebx r12d
..B1.257:                       # Preds ..B1.566
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #217.37
                                # LOE r13 r14 eax ebx r12d
..B1.567:                       # Preds ..B1.257
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #217.37
                                # LOE r13 r14 ebx r12d r15d
..B1.258:                       # Preds ..B1.567
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #217.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.259:                       # Preds ..B1.258
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #217.9
        vmovd     %r15d, %xmm1                                  #217.9
        vmovd     %ebx, %xmm2                                   #217.9
        vmovd     %r12d, %xmm3                                  #217.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #217.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #217.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #217.9
        vmovups   %xmm6, 1584(%rsp)                             #217.9[spill]
#       rand(void)
        call      rand                                          #218.23
                                # LOE r13 r14 eax
..B1.569:                       # Preds ..B1.259
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #218.23
                                # LOE r13 r14 r12d
..B1.260:                       # Preds ..B1.569
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #218.30
                                # LOE r13 r14 eax r12d
..B1.570:                       # Preds ..B1.260
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #218.30
                                # LOE r13 r14 ebx r12d
..B1.261:                       # Preds ..B1.570
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #218.37
                                # LOE r13 r14 eax ebx r12d
..B1.571:                       # Preds ..B1.261
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #218.37
                                # LOE r13 r14 ebx r12d r15d
..B1.262:                       # Preds ..B1.571
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #218.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.263:                       # Preds ..B1.262
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #218.9
        vmovd     %r15d, %xmm1                                  #218.9
        vmovd     %ebx, %xmm2                                   #218.9
        vmovd     %r12d, %xmm3                                  #218.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #218.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #218.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #218.9
        vmovups   %xmm6, 1600(%rsp)                             #218.9[spill]
#       rand(void)
        call      rand                                          #219.23
                                # LOE r13 r14 eax
..B1.573:                       # Preds ..B1.263
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #219.23
                                # LOE r13 r14 r12d
..B1.264:                       # Preds ..B1.573
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #219.30
                                # LOE r13 r14 eax r12d
..B1.574:                       # Preds ..B1.264
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #219.30
                                # LOE r13 r14 ebx r12d
..B1.265:                       # Preds ..B1.574
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #219.37
                                # LOE r13 r14 eax ebx r12d
..B1.575:                       # Preds ..B1.265
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #219.37
                                # LOE r13 r14 ebx r12d r15d
..B1.266:                       # Preds ..B1.575
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #219.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.267:                       # Preds ..B1.266
                                # Execution count [1.00e+00]
        vmovd     %eax, %xmm0                                   #219.9
        vmovd     %r15d, %xmm1                                  #219.9
        vmovd     %ebx, %xmm2                                   #219.9
        vmovd     %r12d, %xmm3                                  #219.9
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #219.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #219.9
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #219.9
        vmovups   %xmm6, 1616(%rsp)                             #219.9[spill]
#       rand(void)
        call      rand                                          #220.23
                                # LOE r13 r14 eax
..B1.577:                       # Preds ..B1.267
                                # Execution count [1.00e+00]
        movl      %eax, %r15d                                   #220.23
                                # LOE r13 r14 r15d
..B1.268:                       # Preds ..B1.577
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #220.30
                                # LOE r13 r14 eax r15d
..B1.578:                       # Preds ..B1.268
                                # Execution count [1.00e+00]
        movl      %eax, %r12d                                   #220.30
                                # LOE r13 r14 r12d r15d
..B1.269:                       # Preds ..B1.578
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #220.37
                                # LOE r13 r14 eax r12d r15d
..B1.579:                       # Preds ..B1.269
                                # Execution count [1.00e+00]
        movl      %eax, %ebx                                    #220.37
                                # LOE r13 r14 ebx r12d r15d
..B1.270:                       # Preds ..B1.579
                                # Execution count [1.00e+00]
#       rand(void)
        call      rand                                          #220.44
                                # LOE r13 r14 eax ebx r12d r15d
..B1.580:                       # Preds ..B1.270
                                # Execution count [1.00e+00]
        movl      %eax, %edx                                    #220.44
                                # LOE r13 r14 edx ebx r12d r15d
..B1.271:                       # Preds ..B1.580
                                # Execution count [9.00e-01]
        vmovd     %edx, %xmm0                                   #220.9
        vmovd     %ebx, %xmm1                                   #220.9
        vmovd     %r12d, %xmm2                                  #220.9
        vmovd     %r15d, %xmm3                                  #220.9
        vmovups   1824(%rsp), %xmm7                             #224.17[spill]
        xorl      %eax, %eax                                    #222.3
        vpunpcklqdq %xmm1, %xmm0, %xmm4                         #220.9
        vpunpcklqdq %xmm3, %xmm2, %xmm5                         #220.9
        vpxor     1808(%rsp), %xmm7, %xmm8                      #224.17[spill]
        vshufps   $136, %xmm5, %xmm4, %xmm6                     #220.9
        vpxor     %xmm9, %xmm8, %xmm0                           #224.17
        vmovups   %xmm6, (%rsp)                                 #220.9[spill]
                                # LOE r13 r14 eax xmm0
..B1.272:                       # Preds ..B1.272 ..B1.271
                                # Execution count [2.50e+00]
        lea       (%rax,%rax), %edx                             #224.5
        incl      %eax                                          #222.3
        shlq      $4, %rdx                                      #224.5
        vmovdqu   %xmm0, (%r13,%rdx)                            #224.5
        vmovdqu   %xmm0, 16(%r13,%rdx)                          #224.5
        cmpl      $16000000, %eax                               #222.3
        jb        ..B1.272      # Prob 63%                      #222.3
                                # LOE r13 r14 eax xmm0
..B1.273:                       # Preds ..B1.272
                                # Execution count [1.00e+00]
        movq      %r13, %rdi                                    #226.3
        movl      $16, %esi                                     #226.3
        movl      $32000000, %edx                               #226.3
        movq      %r14, %rcx                                    #226.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #226.3
                                # LOE r13 r14
..B1.274:                       # Preds ..B1.273
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #229.3
        xorl      %eax, %eax                                    #229.3
..___tag_value_main.13:
#       printf(const char *__restrict__, ...)
        call      printf                                        #229.3
..___tag_value_main.14:
                                # LOE r13 r14
..B1.275:                       # Preds ..B1.274
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #229.27
#       fflush(FILE *)
        call      fflush                                        #229.27
                                # LOE r13 r14
..B1.276:                       # Preds ..B1.275
                                # Execution count [1.00e+00]
        rdtscp                                                   #230.11
        shlq      $32, %rdx                                     #230.11
        orq       %rdx, %rax                                    #230.11
                                # LOE rax r13 r14
..B1.581:                       # Preds ..B1.276
                                # Execution count [1.00e+00]
        movq      %rax, %rbx                                    #230.11
        xorl      %edx, %edx                                    #231.3
        xorl      %eax, %eax                                    #231.3
                                # LOE rbx r13 r14
..B1.277:                       # Preds ..B1.581
                                # Execution count [9.00e-01]
        vmovups   1728(%rsp), %xmm6                             #232.5[spill]
        vpaddd    1200(%rsp), %xmm6, %xmm5                      #232.5[spill]
        vmovups   1824(%rsp), %xmm14                            #232.5[spill]
        vmovups   1712(%rsp), %xmm4                             #232.5[spill]
        vmovdqu   %xmm5, 16(%rsp)                               #232.5[spill]
        vmovups   1360(%rsp), %xmm5                             #232.5[spill]
        vpaddd    1120(%rsp), %xmm14, %xmm13                    #232.5[spill]
        vmovups   1808(%rsp), %xmm12                            #232.5[spill]
        vmovups   1744(%rsp), %xmm7                             #232.5[spill]
        vpaddd    1232(%rsp), %xmm4, %xmm3                      #232.5[spill]
        vmovups   1696(%rsp), %xmm2                             #232.5[spill]
        vpaddd    848(%rsp), %xmm5, %xmm4                       #232.5[spill]
        vmovdqu   %xmm13, 240(%rsp)                             #232.5[spill]
        vpaddd    1136(%rsp), %xmm12, %xmm11                    #232.5[spill]
        vpaddd    1184(%rsp), %xmm7, %xmm13                     #232.5[spill]
        vmovups   1664(%rsp), %xmm15                            #232.5[spill]
        vmovups   1328(%rsp), %xmm7                             #232.5[spill]
        vmovdqu   %xmm3, 128(%rsp)                              #232.5[spill]
        vpaddd    1248(%rsp), %xmm2, %xmm12                     #232.5[spill]
        vmovups   1680(%rsp), %xmm1                             #232.5[spill]
        vmovups   1376(%rsp), %xmm3                             #232.5[spill]
        vmovdqu   %xmm4, 112(%rsp)                              #232.5[spill]
        vmovups   1408(%rsp), %xmm2                             #232.5[spill]
        vmovups   1440(%rsp), %xmm4                             #232.5[spill]
        vmovdqu   %xmm11, 256(%rsp)                             #232.5[spill]
        vpaddd    1280(%rsp), %xmm15, %xmm11                    #232.5[spill]
        vpaddd    832(%rsp), %xmm7, %xmm6                       #232.5[spill]
        vpaddd    1264(%rsp), %xmm1, %xmm0                      #232.5[spill]
        vpaddd    864(%rsp), %xmm3, %xmm7                       #232.5[spill]
        vmovups   1424(%rsp), %xmm15                            #232.5[spill]
        vpaddd    880(%rsp), %xmm2, %xmm1                       #232.5[spill]
        vpaddd    928(%rsp), %xmm4, %xmm3                       #232.5[spill]
        vpaddd    912(%rsp), %xmm15, %xmm5                      #232.5[spill]
        vmovdqu   %xmm0, 192(%rsp)                              #232.5[spill]
        vmovdqu   %xmm1, 208(%rsp)                              #232.5[spill]
        vmovups   1392(%rsp), %xmm0                             #232.5[spill]
        vmovups   1472(%rsp), %xmm2                             #232.5[spill]
        vmovdqu   %xmm3, 80(%rsp)                               #232.5[spill]
        vmovups   1456(%rsp), %xmm1                             #232.5[spill]
        vmovups   1488(%rsp), %xmm15                            #232.5[spill]
        vmovups   1504(%rsp), %xmm3                             #232.5[spill]
        vmovdqu   %xmm6, 64(%rsp)                               #232.5[spill]
        vmovdqu   %xmm5, 48(%rsp)                               #232.5[spill]
        vpaddd    896(%rsp), %xmm0, %xmm6                       #232.5[spill]
        vpaddd    944(%rsp), %xmm2, %xmm5                       #232.5[spill]
        vpaddd    960(%rsp), %xmm1, %xmm0                       #232.5[spill]
        vpaddd    976(%rsp), %xmm15, %xmm4                      #232.5[spill]
        vpaddd    992(%rsp), %xmm3, %xmm2                       #232.5[spill]
        vmovups   1520(%rsp), %xmm1                             #232.5[spill]
        vmovups   1552(%rsp), %xmm15                            #232.5[spill]
        vmovdqu   %xmm0, 96(%rsp)                               #232.5[spill]
        vmovdqu   %xmm2, 144(%rsp)                              #232.5[spill]
        vpaddd    1008(%rsp), %xmm1, %xmm0                      #232.5[spill]
        vpaddd    1024(%rsp), %xmm15, %xmm3                     #232.5[spill]
        vmovups   1536(%rsp), %xmm2                             #232.5[spill]
        vmovups   1760(%rsp), %xmm9                             #232.5[spill]
        vmovups   1584(%rsp), %xmm15                            #232.5[spill]
        vpaddd    1040(%rsp), %xmm2, %xmm1                      #232.5[spill]
        vmovdqu   %xmm0, 160(%rsp)                              #232.5[spill]
        vmovups   1776(%rsp), %xmm10                            #232.5[spill]
        vpaddd    1168(%rsp), %xmm9, %xmm8                      #232.5[spill]
        vmovups   1568(%rsp), %xmm0                             #232.5[spill]
        vpaddd    1072(%rsp), %xmm15, %xmm2                     #232.5[spill]
        vmovups   1792(%rsp), %xmm15                            #232.5[spill]
        vmovdqu   %xmm3, 32(%rsp)                               #232.5[spill]
        vpaddd    1152(%rsp), %xmm10, %xmm14                    #232.5[spill]
        vpaddd    1056(%rsp), %xmm0, %xmm3                      #232.5[spill]
        vmovdqu   %xmm8, 224(%rsp)                              #232.5[spill]
        vmovdqu   %xmm1, 176(%rsp)                              #232.5[spill]
        vmovups   1648(%rsp), %xmm10                            #232.5[spill]
        vmovups   1632(%rsp), %xmm9                             #232.5[spill]
        vmovups   1344(%rsp), %xmm8                             #232.5[spill]
        vmovups   1600(%rsp), %xmm1                             #232.5[spill]
        vmovups   1616(%rsp), %xmm0                             #232.5[spill]
        vpaddd    (%rsp), %xmm15, %xmm15                        #232.5[spill]
        vpaddd    1296(%rsp), %xmm10, %xmm10                    #232.5[spill]
        vpaddd    1312(%rsp), %xmm9, %xmm9                      #232.5[spill]
        vpaddd    1216(%rsp), %xmm8, %xmm8                      #232.5[spill]
        vpaddd    1088(%rsp), %xmm1, %xmm1                      #232.5[spill]
        vpaddd    1104(%rsp), %xmm0, %xmm0                      #232.5[spill]
        vmovdqu   %xmm15, 272(%rsp)                             #232.5[spill]
                                # LOE rax rbx r13 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.278:                       # Preds ..B1.278 ..B1.277
                                # Execution count [5.00e+00]
        vmovdqu   240(%rsp), %xmm15                             #232.5[spill]
        lea       (%rax,%r13), %rsi                             #232.5
        vmovdqu   %xmm15, (%rsi)                                #232.5
        incl      %edx                                          #231.3
        vmovdqu   256(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 16(%rsi)                              #232.5
        vmovdqu   224(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 48(%rsi)                              #232.5
        vmovdqu   16(%rsp), %xmm15                              #232.5[spill]
        vmovdqu   %xmm15, 80(%rsi)                              #232.5
        vmovdqu   128(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 96(%rsi)                              #232.5
        vmovdqu   192(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 128(%rsi)                             #232.5
        vmovdqu   64(%rsp), %xmm15                              #232.5[spill]
        vmovdqu   %xmm15, 208(%rsi)                             #232.5
        vmovdqu   112(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 224(%rsi)                             #232.5
        vmovdqu   208(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 256(%rsi)                             #232.5
        vmovdqu   48(%rsp), %xmm15                              #232.5[spill]
        vmovdqu   %xmm15, 288(%rsi)                             #232.5
        vmovdqu   80(%rsp), %xmm15                              #232.5[spill]
        vmovdqu   %xmm15, 304(%rsi)                             #232.5
        vmovdqu   96(%rsp), %xmm15                              #232.5[spill]
        vmovdqu   %xmm15, 336(%rsi)                             #232.5
        vmovdqu   144(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 368(%rsi)                             #232.5
        vmovdqu   160(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 384(%rsi)                             #232.5
        vmovdqu   32(%rsp), %xmm15                              #232.5[spill]
        vmovdqu   %xmm15, 400(%rsi)                             #232.5
        vmovdqu   176(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm15, 416(%rsi)                             #232.5
        vmovdqu   272(%rsp), %xmm15                             #232.5[spill]
        vmovdqu   %xmm10, 160(%rsi)                             #232.5
        vmovdqu   %xmm9, 176(%rsi)                              #232.5
        vmovdqu   %xmm8, 192(%rsi)                              #232.5
        vmovdqu   %xmm7, 240(%rsi)                              #232.5
        vmovdqu   %xmm6, 272(%rsi)                              #232.5
        vmovdqu   %xmm5, 320(%rsi)                              #232.5
        vmovdqu   %xmm4, 352(%rsi)                              #232.5
        vmovdqu   %xmm3, 432(%rsi)                              #232.5
        vmovdqu   %xmm2, 448(%rsi)                              #232.5
        vmovdqu   %xmm1, 464(%rsi)                              #232.5
        vmovdqu   %xmm0, 480(%rsi)                              #232.5
        vmovdqu   %xmm15, 496(%rsi)                             #232.5
        addq      $512, %rax                                    #231.3
        vmovdqu   %xmm14, 32(%rsi)                              #232.5
        vmovdqu   %xmm13, 64(%rsi)                              #232.5
        vmovdqu   %xmm12, 112(%rsi)                             #232.5
        vmovdqu   %xmm11, 144(%rsi)                             #232.5
        cmpl      $1000000, %edx                                #231.3
        jb        ..B1.277      # Prob 82%                      #231.3
                                # LOE rax rbx r13 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.279:                       # Preds ..B1.278
                                # Execution count [1.00e+00]
        rdtscp                                                   #237.9
        shlq      $32, %rdx                                     #237.9
        orq       %rdx, %rax                                    #237.9
                                # LOE rax rbx r13 r14
..B1.280:                       # Preds ..B1.279
                                # Execution count [1.00e+00]
        subq      %rbx, %rax                                    #238.3
        movl      $.L_2__STRING.3, %edi                         #238.3
        movq      %rax, %rsi                                    #238.3
        xorl      %eax, %eax                                    #238.3
..___tag_value_main.15:
#       printf(const char *__restrict__, ...)
        call      printf                                        #238.3
..___tag_value_main.16:
                                # LOE r13 r14
..B1.281:                       # Preds ..B1.280
                                # Execution count [1.00e+00]
        movq      %r13, %rdi                                    #239.3
        movl      $16, %esi                                     #239.3
        movl      $32000000, %edx                               #239.3
        movq      %r14, %rcx                                    #239.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #239.3
                                # LOE r13 r14
..B1.282:                       # Preds ..B1.281
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.4, %edi                         #241.3
        xorl      %eax, %eax                                    #241.3
..___tag_value_main.17:
#       printf(const char *__restrict__, ...)
        call      printf                                        #241.3
..___tag_value_main.18:
                                # LOE r13 r14
..B1.283:                       # Preds ..B1.282
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #241.27
#       fflush(FILE *)
        call      fflush                                        #241.27
                                # LOE r13 r14
..B1.284:                       # Preds ..B1.283
                                # Execution count [1.00e+00]
        rdtscp                                                   #242.11
        shlq      $32, %rdx                                     #242.11
        orq       %rdx, %rax                                    #242.11
                                # LOE rax r13 r14
..B1.583:                       # Preds ..B1.284
                                # Execution count [1.00e+00]
        movq      %rax, %rbx                                    #242.11
        xorl      %edx, %edx                                    #243.14
        xorl      %eax, %eax                                    #243.14
                                # LOE rbx r13 r14
..B1.285:                       # Preds ..B1.583
                                # Execution count [9.00e-01]
        vmovups   1792(%rsp), %xmm13                            #244.5[spill]
        vpxor     (%rsp), %xmm13, %xmm12                        #244.5[spill]
        vmovdqu   %xmm12, 16(%rsp)                              #244.5[spill]
        vmovups   1120(%rsp), %xmm10                            #244.5[spill]
        vmovups   1824(%rsp), %xmm11                            #244.5[spill]
        vmovups   1136(%rsp), %xmm8                             #244.5[spill]
        vpxor     %xmm10, %xmm11, %xmm15                        #244.5
        vmovups   1808(%rsp), %xmm9                             #244.5[spill]
        vpand     %xmm10, %xmm11, %xmm2                         #244.5
        vmovups   1152(%rsp), %xmm6                             #244.5[spill]
        vpxor     %xmm8, %xmm9, %xmm14                          #244.5
        vmovups   1776(%rsp), %xmm7                             #244.5[spill]
        vpand     %xmm8, %xmm9, %xmm4                           #244.5
        vmovups   1168(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm6, %xmm7, %xmm3                           #244.5
        vmovups   1760(%rsp), %xmm1                             #244.5[spill]
        vpand     %xmm6, %xmm7, %xmm6                           #244.5
        vmovups   1184(%rsp), %xmm12                            #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm5                           #244.5
        vmovups   1744(%rsp), %xmm13                            #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm8                           #244.5
        vmovups   1200(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm12, %xmm13, %xmm7                         #244.5
        vmovups   1728(%rsp), %xmm11                            #244.5[spill]
        vpand     %xmm12, %xmm13, %xmm10                        #244.5
        vmovups   1232(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm1, %xmm11, %xmm9                          #244.5
        vmovups   1712(%rsp), %xmm0                             #244.5[spill]
        vpand     %xmm1, %xmm11, %xmm12                         #244.5
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vpxor     %xmm13, %xmm0, %xmm11                         #244.5
        vmovdqu   %xmm1, 32(%rsp)                               #244.5[spill]
        vmovups   1248(%rsp), %xmm1                             #244.5[spill]
        vmovups   1696(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 48(%rsp)                               #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 64(%rsp)                               #244.5[spill]
        vmovups   1264(%rsp), %xmm0                             #244.5[spill]
        vmovups   1680(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 80(%rsp)                              #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 96(%rsp)                              #244.5[spill]
        vmovups   1280(%rsp), %xmm13                            #244.5[spill]
        vmovups   1664(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 112(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 128(%rsp)                              #244.5[spill]
        vmovups   1296(%rsp), %xmm1                             #244.5[spill]
        vmovups   1648(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 144(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 160(%rsp)                              #244.5[spill]
        vmovups   1312(%rsp), %xmm0                             #244.5[spill]
        vmovups   1632(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 176(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 192(%rsp)                             #244.5[spill]
        vmovups   1216(%rsp), %xmm0                             #244.5[spill]
        vmovups   1344(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 208(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 224(%rsp)                              #244.5[spill]
        vmovups   832(%rsp), %xmm13                             #244.5[spill]
        vmovups   1328(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 240(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 256(%rsp)                              #244.5[spill]
        vmovups   848(%rsp), %xmm1                              #244.5[spill]
        vmovups   1360(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 272(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 288(%rsp)                             #244.5[spill]
        vmovups   864(%rsp), %xmm0                              #244.5[spill]
        vmovups   1376(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 304(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 320(%rsp)                              #244.5[spill]
        vmovups   880(%rsp), %xmm13                             #244.5[spill]
        vmovups   1408(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 336(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 352(%rsp)                              #244.5[spill]
        vmovups   896(%rsp), %xmm1                              #244.5[spill]
        vmovups   1392(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 368(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 384(%rsp)                             #244.5[spill]
        vmovups   912(%rsp), %xmm0                              #244.5[spill]
        vmovups   1424(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 400(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 416(%rsp)                              #244.5[spill]
        vmovups   928(%rsp), %xmm13                             #244.5[spill]
        vmovups   1440(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 432(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 448(%rsp)                              #244.5[spill]
        vmovups   944(%rsp), %xmm1                              #244.5[spill]
        vmovups   1472(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 464(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 480(%rsp)                             #244.5[spill]
        vmovups   960(%rsp), %xmm0                              #244.5[spill]
        vmovups   1456(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 496(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 512(%rsp)                              #244.5[spill]
        vmovups   976(%rsp), %xmm13                             #244.5[spill]
        vmovups   1488(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 528(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 544(%rsp)                              #244.5[spill]
        vmovups   992(%rsp), %xmm1                              #244.5[spill]
        vmovups   1504(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 560(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 576(%rsp)                             #244.5[spill]
        vmovups   1008(%rsp), %xmm0                             #244.5[spill]
        vmovups   1520(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 592(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 608(%rsp)                              #244.5[spill]
        vmovups   1024(%rsp), %xmm13                            #244.5[spill]
        vmovups   1552(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 624(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 640(%rsp)                              #244.5[spill]
        vmovups   1040(%rsp), %xmm1                             #244.5[spill]
        vmovups   1536(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 656(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 672(%rsp)                             #244.5[spill]
        vmovups   1056(%rsp), %xmm0                             #244.5[spill]
        vmovups   1568(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 688(%rsp)                              #244.5[spill]
        vpand     %xmm13, %xmm0, %xmm1                          #244.5
        vmovdqu   %xmm1, 704(%rsp)                              #244.5[spill]
        vmovups   1072(%rsp), %xmm13                            #244.5[spill]
        vmovups   1584(%rsp), %xmm1                             #244.5[spill]
        vpxor     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 720(%rsp)                              #244.5[spill]
        vpand     %xmm1, %xmm13, %xmm0                          #244.5
        vmovdqu   %xmm0, 736(%rsp)                              #244.5[spill]
        vmovups   1088(%rsp), %xmm1                             #244.5[spill]
        vmovups   1600(%rsp), %xmm0                             #244.5[spill]
        vpxor     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 752(%rsp)                             #244.5[spill]
        vpand     %xmm0, %xmm1, %xmm13                          #244.5
        vmovdqu   %xmm13, 768(%rsp)                             #244.5[spill]
        vmovups   1104(%rsp), %xmm1                             #244.5[spill]
        vmovups   1616(%rsp), %xmm13                            #244.5[spill]
        vpxor     %xmm13, %xmm1, %xmm0                          #244.5
        vpand     %xmm13, %xmm1, %xmm1                          #244.5
        vpxor     %xmm13, %xmm13, %xmm13                        #244.5
        vpxor     %xmm13, %xmm15, %xmm15                        #244.5
        vpxor     %xmm13, %xmm2, %xmm13                         #244.5
        vpxor     %xmm13, %xmm14, %xmm2                         #244.5
        vpand     %xmm14, %xmm13, %xmm14                        #244.5
        vpxor     %xmm14, %xmm4, %xmm13                         #244.5
        vpxor     %xmm13, %xmm3, %xmm4                          #244.5
        vpand     %xmm3, %xmm13, %xmm3                          #244.5
        vpxor     %xmm3, %xmm6, %xmm6                           #244.5
        vpxor     %xmm6, %xmm5, %xmm13                          #244.5
        vpand     %xmm5, %xmm6, %xmm5                           #244.5
        vpxor     %xmm5, %xmm8, %xmm8                           #244.5
        vmovdqu   %xmm13, 1888(%rsp)                            #244.5[spill]
        vpxor     %xmm8, %xmm7, %xmm13                          #244.5
        vpand     %xmm7, %xmm8, %xmm7                           #244.5
        vpxor     %xmm7, %xmm10, %xmm6                          #244.5
        vpxor     %xmm6, %xmm9, %xmm10                          #244.5
        vpand     %xmm9, %xmm6, %xmm9                           #244.5
        vpxor     %xmm9, %xmm12, %xmm5                          #244.5
        vpxor     %xmm5, %xmm11, %xmm12                         #244.5
        vpand     %xmm11, %xmm5, %xmm11                         #244.5
        vmovdqu   %xmm2, 1856(%rsp)                             #244.5[spill]
        vpxor     32(%rsp), %xmm11, %xmm3                       #244.5[spill]
        vmovdqu   48(%rsp), %xmm2                               #244.5[spill]
        vpand     %xmm2, %xmm3, %xmm14                          #244.5
        vmovdqu   %xmm13, 1904(%rsp)                            #244.5[spill]
        vmovdqu   %xmm12, 1936(%rsp)                            #244.5[spill]
        vpxor     64(%rsp), %xmm14, %xmm13                      #244.5[spill]
        vmovdqu   80(%rsp), %xmm12                              #244.5[spill]
        vpand     %xmm12, %xmm13, %xmm11                        #244.5
        vpxor     96(%rsp), %xmm11, %xmm9                       #244.5[spill]
        vmovdqu   112(%rsp), %xmm8                              #244.5[spill]
        vpand     %xmm8, %xmm9, %xmm7                           #244.5
        vmovdqu   %xmm4, 1872(%rsp)                             #244.5[spill]
        vpxor     %xmm3, %xmm2, %xmm4                           #244.5
        vmovdqu   %xmm4, 1952(%rsp)                             #244.5[spill]
        vpxor     128(%rsp), %xmm7, %xmm5                       #244.5[spill]
        vmovdqu   144(%rsp), %xmm4                              #244.5[spill]
        vpand     %xmm4, %xmm5, %xmm3                           #244.5
        vpxor     %xmm5, %xmm4, %xmm6                           #244.5
        vmovdqu   %xmm15, 1840(%rsp)                            #244.5[spill]
        vpxor     %xmm13, %xmm12, %xmm15                        #244.5
        vmovdqu   %xmm15, 1968(%rsp)                            #244.5[spill]
        vpxor     160(%rsp), %xmm3, %xmm14                      #244.5[spill]
        vmovdqu   176(%rsp), %xmm15                             #244.5[spill]
        vpand     %xmm15, %xmm14, %xmm13                        #244.5
        vpxor     %xmm14, %xmm15, %xmm2                         #244.5
        vmovdqu   %xmm10, 1920(%rsp)                            #244.5[spill]
        vpxor     %xmm9, %xmm8, %xmm10                          #244.5
        vmovdqu   %xmm10, 1984(%rsp)                            #244.5[spill]
        vpxor     192(%rsp), %xmm13, %xmm11                     #244.5[spill]
        vmovdqu   208(%rsp), %xmm10                             #244.5[spill]
        vpand     %xmm10, %xmm11, %xmm9                         #244.5
        vpxor     %xmm11, %xmm10, %xmm12                        #244.5
        vpxor     224(%rsp), %xmm9, %xmm8                       #244.5[spill]
        vmovdqu   240(%rsp), %xmm7                              #244.5[spill]
        vmovdqu   %xmm6, 2000(%rsp)                             #244.5[spill]
        vpand     %xmm7, %xmm8, %xmm6                           #244.5
        vpxor     256(%rsp), %xmm6, %xmm5                       #244.5[spill]
        vpxor     %xmm8, %xmm7, %xmm13                          #244.5
        vmovdqu   272(%rsp), %xmm4                              #244.5[spill]
        vpand     %xmm4, %xmm5, %xmm3                           #244.5
        vmovdqu   %xmm2, 2016(%rsp)                             #244.5[spill]
        vpxor     288(%rsp), %xmm3, %xmm2                       #244.5[spill]
        vmovdqu   304(%rsp), %xmm14                             #244.5[spill]
        vpand     %xmm14, %xmm2, %xmm15                         #244.5
        vpxor     %xmm2, %xmm14, %xmm11                         #244.5
        vpxor     320(%rsp), %xmm15, %xmm9                      #244.5[spill]
        vmovdqu   336(%rsp), %xmm8                              #244.5[spill]
        vpand     %xmm8, %xmm9, %xmm7                           #244.5
        vpxor     %xmm9, %xmm8, %xmm10                          #244.5
        vpxor     352(%rsp), %xmm7, %xmm6                       #244.5[spill]
        vmovdqu   %xmm12, 2032(%rsp)                            #244.5[spill]
        vpxor     %xmm5, %xmm4, %xmm12                          #244.5
        vmovdqu   368(%rsp), %xmm5                              #244.5[spill]
        vpand     %xmm5, %xmm6, %xmm4                           #244.5
        vpxor     %xmm6, %xmm5, %xmm9                           #244.5
        vpxor     384(%rsp), %xmm4, %xmm3                       #244.5[spill]
        vmovdqu   400(%rsp), %xmm2                              #244.5[spill]
        vpand     %xmm2, %xmm3, %xmm14                          #244.5
        vpxor     %xmm3, %xmm2, %xmm8                           #244.5
        vpxor     416(%rsp), %xmm14, %xmm15                     #244.5[spill]
        vmovdqu   432(%rsp), %xmm6                              #244.5[spill]
        vpand     %xmm6, %xmm15, %xmm5                          #244.5
        vpxor     %xmm15, %xmm6, %xmm7                          #244.5
        vpxor     448(%rsp), %xmm5, %xmm4                       #244.5[spill]
        vmovdqu   464(%rsp), %xmm3                              #244.5[spill]
        vpand     %xmm3, %xmm4, %xmm2                           #244.5
        vpxor     %xmm4, %xmm3, %xmm6                           #244.5
        vpxor     480(%rsp), %xmm2, %xmm14                      #244.5[spill]
        vmovdqu   496(%rsp), %xmm15                             #244.5[spill]
        vpand     %xmm15, %xmm14, %xmm4                         #244.5
        vpxor     %xmm14, %xmm15, %xmm5                         #244.5
        vpxor     512(%rsp), %xmm4, %xmm2                       #244.5[spill]
        vmovdqu   528(%rsp), %xmm14                             #244.5[spill]
        vpand     %xmm14, %xmm2, %xmm15                         #244.5
        vpxor     %xmm2, %xmm14, %xmm3                          #244.5
        vmovdqu   %xmm3, 2048(%rsp)                             #244.5[spill]
        vpxor     544(%rsp), %xmm15, %xmm3                      #244.5[spill]
        vmovdqu   560(%rsp), %xmm2                              #244.5[spill]
        vpand     %xmm2, %xmm3, %xmm14                          #244.5
        vpxor     %xmm3, %xmm2, %xmm4                           #244.5
        vpxor     576(%rsp), %xmm14, %xmm15                     #244.5[spill]
        vmovdqu   592(%rsp), %xmm2                              #244.5[spill]
        vpand     %xmm2, %xmm15, %xmm14                         #244.5
        vpxor     %xmm15, %xmm2, %xmm3                          #244.5
        vpxor     608(%rsp), %xmm14, %xmm2                      #244.5[spill]
        vmovdqu   624(%rsp), %xmm14                             #244.5[spill]
        vpxor     %xmm2, %xmm14, %xmm15                         #244.5
        vmovdqu   %xmm15, 784(%rsp)                             #244.5[spill]
        vpand     %xmm14, %xmm2, %xmm15                         #244.5
        vpxor     640(%rsp), %xmm15, %xmm14                     #244.5[spill]
        vmovdqu   656(%rsp), %xmm15                             #244.5[spill]
        vpxor     %xmm14, %xmm15, %xmm2                         #244.5
        vmovdqu   %xmm2, 800(%rsp)                              #244.5[spill]
        vpand     %xmm15, %xmm14, %xmm2                         #244.5
        vpxor     672(%rsp), %xmm2, %xmm15                      #244.5[spill]
        vmovdqu   688(%rsp), %xmm2                              #244.5[spill]
        vpxor     %xmm15, %xmm2, %xmm14                         #244.5
        vmovdqu   %xmm14, 2080(%rsp)                            #244.5[spill]
        vpand     %xmm2, %xmm15, %xmm14                         #244.5
        vpxor     704(%rsp), %xmm14, %xmm2                      #244.5[spill]
        vmovdqu   720(%rsp), %xmm14                             #244.5[spill]
        vpxor     %xmm2, %xmm14, %xmm15                         #244.5
        vmovdqu   %xmm15, 816(%rsp)                             #244.5[spill]
        vpand     %xmm14, %xmm2, %xmm15                         #244.5
        vpxor     736(%rsp), %xmm15, %xmm14                     #244.5[spill]
        vmovdqu   752(%rsp), %xmm15                             #244.5[spill]
        vpxor     %xmm14, %xmm15, %xmm2                         #244.5
        vmovdqu   %xmm2, 2064(%rsp)                             #244.5[spill]
        vpand     %xmm15, %xmm14, %xmm2                         #244.5
        vpxor     768(%rsp), %xmm2, %xmm14                      #244.5[spill]
        vpxor     %xmm14, %xmm0, %xmm2                          #244.5
        vpand     %xmm0, %xmm14, %xmm0                          #244.5
        vpxor     %xmm0, %xmm1, %xmm1                           #244.5
        vpxor     16(%rsp), %xmm1, %xmm15                       #244.5[spill]
        vmovdqu   784(%rsp), %xmm0                              #244.5[spill]
        vmovdqu   800(%rsp), %xmm1                              #244.5[spill]
        vmovdqu   816(%rsp), %xmm14                             #244.5[spill]
        vmovdqu   %xmm15, 2096(%rsp)                            #244.5[spill]
                                # LOE rax rbx r13 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.286:                       # Preds ..B1.286 ..B1.285
                                # Execution count [5.00e+00]
        vmovdqu   2000(%rsp), %xmm15                            #244.5[spill]
        lea       (%rax,%r13), %rsi                             #244.5
        vmovdqu   %xmm15, 160(%rsi)                             #244.5
        incl      %edx                                          #243.29
        vmovdqu   2016(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 176(%rsi)                             #244.5
        vmovdqu   2032(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 192(%rsi)                             #244.5
        vmovdqu   2048(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 352(%rsi)                             #244.5
        vmovdqu   2080(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 432(%rsi)                             #244.5
        vmovdqu   2064(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 464(%rsi)                             #244.5
        vmovdqu   2096(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 496(%rsi)                             #244.5
        vmovdqu   1840(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, (%rsi)                                #244.5
        vmovdqu   1856(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 16(%rsi)                              #244.5
        vmovdqu   1872(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 32(%rsi)                              #244.5
        vmovdqu   1888(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 48(%rsi)                              #244.5
        vmovdqu   1904(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 64(%rsi)                              #244.5
        vmovdqu   1920(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 80(%rsi)                              #244.5
        vmovdqu   1936(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 96(%rsi)                              #244.5
        vmovdqu   1952(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 112(%rsi)                             #244.5
        vmovdqu   1968(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm15, 128(%rsi)                             #244.5
        vmovdqu   1984(%rsp), %xmm15                            #244.5[spill]
        vmovdqu   %xmm13, 208(%rsi)                             #244.5
        vmovdqu   %xmm12, 224(%rsi)                             #244.5
        vmovdqu   %xmm11, 240(%rsi)                             #244.5
        vmovdqu   %xmm10, 256(%rsi)                             #244.5
        vmovdqu   %xmm9, 272(%rsi)                              #244.5
        vmovdqu   %xmm8, 288(%rsi)                              #244.5
        vmovdqu   %xmm7, 304(%rsi)                              #244.5
        vmovdqu   %xmm6, 320(%rsi)                              #244.5
        vmovdqu   %xmm5, 336(%rsi)                              #244.5
        vmovdqu   %xmm4, 368(%rsi)                              #244.5
        vmovdqu   %xmm3, 384(%rsi)                              #244.5
        vmovdqu   %xmm0, 400(%rsi)                              #244.5
        vmovdqu   %xmm1, 416(%rsi)                              #244.5
        vmovdqu   %xmm14, 448(%rsi)                             #244.5
        vmovdqu   %xmm2, 480(%rsi)                              #244.5
        addq      $512, %rax                                    #243.29
        vmovdqu   %xmm15, 144(%rsi)                             #244.5
        cmpl      $1000000, %edx                                #243.23
        jl        ..B1.285      # Prob 82%                      #243.23
                                # LOE rax rbx r13 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.287:                       # Preds ..B1.286
                                # Execution count [1.00e+00]
        rdtscp                                                   #249.9
        shlq      $32, %rdx                                     #249.9
        orq       %rdx, %rax                                    #249.9
                                # LOE rax rbx r13 r14
..B1.288:                       # Preds ..B1.287
                                # Execution count [1.00e+00]
        subq      %rbx, %rax                                    #250.3
        movl      $.L_2__STRING.3, %edi                         #250.3
        movq      %rax, %rsi                                    #250.3
        xorl      %eax, %eax                                    #250.3
..___tag_value_main.19:
#       printf(const char *__restrict__, ...)
        call      printf                                        #250.3
..___tag_value_main.20:
                                # LOE r13 r14
..B1.289:                       # Preds ..B1.288
                                # Execution count [1.00e+00]
        movq      %r13, %rdi                                    #251.3
        movl      $16, %esi                                     #251.3
        movl      $32000000, %edx                               #251.3
        movq      %r14, %rcx                                    #251.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #251.3
                                # LOE r13 r14
..B1.290:                       # Preds ..B1.289
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.5, %edi                         #253.3
        xorl      %eax, %eax                                    #253.3
..___tag_value_main.21:
#       printf(const char *__restrict__, ...)
        call      printf                                        #253.3
..___tag_value_main.22:
                                # LOE r13 r14
..B1.291:                       # Preds ..B1.290
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #253.27
#       fflush(FILE *)
        call      fflush                                        #253.27
                                # LOE r13 r14
..B1.292:                       # Preds ..B1.291
                                # Execution count [1.00e+00]
        rdtscp                                                   #254.11
        shlq      $32, %rdx                                     #254.11
        orq       %rdx, %rax                                    #254.11
                                # LOE rax r13 r14
..B1.585:                       # Preds ..B1.292
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #254.11
                                # LOE r8 r13 r14
..B1.293:                       # Preds ..B1.585
                                # Execution count [9.00e-01]
        movq      %r13, %rax                                    #255.14
        xorl      %edx, %edx                                    #255.14
        movq      %rax, %rbx                                    #255.14
                                # LOE rax rbx r8 r13 r14 edx
..B1.294:                       # Preds ..B1.296 ..B1.293
                                # Execution count [5.00e+00]
        xorb      %r9b, %r9b                                    #256.5
        xorl      %esi, %esi                                    #256.5
                                # LOE rax rbx rsi r8 r13 r14 edx r9b
..B1.295:                       # Preds ..B1.295 ..B1.294
                                # Execution count [1.60e+02]
        vmovdqu   2112(%rsp,%rsi), %xmm0                        #256.5
        incb      %r9b                                          #256.5
        vpaddb    2624(%rsp,%rsi), %xmm0, %xmm1                 #256.5
        vmovdqu   %xmm1, (%rsi,%rax)                            #256.5
        addq      $16, %rsi                                     #256.5
        cmpb      $32, %r9b                                     #256.5
        jl        ..B1.295      # Prob 96%                      #256.5
                                # LOE rax rbx rsi r8 r13 r14 edx r9b
..B1.296:                       # Preds ..B1.295
                                # Execution count [5.00e+00]
        incl      %edx                                          #255.29
        addq      $512, %rax                                    #255.29
        cmpl      $1000000, %edx                                #255.23
        jl        ..B1.294      # Prob 82%                      #255.23
                                # LOE rax rbx r8 r13 r14 edx
..B1.297:                       # Preds ..B1.296
                                # Execution count [1.00e+00]
        rdtscp                                                   #257.9
        shlq      $32, %rdx                                     #257.9
        orq       %rdx, %rax                                    #257.9
                                # LOE rax rbx r8 r13 r14
..B1.298:                       # Preds ..B1.297
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #258.3
        movl      $.L_2__STRING.3, %edi                         #258.3
        movq      %rax, %rsi                                    #258.3
        xorl      %eax, %eax                                    #258.3
..___tag_value_main.23:
#       printf(const char *__restrict__, ...)
        call      printf                                        #258.3
..___tag_value_main.24:
                                # LOE rbx r13 r14
..B1.299:                       # Preds ..B1.298
                                # Execution count [1.00e+00]
        movq      %r13, %rdi                                    #259.3
        movl      $16, %esi                                     #259.3
        movl      $32000000, %edx                               #259.3
        movq      %r14, %rcx                                    #259.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #259.3
                                # LOE rbx r13 r14
..B1.300:                       # Preds ..B1.299
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.6, %edi                         #261.3
        xorl      %eax, %eax                                    #261.3
..___tag_value_main.25:
#       printf(const char *__restrict__, ...)
        call      printf                                        #261.3
..___tag_value_main.26:
                                # LOE rbx r13 r14
..B1.301:                       # Preds ..B1.300
                                # Execution count [1.00e+00]
        movq      stdout(%rip), %rdi                            #261.27
#       fflush(FILE *)
        call      fflush                                        #261.27
                                # LOE rbx r13 r14
..B1.302:                       # Preds ..B1.301
                                # Execution count [1.00e+00]
        rdtscp                                                   #262.11
        shlq      $32, %rdx                                     #262.11
        orq       %rdx, %rax                                    #262.11
                                # LOE rax rbx r13 r14
..B1.587:                       # Preds ..B1.302
                                # Execution count [1.00e+00]
        movq      %rax, %r8                                     #262.11
                                # LOE rbx r8 r13 r14
..B1.303:                       # Preds ..B1.587
                                # Execution count [9.00e-01]
        xorl      %eax, %eax                                    #263.14
        vpxor     %xmm1, %xmm1, %xmm1                           #263.14
                                # LOE rbx r8 r13 r14 eax xmm1
..B1.304:                       # Preds ..B1.306 ..B1.303
                                # Execution count [5.00e+00]
        vmovdqa   %xmm1, %xmm0                                  #264.5
        xorb      %sil, %sil                                    #264.5
        xorl      %edx, %edx                                    #264.5
                                # LOE rdx rbx r8 r13 r14 eax sil xmm0 xmm1
..B1.305:                       # Preds ..B1.305 ..B1.304
                                # Execution count [1.60e+02]
        vmovdqu   2112(%rsp,%rdx), %xmm2                        #264.22
        incb      %sil                                          #264.5
        vmovdqu   2624(%rsp,%rdx), %xmm3                        #264.24
        vpxor     %xmm3, %xmm2, %xmm4                           #264.5
        vpand     %xmm3, %xmm2, %xmm5                           #264.5
        vpxor     %xmm0, %xmm4, %xmm6                           #264.5
        vpand     %xmm4, %xmm0, %xmm0                           #264.5
        vmovdqu   %xmm6, (%rdx,%rbx)                            #264.5
        addq      $16, %rdx                                     #264.5
        vpxor     %xmm0, %xmm5, %xmm0                           #264.5
        cmpb      $32, %sil                                     #264.5
        jl        ..B1.305      # Prob 96%                      #264.5
                                # LOE rdx rbx r8 r13 r14 eax sil xmm0 xmm1
..B1.306:                       # Preds ..B1.305
                                # Execution count [5.00e+00]
        incl      %eax                                          #263.29
        addq      $512, %rbx                                    #263.29
        cmpl      $1000000, %eax                                #263.23
        jl        ..B1.304      # Prob 82%                      #263.23
                                # LOE rbx r8 r13 r14 eax xmm1
..B1.307:                       # Preds ..B1.306
                                # Execution count [1.00e+00]
        rdtscp                                                   #265.9
        shlq      $32, %rdx                                     #265.9
        orq       %rdx, %rax                                    #265.9
                                # LOE rax r8 r13 r14
..B1.308:                       # Preds ..B1.307
                                # Execution count [1.00e+00]
        subq      %r8, %rax                                     #266.3
        movl      $.L_2__STRING.3, %edi                         #266.3
        movq      %rax, %rsi                                    #266.3
        xorl      %eax, %eax                                    #266.3
..___tag_value_main.27:
#       printf(const char *__restrict__, ...)
        call      printf                                        #266.3
..___tag_value_main.28:
                                # LOE r13 r14
..B1.309:                       # Preds ..B1.308
                                # Execution count [1.00e+00]
        movq      %r13, %rdi                                    #267.3
        movl      $16, %esi                                     #267.3
        movl      $32000000, %edx                               #267.3
        movq      %r14, %rcx                                    #267.3
#       fwrite(const void *__restrict__, size_t, size_t, FILE *__restrict__)
        call      fwrite                                        #267.3
                                # LOE
..B1.310:                       # Preds ..B1.309
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #269.10
        addq      $3160, %rsp                                   #269.10
	.cfi_restore 3
        popq      %rbx                                          #269.10
	.cfi_restore 15
        popq      %r15                                          #269.10
	.cfi_restore 14
        popq      %r14                                          #269.10
	.cfi_restore 13
        popq      %r13                                          #269.10
	.cfi_restore 12
        popq      %r12                                          #269.10
        movq      %rbp, %rsp                                    #269.10
        popq      %rbp                                          #269.10
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #269.10
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
# --- add_pack(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_pack:
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
# parameter 33: 400 + %rbp
# parameter 34: 416 + %rbp
# parameter 35: 432 + %rbp
# parameter 36: 448 + %rbp
# parameter 37: 464 + %rbp
# parameter 38: 480 + %rbp
# parameter 39: 496 + %rbp
# parameter 40: 512 + %rbp
# parameter 41: 528 + %rbp
# parameter 42: 544 + %rbp
# parameter 43: 560 + %rbp
# parameter 44: 576 + %rbp
# parameter 45: 592 + %rbp
# parameter 46: 608 + %rbp
# parameter 47: 624 + %rbp
# parameter 48: 640 + %rbp
# parameter 49: 656 + %rbp
# parameter 50: 672 + %rbp
# parameter 51: 688 + %rbp
# parameter 52: 704 + %rbp
# parameter 53: 720 + %rbp
# parameter 54: 736 + %rbp
# parameter 55: 752 + %rbp
# parameter 56: 768 + %rbp
# parameter 57: 784 + %rbp
# parameter 58: 800 + %rbp
# parameter 59: 816 + %rbp
# parameter 60: 832 + %rbp
# parameter 61: 848 + %rbp
# parameter 62: 864 + %rbp
# parameter 63: 880 + %rbp
# parameter 64: 896 + %rbp
# parameter 65: %rdi
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_pack.37:
..L38:
                                                         #27.40
        pushq     %rbp                                          #27.40
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #27.40
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        vpaddd    400(%rbp), %xmm0, %xmm0                       #28.12
        vmovdqu   16(%rbp), %xmm8                               #27.40
        vmovdqu   32(%rbp), %xmm9                               #27.40
        vmovdqu   48(%rbp), %xmm10                              #27.40
        vmovdqu   64(%rbp), %xmm11                              #27.40
        vmovdqu   %xmm0, (%rdi)                                 #28.3
        vmovdqu   80(%rbp), %xmm12                              #27.40
        vmovdqu   144(%rbp), %xmm0                              #27.40
        vpaddd    512(%rbp), %xmm7, %xmm7                       #35.12
        vpaddd    528(%rbp), %xmm8, %xmm8                       #36.12
        vmovdqu   96(%rbp), %xmm13                              #27.40
        vmovdqu   112(%rbp), %xmm14                             #27.40
        vpaddd    544(%rbp), %xmm9, %xmm9                       #37.12
        vpaddd    560(%rbp), %xmm10, %xmm10                     #38.13
        vmovdqu   128(%rbp), %xmm15                             #27.40
        vpaddd    576(%rbp), %xmm11, %xmm11                     #39.13
        vpaddd    592(%rbp), %xmm12, %xmm12                     #40.13
        vpaddd    656(%rbp), %xmm0, %xmm0                       #44.13
        vmovdqu   %xmm7, 112(%rdi)                              #35.3
        vmovdqu   256(%rbp), %xmm7                              #27.40
        vmovdqu   %xmm8, 128(%rdi)                              #36.3
        vpaddd    608(%rbp), %xmm13, %xmm13                     #41.13
        vpaddd    624(%rbp), %xmm14, %xmm14                     #42.13
        vmovdqu   272(%rbp), %xmm8                              #27.40
        vmovdqu   %xmm9, 144(%rdi)                              #37.3
        vpaddd    416(%rbp), %xmm1, %xmm1                       #29.12
        vpaddd    432(%rbp), %xmm2, %xmm2                       #30.12
        vpaddd    448(%rbp), %xmm3, %xmm3                       #31.12
        vpaddd    464(%rbp), %xmm4, %xmm4                       #32.12
        vpaddd    480(%rbp), %xmm5, %xmm5                       #33.12
        vpaddd    496(%rbp), %xmm6, %xmm6                       #34.12
        vmovdqu   288(%rbp), %xmm9                              #27.40
        vmovdqu   %xmm10, 160(%rdi)                             #38.3
        vpaddd    640(%rbp), %xmm15, %xmm15                     #43.13
        vmovdqu   304(%rbp), %xmm10                             #27.40
        vmovdqu   %xmm11, 176(%rdi)                             #39.3
        vmovdqu   320(%rbp), %xmm11                             #27.40
        vmovdqu   %xmm12, 192(%rdi)                             #40.3
        vmovdqu   %xmm0, 256(%rdi)                              #44.3
        vmovdqu   336(%rbp), %xmm12                             #27.40
        vmovdqu   %xmm13, 208(%rdi)                             #41.3
        vpaddd    768(%rbp), %xmm7, %xmm0                       #51.13
        vpaddd    784(%rbp), %xmm8, %xmm7                       #52.13
        vmovdqu   352(%rbp), %xmm13                             #27.40
        vmovdqu   %xmm14, 224(%rdi)                             #42.3
        vmovdqu   %xmm1, 16(%rdi)                               #29.3
        vmovdqu   %xmm2, 32(%rdi)                               #30.3
        vmovdqu   %xmm3, 48(%rdi)                               #31.3
        vmovdqu   %xmm4, 64(%rdi)                               #32.3
        vmovdqu   %xmm5, 80(%rdi)                               #33.3
        vmovdqu   %xmm6, 96(%rdi)                               #34.3
        vmovdqu   368(%rbp), %xmm14                             #27.40
        vmovdqu   %xmm15, 240(%rdi)                             #43.3
        vpaddd    800(%rbp), %xmm9, %xmm8                       #53.13
        vpaddd    816(%rbp), %xmm10, %xmm9                      #54.13
        vmovdqu   160(%rbp), %xmm1                              #27.40
        vmovdqu   176(%rbp), %xmm2                              #27.40
        vmovdqu   192(%rbp), %xmm3                              #27.40
        vmovdqu   208(%rbp), %xmm4                              #27.40
        vmovdqu   224(%rbp), %xmm5                              #27.40
        vmovdqu   240(%rbp), %xmm6                              #27.40
        vmovdqu   384(%rbp), %xmm15                             #27.40
        vpaddd    832(%rbp), %xmm11, %xmm10                     #55.13
        vpaddd    848(%rbp), %xmm12, %xmm11                     #56.13
        vpaddd    864(%rbp), %xmm13, %xmm12                     #57.13
        vpaddd    880(%rbp), %xmm14, %xmm13                     #58.13
        vpaddd    896(%rbp), %xmm15, %xmm14                     #59.13
        vpaddd    672(%rbp), %xmm1, %xmm1                       #45.13
        vpaddd    688(%rbp), %xmm2, %xmm2                       #46.13
        vpaddd    704(%rbp), %xmm3, %xmm3                       #47.13
        vpaddd    720(%rbp), %xmm4, %xmm4                       #48.13
        vpaddd    736(%rbp), %xmm5, %xmm5                       #49.13
        vpaddd    752(%rbp), %xmm6, %xmm6                       #50.13
        vmovdqu   %xmm1, 272(%rdi)                              #45.3
        vmovdqu   %xmm2, 288(%rdi)                              #46.3
        vmovdqu   %xmm3, 304(%rdi)                              #47.3
        vmovdqu   %xmm4, 320(%rdi)                              #48.3
        vmovdqu   %xmm5, 336(%rdi)                              #49.3
        vmovdqu   %xmm6, 352(%rdi)                              #50.3
        vmovdqu   %xmm0, 368(%rdi)                              #51.3
        vmovdqu   %xmm7, 384(%rdi)                              #52.3
        vmovdqu   %xmm8, 400(%rdi)                              #53.3
        vmovdqu   %xmm9, 416(%rdi)                              #54.3
        vmovdqu   %xmm10, 432(%rdi)                             #55.3
        vmovdqu   %xmm11, 448(%rdi)                             #56.3
        vmovdqu   %xmm12, 464(%rdi)                             #57.3
        vmovdqu   %xmm13, 480(%rdi)                             #58.3
        vmovdqu   %xmm14, 496(%rdi)                             #59.3
        movq      %rbp, %rsp                                    #60.1
        popq      %rbp                                          #60.1
	.cfi_restore 6
        ret                                                     #60.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_pack,@function
	.size	add_pack,.-add_pack
	.data
# -- End  add_pack
	.text
# -- Begin  add_pack_arr
	.text
# mark_begin;
       .align    16,0x90
	.globl add_pack_arr
# --- add_pack_arr(__m128i *, __m128i *, __m128i *__restrict__)
add_pack_arr:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_pack_arr.44:
..L45:
                                                         #62.73
        movq      %rdx, %rcx                                    #62.73
        xorb      %dl, %dl                                      #63.14
        xorl      %eax, %eax                                    #63.14
                                # LOE rax rcx rbx rbp rsi rdi r12 r13 r14 r15 dl
..B3.2:                         # Preds ..B3.2 ..B3.1
                                # Execution count [3.20e+01]
        vmovdqu   (%rax,%rdi), %xmm0                            #64.14
        incb      %dl                                           #63.27
        vpaddb    (%rax,%rsi), %xmm0, %xmm1                     #64.14
        vmovdqu   %xmm1, (%rax,%rcx)                            #64.5
        addq      $16, %rax                                     #63.27
        cmpb      $32, %dl                                      #63.23
        jl        ..B3.2        # Prob 96%                      #63.23
                                # LOE rax rcx rbx rbp rsi rdi r12 r13 r14 r15 dl
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
        ret                                                     #66.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_pack_arr,@function
	.size	add_pack_arr,.-add_pack_arr
	.data
# -- End  add_pack_arr
	.text
# -- Begin  add
	.text
# mark_begin;
       .align    16,0x90
	.globl add
# --- add(__m128i, __m128i, __m128i *__restrict__)
add:
# parameter 1: %xmm0
# parameter 2: %xmm1
# parameter 3: %rdi
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add.47:
..L48:
                                                         #69.56
        vpxor     %xmm1, %xmm0, %xmm5                           #70.21
        vmovdqu   (%rdi), %xmm6                                 #71.24
        vpand     %xmm1, %xmm0, %xmm2                           #72.10
        vpand     %xmm5, %xmm6, %xmm3                           #72.17
        vpxor     %xmm6, %xmm5, %xmm0                           #71.24
        vpxor     %xmm3, %xmm2, %xmm4                           #72.17
        vmovdqu   %xmm4, (%rdi)                                 #72.4
        ret                                                     #73.10
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
# --- add_bitslice(__m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i, __m128i *__restrict__)
add_bitslice:
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
# parameter 33: 400 + %rbp
# parameter 34: 416 + %rbp
# parameter 35: 432 + %rbp
# parameter 36: 448 + %rbp
# parameter 37: 464 + %rbp
# parameter 38: 480 + %rbp
# parameter 39: 496 + %rbp
# parameter 40: 512 + %rbp
# parameter 41: 528 + %rbp
# parameter 42: 544 + %rbp
# parameter 43: 560 + %rbp
# parameter 44: 576 + %rbp
# parameter 45: 592 + %rbp
# parameter 46: 608 + %rbp
# parameter 47: 624 + %rbp
# parameter 48: 640 + %rbp
# parameter 49: 656 + %rbp
# parameter 50: 672 + %rbp
# parameter 51: 688 + %rbp
# parameter 52: 704 + %rbp
# parameter 53: 720 + %rbp
# parameter 54: 736 + %rbp
# parameter 55: 752 + %rbp
# parameter 56: 768 + %rbp
# parameter 57: 784 + %rbp
# parameter 58: 800 + %rbp
# parameter 59: 816 + %rbp
# parameter 60: 832 + %rbp
# parameter 61: 848 + %rbp
# parameter 62: 864 + %rbp
# parameter 63: 880 + %rbp
# parameter 64: 896 + %rbp
# parameter 65: %rdi
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bitslice.50:
..L51:
                                                         #92.43
        pushq     %rbp                                          #92.43
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #92.43
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        vmovdqu   400(%rbp), %xmm8                              #92.43
        vpxor     %xmm10, %xmm10, %xmm10                        #93.15
        vmovdqu   416(%rbp), %xmm12                             #92.43
        vpxor     %xmm8, %xmm0, %xmm9                           #94.12
        vpand     %xmm8, %xmm0, %xmm0                           #94.12
        vpxor     %xmm10, %xmm9, %xmm9                          #94.12
        vpxor     %xmm10, %xmm0, %xmm8                          #94.12
        vpxor     %xmm12, %xmm1, %xmm10                         #95.12
        vmovdqu   432(%rbp), %xmm13                             #92.43
        vpand     %xmm12, %xmm1, %xmm1                          #95.12
        vpand     %xmm10, %xmm8, %xmm12                         #95.12
        vpxor     %xmm8, %xmm10, %xmm0                          #95.12
        vpxor     %xmm12, %xmm1, %xmm1                          #95.12
        vpxor     %xmm13, %xmm2, %xmm8                          #96.12
        vmovdqu   448(%rbp), %xmm14                             #92.43
        vpand     %xmm13, %xmm2, %xmm2                          #96.12
        vpand     %xmm8, %xmm1, %xmm13                          #96.12
        vmovdqu   %xmm0, 16(%rdi)                               #95.3
        vpxor     %xmm1, %xmm8, %xmm0                           #96.12
        vpxor     %xmm13, %xmm2, %xmm1                          #96.12
        vpxor     %xmm14, %xmm3, %xmm2                          #97.12
        vmovdqu   464(%rbp), %xmm15                             #92.43
        vpand     %xmm14, %xmm3, %xmm3                          #97.12
        vpand     %xmm2, %xmm1, %xmm14                          #97.12
        vmovdqu   %xmm0, 32(%rdi)                               #96.3
        vpxor     %xmm1, %xmm2, %xmm0                           #97.12
        vpxor     %xmm14, %xmm3, %xmm1                          #97.12
        vpxor     %xmm15, %xmm4, %xmm2                          #98.12
        vmovdqu   %xmm0, 48(%rdi)                               #97.3
        vpand     %xmm15, %xmm4, %xmm4                          #98.12
        vpxor     %xmm1, %xmm2, %xmm0                           #98.12
        vpand     %xmm2, %xmm1, %xmm15                          #98.12
        vmovdqu   480(%rbp), %xmm1                              #99.12
        vpxor     %xmm15, %xmm4, %xmm2                          #98.12
        vpxor     %xmm1, %xmm5, %xmm3                           #99.12
        vpand     %xmm1, %xmm5, %xmm5                           #99.12
        vmovdqu   496(%rbp), %xmm1                              #100.12
        vmovdqu   %xmm0, 64(%rdi)                               #98.3
        vpxor     %xmm2, %xmm3, %xmm0                           #99.12
        vpand     %xmm3, %xmm2, %xmm2                           #99.12
        vpxor     %xmm1, %xmm6, %xmm4                           #100.12
        vpxor     %xmm2, %xmm5, %xmm3                           #99.12
        vpand     %xmm1, %xmm6, %xmm6                           #100.12
        vmovdqu   %xmm0, 80(%rdi)                               #99.3
        vpxor     %xmm3, %xmm4, %xmm0                           #100.12
        vmovdqu   512(%rbp), %xmm1                              #101.12
        vpand     %xmm4, %xmm3, %xmm3                           #100.12
        vpxor     %xmm3, %xmm6, %xmm2                           #100.12
        vpxor     %xmm1, %xmm7, %xmm4                           #101.12
        vmovdqu   %xmm9, (%rdi)                                 #94.3
        vpand     %xmm1, %xmm7, %xmm5                           #101.12
        vmovdqu   16(%rbp), %xmm8                               #102.12
        vpand     %xmm4, %xmm2, %xmm6                           #101.12
        vmovdqu   528(%rbp), %xmm9                              #102.12
        vpxor     %xmm6, %xmm5, %xmm10                          #101.12
        vpxor     %xmm9, %xmm8, %xmm12                          #102.12
        vpand     %xmm9, %xmm8, %xmm13                          #102.12
        vpxor     %xmm10, %xmm12, %xmm15                        #102.12
        vpand     %xmm12, %xmm10, %xmm14                        #102.12
        vmovdqu   %xmm0, 96(%rdi)                               #100.3
        vpxor     %xmm2, %xmm4, %xmm7                           #101.12
        vmovdqu   %xmm15, 128(%rdi)                             #102.3
        vpxor     %xmm14, %xmm13, %xmm1                         #102.12
        vmovdqu   32(%rbp), %xmm15                              #103.12
        vmovdqu   544(%rbp), %xmm0                              #103.12
        vpxor     %xmm0, %xmm15, %xmm2                          #103.12
        vpand     %xmm0, %xmm15, %xmm3                          #103.12
        vmovdqu   %xmm7, 112(%rdi)                              #101.3
        vpand     %xmm2, %xmm1, %xmm4                           #103.12
        vmovdqu   48(%rbp), %xmm6                               #104.13
        vpxor     %xmm4, %xmm3, %xmm8                           #103.12
        vmovdqu   560(%rbp), %xmm7                              #104.13
        vpxor     %xmm1, %xmm2, %xmm5                           #103.12
        vpxor     %xmm7, %xmm6, %xmm9                           #104.13
        vpand     %xmm7, %xmm6, %xmm10                          #104.13
        vpxor     %xmm8, %xmm9, %xmm13                          #104.13
        vpand     %xmm9, %xmm8, %xmm12                          #104.13
        vmovdqu   %xmm13, 160(%rdi)                             #104.3
        vpxor     %xmm12, %xmm10, %xmm0                         #104.13
        vmovdqu   64(%rbp), %xmm14                              #105.13
        vmovdqu   576(%rbp), %xmm13                             #105.13
        vpxor     %xmm13, %xmm14, %xmm1                         #105.13
        vpand     %xmm13, %xmm14, %xmm2                         #105.13
        vmovdqu   %xmm5, 144(%rdi)                              #103.3
        vpand     %xmm1, %xmm0, %xmm3                           #105.13
        vmovdqu   80(%rbp), %xmm5                               #106.13
        vpxor     %xmm3, %xmm2, %xmm7                           #105.13
        vmovdqu   592(%rbp), %xmm6                              #106.13
        vpxor     %xmm0, %xmm1, %xmm4                           #105.13
        vpxor     %xmm6, %xmm5, %xmm8                           #106.13
        vpand     %xmm6, %xmm5, %xmm9                           #106.13
        vmovdqu   608(%rbp), %xmm15                             #107.13
        vpand     %xmm8, %xmm7, %xmm10                          #106.13
        vmovdqu   96(%rbp), %xmm14                              #107.13
        vpxor     %xmm10, %xmm9, %xmm0                          #106.13
        vpxor     %xmm15, %xmm14, %xmm1                         #107.13
        vpand     %xmm15, %xmm14, %xmm2                         #107.13
        vmovdqu   112(%rbp), %xmm5                              #108.13
        vpand     %xmm1, %xmm0, %xmm3                           #107.13
        vmovdqu   624(%rbp), %xmm6                              #108.13
        vpxor     %xmm7, %xmm8, %xmm12                          #106.13
        vpxor     %xmm3, %xmm2, %xmm7                           #107.13
        vpxor     %xmm6, %xmm5, %xmm8                           #108.13
        vmovdqu   640(%rbp), %xmm14                             #109.13
        vpand     %xmm6, %xmm5, %xmm9                           #108.13
        vmovdqu   128(%rbp), %xmm13                             #109.13
        vpand     %xmm8, %xmm7, %xmm10                          #108.13
        vmovdqu   %xmm4, 176(%rdi)                              #105.3
        vpxor     %xmm0, %xmm1, %xmm4                           #107.13
        vpxor     %xmm10, %xmm9, %xmm15                         #108.13
        vpxor     %xmm14, %xmm13, %xmm0                         #109.13
        vmovdqu   %xmm4, 208(%rdi)                              #107.3
        vpand     %xmm14, %xmm13, %xmm1                         #109.13
        vmovdqu   144(%rbp), %xmm3                              #110.13
        vpxor     %xmm15, %xmm0, %xmm2                          #109.13
        vmovdqu   656(%rbp), %xmm4                              #110.13
        vpand     %xmm0, %xmm15, %xmm15                         #109.13
        vpxor     %xmm15, %xmm1, %xmm5                          #109.13
        vpxor     %xmm4, %xmm3, %xmm6                           #110.13
        vmovdqu   %xmm12, 192(%rdi)                             #106.3
        vpxor     %xmm7, %xmm8, %xmm12                          #108.13
        vmovdqu   %xmm12, 224(%rdi)                             #108.3
        vpand     %xmm4, %xmm3, %xmm7                           #110.13
        vmovdqu   160(%rbp), %xmm10                             #111.13
        vpand     %xmm6, %xmm5, %xmm8                           #110.13
        vmovdqu   672(%rbp), %xmm12                             #111.13
        vpxor     %xmm8, %xmm7, %xmm13                          #110.13
        vpxor     %xmm12, %xmm10, %xmm14                        #111.13
        vpand     %xmm12, %xmm10, %xmm0                         #111.13
        vmovdqu   %xmm2, 240(%rdi)                              #109.3
        vpxor     %xmm13, %xmm14, %xmm1                         #111.13
        vmovdqu   176(%rbp), %xmm2                              #112.13
        vpand     %xmm14, %xmm13, %xmm13                        #111.13
        vmovdqu   688(%rbp), %xmm3                              #112.13
        vpxor     %xmm5, %xmm6, %xmm9                           #110.13
        vpxor     %xmm13, %xmm0, %xmm4                          #111.13
        vpxor     %xmm3, %xmm2, %xmm5                           #112.13
        vmovdqu   %xmm9, 256(%rdi)                              #110.3
        vpand     %xmm3, %xmm2, %xmm6                           #112.13
        vmovdqu   192(%rbp), %xmm9                              #113.13
        vpand     %xmm5, %xmm4, %xmm7                           #112.13
        vmovdqu   704(%rbp), %xmm10                             #113.13
        vpxor     %xmm7, %xmm6, %xmm12                          #112.13
        vpxor     %xmm10, %xmm9, %xmm14                         #113.13
        vpand     %xmm10, %xmm9, %xmm15                         #113.13
        vmovdqu   %xmm1, 272(%rdi)                              #111.3
        vpxor     %xmm12, %xmm14, %xmm0                         #113.13
        vmovdqu   208(%rbp), %xmm1                              #114.13
        vpand     %xmm14, %xmm12, %xmm12                        #113.13
        vmovdqu   720(%rbp), %xmm2                              #114.13
        vpxor     %xmm4, %xmm5, %xmm8                           #112.13
        vpxor     %xmm12, %xmm15, %xmm3                         #113.13
        vpxor     %xmm2, %xmm1, %xmm4                           #114.13
        vmovdqu   %xmm8, 288(%rdi)                              #112.3
        vpand     %xmm2, %xmm1, %xmm5                           #114.13
        vmovdqu   224(%rbp), %xmm8                              #115.13
        vpand     %xmm4, %xmm3, %xmm6                           #114.13
        vmovdqu   736(%rbp), %xmm9                              #115.13
        vpxor     %xmm6, %xmm5, %xmm10                          #114.13
        vpxor     %xmm9, %xmm8, %xmm13                          #115.13
        vpand     %xmm9, %xmm8, %xmm14                          #115.13
        vmovdqu   752(%rbp), %xmm2                              #116.13
        vpand     %xmm13, %xmm10, %xmm15                        #115.13
        vmovdqu   240(%rbp), %xmm1                              #116.13
        vpxor     %xmm3, %xmm4, %xmm7                           #114.13
        vpxor     %xmm15, %xmm14, %xmm3                         #115.13
        vpxor     %xmm2, %xmm1, %xmm4                           #116.13
        vmovdqu   256(%rbp), %xmm8                              #117.13
        vpand     %xmm2, %xmm1, %xmm5                           #116.13
        vmovdqu   768(%rbp), %xmm9                              #117.13
        vpand     %xmm4, %xmm3, %xmm6                           #116.13
        vmovdqu   %xmm0, 304(%rdi)                              #113.3
        vpxor     %xmm10, %xmm13, %xmm0                         #115.13
        vpxor     %xmm6, %xmm5, %xmm10                          #116.13
        vpxor     %xmm9, %xmm8, %xmm12                          #117.13
        vpxor     %xmm10, %xmm12, %xmm15                        #117.13
        vpand     %xmm9, %xmm8, %xmm13                          #117.13
        vmovdqu   %xmm0, 336(%rdi)                              #115.3
        vpand     %xmm12, %xmm10, %xmm14                        #117.13
        vmovdqu   %xmm15, 368(%rdi)                             #117.3
        vpxor     %xmm14, %xmm13, %xmm1                         #117.13
        vmovdqu   272(%rbp), %xmm15                             #118.13
        vmovdqu   784(%rbp), %xmm0                              #118.13
        vpxor     %xmm0, %xmm15, %xmm2                          #118.13
        vmovdqu   %xmm7, 320(%rdi)                              #114.3
        vpxor     %xmm3, %xmm4, %xmm7                           #116.13
        vmovdqu   %xmm7, 352(%rdi)                              #116.3
        vpand     %xmm0, %xmm15, %xmm3                          #118.13
        vmovdqu   288(%rbp), %xmm6                              #119.13
        vpand     %xmm2, %xmm1, %xmm4                           #118.13
        vmovdqu   800(%rbp), %xmm7                              #119.13
        vpxor     %xmm4, %xmm3, %xmm8                           #118.13
        vpxor     %xmm7, %xmm6, %xmm9                           #119.13
        vpand     %xmm7, %xmm6, %xmm10                          #119.13
        vpxor     %xmm8, %xmm9, %xmm13                          #119.13
        vpand     %xmm9, %xmm8, %xmm12                          #119.13
        vmovdqu   %xmm13, 400(%rdi)                             #119.3
        vpxor     %xmm1, %xmm2, %xmm5                           #118.13
        vmovdqu   304(%rbp), %xmm14                             #120.13
        vpxor     %xmm12, %xmm10, %xmm0                         #119.13
        vmovdqu   816(%rbp), %xmm13                             #120.13
        vpxor     %xmm13, %xmm14, %xmm1                         #120.13
        vpand     %xmm13, %xmm14, %xmm14                        #120.13
        vmovdqu   %xmm5, 384(%rdi)                              #118.3
        vpand     %xmm1, %xmm0, %xmm2                           #120.13
        vmovdqu   320(%rbp), %xmm4                              #121.13
        vpxor     %xmm2, %xmm14, %xmm6                          #120.13
        vmovdqu   832(%rbp), %xmm5                              #121.13
        vpxor     %xmm0, %xmm1, %xmm3                           #120.13
        vpxor     %xmm5, %xmm4, %xmm7                           #121.13
        vpand     %xmm5, %xmm4, %xmm8                           #121.13
        vmovdqu   848(%rbp), %xmm15                             #122.13
        vpand     %xmm7, %xmm6, %xmm9                           #121.13
        vmovdqu   336(%rbp), %xmm12                             #122.13
        vpxor     %xmm9, %xmm8, %xmm0                           #121.13
        vpxor     %xmm15, %xmm12, %xmm1                         #122.13
        vpand     %xmm15, %xmm12, %xmm12                        #122.13
        vmovdqu   %xmm3, 416(%rdi)                              #120.3
        vpand     %xmm1, %xmm0, %xmm15                          #122.13
        vmovdqu   352(%rbp), %xmm3                              #123.13
        vpxor     %xmm6, %xmm7, %xmm10                          #121.13
        vmovdqu   864(%rbp), %xmm4                              #123.13
        vpxor     %xmm15, %xmm12, %xmm5                         #122.13
        vpxor     %xmm4, %xmm3, %xmm6                           #123.13
        vpand     %xmm4, %xmm3, %xmm7                           #123.13
        vmovdqu   880(%rbp), %xmm14                             #124.13
        vpand     %xmm6, %xmm5, %xmm8                           #123.13
        vmovdqu   368(%rbp), %xmm13                             #124.13
        vpxor     %xmm0, %xmm1, %xmm2                           #122.13
        vpxor     %xmm8, %xmm7, %xmm0                           #123.13
        vpxor     %xmm14, %xmm13, %xmm1                         #124.13
        vmovdqu   384(%rbp), %xmm11                             #92.43
        vpand     %xmm1, %xmm0, %xmm3                           #124.13
        vmovdqu   %xmm2, 448(%rdi)                              #122.3
        vpand     %xmm14, %xmm13, %xmm2                         #124.13
        vpxor     896(%rbp), %xmm11, %xmm11                     #125.13
        vpxor     %xmm3, %xmm2, %xmm4                           #124.13
        vmovdqu   %xmm10, 432(%rdi)                             #121.3
        vpxor     %xmm5, %xmm6, %xmm9                           #123.13
        vpxor     %xmm0, %xmm1, %xmm10                          #124.13
        vpxor     %xmm4, %xmm11, %xmm11                         #125.13
        vmovdqu   %xmm9, 464(%rdi)                              #123.3
        vmovdqu   %xmm10, 480(%rdi)                             #124.3
        vmovdqu   %xmm11, 496(%rdi)                             #125.3
        movq      %rbp, %rsp                                    #126.1
        popq      %rbp                                          #126.1
	.cfi_restore 6
        ret                                                     #126.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_bitslice,@function
	.size	add_bitslice,.-add_bitslice
	.data
# -- End  add_bitslice
	.text
# -- Begin  add_bitslice_arr
	.text
# mark_begin;
       .align    16,0x90
	.globl add_bitslice_arr
# --- add_bitslice_arr(__m128i *, __m128i *, __m128i *__restrict__)
add_bitslice_arr:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_add_bitslice_arr.57:
..L58:
                                                         #128.77
        movq      %rdx, %rcx                                    #128.77
        vpxor     %xmm0, %xmm0, %xmm0                           #129.15
        xorb      %dl, %dl                                      #130.14
        xorl      %eax, %eax                                    #130.14
                                # LOE rax rcx rbx rbp rsi rdi r12 r13 r14 r15 dl xmm0
..B6.2:                         # Preds ..B6.2 ..B6.1
                                # Execution count [3.20e+01]
        vmovdqu   (%rax,%rdi), %xmm1                            #131.18
        incb      %dl                                           #130.27
        vmovdqu   (%rax,%rsi), %xmm2                            #131.23
        vpxor     %xmm2, %xmm1, %xmm3                           #131.14
        vpand     %xmm2, %xmm1, %xmm4                           #131.14
        vpxor     %xmm0, %xmm3, %xmm5                           #131.14
        vpand     %xmm3, %xmm0, %xmm0                           #131.14
        vmovdqu   %xmm5, (%rax,%rcx)                            #131.5
        addq      $16, %rax                                     #130.27
        vpxor     %xmm0, %xmm4, %xmm0                           #131.14
        cmpb      $32, %dl                                      #130.23
        jl        ..B6.2        # Prob 96%                      #130.23
                                # LOE rax rcx rbx rbp rsi rdi r12 r13 r14 r15 dl xmm0
..B6.3:                         # Preds ..B6.2
                                # Execution count [1.00e+00]
        ret                                                     #133.1
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	add_bitslice_arr,@function
	.size	add_bitslice_arr,.-add_bitslice_arr
	.data
# -- End  add_bitslice_arr
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
	.long	1801675088
	.long	779247967
	.long	774778414
	.word	32
	.type	.L_2__STRING.5,@object
	.size	.L_2__STRING.5,14
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.6:
	.long	1937008962
	.long	1633642860
	.long	774778482
	.word	32
	.type	.L_2__STRING.6,@object
	.size	.L_2__STRING.6,14
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
# End
