
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

/* defining "BENCH" or "STD" */
/* (will impact the .h functions loaded by the .h) */
#define BENCH
#define BITS_PER_REG 64
#define LOG2_BITS_PER_REG 6
/* defining "ORTHO" or not */
#define ORTHO
/* including the architecture specific .h */
#include "AVX.h"

/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64

#ifndef NB_LOOP
#define NB_LOOP 64
#endif

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


  // Reading the input file
  FILE* fh_in = fopen("input.txt","rb");
  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(REG_SIZE);
  DATATYPE *cipher_ortho = ALLOC(REG_SIZE);
  uint64_t *plain_std = ALLOC(size);

  // Storing the input file
  if (fread(plain_std,size,1,fh_in) != 1) {
     fprintf(stderr, "Read error.");
     exit(EXIT_FAILURE);
  }
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < NB_LOOP; u++) {
    for (int x = 0; x < size/8; x += CHUNK_SIZE) {
  
      uint64_t* loc_std = plain_std + x;
    
      for (int i = 0; i < CHUNK_SIZE; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);

      ORTHOGONALIZE(loc_std, plain_ortho);
    
      UNORTHOGONALIZE(cipher_ortho,loc_std);

      for (int i = 0; i < CHUNK_SIZE; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  timer = clock() - timer;

  double speed = size*NB_LOOP/((double)timer/CLOCKS_PER_SEC)/1e6;
  printf("%.2f\n",speed);
  
  FILE* fh_out = fopen("output.txt","wb");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);

  return 0;
}
