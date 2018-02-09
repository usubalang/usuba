
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>

/* Do NOT change the order of those define/include */

/* defining "BENCH" or "STD" */
/* (will impact the .h functions loaded by the .h) */
#define NO_RUNTIME
/* including the architecture specific .h */
#include "STD.h"

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
  t01 = XOR(c,b);
  t02 = OR(d,a);
  t03 = XOR(b,a);
  *z = XOR(t01,t02);
  t05 = OR(*z,c);
  t06 = XOR(d,a);
  t07 = OR(c,b);
  t08 = AND(t05,d);
  t09 = AND(t07,t03);
  *y = XOR(t08,t09);
  t11 = AND(*y,t09);
  t12 = XOR(d,c);
  t13 = XOR(t11,t07);
  t14 = AND(t06,b);
  t15 = XOR(t13,t06);
  *w = NOT(t15);
  t17 = XOR(t14,*w);
  *x = XOR(t17,t12);

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
  t01 = OR(d,a);
  t02 = XOR(d,c);
  t03 = NOT(b);
  t04 = XOR(c,a);
  t05 = OR(t03,a);
  t06 = AND(t04,d);
  t07 = AND(t02,t01);
  t08 = OR(t06,b);
  *y = XOR(t05,t02);
  t10 = XOR(t08,t07);
  t11 = XOR(t10,t01);
  t12 = XOR(t11,*y);
  t13 = AND(d,b);
  *z = NOT(t10);
  *x = XOR(t12,t13);
  t16 = OR(*x,t10);
  t17 = AND(t16,t05);
  *w = XOR(t17,c);

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
  t01 = OR(c,a);
  t02 = XOR(b,a);
  t03 = XOR(t01,d);
  *w = XOR(t03,t02);
  t05 = XOR(*w,c);
  t06 = XOR(t05,b);
  t07 = OR(t05,b);
  t08 = AND(t06,t01);
  t09 = XOR(t07,t03);
  t10 = OR(t09,t02);
  *x = XOR(t08,t10);
  t12 = OR(d,a);
  t13 = XOR(*x,t09);
  t14 = XOR(t13,b);
  *z = NOT(t09);
  *y = XOR(t14,t12);

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
  t01 = XOR(c,a);
  t02 = OR(d,a);
  t03 = AND(d,a);
  t04 = AND(t02,t01);
  t05 = OR(t03,b);
  t06 = AND(b,a);
  t07 = XOR(t04,d);
  t08 = OR(t06,c);
  t09 = XOR(t07,b);
  t10 = AND(t05,d);
  t11 = XOR(t10,t02);
  *z = XOR(t09,t08);
  t13 = OR(*z,d);
  t14 = OR(t07,a);
  t15 = AND(t13,b);
  *y = XOR(t11,t08);
  *w = XOR(t15,t14);
  *x = XOR(t04,t05);

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
  t01 = OR(b,a);
  t02 = OR(c,b);
  t03 = XOR(t02,a);
  t04 = XOR(d,b);
  t05 = OR(t03,d);
  t06 = AND(t01,d);
  *z = XOR(t06,t03);
  t08 = AND(t04,*z);
  t09 = AND(t05,t04);
  t10 = XOR(t06,c);
  t11 = AND(c,b);
  t12 = XOR(t08,t04);
  t13 = OR(t03,t11);
  t14 = XOR(t09,t10);
  t15 = AND(t05,a);
  t16 = OR(t12,t11);
  *y = XOR(t08,t13);
  *x = XOR(t16,t15);
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
  t01 = XOR(d,b);
  t02 = OR(d,b);
  t03 = AND(t01,a);
  t04 = XOR(t02,c);
  t05 = XOR(t04,t03);
  *w = NOT(t05);
  t07 = XOR(t01,a);
  t08 = OR(*w,d);
  t09 = OR(t05,b);
  t10 = XOR(t08,d);
  t11 = OR(t07,b);
  t12 = OR(*w,t03);
  t13 = OR(t10,t07);
  t14 = XOR(t11,t01);
  *y = XOR(t13,t09);
  *x = XOR(t08,t07);
  *z = XOR(t14,t12);

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
  t01 = AND(d,a);
  t02 = XOR(c,b);
  t03 = XOR(d,a);
  t04 = XOR(t02,t01);
  t05 = OR(c,b);
  *x = NOT(t04);
  t07 = AND(t05,t03);
  t08 = AND(*x,b);
  t09 = OR(c,a);
  t10 = XOR(t08,t07);
  t11 = OR(d,b);
  t12 = XOR(t11,c);
  t13 = XOR(t10,t09);
  *y = NOT(t13);
  t15 = AND(t03,*x);
  *z = XOR(t07,t12);
  t17 = XOR(b,a);
  t18 = XOR(t15,*y);
  *w = XOR(t18,t17);

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
  t01 = AND(c,a);
  t02 = NOT(d);
  t03 = AND(t02,a);
  t04 = OR(t01,b);
  t05 = AND(b,a);
  t06 = XOR(t04,c);
  *z = XOR(t06,t03);
  t08 = OR(*z,c);
  t09 = OR(t05,d);
  t10 = XOR(t08,a);
  t11 = AND(*z,t04);
  *x = XOR(t10,t09);
  t13 = XOR(*x,b);
  t14 = XOR(*x,t01);
  t15 = XOR(t05,c);
  t16 = OR(t13,t11);
  t17 = OR(t14,t02);
  *w = XOR(t17,t15);
  *y = XOR(t16,a);

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
  _tmp1_ = XOR(x0__1__,input__1__);
  x1__1__ = XOR(x2__1__,_tmp1_);
  _tmp2_ = XOR(x2__1__,input__3__);
  _tmp3_ = L_SHIFT(x0__1__,3,32);
  x3__1__ = XOR(_tmp3_,_tmp2_);
  x1__2__ = L_ROTATE(x1__1__,1,32);
  x3__2__ = L_ROTATE(x3__1__,7,32);
  _tmp4_ = XOR(x1__2__,x0__1__);
  x0__2__ = XOR(x3__2__,_tmp4_);
  _tmp5_ = XOR(x3__2__,x2__1__);
  _tmp6_ = L_SHIFT(x1__2__,7,32);
  x2__2__ = XOR(_tmp6_,_tmp5_);
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
  DATATYPE _tmp1000_1;
  DATATYPE _tmp1000_2;
  DATATYPE _tmp1000_3;
  DATATYPE _tmp1000_4;
  DATATYPE _tmp1001_1;
  DATATYPE _tmp1001_2;
  DATATYPE _tmp1001_3;
  DATATYPE _tmp1001_4;
  DATATYPE _tmp1002_1;
  DATATYPE _tmp1002_2;
  DATATYPE _tmp1002_3;
  DATATYPE _tmp1002_4;
  DATATYPE _tmp1003_1;
  DATATYPE _tmp1003_2;
  DATATYPE _tmp1003_3;
  DATATYPE _tmp1003_4;
  DATATYPE _tmp1004_1;
  DATATYPE _tmp1004_2;
  DATATYPE _tmp1004_3;
  DATATYPE _tmp1004_4;
  DATATYPE _tmp1005_1;
  DATATYPE _tmp1005_2;
  DATATYPE _tmp1005_3;
  DATATYPE _tmp1005_4;
  DATATYPE _tmp1006_1;
  DATATYPE _tmp1006_2;
  DATATYPE _tmp1006_3;
  DATATYPE _tmp1006_4;
  DATATYPE _tmp1007_1;
  DATATYPE _tmp1007_2;
  DATATYPE _tmp1007_3;
  DATATYPE _tmp1007_4;
  DATATYPE _tmp1008_1;
  DATATYPE _tmp1008_2;
  DATATYPE _tmp1008_3;
  DATATYPE _tmp1008_4;
  DATATYPE _tmp1009_1;
  DATATYPE _tmp1009_2;
  DATATYPE _tmp1009_3;
  DATATYPE _tmp1009_4;
  DATATYPE _tmp1010_1;
  DATATYPE _tmp1010_2;
  DATATYPE _tmp1010_3;
  DATATYPE _tmp1010_4;
  DATATYPE _tmp1011_1;
  DATATYPE _tmp1011_2;
  DATATYPE _tmp1011_3;
  DATATYPE _tmp1011_4;
  DATATYPE _tmp1012_1;
  DATATYPE _tmp1012_2;
  DATATYPE _tmp1012_3;
  DATATYPE _tmp1012_4;
  DATATYPE _tmp1013_1;
  DATATYPE _tmp1013_2;
  DATATYPE _tmp1013_3;
  DATATYPE _tmp1013_4;
  DATATYPE _tmp1014_1;
  DATATYPE _tmp1014_2;
  DATATYPE _tmp1014_3;
  DATATYPE _tmp1014_4;
  DATATYPE _tmp1015_1;
  DATATYPE _tmp1015_2;
  DATATYPE _tmp1015_3;
  DATATYPE _tmp1015_4;
  DATATYPE _tmp1016_1;
  DATATYPE _tmp1016_2;
  DATATYPE _tmp1016_3;
  DATATYPE _tmp1016_4;
  DATATYPE _tmp1017_1;
  DATATYPE _tmp1017_2;
  DATATYPE _tmp1017_3;
  DATATYPE _tmp1017_4;
  DATATYPE _tmp1018_1;
  DATATYPE _tmp1018_2;
  DATATYPE _tmp1018_3;
  DATATYPE _tmp1018_4;
  DATATYPE _tmp1019_1;
  DATATYPE _tmp1019_2;
  DATATYPE _tmp1019_3;
  DATATYPE _tmp1019_4;
  DATATYPE _tmp1020_1;
  DATATYPE _tmp1020_2;
  DATATYPE _tmp1020_3;
  DATATYPE _tmp1020_4;
  DATATYPE _tmp1021_1;
  DATATYPE _tmp1021_2;
  DATATYPE _tmp1021_3;
  DATATYPE _tmp1021_4;
  DATATYPE _tmp1022_1;
  DATATYPE _tmp1022_2;
  DATATYPE _tmp1022_3;
  DATATYPE _tmp1022_4;
  DATATYPE _tmp1023_1;
  DATATYPE _tmp1023_2;
  DATATYPE _tmp1023_3;
  DATATYPE _tmp1023_4;
  DATATYPE _tmp1024_1;
  DATATYPE _tmp1024_2;
  DATATYPE _tmp1024_3;
  DATATYPE _tmp1024_4;
  DATATYPE _tmp1025_1;
  DATATYPE _tmp1025_2;
  DATATYPE _tmp1025_3;
  DATATYPE _tmp1025_4;
  DATATYPE _tmp1026_1;
  DATATYPE _tmp1026_2;
  DATATYPE _tmp1026_3;
  DATATYPE _tmp1026_4;
  DATATYPE _tmp1027_1;
  DATATYPE _tmp1027_2;
  DATATYPE _tmp1027_3;
  DATATYPE _tmp1027_4;
  DATATYPE _tmp1028_1;
  DATATYPE _tmp1028_2;
  DATATYPE _tmp1028_3;
  DATATYPE _tmp1028_4;
  DATATYPE _tmp1029_1;
  DATATYPE _tmp1029_2;
  DATATYPE _tmp1029_3;
  DATATYPE _tmp1029_4;
  DATATYPE _tmp1030_1;
  DATATYPE _tmp1030_2;
  DATATYPE _tmp1030_3;
  DATATYPE _tmp1030_4;
  DATATYPE _tmp967_1;
  DATATYPE _tmp967_2;
  DATATYPE _tmp967_3;
  DATATYPE _tmp967_4;
  DATATYPE _tmp968_1;
  DATATYPE _tmp968_2;
  DATATYPE _tmp968_3;
  DATATYPE _tmp968_4;
  DATATYPE _tmp969_1;
  DATATYPE _tmp969_2;
  DATATYPE _tmp969_3;
  DATATYPE _tmp969_4;
  DATATYPE _tmp970_1;
  DATATYPE _tmp970_2;
  DATATYPE _tmp970_3;
  DATATYPE _tmp970_4;
  DATATYPE _tmp971_1;
  DATATYPE _tmp971_2;
  DATATYPE _tmp971_3;
  DATATYPE _tmp971_4;
  DATATYPE _tmp972_1;
  DATATYPE _tmp972_2;
  DATATYPE _tmp972_3;
  DATATYPE _tmp972_4;
  DATATYPE _tmp973_1;
  DATATYPE _tmp973_2;
  DATATYPE _tmp973_3;
  DATATYPE _tmp973_4;
  DATATYPE _tmp974_1;
  DATATYPE _tmp974_2;
  DATATYPE _tmp974_3;
  DATATYPE _tmp974_4;
  DATATYPE _tmp975_1;
  DATATYPE _tmp975_2;
  DATATYPE _tmp975_3;
  DATATYPE _tmp975_4;
  DATATYPE _tmp976_1;
  DATATYPE _tmp976_2;
  DATATYPE _tmp976_3;
  DATATYPE _tmp976_4;
  DATATYPE _tmp977_1;
  DATATYPE _tmp977_2;
  DATATYPE _tmp977_3;
  DATATYPE _tmp977_4;
  DATATYPE _tmp978_1;
  DATATYPE _tmp978_2;
  DATATYPE _tmp978_3;
  DATATYPE _tmp978_4;
  DATATYPE _tmp979_1;
  DATATYPE _tmp979_2;
  DATATYPE _tmp979_3;
  DATATYPE _tmp979_4;
  DATATYPE _tmp980_1;
  DATATYPE _tmp980_2;
  DATATYPE _tmp980_3;
  DATATYPE _tmp980_4;
  DATATYPE _tmp981_1;
  DATATYPE _tmp981_2;
  DATATYPE _tmp981_3;
  DATATYPE _tmp981_4;
  DATATYPE _tmp982_1;
  DATATYPE _tmp982_2;
  DATATYPE _tmp982_3;
  DATATYPE _tmp982_4;
  DATATYPE _tmp983_1;
  DATATYPE _tmp983_2;
  DATATYPE _tmp983_3;
  DATATYPE _tmp983_4;
  DATATYPE _tmp984_1;
  DATATYPE _tmp984_2;
  DATATYPE _tmp984_3;
  DATATYPE _tmp984_4;
  DATATYPE _tmp985_1;
  DATATYPE _tmp985_2;
  DATATYPE _tmp985_3;
  DATATYPE _tmp985_4;
  DATATYPE _tmp986_1;
  DATATYPE _tmp986_2;
  DATATYPE _tmp986_3;
  DATATYPE _tmp986_4;
  DATATYPE _tmp987_1;
  DATATYPE _tmp987_2;
  DATATYPE _tmp987_3;
  DATATYPE _tmp987_4;
  DATATYPE _tmp988_1;
  DATATYPE _tmp988_2;
  DATATYPE _tmp988_3;
  DATATYPE _tmp988_4;
  DATATYPE _tmp989_1;
  DATATYPE _tmp989_2;
  DATATYPE _tmp989_3;
  DATATYPE _tmp989_4;
  DATATYPE _tmp990_1;
  DATATYPE _tmp990_2;
  DATATYPE _tmp990_3;
  DATATYPE _tmp990_4;
  DATATYPE _tmp991_1;
  DATATYPE _tmp991_2;
  DATATYPE _tmp991_3;
  DATATYPE _tmp991_4;
  DATATYPE _tmp992_1;
  DATATYPE _tmp992_2;
  DATATYPE _tmp992_3;
  DATATYPE _tmp992_4;
  DATATYPE _tmp993_1;
  DATATYPE _tmp993_2;
  DATATYPE _tmp993_3;
  DATATYPE _tmp993_4;
  DATATYPE _tmp994_1;
  DATATYPE _tmp994_2;
  DATATYPE _tmp994_3;
  DATATYPE _tmp994_4;
  DATATYPE _tmp995_1;
  DATATYPE _tmp995_2;
  DATATYPE _tmp995_3;
  DATATYPE _tmp995_4;
  DATATYPE _tmp996_1;
  DATATYPE _tmp996_2;
  DATATYPE _tmp996_3;
  DATATYPE _tmp996_4;
  DATATYPE _tmp997_1;
  DATATYPE _tmp997_2;
  DATATYPE _tmp997_3;
  DATATYPE _tmp997_4;
  DATATYPE _tmp998_1;
  DATATYPE _tmp998_2;
  DATATYPE _tmp998_3;
  DATATYPE _tmp998_4;
  DATATYPE _tmp999_1;
  DATATYPE _tmp999_2;
  DATATYPE _tmp999_3;
  DATATYPE _tmp999_4;
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
  _tmp967_1 = XOR(plaintext__[0],keys__[0][0]);
  _tmp967_2 = XOR(plaintext__[1],keys__[0][1]);
  _tmp967_3 = XOR(plaintext__[2],keys__[0][2]);
  _tmp967_4 = XOR(plaintext__[3],keys__[0][3]);
  sbox__0__(_tmp967_1,_tmp967_2,_tmp967_3,_tmp967_4,&_tmp968_1,&_tmp968_2,&_tmp968_3,&_tmp968_4);
  transform__(_tmp968_1,_tmp968_2,_tmp968_3,_tmp968_4,&tmp__1__0__,&tmp__1__1__,&tmp__1__2__,&tmp__1__3__);
  _tmp969_1 = XOR(tmp__1__0__,keys__[1][0]);
  _tmp969_2 = XOR(tmp__1__1__,keys__[1][1]);
  _tmp969_3 = XOR(tmp__1__2__,keys__[1][2]);
  _tmp969_4 = XOR(tmp__1__3__,keys__[1][3]);
  sbox__1__(_tmp969_1,_tmp969_2,_tmp969_3,_tmp969_4,&_tmp970_1,&_tmp970_2,&_tmp970_3,&_tmp970_4);
  transform__(_tmp970_1,_tmp970_2,_tmp970_3,_tmp970_4,&tmp__2__0__,&tmp__2__1__,&tmp__2__2__,&tmp__2__3__);
  _tmp971_1 = XOR(tmp__2__0__,keys__[2][0]);
  _tmp971_2 = XOR(tmp__2__1__,keys__[2][1]);
  _tmp971_3 = XOR(tmp__2__2__,keys__[2][2]);
  _tmp971_4 = XOR(tmp__2__3__,keys__[2][3]);
  sbox__2__(_tmp971_1,_tmp971_2,_tmp971_3,_tmp971_4,&_tmp972_1,&_tmp972_2,&_tmp972_3,&_tmp972_4);
  transform__(_tmp972_1,_tmp972_2,_tmp972_3,_tmp972_4,&tmp__3__0__,&tmp__3__1__,&tmp__3__2__,&tmp__3__3__);
  _tmp973_1 = XOR(tmp__3__0__,keys__[3][0]);
  _tmp973_2 = XOR(tmp__3__1__,keys__[3][1]);
  _tmp973_3 = XOR(tmp__3__2__,keys__[3][2]);
  _tmp973_4 = XOR(tmp__3__3__,keys__[3][3]);
  sbox__3__(_tmp973_1,_tmp973_2,_tmp973_3,_tmp973_4,&_tmp974_1,&_tmp974_2,&_tmp974_3,&_tmp974_4);
  transform__(_tmp974_1,_tmp974_2,_tmp974_3,_tmp974_4,&tmp__4__0__,&tmp__4__1__,&tmp__4__2__,&tmp__4__3__);
  _tmp975_1 = XOR(tmp__4__0__,keys__[4][0]);
  _tmp975_2 = XOR(tmp__4__1__,keys__[4][1]);
  _tmp975_3 = XOR(tmp__4__2__,keys__[4][2]);
  _tmp975_4 = XOR(tmp__4__3__,keys__[4][3]);
  sbox__4__(_tmp975_1,_tmp975_2,_tmp975_3,_tmp975_4,&_tmp976_1,&_tmp976_2,&_tmp976_3,&_tmp976_4);
  transform__(_tmp976_1,_tmp976_2,_tmp976_3,_tmp976_4,&tmp__5__0__,&tmp__5__1__,&tmp__5__2__,&tmp__5__3__);
  _tmp977_1 = XOR(tmp__5__0__,keys__[5][0]);
  _tmp977_2 = XOR(tmp__5__1__,keys__[5][1]);
  _tmp977_3 = XOR(tmp__5__2__,keys__[5][2]);
  _tmp977_4 = XOR(tmp__5__3__,keys__[5][3]);
  sbox__5__(_tmp977_1,_tmp977_2,_tmp977_3,_tmp977_4,&_tmp978_1,&_tmp978_2,&_tmp978_3,&_tmp978_4);
  transform__(_tmp978_1,_tmp978_2,_tmp978_3,_tmp978_4,&tmp__6__0__,&tmp__6__1__,&tmp__6__2__,&tmp__6__3__);
  _tmp979_1 = XOR(tmp__6__0__,keys__[6][0]);
  _tmp979_2 = XOR(tmp__6__1__,keys__[6][1]);
  _tmp979_3 = XOR(tmp__6__2__,keys__[6][2]);
  _tmp979_4 = XOR(tmp__6__3__,keys__[6][3]);
  sbox__6__(_tmp979_1,_tmp979_2,_tmp979_3,_tmp979_4,&_tmp980_1,&_tmp980_2,&_tmp980_3,&_tmp980_4);
  transform__(_tmp980_1,_tmp980_2,_tmp980_3,_tmp980_4,&tmp__7__0__,&tmp__7__1__,&tmp__7__2__,&tmp__7__3__);
  _tmp981_1 = XOR(tmp__7__0__,keys__[7][0]);
  _tmp981_2 = XOR(tmp__7__1__,keys__[7][1]);
  _tmp981_3 = XOR(tmp__7__2__,keys__[7][2]);
  _tmp981_4 = XOR(tmp__7__3__,keys__[7][3]);
  sbox__7__(_tmp981_1,_tmp981_2,_tmp981_3,_tmp981_4,&_tmp982_1,&_tmp982_2,&_tmp982_3,&_tmp982_4);
  transform__(_tmp982_1,_tmp982_2,_tmp982_3,_tmp982_4,&tmp__8__0__,&tmp__8__1__,&tmp__8__2__,&tmp__8__3__);
  _tmp983_1 = XOR(tmp__8__0__,keys__[8][0]);
  _tmp983_2 = XOR(tmp__8__1__,keys__[8][1]);
  _tmp983_3 = XOR(tmp__8__2__,keys__[8][2]);
  _tmp983_4 = XOR(tmp__8__3__,keys__[8][3]);
  sbox__0__(_tmp983_1,_tmp983_2,_tmp983_3,_tmp983_4,&_tmp984_1,&_tmp984_2,&_tmp984_3,&_tmp984_4);
  transform__(_tmp984_1,_tmp984_2,_tmp984_3,_tmp984_4,&tmp__9__0__,&tmp__9__1__,&tmp__9__2__,&tmp__9__3__);
  _tmp985_1 = XOR(tmp__9__0__,keys__[9][0]);
  _tmp985_2 = XOR(tmp__9__1__,keys__[9][1]);
  _tmp985_3 = XOR(tmp__9__2__,keys__[9][2]);
  _tmp985_4 = XOR(tmp__9__3__,keys__[9][3]);
  sbox__1__(_tmp985_1,_tmp985_2,_tmp985_3,_tmp985_4,&_tmp986_1,&_tmp986_2,&_tmp986_3,&_tmp986_4);
  transform__(_tmp986_1,_tmp986_2,_tmp986_3,_tmp986_4,&tmp__10__0__,&tmp__10__1__,&tmp__10__2__,&tmp__10__3__);
  _tmp987_1 = XOR(tmp__10__0__,keys__[10][0]);
  _tmp987_2 = XOR(tmp__10__1__,keys__[10][1]);
  _tmp987_3 = XOR(tmp__10__2__,keys__[10][2]);
  _tmp987_4 = XOR(tmp__10__3__,keys__[10][3]);
  sbox__2__(_tmp987_1,_tmp987_2,_tmp987_3,_tmp987_4,&_tmp988_1,&_tmp988_2,&_tmp988_3,&_tmp988_4);
  transform__(_tmp988_1,_tmp988_2,_tmp988_3,_tmp988_4,&tmp__11__0__,&tmp__11__1__,&tmp__11__2__,&tmp__11__3__);
  _tmp989_1 = XOR(tmp__11__0__,keys__[11][0]);
  _tmp989_2 = XOR(tmp__11__1__,keys__[11][1]);
  _tmp989_3 = XOR(tmp__11__2__,keys__[11][2]);
  _tmp989_4 = XOR(tmp__11__3__,keys__[11][3]);
  sbox__3__(_tmp989_1,_tmp989_2,_tmp989_3,_tmp989_4,&_tmp990_1,&_tmp990_2,&_tmp990_3,&_tmp990_4);
  transform__(_tmp990_1,_tmp990_2,_tmp990_3,_tmp990_4,&tmp__12__0__,&tmp__12__1__,&tmp__12__2__,&tmp__12__3__);
  _tmp991_1 = XOR(tmp__12__0__,keys__[12][0]);
  _tmp991_2 = XOR(tmp__12__1__,keys__[12][1]);
  _tmp991_3 = XOR(tmp__12__2__,keys__[12][2]);
  _tmp991_4 = XOR(tmp__12__3__,keys__[12][3]);
  sbox__4__(_tmp991_1,_tmp991_2,_tmp991_3,_tmp991_4,&_tmp992_1,&_tmp992_2,&_tmp992_3,&_tmp992_4);
  transform__(_tmp992_1,_tmp992_2,_tmp992_3,_tmp992_4,&tmp__13__0__,&tmp__13__1__,&tmp__13__2__,&tmp__13__3__);
  _tmp993_1 = XOR(tmp__13__0__,keys__[13][0]);
  _tmp993_2 = XOR(tmp__13__1__,keys__[13][1]);
  _tmp993_3 = XOR(tmp__13__2__,keys__[13][2]);
  _tmp993_4 = XOR(tmp__13__3__,keys__[13][3]);
  sbox__5__(_tmp993_1,_tmp993_2,_tmp993_3,_tmp993_4,&_tmp994_1,&_tmp994_2,&_tmp994_3,&_tmp994_4);
  transform__(_tmp994_1,_tmp994_2,_tmp994_3,_tmp994_4,&tmp__14__0__,&tmp__14__1__,&tmp__14__2__,&tmp__14__3__);
  _tmp995_1 = XOR(tmp__14__0__,keys__[14][0]);
  _tmp995_2 = XOR(tmp__14__1__,keys__[14][1]);
  _tmp995_3 = XOR(tmp__14__2__,keys__[14][2]);
  _tmp995_4 = XOR(tmp__14__3__,keys__[14][3]);
  sbox__6__(_tmp995_1,_tmp995_2,_tmp995_3,_tmp995_4,&_tmp996_1,&_tmp996_2,&_tmp996_3,&_tmp996_4);
  transform__(_tmp996_1,_tmp996_2,_tmp996_3,_tmp996_4,&tmp__15__0__,&tmp__15__1__,&tmp__15__2__,&tmp__15__3__);
  _tmp997_1 = XOR(tmp__15__0__,keys__[15][0]);
  _tmp997_2 = XOR(tmp__15__1__,keys__[15][1]);
  _tmp997_3 = XOR(tmp__15__2__,keys__[15][2]);
  _tmp997_4 = XOR(tmp__15__3__,keys__[15][3]);
  sbox__7__(_tmp997_1,_tmp997_2,_tmp997_3,_tmp997_4,&_tmp998_1,&_tmp998_2,&_tmp998_3,&_tmp998_4);
  transform__(_tmp998_1,_tmp998_2,_tmp998_3,_tmp998_4,&tmp__16__0__,&tmp__16__1__,&tmp__16__2__,&tmp__16__3__);
  _tmp999_1 = XOR(tmp__16__0__,keys__[16][0]);
  _tmp999_2 = XOR(tmp__16__1__,keys__[16][1]);
  _tmp999_3 = XOR(tmp__16__2__,keys__[16][2]);
  _tmp999_4 = XOR(tmp__16__3__,keys__[16][3]);
  sbox__0__(_tmp999_1,_tmp999_2,_tmp999_3,_tmp999_4,&_tmp1000_1,&_tmp1000_2,&_tmp1000_3,&_tmp1000_4);
  transform__(_tmp1000_1,_tmp1000_2,_tmp1000_3,_tmp1000_4,&tmp__17__0__,&tmp__17__1__,&tmp__17__2__,&tmp__17__3__);
  _tmp1001_1 = XOR(tmp__17__0__,keys__[17][0]);
  _tmp1001_2 = XOR(tmp__17__1__,keys__[17][1]);
  _tmp1001_3 = XOR(tmp__17__2__,keys__[17][2]);
  _tmp1001_4 = XOR(tmp__17__3__,keys__[17][3]);
  sbox__1__(_tmp1001_1,_tmp1001_2,_tmp1001_3,_tmp1001_4,&_tmp1002_1,&_tmp1002_2,&_tmp1002_3,&_tmp1002_4);
  transform__(_tmp1002_1,_tmp1002_2,_tmp1002_3,_tmp1002_4,&tmp__18__0__,&tmp__18__1__,&tmp__18__2__,&tmp__18__3__);
  _tmp1003_1 = XOR(tmp__18__0__,keys__[18][0]);
  _tmp1003_2 = XOR(tmp__18__1__,keys__[18][1]);
  _tmp1003_3 = XOR(tmp__18__2__,keys__[18][2]);
  _tmp1003_4 = XOR(tmp__18__3__,keys__[18][3]);
  sbox__2__(_tmp1003_1,_tmp1003_2,_tmp1003_3,_tmp1003_4,&_tmp1004_1,&_tmp1004_2,&_tmp1004_3,&_tmp1004_4);
  transform__(_tmp1004_1,_tmp1004_2,_tmp1004_3,_tmp1004_4,&tmp__19__0__,&tmp__19__1__,&tmp__19__2__,&tmp__19__3__);
  _tmp1005_1 = XOR(tmp__19__0__,keys__[19][0]);
  _tmp1005_2 = XOR(tmp__19__1__,keys__[19][1]);
  _tmp1005_3 = XOR(tmp__19__2__,keys__[19][2]);
  _tmp1005_4 = XOR(tmp__19__3__,keys__[19][3]);
  sbox__3__(_tmp1005_1,_tmp1005_2,_tmp1005_3,_tmp1005_4,&_tmp1006_1,&_tmp1006_2,&_tmp1006_3,&_tmp1006_4);
  transform__(_tmp1006_1,_tmp1006_2,_tmp1006_3,_tmp1006_4,&tmp__20__0__,&tmp__20__1__,&tmp__20__2__,&tmp__20__3__);
  _tmp1007_1 = XOR(tmp__20__0__,keys__[20][0]);
  _tmp1007_2 = XOR(tmp__20__1__,keys__[20][1]);
  _tmp1007_3 = XOR(tmp__20__2__,keys__[20][2]);
  _tmp1007_4 = XOR(tmp__20__3__,keys__[20][3]);
  sbox__4__(_tmp1007_1,_tmp1007_2,_tmp1007_3,_tmp1007_4,&_tmp1008_1,&_tmp1008_2,&_tmp1008_3,&_tmp1008_4);
  transform__(_tmp1008_1,_tmp1008_2,_tmp1008_3,_tmp1008_4,&tmp__21__0__,&tmp__21__1__,&tmp__21__2__,&tmp__21__3__);
  _tmp1009_1 = XOR(tmp__21__0__,keys__[21][0]);
  _tmp1009_2 = XOR(tmp__21__1__,keys__[21][1]);
  _tmp1009_3 = XOR(tmp__21__2__,keys__[21][2]);
  _tmp1009_4 = XOR(tmp__21__3__,keys__[21][3]);
  sbox__5__(_tmp1009_1,_tmp1009_2,_tmp1009_3,_tmp1009_4,&_tmp1010_1,&_tmp1010_2,&_tmp1010_3,&_tmp1010_4);
  transform__(_tmp1010_1,_tmp1010_2,_tmp1010_3,_tmp1010_4,&tmp__22__0__,&tmp__22__1__,&tmp__22__2__,&tmp__22__3__);
  _tmp1011_1 = XOR(tmp__22__0__,keys__[22][0]);
  _tmp1011_2 = XOR(tmp__22__1__,keys__[22][1]);
  _tmp1011_3 = XOR(tmp__22__2__,keys__[22][2]);
  _tmp1011_4 = XOR(tmp__22__3__,keys__[22][3]);
  sbox__6__(_tmp1011_1,_tmp1011_2,_tmp1011_3,_tmp1011_4,&_tmp1012_1,&_tmp1012_2,&_tmp1012_3,&_tmp1012_4);
  transform__(_tmp1012_1,_tmp1012_2,_tmp1012_3,_tmp1012_4,&tmp__23__0__,&tmp__23__1__,&tmp__23__2__,&tmp__23__3__);
  _tmp1013_1 = XOR(tmp__23__0__,keys__[23][0]);
  _tmp1013_2 = XOR(tmp__23__1__,keys__[23][1]);
  _tmp1013_3 = XOR(tmp__23__2__,keys__[23][2]);
  _tmp1013_4 = XOR(tmp__23__3__,keys__[23][3]);
  sbox__7__(_tmp1013_1,_tmp1013_2,_tmp1013_3,_tmp1013_4,&_tmp1014_1,&_tmp1014_2,&_tmp1014_3,&_tmp1014_4);
  transform__(_tmp1014_1,_tmp1014_2,_tmp1014_3,_tmp1014_4,&tmp__24__0__,&tmp__24__1__,&tmp__24__2__,&tmp__24__3__);
  _tmp1015_1 = XOR(tmp__24__0__,keys__[24][0]);
  _tmp1015_2 = XOR(tmp__24__1__,keys__[24][1]);
  _tmp1015_3 = XOR(tmp__24__2__,keys__[24][2]);
  _tmp1015_4 = XOR(tmp__24__3__,keys__[24][3]);
  sbox__0__(_tmp1015_1,_tmp1015_2,_tmp1015_3,_tmp1015_4,&_tmp1016_1,&_tmp1016_2,&_tmp1016_3,&_tmp1016_4);
  transform__(_tmp1016_1,_tmp1016_2,_tmp1016_3,_tmp1016_4,&tmp__25__0__,&tmp__25__1__,&tmp__25__2__,&tmp__25__3__);
  _tmp1017_1 = XOR(tmp__25__0__,keys__[25][0]);
  _tmp1017_2 = XOR(tmp__25__1__,keys__[25][1]);
  _tmp1017_3 = XOR(tmp__25__2__,keys__[25][2]);
  _tmp1017_4 = XOR(tmp__25__3__,keys__[25][3]);
  sbox__1__(_tmp1017_1,_tmp1017_2,_tmp1017_3,_tmp1017_4,&_tmp1018_1,&_tmp1018_2,&_tmp1018_3,&_tmp1018_4);
  transform__(_tmp1018_1,_tmp1018_2,_tmp1018_3,_tmp1018_4,&tmp__26__0__,&tmp__26__1__,&tmp__26__2__,&tmp__26__3__);
  _tmp1019_1 = XOR(tmp__26__0__,keys__[26][0]);
  _tmp1019_2 = XOR(tmp__26__1__,keys__[26][1]);
  _tmp1019_3 = XOR(tmp__26__2__,keys__[26][2]);
  _tmp1019_4 = XOR(tmp__26__3__,keys__[26][3]);
  sbox__2__(_tmp1019_1,_tmp1019_2,_tmp1019_3,_tmp1019_4,&_tmp1020_1,&_tmp1020_2,&_tmp1020_3,&_tmp1020_4);
  transform__(_tmp1020_1,_tmp1020_2,_tmp1020_3,_tmp1020_4,&tmp__27__0__,&tmp__27__1__,&tmp__27__2__,&tmp__27__3__);
  _tmp1021_1 = XOR(tmp__27__0__,keys__[27][0]);
  _tmp1021_2 = XOR(tmp__27__1__,keys__[27][1]);
  _tmp1021_3 = XOR(tmp__27__2__,keys__[27][2]);
  _tmp1021_4 = XOR(tmp__27__3__,keys__[27][3]);
  sbox__3__(_tmp1021_1,_tmp1021_2,_tmp1021_3,_tmp1021_4,&_tmp1022_1,&_tmp1022_2,&_tmp1022_3,&_tmp1022_4);
  transform__(_tmp1022_1,_tmp1022_2,_tmp1022_3,_tmp1022_4,&tmp__28__0__,&tmp__28__1__,&tmp__28__2__,&tmp__28__3__);
  _tmp1023_1 = XOR(tmp__28__0__,keys__[28][0]);
  _tmp1023_2 = XOR(tmp__28__1__,keys__[28][1]);
  _tmp1023_3 = XOR(tmp__28__2__,keys__[28][2]);
  _tmp1023_4 = XOR(tmp__28__3__,keys__[28][3]);
  sbox__4__(_tmp1023_1,_tmp1023_2,_tmp1023_3,_tmp1023_4,&_tmp1024_1,&_tmp1024_2,&_tmp1024_3,&_tmp1024_4);
  transform__(_tmp1024_1,_tmp1024_2,_tmp1024_3,_tmp1024_4,&tmp__29__0__,&tmp__29__1__,&tmp__29__2__,&tmp__29__3__);
  _tmp1025_1 = XOR(tmp__29__0__,keys__[29][0]);
  _tmp1025_2 = XOR(tmp__29__1__,keys__[29][1]);
  _tmp1025_3 = XOR(tmp__29__2__,keys__[29][2]);
  _tmp1025_4 = XOR(tmp__29__3__,keys__[29][3]);
  sbox__5__(_tmp1025_1,_tmp1025_2,_tmp1025_3,_tmp1025_4,&_tmp1026_1,&_tmp1026_2,&_tmp1026_3,&_tmp1026_4);
  transform__(_tmp1026_1,_tmp1026_2,_tmp1026_3,_tmp1026_4,&tmp__30__0__,&tmp__30__1__,&tmp__30__2__,&tmp__30__3__);
  _tmp1027_1 = XOR(tmp__30__0__,keys__[30][0]);
  _tmp1027_2 = XOR(tmp__30__1__,keys__[30][1]);
  _tmp1027_3 = XOR(tmp__30__2__,keys__[30][2]);
  _tmp1027_4 = XOR(tmp__30__3__,keys__[30][3]);
  sbox__6__(_tmp1027_1,_tmp1027_2,_tmp1027_3,_tmp1027_4,&_tmp1028_1,&_tmp1028_2,&_tmp1028_3,&_tmp1028_4);
  transform__(_tmp1028_1,_tmp1028_2,_tmp1028_3,_tmp1028_4,&tmp__31__0__,&tmp__31__1__,&tmp__31__2__,&tmp__31__3__);
  _tmp1029_1 = XOR(tmp__31__0__,keys__[31][0]);
  _tmp1029_2 = XOR(tmp__31__1__,keys__[31][1]);
  _tmp1029_3 = XOR(tmp__31__2__,keys__[31][2]);
  _tmp1029_4 = XOR(tmp__31__3__,keys__[31][3]);
  sbox__7__(_tmp1029_1,_tmp1029_2,_tmp1029_3,_tmp1029_4,&_tmp1030_1,&_tmp1030_2,&_tmp1030_3,&_tmp1030_4);
  ciphertext__[0] = XOR(_tmp1030_1,keys__[32][0]);
  ciphertext__[1] = XOR(_tmp1030_2,keys__[32][1]);
  ciphertext__[2] = XOR(_tmp1030_3,keys__[32][2]);
  ciphertext__[3] = XOR(_tmp1030_4,keys__[32][3]);

}


#define ROL(x,n) ((((unsigned long)(x))<<(n))| \
                  (((unsigned long)(x))>>(32-(n))))
#define PHI 0x9e3779b9
#define min(x,y) (((x)<(y))?(x):(y))
int serpent_convert_from_string(int len, const char *str, unsigned long *val);

/*  CORRECT */
int makeKey(const char* keyMaterial, unsigned long key[33][4]) {
  unsigned long i,j;
  unsigned long w[132],k[132];
  int rc;
  unsigned long key_int[8];

  int keyLen = 256;

  rc=serpent_convert_from_string(keyLen, keyMaterial, key_int);

  for(i=0; i<keyLen/32; i++)
    w[i]=key_int[i];
  if(keyLen<256)
    w[i]=(key_int[i]&((1L<<((keyLen&31)))-1))|(1L<<((keyLen&31)));
  for(i++; i<8; i++)
    w[i]=0;
  for(i=8; i<16; i++)
    w[i]=ROL(w[i-8]^w[i-5]^w[i-3]^w[i-1]^PHI^(i-8),11);
  for(i=0; i<8; i++)
    w[i]=w[i+8];
  for(i=8; i<132; i++)
    w[i]=ROL(w[i-8]^w[i-5]^w[i-3]^w[i-1]^PHI^i,11);

    
  sbox__3__(w[  0], w[  1], w[  2], w[  3], &k[  0], &k[  1], &k[  2], &k[  3]);
  sbox__2__(w[  4], w[  5], w[  6], w[  7], &k[  4], &k[  5], &k[  6], &k[  7]);
  sbox__1__(w[  8], w[  9], w[ 10], w[ 11], &k[  8], &k[  9], &k[ 10], &k[ 11]);
  sbox__0__(w[ 12], w[ 13], w[ 14], w[ 15], &k[ 12], &k[ 13], &k[ 14], &k[ 15]);
  sbox__7__(w[ 16], w[ 17], w[ 18], w[ 19], &k[ 16], &k[ 17], &k[ 18], &k[ 19]);
  sbox__6__(w[ 20], w[ 21], w[ 22], w[ 23], &k[ 20], &k[ 21], &k[ 22], &k[ 23]);
  sbox__5__(w[ 24], w[ 25], w[ 26], w[ 27], &k[ 24], &k[ 25], &k[ 26], &k[ 27]);
  sbox__4__(w[ 28], w[ 29], w[ 30], w[ 31], &k[ 28], &k[ 29], &k[ 30], &k[ 31]);
  sbox__3__(w[ 32], w[ 33], w[ 34], w[ 35], &k[ 32], &k[ 33], &k[ 34], &k[ 35]);
  sbox__2__(w[ 36], w[ 37], w[ 38], w[ 39], &k[ 36], &k[ 37], &k[ 38], &k[ 39]);
  sbox__1__(w[ 40], w[ 41], w[ 42], w[ 43], &k[ 40], &k[ 41], &k[ 42], &k[ 43]);
  sbox__0__(w[ 44], w[ 45], w[ 46], w[ 47], &k[ 44], &k[ 45], &k[ 46], &k[ 47]);
  sbox__7__(w[ 48], w[ 49], w[ 50], w[ 51], &k[ 48], &k[ 49], &k[ 50], &k[ 51]);
  sbox__6__(w[ 52], w[ 53], w[ 54], w[ 55], &k[ 52], &k[ 53], &k[ 54], &k[ 55]);
  sbox__5__(w[ 56], w[ 57], w[ 58], w[ 59], &k[ 56], &k[ 57], &k[ 58], &k[ 59]);
  sbox__4__(w[ 60], w[ 61], w[ 62], w[ 63], &k[ 60], &k[ 61], &k[ 62], &k[ 63]);
  sbox__3__(w[ 64], w[ 65], w[ 66], w[ 67], &k[ 64], &k[ 65], &k[ 66], &k[ 67]);
  sbox__2__(w[ 68], w[ 69], w[ 70], w[ 71], &k[ 68], &k[ 69], &k[ 70], &k[ 71]);
  sbox__1__(w[ 72], w[ 73], w[ 74], w[ 75], &k[ 72], &k[ 73], &k[ 74], &k[ 75]);
  sbox__0__(w[ 76], w[ 77], w[ 78], w[ 79], &k[ 76], &k[ 77], &k[ 78], &k[ 79]);
  sbox__7__(w[ 80], w[ 81], w[ 82], w[ 83], &k[ 80], &k[ 81], &k[ 82], &k[ 83]);
  sbox__6__(w[ 84], w[ 85], w[ 86], w[ 87], &k[ 84], &k[ 85], &k[ 86], &k[ 87]);
  sbox__5__(w[ 88], w[ 89], w[ 90], w[ 91], &k[ 88], &k[ 89], &k[ 90], &k[ 91]);
  sbox__4__(w[ 92], w[ 93], w[ 94], w[ 95], &k[ 92], &k[ 93], &k[ 94], &k[ 95]);
  sbox__3__(w[ 96], w[ 97], w[ 98], w[ 99], &k[ 96], &k[ 97], &k[ 98], &k[ 99]);
  sbox__2__(w[100], w[101], w[102], w[103], &k[100], &k[101], &k[102], &k[103]);
  sbox__1__(w[104], w[105], w[106], w[107], &k[104], &k[105], &k[106], &k[107]);
  sbox__0__(w[108], w[109], w[110], w[111], &k[108], &k[109], &k[110], &k[111]);
  sbox__7__(w[112], w[113], w[114], w[115], &k[112], &k[113], &k[114], &k[115]);
  sbox__6__(w[116], w[117], w[118], w[119], &k[116], &k[117], &k[118], &k[119]);
  sbox__5__(w[120], w[121], w[122], w[123], &k[120], &k[121], &k[122], &k[123]);
  sbox__4__(w[124], w[125], w[126], w[127], &k[124], &k[125], &k[126], &k[127]);
  sbox__3__(w[128], w[129], w[130], w[131], &k[128], &k[129], &k[130], &k[131]);

  //for (int i = 0; i < 8; i++) printf("%016lX\n", k[i]);
  
  
  for(i=0; i<=32; i++)
    for(j=0; j<4; j++)
      key[i][j] = k[4*i+j];

  return 1;
}

int serpent_convert_from_string(int len, const char *str, unsigned long *val)
/* the size of val must be at least the next multiple of 32 */
/* bits after len bits */
{
  int is, iv;
  int slen=min(strlen(str), (len+3)/4);

  if(len<0)
    return -1;		/* Error!!! */

  if(len>slen*4 || len<slen*4-3)
    return -1;		/* Error!!! */

  for(is=0; is<slen; is++)
    if(((str[is]<'0')||(str[is]>'9')) &&
       ((str[is]<'A')||(str[is]>'F')) &&
       ((str[is]<'a')||(str[is]>'f')))
      return -1;	/* Error!!! */

  for(is=slen, iv=0; is>=8; is-=8, iv++)
    {
      unsigned long t;
      sscanf(&str[is-8], "%08lX", &t);
      val[iv] = t;
    }
  if(is>0)
    {
      char tmp[10];
      unsigned long t;
      strncpy(tmp, str, is);
      tmp[is] = 0;
      sscanf(tmp, "%08lX", &t);
      val[iv++] = t;
    }
  for(; iv<(len+31)/32; iv++)
    val[iv] = 0;
  return iv;
}


#define NB_LOOP 10000000


int main() {

  char* key_base = "01234567" "89ABCDEF" "FEDCBA98" "76543210"
                   "01234567" "89ABCDEF" "FEDCBA98" "76543210";
  DATATYPE key[33][4];
  makeKey(key_base,key); /* it works! */

  unsigned long plain[4] = { 0x01234567, 0x89ABCDEF, 0xFEDCBA98, 0x76543210 };
  unsigned long cipher[4];
  Serpent__(plain,key,cipher);
  for (int i = 0; i < 4; i++) printf("%lX\n",cipher[i]);
  

  return 0;
}
