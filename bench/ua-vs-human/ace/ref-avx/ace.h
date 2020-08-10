/* Reference implementation of ACE-128, AEAD
 Written by:
 Kalikinkar Mandal <kmandal@uwaterloo.ca>
 */

#ifndef ACE_H
#define ACE_H

#include<stdint.h>
#include<x86intrin.h>
//#include<smmintrin.h>
//#include <immintrin.h>

#define STATEBYTES	40
#define STATEDWORD	10 // 320/32 = 8//
#define SIMECKROUND	8
#define NUMSTEPS	16
#define PARAL_INST_BY8	1

static const unsigned char SC0[16]={0x50,0x5c,0x91,0x8d,0x53,0x60,0x68,0xe1,0xf6,0x9d,0x40,0x4f,0xbe,0x5b,0xe9,0x7f}; //Step constants (SC_{2i})
static const unsigned char SC1[16]={0x28,0xae,0x48,0xc6,0xa9,0x30,0x34,0x70,0x7b,0xce,0x20,0x27,0x5f,0xad,0x74,0x3f}; //Step constants (SC_{2i+1})
static const unsigned char SC2[16]={0x14,0x57,0x24,0x63,0x54,0x18,0x9a,0x38,0xbd,0x67,0x10,0x13,0x2f,0xd6,0xba,0x1f}; //Step constants (SC_{2i+2})

static const unsigned char RC0[16]={0x07,0x0a,0x9b,0xe0,0xd1,0x1a,0x22,0xf7,0x62,0x96,0x71,0xaa,0x2b,0xe9,0xcf,0xb7};//Round constants (RC_{2i})
static const unsigned char RC1[16]={0x53,0x5d,0x49,0x7f,0xbe,0x1d,0x28,0x6c,0x82,0x47,0x6b,0x88,0xdc,0x8b,0x59,0xc6};//Round constants (RC_{2i+1})
static const unsigned char RC2[16]={0x43,0xe4,0x5e,0xcc,0x32,0x4e,0x75,0x25,0xfd,0xf9,0x76,0xa0,0xb0,0x09,0x1e,0xad};//Round constants (RC_{2i+2})

typedef unsigned long long int u64;
typedef unsigned int u32;
typedef unsigned int u8;

#define ROT5(x) (_mm256_slli_epi32(x, 5) | _mm256_srli_epi32(x, 27))
#define ROT1(x) (_mm256_slli_epi32(x, 1) | _mm256_srli_epi32(x, 31))
#define SWAPREG1(x) (_mm256_permutevar8x32_epi32(x, _mm256_set_epi32(7, 5, 3, 1, 6, 4, 2, 0)))
#define RC(t1, t2) (_mm256_set_epi32(0xfffffffe^t2, 0xfffffffe^t1, 0xfffffffe^t2, 0xfffffffe^t1, 0xfffffffe^t2, 0xfffffffe^t1, 0xfffffffe^t2,0xfffffffe^t1))
#define SC(t1, t2) (_mm256_set_epi32(0xffffff00^t2, 0xffffffff, 0xffffff00^t1, 0xffffffff, 0xffffff00^t2, 0xffffffff, 0xffffff00^t1, 0xffffffff))
#define SWAPBLK(x) (_mm256_permute4x64_epi64(x, _MM_SHUFFLE(2,3,0,1)))
#define SWAPREG2(x) (_mm256_permutevar8x32_epi32(x, _mm256_set_epi32(7, 6, 3, 2, 5, 4, 1, 0)))
#define SWAPAC(x)	(_mm256_permutevar8x32_epi32(xtmp, _mm256_set_epi32(5, 4, 7, 6, 1, 0, 3, 2)))
#define masklo		(_mm256_set_epi32(0x0, 0x0, 0x0, 0x0, 0xffffffff, 0xffffffff, 0xffffffff,0xffffffff))
#define maskhi		(_mm256_set_epi32(0xffffffff, 0xffffffff, 0xffffffff,0xffffffff,0x0, 0x0, 0x0, 0x0))

#define _mm256_set_m128i(v0, v1)  _mm256_insertf128_si256(_mm256_castsi128_si256(v1), (v0), 1)

#define ROAX(x, y, t1, t2)\
{\
__m256i x2tmp;\
x2tmp = x;\
x = (ROT5(x)&x)^ROT1(x)^RC(t1, t2)^y;\
y = x2tmp;\
}

#define PACK_SSb(x, y)\
{\
__m256i xtmp, ytmp;\
xtmp = SWAPREG1(x);\
ytmp = SWAPREG1(y);\
x = _mm256_permute2x128_si256(xtmp,ytmp,0x20);\
y = _mm256_permute2x128_si256(xtmp,ytmp, 0x31);\
}

#define UNPACK_SSb(x, y)\
{\
__m256i xtmp, ytmp;\
xtmp = _mm256_unpacklo_epi32(x, y);\
ytmp = _mm256_unpackhi_epi32(x, y);\
x = _mm256_permute2x128_si256(xtmp, ytmp,0x20);\
y = _mm256_permute2x128_si256(xtmp, ytmp, 0x31);\
}


#define PACK(x, y, z, w)\
{\
__m256i x2tmp, x3tmp;\
x2tmp = SWAPREG2(x);\
x3tmp = SWAPREG2(z);\
x = _mm256_permute2x128_si256(x2tmp,x3tmp,0x20);\
z = _mm256_permute2x128_si256(x2tmp,x3tmp, 0x31);\
x2tmp = SWAPREG2(y);\
x3tmp = SWAPREG2(w);\
y = _mm256_permute2x128_si256(x2tmp,x3tmp,0x20);\
w = _mm256_permute2x128_si256(x2tmp,x3tmp, 0x31);\
}

#define UNPACK(x,y,z,w)\
{\
__m256i x2tmp, x3tmp;\
x2tmp = _mm256_unpacklo_epi64(x, z);\
x3tmp = _mm256_unpackhi_epi64(x, z);\
x = _mm256_permute2x128_si256(x2tmp,x3tmp,0x20);\
z = _mm256_permute2x128_si256(x2tmp,x3tmp, 0x31);\
x2tmp = _mm256_unpacklo_epi64(y, w);\
x3tmp = _mm256_unpackhi_epi64(y, w);\
y = _mm256_permute2x128_si256(x2tmp,x3tmp,0x20);\
w = _mm256_permute2x128_si256(x2tmp,x3tmp, 0x31);\
}

void ace320( u32 *state );
int crypto_aead_encrypt( u32 *tag, u32 tlen, u32 *c, u32 *m, u32 mlen, u32 *ad, u32 adlen, u8 *k, u8 *npub, u32 klen );
int crypto_aead_decrypt( u32 *m, u32 *c, u32 mlen, u32 *tag, u32 tlen, u32 *ad, u32 adlen, u8 *k, u8 *npub, u32 klen );
#endif
