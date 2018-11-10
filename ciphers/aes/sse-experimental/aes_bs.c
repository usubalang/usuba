
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define NO_RUNTIME
#include "SSE.h"

#include "aes.c"

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

#ifdef UA_LAYOUT
  for (i = 0; i < 8; i++)
    data[i] =  _mm_shuffle_epi8(data[i],_mm_set_epi8(15,11,7,3,
                                                     14,10,6,2,
                                                     13,9,5,1,
                                                     12,8,4,0));
#endif
}

#define swapmove(a, b, n, m, t)                 \
  t = _mm_srli_epi32(b,n);                      \
  t = _mm_xor_si128(t,a);                       \
  t = _mm_and_si128(t,m);                       \
  a = _mm_xor_si128(a,t);                       \
  t = _mm_slli_epi32(t,n);                      \
  b = _mm_xor_si128(b,t);

#define bitslice(x0, x1, x2, x3, x4, x5, x6, x7)    \
  {                                                 \
    __m128i t0, t1;                                 \
    t0 = _mm_set1_epi32(0x55555555);                \
    swapmove(x7, x6, 1, t0, t1);                    \
    swapmove(x5, x4, 1, t0, t1);                    \
    swapmove(x3, x2, 1, t0, t1);                    \
    swapmove(x1, x0, 1, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(0x33333333);                \
    swapmove(x7, x5, 2, t0, t1);                    \
    swapmove(x6, x4, 2, t0, t1);                    \
    swapmove(x3, x1, 2, t0, t1);                    \
    swapmove(x2, x0, 2, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(0x0f0f0f0f);                \
    swapmove(x7, x3, 4, t0, t1);                    \
    swapmove(x6, x2, 4, t0, t1);                    \
    swapmove(x5, x1, 4, t0, t1);                    \
    swapmove(x4, x0, 4, t0, t1);                    \
  }


static inline void aes_bs(DATATYPE plain[8],DATATYPE key[11][8], DATATYPE cipher[8]) {
  
  bitslice(plain[7],plain[6],plain[5],plain[4],plain[3],plain[2],plain[1],plain[0]);
  AES__(plain,key,cipher);
  //for (int i = 0; i < 8; i++) cipher[i] = plain[i];
  bitslice(cipher[7],cipher[6],cipher[5],cipher[4],cipher[3],cipher[2],cipher[1],cipher[0]);
}
