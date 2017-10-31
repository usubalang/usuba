#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"
#include <inttypes.h>



void print64bin (const unsigned long n) {
  for (int i = 1; i <= 64; i++) {
    printf("%lu",(n>>(64-i)) & 1);
  }  
}

void print256bin (const __m256i v) {
  unsigned long out[4];
  _mm256_store_si256 ((__m256i*)out, v);
  for (int i = 0; i < 4; i++) {
    print64bin(out[i]);
  }
  puts("");
}





void orthogonalize_64(unsigned long data[]) {

  static unsigned long mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
  };

  static unsigned long mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
  };
  
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        unsigned long u = data[j + k] & mask_l[i];
        unsigned long v = data[j + k] & mask_r[i];
        unsigned long x = data[j + n + k] & mask_l[i];
        unsigned long y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}


void orthogonalize(__m256i data[]) {

  __m256i mask_l[8] = {
    _mm256_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm256_set1_epi64x(0xccccccccccccccccUL),
    _mm256_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm256_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm256_set1_epi64x(0xffff0000ffff0000UL),
    _mm256_set1_epi64x(0xffffffff00000000UL),
    _mm256_set_epi64x(0x0000000000000000UL,0xffffffffffffffffUL,0x0000000000000000UL,0xffffffffffffffffUL),
    _mm256_set_epi64x(0x0000000000000000UL,0x0000000000000000UL,0xffffffffffffffffUL,0xffffffffffffffffUL),
  
  };

  __m256i mask_r[8] = {
    _mm256_set1_epi64x(0x5555555555555555UL),
    _mm256_set1_epi64x(0x3333333333333333UL),
    _mm256_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm256_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm256_set1_epi64x(0x0000ffff0000ffffUL),
    _mm256_set1_epi64x(0x00000000ffffffffUL),
    _mm256_set_epi64x(0xffffffffffffffffUL,0x0000000000000000UL,0xffffffffffffffffUL,0x0000000000000000UL),
    _mm256_set_epi64x(0xffffffffffffffffUL,0xffffffffffffffffUL,0x0000000000000000UL,0x0000000000000000UL),
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
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm256_or_si256(u, _mm256_slli_si256(x, 8));
          data[j + n + k] = _mm256_or_si256(_mm256_srli_si256(v, 8), y);
        } else {
          data[j + k] = _mm256_or_si256(u, _mm256_permute2f128_ps( x , x , 1));
          data[j + n + k] = _mm256_or_si256(_mm256_permute2f128_ps( v , v , 1), y);
        }
      }
  }
}

void ortho_wrapper(unsigned long data[1024], __m256i out[256]) {
  for (int i = 0; i < 256; i++)
    out[i] = _mm256_set_epi64x(data[i], data[256+i], data[512+i], data[768+i]);
  orthogonalize(out);
}

void check_ortho_64 () {
  unsigned long* buff64 = malloc(64 * sizeof *buff64);
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buff64[i] = a;
    a -= (unsigned long)1 << (63-i);
  }
  for (int i = 0; i < 64; i++) {
    print64bin(buff64[i]); puts("");
  }
  orthogonalize_64(buff64);
  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  for (int i = 0; i < 64; i++) {
    print64bin(buff64[i]); puts("");
  }

}

void check_ortho () {
  
  __m256i *restrict buffer = aligned_alloc(32,256 * sizeof *buffer);

  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buffer[i] = _mm256_set_epi64x(-1,-1,-1,a);
    a -= (unsigned long)1 << (63-i);
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buffer[i+64] = _mm256_set_epi64x(-1,-1,a,0);
    a -= (unsigned long)1 << (63-i);
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buffer[i+128] = _mm256_set_epi64x(-1,a,0,0);
    a -= (unsigned long)1 << (63-i);
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    buffer[i+192] = _mm256_set_epi64x(a,0,0,0);
    a -= (unsigned long)1 << (63-i);
  }

  for (int i = 0; i < 256; i++)
    print256bin(buffer[i]);

  orthogonalize(buffer);

  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  
  for (int i = 0; i < 256; i++)
    print256bin(buffer[i]); 

}


int main () {

  srand(7);

  //check_ortho();
  
  uint64_t start, end;
  int total = 1e6;



  
  /* ************************************************************* *\
     A fake orthogonalization: the data are send all together
     to be orthogonalized.
     For DES, we'd need first to rearrange them and then 
     orthogonalize them. (see bellow)
  \* ************************************************************* */
  
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
  /* simpl ortho: no reorganization of the data */
  printf("Cycles per simpl ortho: %lu\n", end / total);


  
  /* ************************************************************* *\
     A real orthogonalization.
  \* ************************************************************* */

  unsigned long *restrict buff64 = malloc(1024 * sizeof *buff64);
  __m256i *restrict buff256 = aligned_alloc(32, 256 * sizeof *buff256);
  for  (int i = 0; i < 1024; i++)
    buff64[i] = (unsigned long) rand();

  /* Warming up the cache */
  for (int i = 0; i < 100; i++)
    ortho_wrapper(buff64,buff256);

  /* The actual mesure */
  start = _rdtsc();
  for (int i = 0; i < total; i++)
    ortho_wrapper(buff64,buff256);
  end = _rdtsc() - start;

  /* Counting how much cycles were lost "looping" */
  start = _rdtsc();
  for (int i = 0; i < total; i++)
    asm("");
  end -= (_rdtsc() - start);

  /* Printing the result */
  /* full ortho: reorganization of the data -> a "real" ortho */
  printf("Cycles per full ortho: %lu\n", end / total);

  return 0;
}
