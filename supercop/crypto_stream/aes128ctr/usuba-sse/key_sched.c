#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

/* The only function of this file you shoud need: */
unsigned char* key_sched (const unsigned char in[16]);


unsigned char sbox[256] = {
     0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B,
     0xFE, 0xD7, 0xAB, 0x76, 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0,
     0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0, 0xB7, 0xFD, 0x93, 0x26,
     0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
     0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2,
     0xEB, 0x27, 0xB2, 0x75, 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0,
     0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84, 0x53, 0xD1, 0x00, 0xED,
     0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
     0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F,
     0x50, 0x3C, 0x9F, 0xA8, 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5,
     0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2, 0xCD, 0x0C, 0x13, 0xEC,
     0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
     0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14,
     0xDE, 0x5E, 0x0B, 0xDB, 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C,
     0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79, 0xE7, 0xC8, 0x37, 0x6D,
     0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
     0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F,
     0x4B, 0xBD, 0x8B, 0x8A, 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E,
     0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E, 0xE1, 0xF8, 0x98, 0x11,
     0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
     0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F,
     0xB0, 0x54, 0xBB, 0x16
   };

unsigned char rcon[11] = {
    0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36
};

static void rotate(unsigned char* in) {
  unsigned char tmp = in[0];
  for (int i = 0; i < 3; i++)
    in[i] = in[i+1];
  in[3] = tmp;
}

static void sched_core(unsigned char* in, unsigned int i) {
  rotate(in);
  for (int i = 0; i < 4; i++)
    in[i] = sbox[in[i]];
  in[0] ^= rcon[i];
}

unsigned char* key_sched (const unsigned char in[16]) {

  unsigned char* key = malloc(176 * sizeof(*key));

  memcpy(key,in,16);
  int c = 16, i = 1;

  while (c < 176) {
    unsigned char tmp[4];
    
    memcpy(tmp,&key[c-4],4);
    
    sched_core(tmp,i++);
    
    for (int k = 0; k < 4; k++)
      key[c+k] = key[c+k-16] ^ tmp[k];
    c += 4;
    
    for (int j = 0; j < 3; j++) {
      memcpy(tmp,&key[c-4],4);
      for (int k = 0; k < 4; k++)
        key[c+k] = key[c+k-16] ^ tmp[k];
      c += 4;
    }
  }

  return key;
}



#define NO_RUNTIME
#include "SSE.h"

#ifdef REV_SLICE
#define swapmove(a, b, n, m, t)                 \
  t = _mm_slli_epi32(b,n);                      \
  t = _mm_xor_si128(t,a);                       \
  t = _mm_and_si128(t,m);                       \
  a = _mm_xor_si128(a,t);                       \
  t = _mm_srli_epi32(t,n);                      \
  b = _mm_xor_si128(b,t);

#define bitslice(x0, x1, x2, x3, x4, x5, x6, x7)    \
  {                                                 \
    __m128i t0, t1;                                 \
    t0 = _mm_set1_epi32(/*0x55555555*/0xaaaaaaaa);  \
    swapmove(x7, x6, 1, t0, t1);                    \
    swapmove(x5, x4, 1, t0, t1);                    \
    swapmove(x3, x2, 1, t0, t1);                    \
    swapmove(x1, x0, 1, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(/*0x33333333*/0xcccccccc);  \
    swapmove(x7, x5, 2, t0, t1);                    \
    swapmove(x6, x4, 2, t0, t1);                    \
    swapmove(x3, x1, 2, t0, t1);                    \
    swapmove(x2, x0, 2, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(/*0x0f0f0f0f*/0xf0f0f0f0);  \
    swapmove(x7, x3, 4, t0, t1);                    \
    swapmove(x6, x2, 4, t0, t1);                    \
    swapmove(x5, x1, 4, t0, t1);                    \
    swapmove(x4, x0, 4, t0, t1);                    \
  }
#else
#define swapmove(a, b, n, m, t)                 \
  t = _mm_srli_epi32(b,n);                      \
  t = _mm_xor_si128(t,a);                       \
  t = _mm_and_si128(t,m);                       \
  a = _mm_xor_si128(a,t);                       \
  t = _mm_slli_epi32(t,n);                      \
  b = _mm_xor_si128(b,t);

#define bitslice(x0, x1, x2, x3, x4, x5, x6, x7)    \
  {                                                 \
    __m128i t0, t1;                                 \
    t0 = _mm_set1_epi32(0x55555555);  \
    swapmove(x7, x6, 1, t0, t1);                    \
    swapmove(x5, x4, 1, t0, t1);                    \
    swapmove(x3, x2, 1, t0, t1);                    \
    swapmove(x1, x0, 1, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(0x33333333);  \
    swapmove(x7, x5, 2, t0, t1);                    \
    swapmove(x6, x4, 2, t0, t1);                    \
    swapmove(x3, x1, 2, t0, t1);                    \
    swapmove(x2, x0, 2, t0, t1);                    \
                                                    \
    t0 = _mm_set1_epi32(0x0f0f0f0f);  \
    swapmove(x7, x3, 4, t0, t1);                    \
    swapmove(x6, x2, 4, t0, t1);                    \
    swapmove(x5, x1, 4, t0, t1);                    \
    swapmove(x4, x0, 4, t0, t1);                    \
  }
#endif

#define SBOX 1

void key_sched_128 (const unsigned char in[16], __m128i key[11][8]) {
  unsigned char* sched_key = key_sched(in);
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 8; j++) {
      key[i][j] = _mm_load_si128((__m128i*)&sched_key[i*16]);
    }
    bitslice(key[i][7],key[i][6],key[i][5],key[i][4],key[i][3], key[i][2],key[i][1],key[i][0]);
    if ((SBOX == 0 || SBOX == 1 || SBOX == 3 || SBOX == 5) && i > 0) {
#ifdef REV_SLICE
      key[i][0] = _mm_xor_si128(key[i][0],_mm_set1_epi32(-1));
      key[i][1] = _mm_xor_si128(key[i][1],_mm_set1_epi32(-1));
      key[i][5] = _mm_xor_si128(key[i][5],_mm_set1_epi32(-1));
      key[i][6] = _mm_xor_si128(key[i][6],_mm_set1_epi32(-1));
#else
      key[i][1] = _mm_xor_si128(key[i][1],_mm_set1_epi32(-1));
      key[i][2] = _mm_xor_si128(key[i][2],_mm_set1_epi32(-1));
      key[i][6] = _mm_xor_si128(key[i][6],_mm_set1_epi32(-1));
      key[i][7] = _mm_xor_si128(key[i][7],_mm_set1_epi32(-1));
#endif
    }
  }
}
