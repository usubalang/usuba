#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "Xoodoo-reference.c"
#define xoodoo Xoodoo_Permute_12rounds

#elif defined(UA_V)
#include "xoodoo_ua_vslice.c"

void xoodoo(uint32_t state[3*4]) {
  uint32_t input[3][4];
  memcpy(input,state,3*4*4);
  uint32_t output[3][4];
  xoodoo__(input,output);
  memcpy(state,output,3*4*4);
}

#elif defined(UA_B)
#include "xoodoo_ua_bitslice.c"
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

void xoodoo(uint32_t _state[3*4]) {
  uint32_t state[3][4];
  memcpy(state,_state,3*4*4);

  uint32_t input_bs[3][4][32];
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 4; j++) {
      for (int k = 0; k < 32; k++)
        input_bs[i][j][k] = state[i][j];
      transpose(input_bs[i][j]);
    }

  uint32_t output_bs[3][4][32];
  xoodoo__(input_bs,output_bs);

  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 4; j++) {
      transpose(output_bs[i][j]);
      state[i][j] = output_bs[i][j][0];
    }
  memcpy(_state,state,3*4*4);
}



#else
#error Please define REF or UA_V
#endif




void test_xoodoo() {

  // This seemigly random input is produced by encrypting full 0s plain
  /* uint32_t state[3*4] = { 0 }; */
  uint32_t state[3*4] =  {
    0x89d5d88d, 0xa963fcbf, 0x1b232d19, 0xffa5a014,
    0x36b18106, 0xafc7c1fe, 0xaee57cbe, 0xa77540bd,
    0x2e86e870, 0xfef5b7c9, 0x8b4fadf2, 0x5e4f4062 };

  xoodoo(state);

  /* uint32_t expected[3*4] = { */
  /*   0x89d5d88d, 0xa963fcbf, 0x1b232d19, 0xffa5a014, */
  /*   0x36b18106, 0xafc7c1fe, 0xaee57cbe, 0xa77540bd, */
  /*   0x2e86e870, 0xfef5b7c9, 0x8b4fadf2, 0x5e4f4062 }; */
  uint32_t expected[3*4] = {
    0x7800275b, 0x7a3685b4, 0xaf055416, 0x8e6682e1,
    0x6c704342, 0x2ca90ca3, 0xbd3d8ec0, 0xe1c94ea9,
    0xa4399cad, 0x45b9d15b, 0x29b45758, 0x554aa496 };

  if (memcmp(state, expected, 3*4*4) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 3*4; i++) fprintf(stderr, "%08x ",expected[i]);
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 3*4; i++) fprintf(stderr, "%08x ",state[i]);
    fprintf(stderr, "\n");
    exit(EXIT_FAILURE);
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}


int main() {
  test_xoodoo();
}
