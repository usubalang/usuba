/* Should print:

00000000000000000000000000000000
FFFF00FFFF00FF00FFFFFFFFFFFFFFFF
00FFFFFFFFFF00FFFFFFFF00FFFFFFFF
FFFF0000000000000000FF00FFFF00FF
00000000FF00FF0000FF000000FFFF00
FF0000FF0000000000FFFFFFFF00FFFF
00FF00FF0000FF00000000FF0000FF00
00FF00FF0000FF00FFFFFF0000FF00FF


 */

#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>
#include <stdint.h>

#include "key_sched.c"

void print128hex (const __m128i v) {
  uint8_t a[16];
  _mm_store_si128 ((__m128i*)a, v);
  for (int i = 0; i < 16; i++)
    printf("%02X",a[i]);
  puts("");  
}

void print64bin (const uint64_t n) {
  for (int i = 1; i <= 64; i++)
    printf("%lu",(n>>(64-i)) & 1);
}
void print8bin (const uint8_t n) {
  for (int i = 1; i <= 8; i++)
    printf("%d",(n>>(8-i)) & 1);
}

void print128bin (const __m128i v) {
  uint8_t out[16];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i < 16; i++) {
    print8bin(out[i]);
  }
  puts("");
}


/* Orthogonalization stuffs */
static uint8_t mask_l[3] = {
	0xaa,
	0xcc,
	0xf0,
};

static uint8_t mask_r[3] = {
	0x55,
	0x33,
	0x0f,
};

/* Verified: it works. */
void real_ortho(uint8_t data[8]) {
  for (int i = 0; i < 3; i++) {
    int n = (1 << i);
    for (int j = 0; j < 8; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint8_t u = data[j + k] & mask_l[i];
        uint8_t v = data[j + k] & mask_r[i];
        uint8_t x = data[j + n + k] & mask_l[i];
        uint8_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}


void load_bitslice (const __m128i a[8], __m128i b[8]) {
  uint8_t b_int[8][16];
  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 16; j++)
      b_int[i][j] = 0;

  uint8_t a_int[8][16];
  for (int i = 0; i < 8; i++)
    _mm_store_si128 ((__m128i*)a_int[i], a[i]);

  for (int i_1 = 0; i_1 < 4; i_1++)
    for (int i_2 = 0; i_2 < 4; i_2++) {
      int i_in  = i_1 + i_2*4;
      int i_out = i_1*4 + i_2;
      uint8_t tmp[8];
      for (int j = 0; j < 8; j++)
        tmp[j] = a_int[j][i_in];
      real_ortho(tmp);
      for (int j = 0; j < 8; j++)
        b_int[j][i_out] = tmp[j];
    }

  for (int i = 0; i < 8; i++)
    b[i] = _mm_load_si128((__m128i*)b_int[i]);
}


int main() {
  char key[16] = { 0x54, 0x68, 0x61, 0x74, 0x73, 0x20, 0x6D, 0x79,
                   0x20, 0x4B, 0x75, 0x6E, 0x67, 0x20, 0x46, 0x75 };

  char* sched_key = key_sched(key);

  __m128i fin_key[11][8];
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 8; j++)
      fin_key[i][j] = _mm_load_si128((__m128i*)&sched_key[i*16]);
    load_bitslice(fin_key[i],fin_key[i]);
  }

  for (int i = 0; i < 8; i++)
    print128hex(fin_key[0][i]);

  
}
