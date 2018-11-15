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
#include "key_sched.c"
#include "aes.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 32

#define key_schedule()                          \
  __m512i key[11][8];                           \
  {                                             \
    unsigned char* sched_key = key_sched(k);    \
    int i;                                      \
    for (i = 0; i < 11; i++) {                  \
      int j;                                    \
      for (j = 0; j < 8; j++) {                 \
        __m128i tmp[4];                         \
        for (int i = 0; i < 4; i++)             \
          key[i][j] = _mm512_loadu_si512(tmp);  \
      }                                         \
    }                                           \
  }


#define encrypt() aes_bs(input, key, out_buff)

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
    AES__((__m512i*)out,key,(__m512i*)out);
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

