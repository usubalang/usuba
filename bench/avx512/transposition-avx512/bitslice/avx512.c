#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>


void orthogonalize(__m512i data[]) {

  __m512i mask_l[9] = {
    _mm512_set1_epi64(0xaaaaaaaaaaaaaaaaUL),
    _mm512_set1_epi64(0xccccccccccccccccUL),
    _mm512_set1_epi64(0xf0f0f0f0f0f0f0f0UL),
    _mm512_set1_epi64(0xff00ff00ff00ff00UL),
    _mm512_set1_epi64(0xffff0000ffff0000UL),
    _mm512_set1_epi64(0xffffffff00000000UL),
    _mm512_set_epi64(0UL,-1UL,0UL,-1UL,0UL,-1UL,0UL,-1UL),
    _mm512_set_epi64(0UL,0UL,-1UL,-1UL,0UL,0UL,-1UL,-1UL),
    _mm512_set_epi64(0UL,0UL,0UL,0UL,-1UL,-1UL,-1UL,-1UL),
  };

  __m512i mask_r[9] = {
    _mm512_set1_epi64(0x5555555555555555UL),
    _mm512_set1_epi64(0x3333333333333333UL),
    _mm512_set1_epi64(0x0f0f0f0f0f0f0f0fUL),
    _mm512_set1_epi64(0x00ff00ff00ff00ffUL),
    _mm512_set1_epi64(0x0000ffff0000ffffUL),
    _mm512_set1_epi64(0x00000000ffffffffUL),
    _mm512_set_epi64(-1UL,0UL,-1UL,0UL,-1UL,0UL,-1UL,0UL),
    _mm512_set_epi64(-1UL,-1UL,0UL,0UL,-1UL,-1UL,0UL,0UL),
    _mm512_set_epi64(-1UL,-1UL,-1UL,-1UL,0UL,0UL,0UL,0UL),
  };
  
  for (int i = 0; i < 9; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 512; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m512i u = _mm512_and_si512(data[j + k], mask_l[i]);
        __m512i v = _mm512_and_si512(data[j + k], mask_r[i]);
        __m512i x = _mm512_and_si512(data[j + n + k], mask_l[i]);
        __m512i y = _mm512_and_si512(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm512_or_si512(u, _mm512_srli_epi64(x, n));
          data[j + n + k] = _mm512_or_si512(_mm512_slli_epi64(v, n), y);
        } else if (i == 6) {
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm512_or_si512(u, _mm512_bslli_epi128(x, 8));
          data[j + n + k] = _mm512_or_si512(_mm512_bsrli_epi128(v, 8), y);
        } else if (i == 7) {
          /* might be 0b01001110 instead */
          data[j + k] = _mm512_or_si512(u, _mm512_permutex_epi64(x,0b10110001));
          data[j + n + k] = _mm512_or_si512(_mm512_permutex_epi64(v,0b10110001), y);
        } else {
          /* might be 0,1,2,3,4,5,6,7 */
          __m512i ctrl = _mm512_set_epi64(4,5,6,7,0,1,2,3);
          data[j + k] = _mm512_or_si512(u, _mm512_permutexvar_epi64(ctrl,x));
          data[j + n + k] = _mm512_or_si512(_mm512_permutexvar_epi64(ctrl,v), y);
        }
      }
  }
}



#define NB_LOOP 200000

int main() {
  __m512i data[512];
  for (int i = 0; i < 512; i++)
    data[i] =  _mm512_set_epi64(rand(),rand(),rand(),rand(),
                                rand(),rand(),rand(),rand());

  for (int i = 0; i < 100000; i++)
    orthogonalize(data);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(data);
  timer = _rdtsc() - timer;

  printf("%.2f cycles/byte\n", (double)timer / NB_LOOP / (64*512));


  FILE* FP = fopen("/dev/null","w");
  fwrite(data,64,512,FP);
  fclose(FP);
}
