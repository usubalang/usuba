#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define DATATYPE uint32_t
#include "STD.h"


void SubBytes__ (/*inputs*/ DATATYPE s0__,DATATYPE s1__,DATATYPE s2__,DATATYPE s3__, /*outputs*/ DATATYPE ret__[4]) {
  
  // Variables declaration
  DATATYPE _shadow_s0__1_;
  DATATYPE _shadow_s0__3_;
  DATATYPE _shadow_s1__4_;
  DATATYPE _shadow_s1__7_;
  DATATYPE _shadow_s2__5_;
  DATATYPE _shadow_s2__6_;
  DATATYPE _shadow_s3__2_;
  DATATYPE _shadow_s3__8_;
  DATATYPE _tmp1_;
  DATATYPE _tmp2_;
  DATATYPE _tmp3_;
  DATATYPE _tmp4_;

  // Instructions (body)
  _shadow_s0__1_ = XOR(s0__,s3__);
  _tmp2_ = AND(s1__,s2__);
  _tmp1_ = AND(_shadow_s0__1_,s1__);
  _shadow_s0__3_ = XOR(_shadow_s0__1_,_tmp2_);
  _shadow_s3__2_ = XOR(s3__,_tmp1_);
  ret__[0] = _shadow_s0__3_;
  _tmp3_ = AND(s2__,_shadow_s3__2_);
  _tmp4_ = AND(_shadow_s0__3_,_shadow_s3__2_);
  _shadow_s3__8_ = NOT(_shadow_s3__2_);
  _shadow_s1__4_ = XOR(s1__,_tmp3_);
  _shadow_s2__5_ = XOR(s2__,_tmp4_);
  ret__[2] = _shadow_s3__8_;
  _shadow_s1__7_ = XOR(_shadow_s1__4_,_shadow_s0__3_);
  _shadow_s2__6_ = XOR(_shadow_s2__5_,_shadow_s1__4_);
  ret__[1] = _shadow_s1__7_;
  ret__[3] = _shadow_s2__6_;

}

void sub_bytes_128(uint32_t *state)
{
    state[0] ^= state[3];
    state[3] ^= state[0] & state[1];
    state[0] ^= state[1] & state[2];
    state[1] ^= state[2] & state[3];
    state[2] ^= state[0] & state[3];
    state[2] ^= state[1];
    state[1] ^= state[0];
    state[3] = ~state[3];

    // swap state[2] <-> state[3]
    state[2] ^= state[3];
    state[3] ^= state[2];
    state[2] ^= state[3];
}

int main() {
  
  for (uint32_t s0 = 0; s0 <= 1; s0++)
    for (uint32_t s1 = 0; s1 <= 1; s1++)
      for (uint32_t s2 = 0; s2 <= 1; s2++)
        for (uint32_t s3 = 0; s3 <= 1; s3++) {
          uint32_t state[4] = { s0, s1, s2, s3 };
          sub_bytes_128(state);
          uint32_t stateR[4];
          SubBytes__(s0,s1,s2,s3,stateR);
          for (int i = 0; i < 4; i++) {
            if (state[i] != stateR[i]) {
              printf("Error!!\n");
            }
          }
        }
    
    
    
}
