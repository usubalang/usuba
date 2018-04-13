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
#include "rectangle_bs.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 8

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                          \
  __m128i key[26][4];                                           \
  for (int i = 0; i < 26; i++) {                                \
    for (int j = 0; j < 4; j++) {                               \
      key[i][j] = _mm_set_epi64x(rand(), rand());               \
    }                                                           \
  }


/* This macro should define the variable 'input', 'out_buff' and 
   'nb_blocks'.
   input should be initialized with the counter's values.
   out_buff will be passed to 'encrypt' to be used as output.
   nb_blocks is the number of blocks being actually processed.
   The counter is in 'counter', and the length is in 'signed_len',
   which should be updated by this macro. */
#define load_input()                                                \
  __m128i input[4], out_buff[4];                                    \
  int nb_blocks = 0;                                                \
  for (; (signed_len > 0) && (nb_blocks < PARALLEL_FACTOR);         \
       signed_len -= BLOCK_SIZE, nb_blocks++) {                     \
    input[nb_blocks] = _mm_load_si128((__m128i*)counter);           \
    incr_counter(counter);                                          \
  }                                                                

/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt() rectangle_bs(input, key, out_buff);


/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */

static void incr_counter(unsigned char c[8]) {
  for (int i = 7; i > 0; i--)
    if (++c[i] != 0) break;
}

int crypto_stream(unsigned char *out,
                  unsigned long long outlen,
                  const unsigned char *n,
                  const unsigned char *k
                  )
{
  long long signed_len = outlen;

  /* Key schedule */
  key_schedule();

  /* Copying the counter */
  unsigned char counter[8] __attribute__ ((aligned (32)));;
  memcpy(counter, n, 8);

  /* Encrypting... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */
    encrypt();
    /* Storing the output */
    memcpy(out,out_buff,nb_blocks*BLOCK_SIZE + (signed_len < 0 ? signed_len : 0) );
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
  key_schedule();
  
  /* Copying the counter */
  unsigned char counter[16] __attribute__ ((aligned (32)));
  memcpy(counter, n, 16);

  /* Encrypting the input... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */    
    encrypt();
    /* Xoring the ciphertext with the input to produce the output */
        
    unsigned char* out_buff_char = (unsigned char*) out_buff;
    unsigned long encrypted = nb_blocks * BLOCK_SIZE + (signed_len < 0 ? signed_len : 0);
    for ( ; encrypted >= 16; encrypted -= 16) {
      *((__m128i*)out) = *((__m128i*)out_buff_char) ^ *((__m128i*)in);
      out += 16;
      out_buff_char += 16;
      in += 16;
    }
    
    for ( ; encrypted >= 8; encrypted -= 8) {
      *((unsigned long*)out) = *((unsigned long*)out_buff_char) ^ *((unsigned long*)in);
      out += 8;
      out_buff_char += 8;
      in += 8;
    }
    
    for ( ; encrypted >= 4; encrypted -= 4) {
      *((unsigned int*)out) = *((unsigned int*)out_buff_char) ^ *((unsigned int*)in);
      out += 4;
      out_buff_char += 4;
      in += 4;
    }

    for ( ; encrypted > 0; encrypted-- ) {
      *((unsigned char*)out) = *((unsigned char*)out_buff_char) ^ *((unsigned char*)in);
      out++;
      out_buff_char++;
      in++;
    }
    
  }

  return 0;
}
