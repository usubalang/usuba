/* ******************************************** *\
 * Compile:
 *    powerpc-linux-gnu-gcc -mvsx -maltivec -mabi=altivec  
 *
\* ******************************************** */


/* Including headers */
#pragma once
#include <stdlib.h>
#include <altivec.h>
#include <stdint.h>

/* Defining macros */
#define DATATYPE vector unsigned long int

#define REG_SIZE sizeof(DATATYPE)

/* Defining 0 and 1 */
#define ZERO (DATATYPE){ 0  }
#define ONES (DATATYPE){ -1 }

#define AND(a,b)  vec_and(a,b)
#define OR(a,b)   vec_or(a,b)
#define XOR(a,b)  vec_xor(a,b)
#define ANDN(a,b) vec_nand(a,b)
#define NOT(a)    vec_and(a,ONES)


#define SET_ALL_ONE()  ONES
#define SET_ALL_ZERO() ZERO

#define ORTHOGONALIZE(in,out)   orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) aligned_alloc(32,size * sizeof(DATATYPE))


#ifndef NO_RUNTIME


/* Orthogonalization stuffs */
static uint64_t mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};

static uint64_t mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};


void real_ortho(uint64_t data[]) {
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint64_t u = data[j + k] & mask_l[i];
        uint64_t v = data[j + k] & mask_r[i];
        uint64_t x = data[j + n + k] & mask_l[i];
        uint64_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

#ifdef ORTHO

void orthogonalize(uint64_t* data, DATATYPEi* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  for (int i = 0; i < 64; i++)
    out[i] = (DATATYPE){ data[i], data[64+i] };
}

void unorthogonalize(DATATYPEi *in, uint64_t* data) {
  for (int i = 0; i < 64; i++) {
    data[i] = in[i][0];
    data[64+i] = in[i][1];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
}

#else

void orthogonalize(uint64_t *in, DATATYPE *out) {
  for (int i = 0; i < 64; i++)
    out[i] = (DATATYPE){in[i*2], in[i*2+1]};
}

void unorthogonalize(DATATYPE *in, uint64_t *out) {
  for (int i = 0; i < 64; i++) {
    out[i*2] = in[i][0];
    out[i*2+1] = in[i][1];    
  }
}

#endif /* ORTHO */

#endif /* NO_RUNTIME */

