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
#include "SSE.h"
#include "chacha20.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 64

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 4


unsigned int chacha_const[4] = { 0x61707865, 0x3320646e, 0x79622d32, 0x6b206574 };


#define init()                                                  \
  DATATYPE state[16];                                           \
  for (int i = 0; i < 4; i++)                                   \
    state[i] = _mm_set1_epi32(chacha_const[i]);                 \
  for (int i = 0; i < 8; i++)                                   \
    state[i+4] = _mm_set1_epi32(((int*)k)[i]);                  \
  for (int i = 0; i < 2; i++)                                   \
    state[i+14] = _mm_set1_epi32(((int*)n)[i]);                 \
  state[12] = _mm_set1_epi32(0);                                \
  state[13] = _mm_set1_epi32(0);                                \
  

#define load_input()                            \
  signed_len -= BLOCK_SIZE*PARALLEL_FACTOR;     \
  unsigned int out_state[16*PARALLEL_FACTOR];   \
  int nb_blocks = 4;                            \


/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt()                               \
  DATATYPE cipher[16];                          \
  Chacha20__(state,(__m128i*)out_state); 


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

  /* Encrypting the input... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */
    encrypt();
    /* Xoring the ciphertext with the input to produce the output */
    unsigned long encrypted = nb_blocks * BLOCK_SIZE + (signed_len < 0 ? signed_len : 0);
    
    memcpy(out, out_state, encrypted);
    out += encrypted;
    
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
