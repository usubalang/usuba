#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <inttypes.h>

#define WARMUP 1000
#define NB_RUN 100000000

#define NB_RUN_BITSLICE NB_RUN
#define NB_RUN_PACKED   (NB_RUN * 10)


__attribute__ ((noinline)) void speed_packed_parallel() {
  // Initializing data
  __m128i a = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i b = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i c = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i d = _mm_set_epi32(rand(), rand(), rand(), rand());

  // Warming up caches
  for (int i = 0; i < WARMUP; i++) {
    a = _mm_add_epi8(a,d);
    b = _mm_add_epi8(b,d);
    c = _mm_add_epi8(c,d);
  }

  // The actual measurement
  unsigned int unused;
  uint64_t timer = __rdtscp(&unused);
  for (int i = 0; i < NB_RUN_PACKED; i++) {
    a = _mm_add_epi8(a,d);
    b = _mm_add_epi8(b,d);
    c = _mm_add_epi8(c,d);
  }
  timer = __rdtscp(&unused) - timer;

  printf(" 8-bit packed parallel add:   %.2f\n", ((double)timer) / NB_RUN_PACKED / 16 / 3);

  // Prevent data from being optimized out
  asm volatile("" : "+x" (a), "+x" (b), "+x" (c));

}


__attribute__ ((noinline)) void speed_packed() {
  // Initializing data
  __m128i a = _mm_set_epi32(rand(), rand(), rand(), rand());
  __m128i b = _mm_set_epi32(rand(), rand(), rand(), rand());

  // Warming up caches
  for (int i = 0; i < WARMUP; i++)
    a = _mm_add_epi8(a,b);

  // The actual measurement
  unsigned int unused;
  uint64_t timer = __rdtscp(&unused);
  for (int i = 0; i < NB_RUN_PACKED; i++)
    a = _mm_add_epi8(a,b);
  timer = __rdtscp(&unused) - timer;

  printf(" 8-bit packed add:   %.2f\n", ((double)timer) / NB_RUN_PACKED / 16);

  // Prevent data from being optimized out
  asm volatile("" : "+x" (a));

}

#define full_adder(_a,_b,_c,_res) {             \
    __m128i _res_tmp = _a ^ _b ^ _c;            \
    _c = (_a & _b) ^ (_c & (_a ^ _b));          \
    _res = _res_tmp;                            \
  }

#define add_bitslice(a0, a1, a2, a3, a4, a5, a6, a7,    \
                     b0, b1, b2, b3, b4, b5, b6, b7) {  \
    __m128i c = _mm_setzero_si128();                    \
    full_adder(a0,b0,c,a0);                             \
    full_adder(a1,b1,c,a1);                             \
    full_adder(a2,b2,c,a2);                             \
    full_adder(a3,b3,c,a3);                             \
    full_adder(a4,b4,c,a4);                             \
    full_adder(a5,b5,c,a5);                             \
    full_adder(a6,b6,c,a6);                             \
    full_adder(a7,b7,c,a7);                             \
  }                                                     \


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

  __m128i b0 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  __m128i b7 = _mm_set_epi32(rand(),rand(),rand(),rand());

  // Warming up caches
  for (int i = 0; i < WARMUP; i++)
    add_bitslice(a0, a1, a2, a3, a4, a5, a6, a7,
                 b0, b1, b2, b3, b4, b5, b6, b7);

  // The actual measurement
  unsigned int unused;
  uint64_t timer = __rdtscp(&unused);
  for (int i = 0; i < NB_RUN_BITSLICE; i++)
    add_bitslice(a0, a1, a2, a3, a4, a5, a6, a7,
                 b0, b1, b2, b3, b4, b5, b6, b7);
  timer = __rdtscp(&unused) - timer;

  printf(" 8-bit bitslice add: %.2f\n", ((double)timer) / NB_RUN_BITSLICE / 128);

  // Prevent data from being optimized out
  asm volatile("" : "+x" (a0), "+x" (a1), "+x" (a2), "+x" (a3),
                    "+x" (a4), "+x" (a5), "+x" (a6), "+x" (a7));

}


int main() {
  speed_bitslice();
  speed_packed();
  speed_packed_parallel();
}
