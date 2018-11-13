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
#define SBOX 1
#include "key_sched.c"
#include "aes.c"

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 8

#define key_schedule()                          \
  __m128i key[11][8];                           \
  key_sched_128(k,key);
      

#define encrypt() AES__((__m128i*)out,key,(__m128i*)out);


void AES__ (__m128i plain__[8],__m128i key__[11][8], __m128i cipher__[8]);
  
int crypto_stream_xor( unsigned char *out,
                       const unsigned char *in,
                       unsigned long long inlen,
                       const unsigned char *n,
                       const unsigned char *k
                       )
{
  long long signed_len = inlen;  
  
  key_schedule();
  
  while (signed_len >= PARALLEL_FACTOR * BLOCK_SIZE) {
    AES__((__m128i*)out,key,(__m128i*)out);
    out += PARALLEL_FACTOR * BLOCK_SIZE;
    signed_len -= PARALLEL_FACTOR * BLOCK_SIZE;
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
