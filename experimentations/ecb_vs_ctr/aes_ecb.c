#include <string.h>
#include "header.h"


#define BLOCK_SIZE 16
#define PARALLEL_FACTOR 8

void encrypt_ecb(char* plain, const unsigned char* key, char* cipher, unsigned int length) {

  __m128i subkeys[11][8];
  key_sched_128(key,subkeys);

  while (length > BLOCK_SIZE * PARALLEL_FACTOR) {
    __m128i input[8], output[8];
    memcpy(input, plain, BLOCK_SIZE * PARALLEL_FACTOR);

    bitslice(input[7], input[6], input[5], input[4],
             input[3], input[2], input[1], input[0]);

    AES__(input, subkeys, output);

    bitslice(output[7], output[6], output[5], output[4],
             output[3], output[2], output[1], output[0]);
    memcpy(cipher, output, BLOCK_SIZE * PARALLEL_FACTOR);
    plain  += BLOCK_SIZE * PARALLEL_FACTOR;
    cipher += BLOCK_SIZE * PARALLEL_FACTOR;
    length -= BLOCK_SIZE * PARALLEL_FACTOR;
  }

  if (length > 0) {
    __m128i input[8] = { 0 }, output[8];
    memcpy(input, plain, length);
    bitslice(input[7], input[6], input[5], input[4],
             input[3], input[2], input[1], input[0]);

    AES__(input, subkeys, output);

    bitslice(output[7], output[6], output[5], output[4],
             output[3], output[2], output[1], output[0]);
    memcpy(cipher, output, length);
  }


}
