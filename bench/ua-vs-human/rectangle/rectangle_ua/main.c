#include <x86intrin.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "stream.h"



#define IN_SIZE (8*8192)


#define NB_LOOP 10000
void speed() {
  unsigned char input[IN_SIZE] __attribute ((aligned(32)));
  unsigned char output[IN_SIZE] __attribute ((aligned(32)));
  
  unsigned char key[10] = { 0 };

  {
    for (int i = 0; i < 10000; i++)
      crypto_stream_ecb(output,input,IN_SIZE,key);

    uint64_t timer = _rdtsc();
    for (int i = 0; i < NB_LOOP; i++)
      crypto_stream_ecb(output,input,IN_SIZE,key);
    timer = _rdtsc() - timer;
    printf("Usuba: %.2f\n",(double)timer/IN_SIZE/NB_LOOP);
  }

  {
    for (int i = 0; i < 10000; i++)
      ortho_speed(output,input,IN_SIZE,key);
    
    uint64_t timer = _rdtsc();
    for (int i = 0; i < NB_LOOP; i++)
      ortho_speed(output,input,IN_SIZE,key);
    timer = _rdtsc() - timer;
    printf("Ortho: %.2f\n",(double)timer/IN_SIZE/NB_LOOP);
  }
  
  FILE* fh = fopen("/dev/null","w");
  for (int i = 0; i < 8; i++) fprintf(fh,"%02x ",input[i]);
  for (int i = 0; i < 8; i++) fprintf(fh,"%02x ",output[i]);
  
}

int main() {
  speed();

  return 0;
}
