#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "ace.c"
#define ace ace_permutation

#elif defined(UA_V)

#include "ace_ua_vslice.c"
void ace(unsigned char text[40]) {
  uint32_t input[5][2];
  for (int i = 0; i < 5; i++)
    for (int j = 0; j < 2; j++)
      input[i][j] = __builtin_bswap32(((uint32_t*)text)[i*2+j]);

  uint32_t output[5][2];
  ACE__(input,output);
  for (int i = 0; i < 5; i++)
    for (int j = 0; j < 2; j++)
      ((uint32_t*)text)[i*2+j] = __builtin_bswap32(output[i][j]);
}

#elif defined(UA_B)

#include "ace_ua_bitslice.c"
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

void ace(unsigned char text[40]) {
  uint64_t text_bs[5][64];
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 64; j++)
      text_bs[i][j] = __builtin_bswap64(((uint64_t*)text)[i]);
    transpose(text_bs[i]);
  }

  uint64_t output_bs[5][64];
  ACE__(text_bs,output_bs);

  for (int i = 0; i < 5; i++) {
    transpose(output_bs[i]);
  }

  for (int i = 0; i < 5; i++)
    ((uint64_t*)text)[i] = __builtin_bswap64(output_bs[i][0]);
}


#else
#error Please define REF or UA_V
#endif




void test_ace() {

  // This seemigly random input is produced by encrypting full 0s plain
  unsigned char text[40] = {
    0x5c, 0x93, 0x69, 0x1a, 0xd5, 0x06, 0x09, 0x35, 0xdc, 0x19,
    0xce, 0x94, 0x7e, 0xad, 0x55, 0x0d, 0xac, 0x12, 0xbe, 0xe1,
    0xa6, 0x4b, 0x67, 0x0e, 0xf5, 0x16, 0xe8, 0xbe, 0x1d, 0xfa,
    0x60, 0xda, 0x40, 0x98, 0x92, 0xa4, 0xe4, 0xcc, 0xbc, 0x15
  };

  ace(text);

  unsigned char expected[40] = {
    0x9d, 0x27, 0x59, 0x7d, 0xaf, 0xa5, 0x50, 0x11, 0x22, 0x0c,
    0x24, 0xa2, 0x36, 0xbe, 0x6e, 0x02, 0x8b, 0xe7, 0x20, 0xd3,
    0x33, 0x51, 0x1e, 0xb1, 0x96, 0xc1, 0x53, 0x5e, 0xe1, 0x4f,
    0x70, 0xc7, 0x2e, 0x5b, 0x33, 0xeb, 0xe5, 0x01, 0x01, 0x08
  };

  if (memcmp(text, expected, 40) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 8; j++) fprintf(stderr, "%02x",expected[i*8+j]);
      fprintf(stderr," ");
    }
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 8; j++) fprintf(stderr, "%02x",text[i*8+j]);
      fprintf(stderr," ");
    }
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}


int main() {
  test_ace();
}
