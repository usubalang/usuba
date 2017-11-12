/*

  To run this, you need first to go in "aes.c", remove #define NO_RUNTIME,
  and replace #include "STD.h" with  #include "AVX.h"

  Note however that I'm not sure this test actually works.
  Still, the throughput should be close to what it would be once this
  test is fixed: somewhere between 400 & 500 MiB/s


 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define ORTHO
#include "key_sched.c"
#include "aes.c"

#include "AVX.h"

#define NB_LOOP 16

int main() {

  // Hardcoding a key for now...
  char k[16] = { 0 };
  char* key = key_sched(k);

  DATATYPE* key_ortho = ALLOC(1408);
  DATATYPE* key_cst = ALLOC(1408);
  for (int i = 0; i < 1408; i++)
    key_ortho[i] = key_cst[i] =
      (key[i/8] >> (7-i%8)) & 1 ? SET_ALL_ONE() : SET_ALL_ZERO();

  // Reading the input file
  FILE* fh_in = fopen("input.txt","rb");
  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  // Allocating various stuffs
  DATATYPE* plain_ortho  = ALLOC(128*4);
  DATATYPE* cipher_ortho = ALLOC(128*4);
  /* note: "size" could be size/(size_of(DATATYPE)) */
  char *plain_std = ALLOC(size);

  // Storing the input file
  if (fread(plain_std,size,1,fh_in) != 1) {
     fprintf(stderr, "Read error.");
     exit(EXIT_FAILURE);
  }
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < NB_LOOP; u++) {
    for (int x = 0; x < size; x += 16*REG_SIZE*4) {
  
      char* loc_std = plain_std + x;

      orthogonalize((uint64_t*)loc_std,(DATATYPE*)plain_ortho);

      for (int i = 0; i < 4; i++) {
        memcpy(key_ortho,key_cst,128*sizeof *key_cst);
        AES__(&plain_ortho[128*i], key_ortho, &cipher_ortho[128*i]);
      }
    
      unorthogonalize((DATATYPE*)cipher_ortho,(uint64_t*)loc_std);
    }
  }
  timer = clock() - timer;

  clock_t ortho_ck = clock();
  for (int u = 0; u < 16; u++)
    for (int x = 0; x < size/8; x += 16*REG_SIZE*4) {
      char* loc_std = plain_std + x;
      orthogonalize((uint64_t*)loc_std, (DATATYPE*)plain_ortho);
      unorthogonalize((DATATYPE*)plain_ortho,(uint64_t*)loc_std);
    }
  ortho_ck = clock() - ortho_ck;

  double speed = size*NB_LOOP/((double)timer/CLOCKS_PER_SEC)/1e6;
  double ortho_time = speed * ortho_ck / timer;
  printf("%.2f %.2f\n",speed,ortho_time);
  
  FILE* fh_out = fopen("output.txt","wb");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);

  return 0;
}
