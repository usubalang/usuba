#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#ifdef REF

#include "ascon_ref.c"
#define ascon(x) P12((state*)x)

#elif defined(UA_V)

#include "ascon_ua_vslice.c"
void ascon(uint64_t text[5]) {
  uint64_t output[5];
  ascon12__(text,output);
  memcpy(text,output,5*sizeof(uint64_t));
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

  uint64_t output_bs[320];
  ascon12__(text_bs,output_bs);

  for (int i = 0; i < 5; i++) {
    transpose(&output_bs[i*64]);
  }

  for (int i = 0; i < 5; i++)
    text[i] = output_bs[i*64];//__builtin_bswap64(output_bs[i*64]);
}

#else
#error Please define REF or UA_V
#endif




void test_ascon() {

  // This seemigly random input is produced by encrypting full 0s plain
  uint64_t text[5] = { 0x78ea7ae5cfebb108, 0x9b9bfb8513b560f7, 0x6937f83e03d11a50,
                       0x3fe53f36f2c1178c, 0x045d648e4def12c9 };
  //uint64_t text[5] = { 0, 0, 0, 0, 0 };

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
    exit(EXIT_FAILURE);
  }
}


int main() {
  test_ascon();
}
