#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "crypto_stream.h"
#include "api.h"

/* ******************************************************************* */
/*   Just redifine those defines for a new implementation              */
/*                                                                     */
/* ******************************************************************* */

/* Include your .h (or .c if you're a durty being) here. */
#include "AVX512.h"
#include "key_sched.c"
#include "serpent.c"

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 32

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                  \
  DATATYPE key[33][4];                                  \
  {                                                     \
    unsigned int key_std[33][4];                        \
    makeKey((const char*)k,key_std);                    \
    for (int i = 0; i < 33; i++)                        \
      for (int j = 0; j < 4; j++)                       \
        key[i][j] = _mm512_set1_epi32(key_std[i][j]);   \
  }


int crypto_stream_xor( unsigned char *out,
                       const unsigned char *in,
                       unsigned long long inlen,
                       const unsigned char *n,
                       const unsigned char *k
                       )
{
  long long signed_len = inlen;  
  
  /* Key schedule */
  key_schedule();
  

  /* Encrypting the input... */
  while (signed_len > 0) {
    
    Serpent__((__m512i*)out,&((__m512i*)out)[4],key,
              (__m512i*)out,&((__m512i*)out)[4]);
    signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;
    out += BLOCK_SIZE * PARALLEL_FACTOR;
  }

  return 0;
}


int crypto_stream(unsigned char *out,
                  unsigned long long outlen,
                  const unsigned char *n,
                  const unsigned char *k
                  )
{
  return crypto_stream_xor(out,NULL,outlen,n,k);
}

