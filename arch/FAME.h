#pragma once

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#ifndef DATATYPE
#define DATATYPE unsigned int
#endif


#define TIBSROT_2(a,b) asm volatile("tibsrot %1, 2, %0\n\t" : "=r" (a) : "r" (b) :)
#define TIBSROT_4(a,b) asm volatile("tibsrot %1, 4, %0\n\t" : "=r" (a) : "r" (b) :)

#define ANDC8(a,b,c)   asm volatile("andc8 %1, %2, %0\n\t"   : "=r" (a) : "r" (b), "r" (c) :)
#define XORC8(a,b,c)   asm volatile("xorc8 %1, %2, %0\n\t"   : "=r" (a) : "r" (b), "r" (c) :)
#define XNORC8(a,b,c)  asm volatile("xnorc8 %1, %2, %0\n\t"  : "=r" (a) : "r" (b), "r" (c) :)
#define ANDC16(a,b,c)  asm volatile("andc16 %1, %2, %0\n\t"  : "=r" (a) : "r" (b), "r" (c) :)
#define XORC16(a,b,c)  asm volatile("xorc16 %1, %2, %0\n\t"  : "=r" (a) : "r" (b), "r" (c) :)
#define XNORC16(a,b,c) asm volatile("xnorc16 %1, %2, %0\n\t" : "=r" (a) : "r" (b), "r" (c) :)

static int lcg_rand() {
  static int state = 1;
  state = state * 1664525 + 1013904223;
  return state;
}

#define RAND() lcg_rand()

#if (! defined FD) || (FD == 1)

#define FD_AND(a,b,c) (a) = (b) & (c)
#define FD_OR(a,b,c)  (a) = (b) | (c)
#define FD_XOR(a,b,c) (a) = (b) ^ (c)
#define FD_NOT(a,b)   (a) = ~(b)

#elif FD == 2

#define FD_AND(a,b,c) ANDC16(a,b,c)
#define FD_OR(a,b,c)  { DATATYPE _tmp_or; ANDC16(_tmp_or,b,c); a = ~_tmp_or; }
#define FD_XOR(a,b,c) XORC16(a,b,c)
#define FD_NOT(a,b)   (a) = ~(b)

#elif FD == 4

#define FD_AND(a,b,c) ANDC8(a,b,c)
#define FD_OR(a,b,c)  { DATATYPE _tmp_or; ANDC8(_tmp_or,b,c); a = ~_tmp_or; }
#define FD_XOR(a,b,c) XORC8(a,b,c)
#define FD_NOT(a,b)   (a) = ~(b)

#else
#error Invalid FD value

#endif // FD == 1 // FD == 2 // FD == 4


#if (! defined TI) || (TI == 1)

#define TI_AND(a,b,c) FD_AND(a,b,c) /* a = b & c */
#define TI_OR(a,b,c)  FD_OR(a,b,c)  /* a = b | c */
#define TI_XOR(a,b,c) FD_XOR(a,b,c) /* a = b ^ c */
#define TI_NOT(a,b)   FD_NOT(a,b)   /* a = ~b */

#elif TI == 2

#define TI_AND(a,b,c) {                             \
    DATATYPE c1, c2, d1, d2, d3;                    \
    DATATYPE r = RAND();                            \
    FD_AND(c1,b,c);    /* c1 = b & c */             \
    DATATYPE c_r1;                                  \
    TIBSROT_2(c_r1,c);                              \
    FD_AND(c2,b,c_r1); /* c2 = b & (c <<< 1) */     \
    FD_XOR(d1,c1,r);   /* d1 = c1 ^ r */            \
    FD_XOR(d2,d1,c2);  /* d2 = d1 ^ c2 */           \
    DATATYPE r_r1;                                  \
    TIBSROT_2(r_r1,r);                              \
    FD_XOR(d3,d2,r_r1); /* d3 = d2 ^ (r <<< 1) */   \
    a = d3;             /* a  = d3 */               \
  }

#define TI_NOT(a,b) FD_NOT(a,b) 

#define TI_OR(a,b,c) {                          \
    DATATYPE notb, notc, nota;                  \
    FD_NOT(notb,b);                             \
    FD_NOT(notc,c);                             \
    FD_AND(nota,notb,notc);                     \
    FD_NOT(a,nota);                             \
  }

#define TI_XOR(a,b,c) FD_XOR(a,b,c)

#elif TI == 4

#define TI_AND(a,b,c) {                             \
    DATATYPE c1, c2, c3, c4, d1, d2, d3, d4;        \
    DATATYPE r = RAND();                            \
    FD_AND(c1,b,c);    /* c1 = b & c */             \
    DATATYPE c_r1;                                  \
    TIBSROT_4(c_r1,c);                              \
    FD_AND(c2,b,c_r1); /* c2 = b & (c <<< 1) */     \
    DATATYPE b_r1;                                  \
    TIBSROT_4(b_r1,b);                              \
    FD_AND(c3,b_r1,c); /* c3 = (b <<< 1) & c */     \
    DATATYPE c_r2_1, c_r2_2;                        \
    TIBSROT_4(c_r2_1, c);                           \
    TIBSROT_4(c_r2_2, c_r2_1);                      \
    FD_AND(c4,b,c_r2_2); /* c4 = b & (c <<< 2) */   \
    FD_XOR(d1,c1,r);   /* d1 = c1 ^ r */            \
    FD_XOR(d2,d1,c2);  /* d2 = d1 ^ c2 */           \
    FD_XOR(d3,d2,c3);  /* d3 = d2 ^ c3 */           \
    DATATYPE r_r1;                                  \
    TIBSROT_2(r_r1,r);                              \
    FD_XOR(d4,d3,r_r1); /* d4 = d3 ^ (r <<< 1) */   \
    FD_XOR(a,d4,c4);    /* a  = d4 ^ c4 */      \
  }

#define TI_NOT(a,b) FD_NOT(a,b)

#define TI_OR(a,b,c) {                          \
    DATATYPE notb, notc, nota;                  \
    FD_NOT(notb,b);                             \
    FD_NOT(notc,c);                             \
    FD_AND(nota,notb,notc);                     \
    FD_NOT(a,nota);                             \
  }

#define TI_XOR(a,b,c) FD_XOR(a,b,c)

#else
#error Invalid TI value

#endif // TI


#define AND(a,b,c) TI_AND(a,b,c) /* a = b & c */
#define OR(a,b,c)  TI_OR(a,b,c)  /* a = b | c */
#define XOR(a,b,c) TI_XOR(a,b,c) /* a = b ^ c */
#define NOT(a,b)   TI_NOT(a,b)   /* a = ~b */
