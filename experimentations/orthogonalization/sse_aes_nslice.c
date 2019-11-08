#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
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


void orthogonalize(__m128i data[8]) {

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
    for (int j = 0; j < 8; j += (2 * n)) {
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
}


#define NB_LOOP 100000000

void eval_speed() {

  __m128i data[8];
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < 100000; i++)
    orthogonalize(data);
  timer = _rdtsc() - timer;
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(data);
  timer = _rdtsc() - timer;
  printf("Cycles per ortho: %lu\n", timer / NB_LOOP);
  
  FILE* f = fopen("/dev/null","r");
  fwrite(data,8,16,f);

}

void visual() {

  __m128i data[8];
  for (int i = 0; i < 8; i++) {
    data[i] = _mm_set1_epi8(i == 0 ? 0xFF :
                            i == 1 ? 0x7F :
                            i == 2 ? 0x3F :
                            i == 3 ? 0x1F :
                            i == 4 ? 0x0F :
                            i == 5 ? 0x07 :
                            i == 6 ? 0x03 :
                            i == 7 ? 0x01 : 0);
    /* data[i] = i%2 ? _mm_set_epi8(0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, */
    /*                              0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF) : */
    /*   _mm_set_epi8(0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, */
    /*                0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00); */
  }

  for (int i = 0; i < 8; i++) print128bin(data[i]);

  orthogonalize(data);
  puts("");

  
  for (int i = 0; i < 8; i++) print128bin(data[i]);
  
  
}

int main() {

  //eval_speed();
  visual();
  
  return 0;
  
}
