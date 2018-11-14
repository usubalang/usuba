#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "rectangle.h"

#ifdef sse
#define SSE
#endif

#ifdef avx
#define AVX
#endif

#define BLOCK_SIZE 8

/* **************************** GP **********************************/
#ifdef GP
#error Cannot use GP in nslicing


/* **************************** SSE *********************************/
#elif defined SSE
#define PARALLEL_FACTOR 8
#define NO_RUNTIME
#include "SSE.h"

#define rectangle(in,key,out)                       \
  Rectangle__((DATATYPE*)in,key,(DATATYPE*)out);


/* **************************** AVX *********************************/
#elif defined AVX
#define PARALLEL_FACTOR 16
#define NO_RUNTIME
#include "AVX.h"

#define rectangle(in,key,out)                       \
  Rectangle__((DATATYPE*)in,key,(DATATYPE*)out);


#else
#error No arch specified.
#endif

void Rectangle__ (DATATYPE plain__[4],DATATYPE key__[26][4], DATATYPE cipher__[4]);

int crypto_stream_ecb( unsigned char *out,
                       unsigned char *in,
                       unsigned long long inlen,
                       unsigned char *k
                       )
{

  uint16_t char_key[208];
  Key_Schedule(k,char_key);
#ifdef GP
#elif defined SSE
  __m128i key[26][4];
  for (int i = 0; i < 26; i++)
    for (int j = 0; j < 4; j++)
      key[i][j] = _mm_set1_epi16(char_key[i*4+j]);
#elif defined AVX
  __m256i key[26][4];
  for (int i = 0; i < 26; i++)
    for (int j = 0; j < 4; j++)
      key[i][j] = _mm256_set1_epi16(((unsigned short*)char_key)[i*4+j]);
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
