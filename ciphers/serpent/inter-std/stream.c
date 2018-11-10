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
#include "key_sched.c"
#include "serpent.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 2

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                          \
  unsigned int key[33][4];                                      \
  makeKey((const char*)k,key);

/* This macro should define the variable 'input', 'out_buff' and 
   'nb_blocks'.
   input should be initialized with the counter's values.
   out_buff will be passed to 'encrypt' to be used as output.
   nb_blocks is the number of blocks being actually processed.
   The counter is in 'counter', and the length is in 'signed_len',
   which should be updated by this macro. */
#define load_input()                            \
  unsigned int input[8];                            \
  unsigned int out_buff[8];                         \
  int nb_blocks = 2;                                \
  {                                                 \
    memcpy(input,counter,16);                       \
    unsigned long* tmp = (unsigned long*)input;     \
    tmp[0] = __builtin_bswap64(tmp[0]);             \
    tmp[1] = __builtin_bswap64(tmp[1]);             \
    incr_counter(counter);                          \
    memcpy(&input[4],counter,16);                   \
    tmp = (unsigned long*)&input[4];                \
    tmp[0] = __builtin_bswap64(tmp[0]);             \
    tmp[1] = __builtin_bswap64(tmp[1]);             \
    incr_counter(counter);                          \
    signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;     \
  }

/* Serpent-specific macro */
#define serpent_bs() Serpent__(input,&input[4],key,key,out_buff,&out_buff[4]);
   
/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt() serpent_bs();


/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */
void incr_counter(unsigned long c[2]) {
  if (++c[1] == 0) ++c[0];
}

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
