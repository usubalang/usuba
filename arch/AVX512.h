/* ******************************************** *\
 * 
 * 
 *
\* ******************************************** */


/* Including headers */
#include <stdlib.h>
#include <x86intrin.h>

/* Defining 0 and 1 */
#define ZERO _mm512_setzero_si512()
#define ONES _mm512_set1_epi32(-1)

/* Defining macros */
#define REG_SIZE 512

#define AND(a,b)  _mm512_and_si512(a,b)
#define OR(a,b)   _mm512_or_si512(a,b)
#define XOR(a,b)  _mm512_xor_si512(a,b)
#define ANDN(a,b) _mm512_andnot_si512(a,b)
#define NOT(a)    _mm512_andnot_si512(a,ONES)

#define DATATYPE __m512i

#define SET_ALL_ONE()  ONES
#define SET_ALL_ZERO() ZERO

#define ORTHOGONALIZE(in,out) orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) aligned_alloc(32,size * sizeof(__m512i))


#ifndef NO_RUNTIME


/* Orthogonalization stuffs */
static unsigned long mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};

static unsigned long mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};


void real_ortho(unsigned long data[]) {
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        unsigned long u = data[j + k] & mask_l[i];
        unsigned long v = data[j + k] & mask_r[i];
        unsigned long x = data[j + n + k] & mask_l[i];
        unsigned long y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

#ifdef ORTHO

void orthogonalize(unsigned long* data, __m512i* out) {
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

void unorthogonalize(__m512i *in, unsigned long* data) {
  for (int i = 0; i < 64; i++) {
    unsigned long tmp[8];
    _mm512_store_si512 ((__m512i*)tmp, in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
    data[128+i] = tmp[2];
    data[192+i] = tmp[3];
    data[256+i] = tmp[4];
    data[320+i] = tmp[5];
    data[384+i] = tmp[6];
    data[448+i] = tmp[7];
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

#else

void orthogonalize(unsigned long *in, __m512i *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _mm512_set_epi64(in[i*4], in[i*4+1], in[i*4+2], in[i*4+3],
                              in[i*4+4], in[i*4+5], in[i*4+6], in[i*4+7]);
}

void unorthogonalize(__m512i *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    _mm512_store_si512 ((__m512i*)&(out[i*8]), in[i]);
}

#endif /* ORTHO */

#endif /* NO_RUNTIME */
