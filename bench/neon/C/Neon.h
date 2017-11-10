/* ******************************************** *\
 * 
 * 
 *
\* ******************************************** */


/* Including headers */
#pragma once
#include <stdlib.h>
#include <arm_neon.h>
#include <stdint.h>

/* Defining 0 and 1 */
#define ZERO ((uint64x2_t){  0,  0 })
#define ONES ((uint64x2_t){ -1, -1 })

/* Defining macros */
#define REG_SIZE   128
#define CHUNK_SIZE 128

#define AND(a,b)  vandq_u64(a,b)
#define OR(a,b)   vorrq_u64(a,b)
#define XOR(a,b)  veorq_u64(a,b)
#define ANDN(a,b) vbicq_u64(a,b)
#define NOT(a)    vmvnq_u32((uint32x4_t)a)

#define DATATYPE uint64x2_t

#define SET_ALL_ONE()  ONES
#define SET_ALL_ZERO() ZERO

#define ORTHOGONALIZE(in,out) orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) malloc(size * sizeof(uint64x2_t))


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

void orthogonalize(uint64_t* data, uint64x2_t* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  for (int i = 0; i < 64; i++) {
    uint64_t tmp[2];
    tmp[0] = data[i];
    tmp[1] = data[i+64];
    out[i] = vld1q_u64((uint64_t*)&tmp);
  }
}

void unorthogonalize(uint64x2_t *in, uint64_t* data) {
  for (int i = 0; i < 64; i++) {
    uint64_t tmp[2];
    vst1q_u64((uint64_t*)tmp,in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
}

#else

void orthogonalize(uint64_t *in, uint64x2_t *out) {
  for (int i = 0; i < 64; i++)
    out[i] = vld1q_u64((uint64_t*)&in[i]);
}

void unorthogonalize(uint64x2_t *in, uint64_t *out) {
  for (int i = 0; i < 64; i++)
    vst1q_u64((uint64_t*)&out[i],in[i]);
}

#endif /* ORTHO */

#endif /* NO_RUNTIME */
