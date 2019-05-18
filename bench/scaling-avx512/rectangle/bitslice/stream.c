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
#define NO_RUNTIME
#include "STD.h"

#define rectangle(in,key,out)                                       \
  Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);


/* **************************** SSE *********************************/
#elif defined SSE
#define PARALLEL_FACTOR 128
#define NO_RUNTIME
#include "SSE.h"


#define rectangle(in,key,out)                               \
  Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);


/* **************************** AVX *********************************/
#elif defined AVX
#define PARALLEL_FACTOR 256
#define NO_RUNTIME
#include "AVX.h"


#define rectangle(in,key,out)                                   \
  Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);


/* **************************** AVX512 *********************************/
#elif defined AVX512
#define PARALLEL_FACTOR 512
#define NO_RUNTIME
#include "AVX512.h"


#define rectangle(in,key,out)                                   \
  Rectangle__((DATATYPE*)in,(DATATYPE*)key,(DATATYPE*)out);



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

  DATATYPE key[26][64];
  
  
  while (inlen > 0) {
    rectangle(in,key,out);
    inlen -= PARALLEL_FACTOR * BLOCK_SIZE;
    out += PARALLEL_FACTOR * BLOCK_SIZE;
    in  += PARALLEL_FACTOR * BLOCK_SIZE;
  }

  return 0;
}
