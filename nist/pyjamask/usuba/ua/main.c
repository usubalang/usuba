
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "pyjamask.h"
#include "pyjamask.c"

#if defined(REF)

void test_ref() {
  uint8_t plain[16] = { 0x50, 0x79, 0x6a, 0x61, 0x6d, 0x61, 0x73, 0x6b,
                        0x2d, 0x31, 0x32, 0x38, 0x3a, 0x29, 0x3a, 0x29 };
  uint8_t key[16]   = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                        0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
  uint8_t cipher[16];

  pyjamask_128_enc(plain,key,cipher);

  unsigned char expected[16] = { 0x48, 0xf1, 0x39, 0xa1, 0x09, 0xbd, 0xd9, 0xc0,
                                 0x72, 0x6e, 0x82, 0x61, 0xf8, 0xd6, 0x8e, 0x7d };
  if (memcmp(cipher, expected, 16) != 0) {
    fprintf(stderr, "Ref encryption error.\nExpected: ");
    for (int i = 0; i < 16; i++) printf("%02x ",expected[i]);
    printf("\nGot     : ");
    for (int i = 0; i < 16; i++) printf("%02x ",cipher[i]);
    printf("\n");
  } else {
    fprintf(stderr, "Ref encryption OK.\n");
  }
}

#elif defined(UA_V)
#include "pyjamask_ua_vslice.c"

void test_ua() {
  uint8_t plain[16] = { 0x50, 0x79, 0x6a, 0x61, 0x6d, 0x61, 0x73, 0x6b,
                        0x2d, 0x31, 0x32, 0x38, 0x3a, 0x29, 0x3a, 0x29 };
  uint8_t key[16]   = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                        0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
  uint8_t cipher[16];

  uint32_t roundkeys_[15*4];
  key_schedule(key,roundkeys_);
  uint32_t roundkeys[15][4];
  memcpy(roundkeys,roundkeys_,15*4*sizeof(uint32_t));

  uint32_t input[4];
  memcpy(input,plain,16);
  for (int i = 0; i < 4; i++)
    input[i] = __builtin_bswap32(input[i]);

  uint32_t output[4];
  pyjamask__(input,roundkeys,output);
  for (int i = 0; i < 4; i++)
    output[i] = __builtin_bswap32(output[i]);
  memcpy(cipher,output,16);


  unsigned char expected[16] = { 0x48, 0xf1, 0x39, 0xa1, 0x09, 0xbd, 0xd9, 0xc0,
                                 0x72, 0x6e, 0x82, 0x61, 0xf8, 0xd6, 0x8e, 0x7d };
  if (memcmp(cipher, expected, 16) != 0) {
    fprintf(stderr, "Ref encryption error.\nExpected: ");
    for (int i = 0; i < 16; i++) printf("%02x ",expected[i]);
    printf("\nGot     : ");
    for (int i = 0; i < 16; i++) printf("%02x ",cipher[i]);
    printf("\n");
  } else {
    fprintf(stderr, "Ref encryption OK.\n");
  }
}

#elif defined(UA_B)
#include "pyjamask_ua_bitslice.c"

/* Orthogonalization stuffs */
static uint64_t mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};
static uint64_t mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};
void transpose(uint64_t data[]) {
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint64_t u = data[j + k] & mask_l[i];
        uint64_t v = data[j + k] & mask_r[i];
        uint64_t x = data[j + n + k] & mask_l[i];
        uint64_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}


void test_ua() {
  uint8_t plain[16] = { 0x50, 0x79, 0x6a, 0x61, 0x6d, 0x61, 0x73, 0x6b,
                        0x2d, 0x31, 0x32, 0x38, 0x3a, 0x29, 0x3a, 0x29 };
  uint8_t key[16]   = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                        0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
  uint8_t cipher[16];

  /* input */
  uint64_t input[128];
  for (int i = 0; i < 64; i++) {
    memcpy(&input[i],plain,8);
    memcpy(&input[64+i],&plain[8],8);
    input[i]    = __builtin_bswap64(input[i]);
    input[64+i] = __builtin_bswap64(input[64+i]);
  }

  transpose(input);
  transpose(&input[64]);
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 16; j++) {
      uint64_t tmp = input[i*32+j];
      input[i*32+j] = input[i*32+31-j];
      input[i*32+31-j] = tmp;
    }
  }

  /* keys */
#define NB_ROUNDS_KS 14
  uint32_t round_keys[4*(NB_ROUNDS_KS+1)];
  key_schedule(key, round_keys);

  uint64_t keys[15][128];
  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 2; j++) {
      for (int k = 0; k < 64; k++) {
        memcpy(&keys[i][j*64+k], &round_keys[i*4+j*2+1],   4);
        memcpy(&((uint32_t*)(&keys[i][j*64+k]))[1], &round_keys[i*4+j*2], 4);
      }
      transpose(&keys[i][j*64]);
      for (int ii = 0; ii < 2; ii++) {
        for (int jj = 0; jj < 16; jj++) {
          uint64_t tmp = keys[i][j*64+ii*32+jj];
          keys[i][j*64+ii*32+jj] = keys[i][j*64+ii*32+31-jj];
          keys[i][j*64+ii*32+31-jj] = tmp;
        }
      }
    }
  }

  /* primitive */
  uint64_t output[128];
  pyjamask__(input, keys, output);

  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 16; j++) {
      uint64_t tmp = output[i*32+j];
      output[i*32+j] = output[i*32+31-j];
      output[i*32+31-j] = tmp;
    }
  }
  /* outputs */
  transpose(output);
  transpose(&output[64]);
  for (int i = 0; i < 128; i++)
    output[i] = __builtin_bswap64(output[i]);
  memcpy(cipher,output,8);
  memcpy(&cipher[8],&output[64],8);

  unsigned char expected[16] = { 0x48, 0xf1, 0x39, 0xa1, 0x09, 0xbd, 0xd9, 0xc0,
                                 0x72, 0x6e, 0x82, 0x61, 0xf8, 0xd6, 0x8e, 0x7d };
  if (memcmp(cipher, expected, 16) != 0) {
    fprintf(stderr, "Ref encryption error.\nExpected: ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",expected[i]);
    fprintf(stderr, "\nGot     : ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",cipher[i]);
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr, "UA encryption OK.\n");
  }
}

#else
#error Please defined REF, UA_V or UA_B
#endif

int main() {

#if defined(UA_V) || defined(UA_B)
  test_ua();
#endif
#ifdef REF
  test_ref();
#endif
}
