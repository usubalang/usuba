/* ******************************************** *\
 * 
 * 
 *
\* ******************************************** */


/* Including headers */
#include <stdlib.h>
#include <arm_neon.h>

/* Defining 0 and 1 */
#define ZERO ((uint64x2_t){  0,  0 })
#define ONES ((uint64x2_t){ -1, -1 })

/* Defining macros */
#define REG_SIZE 128

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

void orthogonalize(unsigned long* data, __m128i* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  for (int i = 0; i < 64; i++)
    out[i] = _mm_set_epi64x(data[i], data[64+i]);
}

void unorthogonalize(__m128i *in, unsigned long* data) {
  for (int i = 0; i < 64; i++) {
    unsigned long tmp[2];
    _mm_store_si128 ((__m128i*)tmp, in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
}

#else

void orthogonalize(unsigned long *in, uint64x2_t *out) {
  for (int i = 0; i < 64; i++)
    vst1q_u64((unsigned long long*)&in[i],out[i]);
}

void unorthogonalize(uint64x2_t *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    vld1q_u64
    _mm_store_si128 ((__m128i*)&(out[i*2]), in[i]);
}

#endif
