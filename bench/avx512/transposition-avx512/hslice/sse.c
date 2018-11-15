#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

static inline void orthogonalize(__m128i data[8]) {

  __m128i mask_l[3] = {
    _mm_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm_set1_epi64x(0xccccccccccccccccUL),
    _mm_set1_epi64x(0xf0f0f0f0f0f0f0f0UL)
  
  };

  __m128i mask_r[3] = {
    _mm_set1_epi64x(0x5555555555555555UL),
    _mm_set1_epi64x(0x3333333333333333UL),
    _mm_set1_epi64x(0x0f0f0f0f0f0f0f0fUL)
  };

  int i;
  for (i = 0; i < 3; i ++) {
    int n = (1UL << i);
    int j;
    for (j = 0; j < 8; j += (2 * n)) {
      int k;
      for (k = 0; k < n; k ++) {
        __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
        __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
        __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
        __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
        data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
        data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
      }
    }
  }
}


#define NB_LOOP 15000000

int main() {
  __m128i data[8];
  for (int i = 0; i < 8; i++)
    data[i] = _mm_set_epi64x(rand(),rand());

  for (int i = 0; i < 100000; i++)
    orthogonalize(data);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(data);
  timer = _rdtsc() - timer;

  printf("%.2f cycles/byte\n", (double)timer / NB_LOOP / (16*8));


  FILE* FP = fopen("/dev/null","w");
  fwrite(data,16,8,FP);
  fclose(FP);
}
