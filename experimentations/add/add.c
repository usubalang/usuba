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

#define WARMUP 1000

#ifdef PARALLEL
#define NB_RUN_PACKED 10000000000
#elif defined(PACKED)
#define NB_RUN_PACKED 10000000000
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
#define ADD_SIMD _mm_add_epi32
#define PACKED_ADDS 4 // 4 parallel add with a single _mm_add
#define ADD_SIZE "32"
#elif defined(ADD16)
#define ADD_SIMD _mm_add_epi16
#define PACKED_ADDS 8 // 8 parallel add with a single _mm_add
#define ADD_SIZE "16"
#elif defined(ADD8)
#define ADD_SIMD _mm_add_epi8
#define PACKED_ADDS 16 // 16 parallel add with a single _mm_add
#define ADD_SIZE "8"
#else
#error Please define ADD32, ADD16 or ADD8
#endif


#ifdef PARALLEL
__attribute__ ((noinline)) void speed_packed_parallel() {
  // Initializing data
  __m128i a = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i b = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i c = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i d = _mm_set_epi32(rand(), rand(), rand(), rand());

  // Warming up caches
  for (int i = 0; i < WARMUP; i++) {
    a = ADD_SIMD(a,d);
    b = ADD_SIMD(b,d);
    c = ADD_SIMD(c,d);
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
    a = ADD_SIMD(a,d);
    b = ADD_SIMD(b,d);
    c = ADD_SIMD(c,d);
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
  asm volatile("" : "+x" (a), "+x" (b), "+x" (c));

}
#endif


#ifdef PACKED
__attribute__ ((noinline)) void speed_packed() {
  // Initializing data
  __m128i a = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i b = _mm_set_epi32(rand(), rand(), rand(), rand());

  // Warming up caches
  for (unsigned long i = 0; i < WARMUP; i++) {
    a = ADD_SIMD(a,b);
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
    a = ADD_SIMD(a,b);
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
  asm volatile("" : "+x" (a));

}
#endif


#ifdef BITSLICE
#define full_adder(_a,_b,_c,_res) {             \
    __m128i _res_tmp = _a ^ _b ^ _c;            \
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
    __m128i c = _mm_setzero_si128();                            \
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
    __m128i c = _mm_setzero_si128();                            \
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
    __m128i c = _mm_setzero_si128();                            \
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
  __m128i a0 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a7 = _mm_set_epi32(rand(),rand(),rand(),rand());
#if defined(ADD16) || defined(ADD32)
  __m128i a8 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a9 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a10 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a11 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a12 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a13 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a14 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a15 = _mm_set_epi32(rand(),rand(),rand(),rand());
#if defined(ADD32)
  __m128i a16 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a17 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a18 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a19 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a20 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a21 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a22 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a23 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a24 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a25 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a26 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a27 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a28 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a29 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a30 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i a31 = _mm_set_epi32(rand(),rand(),rand(),rand());
#endif
#endif

  __m128i b0 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b7 = _mm_set_epi32(rand(),rand(),rand(),rand());
#if defined(ADD16) || defined(ADD32)
  __m128i b8 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b9 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b10 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b11 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b12 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b13 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b14 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b15 = _mm_set_epi32(rand(),rand(),rand(),rand());
#if defined(ADD32)
  __m128i b16 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b17 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b18 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b19 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b20 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b21 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b22 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b23 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b24 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b25 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b26 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b27 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b28 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b29 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b30 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b31 = _mm_set_epi32(rand(),rand(),rand(),rand());
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
					  : "+x" (a0) : : "memory" );
#elif defined(MCA_BITSLICE)
    __asm volatile("# LLVM-MCA-BEGIN bitslice" : "+x" (a0));
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
         ((double)timer)/NB_RUN_BITSLICE, ((double)timer) / NB_RUN_BITSLICE / 128);

  // Prevent data from being optimized out
  // (can't do in a single "asm volatile" because it requires too many registers)
  asm volatile("" : "+x" (a0),  "+x" (a1),  "+x" (a2),  "+x" (a3),
                    "+x" (a4),  "+x" (a5),  "+x" (a6),  "+x" (a7));
#if defined(ADD16) || defined(ADD32)
  asm volatile("" : "+x" (a8),  "+x" (a9),  "+x" (a10), "+x" (a11),
                    "+x" (a12), "+x" (a13), "+x" (a14), "+x" (a15));
#if defined(ADD32)
  asm volatile("" : "+x" (a16), "+x" (a17), "+x" (a18), "+x" (a19),
                    "+x" (a20), "+x" (a21), "+x" (a22), "+x" (a23));
  asm volatile("" : "+x" (a24), "+x" (a25), "+x" (a26), "+x" (a27),
                    "+x" (a28), "+x" (a29), "+x" (a30), "+x" (a31));
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
