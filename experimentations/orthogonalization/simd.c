#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"
#include <inttypes.h>


// From https://stackoverflow.com/a/3974138/4990392
void printBits(size_t const size, void const * const ptr) {
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;

    for (i=size-1;i>=0;i--)
    {
        for (j=7;j>=0;j--)
        {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
    }
}

union U256f {
  __m256i v;
  unsigned int a[8];
};

void print256 (const __m256i v) {
  const union U256f u = { v };
  for (int i = 0; i < 8; ++i)
    printBits(sizeof(u.a[i]),&(u.a[i]));
  puts("");
}



void orthogonalize(__m256i data[]) {

  __m256i mask_l[8] = {
    _mm256_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm256_set1_epi64x(0xccccccccccccccccUL),
    _mm256_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm256_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm256_set1_epi64x(0xffff0000ffff0000UL),
    _mm256_set1_epi64x(0xffffffff00000000UL),
    _mm256_set_epi64x(0xffffffffffffffffUL,0x0000000000000000UL,0xffffffffffffffffUL,0x0000000000000000UL),
    _mm256_set_epi64x(0xffffffffffffffffUL,0xffffffffffffffffUL,0x0000000000000000UL,0x0000000000000000UL),
  
  };

  __m256i mask_r[8] = {
    _mm256_set1_epi64x(0x5555555555555555UL),
    _mm256_set1_epi64x(0x3333333333333333UL),
    _mm256_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm256_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm256_set1_epi64x(0x0000ffff0000ffffUL),
    _mm256_set1_epi64x(0x00000000ffffffffUL),
    _mm256_set_epi64x(0x0000000000000000UL,0xffffffffffffffffUL,0x0000000000000000UL,0xffffffffffffffffUL),
    _mm256_set_epi64x(0x0000000000000000UL,0x0000000000000000UL,0xffffffffffffffffUL,0xffffffffffffffffUL),
  };
  
  for (int i = 0; i < 8; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 256; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m256i u = _mm256_and_si256(data[j + k], mask_l[i]);
        __m256i v = _mm256_and_si256(data[j + k], mask_r[i]);
        __m256i x = _mm256_and_si256(data[j + n + k], mask_l[i]);
        __m256i y = _mm256_and_si256(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm256_or_si256(u, _mm256_srli_epi64(x, n));
          data[j + n + k] = _mm256_or_si256(_mm256_slli_epi64(v, n), y);
        } else if (i == 6) {
          data[j + k] = _mm256_or_si256(u, _mm256_srli_si256(x, 8));
          data[j + n + k] = _mm256_or_si256(_mm256_slli_si256(v, 8), y);
        } else {
          data[j + k] = _mm256_or_si256(u, _mm256_permute2f128_ps( x , x , 1));
          data[j + n + k] = _mm256_or_si256(_mm256_permute2f128_ps( v , v , 1), y);
        }
      }
  }
}

void check_ok () {
  __m256i *restrict buffer = aligned_alloc(32,256 * sizeof *buffer);

  // Initializing the buffer
  for (int i = 0; i < 256; i++) 
    buffer[i] = _mm256_set_epi64x((rand()&0xFFFFFFFF) | (((long)rand())<<32),
                                  (rand()&0xFFFFFFFF) | (((long)rand())<<32),
                                  (rand()&0xFFFFFFFF) | (((long)rand())<<32),
                                  (rand()&0xFFFFFFFF) | (((long)rand())<<32));
  
  for (int i = 0; i < 256; i++)
    print256(buffer[i]);

  printf("\n\n");
  orthogonalize(buffer);

  for (int i = 0; i < 256; i++)
    print256(buffer[i]);

  exit(1);
  
}

int main () {

  srand(7);

  check_ok();
  
  uint64_t start, end;
  int total = 1e7;
  __m256i *restrict buffer = aligned_alloc(32,256 * sizeof *buffer);

  // Initializing the buffer
  for (int i = 0; i < 256; i++) 
    buffer[i] = _mm256_set_epi64x((rand()&0xFFFFFFFF) | (((long)rand())<<32),
                                  (rand()&0xFFFFFFFF) | (((long)rand())<<32),
                                  (rand()&0xFFFFFFFF) | (((long)rand())<<32),
                                  (rand()&0xFFFFFFFF) | (((long)rand())<<32));
    
  /* Warming up the cache */
  for (int i = 0; i < 100; i++)
    orthogonalize(buffer);

  /* The actual mesure */
  start = _rdtsc();
  for (int i = 0; i < total; i++)
      orthogonalize(buffer);
  end = _rdtsc() - start;

  /* Counting how much cycles were lost "looping" */
  start = _rdtsc();
  for (int i = 0; i < total; i++)
    asm("");
  end -= (_rdtsc() - start);

  /* Printing the result */
  printf("Cycles per ortho: %lu\n", end / total);

  return 0;
}
