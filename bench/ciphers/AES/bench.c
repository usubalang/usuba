#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "key_sched.c"
#include "aes.c"


void orthogonalize (uint64_t* in, uint64_t* out) {
  for (int i = 0; i < 64; i++)
    out[i] = in[i];
}
void unorthogonalize (uint64_t* in, uint64_t* out) {
  for (int i = 0; i < 64; i++)
    out[i] = in[i];
}

#define NB_LOOP 16

int main() {

  // Hardcoding a key for now...
  char k[16] = { 0 };
  char* key = key_sched(k);

  unsigned long* key_ortho = malloc(1408 * sizeof *key_ortho);
  unsigned long* key_cst = malloc(1408 * sizeof *key_ortho);
  for (int i = 0; i < 1408; i++)
    key_ortho[i] = key_cst[i] =
      (key[i/8] >> (7-i%8)) & 1 ? -1 : 0;

  // Reading the input file
  FILE* fh_in = fopen("input.txt","rb");
  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  // Allocating various stuffs
  unsigned long* plain_ortho  = malloc(128 * sizeof *plain_ortho);
  unsigned long* cipher_ortho = malloc(128 * sizeof *cipher_ortho);
  char *plain_std = malloc(size * sizeof *plain_std);

  // Storing the input file
  if (fread(plain_std,size,1,fh_in) != 1) {
     fprintf(stderr, "Read error.");
     exit(EXIT_FAILURE);
  }
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < NB_LOOP; u++) {
    for (int x = 0; x < size; x += 16*64) {
  
      char* loc_std = plain_std + x;

      orthogonalize((uint64_t*)loc_std, plain_ortho);

      memcpy(key_ortho,key_cst,128*sizeof *key_cst);
      AES__(plain_ortho, key_ortho, cipher_ortho);

    
      unorthogonalize(cipher_ortho,(uint64_t*)loc_std);
    }
  }
  timer = clock() - timer;

  clock_t ortho_ck = clock();
  for (int u = 0; u < 16; u++)
    for (int x = 0; x < size/8; x += CHUNK_SIZE) {
      char* loc_std = plain_std + x;
      orthogonalize((uint64_t*)loc_std, plain_ortho);
      unorthogonalize(plain_ortho,(uint64_t*)loc_std);
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
