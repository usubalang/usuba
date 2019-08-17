#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <string.h>

#ifdef REF
#include "skinny_reference.c"
#elif defined(UA_V)
#include "skinny_ua_vslice.c"
// Just a small wrapper to make gcc/clang not complain about
// incompatible pointer types bla bla bla.
void enc(uint8_t* input, uint8_t* tweakey, uint8_t* output) {
  uint8_t plain[4][4];
  uint8_t tweak[32];
  uint8_t cipher[4][4];
  memcpy(plain,input,16);
  memcpy(tweak,tweakey,32);
  Skinny__(plain,tweak,cipher);
  memcpy(output,cipher,16);
}
#elif defined(UA_B)
#include "skinny_ua_bitslice.c"
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


#define swap(a,b) { uint64_t _tmp_ = a; a = b; b = _tmp_; }
#define bitslice(var,mult)                              \
  uint64_t var##_bs[128*mult];                          \
  for (int i = 0; i < 64; i++)                          \
    for (int j = 0; j < 2*mult; j++)                    \
      memcpy(&var##_bs[64*j+i],&var[j*8],8);            \
                                                        \
  for (int i = 0; i < 2*mult; i++)                      \
    transpose(&var##_bs[64*i]);                         \

void enc(uint8_t* input, const uint8_t* tweakey, uint8_t* output) {
  ((uint64_t*)input)[0] = __builtin_bswap64(((uint64_t*)input)[0]);
  ((uint64_t*)input)[1] = __builtin_bswap64(((uint64_t*)input)[1]);
  bitslice(input,1);
  ((uint64_t*)tweakey)[0] = __builtin_bswap64(((uint64_t*)tweakey)[0]);
  ((uint64_t*)tweakey)[1] = __builtin_bswap64(((uint64_t*)tweakey)[1]);
  ((uint64_t*)tweakey)[2] = __builtin_bswap64(((uint64_t*)tweakey)[2]);
  ((uint64_t*)tweakey)[3] = __builtin_bswap64(((uint64_t*)tweakey)[3]);
  bitslice(tweakey,2);

  uint64_t plain[4][4][8];
  uint64_t tweak[32][8];
  uint64_t cipher[4][4][8];
  memcpy(plain,input_bs,128*sizeof(uint64_t));
  memcpy(tweak,tweakey_bs,256*sizeof(uint64_t));
  Skinny__(plain,tweak,cipher);

  uint64_t output_bs[128];
  memcpy(output_bs,cipher,128*sizeof(uint64_t));

  transpose(output_bs);
  transpose(&output_bs[64]);
  memcpy(output,output_bs,8);
  memcpy(&output[8],&output_bs[64],8);
  ((uint64_t*)output)[0] = __builtin_bswap64(((uint64_t*)output)[0]);
  ((uint64_t*)output)[1] = __builtin_bswap64(((uint64_t*)output)[1]);

}

#else
#error Please define REF or UA_V
#endif




void test_skinny() {

  // This seemigly random input is produced by encrypting full 0s plain/tweakey
  uint8_t input[16]   = { 0xd7, 0x8c, 0x84, 0x05, 0xd3, 0x9c, 0x47, 0xd0,
                          0xdc, 0x90, 0xbb, 0xe9, 0x9b, 0xb6, 0x91, 0x75 };
  uint8_t tweakey[32] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                          0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
                          0x01, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
                          0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
  uint8_t output[16]  = { 0 };

  enc(input, tweakey, output);

  uint8_t output_ref[16] = { 0x84, 0x27, 0x46, 0xbe, 0x9e, 0xae, 0x6b, 0x33,
                             0xfa, 0x9f, 0xf0, 0x00, 0x77, 0x4f, 0x2b, 0x63 };

  if (memcmp(output, output_ref, 16) != 0) {
    fprintf(stderr, "Encryption error.\nExpected: ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",output_ref[i]);
    fprintf(stderr, "\n");
    fprintf(stderr, "Got     : ");
    for (int i = 0; i < 16; i++) fprintf(stderr, "%02x ",output[i]);
    fprintf(stderr, "\n");
    exit(EXIT_FAILURE);
  }
}


int main() {
  test_skinny();
}
