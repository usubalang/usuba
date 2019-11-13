#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <x86intrin.h> // for RDTSCP

// Comment the following 3 line to benchmark without masking
#ifndef MASKING_ORDER
#define MASKING_ORDER 4
#endif

// Comment the following line to use C's rand() instead of not
// generating any random numbers.
#define NUCLEO

#ifndef WARMUP
#define WARMUP 10000
#endif

#ifndef REPEAT
#define REPEAT 100000
#endif

#ifdef MASKING_ORDER
#include "aes_masked.c"
#else
#include "aes.c"
#endif

#ifdef MASKING_ORDER

void speed_masked() {

  uint16_t plain[8][MASKING_ORDER];
  uint16_t key[11][8][MASKING_ORDER];

  /* Warming up caches */
  for (int i = 0; i < WARMUP; i++)
    AES__(plain,key,plain);

  /* The actual measurement */
  unsigned int rdtscp_mem_addr;
  uint64_t timer = __rdtscp(&rdtscp_mem_addr);
  for (int i = 0; i < REPEAT; i++)
    AES__(plain,key,plain);
  timer = __rdtscp(&rdtscp_mem_addr) - timer;


  printf("Time per masked AES: %ld cycles.\n", timer / REPEAT);

}
#else
void speed() {

  uint16_t plain[8];
  uint16_t key[11][8];

  /* Warming up caches */
  for (int i = 0; i < WARMUP; i++)
    AES__(plain,key,plain);

  /* The actual measurement */
  unsigned int rdtscp_mem_addr;
  uint64_t timer = __rdtscp(&rdtscp_mem_addr);
  for (int i = 0; i < REPEAT; i++)
    AES__(plain,key,plain);
  timer = __rdtscp(&rdtscp_mem_addr) - timer;


  printf("Time per AES: %ld cycles.\n", timer / REPEAT);

}
#endif // #ifdef MASKING_ORDER


int main() {
#ifdef MASKING_ORDER
  speed_masked();
#else
  speed();
#endif
}
