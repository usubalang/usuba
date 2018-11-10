/* SBOX:
     0 -> Kivilinna/K&S (C SSA)
     1 -> Kivilinna/K&S (C)
     2 -> Usuba/Canright (C)
     3 -> Kivilinna/K&S (ASM)
     4 -> Usuba/Canright (ASM)
     5 -> Kivilinna/K&S (C, constructive)

define one of those:
UA_LAYOUT : loop + shiftrows/mixcolumn inlined + pshufd
KEYXOR_TOPLOOP : loop + shiftrows/mixcolumn inlined + pshufb + xor top loop
MACRO : loop + macros (pshufb)
UA_FUN : loop + fun (pshufb)
UA_INLINE: no loop, all inlined and scheduled
KIVI : loop + kivi 
_ : loop + shiftrows/mixcolumn inlined + pshufb

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


#include <stdio.h>

static void print64binL (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8binL(c) printf("%d%d%d%d%d%d%d%d ",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8binL(bytearray[i]);
}
static void print128binL (const __m128i v) {
  unsigned long out[2];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i <= 1; i++) {
    print64binL(out[i]);
  }
  puts("");
}

/* #ifndef PRINT128HEX */
/* #define PRINT128HEX */
/* #include <x86intrin.h> */
/* void print128hex(__m128i toPrint) { */
/*   char * bytearray = (char *) &toPrint; */
/*   for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]); */
/*   printf("\n"); */
/* } */
/* #endif */

#ifdef NO_SBOX

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
#elif SBOX == 5

/* auxiliary functions */
void SubBytes__ (/*inputs*/ DATATYPE b7__,DATATYPE b6__,DATATYPE b5__,DATATYPE b4__,DATATYPE b3__,DATATYPE b2__,DATATYPE b1__,DATATYPE b0__, /*outputs*/ DATATYPE* o7__,DATATYPE* o6__,DATATYPE* o5__,DATATYPE* o4__,DATATYPE* o3__,DATATYPE* o2__,DATATYPE* o1__,DATATYPE* o0__) {
  
  // Variables declaration
  DATATYPE InBasisChange___1_t0__;
  DATATYPE InBasisChange___1_t1__;
  DATATYPE InBasisChange___1_t10__;
  DATATYPE InBasisChange___1_t11__;
  DATATYPE InBasisChange___1_t12__;
  DATATYPE InBasisChange___1_t2__;
  DATATYPE InBasisChange___1_t3__;
  DATATYPE InBasisChange___1_t4__;
  DATATYPE InBasisChange___1_t5__;
  DATATYPE InBasisChange___1_t6__;
  DATATYPE InBasisChange___1_t7__;
  DATATYPE InBasisChange___1_t8__;
  DATATYPE InBasisChange___1_t9__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t0__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t1__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t3__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t5__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t6__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t1__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t3__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t5__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t6__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t1__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t3__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t5__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t6__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t0__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t1__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t3__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t5__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t6__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t1__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t1__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t10__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t11__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t12__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t13__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t20__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t21__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t24__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t25__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t26__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t27__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t4__;
  DATATYPE Inv_GF256___1_Mul_GF16_2___1_t5__;
  DATATYPE Inv_GF256___1_t0__;
  DATATYPE Inv_GF256___1_t1__;
  DATATYPE Inv_GF256___1_t10__;
  DATATYPE Inv_GF256___1_t11__;
  DATATYPE Inv_GF256___1_t12__;
  DATATYPE Inv_GF256___1_t13__;
  DATATYPE Inv_GF256___1_t14__;
  DATATYPE Inv_GF256___1_t15__;
  DATATYPE Inv_GF256___1_t16__;
  DATATYPE Inv_GF256___1_t17__;
  DATATYPE Inv_GF256___1_t18__;
  DATATYPE Inv_GF256___1_t19__;
  DATATYPE Inv_GF256___1_t2__;
  DATATYPE Inv_GF256___1_t20__;
  DATATYPE Inv_GF256___1_t21__;
  DATATYPE Inv_GF256___1_t22__;
  DATATYPE Inv_GF256___1_t23__;
  DATATYPE Inv_GF256___1_t24__;
  DATATYPE Inv_GF256___1_t25__;
  DATATYPE Inv_GF256___1_t26__;
  DATATYPE Inv_GF256___1_t27__;
  DATATYPE Inv_GF256___1_t28__;
  DATATYPE Inv_GF256___1_t29__;
  DATATYPE Inv_GF256___1_t3__;
  DATATYPE Inv_GF256___1_t30__;
  DATATYPE Inv_GF256___1_t31__;
  DATATYPE Inv_GF256___1_t32__;
  DATATYPE Inv_GF256___1_t33__;
  DATATYPE Inv_GF256___1_t34__;
  DATATYPE Inv_GF256___1_t35__;
  DATATYPE Inv_GF256___1_t36__;
  DATATYPE Inv_GF256___1_t37__;
  DATATYPE Inv_GF256___1_t38__;
  DATATYPE Inv_GF256___1_t39__;
  DATATYPE Inv_GF256___1_t4__;
  DATATYPE Inv_GF256___1_t40__;
  DATATYPE Inv_GF256___1_t41__;
  DATATYPE Inv_GF256___1_t42__;
  DATATYPE Inv_GF256___1_t43__;
  DATATYPE Inv_GF256___1_t44__;
  DATATYPE Inv_GF256___1_t45__;
  DATATYPE Inv_GF256___1_t46__;
  DATATYPE Inv_GF256___1_t47__;
  DATATYPE Inv_GF256___1_t48__;
  DATATYPE Inv_GF256___1_t49__;
  DATATYPE Inv_GF256___1_t5__;
  DATATYPE Inv_GF256___1_t6__;
  DATATYPE Inv_GF256___1_t7__;
  DATATYPE Inv_GF256___1_t8__;
  DATATYPE Inv_GF256___1_t9__;
  DATATYPE OutBasisChange___1_t0__;
  DATATYPE OutBasisChange___1_t1__;
  DATATYPE OutBasisChange___1_t10__;
  DATATYPE OutBasisChange___1_t2__;
  DATATYPE OutBasisChange___1_t3__;
  DATATYPE OutBasisChange___1_t4__;
  DATATYPE OutBasisChange___1_t5__;
  DATATYPE OutBasisChange___1_t6__;
  DATATYPE OutBasisChange___1_t7__;
  DATATYPE OutBasisChange___1_t8__;
  DATATYPE OutBasisChange___1_t9__;


  // Instructions (body)
  InBasisChange___1_t0__ = XOR(b6__,b5__);
  InBasisChange___1_t1__ = XOR(b1__,b2__);
  InBasisChange___1_t2__ = XOR(b0__,InBasisChange___1_t0__);
  InBasisChange___1_t3__ = XOR(InBasisChange___1_t1__,b6__);
  InBasisChange___1_t4__ = XOR(b0__,b3__);
  InBasisChange___1_t5__ = XOR(InBasisChange___1_t4__,InBasisChange___1_t3__);
  InBasisChange___1_t6__ = XOR(b7__,InBasisChange___1_t4__);
  InBasisChange___1_t7__ = XOR(InBasisChange___1_t2__,b7__);
  InBasisChange___1_t8__ = XOR(b4__,InBasisChange___1_t6__);
  InBasisChange___1_t9__ = XOR(InBasisChange___1_t2__,b4__);
  InBasisChange___1_t10__ = XOR(b1__,InBasisChange___1_t8__);
  InBasisChange___1_t11__ = XOR(InBasisChange___1_t7__,InBasisChange___1_t1__);
  InBasisChange___1_t12__ = XOR(InBasisChange___1_t2__,b1__);
  Inv_GF256___1_t0__ = XOR(InBasisChange___1_t7__,InBasisChange___1_t9__);
  Inv_GF256___1_t1__ = XOR(InBasisChange___1_t12__,InBasisChange___1_t11__);
  Inv_GF256___1_t2__ = XOR(InBasisChange___1_t2__,InBasisChange___1_t10__);
  Inv_GF256___1_t3__ = XOR(InBasisChange___1_t11__,InBasisChange___1_t9__);
  Inv_GF256___1_t4__ = XOR(InBasisChange___1_t5__,b0__);
  Inv_GF256___1_t5__ = XOR(Inv_GF256___1_t0__,Inv_GF256___1_t1__);
  Inv_GF256___1_t6__ = AND(Inv_GF256___1_t1__,Inv_GF256___1_t2__);
  Inv_GF256___1_t7__ = OR(Inv_GF256___1_t2__,Inv_GF256___1_t1__);
  Inv_GF256___1_t8__ = AND(Inv_GF256___1_t0__,Inv_GF256___1_t4__);
  Inv_GF256___1_t9__ = OR(Inv_GF256___1_t4__,Inv_GF256___1_t0__);
  Inv_GF256___1_t10__ = XOR(Inv_GF256___1_t2__,Inv_GF256___1_t4__);
  Inv_GF256___1_t11__ = AND(Inv_GF256___1_t10__,Inv_GF256___1_t5__);
  Inv_GF256___1_t12__ = XOR(InBasisChange___1_t10__,b0__);
  Inv_GF256___1_t13__ = AND(Inv_GF256___1_t12__,Inv_GF256___1_t3__);
  Inv_GF256___1_t14__ = XOR(Inv_GF256___1_t13__,Inv_GF256___1_t9__);
  Inv_GF256___1_t15__ = XOR(Inv_GF256___1_t13__,Inv_GF256___1_t7__);
  Inv_GF256___1_t16__ = XOR(InBasisChange___1_t7__,InBasisChange___1_t12__);
  Inv_GF256___1_t17__ = XOR(InBasisChange___1_t2__,InBasisChange___1_t5__);
  Inv_GF256___1_t18__ = OR(Inv_GF256___1_t16__,Inv_GF256___1_t17__);
  Inv_GF256___1_t19__ = AND(Inv_GF256___1_t17__,Inv_GF256___1_t16__);
  Inv_GF256___1_t20__ = XOR(Inv_GF256___1_t19__,Inv_GF256___1_t6__);
  Inv_GF256___1_t21__ = XOR(Inv_GF256___1_t11__,Inv_GF256___1_t14__);
  Inv_GF256___1_t22__ = XOR(Inv_GF256___1_t8__,Inv_GF256___1_t15__);
  Inv_GF256___1_t23__ = XOR(Inv_GF256___1_t11__,Inv_GF256___1_t18__);
  Inv_GF256___1_t24__ = XOR(Inv_GF256___1_t8__,Inv_GF256___1_t20__);
  Inv_GF256___1_t25__ = XOR(Inv_GF256___1_t8__,Inv_GF256___1_t23__);
  Inv_GF256___1_t26__ = AND(InBasisChange___1_t11__,InBasisChange___1_t10__);
  Inv_GF256___1_t27__ = AND(InBasisChange___1_t9__,b0__);
  Inv_GF256___1_t28__ = AND(InBasisChange___1_t12__,InBasisChange___1_t2__);
  Inv_GF256___1_t29__ = OR(InBasisChange___1_t7__,InBasisChange___1_t5__);
  Inv_GF256___1_t30__ = XOR(Inv_GF256___1_t26__,Inv_GF256___1_t21__);
  Inv_GF256___1_t31__ = XOR(Inv_GF256___1_t27__,Inv_GF256___1_t22__);
  Inv_GF256___1_t32__ = XOR(Inv_GF256___1_t28__,Inv_GF256___1_t25__);
  Inv_GF256___1_t33__ = XOR(Inv_GF256___1_t29__,Inv_GF256___1_t24__);
  Inv_GF256___1_t34__ = XOR(Inv_GF256___1_t30__,Inv_GF256___1_t31__);
  Inv_GF256___1_t35__ = AND(Inv_GF256___1_t32__,Inv_GF256___1_t30__);
  Inv_GF256___1_t36__ = XOR(Inv_GF256___1_t33__,Inv_GF256___1_t35__);
  Inv_GF256___1_t37__ = AND(Inv_GF256___1_t34__,Inv_GF256___1_t36__);
  Inv_GF256___1_t38__ = XOR(Inv_GF256___1_t31__,Inv_GF256___1_t37__);
  Inv_GF256___1_t39__ = XOR(Inv_GF256___1_t32__,Inv_GF256___1_t33__);
  Inv_GF256___1_t40__ = XOR(Inv_GF256___1_t31__,Inv_GF256___1_t35__);
  Inv_GF256___1_t41__ = AND(Inv_GF256___1_t40__,Inv_GF256___1_t39__);
  Inv_GF256___1_t42__ = XOR(Inv_GF256___1_t33__,Inv_GF256___1_t41__);
  Inv_GF256___1_t43__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_t32__);
  Inv_GF256___1_t44__ = XOR(Inv_GF256___1_t36__,Inv_GF256___1_t42__);
  Inv_GF256___1_t45__ = AND(Inv_GF256___1_t33__,Inv_GF256___1_t44__);
  Inv_GF256___1_t46__ = XOR(Inv_GF256___1_t45__,Inv_GF256___1_t43__);
  Inv_GF256___1_t47__ = XOR(Inv_GF256___1_t45__,Inv_GF256___1_t36__);
  Inv_GF256___1_t48__ = AND(Inv_GF256___1_t38__,Inv_GF256___1_t47__);
  Inv_GF256___1_t49__ = XOR(Inv_GF256___1_t34__,Inv_GF256___1_t48__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t0__ = XOR(Inv_GF256___1_t38__,Inv_GF256___1_t49__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t1__ = AND(InBasisChange___1_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t0__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t3__ = AND(Inv_GF256___1_t49__,Inv_GF256___1_t17__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__ = AND(InBasisChange___1_t2__,Inv_GF256___1_t38__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__);
  Inv_GF256___1_Mul_GF16_2___1_t4__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_t38__);
  Inv_GF256___1_Mul_GF16_2___1_t5__ = XOR(Inv_GF256___1_t46__,Inv_GF256___1_t49__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t4__,Inv_GF256___1_Mul_GF16_2___1_t5__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t1__ = AND(Inv_GF256___1_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__ = AND(Inv_GF256___1_Mul_GF16_2___1_t5__,Inv_GF256___1_t10__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t4__ = AND(Inv_GF256___1_Mul_GF16_2___1_t4__,Inv_GF256___1_t2__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t4__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_t46__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t1__ = AND(b0__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t3__ = AND(Inv_GF256___1_t46__,Inv_GF256___1_t12__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__ = AND(InBasisChange___1_t10__,Inv_GF256___1_t42__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__);
  Inv_GF256___1_Mul_GF16_2___1_t10__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t5__);
  Inv_GF256___1_Mul_GF16_2___1_t11__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__);
  Inv_GF256___1_Mul_GF16_2___1_t12__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t6__);
  Inv_GF256___1_Mul_GF16_2___1_t13__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t1__ = AND(Inv_GF256___1_t0__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__ = AND(Inv_GF256___1_Mul_GF16_2___1_t5__,Inv_GF256___1_t5__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t4__ = AND(Inv_GF256___1_Mul_GF16_2___1_t4__,Inv_GF256___1_t1__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t4__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t1__ = AND(InBasisChange___1_t9__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t3__ = AND(Inv_GF256___1_t46__,Inv_GF256___1_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__ = AND(InBasisChange___1_t11__,Inv_GF256___1_t42__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__);
  Inv_GF256___1_Mul_GF16_2___1_t20__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_Mul_GF16_2___1_t4__);
  Inv_GF256___1_Mul_GF16_2___1_t21__ = XOR(Inv_GF256___1_t46__,Inv_GF256___1_Mul_GF16_2___1_t5__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t0__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t20__,Inv_GF256___1_Mul_GF16_2___1_t21__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t1__ = AND(InBasisChange___1_t7__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t0__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t3__ = AND(Inv_GF256___1_Mul_GF16_2___1_t21__,Inv_GF256___1_t16__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__ = AND(InBasisChange___1_t12__,Inv_GF256___1_Mul_GF16_2___1_t20__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t3__);
  Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__);
  Inv_GF256___1_Mul_GF16_2___1_t24__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t5__);
  Inv_GF256___1_Mul_GF16_2___1_t25__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t5__);
  Inv_GF256___1_Mul_GF16_2___1_t26__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t6__);
  Inv_GF256___1_Mul_GF16_2___1_t27__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t6__);
  OutBasisChange___1_t0__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t24__,Inv_GF256___1_Mul_GF16_2___1_t10__);
  OutBasisChange___1_t1__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t26__,Inv_GF256___1_Mul_GF16_2___1_t11__);
  OutBasisChange___1_t2__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t25__,OutBasisChange___1_t0__);
  OutBasisChange___1_t3__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t11__,Inv_GF256___1_Mul_GF16_2___1_t10__);
  OutBasisChange___1_t4__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t10__,OutBasisChange___1_t1__);
  OutBasisChange___1_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t13__,OutBasisChange___1_t1__);
  OutBasisChange___1_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t13__,Inv_GF256___1_Mul_GF16_2___1_t27__);
  OutBasisChange___1_t7__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t27__,Inv_GF256___1_Mul_GF16_2___1_t12__);
  OutBasisChange___1_t8__ = XOR(OutBasisChange___1_t2__,OutBasisChange___1_t6__);
  OutBasisChange___1_t9__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t12__,OutBasisChange___1_t6__);
  OutBasisChange___1_t10__ = XOR(OutBasisChange___1_t3__,OutBasisChange___1_t9__);
  *o0__ = OutBasisChange___1_t4__;
  *o1__ = OutBasisChange___1_t5__;
  *o2__ = OutBasisChange___1_t8__;
  *o3__ = OutBasisChange___1_t10__;
  *o4__ = OutBasisChange___1_t9__;
  *o5__ = OutBasisChange___1_t0__;
  *o6__ = OutBasisChange___1_t7__;
  *o7__ = OutBasisChange___1_t6__;

}

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
 

#elif defined(KEYXOR_TOPLOOP)


#if NO_ARRAY
void AES_usuba (DATATYPE plain__0,DATATYPE plain__1,DATATYPE plain__2,DATATYPE plain__3,
            DATATYPE plain__4,DATATYPE plain__5,DATATYPE plain__6,DATATYPE plain__7,
            DATATYPE key__[11][8],
            DATATYPE* cipher__0,DATATYPE* cipher__1,DATATYPE* cipher__2,DATATYPE* cipher__3,
            DATATYPE* cipher__4,DATATYPE* cipher__5,DATATYPE* cipher__6,DATATYPE* cipher__7) {
#else
/* main function */
void AES__ (/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
#endif

  
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

#ifdef NO_ARRAY
  tmp__[0] = plain__0;
  tmp__[1] = plain__1;
  tmp__[2] = plain__2;
  tmp__[3] = plain__3;
  tmp__[4] = plain__4;
  tmp__[5] = plain__5;
  tmp__[6] = plain__6;
  tmp__[7] = plain__7;  
#else
  // Instructions (body)
  tmp__[0] = plain__[0];
  tmp__[1] = plain__[1];
  tmp__[2] = plain__[2];
  tmp__[3] = plain__[3];
  tmp__[4] = plain__[4];
  tmp__[5] = plain__[5];
  tmp__[6] = plain__[6];
  tmp__[7] = plain__[7];
#endif
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
#ifdef NO_ARRAY
  *cipher__0 = XOR(_tmp71_[0],key__[10][0]);
  *cipher__1 = XOR(_tmp71_[1],key__[10][1]);
  *cipher__2 = XOR(_tmp71_[2],key__[10][2]);
  *cipher__3 = XOR(_tmp71_[3],key__[10][3]);
  *cipher__4 = XOR(_tmp71_[4],key__[10][4]);
  *cipher__5 = XOR(_tmp71_[5],key__[10][5]);
  *cipher__6 = XOR(_tmp71_[6],key__[10][6]);
  *cipher__7 = XOR(_tmp71_[7],key__[10][7]);
#else
  cipher__[0] = XOR(_tmp71_[0],key__[10][0]);
  cipher__[1] = XOR(_tmp71_[1],key__[10][1]);
  cipher__[2] = XOR(_tmp71_[2],key__[10][2]);
  cipher__[3] = XOR(_tmp71_[3],key__[10][3]);
  cipher__[4] = XOR(_tmp71_[4],key__[10][4]);
  cipher__[5] = XOR(_tmp71_[5],key__[10][5]);
  cipher__[6] = XOR(_tmp71_[6],key__[10][6]);
  cipher__[7] = XOR(_tmp71_[7],key__[10][7]);
#endif
}
#elif defined(MACRO)

#ifdef SBOX
#warning MACRO: ignoring SBOX value.
#undef SBOX
#endif
#define SBOX 5

#define SubBytes(v7,v6,v5,v4,v3,v2,v1,v0) {                             \
                                                                        \
    DATATYPE InBasisChange___1_t0__;                                    \
    DATATYPE InBasisChange___1_t1__;                                    \
    DATATYPE InBasisChange___1_t10__;                                   \
    DATATYPE InBasisChange___1_t11__;                                   \
    DATATYPE InBasisChange___1_t12__;                                   \
    DATATYPE InBasisChange___1_t2__;                                    \
    DATATYPE InBasisChange___1_t3__;                                    \
    DATATYPE InBasisChange___1_t4__;                                    \
    DATATYPE InBasisChange___1_t5__;                                    \
    DATATYPE InBasisChange___1_t6__;                                    \
    DATATYPE InBasisChange___1_t7__;                                    \
    DATATYPE InBasisChange___1_t8__;                                    \
    DATATYPE InBasisChange___1_t9__;                                    \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t0__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t1__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t3__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t5__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t6__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t1__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t3__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t5__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t6__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t1__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t3__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t5__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t6__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t0__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t1__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t3__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t5__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t6__;             \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t1__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t4__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t1__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t4__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__;           \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t10__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t11__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t12__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t13__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t20__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t21__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t24__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t25__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t26__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t27__;                        \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t4__;                         \
    DATATYPE Inv_GF256___1_Mul_GF16_2___1_t5__;                         \
    DATATYPE Inv_GF256___1_t0__;                                        \
    DATATYPE Inv_GF256___1_t1__;                                        \
    DATATYPE Inv_GF256___1_t10__;                                       \
    DATATYPE Inv_GF256___1_t11__;                                       \
    DATATYPE Inv_GF256___1_t12__;                                       \
    DATATYPE Inv_GF256___1_t13__;                                       \
    DATATYPE Inv_GF256___1_t14__;                                       \
    DATATYPE Inv_GF256___1_t15__;                                       \
    DATATYPE Inv_GF256___1_t16__;                                       \
    DATATYPE Inv_GF256___1_t17__;                                       \
    DATATYPE Inv_GF256___1_t18__;                                       \
    DATATYPE Inv_GF256___1_t19__;                                       \
    DATATYPE Inv_GF256___1_t2__;                                        \
    DATATYPE Inv_GF256___1_t20__;                                       \
    DATATYPE Inv_GF256___1_t21__;                                       \
    DATATYPE Inv_GF256___1_t22__;                                       \
    DATATYPE Inv_GF256___1_t23__;                                       \
    DATATYPE Inv_GF256___1_t24__;                                       \
    DATATYPE Inv_GF256___1_t25__;                                       \
    DATATYPE Inv_GF256___1_t26__;                                       \
    DATATYPE Inv_GF256___1_t27__;                                       \
    DATATYPE Inv_GF256___1_t28__;                                       \
    DATATYPE Inv_GF256___1_t29__;                                       \
    DATATYPE Inv_GF256___1_t3__;                                        \
    DATATYPE Inv_GF256___1_t30__;                                       \
    DATATYPE Inv_GF256___1_t31__;                                       \
    DATATYPE Inv_GF256___1_t32__;                                       \
    DATATYPE Inv_GF256___1_t33__;                                       \
    DATATYPE Inv_GF256___1_t34__;                                       \
    DATATYPE Inv_GF256___1_t35__;                                       \
    DATATYPE Inv_GF256___1_t36__;                                       \
    DATATYPE Inv_GF256___1_t37__;                                       \
    DATATYPE Inv_GF256___1_t38__;                                       \
    DATATYPE Inv_GF256___1_t39__;                                       \
    DATATYPE Inv_GF256___1_t4__;                                        \
    DATATYPE Inv_GF256___1_t40__;                                       \
    DATATYPE Inv_GF256___1_t41__;                                       \
    DATATYPE Inv_GF256___1_t42__;                                       \
    DATATYPE Inv_GF256___1_t43__;                                       \
    DATATYPE Inv_GF256___1_t44__;                                       \
    DATATYPE Inv_GF256___1_t45__;                                       \
    DATATYPE Inv_GF256___1_t46__;                                       \
    DATATYPE Inv_GF256___1_t47__;                                       \
    DATATYPE Inv_GF256___1_t48__;                                       \
    DATATYPE Inv_GF256___1_t49__;                                       \
    DATATYPE Inv_GF256___1_t5__;                                        \
    DATATYPE Inv_GF256___1_t6__;                                        \
    DATATYPE Inv_GF256___1_t7__;                                        \
    DATATYPE Inv_GF256___1_t8__;                                        \
    DATATYPE Inv_GF256___1_t9__;                                        \
    DATATYPE OutBasisChange___1_t0__;                                   \
    DATATYPE OutBasisChange___1_t1__;                                   \
    DATATYPE OutBasisChange___1_t10__;                                  \
    DATATYPE OutBasisChange___1_t2__;                                   \
    DATATYPE OutBasisChange___1_t3__;                                   \
    DATATYPE OutBasisChange___1_t4__;                                   \
    DATATYPE OutBasisChange___1_t5__;                                   \
    DATATYPE OutBasisChange___1_t6__;                                   \
    DATATYPE OutBasisChange___1_t7__;                                   \
    DATATYPE OutBasisChange___1_t8__;                                   \
    DATATYPE OutBasisChange___1_t9__;                                   \
                                                                        \
                                                                        \
    InBasisChange___1_t0__ = XOR(v6,v5);                                \
    InBasisChange___1_t1__ = XOR(v1,v2);                                \
    InBasisChange___1_t2__ = XOR(v0,InBasisChange___1_t0__);            \
    InBasisChange___1_t3__ = XOR(InBasisChange___1_t1__,v6);            \
    InBasisChange___1_t4__ = XOR(v0,v3);                                \
    InBasisChange___1_t5__ = XOR(InBasisChange___1_t4__,InBasisChange___1_t3__); \
    InBasisChange___1_t6__ = XOR(v7,InBasisChange___1_t4__);            \
    InBasisChange___1_t7__ = XOR(InBasisChange___1_t2__,v7);            \
    InBasisChange___1_t8__ = XOR(v4,InBasisChange___1_t6__);            \
    InBasisChange___1_t9__ = XOR(InBasisChange___1_t2__,v4);            \
    InBasisChange___1_t10__ = XOR(v1,InBasisChange___1_t8__);           \
    InBasisChange___1_t11__ = XOR(InBasisChange___1_t7__,InBasisChange___1_t1__); \
    InBasisChange___1_t12__ = XOR(InBasisChange___1_t2__,v1);           \
    Inv_GF256___1_t0__ = XOR(InBasisChange___1_t7__,InBasisChange___1_t9__); \
    Inv_GF256___1_t1__ = XOR(InBasisChange___1_t12__,InBasisChange___1_t11__); \
    Inv_GF256___1_t2__ = XOR(InBasisChange___1_t2__,InBasisChange___1_t10__); \
    Inv_GF256___1_t3__ = XOR(InBasisChange___1_t11__,InBasisChange___1_t9__); \
    Inv_GF256___1_t4__ = XOR(InBasisChange___1_t5__,v0);                \
    Inv_GF256___1_t5__ = XOR(Inv_GF256___1_t0__,Inv_GF256___1_t1__);    \
    Inv_GF256___1_t6__ = AND(Inv_GF256___1_t1__,Inv_GF256___1_t2__);    \
    Inv_GF256___1_t7__ = OR(Inv_GF256___1_t2__,Inv_GF256___1_t1__);     \
    Inv_GF256___1_t8__ = AND(Inv_GF256___1_t0__,Inv_GF256___1_t4__);    \
    Inv_GF256___1_t9__ = OR(Inv_GF256___1_t4__,Inv_GF256___1_t0__);     \
    Inv_GF256___1_t10__ = XOR(Inv_GF256___1_t2__,Inv_GF256___1_t4__);   \
    Inv_GF256___1_t11__ = AND(Inv_GF256___1_t10__,Inv_GF256___1_t5__);  \
    Inv_GF256___1_t12__ = XOR(InBasisChange___1_t10__,v0);              \
    Inv_GF256___1_t13__ = AND(Inv_GF256___1_t12__,Inv_GF256___1_t3__);  \
    Inv_GF256___1_t14__ = XOR(Inv_GF256___1_t13__,Inv_GF256___1_t9__);  \
    Inv_GF256___1_t15__ = XOR(Inv_GF256___1_t13__,Inv_GF256___1_t7__);  \
    Inv_GF256___1_t16__ = XOR(InBasisChange___1_t7__,InBasisChange___1_t12__); \
    Inv_GF256___1_t17__ = XOR(InBasisChange___1_t2__,InBasisChange___1_t5__); \
    Inv_GF256___1_t18__ = OR(Inv_GF256___1_t16__,Inv_GF256___1_t17__);  \
    Inv_GF256___1_t19__ = AND(Inv_GF256___1_t17__,Inv_GF256___1_t16__); \
    Inv_GF256___1_t20__ = XOR(Inv_GF256___1_t19__,Inv_GF256___1_t6__);  \
    Inv_GF256___1_t21__ = XOR(Inv_GF256___1_t11__,Inv_GF256___1_t14__); \
    Inv_GF256___1_t22__ = XOR(Inv_GF256___1_t8__,Inv_GF256___1_t15__);  \
    Inv_GF256___1_t23__ = XOR(Inv_GF256___1_t11__,Inv_GF256___1_t18__); \
    Inv_GF256___1_t24__ = XOR(Inv_GF256___1_t8__,Inv_GF256___1_t20__);  \
    Inv_GF256___1_t25__ = XOR(Inv_GF256___1_t8__,Inv_GF256___1_t23__);  \
    Inv_GF256___1_t26__ = AND(InBasisChange___1_t11__,InBasisChange___1_t10__); \
    Inv_GF256___1_t27__ = AND(InBasisChange___1_t9__,v0);               \
    Inv_GF256___1_t28__ = AND(InBasisChange___1_t12__,InBasisChange___1_t2__); \
    Inv_GF256___1_t29__ = OR(InBasisChange___1_t7__,InBasisChange___1_t5__); \
    Inv_GF256___1_t30__ = XOR(Inv_GF256___1_t26__,Inv_GF256___1_t21__); \
    Inv_GF256___1_t31__ = XOR(Inv_GF256___1_t27__,Inv_GF256___1_t22__); \
    Inv_GF256___1_t32__ = XOR(Inv_GF256___1_t28__,Inv_GF256___1_t25__); \
    Inv_GF256___1_t33__ = XOR(Inv_GF256___1_t29__,Inv_GF256___1_t24__); \
    Inv_GF256___1_t34__ = XOR(Inv_GF256___1_t30__,Inv_GF256___1_t31__); \
    Inv_GF256___1_t35__ = AND(Inv_GF256___1_t32__,Inv_GF256___1_t30__); \
    Inv_GF256___1_t36__ = XOR(Inv_GF256___1_t33__,Inv_GF256___1_t35__); \
    Inv_GF256___1_t37__ = AND(Inv_GF256___1_t34__,Inv_GF256___1_t36__); \
    Inv_GF256___1_t38__ = XOR(Inv_GF256___1_t31__,Inv_GF256___1_t37__); \
    Inv_GF256___1_t39__ = XOR(Inv_GF256___1_t32__,Inv_GF256___1_t33__); \
    Inv_GF256___1_t40__ = XOR(Inv_GF256___1_t31__,Inv_GF256___1_t35__); \
    Inv_GF256___1_t41__ = AND(Inv_GF256___1_t40__,Inv_GF256___1_t39__); \
    Inv_GF256___1_t42__ = XOR(Inv_GF256___1_t33__,Inv_GF256___1_t41__); \
    Inv_GF256___1_t43__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_t32__); \
    Inv_GF256___1_t44__ = XOR(Inv_GF256___1_t36__,Inv_GF256___1_t42__); \
    Inv_GF256___1_t45__ = AND(Inv_GF256___1_t33__,Inv_GF256___1_t44__); \
    Inv_GF256___1_t46__ = XOR(Inv_GF256___1_t45__,Inv_GF256___1_t43__); \
    Inv_GF256___1_t47__ = XOR(Inv_GF256___1_t45__,Inv_GF256___1_t36__); \
    Inv_GF256___1_t48__ = AND(Inv_GF256___1_t38__,Inv_GF256___1_t47__); \
    Inv_GF256___1_t49__ = XOR(Inv_GF256___1_t34__,Inv_GF256___1_t48__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t0__ = XOR(Inv_GF256___1_t38__,Inv_GF256___1_t49__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t1__ = AND(InBasisChange___1_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t0__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t3__ = AND(Inv_GF256___1_t49__,Inv_GF256___1_t17__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__ = AND(InBasisChange___1_t2__,Inv_GF256___1_t38__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_t4__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_t38__); \
    Inv_GF256___1_Mul_GF16_2___1_t5__ = XOR(Inv_GF256___1_t46__,Inv_GF256___1_t49__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t4__,Inv_GF256___1_Mul_GF16_2___1_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t1__ = AND(Inv_GF256___1_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__ = AND(Inv_GF256___1_Mul_GF16_2___1_t5__,Inv_GF256___1_t10__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t4__ = AND(Inv_GF256___1_Mul_GF16_2___1_t4__,Inv_GF256___1_t2__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_t46__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t1__ = AND(v0,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t3__ = AND(Inv_GF256___1_t46__,Inv_GF256___1_t12__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__ = AND(InBasisChange___1_t10__,Inv_GF256___1_t42__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_t10__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_t11__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t6__); \
    Inv_GF256___1_Mul_GF16_2___1_t12__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t6__); \
    Inv_GF256___1_Mul_GF16_2___1_t13__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___1_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t1__ = AND(Inv_GF256___1_t0__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___1_t0__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__ = AND(Inv_GF256___1_Mul_GF16_2___1_t5__,Inv_GF256___1_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t4__ = AND(Inv_GF256___1_Mul_GF16_2___1_t4__,Inv_GF256___1_t1__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t1__ = AND(InBasisChange___1_t9__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___2_t0__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t3__ = AND(Inv_GF256___1_t46__,Inv_GF256___1_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__ = AND(InBasisChange___1_t11__,Inv_GF256___1_t42__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_t20__ = XOR(Inv_GF256___1_t42__,Inv_GF256___1_Mul_GF16_2___1_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_t21__ = XOR(Inv_GF256___1_t46__,Inv_GF256___1_Mul_GF16_2___1_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t0__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t20__,Inv_GF256___1_Mul_GF16_2___1_t21__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t1__ = AND(InBasisChange___1_t7__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t0__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t3__ = AND(Inv_GF256___1_Mul_GF16_2___1_t21__,Inv_GF256___1_t16__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__ = AND(InBasisChange___1_t12__,Inv_GF256___1_Mul_GF16_2___1_t20__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t3__); \
    Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t1__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t4__); \
    Inv_GF256___1_Mul_GF16_2___1_t24__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_t25__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t6__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t5__); \
    Inv_GF256___1_Mul_GF16_2___1_t26__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___4_t6__); \
    Inv_GF256___1_Mul_GF16_2___1_t27__ = XOR(Inv_GF256___1_Mul_GF16_2___1_Mul_GF4_N___2_t5__,Inv_GF256___1_Mul_GF16_2___1_Mul_GF4___3_t6__); \
    OutBasisChange___1_t0__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t24__,Inv_GF256___1_Mul_GF16_2___1_t10__); \
    OutBasisChange___1_t1__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t26__,Inv_GF256___1_Mul_GF16_2___1_t11__); \
    OutBasisChange___1_t2__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t25__,OutBasisChange___1_t0__); \
    OutBasisChange___1_t3__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t11__,Inv_GF256___1_Mul_GF16_2___1_t10__); \
    OutBasisChange___1_t4__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t10__,OutBasisChange___1_t1__); \
    OutBasisChange___1_t5__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t13__,OutBasisChange___1_t1__); \
    OutBasisChange___1_t6__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t13__,Inv_GF256___1_Mul_GF16_2___1_t27__); \
    OutBasisChange___1_t7__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t27__,Inv_GF256___1_Mul_GF16_2___1_t12__); \
    OutBasisChange___1_t8__ = XOR(OutBasisChange___1_t2__,OutBasisChange___1_t6__); \
    OutBasisChange___1_t9__ = XOR(Inv_GF256___1_Mul_GF16_2___1_t12__,OutBasisChange___1_t6__); \
    OutBasisChange___1_t10__ = XOR(OutBasisChange___1_t3__,OutBasisChange___1_t9__); \
    v0 = OutBasisChange___1_t4__;                                       \
    v1 = OutBasisChange___1_t5__;                                       \
    v2 = OutBasisChange___1_t8__;                                       \
    v3 = OutBasisChange___1_t10__;                                      \
    v4 = OutBasisChange___1_t9__;                                       \
    v5 = OutBasisChange___1_t0__;                                       \
    v6 = OutBasisChange___1_t7__;                                       \
    v7 = OutBasisChange___1_t6__;                                       \
                                                                        \
  }



#define ShiftRows(v0,v1,v2,v3,v4,v5,v6,v7) {                    \
    v0 = PERMUT_16(v0,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v1 = PERMUT_16(v1,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v2 = PERMUT_16(v2,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v3 = PERMUT_16(v3,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v4 = PERMUT_16(v4,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v5 = PERMUT_16(v5,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v6 = PERMUT_16(v6,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
    v7 = PERMUT_16(v7,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);   \
  }




#define MixColumn(v0,v1,v2,v3,v4,v5,v6,v7) {                            \
                                                                        \
    DATATYPE _tmp14_;                                                   \
    DATATYPE _tmp15_;                                                   \
    DATATYPE _tmp16_;                                                   \
    DATATYPE _tmp18_;                                                   \
    DATATYPE _tmp19_;                                                   \
    DATATYPE _tmp22_;                                                   \
    DATATYPE _tmp23_;                                                   \
    DATATYPE _tmp25_;                                                   \
    DATATYPE _tmp26_;                                                   \
    DATATYPE _tmp31_;                                                   \
    DATATYPE _tmp32_;                                                   \
    DATATYPE _tmp33_;                                                   \
    DATATYPE _tmp35_;                                                   \
    DATATYPE _tmp36_;                                                   \
    DATATYPE _tmp3_;                                                    \
    DATATYPE _tmp41_;                                                   \
    DATATYPE _tmp42_;                                                   \
    DATATYPE _tmp43_;                                                   \
    DATATYPE _tmp45_;                                                   \
    DATATYPE _tmp46_;                                                   \
    DATATYPE _tmp49_;                                                   \
    DATATYPE _tmp4_;                                                    \
    DATATYPE _tmp50_;                                                   \
    DATATYPE _tmp52_;                                                   \
    DATATYPE _tmp53_;                                                   \
    DATATYPE _tmp56_;                                                   \
    DATATYPE _tmp57_;                                                   \
    DATATYPE _tmp59_;                                                   \
    DATATYPE _tmp5_;                                                    \
    DATATYPE _tmp60_;                                                   \
    DATATYPE _tmp64_;                                                   \
    DATATYPE _tmp67_;                                                   \
    DATATYPE _tmp6_;                                                    \
    DATATYPE _tmp8_;                                                    \
    DATATYPE _tmp9_;                                                    \
                                                                        \
    _tmp3_ = PERMUT_16(v0,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);       \
    _tmp4_ = XOR(v0,_tmp3_);                                            \
    _tmp5_ = PERMUT_16(v7,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);       \
    _tmp6_ = XOR(_tmp4_,_tmp5_);                                        \
    _tmp8_ = XOR(v7,_tmp5_);                                            \
    _tmp9_ = PERMUT_16(_tmp8_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);   \
    v7 = XOR(_tmp6_,_tmp9_);                                            \
    _tmp14_ = XOR(_tmp8_,_tmp4_);                                       \
    _tmp15_ = PERMUT_16(v6,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp16_ = XOR(_tmp14_,_tmp15_);                                     \
    _tmp18_ = XOR(v6,_tmp15_);                                          \
    _tmp19_ = PERMUT_16(_tmp18_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    v6 = XOR(_tmp16_,_tmp19_);                                          \
    _tmp22_ = PERMUT_16(v5,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp23_ = XOR(_tmp18_,_tmp22_);                                     \
    _tmp25_ = XOR(v5,_tmp22_);                                          \
    _tmp26_ = PERMUT_16(_tmp25_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    v5 = XOR(_tmp23_,_tmp26_);                                          \
    _tmp31_ = XOR(_tmp25_,_tmp4_);                                      \
    _tmp32_ = PERMUT_16(v4,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp33_ = XOR(_tmp31_,_tmp32_);                                     \
    _tmp35_ = XOR(v4,_tmp32_);                                          \
    _tmp36_ = PERMUT_16(_tmp35_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    v4 = XOR(_tmp33_,_tmp36_);                                          \
    _tmp41_ = XOR(_tmp35_,_tmp4_);                                      \
    _tmp42_ = PERMUT_16(v3,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp43_ = XOR(_tmp41_,_tmp42_);                                     \
    _tmp45_ = XOR(v3,_tmp42_);                                          \
    _tmp46_ = PERMUT_16(_tmp45_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    v3 = XOR(_tmp43_,_tmp46_);                                          \
    _tmp49_ = PERMUT_16(v2,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp50_ = XOR(_tmp45_,_tmp49_);                                     \
    _tmp52_ = XOR(v2,_tmp49_);                                          \
    _tmp53_ = PERMUT_16(_tmp52_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    v2 = XOR(_tmp50_,_tmp53_);                                          \
    _tmp56_ = PERMUT_16(v1,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);      \
    _tmp57_ = XOR(_tmp52_,_tmp56_);                                     \
    _tmp59_ = XOR(v1,_tmp56_);                                          \
    _tmp60_ = PERMUT_16(_tmp59_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13); \
    v1 = XOR(_tmp57_,_tmp60_);                                          \
    _tmp64_ = XOR(_tmp59_,_tmp3_);                                      \
    _tmp67_ = PERMUT_16(_tmp4_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);  \
    v0 = XOR(_tmp64_,_tmp67_);                                          \
  }


 
#if 1
static inline void AES__(/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
  // Instructions (body)
  plain__[0] = XOR(plain__[0],key__[0][0]);
  plain__[1] = XOR(plain__[1],key__[0][1]);
  plain__[2] = XOR(plain__[2],key__[0][2]);
  plain__[3] = XOR(plain__[3],key__[0][3]);
  plain__[4] = XOR(plain__[4],key__[0][4]);
  plain__[5] = XOR(plain__[5],key__[0][5]);
  plain__[6] = XOR(plain__[6],key__[0][6]);
  plain__[7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN aes-usuba");
#endif
#ifdef _IACA
    IACA_START
#endif
    SubBytes(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
    ShiftRows(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
    MixColumn(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
    plain__[0] = XOR(plain__[0],key__[i][0]);
    plain__[1] = XOR(plain__[1],key__[i][1]);
    plain__[2] = XOR(plain__[2],key__[i][2]);
    plain__[3] = XOR(plain__[3],key__[i][3]);
    plain__[4] = XOR(plain__[4],key__[i][4]);
    plain__[5] = XOR(plain__[5],key__[i][5]);
    plain__[6] = XOR(plain__[6],key__[i][6]);
    plain__[7] = XOR(plain__[7],key__[i][7]);
  }
#ifdef _MCA
    __asm volatile("# LLVM-MCA-END");
#endif
#ifdef _IACA
    IACA_END
#endif
  SubBytes(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
  ShiftRows(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
  cipher__[0] = XOR(plain__[0],key__[10][0]);
  cipher__[1] = XOR(plain__[1],key__[10][1]);
  cipher__[2] = XOR(plain__[2],key__[10][2]);
  cipher__[3] = XOR(plain__[3],key__[10][3]);
  cipher__[4] = XOR(plain__[4],key__[10][4]);
  cipher__[5] = XOR(plain__[5],key__[10][5]);
  cipher__[6] = XOR(plain__[6],key__[10][6]);
  cipher__[7] = XOR(plain__[7],key__[10][7]);
}

#else /* UA MACRO, for interface with kivi */

void AES__(DATATYPE key__[11][8],DATATYPE plain__0,DATATYPE plain__1,DATATYPE plain__2,DATATYPE plain__3,DATATYPE plain__4,DATATYPE plain__5,DATATYPE plain__6,DATATYPE plain__7, /*outputs*/ DATATYPE cipher__[8]) {


  // Instructions (body)
  plain__0 = XOR(plain__0,key__[0][0]);
  plain__1 = XOR(plain__1,key__[0][1]);
  plain__2 = XOR(plain__2,key__[0][2]);
  plain__3 = XOR(plain__3,key__[0][3]);
  plain__4 = XOR(plain__4,key__[0][4]);
  plain__5 = XOR(plain__5,key__[0][5]);
  plain__6 = XOR(plain__6,key__[0][6]);
  plain__7 = XOR(plain__7,key__[0][7]);
  for (int i = 1; i <= 9; i++) {
    SubBytes(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
    ShiftRows(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
    MixColumn(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
    plain__0 = XOR(plain__0,key__[i][0]);
    plain__1 = XOR(plain__1,key__[i][1]);
    plain__2 = XOR(plain__2,key__[i][2]);
    plain__3 = XOR(plain__3,key__[i][3]);
    plain__4 = XOR(plain__4,key__[i][4]);
    plain__5 = XOR(plain__5,key__[i][5]);
    plain__6 = XOR(plain__6,key__[i][6]);
    plain__7 = XOR(plain__7,key__[i][7]);
  }
  SubBytes(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
  ShiftRows(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
  cipher__[0] = XOR(plain__0,key__[10][0]);
  cipher__[1] = XOR(plain__1,key__[10][1]);
  cipher__[2] = XOR(plain__2,key__[10][2]);
  cipher__[3] = XOR(plain__3,key__[10][3]);
  cipher__[4] = XOR(plain__4,key__[10][4]);
  cipher__[5] = XOR(plain__5,key__[10][5]);
  cipher__[6] = XOR(plain__6,key__[10][6]);
  cipher__[7] = XOR(plain__7,key__[10][7]);
}
#endif
#elif defined(UA_FUN)
 
void ShiftRows__ (/*inputs*/ DATATYPE inputSR__0__,DATATYPE inputSR__1__,DATATYPE inputSR__2__,DATATYPE inputSR__3__,DATATYPE inputSR__4__,DATATYPE inputSR__5__,DATATYPE inputSR__6__,DATATYPE inputSR__7__, /*outputs*/ DATATYPE* out__0__,DATATYPE* out__1__,DATATYPE* out__2__,DATATYPE* out__3__,DATATYPE* out__4__,DATATYPE* out__5__,DATATYPE* out__6__,DATATYPE* out__7__) {
  
  // Variables declaration


  // Instructions (body)
  *out__0__ = PERMUT_16(inputSR__0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__1__ = PERMUT_16(inputSR__1__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__2__ = PERMUT_16(inputSR__2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__3__ = PERMUT_16(inputSR__3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__4__ = PERMUT_16(inputSR__4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__5__ = PERMUT_16(inputSR__5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__6__ = PERMUT_16(inputSR__6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  *out__7__ = PERMUT_16(inputSR__7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);

}

void MixColumn__ (/*inputs*/ DATATYPE a__0__,DATATYPE a__1__,DATATYPE a__2__,DATATYPE a__3__,DATATYPE a__4__,DATATYPE a__5__,DATATYPE a__6__,DATATYPE a__7__, /*outputs*/ DATATYPE* b__0__,DATATYPE* b__1__,DATATYPE* b__2__,DATATYPE* b__3__,DATATYPE* b__4__,DATATYPE* b__5__,DATATYPE* b__6__,DATATYPE* b__7__) {
  
  // Variables declaration
  DATATYPE _tmp14_;
  DATATYPE _tmp15_;
  DATATYPE _tmp16_;
  DATATYPE _tmp18_;
  DATATYPE _tmp19_;
  DATATYPE _tmp22_;
  DATATYPE _tmp23_;
  DATATYPE _tmp25_;
  DATATYPE _tmp26_;
  DATATYPE _tmp31_;
  DATATYPE _tmp32_;
  DATATYPE _tmp33_;
  DATATYPE _tmp35_;
  DATATYPE _tmp36_;
  DATATYPE _tmp3_;
  DATATYPE _tmp41_;
  DATATYPE _tmp42_;
  DATATYPE _tmp43_;
  DATATYPE _tmp45_;
  DATATYPE _tmp46_;
  DATATYPE _tmp49_;
  DATATYPE _tmp4_;
  DATATYPE _tmp50_;
  DATATYPE _tmp52_;
  DATATYPE _tmp53_;
  DATATYPE _tmp56_;
  DATATYPE _tmp57_;
  DATATYPE _tmp59_;
  DATATYPE _tmp5_;
  DATATYPE _tmp60_;
  DATATYPE _tmp64_;
  DATATYPE _tmp67_;
  DATATYPE _tmp6_;
  DATATYPE _tmp8_;
  DATATYPE _tmp9_;


  // Instructions (body)
  _tmp3_ = PERMUT_16(a__0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp4_ = XOR(a__0__,_tmp3_);
  _tmp5_ = PERMUT_16(a__7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp6_ = XOR(_tmp4_,_tmp5_);
  _tmp8_ = XOR(a__7__,_tmp5_);
  _tmp9_ = PERMUT_16(_tmp8_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__7__ = XOR(_tmp6_,_tmp9_);
  _tmp14_ = XOR(_tmp8_,_tmp4_);
  _tmp15_ = PERMUT_16(a__6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp16_ = XOR(_tmp14_,_tmp15_);
  _tmp18_ = XOR(a__6__,_tmp15_);
  _tmp19_ = PERMUT_16(_tmp18_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__6__ = XOR(_tmp16_,_tmp19_);
  _tmp22_ = PERMUT_16(a__5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp23_ = XOR(_tmp18_,_tmp22_);
  _tmp25_ = XOR(a__5__,_tmp22_);
  _tmp26_ = PERMUT_16(_tmp25_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__5__ = XOR(_tmp23_,_tmp26_);
  _tmp31_ = XOR(_tmp25_,_tmp4_);
  _tmp32_ = PERMUT_16(a__4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp33_ = XOR(_tmp31_,_tmp32_);
  _tmp35_ = XOR(a__4__,_tmp32_);
  _tmp36_ = PERMUT_16(_tmp35_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__4__ = XOR(_tmp33_,_tmp36_);
  _tmp41_ = XOR(_tmp35_,_tmp4_);
  _tmp42_ = PERMUT_16(a__3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp43_ = XOR(_tmp41_,_tmp42_);
  _tmp45_ = XOR(a__3__,_tmp42_);
  _tmp46_ = PERMUT_16(_tmp45_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__3__ = XOR(_tmp43_,_tmp46_);
  _tmp49_ = PERMUT_16(a__2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp50_ = XOR(_tmp45_,_tmp49_);
  _tmp52_ = XOR(a__2__,_tmp49_);
  _tmp53_ = PERMUT_16(_tmp52_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__2__ = XOR(_tmp50_,_tmp53_);
  _tmp56_ = PERMUT_16(a__1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp57_ = XOR(_tmp52_,_tmp56_);
  _tmp59_ = XOR(a__1__,_tmp56_);
  _tmp60_ = PERMUT_16(_tmp59_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__1__ = XOR(_tmp57_,_tmp60_);
  _tmp64_ = XOR(_tmp59_,_tmp3_);
  _tmp67_ = PERMUT_16(_tmp4_,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  *b__0__ = XOR(_tmp64_,_tmp67_);

}

 
void AES__(/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {


  // Instructions (body)
  plain__[0] = XOR(plain__[0],key__[0][0]);
  plain__[1] = XOR(plain__[1],key__[0][1]);
  plain__[2] = XOR(plain__[2],key__[0][2]);
  plain__[3] = XOR(plain__[3],key__[0][3]);
  plain__[4] = XOR(plain__[4],key__[0][4]);
  plain__[5] = XOR(plain__[5],key__[0][5]);
  plain__[6] = XOR(plain__[6],key__[0][6]);
  plain__[7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN aes-usuba");
#endif
#ifdef _IACA
    IACA_START
#endif
      SubBytes__(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7],&plain__[0],&plain__[1],&plain__[2],&plain__[3],&plain__[4],&plain__[5],&plain__[6],&plain__[7]);
    ShiftRows__(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7],&plain__[0],&plain__[1],&plain__[2],&plain__[3],&plain__[4],&plain__[5],&plain__[6],&plain__[7]);
    MixColumn__(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7],&plain__[0],&plain__[1],&plain__[2],&plain__[3],&plain__[4],&plain__[5],&plain__[6],&plain__[7]);
    plain__[0] = XOR(plain__[0],key__[i][0]);
    plain__[1] = XOR(plain__[1],key__[i][1]);
    plain__[2] = XOR(plain__[2],key__[i][2]);
    plain__[3] = XOR(plain__[3],key__[i][3]);
    plain__[4] = XOR(plain__[4],key__[i][4]);
    plain__[5] = XOR(plain__[5],key__[i][5]);
    plain__[6] = XOR(plain__[6],key__[i][6]);
    plain__[7] = XOR(plain__[7],key__[i][7]);
  }
#ifdef _MCA
    __asm volatile("# LLVM-MCA-END");
#endif
#ifdef _IACA
    IACA_END
#endif
  SubBytes__(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7],&plain__[0],&plain__[1],&plain__[2],&plain__[3],&plain__[4],&plain__[5],&plain__[6],&plain__[7]);
  ShiftRows__(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7],&plain__[0],&plain__[1],&plain__[2],&plain__[3],&plain__[4],&plain__[5],&plain__[6],&plain__[7]);
  cipher__[0] = XOR(plain__[0],key__[10][0]);
  cipher__[1] = XOR(plain__[1],key__[10][1]);
  cipher__[2] = XOR(plain__[2],key__[10][2]);
  cipher__[3] = XOR(plain__[3],key__[10][3]);
  cipher__[4] = XOR(plain__[4],key__[10][4]);
  cipher__[5] = XOR(plain__[5],key__[10][5]);
  cipher__[6] = XOR(plain__[6],key__[10][6]);
  cipher__[7] = XOR(plain__[7],key__[10][7]);
}
 
#elif defined(KIVI)

#ifdef SBOX
#warning KIVI: ignoring SBOX value.
#undef SBOX
#endif

#define SBOX 0
   
uint64_t Lshiftrow_shuf[2]   = { 0x030e09040f0a0500, 0x0b06010c07020d08 };
uint64_t Lror_byte_1_shuf[2] = { 0x0407060500030201, 0x0c0f0e0d080b0a09 };
uint64_t Lror_byte_2_shuf[2] = { 0x0504070601000302, 0x0d0c0f0e09080b0a };
 
#define shiftrows_subbytes_mixcolumn(/* v0,v1,v2,v3,v4,v5,v6,v7 */ v7,v6,v5,v4,v3,v2,v1,v0 ) \
  __asm__ (                                                             \
                                                                        \
           "vmovdqa %8, %%xmm8; vpshufb %%xmm8, %0, %0; vpshufb %%xmm8, %1, %1; vpshufb %%xmm8, %2, %2; vpshufb %%xmm8, %3, %3; vpshufb %%xmm8, %4, %4; vpshufb %%xmm8, %5, %5; vpshufb %%xmm8, %6, %6; vpshufb %%xmm8, %7, %7;" \
                                                                        \
           "vpxor %6, %5, %5; vpxor %1, %2, %2; vpxor %0, %5, %%xmm8; vpxor %2, %6, %6; vpxor %0, %3, %3; vpxor %3, %6, %6; vpxor %7, %3, %3; vpxor %%xmm8, %7, %7; vpxor %4, %3, %3; vpxor %%xmm8, %4, %4; vpxor %1, %3, %3; vpxor %7, %2, %2; vpxor %%xmm8, %1, %1;; vpxor %7, %4, %%xmm11; vpxor %1, %2, %%xmm10; vpxor %%xmm8, %3, %%xmm9; vpxor %2, %4, %%xmm13; vpxor %6, %0, %%xmm12; vpxor %%xmm11, %%xmm10, %%xmm15; vpand %%xmm10, %%xmm9, %5; vpor %%xmm9, %%xmm10, %%xmm10; vpand %%xmm11, %%xmm12, %%xmm14; vpor %%xmm12, %%xmm11, %%xmm11; vpxor %%xmm9, %%xmm12, %%xmm12; vpand %%xmm12, %%xmm15, %%xmm15; vpxor %3, %0, %%xmm12; vpand %%xmm12, %%xmm13, %%xmm13; vpxor %%xmm13, %%xmm11, %%xmm11; vpxor %%xmm13, %%xmm10, %%xmm10; vpxor %7, %1, %%xmm13; vpxor %%xmm8, %6, %%xmm12; vpor %%xmm13, %%xmm12, %%xmm9; vpand %%xmm12, %%xmm13, %%xmm13; vpxor %%xmm13, %5, %5; vpxor %%xmm15, %%xmm11, %%xmm11; vpxor %%xmm14, %%xmm10, %%xmm10; vpxor %%xmm15, %%xmm9, %%xmm9; vpxor %%xmm14, %5, %5; vpxor %%xmm14, %%xmm9, %%xmm9; vpand %2, %3, %%xmm12; vpand %4, %0, %%xmm13; vpand %1, %%xmm8, %%xmm14; vpor %7, %6, %%xmm15; vpxor %%xmm12, %%xmm11, %%xmm11; vpxor %%xmm13, %%xmm10, %%xmm10; vpxor %%xmm14, %%xmm9, %%xmm9; vpxor %%xmm15, %5, %5; vpxor %%xmm11, %%xmm10, %%xmm12; vpand %%xmm9, %%xmm11, %%xmm11; vpxor %5, %%xmm11, %%xmm14; vpand %%xmm12, %%xmm14, %%xmm15; vpxor %%xmm10, %%xmm15, %%xmm15; vpxor %%xmm9, %5, %%xmm13; vpxor %%xmm10, %%xmm11, %%xmm11; vpand %%xmm11, %%xmm13, %%xmm13; vpxor %5, %%xmm13, %%xmm13; vpxor %%xmm13, %%xmm9, %%xmm9; vpxor %%xmm14, %%xmm13, %%xmm10; vpand %5, %%xmm10, %%xmm10; vpxor %%xmm10, %%xmm9, %%xmm9; vpxor %%xmm10, %%xmm14, %%xmm14; vpand %%xmm15, %%xmm14, %%xmm14; vpxor %%xmm12, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm10; vpand %6, %%xmm10, %%xmm10; vpxor %6, %%xmm8, %%xmm12; vpand %%xmm14, %%xmm12, %%xmm12; vpand %%xmm8, %%xmm15, %5; vpxor %5, %%xmm12, %%xmm12; vpxor %%xmm10, %5, %5;; vpxor %0, %6, %6; vpxor %3, %%xmm8, %%xmm8; vpxor %%xmm13, %%xmm15, %%xmm15; vpxor %%xmm9, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %6, %%xmm11, %%xmm11; vpxor %%xmm8, %6, %6; vpand %%xmm14, %6, %6; vpand %%xmm15, %%xmm8, %%xmm8; vpxor %6, %%xmm8, %%xmm8; vpxor %%xmm11, %6, %6;; vpxor %%xmm13, %%xmm9, %%xmm10; vpand %0, %%xmm10, %%xmm10; vpxor %0, %3, %0; vpand %%xmm9, %0, %0; vpand %3, %%xmm13, %3; vpxor %3, %0, %0; vpxor %%xmm10, %3, %3;; vpxor %6, %0, %0; vpxor %%xmm12, %6, %6; vpxor %%xmm8, %3, %3; vpxor %5, %%xmm8, %%xmm8; vpxor %7, %4, %%xmm12; vpxor %1, %2, %5; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %%xmm12, %%xmm11, %%xmm11; vpxor %5, %%xmm12, %%xmm12; vpand %%xmm14, %%xmm12, %%xmm12; vpand %%xmm15, %5, %5; vpxor %%xmm12, %5, %5; vpxor %%xmm11, %%xmm12, %%xmm12;; vpxor %%xmm13, %%xmm9, %%xmm10; vpand %4, %%xmm10, %%xmm10; vpxor %4, %2, %4; vpand %%xmm9, %4, %4; vpand %2, %%xmm13, %2; vpxor %2, %4, %4; vpxor %%xmm10, %2, %2;; vpxor %%xmm13, %%xmm15, %%xmm15; vpxor %%xmm9, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %7, %%xmm11, %%xmm11; vpxor %7, %1, %7; vpand %%xmm14, %7, %7; vpand %1, %%xmm15, %1; vpxor %1, %7, %7; vpxor %%xmm11, %1, %1;; vpxor %%xmm12, %7, %7; vpxor %%xmm12, %4, %4; vpxor %5, %1, %1; vpxor %5, %2, %2;;; vpxor %7, %0, %5; vpxor %1, %6, %%xmm9; vpxor %4, %5, %%xmm10; vpxor %6, %0, %%xmm12; vpxor %0, %%xmm9, %0; vpxor %%xmm8, %%xmm9, %1; vpxor %%xmm8, %2, %7; vpxor %2, %3, %6; vpxor %%xmm10, %7, %2; vpxor %3, %7, %4; vpxor %%xmm12, %4, %3;" \
                                                                        \
           "vmovdqa Lror_byte_1_shuf, %%xmm14; vmovdqa Lror_byte_2_shuf, %%xmm15; vpshufb %%xmm14, %0, %%xmm8; vpxor %0, %%xmm8, %0; vpshufb %%xmm14, %1, %%xmm9; vpxor %1, %%xmm9, %1; vpshufb %%xmm14, %2, %%xmm10; vpxor %2, %%xmm10, %2; vpshufb %%xmm14, %3, %%xmm11; vpxor %3, %%xmm11, %3; vpxor %0, %%xmm9, %%xmm9; vpshufb %%xmm15, %0, %0; vpxor %1, %%xmm10, %%xmm10; vpshufb %%xmm15, %1, %1; vpxor %2, %%xmm11, %%xmm11; vpshufb %%xmm15, %2, %2; vpxor %2, %%xmm10, %2; vpshufb %%xmm14, %7, %%xmm10; vpxor %7, %%xmm10, %7; vpshufb %%xmm14, %4, %%xmm12; vpxor %4, %%xmm12, %4; vpshufb %%xmm14, %5, %%xmm13; vpxor %5, %%xmm13, %5; vpshufb %%xmm14, %6, %%xmm14; vpxor %6, %%xmm14, %6; vpxor %3, %%xmm12, %%xmm12; vpshufb %%xmm15, %3, %3; vpxor %4, %%xmm13, %%xmm13; vpshufb %%xmm15, %4, %4; vpxor %5, %%xmm14, %%xmm14; vpshufb %%xmm15, %5, %5; vpxor %5, %%xmm13, %5; vpxor %6, %%xmm10, %%xmm10; vpshufb %%xmm15, %6, %6; vpxor %6, %%xmm14, %6; vpxor %7, %%xmm8, %%xmm8; vpxor %0, %%xmm8, %0; vpxor %7, %%xmm9, %%xmm9; vpxor %1, %%xmm9, %1; vpxor %7, %%xmm11, %%xmm11; vpxor %3, %%xmm11, %3; vpxor %7, %%xmm12, %%xmm12; vpxor %4, %%xmm12, %4; vpshufb %%xmm15, %7, %7; vpxor %7, %%xmm10, %7;" \
           :                                                            \
                                                                        \
           "+x" (v0), "+x" (v1), "+x" (v2), "+x" (v3), "+x" (v4), "+x" (v5), "+x" (v6), "+x" (v7) : \
                                                                        "m" (Lshiftrow_shuf), "m" (Lror_byte_1_shuf), "m" (Lror_byte_2_shuf) : \
           "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15");


#define shiftrows_subbytes(/* v0,v1,v2,v3,v4,v5,v6,v7 */ v7,v6,v5,v4,v3,v2,v1,v0 ) \
  __asm__ (                                                             \
                                                                        \
           "vmovdqa %8, %%xmm8; vpshufb %%xmm8, %0, %0; vpshufb %%xmm8, %1, %1; vpshufb %%xmm8, %2, %2; vpshufb %%xmm8, %3, %3; vpshufb %%xmm8, %4, %4; vpshufb %%xmm8, %5, %5; vpshufb %%xmm8, %6, %6; vpshufb %%xmm8, %7, %7;" \
                                                                        \
           "vpxor %6, %5, %5; vpxor %1, %2, %2; vpxor %0, %5, %%xmm8; vpxor %2, %6, %6; vpxor %0, %3, %3; vpxor %3, %6, %6; vpxor %7, %3, %3; vpxor %%xmm8, %7, %7; vpxor %4, %3, %3; vpxor %%xmm8, %4, %4; vpxor %1, %3, %3; vpxor %7, %2, %2; vpxor %%xmm8, %1, %1;; vpxor %7, %4, %%xmm11; vpxor %1, %2, %%xmm10; vpxor %%xmm8, %3, %%xmm9; vpxor %2, %4, %%xmm13; vpxor %6, %0, %%xmm12; vpxor %%xmm11, %%xmm10, %%xmm15; vpand %%xmm10, %%xmm9, %5; vpor %%xmm9, %%xmm10, %%xmm10; vpand %%xmm11, %%xmm12, %%xmm14; vpor %%xmm12, %%xmm11, %%xmm11; vpxor %%xmm9, %%xmm12, %%xmm12; vpand %%xmm12, %%xmm15, %%xmm15; vpxor %3, %0, %%xmm12; vpand %%xmm12, %%xmm13, %%xmm13; vpxor %%xmm13, %%xmm11, %%xmm11; vpxor %%xmm13, %%xmm10, %%xmm10; vpxor %7, %1, %%xmm13; vpxor %%xmm8, %6, %%xmm12; vpor %%xmm13, %%xmm12, %%xmm9; vpand %%xmm12, %%xmm13, %%xmm13; vpxor %%xmm13, %5, %5; vpxor %%xmm15, %%xmm11, %%xmm11; vpxor %%xmm14, %%xmm10, %%xmm10; vpxor %%xmm15, %%xmm9, %%xmm9; vpxor %%xmm14, %5, %5; vpxor %%xmm14, %%xmm9, %%xmm9; vpand %2, %3, %%xmm12; vpand %4, %0, %%xmm13; vpand %1, %%xmm8, %%xmm14; vpor %7, %6, %%xmm15; vpxor %%xmm12, %%xmm11, %%xmm11; vpxor %%xmm13, %%xmm10, %%xmm10; vpxor %%xmm14, %%xmm9, %%xmm9; vpxor %%xmm15, %5, %5; vpxor %%xmm11, %%xmm10, %%xmm12; vpand %%xmm9, %%xmm11, %%xmm11; vpxor %5, %%xmm11, %%xmm14; vpand %%xmm12, %%xmm14, %%xmm15; vpxor %%xmm10, %%xmm15, %%xmm15; vpxor %%xmm9, %5, %%xmm13; vpxor %%xmm10, %%xmm11, %%xmm11; vpand %%xmm11, %%xmm13, %%xmm13; vpxor %5, %%xmm13, %%xmm13; vpxor %%xmm13, %%xmm9, %%xmm9; vpxor %%xmm14, %%xmm13, %%xmm10; vpand %5, %%xmm10, %%xmm10; vpxor %%xmm10, %%xmm9, %%xmm9; vpxor %%xmm10, %%xmm14, %%xmm14; vpand %%xmm15, %%xmm14, %%xmm14; vpxor %%xmm12, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm10; vpand %6, %%xmm10, %%xmm10; vpxor %6, %%xmm8, %%xmm12; vpand %%xmm14, %%xmm12, %%xmm12; vpand %%xmm8, %%xmm15, %5; vpxor %5, %%xmm12, %%xmm12; vpxor %%xmm10, %5, %5;; vpxor %0, %6, %6; vpxor %3, %%xmm8, %%xmm8; vpxor %%xmm13, %%xmm15, %%xmm15; vpxor %%xmm9, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %6, %%xmm11, %%xmm11; vpxor %%xmm8, %6, %6; vpand %%xmm14, %6, %6; vpand %%xmm15, %%xmm8, %%xmm8; vpxor %6, %%xmm8, %%xmm8; vpxor %%xmm11, %6, %6;; vpxor %%xmm13, %%xmm9, %%xmm10; vpand %0, %%xmm10, %%xmm10; vpxor %0, %3, %0; vpand %%xmm9, %0, %0; vpand %3, %%xmm13, %3; vpxor %3, %0, %0; vpxor %%xmm10, %3, %3;; vpxor %6, %0, %0; vpxor %%xmm12, %6, %6; vpxor %%xmm8, %3, %3; vpxor %5, %%xmm8, %%xmm8; vpxor %7, %4, %%xmm12; vpxor %1, %2, %5; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %%xmm12, %%xmm11, %%xmm11; vpxor %5, %%xmm12, %%xmm12; vpand %%xmm14, %%xmm12, %%xmm12; vpand %%xmm15, %5, %5; vpxor %%xmm12, %5, %5; vpxor %%xmm11, %%xmm12, %%xmm12;; vpxor %%xmm13, %%xmm9, %%xmm10; vpand %4, %%xmm10, %%xmm10; vpxor %4, %2, %4; vpand %%xmm9, %4, %4; vpand %2, %%xmm13, %2; vpxor %2, %4, %4; vpxor %%xmm10, %2, %2;; vpxor %%xmm13, %%xmm15, %%xmm15; vpxor %%xmm9, %%xmm14, %%xmm14; vpxor %%xmm15, %%xmm14, %%xmm11; vpand %7, %%xmm11, %%xmm11; vpxor %7, %1, %7; vpand %%xmm14, %7, %7; vpand %1, %%xmm15, %1; vpxor %1, %7, %7; vpxor %%xmm11, %1, %1;; vpxor %%xmm12, %7, %7; vpxor %%xmm12, %4, %4; vpxor %5, %1, %1; vpxor %5, %2, %2;;; vpxor %7, %0, %5; vpxor %1, %6, %%xmm9; vpxor %4, %5, %%xmm10; vpxor %6, %0, %%xmm12; vpxor %0, %%xmm9, %0; vpxor %%xmm8, %%xmm9, %1; vpxor %%xmm8, %2, %7; vpxor %2, %3, %6; vpxor %%xmm10, %7, %2; vpxor %3, %7, %4; vpxor %%xmm12, %4, %3;" \
                                                                        \
           :                                                            \
                                                                        \
           "+x" (v0), "+x" (v1), "+x" (v2), "+x" (v3), "+x" (v4), "+x" (v5), "+x" (v6), "+x" (v7) : \
           "m" (Lshiftrow_shuf) :                                       \
           "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15");


 
#if 1
static inline void AES__(/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {


  /* for (int i = 0; i < 8; i++) print128hex(plain__[i]); puts(""); */
  // Instructions (body)
  plain__[0] = XOR(plain__[0],key__[0][0]);
  plain__[1] = XOR(plain__[1],key__[0][1]);
  plain__[2] = XOR(plain__[2],key__[0][2]);
  plain__[3] = XOR(plain__[3],key__[0][3]);
  plain__[4] = XOR(plain__[4],key__[0][4]);
  plain__[5] = XOR(plain__[5],key__[0][5]);
  plain__[6] = XOR(plain__[6],key__[0][6]);
  plain__[7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
#ifdef _MCA
    __asm __volatile__("# LLVM-MCA-BEGIN aes-usuba");
#endif
#ifdef _IACA
    IACA_START
#endif
#ifdef REV_SLICE
    shiftrows_subbytes_mixcolumn(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
#else
    shiftrows_subbytes_mixcolumn(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
#endif
    /* for (int i = 0; i < 8; i++) print128hex(plain__[i]);puts(""); */
    plain__[0] = XOR(plain__[0],key__[i][0]);
    plain__[1] = XOR(plain__[1],key__[i][1]);
    plain__[2] = XOR(plain__[2],key__[i][2]);
    plain__[3] = XOR(plain__[3],key__[i][3]);
    plain__[4] = XOR(plain__[4],key__[i][4]);
    plain__[5] = XOR(plain__[5],key__[i][5]);
    plain__[6] = XOR(plain__[6],key__[i][6]);
    plain__[7] = XOR(plain__[7],key__[i][7]);
    /* puts(""); */
    /*   for (int i = 0; i < 8; i++) print128hex(plain__[i]); */
    /*   exit(1); */
  }
#ifdef _MCA
    __asm volatile("# LLVM-MCA-END");
#endif
#ifdef _IACA
    IACA_END
#endif
#ifdef REV_SLICE
    shiftrows_subbytes(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
#else
    shiftrows_subbytes(plain__[0],plain__[1],plain__[2],plain__[3],plain__[4],plain__[5],plain__[6],plain__[7]);
#endif
  cipher__[0] = XOR(plain__[0],key__[10][0]);
  cipher__[1] = XOR(plain__[1],key__[10][1]);
  cipher__[2] = XOR(plain__[2],key__[10][2]);
  cipher__[3] = XOR(plain__[3],key__[10][3]);
  cipher__[4] = XOR(plain__[4],key__[10][4]);
  cipher__[5] = XOR(plain__[5],key__[10][5]);
  cipher__[6] = XOR(plain__[6],key__[10][6]);
  cipher__[7] = XOR(plain__[7],key__[10][7]);
  /* for (int i = 0; i < 8; i++) print128hex(cipher__[i]);puts(""); exit(1); */
}
#else

void AES__(DATATYPE key__[11][8],DATATYPE plain__0,DATATYPE plain__1,DATATYPE plain__2,DATATYPE plain__3,DATATYPE plain__4,DATATYPE plain__5,DATATYPE plain__6,DATATYPE plain__7, /*outputs*/ DATATYPE cipher__[8]) {
      
  // Instructions (body)
  plain__0 = XOR(plain__0,key__[0][0]);
  plain__1 = XOR(plain__1,key__[0][1]);
  plain__2 = XOR(plain__2,key__[0][2]);
  plain__3 = XOR(plain__3,key__[0][3]);
  plain__4 = XOR(plain__4,key__[0][4]);
  plain__5 = XOR(plain__5,key__[0][5]);
  plain__6 = XOR(plain__6,key__[0][6]);
  plain__7 = XOR(plain__7,key__[0][7]);
  for (int i = 1; i <= 9; i++) {
    shiftrows_subbytes_mixcolumn(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
    plain__0 = XOR(plain__0,key__[i][0]);
    plain__1 = XOR(plain__1,key__[i][1]);
    plain__2 = XOR(plain__2,key__[i][2]);
    plain__3 = XOR(plain__3,key__[i][3]);
    plain__4 = XOR(plain__4,key__[i][4]);
    plain__5 = XOR(plain__5,key__[i][5]);
    plain__6 = XOR(plain__6,key__[i][6]);
    plain__7 = XOR(plain__7,key__[i][7]);
    
  }
   shiftrows_subbytes(plain__7,plain__6,plain__5,plain__4,plain__3,plain__2,plain__1,plain__0);
  cipher__[0] = XOR(plain__0,key__[10][0]);
  cipher__[1] = XOR(plain__1,key__[10][1]);
  cipher__[2] = XOR(plain__2,key__[10][2]);
  cipher__[3] = XOR(plain__3,key__[10][3]);
  cipher__[4] = XOR(plain__4,key__[10][4]);
  cipher__[5] = XOR(plain__5,key__[10][5]);
  cipher__[6] = XOR(plain__6,key__[10][6]);
  cipher__[7] = XOR(plain__7,key__[10][7]);
}

#endif

#elif defined(UA_INLINE)

#ifdef SBOX
#warning UA_INLINE: Ignore SBOX value.
#undef SBOX
#endif
#define SBOX 2

/* main function */
static inline void AES__ (/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
  
  // Variables declaration
  DATATYPE MixColumn___1__tmp11_;
  DATATYPE MixColumn___1__tmp17_;
  DATATYPE MixColumn___1__tmp21_;
  DATATYPE MixColumn___1__tmp24_;
  DATATYPE MixColumn___1__tmp28_;
  DATATYPE MixColumn___1__tmp34_;
  DATATYPE MixColumn___1__tmp38_;
  DATATYPE MixColumn___1__tmp44_;
  DATATYPE MixColumn___1__tmp48_;
  DATATYPE MixColumn___1__tmp51_;
  DATATYPE MixColumn___1__tmp55_;
  DATATYPE MixColumn___1__tmp58_;
  DATATYPE MixColumn___1__tmp5_;
  DATATYPE MixColumn___1__tmp62_;
  DATATYPE MixColumn___1__tmp69_;
  DATATYPE MixColumn___1__tmp7_;
  DATATYPE MixColumn___2__tmp11_;
  DATATYPE MixColumn___2__tmp17_;
  DATATYPE MixColumn___2__tmp21_;
  DATATYPE MixColumn___2__tmp24_;
  DATATYPE MixColumn___2__tmp28_;
  DATATYPE MixColumn___2__tmp34_;
  DATATYPE MixColumn___2__tmp38_;
  DATATYPE MixColumn___2__tmp44_;
  DATATYPE MixColumn___2__tmp48_;
  DATATYPE MixColumn___2__tmp51_;
  DATATYPE MixColumn___2__tmp55_;
  DATATYPE MixColumn___2__tmp58_;
  DATATYPE MixColumn___2__tmp5_;
  DATATYPE MixColumn___2__tmp62_;
  DATATYPE MixColumn___2__tmp69_;
  DATATYPE MixColumn___2__tmp7_;
  DATATYPE MixColumn___3__tmp11_;
  DATATYPE MixColumn___3__tmp17_;
  DATATYPE MixColumn___3__tmp21_;
  DATATYPE MixColumn___3__tmp24_;
  DATATYPE MixColumn___3__tmp28_;
  DATATYPE MixColumn___3__tmp34_;
  DATATYPE MixColumn___3__tmp38_;
  DATATYPE MixColumn___3__tmp44_;
  DATATYPE MixColumn___3__tmp48_;
  DATATYPE MixColumn___3__tmp51_;
  DATATYPE MixColumn___3__tmp55_;
  DATATYPE MixColumn___3__tmp58_;
  DATATYPE MixColumn___3__tmp5_;
  DATATYPE MixColumn___3__tmp62_;
  DATATYPE MixColumn___3__tmp69_;
  DATATYPE MixColumn___3__tmp7_;
  DATATYPE MixColumn___4__tmp11_;
  DATATYPE MixColumn___4__tmp17_;
  DATATYPE MixColumn___4__tmp21_;
  DATATYPE MixColumn___4__tmp24_;
  DATATYPE MixColumn___4__tmp28_;
  DATATYPE MixColumn___4__tmp34_;
  DATATYPE MixColumn___4__tmp38_;
  DATATYPE MixColumn___4__tmp44_;
  DATATYPE MixColumn___4__tmp48_;
  DATATYPE MixColumn___4__tmp51_;
  DATATYPE MixColumn___4__tmp55_;
  DATATYPE MixColumn___4__tmp58_;
  DATATYPE MixColumn___4__tmp5_;
  DATATYPE MixColumn___4__tmp62_;
  DATATYPE MixColumn___4__tmp69_;
  DATATYPE MixColumn___4__tmp7_;
  DATATYPE MixColumn___5__tmp11_;
  DATATYPE MixColumn___5__tmp17_;
  DATATYPE MixColumn___5__tmp21_;
  DATATYPE MixColumn___5__tmp24_;
  DATATYPE MixColumn___5__tmp28_;
  DATATYPE MixColumn___5__tmp34_;
  DATATYPE MixColumn___5__tmp38_;
  DATATYPE MixColumn___5__tmp44_;
  DATATYPE MixColumn___5__tmp48_;
  DATATYPE MixColumn___5__tmp51_;
  DATATYPE MixColumn___5__tmp55_;
  DATATYPE MixColumn___5__tmp58_;
  DATATYPE MixColumn___5__tmp5_;
  DATATYPE MixColumn___5__tmp62_;
  DATATYPE MixColumn___5__tmp69_;
  DATATYPE MixColumn___5__tmp7_;
  DATATYPE MixColumn___6__tmp11_;
  DATATYPE MixColumn___6__tmp17_;
  DATATYPE MixColumn___6__tmp21_;
  DATATYPE MixColumn___6__tmp24_;
  DATATYPE MixColumn___6__tmp28_;
  DATATYPE MixColumn___6__tmp34_;
  DATATYPE MixColumn___6__tmp38_;
  DATATYPE MixColumn___6__tmp44_;
  DATATYPE MixColumn___6__tmp48_;
  DATATYPE MixColumn___6__tmp51_;
  DATATYPE MixColumn___6__tmp55_;
  DATATYPE MixColumn___6__tmp58_;
  DATATYPE MixColumn___6__tmp5_;
  DATATYPE MixColumn___6__tmp62_;
  DATATYPE MixColumn___6__tmp69_;
  DATATYPE MixColumn___6__tmp7_;
  DATATYPE MixColumn___7__tmp11_;
  DATATYPE MixColumn___7__tmp17_;
  DATATYPE MixColumn___7__tmp21_;
  DATATYPE MixColumn___7__tmp24_;
  DATATYPE MixColumn___7__tmp28_;
  DATATYPE MixColumn___7__tmp34_;
  DATATYPE MixColumn___7__tmp38_;
  DATATYPE MixColumn___7__tmp44_;
  DATATYPE MixColumn___7__tmp48_;
  DATATYPE MixColumn___7__tmp51_;
  DATATYPE MixColumn___7__tmp55_;
  DATATYPE MixColumn___7__tmp58_;
  DATATYPE MixColumn___7__tmp5_;
  DATATYPE MixColumn___7__tmp62_;
  DATATYPE MixColumn___7__tmp69_;
  DATATYPE MixColumn___7__tmp7_;
  DATATYPE MixColumn___8__tmp11_;
  DATATYPE MixColumn___8__tmp17_;
  DATATYPE MixColumn___8__tmp21_;
  DATATYPE MixColumn___8__tmp24_;
  DATATYPE MixColumn___8__tmp28_;
  DATATYPE MixColumn___8__tmp34_;
  DATATYPE MixColumn___8__tmp38_;
  DATATYPE MixColumn___8__tmp44_;
  DATATYPE MixColumn___8__tmp48_;
  DATATYPE MixColumn___8__tmp51_;
  DATATYPE MixColumn___8__tmp55_;
  DATATYPE MixColumn___8__tmp58_;
  DATATYPE MixColumn___8__tmp5_;
  DATATYPE MixColumn___8__tmp62_;
  DATATYPE MixColumn___8__tmp69_;
  DATATYPE MixColumn___8__tmp7_;
  DATATYPE MixColumn___9__tmp11_;
  DATATYPE MixColumn___9__tmp17_;
  DATATYPE MixColumn___9__tmp21_;
  DATATYPE MixColumn___9__tmp24_;
  DATATYPE MixColumn___9__tmp28_;
  DATATYPE MixColumn___9__tmp34_;
  DATATYPE MixColumn___9__tmp38_;
  DATATYPE MixColumn___9__tmp44_;
  DATATYPE MixColumn___9__tmp48_;
  DATATYPE MixColumn___9__tmp51_;
  DATATYPE MixColumn___9__tmp55_;
  DATATYPE MixColumn___9__tmp58_;
  DATATYPE MixColumn___9__tmp5_;
  DATATYPE MixColumn___9__tmp62_;
  DATATYPE MixColumn___9__tmp69_;
  DATATYPE MixColumn___9__tmp7_;
  DATATYPE SubBytes___10__tmp3_;
  DATATYPE SubBytes___10_t0;
  DATATYPE SubBytes___10_t1;
  DATATYPE SubBytes___10_t10;
  DATATYPE SubBytes___10_t12;
  DATATYPE SubBytes___10_t13;
  DATATYPE SubBytes___10_t15;
  DATATYPE SubBytes___10_t2;
  DATATYPE SubBytes___10_t25;
  DATATYPE SubBytes___10_t27;
  DATATYPE SubBytes___10_t28;
  DATATYPE SubBytes___10_t3;
  DATATYPE SubBytes___10_t30;
  DATATYPE SubBytes___10_t35;
  DATATYPE SubBytes___10_t42;
  DATATYPE SubBytes___10_t5;
  DATATYPE SubBytes___10_t7;
  DATATYPE SubBytes___10_t8;
  DATATYPE SubBytes___10_tc7;
  DATATYPE SubBytes___10_y1;
  DATATYPE SubBytes___10_y10;
  DATATYPE SubBytes___10_y11;
  DATATYPE SubBytes___10_y12;
  DATATYPE SubBytes___10_y13;
  DATATYPE SubBytes___10_y14;
  DATATYPE SubBytes___10_y15;
  DATATYPE SubBytes___10_y17;
  DATATYPE SubBytes___10_y18;
  DATATYPE SubBytes___10_y19;
  DATATYPE SubBytes___10_y2;
  DATATYPE SubBytes___10_y21;
  DATATYPE SubBytes___10_y3;
  DATATYPE SubBytes___10_y4;
  DATATYPE SubBytes___10_y5;
  DATATYPE SubBytes___10_y6;
  DATATYPE SubBytes___10_y7;
  DATATYPE SubBytes___10_y8;
  DATATYPE SubBytes___10_y9;
  DATATYPE SubBytes___10_z2;
  DATATYPE SubBytes___1__tmp3_;
  DATATYPE SubBytes___1_t0;
  DATATYPE SubBytes___1_t1;
  DATATYPE SubBytes___1_t10;
  DATATYPE SubBytes___1_t12;
  DATATYPE SubBytes___1_t13;
  DATATYPE SubBytes___1_t15;
  DATATYPE SubBytes___1_t2;
  DATATYPE SubBytes___1_t25;
  DATATYPE SubBytes___1_t27;
  DATATYPE SubBytes___1_t28;
  DATATYPE SubBytes___1_t3;
  DATATYPE SubBytes___1_t30;
  DATATYPE SubBytes___1_t35;
  DATATYPE SubBytes___1_t42;
  DATATYPE SubBytes___1_t5;
  DATATYPE SubBytes___1_t7;
  DATATYPE SubBytes___1_t8;
  DATATYPE SubBytes___1_tc7;
  DATATYPE SubBytes___1_y1;
  DATATYPE SubBytes___1_y10;
  DATATYPE SubBytes___1_y11;
  DATATYPE SubBytes___1_y12;
  DATATYPE SubBytes___1_y13;
  DATATYPE SubBytes___1_y14;
  DATATYPE SubBytes___1_y15;
  DATATYPE SubBytes___1_y17;
  DATATYPE SubBytes___1_y18;
  DATATYPE SubBytes___1_y19;
  DATATYPE SubBytes___1_y2;
  DATATYPE SubBytes___1_y21;
  DATATYPE SubBytes___1_y3;
  DATATYPE SubBytes___1_y4;
  DATATYPE SubBytes___1_y5;
  DATATYPE SubBytes___1_y6;
  DATATYPE SubBytes___1_y7;
  DATATYPE SubBytes___1_y8;
  DATATYPE SubBytes___1_y9;
  DATATYPE SubBytes___1_z2;
  DATATYPE SubBytes___2__tmp3_;
  DATATYPE SubBytes___2_t0;
  DATATYPE SubBytes___2_t1;
  DATATYPE SubBytes___2_t10;
  DATATYPE SubBytes___2_t12;
  DATATYPE SubBytes___2_t13;
  DATATYPE SubBytes___2_t15;
  DATATYPE SubBytes___2_t2;
  DATATYPE SubBytes___2_t25;
  DATATYPE SubBytes___2_t27;
  DATATYPE SubBytes___2_t28;
  DATATYPE SubBytes___2_t3;
  DATATYPE SubBytes___2_t30;
  DATATYPE SubBytes___2_t35;
  DATATYPE SubBytes___2_t42;
  DATATYPE SubBytes___2_t5;
  DATATYPE SubBytes___2_t7;
  DATATYPE SubBytes___2_t8;
  DATATYPE SubBytes___2_tc7;
  DATATYPE SubBytes___2_y1;
  DATATYPE SubBytes___2_y10;
  DATATYPE SubBytes___2_y11;
  DATATYPE SubBytes___2_y12;
  DATATYPE SubBytes___2_y13;
  DATATYPE SubBytes___2_y14;
  DATATYPE SubBytes___2_y15;
  DATATYPE SubBytes___2_y17;
  DATATYPE SubBytes___2_y18;
  DATATYPE SubBytes___2_y19;
  DATATYPE SubBytes___2_y2;
  DATATYPE SubBytes___2_y21;
  DATATYPE SubBytes___2_y3;
  DATATYPE SubBytes___2_y4;
  DATATYPE SubBytes___2_y5;
  DATATYPE SubBytes___2_y6;
  DATATYPE SubBytes___2_y7;
  DATATYPE SubBytes___2_y8;
  DATATYPE SubBytes___2_y9;
  DATATYPE SubBytes___2_z2;
  DATATYPE SubBytes___3__tmp3_;
  DATATYPE SubBytes___3_t0;
  DATATYPE SubBytes___3_t1;
  DATATYPE SubBytes___3_t10;
  DATATYPE SubBytes___3_t12;
  DATATYPE SubBytes___3_t13;
  DATATYPE SubBytes___3_t15;
  DATATYPE SubBytes___3_t2;
  DATATYPE SubBytes___3_t25;
  DATATYPE SubBytes___3_t27;
  DATATYPE SubBytes___3_t28;
  DATATYPE SubBytes___3_t3;
  DATATYPE SubBytes___3_t30;
  DATATYPE SubBytes___3_t35;
  DATATYPE SubBytes___3_t42;
  DATATYPE SubBytes___3_t5;
  DATATYPE SubBytes___3_t7;
  DATATYPE SubBytes___3_t8;
  DATATYPE SubBytes___3_tc7;
  DATATYPE SubBytes___3_y1;
  DATATYPE SubBytes___3_y10;
  DATATYPE SubBytes___3_y11;
  DATATYPE SubBytes___3_y12;
  DATATYPE SubBytes___3_y13;
  DATATYPE SubBytes___3_y14;
  DATATYPE SubBytes___3_y15;
  DATATYPE SubBytes___3_y17;
  DATATYPE SubBytes___3_y18;
  DATATYPE SubBytes___3_y19;
  DATATYPE SubBytes___3_y2;
  DATATYPE SubBytes___3_y21;
  DATATYPE SubBytes___3_y3;
  DATATYPE SubBytes___3_y4;
  DATATYPE SubBytes___3_y5;
  DATATYPE SubBytes___3_y6;
  DATATYPE SubBytes___3_y7;
  DATATYPE SubBytes___3_y8;
  DATATYPE SubBytes___3_y9;
  DATATYPE SubBytes___3_z2;
  DATATYPE SubBytes___4__tmp3_;
  DATATYPE SubBytes___4_t0;
  DATATYPE SubBytes___4_t1;
  DATATYPE SubBytes___4_t10;
  DATATYPE SubBytes___4_t12;
  DATATYPE SubBytes___4_t13;
  DATATYPE SubBytes___4_t15;
  DATATYPE SubBytes___4_t2;
  DATATYPE SubBytes___4_t25;
  DATATYPE SubBytes___4_t27;
  DATATYPE SubBytes___4_t28;
  DATATYPE SubBytes___4_t3;
  DATATYPE SubBytes___4_t30;
  DATATYPE SubBytes___4_t35;
  DATATYPE SubBytes___4_t42;
  DATATYPE SubBytes___4_t5;
  DATATYPE SubBytes___4_t7;
  DATATYPE SubBytes___4_t8;
  DATATYPE SubBytes___4_tc7;
  DATATYPE SubBytes___4_y1;
  DATATYPE SubBytes___4_y10;
  DATATYPE SubBytes___4_y11;
  DATATYPE SubBytes___4_y12;
  DATATYPE SubBytes___4_y13;
  DATATYPE SubBytes___4_y14;
  DATATYPE SubBytes___4_y15;
  DATATYPE SubBytes___4_y17;
  DATATYPE SubBytes___4_y18;
  DATATYPE SubBytes___4_y19;
  DATATYPE SubBytes___4_y2;
  DATATYPE SubBytes___4_y21;
  DATATYPE SubBytes___4_y3;
  DATATYPE SubBytes___4_y4;
  DATATYPE SubBytes___4_y5;
  DATATYPE SubBytes___4_y6;
  DATATYPE SubBytes___4_y7;
  DATATYPE SubBytes___4_y8;
  DATATYPE SubBytes___4_y9;
  DATATYPE SubBytes___4_z2;
  DATATYPE SubBytes___5__tmp3_;
  DATATYPE SubBytes___5_t0;
  DATATYPE SubBytes___5_t1;
  DATATYPE SubBytes___5_t10;
  DATATYPE SubBytes___5_t12;
  DATATYPE SubBytes___5_t13;
  DATATYPE SubBytes___5_t15;
  DATATYPE SubBytes___5_t2;
  DATATYPE SubBytes___5_t25;
  DATATYPE SubBytes___5_t27;
  DATATYPE SubBytes___5_t28;
  DATATYPE SubBytes___5_t3;
  DATATYPE SubBytes___5_t30;
  DATATYPE SubBytes___5_t35;
  DATATYPE SubBytes___5_t42;
  DATATYPE SubBytes___5_t5;
  DATATYPE SubBytes___5_t7;
  DATATYPE SubBytes___5_t8;
  DATATYPE SubBytes___5_tc7;
  DATATYPE SubBytes___5_y1;
  DATATYPE SubBytes___5_y10;
  DATATYPE SubBytes___5_y11;
  DATATYPE SubBytes___5_y12;
  DATATYPE SubBytes___5_y13;
  DATATYPE SubBytes___5_y14;
  DATATYPE SubBytes___5_y15;
  DATATYPE SubBytes___5_y17;
  DATATYPE SubBytes___5_y18;
  DATATYPE SubBytes___5_y19;
  DATATYPE SubBytes___5_y2;
  DATATYPE SubBytes___5_y21;
  DATATYPE SubBytes___5_y3;
  DATATYPE SubBytes___5_y4;
  DATATYPE SubBytes___5_y5;
  DATATYPE SubBytes___5_y6;
  DATATYPE SubBytes___5_y7;
  DATATYPE SubBytes___5_y8;
  DATATYPE SubBytes___5_y9;
  DATATYPE SubBytes___5_z2;
  DATATYPE SubBytes___6__tmp3_;
  DATATYPE SubBytes___6_t0;
  DATATYPE SubBytes___6_t1;
  DATATYPE SubBytes___6_t10;
  DATATYPE SubBytes___6_t12;
  DATATYPE SubBytes___6_t13;
  DATATYPE SubBytes___6_t15;
  DATATYPE SubBytes___6_t2;
  DATATYPE SubBytes___6_t25;
  DATATYPE SubBytes___6_t27;
  DATATYPE SubBytes___6_t28;
  DATATYPE SubBytes___6_t3;
  DATATYPE SubBytes___6_t30;
  DATATYPE SubBytes___6_t35;
  DATATYPE SubBytes___6_t42;
  DATATYPE SubBytes___6_t5;
  DATATYPE SubBytes___6_t7;
  DATATYPE SubBytes___6_t8;
  DATATYPE SubBytes___6_tc7;
  DATATYPE SubBytes___6_y1;
  DATATYPE SubBytes___6_y10;
  DATATYPE SubBytes___6_y11;
  DATATYPE SubBytes___6_y12;
  DATATYPE SubBytes___6_y13;
  DATATYPE SubBytes___6_y14;
  DATATYPE SubBytes___6_y15;
  DATATYPE SubBytes___6_y17;
  DATATYPE SubBytes___6_y18;
  DATATYPE SubBytes___6_y19;
  DATATYPE SubBytes___6_y2;
  DATATYPE SubBytes___6_y21;
  DATATYPE SubBytes___6_y3;
  DATATYPE SubBytes___6_y4;
  DATATYPE SubBytes___6_y5;
  DATATYPE SubBytes___6_y6;
  DATATYPE SubBytes___6_y7;
  DATATYPE SubBytes___6_y8;
  DATATYPE SubBytes___6_y9;
  DATATYPE SubBytes___6_z2;
  DATATYPE SubBytes___7__tmp3_;
  DATATYPE SubBytes___7_t0;
  DATATYPE SubBytes___7_t1;
  DATATYPE SubBytes___7_t10;
  DATATYPE SubBytes___7_t12;
  DATATYPE SubBytes___7_t13;
  DATATYPE SubBytes___7_t15;
  DATATYPE SubBytes___7_t2;
  DATATYPE SubBytes___7_t25;
  DATATYPE SubBytes___7_t27;
  DATATYPE SubBytes___7_t28;
  DATATYPE SubBytes___7_t3;
  DATATYPE SubBytes___7_t30;
  DATATYPE SubBytes___7_t35;
  DATATYPE SubBytes___7_t42;
  DATATYPE SubBytes___7_t5;
  DATATYPE SubBytes___7_t7;
  DATATYPE SubBytes___7_t8;
  DATATYPE SubBytes___7_tc7;
  DATATYPE SubBytes___7_y1;
  DATATYPE SubBytes___7_y10;
  DATATYPE SubBytes___7_y11;
  DATATYPE SubBytes___7_y12;
  DATATYPE SubBytes___7_y13;
  DATATYPE SubBytes___7_y14;
  DATATYPE SubBytes___7_y15;
  DATATYPE SubBytes___7_y17;
  DATATYPE SubBytes___7_y18;
  DATATYPE SubBytes___7_y19;
  DATATYPE SubBytes___7_y2;
  DATATYPE SubBytes___7_y21;
  DATATYPE SubBytes___7_y3;
  DATATYPE SubBytes___7_y4;
  DATATYPE SubBytes___7_y5;
  DATATYPE SubBytes___7_y6;
  DATATYPE SubBytes___7_y7;
  DATATYPE SubBytes___7_y8;
  DATATYPE SubBytes___7_y9;
  DATATYPE SubBytes___7_z2;
  DATATYPE SubBytes___8__tmp3_;
  DATATYPE SubBytes___8_t0;
  DATATYPE SubBytes___8_t1;
  DATATYPE SubBytes___8_t10;
  DATATYPE SubBytes___8_t12;
  DATATYPE SubBytes___8_t13;
  DATATYPE SubBytes___8_t15;
  DATATYPE SubBytes___8_t2;
  DATATYPE SubBytes___8_t25;
  DATATYPE SubBytes___8_t27;
  DATATYPE SubBytes___8_t28;
  DATATYPE SubBytes___8_t3;
  DATATYPE SubBytes___8_t30;
  DATATYPE SubBytes___8_t35;
  DATATYPE SubBytes___8_t42;
  DATATYPE SubBytes___8_t5;
  DATATYPE SubBytes___8_t7;
  DATATYPE SubBytes___8_t8;
  DATATYPE SubBytes___8_tc7;
  DATATYPE SubBytes___8_y1;
  DATATYPE SubBytes___8_y10;
  DATATYPE SubBytes___8_y11;
  DATATYPE SubBytes___8_y12;
  DATATYPE SubBytes___8_y13;
  DATATYPE SubBytes___8_y14;
  DATATYPE SubBytes___8_y15;
  DATATYPE SubBytes___8_y17;
  DATATYPE SubBytes___8_y18;
  DATATYPE SubBytes___8_y19;
  DATATYPE SubBytes___8_y2;
  DATATYPE SubBytes___8_y21;
  DATATYPE SubBytes___8_y3;
  DATATYPE SubBytes___8_y4;
  DATATYPE SubBytes___8_y5;
  DATATYPE SubBytes___8_y6;
  DATATYPE SubBytes___8_y7;
  DATATYPE SubBytes___8_y8;
  DATATYPE SubBytes___8_y9;
  DATATYPE SubBytes___8_z2;
  DATATYPE SubBytes___9__tmp3_;
  DATATYPE SubBytes___9_t0;
  DATATYPE SubBytes___9_t1;
  DATATYPE SubBytes___9_t10;
  DATATYPE SubBytes___9_t12;
  DATATYPE SubBytes___9_t13;
  DATATYPE SubBytes___9_t15;
  DATATYPE SubBytes___9_t2;
  DATATYPE SubBytes___9_t25;
  DATATYPE SubBytes___9_t27;
  DATATYPE SubBytes___9_t28;
  DATATYPE SubBytes___9_t3;
  DATATYPE SubBytes___9_t30;
  DATATYPE SubBytes___9_t35;
  DATATYPE SubBytes___9_t42;
  DATATYPE SubBytes___9_t5;
  DATATYPE SubBytes___9_t7;
  DATATYPE SubBytes___9_t8;
  DATATYPE SubBytes___9_tc7;
  DATATYPE SubBytes___9_y1;
  DATATYPE SubBytes___9_y10;
  DATATYPE SubBytes___9_y11;
  DATATYPE SubBytes___9_y12;
  DATATYPE SubBytes___9_y13;
  DATATYPE SubBytes___9_y14;
  DATATYPE SubBytes___9_y15;
  DATATYPE SubBytes___9_y17;
  DATATYPE SubBytes___9_y18;
  DATATYPE SubBytes___9_y19;
  DATATYPE SubBytes___9_y2;
  DATATYPE SubBytes___9_y21;
  DATATYPE SubBytes___9_y3;
  DATATYPE SubBytes___9_y4;
  DATATYPE SubBytes___9_y5;
  DATATYPE SubBytes___9_y6;
  DATATYPE SubBytes___9_y7;
  DATATYPE SubBytes___9_y8;
  DATATYPE SubBytes___9_y9;
  DATATYPE SubBytes___9_z2;
  DATATYPE _tmp70_0__;
  DATATYPE _tmp70_2__;
  DATATYPE _tmp70_3__;
  DATATYPE _tmp70_4__;
  DATATYPE _tmp70_5__;
  DATATYPE _tmp70_6__;
  DATATYPE _tmp70_7__;
  DATATYPE _tmp71_0__;
  DATATYPE _tmp71_1__;
  DATATYPE _tmp71_2__;
  DATATYPE _tmp71_3__;
  DATATYPE _tmp71_4__;
  DATATYPE _tmp71_5__;
  DATATYPE _tmp71_6__;
  DATATYPE _tmp71_7__;
  DATATYPE _tmp73_0__;
  DATATYPE _tmp73_2__;
  DATATYPE _tmp73_3__;
  DATATYPE _tmp73_4__;
  DATATYPE _tmp73_5__;
  DATATYPE _tmp73_6__;
  DATATYPE _tmp73_7__;
  DATATYPE _tmp74_0__;
  DATATYPE _tmp74_1__;
  DATATYPE _tmp74_2__;
  DATATYPE _tmp74_3__;
  DATATYPE _tmp74_4__;
  DATATYPE _tmp74_5__;
  DATATYPE _tmp74_6__;
  DATATYPE _tmp74_7__;
  DATATYPE _tmp76_0__;
  DATATYPE _tmp76_2__;
  DATATYPE _tmp76_3__;
  DATATYPE _tmp76_4__;
  DATATYPE _tmp76_5__;
  DATATYPE _tmp76_6__;
  DATATYPE _tmp76_7__;
  DATATYPE _tmp77_0__;
  DATATYPE _tmp77_1__;
  DATATYPE _tmp77_2__;
  DATATYPE _tmp77_3__;
  DATATYPE _tmp77_4__;
  DATATYPE _tmp77_5__;
  DATATYPE _tmp77_6__;
  DATATYPE _tmp77_7__;
  DATATYPE _tmp79_0__;
  DATATYPE _tmp79_2__;
  DATATYPE _tmp79_3__;
  DATATYPE _tmp79_4__;
  DATATYPE _tmp79_5__;
  DATATYPE _tmp79_6__;
  DATATYPE _tmp79_7__;
  DATATYPE _tmp80_0__;
  DATATYPE _tmp80_1__;
  DATATYPE _tmp80_2__;
  DATATYPE _tmp80_3__;
  DATATYPE _tmp80_4__;
  DATATYPE _tmp80_5__;
  DATATYPE _tmp80_6__;
  DATATYPE _tmp80_7__;
  DATATYPE _tmp82_0__;
  DATATYPE _tmp82_2__;
  DATATYPE _tmp82_3__;
  DATATYPE _tmp82_4__;
  DATATYPE _tmp82_5__;
  DATATYPE _tmp82_6__;
  DATATYPE _tmp82_7__;
  DATATYPE _tmp83_0__;
  DATATYPE _tmp83_1__;
  DATATYPE _tmp83_2__;
  DATATYPE _tmp83_3__;
  DATATYPE _tmp83_4__;
  DATATYPE _tmp83_5__;
  DATATYPE _tmp83_6__;
  DATATYPE _tmp83_7__;
  DATATYPE _tmp85_0__;
  DATATYPE _tmp85_2__;
  DATATYPE _tmp85_3__;
  DATATYPE _tmp85_4__;
  DATATYPE _tmp85_5__;
  DATATYPE _tmp85_6__;
  DATATYPE _tmp85_7__;
  DATATYPE _tmp86_0__;
  DATATYPE _tmp86_1__;
  DATATYPE _tmp86_2__;
  DATATYPE _tmp86_3__;
  DATATYPE _tmp86_4__;
  DATATYPE _tmp86_5__;
  DATATYPE _tmp86_6__;
  DATATYPE _tmp86_7__;
  DATATYPE _tmp88_0__;
  DATATYPE _tmp88_2__;
  DATATYPE _tmp88_3__;
  DATATYPE _tmp88_4__;
  DATATYPE _tmp88_5__;
  DATATYPE _tmp88_6__;
  DATATYPE _tmp88_7__;
  DATATYPE _tmp89_0__;
  DATATYPE _tmp89_1__;
  DATATYPE _tmp89_2__;
  DATATYPE _tmp89_3__;
  DATATYPE _tmp89_4__;
  DATATYPE _tmp89_5__;
  DATATYPE _tmp89_6__;
  DATATYPE _tmp89_7__;
  DATATYPE _tmp91_0__;
  DATATYPE _tmp91_2__;
  DATATYPE _tmp91_3__;
  DATATYPE _tmp91_4__;
  DATATYPE _tmp91_5__;
  DATATYPE _tmp91_6__;
  DATATYPE _tmp91_7__;
  DATATYPE _tmp92_0__;
  DATATYPE _tmp92_1__;
  DATATYPE _tmp92_2__;
  DATATYPE _tmp92_3__;
  DATATYPE _tmp92_4__;
  DATATYPE _tmp92_5__;
  DATATYPE _tmp92_6__;
  DATATYPE _tmp92_7__;
  DATATYPE _tmp94_0__;
  DATATYPE _tmp94_2__;
  DATATYPE _tmp94_3__;
  DATATYPE _tmp94_4__;
  DATATYPE _tmp94_5__;
  DATATYPE _tmp94_6__;
  DATATYPE _tmp94_7__;
  DATATYPE _tmp95_0__;
  DATATYPE _tmp95_1__;
  DATATYPE _tmp95_2__;
  DATATYPE _tmp95_3__;
  DATATYPE _tmp95_4__;
  DATATYPE _tmp95_5__;
  DATATYPE _tmp95_6__;
  DATATYPE _tmp95_7__;
  DATATYPE _tmp97_0__;
  DATATYPE _tmp97_2__;
  DATATYPE _tmp97_3__;
  DATATYPE _tmp97_4__;
  DATATYPE _tmp97_5__;
  DATATYPE _tmp97_6__;
  DATATYPE _tmp97_7__;
  DATATYPE _tmp98_0__;
  DATATYPE _tmp98_1__;
  DATATYPE _tmp98_2__;
  DATATYPE _tmp98_3__;
  DATATYPE _tmp98_4__;
  DATATYPE _tmp98_5__;
  DATATYPE _tmp98_6__;
  DATATYPE _tmp98_7__;
  DATATYPE tmp__0__0__;
  DATATYPE tmp__0__1__;
  DATATYPE tmp__0__2__;
  DATATYPE tmp__0__3__;
  DATATYPE tmp__0__4__;
  DATATYPE tmp__0__5__;
  DATATYPE tmp__0__6__;
  DATATYPE tmp__0__7__;


  // Instructions (body)
  tmp__0__0__ = XOR(plain__[0],key__[0][0]);
  tmp__0__1__ = XOR(plain__[1],key__[0][1]);
  tmp__0__2__ = XOR(plain__[2],key__[0][2]);
  tmp__0__3__ = XOR(plain__[3],key__[0][3]);
  tmp__0__4__ = XOR(plain__[4],key__[0][4]);
  tmp__0__5__ = XOR(plain__[5],key__[0][5]);
  tmp__0__6__ = XOR(plain__[6],key__[0][6]);
  tmp__0__7__ = XOR(plain__[7],key__[0][7]);
  SubBytes___1_t0 = XOR(tmp__0__1__,tmp__0__2__);
  SubBytes___1_y9 = XOR(tmp__0__0__,tmp__0__3__);
  SubBytes___1_y14 = XOR(tmp__0__3__,tmp__0__5__);
  SubBytes___1_y8 = XOR(tmp__0__0__,tmp__0__5__);
  SubBytes___1_y13 = XOR(tmp__0__0__,tmp__0__6__);
  SubBytes___1_y1 = XOR(SubBytes___1_t0,tmp__0__7__);
  SubBytes___1_y12 = XOR(SubBytes___1_y13,SubBytes___1_y14);
  SubBytes___1_y4 = XOR(SubBytes___1_y1,tmp__0__3__);
  SubBytes___1_y2 = XOR(SubBytes___1_y1,tmp__0__0__);
  SubBytes___1_y5 = XOR(SubBytes___1_y1,tmp__0__6__);
  SubBytes___1_t1 = XOR(tmp__0__4__,SubBytes___1_y12);
  SubBytes___1_t5 = AND(SubBytes___1_y4,tmp__0__7__);
  SubBytes___1_y3 = XOR(SubBytes___1_y5,SubBytes___1_y8);
  SubBytes___1_t8 = AND(SubBytes___1_y5,SubBytes___1_y1);
  SubBytes___1_y15 = XOR(SubBytes___1_t1,tmp__0__5__);
  SubBytes___1_t1 = XOR(SubBytes___1_t1,tmp__0__1__);
  SubBytes___1_y6 = XOR(SubBytes___1_y15,tmp__0__7__);
  SubBytes___1_y10 = XOR(SubBytes___1_y15,SubBytes___1_t0);
  SubBytes___1_t2 = AND(SubBytes___1_y12,SubBytes___1_y15);
  SubBytes___1_y11 = XOR(SubBytes___1_t1,SubBytes___1_y9);
  SubBytes___1_t3 = AND(SubBytes___1_y3,SubBytes___1_y6);
  SubBytes___1_y19 = XOR(SubBytes___1_y10,SubBytes___1_y8);
  SubBytes___1_t15 = AND(SubBytes___1_y8,SubBytes___1_y10);
  SubBytes___1_t5 = XOR(SubBytes___1_t5,SubBytes___1_t2);
  SubBytes___1_y7 = XOR(tmp__0__7__,SubBytes___1_y11);
  SubBytes___1_y17 = XOR(SubBytes___1_y10,SubBytes___1_y11);
  SubBytes___1_t0 = XOR(SubBytes___1_t0,SubBytes___1_y11);
  SubBytes___1_t12 = AND(SubBytes___1_y9,SubBytes___1_y11);
  SubBytes___1_t3 = XOR(SubBytes___1_t3,SubBytes___1_t2);
  SubBytes___1_t10 = AND(SubBytes___1_y2,SubBytes___1_y7);
  SubBytes___1_t13 = AND(SubBytes___1_y14,SubBytes___1_y17);
  SubBytes___1_y21 = XOR(SubBytes___1_y13,SubBytes___1_t0);
  SubBytes___1_y18 = XOR(tmp__0__0__,SubBytes___1_t0);
  SubBytes___1_t7 = AND(SubBytes___1_y13,SubBytes___1_t0);
  SubBytes___1_t15 = XOR(SubBytes___1_t15,SubBytes___1_t12);
  SubBytes___1_t3 = XOR(SubBytes___1_t3,SubBytes___1_t1);
  SubBytes___1_t13 = XOR(SubBytes___1_t13,SubBytes___1_t12);
  SubBytes___1_t8 = XOR(SubBytes___1_t8,SubBytes___1_t7);
  SubBytes___1_t10 = XOR(SubBytes___1_t10,SubBytes___1_t7);
  SubBytes___1_t5 = XOR(SubBytes___1_t5,SubBytes___1_t15);
  SubBytes___1_t3 = XOR(SubBytes___1_t3,SubBytes___1_t13);
  SubBytes___1_t8 = XOR(SubBytes___1_t8,SubBytes___1_t13);
  SubBytes___1_t10 = XOR(SubBytes___1_t10,SubBytes___1_t15);
  SubBytes___1_t5 = XOR(SubBytes___1_t5,SubBytes___1_y19);
  SubBytes___1_t8 = XOR(SubBytes___1_t8,SubBytes___1_y21);
  SubBytes___1_t10 = XOR(SubBytes___1_t10,SubBytes___1_y18);
  SubBytes___1_t25 = XOR(SubBytes___1_t3,SubBytes___1_t5);
  SubBytes___1_t3 = AND(SubBytes___1_t3,SubBytes___1_t8);
  SubBytes___1_t30 = XOR(SubBytes___1_t8,SubBytes___1_t10);
  SubBytes___1_t27 = XOR(SubBytes___1_t10,SubBytes___1_t3);
  SubBytes___1_t3 = XOR(SubBytes___1_t5,SubBytes___1_t3);
  SubBytes___1_t28 = AND(SubBytes___1_t25,SubBytes___1_t27);
  SubBytes___1_t3 = AND(SubBytes___1_t3,SubBytes___1_t30);
  SubBytes___1_t28 = XOR(SubBytes___1_t28,SubBytes___1_t5);
  SubBytes___1_t3 = XOR(SubBytes___1_t3,SubBytes___1_t10);
  SubBytes___1_y7 = AND(SubBytes___1_t28,SubBytes___1_y7);
  SubBytes___1_y2 = AND(SubBytes___1_t28,SubBytes___1_y2);
  SubBytes___1_t8 = XOR(SubBytes___1_t8,SubBytes___1_t3);
  SubBytes___1_t35 = XOR(SubBytes___1_t27,SubBytes___1_t3);
  SubBytes___1_t42 = XOR(SubBytes___1_t28,SubBytes___1_t3);
  SubBytes___1_z2 = AND(SubBytes___1_t3,tmp__0__7__);
  SubBytes___1_y4 = AND(SubBytes___1_t3,SubBytes___1_y4);
  SubBytes___1_t10 = AND(SubBytes___1_t10,SubBytes___1_t35);
  SubBytes___1_y11 = AND(SubBytes___1_t42,SubBytes___1_y11);
  SubBytes___1_y9 = AND(SubBytes___1_t42,SubBytes___1_y9);
  SubBytes___1_t8 = XOR(SubBytes___1_t10,SubBytes___1_t8);
  SubBytes___1_t27 = XOR(SubBytes___1_t27,SubBytes___1_t10);
  SubBytes___1_t3 = XOR(SubBytes___1_t3,SubBytes___1_t8);
  SubBytes___1_y6 = AND(SubBytes___1_t8,SubBytes___1_y6);
  SubBytes___1_y3 = AND(SubBytes___1_t8,SubBytes___1_y3);
  SubBytes___1_t27 = AND(SubBytes___1_t28,SubBytes___1_t27);
  SubBytes___1_y15 = AND(SubBytes___1_t3,SubBytes___1_y15);
  SubBytes___1_t3 = AND(SubBytes___1_t3,SubBytes___1_y12);
  SubBytes___1_t25 = XOR(SubBytes___1_t25,SubBytes___1_t27);
  SubBytes___1_z2 = XOR(SubBytes___1_y15,SubBytes___1_z2);
  SubBytes___1_y6 = XOR(SubBytes___1_y6,SubBytes___1_y15);
  SubBytes___1_t8 = XOR(SubBytes___1_t25,SubBytes___1_t8);
  SubBytes___1_t28 = XOR(SubBytes___1_t28,SubBytes___1_t25);
  SubBytes___1_y1 = AND(SubBytes___1_t25,SubBytes___1_y1);
  SubBytes___1_t25 = AND(SubBytes___1_t25,SubBytes___1_y5);
  SubBytes___1_t42 = XOR(SubBytes___1_t42,SubBytes___1_t8);
  SubBytes___1_y10 = AND(SubBytes___1_t8,SubBytes___1_y10);
  SubBytes___1_t8 = AND(SubBytes___1_t8,SubBytes___1_y8);
  SubBytes___1_t0 = AND(SubBytes___1_t28,SubBytes___1_t0);
  SubBytes___1_t28 = AND(SubBytes___1_t28,SubBytes___1_y13);
  SubBytes___1_y17 = AND(SubBytes___1_t42,SubBytes___1_y17);
  SubBytes___1_t42 = AND(SubBytes___1_t42,SubBytes___1_y14);
  SubBytes___1_y1 = XOR(SubBytes___1_t0,SubBytes___1_y1);
  SubBytes___1_t0 = XOR(SubBytes___1_t0,SubBytes___1_y7);
  SubBytes___1_tc7 = XOR(SubBytes___1_t28,SubBytes___1_z2);
  SubBytes___1_t42 = XOR(SubBytes___1_y9,SubBytes___1_t42);
  SubBytes___1_y17 = XOR(SubBytes___1_y17,SubBytes___1_y1);
  SubBytes___1_y1 = XOR(SubBytes___1_y1,SubBytes___1_y6);
  SubBytes___1_z2 = XOR(SubBytes___1_z2,SubBytes___1_t0);
  SubBytes___1_y10 = XOR(SubBytes___1_y10,SubBytes___1_tc7);
  SubBytes___1_y3 = XOR(SubBytes___1_y3,SubBytes___1_t42);
  SubBytes___1_t25 = XOR(SubBytes___1_t25,SubBytes___1_t42);
  SubBytes___1_y11 = XOR(SubBytes___1_y11,SubBytes___1_y17);
  SubBytes___1_y17 = XOR(SubBytes___1_y17,SubBytes___1_y10);
  SubBytes___1_t3 = XOR(SubBytes___1_t3,SubBytes___1_y3);
  SubBytes___1_y3 = XOR(SubBytes___1_y3,SubBytes___1_y4);
  SubBytes___1_t25 = XOR(SubBytes___1_t25,SubBytes___1_z2);
  SubBytes___1_y9 = XOR(SubBytes___1_y9,SubBytes___1_y11);
  SubBytes___1_y2 = XOR(SubBytes___1_y2,SubBytes___1_y17);
  _tmp70_3__ = XOR(SubBytes___1_t3,SubBytes___1_y1);
  _tmp70_0__ = XOR(SubBytes___1_t3,SubBytes___1_y11);
  SubBytes___1_t28 = XOR(SubBytes___1_t28,SubBytes___1_t25);
  SubBytes___1_y17 = XOR(SubBytes___1_y17,SubBytes___1_t25);
  SubBytes___1_y9 = XOR(SubBytes___1_y2,SubBytes___1_y9);
  _tmp70_5__ = XOR(SubBytes___1_y3,SubBytes___1_y2);
  _tmp70_4__ = XOR(SubBytes___1_z2,_tmp70_3__);
  SubBytes___1__tmp3_ = XOR(_tmp70_3__,SubBytes___1_y11);
  _tmp71_3__ = PERMUT_16(_tmp70_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp71_0__ = PERMUT_16(_tmp70_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp70_7__ = NOT(SubBytes___1_t28);
  _tmp70_6__ = NOT(SubBytes___1_y17);
  SubBytes___1_y9 = XOR(SubBytes___1_y9,SubBytes___1_t8);
  _tmp71_5__ = PERMUT_16(_tmp70_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp71_4__ = PERMUT_16(_tmp70_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___1__tmp3_ = NOT(SubBytes___1__tmp3_);
  MixColumn___1__tmp44_ = PERMUT_16(_tmp71_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___1__tmp5_ = PERMUT_16(_tmp71_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp71_7__ = PERMUT_16(_tmp70_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp71_6__ = PERMUT_16(_tmp70_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp70_2__ = NOT(SubBytes___1_y9);
  MixColumn___1__tmp24_ = PERMUT_16(_tmp71_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___1__tmp34_ = PERMUT_16(_tmp71_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp71_1__ = PERMUT_16(SubBytes___1__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp71_3__ = XOR(_tmp71_3__,MixColumn___1__tmp44_);
  _tmp71_0__ = XOR(_tmp71_0__,MixColumn___1__tmp5_);
  MixColumn___1__tmp7_ = PERMUT_16(_tmp71_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___1__tmp17_ = PERMUT_16(_tmp71_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp71_2__ = PERMUT_16(_tmp70_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp71_5__ = XOR(_tmp71_5__,MixColumn___1__tmp24_);
  _tmp71_4__ = XOR(_tmp71_4__,MixColumn___1__tmp34_);
  MixColumn___1__tmp58_ = PERMUT_16(_tmp71_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___1__tmp48_ = PERMUT_16(_tmp71_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___1__tmp69_ = PERMUT_16(_tmp71_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_7__ = XOR(_tmp71_7__,MixColumn___1__tmp7_);
  MixColumn___1__tmp7_ = XOR(_tmp71_0__,MixColumn___1__tmp7_);
  _tmp71_6__ = XOR(_tmp71_6__,MixColumn___1__tmp17_);
  MixColumn___1__tmp51_ = PERMUT_16(_tmp71_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___1__tmp28_ = PERMUT_16(_tmp71_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_5__ = XOR(_tmp71_5__,_tmp71_0__);
  MixColumn___1__tmp38_ = PERMUT_16(_tmp71_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_4__ = XOR(_tmp71_4__,_tmp71_0__);
  _tmp71_1__ = XOR(_tmp71_1__,MixColumn___1__tmp58_);
  MixColumn___1__tmp11_ = PERMUT_16(_tmp71_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_7__ = XOR(_tmp71_7__,_tmp71_0__);
  MixColumn___1__tmp21_ = PERMUT_16(_tmp71_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_6__ = XOR(_tmp71_6__,MixColumn___1__tmp24_);
  _tmp71_2__ = XOR(_tmp71_2__,MixColumn___1__tmp51_);
  _tmp71_3__ = XOR(_tmp71_3__,MixColumn___1__tmp51_);
  _tmp71_5__ = XOR(_tmp71_5__,MixColumn___1__tmp34_);
  _tmp71_4__ = XOR(_tmp71_4__,MixColumn___1__tmp44_);
  MixColumn___1__tmp62_ = PERMUT_16(_tmp71_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_1__ = XOR(_tmp71_1__,MixColumn___1__tmp5_);
  MixColumn___1__tmp7_ = XOR(MixColumn___1__tmp7_,MixColumn___1__tmp11_);
  _tmp71_7__ = XOR(_tmp71_7__,MixColumn___1__tmp17_);
  _tmp71_6__ = XOR(_tmp71_6__,MixColumn___1__tmp28_);
  MixColumn___1__tmp55_ = PERMUT_16(_tmp71_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_2__ = XOR(_tmp71_2__,MixColumn___1__tmp58_);
  _tmp71_5__ = XOR(_tmp71_5__,MixColumn___1__tmp38_);
  _tmp71_4__ = XOR(_tmp71_4__,MixColumn___1__tmp48_);
  _tmp71_1__ = XOR(_tmp71_1__,MixColumn___1__tmp69_);
  MixColumn___1__tmp7_ = XOR(MixColumn___1__tmp7_,key__[1][7]);
  _tmp71_7__ = XOR(_tmp71_7__,MixColumn___1__tmp21_);
  _tmp71_6__ = XOR(_tmp71_6__,key__[1][5]);
  _tmp71_3__ = XOR(_tmp71_3__,MixColumn___1__tmp55_);
  _tmp71_2__ = XOR(_tmp71_2__,MixColumn___1__tmp62_);
  _tmp71_5__ = XOR(_tmp71_5__,key__[1][4]);
  _tmp71_4__ = XOR(_tmp71_4__,key__[1][3]);
  _tmp71_1__ = XOR(_tmp71_1__,key__[1][0]);
  _tmp71_7__ = XOR(_tmp71_7__,key__[1][6]);
  _tmp71_3__ = XOR(_tmp71_3__,key__[1][2]);
  _tmp71_2__ = XOR(_tmp71_2__,key__[1][1]);
  SubBytes___2_y14 = XOR(_tmp71_4__,_tmp71_6__);
  SubBytes___2_y9 = XOR(_tmp71_1__,_tmp71_4__);
  SubBytes___2_y8 = XOR(_tmp71_1__,_tmp71_6__);
  SubBytes___2_y13 = XOR(_tmp71_1__,_tmp71_7__);
  SubBytes___2_t0 = XOR(_tmp71_2__,_tmp71_3__);
  SubBytes___2_y12 = XOR(SubBytes___2_y13,SubBytes___2_y14);
  SubBytes___2_y1 = XOR(SubBytes___2_t0,MixColumn___1__tmp7_);
  SubBytes___2_t1 = XOR(_tmp71_5__,SubBytes___2_y12);
  SubBytes___2_y4 = XOR(SubBytes___2_y1,_tmp71_4__);
  SubBytes___2_y2 = XOR(SubBytes___2_y1,_tmp71_1__);
  SubBytes___2_y5 = XOR(SubBytes___2_y1,_tmp71_7__);
  SubBytes___2_y15 = XOR(SubBytes___2_t1,_tmp71_6__);
  SubBytes___2_t1 = XOR(SubBytes___2_t1,_tmp71_2__);
  SubBytes___2_t5 = AND(SubBytes___2_y4,MixColumn___1__tmp7_);
  SubBytes___2_y3 = XOR(SubBytes___2_y5,SubBytes___2_y8);
  SubBytes___2_t8 = AND(SubBytes___2_y5,SubBytes___2_y1);
  SubBytes___2_y6 = XOR(SubBytes___2_y15,MixColumn___1__tmp7_);
  SubBytes___2_y10 = XOR(SubBytes___2_y15,SubBytes___2_t0);
  SubBytes___2_t2 = AND(SubBytes___2_y12,SubBytes___2_y15);
  SubBytes___2_y11 = XOR(SubBytes___2_t1,SubBytes___2_y9);
  SubBytes___2_t3 = AND(SubBytes___2_y3,SubBytes___2_y6);
  SubBytes___2_y19 = XOR(SubBytes___2_y10,SubBytes___2_y8);
  SubBytes___2_t15 = AND(SubBytes___2_y8,SubBytes___2_y10);
  SubBytes___2_t5 = XOR(SubBytes___2_t5,SubBytes___2_t2);
  SubBytes___2_y7 = XOR(MixColumn___1__tmp7_,SubBytes___2_y11);
  SubBytes___2_y17 = XOR(SubBytes___2_y10,SubBytes___2_y11);
  SubBytes___2_t0 = XOR(SubBytes___2_t0,SubBytes___2_y11);
  SubBytes___2_t12 = AND(SubBytes___2_y9,SubBytes___2_y11);
  SubBytes___2_t3 = XOR(SubBytes___2_t3,SubBytes___2_t2);
  SubBytes___2_t10 = AND(SubBytes___2_y2,SubBytes___2_y7);
  SubBytes___2_t13 = AND(SubBytes___2_y14,SubBytes___2_y17);
  SubBytes___2_y21 = XOR(SubBytes___2_y13,SubBytes___2_t0);
  SubBytes___2_y18 = XOR(_tmp71_1__,SubBytes___2_t0);
  SubBytes___2_t7 = AND(SubBytes___2_y13,SubBytes___2_t0);
  SubBytes___2_t15 = XOR(SubBytes___2_t15,SubBytes___2_t12);
  SubBytes___2_t3 = XOR(SubBytes___2_t3,SubBytes___2_t1);
  SubBytes___2_t13 = XOR(SubBytes___2_t13,SubBytes___2_t12);
  SubBytes___2_t8 = XOR(SubBytes___2_t8,SubBytes___2_t7);
  SubBytes___2_t10 = XOR(SubBytes___2_t10,SubBytes___2_t7);
  SubBytes___2_t5 = XOR(SubBytes___2_t5,SubBytes___2_t15);
  SubBytes___2_t3 = XOR(SubBytes___2_t3,SubBytes___2_t13);
  SubBytes___2_t8 = XOR(SubBytes___2_t8,SubBytes___2_t13);
  SubBytes___2_t10 = XOR(SubBytes___2_t10,SubBytes___2_t15);
  SubBytes___2_t5 = XOR(SubBytes___2_t5,SubBytes___2_y19);
  SubBytes___2_t8 = XOR(SubBytes___2_t8,SubBytes___2_y21);
  SubBytes___2_t10 = XOR(SubBytes___2_t10,SubBytes___2_y18);
  SubBytes___2_t25 = XOR(SubBytes___2_t3,SubBytes___2_t5);
  SubBytes___2_t3 = AND(SubBytes___2_t3,SubBytes___2_t8);
  SubBytes___2_t30 = XOR(SubBytes___2_t8,SubBytes___2_t10);
  SubBytes___2_t27 = XOR(SubBytes___2_t10,SubBytes___2_t3);
  SubBytes___2_t3 = XOR(SubBytes___2_t5,SubBytes___2_t3);
  SubBytes___2_t28 = AND(SubBytes___2_t25,SubBytes___2_t27);
  SubBytes___2_t3 = AND(SubBytes___2_t3,SubBytes___2_t30);
  SubBytes___2_t28 = XOR(SubBytes___2_t28,SubBytes___2_t5);
  SubBytes___2_t3 = XOR(SubBytes___2_t3,SubBytes___2_t10);
  SubBytes___2_y7 = AND(SubBytes___2_t28,SubBytes___2_y7);
  SubBytes___2_y2 = AND(SubBytes___2_t28,SubBytes___2_y2);
  SubBytes___2_t8 = XOR(SubBytes___2_t8,SubBytes___2_t3);
  SubBytes___2_t35 = XOR(SubBytes___2_t27,SubBytes___2_t3);
  SubBytes___2_t42 = XOR(SubBytes___2_t28,SubBytes___2_t3);
  SubBytes___2_z2 = AND(SubBytes___2_t3,MixColumn___1__tmp7_);
  SubBytes___2_y4 = AND(SubBytes___2_t3,SubBytes___2_y4);
  SubBytes___2_t10 = AND(SubBytes___2_t10,SubBytes___2_t35);
  SubBytes___2_y11 = AND(SubBytes___2_t42,SubBytes___2_y11);
  SubBytes___2_y9 = AND(SubBytes___2_t42,SubBytes___2_y9);
  SubBytes___2_t8 = XOR(SubBytes___2_t10,SubBytes___2_t8);
  SubBytes___2_t27 = XOR(SubBytes___2_t27,SubBytes___2_t10);
  SubBytes___2_t3 = XOR(SubBytes___2_t3,SubBytes___2_t8);
  SubBytes___2_y6 = AND(SubBytes___2_t8,SubBytes___2_y6);
  SubBytes___2_y3 = AND(SubBytes___2_t8,SubBytes___2_y3);
  SubBytes___2_t27 = AND(SubBytes___2_t28,SubBytes___2_t27);
  SubBytes___2_y15 = AND(SubBytes___2_t3,SubBytes___2_y15);
  SubBytes___2_t3 = AND(SubBytes___2_t3,SubBytes___2_y12);
  SubBytes___2_t25 = XOR(SubBytes___2_t25,SubBytes___2_t27);
  SubBytes___2_z2 = XOR(SubBytes___2_y15,SubBytes___2_z2);
  SubBytes___2_y6 = XOR(SubBytes___2_y6,SubBytes___2_y15);
  SubBytes___2_t8 = XOR(SubBytes___2_t25,SubBytes___2_t8);
  SubBytes___2_t28 = XOR(SubBytes___2_t28,SubBytes___2_t25);
  SubBytes___2_y1 = AND(SubBytes___2_t25,SubBytes___2_y1);
  SubBytes___2_t25 = AND(SubBytes___2_t25,SubBytes___2_y5);
  SubBytes___2_t42 = XOR(SubBytes___2_t42,SubBytes___2_t8);
  SubBytes___2_y10 = AND(SubBytes___2_t8,SubBytes___2_y10);
  SubBytes___2_t8 = AND(SubBytes___2_t8,SubBytes___2_y8);
  SubBytes___2_t0 = AND(SubBytes___2_t28,SubBytes___2_t0);
  SubBytes___2_t28 = AND(SubBytes___2_t28,SubBytes___2_y13);
  SubBytes___2_y17 = AND(SubBytes___2_t42,SubBytes___2_y17);
  SubBytes___2_t42 = AND(SubBytes___2_t42,SubBytes___2_y14);
  SubBytes___2_y1 = XOR(SubBytes___2_t0,SubBytes___2_y1);
  SubBytes___2_t0 = XOR(SubBytes___2_t0,SubBytes___2_y7);
  SubBytes___2_tc7 = XOR(SubBytes___2_t28,SubBytes___2_z2);
  SubBytes___2_t42 = XOR(SubBytes___2_y9,SubBytes___2_t42);
  SubBytes___2_y17 = XOR(SubBytes___2_y17,SubBytes___2_y1);
  SubBytes___2_y1 = XOR(SubBytes___2_y1,SubBytes___2_y6);
  SubBytes___2_z2 = XOR(SubBytes___2_z2,SubBytes___2_t0);
  SubBytes___2_y10 = XOR(SubBytes___2_y10,SubBytes___2_tc7);
  SubBytes___2_y3 = XOR(SubBytes___2_y3,SubBytes___2_t42);
  SubBytes___2_t25 = XOR(SubBytes___2_t25,SubBytes___2_t42);
  SubBytes___2_y11 = XOR(SubBytes___2_y11,SubBytes___2_y17);
  SubBytes___2_y17 = XOR(SubBytes___2_y17,SubBytes___2_y10);
  SubBytes___2_t3 = XOR(SubBytes___2_t3,SubBytes___2_y3);
  SubBytes___2_y3 = XOR(SubBytes___2_y3,SubBytes___2_y4);
  SubBytes___2_t25 = XOR(SubBytes___2_t25,SubBytes___2_z2);
  SubBytes___2_y9 = XOR(SubBytes___2_y9,SubBytes___2_y11);
  SubBytes___2_y2 = XOR(SubBytes___2_y2,SubBytes___2_y17);
  _tmp73_3__ = XOR(SubBytes___2_t3,SubBytes___2_y1);
  _tmp73_0__ = XOR(SubBytes___2_t3,SubBytes___2_y11);
  SubBytes___2_t28 = XOR(SubBytes___2_t28,SubBytes___2_t25);
  SubBytes___2_y17 = XOR(SubBytes___2_y17,SubBytes___2_t25);
  SubBytes___2_y9 = XOR(SubBytes___2_y2,SubBytes___2_y9);
  _tmp73_5__ = XOR(SubBytes___2_y3,SubBytes___2_y2);
  _tmp73_4__ = XOR(SubBytes___2_z2,_tmp73_3__);
  SubBytes___2__tmp3_ = XOR(_tmp73_3__,SubBytes___2_y11);
  _tmp74_3__ = PERMUT_16(_tmp73_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp74_0__ = PERMUT_16(_tmp73_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp73_7__ = NOT(SubBytes___2_t28);
  _tmp73_6__ = NOT(SubBytes___2_y17);
  SubBytes___2_y9 = XOR(SubBytes___2_y9,SubBytes___2_t8);
  _tmp74_5__ = PERMUT_16(_tmp73_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp74_4__ = PERMUT_16(_tmp73_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___2__tmp3_ = NOT(SubBytes___2__tmp3_);
  MixColumn___2__tmp44_ = PERMUT_16(_tmp74_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___2__tmp5_ = PERMUT_16(_tmp74_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp74_7__ = PERMUT_16(_tmp73_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp74_6__ = PERMUT_16(_tmp73_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp73_2__ = NOT(SubBytes___2_y9);
  MixColumn___2__tmp24_ = PERMUT_16(_tmp74_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___2__tmp34_ = PERMUT_16(_tmp74_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp74_1__ = PERMUT_16(SubBytes___2__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp74_3__ = XOR(_tmp74_3__,MixColumn___2__tmp44_);
  _tmp74_0__ = XOR(_tmp74_0__,MixColumn___2__tmp5_);
  MixColumn___2__tmp7_ = PERMUT_16(_tmp74_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___2__tmp17_ = PERMUT_16(_tmp74_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp74_2__ = PERMUT_16(_tmp73_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp74_5__ = XOR(_tmp74_5__,MixColumn___2__tmp24_);
  _tmp74_4__ = XOR(_tmp74_4__,MixColumn___2__tmp34_);
  MixColumn___2__tmp58_ = PERMUT_16(_tmp74_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___2__tmp48_ = PERMUT_16(_tmp74_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___2__tmp69_ = PERMUT_16(_tmp74_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_7__ = XOR(_tmp74_7__,MixColumn___2__tmp7_);
  MixColumn___2__tmp7_ = XOR(_tmp74_0__,MixColumn___2__tmp7_);
  _tmp74_6__ = XOR(_tmp74_6__,MixColumn___2__tmp17_);
  MixColumn___2__tmp51_ = PERMUT_16(_tmp74_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___2__tmp28_ = PERMUT_16(_tmp74_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_5__ = XOR(_tmp74_5__,_tmp74_0__);
  MixColumn___2__tmp38_ = PERMUT_16(_tmp74_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_4__ = XOR(_tmp74_4__,_tmp74_0__);
  _tmp74_1__ = XOR(_tmp74_1__,MixColumn___2__tmp58_);
  MixColumn___2__tmp11_ = PERMUT_16(_tmp74_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_7__ = XOR(_tmp74_7__,_tmp74_0__);
  MixColumn___2__tmp21_ = PERMUT_16(_tmp74_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_6__ = XOR(_tmp74_6__,MixColumn___2__tmp24_);
  _tmp74_2__ = XOR(_tmp74_2__,MixColumn___2__tmp51_);
  _tmp74_3__ = XOR(_tmp74_3__,MixColumn___2__tmp51_);
  _tmp74_5__ = XOR(_tmp74_5__,MixColumn___2__tmp34_);
  _tmp74_4__ = XOR(_tmp74_4__,MixColumn___2__tmp44_);
  MixColumn___2__tmp62_ = PERMUT_16(_tmp74_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_1__ = XOR(_tmp74_1__,MixColumn___2__tmp5_);
  MixColumn___2__tmp7_ = XOR(MixColumn___2__tmp7_,MixColumn___2__tmp11_);
  _tmp74_7__ = XOR(_tmp74_7__,MixColumn___2__tmp17_);
  _tmp74_6__ = XOR(_tmp74_6__,MixColumn___2__tmp28_);
  MixColumn___2__tmp55_ = PERMUT_16(_tmp74_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_2__ = XOR(_tmp74_2__,MixColumn___2__tmp58_);
  _tmp74_5__ = XOR(_tmp74_5__,MixColumn___2__tmp38_);
  _tmp74_4__ = XOR(_tmp74_4__,MixColumn___2__tmp48_);
  _tmp74_1__ = XOR(_tmp74_1__,MixColumn___2__tmp69_);
  MixColumn___2__tmp7_ = XOR(MixColumn___2__tmp7_,key__[2][7]);
  _tmp74_7__ = XOR(_tmp74_7__,MixColumn___2__tmp21_);
  _tmp74_6__ = XOR(_tmp74_6__,key__[2][5]);
  _tmp74_3__ = XOR(_tmp74_3__,MixColumn___2__tmp55_);
  _tmp74_2__ = XOR(_tmp74_2__,MixColumn___2__tmp62_);
  _tmp74_5__ = XOR(_tmp74_5__,key__[2][4]);
  _tmp74_4__ = XOR(_tmp74_4__,key__[2][3]);
  _tmp74_1__ = XOR(_tmp74_1__,key__[2][0]);
  _tmp74_7__ = XOR(_tmp74_7__,key__[2][6]);
  _tmp74_3__ = XOR(_tmp74_3__,key__[2][2]);
  _tmp74_2__ = XOR(_tmp74_2__,key__[2][1]);
  SubBytes___3_y14 = XOR(_tmp74_4__,_tmp74_6__);
  SubBytes___3_y9 = XOR(_tmp74_1__,_tmp74_4__);
  SubBytes___3_y8 = XOR(_tmp74_1__,_tmp74_6__);
  SubBytes___3_y13 = XOR(_tmp74_1__,_tmp74_7__);
  SubBytes___3_t0 = XOR(_tmp74_2__,_tmp74_3__);
  SubBytes___3_y12 = XOR(SubBytes___3_y13,SubBytes___3_y14);
  SubBytes___3_y1 = XOR(SubBytes___3_t0,MixColumn___2__tmp7_);
  SubBytes___3_t1 = XOR(_tmp74_5__,SubBytes___3_y12);
  SubBytes___3_y4 = XOR(SubBytes___3_y1,_tmp74_4__);
  SubBytes___3_y2 = XOR(SubBytes___3_y1,_tmp74_1__);
  SubBytes___3_y5 = XOR(SubBytes___3_y1,_tmp74_7__);
  SubBytes___3_y15 = XOR(SubBytes___3_t1,_tmp74_6__);
  SubBytes___3_t1 = XOR(SubBytes___3_t1,_tmp74_2__);
  SubBytes___3_t5 = AND(SubBytes___3_y4,MixColumn___2__tmp7_);
  SubBytes___3_y3 = XOR(SubBytes___3_y5,SubBytes___3_y8);
  SubBytes___3_t8 = AND(SubBytes___3_y5,SubBytes___3_y1);
  SubBytes___3_y6 = XOR(SubBytes___3_y15,MixColumn___2__tmp7_);
  SubBytes___3_y10 = XOR(SubBytes___3_y15,SubBytes___3_t0);
  SubBytes___3_t2 = AND(SubBytes___3_y12,SubBytes___3_y15);
  SubBytes___3_y11 = XOR(SubBytes___3_t1,SubBytes___3_y9);
  SubBytes___3_t3 = AND(SubBytes___3_y3,SubBytes___3_y6);
  SubBytes___3_y19 = XOR(SubBytes___3_y10,SubBytes___3_y8);
  SubBytes___3_t15 = AND(SubBytes___3_y8,SubBytes___3_y10);
  SubBytes___3_t5 = XOR(SubBytes___3_t5,SubBytes___3_t2);
  SubBytes___3_y7 = XOR(MixColumn___2__tmp7_,SubBytes___3_y11);
  SubBytes___3_y17 = XOR(SubBytes___3_y10,SubBytes___3_y11);
  SubBytes___3_t0 = XOR(SubBytes___3_t0,SubBytes___3_y11);
  SubBytes___3_t12 = AND(SubBytes___3_y9,SubBytes___3_y11);
  SubBytes___3_t3 = XOR(SubBytes___3_t3,SubBytes___3_t2);
  SubBytes___3_t10 = AND(SubBytes___3_y2,SubBytes___3_y7);
  SubBytes___3_t13 = AND(SubBytes___3_y14,SubBytes___3_y17);
  SubBytes___3_y21 = XOR(SubBytes___3_y13,SubBytes___3_t0);
  SubBytes___3_y18 = XOR(_tmp74_1__,SubBytes___3_t0);
  SubBytes___3_t7 = AND(SubBytes___3_y13,SubBytes___3_t0);
  SubBytes___3_t15 = XOR(SubBytes___3_t15,SubBytes___3_t12);
  SubBytes___3_t3 = XOR(SubBytes___3_t3,SubBytes___3_t1);
  SubBytes___3_t13 = XOR(SubBytes___3_t13,SubBytes___3_t12);
  SubBytes___3_t8 = XOR(SubBytes___3_t8,SubBytes___3_t7);
  SubBytes___3_t10 = XOR(SubBytes___3_t10,SubBytes___3_t7);
  SubBytes___3_t5 = XOR(SubBytes___3_t5,SubBytes___3_t15);
  SubBytes___3_t3 = XOR(SubBytes___3_t3,SubBytes___3_t13);
  SubBytes___3_t8 = XOR(SubBytes___3_t8,SubBytes___3_t13);
  SubBytes___3_t10 = XOR(SubBytes___3_t10,SubBytes___3_t15);
  SubBytes___3_t5 = XOR(SubBytes___3_t5,SubBytes___3_y19);
  SubBytes___3_t8 = XOR(SubBytes___3_t8,SubBytes___3_y21);
  SubBytes___3_t10 = XOR(SubBytes___3_t10,SubBytes___3_y18);
  SubBytes___3_t25 = XOR(SubBytes___3_t3,SubBytes___3_t5);
  SubBytes___3_t3 = AND(SubBytes___3_t3,SubBytes___3_t8);
  SubBytes___3_t30 = XOR(SubBytes___3_t8,SubBytes___3_t10);
  SubBytes___3_t27 = XOR(SubBytes___3_t10,SubBytes___3_t3);
  SubBytes___3_t3 = XOR(SubBytes___3_t5,SubBytes___3_t3);
  SubBytes___3_t28 = AND(SubBytes___3_t25,SubBytes___3_t27);
  SubBytes___3_t3 = AND(SubBytes___3_t3,SubBytes___3_t30);
  SubBytes___3_t28 = XOR(SubBytes___3_t28,SubBytes___3_t5);
  SubBytes___3_t3 = XOR(SubBytes___3_t3,SubBytes___3_t10);
  SubBytes___3_y7 = AND(SubBytes___3_t28,SubBytes___3_y7);
  SubBytes___3_y2 = AND(SubBytes___3_t28,SubBytes___3_y2);
  SubBytes___3_t8 = XOR(SubBytes___3_t8,SubBytes___3_t3);
  SubBytes___3_t35 = XOR(SubBytes___3_t27,SubBytes___3_t3);
  SubBytes___3_t42 = XOR(SubBytes___3_t28,SubBytes___3_t3);
  SubBytes___3_z2 = AND(SubBytes___3_t3,MixColumn___2__tmp7_);
  SubBytes___3_y4 = AND(SubBytes___3_t3,SubBytes___3_y4);
  SubBytes___3_t10 = AND(SubBytes___3_t10,SubBytes___3_t35);
  SubBytes___3_y11 = AND(SubBytes___3_t42,SubBytes___3_y11);
  SubBytes___3_y9 = AND(SubBytes___3_t42,SubBytes___3_y9);
  SubBytes___3_t8 = XOR(SubBytes___3_t10,SubBytes___3_t8);
  SubBytes___3_t27 = XOR(SubBytes___3_t27,SubBytes___3_t10);
  SubBytes___3_t3 = XOR(SubBytes___3_t3,SubBytes___3_t8);
  SubBytes___3_y6 = AND(SubBytes___3_t8,SubBytes___3_y6);
  SubBytes___3_y3 = AND(SubBytes___3_t8,SubBytes___3_y3);
  SubBytes___3_t27 = AND(SubBytes___3_t28,SubBytes___3_t27);
  SubBytes___3_y15 = AND(SubBytes___3_t3,SubBytes___3_y15);
  SubBytes___3_t3 = AND(SubBytes___3_t3,SubBytes___3_y12);
  SubBytes___3_t25 = XOR(SubBytes___3_t25,SubBytes___3_t27);
  SubBytes___3_z2 = XOR(SubBytes___3_y15,SubBytes___3_z2);
  SubBytes___3_y6 = XOR(SubBytes___3_y6,SubBytes___3_y15);
  SubBytes___3_t8 = XOR(SubBytes___3_t25,SubBytes___3_t8);
  SubBytes___3_t28 = XOR(SubBytes___3_t28,SubBytes___3_t25);
  SubBytes___3_y1 = AND(SubBytes___3_t25,SubBytes___3_y1);
  SubBytes___3_t25 = AND(SubBytes___3_t25,SubBytes___3_y5);
  SubBytes___3_t42 = XOR(SubBytes___3_t42,SubBytes___3_t8);
  SubBytes___3_y10 = AND(SubBytes___3_t8,SubBytes___3_y10);
  SubBytes___3_t8 = AND(SubBytes___3_t8,SubBytes___3_y8);
  SubBytes___3_t0 = AND(SubBytes___3_t28,SubBytes___3_t0);
  SubBytes___3_t28 = AND(SubBytes___3_t28,SubBytes___3_y13);
  SubBytes___3_y17 = AND(SubBytes___3_t42,SubBytes___3_y17);
  SubBytes___3_t42 = AND(SubBytes___3_t42,SubBytes___3_y14);
  SubBytes___3_y1 = XOR(SubBytes___3_t0,SubBytes___3_y1);
  SubBytes___3_t0 = XOR(SubBytes___3_t0,SubBytes___3_y7);
  SubBytes___3_tc7 = XOR(SubBytes___3_t28,SubBytes___3_z2);
  SubBytes___3_t42 = XOR(SubBytes___3_y9,SubBytes___3_t42);
  SubBytes___3_y17 = XOR(SubBytes___3_y17,SubBytes___3_y1);
  SubBytes___3_y1 = XOR(SubBytes___3_y1,SubBytes___3_y6);
  SubBytes___3_z2 = XOR(SubBytes___3_z2,SubBytes___3_t0);
  SubBytes___3_y10 = XOR(SubBytes___3_y10,SubBytes___3_tc7);
  SubBytes___3_y3 = XOR(SubBytes___3_y3,SubBytes___3_t42);
  SubBytes___3_t25 = XOR(SubBytes___3_t25,SubBytes___3_t42);
  SubBytes___3_y11 = XOR(SubBytes___3_y11,SubBytes___3_y17);
  SubBytes___3_y17 = XOR(SubBytes___3_y17,SubBytes___3_y10);
  SubBytes___3_t3 = XOR(SubBytes___3_t3,SubBytes___3_y3);
  SubBytes___3_y3 = XOR(SubBytes___3_y3,SubBytes___3_y4);
  SubBytes___3_t25 = XOR(SubBytes___3_t25,SubBytes___3_z2);
  SubBytes___3_y9 = XOR(SubBytes___3_y9,SubBytes___3_y11);
  SubBytes___3_y2 = XOR(SubBytes___3_y2,SubBytes___3_y17);
  _tmp76_3__ = XOR(SubBytes___3_t3,SubBytes___3_y1);
  _tmp76_0__ = XOR(SubBytes___3_t3,SubBytes___3_y11);
  SubBytes___3_t28 = XOR(SubBytes___3_t28,SubBytes___3_t25);
  SubBytes___3_y17 = XOR(SubBytes___3_y17,SubBytes___3_t25);
  SubBytes___3_y9 = XOR(SubBytes___3_y2,SubBytes___3_y9);
  _tmp76_5__ = XOR(SubBytes___3_y3,SubBytes___3_y2);
  _tmp76_4__ = XOR(SubBytes___3_z2,_tmp76_3__);
  SubBytes___3__tmp3_ = XOR(_tmp76_3__,SubBytes___3_y11);
  _tmp77_3__ = PERMUT_16(_tmp76_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp77_0__ = PERMUT_16(_tmp76_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp76_7__ = NOT(SubBytes___3_t28);
  _tmp76_6__ = NOT(SubBytes___3_y17);
  SubBytes___3_y9 = XOR(SubBytes___3_y9,SubBytes___3_t8);
  _tmp77_5__ = PERMUT_16(_tmp76_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp77_4__ = PERMUT_16(_tmp76_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___3__tmp3_ = NOT(SubBytes___3__tmp3_);
  MixColumn___3__tmp44_ = PERMUT_16(_tmp77_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___3__tmp5_ = PERMUT_16(_tmp77_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp77_7__ = PERMUT_16(_tmp76_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp77_6__ = PERMUT_16(_tmp76_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp76_2__ = NOT(SubBytes___3_y9);
  MixColumn___3__tmp24_ = PERMUT_16(_tmp77_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___3__tmp34_ = PERMUT_16(_tmp77_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp77_1__ = PERMUT_16(SubBytes___3__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp77_3__ = XOR(_tmp77_3__,MixColumn___3__tmp44_);
  _tmp77_0__ = XOR(_tmp77_0__,MixColumn___3__tmp5_);
  MixColumn___3__tmp7_ = PERMUT_16(_tmp77_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___3__tmp17_ = PERMUT_16(_tmp77_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp77_2__ = PERMUT_16(_tmp76_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp77_5__ = XOR(_tmp77_5__,MixColumn___3__tmp24_);
  _tmp77_4__ = XOR(_tmp77_4__,MixColumn___3__tmp34_);
  MixColumn___3__tmp58_ = PERMUT_16(_tmp77_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___3__tmp48_ = PERMUT_16(_tmp77_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___3__tmp69_ = PERMUT_16(_tmp77_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_7__ = XOR(_tmp77_7__,MixColumn___3__tmp7_);
  MixColumn___3__tmp7_ = XOR(_tmp77_0__,MixColumn___3__tmp7_);
  _tmp77_6__ = XOR(_tmp77_6__,MixColumn___3__tmp17_);
  MixColumn___3__tmp51_ = PERMUT_16(_tmp77_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___3__tmp28_ = PERMUT_16(_tmp77_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_5__ = XOR(_tmp77_5__,_tmp77_0__);
  MixColumn___3__tmp38_ = PERMUT_16(_tmp77_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_4__ = XOR(_tmp77_4__,_tmp77_0__);
  _tmp77_1__ = XOR(_tmp77_1__,MixColumn___3__tmp58_);
  MixColumn___3__tmp11_ = PERMUT_16(_tmp77_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_7__ = XOR(_tmp77_7__,_tmp77_0__);
  MixColumn___3__tmp21_ = PERMUT_16(_tmp77_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_6__ = XOR(_tmp77_6__,MixColumn___3__tmp24_);
  _tmp77_2__ = XOR(_tmp77_2__,MixColumn___3__tmp51_);
  _tmp77_3__ = XOR(_tmp77_3__,MixColumn___3__tmp51_);
  _tmp77_5__ = XOR(_tmp77_5__,MixColumn___3__tmp34_);
  _tmp77_4__ = XOR(_tmp77_4__,MixColumn___3__tmp44_);
  MixColumn___3__tmp62_ = PERMUT_16(_tmp77_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_1__ = XOR(_tmp77_1__,MixColumn___3__tmp5_);
  MixColumn___3__tmp7_ = XOR(MixColumn___3__tmp7_,MixColumn___3__tmp11_);
  _tmp77_7__ = XOR(_tmp77_7__,MixColumn___3__tmp17_);
  _tmp77_6__ = XOR(_tmp77_6__,MixColumn___3__tmp28_);
  MixColumn___3__tmp55_ = PERMUT_16(_tmp77_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_2__ = XOR(_tmp77_2__,MixColumn___3__tmp58_);
  _tmp77_5__ = XOR(_tmp77_5__,MixColumn___3__tmp38_);
  _tmp77_4__ = XOR(_tmp77_4__,MixColumn___3__tmp48_);
  _tmp77_1__ = XOR(_tmp77_1__,MixColumn___3__tmp69_);
  MixColumn___3__tmp7_ = XOR(MixColumn___3__tmp7_,key__[3][7]);
  _tmp77_7__ = XOR(_tmp77_7__,MixColumn___3__tmp21_);
  _tmp77_6__ = XOR(_tmp77_6__,key__[3][5]);
  _tmp77_3__ = XOR(_tmp77_3__,MixColumn___3__tmp55_);
  _tmp77_2__ = XOR(_tmp77_2__,MixColumn___3__tmp62_);
  _tmp77_5__ = XOR(_tmp77_5__,key__[3][4]);
  _tmp77_4__ = XOR(_tmp77_4__,key__[3][3]);
  _tmp77_1__ = XOR(_tmp77_1__,key__[3][0]);
  _tmp77_7__ = XOR(_tmp77_7__,key__[3][6]);
  _tmp77_3__ = XOR(_tmp77_3__,key__[3][2]);
  _tmp77_2__ = XOR(_tmp77_2__,key__[3][1]);
  SubBytes___4_y14 = XOR(_tmp77_4__,_tmp77_6__);
  SubBytes___4_y9 = XOR(_tmp77_1__,_tmp77_4__);
  SubBytes___4_y8 = XOR(_tmp77_1__,_tmp77_6__);
  SubBytes___4_y13 = XOR(_tmp77_1__,_tmp77_7__);
  SubBytes___4_t0 = XOR(_tmp77_2__,_tmp77_3__);
  SubBytes___4_y12 = XOR(SubBytes___4_y13,SubBytes___4_y14);
  SubBytes___4_y1 = XOR(SubBytes___4_t0,MixColumn___3__tmp7_);
  SubBytes___4_t1 = XOR(_tmp77_5__,SubBytes___4_y12);
  SubBytes___4_y4 = XOR(SubBytes___4_y1,_tmp77_4__);
  SubBytes___4_y2 = XOR(SubBytes___4_y1,_tmp77_1__);
  SubBytes___4_y5 = XOR(SubBytes___4_y1,_tmp77_7__);
  SubBytes___4_y15 = XOR(SubBytes___4_t1,_tmp77_6__);
  SubBytes___4_t1 = XOR(SubBytes___4_t1,_tmp77_2__);
  SubBytes___4_t5 = AND(SubBytes___4_y4,MixColumn___3__tmp7_);
  SubBytes___4_y3 = XOR(SubBytes___4_y5,SubBytes___4_y8);
  SubBytes___4_t8 = AND(SubBytes___4_y5,SubBytes___4_y1);
  SubBytes___4_y6 = XOR(SubBytes___4_y15,MixColumn___3__tmp7_);
  SubBytes___4_y10 = XOR(SubBytes___4_y15,SubBytes___4_t0);
  SubBytes___4_t2 = AND(SubBytes___4_y12,SubBytes___4_y15);
  SubBytes___4_y11 = XOR(SubBytes___4_t1,SubBytes___4_y9);
  SubBytes___4_t3 = AND(SubBytes___4_y3,SubBytes___4_y6);
  SubBytes___4_y19 = XOR(SubBytes___4_y10,SubBytes___4_y8);
  SubBytes___4_t15 = AND(SubBytes___4_y8,SubBytes___4_y10);
  SubBytes___4_t5 = XOR(SubBytes___4_t5,SubBytes___4_t2);
  SubBytes___4_y7 = XOR(MixColumn___3__tmp7_,SubBytes___4_y11);
  SubBytes___4_y17 = XOR(SubBytes___4_y10,SubBytes___4_y11);
  SubBytes___4_t0 = XOR(SubBytes___4_t0,SubBytes___4_y11);
  SubBytes___4_t12 = AND(SubBytes___4_y9,SubBytes___4_y11);
  SubBytes___4_t3 = XOR(SubBytes___4_t3,SubBytes___4_t2);
  SubBytes___4_t10 = AND(SubBytes___4_y2,SubBytes___4_y7);
  SubBytes___4_t13 = AND(SubBytes___4_y14,SubBytes___4_y17);
  SubBytes___4_y21 = XOR(SubBytes___4_y13,SubBytes___4_t0);
  SubBytes___4_y18 = XOR(_tmp77_1__,SubBytes___4_t0);
  SubBytes___4_t7 = AND(SubBytes___4_y13,SubBytes___4_t0);
  SubBytes___4_t15 = XOR(SubBytes___4_t15,SubBytes___4_t12);
  SubBytes___4_t3 = XOR(SubBytes___4_t3,SubBytes___4_t1);
  SubBytes___4_t13 = XOR(SubBytes___4_t13,SubBytes___4_t12);
  SubBytes___4_t8 = XOR(SubBytes___4_t8,SubBytes___4_t7);
  SubBytes___4_t10 = XOR(SubBytes___4_t10,SubBytes___4_t7);
  SubBytes___4_t5 = XOR(SubBytes___4_t5,SubBytes___4_t15);
  SubBytes___4_t3 = XOR(SubBytes___4_t3,SubBytes___4_t13);
  SubBytes___4_t8 = XOR(SubBytes___4_t8,SubBytes___4_t13);
  SubBytes___4_t10 = XOR(SubBytes___4_t10,SubBytes___4_t15);
  SubBytes___4_t5 = XOR(SubBytes___4_t5,SubBytes___4_y19);
  SubBytes___4_t8 = XOR(SubBytes___4_t8,SubBytes___4_y21);
  SubBytes___4_t10 = XOR(SubBytes___4_t10,SubBytes___4_y18);
  SubBytes___4_t25 = XOR(SubBytes___4_t3,SubBytes___4_t5);
  SubBytes___4_t3 = AND(SubBytes___4_t3,SubBytes___4_t8);
  SubBytes___4_t30 = XOR(SubBytes___4_t8,SubBytes___4_t10);
  SubBytes___4_t27 = XOR(SubBytes___4_t10,SubBytes___4_t3);
  SubBytes___4_t3 = XOR(SubBytes___4_t5,SubBytes___4_t3);
  SubBytes___4_t28 = AND(SubBytes___4_t25,SubBytes___4_t27);
  SubBytes___4_t3 = AND(SubBytes___4_t3,SubBytes___4_t30);
  SubBytes___4_t28 = XOR(SubBytes___4_t28,SubBytes___4_t5);
  SubBytes___4_t3 = XOR(SubBytes___4_t3,SubBytes___4_t10);
  SubBytes___4_y7 = AND(SubBytes___4_t28,SubBytes___4_y7);
  SubBytes___4_y2 = AND(SubBytes___4_t28,SubBytes___4_y2);
  SubBytes___4_t8 = XOR(SubBytes___4_t8,SubBytes___4_t3);
  SubBytes___4_t35 = XOR(SubBytes___4_t27,SubBytes___4_t3);
  SubBytes___4_t42 = XOR(SubBytes___4_t28,SubBytes___4_t3);
  SubBytes___4_z2 = AND(SubBytes___4_t3,MixColumn___3__tmp7_);
  SubBytes___4_y4 = AND(SubBytes___4_t3,SubBytes___4_y4);
  SubBytes___4_t10 = AND(SubBytes___4_t10,SubBytes___4_t35);
  SubBytes___4_y11 = AND(SubBytes___4_t42,SubBytes___4_y11);
  SubBytes___4_y9 = AND(SubBytes___4_t42,SubBytes___4_y9);
  SubBytes___4_t8 = XOR(SubBytes___4_t10,SubBytes___4_t8);
  SubBytes___4_t27 = XOR(SubBytes___4_t27,SubBytes___4_t10);
  SubBytes___4_t3 = XOR(SubBytes___4_t3,SubBytes___4_t8);
  SubBytes___4_y6 = AND(SubBytes___4_t8,SubBytes___4_y6);
  SubBytes___4_y3 = AND(SubBytes___4_t8,SubBytes___4_y3);
  SubBytes___4_t27 = AND(SubBytes___4_t28,SubBytes___4_t27);
  SubBytes___4_y15 = AND(SubBytes___4_t3,SubBytes___4_y15);
  SubBytes___4_t3 = AND(SubBytes___4_t3,SubBytes___4_y12);
  SubBytes___4_t25 = XOR(SubBytes___4_t25,SubBytes___4_t27);
  SubBytes___4_z2 = XOR(SubBytes___4_y15,SubBytes___4_z2);
  SubBytes___4_y6 = XOR(SubBytes___4_y6,SubBytes___4_y15);
  SubBytes___4_t8 = XOR(SubBytes___4_t25,SubBytes___4_t8);
  SubBytes___4_t28 = XOR(SubBytes___4_t28,SubBytes___4_t25);
  SubBytes___4_y1 = AND(SubBytes___4_t25,SubBytes___4_y1);
  SubBytes___4_t25 = AND(SubBytes___4_t25,SubBytes___4_y5);
  SubBytes___4_t42 = XOR(SubBytes___4_t42,SubBytes___4_t8);
  SubBytes___4_y10 = AND(SubBytes___4_t8,SubBytes___4_y10);
  SubBytes___4_t8 = AND(SubBytes___4_t8,SubBytes___4_y8);
  SubBytes___4_t0 = AND(SubBytes___4_t28,SubBytes___4_t0);
  SubBytes___4_t28 = AND(SubBytes___4_t28,SubBytes___4_y13);
  SubBytes___4_y17 = AND(SubBytes___4_t42,SubBytes___4_y17);
  SubBytes___4_t42 = AND(SubBytes___4_t42,SubBytes___4_y14);
  SubBytes___4_y1 = XOR(SubBytes___4_t0,SubBytes___4_y1);
  SubBytes___4_t0 = XOR(SubBytes___4_t0,SubBytes___4_y7);
  SubBytes___4_tc7 = XOR(SubBytes___4_t28,SubBytes___4_z2);
  SubBytes___4_t42 = XOR(SubBytes___4_y9,SubBytes___4_t42);
  SubBytes___4_y17 = XOR(SubBytes___4_y17,SubBytes___4_y1);
  SubBytes___4_y1 = XOR(SubBytes___4_y1,SubBytes___4_y6);
  SubBytes___4_z2 = XOR(SubBytes___4_z2,SubBytes___4_t0);
  SubBytes___4_y10 = XOR(SubBytes___4_y10,SubBytes___4_tc7);
  SubBytes___4_y3 = XOR(SubBytes___4_y3,SubBytes___4_t42);
  SubBytes___4_t25 = XOR(SubBytes___4_t25,SubBytes___4_t42);
  SubBytes___4_y11 = XOR(SubBytes___4_y11,SubBytes___4_y17);
  SubBytes___4_y17 = XOR(SubBytes___4_y17,SubBytes___4_y10);
  SubBytes___4_t3 = XOR(SubBytes___4_t3,SubBytes___4_y3);
  SubBytes___4_y3 = XOR(SubBytes___4_y3,SubBytes___4_y4);
  SubBytes___4_t25 = XOR(SubBytes___4_t25,SubBytes___4_z2);
  SubBytes___4_y9 = XOR(SubBytes___4_y9,SubBytes___4_y11);
  SubBytes___4_y2 = XOR(SubBytes___4_y2,SubBytes___4_y17);
  _tmp79_3__ = XOR(SubBytes___4_t3,SubBytes___4_y1);
  _tmp79_0__ = XOR(SubBytes___4_t3,SubBytes___4_y11);
  SubBytes___4_t28 = XOR(SubBytes___4_t28,SubBytes___4_t25);
  SubBytes___4_y17 = XOR(SubBytes___4_y17,SubBytes___4_t25);
  SubBytes___4_y9 = XOR(SubBytes___4_y2,SubBytes___4_y9);
  _tmp79_5__ = XOR(SubBytes___4_y3,SubBytes___4_y2);
  _tmp79_4__ = XOR(SubBytes___4_z2,_tmp79_3__);
  SubBytes___4__tmp3_ = XOR(_tmp79_3__,SubBytes___4_y11);
  _tmp80_3__ = PERMUT_16(_tmp79_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp80_0__ = PERMUT_16(_tmp79_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp79_7__ = NOT(SubBytes___4_t28);
  _tmp79_6__ = NOT(SubBytes___4_y17);
  SubBytes___4_y9 = XOR(SubBytes___4_y9,SubBytes___4_t8);
  _tmp80_5__ = PERMUT_16(_tmp79_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp80_4__ = PERMUT_16(_tmp79_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___4__tmp3_ = NOT(SubBytes___4__tmp3_);
  MixColumn___4__tmp44_ = PERMUT_16(_tmp80_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___4__tmp5_ = PERMUT_16(_tmp80_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp80_7__ = PERMUT_16(_tmp79_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp80_6__ = PERMUT_16(_tmp79_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp79_2__ = NOT(SubBytes___4_y9);
  MixColumn___4__tmp24_ = PERMUT_16(_tmp80_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___4__tmp34_ = PERMUT_16(_tmp80_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp80_1__ = PERMUT_16(SubBytes___4__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp80_3__ = XOR(_tmp80_3__,MixColumn___4__tmp44_);
  _tmp80_0__ = XOR(_tmp80_0__,MixColumn___4__tmp5_);
  MixColumn___4__tmp7_ = PERMUT_16(_tmp80_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___4__tmp17_ = PERMUT_16(_tmp80_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp80_2__ = PERMUT_16(_tmp79_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp80_5__ = XOR(_tmp80_5__,MixColumn___4__tmp24_);
  _tmp80_4__ = XOR(_tmp80_4__,MixColumn___4__tmp34_);
  MixColumn___4__tmp58_ = PERMUT_16(_tmp80_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___4__tmp48_ = PERMUT_16(_tmp80_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___4__tmp69_ = PERMUT_16(_tmp80_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_7__ = XOR(_tmp80_7__,MixColumn___4__tmp7_);
  MixColumn___4__tmp7_ = XOR(_tmp80_0__,MixColumn___4__tmp7_);
  _tmp80_6__ = XOR(_tmp80_6__,MixColumn___4__tmp17_);
  MixColumn___4__tmp51_ = PERMUT_16(_tmp80_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___4__tmp28_ = PERMUT_16(_tmp80_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_5__ = XOR(_tmp80_5__,_tmp80_0__);
  MixColumn___4__tmp38_ = PERMUT_16(_tmp80_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_4__ = XOR(_tmp80_4__,_tmp80_0__);
  _tmp80_1__ = XOR(_tmp80_1__,MixColumn___4__tmp58_);
  MixColumn___4__tmp11_ = PERMUT_16(_tmp80_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_7__ = XOR(_tmp80_7__,_tmp80_0__);
  MixColumn___4__tmp21_ = PERMUT_16(_tmp80_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_6__ = XOR(_tmp80_6__,MixColumn___4__tmp24_);
  _tmp80_2__ = XOR(_tmp80_2__,MixColumn___4__tmp51_);
  _tmp80_3__ = XOR(_tmp80_3__,MixColumn___4__tmp51_);
  _tmp80_5__ = XOR(_tmp80_5__,MixColumn___4__tmp34_);
  _tmp80_4__ = XOR(_tmp80_4__,MixColumn___4__tmp44_);
  MixColumn___4__tmp62_ = PERMUT_16(_tmp80_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_1__ = XOR(_tmp80_1__,MixColumn___4__tmp5_);
  MixColumn___4__tmp7_ = XOR(MixColumn___4__tmp7_,MixColumn___4__tmp11_);
  _tmp80_7__ = XOR(_tmp80_7__,MixColumn___4__tmp17_);
  _tmp80_6__ = XOR(_tmp80_6__,MixColumn___4__tmp28_);
  MixColumn___4__tmp55_ = PERMUT_16(_tmp80_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_2__ = XOR(_tmp80_2__,MixColumn___4__tmp58_);
  _tmp80_5__ = XOR(_tmp80_5__,MixColumn___4__tmp38_);
  _tmp80_4__ = XOR(_tmp80_4__,MixColumn___4__tmp48_);
  _tmp80_1__ = XOR(_tmp80_1__,MixColumn___4__tmp69_);
  MixColumn___4__tmp7_ = XOR(MixColumn___4__tmp7_,key__[4][7]);
  _tmp80_7__ = XOR(_tmp80_7__,MixColumn___4__tmp21_);
  _tmp80_6__ = XOR(_tmp80_6__,key__[4][5]);
  _tmp80_3__ = XOR(_tmp80_3__,MixColumn___4__tmp55_);
  _tmp80_2__ = XOR(_tmp80_2__,MixColumn___4__tmp62_);
  _tmp80_5__ = XOR(_tmp80_5__,key__[4][4]);
  _tmp80_4__ = XOR(_tmp80_4__,key__[4][3]);
  _tmp80_1__ = XOR(_tmp80_1__,key__[4][0]);
  _tmp80_7__ = XOR(_tmp80_7__,key__[4][6]);
  _tmp80_3__ = XOR(_tmp80_3__,key__[4][2]);
  _tmp80_2__ = XOR(_tmp80_2__,key__[4][1]);
  SubBytes___5_y14 = XOR(_tmp80_4__,_tmp80_6__);
  SubBytes___5_y9 = XOR(_tmp80_1__,_tmp80_4__);
  SubBytes___5_y8 = XOR(_tmp80_1__,_tmp80_6__);
  SubBytes___5_y13 = XOR(_tmp80_1__,_tmp80_7__);
  SubBytes___5_t0 = XOR(_tmp80_2__,_tmp80_3__);
  SubBytes___5_y12 = XOR(SubBytes___5_y13,SubBytes___5_y14);
  SubBytes___5_y1 = XOR(SubBytes___5_t0,MixColumn___4__tmp7_);
  SubBytes___5_t1 = XOR(_tmp80_5__,SubBytes___5_y12);
  SubBytes___5_y4 = XOR(SubBytes___5_y1,_tmp80_4__);
  SubBytes___5_y2 = XOR(SubBytes___5_y1,_tmp80_1__);
  SubBytes___5_y5 = XOR(SubBytes___5_y1,_tmp80_7__);
  SubBytes___5_y15 = XOR(SubBytes___5_t1,_tmp80_6__);
  SubBytes___5_t1 = XOR(SubBytes___5_t1,_tmp80_2__);
  SubBytes___5_t5 = AND(SubBytes___5_y4,MixColumn___4__tmp7_);
  SubBytes___5_y3 = XOR(SubBytes___5_y5,SubBytes___5_y8);
  SubBytes___5_t8 = AND(SubBytes___5_y5,SubBytes___5_y1);
  SubBytes___5_y6 = XOR(SubBytes___5_y15,MixColumn___4__tmp7_);
  SubBytes___5_y10 = XOR(SubBytes___5_y15,SubBytes___5_t0);
  SubBytes___5_t2 = AND(SubBytes___5_y12,SubBytes___5_y15);
  SubBytes___5_y11 = XOR(SubBytes___5_t1,SubBytes___5_y9);
  SubBytes___5_t3 = AND(SubBytes___5_y3,SubBytes___5_y6);
  SubBytes___5_y19 = XOR(SubBytes___5_y10,SubBytes___5_y8);
  SubBytes___5_t15 = AND(SubBytes___5_y8,SubBytes___5_y10);
  SubBytes___5_t5 = XOR(SubBytes___5_t5,SubBytes___5_t2);
  SubBytes___5_y7 = XOR(MixColumn___4__tmp7_,SubBytes___5_y11);
  SubBytes___5_y17 = XOR(SubBytes___5_y10,SubBytes___5_y11);
  SubBytes___5_t0 = XOR(SubBytes___5_t0,SubBytes___5_y11);
  SubBytes___5_t12 = AND(SubBytes___5_y9,SubBytes___5_y11);
  SubBytes___5_t3 = XOR(SubBytes___5_t3,SubBytes___5_t2);
  SubBytes___5_t10 = AND(SubBytes___5_y2,SubBytes___5_y7);
  SubBytes___5_t13 = AND(SubBytes___5_y14,SubBytes___5_y17);
  SubBytes___5_y21 = XOR(SubBytes___5_y13,SubBytes___5_t0);
  SubBytes___5_y18 = XOR(_tmp80_1__,SubBytes___5_t0);
  SubBytes___5_t7 = AND(SubBytes___5_y13,SubBytes___5_t0);
  SubBytes___5_t15 = XOR(SubBytes___5_t15,SubBytes___5_t12);
  SubBytes___5_t3 = XOR(SubBytes___5_t3,SubBytes___5_t1);
  SubBytes___5_t13 = XOR(SubBytes___5_t13,SubBytes___5_t12);
  SubBytes___5_t8 = XOR(SubBytes___5_t8,SubBytes___5_t7);
  SubBytes___5_t10 = XOR(SubBytes___5_t10,SubBytes___5_t7);
  SubBytes___5_t5 = XOR(SubBytes___5_t5,SubBytes___5_t15);
  SubBytes___5_t3 = XOR(SubBytes___5_t3,SubBytes___5_t13);
  SubBytes___5_t8 = XOR(SubBytes___5_t8,SubBytes___5_t13);
  SubBytes___5_t10 = XOR(SubBytes___5_t10,SubBytes___5_t15);
  SubBytes___5_t5 = XOR(SubBytes___5_t5,SubBytes___5_y19);
  SubBytes___5_t8 = XOR(SubBytes___5_t8,SubBytes___5_y21);
  SubBytes___5_t10 = XOR(SubBytes___5_t10,SubBytes___5_y18);
  SubBytes___5_t25 = XOR(SubBytes___5_t3,SubBytes___5_t5);
  SubBytes___5_t3 = AND(SubBytes___5_t3,SubBytes___5_t8);
  SubBytes___5_t30 = XOR(SubBytes___5_t8,SubBytes___5_t10);
  SubBytes___5_t27 = XOR(SubBytes___5_t10,SubBytes___5_t3);
  SubBytes___5_t3 = XOR(SubBytes___5_t5,SubBytes___5_t3);
  SubBytes___5_t28 = AND(SubBytes___5_t25,SubBytes___5_t27);
  SubBytes___5_t3 = AND(SubBytes___5_t3,SubBytes___5_t30);
  SubBytes___5_t28 = XOR(SubBytes___5_t28,SubBytes___5_t5);
  SubBytes___5_t3 = XOR(SubBytes___5_t3,SubBytes___5_t10);
  SubBytes___5_y7 = AND(SubBytes___5_t28,SubBytes___5_y7);
  SubBytes___5_y2 = AND(SubBytes___5_t28,SubBytes___5_y2);
  SubBytes___5_t8 = XOR(SubBytes___5_t8,SubBytes___5_t3);
  SubBytes___5_t35 = XOR(SubBytes___5_t27,SubBytes___5_t3);
  SubBytes___5_t42 = XOR(SubBytes___5_t28,SubBytes___5_t3);
  SubBytes___5_z2 = AND(SubBytes___5_t3,MixColumn___4__tmp7_);
  SubBytes___5_y4 = AND(SubBytes___5_t3,SubBytes___5_y4);
  SubBytes___5_t10 = AND(SubBytes___5_t10,SubBytes___5_t35);
  SubBytes___5_y11 = AND(SubBytes___5_t42,SubBytes___5_y11);
  SubBytes___5_y9 = AND(SubBytes___5_t42,SubBytes___5_y9);
  SubBytes___5_t8 = XOR(SubBytes___5_t10,SubBytes___5_t8);
  SubBytes___5_t27 = XOR(SubBytes___5_t27,SubBytes___5_t10);
  SubBytes___5_t3 = XOR(SubBytes___5_t3,SubBytes___5_t8);
  SubBytes___5_y6 = AND(SubBytes___5_t8,SubBytes___5_y6);
  SubBytes___5_y3 = AND(SubBytes___5_t8,SubBytes___5_y3);
  SubBytes___5_t27 = AND(SubBytes___5_t28,SubBytes___5_t27);
  SubBytes___5_y15 = AND(SubBytes___5_t3,SubBytes___5_y15);
  SubBytes___5_t3 = AND(SubBytes___5_t3,SubBytes___5_y12);
  SubBytes___5_t25 = XOR(SubBytes___5_t25,SubBytes___5_t27);
  SubBytes___5_z2 = XOR(SubBytes___5_y15,SubBytes___5_z2);
  SubBytes___5_y6 = XOR(SubBytes___5_y6,SubBytes___5_y15);
  SubBytes___5_t8 = XOR(SubBytes___5_t25,SubBytes___5_t8);
  SubBytes___5_t28 = XOR(SubBytes___5_t28,SubBytes___5_t25);
  SubBytes___5_y1 = AND(SubBytes___5_t25,SubBytes___5_y1);
  SubBytes___5_t25 = AND(SubBytes___5_t25,SubBytes___5_y5);
  SubBytes___5_t42 = XOR(SubBytes___5_t42,SubBytes___5_t8);
  SubBytes___5_y10 = AND(SubBytes___5_t8,SubBytes___5_y10);
  SubBytes___5_t8 = AND(SubBytes___5_t8,SubBytes___5_y8);
  SubBytes___5_t0 = AND(SubBytes___5_t28,SubBytes___5_t0);
  SubBytes___5_t28 = AND(SubBytes___5_t28,SubBytes___5_y13);
  SubBytes___5_y17 = AND(SubBytes___5_t42,SubBytes___5_y17);
  SubBytes___5_t42 = AND(SubBytes___5_t42,SubBytes___5_y14);
  SubBytes___5_y1 = XOR(SubBytes___5_t0,SubBytes___5_y1);
  SubBytes___5_t0 = XOR(SubBytes___5_t0,SubBytes___5_y7);
  SubBytes___5_tc7 = XOR(SubBytes___5_t28,SubBytes___5_z2);
  SubBytes___5_t42 = XOR(SubBytes___5_y9,SubBytes___5_t42);
  SubBytes___5_y17 = XOR(SubBytes___5_y17,SubBytes___5_y1);
  SubBytes___5_y1 = XOR(SubBytes___5_y1,SubBytes___5_y6);
  SubBytes___5_z2 = XOR(SubBytes___5_z2,SubBytes___5_t0);
  SubBytes___5_y10 = XOR(SubBytes___5_y10,SubBytes___5_tc7);
  SubBytes___5_y3 = XOR(SubBytes___5_y3,SubBytes___5_t42);
  SubBytes___5_t25 = XOR(SubBytes___5_t25,SubBytes___5_t42);
  SubBytes___5_y11 = XOR(SubBytes___5_y11,SubBytes___5_y17);
  SubBytes___5_y17 = XOR(SubBytes___5_y17,SubBytes___5_y10);
  SubBytes___5_t3 = XOR(SubBytes___5_t3,SubBytes___5_y3);
  SubBytes___5_y3 = XOR(SubBytes___5_y3,SubBytes___5_y4);
  SubBytes___5_t25 = XOR(SubBytes___5_t25,SubBytes___5_z2);
  SubBytes___5_y9 = XOR(SubBytes___5_y9,SubBytes___5_y11);
  SubBytes___5_y2 = XOR(SubBytes___5_y2,SubBytes___5_y17);
  _tmp82_3__ = XOR(SubBytes___5_t3,SubBytes___5_y1);
  _tmp82_0__ = XOR(SubBytes___5_t3,SubBytes___5_y11);
  SubBytes___5_t28 = XOR(SubBytes___5_t28,SubBytes___5_t25);
  SubBytes___5_y17 = XOR(SubBytes___5_y17,SubBytes___5_t25);
  SubBytes___5_y9 = XOR(SubBytes___5_y2,SubBytes___5_y9);
  _tmp82_5__ = XOR(SubBytes___5_y3,SubBytes___5_y2);
  _tmp82_4__ = XOR(SubBytes___5_z2,_tmp82_3__);
  SubBytes___5__tmp3_ = XOR(_tmp82_3__,SubBytes___5_y11);
  _tmp83_3__ = PERMUT_16(_tmp82_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp83_0__ = PERMUT_16(_tmp82_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp82_7__ = NOT(SubBytes___5_t28);
  _tmp82_6__ = NOT(SubBytes___5_y17);
  SubBytes___5_y9 = XOR(SubBytes___5_y9,SubBytes___5_t8);
  _tmp83_5__ = PERMUT_16(_tmp82_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp83_4__ = PERMUT_16(_tmp82_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___5__tmp3_ = NOT(SubBytes___5__tmp3_);
  MixColumn___5__tmp44_ = PERMUT_16(_tmp83_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___5__tmp5_ = PERMUT_16(_tmp83_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp83_7__ = PERMUT_16(_tmp82_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp83_6__ = PERMUT_16(_tmp82_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp82_2__ = NOT(SubBytes___5_y9);
  MixColumn___5__tmp24_ = PERMUT_16(_tmp83_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___5__tmp34_ = PERMUT_16(_tmp83_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp83_1__ = PERMUT_16(SubBytes___5__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp83_3__ = XOR(_tmp83_3__,MixColumn___5__tmp44_);
  _tmp83_0__ = XOR(_tmp83_0__,MixColumn___5__tmp5_);
  MixColumn___5__tmp7_ = PERMUT_16(_tmp83_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___5__tmp17_ = PERMUT_16(_tmp83_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp83_2__ = PERMUT_16(_tmp82_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp83_5__ = XOR(_tmp83_5__,MixColumn___5__tmp24_);
  _tmp83_4__ = XOR(_tmp83_4__,MixColumn___5__tmp34_);
  MixColumn___5__tmp58_ = PERMUT_16(_tmp83_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___5__tmp48_ = PERMUT_16(_tmp83_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___5__tmp69_ = PERMUT_16(_tmp83_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_7__ = XOR(_tmp83_7__,MixColumn___5__tmp7_);
  MixColumn___5__tmp7_ = XOR(_tmp83_0__,MixColumn___5__tmp7_);
  _tmp83_6__ = XOR(_tmp83_6__,MixColumn___5__tmp17_);
  MixColumn___5__tmp51_ = PERMUT_16(_tmp83_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___5__tmp28_ = PERMUT_16(_tmp83_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_5__ = XOR(_tmp83_5__,_tmp83_0__);
  MixColumn___5__tmp38_ = PERMUT_16(_tmp83_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_4__ = XOR(_tmp83_4__,_tmp83_0__);
  _tmp83_1__ = XOR(_tmp83_1__,MixColumn___5__tmp58_);
  MixColumn___5__tmp11_ = PERMUT_16(_tmp83_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_7__ = XOR(_tmp83_7__,_tmp83_0__);
  MixColumn___5__tmp21_ = PERMUT_16(_tmp83_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_6__ = XOR(_tmp83_6__,MixColumn___5__tmp24_);
  _tmp83_2__ = XOR(_tmp83_2__,MixColumn___5__tmp51_);
  _tmp83_3__ = XOR(_tmp83_3__,MixColumn___5__tmp51_);
  _tmp83_5__ = XOR(_tmp83_5__,MixColumn___5__tmp34_);
  _tmp83_4__ = XOR(_tmp83_4__,MixColumn___5__tmp44_);
  MixColumn___5__tmp62_ = PERMUT_16(_tmp83_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_1__ = XOR(_tmp83_1__,MixColumn___5__tmp5_);
  MixColumn___5__tmp7_ = XOR(MixColumn___5__tmp7_,MixColumn___5__tmp11_);
  _tmp83_7__ = XOR(_tmp83_7__,MixColumn___5__tmp17_);
  _tmp83_6__ = XOR(_tmp83_6__,MixColumn___5__tmp28_);
  MixColumn___5__tmp55_ = PERMUT_16(_tmp83_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_2__ = XOR(_tmp83_2__,MixColumn___5__tmp58_);
  _tmp83_5__ = XOR(_tmp83_5__,MixColumn___5__tmp38_);
  _tmp83_4__ = XOR(_tmp83_4__,MixColumn___5__tmp48_);
  _tmp83_1__ = XOR(_tmp83_1__,MixColumn___5__tmp69_);
  MixColumn___5__tmp7_ = XOR(MixColumn___5__tmp7_,key__[5][7]);
  _tmp83_7__ = XOR(_tmp83_7__,MixColumn___5__tmp21_);
  _tmp83_6__ = XOR(_tmp83_6__,key__[5][5]);
  _tmp83_3__ = XOR(_tmp83_3__,MixColumn___5__tmp55_);
  _tmp83_2__ = XOR(_tmp83_2__,MixColumn___5__tmp62_);
  _tmp83_5__ = XOR(_tmp83_5__,key__[5][4]);
  _tmp83_4__ = XOR(_tmp83_4__,key__[5][3]);
  _tmp83_1__ = XOR(_tmp83_1__,key__[5][0]);
  _tmp83_7__ = XOR(_tmp83_7__,key__[5][6]);
  _tmp83_3__ = XOR(_tmp83_3__,key__[5][2]);
  _tmp83_2__ = XOR(_tmp83_2__,key__[5][1]);
  SubBytes___6_y14 = XOR(_tmp83_4__,_tmp83_6__);
  SubBytes___6_y9 = XOR(_tmp83_1__,_tmp83_4__);
  SubBytes___6_y8 = XOR(_tmp83_1__,_tmp83_6__);
  SubBytes___6_y13 = XOR(_tmp83_1__,_tmp83_7__);
  SubBytes___6_t0 = XOR(_tmp83_2__,_tmp83_3__);
  SubBytes___6_y12 = XOR(SubBytes___6_y13,SubBytes___6_y14);
  SubBytes___6_y1 = XOR(SubBytes___6_t0,MixColumn___5__tmp7_);
  SubBytes___6_t1 = XOR(_tmp83_5__,SubBytes___6_y12);
  SubBytes___6_y4 = XOR(SubBytes___6_y1,_tmp83_4__);
  SubBytes___6_y2 = XOR(SubBytes___6_y1,_tmp83_1__);
  SubBytes___6_y5 = XOR(SubBytes___6_y1,_tmp83_7__);
  SubBytes___6_y15 = XOR(SubBytes___6_t1,_tmp83_6__);
  SubBytes___6_t1 = XOR(SubBytes___6_t1,_tmp83_2__);
  SubBytes___6_t5 = AND(SubBytes___6_y4,MixColumn___5__tmp7_);
  SubBytes___6_y3 = XOR(SubBytes___6_y5,SubBytes___6_y8);
  SubBytes___6_t8 = AND(SubBytes___6_y5,SubBytes___6_y1);
  SubBytes___6_y6 = XOR(SubBytes___6_y15,MixColumn___5__tmp7_);
  SubBytes___6_y10 = XOR(SubBytes___6_y15,SubBytes___6_t0);
  SubBytes___6_t2 = AND(SubBytes___6_y12,SubBytes___6_y15);
  SubBytes___6_y11 = XOR(SubBytes___6_t1,SubBytes___6_y9);
  SubBytes___6_t3 = AND(SubBytes___6_y3,SubBytes___6_y6);
  SubBytes___6_y19 = XOR(SubBytes___6_y10,SubBytes___6_y8);
  SubBytes___6_t15 = AND(SubBytes___6_y8,SubBytes___6_y10);
  SubBytes___6_t5 = XOR(SubBytes___6_t5,SubBytes___6_t2);
  SubBytes___6_y7 = XOR(MixColumn___5__tmp7_,SubBytes___6_y11);
  SubBytes___6_y17 = XOR(SubBytes___6_y10,SubBytes___6_y11);
  SubBytes___6_t0 = XOR(SubBytes___6_t0,SubBytes___6_y11);
  SubBytes___6_t12 = AND(SubBytes___6_y9,SubBytes___6_y11);
  SubBytes___6_t3 = XOR(SubBytes___6_t3,SubBytes___6_t2);
  SubBytes___6_t10 = AND(SubBytes___6_y2,SubBytes___6_y7);
  SubBytes___6_t13 = AND(SubBytes___6_y14,SubBytes___6_y17);
  SubBytes___6_y21 = XOR(SubBytes___6_y13,SubBytes___6_t0);
  SubBytes___6_y18 = XOR(_tmp83_1__,SubBytes___6_t0);
  SubBytes___6_t7 = AND(SubBytes___6_y13,SubBytes___6_t0);
  SubBytes___6_t15 = XOR(SubBytes___6_t15,SubBytes___6_t12);
  SubBytes___6_t3 = XOR(SubBytes___6_t3,SubBytes___6_t1);
  SubBytes___6_t13 = XOR(SubBytes___6_t13,SubBytes___6_t12);
  SubBytes___6_t8 = XOR(SubBytes___6_t8,SubBytes___6_t7);
  SubBytes___6_t10 = XOR(SubBytes___6_t10,SubBytes___6_t7);
  SubBytes___6_t5 = XOR(SubBytes___6_t5,SubBytes___6_t15);
  SubBytes___6_t3 = XOR(SubBytes___6_t3,SubBytes___6_t13);
  SubBytes___6_t8 = XOR(SubBytes___6_t8,SubBytes___6_t13);
  SubBytes___6_t10 = XOR(SubBytes___6_t10,SubBytes___6_t15);
  SubBytes___6_t5 = XOR(SubBytes___6_t5,SubBytes___6_y19);
  SubBytes___6_t8 = XOR(SubBytes___6_t8,SubBytes___6_y21);
  SubBytes___6_t10 = XOR(SubBytes___6_t10,SubBytes___6_y18);
  SubBytes___6_t25 = XOR(SubBytes___6_t3,SubBytes___6_t5);
  SubBytes___6_t3 = AND(SubBytes___6_t3,SubBytes___6_t8);
  SubBytes___6_t30 = XOR(SubBytes___6_t8,SubBytes___6_t10);
  SubBytes___6_t27 = XOR(SubBytes___6_t10,SubBytes___6_t3);
  SubBytes___6_t3 = XOR(SubBytes___6_t5,SubBytes___6_t3);
  SubBytes___6_t28 = AND(SubBytes___6_t25,SubBytes___6_t27);
  SubBytes___6_t3 = AND(SubBytes___6_t3,SubBytes___6_t30);
  SubBytes___6_t28 = XOR(SubBytes___6_t28,SubBytes___6_t5);
  SubBytes___6_t3 = XOR(SubBytes___6_t3,SubBytes___6_t10);
  SubBytes___6_y7 = AND(SubBytes___6_t28,SubBytes___6_y7);
  SubBytes___6_y2 = AND(SubBytes___6_t28,SubBytes___6_y2);
  SubBytes___6_t8 = XOR(SubBytes___6_t8,SubBytes___6_t3);
  SubBytes___6_t35 = XOR(SubBytes___6_t27,SubBytes___6_t3);
  SubBytes___6_t42 = XOR(SubBytes___6_t28,SubBytes___6_t3);
  SubBytes___6_z2 = AND(SubBytes___6_t3,MixColumn___5__tmp7_);
  SubBytes___6_y4 = AND(SubBytes___6_t3,SubBytes___6_y4);
  SubBytes___6_t10 = AND(SubBytes___6_t10,SubBytes___6_t35);
  SubBytes___6_y11 = AND(SubBytes___6_t42,SubBytes___6_y11);
  SubBytes___6_y9 = AND(SubBytes___6_t42,SubBytes___6_y9);
  SubBytes___6_t8 = XOR(SubBytes___6_t10,SubBytes___6_t8);
  SubBytes___6_t27 = XOR(SubBytes___6_t27,SubBytes___6_t10);
  SubBytes___6_t3 = XOR(SubBytes___6_t3,SubBytes___6_t8);
  SubBytes___6_y6 = AND(SubBytes___6_t8,SubBytes___6_y6);
  SubBytes___6_y3 = AND(SubBytes___6_t8,SubBytes___6_y3);
  SubBytes___6_t27 = AND(SubBytes___6_t28,SubBytes___6_t27);
  SubBytes___6_y15 = AND(SubBytes___6_t3,SubBytes___6_y15);
  SubBytes___6_t3 = AND(SubBytes___6_t3,SubBytes___6_y12);
  SubBytes___6_t25 = XOR(SubBytes___6_t25,SubBytes___6_t27);
  SubBytes___6_z2 = XOR(SubBytes___6_y15,SubBytes___6_z2);
  SubBytes___6_y6 = XOR(SubBytes___6_y6,SubBytes___6_y15);
  SubBytes___6_t8 = XOR(SubBytes___6_t25,SubBytes___6_t8);
  SubBytes___6_t28 = XOR(SubBytes___6_t28,SubBytes___6_t25);
  SubBytes___6_y1 = AND(SubBytes___6_t25,SubBytes___6_y1);
  SubBytes___6_t25 = AND(SubBytes___6_t25,SubBytes___6_y5);
  SubBytes___6_t42 = XOR(SubBytes___6_t42,SubBytes___6_t8);
  SubBytes___6_y10 = AND(SubBytes___6_t8,SubBytes___6_y10);
  SubBytes___6_t8 = AND(SubBytes___6_t8,SubBytes___6_y8);
  SubBytes___6_t0 = AND(SubBytes___6_t28,SubBytes___6_t0);
  SubBytes___6_t28 = AND(SubBytes___6_t28,SubBytes___6_y13);
  SubBytes___6_y17 = AND(SubBytes___6_t42,SubBytes___6_y17);
  SubBytes___6_t42 = AND(SubBytes___6_t42,SubBytes___6_y14);
  SubBytes___6_y1 = XOR(SubBytes___6_t0,SubBytes___6_y1);
  SubBytes___6_t0 = XOR(SubBytes___6_t0,SubBytes___6_y7);
  SubBytes___6_tc7 = XOR(SubBytes___6_t28,SubBytes___6_z2);
  SubBytes___6_t42 = XOR(SubBytes___6_y9,SubBytes___6_t42);
  SubBytes___6_y17 = XOR(SubBytes___6_y17,SubBytes___6_y1);
  SubBytes___6_y1 = XOR(SubBytes___6_y1,SubBytes___6_y6);
  SubBytes___6_z2 = XOR(SubBytes___6_z2,SubBytes___6_t0);
  SubBytes___6_y10 = XOR(SubBytes___6_y10,SubBytes___6_tc7);
  SubBytes___6_y3 = XOR(SubBytes___6_y3,SubBytes___6_t42);
  SubBytes___6_t25 = XOR(SubBytes___6_t25,SubBytes___6_t42);
  SubBytes___6_y11 = XOR(SubBytes___6_y11,SubBytes___6_y17);
  SubBytes___6_y17 = XOR(SubBytes___6_y17,SubBytes___6_y10);
  SubBytes___6_t3 = XOR(SubBytes___6_t3,SubBytes___6_y3);
  SubBytes___6_y3 = XOR(SubBytes___6_y3,SubBytes___6_y4);
  SubBytes___6_t25 = XOR(SubBytes___6_t25,SubBytes___6_z2);
  SubBytes___6_y9 = XOR(SubBytes___6_y9,SubBytes___6_y11);
  SubBytes___6_y2 = XOR(SubBytes___6_y2,SubBytes___6_y17);
  _tmp85_3__ = XOR(SubBytes___6_t3,SubBytes___6_y1);
  _tmp85_0__ = XOR(SubBytes___6_t3,SubBytes___6_y11);
  SubBytes___6_t28 = XOR(SubBytes___6_t28,SubBytes___6_t25);
  SubBytes___6_y17 = XOR(SubBytes___6_y17,SubBytes___6_t25);
  SubBytes___6_y9 = XOR(SubBytes___6_y2,SubBytes___6_y9);
  _tmp85_5__ = XOR(SubBytes___6_y3,SubBytes___6_y2);
  _tmp85_4__ = XOR(SubBytes___6_z2,_tmp85_3__);
  SubBytes___6__tmp3_ = XOR(_tmp85_3__,SubBytes___6_y11);
  _tmp86_3__ = PERMUT_16(_tmp85_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp86_0__ = PERMUT_16(_tmp85_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp85_7__ = NOT(SubBytes___6_t28);
  _tmp85_6__ = NOT(SubBytes___6_y17);
  SubBytes___6_y9 = XOR(SubBytes___6_y9,SubBytes___6_t8);
  _tmp86_5__ = PERMUT_16(_tmp85_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp86_4__ = PERMUT_16(_tmp85_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___6__tmp3_ = NOT(SubBytes___6__tmp3_);
  MixColumn___6__tmp44_ = PERMUT_16(_tmp86_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___6__tmp5_ = PERMUT_16(_tmp86_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp86_7__ = PERMUT_16(_tmp85_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp86_6__ = PERMUT_16(_tmp85_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp85_2__ = NOT(SubBytes___6_y9);
  MixColumn___6__tmp24_ = PERMUT_16(_tmp86_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___6__tmp34_ = PERMUT_16(_tmp86_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp86_1__ = PERMUT_16(SubBytes___6__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp86_3__ = XOR(_tmp86_3__,MixColumn___6__tmp44_);
  _tmp86_0__ = XOR(_tmp86_0__,MixColumn___6__tmp5_);
  MixColumn___6__tmp7_ = PERMUT_16(_tmp86_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___6__tmp17_ = PERMUT_16(_tmp86_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp86_2__ = PERMUT_16(_tmp85_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp86_5__ = XOR(_tmp86_5__,MixColumn___6__tmp24_);
  _tmp86_4__ = XOR(_tmp86_4__,MixColumn___6__tmp34_);
  MixColumn___6__tmp58_ = PERMUT_16(_tmp86_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___6__tmp48_ = PERMUT_16(_tmp86_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___6__tmp69_ = PERMUT_16(_tmp86_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_7__ = XOR(_tmp86_7__,MixColumn___6__tmp7_);
  MixColumn___6__tmp7_ = XOR(_tmp86_0__,MixColumn___6__tmp7_);
  _tmp86_6__ = XOR(_tmp86_6__,MixColumn___6__tmp17_);
  MixColumn___6__tmp51_ = PERMUT_16(_tmp86_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___6__tmp28_ = PERMUT_16(_tmp86_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_5__ = XOR(_tmp86_5__,_tmp86_0__);
  MixColumn___6__tmp38_ = PERMUT_16(_tmp86_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_4__ = XOR(_tmp86_4__,_tmp86_0__);
  _tmp86_1__ = XOR(_tmp86_1__,MixColumn___6__tmp58_);
  MixColumn___6__tmp11_ = PERMUT_16(_tmp86_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_7__ = XOR(_tmp86_7__,_tmp86_0__);
  MixColumn___6__tmp21_ = PERMUT_16(_tmp86_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_6__ = XOR(_tmp86_6__,MixColumn___6__tmp24_);
  _tmp86_2__ = XOR(_tmp86_2__,MixColumn___6__tmp51_);
  _tmp86_3__ = XOR(_tmp86_3__,MixColumn___6__tmp51_);
  _tmp86_5__ = XOR(_tmp86_5__,MixColumn___6__tmp34_);
  _tmp86_4__ = XOR(_tmp86_4__,MixColumn___6__tmp44_);
  MixColumn___6__tmp62_ = PERMUT_16(_tmp86_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_1__ = XOR(_tmp86_1__,MixColumn___6__tmp5_);
  MixColumn___6__tmp7_ = XOR(MixColumn___6__tmp7_,MixColumn___6__tmp11_);
  _tmp86_7__ = XOR(_tmp86_7__,MixColumn___6__tmp17_);
  _tmp86_6__ = XOR(_tmp86_6__,MixColumn___6__tmp28_);
  MixColumn___6__tmp55_ = PERMUT_16(_tmp86_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_2__ = XOR(_tmp86_2__,MixColumn___6__tmp58_);
  _tmp86_5__ = XOR(_tmp86_5__,MixColumn___6__tmp38_);
  _tmp86_4__ = XOR(_tmp86_4__,MixColumn___6__tmp48_);
  _tmp86_1__ = XOR(_tmp86_1__,MixColumn___6__tmp69_);
  MixColumn___6__tmp7_ = XOR(MixColumn___6__tmp7_,key__[6][7]);
  _tmp86_7__ = XOR(_tmp86_7__,MixColumn___6__tmp21_);
  _tmp86_6__ = XOR(_tmp86_6__,key__[6][5]);
  _tmp86_3__ = XOR(_tmp86_3__,MixColumn___6__tmp55_);
  _tmp86_2__ = XOR(_tmp86_2__,MixColumn___6__tmp62_);
  _tmp86_5__ = XOR(_tmp86_5__,key__[6][4]);
  _tmp86_4__ = XOR(_tmp86_4__,key__[6][3]);
  _tmp86_1__ = XOR(_tmp86_1__,key__[6][0]);
  _tmp86_7__ = XOR(_tmp86_7__,key__[6][6]);
  _tmp86_3__ = XOR(_tmp86_3__,key__[6][2]);
  _tmp86_2__ = XOR(_tmp86_2__,key__[6][1]);
  SubBytes___7_y14 = XOR(_tmp86_4__,_tmp86_6__);
  SubBytes___7_y9 = XOR(_tmp86_1__,_tmp86_4__);
  SubBytes___7_y8 = XOR(_tmp86_1__,_tmp86_6__);
  SubBytes___7_y13 = XOR(_tmp86_1__,_tmp86_7__);
  SubBytes___7_t0 = XOR(_tmp86_2__,_tmp86_3__);
  SubBytes___7_y12 = XOR(SubBytes___7_y13,SubBytes___7_y14);
  SubBytes___7_y1 = XOR(SubBytes___7_t0,MixColumn___6__tmp7_);
  SubBytes___7_t1 = XOR(_tmp86_5__,SubBytes___7_y12);
  SubBytes___7_y4 = XOR(SubBytes___7_y1,_tmp86_4__);
  SubBytes___7_y2 = XOR(SubBytes___7_y1,_tmp86_1__);
  SubBytes___7_y5 = XOR(SubBytes___7_y1,_tmp86_7__);
  SubBytes___7_y15 = XOR(SubBytes___7_t1,_tmp86_6__);
  SubBytes___7_t1 = XOR(SubBytes___7_t1,_tmp86_2__);
  SubBytes___7_t5 = AND(SubBytes___7_y4,MixColumn___6__tmp7_);
  SubBytes___7_y3 = XOR(SubBytes___7_y5,SubBytes___7_y8);
  SubBytes___7_t8 = AND(SubBytes___7_y5,SubBytes___7_y1);
  SubBytes___7_y6 = XOR(SubBytes___7_y15,MixColumn___6__tmp7_);
  SubBytes___7_y10 = XOR(SubBytes___7_y15,SubBytes___7_t0);
  SubBytes___7_t2 = AND(SubBytes___7_y12,SubBytes___7_y15);
  SubBytes___7_y11 = XOR(SubBytes___7_t1,SubBytes___7_y9);
  SubBytes___7_t3 = AND(SubBytes___7_y3,SubBytes___7_y6);
  SubBytes___7_y19 = XOR(SubBytes___7_y10,SubBytes___7_y8);
  SubBytes___7_t15 = AND(SubBytes___7_y8,SubBytes___7_y10);
  SubBytes___7_t5 = XOR(SubBytes___7_t5,SubBytes___7_t2);
  SubBytes___7_y7 = XOR(MixColumn___6__tmp7_,SubBytes___7_y11);
  SubBytes___7_y17 = XOR(SubBytes___7_y10,SubBytes___7_y11);
  SubBytes___7_t0 = XOR(SubBytes___7_t0,SubBytes___7_y11);
  SubBytes___7_t12 = AND(SubBytes___7_y9,SubBytes___7_y11);
  SubBytes___7_t3 = XOR(SubBytes___7_t3,SubBytes___7_t2);
  SubBytes___7_t10 = AND(SubBytes___7_y2,SubBytes___7_y7);
  SubBytes___7_t13 = AND(SubBytes___7_y14,SubBytes___7_y17);
  SubBytes___7_y21 = XOR(SubBytes___7_y13,SubBytes___7_t0);
  SubBytes___7_y18 = XOR(_tmp86_1__,SubBytes___7_t0);
  SubBytes___7_t7 = AND(SubBytes___7_y13,SubBytes___7_t0);
  SubBytes___7_t15 = XOR(SubBytes___7_t15,SubBytes___7_t12);
  SubBytes___7_t3 = XOR(SubBytes___7_t3,SubBytes___7_t1);
  SubBytes___7_t13 = XOR(SubBytes___7_t13,SubBytes___7_t12);
  SubBytes___7_t8 = XOR(SubBytes___7_t8,SubBytes___7_t7);
  SubBytes___7_t10 = XOR(SubBytes___7_t10,SubBytes___7_t7);
  SubBytes___7_t5 = XOR(SubBytes___7_t5,SubBytes___7_t15);
  SubBytes___7_t3 = XOR(SubBytes___7_t3,SubBytes___7_t13);
  SubBytes___7_t8 = XOR(SubBytes___7_t8,SubBytes___7_t13);
  SubBytes___7_t10 = XOR(SubBytes___7_t10,SubBytes___7_t15);
  SubBytes___7_t5 = XOR(SubBytes___7_t5,SubBytes___7_y19);
  SubBytes___7_t8 = XOR(SubBytes___7_t8,SubBytes___7_y21);
  SubBytes___7_t10 = XOR(SubBytes___7_t10,SubBytes___7_y18);
  SubBytes___7_t25 = XOR(SubBytes___7_t3,SubBytes___7_t5);
  SubBytes___7_t3 = AND(SubBytes___7_t3,SubBytes___7_t8);
  SubBytes___7_t30 = XOR(SubBytes___7_t8,SubBytes___7_t10);
  SubBytes___7_t27 = XOR(SubBytes___7_t10,SubBytes___7_t3);
  SubBytes___7_t3 = XOR(SubBytes___7_t5,SubBytes___7_t3);
  SubBytes___7_t28 = AND(SubBytes___7_t25,SubBytes___7_t27);
  SubBytes___7_t3 = AND(SubBytes___7_t3,SubBytes___7_t30);
  SubBytes___7_t28 = XOR(SubBytes___7_t28,SubBytes___7_t5);
  SubBytes___7_t3 = XOR(SubBytes___7_t3,SubBytes___7_t10);
  SubBytes___7_y7 = AND(SubBytes___7_t28,SubBytes___7_y7);
  SubBytes___7_y2 = AND(SubBytes___7_t28,SubBytes___7_y2);
  SubBytes___7_t8 = XOR(SubBytes___7_t8,SubBytes___7_t3);
  SubBytes___7_t35 = XOR(SubBytes___7_t27,SubBytes___7_t3);
  SubBytes___7_t42 = XOR(SubBytes___7_t28,SubBytes___7_t3);
  SubBytes___7_z2 = AND(SubBytes___7_t3,MixColumn___6__tmp7_);
  SubBytes___7_y4 = AND(SubBytes___7_t3,SubBytes___7_y4);
  SubBytes___7_t10 = AND(SubBytes___7_t10,SubBytes___7_t35);
  SubBytes___7_y11 = AND(SubBytes___7_t42,SubBytes___7_y11);
  SubBytes___7_y9 = AND(SubBytes___7_t42,SubBytes___7_y9);
  SubBytes___7_t8 = XOR(SubBytes___7_t10,SubBytes___7_t8);
  SubBytes___7_t27 = XOR(SubBytes___7_t27,SubBytes___7_t10);
  SubBytes___7_t3 = XOR(SubBytes___7_t3,SubBytes___7_t8);
  SubBytes___7_y6 = AND(SubBytes___7_t8,SubBytes___7_y6);
  SubBytes___7_y3 = AND(SubBytes___7_t8,SubBytes___7_y3);
  SubBytes___7_t27 = AND(SubBytes___7_t28,SubBytes___7_t27);
  SubBytes___7_y15 = AND(SubBytes___7_t3,SubBytes___7_y15);
  SubBytes___7_t3 = AND(SubBytes___7_t3,SubBytes___7_y12);
  SubBytes___7_t25 = XOR(SubBytes___7_t25,SubBytes___7_t27);
  SubBytes___7_z2 = XOR(SubBytes___7_y15,SubBytes___7_z2);
  SubBytes___7_y6 = XOR(SubBytes___7_y6,SubBytes___7_y15);
  SubBytes___7_t8 = XOR(SubBytes___7_t25,SubBytes___7_t8);
  SubBytes___7_t28 = XOR(SubBytes___7_t28,SubBytes___7_t25);
  SubBytes___7_y1 = AND(SubBytes___7_t25,SubBytes___7_y1);
  SubBytes___7_t25 = AND(SubBytes___7_t25,SubBytes___7_y5);
  SubBytes___7_t42 = XOR(SubBytes___7_t42,SubBytes___7_t8);
  SubBytes___7_y10 = AND(SubBytes___7_t8,SubBytes___7_y10);
  SubBytes___7_t8 = AND(SubBytes___7_t8,SubBytes___7_y8);
  SubBytes___7_t0 = AND(SubBytes___7_t28,SubBytes___7_t0);
  SubBytes___7_t28 = AND(SubBytes___7_t28,SubBytes___7_y13);
  SubBytes___7_y17 = AND(SubBytes___7_t42,SubBytes___7_y17);
  SubBytes___7_t42 = AND(SubBytes___7_t42,SubBytes___7_y14);
  SubBytes___7_y1 = XOR(SubBytes___7_t0,SubBytes___7_y1);
  SubBytes___7_t0 = XOR(SubBytes___7_t0,SubBytes___7_y7);
  SubBytes___7_tc7 = XOR(SubBytes___7_t28,SubBytes___7_z2);
  SubBytes___7_t42 = XOR(SubBytes___7_y9,SubBytes___7_t42);
  SubBytes___7_y17 = XOR(SubBytes___7_y17,SubBytes___7_y1);
  SubBytes___7_y1 = XOR(SubBytes___7_y1,SubBytes___7_y6);
  SubBytes___7_z2 = XOR(SubBytes___7_z2,SubBytes___7_t0);
  SubBytes___7_y10 = XOR(SubBytes___7_y10,SubBytes___7_tc7);
  SubBytes___7_y3 = XOR(SubBytes___7_y3,SubBytes___7_t42);
  SubBytes___7_t25 = XOR(SubBytes___7_t25,SubBytes___7_t42);
  SubBytes___7_y11 = XOR(SubBytes___7_y11,SubBytes___7_y17);
  SubBytes___7_y17 = XOR(SubBytes___7_y17,SubBytes___7_y10);
  SubBytes___7_t3 = XOR(SubBytes___7_t3,SubBytes___7_y3);
  SubBytes___7_y3 = XOR(SubBytes___7_y3,SubBytes___7_y4);
  SubBytes___7_t25 = XOR(SubBytes___7_t25,SubBytes___7_z2);
  SubBytes___7_y9 = XOR(SubBytes___7_y9,SubBytes___7_y11);
  SubBytes___7_y2 = XOR(SubBytes___7_y2,SubBytes___7_y17);
  _tmp88_3__ = XOR(SubBytes___7_t3,SubBytes___7_y1);
  _tmp88_0__ = XOR(SubBytes___7_t3,SubBytes___7_y11);
  SubBytes___7_t28 = XOR(SubBytes___7_t28,SubBytes___7_t25);
  SubBytes___7_y17 = XOR(SubBytes___7_y17,SubBytes___7_t25);
  SubBytes___7_y9 = XOR(SubBytes___7_y2,SubBytes___7_y9);
  _tmp88_5__ = XOR(SubBytes___7_y3,SubBytes___7_y2);
  _tmp88_4__ = XOR(SubBytes___7_z2,_tmp88_3__);
  SubBytes___7__tmp3_ = XOR(_tmp88_3__,SubBytes___7_y11);
  _tmp89_3__ = PERMUT_16(_tmp88_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp89_0__ = PERMUT_16(_tmp88_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp88_7__ = NOT(SubBytes___7_t28);
  _tmp88_6__ = NOT(SubBytes___7_y17);
  SubBytes___7_y9 = XOR(SubBytes___7_y9,SubBytes___7_t8);
  _tmp89_5__ = PERMUT_16(_tmp88_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp89_4__ = PERMUT_16(_tmp88_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___7__tmp3_ = NOT(SubBytes___7__tmp3_);
  MixColumn___7__tmp44_ = PERMUT_16(_tmp89_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___7__tmp5_ = PERMUT_16(_tmp89_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp89_7__ = PERMUT_16(_tmp88_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp89_6__ = PERMUT_16(_tmp88_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp88_2__ = NOT(SubBytes___7_y9);
  MixColumn___7__tmp24_ = PERMUT_16(_tmp89_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___7__tmp34_ = PERMUT_16(_tmp89_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp89_1__ = PERMUT_16(SubBytes___7__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp89_3__ = XOR(_tmp89_3__,MixColumn___7__tmp44_);
  _tmp89_0__ = XOR(_tmp89_0__,MixColumn___7__tmp5_);
  MixColumn___7__tmp7_ = PERMUT_16(_tmp89_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___7__tmp17_ = PERMUT_16(_tmp89_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp89_2__ = PERMUT_16(_tmp88_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp89_5__ = XOR(_tmp89_5__,MixColumn___7__tmp24_);
  _tmp89_4__ = XOR(_tmp89_4__,MixColumn___7__tmp34_);
  MixColumn___7__tmp58_ = PERMUT_16(_tmp89_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___7__tmp48_ = PERMUT_16(_tmp89_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___7__tmp69_ = PERMUT_16(_tmp89_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_7__ = XOR(_tmp89_7__,MixColumn___7__tmp7_);
  MixColumn___7__tmp7_ = XOR(_tmp89_0__,MixColumn___7__tmp7_);
  _tmp89_6__ = XOR(_tmp89_6__,MixColumn___7__tmp17_);
  MixColumn___7__tmp51_ = PERMUT_16(_tmp89_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___7__tmp28_ = PERMUT_16(_tmp89_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_5__ = XOR(_tmp89_5__,_tmp89_0__);
  MixColumn___7__tmp38_ = PERMUT_16(_tmp89_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_4__ = XOR(_tmp89_4__,_tmp89_0__);
  _tmp89_1__ = XOR(_tmp89_1__,MixColumn___7__tmp58_);
  MixColumn___7__tmp11_ = PERMUT_16(_tmp89_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_7__ = XOR(_tmp89_7__,_tmp89_0__);
  MixColumn___7__tmp21_ = PERMUT_16(_tmp89_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_6__ = XOR(_tmp89_6__,MixColumn___7__tmp24_);
  _tmp89_2__ = XOR(_tmp89_2__,MixColumn___7__tmp51_);
  _tmp89_3__ = XOR(_tmp89_3__,MixColumn___7__tmp51_);
  _tmp89_5__ = XOR(_tmp89_5__,MixColumn___7__tmp34_);
  _tmp89_4__ = XOR(_tmp89_4__,MixColumn___7__tmp44_);
  MixColumn___7__tmp62_ = PERMUT_16(_tmp89_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_1__ = XOR(_tmp89_1__,MixColumn___7__tmp5_);
  MixColumn___7__tmp7_ = XOR(MixColumn___7__tmp7_,MixColumn___7__tmp11_);
  _tmp89_7__ = XOR(_tmp89_7__,MixColumn___7__tmp17_);
  _tmp89_6__ = XOR(_tmp89_6__,MixColumn___7__tmp28_);
  MixColumn___7__tmp55_ = PERMUT_16(_tmp89_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_2__ = XOR(_tmp89_2__,MixColumn___7__tmp58_);
  _tmp89_5__ = XOR(_tmp89_5__,MixColumn___7__tmp38_);
  _tmp89_4__ = XOR(_tmp89_4__,MixColumn___7__tmp48_);
  _tmp89_1__ = XOR(_tmp89_1__,MixColumn___7__tmp69_);
  MixColumn___7__tmp7_ = XOR(MixColumn___7__tmp7_,key__[7][7]);
  _tmp89_7__ = XOR(_tmp89_7__,MixColumn___7__tmp21_);
  _tmp89_6__ = XOR(_tmp89_6__,key__[7][5]);
  _tmp89_3__ = XOR(_tmp89_3__,MixColumn___7__tmp55_);
  _tmp89_2__ = XOR(_tmp89_2__,MixColumn___7__tmp62_);
  _tmp89_5__ = XOR(_tmp89_5__,key__[7][4]);
  _tmp89_4__ = XOR(_tmp89_4__,key__[7][3]);
  _tmp89_1__ = XOR(_tmp89_1__,key__[7][0]);
  _tmp89_7__ = XOR(_tmp89_7__,key__[7][6]);
  _tmp89_3__ = XOR(_tmp89_3__,key__[7][2]);
  _tmp89_2__ = XOR(_tmp89_2__,key__[7][1]);
  SubBytes___8_y14 = XOR(_tmp89_4__,_tmp89_6__);
  SubBytes___8_y9 = XOR(_tmp89_1__,_tmp89_4__);
  SubBytes___8_y8 = XOR(_tmp89_1__,_tmp89_6__);
  SubBytes___8_y13 = XOR(_tmp89_1__,_tmp89_7__);
  SubBytes___8_t0 = XOR(_tmp89_2__,_tmp89_3__);
  SubBytes___8_y12 = XOR(SubBytes___8_y13,SubBytes___8_y14);
  SubBytes___8_y1 = XOR(SubBytes___8_t0,MixColumn___7__tmp7_);
  SubBytes___8_t1 = XOR(_tmp89_5__,SubBytes___8_y12);
  SubBytes___8_y4 = XOR(SubBytes___8_y1,_tmp89_4__);
  SubBytes___8_y2 = XOR(SubBytes___8_y1,_tmp89_1__);
  SubBytes___8_y5 = XOR(SubBytes___8_y1,_tmp89_7__);
  SubBytes___8_y15 = XOR(SubBytes___8_t1,_tmp89_6__);
  SubBytes___8_t1 = XOR(SubBytes___8_t1,_tmp89_2__);
  SubBytes___8_t5 = AND(SubBytes___8_y4,MixColumn___7__tmp7_);
  SubBytes___8_y3 = XOR(SubBytes___8_y5,SubBytes___8_y8);
  SubBytes___8_t8 = AND(SubBytes___8_y5,SubBytes___8_y1);
  SubBytes___8_y6 = XOR(SubBytes___8_y15,MixColumn___7__tmp7_);
  SubBytes___8_y10 = XOR(SubBytes___8_y15,SubBytes___8_t0);
  SubBytes___8_t2 = AND(SubBytes___8_y12,SubBytes___8_y15);
  SubBytes___8_y11 = XOR(SubBytes___8_t1,SubBytes___8_y9);
  SubBytes___8_t3 = AND(SubBytes___8_y3,SubBytes___8_y6);
  SubBytes___8_y19 = XOR(SubBytes___8_y10,SubBytes___8_y8);
  SubBytes___8_t15 = AND(SubBytes___8_y8,SubBytes___8_y10);
  SubBytes___8_t5 = XOR(SubBytes___8_t5,SubBytes___8_t2);
  SubBytes___8_y7 = XOR(MixColumn___7__tmp7_,SubBytes___8_y11);
  SubBytes___8_y17 = XOR(SubBytes___8_y10,SubBytes___8_y11);
  SubBytes___8_t0 = XOR(SubBytes___8_t0,SubBytes___8_y11);
  SubBytes___8_t12 = AND(SubBytes___8_y9,SubBytes___8_y11);
  SubBytes___8_t3 = XOR(SubBytes___8_t3,SubBytes___8_t2);
  SubBytes___8_t10 = AND(SubBytes___8_y2,SubBytes___8_y7);
  SubBytes___8_t13 = AND(SubBytes___8_y14,SubBytes___8_y17);
  SubBytes___8_y21 = XOR(SubBytes___8_y13,SubBytes___8_t0);
  SubBytes___8_y18 = XOR(_tmp89_1__,SubBytes___8_t0);
  SubBytes___8_t7 = AND(SubBytes___8_y13,SubBytes___8_t0);
  SubBytes___8_t15 = XOR(SubBytes___8_t15,SubBytes___8_t12);
  SubBytes___8_t3 = XOR(SubBytes___8_t3,SubBytes___8_t1);
  SubBytes___8_t13 = XOR(SubBytes___8_t13,SubBytes___8_t12);
  SubBytes___8_t8 = XOR(SubBytes___8_t8,SubBytes___8_t7);
  SubBytes___8_t10 = XOR(SubBytes___8_t10,SubBytes___8_t7);
  SubBytes___8_t5 = XOR(SubBytes___8_t5,SubBytes___8_t15);
  SubBytes___8_t3 = XOR(SubBytes___8_t3,SubBytes___8_t13);
  SubBytes___8_t8 = XOR(SubBytes___8_t8,SubBytes___8_t13);
  SubBytes___8_t10 = XOR(SubBytes___8_t10,SubBytes___8_t15);
  SubBytes___8_t5 = XOR(SubBytes___8_t5,SubBytes___8_y19);
  SubBytes___8_t8 = XOR(SubBytes___8_t8,SubBytes___8_y21);
  SubBytes___8_t10 = XOR(SubBytes___8_t10,SubBytes___8_y18);
  SubBytes___8_t25 = XOR(SubBytes___8_t3,SubBytes___8_t5);
  SubBytes___8_t3 = AND(SubBytes___8_t3,SubBytes___8_t8);
  SubBytes___8_t30 = XOR(SubBytes___8_t8,SubBytes___8_t10);
  SubBytes___8_t27 = XOR(SubBytes___8_t10,SubBytes___8_t3);
  SubBytes___8_t3 = XOR(SubBytes___8_t5,SubBytes___8_t3);
  SubBytes___8_t28 = AND(SubBytes___8_t25,SubBytes___8_t27);
  SubBytes___8_t3 = AND(SubBytes___8_t3,SubBytes___8_t30);
  SubBytes___8_t28 = XOR(SubBytes___8_t28,SubBytes___8_t5);
  SubBytes___8_t3 = XOR(SubBytes___8_t3,SubBytes___8_t10);
  SubBytes___8_y7 = AND(SubBytes___8_t28,SubBytes___8_y7);
  SubBytes___8_y2 = AND(SubBytes___8_t28,SubBytes___8_y2);
  SubBytes___8_t8 = XOR(SubBytes___8_t8,SubBytes___8_t3);
  SubBytes___8_t35 = XOR(SubBytes___8_t27,SubBytes___8_t3);
  SubBytes___8_t42 = XOR(SubBytes___8_t28,SubBytes___8_t3);
  SubBytes___8_z2 = AND(SubBytes___8_t3,MixColumn___7__tmp7_);
  SubBytes___8_y4 = AND(SubBytes___8_t3,SubBytes___8_y4);
  SubBytes___8_t10 = AND(SubBytes___8_t10,SubBytes___8_t35);
  SubBytes___8_y11 = AND(SubBytes___8_t42,SubBytes___8_y11);
  SubBytes___8_y9 = AND(SubBytes___8_t42,SubBytes___8_y9);
  SubBytes___8_t8 = XOR(SubBytes___8_t10,SubBytes___8_t8);
  SubBytes___8_t27 = XOR(SubBytes___8_t27,SubBytes___8_t10);
  SubBytes___8_t3 = XOR(SubBytes___8_t3,SubBytes___8_t8);
  SubBytes___8_y6 = AND(SubBytes___8_t8,SubBytes___8_y6);
  SubBytes___8_y3 = AND(SubBytes___8_t8,SubBytes___8_y3);
  SubBytes___8_t27 = AND(SubBytes___8_t28,SubBytes___8_t27);
  SubBytes___8_y15 = AND(SubBytes___8_t3,SubBytes___8_y15);
  SubBytes___8_t3 = AND(SubBytes___8_t3,SubBytes___8_y12);
  SubBytes___8_t25 = XOR(SubBytes___8_t25,SubBytes___8_t27);
  SubBytes___8_z2 = XOR(SubBytes___8_y15,SubBytes___8_z2);
  SubBytes___8_y6 = XOR(SubBytes___8_y6,SubBytes___8_y15);
  SubBytes___8_t8 = XOR(SubBytes___8_t25,SubBytes___8_t8);
  SubBytes___8_t28 = XOR(SubBytes___8_t28,SubBytes___8_t25);
  SubBytes___8_y1 = AND(SubBytes___8_t25,SubBytes___8_y1);
  SubBytes___8_t25 = AND(SubBytes___8_t25,SubBytes___8_y5);
  SubBytes___8_t42 = XOR(SubBytes___8_t42,SubBytes___8_t8);
  SubBytes___8_y10 = AND(SubBytes___8_t8,SubBytes___8_y10);
  SubBytes___8_t8 = AND(SubBytes___8_t8,SubBytes___8_y8);
  SubBytes___8_t0 = AND(SubBytes___8_t28,SubBytes___8_t0);
  SubBytes___8_t28 = AND(SubBytes___8_t28,SubBytes___8_y13);
  SubBytes___8_y17 = AND(SubBytes___8_t42,SubBytes___8_y17);
  SubBytes___8_t42 = AND(SubBytes___8_t42,SubBytes___8_y14);
  SubBytes___8_y1 = XOR(SubBytes___8_t0,SubBytes___8_y1);
  SubBytes___8_t0 = XOR(SubBytes___8_t0,SubBytes___8_y7);
  SubBytes___8_tc7 = XOR(SubBytes___8_t28,SubBytes___8_z2);
  SubBytes___8_t42 = XOR(SubBytes___8_y9,SubBytes___8_t42);
  SubBytes___8_y17 = XOR(SubBytes___8_y17,SubBytes___8_y1);
  SubBytes___8_y1 = XOR(SubBytes___8_y1,SubBytes___8_y6);
  SubBytes___8_z2 = XOR(SubBytes___8_z2,SubBytes___8_t0);
  SubBytes___8_y10 = XOR(SubBytes___8_y10,SubBytes___8_tc7);
  SubBytes___8_y3 = XOR(SubBytes___8_y3,SubBytes___8_t42);
  SubBytes___8_t25 = XOR(SubBytes___8_t25,SubBytes___8_t42);
  SubBytes___8_y11 = XOR(SubBytes___8_y11,SubBytes___8_y17);
  SubBytes___8_y17 = XOR(SubBytes___8_y17,SubBytes___8_y10);
  SubBytes___8_t3 = XOR(SubBytes___8_t3,SubBytes___8_y3);
  SubBytes___8_y3 = XOR(SubBytes___8_y3,SubBytes___8_y4);
  SubBytes___8_t25 = XOR(SubBytes___8_t25,SubBytes___8_z2);
  SubBytes___8_y9 = XOR(SubBytes___8_y9,SubBytes___8_y11);
  SubBytes___8_y2 = XOR(SubBytes___8_y2,SubBytes___8_y17);
  _tmp91_3__ = XOR(SubBytes___8_t3,SubBytes___8_y1);
  _tmp91_0__ = XOR(SubBytes___8_t3,SubBytes___8_y11);
  SubBytes___8_t28 = XOR(SubBytes___8_t28,SubBytes___8_t25);
  SubBytes___8_y17 = XOR(SubBytes___8_y17,SubBytes___8_t25);
  SubBytes___8_y9 = XOR(SubBytes___8_y2,SubBytes___8_y9);
  _tmp91_5__ = XOR(SubBytes___8_y3,SubBytes___8_y2);
  _tmp91_4__ = XOR(SubBytes___8_z2,_tmp91_3__);
  SubBytes___8__tmp3_ = XOR(_tmp91_3__,SubBytes___8_y11);
  _tmp92_3__ = PERMUT_16(_tmp91_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp92_0__ = PERMUT_16(_tmp91_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp91_7__ = NOT(SubBytes___8_t28);
  _tmp91_6__ = NOT(SubBytes___8_y17);
  SubBytes___8_y9 = XOR(SubBytes___8_y9,SubBytes___8_t8);
  _tmp92_5__ = PERMUT_16(_tmp91_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp92_4__ = PERMUT_16(_tmp91_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___8__tmp3_ = NOT(SubBytes___8__tmp3_);
  MixColumn___8__tmp44_ = PERMUT_16(_tmp92_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___8__tmp5_ = PERMUT_16(_tmp92_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp92_7__ = PERMUT_16(_tmp91_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp92_6__ = PERMUT_16(_tmp91_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp91_2__ = NOT(SubBytes___8_y9);
  MixColumn___8__tmp24_ = PERMUT_16(_tmp92_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___8__tmp34_ = PERMUT_16(_tmp92_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp92_1__ = PERMUT_16(SubBytes___8__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp92_3__ = XOR(_tmp92_3__,MixColumn___8__tmp44_);
  _tmp92_0__ = XOR(_tmp92_0__,MixColumn___8__tmp5_);
  MixColumn___8__tmp7_ = PERMUT_16(_tmp92_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___8__tmp17_ = PERMUT_16(_tmp92_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp92_2__ = PERMUT_16(_tmp91_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp92_5__ = XOR(_tmp92_5__,MixColumn___8__tmp24_);
  _tmp92_4__ = XOR(_tmp92_4__,MixColumn___8__tmp34_);
  MixColumn___8__tmp58_ = PERMUT_16(_tmp92_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___8__tmp48_ = PERMUT_16(_tmp92_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___8__tmp69_ = PERMUT_16(_tmp92_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_7__ = XOR(_tmp92_7__,MixColumn___8__tmp7_);
  MixColumn___8__tmp7_ = XOR(_tmp92_0__,MixColumn___8__tmp7_);
  _tmp92_6__ = XOR(_tmp92_6__,MixColumn___8__tmp17_);
  MixColumn___8__tmp51_ = PERMUT_16(_tmp92_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___8__tmp28_ = PERMUT_16(_tmp92_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_5__ = XOR(_tmp92_5__,_tmp92_0__);
  MixColumn___8__tmp38_ = PERMUT_16(_tmp92_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_4__ = XOR(_tmp92_4__,_tmp92_0__);
  _tmp92_1__ = XOR(_tmp92_1__,MixColumn___8__tmp58_);
  MixColumn___8__tmp11_ = PERMUT_16(_tmp92_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_7__ = XOR(_tmp92_7__,_tmp92_0__);
  MixColumn___8__tmp21_ = PERMUT_16(_tmp92_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_6__ = XOR(_tmp92_6__,MixColumn___8__tmp24_);
  _tmp92_2__ = XOR(_tmp92_2__,MixColumn___8__tmp51_);
  _tmp92_3__ = XOR(_tmp92_3__,MixColumn___8__tmp51_);
  _tmp92_5__ = XOR(_tmp92_5__,MixColumn___8__tmp34_);
  _tmp92_4__ = XOR(_tmp92_4__,MixColumn___8__tmp44_);
  MixColumn___8__tmp62_ = PERMUT_16(_tmp92_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_1__ = XOR(_tmp92_1__,MixColumn___8__tmp5_);
  MixColumn___8__tmp7_ = XOR(MixColumn___8__tmp7_,MixColumn___8__tmp11_);
  _tmp92_7__ = XOR(_tmp92_7__,MixColumn___8__tmp17_);
  _tmp92_6__ = XOR(_tmp92_6__,MixColumn___8__tmp28_);
  MixColumn___8__tmp55_ = PERMUT_16(_tmp92_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_2__ = XOR(_tmp92_2__,MixColumn___8__tmp58_);
  _tmp92_5__ = XOR(_tmp92_5__,MixColumn___8__tmp38_);
  _tmp92_4__ = XOR(_tmp92_4__,MixColumn___8__tmp48_);
  _tmp92_1__ = XOR(_tmp92_1__,MixColumn___8__tmp69_);
  MixColumn___8__tmp7_ = XOR(MixColumn___8__tmp7_,key__[8][7]);
  _tmp92_7__ = XOR(_tmp92_7__,MixColumn___8__tmp21_);
  _tmp92_6__ = XOR(_tmp92_6__,key__[8][5]);
  _tmp92_3__ = XOR(_tmp92_3__,MixColumn___8__tmp55_);
  _tmp92_2__ = XOR(_tmp92_2__,MixColumn___8__tmp62_);
  _tmp92_5__ = XOR(_tmp92_5__,key__[8][4]);
  _tmp92_4__ = XOR(_tmp92_4__,key__[8][3]);
  _tmp92_1__ = XOR(_tmp92_1__,key__[8][0]);
  _tmp92_7__ = XOR(_tmp92_7__,key__[8][6]);
  _tmp92_3__ = XOR(_tmp92_3__,key__[8][2]);
  _tmp92_2__ = XOR(_tmp92_2__,key__[8][1]);
  SubBytes___9_y14 = XOR(_tmp92_4__,_tmp92_6__);
  SubBytes___9_y9 = XOR(_tmp92_1__,_tmp92_4__);
  SubBytes___9_y8 = XOR(_tmp92_1__,_tmp92_6__);
  SubBytes___9_y13 = XOR(_tmp92_1__,_tmp92_7__);
  SubBytes___9_t0 = XOR(_tmp92_2__,_tmp92_3__);
  SubBytes___9_y12 = XOR(SubBytes___9_y13,SubBytes___9_y14);
  SubBytes___9_y1 = XOR(SubBytes___9_t0,MixColumn___8__tmp7_);
  SubBytes___9_t1 = XOR(_tmp92_5__,SubBytes___9_y12);
  SubBytes___9_y4 = XOR(SubBytes___9_y1,_tmp92_4__);
  SubBytes___9_y2 = XOR(SubBytes___9_y1,_tmp92_1__);
  SubBytes___9_y5 = XOR(SubBytes___9_y1,_tmp92_7__);
  SubBytes___9_y15 = XOR(SubBytes___9_t1,_tmp92_6__);
  SubBytes___9_t1 = XOR(SubBytes___9_t1,_tmp92_2__);
  SubBytes___9_t5 = AND(SubBytes___9_y4,MixColumn___8__tmp7_);
  SubBytes___9_y3 = XOR(SubBytes___9_y5,SubBytes___9_y8);
  SubBytes___9_t8 = AND(SubBytes___9_y5,SubBytes___9_y1);
  SubBytes___9_y6 = XOR(SubBytes___9_y15,MixColumn___8__tmp7_);
  SubBytes___9_y10 = XOR(SubBytes___9_y15,SubBytes___9_t0);
  SubBytes___9_t2 = AND(SubBytes___9_y12,SubBytes___9_y15);
  SubBytes___9_y11 = XOR(SubBytes___9_t1,SubBytes___9_y9);
  SubBytes___9_t3 = AND(SubBytes___9_y3,SubBytes___9_y6);
  SubBytes___9_y19 = XOR(SubBytes___9_y10,SubBytes___9_y8);
  SubBytes___9_t15 = AND(SubBytes___9_y8,SubBytes___9_y10);
  SubBytes___9_t5 = XOR(SubBytes___9_t5,SubBytes___9_t2);
  SubBytes___9_y7 = XOR(MixColumn___8__tmp7_,SubBytes___9_y11);
  SubBytes___9_y17 = XOR(SubBytes___9_y10,SubBytes___9_y11);
  SubBytes___9_t0 = XOR(SubBytes___9_t0,SubBytes___9_y11);
  SubBytes___9_t12 = AND(SubBytes___9_y9,SubBytes___9_y11);
  SubBytes___9_t3 = XOR(SubBytes___9_t3,SubBytes___9_t2);
  SubBytes___9_t10 = AND(SubBytes___9_y2,SubBytes___9_y7);
  SubBytes___9_t13 = AND(SubBytes___9_y14,SubBytes___9_y17);
  SubBytes___9_y21 = XOR(SubBytes___9_y13,SubBytes___9_t0);
  SubBytes___9_y18 = XOR(_tmp92_1__,SubBytes___9_t0);
  SubBytes___9_t7 = AND(SubBytes___9_y13,SubBytes___9_t0);
  SubBytes___9_t15 = XOR(SubBytes___9_t15,SubBytes___9_t12);
  SubBytes___9_t3 = XOR(SubBytes___9_t3,SubBytes___9_t1);
  SubBytes___9_t13 = XOR(SubBytes___9_t13,SubBytes___9_t12);
  SubBytes___9_t8 = XOR(SubBytes___9_t8,SubBytes___9_t7);
  SubBytes___9_t10 = XOR(SubBytes___9_t10,SubBytes___9_t7);
  SubBytes___9_t5 = XOR(SubBytes___9_t5,SubBytes___9_t15);
  SubBytes___9_t3 = XOR(SubBytes___9_t3,SubBytes___9_t13);
  SubBytes___9_t8 = XOR(SubBytes___9_t8,SubBytes___9_t13);
  SubBytes___9_t10 = XOR(SubBytes___9_t10,SubBytes___9_t15);
  SubBytes___9_t5 = XOR(SubBytes___9_t5,SubBytes___9_y19);
  SubBytes___9_t8 = XOR(SubBytes___9_t8,SubBytes___9_y21);
  SubBytes___9_t10 = XOR(SubBytes___9_t10,SubBytes___9_y18);
  SubBytes___9_t25 = XOR(SubBytes___9_t3,SubBytes___9_t5);
  SubBytes___9_t3 = AND(SubBytes___9_t3,SubBytes___9_t8);
  SubBytes___9_t30 = XOR(SubBytes___9_t8,SubBytes___9_t10);
  SubBytes___9_t27 = XOR(SubBytes___9_t10,SubBytes___9_t3);
  SubBytes___9_t3 = XOR(SubBytes___9_t5,SubBytes___9_t3);
  SubBytes___9_t28 = AND(SubBytes___9_t25,SubBytes___9_t27);
  SubBytes___9_t3 = AND(SubBytes___9_t3,SubBytes___9_t30);
  SubBytes___9_t28 = XOR(SubBytes___9_t28,SubBytes___9_t5);
  SubBytes___9_t3 = XOR(SubBytes___9_t3,SubBytes___9_t10);
  SubBytes___9_y7 = AND(SubBytes___9_t28,SubBytes___9_y7);
  SubBytes___9_y2 = AND(SubBytes___9_t28,SubBytes___9_y2);
  SubBytes___9_t8 = XOR(SubBytes___9_t8,SubBytes___9_t3);
  SubBytes___9_t35 = XOR(SubBytes___9_t27,SubBytes___9_t3);
  SubBytes___9_t42 = XOR(SubBytes___9_t28,SubBytes___9_t3);
  SubBytes___9_z2 = AND(SubBytes___9_t3,MixColumn___8__tmp7_);
  SubBytes___9_y4 = AND(SubBytes___9_t3,SubBytes___9_y4);
  SubBytes___9_t10 = AND(SubBytes___9_t10,SubBytes___9_t35);
  SubBytes___9_y11 = AND(SubBytes___9_t42,SubBytes___9_y11);
  SubBytes___9_y9 = AND(SubBytes___9_t42,SubBytes___9_y9);
  SubBytes___9_t8 = XOR(SubBytes___9_t10,SubBytes___9_t8);
  SubBytes___9_t27 = XOR(SubBytes___9_t27,SubBytes___9_t10);
  SubBytes___9_t3 = XOR(SubBytes___9_t3,SubBytes___9_t8);
  SubBytes___9_y6 = AND(SubBytes___9_t8,SubBytes___9_y6);
  SubBytes___9_y3 = AND(SubBytes___9_t8,SubBytes___9_y3);
  SubBytes___9_t27 = AND(SubBytes___9_t28,SubBytes___9_t27);
  SubBytes___9_y15 = AND(SubBytes___9_t3,SubBytes___9_y15);
  SubBytes___9_t3 = AND(SubBytes___9_t3,SubBytes___9_y12);
  SubBytes___9_t25 = XOR(SubBytes___9_t25,SubBytes___9_t27);
  SubBytes___9_z2 = XOR(SubBytes___9_y15,SubBytes___9_z2);
  SubBytes___9_y6 = XOR(SubBytes___9_y6,SubBytes___9_y15);
  SubBytes___9_t8 = XOR(SubBytes___9_t25,SubBytes___9_t8);
  SubBytes___9_t28 = XOR(SubBytes___9_t28,SubBytes___9_t25);
  SubBytes___9_y1 = AND(SubBytes___9_t25,SubBytes___9_y1);
  SubBytes___9_t25 = AND(SubBytes___9_t25,SubBytes___9_y5);
  SubBytes___9_t42 = XOR(SubBytes___9_t42,SubBytes___9_t8);
  SubBytes___9_y10 = AND(SubBytes___9_t8,SubBytes___9_y10);
  SubBytes___9_t8 = AND(SubBytes___9_t8,SubBytes___9_y8);
  SubBytes___9_t0 = AND(SubBytes___9_t28,SubBytes___9_t0);
  SubBytes___9_t28 = AND(SubBytes___9_t28,SubBytes___9_y13);
  SubBytes___9_y17 = AND(SubBytes___9_t42,SubBytes___9_y17);
  SubBytes___9_t42 = AND(SubBytes___9_t42,SubBytes___9_y14);
  SubBytes___9_y1 = XOR(SubBytes___9_t0,SubBytes___9_y1);
  SubBytes___9_t0 = XOR(SubBytes___9_t0,SubBytes___9_y7);
  SubBytes___9_tc7 = XOR(SubBytes___9_t28,SubBytes___9_z2);
  SubBytes___9_t42 = XOR(SubBytes___9_y9,SubBytes___9_t42);
  SubBytes___9_y17 = XOR(SubBytes___9_y17,SubBytes___9_y1);
  SubBytes___9_y1 = XOR(SubBytes___9_y1,SubBytes___9_y6);
  SubBytes___9_z2 = XOR(SubBytes___9_z2,SubBytes___9_t0);
  SubBytes___9_y10 = XOR(SubBytes___9_y10,SubBytes___9_tc7);
  SubBytes___9_y3 = XOR(SubBytes___9_y3,SubBytes___9_t42);
  SubBytes___9_t25 = XOR(SubBytes___9_t25,SubBytes___9_t42);
  SubBytes___9_y11 = XOR(SubBytes___9_y11,SubBytes___9_y17);
  SubBytes___9_y17 = XOR(SubBytes___9_y17,SubBytes___9_y10);
  SubBytes___9_t3 = XOR(SubBytes___9_t3,SubBytes___9_y3);
  SubBytes___9_y3 = XOR(SubBytes___9_y3,SubBytes___9_y4);
  SubBytes___9_t25 = XOR(SubBytes___9_t25,SubBytes___9_z2);
  SubBytes___9_y9 = XOR(SubBytes___9_y9,SubBytes___9_y11);
  SubBytes___9_y2 = XOR(SubBytes___9_y2,SubBytes___9_y17);
  _tmp94_3__ = XOR(SubBytes___9_t3,SubBytes___9_y1);
  _tmp94_0__ = XOR(SubBytes___9_t3,SubBytes___9_y11);
  SubBytes___9_t28 = XOR(SubBytes___9_t28,SubBytes___9_t25);
  SubBytes___9_y17 = XOR(SubBytes___9_y17,SubBytes___9_t25);
  SubBytes___9_y9 = XOR(SubBytes___9_y2,SubBytes___9_y9);
  _tmp94_5__ = XOR(SubBytes___9_y3,SubBytes___9_y2);
  _tmp94_4__ = XOR(SubBytes___9_z2,_tmp94_3__);
  SubBytes___9__tmp3_ = XOR(_tmp94_3__,SubBytes___9_y11);
  _tmp95_3__ = PERMUT_16(_tmp94_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp95_0__ = PERMUT_16(_tmp94_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp94_7__ = NOT(SubBytes___9_t28);
  _tmp94_6__ = NOT(SubBytes___9_y17);
  SubBytes___9_y9 = XOR(SubBytes___9_y9,SubBytes___9_t8);
  _tmp95_5__ = PERMUT_16(_tmp94_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp95_4__ = PERMUT_16(_tmp94_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___9__tmp3_ = NOT(SubBytes___9__tmp3_);
  MixColumn___9__tmp44_ = PERMUT_16(_tmp95_3__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___9__tmp5_ = PERMUT_16(_tmp95_0__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp95_7__ = PERMUT_16(_tmp94_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp95_6__ = PERMUT_16(_tmp94_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp94_2__ = NOT(SubBytes___9_y9);
  MixColumn___9__tmp24_ = PERMUT_16(_tmp95_5__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___9__tmp34_ = PERMUT_16(_tmp95_4__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp95_1__ = PERMUT_16(SubBytes___9__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp95_3__ = XOR(_tmp95_3__,MixColumn___9__tmp44_);
  _tmp95_0__ = XOR(_tmp95_0__,MixColumn___9__tmp5_);
  MixColumn___9__tmp7_ = PERMUT_16(_tmp95_7__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___9__tmp17_ = PERMUT_16(_tmp95_6__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  _tmp95_2__ = PERMUT_16(_tmp94_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp95_5__ = XOR(_tmp95_5__,MixColumn___9__tmp24_);
  _tmp95_4__ = XOR(_tmp95_4__,MixColumn___9__tmp34_);
  MixColumn___9__tmp58_ = PERMUT_16(_tmp95_1__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___9__tmp48_ = PERMUT_16(_tmp95_3__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  MixColumn___9__tmp69_ = PERMUT_16(_tmp95_0__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_7__ = XOR(_tmp95_7__,MixColumn___9__tmp7_);
  MixColumn___9__tmp7_ = XOR(_tmp95_0__,MixColumn___9__tmp7_);
  _tmp95_6__ = XOR(_tmp95_6__,MixColumn___9__tmp17_);
  MixColumn___9__tmp51_ = PERMUT_16(_tmp95_2__,1,2,3,0,5,6,7,4,9,10,11,8,13,14,15,12);
  MixColumn___9__tmp28_ = PERMUT_16(_tmp95_5__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_5__ = XOR(_tmp95_5__,_tmp95_0__);
  MixColumn___9__tmp38_ = PERMUT_16(_tmp95_4__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_4__ = XOR(_tmp95_4__,_tmp95_0__);
  _tmp95_1__ = XOR(_tmp95_1__,MixColumn___9__tmp58_);
  MixColumn___9__tmp11_ = PERMUT_16(_tmp95_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_7__ = XOR(_tmp95_7__,_tmp95_0__);
  MixColumn___9__tmp21_ = PERMUT_16(_tmp95_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_6__ = XOR(_tmp95_6__,MixColumn___9__tmp24_);
  _tmp95_2__ = XOR(_tmp95_2__,MixColumn___9__tmp51_);
  _tmp95_3__ = XOR(_tmp95_3__,MixColumn___9__tmp51_);
  _tmp95_5__ = XOR(_tmp95_5__,MixColumn___9__tmp34_);
  _tmp95_4__ = XOR(_tmp95_4__,MixColumn___9__tmp44_);
  MixColumn___9__tmp62_ = PERMUT_16(_tmp95_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_1__ = XOR(_tmp95_1__,MixColumn___9__tmp5_);
  MixColumn___9__tmp7_ = XOR(MixColumn___9__tmp7_,MixColumn___9__tmp11_);
  _tmp95_7__ = XOR(_tmp95_7__,MixColumn___9__tmp17_);
  _tmp95_6__ = XOR(_tmp95_6__,MixColumn___9__tmp28_);
  MixColumn___9__tmp55_ = PERMUT_16(_tmp95_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_2__ = XOR(_tmp95_2__,MixColumn___9__tmp58_);
  _tmp95_5__ = XOR(_tmp95_5__,MixColumn___9__tmp38_);
  _tmp95_4__ = XOR(_tmp95_4__,MixColumn___9__tmp48_);
  _tmp95_1__ = XOR(_tmp95_1__,MixColumn___9__tmp69_);
  MixColumn___9__tmp7_ = XOR(MixColumn___9__tmp7_,key__[9][7]);
  _tmp95_7__ = XOR(_tmp95_7__,MixColumn___9__tmp21_);
  _tmp95_6__ = XOR(_tmp95_6__,key__[9][5]);
  _tmp95_3__ = XOR(_tmp95_3__,MixColumn___9__tmp55_);
  _tmp95_2__ = XOR(_tmp95_2__,MixColumn___9__tmp62_);
  _tmp95_5__ = XOR(_tmp95_5__,key__[9][4]);
  _tmp95_4__ = XOR(_tmp95_4__,key__[9][3]);
  _tmp95_1__ = XOR(_tmp95_1__,key__[9][0]);
  _tmp95_7__ = XOR(_tmp95_7__,key__[9][6]);
  _tmp95_3__ = XOR(_tmp95_3__,key__[9][2]);
  _tmp95_2__ = XOR(_tmp95_2__,key__[9][1]);
  SubBytes___10_y14 = XOR(_tmp95_4__,_tmp95_6__);
  SubBytes___10_y9 = XOR(_tmp95_1__,_tmp95_4__);
  SubBytes___10_y8 = XOR(_tmp95_1__,_tmp95_6__);
  SubBytes___10_y13 = XOR(_tmp95_1__,_tmp95_7__);
  SubBytes___10_t0 = XOR(_tmp95_2__,_tmp95_3__);
  SubBytes___10_y12 = XOR(SubBytes___10_y13,SubBytes___10_y14);
  SubBytes___10_y1 = XOR(SubBytes___10_t0,MixColumn___9__tmp7_);
  SubBytes___10_t1 = XOR(_tmp95_5__,SubBytes___10_y12);
  SubBytes___10_y4 = XOR(SubBytes___10_y1,_tmp95_4__);
  SubBytes___10_y2 = XOR(SubBytes___10_y1,_tmp95_1__);
  SubBytes___10_y5 = XOR(SubBytes___10_y1,_tmp95_7__);
  SubBytes___10_y15 = XOR(SubBytes___10_t1,_tmp95_6__);
  SubBytes___10_t1 = XOR(SubBytes___10_t1,_tmp95_2__);
  SubBytes___10_t5 = AND(SubBytes___10_y4,MixColumn___9__tmp7_);
  SubBytes___10_y3 = XOR(SubBytes___10_y5,SubBytes___10_y8);
  SubBytes___10_t8 = AND(SubBytes___10_y5,SubBytes___10_y1);
  SubBytes___10_y6 = XOR(SubBytes___10_y15,MixColumn___9__tmp7_);
  SubBytes___10_y10 = XOR(SubBytes___10_y15,SubBytes___10_t0);
  SubBytes___10_t2 = AND(SubBytes___10_y12,SubBytes___10_y15);
  SubBytes___10_y11 = XOR(SubBytes___10_t1,SubBytes___10_y9);
  SubBytes___10_t3 = AND(SubBytes___10_y3,SubBytes___10_y6);
  SubBytes___10_y19 = XOR(SubBytes___10_y10,SubBytes___10_y8);
  SubBytes___10_t15 = AND(SubBytes___10_y8,SubBytes___10_y10);
  SubBytes___10_t5 = XOR(SubBytes___10_t5,SubBytes___10_t2);
  SubBytes___10_y7 = XOR(MixColumn___9__tmp7_,SubBytes___10_y11);
  SubBytes___10_y17 = XOR(SubBytes___10_y10,SubBytes___10_y11);
  SubBytes___10_t0 = XOR(SubBytes___10_t0,SubBytes___10_y11);
  SubBytes___10_t12 = AND(SubBytes___10_y9,SubBytes___10_y11);
  SubBytes___10_t3 = XOR(SubBytes___10_t3,SubBytes___10_t2);
  SubBytes___10_t10 = AND(SubBytes___10_y2,SubBytes___10_y7);
  SubBytes___10_t13 = AND(SubBytes___10_y14,SubBytes___10_y17);
  SubBytes___10_y21 = XOR(SubBytes___10_y13,SubBytes___10_t0);
  SubBytes___10_y18 = XOR(_tmp95_1__,SubBytes___10_t0);
  SubBytes___10_t7 = AND(SubBytes___10_y13,SubBytes___10_t0);
  SubBytes___10_t15 = XOR(SubBytes___10_t15,SubBytes___10_t12);
  SubBytes___10_t3 = XOR(SubBytes___10_t3,SubBytes___10_t1);
  SubBytes___10_t13 = XOR(SubBytes___10_t13,SubBytes___10_t12);
  SubBytes___10_t8 = XOR(SubBytes___10_t8,SubBytes___10_t7);
  SubBytes___10_t10 = XOR(SubBytes___10_t10,SubBytes___10_t7);
  SubBytes___10_t5 = XOR(SubBytes___10_t5,SubBytes___10_t15);
  SubBytes___10_t3 = XOR(SubBytes___10_t3,SubBytes___10_t13);
  SubBytes___10_t8 = XOR(SubBytes___10_t8,SubBytes___10_t13);
  SubBytes___10_t10 = XOR(SubBytes___10_t10,SubBytes___10_t15);
  SubBytes___10_t5 = XOR(SubBytes___10_t5,SubBytes___10_y19);
  SubBytes___10_t8 = XOR(SubBytes___10_t8,SubBytes___10_y21);
  SubBytes___10_t10 = XOR(SubBytes___10_t10,SubBytes___10_y18);
  SubBytes___10_t25 = XOR(SubBytes___10_t3,SubBytes___10_t5);
  SubBytes___10_t3 = AND(SubBytes___10_t3,SubBytes___10_t8);
  SubBytes___10_t30 = XOR(SubBytes___10_t8,SubBytes___10_t10);
  SubBytes___10_t27 = XOR(SubBytes___10_t10,SubBytes___10_t3);
  SubBytes___10_t3 = XOR(SubBytes___10_t5,SubBytes___10_t3);
  SubBytes___10_t28 = AND(SubBytes___10_t25,SubBytes___10_t27);
  SubBytes___10_t3 = AND(SubBytes___10_t3,SubBytes___10_t30);
  SubBytes___10_t28 = XOR(SubBytes___10_t28,SubBytes___10_t5);
  SubBytes___10_t3 = XOR(SubBytes___10_t3,SubBytes___10_t10);
  SubBytes___10_y7 = AND(SubBytes___10_t28,SubBytes___10_y7);
  SubBytes___10_y2 = AND(SubBytes___10_t28,SubBytes___10_y2);
  SubBytes___10_t8 = XOR(SubBytes___10_t8,SubBytes___10_t3);
  SubBytes___10_t35 = XOR(SubBytes___10_t27,SubBytes___10_t3);
  SubBytes___10_t42 = XOR(SubBytes___10_t28,SubBytes___10_t3);
  SubBytes___10_z2 = AND(SubBytes___10_t3,MixColumn___9__tmp7_);
  SubBytes___10_y4 = AND(SubBytes___10_t3,SubBytes___10_y4);
  SubBytes___10_t10 = AND(SubBytes___10_t10,SubBytes___10_t35);
  SubBytes___10_y11 = AND(SubBytes___10_t42,SubBytes___10_y11);
  SubBytes___10_y9 = AND(SubBytes___10_t42,SubBytes___10_y9);
  SubBytes___10_t8 = XOR(SubBytes___10_t10,SubBytes___10_t8);
  SubBytes___10_t27 = XOR(SubBytes___10_t27,SubBytes___10_t10);
  SubBytes___10_t3 = XOR(SubBytes___10_t3,SubBytes___10_t8);
  SubBytes___10_y6 = AND(SubBytes___10_t8,SubBytes___10_y6);
  SubBytes___10_y3 = AND(SubBytes___10_t8,SubBytes___10_y3);
  SubBytes___10_t27 = AND(SubBytes___10_t28,SubBytes___10_t27);
  SubBytes___10_y15 = AND(SubBytes___10_t3,SubBytes___10_y15);
  SubBytes___10_t3 = AND(SubBytes___10_t3,SubBytes___10_y12);
  SubBytes___10_t25 = XOR(SubBytes___10_t25,SubBytes___10_t27);
  SubBytes___10_z2 = XOR(SubBytes___10_y15,SubBytes___10_z2);
  SubBytes___10_y6 = XOR(SubBytes___10_y6,SubBytes___10_y15);
  SubBytes___10_t8 = XOR(SubBytes___10_t25,SubBytes___10_t8);
  SubBytes___10_t28 = XOR(SubBytes___10_t28,SubBytes___10_t25);
  SubBytes___10_y1 = AND(SubBytes___10_t25,SubBytes___10_y1);
  SubBytes___10_t25 = AND(SubBytes___10_t25,SubBytes___10_y5);
  SubBytes___10_t42 = XOR(SubBytes___10_t42,SubBytes___10_t8);
  SubBytes___10_y10 = AND(SubBytes___10_t8,SubBytes___10_y10);
  SubBytes___10_t8 = AND(SubBytes___10_t8,SubBytes___10_y8);
  SubBytes___10_t0 = AND(SubBytes___10_t28,SubBytes___10_t0);
  SubBytes___10_t28 = AND(SubBytes___10_t28,SubBytes___10_y13);
  SubBytes___10_y17 = AND(SubBytes___10_t42,SubBytes___10_y17);
  SubBytes___10_t42 = AND(SubBytes___10_t42,SubBytes___10_y14);
  SubBytes___10_y1 = XOR(SubBytes___10_t0,SubBytes___10_y1);
  SubBytes___10_t0 = XOR(SubBytes___10_t0,SubBytes___10_y7);
  SubBytes___10_tc7 = XOR(SubBytes___10_t28,SubBytes___10_z2);
  SubBytes___10_t42 = XOR(SubBytes___10_y9,SubBytes___10_t42);
  SubBytes___10_y17 = XOR(SubBytes___10_y17,SubBytes___10_y1);
  SubBytes___10_y1 = XOR(SubBytes___10_y1,SubBytes___10_y6);
  SubBytes___10_z2 = XOR(SubBytes___10_z2,SubBytes___10_t0);
  SubBytes___10_y10 = XOR(SubBytes___10_y10,SubBytes___10_tc7);
  SubBytes___10_y3 = XOR(SubBytes___10_y3,SubBytes___10_t42);
  SubBytes___10_t25 = XOR(SubBytes___10_t25,SubBytes___10_t42);
  SubBytes___10_y11 = XOR(SubBytes___10_y11,SubBytes___10_y17);
  SubBytes___10_y17 = XOR(SubBytes___10_y17,SubBytes___10_y10);
  SubBytes___10_t3 = XOR(SubBytes___10_t3,SubBytes___10_y3);
  SubBytes___10_y3 = XOR(SubBytes___10_y3,SubBytes___10_y4);
  SubBytes___10_t25 = XOR(SubBytes___10_t25,SubBytes___10_z2);
  SubBytes___10_y9 = XOR(SubBytes___10_y9,SubBytes___10_y11);
  SubBytes___10_y2 = XOR(SubBytes___10_y2,SubBytes___10_y17);
  _tmp97_3__ = XOR(SubBytes___10_t3,SubBytes___10_y1);
  _tmp97_0__ = XOR(SubBytes___10_t3,SubBytes___10_y11);
  SubBytes___10_t28 = XOR(SubBytes___10_t28,SubBytes___10_t25);
  SubBytes___10_y17 = XOR(SubBytes___10_y17,SubBytes___10_t25);
  SubBytes___10_y9 = XOR(SubBytes___10_y2,SubBytes___10_y9);
  _tmp97_5__ = XOR(SubBytes___10_y3,SubBytes___10_y2);
  _tmp97_4__ = XOR(SubBytes___10_z2,_tmp97_3__);
  SubBytes___10__tmp3_ = XOR(_tmp97_3__,SubBytes___10_y11);
  _tmp98_3__ = PERMUT_16(_tmp97_3__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp98_0__ = PERMUT_16(_tmp97_0__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp97_7__ = NOT(SubBytes___10_t28);
  _tmp97_6__ = NOT(SubBytes___10_y17);
  SubBytes___10_y9 = XOR(SubBytes___10_y9,SubBytes___10_t8);
  _tmp98_5__ = PERMUT_16(_tmp97_5__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp98_4__ = PERMUT_16(_tmp97_4__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  SubBytes___10__tmp3_ = NOT(SubBytes___10__tmp3_);
  cipher__[3] = XOR(_tmp98_3__,key__[10][3]);
  cipher__[0] = XOR(_tmp98_0__,key__[10][0]);
  _tmp98_7__ = PERMUT_16(_tmp97_7__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp98_6__ = PERMUT_16(_tmp97_6__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  _tmp97_2__ = NOT(SubBytes___10_y9);
  cipher__[5] = XOR(_tmp98_5__,key__[10][5]);
  cipher__[4] = XOR(_tmp98_4__,key__[10][4]);
  _tmp98_1__ = PERMUT_16(SubBytes___10__tmp3_,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  cipher__[7] = XOR(_tmp98_7__,key__[10][7]);
  cipher__[6] = XOR(_tmp98_6__,key__[10][6]);
  _tmp98_2__ = PERMUT_16(_tmp97_2__,0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11);
  cipher__[1] = XOR(_tmp98_1__,key__[10][1]);
  cipher__[2] = XOR(_tmp98_2__,key__[10][2]);

}
 /
#else

#warning No implementation defined. Using default.

 
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
