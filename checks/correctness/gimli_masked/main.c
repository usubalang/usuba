#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define STATE_SIZE (4*3*4)


#define MASK_VAL(a,x,n) {                           \
    uint ## n ##_t val = a;                         \
    for (int _i = 1; _i < MASKING_ORDER; _i++) {    \
      uint ## n ##_t mask = rand();                 \
      val ^= mask;                                  \
      x[_i] = mask;                                 \
    }                                               \
    x[0] = val;                                     \
  }
#define UNMASK_VAL(x,a) {                       \
    a = 0;                                      \
    for (int _i = 0; _i < MASKING_ORDER; _i++)  \
      a ^= x[_i];                               \
  }

#define MASK_VAL32(a,x)   MASK_VAL(a,x,32)
#define UNMASK_VAL32(x,a) UNMASK_VAL(x,a)
#define MASK_VAL64(a,x)   MASK_VAL(a,x,64)
#define UNMASK_VAL64(x,a) UNMASK_VAL(x,a)


#ifdef REF

#error Not Implemented

#elif defined(UA_V)
#include "gimli_ua_vslice.c"
void gimli(uint8_t* s) {

  uint32_t* state = (uint32_t*)s;
  uint32_t input_masked[3][4][MASKING_ORDER];
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 4; j++)
      MASK_VAL32(state[i*4+j],input_masked[i][j]);

  uint32_t output_masked[3][4][MASKING_ORDER];
  gimli__(input_masked, output_masked);

  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 4; j++)
      UNMASK_VAL32(output_masked[i][j],state[i*4+j]);

}
#elif defined(UA_B)
#include "gimli_ua_bitslice.c"
void gimli(uint8_t* state) {
  uint64_t state_bs[STATE_SIZE*8];
  for (int i = 0; i < 4*3; i++)
    ((uint32_t*)state)[i] = __builtin_bswap32(((uint32_t*)state)[i]);
  for (int i = 0; i < STATE_SIZE; i++)
    for (int j = 0; j < 8; j++)
      state_bs[i*8+j] = ((state[i] >> (7-j)) & 1) ? -1 : 0;

  uint64_t input_masked[3][128][MASKING_ORDER];
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 128; j++)
      MASK_VAL32(state_bs[i*128+j],input_masked[i][j]);

  uint64_t output_masked[3][128][MASKING_ORDER];
  gimli__(input_masked,output_masked);
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 128; j++)
      UNMASK_VAL32(output_masked[i][j],state_bs[i*128+j]);

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

  // This seemingly random state is the result of encrypting a full 0 state
  uint8_t state[STATE_SIZE] =
    { 0xc4, 0xd8, 0x67, 0x64, 0x3b, 0xf8, 0xdc, 0x07, 0xd4, 0xb0, 0x0b, 0x3b,
      0x4c, 0x36, 0x21, 0x1b, 0xdc, 0x31, 0x34, 0x08, 0x8e, 0xbe, 0xfb, 0x0e,
      0x84, 0xe8, 0x54, 0x00, 0x55, 0xd9, 0x8b, 0x64, 0x2e, 0xb4, 0x5d, 0x4a,
      0xcb, 0x41, 0x06, 0xca, 0xc2, 0xd2, 0x73, 0x86, 0x09, 0xd8, 0x30, 0x2e };

  gimli(state);

  uint8_t expected[STATE_SIZE] =
    { 0x57, 0xa6, 0x9d, 0xf9, 0x78, 0x78, 0x6a, 0xfd, 0xe9, 0xea, 0x94, 0x88,
      0x85, 0xfd, 0x59, 0xfd, 0x12, 0xcd, 0x41, 0x9f, 0x91, 0x18, 0x6a, 0x26,
      0x31, 0xd8, 0x7a, 0xcf, 0xe9, 0xb6, 0x16, 0xf9, 0xe8, 0xa5, 0xa3, 0xb9,
      0x51, 0xee, 0x7d, 0x3d, 0xfd, 0xe0, 0x0c, 0xf5, 0x5e, 0x00, 0x02, 0xf1 };

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
