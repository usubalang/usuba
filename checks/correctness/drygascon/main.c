#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "drygascon128_ref.h"
#include "drysponge_ref.h"
void drygascon(uint8_t x[40], uint8_t r[16]) {
  DRYSPONGE_t ctx;
  memcpy(ctx.c,x,40);
  ctx.rounds = 11;
  DRYSPONGE_g(&ctx);
  memcpy(x,ctx.c,40);
  memcpy(r,ctx.r,16);
}

#elif defined(UA_V)

#include "drygascon_ua_vslice.c"
void drygascon(uint8_t text[40], uint8_t r[16]) {
  uint64_t* input = (uint64_t*)text;
  uint64_t output[5];
  drysponge_g__(input,output,(uint64_t*)r);
  memcpy(text,output,5*sizeof(uint64_t));
}

#elif defined(UA_B)

#include "drygascon_ua_bitslice.c"
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

void drygascon(uint8_t text[40], uint8_t r[16]) {
  uint64_t text_bs[5][64];
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 64; j++)
      text_bs[i][j] = ((uint64_t*)text)[i];
    transpose(text_bs[i]);
  }

  uint64_t output_bs[5][64];
  uint64_t r_bs[2][64];
  drysponge_g__(text_bs,output_bs,r_bs);

  for (int i = 0; i < 5; i++)
    transpose(output_bs[i]);
  for (int i = 0; i < 2; i++)
    transpose(r_bs[i]);

  for (int i = 0; i < 5; i++)
    ((uint64_t*)text)[i] = output_bs[i][0];
  for (int i = 0; i < 2; i++)
    ((uint64_t*)r)[i] = r_bs[i][0];
}

#else
#error Please define REF or UA_VDRYSPONGE_MixPhase
#endif


void test_drygascon() {

  //uint8_t text[5*8+2*8] = { 0 };
  // This seemigly random input is produced by encrypting full 0s plain
  uint8_t text[5*8+2*8] = {
    0x6d, 0x21, 0x29, 0x00, 0xa0, 0x5c, 0x84, 0xa5,
    0x20, 0x6f, 0xac, 0xd9, 0x8d, 0xb4, 0x1d, 0xd5,
    0x6a, 0xa0, 0x1a, 0x6e, 0xfe, 0x2c, 0xfa, 0xeb,
    0xd4, 0xa7, 0x3d, 0xe6, 0x63, 0x16, 0x7e, 0x66,
    0x14, 0xc1, 0x9c, 0xc3, 0xe2, 0x1b, 0xdc, 0xf2
  };

  drygascon(text,&text[40]);

  /* uint8_t expected[56] = { */
  /*   /\* C *\/ */
  /*   0x6d, 0x21, 0x29, 0x00, 0xa0, 0x5c, 0x84, 0xa5, */
  /*   0x20, 0x6f, 0xac, 0xd9, 0x8d, 0xb4, 0x1d, 0xd5, */
  /*   0x6a, 0xa0, 0x1a, 0x6e, 0xfe, 0x2c, 0xfa, 0xeb, */
  /*   0xd4, 0xa7, 0x3d, 0xe6, 0x63, 0x16, 0x7e, 0x66, */
  /*   0x14, 0xc1, 0x9c, 0xc3, 0xe2, 0x1b, 0xdc, 0xf2, */
  /*   /\* R *\/ */
  /*   0x5b, 0xfb, 0x58, 0xe5, 0xac, 0xf4, 0x72, 0x1d, */
  /*   0xfc, 0x57, 0x59, 0x6d, 0x8b, 0xa3, 0x16, 0xac */
  /* }; */

  uint8_t expected[56] = {
    /* C */
    0x59, 0xf8, 0xa6, 0x36, 0x51, 0xee, 0x7b, 0xae,
    0xe2, 0x09, 0xbe, 0x35, 0x5d, 0x28, 0x1e, 0x23,
    0x80, 0xcd, 0xdb, 0x2b, 0xa2, 0x88, 0xc4, 0x45,
    0xa6, 0xa6, 0xda, 0xc8, 0x0f, 0x04, 0xe9, 0x79,
    0x99, 0x74, 0xbe, 0x95, 0x7e, 0x31, 0x32, 0x60,
    /* R */
    0x42, 0x2d, 0xb5, 0xc3, 0x85, 0x1e, 0x7e, 0xea,
    0x9d, 0x67, 0xd9, 0x32, 0x71, 0x3a, 0x12, 0x04
  };

  if (memcmp(text, expected, 56) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 8; j++) fprintf(stderr, "%02x", expected[i*8+j]);
      fprintf(stderr, " ");
    }
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 8; j++) fprintf(stderr, "%02x", text[i*8+j]);
      fprintf(stderr, " ");
    }
    fprintf(stderr, "\n");
    exit(EXIT_FAILURE);
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}


int main() {
  test_drygascon();
}
