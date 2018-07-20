
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
#include "AVX.h"

/* auxiliary functions */
static void QR_start__ (/*inputs*/ DATATYPE a__,DATATYPE b__,DATATYPE c__,DATATYPE d__, /*outputs*/ DATATYPE* aR__,DATATYPE* bR__,DATATYPE* cR__,DATATYPE* dR__) {
  
  // Variables declaration
  DATATYPE _tmp1_;
  DATATYPE _tmp2_;


  // Instructions (body)
  *aR__ = ADD(a__,b__,32);
  _tmp1_ = XOR(d__,*aR__);
  *dR__ = L_ROTATE(_tmp1_,16,32);
  *cR__ = ADD(c__,*dR__,32);
  _tmp2_ = XOR(b__,*cR__);
  *bR__ = L_ROTATE(_tmp2_,12,32);

}

static void QR_end__ (/*inputs*/ DATATYPE a__,DATATYPE b__,DATATYPE c__,DATATYPE d__, /*outputs*/ DATATYPE* aR__,DATATYPE* bR__,DATATYPE* cR__,DATATYPE* dR__) {
  
  // Variables declaration
  DATATYPE _tmp3_;
  DATATYPE _tmp4_;


  // Instructions (body)
  *aR__ = ADD(a__,b__,32);
  _tmp3_ = XOR(d__,*aR__);
  *dR__ = L_ROTATE(_tmp3_,8,32);
  *cR__ = ADD(c__,*dR__,32);
  _tmp4_ = XOR(b__,*cR__);
  *bR__ = L_ROTATE(_tmp4_,7,32);

}

static void QR__ (/*inputs*/ DATATYPE input__0__,DATATYPE input__1__,DATATYPE input__2__,DATATYPE input__3__, /*outputs*/ DATATYPE* output__0__,DATATYPE* output__1__,DATATYPE* output__2__,DATATYPE* output__3__) {
  
  // Variables declaration
  DATATYPE _tmp5_[4];


  // Instructions (body)
  QR_start__(input__0__,input__1__,input__2__,input__3__,&_tmp5_[0],&_tmp5_[1],&_tmp5_[2],&_tmp5_[3]);
  QR_end__(_tmp5_[0],_tmp5_[1],_tmp5_[2],_tmp5_[3],&*output__0__,&*output__1__,&*output__2__,&*output__3__);

}

static void DR_start__ (/*inputs*/ DATATYPE state__[16], /*outputs*/ DATATYPE stateR__[16]) {
  
  // Variables declaration


  // Instructions (body)
  QR__(state__[0],state__[4],state__[8],state__[12],&stateR__[0],&stateR__[4],&stateR__[8],&stateR__[12]);
  QR__(state__[1],state__[5],state__[9],state__[13],&stateR__[1],&stateR__[5],&stateR__[9],&stateR__[13]);
  QR__(state__[2],state__[6],state__[10],state__[14],&stateR__[2],&stateR__[6],&stateR__[10],&stateR__[14]);
  QR__(state__[3],state__[7],state__[11],state__[15],&stateR__[3],&stateR__[7],&stateR__[11],&stateR__[15]);

}

static void DR_end__ (/*inputs*/ DATATYPE state__[16], /*outputs*/ DATATYPE stateR__[16]) {
  
  // Variables declaration


  // Instructions (body)
  QR__(state__[0],state__[5],state__[10],state__[15],&stateR__[0],&stateR__[5],&stateR__[10],&stateR__[15]);
  QR__(state__[1],state__[6],state__[11],state__[12],&stateR__[1],&stateR__[6],&stateR__[11],&stateR__[12]);
  QR__(state__[2],state__[7],state__[8],state__[13],&stateR__[2],&stateR__[7],&stateR__[8],&stateR__[13]);
  QR__(state__[3],state__[4],state__[9],state__[14],&stateR__[3],&stateR__[4],&stateR__[9],&stateR__[14]);

}

static void DR__ (/*inputs*/ DATATYPE state__[16], /*outputs*/ DATATYPE stateR__[16]) {
  
  // Variables declaration
  DATATYPE _tmp6_[16];


  // Instructions (body)
  DR_start__(state__,_tmp6_);
  DR_end__(_tmp6_,stateR__);

}

/* main function */
void Chacha20__ (/*inputs*/ DATATYPE plain__[16], /*outputs*/ DATATYPE cipher__[16]) {
  
  // Variables declaration
  DATATYPE state__[16];


  // Instructions (body)
  state__[0] = plain__[0];
  state__[1] = plain__[1];
  state__[2] = plain__[2];
  state__[3] = plain__[3];
  state__[4] = plain__[4];
  state__[5] = plain__[5];
  state__[6] = plain__[6];
  state__[7] = plain__[7];
  state__[8] = plain__[8];
  state__[9] = plain__[9];
  state__[10] = plain__[10];
  state__[11] = plain__[11];
  state__[12] = plain__[12];
  state__[13] = plain__[13];
  state__[14] = plain__[14];
  state__[15] = plain__[15];
  for (int i = 1; i <= 10; i++) {
    DR__(state__,state__);
  }
  cipher__[0] = state__[0];
  cipher__[1] = state__[1];
  cipher__[2] = state__[2];
  cipher__[3] = state__[3];
  cipher__[4] = state__[4];
  cipher__[5] = state__[5];
  cipher__[6] = state__[6];
  cipher__[7] = state__[7];
  cipher__[8] = state__[8];
  cipher__[9] = state__[9];
  cipher__[10] = state__[10];
  cipher__[11] = state__[11];
  cipher__[12] = state__[12];
  cipher__[13] = state__[13];
  cipher__[14] = state__[14];
  cipher__[15] = state__[15];

}
 
