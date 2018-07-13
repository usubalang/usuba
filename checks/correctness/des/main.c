
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define ORTHO

#ifdef STD
#include "STD.h"
#else
#ifdef SSE
#include "SSE.h"
#else
#ifdef AVX
#include "AVX.h"
#else
#error "No implementation provided"
#endif
#endif
#endif


#include "des.c"


/* runtime */

#define BLOCK_SIZE 64
#define KEY_SIZE   64

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
  FILE* fh_out = fopen("output_to_test.txt","wb");
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(REG_SIZE);
  DATATYPE *cipher_ortho = ALLOC(REG_SIZE);
  uint64_t *plain_std = ALLOC(CHUNK_SIZE);


  while(fread(plain_std, 8, CHUNK_SIZE, fh_in)) {

    for (int i = 0; i < CHUNK_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    ORTHOGONALIZE(plain_std, plain_ortho);

    for (int i = 0; i < CHUNK_SIZE / REG_SIZE; i++) {
    
      memcpy(key_ortho,key_cst,KEY_SIZE*sizeof *key_cst);
      des__(&plain_ortho[i*64], key_ortho, &cipher_ortho[i*64]);

    }
    
    UNORTHOGONALIZE(cipher_ortho,plain_std);
    
    for (int i = 0; i < CHUNK_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    fwrite(plain_std, 8, CHUNK_SIZE, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);

  return 0;
}
