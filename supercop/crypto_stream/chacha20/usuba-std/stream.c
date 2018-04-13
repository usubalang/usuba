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
#define BITS_PER_REG 32
#define DATATYPE unsigned int
#include "STD.h"
#include "chacha20.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 64

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 1


unsigned int chacha_const[4] = { 0x61707865, 0x3320646e, 0x79622d32, 0x6b206574 };


#define init()                                                  \
  unsigned int state[16];                                       \
  for (int i = 0; i < 4; i++)                                   \
    state[i] = chacha_const[i];                                 \
  for (int i = 0; i < 8; i++)                                   \
    state[i+4] = ((int*)k)[i];                                  \
  for (int i = 0; i < 2; i++)                                   \
    state[i+14] = ((int*)n)[i];                                 \
  state[12] = state[13] = 0;                                    \
  

#define load_input()                            \
  signed_len -= BLOCK_SIZE;                     \
  unsigned int out_state[16];                   \
  int nb_blocks = 1;                            \
   
/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt()                               \
  Chacha20__(state,out_state);                  \
  incr_counter(state);                          \
  for (int i = 0; i < 16; i++)                  \
    out_state[i] += state[i];

void print_state(unsigned int state[16]) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++)
      printf("%08x ",state[i*4+j]);
    printf("\n");
  }
  printf("\n");
}

/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */

static void incr_counter(unsigned int state[16]) {
  if (! ++state[12]) ++state[13];
}

int crypto_stream(unsigned char *out,
                  unsigned long long outlen,
                  const unsigned char *n,
                  const unsigned char *k
                  )
{
  long long signed_len = outlen;

  /* Key schedule */
  init();

  /* Copying the counter */
  unsigned char counter[8] __attribute__ ((aligned (32))) = { 0 };
  counter[7] = 1;

  /* Encrypting... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */
    encrypt();
    /* Storing the output */
    memcpy(out,out_state,nb_blocks*BLOCK_SIZE + (signed_len < 0 ? signed_len : 0) );
    /* Updating the output pointer */
    out += nb_blocks * BLOCK_SIZE;
  }

  return 0;

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
  init();

  /* Copying the counter */
  unsigned char counter[8] __attribute__ ((aligned (32))) = { 0 };
  counter[7] = 1;

  /* Encrypting the input... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */
    encrypt();
    /* Xoring the ciphertext with the input to produce the output */
    unsigned char* out_state_char = (unsigned char*) out_state;
    unsigned long encrypted = nb_blocks * BLOCK_SIZE + (signed_len < 0 ? signed_len : 0);
    for ( ; encrypted >= 8; encrypted -= 8) {
      *((unsigned long*)out) = *((unsigned long*)out_state_char) ^ *((unsigned long*)in);
      out += 8;
      out_state_char += 8;
      in += 8;
    }
    
    for ( ; encrypted >= 4; encrypted -= 4) {
      *((unsigned int*)out) = *((unsigned int*)out_state_char) ^ *((unsigned int*)in);
      out += 4;
      out_state_char += 4;
      in += 4;
    }

    for ( ; encrypted > 0; encrypted-- ) {
      *((unsigned char*)out) = *((unsigned char*)out_state_char) ^ *((unsigned char*)in);
      out++;
      out_state_char++;
      in++;
    }
  }

  return 0;
}
