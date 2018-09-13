#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>

#define NO_RUNTIME
#include "SSE.h"

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
void print128bin (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}
void print64binSPC8 (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8binSPC8(c) printf("%d%d%d%d%d%d%d%d ",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8binSPC8(bytearray[i]);
}
void print128binSPC8 (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64binSPC8(out[i]);
  }
  puts("");
}

void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
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
    /* for (int i = 0; i < 4; i++) print128bin(data[i]); puts(""); */
  }
}
#pragma pop_macro("L_SHIFT")
#pragma pop_macro("R_SHIFT")


/* For instance: DES bitslice */
void visual_bitslice_128x64() {
  uint64_t data[128];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = a;
    data[i+64] = a;
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }

  for (int i = 0; i < 128; i++) { print64bin(data[i]); puts(""); } puts("");
  for (int i = 0; i < 64; i++) { print128bin(((__m128i*)data)[i]); }

  orthogonalize((DATATYPE*)data,64,6,0);
  puts("");

  for (int i = 0; i < 64; i++) print128bin(((__m128i*)data)[i]);
  puts("\n");
}

/* For instance: AES bitslice */
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

/* For instance: AES n-slice */
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

/* For instance: AES n-slice */
#define PRINTS 0
void visual_nslice_8x64() {
  unsigned long data_int[16];
  for (int i = 0; i < 8; i++) {
    data_int[i] = i == 0 || i == 7 ? 0x1032547698BADCFE : 0;
    /* data_int[i] = i == 0 ? 0xFFFFFFFFFFFFFFFF : i == 1 ? 0 : */
    /*   i == 2 ? 0x3F3F3F3F3F3F3F3F : i == 3 ? 0x1F1F1F1F1F1F1F1F : */
    /*   i == 4 ? 0x0F0F0F0F0F0F0F0F : i == 5 ? 0x0707070707070707 : */
    /*   i == 6 ? 0x0303030303030303 : i == 7 ? 0x0101010101010101 : 0x7F7F7F7F7F7F7F7F; */
  }
  for (int i = 8; i < 16; i++) data_int[i] = 0;
  __m128i* data = (__m128i*) data_int;

  for (int i = 0; i < 8; i++) print128binSPC8(data[i]); puts("");

  orthogonalize(data,8,3,0);
  puts("Orthogonalized:"); for (int i = 0; i < 8; i++) print128binSPC8(data[i]); puts("");

  __m128i tmp[8];  
  for (int i = 0; i < 8; i++) tmp[i] = _mm_shuffle_epi32(data[i],0b01001110);
  puts("Shuffled (>>> 64):"); for (int i = 0; i < 8; i++) print128binSPC8(tmp[i]); puts("");

  for (int i = 0; i < 4; i++)
    data[i] = OR(OR(AND(data[i],_mm_set_epi64x(0,-1)),
                    AND(tmp[i+4],_mm_set_epi64x(-1,0))),
                 OR(AND(_mm_srli_epi16(data[i+4],4),_mm_set_epi64x(-1,0)),
                    AND(_mm_srli_epi16(tmp[i],4),_mm_set_epi64x(0,-1))));
  puts("Combined (|):"); for (int i = 0; i < 4; i++) print128binSPC8(data[i]); puts(""); 
  
  for (int i = 0; i < 4; i++)
    data[i] = _mm_shuffle_epi8(data[i],_mm_set_epi8(15,13,11,9,7,5,3,1,14,12,10,8,6,4,2,0));
  puts("Shuffled (mixed):"); for (int i = 0; i < 4; i++) print128binSPC8(data[i]); puts("");
  
  orthogonalize(data,4,2,3);
  puts("Finale transpose:"); for (int i = 0; i < 4; i++) print128binSPC8(data[i]); puts("");
    
  puts("");
}

/* For instance: Serpent vectorized */
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

/* For instance: Serpent vectorized */
void visual_vector_16x128() {

  __m128i data[16];
  data[0]  = _mm_set1_epi32(0x00000000);
  data[1]  = _mm_set1_epi32(0x11111111);
  data[2]  = _mm_set1_epi32(0x22222222);
  data[3]  = _mm_set1_epi32(0x33333333);
  data[4]  = _mm_set1_epi32(0x44444444);
  data[5]  = _mm_set1_epi32(0x55555555);
  data[6]  = _mm_set1_epi32(0x66666666);
  data[7]  = _mm_set1_epi32(0x77777777);
  data[8]  = _mm_set1_epi32(0x88888888);
  data[9]  = _mm_set1_epi32(0x99999999);
  data[10] = _mm_set1_epi32(0xAAAAAAAA);
  data[11] = _mm_set1_epi32(0xBBBBBBBB);
  data[12] = _mm_set1_epi32(0xCCCCCCCC);
  data[13] = _mm_set1_epi32(0xDDDDDDDD);
  data[14] = _mm_set1_epi32(0xEEEEEEEE);
  data[15] = _mm_set1_epi32(0xFFFFFFFF);

  for (int i = 0; i < 16; i++) print128hex(data[i]); puts("");

  orthogonalize(data,16,4,5);

  for (int i = 0; i < 16; i++) print128hex(data[i]);
  puts("\n");
  
}

#define TRANSPOSE4(x0, x1, x2, x3) {                    \
    __m128i xmm01 = x0;                                 \
    __m128i xmm23 = x1;                                 \
    __m128i xmm45 = x2;                                 \
    __m128i xmm67 = x3;                                 \
	__m128i xmm02 = _mm_unpacklo_epi64(xmm01, xmm23);   \
    __m128i xmm13 = _mm_unpackhi_epi64(xmm01, xmm23);   \
	xmm01 = _mm_unpacklo_epi16(xmm02, xmm13);           \
	xmm23 = _mm_unpackhi_epi16(xmm02, xmm13);           \
	xmm02 = _mm_unpacklo_epi32(xmm01, xmm23);           \
	xmm13 = _mm_unpackhi_epi32(xmm01, xmm23);           \
	__m128i xmm46 = _mm_unpacklo_epi64(xmm45, xmm67);   \
	__m128i xmm57 = _mm_unpackhi_epi64(xmm45, xmm67);   \
	xmm45 = _mm_unpacklo_epi16(xmm46, xmm57);           \
	xmm67 = _mm_unpackhi_epi16(xmm46, xmm57);           \
	xmm46 = _mm_unpacklo_epi32(xmm45, xmm67);           \
	xmm57 = _mm_unpackhi_epi32(xmm45, xmm67);           \
	x0    = _mm_unpacklo_epi64(xmm02, xmm46);           \
	x1    = _mm_unpackhi_epi64(xmm02, xmm46);           \
	x2    = _mm_unpacklo_epi64(xmm13, xmm57);           \
	x3    = _mm_unpackhi_epi64(xmm13, xmm57);           \
  }


/* For instance: Rectangle vectorized */
void visual_vector_8x64() {

  __m128i data[4];
  data[0] = _mm_set_epi16(0x7777, 0x6666, 0x5555, 0x4444,
                          0x3333, 0x2222, 0x1111, 0x0000);
  data[1] = _mm_set_epi16(0xBBBB, 0xAAAA, 0x9999, 0x8888,
                          0xFFFF, 0xEEEE, 0xDDDD, 0xCCCC);
  data[2] = _mm_set_epi16(0x0707, 0x0606, 0x0505, 0x0404,
                          0x0303, 0x0202, 0x0101, 0x0000);
  data[3] = _mm_set_epi16(0x0F0F, 0x0E0E, 0x0D0D, 0x0C0C,
                          0x0B0B, 0x0A0A, 0x0909, 0x0808);

  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("");

  orthogonalize(data,4,2,4);

  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("");
  
  orthogonalize(data,4,2,4);
  
  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("");
  
  TRANSPOSE4(data[0],data[1],data[2],data[3]);
  
  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("");
  
  TRANSPOSE4(data[0],data[1],data[2],data[3]);
  
  for (int i = 0; i < 4; i++) print128hex(data[i]); puts("\n");
  
}

int main() {
  //test_shift();
  /* visual_bitslice_128x64(); */
  /* visual_bitslice_128x128(); */
  /* visual_nslice_8x128(); */
  /* visual_vector_4x128(); */
  /* visual_vector_16x128(); */
  /* visual_vector_8x64(); */
  visual_nslice_8x64();
  
  return 0;
  
}
