// Should print 632FAFA2EB93C7209F92ABCBA0C0302B


#include <stdlib.h>
#include <stdio.h>
#include <x86intrin.h>
#include <stdint.h>

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


void load_bitslice (__m128i a[8], __m128i b[8]) {
  for (int i = 0; i < 8; i++) b[i] = _mm_setzero_si128();

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

#define DATATYPE __m128i
#define PERMUT_16(a,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16) \
  _mm_shuffle_epi8(a,_mm_set_epi8(x16,x15,x14,x13,x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1))

void ShiftRows_single__(/*input*/ DATATYPE inputSR__, /*outputs*/ DATATYPE* out__) {
  *out__ = PERMUT_16(inputSR__,0,1,2,3,5,6,7,4,10,11,8,9,15,12,13,14);
  //*out__ = PERMUT_16(inputSR__,14,13,12,15,9,8,11,10,4,7,6,5,3,2,1,0);
}

void ShiftRows__ (/*inputs*/ DATATYPE inputSR__[8], /*outputs*/ DATATYPE out__[8]) {
  // Instructions (body)
  ShiftRows_single__(inputSR__[0],&out__[0]);
  ShiftRows_single__(inputSR__[1],&out__[1]);
  ShiftRows_single__(inputSR__[2],&out__[2]);
  ShiftRows_single__(inputSR__[3],&out__[3]);
  ShiftRows_single__(inputSR__[4],&out__[4]);
  ShiftRows_single__(inputSR__[5],&out__[5]);
  ShiftRows_single__(inputSR__[6],&out__[6]);
  ShiftRows_single__(inputSR__[7],&out__[7]);

}

int main() {

  __m128i a[8], b[8];
  //uint8_t x[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
  //                  0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
  uint8_t x[16] = { 0x63, 0xC0, 0xAB, 0x20, 0xEB, 0x2F, 0x30, 0xCB,
                    0x9F, 0x93, 0xAF, 0x2B, 0xA0, 0x92, 0xC7, 0xA2 };
  for (int i = 0; i < 8; i++)
    a[i] = _mm_load_si128((__m128i*)x);
  

  for (int i = 0; i < 8; i++)
    print128hex(a[i]);
  load_bitslice(a,b);


  ShiftRows__(b,b);
  
  
  load_bitslice(b,a);
  puts("");
  for (int i = 0; i < 8; i++)
    print128hex(a[i]);

  
  
  
  return 0;
}
