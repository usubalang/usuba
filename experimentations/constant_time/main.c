
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <x86intrin.h>


#define NB_LOOP 10000

#include "des.h"


#ifdef FULL_ZERO
uint64_t rand_ulong(uint64_t* state) {
  return 0UL;
}
#elif defined FULL_ONE
uint64_t rand_ulong(uint64_t* state) {
  return -1UL;
}
#else
uint64_t rand_ulong(uint64_t* state) {
  *state = *state * 6364136223846793005 + 1442695040888963407;
  return *state;
}
#endif


void orthogonalize(uint64_t* data, uint64_t* out) {
  for (int i = 0; i < 64; i++)
    out[i] = data[i];
}

void unorthogonalize(uint64_t *in, uint64_t* data) {
  for (int i = 0; i < 64; i++)
    data[i] = in[i];
}


#define KEY_SIZE   64

int main(int argc, char** argv) {

  uint64_t state = atoi(argv[1]);

  // Hardcoding a key for now...
  uint64_t key_std = 0x133457799BBCDFF1;
  unsigned long *key_ortho = malloc(64*sizeof *key_ortho);
  unsigned long *key_cst   = malloc(64*sizeof *key_cst);

  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = key_cst[63-i] = 0;
    else
      key_ortho[63-i] = key_cst[63-i] = -1;

  
  // Allocating various stuffs
  unsigned long *plain_ortho  = malloc(64*sizeof *plain_ortho);
  unsigned long *cipher_ortho = malloc(64*sizeof *cipher_ortho);
  uint64_t *plain_std = malloc(64*sizeof *plain_std);
  for (int i = 0; i < 64; i++) plain_std[i] = rand_ulong(&state);

  for (int i = 0; i < 64; i++) plain_std[i] ^= rand_ulong(&state);
  orthogonalize(plain_std, plain_ortho);
  des__(plain_ortho, key_ortho, cipher_ortho);
  unorthogonalize(cipher_ortho,plain_std);
    
  for (int i = 0; i < NB_LOOP; i++) {
    orthogonalize(plain_std, plain_ortho);
    uint64_t timer = _rdtsc();
    //clock_t ck = clock_gettime(CLOCK_MONOTONIC_RAW);
    des__(plain_ortho, key_ortho, cipher_ortho);
    timer = _rdtsc() - timer;
    unorthogonalize(cipher_ortho,plain_std);
    printf("%ld ", timer);
  }
  
  return 0;
}
