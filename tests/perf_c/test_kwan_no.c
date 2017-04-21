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

  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = malloc(64 * sizeof *plain_std);
  unsigned long *cipher_std = malloc(64 * sizeof *cipher_std);
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std = *(unsigned long*) key_std_char;
  unsigned long *key_ortho = malloc(64 * sizeof *key_ortho);
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[i] = -1;
    else
      key_ortho[i] = 0;
  
  
  while(fread(plain_std, 8, 64, fh_in)) {
    
    deseval(plain_std, cipher_std, key_ortho);
    
    fwrite(cipher_std, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
