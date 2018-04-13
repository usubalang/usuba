
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

#define NO_RUNTIME
#ifndef BITS_PER_REG
#define BITS_PER_REG 64
#endif
/* including the architecture specific .h */
#include "SSE.h"

/* auxiliary functions */
void sbox__0__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t17;


  // Instructions (body)
  t01 = XOR(b,c);
  t02 = OR(a,d);
  t03 = XOR(a,b);
  *z = XOR(t02,t01);
  t05 = OR(c,*z);
  t06 = XOR(a,d);
  t07 = OR(b,c);
  t08 = AND(d,t05);
  t09 = AND(t03,t07);
  *y = XOR(t09,t08);
  t11 = AND(t09,*y);
  t12 = XOR(c,d);
  t13 = XOR(t07,t11);
  t14 = AND(b,t06);
  t15 = XOR(t06,t13);
  *w = NOT(t15);
  t17 = XOR(*w,t14);
  *x = XOR(t12,t17);

}

void sbox__1__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t16;
  DATATYPE t17;


  // Instructions (body)
  t01 = OR(a,d);
  t02 = XOR(c,d);
  t03 = NOT(b);
  t04 = XOR(a,c);
  t05 = OR(a,t03);
  t06 = AND(d,t04);
  t07 = AND(t01,t02);
  t08 = OR(b,t06);
  *y = XOR(t02,t05);
  t10 = XOR(t07,t08);
  t11 = XOR(t01,t10);
  t12 = XOR(*y,t11);
  t13 = AND(b,d);
  *z = NOT(t10);
  *x = XOR(t13,t12);
  t16 = OR(t10,*x);
  t17 = AND(t05,t16);
  *w = XOR(c,t17);

}

void sbox__2__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;


  // Instructions (body)
  t01 = OR(a,c);
  t02 = XOR(a,b);
  t03 = XOR(d,t01);
  *w = XOR(t02,t03);
  t05 = XOR(c,*w);
  t06 = XOR(b,t05);
  t07 = OR(b,t05);
  t08 = AND(t01,t06);
  t09 = XOR(t03,t07);
  t10 = OR(t02,t09);
  *x = XOR(t10,t08);
  t12 = OR(a,d);
  t13 = XOR(t09,*x);
  t14 = XOR(b,t13);
  *z = NOT(t09);
  *y = XOR(t12,t14);

}

void sbox__3__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;


  // Instructions (body)
  t01 = XOR(a,c);
  t02 = OR(a,d);
  t03 = AND(a,d);
  t04 = AND(t01,t02);
  t05 = OR(b,t03);
  t06 = AND(a,b);
  t07 = XOR(d,t04);
  t08 = OR(c,t06);
  t09 = XOR(b,t07);
  t10 = AND(d,t05);
  t11 = XOR(t02,t10);
  *z = XOR(t08,t09);
  t13 = OR(d,*z);
  t14 = OR(a,t07);
  t15 = AND(b,t13);
  *y = XOR(t08,t11);
  *w = XOR(t14,t15);
  *x = XOR(t05,t04);

}

void sbox__4__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t16;


  // Instructions (body)
  t01 = OR(a,b);
  t02 = OR(b,c);
  t03 = XOR(a,t02);
  t04 = XOR(b,d);
  t05 = OR(d,t03);
  t06 = AND(d,t01);
  *z = XOR(t03,t06);
  t08 = AND(*z,t04);
  t09 = AND(t04,t05);
  t10 = XOR(c,t06);
  t11 = AND(b,c);
  t12 = XOR(t04,t08);
  t13 = OR(t11,t03);
  t14 = XOR(t10,t09);
  t15 = AND(a,t05);
  t16 = OR(t11,t12);
  *y = XOR(t13,t08);
  *x = XOR(t15,t16);
  *w = NOT(t14);

}

void sbox__5__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;


  // Instructions (body)
  t01 = XOR(b,d);
  t02 = OR(b,d);
  t03 = AND(a,t01);
  t04 = XOR(c,t02);
  t05 = XOR(t03,t04);
  *w = NOT(t05);
  t07 = XOR(a,t01);
  t08 = OR(d,*w);
  t09 = OR(b,t05);
  t10 = XOR(d,t08);
  t11 = OR(b,t07);
  t12 = OR(t03,*w);
  t13 = OR(t07,t10);
  t14 = XOR(t01,t11);
  *y = XOR(t09,t13);
  *x = XOR(t07,t08);
  *z = XOR(t12,t14);

}

void sbox__6__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t15;
  DATATYPE t17;
  DATATYPE t18;


  // Instructions (body)
  t01 = AND(a,d);
  t02 = XOR(b,c);
  t03 = XOR(a,d);
  t04 = XOR(t01,t02);
  t05 = OR(b,c);
  *x = NOT(t04);
  t07 = AND(t03,t05);
  t08 = AND(b,*x);
  t09 = OR(a,c);
  t10 = XOR(t07,t08);
  t11 = OR(b,d);
  t12 = XOR(c,t11);
  t13 = XOR(t09,t10);
  *y = NOT(t13);
  t15 = AND(*x,t03);
  *z = XOR(t12,t07);
  t17 = XOR(a,b);
  t18 = XOR(*y,t15);
  *w = XOR(t17,t18);

}

void sbox__7__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t16;
  DATATYPE t17;


  // Instructions (body)
  t01 = AND(a,c);
  t02 = NOT(d);
  t03 = AND(a,t02);
  t04 = OR(b,t01);
  t05 = AND(a,b);
  t06 = XOR(c,t04);
  *z = XOR(t03,t06);
  t08 = OR(c,*z);
  t09 = OR(d,t05);
  t10 = XOR(a,t08);
  t11 = AND(t04,*z);
  *x = XOR(t09,t10);
  t13 = XOR(b,*x);
  t14 = XOR(t01,*x);
  t15 = XOR(c,t05);
  t16 = OR(t11,t13);
  t17 = OR(t02,t14);
  *w = XOR(t15,t17);
  *y = XOR(a,t16);

}

void transform__ (/*inputs*/ DATATYPE input__0__,DATATYPE input__1__,DATATYPE input__2__,DATATYPE input__3__, /*outputs*/ DATATYPE* out__0__,DATATYPE* out__1__,DATATYPE* out__2__,DATATYPE* out__3__) {
  
  // Variables declaration
  DATATYPE _tmp1_;
  DATATYPE _tmp2_;
  DATATYPE _tmp3_;
  DATATYPE _tmp4_;
  DATATYPE _tmp5_;
  DATATYPE _tmp6_;
  DATATYPE x0__1__;
  DATATYPE x0__2__;
  DATATYPE x0__3__;
  DATATYPE x1__1__;
  DATATYPE x1__2__;
  DATATYPE x2__1__;
  DATATYPE x2__2__;
  DATATYPE x2__3__;
  DATATYPE x3__1__;
  DATATYPE x3__2__;


  // Instructions (body)
  x0__1__ = L_ROTATE(input__0__,13,32);
  x2__1__ = L_ROTATE(input__2__,3,32);
  _tmp1_ = XOR(input__1__,x0__1__);
  x1__1__ = XOR(_tmp1_,x2__1__);
  _tmp2_ = XOR(input__3__,x2__1__);
  _tmp3_ = L_SHIFT(x0__1__,3,32);
  x3__1__ = XOR(_tmp2_,_tmp3_);
  x1__2__ = L_ROTATE(x1__1__,1,32);
  x3__2__ = L_ROTATE(x3__1__,7,32);
  _tmp4_ = XOR(x0__1__,x1__2__);
  x0__2__ = XOR(_tmp4_,x3__2__);
  _tmp5_ = XOR(x2__1__,x3__2__);
  _tmp6_ = L_SHIFT(x1__2__,7,32);
  x2__2__ = XOR(_tmp5_,_tmp6_);
  x0__3__ = L_ROTATE(x0__2__,5,32);
  x2__3__ = L_ROTATE(x2__2__,22,32);
  *out__0__ = x0__3__;
  *out__1__ = x1__2__;
  *out__2__ = x2__3__;
  *out__3__ = x3__2__;

}

/* main function */
void Serpent__ (/*inputs*/ DATATYPE plaintext__[4],DATATYPE keys__[33][4], /*outputs*/ DATATYPE ciphertext__[4]) {
  
  // Variables declaration
  DATATYPE _tmp10_1;
  DATATYPE _tmp10_2;
  DATATYPE _tmp10_3;
  DATATYPE _tmp10_4;
  DATATYPE _tmp11_1;
  DATATYPE _tmp11_2;
  DATATYPE _tmp11_3;
  DATATYPE _tmp11_4;
  DATATYPE _tmp12_1;
  DATATYPE _tmp12_2;
  DATATYPE _tmp12_3;
  DATATYPE _tmp12_4;
  DATATYPE _tmp13_1;
  DATATYPE _tmp13_2;
  DATATYPE _tmp13_3;
  DATATYPE _tmp13_4;
  DATATYPE _tmp14_1;
  DATATYPE _tmp14_2;
  DATATYPE _tmp14_3;
  DATATYPE _tmp14_4;
  DATATYPE _tmp15_1;
  DATATYPE _tmp15_2;
  DATATYPE _tmp15_3;
  DATATYPE _tmp15_4;
  DATATYPE _tmp16_1;
  DATATYPE _tmp16_2;
  DATATYPE _tmp16_3;
  DATATYPE _tmp16_4;
  DATATYPE _tmp17_1;
  DATATYPE _tmp17_2;
  DATATYPE _tmp17_3;
  DATATYPE _tmp17_4;
  DATATYPE _tmp18_1;
  DATATYPE _tmp18_2;
  DATATYPE _tmp18_3;
  DATATYPE _tmp18_4;
  DATATYPE _tmp19_1;
  DATATYPE _tmp19_2;
  DATATYPE _tmp19_3;
  DATATYPE _tmp19_4;
  DATATYPE _tmp20_1;
  DATATYPE _tmp20_2;
  DATATYPE _tmp20_3;
  DATATYPE _tmp20_4;
  DATATYPE _tmp21_1;
  DATATYPE _tmp21_2;
  DATATYPE _tmp21_3;
  DATATYPE _tmp21_4;
  DATATYPE _tmp22_1;
  DATATYPE _tmp22_2;
  DATATYPE _tmp22_3;
  DATATYPE _tmp22_4;
  DATATYPE _tmp23_1;
  DATATYPE _tmp23_2;
  DATATYPE _tmp23_3;
  DATATYPE _tmp23_4;
  DATATYPE _tmp24_1;
  DATATYPE _tmp24_2;
  DATATYPE _tmp24_3;
  DATATYPE _tmp24_4;
  DATATYPE _tmp25_1;
  DATATYPE _tmp25_2;
  DATATYPE _tmp25_3;
  DATATYPE _tmp25_4;
  DATATYPE _tmp26_1;
  DATATYPE _tmp26_2;
  DATATYPE _tmp26_3;
  DATATYPE _tmp26_4;
  DATATYPE _tmp27_1;
  DATATYPE _tmp27_2;
  DATATYPE _tmp27_3;
  DATATYPE _tmp27_4;
  DATATYPE _tmp28_1;
  DATATYPE _tmp28_2;
  DATATYPE _tmp28_3;
  DATATYPE _tmp28_4;
  DATATYPE _tmp29_1;
  DATATYPE _tmp29_2;
  DATATYPE _tmp29_3;
  DATATYPE _tmp29_4;
  DATATYPE _tmp30_1;
  DATATYPE _tmp30_2;
  DATATYPE _tmp30_3;
  DATATYPE _tmp30_4;
  DATATYPE _tmp31_1;
  DATATYPE _tmp31_2;
  DATATYPE _tmp31_3;
  DATATYPE _tmp31_4;
  DATATYPE _tmp32_1;
  DATATYPE _tmp32_2;
  DATATYPE _tmp32_3;
  DATATYPE _tmp32_4;
  DATATYPE _tmp33_1;
  DATATYPE _tmp33_2;
  DATATYPE _tmp33_3;
  DATATYPE _tmp33_4;
  DATATYPE _tmp34_1;
  DATATYPE _tmp34_2;
  DATATYPE _tmp34_3;
  DATATYPE _tmp34_4;
  DATATYPE _tmp35_1;
  DATATYPE _tmp35_2;
  DATATYPE _tmp35_3;
  DATATYPE _tmp35_4;
  DATATYPE _tmp36_1;
  DATATYPE _tmp36_2;
  DATATYPE _tmp36_3;
  DATATYPE _tmp36_4;
  DATATYPE _tmp37_1;
  DATATYPE _tmp37_2;
  DATATYPE _tmp37_3;
  DATATYPE _tmp37_4;
  DATATYPE _tmp38_1;
  DATATYPE _tmp38_2;
  DATATYPE _tmp38_3;
  DATATYPE _tmp38_4;
  DATATYPE _tmp39_1;
  DATATYPE _tmp39_2;
  DATATYPE _tmp39_3;
  DATATYPE _tmp39_4;
  DATATYPE _tmp40_1;
  DATATYPE _tmp40_2;
  DATATYPE _tmp40_3;
  DATATYPE _tmp40_4;
  DATATYPE _tmp41_1;
  DATATYPE _tmp41_2;
  DATATYPE _tmp41_3;
  DATATYPE _tmp41_4;
  DATATYPE _tmp42_1;
  DATATYPE _tmp42_2;
  DATATYPE _tmp42_3;
  DATATYPE _tmp42_4;
  DATATYPE _tmp43_1;
  DATATYPE _tmp43_2;
  DATATYPE _tmp43_3;
  DATATYPE _tmp43_4;
  DATATYPE _tmp44_1;
  DATATYPE _tmp44_2;
  DATATYPE _tmp44_3;
  DATATYPE _tmp44_4;
  DATATYPE _tmp45_1;
  DATATYPE _tmp45_2;
  DATATYPE _tmp45_3;
  DATATYPE _tmp45_4;
  DATATYPE _tmp46_1;
  DATATYPE _tmp46_2;
  DATATYPE _tmp46_3;
  DATATYPE _tmp46_4;
  DATATYPE _tmp47_1;
  DATATYPE _tmp47_2;
  DATATYPE _tmp47_3;
  DATATYPE _tmp47_4;
  DATATYPE _tmp48_1;
  DATATYPE _tmp48_2;
  DATATYPE _tmp48_3;
  DATATYPE _tmp48_4;
  DATATYPE _tmp49_1;
  DATATYPE _tmp49_2;
  DATATYPE _tmp49_3;
  DATATYPE _tmp49_4;
  DATATYPE _tmp50_1;
  DATATYPE _tmp50_2;
  DATATYPE _tmp50_3;
  DATATYPE _tmp50_4;
  DATATYPE _tmp51_1;
  DATATYPE _tmp51_2;
  DATATYPE _tmp51_3;
  DATATYPE _tmp51_4;
  DATATYPE _tmp52_1;
  DATATYPE _tmp52_2;
  DATATYPE _tmp52_3;
  DATATYPE _tmp52_4;
  DATATYPE _tmp53_1;
  DATATYPE _tmp53_2;
  DATATYPE _tmp53_3;
  DATATYPE _tmp53_4;
  DATATYPE _tmp54_1;
  DATATYPE _tmp54_2;
  DATATYPE _tmp54_3;
  DATATYPE _tmp54_4;
  DATATYPE _tmp55_1;
  DATATYPE _tmp55_2;
  DATATYPE _tmp55_3;
  DATATYPE _tmp55_4;
  DATATYPE _tmp56_1;
  DATATYPE _tmp56_2;
  DATATYPE _tmp56_3;
  DATATYPE _tmp56_4;
  DATATYPE _tmp57_1;
  DATATYPE _tmp57_2;
  DATATYPE _tmp57_3;
  DATATYPE _tmp57_4;
  DATATYPE _tmp58_1;
  DATATYPE _tmp58_2;
  DATATYPE _tmp58_3;
  DATATYPE _tmp58_4;
  DATATYPE _tmp59_1;
  DATATYPE _tmp59_2;
  DATATYPE _tmp59_3;
  DATATYPE _tmp59_4;
  DATATYPE _tmp60_1;
  DATATYPE _tmp60_2;
  DATATYPE _tmp60_3;
  DATATYPE _tmp60_4;
  DATATYPE _tmp61_1;
  DATATYPE _tmp61_2;
  DATATYPE _tmp61_3;
  DATATYPE _tmp61_4;
  DATATYPE _tmp62_1;
  DATATYPE _tmp62_2;
  DATATYPE _tmp62_3;
  DATATYPE _tmp62_4;
  DATATYPE _tmp63_1;
  DATATYPE _tmp63_2;
  DATATYPE _tmp63_3;
  DATATYPE _tmp63_4;
  DATATYPE _tmp64_1;
  DATATYPE _tmp64_2;
  DATATYPE _tmp64_3;
  DATATYPE _tmp64_4;
  DATATYPE _tmp65_1;
  DATATYPE _tmp65_2;
  DATATYPE _tmp65_3;
  DATATYPE _tmp65_4;
  DATATYPE _tmp66_1;
  DATATYPE _tmp66_2;
  DATATYPE _tmp66_3;
  DATATYPE _tmp66_4;
  DATATYPE _tmp67_1;
  DATATYPE _tmp67_2;
  DATATYPE _tmp67_3;
  DATATYPE _tmp67_4;
  DATATYPE _tmp68_1;
  DATATYPE _tmp68_2;
  DATATYPE _tmp68_3;
  DATATYPE _tmp68_4;
  DATATYPE _tmp69_1;
  DATATYPE _tmp69_2;
  DATATYPE _tmp69_3;
  DATATYPE _tmp69_4;
  DATATYPE _tmp70_1;
  DATATYPE _tmp70_2;
  DATATYPE _tmp70_3;
  DATATYPE _tmp70_4;
  DATATYPE _tmp7_1;
  DATATYPE _tmp7_2;
  DATATYPE _tmp7_3;
  DATATYPE _tmp7_4;
  DATATYPE _tmp8_1;
  DATATYPE _tmp8_2;
  DATATYPE _tmp8_3;
  DATATYPE _tmp8_4;
  DATATYPE _tmp9_1;
  DATATYPE _tmp9_2;
  DATATYPE _tmp9_3;
  DATATYPE _tmp9_4;
  DATATYPE tmp__1__0__;
  DATATYPE tmp__1__1__;
  DATATYPE tmp__1__2__;
  DATATYPE tmp__1__3__;
  DATATYPE tmp__10__0__;
  DATATYPE tmp__10__1__;
  DATATYPE tmp__10__2__;
  DATATYPE tmp__10__3__;
  DATATYPE tmp__11__0__;
  DATATYPE tmp__11__1__;
  DATATYPE tmp__11__2__;
  DATATYPE tmp__11__3__;
  DATATYPE tmp__12__0__;
  DATATYPE tmp__12__1__;
  DATATYPE tmp__12__2__;
  DATATYPE tmp__12__3__;
  DATATYPE tmp__13__0__;
  DATATYPE tmp__13__1__;
  DATATYPE tmp__13__2__;
  DATATYPE tmp__13__3__;
  DATATYPE tmp__14__0__;
  DATATYPE tmp__14__1__;
  DATATYPE tmp__14__2__;
  DATATYPE tmp__14__3__;
  DATATYPE tmp__15__0__;
  DATATYPE tmp__15__1__;
  DATATYPE tmp__15__2__;
  DATATYPE tmp__15__3__;
  DATATYPE tmp__16__0__;
  DATATYPE tmp__16__1__;
  DATATYPE tmp__16__2__;
  DATATYPE tmp__16__3__;
  DATATYPE tmp__17__0__;
  DATATYPE tmp__17__1__;
  DATATYPE tmp__17__2__;
  DATATYPE tmp__17__3__;
  DATATYPE tmp__18__0__;
  DATATYPE tmp__18__1__;
  DATATYPE tmp__18__2__;
  DATATYPE tmp__18__3__;
  DATATYPE tmp__19__0__;
  DATATYPE tmp__19__1__;
  DATATYPE tmp__19__2__;
  DATATYPE tmp__19__3__;
  DATATYPE tmp__2__0__;
  DATATYPE tmp__2__1__;
  DATATYPE tmp__2__2__;
  DATATYPE tmp__2__3__;
  DATATYPE tmp__20__0__;
  DATATYPE tmp__20__1__;
  DATATYPE tmp__20__2__;
  DATATYPE tmp__20__3__;
  DATATYPE tmp__21__0__;
  DATATYPE tmp__21__1__;
  DATATYPE tmp__21__2__;
  DATATYPE tmp__21__3__;
  DATATYPE tmp__22__0__;
  DATATYPE tmp__22__1__;
  DATATYPE tmp__22__2__;
  DATATYPE tmp__22__3__;
  DATATYPE tmp__23__0__;
  DATATYPE tmp__23__1__;
  DATATYPE tmp__23__2__;
  DATATYPE tmp__23__3__;
  DATATYPE tmp__24__0__;
  DATATYPE tmp__24__1__;
  DATATYPE tmp__24__2__;
  DATATYPE tmp__24__3__;
  DATATYPE tmp__25__0__;
  DATATYPE tmp__25__1__;
  DATATYPE tmp__25__2__;
  DATATYPE tmp__25__3__;
  DATATYPE tmp__26__0__;
  DATATYPE tmp__26__1__;
  DATATYPE tmp__26__2__;
  DATATYPE tmp__26__3__;
  DATATYPE tmp__27__0__;
  DATATYPE tmp__27__1__;
  DATATYPE tmp__27__2__;
  DATATYPE tmp__27__3__;
  DATATYPE tmp__28__0__;
  DATATYPE tmp__28__1__;
  DATATYPE tmp__28__2__;
  DATATYPE tmp__28__3__;
  DATATYPE tmp__29__0__;
  DATATYPE tmp__29__1__;
  DATATYPE tmp__29__2__;
  DATATYPE tmp__29__3__;
  DATATYPE tmp__3__0__;
  DATATYPE tmp__3__1__;
  DATATYPE tmp__3__2__;
  DATATYPE tmp__3__3__;
  DATATYPE tmp__30__0__;
  DATATYPE tmp__30__1__;
  DATATYPE tmp__30__2__;
  DATATYPE tmp__30__3__;
  DATATYPE tmp__31__0__;
  DATATYPE tmp__31__1__;
  DATATYPE tmp__31__2__;
  DATATYPE tmp__31__3__;
  DATATYPE tmp__4__0__;
  DATATYPE tmp__4__1__;
  DATATYPE tmp__4__2__;
  DATATYPE tmp__4__3__;
  DATATYPE tmp__5__0__;
  DATATYPE tmp__5__1__;
  DATATYPE tmp__5__2__;
  DATATYPE tmp__5__3__;
  DATATYPE tmp__6__0__;
  DATATYPE tmp__6__1__;
  DATATYPE tmp__6__2__;
  DATATYPE tmp__6__3__;
  DATATYPE tmp__7__0__;
  DATATYPE tmp__7__1__;
  DATATYPE tmp__7__2__;
  DATATYPE tmp__7__3__;
  DATATYPE tmp__8__0__;
  DATATYPE tmp__8__1__;
  DATATYPE tmp__8__2__;
  DATATYPE tmp__8__3__;
  DATATYPE tmp__9__0__;
  DATATYPE tmp__9__1__;
  DATATYPE tmp__9__2__;
  DATATYPE tmp__9__3__;


  // Instructions (body)
  _tmp7_1 = XOR(plaintext__[0],keys__[0][0]);
  _tmp7_2 = XOR(plaintext__[1],keys__[0][1]);
  _tmp7_3 = XOR(plaintext__[2],keys__[0][2]);
  _tmp7_4 = XOR(plaintext__[3],keys__[0][3]);
  sbox__0__(_tmp7_1,_tmp7_2,_tmp7_3,_tmp7_4,&_tmp8_1,&_tmp8_2,&_tmp8_3,&_tmp8_4);
  transform__(_tmp8_1,_tmp8_2,_tmp8_3,_tmp8_4,&tmp__1__0__,&tmp__1__1__,&tmp__1__2__,&tmp__1__3__);
  _tmp9_1 = XOR(tmp__1__0__,keys__[1][0]);
  _tmp9_2 = XOR(tmp__1__1__,keys__[1][1]);
  _tmp9_3 = XOR(tmp__1__2__,keys__[1][2]);
  _tmp9_4 = XOR(tmp__1__3__,keys__[1][3]);
  sbox__1__(_tmp9_1,_tmp9_2,_tmp9_3,_tmp9_4,&_tmp10_1,&_tmp10_2,&_tmp10_3,&_tmp10_4);
  transform__(_tmp10_1,_tmp10_2,_tmp10_3,_tmp10_4,&tmp__2__0__,&tmp__2__1__,&tmp__2__2__,&tmp__2__3__);
  _tmp11_1 = XOR(tmp__2__0__,keys__[2][0]);
  _tmp11_2 = XOR(tmp__2__1__,keys__[2][1]);
  _tmp11_3 = XOR(tmp__2__2__,keys__[2][2]);
  _tmp11_4 = XOR(tmp__2__3__,keys__[2][3]);
  sbox__2__(_tmp11_1,_tmp11_2,_tmp11_3,_tmp11_4,&_tmp12_1,&_tmp12_2,&_tmp12_3,&_tmp12_4);
  transform__(_tmp12_1,_tmp12_2,_tmp12_3,_tmp12_4,&tmp__3__0__,&tmp__3__1__,&tmp__3__2__,&tmp__3__3__);
  _tmp13_1 = XOR(tmp__3__0__,keys__[3][0]);
  _tmp13_2 = XOR(tmp__3__1__,keys__[3][1]);
  _tmp13_3 = XOR(tmp__3__2__,keys__[3][2]);
  _tmp13_4 = XOR(tmp__3__3__,keys__[3][3]);
  sbox__3__(_tmp13_1,_tmp13_2,_tmp13_3,_tmp13_4,&_tmp14_1,&_tmp14_2,&_tmp14_3,&_tmp14_4);
  transform__(_tmp14_1,_tmp14_2,_tmp14_3,_tmp14_4,&tmp__4__0__,&tmp__4__1__,&tmp__4__2__,&tmp__4__3__);
  _tmp15_1 = XOR(tmp__4__0__,keys__[4][0]);
  _tmp15_2 = XOR(tmp__4__1__,keys__[4][1]);
  _tmp15_3 = XOR(tmp__4__2__,keys__[4][2]);
  _tmp15_4 = XOR(tmp__4__3__,keys__[4][3]);
  sbox__4__(_tmp15_1,_tmp15_2,_tmp15_3,_tmp15_4,&_tmp16_1,&_tmp16_2,&_tmp16_3,&_tmp16_4);
  transform__(_tmp16_1,_tmp16_2,_tmp16_3,_tmp16_4,&tmp__5__0__,&tmp__5__1__,&tmp__5__2__,&tmp__5__3__);
  _tmp17_1 = XOR(tmp__5__0__,keys__[5][0]);
  _tmp17_2 = XOR(tmp__5__1__,keys__[5][1]);
  _tmp17_3 = XOR(tmp__5__2__,keys__[5][2]);
  _tmp17_4 = XOR(tmp__5__3__,keys__[5][3]);
  sbox__5__(_tmp17_1,_tmp17_2,_tmp17_3,_tmp17_4,&_tmp18_1,&_tmp18_2,&_tmp18_3,&_tmp18_4);
  transform__(_tmp18_1,_tmp18_2,_tmp18_3,_tmp18_4,&tmp__6__0__,&tmp__6__1__,&tmp__6__2__,&tmp__6__3__);
  _tmp19_1 = XOR(tmp__6__0__,keys__[6][0]);
  _tmp19_2 = XOR(tmp__6__1__,keys__[6][1]);
  _tmp19_3 = XOR(tmp__6__2__,keys__[6][2]);
  _tmp19_4 = XOR(tmp__6__3__,keys__[6][3]);
  sbox__6__(_tmp19_1,_tmp19_2,_tmp19_3,_tmp19_4,&_tmp20_1,&_tmp20_2,&_tmp20_3,&_tmp20_4);
  transform__(_tmp20_1,_tmp20_2,_tmp20_3,_tmp20_4,&tmp__7__0__,&tmp__7__1__,&tmp__7__2__,&tmp__7__3__);
  _tmp21_1 = XOR(tmp__7__0__,keys__[7][0]);
  _tmp21_2 = XOR(tmp__7__1__,keys__[7][1]);
  _tmp21_3 = XOR(tmp__7__2__,keys__[7][2]);
  _tmp21_4 = XOR(tmp__7__3__,keys__[7][3]);
  sbox__7__(_tmp21_1,_tmp21_2,_tmp21_3,_tmp21_4,&_tmp22_1,&_tmp22_2,&_tmp22_3,&_tmp22_4);
  transform__(_tmp22_1,_tmp22_2,_tmp22_3,_tmp22_4,&tmp__8__0__,&tmp__8__1__,&tmp__8__2__,&tmp__8__3__);
  _tmp23_1 = XOR(tmp__8__0__,keys__[8][0]);
  _tmp23_2 = XOR(tmp__8__1__,keys__[8][1]);
  _tmp23_3 = XOR(tmp__8__2__,keys__[8][2]);
  _tmp23_4 = XOR(tmp__8__3__,keys__[8][3]);
  sbox__0__(_tmp23_1,_tmp23_2,_tmp23_3,_tmp23_4,&_tmp24_1,&_tmp24_2,&_tmp24_3,&_tmp24_4);
  transform__(_tmp24_1,_tmp24_2,_tmp24_3,_tmp24_4,&tmp__9__0__,&tmp__9__1__,&tmp__9__2__,&tmp__9__3__);
  _tmp25_1 = XOR(tmp__9__0__,keys__[9][0]);
  _tmp25_2 = XOR(tmp__9__1__,keys__[9][1]);
  _tmp25_3 = XOR(tmp__9__2__,keys__[9][2]);
  _tmp25_4 = XOR(tmp__9__3__,keys__[9][3]);
  sbox__1__(_tmp25_1,_tmp25_2,_tmp25_3,_tmp25_4,&_tmp26_1,&_tmp26_2,&_tmp26_3,&_tmp26_4);
  transform__(_tmp26_1,_tmp26_2,_tmp26_3,_tmp26_4,&tmp__10__0__,&tmp__10__1__,&tmp__10__2__,&tmp__10__3__);
  _tmp27_1 = XOR(tmp__10__0__,keys__[10][0]);
  _tmp27_2 = XOR(tmp__10__1__,keys__[10][1]);
  _tmp27_3 = XOR(tmp__10__2__,keys__[10][2]);
  _tmp27_4 = XOR(tmp__10__3__,keys__[10][3]);
  sbox__2__(_tmp27_1,_tmp27_2,_tmp27_3,_tmp27_4,&_tmp28_1,&_tmp28_2,&_tmp28_3,&_tmp28_4);
  transform__(_tmp28_1,_tmp28_2,_tmp28_3,_tmp28_4,&tmp__11__0__,&tmp__11__1__,&tmp__11__2__,&tmp__11__3__);
  _tmp29_1 = XOR(tmp__11__0__,keys__[11][0]);
  _tmp29_2 = XOR(tmp__11__1__,keys__[11][1]);
  _tmp29_3 = XOR(tmp__11__2__,keys__[11][2]);
  _tmp29_4 = XOR(tmp__11__3__,keys__[11][3]);
  sbox__3__(_tmp29_1,_tmp29_2,_tmp29_3,_tmp29_4,&_tmp30_1,&_tmp30_2,&_tmp30_3,&_tmp30_4);
  transform__(_tmp30_1,_tmp30_2,_tmp30_3,_tmp30_4,&tmp__12__0__,&tmp__12__1__,&tmp__12__2__,&tmp__12__3__);
  _tmp31_1 = XOR(tmp__12__0__,keys__[12][0]);
  _tmp31_2 = XOR(tmp__12__1__,keys__[12][1]);
  _tmp31_3 = XOR(tmp__12__2__,keys__[12][2]);
  _tmp31_4 = XOR(tmp__12__3__,keys__[12][3]);
  sbox__4__(_tmp31_1,_tmp31_2,_tmp31_3,_tmp31_4,&_tmp32_1,&_tmp32_2,&_tmp32_3,&_tmp32_4);
  transform__(_tmp32_1,_tmp32_2,_tmp32_3,_tmp32_4,&tmp__13__0__,&tmp__13__1__,&tmp__13__2__,&tmp__13__3__);
  _tmp33_1 = XOR(tmp__13__0__,keys__[13][0]);
  _tmp33_2 = XOR(tmp__13__1__,keys__[13][1]);
  _tmp33_3 = XOR(tmp__13__2__,keys__[13][2]);
  _tmp33_4 = XOR(tmp__13__3__,keys__[13][3]);
  sbox__5__(_tmp33_1,_tmp33_2,_tmp33_3,_tmp33_4,&_tmp34_1,&_tmp34_2,&_tmp34_3,&_tmp34_4);
  transform__(_tmp34_1,_tmp34_2,_tmp34_3,_tmp34_4,&tmp__14__0__,&tmp__14__1__,&tmp__14__2__,&tmp__14__3__);
  _tmp35_1 = XOR(tmp__14__0__,keys__[14][0]);
  _tmp35_2 = XOR(tmp__14__1__,keys__[14][1]);
  _tmp35_3 = XOR(tmp__14__2__,keys__[14][2]);
  _tmp35_4 = XOR(tmp__14__3__,keys__[14][3]);
  sbox__6__(_tmp35_1,_tmp35_2,_tmp35_3,_tmp35_4,&_tmp36_1,&_tmp36_2,&_tmp36_3,&_tmp36_4);
  transform__(_tmp36_1,_tmp36_2,_tmp36_3,_tmp36_4,&tmp__15__0__,&tmp__15__1__,&tmp__15__2__,&tmp__15__3__);
  _tmp37_1 = XOR(tmp__15__0__,keys__[15][0]);
  _tmp37_2 = XOR(tmp__15__1__,keys__[15][1]);
  _tmp37_3 = XOR(tmp__15__2__,keys__[15][2]);
  _tmp37_4 = XOR(tmp__15__3__,keys__[15][3]);
  sbox__7__(_tmp37_1,_tmp37_2,_tmp37_3,_tmp37_4,&_tmp38_1,&_tmp38_2,&_tmp38_3,&_tmp38_4);
  transform__(_tmp38_1,_tmp38_2,_tmp38_3,_tmp38_4,&tmp__16__0__,&tmp__16__1__,&tmp__16__2__,&tmp__16__3__);
  _tmp39_1 = XOR(tmp__16__0__,keys__[16][0]);
  _tmp39_2 = XOR(tmp__16__1__,keys__[16][1]);
  _tmp39_3 = XOR(tmp__16__2__,keys__[16][2]);
  _tmp39_4 = XOR(tmp__16__3__,keys__[16][3]);
  sbox__0__(_tmp39_1,_tmp39_2,_tmp39_3,_tmp39_4,&_tmp40_1,&_tmp40_2,&_tmp40_3,&_tmp40_4);
  transform__(_tmp40_1,_tmp40_2,_tmp40_3,_tmp40_4,&tmp__17__0__,&tmp__17__1__,&tmp__17__2__,&tmp__17__3__);
  _tmp41_1 = XOR(tmp__17__0__,keys__[17][0]);
  _tmp41_2 = XOR(tmp__17__1__,keys__[17][1]);
  _tmp41_3 = XOR(tmp__17__2__,keys__[17][2]);
  _tmp41_4 = XOR(tmp__17__3__,keys__[17][3]);
  sbox__1__(_tmp41_1,_tmp41_2,_tmp41_3,_tmp41_4,&_tmp42_1,&_tmp42_2,&_tmp42_3,&_tmp42_4);
  transform__(_tmp42_1,_tmp42_2,_tmp42_3,_tmp42_4,&tmp__18__0__,&tmp__18__1__,&tmp__18__2__,&tmp__18__3__);
  _tmp43_1 = XOR(tmp__18__0__,keys__[18][0]);
  _tmp43_2 = XOR(tmp__18__1__,keys__[18][1]);
  _tmp43_3 = XOR(tmp__18__2__,keys__[18][2]);
  _tmp43_4 = XOR(tmp__18__3__,keys__[18][3]);
  sbox__2__(_tmp43_1,_tmp43_2,_tmp43_3,_tmp43_4,&_tmp44_1,&_tmp44_2,&_tmp44_3,&_tmp44_4);
  transform__(_tmp44_1,_tmp44_2,_tmp44_3,_tmp44_4,&tmp__19__0__,&tmp__19__1__,&tmp__19__2__,&tmp__19__3__);
  _tmp45_1 = XOR(tmp__19__0__,keys__[19][0]);
  _tmp45_2 = XOR(tmp__19__1__,keys__[19][1]);
  _tmp45_3 = XOR(tmp__19__2__,keys__[19][2]);
  _tmp45_4 = XOR(tmp__19__3__,keys__[19][3]);
  sbox__3__(_tmp45_1,_tmp45_2,_tmp45_3,_tmp45_4,&_tmp46_1,&_tmp46_2,&_tmp46_3,&_tmp46_4);
  transform__(_tmp46_1,_tmp46_2,_tmp46_3,_tmp46_4,&tmp__20__0__,&tmp__20__1__,&tmp__20__2__,&tmp__20__3__);
  _tmp47_1 = XOR(tmp__20__0__,keys__[20][0]);
  _tmp47_2 = XOR(tmp__20__1__,keys__[20][1]);
  _tmp47_3 = XOR(tmp__20__2__,keys__[20][2]);
  _tmp47_4 = XOR(tmp__20__3__,keys__[20][3]);
  sbox__4__(_tmp47_1,_tmp47_2,_tmp47_3,_tmp47_4,&_tmp48_1,&_tmp48_2,&_tmp48_3,&_tmp48_4);
  transform__(_tmp48_1,_tmp48_2,_tmp48_3,_tmp48_4,&tmp__21__0__,&tmp__21__1__,&tmp__21__2__,&tmp__21__3__);
  _tmp49_1 = XOR(tmp__21__0__,keys__[21][0]);
  _tmp49_2 = XOR(tmp__21__1__,keys__[21][1]);
  _tmp49_3 = XOR(tmp__21__2__,keys__[21][2]);
  _tmp49_4 = XOR(tmp__21__3__,keys__[21][3]);
  sbox__5__(_tmp49_1,_tmp49_2,_tmp49_3,_tmp49_4,&_tmp50_1,&_tmp50_2,&_tmp50_3,&_tmp50_4);
  transform__(_tmp50_1,_tmp50_2,_tmp50_3,_tmp50_4,&tmp__22__0__,&tmp__22__1__,&tmp__22__2__,&tmp__22__3__);
  _tmp51_1 = XOR(tmp__22__0__,keys__[22][0]);
  _tmp51_2 = XOR(tmp__22__1__,keys__[22][1]);
  _tmp51_3 = XOR(tmp__22__2__,keys__[22][2]);
  _tmp51_4 = XOR(tmp__22__3__,keys__[22][3]);
  sbox__6__(_tmp51_1,_tmp51_2,_tmp51_3,_tmp51_4,&_tmp52_1,&_tmp52_2,&_tmp52_3,&_tmp52_4);
  transform__(_tmp52_1,_tmp52_2,_tmp52_3,_tmp52_4,&tmp__23__0__,&tmp__23__1__,&tmp__23__2__,&tmp__23__3__);
  _tmp53_1 = XOR(tmp__23__0__,keys__[23][0]);
  _tmp53_2 = XOR(tmp__23__1__,keys__[23][1]);
  _tmp53_3 = XOR(tmp__23__2__,keys__[23][2]);
  _tmp53_4 = XOR(tmp__23__3__,keys__[23][3]);
  sbox__7__(_tmp53_1,_tmp53_2,_tmp53_3,_tmp53_4,&_tmp54_1,&_tmp54_2,&_tmp54_3,&_tmp54_4);
  transform__(_tmp54_1,_tmp54_2,_tmp54_3,_tmp54_4,&tmp__24__0__,&tmp__24__1__,&tmp__24__2__,&tmp__24__3__);
  _tmp55_1 = XOR(tmp__24__0__,keys__[24][0]);
  _tmp55_2 = XOR(tmp__24__1__,keys__[24][1]);
  _tmp55_3 = XOR(tmp__24__2__,keys__[24][2]);
  _tmp55_4 = XOR(tmp__24__3__,keys__[24][3]);
  sbox__0__(_tmp55_1,_tmp55_2,_tmp55_3,_tmp55_4,&_tmp56_1,&_tmp56_2,&_tmp56_3,&_tmp56_4);
  transform__(_tmp56_1,_tmp56_2,_tmp56_3,_tmp56_4,&tmp__25__0__,&tmp__25__1__,&tmp__25__2__,&tmp__25__3__);
  _tmp57_1 = XOR(tmp__25__0__,keys__[25][0]);
  _tmp57_2 = XOR(tmp__25__1__,keys__[25][1]);
  _tmp57_3 = XOR(tmp__25__2__,keys__[25][2]);
  _tmp57_4 = XOR(tmp__25__3__,keys__[25][3]);
  sbox__1__(_tmp57_1,_tmp57_2,_tmp57_3,_tmp57_4,&_tmp58_1,&_tmp58_2,&_tmp58_3,&_tmp58_4);
  transform__(_tmp58_1,_tmp58_2,_tmp58_3,_tmp58_4,&tmp__26__0__,&tmp__26__1__,&tmp__26__2__,&tmp__26__3__);
  _tmp59_1 = XOR(tmp__26__0__,keys__[26][0]);
  _tmp59_2 = XOR(tmp__26__1__,keys__[26][1]);
  _tmp59_3 = XOR(tmp__26__2__,keys__[26][2]);
  _tmp59_4 = XOR(tmp__26__3__,keys__[26][3]);
  sbox__2__(_tmp59_1,_tmp59_2,_tmp59_3,_tmp59_4,&_tmp60_1,&_tmp60_2,&_tmp60_3,&_tmp60_4);
  transform__(_tmp60_1,_tmp60_2,_tmp60_3,_tmp60_4,&tmp__27__0__,&tmp__27__1__,&tmp__27__2__,&tmp__27__3__);
  _tmp61_1 = XOR(tmp__27__0__,keys__[27][0]);
  _tmp61_2 = XOR(tmp__27__1__,keys__[27][1]);
  _tmp61_3 = XOR(tmp__27__2__,keys__[27][2]);
  _tmp61_4 = XOR(tmp__27__3__,keys__[27][3]);
  sbox__3__(_tmp61_1,_tmp61_2,_tmp61_3,_tmp61_4,&_tmp62_1,&_tmp62_2,&_tmp62_3,&_tmp62_4);
  transform__(_tmp62_1,_tmp62_2,_tmp62_3,_tmp62_4,&tmp__28__0__,&tmp__28__1__,&tmp__28__2__,&tmp__28__3__);
  _tmp63_1 = XOR(tmp__28__0__,keys__[28][0]);
  _tmp63_2 = XOR(tmp__28__1__,keys__[28][1]);
  _tmp63_3 = XOR(tmp__28__2__,keys__[28][2]);
  _tmp63_4 = XOR(tmp__28__3__,keys__[28][3]);
  sbox__4__(_tmp63_1,_tmp63_2,_tmp63_3,_tmp63_4,&_tmp64_1,&_tmp64_2,&_tmp64_3,&_tmp64_4);
  transform__(_tmp64_1,_tmp64_2,_tmp64_3,_tmp64_4,&tmp__29__0__,&tmp__29__1__,&tmp__29__2__,&tmp__29__3__);
  _tmp65_1 = XOR(tmp__29__0__,keys__[29][0]);
  _tmp65_2 = XOR(tmp__29__1__,keys__[29][1]);
  _tmp65_3 = XOR(tmp__29__2__,keys__[29][2]);
  _tmp65_4 = XOR(tmp__29__3__,keys__[29][3]);
  sbox__5__(_tmp65_1,_tmp65_2,_tmp65_3,_tmp65_4,&_tmp66_1,&_tmp66_2,&_tmp66_3,&_tmp66_4);
  transform__(_tmp66_1,_tmp66_2,_tmp66_3,_tmp66_4,&tmp__30__0__,&tmp__30__1__,&tmp__30__2__,&tmp__30__3__);
  _tmp67_1 = XOR(tmp__30__0__,keys__[30][0]);
  _tmp67_2 = XOR(tmp__30__1__,keys__[30][1]);
  _tmp67_3 = XOR(tmp__30__2__,keys__[30][2]);
  _tmp67_4 = XOR(tmp__30__3__,keys__[30][3]);
  sbox__6__(_tmp67_1,_tmp67_2,_tmp67_3,_tmp67_4,&_tmp68_1,&_tmp68_2,&_tmp68_3,&_tmp68_4);
  transform__(_tmp68_1,_tmp68_2,_tmp68_3,_tmp68_4,&tmp__31__0__,&tmp__31__1__,&tmp__31__2__,&tmp__31__3__);
  _tmp69_1 = XOR(tmp__31__0__,keys__[31][0]);
  _tmp69_2 = XOR(tmp__31__1__,keys__[31][1]);
  _tmp69_3 = XOR(tmp__31__2__,keys__[31][2]);
  _tmp69_4 = XOR(tmp__31__3__,keys__[31][3]);
  sbox__7__(_tmp69_1,_tmp69_2,_tmp69_3,_tmp69_4,&_tmp70_1,&_tmp70_2,&_tmp70_3,&_tmp70_4);
  ciphertext__[0] = XOR(_tmp70_1,keys__[32][0]);
  ciphertext__[1] = XOR(_tmp70_2,keys__[32][1]);
  ciphertext__[2] = XOR(_tmp70_3,keys__[32][2]);
  ciphertext__[3] = XOR(_tmp70_4,keys__[32][3]);

}
 