/** @file main.cpp
 */

#include "rectangle.h"
#include "test.h"
#include "timing.h"
#include <x86intrin.h>
#include <time.h>


#define IN_SIZE (8*8192)

#define NB_LOOP 10000
void speed() {
  unsigned char input[IN_SIZE] __attribute ((aligned(32)));
  unsigned char output[IN_SIZE] __attribute ((aligned(32)));
  
  unsigned char key[10] = { 0 };

  {
    int outlen;
    for (int i = 0; i < 10000; i++)
      rectangle_ecb_enc(input,IN_SIZE,output,&outlen,key,80);

    uint64_t timer = _rdtsc();
    for (int i = 0; i < NB_LOOP; i++)
      rectangle_ecb_enc(input,IN_SIZE,output,&outlen,key,80);
    timer = _rdtsc() - timer;
    printf("%.2f\n",(double)timer/IN_SIZE/NB_LOOP);
  }

  
  FILE* fh = fopen("/dev/null","w");
  for (int i = 0; i < 8; i++) fprintf(fh,"%02x ",input[i]);
  for (int i = 0; i < 8; i++) fprintf(fh,"%02x ",output[i]);
  
}

int main()
{
  speed();

  return 0;
}
