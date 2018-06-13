
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
void AES__ (/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
  
  // Variables declaration
  DATATYPE MixColumn___1__tmp10_;
  DATATYPE MixColumn___1__tmp11_;
  DATATYPE MixColumn___1__tmp16_;
  DATATYPE MixColumn___1__tmp17_;
  DATATYPE MixColumn___1__tmp18_;
  DATATYPE MixColumn___1__tmp20_;
  DATATYPE MixColumn___1__tmp21_;
  DATATYPE MixColumn___1__tmp24_;
  DATATYPE MixColumn___1__tmp25_;
  DATATYPE MixColumn___1__tmp27_;
  DATATYPE MixColumn___1__tmp28_;
  DATATYPE MixColumn___1__tmp33_;
  DATATYPE MixColumn___1__tmp34_;
  DATATYPE MixColumn___1__tmp35_;
  DATATYPE MixColumn___1__tmp37_;
  DATATYPE MixColumn___1__tmp38_;
  DATATYPE MixColumn___1__tmp43_;
  DATATYPE MixColumn___1__tmp44_;
  DATATYPE MixColumn___1__tmp45_;
  DATATYPE MixColumn___1__tmp47_;
  DATATYPE MixColumn___1__tmp48_;
  DATATYPE MixColumn___1__tmp51_;
  DATATYPE MixColumn___1__tmp52_;
  DATATYPE MixColumn___1__tmp54_;
  DATATYPE MixColumn___1__tmp55_;
  DATATYPE MixColumn___1__tmp58_;
  DATATYPE MixColumn___1__tmp59_;
  DATATYPE MixColumn___1__tmp5_;
  DATATYPE MixColumn___1__tmp61_;
  DATATYPE MixColumn___1__tmp62_;
  DATATYPE MixColumn___1__tmp66_;
  DATATYPE MixColumn___1__tmp69_;
  DATATYPE MixColumn___1__tmp6_;
  DATATYPE MixColumn___1__tmp7_;
  DATATYPE MixColumn___1__tmp8_;
  DATATYPE _tmp70_[8];
  DATATYPE _tmp71_[8];
  DATATYPE _tmp72_[8];
  DATATYPE _tmp73_[8];
  DATATYPE _tmp74_[8];
  DATATYPE tmp__[10][8];


  // Instructions (body)
  tmp__[0][0] = XOR(plain__[0],key__[0][0]);
  tmp__[0][1] = XOR(plain__[1],key__[0][1]);
  tmp__[0][2] = XOR(plain__[2],key__[0][2]);
  tmp__[0][3] = XOR(plain__[3],key__[0][3]);
  tmp__[0][4] = XOR(plain__[4],key__[0][4]);
  tmp__[0][5] = XOR(plain__[5],key__[0][5]);
  tmp__[0][6] = XOR(plain__[6],key__[0][6]);
  tmp__[0][7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
    SubBytes_single__(tmp__[(i - 1)][0],tmp__[(i - 1)][1],tmp__[(i - 1)][2],tmp__[(i - 1)][3],tmp__[(i - 1)][4],tmp__[(i - 1)][5],tmp__[(i - 1)][6],tmp__[(i - 1)][7],&_tmp70_[0],&_tmp70_[1],&_tmp70_[2],&_tmp70_[3],&_tmp70_[4],&_tmp70_[5],&_tmp70_[6],&_tmp70_[7]);
    for (int i = 0; i <= 7; i++) {
      _tmp71_[i] = PERMUT_16(_tmp70_[i],0,1,2,3,5,6,7,4,10,11,8,9,15,12,13,14);
    }
    MixColumn___1__tmp5_ = PERMUT_4(_tmp71_[0],1,2,3,0);
    MixColumn___1__tmp6_ = XOR(MixColumn___1__tmp5_,_tmp71_[0]);
    MixColumn___1__tmp7_ = PERMUT_4(_tmp71_[7],1,2,3,0);
    MixColumn___1__tmp8_ = XOR(MixColumn___1__tmp7_,MixColumn___1__tmp6_);
    MixColumn___1__tmp10_ = XOR(MixColumn___1__tmp7_,_tmp71_[7]);
    MixColumn___1__tmp11_ = PERMUT_4(MixColumn___1__tmp10_,2,3,0,1);
    _tmp72_[7] = XOR(MixColumn___1__tmp11_,MixColumn___1__tmp8_);
    MixColumn___1__tmp16_ = XOR(MixColumn___1__tmp6_,MixColumn___1__tmp10_);
    MixColumn___1__tmp17_ = PERMUT_4(_tmp71_[6],1,2,3,0);
    MixColumn___1__tmp18_ = XOR(MixColumn___1__tmp17_,MixColumn___1__tmp16_);
    MixColumn___1__tmp20_ = XOR(MixColumn___1__tmp17_,_tmp71_[6]);
    MixColumn___1__tmp21_ = PERMUT_4(MixColumn___1__tmp20_,2,3,0,1);
    _tmp72_[6] = XOR(MixColumn___1__tmp21_,MixColumn___1__tmp18_);
    MixColumn___1__tmp24_ = PERMUT_4(_tmp71_[5],1,2,3,0);
    MixColumn___1__tmp25_ = XOR(MixColumn___1__tmp24_,MixColumn___1__tmp20_);
    MixColumn___1__tmp27_ = XOR(MixColumn___1__tmp24_,_tmp71_[5]);
    MixColumn___1__tmp28_ = PERMUT_4(MixColumn___1__tmp27_,2,3,0,1);
    _tmp72_[5] = XOR(MixColumn___1__tmp28_,MixColumn___1__tmp25_);
    MixColumn___1__tmp33_ = XOR(MixColumn___1__tmp6_,MixColumn___1__tmp27_);
    MixColumn___1__tmp34_ = PERMUT_4(_tmp71_[4],1,2,3,0);
    MixColumn___1__tmp35_ = XOR(MixColumn___1__tmp34_,MixColumn___1__tmp33_);
    MixColumn___1__tmp37_ = XOR(MixColumn___1__tmp34_,_tmp71_[4]);
    MixColumn___1__tmp38_ = PERMUT_4(MixColumn___1__tmp37_,2,3,0,1);
    _tmp72_[4] = XOR(MixColumn___1__tmp38_,MixColumn___1__tmp35_);
    MixColumn___1__tmp43_ = XOR(MixColumn___1__tmp6_,MixColumn___1__tmp37_);
    MixColumn___1__tmp44_ = PERMUT_4(_tmp71_[3],1,2,3,0);
    MixColumn___1__tmp45_ = XOR(MixColumn___1__tmp44_,MixColumn___1__tmp43_);
    MixColumn___1__tmp47_ = XOR(MixColumn___1__tmp44_,_tmp71_[3]);
    MixColumn___1__tmp48_ = PERMUT_4(MixColumn___1__tmp47_,2,3,0,1);
    _tmp72_[3] = XOR(MixColumn___1__tmp48_,MixColumn___1__tmp45_);
    MixColumn___1__tmp51_ = PERMUT_4(_tmp71_[2],1,2,3,0);
    MixColumn___1__tmp52_ = XOR(MixColumn___1__tmp51_,MixColumn___1__tmp47_);
    MixColumn___1__tmp54_ = XOR(MixColumn___1__tmp51_,_tmp71_[2]);
    MixColumn___1__tmp55_ = PERMUT_4(MixColumn___1__tmp54_,2,3,0,1);
    _tmp72_[2] = XOR(MixColumn___1__tmp55_,MixColumn___1__tmp52_);
    MixColumn___1__tmp58_ = PERMUT_4(_tmp71_[1],1,2,3,0);
    MixColumn___1__tmp59_ = XOR(MixColumn___1__tmp58_,MixColumn___1__tmp54_);
    MixColumn___1__tmp61_ = XOR(MixColumn___1__tmp58_,_tmp71_[1]);
    MixColumn___1__tmp62_ = PERMUT_4(MixColumn___1__tmp61_,2,3,0,1);
    _tmp72_[1] = XOR(MixColumn___1__tmp62_,MixColumn___1__tmp59_);
    MixColumn___1__tmp66_ = XOR(MixColumn___1__tmp5_,MixColumn___1__tmp61_);
    MixColumn___1__tmp69_ = PERMUT_4(MixColumn___1__tmp6_,2,3,0,1);
    _tmp72_[0] = XOR(MixColumn___1__tmp69_,MixColumn___1__tmp66_);
    tmp__[i][0] = XOR(_tmp72_[0],key__[i][0]);
    tmp__[i][1] = XOR(_tmp72_[1],key__[i][1]);
    tmp__[i][2] = XOR(_tmp72_[2],key__[i][2]);
    tmp__[i][3] = XOR(_tmp72_[3],key__[i][3]);
    tmp__[i][4] = XOR(_tmp72_[4],key__[i][4]);
    tmp__[i][5] = XOR(_tmp72_[5],key__[i][5]);
    tmp__[i][6] = XOR(_tmp72_[6],key__[i][6]);
    tmp__[i][7] = XOR(_tmp72_[7],key__[i][7]);
  }
  SubBytes_single__(tmp__[9][0],tmp__[9][1],tmp__[9][2],tmp__[9][3],tmp__[9][4],tmp__[9][5],tmp__[9][6],tmp__[9][7],&_tmp73_[0],&_tmp73_[1],&_tmp73_[2],&_tmp73_[3],&_tmp73_[4],&_tmp73_[5],&_tmp73_[6],&_tmp73_[7]);
  for (int i = 0; i <= 7; i++) {
    _tmp74_[i] = PERMUT_16(_tmp73_[i],0,1,2,3,5,6,7,4,10,11,8,9,15,12,13,14);
  }
  cipher__[0] = XOR(_tmp74_[0],key__[10][0]);
  cipher__[1] = XOR(_tmp74_[1],key__[10][1]);
  cipher__[2] = XOR(_tmp74_[2],key__[10][2]);
  cipher__[3] = XOR(_tmp74_[3],key__[10][3]);
  cipher__[4] = XOR(_tmp74_[4],key__[10][4]);
  cipher__[5] = XOR(_tmp74_[5],key__[10][5]);
  cipher__[6] = XOR(_tmp74_[6],key__[10][6]);
  cipher__[7] = XOR(_tmp74_[7],key__[10][7]);

}
 