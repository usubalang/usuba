/*
chacha.c version $Date: 2014/09/08 17:38:05 $
D. J. Bernstein
Romain Dolbeau
Public domain.
*/

#include <stdint.h>
#include "crypto_stream.h"

#define u8 uint8_t
#define u32 uint32_t
#define u64 uint64_t


/* including the architecture specific .h */
#define NO_RUNTIME
#include "SSE.h"

/* auxiliary functions */
static inline __attribute__((always_inline)) void DR__ (/*inputs*/ DATATYPE state__[16], /*outputs*/ DATATYPE stateR__[16])  {
  
  // Variables declaration
  DATATYPE DR_end___1_QR___1_QR_end___1__tmp3_;
  DATATYPE DR_end___1_QR___1_QR_end___1__tmp4_;
  DATATYPE DR_end___1_QR___1_QR_start___1__tmp1_;
  DATATYPE DR_end___1_QR___1_QR_start___1__tmp2_;
  DATATYPE DR_end___1_QR___1__tmp5_[4];
  DATATYPE DR_end___1_QR___2_QR_end___1__tmp3_;
  DATATYPE DR_end___1_QR___2_QR_end___1__tmp4_;
  DATATYPE DR_end___1_QR___2_QR_start___1__tmp1_;
  DATATYPE DR_end___1_QR___2_QR_start___1__tmp2_;
  DATATYPE DR_end___1_QR___2__tmp5_[4];
  DATATYPE DR_end___1_QR___3_QR_end___1__tmp3_;
  DATATYPE DR_end___1_QR___3_QR_end___1__tmp4_;
  DATATYPE DR_end___1_QR___3_QR_start___1__tmp1_;
  DATATYPE DR_end___1_QR___3_QR_start___1__tmp2_;
  DATATYPE DR_end___1_QR___3__tmp5_[4];
  DATATYPE DR_end___1_QR___4_QR_end___1__tmp3_;
  DATATYPE DR_end___1_QR___4_QR_end___1__tmp4_;
  DATATYPE DR_end___1_QR___4_QR_start___1__tmp1_;
  DATATYPE DR_end___1_QR___4_QR_start___1__tmp2_;
  DATATYPE DR_end___1_QR___4__tmp5_[4];
  DATATYPE DR_start___1_QR___1_QR_end___1__tmp3_;
  DATATYPE DR_start___1_QR___1_QR_end___1__tmp4_;
  DATATYPE DR_start___1_QR___1_QR_start___1__tmp1_;
  DATATYPE DR_start___1_QR___1_QR_start___1__tmp2_;
  DATATYPE DR_start___1_QR___1__tmp5_[4];
  DATATYPE DR_start___1_QR___2_QR_end___1__tmp3_;
  DATATYPE DR_start___1_QR___2_QR_end___1__tmp4_;
  DATATYPE DR_start___1_QR___2_QR_start___1__tmp1_;
  DATATYPE DR_start___1_QR___2_QR_start___1__tmp2_;
  DATATYPE DR_start___1_QR___2__tmp5_[4];
  DATATYPE DR_start___1_QR___3_QR_end___1__tmp3_;
  DATATYPE DR_start___1_QR___3_QR_end___1__tmp4_;
  DATATYPE DR_start___1_QR___3_QR_start___1__tmp1_;
  DATATYPE DR_start___1_QR___3_QR_start___1__tmp2_;
  DATATYPE DR_start___1_QR___3__tmp5_[4];
  DATATYPE DR_start___1_QR___4_QR_end___1__tmp3_;
  DATATYPE DR_start___1_QR___4_QR_end___1__tmp4_;
  DATATYPE DR_start___1_QR___4_QR_start___1__tmp1_;
  DATATYPE DR_start___1_QR___4_QR_start___1__tmp2_;
  DATATYPE DR_start___1_QR___4__tmp5_[4];
  DATATYPE _tmp6_[16];


  // Instructions (body)
  DR_start___1_QR___1__tmp5_[0] = ADD(state__[0],state__[4],32);
  DR_start___1_QR___2__tmp5_[0] = ADD(state__[1],state__[5],32);
  DR_start___1_QR___3__tmp5_[0] = ADD(state__[2],state__[6],32);
  DR_start___1_QR___4__tmp5_[0] = ADD(state__[3],state__[7],32);
  DR_start___1_QR___1_QR_start___1__tmp1_ = XOR(state__[12],DR_start___1_QR___1__tmp5_[0]);
  DR_start___1_QR___2_QR_start___1__tmp1_ = XOR(state__[13],DR_start___1_QR___2__tmp5_[0]);
  DR_start___1_QR___3_QR_start___1__tmp1_ = XOR(state__[14],DR_start___1_QR___3__tmp5_[0]);
  DR_start___1_QR___4_QR_start___1__tmp1_ = XOR(state__[15],DR_start___1_QR___4__tmp5_[0]);
  DR_start___1_QR___1__tmp5_[3] = L_ROTATE(DR_start___1_QR___1_QR_start___1__tmp1_,16,32);
  DR_start___1_QR___2__tmp5_[3] = L_ROTATE(DR_start___1_QR___2_QR_start___1__tmp1_,16,32);
  DR_start___1_QR___3__tmp5_[3] = L_ROTATE(DR_start___1_QR___3_QR_start___1__tmp1_,16,32);
  DR_start___1_QR___4__tmp5_[3] = L_ROTATE(DR_start___1_QR___4_QR_start___1__tmp1_,16,32);
  DR_start___1_QR___1__tmp5_[2] = ADD(state__[8],DR_start___1_QR___1__tmp5_[3],32);
  DR_start___1_QR___2__tmp5_[2] = ADD(state__[9],DR_start___1_QR___2__tmp5_[3],32);
  DR_start___1_QR___3__tmp5_[2] = ADD(state__[10],DR_start___1_QR___3__tmp5_[3],32);
  DR_start___1_QR___4__tmp5_[2] = ADD(state__[11],DR_start___1_QR___4__tmp5_[3],32);
  DR_start___1_QR___1_QR_start___1__tmp2_ = XOR(state__[4],DR_start___1_QR___1__tmp5_[2]);
  DR_start___1_QR___2_QR_start___1__tmp2_ = XOR(state__[5],DR_start___1_QR___2__tmp5_[2]);
  DR_start___1_QR___3_QR_start___1__tmp2_ = XOR(state__[6],DR_start___1_QR___3__tmp5_[2]);
  DR_start___1_QR___4_QR_start___1__tmp2_ = XOR(state__[7],DR_start___1_QR___4__tmp5_[2]);
  DR_start___1_QR___1__tmp5_[1] = L_ROTATE(DR_start___1_QR___1_QR_start___1__tmp2_,12,32);
  DR_start___1_QR___2__tmp5_[1] = L_ROTATE(DR_start___1_QR___2_QR_start___1__tmp2_,12,32);
  DR_start___1_QR___3__tmp5_[1] = L_ROTATE(DR_start___1_QR___3_QR_start___1__tmp2_,12,32);
  DR_start___1_QR___4__tmp5_[1] = L_ROTATE(DR_start___1_QR___4_QR_start___1__tmp2_,12,32);
  _tmp6_[0] = ADD(DR_start___1_QR___1__tmp5_[0],DR_start___1_QR___1__tmp5_[1],32);
  _tmp6_[1] = ADD(DR_start___1_QR___2__tmp5_[0],DR_start___1_QR___2__tmp5_[1],32);
  _tmp6_[2] = ADD(DR_start___1_QR___3__tmp5_[0],DR_start___1_QR___3__tmp5_[1],32);
  _tmp6_[3] = ADD(DR_start___1_QR___4__tmp5_[0],DR_start___1_QR___4__tmp5_[1],32);
  DR_start___1_QR___1_QR_end___1__tmp3_ = XOR(DR_start___1_QR___1__tmp5_[3],_tmp6_[0]);
  DR_start___1_QR___2_QR_end___1__tmp3_ = XOR(DR_start___1_QR___2__tmp5_[3],_tmp6_[1]);
  DR_start___1_QR___3_QR_end___1__tmp3_ = XOR(DR_start___1_QR___3__tmp5_[3],_tmp6_[2]);
  DR_start___1_QR___4_QR_end___1__tmp3_ = XOR(DR_start___1_QR___4__tmp5_[3],_tmp6_[3]);
  _tmp6_[12] = L_ROTATE(DR_start___1_QR___1_QR_end___1__tmp3_,8,32);
  _tmp6_[13] = L_ROTATE(DR_start___1_QR___2_QR_end___1__tmp3_,8,32);
  _tmp6_[14] = L_ROTATE(DR_start___1_QR___3_QR_end___1__tmp3_,8,32);
  _tmp6_[15] = L_ROTATE(DR_start___1_QR___4_QR_end___1__tmp3_,8,32);
  _tmp6_[8] = ADD(DR_start___1_QR___1__tmp5_[2],_tmp6_[12],32);
  _tmp6_[9] = ADD(DR_start___1_QR___2__tmp5_[2],_tmp6_[13],32);
  _tmp6_[10] = ADD(DR_start___1_QR___3__tmp5_[2],_tmp6_[14],32);
  _tmp6_[11] = ADD(DR_start___1_QR___4__tmp5_[2],_tmp6_[15],32);
  DR_start___1_QR___1_QR_end___1__tmp4_ = XOR(DR_start___1_QR___1__tmp5_[1],_tmp6_[8]);
  DR_start___1_QR___2_QR_end___1__tmp4_ = XOR(DR_start___1_QR___2__tmp5_[1],_tmp6_[9]);
  DR_start___1_QR___3_QR_end___1__tmp4_ = XOR(DR_start___1_QR___3__tmp5_[1],_tmp6_[10]);
  DR_start___1_QR___4_QR_end___1__tmp4_ = XOR(DR_start___1_QR___4__tmp5_[1],_tmp6_[11]);
  _tmp6_[4] = L_ROTATE(DR_start___1_QR___1_QR_end___1__tmp4_,7,32);
  _tmp6_[5] = L_ROTATE(DR_start___1_QR___2_QR_end___1__tmp4_,7,32);
  _tmp6_[6] = L_ROTATE(DR_start___1_QR___3_QR_end___1__tmp4_,7,32);
  _tmp6_[7] = L_ROTATE(DR_start___1_QR___4_QR_end___1__tmp4_,7,32);
  DR_end___1_QR___4__tmp5_[0] = ADD(_tmp6_[3],_tmp6_[4],32);
  DR_end___1_QR___1__tmp5_[0] = ADD(_tmp6_[0],_tmp6_[5],32);
  DR_end___1_QR___2__tmp5_[0] = ADD(_tmp6_[1],_tmp6_[6],32);
  DR_end___1_QR___3__tmp5_[0] = ADD(_tmp6_[2],_tmp6_[7],32);
  DR_end___1_QR___4_QR_start___1__tmp1_ = XOR(_tmp6_[14],DR_end___1_QR___4__tmp5_[0]);
  DR_end___1_QR___1_QR_start___1__tmp1_ = XOR(_tmp6_[15],DR_end___1_QR___1__tmp5_[0]);
  DR_end___1_QR___2_QR_start___1__tmp1_ = XOR(_tmp6_[12],DR_end___1_QR___2__tmp5_[0]);
  DR_end___1_QR___3_QR_start___1__tmp1_ = XOR(_tmp6_[13],DR_end___1_QR___3__tmp5_[0]);
  DR_end___1_QR___4__tmp5_[3] = L_ROTATE(DR_end___1_QR___4_QR_start___1__tmp1_,16,32);
  DR_end___1_QR___1__tmp5_[3] = L_ROTATE(DR_end___1_QR___1_QR_start___1__tmp1_,16,32);
  DR_end___1_QR___2__tmp5_[3] = L_ROTATE(DR_end___1_QR___2_QR_start___1__tmp1_,16,32);
  DR_end___1_QR___3__tmp5_[3] = L_ROTATE(DR_end___1_QR___3_QR_start___1__tmp1_,16,32);
  DR_end___1_QR___4__tmp5_[2] = ADD(_tmp6_[9],DR_end___1_QR___4__tmp5_[3],32);
  DR_end___1_QR___1__tmp5_[2] = ADD(_tmp6_[10],DR_end___1_QR___1__tmp5_[3],32);
  DR_end___1_QR___2__tmp5_[2] = ADD(_tmp6_[11],DR_end___1_QR___2__tmp5_[3],32);
  DR_end___1_QR___3__tmp5_[2] = ADD(_tmp6_[8],DR_end___1_QR___3__tmp5_[3],32);
  DR_end___1_QR___4_QR_start___1__tmp2_ = XOR(_tmp6_[4],DR_end___1_QR___4__tmp5_[2]);
  DR_end___1_QR___1_QR_start___1__tmp2_ = XOR(_tmp6_[5],DR_end___1_QR___1__tmp5_[2]);
  DR_end___1_QR___2_QR_start___1__tmp2_ = XOR(_tmp6_[6],DR_end___1_QR___2__tmp5_[2]);
  DR_end___1_QR___3_QR_start___1__tmp2_ = XOR(_tmp6_[7],DR_end___1_QR___3__tmp5_[2]);
  DR_end___1_QR___4__tmp5_[1] = L_ROTATE(DR_end___1_QR___4_QR_start___1__tmp2_,12,32);
  DR_end___1_QR___1__tmp5_[1] = L_ROTATE(DR_end___1_QR___1_QR_start___1__tmp2_,12,32);
  DR_end___1_QR___2__tmp5_[1] = L_ROTATE(DR_end___1_QR___2_QR_start___1__tmp2_,12,32);
  DR_end___1_QR___3__tmp5_[1] = L_ROTATE(DR_end___1_QR___3_QR_start___1__tmp2_,12,32);
  stateR__[3] = ADD(DR_end___1_QR___4__tmp5_[0],DR_end___1_QR___4__tmp5_[1],32);
  stateR__[0] = ADD(DR_end___1_QR___1__tmp5_[0],DR_end___1_QR___1__tmp5_[1],32);
  stateR__[1] = ADD(DR_end___1_QR___2__tmp5_[0],DR_end___1_QR___2__tmp5_[1],32);
  stateR__[2] = ADD(DR_end___1_QR___3__tmp5_[0],DR_end___1_QR___3__tmp5_[1],32);
  DR_end___1_QR___4_QR_end___1__tmp3_ = XOR(DR_end___1_QR___4__tmp5_[3],stateR__[3]);
  DR_end___1_QR___1_QR_end___1__tmp3_ = XOR(DR_end___1_QR___1__tmp5_[3],stateR__[0]);
  DR_end___1_QR___2_QR_end___1__tmp3_ = XOR(DR_end___1_QR___2__tmp5_[3],stateR__[1]);
  DR_end___1_QR___3_QR_end___1__tmp3_ = XOR(DR_end___1_QR___3__tmp5_[3],stateR__[2]);
  stateR__[14] = L_ROTATE(DR_end___1_QR___4_QR_end___1__tmp3_,8,32);
  stateR__[15] = L_ROTATE(DR_end___1_QR___1_QR_end___1__tmp3_,8,32);
  stateR__[12] = L_ROTATE(DR_end___1_QR___2_QR_end___1__tmp3_,8,32);
  stateR__[13] = L_ROTATE(DR_end___1_QR___3_QR_end___1__tmp3_,8,32);
  stateR__[9] = ADD(DR_end___1_QR___4__tmp5_[2],stateR__[14],32);
  stateR__[10] = ADD(DR_end___1_QR___1__tmp5_[2],stateR__[15],32);
  stateR__[11] = ADD(DR_end___1_QR___2__tmp5_[2],stateR__[12],32);
  stateR__[8] = ADD(DR_end___1_QR___3__tmp5_[2],stateR__[13],32);
  DR_end___1_QR___4_QR_end___1__tmp4_ = XOR(DR_end___1_QR___4__tmp5_[1],stateR__[9]);
  DR_end___1_QR___1_QR_end___1__tmp4_ = XOR(DR_end___1_QR___1__tmp5_[1],stateR__[10]);
  DR_end___1_QR___2_QR_end___1__tmp4_ = XOR(DR_end___1_QR___2__tmp5_[1],stateR__[11]);
  DR_end___1_QR___3_QR_end___1__tmp4_ = XOR(DR_end___1_QR___3__tmp5_[1],stateR__[8]);
  stateR__[4] = L_ROTATE(DR_end___1_QR___4_QR_end___1__tmp4_,7,32);
  stateR__[5] = L_ROTATE(DR_end___1_QR___1_QR_end___1__tmp4_,7,32);
  stateR__[6] = L_ROTATE(DR_end___1_QR___2_QR_end___1__tmp4_,7,32);
  stateR__[7] = L_ROTATE(DR_end___1_QR___3_QR_end___1__tmp4_,7,32);

}


#undef ZERO
#undef ONES
#undef REG_SIZE
#undef CHUNK_SIZE
#undef AND
#undef OR
#undef XOR
#undef ANDN
#undef NOT
#undef ADD
#undef L_SHIFT
#undef R_SHIFT
#undef L_ROTATE
#undef R_ROTATE
#undef DATATYPE
#undef SET_ALL_ONE
#undef SET_ALL_ZERO
#undef PERMUT_16
#undef PERMUT_4
#undef ORTHOGONALIZE
#undef UNORTHOGONALIZE
#undef ALLOC

#define U32V(v) ((u32)(v) & U32C(0xFFFFFFFF))
#define ROTL32(v, n) \
  (U32V((v) << (n)) | ((v) >> (32 - (n))))
#define U32TO8_LITTLE(p, v) (((u32*)(p))[0] = U32TO32_LITTLE(v))
#define U8TO32_LITTLE(p) \
  (((u32)((p)[0])      ) | \
   ((u32)((p)[1]) <<  8) | \
   ((u32)((p)[2]) << 16) | \
   ((u32)((p)[3]) << 24))
#define U32C(v) (v##U)
#define U32TO32_LITTLE(v) (v)


#include <immintrin.h>
#include <stdio.h>
#define ROUNDS 20

#define ROTATE(v,c) (ROTL32(v,c))
#define XOR(v,w) ((v) ^ (w))
#define PLUS(v,w) (U32V((v) + (w)))
#define PLUSONE(v) (PLUS((v),1))

#define QUARTERROUND(a,b,c,d) \
  x[a] = PLUS(x[a],x[b]); x[d] = ROTATE(XOR(x[d],x[a]),16); \
  x[c] = PLUS(x[c],x[d]); x[b] = ROTATE(XOR(x[b],x[c]),12); \
  x[a] = PLUS(x[a],x[b]); x[d] = ROTATE(XOR(x[d],x[a]), 8); \
  x[c] = PLUS(x[c],x[d]); x[b] = ROTATE(XOR(x[b],x[c]), 7);

static void salsa20_wordtobyte(u8 output[64],const u32 input[16])
{
  u32 x[16];
  int i;

  for (i = 0;i < 16;++i) x[i] = input[i];
  for (i = ROUNDS;i > 0;i -= 2) {
    QUARTERROUND( 0, 4, 8,12)
    QUARTERROUND( 1, 5, 9,13)
    QUARTERROUND( 2, 6,10,14)
    QUARTERROUND( 3, 7,11,15)
    QUARTERROUND( 0, 5,10,15)
    QUARTERROUND( 1, 6,11,12)
    QUARTERROUND( 2, 7, 8,13)
    QUARTERROUND( 3, 4, 9,14)
  }
  for (i = 0;i < 16;++i) x[i] = PLUS(x[i],input[i]);
  for (i = 0;i < 16;++i) U32TO8_LITTLE(output + 4 * i,x[i]);
}

static const char sigma[16] = "expand 32-byte k";


void keysetup(u32 x[16],const u8 *k)
{
  const char *constants;

  x[4] = U8TO32_LITTLE(k + 0);
  x[5] = U8TO32_LITTLE(k + 4);
  x[6] = U8TO32_LITTLE(k + 8);
  x[7] = U8TO32_LITTLE(k + 12);
  k += 16;
  constants = sigma;
  x[8] = U8TO32_LITTLE(k + 0);
  x[9] = U8TO32_LITTLE(k + 4);
  x[10] = U8TO32_LITTLE(k + 8);
  x[11] = U8TO32_LITTLE(k + 12);
  x[0] = U8TO32_LITTLE(constants + 0);
  x[1] = U8TO32_LITTLE(constants + 4);
  x[2] = U8TO32_LITTLE(constants + 8);
  x[3] = U8TO32_LITTLE(constants + 12);
}

void ivsetup(u32 x[16],const u8 *iv)
{
  x[12] = 0;
  x[13] = 0;
  x[14] = U8TO32_LITTLE(iv + 0);
  x[15] = U8TO32_LITTLE(iv + 4);
}

void crypto_stream_xor_inner(u32 x[16],const u8 *m,u8 *c_,u32 bytes)
{
  u8 output[64];
  unsigned int i;
  u8* out = c_;

#include "u4.h"
  
}

int crypto_stream_xor( unsigned char *out,
                       const unsigned char *in,
                       unsigned long long inlen,
                       const unsigned char *n,
                       const unsigned char *k
                       )
{
  u32 state[16];
  keysetup(state,k);
  ivsetup(state,n);

  crypto_stream_xor_inner(state,in,out,inlen);
  

  return 0;
}

int crypto_stream(unsigned char *out,
                  unsigned long long outlen,
                  const unsigned char *n,
                  const unsigned char *k
                  )
{
  u32 in[outlen];
  for (unsigned int i = 0; i < outlen; i++) in[i] = 0;
  return crypto_stream_xor(out,(unsigned char*)in,outlen,n,k);

}
