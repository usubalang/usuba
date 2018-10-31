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

#else
#error You need to define MACRO or KIVI
#endif
