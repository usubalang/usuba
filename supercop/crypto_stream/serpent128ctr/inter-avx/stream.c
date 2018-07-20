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
#include "AVX.h"
#include "key_sched.c"
#include "serpent.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 16

/* This macro should define a variable 'key' of whatever type.         */
/* It should only rely on the variable 'k' (of type unsigned char*).   */
#define key_schedule()                                  \
  DATATYPE key[33][4];                                  \
  {                                                     \
    unsigned int key_std[33][4];                        \
    makeKey((const char*)k,key_std);                    \
    for (int i = 0; i < 33; i++)                        \
      for (int j = 0; j < 4; j++)                       \
        key[i][j] = _mm256_set1_epi32(key_std[i][j]);   \
  }

/* This macro should define the variable 'input', 'out_buff' and 
   'nb_blocks'.
   input should be initialized with the counter's values.
   out_buff will be passed to 'encrypt' to be used as output.
   nb_blocks is the number of blocks being actually processed.
   The counter is in 'counter', and the length is in 'signed_len',
   which should be updated by this macro. */
#define load_input()                            \
  unsigned long input[PARALLEL_FACTOR*4] __attribute__ ((aligned (32))); \
  int nb_blocks = PARALLEL_FACTOR;              \
  for (int i = 0; i < 8; i++) {                 \
    memcpy(&input[i*2],counter,16);             \
    incr_counter(counter);                      \
  }                                             \
  for (int i = 0; i < 8; i++) {                 \
    memcpy(&input[16+i*2],counter,16);          \
    incr_counter(counter);                      \
  }                                             \
  signed_len -= BLOCK_SIZE*PARALLEL_FACTOR;     \



#define TRANSPOSE4(x0, x1, x2, x3)              \
  do {                                          \
    __m256i t0, t1, t2;                         \
                                                \
    t0 = _mm256_unpacklo_epi32(x1,x0);          \
    t2 = _mm256_unpackhi_epi32(x1,x0);          \
    t1 = _mm256_unpacklo_epi32(x3,x2);          \
    x3 = _mm256_unpackhi_epi32(x3,x2);          \
                                                \
    x0 = _mm256_unpacklo_epi64(t1,t0);          \
    x1 = _mm256_unpackhi_epi64(t1,t0);          \
    x2 = _mm256_unpacklo_epi64(x3,t2);          \
    x3 = _mm256_unpackhi_epi64(x3,t2);          \
  } while (0);

#define TRANSPOSE4_out(x0, x1, x2, x3)          \
  do {                                          \
    __m256i t0, t1, t2;                         \
                                                \
    t0 = _mm256_unpacklo_epi32(x1,x0);          \
    t2 = _mm256_unpackhi_epi32(x1,x0);          \
    t1 = _mm256_unpacklo_epi32(x3,x2);          \
    x3 = _mm256_unpackhi_epi32(x3,x2);          \
                                                \
    x0 = _mm256_unpackhi_epi64(x3,t2);          \
    x1 = _mm256_unpacklo_epi64(x3,t2);          \
    x2 = _mm256_unpackhi_epi64(t1,t0);          \
    x3 = _mm256_unpacklo_epi64(t1,t0);          \
  } while (0);

/* Serpent-specific macro */
#define serpent_bs()                                                    \
  DATATYPE *plain = (DATATYPE*) input;                                  \
  for (int i = 0; i < 8; i++)                                           \
    plain[i] = _mm256_shuffle_epi8(plain[i],                            \
                                   _mm256_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7, \
                                                    8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
  TRANSPOSE4(plain[0],plain[1],plain[2],plain[3]);                      \
  TRANSPOSE4(plain[4],plain[5],plain[6],plain[7]);                      \
                                                                        \
  DATATYPE cipher[8] __attribute__ ((aligned (32)));                    \
  Serpent__(plain,&plain[4],key,key,cipher,&cipher[4]);                 \
                                                                        \
  TRANSPOSE4_out(cipher[0],cipher[1],cipher[2],cipher[3]);              \
  TRANSPOSE4_out(cipher[4],cipher[5],cipher[6],cipher[7]);              \
  for (int i = 0; i < 8; i++)                                           \
    cipher[i] = _mm256_shuffle_epi8(cipher[i],                          \
                                    _mm256_set_epi8(3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12, \
                                                    3,2,1,0,7,6,5,4,11,10,9,8,15,14,13,12)); \
  unsigned int *out_buff = (unsigned int*) cipher;


   
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
      end_xor(__m256i);
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

