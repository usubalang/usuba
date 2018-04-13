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
#include "aes_bs.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 16

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                                  \
  __m256i key[11][8];                                                   \
  {                                                                     \
    unsigned char* sched_key = key_sched(k);                            \
    int i;                                                              \
    for (i = 0; i < 11; i++) {                                          \
      int j;                                                            \
      for (j = 0; j < 8; j++)                                           \
        key[i][j] = _mm256_loadu2_m128i((__m128i*)&sched_key[i*16],     \
                                        (__m128i*)&sched_key[i*16]);    \
      orthogonalize(key[i]);                                            \
    }                                                                   \
  }                                                             

/* This macro should define the variable 'input', 'out_buff' and 
   'nb_blocks'.
   input should be initialized with the counter's values.
   out_buff will be passed to 'encrypt' to be used as output.
   nb_blocks is the number of blocks being actually processed.
   The counter is in 'counter', and the length is in 'signed_len',
   which should be updated by this macro. */
#define load_input()                                                    \
  __m256i input[8], out_buff[8];                                        \
  int nb_blocks = 0;                                                    \
  for (; (signed_len > 0) && (nb_blocks < PARALLEL_FACTOR);             \
       /* Note the two *2 in the following line */                      \
       signed_len -= BLOCK_SIZE*2, nb_blocks += 2) {                    \
    __m128i low_part  = _mm_load_si128((__m128i*) counter);             \
    incr_counter(counter);                                              \
    __m128i high_part = _mm_load_si128((__m128i*) counter);             \
    incr_counter(counter);                                              \
    input[nb_blocks/2] = _mm256_loadu2_m128i(&low_part,&high_part);     \
  }                                                                

/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt() aes_bs(input, key, out_buff);


/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */

static void incr_counter(unsigned char c[16]) {
  for (int i = 15; i > 0; i--)
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
  unsigned char counter[16] __attribute__ ((aligned (32)));;
  memcpy(counter, n, 16);

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
    for ( ; encrypted >= 32; encrypted -= 32) {
      *((__m256i*)out) = *((__m256i*)out_buff_char) ^ *((__m256i*)in);
      out += 32;
      out_buff_char += 32;
      in += 32;
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
