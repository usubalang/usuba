/* Some explanations might be helpful since quite a few macros are
   used. You should also read the Readme accompanying this program.

   - You _always_ need to define either ADD32, ADD16 or ADD8,
     depending on whether you want to compare additions on 8, 16 or 32
     bits. If you just want to run the program, there is nothing more
     to do.

   - If you want to use IACA to analyze loops, define either
     IACA_PARALLEL, IACA_PACKED or IACA_BITSLICE.

   - If you want to use llvm-mca to analyze loops, define either
     MCA_PARALLEL, MCA_PACKED of MCA_BITSLICE.

   - If you want to only run only one or two of the additions, define
     either PARALLEL, PACKED or BITSLICE. (if none are defined, then
     all additions are ran) This should be useful if you want to use
     perf or vtune to analyze performances. Note that this will
     increase the loop number to make the program run longer.
 */

#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <inttypes.h>

#if defined(IACA_PARALLEL) || defined(IACA_PACKED) || defined(IACA_BITSLICE)
#include "iacaMarks.h"
#endif

#if defined(MCA_PARALLEL)
#define PARALLEL
#elif defined(MCA_PACKED)
#define PACKED
#elif defined(MCA_BITSLICE)
#define BITSLICE
#endif

#define WARMUP 1000

#if ! (defined(SSE) || defined(GP))
#define SSE
#endif

#ifdef SSE
#define DATATYPE __m128i
#define ADD_32(_a,_b) _mm_add_epi32(_a,_b)
#define ADD_16(_a,_b) _mm_add_epi16(_a,_b)
#define ADD_8(_a,_b)  _mm_add_epi8(_a,_b)
#define PACKED_ADDS_32 4 // 4 parallel add with a single _mm_add
#define PACKED_ADDS_16 8 // 8 parallel add with a single _mm_add
#define PACKED_ADDS_8 16 // 16 parallel add with a single _mm_add
#define REG_SIZE (sizeof(__m128i)*8)
#define ZERO _mm_setzero_si128()
#define INIT() _mm_set_epi32(rand(), rand(), rand(), rand())
#define ASM_MOD "x"
#elif defined(GP)
#define DATATYPE int
#define ADD_32(_a,_b) ((_a) + (_b))
#define ADD_16(_a,_b) ((_a) + (_b))
#define ADD_8(_a,_b) ((_a) + (_b))
#define PACKED_ADDS_32 1
#define PACKED_ADDS_16 1
#define PACKED_ADDS_8 1
#define ZERO 0
#define REG_SIZE (sizeof(int)*8)
#define INIT() rand()
#define ASM_MOD "r"
#else
#error SSE or GP must be defined
#endif


#ifdef PARALLEL
#define NB_RUN_PACKED 10000000000
#elif defined(PACKED)
#define NB_RUN_PACKED 500000000
#elif defined(BITSLICE)
#define NB_RUN_BITSLICE 200000000
#else
#define NB_RUN 100000000
#define NB_RUN_BITSLICE NB_RUN
#define NB_RUN_PACKED   (NB_RUN * 10)
#endif

#if ! (defined(PARALLEL) || defined(PACKED) || defined(BITSLICE))
#define BITSLICE
#define PARALLEL
#define PACKED
#endif

#ifdef ADD32
#define ADD_NATIVE(_a,_b) ADD_32(_a,_b)
#define PACKED_ADDS PACKED_ADDS_32
#define ADD_SIZE "32"
#elif defined(ADD16)
#define ADD_NATIVE(_a,_b) ADD_16(_a,_b)
#define PACKED_ADDS PACKED_ADDS_16
#define ADD_SIZE "16"
#elif defined(ADD8)
#define ADD_NATIVE(_a,_b) ADD_8(_a,_b)
#define PACKED_ADDS PACKED_ADDS_8
#define ADD_SIZE "8"
#else
#error Please define ADD32, ADD16 or ADD8
#endif


#ifdef PARALLEL
__attribute__ ((noinline)) void speed_packed_parallel() {
  // Initializing data
  DATATYPE a = INIT();
  DATATYPE b = INIT();
  DATATYPE c = INIT();
  DATATYPE d = INIT();

  // Warming up caches
  for (int i = 0; i < WARMUP; i++) {
    asm volatile("" : "+"ASM_MOD (a), "+"ASM_MOD (b), "+"ASM_MOD (c));
    a = ADD_NATIVE(a,d);
    b = ADD_NATIVE(b,d);
    c = ADD_NATIVE(c,d);
  }

  // The actual measurement
  unsigned int unused;
  uint64_t timer = __rdtscp(&unused);
  for (unsigned long i = 0; i < NB_RUN_PACKED; i++) {
  #ifdef IACA_PARALLEL
    IACA_START
#elif defined(MCA_PARALLEL)
    __asm volatile("# LLVM-MCA-BEGIN parallel");
#endif
    asm volatile("" : "+"ASM_MOD (a), "+"ASM_MOD (b), "+"ASM_MOD (c));
    a = ADD_NATIVE(a,d);
    b = ADD_NATIVE(b,d);
    c = ADD_NATIVE(c,d);
  }
#ifdef IACA_PARALLEL
  IACA_END
#elif defined(MCA_PARALLEL)
  __asm volatile("# LLVM-MCA-END");
#endif
  timer = __rdtscp(&unused) - timer;

  printf(ADD_SIZE "-bit packed parallel add: %5.2f cycles/loop  (%.2f cycles/add)\n",
         ((double)timer)/NB_RUN_PACKED,
         ((double)timer) / NB_RUN_PACKED / PACKED_ADDS / 3);

  // Prevent data from being optimized out
  asm volatile("" : "+"ASM_MOD (a), "+"ASM_MOD (b), "+"ASM_MOD (c));

}
#endif


#ifdef PACKED
__attribute__ ((noinline)) void speed_packed() {
  // Initializing data
  DATATYPE a = INIT();
  DATATYPE b = INIT();

  // Warming up caches
  for (unsigned long i = 0; i < WARMUP; i++) {
    asm volatile("" : "+"ASM_MOD (a));
    a = ADD_NATIVE(a,b);
  }

  // The actual measurement
  unsigned int unused;
  uint64_t timer = __rdtscp(&unused);
  for (unsigned long i = 0; i < NB_RUN_PACKED; i++) {
#ifdef IACA_PACKED
    IACA_START
#elif defined(MCA_PACKED)
    __asm volatile("# LLVM-MCA-BEGIN packed");
#endif
    asm volatile("" : "+"ASM_MOD (a));
    a = ADD_NATIVE(a,b);
  }
#ifdef IACA_PACKED
  IACA_END
#elif defined(MCA_PACKED)
  __asm volatile("# LLVM-MCA-END");
#endif
  timer = __rdtscp(&unused) - timer;

  printf(ADD_SIZE "-bit packed add:          %5.2f cycles/loop  (%.2f cycles/add)\n",
         ((double)timer)/NB_RUN_PACKED,
         ((double)timer) / NB_RUN_PACKED / PACKED_ADDS);

  // Prevent data from being optimized out
  asm volatile("" : "+"ASM_MOD (a));

}
#endif


#ifdef BITSLICE
#define full_adder(_a,_b,_c,_res) {             \
    DATATYPE _res_tmp = _a ^ _b ^ _c;            \
    _c = (_a & _b) ^ (_c & (_a ^ _b));          \
    _res = _res_tmp;                            \
  }

#ifdef ADD32
#define add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,    \
                     a8,  a9,  a10, a11, a12, a13, a14, a15,    \
                     a16, a17, a18, a19, a20, a21, a22, a23,    \
                     a24, a25, a26, a27, a28, a29, a30, a31,    \
                     b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7,    \
                     b8,  b9,  b10, b11, b12, b13, b14, b15,    \
                     b16, b17, b18, b19, b20, b21, b22, b23,    \
                     b24, b25, b26, b27, b28, b29, b30, b31) {  \
    DATATYPE c = ZERO;                            \
    full_adder(a0,b0,c,a0);                                     \
    full_adder(a1,b1,c,a1);                                     \
    full_adder(a2,b2,c,a2);                                     \
    full_adder(a3,b3,c,a3);                                     \
    full_adder(a4,b4,c,a4);                                     \
    full_adder(a5,b5,c,a5);                                     \
    full_adder(a6,b6,c,a6);                                     \
    full_adder(a7,b7,c,a7);                                     \
    full_adder(a8,b8,c,a9);                                     \
    full_adder(a9,b9,c,a9);                                     \
    full_adder(a10,b10,c,a10);                                  \
    full_adder(a11,b11,c,a11);                                  \
    full_adder(a12,b12,c,a12);                                  \
    full_adder(a13,b13,c,a13);                                  \
    full_adder(a14,b14,c,a14);                                  \
    full_adder(a15,b15,c,a15);                                  \
    full_adder(a16,b16,c,a16);                                  \
    full_adder(a17,b17,c,a17);                                  \
    full_adder(a18,b18,c,a18);                                  \
    full_adder(a19,b19,c,a19);                                  \
    full_adder(a20,b20,c,a20);                                  \
    full_adder(a21,b21,c,a21);                                  \
    full_adder(a22,b22,c,a22);                                  \
    full_adder(a23,b23,c,a23);                                  \
    full_adder(a24,b24,c,a24);                                  \
    full_adder(a25,b25,c,a25);                                  \
    full_adder(a26,b26,c,a26);                                  \
    full_adder(a27,b27,c,a27);                                  \
    full_adder(a28,b28,c,a28);                                  \
    full_adder(a29,b29,c,a29);                                  \
    full_adder(a30,b30,c,a30);                                  \
    full_adder(a31,b31,c,a31);                                  \
  }

#elif defined(ADD16)
#define add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,    \
                     a8,  a9,  a10, a11, a12, a13, a14, a15,    \
                     b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7,    \
                     b8,  b9,  b10, b11, b12, b13, b14, b15) {  \
    DATATYPE c = ZERO;                            \
    full_adder(a0,b0,c,a0);                                     \
    full_adder(a1,b1,c,a1);                                     \
    full_adder(a2,b2,c,a2);                                     \
    full_adder(a3,b3,c,a3);                                     \
    full_adder(a4,b4,c,a4);                                     \
    full_adder(a5,b5,c,a5);                                     \
    full_adder(a6,b6,c,a6);                                     \
    full_adder(a7,b7,c,a7);                                     \
    full_adder(a8,b8,c,a9);                                     \
    full_adder(a9,b9,c,a9);                                     \
    full_adder(a10,b10,c,a10);                                  \
    full_adder(a11,b11,c,a11);                                  \
    full_adder(a12,b12,c,a12);                                  \
    full_adder(a13,b13,c,a13);                                  \
    full_adder(a14,b14,c,a14);                                  \
    full_adder(a15,b15,c,a15);                                  \
  }

#elif defined(ADD8)
#define add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,    \
                     b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7) {  \
    DATATYPE c = ZERO;                            \
    full_adder(a0,b0,c,a0);                                     \
    full_adder(a1,b1,c,a1);                                     \
    full_adder(a2,b2,c,a2);                                     \
    full_adder(a3,b3,c,a3);                                     \
    full_adder(a4,b4,c,a4);                                     \
    full_adder(a5,b5,c,a5);                                     \
    full_adder(a6,b6,c,a6);                                     \
    full_adder(a7,b7,c,a7);                                     \
  }

#endif

__attribute__ ((noinline)) void speed_bitslice() {

  // Initializing data
  DATATYPE a0 = INIT();
  DATATYPE a1 = INIT();
  DATATYPE a2 = INIT();
  DATATYPE a3 = INIT();
  DATATYPE a4 = INIT();
  DATATYPE a5 = INIT();
  DATATYPE a6 = INIT();
  DATATYPE a7 = INIT();
#if defined(ADD16) || defined(ADD32)
  DATATYPE a8 = INIT();
  DATATYPE a9 = INIT();
  DATATYPE a10 = INIT();
  DATATYPE a11 = INIT();
  DATATYPE a12 = INIT();
  DATATYPE a13 = INIT();
  DATATYPE a14 = INIT();
  DATATYPE a15 = INIT();
#if defined(ADD32)
  DATATYPE a16 = INIT();
  DATATYPE a17 = INIT();
  DATATYPE a18 = INIT();
  DATATYPE a19 = INIT();
  DATATYPE a20 = INIT();
  DATATYPE a21 = INIT();
  DATATYPE a22 = INIT();
  DATATYPE a23 = INIT();
  DATATYPE a24 = INIT();
  DATATYPE a25 = INIT();
  DATATYPE a26 = INIT();
  DATATYPE a27 = INIT();
  DATATYPE a28 = INIT();
  DATATYPE a29 = INIT();
  DATATYPE a30 = INIT();
  DATATYPE a31 = INIT();
#endif
#endif

  DATATYPE b0 = INIT();
  DATATYPE b1 = INIT();
  DATATYPE b2 = INIT();
  DATATYPE b3 = INIT();
  DATATYPE b4 = INIT();
  DATATYPE b5 = INIT();
  DATATYPE b6 = INIT();
  DATATYPE b7 = INIT();
#if defined(ADD16) || defined(ADD32)
  DATATYPE b8 = INIT();
  DATATYPE b9 = INIT();
  DATATYPE b10 = INIT();
  DATATYPE b11 = INIT();
  DATATYPE b12 = INIT();
  DATATYPE b13 = INIT();
  DATATYPE b14 = INIT();
  DATATYPE b15 = INIT();
#if defined(ADD32)
  DATATYPE b16 = INIT();
  DATATYPE b17 = INIT();
  DATATYPE b18 = INIT();
  DATATYPE b19 = INIT();
  DATATYPE b20 = INIT();
  DATATYPE b21 = INIT();
  DATATYPE b22 = INIT();
  DATATYPE b23 = INIT();
  DATATYPE b24 = INIT();
  DATATYPE b25 = INIT();
  DATATYPE b26 = INIT();
  DATATYPE b27 = INIT();
  DATATYPE b28 = INIT();
  DATATYPE b29 = INIT();
  DATATYPE b30 = INIT();
  DATATYPE b31 = INIT();
#endif
#endif


  // Warming up caches
  for (unsigned long i = 0; i < WARMUP; i++) {
#ifdef ADD8
    add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,
                 b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7);
#elif defined(ADD16)
    add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,
                 a8,  a9,  a10, a11, a12, a13, a14, a15,
                 b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7,
                 b8,  b9,  b10, b11, b12, b13, b14, b15);
#elif defined(ADD32)
    add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,
                 a8,  a9,  a10, a11, a12, a13, a14, a15,
                 a16, a17, a18, a19, a20, a21, a22, a23,
                 a24, a25, a26, a27, a28, a29, a30, a31,
                 b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7,
                 b8,  b9,  b10, b11, b12, b13, b14, b15,
                 b16, b17, b18, b19, b20, b21, b22, b23,
                 b24, b25, b26, b27, b28, b29, b30, b31);
#endif
  }

  // The actual measurement
  unsigned int unused;
  uint64_t timer = __rdtscp(&unused);
  for (unsigned long i = 0; i < NB_RUN_BITSLICE; i++) {
#ifdef IACA_BITSLICE
    __asm__ __volatile__ (
					  "\n\t  movl $111, %%ebx"
					  "\n\t  .byte 0x64, 0x67, 0x90"
					  : "+"ASM_MOD (a0) : : "memory" );
#elif defined(MCA_BITSLICE)
    __asm volatile("# LLVM-MCA-BEGIN bitslice" : "+"ASM_MOD (a0));
#endif
#ifdef ADD8
    add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,
                 b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7);
#elif defined(ADD16)
    add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,
                 a8,  a9,  a10, a11, a12, a13, a14, a15,
                 b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7,
                 b8,  b9,  b10, b11, b12, b13, b14, b15);
#elif defined(ADD32)
    add_bitslice(a0,  a1,  a2,   a3,  a4,  a5,  a6,  a7,
                 a8,  a9,  a10, a11, a12, a13, a14, a15,
                 a16, a17, a18, a19, a20, a21, a22, a23,
                 a24, a25, a26, a27, a28, a29, a30, a31,
                 b0,  b1,  b2,   b3,  b4,  b5,  b6,  b7,
                 b8,  b9,  b10, b11, b12, b13, b14, b15,
                 b16, b17, b18, b19, b20, b21, b22, b23,
                 b24, b25, b26, b27, b28, b29, b30, b31);
#endif
  }
#ifdef IACA_BITSLICE
  IACA_END
#elif defined(MCA_BITSLICE)
  __asm volatile("# LLVM-MCA-END");
#endif
  timer = __rdtscp(&unused) - timer;

  printf(ADD_SIZE "-bit bitslice add:        %5.2f cycles/loop  (%.2f cycles/add)\n",
         ((double)timer)/NB_RUN_BITSLICE, ((double)timer) / NB_RUN_BITSLICE / REG_SIZE);

  // Prevent data from being optimized out
  // (can't do in a single "asm volatile" because it requires too many registers)
  asm volatile("" : "+"ASM_MOD (a0),  "+"ASM_MOD (a1),  "+"ASM_MOD (a2),  "+"ASM_MOD (a3),
                    "+"ASM_MOD (a4),  "+"ASM_MOD (a5),  "+"ASM_MOD (a6),  "+"ASM_MOD (a7));
#if defined(ADD16) || defined(ADD32)
  asm volatile("" : "+"ASM_MOD (a8),  "+"ASM_MOD (a9),  "+"ASM_MOD (a10), "+"ASM_MOD (a11),
                    "+"ASM_MOD (a12), "+"ASM_MOD (a13), "+"ASM_MOD (a14), "+"ASM_MOD (a15));
#if defined(ADD32)
  asm volatile("" : "+"ASM_MOD (a16), "+"ASM_MOD (a17), "+"ASM_MOD (a18), "+"ASM_MOD (a19),
                    "+"ASM_MOD (a20), "+"ASM_MOD (a21), "+"ASM_MOD (a22), "+"ASM_MOD (a23));
  asm volatile("" : "+"ASM_MOD (a24), "+"ASM_MOD (a25), "+"ASM_MOD (a26), "+"ASM_MOD (a27),
                    "+"ASM_MOD (a28), "+"ASM_MOD (a29), "+"ASM_MOD (a30), "+"ASM_MOD (a31));
#endif
#endif

}
#endif


int main() {
#ifdef BITSLICE
  speed_bitslice();
#endif

#ifdef PACKED
  speed_packed();
#endif

#ifdef PARALLEL
  speed_packed_parallel();
#endif
}
