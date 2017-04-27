#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "des_kwan.c"

void orthogonalize(unsigned long *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    out[i] = in[i];
}

void unorthogonalize(unsigned long *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    out[i] = in[i];
}

int main() {
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std = *(unsigned long*) key_std_char;
  unsigned long *key_ortho = malloc(64 * sizeof *key_ortho);
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[i] = -1;
    else
      key_ortho[i] = 0;
  

  FILE* fh_in = fopen("input.txt","rb");

  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  unsigned long *plain_std = aligned_alloc(32,size);

  fread(plain_std,size,1,fh_in);
  fclose(fh_in);
  
  clock_t timer = clock();
  for (int u = 0; u < 16; u++) {
    for (int x = 0; x < size/8; x += 64) {
  
      unsigned long* loc_std = plain_std + x;
    
      for (int i = 0; i < 64; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
      
      deseval(loc_std, loc_std, key_ortho);
    
      for (int i = 0; i < 64; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  printf("%f\n",((double)clock()-timer)/CLOCKS_PER_SEC);
  
  FILE* fh_out = fopen("output.txt","wb");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);

}
