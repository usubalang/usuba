/* gcc -O3 -march=native -o sse sse.c */


#include <stdio.h>
#include <stdlib.h>
#include <x86intrin.h>
#include <stdint.h>


#include "ortho_avx.h"

void print64bin (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8bin(c) printf("%d%d%d%d%d%d%d%d",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8bin(bytearray[i]);
}
void print256bin (const __m256i v) {
  unsigned long *out = (unsigned long*) &v;
  for (int i = 0; i <= 3; i++) {
    print64bin(out[i]);
  }
  puts("");
}

#define NB_LOOP 5000000

void eval_speed() {

  __m256i data[256];
  
  uint64_t timer = _rdtsc();
  for (int i = 0; i < 100000; i++)
    orthogonalize(data,256,8,0);
  timer = _rdtsc() - timer;
  
  timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
  orthogonalize(data,256,8,0);
  timer = _rdtsc() - timer;
  printf("Cycles per ortho: %lu\n", timer / NB_LOOP);
  
  FILE* f = fopen("/dev/null","r");
  fwrite(data,8,16,f);

}

void visual() {
  __m256i data[256];
  
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i] = _mm256_set_epi64x(-1,-1,-1,a);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i+64] = _mm256_set_epi64x(-1,-1,a,0);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i+128] = _mm256_set_epi64x(-1,a,0,0);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }
  for (unsigned long i = 0, a = -1; i < 64; i++) {
    data[i+192] = _mm256_set_epi64x(a,0,0,0);
    a -= (unsigned long)1 << ((7+8*(i/8))-(i%8));
  }

  for (int i = 0; i < 256; i++) print256bin(data[i]);

  orthogonalize(data,256,8,0);
  puts("");

  for (int i = 0; i < 256; i++) print256bin(data[i]);
  puts("\n");
}

int main() {

  //eval_speed();
  visual();
  
  return 0;
  
}
