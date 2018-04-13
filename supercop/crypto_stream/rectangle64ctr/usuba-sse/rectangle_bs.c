
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define NO_RUNTIME
#include "SSE.h"

#include "rectangle.c"


void real_ortho_128x128(__m128i data[4]) {

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
  
  for (int i = 0; i < 3; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 4; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
        __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
        __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
        __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
        data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
        data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
      }
  }
  
  for (int i = 0; i < 4; i++)
    data[i] =  _mm_shuffle_epi8(data[i],_mm_set_epi8(15,11,7,3,
                                                     14,10,6,2,
                                                     13,9,5,1,
                                                     12,8,4,0));  
}


void rectangle_bs(DATATYPE plain[4],DATATYPE key[26][4], DATATYPE cipher[4]) {
  orthogonalize(plain);
  Rectangle__(plain,key,cipher);
  orthogonalize(cipher);  
}
