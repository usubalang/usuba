/* ******************************************** *\
 * 
 *  gcc -O3 -std=gnu11 -mfpu=neon -flax-vector-conversions 
 *
\* ******************************************** */


/* Including headers */
#pragma once
#include <stdlib.h>
#include <arm_neon.h>
#include <stdint.h>

/* Defining 0 and 1 */
#define ZERO ((uint64x2_t){  0ULL,  0ULL })
#define ONES ((uint64x2_t){ -1ULL, -1ULL })

/* Defining macros */
#define REG_SIZE   128
#define CHUNK_SIZE 256

#define AND(a,b)  vandq_u64(a,b)
#define OR(a,b)   vorrq_u64(a,b)
#define XOR(a,b)  veorq_u64(a,b)
#define ANDN(a,b) vbicq_u64(a,b)
#define NOT(a)    vmvnq_u32((uint32x4_t)a)

#define DATATYPE uint64x2_t

#define SET_ALL_ONE()  ONES
#define SET_ALL_ZERO() ZERO


#define PERMUT_8(a,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16) \
  vtbl1_u8(a,(uint8x8_t){x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16})

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

void real_ortho_128x128(DATATYPE data[]) {

  DATATYPE mask_l[7] = {
    (DATATYPE){ 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL },
    (DATATYPE){ 0xccccccccccccccccULL, 0xccccccccccccccccULL },
    (DATATYPE){ 0xf0f0f0f0f0f0f0f0ULL, 0xf0f0f0f0f0f0f0f0ULL },
    (DATATYPE){ 0xff00ff00ff00ff00ULL, 0xff00ff00ff00ff00ULL },
    (DATATYPE){ 0xffff0000ffff0000ULL, 0xffff0000ffff0000ULL },
    (DATATYPE){ 0xffffffff00000000ULL, 0xffffffff00000000ULL },
    (DATATYPE){ 0x0000000000000000ULL, 0xffffffffffffffffULL },  
  };

  DATATYPE mask_r[7] = {
    (DATATYPE){ 0x5555555555555555ULL, 0x5555555555555555ULL },
    (DATATYPE){ 0x3333333333333333ULL, 0x3333333333333333ULL },
    (DATATYPE){ 0x0f0f0f0f0f0f0f0fULL, 0x0f0f0f0f0f0f0f0fULL },
    (DATATYPE){ 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL },
    (DATATYPE){ 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL },
    (DATATYPE){ 0x00000000ffffffffULL, 0x00000000ffffffffULL },
    (DATATYPE){ 0xffffffffffffffffULL, 0x0000000000000000ULL },
  };
  
  for (int i = 0; i < 7; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 128; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        DATATYPE u = AND(data[j + k], mask_l[i]);
        DATATYPE v = AND(data[j + k], mask_r[i]);
        DATATYPE x = AND(data[j + n + k], mask_l[i]);
        DATATYPE y = AND(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = OR(u, vshrq_n_u64(x, n));
          data[j + n + k] = OR(vshlq_n_u64(v, n), y);
        } else {
          data[j + k] = OR(u, vcombine_s64(vget_low_s64(x),vget_high_s64(x)));
          data[j + n + k] = OR(vcombine_s64(vget_low_s64(v),vget_high_s64(v)), y);
        } 
      }
  }
}

#ifdef ORTHO

void orthogonalize_128x64(uint64_t* data, uint64x2_t* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  for (int i = 0; i < 64; i++) {
    uint64_t tmp[2];
    tmp[0] = data[i];
    tmp[1] = data[i+64];
    out[i] = vld1q_u64((uint64_t*)&tmp);
  }
}

void unorthogonalize_64x128(uint64x2_t *in, uint64_t* data) {
  for (int i = 0; i < 64; i++) {
    uint64_t tmp[2];
    vst1q_u64((uint64_t*)tmp,in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
}


void orthogonalize_128x128(uint64_t* data, DATATYPE* out) {
  for (int i = 0; i < 128; i++) {
    uint64_t tmp[2];
    tmp[0] = data[i];
    tmp[1] = data[i+128];
    out[i] = vld1q_u64(tmp);
  }
  real_ortho_128x128(out);
}

void unorthogonalize_128x128(DATATYPE *in, uint64_t* data) {
  real_ortho_128x128(in);
  for (int i = 0; i < 128; i++) {
    uint64_t tmp[2];
    vst1q_u64(tmp, in[i]);
    data[i] = tmp[1];
    data[128+i] = tmp[0];
  }
}

void orthogonalize(uint64_t* data, DATATYPE* out) {
  orthogonalize_128x128(data,out);
}
void unorthogonalize(DATATYPE *in, uint64_t* data) {
  unorthogonalize_128x128(in,data);
}


#else

void orthogonalize_128x64(uint64_t *in, uint64x2_t *out) {
  for (int i = 0; i < 64; i++)
    out[i] = vld1q_u64(&in[i*2]);
}

void unorthogonalize_64x128(uint64x2_t *in, uint64_t *out) {
  for (int i = 0; i < 64; i++)
    vst1q_u64(&out[i*2],in[i]);
}


void orthogonalize_128x128(uint64_t *in, uint64x2_t *out) {
  for (int i = 0; i < 128; i++)
    out[i] = vld1q_u64(&in[i*2]);
}

void unorthogonalize_128x128(uint64x2_t *in, uint64_t *out) {
  for (int i = 0; i < 64; i++)
    vst1q_u64(&out[i*2],in[i]);
}

void orthogonalize(uint64_t *in, DATATYPE *out) {
  orthogonalize_128x128(in,out);
}
void unorthogonalize(DATATYPE *in, uint64_t *out) {
  unorthogonalize_128x128(in,out);
}


#endif /* ORTHO */

#endif /* NO_RUNTIME */
