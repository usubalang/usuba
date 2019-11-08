/* gcc -O3 -march=native -o sse sse.c */


#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>


#include "ortho_sse.h"

void print64bin (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8bin(c) printf("%d%d%d%d%d%d%d%d",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8bin(bytearray[i]);
}

void print128bin (const __m128i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}

#define NB_LOOP 5000000

void eval_speed() {

  __m128i data[128];
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < 100000; i++)
    orthogonalize(data,128,7,0);
  timer = _rdtsc() - timer;
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
  orthogonalize(data,128,7,0);
  timer = _rdtsc() - timer;
  printf("Cycles per ortho: %lu\n", timer / NB_LOOP);
  
  FILE* f = fopen("/dev/null","r");
  fwrite(data,8,16,f);

}

void visual() {
  __m128i data[128];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = _mm_set_epi64x(-1,a);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i+64] = _mm_set_epi64x(a,0);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }

  for (int i = 0; i < 128; i++) print128bin(data[i]);

  orthogonalize(data,128,7,0);
  puts("");

  for (int i = 0; i < 128; i++) print128bin(data[i]);
  puts("\n");
}

int main() {

  eval_speed();
  //visual();
  
  return 0;
  
}
