
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>


#include "des.c"


#ifndef INIT_RAND
#define INIT_RAND 5
#endif

uint64_t rand_ulong() {
  static uint64_t state = INIT_RAND;
  return state = state * 6364136223846793005 + 1442695040888963407;
}

/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64

#define NB_LOOP 100000

int main() {

  // Hardcoding a key for now...
  uint64_t key_std = 0x133457799BBCDFF1;
  DATATYPE *key_ortho = ALLOC(KEY_SIZE);
  DATATYPE *key_cst   = ALLOC(KEY_SIZE);

  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = key_cst[63-i] = SET_ALL_ONE();
    else
      key_ortho[63-i] = key_cst[63-i] = SET_ALL_ZERO();
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(BLOCK_SIZE);
  DATATYPE *cipher_ortho = ALLOC(BLOCK_SIZE);
  uint64_t *plain_std = ALLOC(REG_SIZE);
  for (int i = 0; i < REG_SIZE; i++) plain_std[i] = rand_ulong();

  uint64_t timer;
  for (int i = 0; i < NB_LOOP; i++) {

    for (int i = 0; i < REG_SIZE; i++) plain_std[i] ^= rand_ulong();

    ORTHOGONALIZE(plain_std, plain_ortho);

    uint64_t tmp = _rdtsc();
    des__(plain_ortho, key_ortho, cipher_ortho);
    timer += _rdtsc() - tmp;
    
    UNORTHOGONALIZE(cipher_ortho,plain_std);

  }
  printf("%lu\n",timer);
  
  return 0;
}
