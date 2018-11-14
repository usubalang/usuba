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

#define TRANSPOSE4_IN(x0, x1, x2, x3) {                    \
    __m128i xmm01 = x0;                                 \
    __m128i xmm23 = x1;                                 \
    __m128i xmm45 = x2;                                 \
    __m128i xmm67 = x3;                                 \
	__m128i xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);   \
    __m128i xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);   \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);           \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);           \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);           \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);           \
	__m128i xmm46 = _mm_unpacklo_epi64(xmm45, xmm67);   \
	__m128i xmm57 = _mm_unpackhi_epi64(xmm45, xmm67);   \
	xmm45 = _mm_unpacklo_epi16(xmm46, xmm57);           \
	xmm67 = _mm_unpackhi_epi16(xmm46, xmm57);           \
	xmm46 = _mm_unpacklo_epi32(xmm45, xmm67);           \
	xmm57 = _mm_unpackhi_epi32(xmm45, xmm67);           \
	x0    = _mm_unpacklo_epi64(xmm02, xmm46);           \
	x1    = _mm_unpackhi_epi64(xmm02, xmm46);           \
	x2    = _mm_unpacklo_epi64(xmm13, xmm57);           \
	x3    = _mm_unpackhi_epi64(xmm13, xmm57);           \
  }
#define TRANSPOSE4_OUT(x0, x1, x2, x3) {                \
	__m128i xmm01 = _mm_unpacklo_epi16(x0, x1);         \
	__m128i xmm45 = _mm_unpackhi_epi16(x0, x1);         \
	__m128i xmm23 = _mm_unpacklo_epi16(x2, x3);         \
	__m128i xmm67 = _mm_unpackhi_epi16(x2, x3);         \
	x0    = _mm_unpacklo_epi32(xmm01, xmm23);           \
	x1    = _mm_unpackhi_epi32(xmm01, xmm23);           \
	x2    = _mm_unpacklo_epi32(xmm45, xmm67);           \
	x3    = _mm_unpackhi_epi32(xmm45, xmm67);           \
  }

#define Rectangle(in,key,out) {                                 \
    __m128i* plain  = (__m128i*)in;                             \
    __m128i* cipher = (__m128i*)out;                            \
    TRANSPOSE4_IN(plain[0],plain[1],plain[2],plain[3]);         \
    Rectangle__(plain,key,cipher);                              \
    TRANSPOSE4_OUT(cipher[0],cipher[1],cipher[2],cipher[3]);    \
  }




void Rectangle__ (DATATYPE plain__[4],uint16_t* key__,DATATYPE cipher__[4]);
  
int crypto_stream_ecb( unsigned char *out,
                       unsigned char *in,
                       unsigned long long inlen,
                       unsigned char *k
                       )
{

  uint16_t key[208];
  Key_Schedule(k,key);
  
  while (inlen >= PARALLEL_FACTOR * BLOCK_SIZE) {
    Rectangle(in,key,out);
    inlen -= PARALLEL_FACTOR * BLOCK_SIZE;
    out += PARALLEL_FACTOR * BLOCK_SIZE;
    in  += PARALLEL_FACTOR * BLOCK_SIZE;
  }

  if (inlen > 0) {
    unsigned char input[PARALLEL_FACTOR*BLOCK_SIZE];
    unsigned char output[PARALLEL_FACTOR*BLOCK_SIZE];
    memcpy(input,in,inlen);
    Rectangle(input,key,output);
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
