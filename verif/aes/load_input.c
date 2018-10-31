#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <x86intrin.h>

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))


#define BLOCK_SIZE 16
#define PARALLEL_FACTOR 8

#define NO_RUNTIME
#include "SSE.h"


#ifdef C128

#define load_input()                                                    \
  __m128i input[8], out_buff[8];                                        \
  int nb_blocks =  0;                                                   \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                           \
  if (unlikely(((uint64_t*)&counter)[1] > (0xffffffffffffffff-8))) {    \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                  \
      input[nb_blocks] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      incr_128(counter);                                                \
    }                                                                   \
  } else {                                                              \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                  \
      input[nb_blocks] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      counter = _mm_sub_epi64(counter,_mm_slli_si128(ONES,8));          \
    }                                                                   \
  }

#define incr_128(c) {                                   \
    __m128i minus_one = _mm_slli_si128(ONES,8);         \
    __m128i overflow = _mm_cmpeq_epi64(c, minus_one);   \
    c = _mm_sub_epi64(c,minus_one);                     \
    overflow = _mm_srli_si128(overflow,8);              \
    c = _mm_sub_epi64(c,overflow);                      \
  }

#elif defined(C64_REG)


#define load_input()                                                    \
  __m128i input[8], out_buff[8];                                        \
  int nb_blocks =  PARALLEL_FACTOR;                                     \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                           \
  if (unlikely(c1 > (0xffffffffffffffff-8))) {                          \
    for (int i = 0; i < PARALLEL_FACTOR; i++) {                         \
      input[i] = _mm_shuffle_epi8(_mm_set_epi64x(c1,c0),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      if (++c1 == 0) ++c0;                                              \
    }                                                                   \
  }                                                                     \
  else {                                                                \
    for (int i = 0; i < PARALLEL_FACTOR; i++) {                         \
      input[i] = _mm_shuffle_epi8(_mm_set_epi64x(c1,c0),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      ++c1;                                                             \
    }                                                                   \
  }

#else


#define load_input()                                                    \
  __m128i input[8], out_buff[8];                                        \
  int nb_blocks =  PARALLEL_FACTOR;                                     \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                           \
  if (unlikely(counter[1] > (0xffffffffffffffff-8))) {                  \
    for (int i = 0; i < PARALLEL_FACTOR; i++) {                         \
      input[i] = _mm_shuffle_epi8(*((__m128i*)counter),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      incr_counter(counter);                                            \
    }                                                                   \
  }                                                                     \
  else {                                                                \
    for (int i = 0; i < PARALLEL_FACTOR; i++) {                         \
      input[i] = _mm_shuffle_epi8(*((__m128i*)counter),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      ++counter[1];                                                     \
    }                                                                   \
  }
static void incr_counter(unsigned long c[2]) {
  if (++c[1] == 0) ++c[0];
}

#endif


int main() {

  FILE* fp = fopen("/dev/null","w");

  uint64_t n[2];
  n[0] = rand();
  n[1] = rand();

  uint64_t signed_len = rand();
  
#ifdef C128
  __m128i counter = _mm_load_si128((__m128i*)n);
  counter = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
  fwrite(&counter,16,1,fp);
#elif defined(C64_REG)
  register uint64_t c0 = __builtin_bswap64(((uint64_t*)n)[0]);
  register uint64_t c1 = __builtin_bswap64(((uint64_t*)n)[1]);
  fprintf(fp,"%lu%lu\n",c0,c1);
#else
  unsigned long counter[2] __attribute__ ((aligned (32)));
  memcpy(counter, n, 16);
  counter[0] = __builtin_bswap64(counter[0]);
  counter[1] = __builtin_bswap64(counter[1]);
  fwrite(counter,16,1,fp);
#endif

  for (int i = 0; i < 100000; i++) {
    load_input();
    fwrite(input,16,8,fp);
  }
  
}
