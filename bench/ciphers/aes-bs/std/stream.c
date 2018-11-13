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
#define DATATYPE unsigned long
#endif

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 64

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                                  \
  DATATYPE key[11][128];                                                \
  {                                                                     \
    unsigned char* sched_key = key_sched(k);                            \
    for (int i = 0; i < 11; i++)                                        \
      for (int j = 0; j < 128; j++)                                     \
        key[i][j] = sched_key[i*16+j/8] >> (7-j%8) & 1 ? -1 : 0;        \
  }
                                    

/* This macro should define the variable 'input', 'out_buff' and 
   'nb_blocks'.
   input should be initialized with the counter's values.
   out_buff will be passed to 'encrypt' to be used as output.
   nb_blocks is the number of blocks being actually processed.
   The counter is in 'counter', and the length is in 'signed_len',
   which should be updated by this macro. */
#define load_input()                                                \
  DATATYPE input[128], out_buff[128];                               \
  int nb_blocks = 0;                                                \
  for (; (signed_len > 0) && (nb_blocks < PARALLEL_FACTOR);         \
       signed_len -= BLOCK_SIZE, nb_blocks++) {                     \
    memcpy(&input[nb_blocks],counter,8);                            \
    memcpy(&input[nb_blocks+64],&counter[8],8);                     \
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

    
    if (in) {    
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

