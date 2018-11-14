#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "rectangle.h"

#include "key.c"

#define BLOCK_SIZE 8


#define PARALLEL_FACTOR 8
#define NO_RUNTIME
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
                            exit(EXIT_FAILURE);                         \
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


void Rectangle__ (DATATYPE plain__[4],DATATYPE key__[26][4], DATATYPE cipher__[4]);

int crypto_stream_ecb( unsigned char *out,
                       unsigned char *in,
                       unsigned long long inlen,
                       unsigned char *k
                       )
{

  uint16_t char_key[208];
  Key_Schedule(k,char_key);
  
  __m128i key[26][4];
  for (int i = 0; i < 26; i++) {
    __m128i tmp[8];
    for (int j = 0; j < 4; j++)
      tmp[j] = _mm_set1_epi16(char_key[i*4+j]);
    nslice_8x64(tmp);
    memcpy(key[i],tmp,64);
  }

  
  while (inlen >= PARALLEL_FACTOR * BLOCK_SIZE) {
    __m128i plain[8]; memcpy(plain,in,64);
    __m128i cipher[8];
    nslice_8x64(plain);
    Rectangle__(plain,key,cipher);
    nslice_8x64_undo(cipher);
    memcpy(out,cipher,64);
    inlen -= PARALLEL_FACTOR * BLOCK_SIZE;
    out += PARALLEL_FACTOR * BLOCK_SIZE;
    in  += PARALLEL_FACTOR * BLOCK_SIZE;
  }

  if (inlen > 0) {
    unsigned char input[PARALLEL_FACTOR*BLOCK_SIZE];
    unsigned char output[PARALLEL_FACTOR*BLOCK_SIZE];
    memcpy(input,in,inlen);
    __m128i plain[8]; memcpy(plain,in,64);
    __m128i cipher[8];
    nslice_8x64(plain);
    Rectangle__(plain,key,cipher);
    nslice_8x64_undo(cipher);
    memcpy(out,cipher,64);
    memcpy(out,output,inlen);
  }

  return 0;
}

/* just some glue */
int crypto_stream_xor (unsigned char *out,
                       const unsigned char *in,
                       unsigned long long inlen,
                       const unsigned char *n,
                       const unsigned char *k) {
  crypto_stream_ecb(out,(unsigned char *)in,inlen,(unsigned char *)k);
  return 0;
}
