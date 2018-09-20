/* SBOX:
     0 -> Kivilinna/K&S (C SSA)
     1 -> Kivilinna/K&S (C)
     2 -> Usuba/Canright (C)
     3 -> Kivilinna/K&S (ASM)
     4 -> Usuba/Canright (ASM)
*/

/* Do NOT change the order of those define/include */
#define NO_RUNTIME
#ifndef BITS_PER_REG
#define BITS_PER_REG 128
#endif

#ifdef _IACA
#include "iacaMarks.h"
#endif

/* including the architecture specific .h */
#include "SSE.h"
#ifndef SBOX
#error Sbox not defined
#elif defined NO_SBOX

static inline void SubBytes__ (/*inputs*/ DATATYPE U0,DATATYPE U1,DATATYPE U2,DATATYPE U3,DATATYPE U4,DATATYPE U5,DATATYPE U6,DATATYPE U7, /*outputs*/ DATATYPE* S0,DATATYPE* S1,DATATYPE* S2,DATATYPE* S3,DATATYPE* S4,DATATYPE* S5,DATATYPE* S6,DATATYPE* S7) {
  *S0 = U0;
  *S1 = U1;
  *S2 = U2;
  *S3 = U3;
  *S4 = U4;
  *S5 = U5;
  *S6 = U6;
  *S7 = U7;
}
#elif SBOX == 0

static inline void SubBytes__ (/*inputs*/ DATATYPE xmm7,DATATYPE xmm6,DATATYPE xmm5,DATATYPE xmm4,DATATYPE xmm3,DATATYPE xmm2,DATATYPE xmm1,DATATYPE xmm0, /*outputs*/ DATATYPE* S7,DATATYPE* S6,DATATYPE* S5,DATATYPE* S4,DATATYPE* S3,DATATYPE* S2,DATATYPE* S1,DATATYPE* S0) {

    DATATYPE xmm8 = XOR(xmm6,xmm5);     
    DATATYPE xmm9 = XOR(xmm1,xmm2);     
    DATATYPE xmm10 = XOR(xmm0,xmm8);     
    DATATYPE xmm11 = XOR(xmm9,xmm6);     
    DATATYPE xmm12 = XOR(xmm0,xmm3);     
    DATATYPE xmm13 = XOR(xmm12,xmm11);     
    DATATYPE xmm14 = XOR(xmm7,xmm12);     
    DATATYPE xmm15 = XOR(xmm10,xmm7);     
    DATATYPE xmm16 = XOR(xmm4,xmm14);     
    DATATYPE xmm17 = XOR(xmm10,xmm4);     
    DATATYPE xmm18 = XOR(xmm1,xmm16);     
    DATATYPE xmm19 = XOR(xmm15,xmm9);     
    DATATYPE xmm20 = XOR(xmm10,xmm1);     
    DATATYPE xmm21 = XOR(xmm15,xmm17);    
    DATATYPE xmm22 = XOR(xmm20,xmm19);    
    DATATYPE xmm23 = XOR(xmm10,xmm18);     
    DATATYPE xmm24 = XOR(xmm19,xmm17);    
    DATATYPE xmm25 = XOR(xmm13,xmm0);    
    DATATYPE xmm26 = XOR(xmm21,xmm22);  
    DATATYPE xmm27 = AND(xmm22,xmm23);    
    DATATYPE xmm28 = OR(xmm23,xmm22);    
    DATATYPE xmm29 = AND(xmm21,xmm25);  
    DATATYPE xmm30 = OR(xmm25,xmm21);   
    DATATYPE xmm31 = XOR(xmm23,xmm25);   
    DATATYPE xmm32 = AND(xmm31,xmm26);  
    DATATYPE xmm33 = XOR(xmm18,xmm0);    
    DATATYPE xmm34 = AND(xmm33,xmm24);  
    DATATYPE xmm35 = XOR(xmm34,xmm30);  
    DATATYPE xmm36 = XOR(xmm34,xmm28);  
    DATATYPE xmm37 = XOR(xmm15,xmm20);    
    DATATYPE xmm38 = XOR(xmm10,xmm13);    
    DATATYPE xmm39 = OR(xmm37,xmm38);    
    DATATYPE xmm40 = AND(xmm38,xmm37);  
    DATATYPE xmm41 = XOR(xmm40,xmm27);    
    DATATYPE xmm42 = XOR(xmm32,xmm35);  
    DATATYPE xmm43 = XOR(xmm29,xmm36);  
    DATATYPE xmm44 = XOR(xmm32,xmm39);    
    DATATYPE xmm45 = XOR(xmm29,xmm41);    
    DATATYPE xmm46 = XOR(xmm29,xmm44);    
    DATATYPE xmm47 = AND(xmm19,xmm18);    
    DATATYPE xmm48 = AND(xmm17,xmm0);    
    DATATYPE xmm49 = AND(xmm20,xmm10);    
    DATATYPE xmm50 = OR(xmm15,xmm13);     
    DATATYPE xmm51 = XOR(xmm47,xmm42);  
    DATATYPE xmm52 = XOR(xmm48,xmm43);  
    DATATYPE xmm53 = XOR(xmm49,xmm46);    
    DATATYPE xmm54 = XOR(xmm50,xmm45);    
    DATATYPE xmm55 = XOR(xmm51,xmm52);  
    DATATYPE xmm56 = AND(xmm53,xmm51);   
    DATATYPE xmm57 = XOR(xmm54,xmm56);   
    DATATYPE xmm58 = AND(xmm55,xmm57);  
    DATATYPE xmm59 = XOR(xmm52,xmm58);  
    DATATYPE xmm60 = XOR(xmm53,xmm54);    
    DATATYPE xmm61 = XOR(xmm52,xmm56);  
    DATATYPE xmm62 = AND(xmm61,xmm60);  
    DATATYPE xmm63 = XOR(xmm54,xmm62);   
    DATATYPE xmm64 = XOR(xmm63,xmm53);    
    DATATYPE xmm65 = XOR(xmm57,xmm63);  
    DATATYPE xmm66 = AND(xmm54,xmm65);   
    DATATYPE xmm67 = XOR(xmm66,xmm64);    
    DATATYPE xmm68 = XOR(xmm66,xmm57);  
    DATATYPE xmm69 = AND(xmm59,xmm68);  
    DATATYPE xmm70 = XOR(xmm55,xmm69);  
    DATATYPE xmm71 = XOR(xmm59,xmm70);  
    DATATYPE xmm72 = AND(xmm13,xmm71);   
    DATATYPE xmm73 = XOR(xmm13,xmm10);    
    DATATYPE xmm74 = AND(xmm70,xmm73);  
    DATATYPE xmm75 = AND(xmm10,xmm59);    
    DATATYPE xmm76 = XOR(xmm75,xmm74);   
    DATATYPE xmm77 = XOR(xmm72,xmm75);    
    DATATYPE xmm78 = XOR(xmm0,xmm13);     
    DATATYPE xmm79 = XOR(xmm18,xmm10);     
    DATATYPE xmm80 = XOR(xmm63,xmm59);  
    DATATYPE xmm81 = XOR(xmm67,xmm70);   
    DATATYPE xmm82 = XOR(xmm80,xmm81);  
    DATATYPE xmm83 = AND(xmm78,xmm82);   
    DATATYPE xmm84 = XOR(xmm79,xmm78);     
    DATATYPE xmm85 = AND(xmm81,xmm84);    
    DATATYPE xmm86 = AND(xmm80,xmm79);    
    DATATYPE xmm87 = XOR(xmm85,xmm86);     
    DATATYPE xmm88 = XOR(xmm83,xmm85);    
    DATATYPE xmm89 = XOR(xmm63,xmm67);   
    DATATYPE xmm90 = AND(xmm0,xmm89);   
    DATATYPE xmm91 = XOR(xmm0,xmm18);     
    DATATYPE xmm92 = AND(xmm67,xmm91);     
    DATATYPE xmm93 = AND(xmm18,xmm63);    
    DATATYPE xmm94 = XOR(xmm93,xmm92);     
    DATATYPE xmm95 = XOR(xmm90,xmm93);    
    DATATYPE xmm96 = XOR(xmm88,xmm94);     
    DATATYPE xmm97 = XOR(xmm76,xmm88);    
    DATATYPE xmm98 = XOR(xmm87,xmm95);     
    DATATYPE xmm99 = XOR(xmm77,xmm87);     
    DATATYPE xmm100 = XOR(xmm15,xmm17);    
    DATATYPE xmm101 = XOR(xmm20,xmm19);     
    DATATYPE xmm102 = XOR(xmm80,xmm81);  
    DATATYPE xmm103 = AND(xmm100,xmm102);  
    DATATYPE xmm104 = XOR(xmm101,xmm100);   
    DATATYPE xmm105 = AND(xmm81,xmm104);  
    DATATYPE xmm106 = AND(xmm80,xmm101);    
    DATATYPE xmm107 = XOR(xmm105,xmm106);    
    DATATYPE xmm108 = XOR(xmm103,xmm105);  
    DATATYPE xmm109 = XOR(xmm63,xmm67);   
    DATATYPE xmm110 = AND(xmm17,xmm109);   
    DATATYPE xmm111 = XOR(xmm17,xmm19);     
    DATATYPE xmm112 = AND(xmm67,xmm111);     
    DATATYPE xmm113 = AND(xmm19,xmm63);    
    DATATYPE xmm114 = XOR(xmm113,xmm112);     
    DATATYPE xmm115 = XOR(xmm110,xmm113);    
    DATATYPE xmm116 = XOR(xmm63,xmm80);  
    DATATYPE xmm117 = XOR(xmm67,xmm81);   
    DATATYPE xmm118 = XOR(xmm116,xmm117);  
    DATATYPE xmm119 = AND(xmm15,xmm118);   
    DATATYPE xmm120 = XOR(xmm15,xmm20);     
    DATATYPE xmm121 = AND(xmm117,xmm120);    
    DATATYPE xmm122 = AND(xmm20,xmm116);    
    DATATYPE xmm123 = XOR(xmm122,xmm121);     
    DATATYPE xmm124 = XOR(xmm119,xmm122);    
    DATATYPE xmm125 = XOR(xmm108,xmm123);    
    DATATYPE xmm126 = XOR(xmm108,xmm114);    
    DATATYPE xmm127 = XOR(xmm107,xmm124);     
    DATATYPE xmm128 = XOR(xmm107,xmm115);     
    DATATYPE xmm129 = XOR(xmm125,xmm96);     
    DATATYPE xmm130 = XOR(xmm127,xmm97);     
    DATATYPE xmm131 = XOR(xmm126,xmm129);    
    DATATYPE xmm132 = XOR(xmm97,xmm96);    
    DATATYPE xmm133 = XOR(xmm96,xmm130);     
    DATATYPE xmm134 = XOR(xmm99,xmm130);     
    DATATYPE xmm135 = XOR(xmm99,xmm128);     
    DATATYPE xmm136 = XOR(xmm128,xmm98);     
    DATATYPE xmm137 = XOR(xmm131,xmm135);    
    DATATYPE xmm138 = XOR(xmm98,xmm135);     
    DATATYPE xmm139 = XOR(xmm132,xmm138);    
    *S0 = (xmm133);
    *S1 = (xmm134);
    *S2 = xmm137;
    *S3 = xmm139;
    *S4 = xmm138;
    *S5 = (xmm129);
    *S6 = (xmm136);
    *S7 = xmm135;
}

#elif SBOX == 1

static inline void SubBytes__ (/*inputs*/ DATATYPE xmm7,DATATYPE xmm6,DATATYPE xmm5,DATATYPE xmm4,DATATYPE xmm3,DATATYPE xmm2,DATATYPE xmm1,DATATYPE xmm0, /*outputs*/ DATATYPE* S7,DATATYPE* S6,DATATYPE* S5,DATATYPE* S4,DATATYPE* S3,DATATYPE* S2,DATATYPE* S1,DATATYPE* S0) {
    DATATYPE xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15;  \
    xmm5 = XOR(xmm6,xmm5);     
    xmm2 = XOR(xmm1,xmm2);     
    xmm8 = XOR(xmm0,xmm5);     
    xmm6 = XOR(xmm2,xmm6);     
    xmm3 = XOR(xmm0,xmm3);     
    xmm6 = XOR(xmm3,xmm6);     
    xmm3 = XOR(xmm7,xmm3);     
    xmm7 = XOR(xmm8,xmm7);     
    xmm3 = XOR(xmm4,xmm3);     
    xmm4 = XOR(xmm8,xmm4);     
    xmm3 = XOR(xmm1,xmm3);     
    xmm2 = XOR(xmm7,xmm2);     
    xmm1 = XOR(xmm8,xmm1);     
    xmm11 = XOR(xmm7,xmm4);    
    xmm10 = XOR(xmm1,xmm2);    
    xmm9 = XOR(xmm8,xmm3);     
    xmm13 = XOR(xmm2,xmm4);    
    xmm12 = XOR(xmm6,xmm0);    
    xmm15 = XOR(xmm11,xmm10);  
    xmm5 = AND(xmm10,xmm9);    
    xmm10 = OR(xmm9,xmm10);    
    xmm14 = AND(xmm11,xmm12);  
    xmm11 = OR(xmm12,xmm11);   
    xmm12 = XOR(xmm9,xmm12);   
    xmm15 = AND(xmm12,xmm15);  
    xmm12 = XOR(xmm3,xmm0);    
    xmm13 = AND(xmm12,xmm13);  
    xmm11 = XOR(xmm13,xmm11);  
    xmm10 = XOR(xmm13,xmm10);  
    xmm13 = XOR(xmm7,xmm1);    
    xmm12 = XOR(xmm8,xmm6);    
    xmm9 = OR(xmm13,xmm12);    
    xmm13 = AND(xmm12,xmm13);  
    xmm5 = XOR(xmm13,xmm5);    
    xmm11 = XOR(xmm15,xmm11);  
    xmm10 = XOR(xmm14,xmm10);  
    xmm9 = XOR(xmm15,xmm9);    
    xmm5 = XOR(xmm14,xmm5);    
    xmm9 = XOR(xmm14,xmm9);    
    xmm12 = AND(xmm2,xmm3);    
    xmm13 = AND(xmm4,xmm0);    
    xmm14 = AND(xmm1,xmm8);    
    xmm15 = OR(xmm7,xmm6);     
    xmm11 = XOR(xmm12,xmm11);  
    xmm10 = XOR(xmm13,xmm10);  
    xmm9 = XOR(xmm14,xmm9);    
    xmm5 = XOR(xmm15,xmm5);    
    xmm12 = XOR(xmm11,xmm10);  
    xmm11 = AND(xmm9,xmm11);   
    xmm14 = XOR(xmm5,xmm11);   
    xmm15 = AND(xmm12,xmm14);  
    xmm15 = XOR(xmm10,xmm15);  
    xmm13 = XOR(xmm9,xmm5);    
    xmm11 = XOR(xmm10,xmm11);  
    xmm13 = AND(xmm11,xmm13);  
    xmm13 = XOR(xmm5,xmm13);   
    xmm9 = XOR(xmm13,xmm9);    
    xmm10 = XOR(xmm14,xmm13);  
    xmm10 = AND(xmm5,xmm10);   
    xmm9 = XOR(xmm10,xmm9);    
    xmm14 = XOR(xmm10,xmm14);  
    xmm14 = AND(xmm15,xmm14);  
    xmm14 = XOR(xmm12,xmm14);  
    xmm10 = XOR(xmm15,xmm14);  
    xmm10 = AND(xmm6,xmm10);   
    xmm12 = XOR(xmm6,xmm8);    
    xmm12 = AND(xmm14,xmm12);  
    xmm5 = AND(xmm8,xmm15);    
    xmm12 = XOR(xmm5,xmm12);   
    xmm5 = XOR(xmm10,xmm5);    
    xmm6 = XOR(xmm0,xmm6);     
    xmm8 = XOR(xmm3,xmm8);     
    xmm15 = XOR(xmm13,xmm15);  
    xmm14 = XOR(xmm9,xmm14);   
    xmm11 = XOR(xmm15,xmm14);  
    xmm11 = AND(xmm6,xmm11);   
    xmm6 = XOR(xmm8,xmm6);     
    xmm6 = AND(xmm14,xmm6);    
    xmm8 = AND(xmm15,xmm8);    
    xmm8 = XOR(xmm6,xmm8);     
    xmm6 = XOR(xmm11,xmm6);    
    xmm10 = XOR(xmm13,xmm9);   
    xmm10 = AND(xmm0,xmm10);   
    xmm0 = XOR(xmm0,xmm3);     
    xmm0 = AND(xmm9,xmm0);     
    xmm3 = AND(xmm3,xmm13);    
    xmm0 = XOR(xmm3,xmm0);     
    xmm3 = XOR(xmm10,xmm3);    
    xmm0 = XOR(xmm6,xmm0);     
    xmm6 = XOR(xmm12,xmm6);    
    xmm3 = XOR(xmm8,xmm3);     
    xmm8 = XOR(xmm5,xmm8);     
    xmm12 = XOR(xmm7,xmm4);    
    xmm5 = XOR(xmm1,xmm2);     
    xmm11 = XOR(xmm15,xmm14);  
    xmm11 = AND(xmm12,xmm11);  
    xmm12 = XOR(xmm5,xmm12);   
    xmm12 = AND(xmm14,xmm12);  
    xmm5 = AND(xmm15,xmm5);    
    xmm5 = XOR(xmm12,xmm5);    
    xmm12 = XOR(xmm11,xmm12);  
    xmm10 = XOR(xmm13,xmm9);   
    xmm10 = AND(xmm4,xmm10);   
    xmm4 = XOR(xmm4,xmm2);     
    xmm4 = AND(xmm9,xmm4);     
    xmm2 = AND(xmm2,xmm13);    
    xmm4 = XOR(xmm2,xmm4);     
    xmm2 = XOR(xmm10,xmm2);    
    xmm15 = XOR(xmm13,xmm15);  
    xmm14 = XOR(xmm9,xmm14);   
    xmm11 = XOR(xmm15,xmm14);  
    xmm11 = AND(xmm7,xmm11);   
    xmm7 = XOR(xmm7,xmm1);     
    xmm7 = AND(xmm14,xmm7);    
    xmm1 = AND(xmm1,xmm15);    
    xmm7 = XOR(xmm1,xmm7);     
    xmm1 = XOR(xmm11,xmm1);    
    xmm7 = XOR(xmm12,xmm7);    
    xmm4 = XOR(xmm12,xmm4);    
    xmm1 = XOR(xmm5,xmm1);     
    xmm2 = XOR(xmm5,xmm2);     
    xmm5 = XOR(xmm7,xmm0);     
    xmm9 = XOR(xmm1,xmm6);     
    xmm10 = XOR(xmm4,xmm5);    
    xmm12 = XOR(xmm6,xmm0);    
    xmm0 = XOR(xmm0,xmm9);     
    xmm1 = XOR(xmm8,xmm9);     
    xmm7 = XOR(xmm8,xmm2);     
    xmm6 = XOR(xmm2,xmm3);     
    xmm2 = XOR(xmm10,xmm7);    
    xmm4 = XOR(xmm3,xmm7);     
    xmm3 = XOR(xmm12,xmm4);    
    *S0 = xmm0;
    *S1 = xmm1;
    *S2 = xmm2;
    *S3 = xmm3;
    *S4 = xmm4;
    *S5 = xmm5;
    *S6 = xmm6;
    *S7 = xmm7;
}
#elif SBOX == 2
/* auxiliary functions */
static inline void SubBytes__ (/*inputs*/ DATATYPE U0,DATATYPE U1,DATATYPE U2,DATATYPE U3,DATATYPE U4,DATATYPE U5,DATATYPE U6,DATATYPE U7, /*outputs*/ DATATYPE* S0,DATATYPE* S1,DATATYPE* S2,DATATYPE* S3,DATATYPE* S4,DATATYPE* S5,DATATYPE* S6,DATATYPE* S7) {
  
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
  y12 = XOR(y13,y14);
  y1 = XOR(t0,U7);
  t1 = XOR(U4,y12);
  y4 = XOR(y1,U3);
  y2 = XOR(y1,U0);
  y5 = XOR(y1,U6);
  y15 = XOR(t1,U5);
  y20 = XOR(t1,U1);
  t5 = AND(y4,U7);
  y3 = XOR(y5,y8);
  t8 = AND(y5,y1);
  y6 = XOR(y15,U7);
  y10 = XOR(y15,t0);
  t2 = AND(y12,y15);
  y11 = XOR(y20,y9);
  t3 = AND(y3,y6);
  y19 = XOR(y10,y8);
  t15 = AND(y8,y10);
  t6 = XOR(t5,t2);
  y7 = XOR(U7,y11);
  y17 = XOR(y10,y11);
  y16 = XOR(t0,y11);
  t12 = AND(y9,y11);
  t4 = XOR(t3,t2);
  t10 = AND(y2,y7);
  t13 = AND(y14,y17);
  y21 = XOR(y13,y16);
  y18 = XOR(U0,y16);
  t7 = AND(y13,y16);
  t16 = XOR(t15,t12);
  t17 = XOR(t4,y20);
  t14 = XOR(t13,t12);
  t9 = XOR(t8,t7);
  t11 = XOR(t10,t7);
  t18 = XOR(t6,t16);
  t21 = XOR(t17,t14);
  t19 = XOR(t9,t14);
  t20 = XOR(t11,t16);
  t22 = XOR(t18,y19);
  t23 = XOR(t19,y21);
  t24 = XOR(t20,y18);
  t25 = XOR(t21,t22);
  t26 = AND(t21,t23);
  t30 = XOR(t23,t24);
  t27 = XOR(t24,t26);
  t31 = XOR(t22,t26);
  t28 = AND(t25,t27);
  t32 = AND(t31,t30);
  t29 = XOR(t28,t22);
  t33 = XOR(t32,t24);
  z5 = AND(t29,y7);
  z14 = AND(t29,y2);
  t34 = XOR(t23,t33);
  t35 = XOR(t27,t33);
  t42 = XOR(t29,t33);
  z2 = AND(t33,U7);
  z11 = AND(t33,y4);
  t36 = AND(t24,t35);
  z6 = AND(t42,y11);
  z15 = AND(t42,y9);
  t37 = XOR(t36,t34);
  t38 = XOR(t27,t36);
  t44 = XOR(t33,t37);
  z1 = AND(t37,y6);
  z10 = AND(t37,y3);
  t39 = AND(t29,t38);
  z0 = AND(t44,y15);
  z9 = AND(t44,y12);
  t40 = XOR(t25,t39);
  tc4 = XOR(z0,z2);
  tc5 = XOR(z1,z0);
  t41 = XOR(t40,t37);
  t43 = XOR(t29,t40);
  z4 = AND(t40,y1);
  z13 = AND(t40,y5);
  t45 = XOR(t42,t41);
  z8 = AND(t41,y10);
  z17 = AND(t41,y8);
  z3 = AND(t43,y16);
  z12 = AND(t43,y13);
  z7 = AND(t45,y17);
  z16 = AND(t45,y14);
  tc6 = XOR(z3,z4);
  tc12 = XOR(z3,z5);
  tc7 = XOR(z12,tc4);
  tc1 = XOR(z15,z16);
  tc8 = XOR(z7,tc6);
  tc11 = XOR(tc6,tc5);
  tc14 = XOR(tc4,tc12);
  tc9 = XOR(z8,tc7);
  tc2 = XOR(z10,tc1);
  tc13 = XOR(z13,tc1);
  tc16 = XOR(z6,tc8);
  tc10 = XOR(tc8,tc9);
  tc3 = XOR(z9,tc2);
  tc21 = XOR(tc2,z11);
  tc18 = XOR(tc13,tc14);
  tc20 = XOR(z15,tc16);
  tc17 = XOR(z14,tc10);
  *S3 = XOR(tc3,tc11);
  *S0 = XOR(tc3,tc16);
  _tmp1_ = XOR(z12,tc18);
  _tmp2_ = XOR(tc10,tc18);
  tc26 = XOR(tc17,tc20);
  *S5 = XOR(tc21,tc17);
  *S4 = XOR(tc14,*S3);
  _tmp3_ = XOR(*S3,tc16);
  *S7 = NOT(_tmp1_);
  *S6 = NOT(_tmp2_);
  _tmp4_ = XOR(tc26,z17);
  *S1 = NOT(_tmp3_);
  *S2 = NOT(_tmp4_);
}
#elif SBOX == 3
void subbytes(DATATYPE xmm0, DATATYPE xmm1, DATATYPE xmm2, DATATYPE xmm3,
              DATATYPE xmm4, DATATYPE xmm5, DATATYPE xmm6, DATATYPE xmm7,
              DATATYPE* o0, DATATYPE* o1, DATATYPE* o2, DATATYPE* o3,
              DATATYPE* o4, DATATYPE* o5, DATATYPE* o6, DATATYPE* o7);
#define SubBytes__(i0,i1,i2,i3,i4,i5,i6,i7,o0,o1,o2,o3,o4,o5,o6,o7) \
  subbytes(i7,i6,i5,i4,i3,i2,i1,i0,o7,o6,o5,o4,o3,o2,o1,o0)
#elif SBOX == 4
void SubBytes__ (/*inputs*/ DATATYPE U0,DATATYPE U1,DATATYPE U2,DATATYPE U3,DATATYPE U4,DATATYPE U5,DATATYPE U6,DATATYPE U7, /*outputs*/ DATATYPE* S0,DATATYPE* S1,DATATYPE* S2,DATATYPE* S3,DATATYPE* S4,DATATYPE* S5,DATATYPE* S6,DATATYPE* S7);
#else
#error Wrong value for SBOX
#endif

#ifdef UA_LAYOUT
/* main function */
void AES__ (/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
  
  // Variables declaration
  DATATYPE MixColumn___1__tmp10_;
  DATATYPE MixColumn___1__tmp11_;
  DATATYPE MixColumn___1__tmp12_;
  DATATYPE MixColumn___1__tmp13_;
  DATATYPE MixColumn___1__tmp14_;
  DATATYPE MixColumn___1__tmp15_;
  DATATYPE MixColumn___1__tmp16_;
  DATATYPE MixColumn___1__tmp17_;
  DATATYPE MixColumn___1__tmp18_;
  DATATYPE MixColumn___1__tmp19_;
  DATATYPE MixColumn___1__tmp1_;
  DATATYPE MixColumn___1__tmp20_;
  DATATYPE MixColumn___1__tmp21_;
  DATATYPE MixColumn___1__tmp22_;
  DATATYPE MixColumn___1__tmp23_;
  DATATYPE MixColumn___1__tmp24_;
  DATATYPE MixColumn___1__tmp25_;
  DATATYPE MixColumn___1__tmp26_;
  DATATYPE MixColumn___1__tmp27_;
  DATATYPE MixColumn___1__tmp28_;
  DATATYPE MixColumn___1__tmp29_;
  DATATYPE MixColumn___1__tmp2_;
  DATATYPE MixColumn___1__tmp30_;
  DATATYPE MixColumn___1__tmp31_;
  DATATYPE MixColumn___1__tmp32_;
  DATATYPE MixColumn___1__tmp33_;
  DATATYPE MixColumn___1__tmp34_;
  DATATYPE MixColumn___1__tmp35_;
  DATATYPE MixColumn___1__tmp36_;
  DATATYPE MixColumn___1__tmp37_;
  DATATYPE MixColumn___1__tmp38_;
  DATATYPE MixColumn___1__tmp39_;
  DATATYPE MixColumn___1__tmp3_;
  DATATYPE MixColumn___1__tmp40_;
  DATATYPE MixColumn___1__tmp41_;
  DATATYPE MixColumn___1__tmp42_;
  DATATYPE MixColumn___1__tmp43_;
  DATATYPE MixColumn___1__tmp44_;
  DATATYPE MixColumn___1__tmp45_;
  DATATYPE MixColumn___1__tmp46_;
  DATATYPE MixColumn___1__tmp47_;
  DATATYPE MixColumn___1__tmp48_;
  DATATYPE MixColumn___1__tmp49_;
  DATATYPE MixColumn___1__tmp4_;
  DATATYPE MixColumn___1__tmp50_;
  DATATYPE MixColumn___1__tmp51_;
  DATATYPE MixColumn___1__tmp52_;
  DATATYPE MixColumn___1__tmp53_;
  DATATYPE MixColumn___1__tmp54_;
  DATATYPE MixColumn___1__tmp55_;
  DATATYPE MixColumn___1__tmp56_;
  DATATYPE MixColumn___1__tmp57_;
  DATATYPE MixColumn___1__tmp58_;
  DATATYPE MixColumn___1__tmp59_;
  DATATYPE MixColumn___1__tmp5_;
  DATATYPE MixColumn___1__tmp60_;
  DATATYPE MixColumn___1__tmp61_;
  DATATYPE MixColumn___1__tmp62_;
  DATATYPE MixColumn___1__tmp63_;
  DATATYPE MixColumn___1__tmp64_;
  DATATYPE MixColumn___1__tmp65_;
  DATATYPE MixColumn___1__tmp6_;
  DATATYPE MixColumn___1__tmp7_;
  DATATYPE MixColumn___1__tmp8_;
  DATATYPE MixColumn___1__tmp9_;
  DATATYPE _tmp66_[8];
  DATATYPE _tmp67_[8];
  DATATYPE _tmp68_[8];
  DATATYPE _tmp69_[8];
  DATATYPE _tmp70_[8];
  DATATYPE tmp__[8];


  // Instructions (body)
  tmp__[0] = XOR(plain__[0],key__[0][0]);
  tmp__[1] = XOR(plain__[1],key__[0][1]);
  tmp__[2] = XOR(plain__[2],key__[0][2]);
  tmp__[3] = XOR(plain__[3],key__[0][3]);
  tmp__[4] = XOR(plain__[4],key__[0][4]);
  tmp__[5] = XOR(plain__[5],key__[0][5]);
  tmp__[6] = XOR(plain__[6],key__[0][6]);
  tmp__[7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN aes-usuba");
#endif
#ifdef _IACA
    IACA_START
#endif      
    SubBytes__(tmp__[0],tmp__[1],tmp__[2],tmp__[3],tmp__[4],tmp__[5],tmp__[6],tmp__[7],&_tmp66_[0],&_tmp66_[1],&_tmp66_[2],&_tmp66_[3],&_tmp66_[4],&_tmp66_[5],&_tmp66_[6],&_tmp66_[7]);
    for (int i1 = 0; i1 <= 7; i1++) {
      _tmp67_[i1] = PERMUT_16(_tmp66_[i1],0,1,2,3,5,6,7,4,10,11,8,9,15,12,13,14);
    }
    MixColumn___1__tmp1_ = PERMUT_4(_tmp67_[0],1,2,3,0);
    MixColumn___1__tmp2_ = XOR(_tmp67_[0],MixColumn___1__tmp1_);
    MixColumn___1__tmp3_ = PERMUT_4(_tmp67_[7],1,2,3,0);
    MixColumn___1__tmp4_ = XOR(MixColumn___1__tmp2_,MixColumn___1__tmp3_);
    MixColumn___1__tmp5_ = PERMUT_4(_tmp67_[7],1,2,3,0);
    MixColumn___1__tmp6_ = XOR(_tmp67_[7],MixColumn___1__tmp5_);
    MixColumn___1__tmp7_ = PERMUT_4(MixColumn___1__tmp6_,2,3,0,1);
    _tmp68_[7] = XOR(MixColumn___1__tmp4_,MixColumn___1__tmp7_);
    MixColumn___1__tmp8_ = PERMUT_4(_tmp67_[7],1,2,3,0);
    MixColumn___1__tmp9_ = XOR(_tmp67_[7],MixColumn___1__tmp8_);
    MixColumn___1__tmp10_ = PERMUT_4(_tmp67_[0],1,2,3,0);
    MixColumn___1__tmp11_ = XOR(_tmp67_[0],MixColumn___1__tmp10_);
    MixColumn___1__tmp12_ = XOR(MixColumn___1__tmp9_,MixColumn___1__tmp11_);
    MixColumn___1__tmp13_ = PERMUT_4(_tmp67_[6],1,2,3,0);
    MixColumn___1__tmp14_ = XOR(MixColumn___1__tmp12_,MixColumn___1__tmp13_);
    MixColumn___1__tmp15_ = PERMUT_4(_tmp67_[6],1,2,3,0);
    MixColumn___1__tmp16_ = XOR(_tmp67_[6],MixColumn___1__tmp15_);
    MixColumn___1__tmp17_ = PERMUT_4(MixColumn___1__tmp16_,2,3,0,1);
    _tmp68_[6] = XOR(MixColumn___1__tmp14_,MixColumn___1__tmp17_);
    MixColumn___1__tmp18_ = PERMUT_4(_tmp67_[6],1,2,3,0);
    MixColumn___1__tmp19_ = XOR(_tmp67_[6],MixColumn___1__tmp18_);
    MixColumn___1__tmp20_ = PERMUT_4(_tmp67_[5],1,2,3,0);
    MixColumn___1__tmp21_ = XOR(MixColumn___1__tmp19_,MixColumn___1__tmp20_);
    MixColumn___1__tmp22_ = PERMUT_4(_tmp67_[5],1,2,3,0);
    MixColumn___1__tmp23_ = XOR(_tmp67_[5],MixColumn___1__tmp22_);
    MixColumn___1__tmp24_ = PERMUT_4(MixColumn___1__tmp23_,2,3,0,1);
    _tmp68_[5] = XOR(MixColumn___1__tmp21_,MixColumn___1__tmp24_);
    MixColumn___1__tmp25_ = PERMUT_4(_tmp67_[5],1,2,3,0);
    MixColumn___1__tmp26_ = XOR(_tmp67_[5],MixColumn___1__tmp25_);
    MixColumn___1__tmp27_ = PERMUT_4(_tmp67_[0],1,2,3,0);
    MixColumn___1__tmp28_ = XOR(_tmp67_[0],MixColumn___1__tmp27_);
    MixColumn___1__tmp29_ = XOR(MixColumn___1__tmp26_,MixColumn___1__tmp28_);
    MixColumn___1__tmp30_ = PERMUT_4(_tmp67_[4],1,2,3,0);
    MixColumn___1__tmp31_ = XOR(MixColumn___1__tmp29_,MixColumn___1__tmp30_);
    MixColumn___1__tmp32_ = PERMUT_4(_tmp67_[4],1,2,3,0);
    MixColumn___1__tmp33_ = XOR(_tmp67_[4],MixColumn___1__tmp32_);
    MixColumn___1__tmp34_ = PERMUT_4(MixColumn___1__tmp33_,2,3,0,1);
    _tmp68_[4] = XOR(MixColumn___1__tmp31_,MixColumn___1__tmp34_);
    MixColumn___1__tmp35_ = PERMUT_4(_tmp67_[4],1,2,3,0);
    MixColumn___1__tmp36_ = XOR(_tmp67_[4],MixColumn___1__tmp35_);
    MixColumn___1__tmp37_ = PERMUT_4(_tmp67_[0],1,2,3,0);
    MixColumn___1__tmp38_ = XOR(_tmp67_[0],MixColumn___1__tmp37_);
    MixColumn___1__tmp39_ = XOR(MixColumn___1__tmp36_,MixColumn___1__tmp38_);
    MixColumn___1__tmp40_ = PERMUT_4(_tmp67_[3],1,2,3,0);
    MixColumn___1__tmp41_ = XOR(MixColumn___1__tmp39_,MixColumn___1__tmp40_);
    MixColumn___1__tmp42_ = PERMUT_4(_tmp67_[3],1,2,3,0);
    MixColumn___1__tmp43_ = XOR(_tmp67_[3],MixColumn___1__tmp42_);
    MixColumn___1__tmp44_ = PERMUT_4(MixColumn___1__tmp43_,2,3,0,1);
    _tmp68_[3] = XOR(MixColumn___1__tmp41_,MixColumn___1__tmp44_);
    MixColumn___1__tmp45_ = PERMUT_4(_tmp67_[3],1,2,3,0);
    MixColumn___1__tmp46_ = XOR(_tmp67_[3],MixColumn___1__tmp45_);
    MixColumn___1__tmp47_ = PERMUT_4(_tmp67_[2],1,2,3,0);
    MixColumn___1__tmp48_ = XOR(MixColumn___1__tmp46_,MixColumn___1__tmp47_);
    MixColumn___1__tmp49_ = PERMUT_4(_tmp67_[2],1,2,3,0);
    MixColumn___1__tmp50_ = XOR(_tmp67_[2],MixColumn___1__tmp49_);
    MixColumn___1__tmp51_ = PERMUT_4(MixColumn___1__tmp50_,2,3,0,1);
    _tmp68_[2] = XOR(MixColumn___1__tmp48_,MixColumn___1__tmp51_);
    MixColumn___1__tmp52_ = PERMUT_4(_tmp67_[2],1,2,3,0);
    MixColumn___1__tmp53_ = XOR(_tmp67_[2],MixColumn___1__tmp52_);
    MixColumn___1__tmp54_ = PERMUT_4(_tmp67_[1],1,2,3,0);
    MixColumn___1__tmp55_ = XOR(MixColumn___1__tmp53_,MixColumn___1__tmp54_);
    MixColumn___1__tmp56_ = PERMUT_4(_tmp67_[1],1,2,3,0);
    MixColumn___1__tmp57_ = XOR(_tmp67_[1],MixColumn___1__tmp56_);
    MixColumn___1__tmp58_ = PERMUT_4(MixColumn___1__tmp57_,2,3,0,1);
    _tmp68_[1] = XOR(MixColumn___1__tmp55_,MixColumn___1__tmp58_);
    MixColumn___1__tmp59_ = PERMUT_4(_tmp67_[1],1,2,3,0);
    MixColumn___1__tmp60_ = XOR(_tmp67_[1],MixColumn___1__tmp59_);
    MixColumn___1__tmp61_ = PERMUT_4(_tmp67_[0],1,2,3,0);
    MixColumn___1__tmp62_ = XOR(MixColumn___1__tmp60_,MixColumn___1__tmp61_);
    MixColumn___1__tmp63_ = PERMUT_4(_tmp67_[0],1,2,3,0);
    MixColumn___1__tmp64_ = XOR(_tmp67_[0],MixColumn___1__tmp63_);
    MixColumn___1__tmp65_ = PERMUT_4(MixColumn___1__tmp64_,2,3,0,1);
    _tmp68_[0] = XOR(MixColumn___1__tmp62_,MixColumn___1__tmp65_);
    tmp__[0] = XOR(_tmp68_[0],key__[i][0]);
    tmp__[1] = XOR(_tmp68_[1],key__[i][1]);
    tmp__[2] = XOR(_tmp68_[2],key__[i][2]);
    tmp__[3] = XOR(_tmp68_[3],key__[i][3]);
    tmp__[4] = XOR(_tmp68_[4],key__[i][4]);
    tmp__[5] = XOR(_tmp68_[5],key__[i][5]);
    tmp__[6] = XOR(_tmp68_[6],key__[i][6]);
    tmp__[7] = XOR(_tmp68_[7],key__[i][7]);
  }
#ifdef _MCA
    __asm volatile("# LLVM-MCA-END");
#endif
#ifdef _IACA
    IACA_END
#endif
  SubBytes__(tmp__[0],tmp__[1],tmp__[2],tmp__[3],tmp__[4],tmp__[5],tmp__[6],tmp__[7],&_tmp69_[0],&_tmp69_[1],&_tmp69_[2],&_tmp69_[3],&_tmp69_[4],&_tmp69_[5],&_tmp69_[6],&_tmp69_[7]);
  for (int i2 = 0; i2 <= 7; i2++) {
    _tmp70_[i2] = PERMUT_16(_tmp69_[i2],0,1,2,3,5,6,7,4,10,11,8,9,15,12,13,14);
  }
  cipher__[0] = XOR(_tmp70_[0],key__[10][0]);
  cipher__[1] = XOR(_tmp70_[1],key__[10][1]);
  cipher__[2] = XOR(_tmp70_[2],key__[10][2]);
  cipher__[3] = XOR(_tmp70_[3],key__[10][3]);
  cipher__[4] = XOR(_tmp70_[4],key__[10][4]);
  cipher__[5] = XOR(_tmp70_[5],key__[10][5]);
  cipher__[6] = XOR(_tmp70_[6],key__[10][6]);
  cipher__[7] = XOR(_tmp70_[7],key__[10][7]);

}
 

#else
#ifdef KEYXOR_TOPLOOP

/* main function */
void AES__ (/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
  
  // Variables declaration
  DATATYPE MixColumn___1__tmp12_;
  DATATYPE MixColumn___1__tmp13_;
  DATATYPE MixColumn___1__tmp14_;
  DATATYPE MixColumn___1__tmp16_;
  DATATYPE MixColumn___1__tmp17_;
  DATATYPE MixColumn___1__tmp1_;
  DATATYPE MixColumn___1__tmp20_;
  DATATYPE MixColumn___1__tmp21_;
  DATATYPE MixColumn___1__tmp23_;
  DATATYPE MixColumn___1__tmp24_;
  DATATYPE MixColumn___1__tmp29_;
  DATATYPE MixColumn___1__tmp2_;
  DATATYPE MixColumn___1__tmp30_;
  DATATYPE MixColumn___1__tmp31_;
  DATATYPE MixColumn___1__tmp33_;
  DATATYPE MixColumn___1__tmp34_;
  DATATYPE MixColumn___1__tmp39_;
  DATATYPE MixColumn___1__tmp3_;
  DATATYPE MixColumn___1__tmp40_;
  DATATYPE MixColumn___1__tmp41_;
  DATATYPE MixColumn___1__tmp43_;
  DATATYPE MixColumn___1__tmp44_;
  DATATYPE MixColumn___1__tmp47_;
  DATATYPE MixColumn___1__tmp48_;
  DATATYPE MixColumn___1__tmp4_;
  DATATYPE MixColumn___1__tmp50_;
  DATATYPE MixColumn___1__tmp51_;
  DATATYPE MixColumn___1__tmp54_;
  DATATYPE MixColumn___1__tmp55_;
  DATATYPE MixColumn___1__tmp57_;
  DATATYPE MixColumn___1__tmp58_;
  DATATYPE MixColumn___1__tmp62_;
  DATATYPE MixColumn___1__tmp65_;
  DATATYPE MixColumn___1__tmp6_;
  DATATYPE MixColumn___1__tmp7_;
  DATATYPE _tmp66_[8];
  DATATYPE _tmp67_[8];
  DATATYPE _tmp68_[8];
  DATATYPE _tmp69_[8];
  DATATYPE _tmp70_[8];
  DATATYPE _tmp71_[8];
  DATATYPE tmp__[8];


  // Instructions (body)
  tmp__[0] = plain__[0];
  tmp__[1] = plain__[1];
  tmp__[2] = plain__[2];
  tmp__[3] = plain__[3];
  tmp__[4] = plain__[4];
  tmp__[5] = plain__[5];
  tmp__[6] = plain__[6];
  tmp__[7] = plain__[7];
  for (int i = 1; i <= 9; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN aes-usuba");
#endif
#ifdef _IACA
    IACA_START
#endif
    _tmp66_[0] = XOR(tmp__[0],key__[(i - 1)][0]);
    _tmp66_[1] = XOR(tmp__[1],key__[(i - 1)][1]);
    _tmp66_[2] = XOR(tmp__[2],key__[(i - 1)][2]);
    _tmp66_[3] = XOR(tmp__[3],key__[(i - 1)][3]);
    _tmp66_[4] = XOR(tmp__[4],key__[(i - 1)][4]);
    _tmp66_[5] = XOR(tmp__[5],key__[(i - 1)][5]);
    _tmp66_[6] = XOR(tmp__[6],key__[(i - 1)][6]);
    _tmp66_[7] = XOR(tmp__[7],key__[(i - 1)][7]);
    SubBytes__(_tmp66_[0],_tmp66_[1],_tmp66_[2],_tmp66_[3],_tmp66_[4],_tmp66_[5],_tmp66_[6],_tmp66_[7],&_tmp67_[0],&_tmp67_[1],&_tmp67_[2],&_tmp67_[3],&_tmp67_[4],&_tmp67_[5],&_tmp67_[6],&_tmp67_[7]);
    for (int i1 = 0; i1 <= 7; i1++) {
      _tmp68_[i1] = PERMUT_16(_tmp67_[i1],0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
    }
    MixColumn___1__tmp1_ = PERMUT_16(_tmp68_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp2_ = XOR(_tmp68_[0],MixColumn___1__tmp1_);
    MixColumn___1__tmp3_ = PERMUT_16(_tmp68_[7],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp4_ = XOR(MixColumn___1__tmp2_,MixColumn___1__tmp3_);
    MixColumn___1__tmp6_ = XOR(_tmp68_[7],MixColumn___1__tmp3_);
    MixColumn___1__tmp7_ = PERMUT_16(MixColumn___1__tmp6_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[7] = XOR(MixColumn___1__tmp4_,MixColumn___1__tmp7_);
    MixColumn___1__tmp12_ = XOR(MixColumn___1__tmp6_,MixColumn___1__tmp2_);
    MixColumn___1__tmp13_ = PERMUT_16(_tmp68_[6],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp14_ = XOR(MixColumn___1__tmp12_,MixColumn___1__tmp13_);
    MixColumn___1__tmp16_ = XOR(_tmp68_[6],MixColumn___1__tmp13_);
    MixColumn___1__tmp17_ = PERMUT_16(MixColumn___1__tmp16_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[6] = XOR(MixColumn___1__tmp14_,MixColumn___1__tmp17_);
    MixColumn___1__tmp20_ = PERMUT_16(_tmp68_[5],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp21_ = XOR(MixColumn___1__tmp16_,MixColumn___1__tmp20_);
    MixColumn___1__tmp23_ = XOR(_tmp68_[5],MixColumn___1__tmp20_);
    MixColumn___1__tmp24_ = PERMUT_16(MixColumn___1__tmp23_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[5] = XOR(MixColumn___1__tmp21_,MixColumn___1__tmp24_);
    MixColumn___1__tmp29_ = XOR(MixColumn___1__tmp23_,MixColumn___1__tmp2_);
    MixColumn___1__tmp30_ = PERMUT_16(_tmp68_[4],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp31_ = XOR(MixColumn___1__tmp29_,MixColumn___1__tmp30_);
    MixColumn___1__tmp33_ = XOR(_tmp68_[4],MixColumn___1__tmp30_);
    MixColumn___1__tmp34_ = PERMUT_16(MixColumn___1__tmp33_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[4] = XOR(MixColumn___1__tmp31_,MixColumn___1__tmp34_);
    MixColumn___1__tmp39_ = XOR(MixColumn___1__tmp33_,MixColumn___1__tmp2_);
    MixColumn___1__tmp40_ = PERMUT_16(_tmp68_[3],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp41_ = XOR(MixColumn___1__tmp39_,MixColumn___1__tmp40_);
    MixColumn___1__tmp43_ = XOR(_tmp68_[3],MixColumn___1__tmp40_);
    MixColumn___1__tmp44_ = PERMUT_16(MixColumn___1__tmp43_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[3] = XOR(MixColumn___1__tmp41_,MixColumn___1__tmp44_);
    MixColumn___1__tmp47_ = PERMUT_16(_tmp68_[2],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp48_ = XOR(MixColumn___1__tmp43_,MixColumn___1__tmp47_);
    MixColumn___1__tmp50_ = XOR(_tmp68_[2],MixColumn___1__tmp47_);
    MixColumn___1__tmp51_ = PERMUT_16(MixColumn___1__tmp50_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[2] = XOR(MixColumn___1__tmp48_,MixColumn___1__tmp51_);
    MixColumn___1__tmp54_ = PERMUT_16(_tmp68_[1],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp55_ = XOR(MixColumn___1__tmp50_,MixColumn___1__tmp54_);
    MixColumn___1__tmp57_ = XOR(_tmp68_[1],MixColumn___1__tmp54_);
    MixColumn___1__tmp58_ = PERMUT_16(MixColumn___1__tmp57_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[1] = XOR(MixColumn___1__tmp55_,MixColumn___1__tmp58_);
    MixColumn___1__tmp62_ = XOR(MixColumn___1__tmp57_,MixColumn___1__tmp1_);
    MixColumn___1__tmp65_ = PERMUT_16(MixColumn___1__tmp2_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    tmp__[0] = XOR(MixColumn___1__tmp62_,MixColumn___1__tmp65_);
  }
#ifdef _MCA
    __asm volatile("# LLVM-MCA-END");
#endif
#ifdef _IACA
    IACA_END
#endif
  _tmp69_[0] = XOR(tmp__[0],key__[9][0]);
  _tmp69_[1] = XOR(tmp__[1],key__[9][1]);
  _tmp69_[2] = XOR(tmp__[2],key__[9][2]);
  _tmp69_[3] = XOR(tmp__[3],key__[9][3]);
  _tmp69_[4] = XOR(tmp__[4],key__[9][4]);
  _tmp69_[5] = XOR(tmp__[5],key__[9][5]);
  _tmp69_[6] = XOR(tmp__[6],key__[9][6]);
  _tmp69_[7] = XOR(tmp__[7],key__[9][7]);
  SubBytes__(_tmp69_[0],_tmp69_[1],_tmp69_[2],_tmp69_[3],_tmp69_[4],_tmp69_[5],_tmp69_[6],_tmp69_[7],&_tmp70_[0],&_tmp70_[1],&_tmp70_[2],&_tmp70_[3],&_tmp70_[4],&_tmp70_[5],&_tmp70_[6],&_tmp70_[7]);
  for (int i2 = 0; i2 <= 7; i2++) {
    _tmp71_[i2] = PERMUT_16(_tmp70_[i2],0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  }
  cipher__[0] = XOR(_tmp71_[0],key__[10][0]);
  cipher__[1] = XOR(_tmp71_[1],key__[10][1]);
  cipher__[2] = XOR(_tmp71_[2],key__[10][2]);
  cipher__[3] = XOR(_tmp71_[3],key__[10][3]);
  cipher__[4] = XOR(_tmp71_[4],key__[10][4]);
  cipher__[5] = XOR(_tmp71_[5],key__[10][5]);
  cipher__[6] = XOR(_tmp71_[6],key__[10][6]);
  cipher__[7] = XOR(_tmp71_[7],key__[10][7]);

}
#else
/* main function */
void AES__ (/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
  
  // Variables declaration
  DATATYPE MixColumn___1__tmp10_;
  DATATYPE MixColumn___1__tmp11_;
  DATATYPE MixColumn___1__tmp12_;
  DATATYPE MixColumn___1__tmp13_;
  DATATYPE MixColumn___1__tmp14_;
  DATATYPE MixColumn___1__tmp15_;
  DATATYPE MixColumn___1__tmp16_;
  DATATYPE MixColumn___1__tmp17_;
  DATATYPE MixColumn___1__tmp18_;
  DATATYPE MixColumn___1__tmp19_;
  DATATYPE MixColumn___1__tmp1_;
  DATATYPE MixColumn___1__tmp20_;
  DATATYPE MixColumn___1__tmp21_;
  DATATYPE MixColumn___1__tmp22_;
  DATATYPE MixColumn___1__tmp23_;
  DATATYPE MixColumn___1__tmp24_;
  DATATYPE MixColumn___1__tmp25_;
  DATATYPE MixColumn___1__tmp26_;
  DATATYPE MixColumn___1__tmp27_;
  DATATYPE MixColumn___1__tmp28_;
  DATATYPE MixColumn___1__tmp29_;
  DATATYPE MixColumn___1__tmp2_;
  DATATYPE MixColumn___1__tmp30_;
  DATATYPE MixColumn___1__tmp31_;
  DATATYPE MixColumn___1__tmp32_;
  DATATYPE MixColumn___1__tmp33_;
  DATATYPE MixColumn___1__tmp34_;
  DATATYPE MixColumn___1__tmp35_;
  DATATYPE MixColumn___1__tmp36_;
  DATATYPE MixColumn___1__tmp37_;
  DATATYPE MixColumn___1__tmp38_;
  DATATYPE MixColumn___1__tmp39_;
  DATATYPE MixColumn___1__tmp3_;
  DATATYPE MixColumn___1__tmp40_;
  DATATYPE MixColumn___1__tmp41_;
  DATATYPE MixColumn___1__tmp42_;
  DATATYPE MixColumn___1__tmp43_;
  DATATYPE MixColumn___1__tmp44_;
  DATATYPE MixColumn___1__tmp45_;
  DATATYPE MixColumn___1__tmp46_;
  DATATYPE MixColumn___1__tmp47_;
  DATATYPE MixColumn___1__tmp48_;
  DATATYPE MixColumn___1__tmp49_;
  DATATYPE MixColumn___1__tmp4_;
  DATATYPE MixColumn___1__tmp50_;
  DATATYPE MixColumn___1__tmp51_;
  DATATYPE MixColumn___1__tmp52_;
  DATATYPE MixColumn___1__tmp53_;
  DATATYPE MixColumn___1__tmp54_;
  DATATYPE MixColumn___1__tmp55_;
  DATATYPE MixColumn___1__tmp56_;
  DATATYPE MixColumn___1__tmp57_;
  DATATYPE MixColumn___1__tmp58_;
  DATATYPE MixColumn___1__tmp59_;
  DATATYPE MixColumn___1__tmp5_;
  DATATYPE MixColumn___1__tmp60_;
  DATATYPE MixColumn___1__tmp61_;
  DATATYPE MixColumn___1__tmp62_;
  DATATYPE MixColumn___1__tmp63_;
  DATATYPE MixColumn___1__tmp64_;
  DATATYPE MixColumn___1__tmp65_;
  DATATYPE MixColumn___1__tmp6_;
  DATATYPE MixColumn___1__tmp7_;
  DATATYPE MixColumn___1__tmp8_;
  DATATYPE MixColumn___1__tmp9_;
  DATATYPE _tmp66_[8];
  DATATYPE _tmp67_[8];
  DATATYPE _tmp68_[8];
  DATATYPE _tmp69_[8];
  DATATYPE _tmp70_[8];
  DATATYPE tmp__[8];


  // Instructions (body)
  tmp__[0] = XOR(plain__[0],key__[0][0]);
  tmp__[1] = XOR(plain__[1],key__[0][1]);
  tmp__[2] = XOR(plain__[2],key__[0][2]);
  tmp__[3] = XOR(plain__[3],key__[0][3]);
  tmp__[4] = XOR(plain__[4],key__[0][4]);
  tmp__[5] = XOR(plain__[5],key__[0][5]);
  tmp__[6] = XOR(plain__[6],key__[0][6]);
  tmp__[7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN aes-usuba");
#endif
#ifdef _IACA
    IACA_START
#endif
    SubBytes__(tmp__[0],tmp__[1],tmp__[2],tmp__[3],tmp__[4],tmp__[5],tmp__[6],tmp__[7],&_tmp66_[0],&_tmp66_[1],&_tmp66_[2],&_tmp66_[3],&_tmp66_[4],&_tmp66_[5],&_tmp66_[6],&_tmp66_[7]);
    for (int i1 = 0; i1 <= 7; i1++) {
      _tmp67_[i1] = PERMUT_16(_tmp66_[i1],0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
    }
    MixColumn___1__tmp1_ = PERMUT_16(_tmp67_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp2_ = XOR(_tmp67_[0],MixColumn___1__tmp1_);
    MixColumn___1__tmp3_ = PERMUT_16(_tmp67_[7],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp4_ = XOR(MixColumn___1__tmp2_,MixColumn___1__tmp3_);
    MixColumn___1__tmp5_ = PERMUT_16(_tmp67_[7],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp6_ = XOR(_tmp67_[7],MixColumn___1__tmp5_);
    MixColumn___1__tmp7_ = PERMUT_16(MixColumn___1__tmp6_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[7] = XOR(MixColumn___1__tmp4_,MixColumn___1__tmp7_);
    MixColumn___1__tmp8_ = PERMUT_16(_tmp67_[7],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp9_ = XOR(_tmp67_[7],MixColumn___1__tmp8_);
    MixColumn___1__tmp10_ = PERMUT_16(_tmp67_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp11_ = XOR(_tmp67_[0],MixColumn___1__tmp10_);
    MixColumn___1__tmp12_ = XOR(MixColumn___1__tmp9_,MixColumn___1__tmp11_);
    MixColumn___1__tmp13_ = PERMUT_16(_tmp67_[6],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp14_ = XOR(MixColumn___1__tmp12_,MixColumn___1__tmp13_);
    MixColumn___1__tmp15_ = PERMUT_16(_tmp67_[6],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp16_ = XOR(_tmp67_[6],MixColumn___1__tmp15_);
    MixColumn___1__tmp17_ = PERMUT_16(MixColumn___1__tmp16_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[6] = XOR(MixColumn___1__tmp14_,MixColumn___1__tmp17_);
    MixColumn___1__tmp18_ = PERMUT_16(_tmp67_[6],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp19_ = XOR(_tmp67_[6],MixColumn___1__tmp18_);
    MixColumn___1__tmp20_ = PERMUT_16(_tmp67_[5],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp21_ = XOR(MixColumn___1__tmp19_,MixColumn___1__tmp20_);
    MixColumn___1__tmp22_ = PERMUT_16(_tmp67_[5],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp23_ = XOR(_tmp67_[5],MixColumn___1__tmp22_);
    MixColumn___1__tmp24_ = PERMUT_16(MixColumn___1__tmp23_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[5] = XOR(MixColumn___1__tmp21_,MixColumn___1__tmp24_);
    MixColumn___1__tmp25_ = PERMUT_16(_tmp67_[5],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp26_ = XOR(_tmp67_[5],MixColumn___1__tmp25_);
    MixColumn___1__tmp27_ = PERMUT_16(_tmp67_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp28_ = XOR(_tmp67_[0],MixColumn___1__tmp27_);
    MixColumn___1__tmp29_ = XOR(MixColumn___1__tmp26_,MixColumn___1__tmp28_);
    MixColumn___1__tmp30_ = PERMUT_16(_tmp67_[4],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp31_ = XOR(MixColumn___1__tmp29_,MixColumn___1__tmp30_);
    MixColumn___1__tmp32_ = PERMUT_16(_tmp67_[4],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp33_ = XOR(_tmp67_[4],MixColumn___1__tmp32_);
    MixColumn___1__tmp34_ = PERMUT_16(MixColumn___1__tmp33_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[4] = XOR(MixColumn___1__tmp31_,MixColumn___1__tmp34_);
    MixColumn___1__tmp35_ = PERMUT_16(_tmp67_[4],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp36_ = XOR(_tmp67_[4],MixColumn___1__tmp35_);
    MixColumn___1__tmp37_ = PERMUT_16(_tmp67_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp38_ = XOR(_tmp67_[0],MixColumn___1__tmp37_);
    MixColumn___1__tmp39_ = XOR(MixColumn___1__tmp36_,MixColumn___1__tmp38_);
    MixColumn___1__tmp40_ = PERMUT_16(_tmp67_[3],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp41_ = XOR(MixColumn___1__tmp39_,MixColumn___1__tmp40_);
    MixColumn___1__tmp42_ = PERMUT_16(_tmp67_[3],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp43_ = XOR(_tmp67_[3],MixColumn___1__tmp42_);
    MixColumn___1__tmp44_ = PERMUT_16(MixColumn___1__tmp43_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[3] = XOR(MixColumn___1__tmp41_,MixColumn___1__tmp44_);
    MixColumn___1__tmp45_ = PERMUT_16(_tmp67_[3],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp46_ = XOR(_tmp67_[3],MixColumn___1__tmp45_);
    MixColumn___1__tmp47_ = PERMUT_16(_tmp67_[2],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp48_ = XOR(MixColumn___1__tmp46_,MixColumn___1__tmp47_);
    MixColumn___1__tmp49_ = PERMUT_16(_tmp67_[2],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp50_ = XOR(_tmp67_[2],MixColumn___1__tmp49_);
    MixColumn___1__tmp51_ = PERMUT_16(MixColumn___1__tmp50_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[2] = XOR(MixColumn___1__tmp48_,MixColumn___1__tmp51_);
    MixColumn___1__tmp52_ = PERMUT_16(_tmp67_[2],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp53_ = XOR(_tmp67_[2],MixColumn___1__tmp52_);
    MixColumn___1__tmp54_ = PERMUT_16(_tmp67_[1],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp55_ = XOR(MixColumn___1__tmp53_,MixColumn___1__tmp54_);
    MixColumn___1__tmp56_ = PERMUT_16(_tmp67_[1],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp57_ = XOR(_tmp67_[1],MixColumn___1__tmp56_);
    MixColumn___1__tmp58_ = PERMUT_16(MixColumn___1__tmp57_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[1] = XOR(MixColumn___1__tmp55_,MixColumn___1__tmp58_);
    MixColumn___1__tmp59_ = PERMUT_16(_tmp67_[1],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp60_ = XOR(_tmp67_[1],MixColumn___1__tmp59_);
    MixColumn___1__tmp61_ = PERMUT_16(_tmp67_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp62_ = XOR(MixColumn___1__tmp60_,MixColumn___1__tmp61_);
    MixColumn___1__tmp63_ = PERMUT_16(_tmp67_[0],1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
    MixColumn___1__tmp64_ = XOR(_tmp67_[0],MixColumn___1__tmp63_);
    MixColumn___1__tmp65_ = PERMUT_16(MixColumn___1__tmp64_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
    _tmp68_[0] = XOR(MixColumn___1__tmp62_,MixColumn___1__tmp65_);
    tmp__[0] = XOR(_tmp68_[0],key__[i][0]);
    tmp__[1] = XOR(_tmp68_[1],key__[i][1]);
    tmp__[2] = XOR(_tmp68_[2],key__[i][2]);
    tmp__[3] = XOR(_tmp68_[3],key__[i][3]);
    tmp__[4] = XOR(_tmp68_[4],key__[i][4]);
    tmp__[5] = XOR(_tmp68_[5],key__[i][5]);
    tmp__[6] = XOR(_tmp68_[6],key__[i][6]);
    tmp__[7] = XOR(_tmp68_[7],key__[i][7]);
  }
#ifdef _MCA
    __asm volatile("# LLVM-MCA-END");
#endif
#ifdef _IACA
    IACA_END
#endif
  SubBytes__(tmp__[0],tmp__[1],tmp__[2],tmp__[3],tmp__[4],tmp__[5],tmp__[6],tmp__[7],&_tmp69_[0],&_tmp69_[1],&_tmp69_[2],&_tmp69_[3],&_tmp69_[4],&_tmp69_[5],&_tmp69_[6],&_tmp69_[7]);
  for (int i2 = 0; i2 <= 7; i2++) {
    _tmp70_[i2] = PERMUT_16(_tmp69_[i2],0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  }
  cipher__[0] = XOR(_tmp70_[0],key__[10][0]);
  cipher__[1] = XOR(_tmp70_[1],key__[10][1]);
  cipher__[2] = XOR(_tmp70_[2],key__[10][2]);
  cipher__[3] = XOR(_tmp70_[3],key__[10][3]);
  cipher__[4] = XOR(_tmp70_[4],key__[10][4]);
  cipher__[5] = XOR(_tmp70_[5],key__[10][5]);
  cipher__[6] = XOR(_tmp70_[6],key__[10][6]);
  cipher__[7] = XOR(_tmp70_[7],key__[10][7]);

}
#endif
#endif
