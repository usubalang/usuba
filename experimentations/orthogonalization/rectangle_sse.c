/* gcc -O3 -march=native -o sse sse.c */


#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include <stdint.h>



#define SIZE 8

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

void printData (const __m128i data[SIZE]) {
  for (int i = 0; i < SIZE; i++)
    print128bin(data[i]);
  puts("");
}

void orthogonalize(__m128i data[4]) {

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
    printData(data);
    int n = (1UL << i);
    int j;
    for (j = 0; j < SIZE; j += (2 * n)) {
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
  printData(data);
  exit(1);
}

void check_ortho () {
  
  __m128i buffer[SIZE];

  for (int i = 0; i < SIZE; i++)
    buffer[i] = _mm_set_epi64x(0,0);

  buffer[0] = _mm_set1_epi64x(-1);

  for (int i = 0; i < SIZE; i++)
    print128bin(buffer[i]);
  puts("");

  orthogonalize(buffer);

  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  
  for (int i = 0; i < SIZE; i++)
    print128bin(buffer[i]); 

  orthogonalize(buffer);

  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  
  for (int i = 0; i < SIZE; i++)
    print128bin(buffer[i]); 

}


int main() {

  check_ortho();

  return 0;
  
}
