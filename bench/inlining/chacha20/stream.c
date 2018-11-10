/*
chacha.c version $Date: 2014/09/08 17:38:05 $
D. J. Bernstein
Romain Dolbeau
Public domain.
*/

#include <stdint.h>

#define u8 uint8_t
#define u32 uint32_t
#define u64 uint64_t



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

void Chacha20__ (__m128i plain__[16], __m128i cipher__[16]);
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
