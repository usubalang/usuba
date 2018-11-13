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

#define BLOCK_SIZE 8

/* **************************** GP **********************************/
#ifdef GP
#define PARALLEL_FACTOR 2
#define NO_RUNTIME
#define DATATYPE uint16_t
#define BITS_PER_REG 16
#define rectangle(in,key,out) \
  Rectangle__((DATATYPE*)in,((DATATYPE*)in)+4,key,\
              (DATATYPE*)out,((DATATYPE*)out)+4)


/* **************************** SSE *********************************/
#elif defined SSE
#define PARALLEL_FACTOR 16

#define NO_RUNTIME
#include "SSE.h"


#define rectangle(in,key,out) {                                 \
    __m128i* plain  = (__m128i*)in;                             \
    __m128i* cipher = (__m128i*)out;                            \
    Rectangle__(plain, &plain[4], key, cipher, &cipher[4]);     \
  }

/* **************************** AVX *********************************/
#elif defined AVX
#define PARALLEL_FACTOR 32

#define NO_RUNTIME
#include "AVX.h"

#define rectangle(in,key,out) {                                 \
    __m256i* plain  = (__m256i*)in;                             \
    __m256i* cipher = (__m256i*)out;                            \
    Rectangle__(plain, &plain[4], key, cipher, &cipher[4]);     \
  }

#else
#error No arch specified.
#endif

void Rectangle__ (DATATYPE plain__[4],DATATYPE plain____2[4],uint16_t* key__,
                  DATATYPE cipher__[4],DATATYPE cipher____2[4]);
  
int crypto_stream_ecb( unsigned char *out,
                       unsigned char *in,
                       unsigned long long inlen,
                       unsigned char *k
                       )
{

  uint16_t key[208];
  Key_Schedule(k,key);
  
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
