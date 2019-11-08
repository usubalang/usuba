#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <x86intrin.h>

#ifndef NB_RUN
#define NB_RUN 1000
#endif

#ifndef WARMING
#define WARMING 100
#endif

extern uint32_t bench_speed();

int main() {

  /* Getting number of encrypted bytes */
  uint64_t encrypted = bench_speed();

  /* Warming up caches */
  for (int i = 0; i < WARMING; i++)
    bench_speed();

  /* The actual benchmark */
  unsigned int garbage;
  uint64_t timer = __rdtscp(&garbage);
  for (int i = 0; i < NB_RUN; i++)
    bench_speed();
  timer = __rdtscp(&garbage) - timer;

  /* Printing the result */
  printf("%.2f cycles/bytes\n", (double)timer / (NB_RUN * encrypted));
}
