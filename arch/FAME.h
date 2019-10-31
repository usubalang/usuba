#pragma once

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif

#ifndef DATATYPE
#define DATATYPE unsigned int
#endif

#ifndef FD
#error FD not defined (should be 1, 2 or 4)
#endif

#ifndef TI
#error TI not defined (should be 1, 2 or 4)
#endif

#if FD == 1
#define IMM_FTCHK 0 /* no redundancy -> no fault check */
#elif FD == 2
#define IMM_FTCHK 0b0011
#elif FD == 4 && !defined(CORRECT)
#define IMM_FTCHK 0b0101
#elif FD == 4 && defined(CORRECT)
#define IMM_FTCHK 0b11101
#else
#error Dunno know what IMM_FTCHK to use...
#endif

#ifdef X86
#include <stdio.h>
#include <stdlib.h>
#endif

extern int fault_flags;

#if defined(X86) || defined(NO_CUSTOM_INSTR)

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
    if (i == 0b0010 || i == 0b1010) {                                   \
      int low = a & 0xFFFF, high = a >> 16;                             \
      int _fault_flags = low ^ high;                                     \
      if (i == 0b0010) rd = _fault_flags | (_fault_flags << 16);          \
      if (i == 0b1010) rd = _fault_flags | (~_fault_flags << 16);         \
    }                                                                   \
    else if (i == 0b0011 || i == 0b1011) {                              \
      int low = a & 0xFFFF, high = a >> 16;                             \
      int _fault_flags = (~(low ^ high)) & 0xFFFF;                       \
      if (i == 0b0011) rd = _fault_flags | (_fault_flags << 16);          \
      if (i == 0b1011) rd = _fault_flags | (~_fault_flags << 16);         \
    }                                                                   \
    else if (i == 0b0100 || i == 0b1100) {                              \
      int q1 = a & 0xff,         q2 = (a >> 8) & 0xff,                  \
          q3 = (a >> 16) & 0xff, q4 = (a >> 24) & 0xff;                 \
      int _fault_flags = (q1 ^ q2) | (q1 ^ q3) | (q1 ^ q4);              \
      if (i == 0b0100) rd = _fault_flags | (_fault_flags << 8) |          \
                         (_fault_flags << 16) | (_fault_flags << 24);     \
      if (i == 0b1100) rd = _fault_flags | ((~_fault_flags & 0xff) << 8) | \
                         (_fault_flags << 16) | ((~_fault_flags & 0xff) << 24); \
    }                                                                   \
    else if (i == 0b0101 || i == 0b1101) {                              \
      int q1 = a & 0xff,         q2 = (a >> 8) & 0xff,                  \
          q3 = (a >> 16) & 0xff, q4 = (a >> 24) & 0xff;                 \
      int _fault_flags = (~(q1 ^ q2) | (q1 ^ q3) | ~(q1 ^ q4)) & 0xff;   \
      if (i == 0b0101) rd = _fault_flags | (_fault_flags << 8) |          \
                         (_fault_flags << 16) | (_fault_flags << 24);     \
      if (i == 0b1101) rd = _fault_flags | ((~_fault_flags & 0xff) << 8) | \
                         (_fault_flags << 16) | ((~_fault_flags & 0xff) << 24); \
    }                                                                   \
    else if (i == 0b11100) {                                            \
      int q1 = a & 0xff,         q2 = (a >> 8) & 0xff,                  \
          q3 = (a >> 16) & 0xff, q4 = (a >> 24) & 0xff;                 \
      int _fault_flags = (q1&q2) | (q1&q3) | (q1&q4) | (q2&q3) | (q2&q4) | (q3&q4); \
      rd = _fault_flags | (_fault_flags << 8) |                         \
        (_fault_flags << 16) | (_fault_flags << 24);                    \
    }                                                                   \
    else if (i == 0b11101) {                                            \
      int q1 = a & 0xff,         q2 = (~a >> 8) & 0xff,                 \
          q3 = (a >> 16) & 0xff, q4 = (~a >> 24) & 0xff;                \
      int _fault_flags = (q1&q2) | (q1&q3) | (q1&q4) | (q2&q3) | (q2&q4) | (q3&q4); \
      rd = _fault_flags | ((~_fault_flags & 0xff) << 8) |                 \
        (_fault_flags << 16) | ((~_fault_flags & 0xff) << 24);            \
    }                                                                   \
                                                                        \
    /* else { */                                                        \
    /* fprintf(stderr, "Invalid FTCHK@%d.\n",i); */                     \
    /* exit(EXIT_FAILURE); */                                           \
    /* } */                                                             \
  }

#define SUBROT_2(r,a) r = ((a << 1) & 0xAAAAAAAA) | ((a >> 1) & 0x55555555)
#define SUBROT_4(r,a) r = ((a << 1) & 0xEEEEEEEE) | ((a >> 3) & 0x11111111)

#ifdef ASM_SOFT
#define ANDC8(r,a,b) {                                          \
    DATATYPE tmp;                                               \
    DATATYPE lmask = 0xFF00FF00, rmask = 0x00FF00FF;            \
    asm volatile("or  %[a_], %[b_], %[r_]\n\t"                  \
                 "and %[r_], %[lmask_], %[r_]\n\t"              \
                 "and %[a_], %[b_], %[tmp_]\n\t"                \
                 "and %[tmp_], %[rmask_], %[tmp_]\n\t"          \
                 "or  %[r_], %[tmp_], %[r_]"                    \
                 : [r_] "=&r" (r), [tmp_] "=r" (tmp)            \
                 : [a_] "r" (a), [b_] "r" (b),                  \
                   [lmask_] "r" (lmask), [rmask_] "r" (rmask)); \
  }
#define XORC8(r,a,b) {                                                  \
    DATATYPE mask = 0xFF00FF00;                                         \
    asm volatile("xor %[a_], %[mask_], %[r_]\n\t"                       \
                 "xor %[b_], %[r_], %[r_]"                              \
                 : [r_] "=&r" (r)                                       \
                 : [a_] "r" (a), [b_] "r" (b), [mask_] "r" (mask) );    \
  }
#else
#define ANDC8(r,a,b)   r = ( ((a) | (b)) & 0xFF00FF00) | ( ((a) & (b)) & 0x00FF00FF)
#define XORC8(r,a,b)   r = (~((a) ^ (b)) & 0xFF00FF00) | ( ((a) ^ (b)) & 0x00FF00FF)
#endif
#define XNORC8(r,a,b)  r = ( ((a) ^ (b)) & 0xFF00FF00) | (~((a) ^ (b)) & 0x00FF00FF)

#ifdef ASM_SOFT
#define ANDC16(r,a,b) {                                                 \
  DATATYPE tmp;                                                         \
  DATATYPE lmask = 0xFFFF0000, rmask = 0x0000FFFF;                      \
  asm volatile("or  %[a_], %[b_], %[r_]\n\t"                            \
               "and %[r_], %[lmask_], %[r_]\n\t"                         \
               "and %[a_], %[b_], %[tmp_]\n\t"                          \
               "and %[tmp_], %[rmask_], %[tmp_]\n\t"                     \
               "or  %[r_], %[tmp_], %[r_]"                              \
               : [r_] "=&r" (r), [tmp_] "=r" (tmp)                       \
               : [a_] "r" (a), [b_] "r" (b),                            \
                 [lmask_] "r" (lmask), [rmask_] "r" (rmask));   \
  }
#define XORC16(r,a,b) {                                                 \
    DATATYPE mask = 0xFFFF0000;                                         \
    asm volatile("xor %[a_], %[mask_], %[r_]\n\t"                       \
                 "xor %[b_], %[r_], %[r_]"                              \
                 : [r_] "=&r" (r)                                        \
                 : [a_] "r" (a), [b_] "r" (b), [mask_] "r" (mask) );    \
  }
#else
#define ANDC16(r,a,b)  r = ( ((a) | (b)) & 0xFFFF0000) | ( ((a) & (b)) & 0x0000FFFF)
#define XORC16(r,a,b)  r = (~((a) ^ (b)) & 0xFFFF0000) | ( ((a) ^ (b)) & 0x0000FFFF)
#endif
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

#define SUBROT_2(r,a) asm volatile("tibsrot %1, 2, %0\n\t" : "=r" (r) : "r" (a) :)
#define SUBROT_4(r,a) asm volatile("tibsrot %1, 4, %0\n\t" : "=r" (r) : "r" (a) :)

#ifdef CHEATY_CUSTOM
#ifdef GCC_SUPPORT
#define ANDC8(r,a,b)   r = (a) & (b)
#define XORC8(r,a,b)   r = (a) ^ (b)
#define ANDC16(r,a,b)  r = (a) & (b)
#define XORC16(r,a,b)  r = (a) ^ (b)
#define ANDC32(r,a,b)  r = (a) & (b)
#define XORC32(r,a,b)  r = (a) ^ (b)
#else
#define ANDC8(r,a,b)   asm volatile("and %1, %2, %0\n\t"   : "=r" (r) : "r" (a), "r" (b) :)
#define XORC8(r,a,b)   asm volatile("xor %1, %2, %0\n\t"   : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC8(r,a,b)  asm volatile("xnor %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define ANDC16(r,a,b)  asm volatile("and %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define XORC16(r,a,b)  asm volatile("xor %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC16(r,a,b) asm volatile("xnor %1, %2, %0\n\t" : "=r" (r) : "r" (a), "r" (b) :)
#define ANDC32(r,a,b)  asm volatile("and %1, %2, %0\n\t"     : "=r" (r) : "r" (a), "r" (b) :)
#define XORC32(r,a,b)  asm volatile("xor %1, %2, %0\n\t"     : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC32(r,a,b) asm volatile("xnor %1, %2, %0\n\t"    : "=r" (r) : "r" (a), "r" (b) :)
#endif
#else
#define ANDC8(r,a,b)   asm volatile("andc8 %1, %2, %0\n\t"   : "=r" (r) : "r" (a), "r" (b) :)
#define XORC8(r,a,b)   asm volatile("xorc8 %1, %2, %0\n\t"   : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC8(r,a,b)  asm volatile("xnorc8 %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define ANDC16(r,a,b)  asm volatile("andc16 %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define XORC16(r,a,b)  asm volatile("xorc16 %1, %2, %0\n\t"  : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC16(r,a,b) asm volatile("xnorc16 %1, %2, %0\n\t" : "=r" (r) : "r" (a), "r" (b) :)
#define ANDC32(r,a,b)  asm volatile("and %1, %2, %0\n\t"     : "=r" (r) : "r" (a), "r" (b) :)
#define XORC32(r,a,b)  asm volatile("xor %1, %2, %0\n\t"     : "=r" (r) : "r" (a), "r" (b) :)
#define XNORC32(r,a,b) asm volatile("xnor %1, %2, %0\n\t"    : "=r" (r) : "r" (a), "r" (b) :)
#endif
#endif

#ifdef COPROC_RAND

#define ADDR 0x80000600
typedef struct {
  volatile unsigned int counter;
  volatile unsigned int reload;
  volatile unsigned int control;
  volatile unsigned int latch;
} timerreg;
typedef struct {
  volatile unsigned int scalercnt;
  volatile unsigned int scalerload;
  volatile unsigned int configreg;
  volatile unsigned int latch;
  timerreg timer[7];
} gptimer;

extern int waiting_cycles;

static unsigned long timer_count_cycles() {
  gptimer* lr = (gptimer*) ADDR;
  static unsigned long count = 0;
  unsigned long lap = (unsigned long) (count - lr->timer[0].counter);
  if (lap < RANDOM_DELAY) waiting_cycles += RANDOM_DELAY - lap;
  count = lr->timer[0].counter;
  return lap;
}
static int state = 0x8e20a6e5;
static int remaining = 32;
static int xorshift_rand() {
  /* NOT AT ALL a xorshift, but it's easier to keep this function name */
  if (remaining == 0) {
    state     = timer_count_cycles();
    remaining = 32;
  }
  int bits_per_rand = 32 / FD;
#ifdef PIPELINED
  bits_per_rand /= 2;
#endif
  remaining -= bits_per_rand;
  return state; // Not quite correct, should depend on TI, FD and PIPELINED
}
#define RAND() xorshift_rand()
#else // #ifdef COPROC_RAND
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
static int __attribute__((noinline)) xorshift_rand() {
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
#endif

#ifdef CST_RAND
#undef RAND
#define RAND() (unsigned int) *((volatile unsigned int*)0x80000600)
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

#if defined(X86) || defined(NO_CUSTOM_INSTR)
#define TI_AND_2(res,a,b) {                           \
    DATATYPE not_fault_flags, a2;                     \
    FD_NOT(not_fault_flags,fault_flags);              \
    a2 = a & not_fault_flags;                         \
                                                      \
    DATATYPE r = RAND();                              \
                                                      \
    DATATYPE c1, a_r, c2, d1, d2, r_r;                \
    FD_AND(c1,a2,b);   /* partial product 1 */        \
    SUBROT_2(a_r,a2);  /* share rotate */             \
    FD_AND(c2,a_r,b);  /* partial product 2 */        \
    FD_XOR(d1,r,c1);   /* random + parprod 1 */       \
    FD_XOR(d2,d1,c2);  /*    + parprod 2 */           \
    SUBROT_2(r_r,r);   /* parallel refresh */         \
    XOR(res,r_r,d2);   /* output */                   \
                                                      \
    if (FD != 1) {                                    \
      DATATYPE g5 = 0;                                \
      FTCHK(g5,IMM_FTCHK,res);                        \
      FD_OR(fault_flags,fault_flags,g5);              \
    }                                                 \
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

#define TI_AND_2(res,a,b) {                                             \
    DATATYPE not_fault_flags, a2;                                       \
    FD_NOT(not_fault_flags,fault_flags);                                \
    a2 = a & not_fault_flags;                                           \
                                                                        \
    DATATYPE r = RAND();                                                \
                                                                        \
    register DATATYPE c1, c2, d1, d2, r_r, a_r;                         \
    asm volatile(                                                       \
        _FD_AND_TI2 " %[b_], %[a2_], %[c1_]\n\t"      /* partial product 1 */ \
        "tibsrot %[a2_], 2, %[a_r_]\n\t"             /* share rotate */     \
        _FD_AND_TI2 " %[a_r_], %[b_], %[c2_]\n\t"     /* partial product 2 */ \
        "xor %[a_r_], %[a_r_], %[a_r_]\n\t"           /* clean subrot output */\
        _FD_XOR_TI2 " %[r_], %[c1_], %[d1_]\n\t"      /* random + parprod 1 */ \
        _FD_XOR_TI2 " %[d1_], %[c2_], %[d2_]\n\t"     /*    + parprod 2 */   \
        "tibsrot %[r_], 2, %[r_r_]\n\t"              /* parallel refresh */ \
        _FD_XOR_TI2 " %[r_r_], %[d2_], %[res_]\n\t"   /* output */           \
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
#define TI_AND_4(res,a,b) {                                         \
    DATATYPE not_fault_flags, a2;                                   \
    FD_NOT(not_fault_flags,fault_flags);                            \
    a2 = a & not_fault_flags;                                       \
                                                                    \
    DATATYPE r = RAND();                                            \
                                                                    \
    DATATYPE c1, c2, c3, c4, a_r1, a_r2, b_r, r_r, d1, d2, d3, d4;  \
    FD_AND(c1,a2,b);    /* partial product 1 */                     \
    SUBROT_4(a_r1,a2);  /* share rotate */                          \
    FD_AND(c2,a_r1,b);  /* partial product 2 */                     \
    SUBROT_4(b_r,b);    /* share rotate */                          \
    FD_AND(c3,b_r,a);   /* partial product 3 */                     \
    SUBROT_4(a_r2,a_r1); /* share rotate */                         \
    FD_AND(c4,a_r2,b);  /* partial product 4 */                     \
    FD_XOR(d1,r,c1);   /* random + parprod 1 */                     \
    FD_XOR(d2,d1,c2);  /*    + parprod 2 */                         \
    FD_XOR(d3,d2,c3);  /*    + parprod 3 */                         \
    SUBROT_2(r_r,r);   /* parallel refresh */                       \
    FD_XOR(d4, d3, r_r);                                            \
    XOR(res,d4,c4);   /* output */                                  \
                                                                    \
    if (FD != 1) {                                                  \
      DATATYPE g5 = 0;                                              \
      FTCHK(g5,IMM_FTCHK,res);                                      \
      FD_OR(fault_flags,fault_flags,g5);                            \
    }                                                               \
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
#define TI_AND_4(res,a,b) {                                         \
    DATATYPE not_fault_flags, a2;                                   \
    FD_NOT(not_fault_flags,fault_flags);                            \
    a2 = a & not_fault_flags;                                       \
                                                                    \
    DATATYPE r = RAND();                                            \
                                                                    \
    register DATATYPE c1, c2, c3, c4, a_r1, a_r2, b_r, r_r, d1, d2, d3, d4; \
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
        _FD_XOR_TI4 " %[d4_], %[c4_], %[res_]\n\t" /* output */       \
                                                                      \
        : [res_] "=&r" (res),                                         \
          [c1_] "=&r" (c1), [c2_] "=&r" (c2), [c3_] "=&r" (c3), [c4_] "=&r" (c4), \
          [d1_] "=&r" (d1), [d2_] "=&r" (d2), [d3_] "=&r" (d3), [d4_] "=&r" (d4), \
          [a_r1_] "=&r" (a_r1), [a_r2_] "=&r" (a_r2),                   \
          [b_r_] "=&r" (b_r),  [r_r_] "=&r" (r_r)                       \
        : [r_] "r" (r), [a2_] "r" (a2), [b_] "r" (b));                  \
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
