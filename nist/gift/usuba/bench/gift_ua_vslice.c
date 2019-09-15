/* This code was generated by Usuba.
   See https://github.com/DadaIsCrazy/usuba.
   From the file "nist/gift/usuba/ua/gift.ua" (included below). */

#include <stdint.h>

/* Do NOT change the order of those define/include */

#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif
/* including the architecture specific .h */
#include "STD.h"

/* auxiliary functions */
void SubCells__V32 (/*inputs*/ DATATYPE S0__,DATATYPE S1__,DATATYPE S2__,DATATYPE S3__, /*outputs*/ DATATYPE S____[4]) {

  // Variables declaration
  DATATYPE _shadow_S0__2_;
  DATATYPE _shadow_S1__1_;
  DATATYPE _shadow_S1__5_;
  DATATYPE _shadow_S2__3_;
  DATATYPE _shadow_S2__7_;
  DATATYPE _shadow_S3__4_;
  DATATYPE _shadow_S3__6_;
  DATATYPE _tmp1_;
  DATATYPE _tmp2_;
  DATATYPE _tmp3_;
  DATATYPE _tmp4_;

  // Instructions (body)
  _tmp1_ = AND(S0__,S2__);
  _shadow_S1__1_ = XOR(S1__,_tmp1_);
  _tmp2_ = AND(_shadow_S1__1_,S3__);
  _shadow_S0__2_ = XOR(S0__,_tmp2_);
  _tmp3_ = OR(_shadow_S0__2_,_shadow_S1__1_);
  _shadow_S2__3_ = XOR(S2__,_tmp3_);
  _shadow_S3__4_ = XOR(S3__,_shadow_S2__3_);
  _shadow_S1__5_ = XOR(_shadow_S1__1_,_shadow_S3__4_);
  _shadow_S3__6_ = NOT(_shadow_S3__4_);
  _tmp4_ = AND(_shadow_S0__2_,_shadow_S1__5_);
  _shadow_S2__7_ = XOR(_shadow_S2__3_,_tmp4_);
  S____[0] = _shadow_S3__6_;
  S____[1] = _shadow_S1__5_;
  S____[2] = _shadow_S2__7_;
  S____[3] = _shadow_S0__2_;

}

void rowperm__V_Natnat_32 (/*inputs*/ DATATYPE S__,int B0_pos__,int B1_pos__,int B2_pos__,int B3_pos__, /*outputs*/ DATATYPE* S____) {

  // Variables declaration
  DATATYPE T__;
  DATATYPE _tmp10_;
  DATATYPE _tmp12_;
  DATATYPE _tmp13_;
  DATATYPE _tmp14_;
  DATATYPE _tmp15_;
  DATATYPE _tmp17_;
  DATATYPE _tmp18_;
  DATATYPE _tmp19_;
  DATATYPE _tmp20_;
  DATATYPE _tmp22_;
  DATATYPE _tmp23_;
  DATATYPE _tmp5_;
  DATATYPE _tmp7_;
  DATATYPE _tmp8_;
  DATATYPE _tmp9_;
  DATATYPE _tmp99_;
  DATATYPE _tmp98_;
  DATATYPE _tmp97_;
  DATATYPE _tmp96_;

  // Instructions (body)
  T__ = LIFT_32(0);
  for (int b__ = 0; b__ <= 7; b__++) {
    _tmp5_ = R_SHIFT(S__,((4 * b__) + 0),32);
    _tmp96_ = LIFT_32(1);
    _tmp7_ = AND(_tmp5_,_tmp96_);
    _tmp8_ = L_SHIFT(_tmp7_,(b__ + (8 * B0_pos__)),32);
    _tmp9_ = XOR(T__,_tmp8_);
    _tmp10_ = R_SHIFT(S__,((4 * b__) + 1),32);
    _tmp97_ = LIFT_32(1);
    _tmp12_ = AND(_tmp10_,_tmp97_);
    _tmp13_ = L_SHIFT(_tmp12_,(b__ + (8 * B1_pos__)),32);
    _tmp14_ = XOR(_tmp9_,_tmp13_);
    _tmp15_ = R_SHIFT(S__,((4 * b__) + 2),32);
    _tmp98_ = LIFT_32(1);
    _tmp17_ = AND(_tmp15_,_tmp98_);
    _tmp18_ = L_SHIFT(_tmp17_,(b__ + (8 * B2_pos__)),32);
    _tmp19_ = XOR(_tmp14_,_tmp18_);
    _tmp20_ = R_SHIFT(S__,((4 * b__) + 3),32);
    _tmp99_ = LIFT_32(1);
    _tmp22_ = AND(_tmp20_,_tmp99_);
    _tmp23_ = L_SHIFT(_tmp22_,(b__ + (8 * B3_pos__)),32);
    T__ = XOR(_tmp19_,_tmp23_);
  }
  *S____ = T__;

}

void PermBits__V32 (/*inputs*/ DATATYPE S__[4], /*outputs*/ DATATYPE S____[4]) {

  // Variables declaration
  int _tmp115_;
  int _tmp114_;
  int _tmp113_;
  int _tmp112_;
  int _tmp111_;
  int _tmp110_;
  int _tmp109_;
  int _tmp108_;
  int _tmp107_;
  int _tmp106_;
  int _tmp105_;
  int _tmp104_;
  int _tmp103_;
  int _tmp102_;
  int _tmp101_;
  int _tmp100_;

  // Instructions (body)
  _tmp100_ = 0;
  _tmp101_ = 3;
  _tmp102_ = 2;
  _tmp103_ = 1;
  rowperm__V_Natnat_32(S__[0],_tmp100_,_tmp101_,_tmp102_,_tmp103_,&S____[0]);
  _tmp104_ = 1;
  _tmp105_ = 0;
  _tmp106_ = 3;
  _tmp107_ = 2;
  rowperm__V_Natnat_32(S__[1],_tmp104_,_tmp105_,_tmp106_,_tmp107_,&S____[1]);
  _tmp108_ = 2;
  _tmp109_ = 1;
  _tmp110_ = 0;
  _tmp111_ = 3;
  rowperm__V_Natnat_32(S__[2],_tmp108_,_tmp109_,_tmp110_,_tmp111_,&S____[2]);
  _tmp112_ = 3;
  _tmp113_ = 2;
  _tmp114_ = 1;
  _tmp115_ = 0;
  rowperm__V_Natnat_32(S__[3],_tmp112_,_tmp113_,_tmp114_,_tmp115_,&S____[3]);

}

void AddRoundKey__V32 (/*inputs*/ DATATYPE S__[4],DATATYPE W__[8],DATATYPE rc__, /*outputs*/ DATATYPE S____[4]) {

  // Variables declaration
  DATATYPE _tmp40_;
  DATATYPE _tmp41_;
  DATATYPE _tmp42_;
  DATATYPE _tmp43_;
  DATATYPE _tmp45_;
  DATATYPE _tmp116_;

  // Instructions (body)
  _tmp40_ = L_SHIFT(W__[2],16,32);
  _tmp41_ = XOR(_tmp40_,W__[3]);
  S____[2] = XOR(S__[2],_tmp41_);
  _tmp42_ = L_SHIFT(W__[6],16,32);
  _tmp43_ = XOR(_tmp42_,W__[7]);
  S____[1] = XOR(S__[1],_tmp43_);
  _tmp116_ = LIFT_32(2147483648);
  _tmp45_ = XOR(S__[3],_tmp116_);
  S____[3] = XOR(_tmp45_,rc__);
  S____[0] = S__[0];

}

void KeyUpdate__V32 (/*inputs*/ DATATYPE W__[8], /*outputs*/ DATATYPE W____[8]) {

  // Variables declaration
  DATATYPE _tmp46_;
  DATATYPE _tmp47_;
  DATATYPE _tmp48_;
  DATATYPE _tmp50_;
  DATATYPE _tmp51_;
  DATATYPE _tmp52_;
  DATATYPE _tmp118_;
  DATATYPE _tmp117_;

  // Instructions (body)
  _tmp46_ = R_SHIFT(W__[6],2,32);
  _tmp47_ = L_SHIFT(W__[6],14,32);
  _tmp48_ = XOR(_tmp46_,_tmp47_);
  _tmp117_ = LIFT_32(65535);
  W____[0] = AND(_tmp48_,_tmp117_);
  _tmp50_ = R_SHIFT(W__[7],12,32);
  _tmp51_ = L_SHIFT(W__[7],4,32);
  _tmp52_ = XOR(_tmp50_,_tmp51_);
  _tmp118_ = LIFT_32(65535);
  W____[1] = AND(_tmp52_,_tmp118_);
  W____[7] = W__[5];
  W____[6] = W__[4];
  W____[5] = W__[3];
  W____[4] = W__[2];
  W____[3] = W__[1];
  W____[2] = W__[0];

}

/* main function */
void gift__ (/*inputs*/ DATATYPE P__[4],DATATYPE K__[8], /*outputs*/ DATATYPE C__[4]) {

  // Variables declaration
  DATATYPE GIFT_RC__[40];
  DATATYPE W__[41][8];
  DATATYPE _tmp94_[4];
  DATATYPE _tmp95_[4];
  DATATYPE round__[4];

  // Instructions (body)
  round__[0] = P__[0];
  round__[1] = P__[1];
  round__[2] = P__[2];
  round__[3] = P__[3];
  W__[0][0] = K__[0];
  W__[0][1] = K__[1];
  W__[0][2] = K__[2];
  W__[0][3] = K__[3];
  W__[0][4] = K__[4];
  W__[0][5] = K__[5];
  W__[0][6] = K__[6];
  W__[0][7] = K__[7];
  GIFT_RC__[0] = LIFT_32(1);
  GIFT_RC__[1] = LIFT_32(3);
  GIFT_RC__[2] = LIFT_32(7);
  GIFT_RC__[3] = LIFT_32(15);
  GIFT_RC__[4] = LIFT_32(31);
  GIFT_RC__[5] = LIFT_32(62);
  GIFT_RC__[6] = LIFT_32(61);
  GIFT_RC__[7] = LIFT_32(59);
  GIFT_RC__[8] = LIFT_32(55);
  GIFT_RC__[9] = LIFT_32(47);
  GIFT_RC__[10] = LIFT_32(30);
  GIFT_RC__[11] = LIFT_32(60);
  GIFT_RC__[12] = LIFT_32(57);
  GIFT_RC__[13] = LIFT_32(51);
  GIFT_RC__[14] = LIFT_32(39);
  GIFT_RC__[15] = LIFT_32(14);
  GIFT_RC__[16] = LIFT_32(29);
  GIFT_RC__[17] = LIFT_32(58);
  GIFT_RC__[18] = LIFT_32(53);
  GIFT_RC__[19] = LIFT_32(43);
  GIFT_RC__[20] = LIFT_32(22);
  GIFT_RC__[21] = LIFT_32(44);
  GIFT_RC__[22] = LIFT_32(24);
  GIFT_RC__[23] = LIFT_32(48);
  GIFT_RC__[24] = LIFT_32(33);
  GIFT_RC__[25] = LIFT_32(2);
  GIFT_RC__[26] = LIFT_32(5);
  GIFT_RC__[27] = LIFT_32(11);
  GIFT_RC__[28] = LIFT_32(23);
  GIFT_RC__[29] = LIFT_32(46);
  GIFT_RC__[30] = LIFT_32(28);
  GIFT_RC__[31] = LIFT_32(56);
  GIFT_RC__[32] = LIFT_32(49);
  GIFT_RC__[33] = LIFT_32(35);
  GIFT_RC__[34] = LIFT_32(6);
  GIFT_RC__[35] = LIFT_32(13);
  GIFT_RC__[36] = LIFT_32(27);
  GIFT_RC__[37] = LIFT_32(54);
  GIFT_RC__[38] = LIFT_32(45);
  GIFT_RC__[39] = LIFT_32(26);
  for (int i__ = 0; i__ <= 39; i__++) {
    SubCells__V32(round__[0],round__[1],round__[2],round__[3],_tmp94_);
    PermBits__V32(_tmp94_,_tmp95_);
    AddRoundKey__V32(_tmp95_,W__[i__],GIFT_RC__[i__],round__);
    KeyUpdate__V32(W__[i__],W__[(i__ + 1)]);
  }
  C__[0] = round__[0];
  C__[1] = round__[1];
  C__[2] = round__[2];
  C__[3] = round__[3];

}

/* Additional functions */
uint32_t bench_speed() {
  /* inputs */
  DATATYPE P__[4] = { 0 };
  DATATYPE K__[8] = { 0 };
  /* outputs */
  DATATYPE C__[4] = { 0 };
  /* fun call */
  gift__(P__, K__,C__);

  /* Returning the number of encrypted bytes */
  return 16;
}

/* **************************************************************** */
/*                            Usuba source                          */
/*                                                                  */
/*

 node SubCells(S0 :  v1 :: base,S1 :  v1 :: base,S2 :  v1 :: base,S3 :  v1 :: base)
  returns S' :  v4 :: base
vars

let
  (S1) := (S1 ^ (S0 & S2));
  (S0) := (S0 ^ (S1 & S3));
  (S2) := (S2 ^ (S0 | S1));
  (S3) := (S3 ^ S2);
  (S1) := (S1 ^ S3);
  (S3) := (~ S3);
  (S2) := (S2 ^ (S0 & S1));
  (S') = (S3,S1,S2,S0)
tel

 node rowperm(S :  u32 :: base,B0_pos :  nat :: base,B1_pos :  nat :: base,B2_pos :  nat :: base,B3_pos :  nat :: base)
  returns S' :  u32 :: base
vars
  T :  u32[9] :: base
let
  (T[0]) = 0;
  forall b in [0,7] {
    (T[(b + 1)]) = ((((T[b] ^ (((S >> ((4 * b) + 0)) & 1) << (b + (8 * B0_pos)))) ^ (((S >> ((4 * b) + 1)) & 1) << (b + (8 * B1_pos)))) ^ (((S >> ((4 * b) + 2)) & 1) << (b + (8 * B2_pos)))) ^ (((S >> ((4 * b) + 3)) & 1) << (b + (8 * B3_pos))))
  };
  (S') = T[8]
tel

 node PermBits(S :  u32x4 :: base)
  returns S' :  u32x4 :: base
vars

let
  (S'[0]) = rowperm(S[0],0,3,2,1);
  (S'[1]) = rowperm(S[1],1,0,3,2);
  (S'[2]) = rowperm(S[2],2,1,0,3);
  (S'[3]) = rowperm(S[3],3,2,1,0)
tel

 node AddRoundKey(S :  u32x4 :: base,W :  u32[8] :: base,rc :  u32 :: base)
  returns S' :  u32x4 :: base
vars

let
  (S'[2]) = (S[2] ^ ((W[2] << 16) ^ W[3]));
  (S'[1]) = (S[1] ^ ((W[6] << 16) ^ W[7]));
  (S'[3]) = ((S[3] ^ 2147483648) ^ rc);
  (S'[0]) = S[0]
tel

 node KeyUpdate(W :  u32[8] :: base)
  returns W' :  u32[8] :: base
vars

let
  (W'[0]) = (((W[6] >> 2) ^ (W[6] << 14)) & 65535);
  (W'[1]) = (((W[7] >> 12) ^ (W[7] << 4)) & 65535);
  (W'[7 .. 2]) = W[5 .. 0]
tel

 node gift(P :  u32x4 :: base,K : const u32[8] :: base)
  returns C :  u32x4 :: base
vars
  round :  u32x4[41] :: base,
  W :  u32[41][8] :: base,
  GIFT_RC :  u32[40] :: base
let
  (round[0]) = P;
  (W[0]) = K;
  (GIFT_RC) = (1,3,7,15,31,62,61,59,55,47,30,60,57,51,39,14,29,58,53,43,22,44,24,48,33,2,5,11,23,46,28,56,49,35,6,13,27,54,45,26);
  forall i in [0,39] {
    (round[(i + 1)]) = AddRoundKey(PermBits(SubCells(round[i])),W[i],GIFT_RC[i]);
    (W[(i + 1)]) = KeyUpdate(W[i])
  };
  (C) = round[40]
tel

*/
 