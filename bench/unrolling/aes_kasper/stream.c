#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>


/* ******************************************************************* */
/*   Just redifine those defines for a new implementation              */
/*                                                                     */
/* ******************************************************************* */

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

/* Include your .h (or .c if you're a durty being) here. */
#include "key_sched.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 8

#define key_schedule()                                                  \
  __m128i key[11][8];                                                   \
  key_sched_128(k,key);


#define load_input()                                                    \
  __m128i input[8], out_buff[8];                                        \
  int nb_blocks =  PARALLEL_FACTOR;                                     \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                           \
  if (likely(((uint64_t*)&counter)[1] <= (0xffffffffffffffff-8))) {     \
    for (int i = 0; i < PARALLEL_FACTOR; i++) {                         \
      input[i] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      counter = _mm_sub_epi64(counter,_mm_slli_si128(ONES,8));          \
    }                                                                   \
  } else {                                                              \
    for (int i = 0; i < PARALLEL_FACTOR; i++) {                         \
      input[i] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      incr_128(counter);                                                \
    }                                                                   \
  }

#define incr_128(c) {                                   \
    __m128i minus_one = _mm_slli_si128(ONES,8);         \
    __m128i overflow = _mm_cmpeq_epi64(c, minus_one);   \
    c = _mm_sub_epi64(c,minus_one);                     \
    overflow = _mm_srli_si128(overflow,8);              \
    c = _mm_sub_epi64(c,overflow);                      \
  }
  


#define encrypt()                                                       \
  bitslice(input[7],input[6],input[5],input[4],input[3],input[2],input[1],input[0]); \
  AES__(input,key,out_buff);                                              \
  bitslice(out_buff[7],out_buff[6],out_buff[5],out_buff[4],out_buff[3],out_buff[2],out_buff[1],out_buff[0]);




#define end_xor(type)                                               \
  for ( ; encrypted >= sizeof(type); encrypted -= sizeof(type) ) {  \
    *((type*)out) = *((type*)out_buff_char) ^ *((type*)in);         \
    out += sizeof(type);                                            \
    out_buff_char += sizeof(type);                                  \
    in += sizeof(type);                                             \
  }

#define NO_RUNTIME
#include "SSE.h"
void AES__ (DATATYPE plain__[8],DATATYPE key__[11][8], DATATYPE cipher__[8]);

int crypto_stream_xor( unsigned char *out,
                       const unsigned char *in,
                       unsigned long long inlen,
                       const unsigned char *n,
                       const unsigned char *k
                       )
{
  long long signed_len = inlen;

  /* Copying the counter */
  __m128i counter = _mm_load_si128((__m128i*)n);
  counter = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
  
  /* Key schedule */
  key_schedule();
  
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
      /* end_xor(unsigned long); */
      /* end_xor(unsigned int); */
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
