#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

static inline void orthogonalize(__m512i data[8]) {

  __m512i mask_l[3] = {
    _mm512_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm512_set1_epi64x(0xccccccccccccccccUL),
    _mm512_set1_epi64x(0xf0f0f0f0f0f0f0f0UL)
  
  };

  __m512i mask_r[3] = {
    _mm512_set1_epi64x(0x5555555555555555UL),
    _mm512_set1_epi64x(0x3333333333333333UL),
    _mm512_set1_epi64x(0x0f0f0f0f0f0f0f0fUL)
  };
  
  for (int i = 0; i < 3; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 8; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m512i u = _mm512_and_si512(data[j + k], mask_l[i]);
        __m512i v = _mm512_and_si512(data[j + k], mask_r[i]);
        __m512i x = _mm512_and_si512(data[j + n + k], mask_l[i]);
        __m512i y = _mm512_and_si512(data[j + n + k], mask_r[i]);
        data[j + k] = _mm512_or_si512(u, _mm512_srli_epi64(x, n));
        data[j + n + k] = _mm512_or_si512(_mm512_slli_epi64(v, n), y);
      }
  }

}

#define NB_LOOP 200000000

int main() {
  __m512i data[8];
  for (int i = 0; i < 8; i++)
    data[i] = _mm512_set_epi64x(rand(),rand(),rand(),rand(),
                                rand(),rand(),rand(),rand());

  for (int i = 0; i < 100000; i++)
    orthogonalize(data);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(data);
  timer = _rdtsc() - timer;

  printf("%.2f cycles/byte\n", (double)timer / NB_LOOP / (64*8));


  FILE* FP = fopen("/dev/null","w");
  fwrite(data,64,8,FP);
  fclose(FP);
}
