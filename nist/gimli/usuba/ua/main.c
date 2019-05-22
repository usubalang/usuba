#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define STATE_SIZE (4*3*4)


#ifdef REF
#include "gimli_ref.c"
#elif defined(UA_V)
#include "gimli_ua_vslice.c"
void gimli(uint8_t* state) {
  gimli__((uint32_t*)state, (uint32_t*)state);
}
#elif defined(UA_B)
#include "gimli_ua_bitslice.c"
void gimli(uint8_t* state) {
  uint64_t state_bs[STATE_SIZE*8];
  for (int i = 0; i < STATE_SIZE; i++)
    for (int j = 0; j < 8; j++)
      state_bs[i*8+j] = ((state[i] >> j) & 1) ? -1 : 0;
  gimli__(state_bs,state_bs);
  for (int i = 0; i < STATE_SIZE; i++) {
    uint8_t tmp = 0;
    for (int j = 0; j < 8; j++)
      tmp |= (state_bs[i*8+7-j]&1) << j;
    state[i] = tmp;
  }
  for (int i = 0; i < 4*3; i++)
    ((uint32_t*)state)[i] = __builtin_bswap32(((uint32_t*)state)[i]);
}
#else
#error Please define REF, UA_V or UA_B
#endif


void test_gimli() {

  uint8_t state[STATE_SIZE] = { 0 };

  gimli(state);

  uint8_t expected[STATE_SIZE] =
    { 0xc4, 0xd8, 0x67, 0x64, 0x3b, 0xf8, 0xdc, 0x07, 0xd4, 0xb0, 0x0b, 0x3b,
      0x4c, 0x36, 0x21, 0x1b, 0xdc, 0x31, 0x34, 0x08, 0x8e, 0xbe, 0xfb, 0x0e,
      0x84, 0xe8, 0x54, 0x00, 0x55, 0xd9, 0x8b, 0x64, 0x2e, 0xb4, 0x5d, 0x4a,
      0xcb, 0x41, 0x06, 0xca, 0xc2, 0xd2, 0x73, 0x86, 0x09, 0xd8, 0x30, 0x2e };

  if (memcmp(state, expected, STATE_SIZE) != 0) {
    fprintf(stderr, "Encryption error.\n");
    fprintf(stderr, "Expected: ");
    for (int i = 0; i < STATE_SIZE; i++)
      printf("%02x ", expected[i]);
    printf("\nGot     : ");
    for (int i = 0; i < STATE_SIZE; i++)
      printf("%02x ", state[i]);
    printf("\n");
  } else {
    fprintf(stderr, "Encryption seems OK.\n");
  }  
}


int main() {
  test_gimli();
}
