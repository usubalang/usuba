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
#define NO_RUNTIME
#include "AVX512.h"
#include "chacha20.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 64

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 16


unsigned int chacha_const[4] = { 0x61707865, 0x3320646e, 0x79622d32, 0x6b206574 };


#define init()                                                  \
  DATATYPE state[16];                                           \
  for (int i = 0; i < 4; i++)                                   \
    state[i] = _mm512_set1_epi32(chacha_const[i]);              \
  for (int i = 0; i < 8; i++)                                   \
    state[i+4] = _mm512_set1_epi32(((int*)k)[i]);               \
  for (int i = 0; i < 2; i++)                                   \
    state[i+14] = _mm512_set1_epi32(((int*)n)[i]);              \
  for (int i = 0; i < 2; i++)                                   \
    state[i+12] = _mm512_setzero_si512();                       \
  state[12] = _mm512_set1_epi32(0);                             \
  state[13] = _mm512_set1_epi32(0);                             \


/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */


int crypto_stream_xor( unsigned char *out,
                       const unsigned char *in,
                       unsigned long long inlen,
                       const unsigned char *n,
                       const unsigned char *k
                       )
{
  long long signed_len = inlen;
  
  /* Key schedule */
  init();

  while (signed_len > 0) {
    Chacha20__((__m512i*)out,(__m512i*)out);
    unsigned long encrypted = PARALLEL_FACTOR * BLOCK_SIZE;
    signed_len -= BLOCK_SIZE*PARALLEL_FACTOR;
    out += BLOCK_SIZE*PARALLEL_FACTOR;
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
