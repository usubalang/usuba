
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

#define NO_RUNTIME
#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif
/* including the architecture specific .h */
#include "STD.h"

void sbox__0__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r3 ^= r0;
  r4 = r1; 
  r1 &= r3;
  r4 ^= r2;
  r1 ^= r0;
  r0 |= r3;
  r0 ^= r4;
  r4 ^= r3;
  r3 ^= r2;
  r2 |= r1;
  r2 ^= r4;
  r4 = ~r4; 
  r4 |= r1;
  r1 ^= r3;
  r1 ^= r4;
  r3 |= r0;
  r1 ^= r3;
  r4 ^= r3;
  *r5 = r1;
  *r6 = r4;
  *r7 = r2;
  *r8 = r0;
}
void sbox__1__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r0 = ~r0;  
  r2 = ~r2;
  r4 = r0; 
  r0 &= r1;
  r2 ^= r0;
  r0 |= r3;
  r3 ^= r2;
  r1 ^= r0;
  r0 ^= r4;
  r4 |= r1;
  r1 ^= r3;
  r2 |= r0;
  r2 &= r4;
  r0 ^= r1;
  r1 &= r2;
  r1 ^= r0;
  r0 &= r2;
  r0 ^= r4;
  *r5 = r2;
  *r6 = r0;
  *r7 = r3;
  *r8 = r1;
}
void sbox__2__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r4 = r0;
  r0 &= r2; 
  r0 ^= r3; 
  r2 ^= r1; 
  r2 ^= r0; 
  r3 |= r4; 
  r3 ^= r1; 
  r4 ^= r2; 
  r1 = r3;  
  r3 |= r4; 
  r3 ^= r0; 
  r0 &= r1; 
  r4 ^= r0; 
  r1 ^= r3; 
  r1 ^= r4; 
  r4 = ~r4; 
  *r5 = r2;
  *r6 = r3;
  *r7 = r1;
  *r8 = r4;
}
void sbox__3__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r4 = r0; 
  r0 |= r3;
  r3 ^= r1;
  r1 &= r4;
  r4 ^= r2;
  r2 ^= r3;
  r3 &= r0;
  r4 |= r1;
  r3 ^= r4;
  r0 ^= r1;
  r4 &= r0;
  r1 ^= r3;
  r4 ^= r2;
  r1 |= r0;
  r1 ^= r2;
  r0 ^= r3;
  r2 = r1; 
  r1 |= r3;
  r1 ^= r0;
  *r5 = r1;
  *r6 = r2;
  *r7 = r3;
  *r8 = r4;
}
void sbox__4__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r1 ^= r3;
  r3 = ~r3;
  r2 ^= r3;
  r3 ^= r0;
  r4 = r1; 
  r1 &= r3;
  r1 ^= r2;
  r4 ^= r3;
  r0 ^= r4;
  r2 &= r4;
  r2 ^= r0;
  r0 &= r1;
  r3 ^= r0;
  r4 |= r1;
  r4 ^= r0;
  r0 |= r3;
  r0 ^= r2;
  r2 &= r3;
  r0 = ~r0;
  r4 ^= r2;
  *r5 = r1;
  *r6 = r4;
  *r7 = r0;
  *r8 = r3;
}
void sbox__5__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
   DATATYPE r4;
   r0 ^= r1;
   r1 ^= r3;
   r3 = ~r3;
   r4 = r1; 
   r1 &= r0;
   r2 ^= r3;
   r1 ^= r2;
   r2 |= r4;
   r4 ^= r3;
   r3 &= r1;
   r3 ^= r0;
   r4 ^= r1;
   r4 ^= r2;
   r2 ^= r0;
   r0 &= r3;
   r2 = ~r2;
   r0 ^= r4;
   r4 |= r3;
   r2 ^= r4;
  *r5 = r1;
  *r6 = r3;
  *r7 = r0;
  *r8 = r2;
}
void sbox__6__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
   DATATYPE r4;
   r2 = ~r2; 
   r4 = r3; 
   r3 &= r0;
   r0 ^= r4;
   r3 ^= r2;
   r2 |= r4;
   r1 ^= r3;
   r2 ^= r0;
   r0 |= r1;
   r2 ^= r1;
   r4 ^= r0;
   r0 |= r3;
   r0 ^= r2;
   r4 ^= r3;
   r4 ^= r0;
   r3 = ~r3;
   r2 &= r4;
   r2 ^= r3;
  *r5 = r0;
  *r6 = r1;
  *r7 = r4;
  *r8 = r2;
}
void sbox__7__(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r4 = r1;
  r1 |= r2;
  r1 ^= r3;
  r4 ^= r2;
  r2 ^= r1;
  r3 |= r4;
  r3 &= r0;
  r4 ^= r2;
  r3 ^= r1;
  r1 |= r4;
  r1 ^= r0;
  r0 |= r4;
  r0 ^= r2;
  r1 ^= r4;
  r2 ^= r1;
  r1 &= r0;
  r1 ^= r4;
  r2 = ~r2;
  r2 |= r0;
  r4 ^= r2;
  *r5 = r4;
  *r6 = r3;
  *r7 = r1;
  *r8 = r0;
}



void transform__ (/*inputs*/ DATATYPE input__[4], /*outputs*/ DATATYPE out__[4]) {
  
  // Variables declaration
  DATATYPE _tmp1_;
  DATATYPE _tmp2_;
  DATATYPE _tmp3_;
  DATATYPE _tmp4_;
  DATATYPE _tmp5_;
  DATATYPE _tmp6_;
  DATATYPE x0__[4];
  DATATYPE x1__[3];
  DATATYPE x2__[4];
  DATATYPE x3__[3];


  // Instructions (body)
  x0__[1] = L_ROTATE(input__[0],13,32);
  x2__[1] = L_ROTATE(input__[2],3,32);
  _tmp1_ = XOR(input__[1],x0__[1]);
  x1__[1] = XOR(_tmp1_,x2__[1]);
  _tmp2_ = XOR(input__[3],x2__[1]);
  _tmp3_ = L_SHIFT(x0__[1],3,32);
  x3__[1] = XOR(_tmp2_,_tmp3_);
  x1__[2] = L_ROTATE(x1__[1],1,32);
  x3__[2] = L_ROTATE(x3__[1],7,32);
  _tmp4_ = XOR(x0__[1],x1__[2]);
  x0__[2] = XOR(_tmp4_,x3__[2]);
  _tmp5_ = XOR(x2__[1],x3__[2]);
  _tmp6_ = L_SHIFT(x1__[2],7,32);
  x2__[2] = XOR(_tmp5_,_tmp6_);
  x0__[3] = L_ROTATE(x0__[2],5,32);
  x2__[3] = L_ROTATE(x2__[2],22,32);
  out__[0] = x0__[3];
  out__[1] = x1__[2];
  out__[2] = x2__[3];
  out__[3] = x3__[2];

}

/* main function */
void Serpent__ (/*inputs*/ DATATYPE plaintext__[4],DATATYPE keys__[33][4], /*outputs*/ DATATYPE ciphertext__[4]) {
  
  // Variables declaration
  DATATYPE _tmp10_[4];
  DATATYPE _tmp11_[4];
  DATATYPE _tmp12_[4];
  DATATYPE _tmp13_[4];
  DATATYPE _tmp14_[4];
  DATATYPE _tmp15_[4];
  DATATYPE _tmp16_[4];
  DATATYPE _tmp17_[4];
  DATATYPE _tmp18_[4];
  DATATYPE _tmp19_[4];
  DATATYPE _tmp20_[4];
  DATATYPE _tmp21_[4];
  DATATYPE _tmp22_[4];
  DATATYPE _tmp23_[4];
  DATATYPE _tmp24_[4];
  DATATYPE _tmp25_[4];
  DATATYPE _tmp26_[4];
  DATATYPE _tmp27_[4];
  DATATYPE _tmp28_[4];
  DATATYPE _tmp29_[4];
  DATATYPE _tmp30_[4];
  DATATYPE _tmp31_[4];
  DATATYPE _tmp32_[4];
  DATATYPE _tmp33_[4];
  DATATYPE _tmp34_[4];
  DATATYPE _tmp35_[4];
  DATATYPE _tmp36_[4];
  DATATYPE _tmp37_[4];
  DATATYPE _tmp38_[4];
  DATATYPE _tmp39_[4];
  DATATYPE _tmp40_[4];
  DATATYPE _tmp41_[4];
  DATATYPE _tmp42_[4];
  DATATYPE _tmp43_[4];
  DATATYPE _tmp44_[4];
  DATATYPE _tmp45_[4];
  DATATYPE _tmp46_[4];
  DATATYPE _tmp47_[4];
  DATATYPE _tmp48_[4];
  DATATYPE _tmp49_[4];
  DATATYPE _tmp50_[4];
  DATATYPE _tmp51_[4];
  DATATYPE _tmp52_[4];
  DATATYPE _tmp53_[4];
  DATATYPE _tmp54_[4];
  DATATYPE _tmp55_[4];
  DATATYPE _tmp56_[4];
  DATATYPE _tmp57_[4];
  DATATYPE _tmp58_[4];
  DATATYPE _tmp59_[4];
  DATATYPE _tmp60_[4];
  DATATYPE _tmp61_[4];
  DATATYPE _tmp62_[4];
  DATATYPE _tmp63_[4];
  DATATYPE _tmp64_[4];
  DATATYPE _tmp65_[4];
  DATATYPE _tmp66_[4];
  DATATYPE _tmp67_[4];
  DATATYPE _tmp68_[4];
  DATATYPE _tmp69_[4];
  DATATYPE _tmp70_[4];
  DATATYPE _tmp7_[4];
  DATATYPE _tmp8_[4];
  DATATYPE _tmp9_[4];
  DATATYPE tmp__[32][4];


  // Instructions (body)
  _tmp7_[0] = XOR(plaintext__[0],keys__[0][0]);
  _tmp7_[1] = XOR(plaintext__[1],keys__[0][1]);
  _tmp7_[2] = XOR(plaintext__[2],keys__[0][2]);
  _tmp7_[3] = XOR(plaintext__[3],keys__[0][3]);
  sbox__0__(_tmp7_[0],_tmp7_[1],_tmp7_[2],_tmp7_[3],&_tmp8_[0],&_tmp8_[1],&_tmp8_[2],&_tmp8_[3]);
  transform__(_tmp8_,tmp__[1]);
  _tmp9_[0] = XOR(tmp__[1][0],keys__[1][0]);
  _tmp9_[1] = XOR(tmp__[1][1],keys__[1][1]);
  _tmp9_[2] = XOR(tmp__[1][2],keys__[1][2]);
  _tmp9_[3] = XOR(tmp__[1][3],keys__[1][3]);
  sbox__1__(_tmp9_[0],_tmp9_[1],_tmp9_[2],_tmp9_[3],&_tmp10_[0],&_tmp10_[1],&_tmp10_[2],&_tmp10_[3]);
  transform__(_tmp10_,tmp__[2]);
  _tmp11_[0] = XOR(tmp__[2][0],keys__[2][0]);
  _tmp11_[1] = XOR(tmp__[2][1],keys__[2][1]);
  _tmp11_[2] = XOR(tmp__[2][2],keys__[2][2]);
  _tmp11_[3] = XOR(tmp__[2][3],keys__[2][3]);
  sbox__2__(_tmp11_[0],_tmp11_[1],_tmp11_[2],_tmp11_[3],&_tmp12_[0],&_tmp12_[1],&_tmp12_[2],&_tmp12_[3]);
  transform__(_tmp12_,tmp__[3]);
  _tmp13_[0] = XOR(tmp__[3][0],keys__[3][0]);
  _tmp13_[1] = XOR(tmp__[3][1],keys__[3][1]);
  _tmp13_[2] = XOR(tmp__[3][2],keys__[3][2]);
  _tmp13_[3] = XOR(tmp__[3][3],keys__[3][3]);
  sbox__3__(_tmp13_[0],_tmp13_[1],_tmp13_[2],_tmp13_[3],&_tmp14_[0],&_tmp14_[1],&_tmp14_[2],&_tmp14_[3]);
  transform__(_tmp14_,tmp__[4]);
  _tmp15_[0] = XOR(tmp__[4][0],keys__[4][0]);
  _tmp15_[1] = XOR(tmp__[4][1],keys__[4][1]);
  _tmp15_[2] = XOR(tmp__[4][2],keys__[4][2]);
  _tmp15_[3] = XOR(tmp__[4][3],keys__[4][3]);
  sbox__4__(_tmp15_[0],_tmp15_[1],_tmp15_[2],_tmp15_[3],&_tmp16_[0],&_tmp16_[1],&_tmp16_[2],&_tmp16_[3]);
  transform__(_tmp16_,tmp__[5]);
  _tmp17_[0] = XOR(tmp__[5][0],keys__[5][0]);
  _tmp17_[1] = XOR(tmp__[5][1],keys__[5][1]);
  _tmp17_[2] = XOR(tmp__[5][2],keys__[5][2]);
  _tmp17_[3] = XOR(tmp__[5][3],keys__[5][3]);
  sbox__5__(_tmp17_[0],_tmp17_[1],_tmp17_[2],_tmp17_[3],&_tmp18_[0],&_tmp18_[1],&_tmp18_[2],&_tmp18_[3]);
  transform__(_tmp18_,tmp__[6]);
  _tmp19_[0] = XOR(tmp__[6][0],keys__[6][0]);
  _tmp19_[1] = XOR(tmp__[6][1],keys__[6][1]);
  _tmp19_[2] = XOR(tmp__[6][2],keys__[6][2]);
  _tmp19_[3] = XOR(tmp__[6][3],keys__[6][3]);
  sbox__6__(_tmp19_[0],_tmp19_[1],_tmp19_[2],_tmp19_[3],&_tmp20_[0],&_tmp20_[1],&_tmp20_[2],&_tmp20_[3]);
  transform__(_tmp20_,tmp__[7]);
  _tmp21_[0] = XOR(tmp__[7][0],keys__[7][0]);
  _tmp21_[1] = XOR(tmp__[7][1],keys__[7][1]);
  _tmp21_[2] = XOR(tmp__[7][2],keys__[7][2]);
  _tmp21_[3] = XOR(tmp__[7][3],keys__[7][3]);
  sbox__7__(_tmp21_[0],_tmp21_[1],_tmp21_[2],_tmp21_[3],&_tmp22_[0],&_tmp22_[1],&_tmp22_[2],&_tmp22_[3]);
  transform__(_tmp22_,tmp__[8]);
  _tmp23_[0] = XOR(tmp__[8][0],keys__[8][0]);
  _tmp23_[1] = XOR(tmp__[8][1],keys__[8][1]);
  _tmp23_[2] = XOR(tmp__[8][2],keys__[8][2]);
  _tmp23_[3] = XOR(tmp__[8][3],keys__[8][3]);
  sbox__0__(_tmp23_[0],_tmp23_[1],_tmp23_[2],_tmp23_[3],&_tmp24_[0],&_tmp24_[1],&_tmp24_[2],&_tmp24_[3]);
  transform__(_tmp24_,tmp__[9]);
  _tmp25_[0] = XOR(tmp__[9][0],keys__[9][0]);
  _tmp25_[1] = XOR(tmp__[9][1],keys__[9][1]);
  _tmp25_[2] = XOR(tmp__[9][2],keys__[9][2]);
  _tmp25_[3] = XOR(tmp__[9][3],keys__[9][3]);
  sbox__1__(_tmp25_[0],_tmp25_[1],_tmp25_[2],_tmp25_[3],&_tmp26_[0],&_tmp26_[1],&_tmp26_[2],&_tmp26_[3]);
  transform__(_tmp26_,tmp__[10]);
  _tmp27_[0] = XOR(tmp__[10][0],keys__[10][0]);
  _tmp27_[1] = XOR(tmp__[10][1],keys__[10][1]);
  _tmp27_[2] = XOR(tmp__[10][2],keys__[10][2]);
  _tmp27_[3] = XOR(tmp__[10][3],keys__[10][3]);
  sbox__2__(_tmp27_[0],_tmp27_[1],_tmp27_[2],_tmp27_[3],&_tmp28_[0],&_tmp28_[1],&_tmp28_[2],&_tmp28_[3]);
  transform__(_tmp28_,tmp__[11]);
  _tmp29_[0] = XOR(tmp__[11][0],keys__[11][0]);
  _tmp29_[1] = XOR(tmp__[11][1],keys__[11][1]);
  _tmp29_[2] = XOR(tmp__[11][2],keys__[11][2]);
  _tmp29_[3] = XOR(tmp__[11][3],keys__[11][3]);
  sbox__3__(_tmp29_[0],_tmp29_[1],_tmp29_[2],_tmp29_[3],&_tmp30_[0],&_tmp30_[1],&_tmp30_[2],&_tmp30_[3]);
  transform__(_tmp30_,tmp__[12]);
  _tmp31_[0] = XOR(tmp__[12][0],keys__[12][0]);
  _tmp31_[1] = XOR(tmp__[12][1],keys__[12][1]);
  _tmp31_[2] = XOR(tmp__[12][2],keys__[12][2]);
  _tmp31_[3] = XOR(tmp__[12][3],keys__[12][3]);
  sbox__4__(_tmp31_[0],_tmp31_[1],_tmp31_[2],_tmp31_[3],&_tmp32_[0],&_tmp32_[1],&_tmp32_[2],&_tmp32_[3]);
  transform__(_tmp32_,tmp__[13]);
  _tmp33_[0] = XOR(tmp__[13][0],keys__[13][0]);
  _tmp33_[1] = XOR(tmp__[13][1],keys__[13][1]);
  _tmp33_[2] = XOR(tmp__[13][2],keys__[13][2]);
  _tmp33_[3] = XOR(tmp__[13][3],keys__[13][3]);
  sbox__5__(_tmp33_[0],_tmp33_[1],_tmp33_[2],_tmp33_[3],&_tmp34_[0],&_tmp34_[1],&_tmp34_[2],&_tmp34_[3]);
  transform__(_tmp34_,tmp__[14]);
  _tmp35_[0] = XOR(tmp__[14][0],keys__[14][0]);
  _tmp35_[1] = XOR(tmp__[14][1],keys__[14][1]);
  _tmp35_[2] = XOR(tmp__[14][2],keys__[14][2]);
  _tmp35_[3] = XOR(tmp__[14][3],keys__[14][3]);
  sbox__6__(_tmp35_[0],_tmp35_[1],_tmp35_[2],_tmp35_[3],&_tmp36_[0],&_tmp36_[1],&_tmp36_[2],&_tmp36_[3]);
  transform__(_tmp36_,tmp__[15]);
  _tmp37_[0] = XOR(tmp__[15][0],keys__[15][0]);
  _tmp37_[1] = XOR(tmp__[15][1],keys__[15][1]);
  _tmp37_[2] = XOR(tmp__[15][2],keys__[15][2]);
  _tmp37_[3] = XOR(tmp__[15][3],keys__[15][3]);
  sbox__7__(_tmp37_[0],_tmp37_[1],_tmp37_[2],_tmp37_[3],&_tmp38_[0],&_tmp38_[1],&_tmp38_[2],&_tmp38_[3]);
  transform__(_tmp38_,tmp__[16]);
  _tmp39_[0] = XOR(tmp__[16][0],keys__[16][0]);
  _tmp39_[1] = XOR(tmp__[16][1],keys__[16][1]);
  _tmp39_[2] = XOR(tmp__[16][2],keys__[16][2]);
  _tmp39_[3] = XOR(tmp__[16][3],keys__[16][3]);
  sbox__0__(_tmp39_[0],_tmp39_[1],_tmp39_[2],_tmp39_[3],&_tmp40_[0],&_tmp40_[1],&_tmp40_[2],&_tmp40_[3]);
  transform__(_tmp40_,tmp__[17]);
  _tmp41_[0] = XOR(tmp__[17][0],keys__[17][0]);
  _tmp41_[1] = XOR(tmp__[17][1],keys__[17][1]);
  _tmp41_[2] = XOR(tmp__[17][2],keys__[17][2]);
  _tmp41_[3] = XOR(tmp__[17][3],keys__[17][3]);
  sbox__1__(_tmp41_[0],_tmp41_[1],_tmp41_[2],_tmp41_[3],&_tmp42_[0],&_tmp42_[1],&_tmp42_[2],&_tmp42_[3]);
  transform__(_tmp42_,tmp__[18]);
  _tmp43_[0] = XOR(tmp__[18][0],keys__[18][0]);
  _tmp43_[1] = XOR(tmp__[18][1],keys__[18][1]);
  _tmp43_[2] = XOR(tmp__[18][2],keys__[18][2]);
  _tmp43_[3] = XOR(tmp__[18][3],keys__[18][3]);
  sbox__2__(_tmp43_[0],_tmp43_[1],_tmp43_[2],_tmp43_[3],&_tmp44_[0],&_tmp44_[1],&_tmp44_[2],&_tmp44_[3]);
  transform__(_tmp44_,tmp__[19]);
  _tmp45_[0] = XOR(tmp__[19][0],keys__[19][0]);
  _tmp45_[1] = XOR(tmp__[19][1],keys__[19][1]);
  _tmp45_[2] = XOR(tmp__[19][2],keys__[19][2]);
  _tmp45_[3] = XOR(tmp__[19][3],keys__[19][3]);
  sbox__3__(_tmp45_[0],_tmp45_[1],_tmp45_[2],_tmp45_[3],&_tmp46_[0],&_tmp46_[1],&_tmp46_[2],&_tmp46_[3]);
  transform__(_tmp46_,tmp__[20]);
  _tmp47_[0] = XOR(tmp__[20][0],keys__[20][0]);
  _tmp47_[1] = XOR(tmp__[20][1],keys__[20][1]);
  _tmp47_[2] = XOR(tmp__[20][2],keys__[20][2]);
  _tmp47_[3] = XOR(tmp__[20][3],keys__[20][3]);
  sbox__4__(_tmp47_[0],_tmp47_[1],_tmp47_[2],_tmp47_[3],&_tmp48_[0],&_tmp48_[1],&_tmp48_[2],&_tmp48_[3]);
  transform__(_tmp48_,tmp__[21]);
  _tmp49_[0] = XOR(tmp__[21][0],keys__[21][0]);
  _tmp49_[1] = XOR(tmp__[21][1],keys__[21][1]);
  _tmp49_[2] = XOR(tmp__[21][2],keys__[21][2]);
  _tmp49_[3] = XOR(tmp__[21][3],keys__[21][3]);
  sbox__5__(_tmp49_[0],_tmp49_[1],_tmp49_[2],_tmp49_[3],&_tmp50_[0],&_tmp50_[1],&_tmp50_[2],&_tmp50_[3]);
  transform__(_tmp50_,tmp__[22]);
  _tmp51_[0] = XOR(tmp__[22][0],keys__[22][0]);
  _tmp51_[1] = XOR(tmp__[22][1],keys__[22][1]);
  _tmp51_[2] = XOR(tmp__[22][2],keys__[22][2]);
  _tmp51_[3] = XOR(tmp__[22][3],keys__[22][3]);
  sbox__6__(_tmp51_[0],_tmp51_[1],_tmp51_[2],_tmp51_[3],&_tmp52_[0],&_tmp52_[1],&_tmp52_[2],&_tmp52_[3]);
  transform__(_tmp52_,tmp__[23]);
  _tmp53_[0] = XOR(tmp__[23][0],keys__[23][0]);
  _tmp53_[1] = XOR(tmp__[23][1],keys__[23][1]);
  _tmp53_[2] = XOR(tmp__[23][2],keys__[23][2]);
  _tmp53_[3] = XOR(tmp__[23][3],keys__[23][3]);
  sbox__7__(_tmp53_[0],_tmp53_[1],_tmp53_[2],_tmp53_[3],&_tmp54_[0],&_tmp54_[1],&_tmp54_[2],&_tmp54_[3]);
  transform__(_tmp54_,tmp__[24]);
  _tmp55_[0] = XOR(tmp__[24][0],keys__[24][0]);
  _tmp55_[1] = XOR(tmp__[24][1],keys__[24][1]);
  _tmp55_[2] = XOR(tmp__[24][2],keys__[24][2]);
  _tmp55_[3] = XOR(tmp__[24][3],keys__[24][3]);
  sbox__0__(_tmp55_[0],_tmp55_[1],_tmp55_[2],_tmp55_[3],&_tmp56_[0],&_tmp56_[1],&_tmp56_[2],&_tmp56_[3]);
  transform__(_tmp56_,tmp__[25]);
  _tmp57_[0] = XOR(tmp__[25][0],keys__[25][0]);
  _tmp57_[1] = XOR(tmp__[25][1],keys__[25][1]);
  _tmp57_[2] = XOR(tmp__[25][2],keys__[25][2]);
  _tmp57_[3] = XOR(tmp__[25][3],keys__[25][3]);
  sbox__1__(_tmp57_[0],_tmp57_[1],_tmp57_[2],_tmp57_[3],&_tmp58_[0],&_tmp58_[1],&_tmp58_[2],&_tmp58_[3]);
  transform__(_tmp58_,tmp__[26]);
  _tmp59_[0] = XOR(tmp__[26][0],keys__[26][0]);
  _tmp59_[1] = XOR(tmp__[26][1],keys__[26][1]);
  _tmp59_[2] = XOR(tmp__[26][2],keys__[26][2]);
  _tmp59_[3] = XOR(tmp__[26][3],keys__[26][3]);
  sbox__2__(_tmp59_[0],_tmp59_[1],_tmp59_[2],_tmp59_[3],&_tmp60_[0],&_tmp60_[1],&_tmp60_[2],&_tmp60_[3]);
  transform__(_tmp60_,tmp__[27]);
  _tmp61_[0] = XOR(tmp__[27][0],keys__[27][0]);
  _tmp61_[1] = XOR(tmp__[27][1],keys__[27][1]);
  _tmp61_[2] = XOR(tmp__[27][2],keys__[27][2]);
  _tmp61_[3] = XOR(tmp__[27][3],keys__[27][3]);
  sbox__3__(_tmp61_[0],_tmp61_[1],_tmp61_[2],_tmp61_[3],&_tmp62_[0],&_tmp62_[1],&_tmp62_[2],&_tmp62_[3]);
  transform__(_tmp62_,tmp__[28]);
  _tmp63_[0] = XOR(tmp__[28][0],keys__[28][0]);
  _tmp63_[1] = XOR(tmp__[28][1],keys__[28][1]);
  _tmp63_[2] = XOR(tmp__[28][2],keys__[28][2]);
  _tmp63_[3] = XOR(tmp__[28][3],keys__[28][3]);
  sbox__4__(_tmp63_[0],_tmp63_[1],_tmp63_[2],_tmp63_[3],&_tmp64_[0],&_tmp64_[1],&_tmp64_[2],&_tmp64_[3]);
  transform__(_tmp64_,tmp__[29]);
  _tmp65_[0] = XOR(tmp__[29][0],keys__[29][0]);
  _tmp65_[1] = XOR(tmp__[29][1],keys__[29][1]);
  _tmp65_[2] = XOR(tmp__[29][2],keys__[29][2]);
  _tmp65_[3] = XOR(tmp__[29][3],keys__[29][3]);
  sbox__5__(_tmp65_[0],_tmp65_[1],_tmp65_[2],_tmp65_[3],&_tmp66_[0],&_tmp66_[1],&_tmp66_[2],&_tmp66_[3]);
  transform__(_tmp66_,tmp__[30]);
  _tmp67_[0] = XOR(tmp__[30][0],keys__[30][0]);
  _tmp67_[1] = XOR(tmp__[30][1],keys__[30][1]);
  _tmp67_[2] = XOR(tmp__[30][2],keys__[30][2]);
  _tmp67_[3] = XOR(tmp__[30][3],keys__[30][3]);
  sbox__6__(_tmp67_[0],_tmp67_[1],_tmp67_[2],_tmp67_[3],&_tmp68_[0],&_tmp68_[1],&_tmp68_[2],&_tmp68_[3]);
  transform__(_tmp68_,tmp__[31]);
  _tmp69_[0] = XOR(tmp__[31][0],keys__[31][0]);
  _tmp69_[1] = XOR(tmp__[31][1],keys__[31][1]);
  _tmp69_[2] = XOR(tmp__[31][2],keys__[31][2]);
  _tmp69_[3] = XOR(tmp__[31][3],keys__[31][3]);
  sbox__7__(_tmp69_[0],_tmp69_[1],_tmp69_[2],_tmp69_[3],&_tmp70_[0],&_tmp70_[1],&_tmp70_[2],&_tmp70_[3]);
  ciphertext__[0] = XOR(_tmp70_[0],keys__[32][0]);
  ciphertext__[1] = XOR(_tmp70_[1],keys__[32][1]);
  ciphertext__[2] = XOR(_tmp70_[2],keys__[32][2]);
  ciphertext__[3] = XOR(_tmp70_[3],keys__[32][3]);

}
 
