#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "rectangle.h"

#ifdef std
#define GP
#endif

#ifdef sse
#define SSE
#endif

#ifdef avx
#define AVX
#endif

#ifdef avx512
#define AVX512
#endif

#define BLOCK_SIZE 8

/* **************************** GP **********************************/
#ifdef GP
#define PARALLEL_FACTOR 64
#include "STD.h"



void real_ortho(uint64_t data[]) {
  uint64_t mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
  };

  uint64_t mask_r[6] = {
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
        uint64_t u = data[j + k] & mask_l[i];
        uint64_t v = data[j + k] & mask_r[i];
        uint64_t x = data[j + n + k] & mask_l[i];
        uint64_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

#define rectangle(in,key,out) {                                     \
    for (int i = 0; i < 64; i++)                                    \
      ((uint64_t*)in)[i] = __builtin_bswap64(((uint64_t*)in)[i]);   \
    real_ortho((uint64_t*) in);                                     \
    Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);       \
    real_ortho((uint64_t*) out);                                    \
    for (int i = 0; i < 64; i++)                                    \
      ((uint64_t*)out)[i] = __builtin_bswap64(((uint64_t*)out)[i]); \
  }


void ortho_speed ( unsigned char *out,
                   unsigned char *in,
                   unsigned long long inlen,
                   unsigned char *k
                   ) {
  for (int i = 0; i < inlen; i += PARALLEL_FACTOR * BLOCK_SIZE) {
    real_ortho((uint64_t*)out);
    real_ortho((uint64_t*)out);
  }
}
/* **************************** SSE *********************************/
#elif defined SSE
#define PARALLEL_FACTOR 128
#define NO_RUNTIME
#include "SSE.h"

void real_ortho_128x64(__m128i data[]) {

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

  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
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



#define rectangle(in,key,out) {                                     \
    for (int i = 0; i < PARALLEL_FACTOR; i++)                       \
      ((uint64_t*)in)[i] = __builtin_bswap64(((uint64_t*)in)[i]);   \
    real_ortho_128x64((DATATYPE*) in);                              \
    Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);       \
    real_ortho_128x64((DATATYPE*) out);                             \
    for (int i = 0; i < PARALLEL_FACTOR; i++)                       \
      ((uint64_t*)out)[i] = __builtin_bswap64(((uint64_t*)out)[i]); \
  }

void ortho_speed ( unsigned char *out,
                   unsigned char *in,
                   unsigned long long inlen,
                   unsigned char *k
                   ) {
  for (int i = 0; i < inlen; i += PARALLEL_FACTOR * BLOCK_SIZE) {
    real_ortho_128x64((DATATYPE*)out);
    real_ortho_128x64((DATATYPE*)out);
  }
}


/* **************************** AVX *********************************/
#elif defined AVX
#define PARALLEL_FACTOR 256
#define NO_RUNTIME
#include "AVX.h"

void real_ortho_256x64(__m256i data[]) {

  __m256i mask_l[8] = {
    _mm256_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm256_set1_epi64x(0xccccccccccccccccUL),
    _mm256_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm256_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm256_set1_epi64x(0xffff0000ffff0000UL),
    _mm256_set1_epi64x(0xffffffff00000000UL),
    _mm256_set_epi64x(0UL,-1UL,0UL,-1UL),
    _mm256_set_epi64x(0UL,0UL,-1UL,-1UL),

  };

  __m256i mask_r[8] = {
    _mm256_set1_epi64x(0x5555555555555555UL),
    _mm256_set1_epi64x(0x3333333333333333UL),
    _mm256_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm256_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm256_set1_epi64x(0x0000ffff0000ffffUL),
    _mm256_set1_epi64x(0x00000000ffffffffUL),
    _mm256_set_epi64x(-1UL,0UL,-1UL,0UL),
    _mm256_set_epi64x(-1UL,-1UL,0UL,0UL),
  };

  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
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
          data[j + k] = _mm256_or_si256(u, _mm256_permute2x128_si256( x , x , 1));
          data[j + n + k] = _mm256_or_si256(_mm256_permute2x128_si256( v , v , 1), y);
        }
      }
  }
}

#define rectangle(in,key,out) {                                     \
    for (int i = 0; i < PARALLEL_FACTOR; i++)                       \
      ((uint64_t*)in)[i] = __builtin_bswap64(((uint64_t*)in)[i]);   \
    real_ortho_256x64((DATATYPE*) in);                              \
    Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);       \
    real_ortho_256x64((DATATYPE*) out);                             \
    for (int i = 0; i < PARALLEL_FACTOR; i++)                       \
      ((uint64_t*)out)[i] = __builtin_bswap64(((uint64_t*)out)[i]); \
  }

void ortho_speed ( unsigned char *out,
                   unsigned char *in,
                   unsigned long long inlen,
                   unsigned char *k
                   ) {
  for (int i = 0; i < inlen; i += PARALLEL_FACTOR * BLOCK_SIZE) {
    real_ortho_256x64((DATATYPE*)out);
    real_ortho_256x64((DATATYPE*)out);
  }
}


/* **************************** AVX *********************************/
#elif defined AVX512
#define PARALLEL_FACTOR 512
#define NO_RUNTIME
#include "AVX512.h"

void real_ortho_512x64(__m512i data[]) {

  __m512i mask_l[9] = {
    _mm512_set1_epi64(0xaaaaaaaaaaaaaaaaUL),
    _mm512_set1_epi64(0xccccccccccccccccUL),
    _mm512_set1_epi64(0xf0f0f0f0f0f0f0f0UL),
    _mm512_set1_epi64(0xff00ff00ff00ff00UL),
    _mm512_set1_epi64(0xffff0000ffff0000UL),
    _mm512_set1_epi64(0xffffffff00000000UL),
    _mm512_set_epi64(0UL,-1UL,0UL,-1UL,0UL,-1UL,0UL,-1UL),
    _mm512_set_epi64(0UL,0UL,-1UL,-1UL,0UL,0UL,-1UL,-1UL),
    _mm512_set_epi64(0UL,0UL,0UL,0UL,-1UL,-1UL,-1UL,-1UL),
  };

  __m512i mask_r[9] = {
    _mm512_set1_epi64(0x5555555555555555UL),
    _mm512_set1_epi64(0x3333333333333333UL),
    _mm512_set1_epi64(0x0f0f0f0f0f0f0f0fUL),
    _mm512_set1_epi64(0x00ff00ff00ff00ffUL),
    _mm512_set1_epi64(0x0000ffff0000ffffUL),
    _mm512_set1_epi64(0x00000000ffffffffUL),
    _mm512_set_epi64(-1UL,0UL,-1UL,0UL,-1UL,0UL,-1UL,0UL),
    _mm512_set_epi64(-1UL,-1UL,0UL,0UL,-1UL,-1UL,0UL,0UL),
    _mm512_set_epi64(-1UL,-1UL,-1UL,-1UL,0UL,0UL,0UL,0UL),
  };

  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m512i u = _mm512_and_si512(data[j + k], mask_l[i]);
        __m512i v = _mm512_and_si512(data[j + k], mask_r[i]);
        __m512i x = _mm512_and_si512(data[j + n + k], mask_l[i]);
        __m512i y = _mm512_and_si512(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm512_or_si512(u, _mm512_srli_epi64(x, n));
          data[j + n + k] = _mm512_or_si512(_mm512_slli_epi64(v, n), y);
        } else if (i == 6) {
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm512_or_si512(u, _mm512_bslli_epi128(x, 8));
          data[j + n + k] = _mm512_or_si512(_mm512_bsrli_epi128(v, 8), y);
        } else if (i == 7) {
          /* might be 0b01001110 instead */
          data[j + k] = _mm512_or_si512(u, _mm512_permutex_epi64(x,0b10110001));
          data[j + n + k] = _mm512_or_si512(_mm512_permutex_epi64(v,0b10110001), y);
        } else {
          /* might be 0,1,2,3,4,5,6,7 */
          __m512i ctrl = _mm512_set_epi64(4,5,6,7,0,1,2,3);
          data[j + k] = _mm512_or_si512(u, _mm512_permutexvar_epi64(ctrl,x));
          data[j + n + k] = _mm512_or_si512(_mm512_permutexvar_epi64(ctrl,v), y);
        }
      }
  }
}

#define rectangle(in,key,out) {                                     \
    for (int i = 0; i < PARALLEL_FACTOR; i++)                       \
      ((uint64_t*)in)[i] = __builtin_bswap64(((uint64_t*)in)[i]);   \
    real_ortho_512x64((DATATYPE*) in);                              \
    Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);       \
    real_ortho_512x64((DATATYPE*) out);                             \
    for (int i = 0; i < PARALLEL_FACTOR; i++)                       \
      ((uint64_t*)out)[i] = __builtin_bswap64(((uint64_t*)out)[i]); \
  }

void ortho_speed ( unsigned char *out,
                   unsigned char *in,
                   unsigned long long inlen,
                   unsigned char *k
                   ) {
  for (int i = 0; i < inlen; i += PARALLEL_FACTOR * BLOCK_SIZE) {
    real_ortho_512x64((DATATYPE*)out);
    real_ortho_512x64((DATATYPE*)out);
  }
}


#else
#error No arch specified.
#endif

void Rectangle__ (DATATYPE plain__[64],DATATYPE* key__, DATATYPE cipher__[64]);

int crypto_stream_ecb( unsigned char *out,
                       unsigned char *in,
                       unsigned long long inlen,
                       unsigned char *k
                       )
{

  uint16_t char_key[208];
  Key_Schedule(k,(uint16_t*)char_key);
  DATATYPE key[26][64];
  for (int i = 0; i < 26; i++) {
    ((uint64_t*)char_key)[i] = __builtin_bswap64(((uint64_t*)char_key)[i]);
    for (int j = 0; j < 4; j++)
      for (int k = 0; k < 16; k++)
        key[i][63-(j*16+k)] = (char_key[i*4+j] >> k) & 1 ? ONES : ZERO;
  }


  while (inlen >= PARALLEL_FACTOR * BLOCK_SIZE) {
    rectangle(in,key,out);
    inlen -= PARALLEL_FACTOR * BLOCK_SIZE;
    out += PARALLEL_FACTOR * BLOCK_SIZE;
    in  += PARALLEL_FACTOR * BLOCK_SIZE;
  }

  if (inlen > 0) {
    unsigned char input[PARALLEL_FACTOR*BLOCK_SIZE];
    unsigned char output[PARALLEL_FACTOR*BLOCK_SIZE];
    memcpy(input,in,inlen);
    rectangle(input,key,output);
    memcpy(out,output,inlen);
  }

  return 0;
}
