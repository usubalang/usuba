/* gcc -O3 -march=native -o sse sse.c */


#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>


#include "ortho_gp.h"

/* static void print64bin (const unsigned long n) { */
/*   char* bytearray = (char*)&n; */
/* #define print8bin(c) printf("%d%d%d%d%d%d%d%d",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\ */
/*                             c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0) */
/*   for (int i = 0; i < 8; i++) */
/*     print8bin(bytearray[i]); */
/*   puts(""); */
/* } */

void print64bin (const unsigned long n) {
  for (int i = 1; i <= 64; i++) {
    printf("%lu",(n>>(64-i)) & 1);
  }
  puts("");
}


#define NB_LOOP 5000000

void eval_speed() {

  uint64_t data[64];
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < 100000; i++)
    orthogonalize(data,64,6,0);
  timer = _rdtsc() - timer;
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    orthogonalize(data,64,6,0);
  timer = _rdtsc() - timer;
  printf("Cycles per ortho: %lu\n", timer / NB_LOOP);
  
  FILE* f = fopen("/dev/null","r");
  fwrite(data,8,16,f);

}

void visual() {

  uint64_t data[64];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = a;
    a -= (unsigned long)1 << (63-i);
  }
  
  for (int i = 0; i < 64; i++) print64bin(data[i]); puts("\n");

  orthogonalize(data,64,6,0);

  
  for (int i = 0; i < 64; i++) print64bin(data[i]);puts("\n");
  
  
}

int main() {

  eval_speed();
  //visual();
  
  return 0;
  
}
