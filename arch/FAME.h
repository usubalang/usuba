#pragma once

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#ifndef DATATYPE
#define DATATYPE unsigned int
#endif

#ifdef X86

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
void seed(int seed) { state = seed; }
static int xorshift_rand() {
  state ^= state << 13;
  state ^= state >> 17;
  state ^= state << 5;
  return state;
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
#define FD_OR_1(r,a,b) (r) = (a) | (b)
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
#define TI_NOT_2(a,b) a = (b) ^ 0x55555555 
#define TI_OR_2(a,b,c) {                        \
    DATATYPE notb, notc, nota;                  \
    TI_NOT_2(notb,b);                           \
    TI_NOT_2(notc,c);                           \
    TI_AND_2(nota,notb,notc);                   \
    TI_NOT_2(a,nota);                           \
  }
#define TI_XOR_2(a,b,c) FD_XOR(a,b,c)

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
    FD_XOR(a,d4,c4);    /* a  = d4 ^ c4 */          \
  }
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
