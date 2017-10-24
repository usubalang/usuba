#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include <inttypes.h>


static unsigned int mask_l[5] = {
	0xaaaaaaaaUL,
	0xccccccccUL,
	0xf0f0f0f0UL,
	0xff00ff00UL,
	0xffff0000UL
};

static unsigned int mask_r[5] = {
	0x55555555UL,
	0x33333333UL,
	0x0f0f0f0fUL,
	0x00ff00ffUL,
	0x0000ffffUL
};


void orthogonalize(unsigned int data[]) {
  for (int i = 0; i < 5; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 32; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        unsigned int u = data[j + k] & mask_l[i];
        unsigned int v = data[j + k] & mask_r[i];
        unsigned int x = data[j + n + k] & mask_l[i];
        unsigned int y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

int main () {
  
  uint64_t start, end;
  int total = 1e7;
  unsigned int *restrict buffer = malloc(32 * sizeof *buffer);

  // Initializing the buffer
  for (int i = 0; i < 32; i++) 
    buffer[i] = rand()&0xFFFFFFFF;
    
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
