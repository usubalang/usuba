
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define NO_RUNTIME
#include "AVX.h"

#include "aes.c"


static inline void orthogonalize(__m256i data[8]) {

  __m256i mask_l[3] = {
    _mm256_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm256_set1_epi64x(0xccccccccccccccccUL),
    _mm256_set1_epi64x(0xf0f0f0f0f0f0f0f0UL)
  
  };

  __m256i mask_r[3] = {
    _mm256_set1_epi64x(0x5555555555555555UL),
    _mm256_set1_epi64x(0x3333333333333333UL),
    _mm256_set1_epi64x(0x0f0f0f0f0f0f0f0fUL)
  };
  
  for (int i = 0; i < 3; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 8; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m256i u = _mm256_and_si256(data[j + k], mask_l[i]);
        __m256i v = _mm256_and_si256(data[j + k], mask_r[i]);
        __m256i x = _mm256_and_si256(data[j + n + k], mask_l[i]);
        __m256i y = _mm256_and_si256(data[j + n + k], mask_r[i]);
        data[j + k] = _mm256_or_si256(u, _mm256_srli_epi64(x, n));
        data[j + n + k] = _mm256_or_si256(_mm256_slli_epi64(v, n), y);
      }
  }

}

#define swapmove(a, b, n, m, t)                 \
  t = _mm256_srli_epi32(b,n);                      \
  t = _mm256_xor_si256(t,a);                       \
  t = _mm256_and_si256(t,m);                       \
  a = _mm256_xor_si256(a,t);                       \
  t = _mm256_slli_epi32(t,n);                      \
  b = _mm256_xor_si256(b,t);

#define bitslice(x0, x1, x2, x3, x4, x5, x6, x7)    \
  {                                                 \
    __m256i t0, t1;                                 \
    t0 = _mm256_set1_epi32(0x55555555);             \
    swapmove(x7, x6, 1, t0, t1);                    \
    swapmove(x5, x4, 1, t0, t1);                    \
    swapmove(x3, x2, 1, t0, t1);                    \
    swapmove(x1, x0, 1, t0, t1);                    \
                                                    \
    t0 = _mm256_set1_epi32(0x33333333);             \
    swapmove(x7, x5, 2, t0, t1);                    \
    swapmove(x6, x4, 2, t0, t1);                    \
    swapmove(x3, x1, 2, t0, t1);                    \
    swapmove(x2, x0, 2, t0, t1);                    \
                                                    \
    t0 = _mm256_set1_epi32(0x0f0f0f0f);             \
    swapmove(x7, x3, 4, t0, t1);                    \
    swapmove(x6, x2, 4, t0, t1);                    \
    swapmove(x5, x1, 4, t0, t1);                    \
    swapmove(x4, x0, 4, t0, t1);                    \
  }

void aes_bs(DATATYPE plain[8],DATATYPE key[11][8], DATATYPE cipher[8]) {
  
  for (int i = 0; i < 8; i++)
    plain[i] = _mm256_shuffle_epi8(plain[i],
                                   _mm256_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7,
                                                   8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
  
  bitslice(plain[7],plain[6],plain[5],plain[4],plain[3],plain[2],plain[1],plain[0]);
  AES__(plain,key,cipher);
  bitslice(cipher[7],cipher[6],cipher[5],cipher[4],cipher[3],cipher[2],cipher[1],cipher[0]);
}
