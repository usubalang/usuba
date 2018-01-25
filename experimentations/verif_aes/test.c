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


void load_bitslice (const __m128i a[8], __m128i b[8]) {
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
#define ZERO _mm_setzero_si128()
#define ONES _mm_set1_epi32(-1)
#define AND(a,b)  _mm_and_si128(a,b)
#define OR(a,b)   _mm_or_si128(a,b)
#define XOR(a,b)  _mm_xor_si128(a,b)
#define ANDN(a,b) _mm_andnot_si128(a,b)
#define NOT(a)    _mm_andnot_si128(a,ONES)
#define PERMUT_16(a,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16) \
  _mm_shuffle_epi8(a,_mm_set_epi8(x16,x15,x14,x13,x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1))
#define PERMUT_4(a,x1,x2,x3,x4) _mm_shuffle_epi32(a,(x4<<6)|(x3<<4)|(x2<<2)|x1)

  
/* auxiliary functions */
void v2RL32__(/*input*/ DATATYPE input__, /*outputs*/ DATATYPE* out__) {
  *out__ = PERMUT_4(input__,/*A*/0,1,2,3);
}

void v2RL64__(/*input*/ DATATYPE input__, /*outputs*/ DATATYPE* out__) {
  *out__ = PERMUT_4(input__,/*B*/0,1,2,3);
}

/* main function */
void MixColumnns2__ (/*inputs*/ DATATYPE a__[8], /*outputs*/ DATATYPE b__[8]) {
  
  // Variables declaration
  DATATYPE _tmp12_;
  DATATYPE _tmp13_;
  DATATYPE _tmp14_;
  DATATYPE _tmp16_;
  DATATYPE _tmp17_;
  DATATYPE _tmp1_;
  DATATYPE _tmp20_;
  DATATYPE _tmp21_;
  DATATYPE _tmp23_;
  DATATYPE _tmp24_;
  DATATYPE _tmp29_;
  DATATYPE _tmp2_;
  DATATYPE _tmp30_;
  DATATYPE _tmp31_;
  DATATYPE _tmp33_;
  DATATYPE _tmp34_;
  DATATYPE _tmp39_;
  DATATYPE _tmp3_;
  DATATYPE _tmp40_;
  DATATYPE _tmp41_;
  DATATYPE _tmp43_;
  DATATYPE _tmp44_;
  DATATYPE _tmp47_;
  DATATYPE _tmp48_;
  DATATYPE _tmp4_;
  DATATYPE _tmp50_;
  DATATYPE _tmp51_;
  DATATYPE _tmp54_;
  DATATYPE _tmp55_;
  DATATYPE _tmp57_;
  DATATYPE _tmp58_;
  DATATYPE _tmp62_;
  DATATYPE _tmp65_;
  DATATYPE _tmp6_;
  DATATYPE _tmp7_;


  // Instructions (body)
  v2RL32__(a__[7],&_tmp1_);
  _tmp2_ = XOR(a__[7],_tmp1_);
  v2RL32__(a__[0],&_tmp3_);
  _tmp6_ = XOR(a__[0],_tmp3_);
  v2RL64__(_tmp6_,&_tmp7_);
  v2RL32__(a__[1],&_tmp13_);
  _tmp16_ = XOR(a__[1],_tmp13_);
  v2RL64__(_tmp16_,&_tmp17_);
  v2RL32__(a__[2],&_tmp20_);
  _tmp23_ = XOR(a__[2],_tmp20_);
  v2RL64__(_tmp23_,&_tmp24_);
  v2RL32__(a__[3],&_tmp30_);
  _tmp33_ = XOR(a__[3],_tmp30_);
  v2RL64__(_tmp33_,&_tmp34_);
  v2RL32__(a__[4],&_tmp40_);
  _tmp43_ = XOR(a__[4],_tmp40_);
  v2RL64__(_tmp43_,&_tmp44_);
  v2RL32__(a__[5],&_tmp47_);
  _tmp50_ = XOR(a__[5],_tmp47_);
  v2RL64__(_tmp50_,&_tmp51_);
  v2RL32__(a__[6],&_tmp54_);
  _tmp57_ = XOR(a__[6],_tmp54_);
  v2RL64__(_tmp57_,&_tmp58_);
  v2RL64__(_tmp2_,&_tmp65_);
  _tmp4_ = XOR(_tmp2_,_tmp3_);
  b__[0] = XOR(_tmp4_,_tmp7_);
  _tmp12_ = XOR(_tmp6_,_tmp2_);
  _tmp14_ = XOR(_tmp12_,_tmp13_);
  b__[1] = XOR(_tmp14_,_tmp17_);
  _tmp21_ = XOR(_tmp16_,_tmp20_);
  b__[2] = XOR(_tmp21_,_tmp24_);
  _tmp29_ = XOR(_tmp23_,_tmp2_);
  _tmp31_ = XOR(_tmp29_,_tmp30_);
  b__[3] = XOR(_tmp31_,_tmp34_);
  _tmp39_ = XOR(_tmp33_,_tmp2_);
  _tmp41_ = XOR(_tmp39_,_tmp40_);
  b__[4] = XOR(_tmp41_,_tmp44_);
  _tmp48_ = XOR(_tmp43_,_tmp47_);
  b__[5] = XOR(_tmp48_,_tmp51_);
  _tmp55_ = XOR(_tmp50_,_tmp54_);
  b__[6] = XOR(_tmp55_,_tmp58_);
  _tmp62_ = XOR(_tmp57_,_tmp1_);
  b__[7] = XOR(_tmp62_,_tmp65_);

}




int main() {

  __m128i a[8], b[8], c[8];//, d[8], e[8];
  //uint8_t x[16] = { 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
  //                  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
  //uint8_t x[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
  //                  0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
  uint8_t x[16] = { 0x63, 0x2F, 0xAF, 0xA2, 0xEB, 0x93, 0xC7, 0x20,
                    0x9F, 0x92, 0xAB, 0xCD, 0xA0, 0xC0, 0x30, 0x2B };
  //uint8_t x[16] = { 0x63, 0xC0, 0xAB, 0x20, 0xEB, 0x2F, 0x30, 0xCB,
  //                  0x9F, 0x93, 0xAF, 0x2B, 0xA0, 0x92, 0xC7, 0xA2 };
  
  for (int i = 0; i < 8; i++)
    a[i] = _mm_load_si128((__m128i*)x);

  /*
  puts("RL 64");
  v2RL64__(a[0],&b[0]);
  print128hex(a[0]);
  print128hex(b[0]);
  puts("RL 32");
  v2RL32__(a[1],&b[1]);
  print128hex(a[1]);
  print128hex(b[1]);
  */

  //for (int i = 0; i < 8; i++)
  //  print128hex(a[i]);
  
  load_bitslice(a,b);

  MixColumnns2__(b,c);
  
  load_bitslice(c,a);
  print128hex(a[0]);
  /*
  for (int i = 0; i < 8; i++)
    print128hex(a[i]);
  */
  
  /* load_bitslice(e,a); */
  /* puts(""); */
  /* for (int i = 0; i < 8; i++) */
  /*   print128hex(a[i]); */
  


  
  
  
  return 0;
}
