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

/** Encryption **/

void sBoxLayer(word *Y, word *X) {
  present_sbox(Y+ 0,Y+ 1,Y+ 2,Y+ 3, X[ 0],X[ 1],X[ 2],X[ 3]);
  present_sbox(Y+ 4,Y+ 5,Y+ 6,Y+ 7, X[ 4],X[ 5],X[ 6],X[ 7]);
  present_sbox(Y+ 8,Y+ 9,Y+10,Y+11, X[ 8],X[ 9],X[10],X[11]);
  present_sbox(Y+12,Y+13,Y+14,Y+15, X[12],X[13],X[14],X[15]);
  present_sbox(Y+16,Y+17,Y+18,Y+19, X[16],X[17],X[18],X[19]);

  present_sbox(Y+20,Y+21,Y+22,Y+23, X[20],X[21],X[22],X[23]);
  present_sbox(Y+24,Y+25,Y+26,Y+27, X[24],X[25],X[26],X[27]);
  present_sbox(Y+28,Y+29,Y+30,Y+31, X[28],X[29],X[30],X[31]);
  present_sbox(Y+32,Y+33,Y+34,Y+35, X[32],X[33],X[34],X[35]);
  present_sbox(Y+36,Y+37,Y+38,Y+39, X[36],X[37],X[38],X[39]);

  present_sbox(Y+40,Y+41,Y+42,Y+43, X[40],X[41],X[42],X[43]);
  present_sbox(Y+44,Y+45,Y+46,Y+47, X[44],X[45],X[46],X[47]);
  present_sbox(Y+48,Y+49,Y+50,Y+51, X[48],X[49],X[50],X[51]);
  present_sbox(Y+52,Y+53,Y+54,Y+55, X[52],X[53],X[54],X[55]);
  present_sbox(Y+56,Y+57,Y+58,Y+59, X[56],X[57],X[58],X[59]);

  present_sbox(Y+60,Y+61,Y+62,Y+63, X[60],X[61],X[62],X[63]);
}

void addRoundKey(word *X, const word *K) {
  printf("%llu ^ %llu = %llu\n",X[4]&1,K[4]&1,(X[4]^K[4])&1);
  X[ 0] ^= K[ 0],  X[ 1] ^= K[ 1],  X[ 2] ^= K[ 2],  X[ 3] ^= K[ 3];
  X[ 4] ^= K[ 4],  X[ 5] ^= K[ 5],  X[ 6] ^= K[ 6],  X[ 7] ^= K[ 7];
  X[ 8] ^= K[ 8],  X[ 9] ^= K[ 9],  X[10] ^= K[10],  X[11] ^= K[11];
  X[12] ^= K[12],  X[13] ^= K[13],  X[14] ^= K[14],  X[15] ^= K[15];
  X[16] ^= K[16],  X[17] ^= K[17],  X[18] ^= K[18],  X[19] ^= K[19];
  X[20] ^= K[20],  X[21] ^= K[21],  X[22] ^= K[22],  X[23] ^= K[23];
  X[24] ^= K[24],  X[25] ^= K[25],  X[26] ^= K[26],  X[27] ^= K[27];
  X[28] ^= K[28],  X[29] ^= K[29],  X[30] ^= K[30],  X[31] ^= K[31];
  X[32] ^= K[32],  X[33] ^= K[33],  X[34] ^= K[34],  X[35] ^= K[35];
  X[36] ^= K[36],  X[37] ^= K[37],  X[38] ^= K[38],  X[39] ^= K[39];
  X[40] ^= K[40],  X[41] ^= K[41],  X[42] ^= K[42],  X[43] ^= K[43];
  X[44] ^= K[44],  X[45] ^= K[45],  X[46] ^= K[46],  X[47] ^= K[47];
  X[48] ^= K[48],  X[49] ^= K[49],  X[50] ^= K[50],  X[51] ^= K[51];
  X[52] ^= K[52],  X[53] ^= K[53],  X[54] ^= K[54],  X[55] ^= K[55];
  X[56] ^= K[56],  X[57] ^= K[57],  X[58] ^= K[58],  X[59] ^= K[59];
  X[60] ^= K[60],  X[61] ^= K[61],  X[62] ^= K[62],  X[63] ^= K[63];
}

void pLayer(word *X, word *Y) {
  X[ 0] = Y[ 0],  X[ 1] = Y[ 4],  X[ 2] = Y[ 8],  X[ 3] = Y[12];
  X[ 4] = Y[16],  X[ 5] = Y[20],  X[ 6] = Y[24],  X[ 7] = Y[28];
  X[ 8] = Y[32],  X[ 9] = Y[36],  X[10] = Y[40],  X[11] = Y[44];
  X[12] = Y[48],  X[13] = Y[52],  X[14] = Y[56],  X[15] = Y[60];
  X[16] = Y[ 1],  X[17] = Y[ 5],  X[18] = Y[ 9],  X[19] = Y[13];
  X[20] = Y[17],  X[21] = Y[21],  X[22] = Y[25],  X[23] = Y[29];
  X[24] = Y[33],  X[25] = Y[37],  X[26] = Y[41],  X[27] = Y[45];
  X[28] = Y[49],  X[29] = Y[53],  X[30] = Y[57],  X[31] = Y[61];
  X[32] = Y[ 2],  X[33] = Y[ 6],  X[34] = Y[10],  X[35] = Y[14];
  X[36] = Y[18],  X[37] = Y[22],  X[38] = Y[26],  X[39] = Y[30];
  X[40] = Y[34],  X[41] = Y[38],  X[42] = Y[42],  X[43] = Y[46];
  X[44] = Y[50],  X[45] = Y[54],  X[46] = Y[58],  X[47] = Y[62];
  X[48] = Y[ 3],  X[49] = Y[ 7],  X[50] = Y[11],  X[51] = Y[15];
  X[52] = Y[19],  X[53] = Y[23],  X[54] = Y[27],  X[55] = Y[31];
  X[56] = Y[35],  X[57] = Y[39],  X[58] = Y[43],  X[59] = Y[47];
  X[60] = Y[51],  X[61] = Y[55],  X[62] = Y[59],  X[63] = Y[63];
}

void encrypt(word *X, const word *subkeys, const size_t nr) {


  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 64; j++) printf("%llu",(subkeys+i*64)[j]&1);
    printf("\n");
  }
  //exit(1);
  
  printf("size: %lu\n",sizeof(word));
  static word Y[Bs];
  
    
  for(size_t i=0; i<nr;i++) {
    printf("\nStart %zu : ",i);
    for (int j = 0; j < 64; j++) printf("%llu",X[j] & 1);
    printf("\n");
    //if (i == 4) exit(1);
  
    addRoundKey(X, subkeys + (i*Bs));
    
    printf("Sbox_in : ");
    for (int j = 0; j < 64; j++) printf("%llu",X[j] & 1);
    printf("\n");
    
    sBoxLayer(Y, X);
    
    printf("Sbox_out: ");
    for (int j = 0; j < 64; j++) printf("%llu",Y[j] & 1);
    printf("\n");
    
    pLayer(X, Y);
  }
  addRoundKey(X, subkeys + (nr*Bs));
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
    encrypt(tmp, subkeys, nr);
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
