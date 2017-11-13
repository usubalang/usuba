#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include <inttypes.h>


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


void orthogonalize(unsigned long data[]) {
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

static unsigned long m[6] = {
  0x5555555555555555UL,
  0x3333333333333333UL,
  0x0f0f0f0f0f0f0f0fUL,
  0x00ff00ff00ff00ffUL,
  0x0000ffff0000ffffUL,
  0x00000000ffffffffUL
};
static unsigned long _m[6] = {
  0xaaaaaaaaaaaaaaaaUL,
  0xccccccccccccccccUL,
  0xf0f0f0f0f0f0f0f0UL,
  0xff00ff00ff00ff00UL,
  0xffff0000ffff0000UL,
  0xffffffff00000000UL
};

/* Pseudo-code from "Bitslice implementation of aes" */
void orthogonalize2(unsigned long B[]) {

  for (int j = 0; j < 6; j++) {
    unsigned long k = 1 << j;
    unsigned long k2 = k * 2;
    unsigned long r = k - 1;
    for (int i = 0; i < 64 / 2; i++) {
      unsigned long l = 2*(i - (i&r)) + (i&r);
      unsigned long temp = (B[l] & m[j]) | ((B[l+k2] | m[j]) << k);
      B[l+k2] = (B[l+k2] & _m[j]) | ((B[l] & _m[j]) >> k);
      B[l] = temp;
    }
  }
}

int main () {
  
  uint64_t start, end;
  int total = 1e7;
  unsigned long *restrict buffer = malloc(64 * sizeof *buffer);

  // Initializing the buffer
  for (int i = 0; i < 64; i++) 
    buffer[i] = (rand()&0xFFFFFFFF) | (((long)rand())<<32);
    
  /* Warming up the cache */
  for (int i = 0; i < 100; i++)
    orthogonalize(buffer);

  /* The actual mesure */
  start = _rdtsc();
  for (int i = 0; i < total; i++)
      orthogonalize(buffer);
  end = _rdtsc() - start;

  /* Counting how much cycles were lost "looping" */
  start = _rdtsc();
  for (int i = 0; i < total; i++)
    asm("");
  end -= (_rdtsc() - start);

  /* Printing the result */
  printf("Cycles per ortho: %lu\n", end / total);

  return 0;
}
