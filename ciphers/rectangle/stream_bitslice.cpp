#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "rectangle.h"
#include "rect_ua.h"

#define BLOCK_SIZE 8

/* **************************** GP **********************************/
#ifdef USE_GP
#define PARALLEL_FACTOR 64
#include "STD.h"

#define rectangle(in,key,out) {                 \
    real_ortho((uint64_t*) in);                 \
    RectangleGP__(in,(unsigned char*)key,out);  \
    real_ortho((uint64_t*) out);                \
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
#elif defined USE_SSE
#define PARALLEL_FACTOR 128
#define NO_RUNTIME
#include "SSE.h"

#if 1


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



#define rectangle(in,key,out) {                 \
    real_ortho_128x64((DATATYPE*) in);              \
    RectangleGP__(in,(unsigned char*)key,out);  \
    real_ortho_128x64((DATATYPE*) out);             \
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

#else

#define SET1_EPI64(x)         _mm_set1_epi64x(x)
#define SET_EPI64_2(a,b)      _mm_set_epi64x(a,b)
#define SET_EPI64_4(a,b,c,d)  _mm_set1_epi64x(0)


#pragma push_macro("L_SHIFT")
#pragma push_macro("R_SHIFT")

#define _mm_slli_epi128(a,b) ZERO
#define _L_SHIFT(a,b,c) (c <= 64 ? _mm_slli_epi##c(a,b) :               \
                         b == 8  ? _mm_srli_si128(a, 1) :               \
                         b == 16 ? _mm_srli_si128(a, 2) :               \
                         b == 32 ? _mm_srli_si128(a, 4) :               \
                         b == 64 ? _mm_srli_si128(a, 8) :               \
                         ({ fprintf(stderr, "Not implemented L_SHIFT(x,%d,%d).\n", (int)b, c); \
                           exit(EXIT_FAILURE);                          \
                           ZERO; }))
#define L_SHIFT(a,b,c) _L_SHIFT(a,b,c)

#define _mm_srli_epi128(a,b) ZERO
#define _R_SHIFT(a,b,c)  (c <= 64 ? _mm_srli_epi##c(a,b) :              \
                          b == 8  ? _mm_slli_si128(a, 1) :              \
                          b == 16 ? _mm_slli_si128(a, 2) :              \
                          b == 32 ? _mm_slli_si128(a, 4) :              \
                          b == 64 ? _mm_slli_si128(a, 8) :              \
                         ({ fprintf(stderr, "Not implemented R_SHIFT(x,%d,%d).\n", (int)b, c); \
                           exit(EXIT_FAILURE);                          \
                           ZERO; }))
#define R_SHIFT(a,b,c) _R_SHIFT(a,b,c)


static inline void orthogonalize(DATATYPE data[], int M, int LOG2_M, int LOG2_A) {
  DATATYPE mask_l[] = {
    SET1_EPI64(0xaaaaaaaaaaaaaaaaUL),
    SET1_EPI64(0xccccccccccccccccUL),
    SET1_EPI64(0xf0f0f0f0f0f0f0f0UL),
    SET1_EPI64(0x00ff00ff00ff00ffUL),
    SET1_EPI64(0x0000ffff0000ffffUL),
    SET1_EPI64(0x00000000ffffffffUL),
    SET_EPI64_2(0x0000000000000000UL,0xffffffffffffffffUL),
    SET_EPI64_4(0x0000000000000000UL,0x0000000000000000UL,
                0xffffffffffffffffUL,0xffffffffffffffffUL)
  };
  
  DATATYPE mask_r[] = {
    SET1_EPI64(0x5555555555555555UL),
    SET1_EPI64(0x3333333333333333UL),
    SET1_EPI64(0x0f0f0f0f0f0f0f0fUL),
    SET1_EPI64(0xff00ff00ff00ff00UL),
    SET1_EPI64(0xffff0000ffff0000UL),
    SET1_EPI64(0xffffffff00000000UL),
    SET_EPI64_2(0xffffffffffffffffUL,0x0000000000000000UL),
    SET_EPI64_4(0xffffffffffffffffUL,0xffffffffffffffffUL,
                0x0000000000000000UL,0x0000000000000000UL)
  };

  for (int i = 0; i < LOG2_M; i++) {
    int n = 1UL << i;
    for (int j = 0; j < M; j += 2*n) {
      for (int k = 0; k < n; k++) {
        DATATYPE u = AND(data[j + k], mask_l[LOG2_A+i]);
        DATATYPE v = AND(data[j + k], mask_r[LOG2_A+i]);
        DATATYPE x = AND(data[j + n + k], mask_l[LOG2_A+i]);
        DATATYPE y = AND(data[j + n + k], mask_r[LOG2_A+i]);
        if ((i+LOG2_A) < 3) {
          data[j + k] = OR(u, R_SHIFT(x,(1UL << (i+LOG2_A)),64));
          data[j + n + k] =OR(L_SHIFT(v,(1UL << (i+LOG2_A)),64), y);
        } else {
          data[j + k] = OR(u, R_SHIFT(x,(1UL << (i+LOG2_A)),BITS_PER_REG));
          data[j + n + k] =OR(L_SHIFT(v,(1UL << (i+LOG2_A)),BITS_PER_REG), y);
        }
      }
    }
  }
}
#pragma pop_macro("L_SHIFT")
#pragma pop_macro("R_SHIFT")


#define rectangle(in,key,out) {                 \
    orthogonalize((DATATYPE*) in,64,6,0);       \
    RectangleGP__(in,(unsigned char*)key,out);  \
    orthogonalize((DATATYPE*) out,64,6,0);      \
  }
#endif

/* **************************** AVX *********************************/
#elif defined USE_AVX
#define PARALLEL_FACTOR 256
#define NO_RUNTIME
#include "AVX.h"

#if 1
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

#define rectangle(in,key,out) {                 \
    real_ortho_256x64((DATATYPE*) in);              \
    RectangleGP__(in,(unsigned char*)key,out);  \
    real_ortho_256x64((DATATYPE*) out);             \
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

#else

#define SET1_EPI64(x)         _mm256_set1_epi64x(x)
#define SET_EPI64_2(a,b)      _mm256_set_epi64x(a,b,a,b)
#define SET_EPI64_4(a,b,c,d)  _mm256_set_epi64x(a,b,c,d)


#pragma push_macro("L_SHIFT")
#pragma push_macro("R_SHIFT")

#define _mm256_slli_epi128(a,b) ZERO
#define _mm256_slli_epi256(a,b) ZERO
#define _L_SHIFT(a,b,c) (c <= 64 ? _mm256_slli_epi##c(a,b) :               \
                         b == 8  ? _mm256_srli_si256(a, 1) :               \
                         b == 16 ? _mm256_srli_si256(a, 2) :               \
                         b == 32 ? _mm256_srli_si256(a, 4) :               \
                         b == 64 ? _mm256_srli_si256(a, 8) :               \
                         ({ fprintf(stderr, "Not implemented L_SHIFT(x,%d,%d).\n", (int)b, c); \
                           exit(EXIT_FAILURE);                          \
                           ZERO; }))
#define L_SHIFT(a,b,c) _L_SHIFT(a,b,c)

#define _mm256_srli_epi128(a,b) ZERO
#define _mm256_srli_epi256(a,b) ZERO
#define _R_SHIFT(a,b,c)  (c <= 64 ? _mm256_srli_epi##c(a,b) :              \
                          b == 8  ? _mm256_slli_si256(a, 1) :              \
                          b == 16 ? _mm256_slli_si256(a, 2) :              \
                          b == 32 ? _mm256_slli_si256(a, 4) :              \
                          b == 64 ? _mm256_slli_si256(a, 8) :              \
                         ({ fprintf(stderr, "Not implemented R_SHIFT(x,%d,%d).\n", (int)b, c); \
                           exit(EXIT_FAILURE);                          \
                           ZERO; }))
#define R_SHIFT(a,b,c) _R_SHIFT(a,b,c)


static inline void orthogonalize(DATATYPE data[], int M, int LOG2_M, int LOG2_A) {
  DATATYPE mask_l[] = {
    SET1_EPI64(0xaaaaaaaaaaaaaaaaUL),
    SET1_EPI64(0xccccccccccccccccUL),
    SET1_EPI64(0xf0f0f0f0f0f0f0f0UL),
    SET1_EPI64(0x00ff00ff00ff00ffUL),
    SET1_EPI64(0x0000ffff0000ffffUL),
    SET1_EPI64(0x00000000ffffffffUL),
    SET_EPI64_2(0x0000000000000000UL,0xffffffffffffffffUL),
    SET_EPI64_4(0x0000000000000000UL,0x0000000000000000UL,
                0xffffffffffffffffUL,0xffffffffffffffffUL)
  };
  
  DATATYPE mask_r[] = {
    SET1_EPI64(0x5555555555555555UL),
    SET1_EPI64(0x3333333333333333UL),
    SET1_EPI64(0x0f0f0f0f0f0f0f0fUL),
    SET1_EPI64(0xff00ff00ff00ff00UL),
    SET1_EPI64(0xffff0000ffff0000UL),
    SET1_EPI64(0xffffffff00000000UL),
    SET_EPI64_2(0xffffffffffffffffUL,0x0000000000000000UL),
    SET_EPI64_4(0xffffffffffffffffUL,0xffffffffffffffffUL,
                0x0000000000000000UL,0x0000000000000000UL)
  };

  for (int i = 0; i < LOG2_M; i++) {
    int n = 1UL << i;
    for (int j = 0; j < M; j += 2*n) {
      for (int k = 0; k < n; k++) {
        DATATYPE u = AND(data[j + k], mask_l[LOG2_A+i]);
        DATATYPE v = AND(data[j + k], mask_r[LOG2_A+i]);
        DATATYPE x = AND(data[j + n + k], mask_l[LOG2_A+i]);
        DATATYPE y = AND(data[j + n + k], mask_r[LOG2_A+i]);
        if ((i+LOG2_A) < 3) {
          data[j + k] = OR(u, R_SHIFT(x,(1UL << (i+LOG2_A)),64));
          data[j + n + k] =OR(L_SHIFT(v,(1UL << (i+LOG2_A)),64), y);
        } else {
          data[j + k] = OR(u, R_SHIFT(x,(1UL << (i+LOG2_A)),BITS_PER_REG));
          data[j + n + k] =OR(L_SHIFT(v,(1UL << (i+LOG2_A)),BITS_PER_REG), y);
        }
      }
    }
  }
}
#pragma pop_macro("L_SHIFT")
#pragma pop_macro("R_SHIFT")


#define rectangle(in,key,out) {                 \
    orthogonalize((DATATYPE*) in,64,6,0);       \
    RectangleGP__(in,(unsigned char*)key,out);  \
    orthogonalize((DATATYPE*) out,64,6,0);      \
  }

#endif

#else
#error No arch specified.
#endif


int crypto_stream_ecb( unsigned char *out,
                       unsigned char *in,
                       unsigned long long inlen,
                       unsigned char *k
                       )
{

  unsigned char char_key[208];
  Key_Schedule(k,80,ENC,char_key);
  DATATYPE key[208][8];
  for (int i = 0; i < 208; i++) 
    for (int j = 0; j < 8; j++)
      key[i][j] = (char_key[i] >> j) & 1 ? ONES : ZERO;

  
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
