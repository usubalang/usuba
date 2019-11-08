#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "rectangle.h"
#include "rect_ua_inter.h"

#define BLOCK_SIZE 8

/* **************************** GP **********************************/
#ifdef USE_GP
#error Cannot use GP in nslicing


/* **************************** SSE *********************************/
#elif defined USE_SSE
#define PARALLEL_FACTOR 16

#include "SSE.h"

#pragma push_macro("L_SHIFT")
#pragma push_macro("R_SHIFT")

#define SET1_EPI64(x)         _mm_set1_epi64x(x)
#define SET_EPI64_2(a,b)      _mm_set_epi64x(a,b)
#define SET_EPI64_4(a,b,c,d)  _mm_set1_epi64x(0)

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


inline void orthogonalize(DATATYPE data[], int M, int LOG2_M, int LOG2_A) {
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

#define nslice_8x64(data) {                                             \
    __m128i* dataSSE = (__m128i*)data;                                  \
    for (int i = 4; i < 8; i++) dataSSE[i] = ZERO;                      \
    orthogonalize(dataSSE,8,3,0);                                       \
    __m128i tmp[8];                                                     \
    for (int i = 0; i < 8; i++)                                         \
      tmp[i] = _mm_shuffle_epi32(dataSSE[i],0b01001110);                \
    for (int i = 0; i < 4; i++)                                         \
      dataSSE[i] = OR(OR(AND(dataSSE[i],_mm_set_epi64x(0,-1)),          \
                         AND(tmp[i+4],_mm_set_epi64x(-1,0))),           \
                      OR(AND(_mm_srli_epi16(dataSSE[i+4],4),_mm_set_epi64x(-1,0)), \
                         AND(_mm_srli_epi16(tmp[i],4),_mm_set_epi64x(0,-1)))); \
    for (int i = 0; i < 4; i++)                                         \
      dataSSE[i] = _mm_shuffle_epi8(dataSSE[i],_mm_set_epi8(15,13,11,9,7,5,3,1, \
                                                            14,12,10,8,6,4,2,0)); \
    orthogonalize(dataSSE,4,2,3);                                       \
  }
#define nslice_8x64_undo(data) {                                        \
    __m128i* dataSSE = (__m128i*)data;                                  \
    for (int i = 4; i < 8; i++) dataSSE[i] = ZERO;                      \
    orthogonalize(dataSSE,4,2,3);                                       \
    for (int i = 0; i < 4; i++)                                         \
      dataSSE[i] = _mm_shuffle_epi8(dataSSE[i],_mm_set_epi8(15,7,14,6,13,5,12,4, \
                                                            11,3,10,2,9,1,8,0)); \
    __m128i tmp[4];                                                     \
    for (int i = 0; i < 4; i++)                                         \
      tmp[i] = _mm_shuffle_epi32(dataSSE[i],0b01001110);                \
    for (int i = 0; i < 4; i++) {                                       \
      dataSSE[i+4] = OR(AND(tmp[i],_mm_set_epi64x(0,-1)),               \
                        AND(_mm_slli_epi16(dataSSE[i],4),_mm_set_epi64x(-1,0))); \
      dataSSE[i]   = OR(AND(dataSSE[i],_mm_set_epi64x(0,-1)),           \
                        AND(_mm_slli_epi16(tmp[i],4),_mm_set_epi64x(-1,0))); \
    }                                                                   \
    orthogonalize(dataSSE,8,3,0);                                       \
  }

#define rectangle(in,key,out) {                                         \
    __m128i plain[16]; memcpy(plain,in,64);                             \
    memcpy(&plain[8],&((__m128i*)in)[4],64);                             \
    __m128i cipher[16];                                                 \
    nslice_8x64(plain);                                                 \
    nslice_8x64(&plain[8]);                                             \
    RectangleSSE__((unsigned char*)plain,(unsigned char*)&plain[8],     \
                   (unsigned char*)key,                                 \
                   (unsigned char*)cipher,(unsigned char*)&cipher[8]);  \
    nslice_8x64_undo(cipher);                                           \
    nslice_8x64_undo(&cipher[8]);                                       \
    memcpy(out,cipher,64);                                              \
    memcpy(&((__m128i*)out)[4],&cipher[8],64);                           \
  }

void ortho_speed ( unsigned char *out,
                   unsigned char *in,
                   unsigned long long inlen,
                   unsigned char *k
                   ) {
  for (int i = 0; i < inlen; i += PARALLEL_FACTOR * BLOCK_SIZE) {
    nslice_8x64((DATATYPE*)out);
    nslice_8x64((DATATYPE*)out);
    nslice_8x64_undo((DATATYPE*)out);
    nslice_8x64_undo((DATATYPE*)out);
  }
}

/* **************************** AVX *********************************/
#elif defined USE_AVX
#define PARALLEL_FACTOR 32

#include "AVX.h"

#pragma push_macro("L_SHIFT")
#pragma push_macro("R_SHIFT")

#define SET1_EPI64(x)         _mm256_set1_epi64x(x)
#define SET_EPI64_2(a,b)      _mm256_set_epi64x(a,b,a,b)
#define SET_EPI64_4(a,b,c,d)  _mm256_set_epi64x(a,b,c,d)

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


inline void orthogonalize(DATATYPE data[], int M, int LOG2_M, int LOG2_A) {
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

#define nslice_16x64(data) {                                            \
    __m256i* dataAVX = (__m256i*)data;                                  \
    for (int i = 4; i < 8; i++) dataAVX[i] = ZERO;                      \
    orthogonalize(dataAVX,8,3,0);                                       \
    __m256i tmp[8];                                                     \
    for (int i = 0; i < 8; i++)                                         \
      tmp[i] = _mm256_shuffle_epi32(dataAVX[i],0b01001110);             \
    for (int i = 0; i < 4; i++)                                         \
      dataAVX[i] = OR(OR(AND(dataAVX[i],_mm256_set_epi64x(0,-1,0,-1)),  \
                         AND(tmp[i+4],_mm256_set_epi64x(-1,0,-1,0))),   \
                      OR(AND(_mm256_srli_epi16(dataAVX[i+4],4),_mm256_set_epi64x(-1,0,-1,0)), \
                         AND(_mm256_srli_epi16(tmp[i],4),_mm256_set_epi64x(0,-1,0,-1)))); \
    for (int i = 0; i < 4; i++)                                         \
      dataAVX[i] = _mm256_shuffle_epi8(dataAVX[i],_mm256_set_epi8(15,13,11,9,7,5,3,1, \
                                                                  14,12,10,8,6,4,2,0, \
                                                                  15,13,11,9,7,5,3,1, \
                                                                  14,12,10,8,6,4,2,0)); \
    orthogonalize(dataAVX,4,2,3);                                       \
  }
#define nslice_16x64_undo(data) {                                       \
    __m256i* dataAVX = (__m256i*)data;                                  \
    for (int i = 4; i < 8; i++) dataAVX[i] = ZERO;                      \
    orthogonalize(dataAVX,4,2,3);                                       \
    for (int i = 0; i < 4; i++)                                         \
      dataAVX[i] = _mm256_shuffle_epi8(dataAVX[i],_mm256_set_epi8(15,7,14,6,13,5,12,4, \
                                                                  11,3,10,2,9,1,8,0, \
                                                                  15,7,14,6,13,5,12,4, \
                                                                  11,3,10,2,9,1,8,0)); \
    __m256i tmp[4];                                                     \
    for (int i = 0; i < 4; i++)                                         \
      tmp[i] = _mm256_shuffle_epi32(dataAVX[i],0b01001110);             \
    for (int i = 0; i < 4; i++) {                                       \
      dataAVX[i+4] = OR(AND(tmp[i],_mm256_set_epi64x(0,-1,0,-1)),       \
                        AND(_mm256_slli_epi16(dataAVX[i],4),_mm256_set_epi64x(-1,0,-1,0))); \
      dataAVX[i]   = OR(AND(dataAVX[i],_mm256_set_epi64x(0,-1,0,-1)),   \
                        AND(_mm256_slli_epi16(tmp[i],4),_mm256_set_epi64x(-1,0,-1,0))); \
    }                                                                   \
    orthogonalize(dataAVX,8,3,0);                                       \
  }

#define rectangle(in,key,out) {                                         \
    __m256i plain[16]; memcpy(plain,in,128);                            \
    memcpy(&plain[8],&((__m256i*)in)[4],128);         \
    __m256i cipher[16];                                                 \
    nslice_16x64(plain);                                                \
    nslice_16x64(&plain[8]);                                            \
    RectangleAVX__((unsigned char*)plain, (unsigned char*)&plain[8],    \
                   (unsigned char*)key,                                 \
                   (unsigned char*)cipher, (unsigned char*)&cipher[8]); \
    nslice_16x64_undo(cipher);                                          \
    nslice_16x64_undo(&cipher[8]);                                      \
    memcpy(out,cipher,128);                                             \
    memcpy(&((__m256i*)out)[4],&cipher[8],128);                          \
  }

void ortho_speed ( unsigned char *out,
                   unsigned char *in,
                   unsigned long long inlen,
                   unsigned char *k
                   ) {
  for (int i = 0; i < inlen; i += PARALLEL_FACTOR * BLOCK_SIZE) {
    nslice_16x64((DATATYPE*)out);
    nslice_16x64((DATATYPE*)out);
    nslice_16x64_undo((DATATYPE*)out);
    nslice_16x64_undo((DATATYPE*)out);
  }
}

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
  #ifdef USE_GP
  #elif defined USE_SSE
  __m128i key[26][4];
  for (int i = 0; i < 26; i++) {
    __m128i tmp[8];
    for (int j = 0; j < 4; j++)
      tmp[j] = _mm_set1_epi16(((unsigned short*)char_key)[i*4+j]);
    nslice_8x64(tmp);
    memcpy(key[i],tmp,64);
  }
  #elif defined USE_AVX
  __m256i key[26][4];
  for (int i = 0; i < 26; i++) {
    __m256i tmp[8];
    for (int j = 0; j < 4; j++)
      tmp[j] = _mm256_set1_epi16(((unsigned short*)char_key)[i*4+j]);
    nslice_16x64(tmp);
    memcpy(key[i],tmp,128);
  }
  #endif

  
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
