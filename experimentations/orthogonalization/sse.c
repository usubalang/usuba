/* gcc -O3 -march=native -o sse sse.c */


#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include <stdint.h>



void print64bin (const unsigned long n) {
  for (int i = 1; i <= 64; i++) {
    printf("%lu",(n>>(64-i)) & 1);
  }  
}

void print128bin (const __m128i v) {
  unsigned long out[2];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}

// Copied-pasted from SSE.h
void real_ortho_128x128(__m128i data[]) {

  __m128i mask_l[7] = {
    _mm_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm_set1_epi64x(0xccccccccccccccccUL),
    _mm_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm_set1_epi64x(0xffff0000ffff0000UL),
    _mm_set1_epi64x(0xffffffff00000000UL),
    _mm_set_epi64x(0UL,-1UL),
  
  };

  __m128i mask_r[7] = {
    _mm_set1_epi64x(0x5555555555555555UL),
    _mm_set1_epi64x(0x3333333333333333UL),
    _mm_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm_set1_epi64x(0x0000ffff0000ffffUL),
    _mm_set1_epi64x(0x00000000ffffffffUL),
    _mm_set_epi64x(-1UL,0UL),
  };
  
  for (int i = 0; i < 7; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 128; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        if (i <= 3) {
          __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
          __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
          __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
          __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
          data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
          data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
        } else if (i == 4) {
          __m128i u = data[j + k];
          __m128i v = data[j + k];
          __m128i x = data[j + n + k];
          __m128i y = data[j + n + k];
          data[j + k] = _mm_blend_epi16(u,_mm_srli_epi64(x, n), 0b01010101);
          data[j + n + k] = _mm_blend_epi16(_mm_slli_epi64(v, n), y, 0b01010101);
        } else if (i == 5) {
          __m128i u = data[j + k];
          __m128i v = data[j + k];
          __m128i x = data[j + n + k];
          __m128i y = data[j + n + k];
          data[j + k] = _mm_blend_epi16(u,_mm_srli_epi64(x, n), 0b00110011);
          data[j + n + k] = _mm_blend_epi16(_mm_slli_epi64(v, n), y, 0b00110011);
        } else {
          __m128i u = data[j + k];
          __m128i v = data[j + k];
          __m128i x = data[j + n + k];
          __m128i y = data[j + n + k];
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm_blend_epi16(u,_mm_slli_si128(x,8), 0b11110000);
          data[j + n + k] = _mm_blend_epi16(_mm_srli_si128(v, 8), y, 0b11110000);
        } 
      }
  }
}

void check_ortho () {
  
  __m128i *restrict buffer = aligned_alloc(32,128 * sizeof *buffer);

  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buffer[i] = _mm_set_epi64x(-1,a);
    a -= (unsigned long)1 << (63-i);
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buffer[i+64] = _mm_set_epi64x(a,0);
    a -= (unsigned long)1 << (63-i);
  }

  for (int i = 0; i < 128; i++)
    print128bin(buffer[i]);

  real_ortho_128x128(buffer);

  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  
  for (int i = 0; i < 128; i++)
    print128bin(buffer[i]); 

}


int main() {

  check_ortho();

  return 0;
  
}
