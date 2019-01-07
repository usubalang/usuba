#pragma once

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#ifndef DATATYPE
#define DATATYPE unsigned int
#endif

#ifdef X86
#include <stdio.h>
#include <stdlib.h>

#define TIBS(rd,y,r1,r2) {                          \
    DATATYPE _r1 = r1, _r2 = r2;                    \
    rd = 0, y = 0;                                  \
    for (int i = 31, j = 0; i >= 16; i--, j++) {    \
      rd |= ((_r1 >> i) & 1) << (31 - j*2);         \
      rd |= ((_r2 >> i) & 1) << (31 - (j*2+1));     \
    }                                               \
    for (int i = 0; i < 16; i++) {                  \
      y |= ((_r2 >> i) & 1) << i*2;                 \
      y |= ((_r1 >> i) & 1) << (i*2+1);             \
    }                                               \
  }

/* r1/r2 are actually the destination, and rd/y the source
   but it makes it clearer to name them that way (since 
   INVTIBS is the inverse of TIBS) */
#define INVTIBS(r1,r2,rd,y) {                       \
    r1 = 0, r2 = 0;                                 \
    for (int i = 31, j = 31; i >= 0; i -= 2, j--) { \
      r1 |= ((rd >> i) & 1) << j;                   \
      r2 |= ((rd >> (i-1)) & 1) << j;               \
    }                                               \
    for (int i = 31, j = 15; i >= 0; i -= 2, j--) { \
      r1 |= ((y >> i) & 1) << j;                    \
      r2 |= ((y >> (i-1)) & 1) << j;                \
    }                                               \
  }

#define RED(rd,y,i,a) {                                                 \
    if (i == 0b010) {                                                   \
      rd = ((a) << 16) | ((a) & 0xFFFF);                                \
      y  = ((a) & 0xFFFF0000) | ((a) >> 16);                            \
    }                                                                   \
    else if (i == 0b011) {                                              \
      rd = (~(a) << 16) | ((a) & 0xFFFF);                               \
      y  = (~(a) & 0xFFFF0000) | ((a) >> 16);                           \
    }                                                                   \
    else if (i == 0b100) {                                              \
      rd = ((a) & 0xFF) | (((a) & 0xFF) << 8) |                         \
      (((a) & 0xFF) << 16) | (((a) & 0xFF) << 24);                      \
      y  = (((a) & 0xFF00) >> 8) | ((a) & 0xFF00) |                     \
      (((a) & 0xFF00) << 8) | (((a) & 0xFF00) << 16);                   \
    }                                                                   \
    else if (i == 0b101) {                                              \
      rd = ((a) & 0xFF) | ((~(a) & 0xFF) << 8) |                        \
      (((a) & 0xFF) << 16) | ((~(a) & 0xFF) << 24);                     \
      y  = (((a) & 0xFF00) >> 8) | (~(a) & 0xFF00) |                    \
      (((a) & 0xFF00) << 8) | ((~(a) & 0xFF00) << 16);                  \
    }                                                                   \
    else if (i == 0b110) {                                              \
      rd = (((a) & 0xFF0000) >> 16) | (((a) & 0xFF0000) >> 8) |         \
      ((a) & 0xFF0000) | (((a) & 0xFF0000) << 8);                       \
      y  = (((a) & 0xFF000000) >> 24) | (((a) & 0xFF000000) >> 16) |    \
      (((a) & 0xFF000000) >> 8) | ((a) & 0xFF000000);                   \
    }                                                                   \
    else if (i == 0b111) {                                              \
      rd = (((a) & 0xFF0000) >> 16) | ((~(a) & 0xFF0000) >> 8) |        \
      ((a) & 0xFF0000) | ((~(a) & 0xFF0000) << 8);                      \
      y  = (((a) & 0xFF000000) >> 24) | ((~(a) & 0xFF000000) >> 16) |   \
      (((a) & 0xFF000000) >> 8) | (~(a) & 0xFF000000);                  \
    }                                                                   \
    else {                                                              \
      fprintf(stderr, "Invalid RED@%d.\n",i);                           \
      exit(EXIT_FAILURE);                                               \
    }                                                                   \
  }

#define FTCHK(rd,i,a) {                                                 \
    if (i == 0b0010) {                                                  \
      rd = (((a) >> 16) ^ (a)) & 0xFFFF;                                \
    }                                                                   \
    else if (i == 0b1010) {                                             \
      rd = ((((a) >> 16) ^ (a)) & 0xFFFF) | (~(((a) >> 16) ^ (a)) << 16) ; \
    }                                                                   \
    else if (i == 0b0011) {                                             \
      rd = ~(((a) >> 16) ^ (a)) & 0xFFFF;                               \
    }                                                                   \
    else if (i == 0b1011) {                                             \
      rd = (~(((a) >> 16) ^ (a)) & 0xFFFF) | ((((a) >> 16) ^ (a)) << 16); \
    }                                                                   \
    else if (i == 0b0100) {                                             \
      rd = ((((a) & 0xFF) ^ ((a) >> 8)) |                               \
            (((a) & 0xFF) ^ ((a) >> 16)) |                              \
            (((a) & 0xFF) ^ ((a) >> 24))) & 0xFF;                       \
    }                                                                   \
    else if (i == 0b1100) {                                             \
      DATATYPE tmp = ((((a) & 0xFF) ^ ((a) >> 8)) |                     \
                      (((a) & 0xFF) ^ ((a) >> 16)) |                    \
                      (((a) & 0xFF) ^ ((a) >> 24))) & 0xFF;             \
      rd = tmp | ((~tmp & 0xFF) << 8) | (tmp << 16) | ((~tmp & 0xFF) << 24); \
    }                                                                   \
    else if (i == 0b0101) {                                             \
      rd = (((~(a) & 0xFF) ^ ((a) >> 8)) |                              \
            (((a) & 0xFF) ^ ((a) >> 16)) |                              \
            ((~(a) & 0xFF) ^ ((a) >> 24))) & 0xFF;                      \
    }                                                                   \
    else if (i == 0b1101) {                                             \
      DATATYPE tmp = ((~((a) & 0xFF) ^ ((a) >> 8)) |                    \
                      (((a) & 0xFF) ^ ((a) >> 16)) |                    \
                      (~((a) & 0xFF) ^ ((a) >> 24))) & 0xFF;            \
      rd = tmp | ((~tmp & 0xFF) << 8) | (tmp << 16) | ((~tmp & 0xFF) << 24); \
    }                                                                   \
    else {                                                              \
      fprintf(stderr, "Invalid FTCHK@%d.\n",i);                         \
      exit(EXIT_FAILURE);                                               \
    }                                                                   \
  }

#define TIBSROT_2(r,a) r = ((a << 1) & 0xAAAAAAAA) | ((a >> 1) & 0x55555555)
#define TIBSROT_4(r,a) r = ((a << 1) & 0xEEEEEEEE) | ((a >> 3) & 0x11111111)

#define ANDC8(r,a,b)   r = ( ((a) | (b)) & 0xFF00FF00) | ( ((a) & (b)) & 0x00FF00FF)
#define XORC8(r,a,b)   r = (~((a) ^ (b)) & 0xFF00FF00) | ( ((a) ^ (b)) & 0x00FF00FF)
#define XNORC8(r,a,b)  r = ( ((a) ^ (b)) & 0xFF00FF00) | (~((a) ^ (b)) & 0x00FF00FF)

#define ANDC16(r,a,b)  r = ( ((a) | (b)) & 0xFFFF0000) | ( ((a) & (b)) & 0x0000FFFF)
#define XORC16(r,a,b)  r = (~((a) ^ (b)) & 0xFFFF0000) | ( ((a) ^ (b)) & 0x0000FFFF)
#define XNORC16(r,a,b) r = ( ((a) ^ (b)) & 0xFFFF0000) | (~((a) ^ (b)) & 0x0000FFFF)

#else

#define TIBS(y,rd,r1,r2) {                                              \
    asm volatile("tibs %2, %3, %0\n\t"                                  \
                 "mov %%y, %1\n\t" : "=r" (rd), "=r" (y) : "r" (r1), "r" (r2)); \
  }
/* r1/r2 are actually the destination, and rd/y the source
   but it makes it clearer to name them that way (since 
   INVTIBS is the inverse of TIBS) */
#define INVTIBS(r2,r1,rd,y) {                                           \
    asm volatile("invtibs %2, %3, %0\n\t"                               \
                 "mov %%y, %1\n\t" : "=r" (r1), "=r" (r2) : "r" (rd), "r" (y)); \
  }

#define RED(r,y,i,a)   {                                                \
    asm volatile("red %2, %3, %0\n\t"                                   \
                 "mov %%y, %1\n\t" : "=r" (r), "=r" (y) : "r" (a), "i" (i)); \
  }

#define FTCHK(r,i,a)   asm volatile("ftchk %1, %2, %0\n\t" : "=r" (r) : "r" (a), "i" (i) );

#define TIBSROT_2(r,a) asm volatile("tibsrot %1, 2, %0\n\t" : "=r" (r) : "r" (a) :)
#define TIBSROT_4(r,a) asm volatile("tibsrot %1, 4, %0\n\t" : "=r" (r) : "r" (a) :)

#define ANDC8(r,a,b)   asm volatile("andc8 %1, %2, %0\n\t"   : "=r" (r) : "r" (a), "r" (b) :)
#define XORC8(r,a,b)   asm volatile("xorc8 %1, %2, %0\n\t"   : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC8(r,a,b)  asm volatile("xnorc8 %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define ANDC16(r,a,b)  asm volatile("andc16 %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define XORC16(r,a,b)  asm volatile("xorc16 %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC16(r,a,b) asm volatile("xnorc16 %1, %2, %0\n\t" : "=r" (r) : "r" (a), "r" (b) :)
#endif

/* The following algorithm is attritubed by Wikipedia (https://en.wikipedia.org/wiki/Xorshift)
   to p. 4 of Marsaglia, "Xorshift RNGs" */
static int state = 0x8e20a6e5;
#ifdef PIPELINED
static int state_prev = 0x8e20a6e5;
#endif
static void seed(int seed) { state = seed; }
#ifdef PIPELINED
static int get_seed() { return state; }
static void seed_prev(int seed) { state_prev = seed; }
#endif
static int xorshift_rand() {
  state ^= state << 13;
  state ^= state >> 17;
  state ^= state << 5;
#ifdef PIPELINED
  state_prev ^= state_prev << 13;
  state_prev ^= state_prev >> 17;
  state_prev ^= state_prev << 5;
#endif
#if FD == 1
#ifdef PIPELINED
  return (state_prev << 16) | (state & 0xFFFF);
#else
  return state;
#endif
#elif FD == 2
  // Can't have both PIPELINED and FD == 2
  return (~state << 16) | (state & 0xFFFF);
#elif FD == 4
#ifdef PIPELINED
  return (~state_prev << 24) | ((state_prev & 0xFF) << 16) |
    ((~state & 0xFF) << 8) | (state & 0xFF);
#else
  return (~state << 24) | ((state & 0xFF) << 16) |
    ((~state & 0xFF) << 8) | (state & 0xFF);
#endif
#endif
}

#if defined(FD) && FD >= 2
#if FD == 2
#define RAND() ({ DATATYPE _tmp = xorshift_rand(); (~_tmp & 0xFFFF) | (_tmp << 16); }) 
#elif FD == 4
#define RAND() ({ DATATYPE _tmp = xorshift_rand();                      \
      (~_tmp & 0xFF) | ((_tmp & 0xFF) << 8) | ((~_tmp & 0xFF) << 16) | (_tmp<< 24); })
#else
#error Invalid FD
#endif
#else
#define RAND() xorshift_rand()
#endif

#define FD_AND_1(r,a,b) (r) = (a) & (b)
#define FD_OR_1(r,a,b)  (r) = (a) | (b)
#define FD_XOR_1(r,a,b) (r) = (a) ^ (b)
#define FD_NOT_1(r,a)   (r) = ~(a)

#define FD_AND_2(r,a,b) ANDC16(r,a,b)
#define FD_OR_2(r,a,b)  { DATATYPE _tmp_or; ANDC16(_tmp_or,~a,~b); r = ~_tmp_or; }
#define FD_XOR_2(r,a,b) XORC16(r,a,b)
#define FD_NOT_2(r,a)   (r) = ~(a)

#define FD_AND_4(r,a,b) ANDC8(r,a,b)
#define FD_OR_4(r,a,b)  { DATATYPE _tmp_or; ANDC8(_tmp_or,~a,~b); r = ~_tmp_or; }
#define FD_XOR_4(r,a,b) XORC8(r,a,b)
#define FD_NOT_4(r,a)   (r) = ~(a)

#ifndef FD
#define FD 1
#endif

#define _BUILD_OP_FD(OP,n) FD_ ## OP ## _ ## n
#define BUILD_OP_FD(OP,n) _BUILD_OP_FD(OP,n)

#define FD_AND BUILD_OP_FD(AND,FD)
#define FD_OR  BUILD_OP_FD(OR, FD)
#define FD_XOR BUILD_OP_FD(XOR,FD)
#define FD_NOT BUILD_OP_FD(NOT,FD)


#define TI_AND_1(r,a,b) FD_AND(r,a,b) /* a = b & c */
#define TI_OR_1(r,a,b)  FD_OR(r,a,b)  /* a = b | c */
#define TI_XOR_1(r,a,b) FD_XOR(r,a,b) /* a = b ^ c */
#define TI_NOT_1(r,a)   FD_NOT(r,a)   /* a = ~b */

#ifdef X86
#define TI_AND_2(a,b,c) {                           \
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
#else
#if FD == 1
#define _FD_AND_TI2 "and"
#define _FD_XOR_TI2 "xor"
#elif FD == 2
#define _FD_AND_TI2 "andc16"
#define _FD_XOR_TI2 "xorc16"
#elif FD == 4
#define _FD_AND_TI2 "andc8"
#define _FD_XOR_TI2 "xorc8"
#endif
#define TI_AND_2(a,b,c) {                                               \
    DATATYPE r = RAND();                                                \
    register DATATYPE c1, c2, d1, d2, c_r1, r_r1;                       \
    asm volatile(_FD_AND_TI2 " %8, %9, %1\n\t" /* c1 = b & c */          \
                 "tibsrot %9, 2, %5\n\t"      /* [tmp]  c_r1 = c <<< 1 */ \
                 _FD_AND_TI2 " %8, %5, %2\n\t" /* c2 = b & (c <<< 1) */  \
                 _FD_XOR_TI2 " %1, %7, %3\n\t" /* d1 = c1 ^ r */         \
                 _FD_XOR_TI2 " %3, %2, %4\n\t" /* d2 = d1 ^ c2 */        \
                 "tibsrot %7, 2, %6\n\t"      /* [tmp] r_r1 = r <<< 1 */ \
                 _FD_XOR_TI2 " %4, %6, %0\n\t" /* a = d2 ^ (r <<< 1) */  \
                                                                        \
                 : "=&r" (a), "=&r" (c1), "=&r" (c2), "=&r" (d1), "=&r" (d2), \
                   /*     0          1           2           3           4    */ \
                   "=&r" (c_r1), "=&r" (r_r1)                           \
                   /*       5            6*/                            \
                 : "r" (r), "r" (b), "r" (c));                          \
                   /*   7        8        9             */              \
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

#ifdef X86
#define TI_AND_4(a,b,c) {                           \
    DATATYPE c1, c2, c3, c4, d1, d2, d3, d4;        \
    DATATYPE r = RAND();                            \
    FD_AND(c1,b,c);    /* c1 = b & c */             \
    DATATYPE c_r1;                                  \
    TIBSROT_4(c_r1,c);                              \
    FD_AND(c2,b,c_r1); /* c2 = b & (c <<< 1) */     \
    DATATYPE b_r1;                                  \
    TIBSROT_4(b_r1,b);                              \
    FD_AND(c3,b_r1,c); /* c3 = (b <<< 1) & c */     \
    DATATYPE c_r2;                                  \
    TIBSROT_4(c_r2, c_r1);                          \
    FD_AND(c4,b,c_r2); /* c4 = b & (c <<< 2) */     \
    FD_XOR(d1,c1,r);   /* d1 = c1 ^ r */            \
    FD_XOR(d2,d1,c2);  /* d2 = d1 ^ c2 */           \
    FD_XOR(d3,d2,c3);  /* d3 = d2 ^ c3 */           \
    DATATYPE r_r1;                                  \
    TIBSROT_4(r_r1,r);                              \
    FD_XOR(d4,d3,r_r1); /* d4 = d3 ^ (r <<< 1) */   \
    FD_XOR(a,d4,c4);    /* a  = d4 ^ c4 */          \
  }
#else
#if FD == 1
#define _FD_AND_TI4 "and"
#define _FD_XOR_TI4 "xor"
#elif FD == 2
#define _FD_AND_TI4 "andc16"
#define _FD_XOR_TI4 "xorc16"
#elif FD == 4
#define _FD_AND_TI4 "andc8"
#define _FD_XOR_TI4 "xorc8"
#endif
#define TI_AND_4(a,b,c) {                                               \
    DATATYPE r = RAND();                                                \
    register DATATYPE c1, c2, c3, c4, d1, d2, d3, d4, c_r1, b_r1, c_r2, r_r1; \
    asm volatile(_FD_AND_TI4 " %14, %15, %1\n\t" /* c1 = b & c */             \
                 "tibsrot %15, 4, %9\n\t"        /* [tmp] c_r1 = c <<< 1 */   \
                 _FD_AND_TI4 " %14, %9, %2\n\t"  /* c2 = b & (c <<< 1) */     \
                 "tibsrot %14, 4, %10\n\t"       /* [tmp] b_r1 = b <<< 1 */   \
                 _FD_AND_TI4 " %10, %15, %3\n\t" /* c3 = (b <<< 1) & c */     \
                 "tibsrot %9, 4, %11\n\t"        /* [tmp] c_r2 = c_r1 <<< 1 */ \
                 _FD_AND_TI4 " %14, %11, %4\n\t" /* c4 = b & (c <<< 2) */     \
                 _FD_XOR_TI4 " %1, %13, %5\n\t"  /* d1 = c1 ^ r */            \
                 _FD_XOR_TI4 " %5, %2, %6\n\t"   /* d2 = d1 ^ c2 */           \
                 _FD_XOR_TI4 " %6, %3, %7\n\t"   /* d3 = d2 ^ c3 */           \
                 "tibsrot %13, 4, %12\n\t"       /* [tmp] r_r1 = r <<< 1 */   \
                 _FD_XOR_TI4 " %7, %12, %8\n\t"  /* d4 = d3 ^ (r <<< 1) */    \
                 _FD_XOR_TI4 " %8, %4, %0\n\t"   /* a = d4 ^ c4 */            \
                                                                              \
                 : "=&r" (a), "=&r" (c1), "=&r" (c2), "=&r" (c3), "=&r" (c4), \
                   /*     0          1           2           3           4 */ \
                   "=&r" (d1), "=&r" (d2), "=&r" (d3), "=&r" (d4),            \
                   /*     5           6           7           8  */           \
                   "=&r" (c_r1), "=&r" (b_r1), "=&r" (c_r2), "=&r" (r_r1)     \
                   /*      9             10            11            12 */    \
                 : "r" (r), "r" (b), "r" (c));                                \
                   /*  13       14       15             */                    \
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

#ifndef TI
#define TI 1
#endif

#define _BUILD_OP_TI(OP,n) TI_ ## OP ## _ ## n
#define BUILD_OP_TI(OP,n) _BUILD_OP_TI(OP,n)

#define TI_AND BUILD_OP_TI(AND,TI)
#define TI_OR  BUILD_OP_TI(OR, TI)
#define TI_XOR BUILD_OP_TI(XOR,TI)
#define TI_NOT BUILD_OP_TI(NOT,TI)


#define AND(a,b,c) TI_AND(a,b,c) /* a = b & c */
#define OR(a,b,c)  TI_OR(a,b,c)  /* a = b | c */
#define XOR(a,b,c) TI_XOR(a,b,c) /* a = b ^ c */
#define NOT(a,b)   TI_NOT(a,b)   /* a = ~b */


// TODO: should fix this for TI
#if !defined(FD) || (FD == 1)
#define SET_ALL_ONE()  -1
#define SET_ALL_ZERO() 0
#elif FD == 2
#define SET_ALL_ONE()  0x0000ffff
#define SET_ALL_ZERO() 0xffff0000
#elif FD == 4
#define SET_ALL_ONE()  0x00ff00ff
#define SET_ALL_ZERO() 0xff00ff00
#endif