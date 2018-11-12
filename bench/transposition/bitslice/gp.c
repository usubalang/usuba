#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

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


static void orthogonalize(uint64_t data[]) {
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



#define NB_LOOP 10000000

int main() {
  uint64_t data[64];
  for (int i = 0; i < 64; i++)
    data[i] = rand();

  for (int i = 0; i < 100000; i++)
    orthogonalize(data);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(data);
  timer = _rdtsc() - timer;

  printf("%.2f cycles/byte\n", (double)timer / NB_LOOP / (8*64));


  FILE* FP = fopen("/dev/null","w");
  fwrite(data,8,64,FP);
  fclose(FP);
}
