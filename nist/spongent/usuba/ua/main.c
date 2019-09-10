#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "spongent.c"
#define spongent permutation

#elif defined(UA_B)

#include "spongent_ua_bitslice.c"
/* Transposition stuffs */
static uint32_t mask_l[5] = {
	0xaaaaaaaa,
	0xcccccccc,
	0xf0f0f0f0,
	0xff00ff00,
	0xffff0000
};
static uint32_t mask_r[5] = {
	0x55555555,
	0x33333333,
	0x0f0f0f0f,
	0x00ff00ff,
	0x0000ffff
};
void transpose(uint32_t data[]) {
  for (int i = 0; i < 5; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 32; j += (2 * n))
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

void spongent(unsigned char text[20]) {
  uint32_t text_bs[20][8];
  for (int i = 0; i < 20; i++)
    for (int j = 0; j < 8; j++)
      text_bs[i][j] = (text[i] >> (7-j)) & 1 ? -1 : 0;

  uint32_t output_bs[20][8];
  permutation__(text_bs,output_bs);

  for (int i = 0; i < 20; i++) {
    unsigned char c = 0;
    for (int j = 0; j < 8; j++)
      c |= output_bs[i][j] ? (1 << (7-j)) : 0;
    text[i] = c;
  }
}


#else
#error Please define REF or UA_V
#endif




void test_spongent() {

  // This seemigly random input is produced by encrypting full 0s plain
  /* unsigned char text[20] = { 0 }; */
  unsigned char text[20] = {
    0xe8, 0x0c, 0x00, 0x86, 0xa2, 0xcb, 0x82, 0x86, 0xa1, 0x62,
    0xc5, 0x0e, 0xde, 0x3e, 0xd1, 0xb9, 0x5f, 0x74, 0xed, 0xca
  };

  spongent(text);

  /* unsigned char expected[20] = { */
  /*   0xe8, 0x0c, 0x00, 0x86, 0xa2, 0xcb, 0x82, 0x86, 0xa1, 0x62, */
  /*   0xc5, 0x0e, 0xde, 0x3e, 0xd1, 0xb9, 0x5f, 0x74, 0xed, 0xca */
  /* }; */
  unsigned char expected[20] = {
    0x0d, 0x7f, 0x1a, 0xf2, 0xc8, 0x5e, 0xb8, 0x0f, 0x1b, 0x95,
    0xcc, 0x80, 0x60, 0x5f, 0x10, 0x56, 0x8e, 0x6e, 0x34, 0xac
  };

  if (memcmp(text, expected, 20) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 20; i++)
      fprintf(stderr, "%02x ",expected[i]);
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 20; i++)
      fprintf(stderr, "%02x ",text[i]);
    fprintf(stderr,"\n");
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}


int main() {
  test_spongent();
}
