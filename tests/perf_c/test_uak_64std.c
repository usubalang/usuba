#include <stdlib.h>
#include <stdio.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "des_ua_kwan_Std64.c"

void orthogonalize(unsigned long *in, unsigned long *out) {
    for (int j = 0; j < 64; j++) {
    out[63-j] = 0;
    for (int i = 0; i < 64; i++)
      out[63-j] |= (in[i]>>j & 1) << i;
  }
}

void unorthogonalize(unsigned long *in, unsigned long *out) {
    for (int i = 0; i < 64; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++)
    for (int i = 0; i < 64; i++)
      out[i] |= (in[63-j]>>i & 1) << j;
}

int main() {
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = aligned_alloc(32,64 * sizeof *plain_std);
  unsigned long *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);

  unsigned long *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);
  unsigned long *cipher_std = aligned_alloc(32,64 * sizeof *cipher_std);
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std =
    ((unsigned long) key_std_char[0]) << 56 |
    ((unsigned long) key_std_char[1]) << 48  |
    ((unsigned long) key_std_char[2]) << 40 |
    ((unsigned long) key_std_char[3]) << 32 |
    ((unsigned long) key_std_char[4]) << 24 |
    ((unsigned long) key_std_char[5]) << 16 |
    ((unsigned long) key_std_char[6]) << 8 |
    ((unsigned long) key_std_char[7]) << 0;
  unsigned long *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = -1;
    else
      key_ortho[63-i] = 0;
  
  
  while(fread(plain_std, 8, 64, fh_in)) {

    for (int i = 0; i < 64; i++) {
      unsigned long l = plain_std[i];
      plain_std[i] = (l >> 56) | (l >> 40 & 0x00FF00) | (l >> 24 & 0x00FF0000)
        | (l >> 8 & 0x00FF000000) | (l << 8 & 0x00FF00000000) | (l << 24 & 0x00FF0000000000)
        | (l << 40 & 0x00FF000000000000) | (l << 56);
    }

    orthogonalize(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    unorthogonalize(cipher_ortho,cipher_std);
    
    for (int i = 0; i < 64; i++) {
      unsigned long l = cipher_std[i];
      cipher_std[i] = (l >> 56) | (l >> 40 & 0x00FF00) | (l >> 24 & 0x00FF0000)
        | (l >> 8 & 0x00FF000000) | (l << 8 & 0x00FF00000000) | (l << 24 & 0x00FF0000000000)
        | (l << 40 & 0x00FF000000000000) | (l << 56);
    }

    fwrite(cipher_std, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
