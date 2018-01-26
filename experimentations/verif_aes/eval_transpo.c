// Should print 632FAFA2EB93C7209F92ABCBA0C0302B


#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>
#include <stdint.h>

void print128hex (const __m128i v) {
  uint8_t a[16];
  _mm_store_si128 ((__m128i*)a, v);
  for (int i = 0; i < 16; i++)
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

void print128bin (const __m128i v) {
  uint8_t out[16];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i < 16; i++) {
    print8bin(out[i]);
  }
  puts("");
}


void real_ortho_128x128(__m128i data[8]) {

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
    for (int j = 0; j < 8; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
        __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
        __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
        __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
        data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
        data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
      }
  }
  
  for (int i = 0; i < 8; i++)
    data[i] =  _mm_shuffle_epi8(data[i],_mm_set_epi8(15,11,7,3,
                                                     14,10,6,2,
                                                     13,9,5,1,
                                                     12,8,4,0));  
}


#define NB_LOOP 1e8

int main() {

  __m128i a[8];
  uint8_t x[16] = { 0x63, 0xC0, 0xAB, 0x20, 0xEB, 0x2F, 0x30, 0xCB,
                    0x9F, 0x93, 0xAF, 0x2B, 0xA0, 0x92, 0xC7, 0xA2 };
  for (int i = 0; i < 8; i++)
    a[i] = _mm_load_si128((__m128i*)x);

  uint64_t timer = _rdtsc();
  real_ortho_128x128(a);
  timer = _rdtsc() - timer;
  printf("Just one: %lu\n",timer);

  for (int i = 0; i < 1000; i++) {
    real_ortho_128x128(a);
  }
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    real_ortho_128x128(a);
  }
  timer = _rdtsc() - timer;
  printf("Transpo: %lu\n",timer/(unsigned long)NB_LOOP);

  freopen("w", "/dev/null",stdout);
  for (int i = 0; i < 8; i++)
    print128hex(a[i]);
  
  
  return 0;
}
