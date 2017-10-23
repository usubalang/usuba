/* ******************************************** *\
 * 
 * 
 *
\* ******************************************** */


/* Including headers */
#include <stdlib.h>


#ifndef LOG2_BITS_PER_REG
#define LOG2_BITS_PER_REG 6
#endif
#ifndef BITS_PER_REG
#define BITS_PER_REG 64
#endif

/* Defining macros */
#define REG_SIZE BITS_PER_REG

#define AND(a,b)  ((a) & (b))
#define OR(a,b)   ((a) | (b))
#define XOR(a,b)  ((a) ^ (b))
#define ANDN(a,b) (~(a) & (b))
#define NOT(a)    (~(a))

#define DATATYPE unsigned long

#define SET_ALL_ONE()  -1
#define SET_ALL_ZERO() 0

#define ORTHOGONALIZE(in,out)   orthogonalize(in,out)
#define UNORTHOGONALIZE(in,out) unorthogonalize(in,out)

#define ALLOC(size) malloc(size * sizeof(unsigned long))



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
  for (int i = 0; i < LOG2_BITS_PER_REG; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < BITS_PER_REG; j += (2 * n))
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

void orthogonalize(unsigned long* data, unsigned long* out) {
  for (int i = 0; i < 64; i++)
    out[i] = data[i];
  real_ortho(out);
}

void unorthogonalize(unsigned long *in, unsigned long* data) {
  for (int i = 0; i < 64; i++)
    data[i] = in[i];
  real_ortho(data);
}

#else

void orthogonalize(unsigned long* data, unsigned long* out) {
  for (int i = 0; i < 64; i++)
    out[i] = data[i];
}

void unorthogonalize(unsigned long *in, unsigned long* data) {
  for (int i = 0; i < 64; i++)
    data[i] = in[i];
}


#endif /* ORTHO */

#endif /* NO_RUNTIME */
