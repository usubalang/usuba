
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
static uint16_t mask_l[4] = {
	0xaaaa,
	0xcccc,
	0xf0f0,
	0xff00
};

static uint16_t mask_r[4] = {
	0x5555,
	0x3333,
	0x0f0f,
	0x00ff,
};


void real_ortho(uint16_t data[]) {
  for (int i = 0; i < 4; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 16; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint16_t u = data[j + k] & mask_l[i];
        uint16_t v = data[j + k] & mask_r[i];
        uint16_t x = data[j + n + k] & mask_l[i];
        uint16_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

void orthogonalize(uint16_t* data, uint16_t* out) {
  for (int i = 0; i < 16; i++)
    out[i] = data[i];
  real_ortho(out);
}

void unorthogonalize(uint16_t *in, uint16_t* data) {
  for (int i = 0; i < 16; i++)
    data[i] = in[i];
  real_ortho(data);
}

/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64


int main() {

  uint16_t* input  = malloc(16 * sizeof *input);
  uint16_t* output = malloc(16 * sizeof *output);

  // Initializing the buffer
  for (int i = 0; i < 16; i++) 
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
