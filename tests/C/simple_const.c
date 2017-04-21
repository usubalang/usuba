#include <stdlib.h>
#include "mmintrin.h"
#include "immintrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"


void test_tuple__ (__m256i input[3],__m256i output[8]) {
  __m256i a__1 = input[0];
  __m256i a__2 = input[1];
  __m256i a__3 = input[2];

  __m256i b__1;
  __m256i b__2;
  __m256i b__3;
  __m256i b__4;
  __m256i b__5;
  __m256i b__6;
  __m256i b__7;
  __m256i b__8;

  b__1 = a__1;
  b__2 = a__2;
  b__3 = a__3;
  b__4 = _mm256_setzero_si256();
  b__5 = _mm256_setzero_si256();
  b__6 = _mm256_setzero_si256();
  b__7 = _mm256_set1_epi32(-1);
  b__8 = _mm256_set1_epi32(-1);
  output[0] = b__1;
  output[1] = b__2;
  output[2] = b__3;
  output[3] = b__4;
  output[4] = b__5;
  output[5] = b__6;
  output[6] = b__7;
  output[7] = b__8;

}


int main() { return 0; }