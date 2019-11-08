/* gcc -O3 -march=native -o sse sse.c */


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
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}


void orthogonalize(__m128i data[]) {

  __m128i mask_l[7] = {
    _mm_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm_set1_epi64x(0xccccccccccccccccUL),
    _mm_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm_set1_epi64x(0xffff0000ffff0000UL),
    _mm_set1_epi64x(0xffffffff00000000UL),
    _mm_set_epi64x(0x0000000000000000UL,0xffffffffffffffffUL),
  
  };

  __m128i mask_r[7] = {
    _mm_set1_epi64x(0x5555555555555555UL),
    _mm_set1_epi64x(0x3333333333333333UL),
    _mm_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm_set1_epi64x(0x0000ffff0000ffffUL),
    _mm_set1_epi64x(0x00000000ffffffffUL),
    _mm_set_epi64x(0xffffffffffffffffUL,0x0000000000000000UL),
  };
  
  for (int i = 0; i < 7; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 128; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
        __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
        __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
        __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
          data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
        } else {
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm_or_si128(u, _mm_slli_si128(x, 8));
          data[j + n + k] = _mm_or_si128(_mm_srli_si128(v, 8), y);
        } 
      }
    for (int i = 0; i < 128; i++) print128bin(data[i]);
    puts("\n*************************************************\n");
  }
}


#define NB_LOOP 5000000

void eval_speed() {

  __m128i data[128];
  
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

  __m128i data[128];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = _mm_set_epi64x(-1,a);
    a -= (unsigned long)1 << (63-i);
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i+64] = _mm_set_epi64x(a,0);
    a -= (unsigned long)1 << (63-i);
  }

  for (int i = 0; i < 128; i++) print128bin(data[i]);

  orthogonalize(data);
  puts("");

  
  for (int i = 0; i < 128; i++) print128bin(data[i]);
  
  
}

int main() {

  //eval_speed();
  visual();
  
  return 0;
  
}
