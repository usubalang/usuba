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

#ifndef AltiVec
#define AltiVec
#endif

/* Defining macros */
#define DATATYPE vector unsigned int

#define REG_SIZE (sizeof(DATATYPE)*8)
#define CHUNK_SIZE 256

/* Defining 0 and 1 */
#define ZERO (DATATYPE){ 0  }
#define ONES (DATATYPE){ -1 }

#define AND(a,b)  vec_and(a,b)
#define OR(a,b)   vec_or(a,b)
#define XOR(a,b)  vec_xor(a,b)
#define ANDN(a,b) vec_andc(b,a)
#define NOT(a)    vec_andc(ONES,a)


#define SET_ALL_ONE()  ONES
#define SET_ALL_ZERO() ZERO


#define PERMUT_16(a,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16) \
  vec_perm(a,a,(vector unsigned char){x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16})

  
#define ORTHOGONALIZE(in,out)   orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) malloc(size * sizeof(DATATYPE))


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
    (DATATYPE){ 0xaaaaaaaa, 0xaaaaaaaa, 0xaaaaaaaa, 0xaaaaaaaa },
    (DATATYPE){ 0xcccccccc, 0xcccccccc, 0xcccccccc, 0xcccccccc },
    (DATATYPE){ 0xf0f0f0f0, 0xf0f0f0f0, 0xf0f0f0f0, 0xf0f0f0f0 },
    (DATATYPE){ 0xff00ff00, 0xff00ff00, 0xff00ff00, 0xff00ff00 },
    (DATATYPE){ 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000 },
    (DATATYPE){ -1, 0, -1, 0 },
    (DATATYPE){ -1, -1, 0, 0 }
  };

  DATATYPE mask_r[7] = {
    (DATATYPE){ 0x55555555, 0x55555555, 0x55555555, 0x55555555 },
    (DATATYPE){ 0x33333333, 0x33333333, 0x33333333, 0x33333333 },
    (DATATYPE){ 0x0f0f0f0f, 0x0f0f0f0f, 0x0f0f0f0f, 0x0f0f0f0f },
    (DATATYPE){ 0x00ff00ff, 0x00ff00ff, 0x00ff00ff, 0x00ff00ff },
    (DATATYPE){ 0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff },
    (DATATYPE){ 0, -1, 0, -1 },
    (DATATYPE){ 0, 0, -1, -1 }
  };
  
  for (int i = 0; i < 7; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 128; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        DATATYPE u = AND(data[j + k], mask_l[i]);
        DATATYPE v = AND(data[j + k], mask_r[i]);
        DATATYPE x = AND(data[j + n + k], mask_l[i]);
        DATATYPE y = AND(data[j + n + k], mask_r[i]);
        if (i <= 4) {
	  DATATYPE shift_mask = {n,n,n,n}; 
          data[j + k] = OR(u, vec_sr(x,shift_mask));
          data[j + n + k] = OR(vec_sl(v,shift_mask), y);
        } else if (i == 5) {
	  vector unsigned char shift_mask = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0x20};
          data[j + k] = OR(u,vec_sro(x,shift_mask));
          data[j + n + k] = OR(vec_slo(v,shift_mask),y);
        } else { /* i == 6 */ 
	  vector unsigned char shift_mask = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0x40};
          data[j + k] = OR(u,vec_sro(x,shift_mask));
          data[j + n + k] = OR(vec_slo(v,shift_mask),y);
        } 
      }
  }
}

#ifdef ORTHO

void orthogonalize_128x64(uint64_t* data, DATATYPE* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  for (int i = 0; i < 64; i++) {
    uint64_t tmp[2];
    tmp[0] = data[i];
    tmp[1] = data[64+i];
    out[i] = vec_ld(0,(DATATYPE*)tmp);
  }
}

void unorthogonalize_64x128(DATATYPE *in, uint64_t* data) {
  for (int i = 0; i < 64; i++) {
    unsigned int tmp[4];
    vec_st(in[i],0,(DATATYPE*)tmp);
    data[i] = ((uint64_t*)tmp)[0];
    data[64+i] = ((uint64_t*)tmp)[1];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
}

void orthogonalize_128x128(uint64_t* data, DATATYPE* out) {
  for (int i = 0; i < 128; i++) {
    //uint64_t tmp[2] = { data[i], data[128+i] };
    //out[i] = vec_ld(0,(DATATYPE*)tmp);
    /* NOTE: could be "128+i" then "i" */
    out[i] = (DATATYPE){ data[i], data[128+i] };
  }
  real_ortho_128x128(out);
}

void unorthogonalize_128x128(DATATYPE *in, uint64_t* data) {
  real_ortho_128x128(in);
  for (int i = 0; i < 128; i++) {
    DATATYPE tmp_vec;
    vec_st(in[i],0,&tmp_vec);
    uint64_t* tmp = (uint64_t*)&tmp_vec;
    /* NOTE: could be "0" then "1" */
    data[i] = tmp[0];
    data[128+i] = tmp[1];
  }
}

void orthogonalize(uint64_t* data, DATATYPE* out) {
  orthogonalize_128x128(data,out);
}
void unorthogonalize(DATATYPE *in, uint64_t* data) {
  unorthogonalize_128x128(in,data);
}

#else

void orthogonalize_128x64(uint64_t *in, DATATYPE *out) {
  for (int i = 0; i < 64; i++)
    out[i] = vec_ld(0,(DATATYPE*)&in[i*2]);
}

void unorthogonalize_64x128(DATATYPE *in, uint64_t *out) {
  for (int i = 0; i < 64; i++) {
    vec_st(in[i],0,(DATATYPE*)&out[i*2]);
  }
}

void orthogonalize_128x128(uint64_t *in, DATATYPE *out) {
  for (int i = 0; i < 128; i++)
    out[i] = vec_ld(0,(DATATYPE*)&in[i*2]);
}

void unorthogonalize_128x128(DATATYPE *in, uint64_t *out) {
  for (int i = 0; i < 128; i++) {
    vec_st(in[i],0,(DATATYPE*)&out[i*2]);
  }
}

void orthogonalize(uint64_t *in, DATATYPE *out) {
  orthogonalize_128x128(in,out);
}
void unorthogonalize(DATATYPE *in, uint64_t *out) {
  unorthogonalize_128x128(in,out);
}



#endif /* ORTHO */

#endif /* NO_RUNTIME */

