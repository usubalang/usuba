#include <stdlib.h>
#include "mmintrin.h"
#include "immintrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"


void is_live__ (__m256i input[9],__m256i output[1]) {
  __m256i v__ = input[0];
  __m256i a__1 = input[1];
  __m256i a__2 = input[2];
  __m256i a__3 = input[3];
  __m256i a__4 = input[4];
  __m256i a__5 = input[5];
  __m256i a__6 = input[6];
  __m256i a__7 = input[7];
  __m256i a__8 = input[8];

  __m256i _tmp57_;
  __m256i _tmp56_;
  __m256i _tmp55_;
  __m256i _tmp54_;
  __m256i _tmp52_;
  __m256i _tmp51_;
  __m256i _tmp49_;
  __m256i _tmp48_;
  __m256i _tmp47_;
  __m256i _tmp46_;
  __m256i _tmp45_;
  __m256i _tmp43_;
  __m256i _tmp42_;
  __m256i b__;

  _tmp42_ = _mm256_andnot_si256(s1__,_mm256_set1_epi32(-1));
  _tmp43_ = _mm256_andnot_si256(s2__,_mm256_set1_epi32(-1));
  _tmp54_ = _mm256_and_si256(_tmp43_,_tmp42_);
  _tmp45_ = _mm256_and_si256(s3__,_tmp54_);
  _tmp46_ = _mm256_and_si256(_tmp45_,v__);
  _tmp47_ = _mm256_andnot_si256(v__,_mm256_set1_epi32(-1));
  _tmp48_ = _mm256_andnot_si256(v1__,_mm256_set1_epi32(-1));
  _tmp49_ = _mm256_andnot_si256(v2__,_mm256_set1_epi32(-1));
  _tmp55_ = _mm256_and_si256(_tmp49_,_tmp48_);
  _tmp51_ = _mm256_and_si256(v3__,_tmp55_);
  _tmp52_ = _mm256_and_si256(v4__,_tmp51_);
  _tmp56_ = _mm256_and_si256(_tmp52_,_tmp47_);
  _tmp57_ = _mm256_or_si256(_tmp56_,_tmp46_);
  b__ = _tmp57_;
  output[0] = b__;

}


int main() { return 0; }