// Should print 632FAFA2EB93C7209F92ABCBA0C0302B


#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>
#include <stdint.h>

void print256hex (const __m256i v) {
  uint8_t a[32];
  _mm256_store_si256 ((__m256i*)a, v);
  for (int i = 0; i < 32; i++)
    printf("%02X",a[i]);
  puts("");  
}

void print64bin (const uint64_t n) {
  for (int i = 1; i <= 64; i++)
    printf("%lu",(n>>(64-i)) & 1);
}
void print8bin (const uint8_t n) {
  for (int i = 1; i <= 8; i++)
    printf("%d",(n>>(8-i)) & 1);
}

void print128bin (const __m256i v) {
  uint8_t out[32];
  _mm256_store_si256 ((__m256i*)out, v);
  for (int i = 0; i < 32; i++) {
    print8bin(out[i]);
  }
  puts("");
}

void orthogonalize(__m256i data[8]) {

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
  
  for (int i = 0; i < 8; i++)
    data[i] =  _mm256_shuffle_epi8(data[i],
                                   _mm256_set_epi8(15,11,7,3,14,10,6,2,
                                                   13,9,5,1,12,8,4,0,
                                                   15,11,7,3,14,10,6,2,
                                                   13,9,5,1,12,8,4,0));

}


#define NB_LOOP 1000000

int main() {

  __m256i a[8];
  uint8_t x[32] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                    0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF,
                    0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                    0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
  //uint8_t x[16] = { 0x63, 0xC0, 0xAB, 0x20, 0xEB, 0x2F, 0x30, 0xCB,
  //                  0x9F, 0x93, 0xAF, 0x2B, 0xA0, 0x92, 0xC7, 0xA2 };
  for (int i = 0; i < 8; i++)
    a[i] = _mm256_load_si256((__m256i*)x);

  /* puts(""); */
  /* for (int i = 0; i < 8; i++) */
  /*   print256hex(a[i]); */
  /* puts(""); */

  /* orthogonalize(a); */
  
  /* puts(""); */
  /* for (int i = 0; i < 8; i++) */
  /*   print256hex(a[i]); */
  /* puts(""); */
  
  /* orthogonalize(a); */
  
  /* puts(""); */
  /* for (int i = 0; i < 8; i++) */
  /*   print256hex(a[i]); */
  /* puts(""); */


  for (int i = 0; i < 10000; i++) {
    orthogonalize(a);
  }
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    orthogonalize(a);
  }
  timer = _rdtsc() - timer;
  printf("Transpo: %lu\n",timer/NB_LOOP);

  fflush(stdout);
  freopen("/dev/null", "w", stdout);
  for (int i = 0; i < 8; i++)
    print256hex(a[i]);
  
  return 0;
}
