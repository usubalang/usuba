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
  
  
  while (inlen > 0) {
    rectangle(in,key,out);
    inlen -= PARALLEL_FACTOR * BLOCK_SIZE;
    out += PARALLEL_FACTOR * BLOCK_SIZE;
    in  += PARALLEL_FACTOR * BLOCK_SIZE;
  }

  return 0;
}
