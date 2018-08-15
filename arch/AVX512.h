/* ******************************************** *\
 * 
 * 
 *
\* ******************************************** */


/* Including headers */
#pragma once
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>

#ifndef AVX512
#define AVX512
#endif

/* Defining 0 and 1 */
#define ZERO _mm512_setzero_si512()
#define ONES _mm512_set1_epi32(-1)

/* Defining macros */
#define REG_SIZE 512
#define CHUNK_SIZE 4096

#define AND(a,b)  _mm512_and_si512(a,b)
#define OR(a,b)   _mm512_or_si512(a,b)
#define XOR(a,b)  _mm512_xor_si512(a,b)
#define ANDN(a,b) _mm512_andnot_si512(a,b)
#define NOT(a)    _mm512_xor_si512(ONES,a)

#define DATATYPE __m512i

#define SET_ALL_ONE()  ONES
#define SET_ALL_ZERO() ZERO

#define ORTHOGONALIZE(in,out) orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) aligned_alloc(64,size * sizeof(__m512i))


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


void real_ortho_512x512(__m512i data[]) {

  __m512i mask_l[9] = {
    _mm512_set1_epi64(0xaaaaaaaaaaaaaaaaUL),
    _mm512_set1_epi64(0xccccccccccccccccUL),
    _mm512_set1_epi64(0xf0f0f0f0f0f0f0f0UL),
    _mm512_set1_epi64(0xff00ff00ff00ff00UL),
    _mm512_set1_epi64(0xffff0000ffff0000UL),
    _mm512_set1_epi64(0xffffffff00000000UL),
    _mm512_set_epi64(0UL,-1UL,0UL,-1UL,0UL,-1UL,0UL,-1UL),
    _mm512_set_epi64(0UL,0UL,-1UL,-1UL,0UL,0UL,-1UL,-1UL),
    _mm512_set_epi64(0UL,0UL,0UL,0UL,-1UL,-1UL,-1UL,-1UL),
  };

  __m512i mask_r[9] = {
    _mm512_set1_epi64(0x5555555555555555UL),
    _mm512_set1_epi64(0x3333333333333333UL),
    _mm512_set1_epi64(0x0f0f0f0f0f0f0f0fUL),
    _mm512_set1_epi64(0x00ff00ff00ff00ffUL),
    _mm512_set1_epi64(0x0000ffff0000ffffUL),
    _mm512_set1_epi64(0x00000000ffffffffUL),
    _mm512_set_epi64(-1UL,0UL,-1UL,0UL,-1UL,0UL,-1UL,0UL),
    _mm512_set_epi64(-1UL,-1UL,0UL,0UL,-1UL,-1UL,0UL,0UL),
    _mm512_set_epi64(-1UL,-1UL,-1UL,-1UL,0UL,0UL,0UL,0UL),
  };
  
  for (int i = 0; i < 9; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 512; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m512i u = _mm512_and_si512(data[j + k], mask_l[i]);
        __m512i v = _mm512_and_si512(data[j + k], mask_r[i]);
        __m512i x = _mm512_and_si512(data[j + n + k], mask_l[i]);
        __m512i y = _mm512_and_si512(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm512_or_si512(u, _mm512_srli_epi64(x, n));
          data[j + n + k] = _mm512_or_si512(_mm512_slli_epi64(v, n), y);
        } else if (i == 6) {
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm512_or_si512(u, _mm512_bslli_epi128(x, 8));
          data[j + n + k] = _mm512_or_si512(_mm512_bsrli_epi128(v, 8), y);
        } else if (i == 7) {
          /* might be 0b01001110 instead */
          data[j + k] = _mm512_or_si512(u, _mm512_permutex_epi64(x,0b10110001));
          data[j + n + k] = _mm512_or_si512(_mm512_permutex_epi64(v,0b10110001), y);
        } else {
          /* might be 0,1,2,3,4,5,6,7 */
          __m512i ctrl = _mm512_set_epi64(4,5,6,7,0,1,2,3);
          data[j + k] = _mm512_or_si512(u, _mm512_permutexvar_epi64(ctrl,x));
          data[j + n + k] = _mm512_or_si512(_mm512_permutexvar_epi64(ctrl,v), y);
        }
      }
  }
}

#ifdef ORTHO

void orthogonalize_512x64(uint64_t* data, __m512i* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  real_ortho(&(data[128]));
  real_ortho(&(data[192]));
  real_ortho(&(data[256]));
  real_ortho(&(data[320]));
  real_ortho(&(data[384]));
  real_ortho(&(data[448]));
  for (int i = 0; i < 64; i++)
    out[i] = _mm512_set_epi64(data[i], data[64+i], data[128+i], data[192+i],
                              data[256+i], data[320+i], data[384+i], data[448+i]);
}

void unorthogonalize_64x512(__m512i *in, uint64_t* data) {
  for (int i = 0; i < 64; i++) {
    uint64_t tmp[8];
    _mm512_store_si512 ((__m512i*)tmp, in[i]);
    data[i] = tmp[7];
    data[64+i] = tmp[6];
    data[128+i] = tmp[5];
    data[192+i] = tmp[4];
    data[256+i] = tmp[3];
    data[320+i] = tmp[2];
    data[384+i] = tmp[1];
    data[448+i] = tmp[0];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
  real_ortho(&(data[128]));
  real_ortho(&(data[192]));
  real_ortho(&(data[256]));
  real_ortho(&(data[320]));
  real_ortho(&(data[384]));
  real_ortho(&(data[448]));
}

void orthogonalize_512x512(uint64_t* data, __m512i* out) {
  for (int i = 0; i < 512; i++)
    out[i] = _mm512_set_epi64(data[i], data[512+i], data[1024+i],
                              data[1536+i], data[2048+i],data[2560+i],
                              data[3072+i],data[3584+i]);
  real_ortho_512x512(out);
}

void unorthogonalize_512x512(__m512i *in, uint64_t* data) {
  real_ortho_512x512(in);
  for (int i = 0; i < 512; i++) {
    uint64_t tmp[8];
    _mm512_store_si512 ((__m512i*)tmp, in[i]);
    data[i]      = tmp[7];
    data[512+i]  = tmp[6];
    data[1024+i] = tmp[5];
    data[1536+i] = tmp[4];
    data[2048+i] = tmp[3];
    data[2560+i] = tmp[2];
    data[3072+i] = tmp[1];
    data[3584+i] = tmp[0];
  }
}

void orthogonalize(uint64_t* data, __m512i* out) {
  orthogonalize_512x512(data,out);
}
void unorthogonalize(__m512i *in, uint64_t* data) {
  unorthogonalize_512x512(in,data);
}

#else

void orthogonalize(uint64_t *in, __m512i *out) {
  for (int i = 0; i < 512; i++)
    out[i] = _mm512_set_epi64(in[i*8], in[i*8+1], in[i*8+2], in[i*8+3],
                              in[i*8+4], in[i*8+5], in[i*8+6], in[i*8+7]);
}

void unorthogonalize(__m512i *in, uint64_t *out) {
  for (int i = 0; i < 512; i++)
    _mm512_store_si512 ((__m512i*)&(out[i*8]), in[i]);
}

#endif /* ORTHO */

#endif /* NO_RUNTIME */
