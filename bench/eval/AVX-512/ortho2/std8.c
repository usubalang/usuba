
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
static uint8_t mask_l[3] = {
	0xaa,
	0xcc,
	0xf0,
};

static uint8_t mask_r[3] = {
	0x55,
	0x33,
	0x0f,
};


void real_ortho(uint8_t data[]) {
  for (int i = 0; i < 3; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 8; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint8_t u = data[j + k] & mask_l[i];
        uint8_t v = data[j + k] & mask_r[i];
        uint8_t x = data[j + n + k] & mask_l[i];
        uint8_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

void orthogonalize(uint8_t* data, uint8_t* out) {
  for (int i = 0; i < 8; i++)
    out[i] = data[i];
  real_ortho(out);
}

void unorthogonalize(uint8_t *in, uint8_t* data) {
  for (int i = 0; i < 8; i++)
    data[i] = in[i];
  real_ortho(data);
}

/* runtime */


int main() {

  uint8_t* input  = malloc(8 * sizeof *input);
  uint8_t* output = malloc(8 * sizeof *output);

  // Initializing the buffer
  for (int i = 0; i < 8; i++) 
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
