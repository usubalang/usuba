#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define MASK_VAL(a,x) {                         \
    uint64_t val = a;                           \
    for (int j = 1; j < MASKING_ORDER; j++) {   \
      uint64_t mask = rand();                   \
      val ^= mask;                              \
      x[j] = mask;                              \
    }                                           \
    x[0] = val;                                 \
  }
#define UNMASK_VAL(x,a) {                       \
    a = 0;                                      \
    for (int j = 0; j < MASKING_ORDER; j++)     \
      a ^= x[j];                                \
  }

#ifdef REF

#error Not Implemented

#elif defined(UA_V)

#include "ascon_ua_vslice.c"
void ascon(uint64_t text[5]) {
  uint64_t input[5][MASKING_ORDER];
  for (int i = 0; i < 5; i++)
    MASK_VAL(text[i],input[i]);

  uint64_t output[5][MASKING_ORDER];
  ascon12__(input,output);

  for (int i = 0; i < 5; i++)
    UNMASK_VAL(output[i],text[i]);
}

#elif defined(UA_B)
#include "ascon_ua_bitslice.c"
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

void ascon(uint64_t text[5]) {
  uint64_t text_bs[320];
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 64; j++)
      text_bs[i*64+j] = text[i];
    transpose(&text_bs[i*64]);
  }

  uint64_t input_masked[320][MASKING_ORDER];
  for (int i = 0; i < 320; i++)
    MASK_VAL(text_bs[i], input_masked[i]);

  uint64_t output_masked[320][MASKING_ORDER];
  ascon12__(input_masked,output_masked);

  uint64_t output_bs[320];
  for (int i = 0; i < 320; i++)
    UNMASK_VAL(output_masked[i], output_bs[i]);

  for (int i = 0; i < 5; i++) {
    transpose(&output_bs[i*64]);
  }

  for (int i = 0; i < 5; i++)
    text[i] = output_bs[i*64];//__builtin_bswap64(output_bs[i*64]);
}

#else
#error Please define REF or UA_V
#endif




void test_skinny() {

  // This seemigly random input is produced by encrypting full 0s plain
  uint64_t text[5] = { 0x78ea7ae5cfebb108, 0x9b9bfb8513b560f7, 0x6937f83e03d11a50,
                       0x3fe53f36f2c1178c, 0x045d648e4def12c9 };
  /* uint64_t text[5] = { 0, 0, 0, 0, 0 }; */

  ascon(text);

  uint64_t expected[5] = { 0x0e87fa7d4b40022e, 0x94f14f2525499af5, 0x30a1d1621866701c,
                           0x4b419cf3ae4c9962, 0xb11ce0a087175b71 };

  if (memcmp(text, expected, 5*sizeof(uint64_t)) != 0) {
    fprintf(stderr, "Error encryption.\n");
    fprintf(stderr, "Expected : ");
    for (int i = 0; i < 5; i++) fprintf(stderr, "%016lx ",expected[i]);
    fprintf(stderr, "\nGot      : ");
    for (int i = 0; i < 5; i++) fprintf(stderr, "%016lx ",text[i]);
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr, "Seems OK.\n");
  }
}


int main() {
  test_skinny();
}
