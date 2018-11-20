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
#define NO_RUNTIME
#include "SSE.h"
#include "chacha20.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 64

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 4


unsigned int chacha_const[4] = { 0x61707865, 0x3320646e, 0x79622d32, 0x6b206574 };

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

#define init()                                                  \
  DATATYPE state[16];                                           \
  for (int i = 0; i < 4; i++)                                   \
    state[i] = _mm_set1_epi32(chacha_const[i]);                 \
  for (int i = 0; i < 8; i++)                                   \
    state[i+4] = _mm_set1_epi32(((int*)k)[i]);                  \
  for (int i = 0; i < 2; i++)                                   \
    state[i+14] = _mm_set1_epi32(((int*)n)[i]);                 \
  

#define load_input()                                    \
  int c1_1, c1_2, c1_3, c1_4, c2_1, c2_2, c2_3, c2_4;   \
  c1_1 = c1; c2_1 = c2;                                 \
  if (likely(c1 < (0xffffffffffffffff-4))) {            \
    state[12] = _mm_set_epi32(c1,c1+1,c1+2,c1+3);       \
    state[13] = _mm_set1_epi32(c2);                     \
    c1 += 4;                                            \
  } else {                                              \
    if (!++c1) ++c2;                                    \
    c1_2 = c1; c2_2 = c2;                               \
    if (!++c1) ++c2;                                    \
    c1_3 = c1; c2_3 = c2;                               \
    if (!++c1) ++c2;                                    \
    c1_4 = c1; c2_4 = c2;                               \
    if (!++c1) ++c2;                                    \
    state[12] = _mm_set_epi32(c1_1,c1_2,c1_3,c1_4);     \
    state[13] = _mm_set_epi32(c2_1,c2_2,c2_3,c2_4);     \
  }                                                     \
  signed_len -= BLOCK_SIZE*PARALLEL_FACTOR;             \
  unsigned int out_state[16*PARALLEL_FACTOR];           \
  int nb_blocks = 4;                                    \


#define TRANSPOSE4(row0, row1, row2, row3)   \
  do {                                              \
    __m128 tmp3, tmp2, tmp1, tmp0;                  \
    tmp0 = _mm_unpacklo_ps((row0), (row1));         \
    tmp2 = _mm_unpacklo_ps((row2), (row3));         \
    tmp1 = _mm_unpackhi_ps((row0), (row1));         \
    tmp3 = _mm_unpackhi_ps((row2), (row3));         \
    row0 = _mm_movelh_ps(tmp0, tmp2);             \
    row1 = _mm_movehl_ps(tmp2, tmp0);             \
    row2 = _mm_movelh_ps(tmp1, tmp3);             \
    row3 = _mm_movehl_ps(tmp3, tmp1);             \
  } while (0)

static void unortho(__m128 in[], __m128 out[]) {

  for (int i = 0; i < 4; i++) 
    TRANSPOSE4(in[i*4+0],in[i*4+1],in[i*4+2],in[i*4+3]);

  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      out[(3-i)*4+j] = in[i+j*4];
}

/* This macro should just call the encryption function, with the parameters
   input, key and out_buff */
#define encrypt()                                                       \
  DATATYPE cipher[16];                                                  \
  Chacha20__(state,cipher);                                             \
  for (int i = 0; i < 16; i++)                                          \
    cipher[i] = _mm_add_epi32(cipher[i],state[i]);                      \
  unortho((__m128*)cipher,(__m128*)out_state);

  
void print128hex (const __m128i v) {
  unsigned int out[4];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i < 4; i++) {
    printf("%08X",out[i]);
  }
  puts("");
}

void print_state(__m128i state[16]) {
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      print128hex(state[i*4+j]);
  printf("\n");
}

/* ******************************************************************* */
/* This part should be independent of the ciphers => do not modify it. */
/*                                                                     */
/* ******************************************************************* */

#define end_xor(type)                                                   \
  for ( ; encrypted >= sizeof(type); encrypted -= sizeof(type) ) {      \
    *((type*)out) = *((type*)out_state_char) ^ *((type*)in);            \
    out += sizeof(type);                                                \
    out_state_char += sizeof(type);                                     \
    in += sizeof(type);                                                 \
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
  unsigned int c1 = 0;
  unsigned int c2 = 0;

  /* Encrypting the input... */
  while (signed_len > 0) {
    /* Loading the input (from the counter) */
    load_input();
    /* Encrypting it */
    encrypt();
    /* Xoring the ciphertext with the input to produce the output */
    unsigned char* out_state_char = (unsigned char*) out_state;
    unsigned long encrypted = nb_blocks * BLOCK_SIZE + (signed_len < 0 ? signed_len : 0);
    
    if (in) {
      end_xor(__m128i);
      end_xor(unsigned long);
      end_xor(unsigned int);
      end_xor(unsigned char);
    } else {
      memcpy(out, out_state_char, encrypted);
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
