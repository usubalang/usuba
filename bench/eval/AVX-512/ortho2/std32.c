
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>


#define NB_LOOP 1e6


/* do NOT change the following line */
#define ORTHO
/* including the architecture specific .h */
/* Orthogonalization stuffs */
static int mask_l[5] = {
	0xaaaaaaaaUL,
	0xccccccccUL,
	0xf0f0f0f0UL,
	0xff00ff00UL,
	0xffff0000UL
};

static int mask_r[5] = {
	0x55555555UL,
	0x33333333UL,
	0x0f0f0f0fUL,
	0x00ff00ffUL,
	0x0000ffffUL
};


void real_ortho(int data[]) {
  for (int i = 0; i < 5; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 32; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        int u = data[j + k] & mask_l[i];
        int v = data[j + k] & mask_r[i];
        int x = data[j + n + k] & mask_l[i];
        int y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

void orthogonalize(int* data, int* out) {
  for (int i = 0; i < 32; i++)
    out[i] = data[i];
  real_ortho(out);
}

void unorthogonalize(int *in, int* data) {
  for (int i = 0; i < 32; i++)
    data[i] = in[i];
  real_ortho(data);
}

/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64


int main() {

  int* input  = malloc(32 * sizeof *input);
  int* output = malloc(32 * sizeof *output);

  // Initializing the buffer
  for (int i = 0; i < 32; i++) 
    input[i] = rand();

  /* Warming up the cache */
  for (int i = 0; i < 100; i++)
    orthogonalize(input, output);

  /* The actual mesure */
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(input, output);
  timer = _rdtsc() - timer;

  /* Counting how much cycles were lost "looping" */
  timer -= _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    asm("");
  timer += _rdtsc();

  printf("%d\n",(int)(timer/NB_LOOP));
  

  return 0;
}
