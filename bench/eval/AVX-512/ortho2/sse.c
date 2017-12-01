
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
#include "SSE.h"

/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64



int main() {

  unsigned long* input = ALLOC(CHUNK_SIZE);
  DATATYPE* output     = ALLOC(REG_SIZE);

  // Initializing the buffer
  for (int i = 0; i < CHUNK_SIZE; i++) 
    input[i] = rand();

  /* Warming up the cache */
  for (int i = 0; i < 100; i++)
    ORTHOGONALIZE(input, output);

  /* The actual mesure */
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    ORTHOGONALIZE(input, output);
  timer = _rdtsc() - timer;

  /* Counting how much cycles were lost "looping" */
  timer -= _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    asm("");
  timer += _rdtsc();

  printf("%d\n",(int)(timer/NB_LOOP));
  

  return 0;
}
