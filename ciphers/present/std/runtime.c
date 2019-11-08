/**
 * Bit-Slice Implementation of PRESENT in pure standard C.
 * v1.5 26/08/2011
 *
 * The authors are
 *  Martin Albrecht <martinralbrecht@googlemail.com>
 *  Nicolas T. Courtois <firstinitial.family_name@cs.ucl.ac.uk>
 *  Daniel Hulme <firstname@satalia.com>
 *  Guangyan Song <firstname.lastname@gmail.com>
 * This work was partly funded by the Technology Strategy Board
 * in the United Kingdom under Project No 9626-58525.
 *
 * NEW FEATURES in this version:
 * - it contains an optimized sbox() using 15 only gates, instead of 39
 *   previously
 * - it now supports both 80-bit and 128-bit PRESENT
 * - it contains test vectors for both versions
 *
 * This is a simple and straightforward implementation
 * it encrypts at the speed of
 *   59 cycles per byte on Intel Xeon 5130 1.66 GHz
 * this can be compared to for example
 *   147 cycles per byte for optimized triple DES on the same CPU
 *
 * To compile try:
 *   gcc -O2 -g -std=c99 present_bitslice.c -o present_bitslice
 * will also compile with any version of Microsoft Visual Studio
 *
 * TODO:
 *  - improve performance
 *     It could easily be optimised quite a bit by using SSE2,
 *     pushing critical paths down to assembly
 *  - make it safer, right now we assume sizeof(word) == 8
 */

#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define RADIX 64 //I think this code is only correct if RADIX==Bs, due to transpose operations
#define Bs 64
#define Ks 80 //80 or 128-bit keys, both versions tested to work correctly

#ifdef _MSC_VER
typedef unsigned __int64 uint64_t;
#else
typedef unsigned long long uint64_t;
#endif
typedef uint64_t word;

static inline void present_sbox(word *Y3, word *Y2, word *Y1, word *Y0, const word X3, const word X2, const word X1, const word X0) {
  register word T1,T2,T3,T4;
  T1 = X1 ^ X2;
  T2 = X2 & T1;
  T3 = X3 ^ T2;
  *Y0 = X0 ^ T3;
  T2 = T1 & T3;
  T1 ^= (*Y0);
  T2 ^= X2;
  T4 = X0 | T2;
  *Y1 = T1 ^ T4;
  T2 ^= (~X0);
  *Y3 = (*Y1) ^ T2;
  T2 |= T1;
  *Y2 = T3 ^ T2;
}


void transpose(word *out, word *inp, const size_t out_size, const size_t inp_size) {
  for(size_t j=0; j<out_size; j++) {
    out[j] = 0;
    for(size_t i=0; i<inp_size; i++) {
      out[j] |= ( ((inp[i]>>(j&63))&1) )<<(i&63);
    }
  }
}

/** Key Schedule **/

void rotate(word *k) {
  word temp[Ks];
  memcpy(temp,k,Ks*sizeof(word));
  for(size_t i =0; i<Ks; i++) {
    k[i] = temp[(i+61)%Ks];
  }
}

static inline void round_constant(word *rc, size_t i) {
  static word lookup[2] =
    {(uint64_t)0x0000000000000000,((uint64_t)0xFFFFFFFFFFFFFFFF)};
  rc[4] = lookup[(i&(1<<0))>>0];
  rc[3] = lookup[(i&(1<<1))>>1];
  rc[2] = lookup[(i&(1<<2))>>2];
  rc[1] = lookup[(i&(1<<3))>>3];
  rc[0] = lookup[(i&(1<<4))>>4];
}

void key_schedule(word *subkeys, word *key, const size_t nr) {
  /** TODO: The key schedule isn't optimised at all */
  word *ki = subkeys;
  word S[8];
  word rc[5];
  for(size_t i=0; i<=nr; i++) {
    for(size_t j=0; j<Bs; j++)
      ki[j] = key[j];
    ki+=Bs;

    rotate(key);

    present_sbox(&S[0],&S[1],&S[2],&S[3], key[0], key[1], key[2], key[3]);
    key[0] = S[0], key[1] = S[1], key[2] = S[2], key[3] = S[3];
    if(Ks==128) { //one more S-box
      present_sbox(&S[4+0],&S[4+1],&S[4+2],&S[4+3], key[4+0], key[4+1], key[4+2], key[4+3]);
      key[4+0] = S[4+0], key[4+1] = S[4+1], key[4+2] = S[4+2], key[4+3] = S[4+3];
    };
    round_constant(rc, i+1);
    if(Ks==80) {
      key[Ks-1-19] ^= rc[0], key[Ks-1-18] ^= rc[1], key[Ks-1-17] ^= rc[2];
      key[Ks-1-16] ^= rc[3], key[Ks-1-15] ^= rc[4];
    };
    if(Ks==128) {
      key[Ks-1-66] ^= rc[0], key[Ks-1-65] ^= rc[1], key[Ks-1-64] ^= rc[2];
      key[Ks-1-63] ^= rc[3], key[Ks-1-62] ^= rc[4];
    };
  }
}


uint64_t Mirror64(uint64_t ins) {
  uint64_t inv_ins=0;
  for (int i = 0; i < 64; i++)
    if((ins>>i)&1)
      inv_ins|=(((uint64_t)0x0000000000000001)<<(64-1-i));
  return inv_ins;
}

int main() {
  uint64_t plaintexts[RADIX];
  uint64_t ciphertexts[RADIX];
  word tmp[Bs];
  word key[Ks];

  size_t nr = 31;

  if(Ks==80) {
    printf("run official testvectors\n");

    for(size_t i=0;i<Ks;i++)
      key[i] = 0;
    for(size_t i=0; i<RADIX; i++)
      plaintexts[i] = 0;

    uint64_t tv[4];

    plaintexts[0] =  0; key[0] =  0; tv[0] = 0x5579c1387b228445;
    plaintexts[1] =  0; key[1] = -1; tv[1] = 0xe72c46c0f5945049;
    plaintexts[2] = -1; key[2] =  0; tv[2] = 0xa112ffc72f68417b;
    plaintexts[3] = -1; key[3] = -1; tv[3] = 0x3333dcd3213210d2;

    transpose(tmp, key, Ks, RADIX);
    word *subkeys = (word *)calloc(Bs * (nr+1), sizeof(word));
    key_schedule(subkeys, tmp, nr);

    transpose(tmp, plaintexts, Bs, RADIX);
    present__(tmp, subkeys, tmp);
    transpose(ciphertexts, tmp, RADIX, Bs);

    free(subkeys);

    printf("   plaintext            key          ciphertext           tv\n");
    for(size_t i=0;i<4;++i) {
#ifdef _MSC_VER
      printf("%016I64X %016I64X %016I64X %016I64X\n",
             Mirror64(plaintexts[i]), Mirror64(key[i]),
             Mirror64(ciphertexts[i]), tv[i]);
#else
      printf("%016llx %016llx %016llx %016llx\n",
             Mirror64(plaintexts[i]), Mirror64(key[i]),
             Mirror64(ciphertexts[i]), tv[i]);
#endif
    }
  }
  return 0;
}
