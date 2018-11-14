#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>
#include <stdint.h>

#include "stream.h"


#ifndef NB_LOOP
#define NB_LOOP 100000
#endif

#ifndef BUFF_SIZE
#define BUFF_SIZE 4096
#endif

int main() {
  
  unsigned char key[16] = { 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
                            0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };
  unsigned char iv[16]  = { 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
                            0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };

  unsigned char input[BUFF_SIZE] __attribute__((aligned(32)));

  for (int i = 0; i < 10000; i++) {
    crypto_stream(input,BUFF_SIZE,iv,key);
  }
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    crypto_stream(input,BUFF_SIZE,iv,key);
  }
  timer = _rdtsc() - timer;

  printf("%.2f cycle/byte\n",(double)timer/NB_LOOP/BUFF_SIZE);

  FILE* fp = fopen("/dev/null","w");
  fwrite(input,BUFF_SIZE,1,fp);

}
