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

#ifdef avx512
#define AVX512
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


/* **************************** AVX512 *********************************/
#elif defined AVX512
#define PARALLEL_FACTOR 32
#define NO_RUNTIME
#include "AVX512.h"

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

  DATATYPE key[26][4];
  
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
