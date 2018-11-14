#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>
#include <stdint.h>

#include "stream.h"

//#include "t/crypto_stream_aes128ctr.h"
//#include "t/crypto_stream.h"

#ifndef NB_LOOP
#define NB_LOOP 25000
#endif

#ifndef BUFF_SIZE
#define BUFF_SIZE (4096*8)
#endif

int main() {
  
  unsigned char key[16] = { 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
                            0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };

  unsigned char* input = aligned_alloc(32, BUFF_SIZE);

  for (int i = 0; i < 5000; i++) {
    crypto_stream_ecb(input,input,BUFF_SIZE,key);
  }
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    crypto_stream_ecb(input,input,BUFF_SIZE,key);
  }
  timer = _rdtsc() - timer;

  printf("%.2f cycle/byte\n",(double)timer/NB_LOOP/BUFF_SIZE);

  FILE* fp = fopen("/dev/null","w");
  fwrite(input,BUFF_SIZE,1,fp);

}
