
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>


#define NB_LOOP 1e6



#define REG_SIZE 128
#define CHUNK_SIZE 256

#define DATATYPE __m128i

#define ORTHOGONALIZE(in,out) orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) aligned_alloc(32,size * sizeof(__m128i))

void real_ortho_128x128(__m128i data[]) {

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
  }
}

void orthogonalize_128x128(uint64_t* data, __m128i* out) {
  for (int i = 0; i < 128; i++)
    out[i] = _mm_set_epi64x(data[i], data[128+i]);
  real_ortho_128x128(out);
}

void unorthogonalize_128x128(__m128i *in, uint64_t* data) {
  real_ortho_128x128(in);
  for (int i = 0; i < 128; i++) {
    uint64_t tmp[2];
    _mm_store_si128 ((__m128i*)tmp, in[i]);
    data[i] = tmp[1];
    data[128+i] = tmp[0];
  }
}

void orthogonalize(uint64_t* data, __m128i* out) {
  orthogonalize_128x128(data,out);
}
void unorthogonalize(__m128i *in, uint64_t* data) {
  unorthogonalize_128x128(in,data);
}


/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64



int main() {

  unsigned long* input = ALLOC(CHUNK_SIZE);
  DATATYPE* output     = ALLOC(REG_SIZE);

  // Initializing the buffer
  for (int i = 0; i < CHUNK_SIZE; i++) 
    input[i] = rand();

  /* Warming up the cache */
  for (int i = 0; i < 100; i++)
    ORTHOGONALIZE(input, output);

  /* The actual mesure */
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    ORTHOGONALIZE(input, output);
  timer = _rdtsc() - timer;

  /* Counting how much cycles were lost "looping" */
  timer -= _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    asm("");
  timer += _rdtsc();

  printf("%d\n",(int)(timer/NB_LOOP));
  

  return 0;
}
