#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>

#define NO_RUNTIME
#include "../../arch/SSE.h"

#define SET1_EPI64(x)         _mm_set1_epi64x(x)
#define SET_EPI64_2(a,b)      _mm_set_epi64x(a,b)
#define SET_EPI64_4(a,b,c,d)  _mm_set1_epi64x(0)


void print64bin (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8bin(c) printf("%d%d%d%d%d%d%d%d",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8bin(bytearray[i]);
}

/* void print64bin (const unsigned long n) { */
/*   for (int i = 1; i <= 64; i++) { */
/*     printf("%lu",(n>>(64-i)) & 1); */
/*   }   */
/* } */

void print128bin (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}

void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
  /* printf("%016lx%016lx\n",((unsigned long*)bytearray)[0], ((unsigned long *)bytearray)[1]); */
}

#pragma push_macro("L_SHIFT")
#pragma push_macro("R_SHIFT")

#define _mm_slli_epi128(a,b) ZERO
#define _L_SHIFT(a,b,c) (c <= 64 ? _mm_slli_epi##c(a,b) :               \
                         b == 8  ? _mm_srli_si128(a, 1) :               \
                         b == 16 ? _mm_srli_si128(a, 2) :               \
                         b == 32 ? _mm_srli_si128(a, 4) :               \
                         b == 64 ? _mm_srli_si128(a, 8) :               \
                         ({ fprintf(stderr, "Not implemented L_SHIFT(x,%d,%d).\n", (int)b, c); \
                           exit(EXIT_FAILURE);                          \
                           ZERO; }))
#define L_SHIFT(a,b,c) _L_SHIFT(a,b,c)

#define _mm_srli_epi128(a,b) ZERO
#define _R_SHIFT(a,b,c)  (c <= 64 ? _mm_srli_epi##c(a,b) :              \
                          b == 8  ? _mm_slli_si128(a, 1) :              \
                          b == 16 ? _mm_slli_si128(a, 2) :              \
                          b == 32 ? _mm_slli_si128(a, 4) :              \
                          b == 64 ? _mm_slli_si128(a, 8) :              \
                         ({ fprintf(stderr, "Not implemented R_SHIFT(x,%d,%d).\n", (int)b, c); \
                           exit(EXIT_FAILURE);                          \
                           ZERO; }))
#define R_SHIFT(a,b,c) _R_SHIFT(a,b,c)


void orthogonalize(DATATYPE data[], int M, int LOG2_M, int LOG2_A) {
  DATATYPE mask_l[] = {
    SET1_EPI64(0xaaaaaaaaaaaaaaaaUL),
    SET1_EPI64(0xccccccccccccccccUL),
    SET1_EPI64(0xf0f0f0f0f0f0f0f0UL),
    SET1_EPI64(0x00ff00ff00ff00ffUL),
    SET1_EPI64(0x0000ffff0000ffffUL),
    SET1_EPI64(0x00000000ffffffffUL),
    SET_EPI64_2(0x0000000000000000UL,0xffffffffffffffffUL),
    SET_EPI64_4(0x0000000000000000UL,0x0000000000000000UL,
                0xffffffffffffffffUL,0xffffffffffffffffUL)
  };
  
  DATATYPE mask_r[] = {
    SET1_EPI64(0x5555555555555555UL),
    SET1_EPI64(0x3333333333333333UL),
    SET1_EPI64(0x0f0f0f0f0f0f0f0fUL),
    SET1_EPI64(0xff00ff00ff00ff00UL),
    SET1_EPI64(0xffff0000ffff0000UL),
    SET1_EPI64(0xffffffff00000000UL),
    SET_EPI64_2(0xffffffffffffffffUL,0x0000000000000000UL),
    SET_EPI64_4(0xffffffffffffffffUL,0xffffffffffffffffUL,
                0x0000000000000000UL,0x0000000000000000UL)
  };

  for (int i = 0; i < LOG2_M; i++) {
    int n = 1UL << i;
    for (int j = 0; j < M; j += 2*n) {
      for (int k = 0; k < n; k++) {
        DATATYPE u = AND(data[j + k], mask_l[LOG2_A+i]);
        DATATYPE v = AND(data[j + k], mask_r[LOG2_A+i]);
        DATATYPE x = AND(data[j + n + k], mask_l[LOG2_A+i]);
        DATATYPE y = AND(data[j + n + k], mask_r[LOG2_A+i]);
        if ((i+LOG2_A) < 3) {
          data[j + k] = OR(u, R_SHIFT(x,(1UL << (i+LOG2_A)),64));
          data[j + n + k] =OR(L_SHIFT(v,(1UL << (i+LOG2_A)),64), y);
        } else {
          data[j + k] = OR(u, R_SHIFT(x,(1UL << (i+LOG2_A)),BITS_PER_REG));
          data[j + n + k] =OR(L_SHIFT(v,(1UL << (i+LOG2_A)),BITS_PER_REG), y);
        }
      }
    }
  }
}
#pragma pop_macro("L_SHIFT")
#pragma pop_macro("R_SHIFT")



void visual_bitslice_128x64() {
  uint64_t data[128];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = a;
    data[i+64] = a;
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }

  for (int i = 0; i < 128; i++) { print64bin(data[i]); puts(""); }

  orthogonalize(data,128,7,0);
  puts("");

  for (int i = 0; i < 64; i++) print128bin(((__m128i*)data)[i]);
  puts("\n");
}

void visual_bitslice_128x128() {
  __m128i data[128];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = _mm_set_epi64x(-1,a);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i+64] = _mm_set_epi64x(a,0);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }

  for (int i = 0; i < 128; i++) print128bin(data[i]);

  orthogonalize(data,128,7,0);
  puts("");

  for (int i = 0; i < 128; i++) print128bin(data[i]);
  puts("\n");
}

void visual_nslice_8x128() {
  __m128i data[8];
  for (int i = 0; i < 8; i++) {
    data[i] = _mm_set1_epi8(i == 0 ? 0xFF : i == 1 ? 0x7F : i == 2 ? 0x3F :
                            i == 3 ? 0x1F : i == 4 ? 0x0F : i == 5 ? 0x07 :
                            i == 6 ? 0x03 : i == 7 ? 0x01 : 0);
  }

  for (int i = 0; i < 8; i++) print128bin(data[i]);

  orthogonalize(data,8,3,0);
  puts("");

  for (int i = 0; i < 8; i++) print128bin(data[i]);
  puts("\n");
  
  
}
void visual_vector_4x128() {

  __m128i data[4];
  data[0] = _mm_set_epi32(0x33333333, 0x22222222, 0x11111111, 0x00000000);
  data[1] = _mm_set_epi32(0x77777777, 0x66666666, 0x55555555, 0x44444444);
  data[2] = _mm_set_epi32(0xBBBBBBBB, 0xAAAAAAAA, 0x99999999, 0x88888888);
  data[3] = _mm_set_epi32(0xFFFFFFFF, 0xEEEEEEEE, 0xDDDDDDDD, 0xCCCCCCCC);

  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("");

  orthogonalize(data,4,2,5);

  
  for (int i = 0; i < 4; i++) print128hex(data[i]);
  puts("\n");
  
  
}

int main() {
  //test_shift();
  visual_bitslice_128x64();
  /* visual_bitslice_128x128(); */
  /* visual_nslice_8x128(); */
  /* visual_vector_4x128(); */
  
  return 0;
  
}
