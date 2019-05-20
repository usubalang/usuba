#include <x86intrin.h>

void AddRoundKey(__m128i plain[64], __m128i key[64]) {
  for (int i = 0; i < 64; i++)
    plain[i] = _mm_xor_si128(plain[i], key[i]);
}

void SubColumn(__m128i* a0,  __m128i* a1,  __m128i* a2,  __m128i* a3) {
  __m128i t1, t2, t3, t5, t6, t8, t9, t11;
  t1 = _mm_andnot_si128(_mm_set1_epi32(-1),*a1);
  t2 = _mm_and_si128(*a0, t1);
  t3 = _mm_xor_si128(*a2, *a3);
  __m128i a0_tmp = *a0;
  *a0 = _mm_xor_si128(t2, t3);
  t5 = _mm_or_si128(*a3, t1);
  t6 = _mm_xor_si128(a0_tmp, t5);
  __m128i a1_tmp = *a1;
  *a1 = _mm_xor_si128(*a2, t6);
  t8 = _mm_xor_si128(a1_tmp, *a2);
  t9 = _mm_and_si128(t3, t6);
  *a3 = _mm_xor_si128(t8, t9);
  t11 = _mm_or_si128(*a0, t8);
  *a2 = _mm_xor_si128(t6, t11);
}

void ShiftRow(__m128i a[64]) {
  int rot[] = { 0, 1, 12, 13 };
  for (int k = 1; k < 4; k++) {
    __m128i tmp[16];
    for (int i = 0; i < 16; i++)
      tmp[i] = a[k*16+(16+rot[k]+i)%16];
    for (int i = 0; i < 16; i++)
      a[k*16+i] = tmp[i];
  }
}


void Rectangle__(__m128i plain[64], __m128i key[26][64], __m128i cipher[64]) {

  for (int i = 0; i < 25; i++) {
    AddRoundKey(plain,key[i]);
    for (int j = 0; j < 16; j++)
      SubColumn(&plain[j], &plain[j+16], &plain[j+32], &plain[j+48]);
    ShiftRow(plain);
  }

  for (int i = 0; i < 64; i++)
    cipher[i] = _mm_xor_si128(plain[i], key[25][i]);
  
}
