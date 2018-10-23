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

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

/* Include your .h (or .c if you're a durty being) here. */
#include "key_sched.c"
#include "aes_bs.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 16

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 8

#define key_schedule()                                                  \
  __m128i key[11][8];                                                   \
  {                                                                     \
    unsigned char* sched_key = key_sched(k);                            \
    int i;                                                              \
    for (i = 0; i < 11; i++) {                                          \
      int j;                                                            \
      for (j = 0; j < 8; j++) {                                         \
        key[i][j] = _mm_load_si128((__m128i*)&sched_key[i*16]);         \
      }                                                                 \
      /* orthogonalize(key[i]);   */                                          \
      bitslice(key[i][7],key[i][6],key[i][5],key[i][4],key[i][3], key[i][2],key[i][1],key[i][0]); \
      if ((SBOX == 0 || SBOX == 1 || SBOX == 3 || SBOX == 5) && i > 0) { \
        key[i][1] = _mm_xor_si128(key[i][1],_mm_set1_epi32(-1));        \
        key[i][2] = _mm_xor_si128(key[i][2],_mm_set1_epi32(-1));        \
        key[i][6] = _mm_xor_si128(key[i][6],_mm_set1_epi32(-1));        \
        key[i][7] = _mm_xor_si128(key[i][7],_mm_set1_epi32(-1));        \
      }                                                                 \
    }                                                                   \
  }

#ifdef C128

#define load_input()                                                    \
  __m128i input[8], out_buff[8];                                        \
  int nb_blocks =  0;                                                   \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                           \
  if (unlikely(((uint64_t*)&counter)[1] > (0xffffffffffffffff-8))) {    \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                  \
      input[nb_blocks] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      incr_128(counter);                                                \
    }                                                                   \
  } else {                                                              \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                  \
      input[nb_blocks] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      counter = _mm_sub_epi64(counter,_mm_slli_si128(ONES,8));          \
    }                                                                   \
  }

#else


#define load_input()                                                    \
  __m128i input[8], out_buff[8];                                        \
  int nb_blocks =  0;                                                   \
  signed_len -= BLOCK_SIZE * PARALLEL_FACTOR;                            \
  if (unlikely(counter[1] > (0xffffffffffffffff-8))) {                  \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                  \
      input[nb_blocks] = _mm_shuffle_epi8(*((__m128i*)counter),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      /* memcpy(&input[nb_blocks],counter,16) ;  */                     \
      incr_counter(counter);                                            \
    }                                                                   \
  }                                                                     \
  else {                                                                \
    for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                  \
      input[nb_blocks] = _mm_shuffle_epi8(*((__m128i*)counter),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
      /* memcpy(&input[nb_blocks],counter,16) ;  */                     \
      ++counter[1];                                                     \
    }                                                                   \
  }

#endif


#define encrypt() aes_bs(input, key, out_buff);


static void incr_counter(unsigned long c[2]) {
  if (++c[1] == 0) ++c[0];
}

#define incr_128(c) {                                   \
    __m128i minus_one = _mm_slli_si128(ONES,8);         \
    __m128i overflow = _mm_cmpeq_epi64(c, minus_one);   \
    c = _mm_sub_epi64(minus_one,c);                     \
    overflow = _mm_slli_si128(overflow,8);              \
    c = _mm_sub_epi64(overflow,c);                      \
  }

#define end_xor(type)                                               \
  for ( ; encrypted >= sizeof(type); encrypted -= sizeof(type) ) {  \
    *((type*)out) = *((type*)out_buff_char) ^ *((type*)in);         \
    out += sizeof(type);                                            \
    out_buff_char += sizeof(type);                                  \
    in += sizeof(type);                                             \
  }

#include <stdio.h>

static void print64bin (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8bin(c) printf("%d%d%d%d%d%d%d%d ",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8bin(bytearray[i]);
}
static void print128bin (const __m128i v) {
  unsigned long out[2];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
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
#ifdef C128
  __m128i counter = _mm_load_si128((__m128i*)n);
  counter = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
#else
  unsigned long counter[2] __attribute__ ((aligned (32)));
  memcpy(counter, n, 16);
  counter[0] = __builtin_bswap64(counter[0]);
  counter[1] = __builtin_bswap64(counter[1]);
#endif
  
  asm("#counter start");
  /* Encrypting the input... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    asm("#counter end");
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
