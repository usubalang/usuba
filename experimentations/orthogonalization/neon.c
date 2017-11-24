/* gcc -O3 -march=native -o sse sse.c */


#include <stdio.h>
#include <stdlib.h>
#include "x86intrin.h"
#include <stdint.h>

#include "Neon.h"

void print64bin (const uint64_t n) {
  for (int i = 1; i <= 64; i++) {
    printf("%lu",(n>>(64-i)) & 1);
  }  
}

void print128bin (const __m128i v) {
  uint64_t out[2];
  vst1q_u64((uint64_t*)out,v);
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}


void check_ortho () {
  
  DATATYPE buffer[128];

  for (uint64_t i = 0, a = -1; i < 64; i++) {
    buffer[i] = (uint64x2_t){ -1,  a };
    a -= (uint64_t)1 << (63-i);
  }
  for (uint64_t i = 0, a = -1; i < 64; i++) {
    buffer[i+64] = (uint64x2_t){ a,  0 };
    a -= (uint64_t)1 << (63-i);
  }

  for (int i = 0; i < 128; i++)
    print128bin(buffer[i]);

  real_ortho_128x128(buffer);

  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  
  for (int i = 0; i < 128; i++)
    print128bin(buffer[i]); 

}


int main() {

  check_ortho();

  return 0;
  
}
