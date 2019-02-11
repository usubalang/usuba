#define NO_RUNTIME
#include "SSE.h"
#include <stdio.h>

#ifndef PRINT128HEX
#define PRINT128HEX
#include <x86intrin.h>
void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
}
#endif

#if defined(MACRO)

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


 
#if !defined(EXPANDED)
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
    SubBytes(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
    ShiftRows(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
    MixColumn(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
    plain__[0] = XOR(plain__[0],key__[i][0]);
    plain__[1] = XOR(plain__[1],key__[i][1]);
    plain__[2] = XOR(plain__[2],key__[i][2]);
    plain__[3] = XOR(plain__[3],key__[i][3]);
    plain__[4] = XOR(plain__[4],key__[i][4]);
    plain__[5] = XOR(plain__[5],key__[i][5]);
    plain__[6] = XOR(plain__[6],key__[i][6]);
    plain__[7] = XOR(plain__[7],key__[i][7]);
  }
  SubBytes(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
  ShiftRows(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
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

 
#elif defined(KIVI)

   
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


 
#if !defined(EXPANDED)
void AES__(/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {

  plain__[0] = XOR(plain__[0],key__[0][0]);
  plain__[1] = XOR(plain__[1],key__[0][1]);
  plain__[2] = XOR(plain__[2],key__[0][2]);
  plain__[3] = XOR(plain__[3],key__[0][3]);
  plain__[4] = XOR(plain__[4],key__[0][4]);
  plain__[5] = XOR(plain__[5],key__[0][5]);
  plain__[6] = XOR(plain__[6],key__[0][6]);
  plain__[7] = XOR(plain__[7],key__[0][7]);
  for (int i = 1; i <= 9; i++) {
    shiftrows_subbytes_mixcolumn(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
    plain__[0] = XOR(plain__[0],key__[i][0]);
    plain__[1] = XOR(plain__[1],key__[i][1]);
    plain__[2] = XOR(plain__[2],key__[i][2]);
    plain__[3] = XOR(plain__[3],key__[i][3]);
    plain__[4] = XOR(plain__[4],key__[i][4]);
    plain__[5] = XOR(plain__[5],key__[i][5]);
    plain__[6] = XOR(plain__[6],key__[i][6]);
    plain__[7] = XOR(plain__[7],key__[i][7]);
  }
    shiftrows_subbytes(plain__[7],plain__[6],plain__[5],plain__[4],plain__[3],plain__[2],plain__[1],plain__[0]);
  cipher__[0] = XOR(plain__[0],key__[10][0]);
  cipher__[1] = XOR(plain__[1],key__[10][1]);
  cipher__[2] = XOR(plain__[2],key__[10][2]);
  cipher__[3] = XOR(plain__[3],key__[10][3]);
  cipher__[4] = XOR(plain__[4],key__[10][4]);
  cipher__[5] = XOR(plain__[5],key__[10][5]);
  cipher__[6] = XOR(plain__[6],key__[10][6]);
  cipher__[7] = XOR(plain__[7],key__[10][7]);
}
#else

void __attribute__ ((noinline)) AES__(DATATYPE key__[11][8],DATATYPE plain__0,DATATYPE plain__1,DATATYPE plain__2,DATATYPE plain__3,DATATYPE plain__4,DATATYPE plain__5,DATATYPE plain__6,DATATYPE plain__7, /*outputs*/ DATATYPE cipher__[8])  {
      
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

#elif defined(UA_FULL)

#ifndef EXPANDED
static inline void AES__(/*inputs*/ DATATYPE plain__[8],DATATYPE key__[11][8], /*outputs*/ DATATYPE cipher__[8]) {
#else
static inline void AES__(DATATYPE key__[11][8],DATATYPE plain__0,DATATYPE plain__1,DATATYPE plain__2,DATATYPE plain__3,DATATYPE plain__4,DATATYPE plain__5,DATATYPE plain__6,DATATYPE plain__7, /*outputs*/ DATATYPE cipher__[8]) {
#endif
  
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
#ifndef EXPANDED
  tmp__0__0__ = XOR(plain__[0],key__[0][0]);
  tmp__0__1__ = XOR(plain__[1],key__[0][1]);
  tmp__0__2__ = XOR(plain__[2],key__[0][2]);
  tmp__0__3__ = XOR(plain__[3],key__[0][3]);
  tmp__0__4__ = XOR(plain__[4],key__[0][4]);
  tmp__0__5__ = XOR(plain__[5],key__[0][5]);
  tmp__0__6__ = XOR(plain__[6],key__[0][6]);
  tmp__0__7__ = XOR(plain__[7],key__[0][7]);
#else
  tmp__0__0__ = XOR(plain__0,key__[0][0]);
  tmp__0__1__ = XOR(plain__1,key__[0][1]);
  tmp__0__2__ = XOR(plain__2,key__[0][2]);
  tmp__0__3__ = XOR(plain__3,key__[0][3]);
  tmp__0__4__ = XOR(plain__4,key__[0][4]);
  tmp__0__5__ = XOR(plain__5,key__[0][5]);
  tmp__0__6__ = XOR(plain__6,key__[0][6]);
  tmp__0__7__ = XOR(plain__7,key__[0][7]);
#endif
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
  _tmp71_1__ = XOR(_tmp71_1__,MixColumn___1__tmp58_);
  _tmp71_4__ = XOR(_tmp71_4__,_tmp71_0__);
  MixColumn___1__tmp11_ = PERMUT_16(_tmp71_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_7__ = XOR(_tmp71_7__,_tmp71_0__);
  MixColumn___1__tmp21_ = PERMUT_16(_tmp71_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_6__ = XOR(_tmp71_6__,MixColumn___1__tmp24_);
  _tmp71_2__ = XOR(_tmp71_2__,MixColumn___1__tmp51_);
  _tmp71_3__ = XOR(_tmp71_3__,MixColumn___1__tmp51_);
  _tmp71_5__ = XOR(_tmp71_5__,MixColumn___1__tmp34_);
  MixColumn___1__tmp62_ = PERMUT_16(_tmp71_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_1__ = XOR(_tmp71_1__,MixColumn___1__tmp5_);
  _tmp71_4__ = XOR(_tmp71_4__,MixColumn___1__tmp44_);
  MixColumn___1__tmp7_ = XOR(MixColumn___1__tmp7_,MixColumn___1__tmp11_);
  _tmp71_7__ = XOR(_tmp71_7__,MixColumn___1__tmp17_);
  _tmp71_6__ = XOR(_tmp71_6__,MixColumn___1__tmp28_);
  MixColumn___1__tmp55_ = PERMUT_16(_tmp71_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp71_2__ = XOR(_tmp71_2__,MixColumn___1__tmp58_);
  _tmp71_5__ = XOR(_tmp71_5__,MixColumn___1__tmp38_);
  _tmp71_1__ = XOR(_tmp71_1__,MixColumn___1__tmp69_);
  _tmp71_4__ = XOR(_tmp71_4__,MixColumn___1__tmp48_);
  MixColumn___1__tmp7_ = XOR(MixColumn___1__tmp7_,key__[1][7]);
  _tmp71_7__ = XOR(_tmp71_7__,MixColumn___1__tmp21_);
  _tmp71_6__ = XOR(_tmp71_6__,key__[1][5]);
  _tmp71_3__ = XOR(_tmp71_3__,MixColumn___1__tmp55_);
  _tmp71_2__ = XOR(_tmp71_2__,MixColumn___1__tmp62_);
  _tmp71_5__ = XOR(_tmp71_5__,key__[1][4]);
  _tmp71_1__ = XOR(_tmp71_1__,key__[1][0]);
  _tmp71_4__ = XOR(_tmp71_4__,key__[1][3]);
  _tmp71_7__ = XOR(_tmp71_7__,key__[1][6]);
  _tmp71_3__ = XOR(_tmp71_3__,key__[1][2]);
  _tmp71_2__ = XOR(_tmp71_2__,key__[1][1]);
  SubBytes___2_y8 = XOR(_tmp71_1__,_tmp71_6__);
  SubBytes___2_y14 = XOR(_tmp71_4__,_tmp71_6__);
  SubBytes___2_y9 = XOR(_tmp71_1__,_tmp71_4__);
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
  _tmp74_1__ = XOR(_tmp74_1__,MixColumn___2__tmp58_);
  _tmp74_4__ = XOR(_tmp74_4__,_tmp74_0__);
  MixColumn___2__tmp11_ = PERMUT_16(_tmp74_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_7__ = XOR(_tmp74_7__,_tmp74_0__);
  MixColumn___2__tmp21_ = PERMUT_16(_tmp74_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_6__ = XOR(_tmp74_6__,MixColumn___2__tmp24_);
  _tmp74_2__ = XOR(_tmp74_2__,MixColumn___2__tmp51_);
  _tmp74_3__ = XOR(_tmp74_3__,MixColumn___2__tmp51_);
  _tmp74_5__ = XOR(_tmp74_5__,MixColumn___2__tmp34_);
  MixColumn___2__tmp62_ = PERMUT_16(_tmp74_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_1__ = XOR(_tmp74_1__,MixColumn___2__tmp5_);
  _tmp74_4__ = XOR(_tmp74_4__,MixColumn___2__tmp44_);
  MixColumn___2__tmp7_ = XOR(MixColumn___2__tmp7_,MixColumn___2__tmp11_);
  _tmp74_7__ = XOR(_tmp74_7__,MixColumn___2__tmp17_);
  _tmp74_6__ = XOR(_tmp74_6__,MixColumn___2__tmp28_);
  MixColumn___2__tmp55_ = PERMUT_16(_tmp74_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp74_2__ = XOR(_tmp74_2__,MixColumn___2__tmp58_);
  _tmp74_5__ = XOR(_tmp74_5__,MixColumn___2__tmp38_);
  _tmp74_1__ = XOR(_tmp74_1__,MixColumn___2__tmp69_);
  _tmp74_4__ = XOR(_tmp74_4__,MixColumn___2__tmp48_);
  MixColumn___2__tmp7_ = XOR(MixColumn___2__tmp7_,key__[2][7]);
  _tmp74_7__ = XOR(_tmp74_7__,MixColumn___2__tmp21_);
  _tmp74_6__ = XOR(_tmp74_6__,key__[2][5]);
  _tmp74_3__ = XOR(_tmp74_3__,MixColumn___2__tmp55_);
  _tmp74_2__ = XOR(_tmp74_2__,MixColumn___2__tmp62_);
  _tmp74_5__ = XOR(_tmp74_5__,key__[2][4]);
  _tmp74_1__ = XOR(_tmp74_1__,key__[2][0]);
  _tmp74_4__ = XOR(_tmp74_4__,key__[2][3]);
  _tmp74_7__ = XOR(_tmp74_7__,key__[2][6]);
  _tmp74_3__ = XOR(_tmp74_3__,key__[2][2]);
  _tmp74_2__ = XOR(_tmp74_2__,key__[2][1]);
  SubBytes___3_y8 = XOR(_tmp74_1__,_tmp74_6__);
  SubBytes___3_y14 = XOR(_tmp74_4__,_tmp74_6__);
  SubBytes___3_y9 = XOR(_tmp74_1__,_tmp74_4__);
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
  _tmp77_1__ = XOR(_tmp77_1__,MixColumn___3__tmp58_);
  _tmp77_4__ = XOR(_tmp77_4__,_tmp77_0__);
  MixColumn___3__tmp11_ = PERMUT_16(_tmp77_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_7__ = XOR(_tmp77_7__,_tmp77_0__);
  MixColumn___3__tmp21_ = PERMUT_16(_tmp77_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_6__ = XOR(_tmp77_6__,MixColumn___3__tmp24_);
  _tmp77_2__ = XOR(_tmp77_2__,MixColumn___3__tmp51_);
  _tmp77_3__ = XOR(_tmp77_3__,MixColumn___3__tmp51_);
  _tmp77_5__ = XOR(_tmp77_5__,MixColumn___3__tmp34_);
  MixColumn___3__tmp62_ = PERMUT_16(_tmp77_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_1__ = XOR(_tmp77_1__,MixColumn___3__tmp5_);
  _tmp77_4__ = XOR(_tmp77_4__,MixColumn___3__tmp44_);
  MixColumn___3__tmp7_ = XOR(MixColumn___3__tmp7_,MixColumn___3__tmp11_);
  _tmp77_7__ = XOR(_tmp77_7__,MixColumn___3__tmp17_);
  _tmp77_6__ = XOR(_tmp77_6__,MixColumn___3__tmp28_);
  MixColumn___3__tmp55_ = PERMUT_16(_tmp77_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp77_2__ = XOR(_tmp77_2__,MixColumn___3__tmp58_);
  _tmp77_5__ = XOR(_tmp77_5__,MixColumn___3__tmp38_);
  _tmp77_1__ = XOR(_tmp77_1__,MixColumn___3__tmp69_);
  _tmp77_4__ = XOR(_tmp77_4__,MixColumn___3__tmp48_);
  MixColumn___3__tmp7_ = XOR(MixColumn___3__tmp7_,key__[3][7]);
  _tmp77_7__ = XOR(_tmp77_7__,MixColumn___3__tmp21_);
  _tmp77_6__ = XOR(_tmp77_6__,key__[3][5]);
  _tmp77_3__ = XOR(_tmp77_3__,MixColumn___3__tmp55_);
  _tmp77_2__ = XOR(_tmp77_2__,MixColumn___3__tmp62_);
  _tmp77_5__ = XOR(_tmp77_5__,key__[3][4]);
  _tmp77_1__ = XOR(_tmp77_1__,key__[3][0]);
  _tmp77_4__ = XOR(_tmp77_4__,key__[3][3]);
  _tmp77_7__ = XOR(_tmp77_7__,key__[3][6]);
  _tmp77_3__ = XOR(_tmp77_3__,key__[3][2]);
  _tmp77_2__ = XOR(_tmp77_2__,key__[3][1]);
  SubBytes___4_y8 = XOR(_tmp77_1__,_tmp77_6__);
  SubBytes___4_y14 = XOR(_tmp77_4__,_tmp77_6__);
  SubBytes___4_y9 = XOR(_tmp77_1__,_tmp77_4__);
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
  _tmp80_1__ = XOR(_tmp80_1__,MixColumn___4__tmp58_);
  _tmp80_4__ = XOR(_tmp80_4__,_tmp80_0__);
  MixColumn___4__tmp11_ = PERMUT_16(_tmp80_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_7__ = XOR(_tmp80_7__,_tmp80_0__);
  MixColumn___4__tmp21_ = PERMUT_16(_tmp80_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_6__ = XOR(_tmp80_6__,MixColumn___4__tmp24_);
  _tmp80_2__ = XOR(_tmp80_2__,MixColumn___4__tmp51_);
  _tmp80_3__ = XOR(_tmp80_3__,MixColumn___4__tmp51_);
  _tmp80_5__ = XOR(_tmp80_5__,MixColumn___4__tmp34_);
  MixColumn___4__tmp62_ = PERMUT_16(_tmp80_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_1__ = XOR(_tmp80_1__,MixColumn___4__tmp5_);
  _tmp80_4__ = XOR(_tmp80_4__,MixColumn___4__tmp44_);
  MixColumn___4__tmp7_ = XOR(MixColumn___4__tmp7_,MixColumn___4__tmp11_);
  _tmp80_7__ = XOR(_tmp80_7__,MixColumn___4__tmp17_);
  _tmp80_6__ = XOR(_tmp80_6__,MixColumn___4__tmp28_);
  MixColumn___4__tmp55_ = PERMUT_16(_tmp80_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp80_2__ = XOR(_tmp80_2__,MixColumn___4__tmp58_);
  _tmp80_5__ = XOR(_tmp80_5__,MixColumn___4__tmp38_);
  _tmp80_1__ = XOR(_tmp80_1__,MixColumn___4__tmp69_);
  _tmp80_4__ = XOR(_tmp80_4__,MixColumn___4__tmp48_);
  MixColumn___4__tmp7_ = XOR(MixColumn___4__tmp7_,key__[4][7]);
  _tmp80_7__ = XOR(_tmp80_7__,MixColumn___4__tmp21_);
  _tmp80_6__ = XOR(_tmp80_6__,key__[4][5]);
  _tmp80_3__ = XOR(_tmp80_3__,MixColumn___4__tmp55_);
  _tmp80_2__ = XOR(_tmp80_2__,MixColumn___4__tmp62_);
  _tmp80_5__ = XOR(_tmp80_5__,key__[4][4]);
  _tmp80_1__ = XOR(_tmp80_1__,key__[4][0]);
  _tmp80_4__ = XOR(_tmp80_4__,key__[4][3]);
  _tmp80_7__ = XOR(_tmp80_7__,key__[4][6]);
  _tmp80_3__ = XOR(_tmp80_3__,key__[4][2]);
  _tmp80_2__ = XOR(_tmp80_2__,key__[4][1]);
  SubBytes___5_y8 = XOR(_tmp80_1__,_tmp80_6__);
  SubBytes___5_y14 = XOR(_tmp80_4__,_tmp80_6__);
  SubBytes___5_y9 = XOR(_tmp80_1__,_tmp80_4__);
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
  _tmp83_1__ = XOR(_tmp83_1__,MixColumn___5__tmp58_);
  _tmp83_4__ = XOR(_tmp83_4__,_tmp83_0__);
  MixColumn___5__tmp11_ = PERMUT_16(_tmp83_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_7__ = XOR(_tmp83_7__,_tmp83_0__);
  MixColumn___5__tmp21_ = PERMUT_16(_tmp83_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_6__ = XOR(_tmp83_6__,MixColumn___5__tmp24_);
  _tmp83_2__ = XOR(_tmp83_2__,MixColumn___5__tmp51_);
  _tmp83_3__ = XOR(_tmp83_3__,MixColumn___5__tmp51_);
  _tmp83_5__ = XOR(_tmp83_5__,MixColumn___5__tmp34_);
  MixColumn___5__tmp62_ = PERMUT_16(_tmp83_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_1__ = XOR(_tmp83_1__,MixColumn___5__tmp5_);
  _tmp83_4__ = XOR(_tmp83_4__,MixColumn___5__tmp44_);
  MixColumn___5__tmp7_ = XOR(MixColumn___5__tmp7_,MixColumn___5__tmp11_);
  _tmp83_7__ = XOR(_tmp83_7__,MixColumn___5__tmp17_);
  _tmp83_6__ = XOR(_tmp83_6__,MixColumn___5__tmp28_);
  MixColumn___5__tmp55_ = PERMUT_16(_tmp83_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp83_2__ = XOR(_tmp83_2__,MixColumn___5__tmp58_);
  _tmp83_5__ = XOR(_tmp83_5__,MixColumn___5__tmp38_);
  _tmp83_1__ = XOR(_tmp83_1__,MixColumn___5__tmp69_);
  _tmp83_4__ = XOR(_tmp83_4__,MixColumn___5__tmp48_);
  MixColumn___5__tmp7_ = XOR(MixColumn___5__tmp7_,key__[5][7]);
  _tmp83_7__ = XOR(_tmp83_7__,MixColumn___5__tmp21_);
  _tmp83_6__ = XOR(_tmp83_6__,key__[5][5]);
  _tmp83_3__ = XOR(_tmp83_3__,MixColumn___5__tmp55_);
  _tmp83_2__ = XOR(_tmp83_2__,MixColumn___5__tmp62_);
  _tmp83_5__ = XOR(_tmp83_5__,key__[5][4]);
  _tmp83_1__ = XOR(_tmp83_1__,key__[5][0]);
  _tmp83_4__ = XOR(_tmp83_4__,key__[5][3]);
  _tmp83_7__ = XOR(_tmp83_7__,key__[5][6]);
  _tmp83_3__ = XOR(_tmp83_3__,key__[5][2]);
  _tmp83_2__ = XOR(_tmp83_2__,key__[5][1]);
  SubBytes___6_y8 = XOR(_tmp83_1__,_tmp83_6__);
  SubBytes___6_y14 = XOR(_tmp83_4__,_tmp83_6__);
  SubBytes___6_y9 = XOR(_tmp83_1__,_tmp83_4__);
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
  _tmp86_1__ = XOR(_tmp86_1__,MixColumn___6__tmp58_);
  _tmp86_4__ = XOR(_tmp86_4__,_tmp86_0__);
  MixColumn___6__tmp11_ = PERMUT_16(_tmp86_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_7__ = XOR(_tmp86_7__,_tmp86_0__);
  MixColumn___6__tmp21_ = PERMUT_16(_tmp86_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_6__ = XOR(_tmp86_6__,MixColumn___6__tmp24_);
  _tmp86_2__ = XOR(_tmp86_2__,MixColumn___6__tmp51_);
  _tmp86_3__ = XOR(_tmp86_3__,MixColumn___6__tmp51_);
  _tmp86_5__ = XOR(_tmp86_5__,MixColumn___6__tmp34_);
  MixColumn___6__tmp62_ = PERMUT_16(_tmp86_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_1__ = XOR(_tmp86_1__,MixColumn___6__tmp5_);
  _tmp86_4__ = XOR(_tmp86_4__,MixColumn___6__tmp44_);
  MixColumn___6__tmp7_ = XOR(MixColumn___6__tmp7_,MixColumn___6__tmp11_);
  _tmp86_7__ = XOR(_tmp86_7__,MixColumn___6__tmp17_);
  _tmp86_6__ = XOR(_tmp86_6__,MixColumn___6__tmp28_);
  MixColumn___6__tmp55_ = PERMUT_16(_tmp86_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp86_2__ = XOR(_tmp86_2__,MixColumn___6__tmp58_);
  _tmp86_5__ = XOR(_tmp86_5__,MixColumn___6__tmp38_);
  _tmp86_1__ = XOR(_tmp86_1__,MixColumn___6__tmp69_);
  _tmp86_4__ = XOR(_tmp86_4__,MixColumn___6__tmp48_);
  MixColumn___6__tmp7_ = XOR(MixColumn___6__tmp7_,key__[6][7]);
  _tmp86_7__ = XOR(_tmp86_7__,MixColumn___6__tmp21_);
  _tmp86_6__ = XOR(_tmp86_6__,key__[6][5]);
  _tmp86_3__ = XOR(_tmp86_3__,MixColumn___6__tmp55_);
  _tmp86_2__ = XOR(_tmp86_2__,MixColumn___6__tmp62_);
  _tmp86_5__ = XOR(_tmp86_5__,key__[6][4]);
  _tmp86_1__ = XOR(_tmp86_1__,key__[6][0]);
  _tmp86_4__ = XOR(_tmp86_4__,key__[6][3]);
  _tmp86_7__ = XOR(_tmp86_7__,key__[6][6]);
  _tmp86_3__ = XOR(_tmp86_3__,key__[6][2]);
  _tmp86_2__ = XOR(_tmp86_2__,key__[6][1]);
  SubBytes___7_y8 = XOR(_tmp86_1__,_tmp86_6__);
  SubBytes___7_y14 = XOR(_tmp86_4__,_tmp86_6__);
  SubBytes___7_y9 = XOR(_tmp86_1__,_tmp86_4__);
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
  _tmp89_1__ = XOR(_tmp89_1__,MixColumn___7__tmp58_);
  _tmp89_4__ = XOR(_tmp89_4__,_tmp89_0__);
  MixColumn___7__tmp11_ = PERMUT_16(_tmp89_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_7__ = XOR(_tmp89_7__,_tmp89_0__);
  MixColumn___7__tmp21_ = PERMUT_16(_tmp89_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_6__ = XOR(_tmp89_6__,MixColumn___7__tmp24_);
  _tmp89_2__ = XOR(_tmp89_2__,MixColumn___7__tmp51_);
  _tmp89_3__ = XOR(_tmp89_3__,MixColumn___7__tmp51_);
  _tmp89_5__ = XOR(_tmp89_5__,MixColumn___7__tmp34_);
  MixColumn___7__tmp62_ = PERMUT_16(_tmp89_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_1__ = XOR(_tmp89_1__,MixColumn___7__tmp5_);
  _tmp89_4__ = XOR(_tmp89_4__,MixColumn___7__tmp44_);
  MixColumn___7__tmp7_ = XOR(MixColumn___7__tmp7_,MixColumn___7__tmp11_);
  _tmp89_7__ = XOR(_tmp89_7__,MixColumn___7__tmp17_);
  _tmp89_6__ = XOR(_tmp89_6__,MixColumn___7__tmp28_);
  MixColumn___7__tmp55_ = PERMUT_16(_tmp89_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp89_2__ = XOR(_tmp89_2__,MixColumn___7__tmp58_);
  _tmp89_5__ = XOR(_tmp89_5__,MixColumn___7__tmp38_);
  _tmp89_1__ = XOR(_tmp89_1__,MixColumn___7__tmp69_);
  _tmp89_4__ = XOR(_tmp89_4__,MixColumn___7__tmp48_);
  MixColumn___7__tmp7_ = XOR(MixColumn___7__tmp7_,key__[7][7]);
  _tmp89_7__ = XOR(_tmp89_7__,MixColumn___7__tmp21_);
  _tmp89_6__ = XOR(_tmp89_6__,key__[7][5]);
  _tmp89_3__ = XOR(_tmp89_3__,MixColumn___7__tmp55_);
  _tmp89_2__ = XOR(_tmp89_2__,MixColumn___7__tmp62_);
  _tmp89_5__ = XOR(_tmp89_5__,key__[7][4]);
  _tmp89_1__ = XOR(_tmp89_1__,key__[7][0]);
  _tmp89_4__ = XOR(_tmp89_4__,key__[7][3]);
  _tmp89_7__ = XOR(_tmp89_7__,key__[7][6]);
  _tmp89_3__ = XOR(_tmp89_3__,key__[7][2]);
  _tmp89_2__ = XOR(_tmp89_2__,key__[7][1]);
  SubBytes___8_y8 = XOR(_tmp89_1__,_tmp89_6__);
  SubBytes___8_y14 = XOR(_tmp89_4__,_tmp89_6__);
  SubBytes___8_y9 = XOR(_tmp89_1__,_tmp89_4__);
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
  _tmp92_1__ = XOR(_tmp92_1__,MixColumn___8__tmp58_);
  _tmp92_4__ = XOR(_tmp92_4__,_tmp92_0__);
  MixColumn___8__tmp11_ = PERMUT_16(_tmp92_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_7__ = XOR(_tmp92_7__,_tmp92_0__);
  MixColumn___8__tmp21_ = PERMUT_16(_tmp92_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_6__ = XOR(_tmp92_6__,MixColumn___8__tmp24_);
  _tmp92_2__ = XOR(_tmp92_2__,MixColumn___8__tmp51_);
  _tmp92_3__ = XOR(_tmp92_3__,MixColumn___8__tmp51_);
  _tmp92_5__ = XOR(_tmp92_5__,MixColumn___8__tmp34_);
  MixColumn___8__tmp62_ = PERMUT_16(_tmp92_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_1__ = XOR(_tmp92_1__,MixColumn___8__tmp5_);
  _tmp92_4__ = XOR(_tmp92_4__,MixColumn___8__tmp44_);
  MixColumn___8__tmp7_ = XOR(MixColumn___8__tmp7_,MixColumn___8__tmp11_);
  _tmp92_7__ = XOR(_tmp92_7__,MixColumn___8__tmp17_);
  _tmp92_6__ = XOR(_tmp92_6__,MixColumn___8__tmp28_);
  MixColumn___8__tmp55_ = PERMUT_16(_tmp92_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp92_2__ = XOR(_tmp92_2__,MixColumn___8__tmp58_);
  _tmp92_5__ = XOR(_tmp92_5__,MixColumn___8__tmp38_);
  _tmp92_1__ = XOR(_tmp92_1__,MixColumn___8__tmp69_);
  _tmp92_4__ = XOR(_tmp92_4__,MixColumn___8__tmp48_);
  MixColumn___8__tmp7_ = XOR(MixColumn___8__tmp7_,key__[8][7]);
  _tmp92_7__ = XOR(_tmp92_7__,MixColumn___8__tmp21_);
  _tmp92_6__ = XOR(_tmp92_6__,key__[8][5]);
  _tmp92_3__ = XOR(_tmp92_3__,MixColumn___8__tmp55_);
  _tmp92_2__ = XOR(_tmp92_2__,MixColumn___8__tmp62_);
  _tmp92_5__ = XOR(_tmp92_5__,key__[8][4]);
  _tmp92_1__ = XOR(_tmp92_1__,key__[8][0]);
  _tmp92_4__ = XOR(_tmp92_4__,key__[8][3]);
  _tmp92_7__ = XOR(_tmp92_7__,key__[8][6]);
  _tmp92_3__ = XOR(_tmp92_3__,key__[8][2]);
  _tmp92_2__ = XOR(_tmp92_2__,key__[8][1]);
  SubBytes___9_y8 = XOR(_tmp92_1__,_tmp92_6__);
  SubBytes___9_y14 = XOR(_tmp92_4__,_tmp92_6__);
  SubBytes___9_y9 = XOR(_tmp92_1__,_tmp92_4__);
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
  _tmp95_1__ = XOR(_tmp95_1__,MixColumn___9__tmp58_);
  _tmp95_4__ = XOR(_tmp95_4__,_tmp95_0__);
  MixColumn___9__tmp11_ = PERMUT_16(_tmp95_7__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_7__ = XOR(_tmp95_7__,_tmp95_0__);
  MixColumn___9__tmp21_ = PERMUT_16(_tmp95_6__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_6__ = XOR(_tmp95_6__,MixColumn___9__tmp24_);
  _tmp95_2__ = XOR(_tmp95_2__,MixColumn___9__tmp51_);
  _tmp95_3__ = XOR(_tmp95_3__,MixColumn___9__tmp51_);
  _tmp95_5__ = XOR(_tmp95_5__,MixColumn___9__tmp34_);
  MixColumn___9__tmp62_ = PERMUT_16(_tmp95_1__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_1__ = XOR(_tmp95_1__,MixColumn___9__tmp5_);
  _tmp95_4__ = XOR(_tmp95_4__,MixColumn___9__tmp44_);
  MixColumn___9__tmp7_ = XOR(MixColumn___9__tmp7_,MixColumn___9__tmp11_);
  _tmp95_7__ = XOR(_tmp95_7__,MixColumn___9__tmp17_);
  _tmp95_6__ = XOR(_tmp95_6__,MixColumn___9__tmp28_);
  MixColumn___9__tmp55_ = PERMUT_16(_tmp95_2__,2,3,0,1,6,7,4,5,10,11,8,9,14,15,12,13);
  _tmp95_2__ = XOR(_tmp95_2__,MixColumn___9__tmp58_);
  _tmp95_5__ = XOR(_tmp95_5__,MixColumn___9__tmp38_);
  _tmp95_1__ = XOR(_tmp95_1__,MixColumn___9__tmp69_);
  _tmp95_4__ = XOR(_tmp95_4__,MixColumn___9__tmp48_);
  MixColumn___9__tmp7_ = XOR(MixColumn___9__tmp7_,key__[9][7]);
  _tmp95_7__ = XOR(_tmp95_7__,MixColumn___9__tmp21_);
  _tmp95_6__ = XOR(_tmp95_6__,key__[9][5]);
  _tmp95_3__ = XOR(_tmp95_3__,MixColumn___9__tmp55_);
  _tmp95_2__ = XOR(_tmp95_2__,MixColumn___9__tmp62_);
  _tmp95_5__ = XOR(_tmp95_5__,key__[9][4]);
  _tmp95_1__ = XOR(_tmp95_1__,key__[9][0]);
  _tmp95_4__ = XOR(_tmp95_4__,key__[9][3]);
  _tmp95_7__ = XOR(_tmp95_7__,key__[9][6]);
  _tmp95_3__ = XOR(_tmp95_3__,key__[9][2]);
  _tmp95_2__ = XOR(_tmp95_2__,key__[9][1]);
  SubBytes___10_y8 = XOR(_tmp95_1__,_tmp95_6__);
  SubBytes___10_y14 = XOR(_tmp95_4__,_tmp95_6__);
  SubBytes___10_y9 = XOR(_tmp95_1__,_tmp95_4__);
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



#else
#error You need to define MACRO or KIVI
#endif
