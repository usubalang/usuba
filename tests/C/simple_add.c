#include <stdlib.h>
#include "mmintrin.h"
#include "immintrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"


void f__ (__m256i input[2],__m256i output[1]) {
  __m256i x__ = input[0];
  __m256i y__ = input[1];

  __m256i z__;

  z__ = _mm256_add_epi8(y__,x__);
  output[0] = z__;

}


int main() { return 0; }