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
#include "AVX.h"
#include "chacha20.c"

/* The size of the block, in bytes. */
#define BLOCK_SIZE 64

/* How many blocks can be processed at once. */
#define PARALLEL_FACTOR 8


unsigned int chacha_const[4] = { 0x61707865, 0x3320646e, 0x79622d32, 0x6b206574 };


#define init()                                                  \
  DATATYPE state[16];                                           \
  for (int i = 0; i < 4; i++)                                   \
    state[i] = _mm256_set1_epi32(chacha_const[i]);              \
  for (int i = 0; i < 8; i++)                                   \
    state[i+4] = _mm256_set1_epi32(((int*)k)[i]);               \
  for (int i = 0; i < 2; i++)                                   \
    state[i+14] = _mm256_set1_epi32(((int*)n)[i]);              \
  for (int i = 0; i < 2; i++)                                   \
    state[i+12] = _mm256_setzero_si256();                       \

/* Note: that's buggy: if the initial key isn't a multiple of 8, 
   the overflow won't be right */
#define load_input()                                                    \
  state[12] = _mm256_set_epi32(c1,c1+1,c1+2,c1+3,c1+4,c1+5,c1+6,c1+7);  \
  state[13] = _mm256_set1_epi32(c2);                                    \
  c1 += 8;                                                              \
  if (!c1) c2++;                                                        \
  signed_len -= BLOCK_SIZE*PARALLEL_FACTOR;                             \
  unsigned int out_state[16*PARALLEL_FACTOR] __attribute__  ((aligned (32))); \
  int nb_blocks = PARALLEL_FACTOR;                                      \

#define V_ELEMS 8

static inline void _mm256_merge_epi32(const __m256i v0, const __m256i v1, __m256i *vl, __m256i *vh)
{
    __m256i va = _mm256_permute4x64_epi64(v0, _MM_SHUFFLE(3, 1, 2, 0));
    __m256i vb = _mm256_permute4x64_epi64(v1, _MM_SHUFFLE(3, 1, 2, 0));
    *vl = _mm256_unpacklo_epi32(va, vb);
    *vh = _mm256_unpackhi_epi32(va, vb);
}

static inline void _mm256_merge_epi64(const __m256i v0, const __m256i v1, __m256i *vl, __m256i *vh)
{
    __m256i va = _mm256_permute4x64_epi64(v0, _MM_SHUFFLE(3, 1, 2, 0));
    __m256i vb = _mm256_permute4x64_epi64(v1, _MM_SHUFFLE(3, 1, 2, 0));
    *vl = _mm256_unpacklo_epi64(va, vb);
    *vh = _mm256_unpackhi_epi64(va, vb);
}

static inline void _mm256_merge_si128(const __m256i v0, const __m256i v1, __m256i *vl, __m256i *vh)
{
    *vl = _mm256_permute2x128_si256(v0, v1, _MM_SHUFFLE(0, 2, 0, 0));
    *vh = _mm256_permute2x128_si256(v0, v1, _MM_SHUFFLE(0, 3, 0, 1));
}

//
// Transpose_8_8
//
// in place transpose of 8 x 8 int array
//

static void Transpose_8_8(
    __m256i *v0,
    __m256i *v1,
    __m256i *v2,
    __m256i *v3,
    __m256i *v4,
    __m256i *v5,
    __m256i *v6,
    __m256i *v7)
{
    __m256i w0, w1, w2, w3, w4, w5, w6, w7;
    __m256i x0, x1, x2, x3, x4, x5, x6, x7;

    _mm256_merge_epi32(*v0, *v1, &w0, &w1);
    _mm256_merge_epi32(*v2, *v3, &w2, &w3);
    _mm256_merge_epi32(*v4, *v5, &w4, &w5);
    _mm256_merge_epi32(*v6, *v7, &w6, &w7);

    _mm256_merge_epi64(w0, w2, &x0, &x1);
    _mm256_merge_epi64(w1, w3, &x2, &x3);
    _mm256_merge_epi64(w4, w6, &x4, &x5);
    _mm256_merge_epi64(w5, w7, &x6, &x7);

    _mm256_merge_si128(x0, x4, v0, v1);
    _mm256_merge_si128(x1, x5, v2, v3);
    _mm256_merge_si128(x2, x6, v4, v5);
    _mm256_merge_si128(x3, x7, v6, v7);
}

static void unortho(__m256i in[], __m256i out[]) {

  for (int i = 0; i < 2; i++) 
    Transpose_8_8(&in[i*8],&in[i*8+1],&in[i*8+2],&in[i*8+3],
                  &in[i*8+4],&in[i*8+5],&in[i*8+6],&in[i*8+7]);

  
  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 2; j++)
      out[(7-i)*2+j] = in[i+j*8];
}

#define encrypt()                                                       \
  DATATYPE cipher[16];                                                  \
  Chacha20__(state,cipher);                                             \
  for (int i = 0; i < 16; i++)                                          \
    cipher[i] = _mm256_add_epi32(cipher[i],state[i]);                   \
  unortho(cipher,(__m256i*)out_state);

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
