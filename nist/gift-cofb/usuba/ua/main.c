#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "gift128.c"
#define gift giftb128

#elif defined(UA_V)

#include "gift_ua_vslice.c"
void gift(uint32_t text[4], uint16_t key16[8]) {
  uint32_t key[8];
  for (int i = 0; i < 8; i++)
    key[i] = key16[i];

  uint32_t output[4];
  gift__(text,key,output);

  memcpy(text,output,16);
}

#elif defined(UA_B)

#include "gift_ua_bitslice.c"
/* Transposition stuffs */
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

void gift(uint32_t text[4], uint16_t key16[8]) {
  uint64_t text_bs[128];
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 64; j++) {
      text_bs[i*64+j] = ((uint64_t*)text)[i];
      text_bs[i*64+j] = (text_bs[i*64+j] >> 32) | (text_bs[i*64+j] << 32);
    }
    transpose(&text_bs[i*64]);
  }
  
  uint64_t key_bs[8][32];
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 16; j++)
      key_bs[i][j] = 0;
    for (int j = 0; j < 16; j++)
      key_bs[i][j+16] = (key16[i] >> (15-j)) & 1 ? -1 : 0;
  }

  uint64_t output_bs[128];
  gift__(text_bs, key_bs, output_bs);
  
  for (int i = 0; i < 2; i++)
    transpose(&output_bs[i*64]);

  memcpy(&text[0],&output_bs[0],8);
  memcpy(&text[2],&output_bs[64],8);
#define SWAP(a,b) { a ^= b; b ^= a; a ^= b; }
  SWAP(text[0],text[1]);
  SWAP(text[2],text[3]);
}


#else
#error Please define REF or UA_V
#endif




void test_gift() {
  
  // Uncomments the comments for a full of 0 plain/key.
  //uint32_t text[4] = { 0 };
  uint32_t text[4] = { 0xaaa8353c, 0xd131b478, 0x95fde102, 0x2de5d87a };
  //uint16_t key[8] = { 0 };
  uint16_t key[8]  = { 0x0123, 0x4567, 0x89ab, 0xcdef, 0xf0e1, 0xd2c3, 0xb4a5, 0x9687 };

  gift(text, key);
  for (int i = 0; i < 4; i++)
    text[i] = __builtin_bswap32(text[i]);

  //uint32_t expected[4] = { 0x2e3a8e5e, 0x7da79716, 0xdc890bcc, 0xee647ad9 };
  uint32_t expected[4] = { 0x739cfe1e, 0xb755869f, 0x603b349c, 0x889d5bad };

  if (memcmp(text, expected, 16) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 4; i++)
      fprintf(stderr, "%08x ",expected[i]);
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 4; i++)
      fprintf(stderr, "%08x ",text[i]);
    fprintf(stderr, "\n");
    exit(EXIT_FAILURE);
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}

int main() {
  test_gift();
}
