// Should print 63C0AB20EB2F30CB9F93AF2BA092C732

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
#define ZERO _mm_setzero_si128()
#define ONES _mm_set1_epi32(-1)
#define AND(a,b)  _mm_and_si128(a,b)
#define OR(a,b)   _mm_or_si128(a,b)
#define XOR(a,b)  _mm_xor_si128(a,b)
#define ANDN(a,b) _mm_andnot_si128(a,b)
#define NOT(a)    _mm_andnot_si128(a,ONES)
#define PERMUT_16(a,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16) \
  _mm_shuffle_epi8(a,_mm_set_epi8(x16,x15,x14,x13,x12,x11,x10,x9,x8,x7,x6,x5,x4,x3,x2,x1))

/* auxiliary functions */
void SubBytes_single__ (/*inputs*/ DATATYPE U0,DATATYPE U1,DATATYPE U2,DATATYPE U3,DATATYPE U4,DATATYPE U5,DATATYPE U6,DATATYPE U7, /*outputs*/ DATATYPE* S0,DATATYPE* S1,DATATYPE* S2,DATATYPE* S3,DATATYPE* S4,DATATYPE* S5,DATATYPE* S6,DATATYPE* S7) {
  
  // Variables declaration
  DATATYPE _tmp1_;
  DATATYPE _tmp2_;
  DATATYPE _tmp3_;
  DATATYPE _tmp4_;
  DATATYPE t0;
  DATATYPE t1;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t16;
  DATATYPE t17;
  DATATYPE t18;
  DATATYPE t19;
  DATATYPE t2;
  DATATYPE t20;
  DATATYPE t21;
  DATATYPE t22;
  DATATYPE t23;
  DATATYPE t24;
  DATATYPE t25;
  DATATYPE t26;
  DATATYPE t27;
  DATATYPE t28;
  DATATYPE t29;
  DATATYPE t3;
  DATATYPE t30;
  DATATYPE t31;
  DATATYPE t32;
  DATATYPE t33;
  DATATYPE t34;
  DATATYPE t35;
  DATATYPE t36;
  DATATYPE t37;
  DATATYPE t38;
  DATATYPE t39;
  DATATYPE t4;
  DATATYPE t40;
  DATATYPE t41;
  DATATYPE t42;
  DATATYPE t43;
  DATATYPE t44;
  DATATYPE t45;
  DATATYPE t5;
  DATATYPE t6;
  DATATYPE t7;
  DATATYPE t8;
  DATATYPE t9;
  DATATYPE tc1;
  DATATYPE tc10;
  DATATYPE tc11;
  DATATYPE tc12;
  DATATYPE tc13;
  DATATYPE tc14;
  DATATYPE tc16;
  DATATYPE tc17;
  DATATYPE tc18;
  DATATYPE tc2;
  DATATYPE tc20;
  DATATYPE tc21;
  DATATYPE tc26;
  DATATYPE tc3;
  DATATYPE tc4;
  DATATYPE tc5;
  DATATYPE tc6;
  DATATYPE tc7;
  DATATYPE tc8;
  DATATYPE tc9;
  DATATYPE y1;
  DATATYPE y10;
  DATATYPE y11;
  DATATYPE y12;
  DATATYPE y13;
  DATATYPE y14;
  DATATYPE y15;
  DATATYPE y16;
  DATATYPE y17;
  DATATYPE y18;
  DATATYPE y19;
  DATATYPE y2;
  DATATYPE y20;
  DATATYPE y21;
  DATATYPE y3;
  DATATYPE y4;
  DATATYPE y5;
  DATATYPE y6;
  DATATYPE y7;
  DATATYPE y8;
  DATATYPE y9;
  DATATYPE z0;
  DATATYPE z1;
  DATATYPE z10;
  DATATYPE z11;
  DATATYPE z12;
  DATATYPE z13;
  DATATYPE z14;
  DATATYPE z15;
  DATATYPE z16;
  DATATYPE z17;
  DATATYPE z2;
  DATATYPE z3;
  DATATYPE z4;
  DATATYPE z5;
  DATATYPE z6;
  DATATYPE z7;
  DATATYPE z8;
  DATATYPE z9;


  // Instructions (body)
  y14 = XOR(U3,U5);
  y13 = XOR(U0,U6);
  y9 = XOR(U0,U3);
  y8 = XOR(U0,U5);
  t0 = XOR(U1,U2);
  y1 = XOR(t0,U7);
  y4 = XOR(y1,U3);
  y12 = XOR(y13,y14);
  y2 = XOR(y1,U0);
  y5 = XOR(y1,U6);
  y3 = XOR(y5,y8);
  t1 = XOR(U4,y12);
  y15 = XOR(t1,U5);
  y20 = XOR(t1,U1);
  y6 = XOR(y15,U7);
  y10 = XOR(y15,t0);
  y11 = XOR(y20,y9);
  y7 = XOR(U7,y11);
  y17 = XOR(y10,y11);
  y19 = XOR(y10,y8);
  y16 = XOR(t0,y11);
  y21 = XOR(y13,y16);
  y18 = XOR(U0,y16);
  t2 = AND(y12,y15);
  t3 = AND(y3,y6);
  t4 = XOR(t3,t2);
  t5 = AND(y4,U7);
  t6 = XOR(t5,t2);
  t7 = AND(y13,y16);
  t8 = AND(y5,y1);
  t9 = XOR(t8,t7);
  t10 = AND(y2,y7);
  t11 = XOR(t10,t7);
  t12 = AND(y9,y11);
  t13 = AND(y14,y17);
  t14 = XOR(t13,t12);
  t15 = AND(y8,y10);
  t16 = XOR(t15,t12);
  t17 = XOR(t4,y20);
  t18 = XOR(t6,t16);
  t19 = XOR(t9,t14);
  t20 = XOR(t11,t16);
  t21 = XOR(t17,t14);
  t22 = XOR(t18,y19);
  t23 = XOR(t19,y21);
  t24 = XOR(t20,y18);
  t25 = XOR(t21,t22);
  t26 = AND(t21,t23);
  t27 = XOR(t24,t26);
  t28 = AND(t25,t27);
  t29 = XOR(t28,t22);
  t30 = XOR(t23,t24);
  t31 = XOR(t22,t26);
  t32 = AND(t31,t30);
  t33 = XOR(t32,t24);
  t34 = XOR(t23,t33);
  t35 = XOR(t27,t33);
  t36 = AND(t24,t35);
  t37 = XOR(t36,t34);
  t38 = XOR(t27,t36);
  t39 = AND(t29,t38);
  t40 = XOR(t25,t39);
  t41 = XOR(t40,t37);
  t42 = XOR(t29,t33);
  t43 = XOR(t29,t40);
  t44 = XOR(t33,t37);
  t45 = XOR(t42,t41);
  z0 = AND(t44,y15);
  z1 = AND(t37,y6);
  z2 = AND(t33,U7);
  z3 = AND(t43,y16);
  z4 = AND(t40,y1);
  z5 = AND(t29,y7);
  z6 = AND(t42,y11);
  z7 = AND(t45,y17);
  z8 = AND(t41,y10);
  z9 = AND(t44,y12);
  z10 = AND(t37,y3);
  z11 = AND(t33,y4);
  z12 = AND(t43,y13);
  z13 = AND(t40,y5);
  z14 = AND(t29,y2);
  z15 = AND(t42,y9);
  z16 = AND(t45,y14);
  z17 = AND(t41,y8);
  tc1 = XOR(z15,z16);
  tc2 = XOR(z10,tc1);
  tc3 = XOR(z9,tc2);
  tc4 = XOR(z0,z2);
  tc5 = XOR(z1,z0);
  tc6 = XOR(z3,z4);
  tc7 = XOR(z12,tc4);
  tc8 = XOR(z7,tc6);
  tc9 = XOR(z8,tc7);
  tc10 = XOR(tc8,tc9);
  tc11 = XOR(tc6,tc5);
  tc12 = XOR(z3,z5);
  tc13 = XOR(z13,tc1);
  tc14 = XOR(tc4,tc12);
  *S3 = XOR(tc3,tc11);
  tc16 = XOR(z6,tc8);
  tc17 = XOR(z14,tc10);
  tc18 = XOR(tc13,tc14);
  _tmp1_ = XOR(z12,tc18);
  *S7 = NOT(_tmp1_);
  tc20 = XOR(z15,tc16);
  tc21 = XOR(tc2,z11);
  *S0 = XOR(tc3,tc16);
  _tmp2_ = XOR(tc10,tc18);
  *S6 = NOT(_tmp2_);
  *S4 = XOR(tc14,*S3);
  _tmp3_ = XOR(*S3,tc16);
  *S1 = NOT(_tmp3_);
  tc26 = XOR(tc17,tc20);
  _tmp4_ = XOR(tc26,z17);
  *S2 = NOT(_tmp4_);
  *S5 = XOR(tc21,tc17);

}

/* main function */
void SubBytes__ (/*inputs*/ DATATYPE inputSB__[8], /*outputs*/ DATATYPE out__[8]) {
  // Instructions (body)
  SubBytes_single__(inputSB__[0],inputSB__[1],inputSB__[2],inputSB__[3],inputSB__[4],inputSB__[5],inputSB__[6],inputSB__[7],&out__[0],&out__[1],&out__[2],&out__[3],&out__[4],&out__[5],&out__[6],&out__[7]);

}

int main() {

  __m128i a[8], b[8];
  //uint8_t x[16] = { 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF,
  //                  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
  //uint8_t x[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
  //                  0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
  uint8_t x[16] = { 0x00, 0x1F, 0x0E, 0x54, 0x3C, 0x4E, 0x08, 0x59,
                    0x6E, 0x22, 0x1B, 0x0B, 0x47, 0x74, 0x31, 0xA1 };
  for (int i = 0; i < 8; i++)
    a[i] = _mm_load_si128((__m128i*)x);
  

  for (int i = 0; i < 8; i++)
    print128hex(a[i]);
  load_bitslice(a,b);


  SubBytes__(b,b);
  
  
  load_bitslice(b,a);
  puts("");
  for (int i = 0; i < 8; i++)
    print128hex(a[i]);

  
  
  
  return 0;
}
