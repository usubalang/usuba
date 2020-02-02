#include <string.h>
#include "header.h"

#define BLOCK_SIZE 16
#define PARALLEL_FACTOR 8


#define incr_128(c) {                                           \
    __m128i minus_one = _mm_slli_si128(_mm_set1_epi32(-1),8);   \
    __m128i overflow = _mm_cmpeq_epi64(c, minus_one);           \
    c = _mm_sub_epi64(c,minus_one);                             \
    overflow = _mm_srli_si128(overflow,8);                      \
    c = _mm_sub_epi64(c,overflow);                              \
  }

void encrypt_ctr(char* plain, const unsigned char* key,
                 const unsigned char* iv,
                 char* cipher, unsigned int length) {

  __m128i subkeys[11][8];
  key_sched_128(key,subkeys);

  __m128i counter = _mm_load_si128((__m128i*)iv);
  counter = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));

  while (length > BLOCK_SIZE * PARALLEL_FACTOR) {
    __m128i input[8], output[8];
    for (int i = 0; i < 8; i++) {
      input[i] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
      incr_128(counter);
    }

    bitslice(input[7], input[6], input[5], input[4],
             input[3], input[2], input[1], input[0]);

    AES__(input, subkeys, output);

    bitslice(output[7], output[6], output[5], output[4],
             output[3], output[2], output[1], output[0]);

    memcpy(cipher, output, BLOCK_SIZE * PARALLEL_FACTOR);
    for (int i = 0; i < PARALLEL_FACTOR * BLOCK_SIZE; i++)
      cipher[i] ^= plain[i];

    plain  += BLOCK_SIZE * PARALLEL_FACTOR;
    cipher += BLOCK_SIZE * PARALLEL_FACTOR;
    length -= BLOCK_SIZE * PARALLEL_FACTOR;
  }

  if (length > 0) {
    __m128i input[8], output[8];
    for (int i = 0; i < 8; i++) {
      input[i] = _mm_shuffle_epi8(counter,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
      incr_128(counter);
    }

    bitslice(input[7], input[6], input[5], input[4],
             input[3], input[2], input[1], input[0]);

    AES__(input, subkeys, output);

    bitslice(output[7], output[6], output[5], output[4],
             output[3], output[2], output[1], output[0]);
    memcpy(cipher, output, length);
    for (unsigned int i = 0; i < length; i++)
      cipher[i] ^= plain[i];
  }


}
