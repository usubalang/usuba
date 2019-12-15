#pragma once

/* Will generate the macros TI_AND_x, TI_OR_x, TI_XOR_x, TI_NOT_x for
    x in 1, 2, 4,

   as well as TI_AND, TI_OR, TI_XOR and TI_NOT, which are the
   specialized versions of those macros for the currently defined TI.

   Uses the macros FD_AND, FD_OR, FD_XOR and FD_NOT, which are
   therefore expected to be available (defined in FAME_FD.h).
 */


#define TI_AND_1(r,a,b) FD_AND(r,a,b) /* a = b & c */
#define TI_OR_1(r,a,b)  FD_OR(r,a,b)  /* a = b | c */
#define TI_XOR_1(r,a,b) FD_XOR(r,a,b) /* a = b ^ c */
#define TI_NOT_1(r,a)   FD_NOT(r,a)   /* a = ~b */

#if defined(X86) || defined(NO_CUSTOM_INSTR)
#define TI_AND_2(res,a,b) {                                             \
    DATATYPE not_fault_flags, a2;                                       \
    FD_NOT(not_fault_flags,fault_flags);                                \
    a2 = a & not_fault_flags;                                           \
                                                                        \
    DATATYPE r = RAND();                                                \
                                                                        \
    DATATYPE c1, c2, d1, d2, r_r, a_r;                                  \
    FD_AND(c1, b, a2);                       /* partial product 1 */    \
    SUBROT_2(a_r, a2);                       /* share rotate */         \
    FD_AND(c2, a_r, b);                      /* partial product 2 */    \
    a_r = 0;                                 /* clear subrot output */  \
    asm volatile("" : "+r" (a_r)::);                                    \
    FD_XOR(d1, r, c1);                        /* random + parprod 1 */  \
    FD_XOR(d2, d1, c2);                       /*    + parprod 2 */      \
    SUBROT_2(r_r, r);                         /* parallel refresh */    \
    FD_XOR(res, r_r, d2);                     /* output */              \
                                                                        \
    if (FD != 1) {                                                      \
      DATATYPE g5 = 0;                                                  \
      FTCHK(g5,IMM_FTCHK,res);                                          \
      FD_OR(fault_flags,fault_flags,g5);                                \
    }                                                                   \
}
#else

#if FD == 1 || defined(CHEATY_CUSTOM)
#define _FD_AND_TI2 "and"
#define _FD_XOR_TI2 "xor"
#elif FD == 2
#define _FD_AND_TI2 "andc16"
#define _FD_XOR_TI2 "xorc16"
#elif FD == 4
#define _FD_AND_TI2 "andc8"
#define _FD_XOR_TI2 "xorc8"
#endif


#define TI_AND_2(res,a,b) {                                             \
    DATATYPE not_fault_flags, a2;                                       \
    FD_NOT(not_fault_flags,fault_flags);                                \
    a2 = a & not_fault_flags;                                           \
                                                                        \
    DATATYPE r = RAND();                                                \
                                                                        \
    register DATATYPE c1, c2, d1, d2, r_r, a_r;                         \
    asm volatile(                                                       \
        _FD_AND_TI2 " %[b_], %[a2_], %[c1_]\n\t"      /* partial product 1 */   \
        "tibsrot %[a2_], 2, %[a_r_]\n\t"              /* share rotate */        \
        _FD_AND_TI2 " %[a_r_], %[b_], %[c2_]\n\t"     /* partial product 2 */   \
        "xor %[a_r_], %[a_r_], %[a_r_]\n\t"           /* clear subrot output */ \
        _FD_XOR_TI2 " %[r_], %[c1_], %[d1_]\n\t"      /* random + parprod 1 */  \
        _FD_XOR_TI2 " %[d1_], %[c2_], %[d2_]\n\t"     /*    + parprod 2 */      \
        "tibsrot %[r_], 2, %[r_r_]\n\t"               /* parallel refresh */    \
        _FD_XOR_TI2 " %[r_r_], %[d2_], %[res_]\n\t"   /* output */              \
                                                                        \
        : [res_] "=&r" (res), [c1_] "=&r" (c1), [c2_] "=&r" (c2),       \
          [d1_] "=&r" (d1), [d2_] "=&r" (d2),                           \
          [a_r_] "=&r" (a_r), [r_r_] "=&r" (r_r)                        \
        : [r_] "r" (r), [a2_] "r" (a2), [b_] "r" (b));                  \
                                                                        \
                                                                        \
    DATATYPE g5 = 0;                                                    \
    if (FD != 1) {                                                      \
      FTCHK(g5,IMM_FTCHK,res);                                          \
      FD_OR(fault_flags,fault_flags,g5);                                \
    }                                                                   \
}

#endif

#define TI_NOT_2(a,b) a = (b) ^ 0x55555555
#define TI_OR_2(a,b,c) {                        \
    DATATYPE notb, notc, nota;                  \
    TI_NOT_2(notb,b);                           \
    TI_NOT_2(notc,c);                           \
    TI_AND_2(nota,notb,notc);                   \
    TI_NOT_2(a,nota);                           \
  }
#define TI_XOR_2(a,b,c) FD_XOR(a,b,c)

#if defined(X86) || defined(NO_CUSTOM_INSTR)
#define TI_AND_4(res,a,b) {                                             \
    DATATYPE not_fault_flags, a2;                                       \
    FD_NOT(not_fault_flags,fault_flags);                                \
    a2 = a & not_fault_flags;                                           \
                                                                        \
    DATATYPE r = RAND(), r_output = RAND();                             \
                                                                        \
    DATATYPE c1, c2, c3, c4, a_r1, a_r2, b_r, r_r, d1, d2, d3, d4, res_1, res_2, r_output_r; \
    FD_AND(c1, a2, b);             /* partial product 1 */              \
    SUBROT_4(a_r1, a2);            /* share rotate */                   \
    FD_AND(c2, a_r1, b);             /* partial product 2 */            \
    SUBROT_4(b_r, b);                /* share rotate */                 \
    FD_AND(c3, b_r, a2);           /* partial product 3 */              \
    SUBROT_4(a_r2, a_r1);            /* share rotate */                 \
    FD_AND(c4, a_r2, b);             /* partial product 4 */            \
    a_r1 = 0;                        /* clear subrot output */          \
    asm volatile("" : "+r" (a_r1)::);                                   \
    b_r = 0;                         /* clear subrot output */          \
    asm volatile("" : "+r" (b_r)::);                                    \
    a_r2 = 0;                        /* clear subrot output */          \
    asm volatile("" : "+r" (a_r2)::);                                   \
    FD_XOR(d1, r, c1);               /* random + parprod 1 */           \
    FD_XOR(d2, d1, c2);              /*    + parprod 2 */               \
    FD_XOR(d3, d2, c3);              /*    + parprod 3 */               \
    SUBROT_4(r_r, r);                /* parallel refresh */             \
    FD_XOR(d4, d3, r_r);                                                \
    FD_XOR(res_1, d4, c4);             /* output */                     \
    FD_XOR(res_2, res_1, r_output);       /* random + res */            \
    SUBROT_4(r_output_r, r_output);    /* rotate random */              \
    FD_XOR(res, res_2, r_output_r);     /* a + rot(random) */            \
    r_output_r = 0;                   /* clear subrot output */         \
    asm volatile("" : "+r" (r_output_r)::);                             \
                                                                        \
    if (FD != 1) {                                                      \
      DATATYPE g5 = 0;                                                  \
      FTCHK(g5,IMM_FTCHK,res);                                          \
      FD_OR(fault_flags,fault_flags,g5);                                \
    }                                                                   \
  }
#else
#if FD == 1 || defined(CHEATY_CUSTOM)
#define _FD_AND_TI4 "and"
#define _FD_XOR_TI4 "xor"
#elif FD == 2
#define _FD_AND_TI4 "andc16"
#define _FD_XOR_TI4 "xorc16"
#elif FD == 4
#define _FD_AND_TI4 "andc8"
#define _FD_XOR_TI4 "xorc8"
#endif

#define TI_AND_4(res,a,b) {                                         \
    DATATYPE not_fault_flags, a2;                                   \
    FD_NOT(not_fault_flags,fault_flags);                            \
    a2 = a & not_fault_flags;                                       \
                                                                    \
    DATATYPE r = RAND(), r_output = RAND();                          \
                                                                    \
    register DATATYPE c1, c2, c3, c4, a_r1, a_r2, b_r, r_r, d1, d2, d3, d4, res_1, res_2, r_output_r; \
    asm volatile(                                                   \
        _FD_AND_TI4 " %[a2_], %[b_], %[c1_]\n\t"   /* partial product 1 */ \
        "tibsrot %[a2_], 4, %[a_r1_]\n\t"          /* share rotate */   \
        _FD_AND_TI4 " %[a_r1_], %[b_], %[c2_]\n\t" /* partial product 2 */ \
        "tibsrot %[b_], 4, %[b_r_]\n\t"            /* share rotate */   \
        _FD_AND_TI4 " %[b_r_], %[a2_], %[c3_]\n\t"  /* partial product 3 */ \
        "tibsrot %[a_r1_], 4, %[a_r2_]\n\t"        /* share rotate */   \
        _FD_AND_TI4 " %[a_r2_], %[b_], %[c4_]\n\t" /* partial product 4 */ \
        "xor %[a_r1_], %[a_r1_], %[a_r1_]\n\t"     /* clear subrot output */ \
        "xor %[b_r_], %[b_r_], %[b_r_]\n\t"        /* clear subrot output */ \
        "xor %[a_r2_], %[a_r2_], %[a_r2_]\n\t"     /* clear subrot output */ \
        _FD_XOR_TI4 " %[r_], %[c1_], %[d1_]\n\t"   /* random + parprod 1 */ \
        _FD_XOR_TI4 " %[d1_], %[c2_], %[d2_]\n\t"  /*    + parprod 2 */ \
        _FD_XOR_TI4 " %[d2_], %[c3_], %[d3_]\n\t"  /*    + parprod 3 */ \
        "tibsrot %[r_], 4, %[r_r_]\n\t"            /* parallel refresh */ \
        _FD_XOR_TI4 " %[d3_], %[r_r_], %[d4_]\n\t"                      \
        _FD_XOR_TI4 " %[d4_], %[c4_], %[res_1_]\n\t" /* output */       \
        _FD_XOR_TI4 " %[res_1_], %[r_output_], %[res_2_]\n\t"     /* random + a */ \
        "tibsrot %[r_output_], 4, %[r_output_r_]\n\t"          /* rotate random */ \
        _FD_XOR_TI4 " %[res_2_], %[r_output_r_], %[res_]\n\t"  /* a + rot(random) */\
        "xor %[r_output_r_], %[r_output_r_], %[r_output_r_]\n\t" /* clear subrot output */ \
                                                                      \
        : [res_] "=&r" (res),                                         \
          [c1_] "=&r" (c1), [c2_] "=&r" (c2), [c3_] "=&r" (c3), [c4_] "=&r" (c4), \
          [d1_] "=&r" (d1), [d2_] "=&r" (d2), [d3_] "=&r" (d3), [d4_] "=&r" (d4), \
          [a_r1_] "=&r" (a_r1), [a_r2_] "=&r" (a_r2),                   \
          [b_r_] "=&r" (b_r),  [r_r_] "=&r" (r_r),                      \
          [res_1_] "=&r" (res_1), [res_2_] "=&r" (res_2), [r_output_r_] "=&r" (r_output_r) \
        : [r_] "r" (r), [a2_] "r" (a2), [b_] "r" (b), [r_output_] "r" (r_output)); \
                                                                        \
    if (FD != 1) {                                                      \
      DATATYPE g5 = 0;                                                  \
      FTCHK(g5,IMM_FTCHK,res);                                          \
      FD_OR(fault_flags,fault_flags,g5);                                \
    }                                                                   \
}

#endif

#define TI_NOT_4(a,b) a = (b) ^ 0x11111111
#define TI_OR_4(a,b,c) {                        \
    DATATYPE notb, notc, nota;                  \
    TI_NOT_4(notb,b);                           \
    TI_NOT_4(notc,c);                           \
    TI_AND_4(nota,notb,notc);                   \
    TI_NOT_4(a,nota);                           \
  }
#define TI_XOR_4(a,b,c) FD_XOR(a,b,c)



#define _BUILD_OP_TI(OP,n) TI_ ## OP ## _ ## n
#define BUILD_OP_TI(OP,n) _BUILD_OP_TI(OP,n)

#define TI_AND BUILD_OP_TI(AND,TI)
#define TI_OR  BUILD_OP_TI(OR, TI)
#define TI_XOR BUILD_OP_TI(XOR,TI)
#define TI_NOT BUILD_OP_TI(NOT,TI)
