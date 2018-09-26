
#define NO_RUNTIME
#ifdef STD
#include "STD.h"
#elif defined(SSE)
#include "SSE.h"
#elif defined(AVX)
#include "AVX.h"
#else
#error No architecture specified
#endif

extern DATATYPE v0, v1, v2, v3, v4, v5, v6, v7;

void sbox(){
  DATATYPE xmm8, xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15;
  v5 = XOR(v6,v5);
  v2 = XOR(v1,v2);
  xmm8 = XOR(v0,v5);
  v6 = XOR(v2,v6);
  v3 = XOR(v0,v3);
  v6 = XOR(v3,v6);
  v3 = XOR(v7,v3);
  v7 = XOR(xmm8,v7);
  v3 = XOR(v4,v3);
  v4 = XOR(xmm8,v4);
  v3 = XOR(v1,v3);
  v2 = XOR(v7,v2);
  v1 = XOR(xmm8,v1);
  xmm11 = XOR(v7,v4);
  xmm10 = XOR(v1,v2);
  xmm9 = XOR(xmm8,v3);
  xmm13 = XOR(v2,v4);
  xmm12 = XOR(v6,v0);
  xmm15 = XOR(xmm11,xmm10);
  v5 = AND(xmm10,xmm9);
  xmm10 = OR(xmm9,xmm10);
  xmm14 = AND(xmm11,xmm12);
  xmm11 = OR(xmm12,xmm11);
  xmm12 = XOR(xmm9,xmm12);
  xmm15 = AND(xmm12,xmm15);
  xmm12 = XOR(v3,v0);
  xmm13 = AND(xmm12,xmm13);
  xmm11 = XOR(xmm13,xmm11);
  xmm10 = XOR(xmm13,xmm10);
  xmm13 = XOR(v7,v1);
  xmm12 = XOR(xmm8,v6);
  xmm9 = OR(xmm13,xmm12);
  xmm13 = AND(xmm12,xmm13);
  v5 = XOR(xmm13,v5);
  xmm11 = XOR(xmm15,xmm11);
  xmm10 = XOR(xmm14,xmm10);
  xmm9 = XOR(xmm15,xmm9);
  v5 = XOR(xmm14,v5);
  xmm9 = XOR(xmm14,xmm9);
  xmm12 = AND(v2,v3);
  xmm13 = AND(v4,v0);
  xmm14 = AND(v1,xmm8);
  xmm15 = OR(v7,v6);
  xmm11 = XOR(xmm12,xmm11);
  xmm10 = XOR(xmm13,xmm10);
  xmm9 = XOR(xmm14,xmm9);
  v5 = XOR(xmm15,v5);
  xmm12 = XOR(xmm11,xmm10);
  xmm11 = AND(xmm9,xmm11);
  xmm14 = XOR(v5,xmm11);
  xmm15 = AND(xmm12,xmm14);
  xmm15 = XOR(xmm10,xmm15);
  xmm13 = XOR(xmm9,v5);
  xmm11 = XOR(xmm10,xmm11);
  xmm13 = AND(xmm11,xmm13);
  xmm13 = XOR(v5,xmm13);
  xmm9 = XOR(xmm13,xmm9);
  xmm10 = XOR(xmm14,xmm13);
  xmm10 = AND(v5,xmm10);
  xmm9 = XOR(xmm10,xmm9);
  xmm14 = XOR(xmm10,xmm14);
  xmm14 = AND(xmm15,xmm14);
  xmm14 = XOR(xmm12,xmm14);
  xmm10 = XOR(xmm15,xmm14);
  xmm10 = AND(v6,xmm10);
  xmm12 = XOR(v6,xmm8);
  xmm12 = AND(xmm14,xmm12);
  v5 = AND(xmm8,xmm15);
  xmm12 = XOR(v5,xmm12);
  v5 = XOR(xmm10,v5);
  v6 = XOR(v0,v6);
  xmm8 = XOR(v3,xmm8);
  xmm15 = XOR(xmm13,xmm15);
  xmm14 = XOR(xmm9,xmm14);
  xmm11 = XOR(xmm15,xmm14);
  xmm11 = AND(v6,xmm11);
  v6 = XOR(xmm8,v6);
  v6 = AND(xmm14,v6);
  xmm8 = AND(xmm15,xmm8);
  xmm8 = XOR(v6,xmm8);
  v6 = XOR(xmm11,v6);
  xmm10 = XOR(xmm13,xmm9);
  xmm10 = AND(v0,xmm10);
  v0 = XOR(v0,v3);
  v0 = AND(xmm9,v0);
  v3 = AND(v3,xmm13);
  v0 = XOR(v3,v0);
  v3 = XOR(xmm10,v3);
  v0 = XOR(v6,v0);
  v6 = XOR(xmm12,v6);
  v3 = XOR(xmm8,v3);
  xmm8 = XOR(v5,xmm8);
  xmm12 = XOR(v7,v4);
  v5 = XOR(v1,v2);
  xmm11 = XOR(xmm15,xmm14);
  xmm11 = AND(xmm12,xmm11);
  xmm12 = XOR(v5,xmm12);
  xmm12 = AND(xmm14,xmm12);
  v5 = AND(xmm15,v5);
  v5 = XOR(xmm12,v5);
  xmm12 = XOR(xmm11,xmm12);
  xmm10 = XOR(xmm13,xmm9);
  xmm10 = AND(v4,xmm10);
  v4 = XOR(v4,v2);
  v4 = AND(xmm9,v4);
  v2 = AND(v2,xmm13);
  v4 = XOR(v2,v4);
  v2 = XOR(xmm10,v2);
  xmm15 = XOR(xmm13,xmm15);
  xmm14 = XOR(xmm9,xmm14);
  xmm11 = XOR(xmm15,xmm14);
  xmm11 = AND(v7,xmm11);
  v7 = XOR(v7,v1);
  v7 = AND(xmm14,v7);
  v1 = AND(v1,xmm15);
  v7 = XOR(v1,v7);
  v1 = XOR(xmm11,v1);
  v7 = XOR(xmm12,v7);
  v4 = XOR(xmm12,v4);
  v1 = XOR(v5,v1);
  v2 = XOR(v5,v2);
  v5 = XOR(v7,v0);
  xmm9 = XOR(v1,v6);
  xmm10 = XOR(v4,v5);
  xmm12 = XOR(v6,v0);
  v0 = XOR(v0,xmm9);
  v1 = XOR(xmm8,xmm9);
  v7 = XOR(xmm8,v2);
  v6 = XOR(v2,v3);
  v2 = XOR(xmm10,v7);
  v4 = XOR(v3,v7);
  v3 = XOR(xmm12,v4);
  v0 = NOT(v0);
  v1 = NOT(v1);
  v5 = NOT(v5);
  v6 = NOT(v6);
}
