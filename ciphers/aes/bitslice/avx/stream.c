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
#ifndef DATATYPE
#define DATATYPE __m256i
#endif

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 512

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                                  \
  DATATYPE key[11][128];                                                \
  {                                                                     \
    unsigned char* sched_key = key_sched(k);                            \
    for (int i = 0; i < 11; i++)                                        \
      for (int j = 0; j < 128; j++)                                     \
        key[i][j] = sched_key[i*16+j/8] >> (7-j%8) & 1 ? ONES : ZERO;   \
  }
                                    

/* This macro should define the variable 'input', 'out_buff' and 
   'nb_blocks'.
   input should be initialized with the counter's values.
   out_buff will be passed to 'encrypt' to be used as output.
   nb_blocks is the number of blocks being actually processed.
   The counter is in 'counter', and the length is in 'signed_len',
   which should be updated by this macro. */
#define load_input()                                                    \
  __m256i input[256], out_buff[256];                                    \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                           \
  int nb_blocks = 0;                                                    \
  if (counter[1] > (0xffffffffffffffff-16)) {                           \
    for ( ; nb_blocks < PARALLEL_FACTOR; nb_blocks += 2) {              \
      __m128i low_part, high_part;                                      \
      memcpy(&low_part,counter,16);                                     \
      incr_counter(counter);                                            \
      memcpy(&high_part,counter,16);                                    \
      incr_counter(counter);                                            \
      input[nb_blocks/2] = _mm256_loadu2_m128i(&high_part,&low_part);   \
    }                                                                   \
  } else {                                                              \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks += 2) {               \
      __m128i low_part, high_part;                                      \
      memcpy(&low_part,counter,16);                                     \
      ++counter[1];                                                     \
      memcpy(&high_part,counter,16);                                    \
      ++counter[1];                                                     \
      input[nb_blocks/2] = _mm256_loadu2_m128i(&high_part,&low_part);   \
    }                                                                   \
  }
static void incr_counter(unsigned long c[2]) {
  if (++c[1] == 0) ++c[0];
}


/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt() aes_bs(input, key, out_buff);


/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */


#define end_xor(type)                                               \
  for ( ; encrypted >= sizeof(type); encrypted -= sizeof(type) ) {  \
    *((type*)out) = *((type*)out_buff_char) ^ *((type*)in);         \
    out += sizeof(type);                                            \
    out_buff_char += sizeof(type);                                  \
    in += sizeof(type);                                             \
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
  unsigned long counter[2] __attribute__ ((aligned (32)));
  memcpy(counter, n, 16);
  counter[0] = __builtin_bswap64(counter[0]);
  counter[1] = __builtin_bswap64(counter[1]);

  
  /* Encrypting the input... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */    
    encrypt();
    /* Xoring the ciphertext with the input to produce the output */
        
    unsigned char* out_buff_char = (unsigned char*) out_buff;
    unsigned long encrypted = nb_blocks * BLOCK_SIZE + (signed_len < 0 ? signed_len : 0);

    
    if (in) {    
      end_xor(__m128i);
      end_xor(unsigned long);
      end_xor(unsigned int);
      end_xor(unsigned char);
    } else {
      memcpy(out, out_buff_char, encrypted);
      out += encrypted;
    }
    
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

