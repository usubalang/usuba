#include <stdlib.h>
#include <stdio.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "des_uak_manual_64std.c"


int main() {
  
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain = malloc(64 * sizeof *plain);
  unsigned long *cipher = malloc(64 * sizeof *cipher);
  
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
  unsigned long *key_ortho = malloc(64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = -1;
    else
      key_ortho[63-i] = 0;
  
  
  while(fread(plain, 8, 64, fh_in)) {

    for (int i = 0; i < 64; i++)
      plain[i] = __builtin_bswap64(plain[i]);

    des__(plain, key_ortho, cipher);
             
    for (int i = 0; i < 64; i++)
      cipher[i] = __builtin_bswap64(cipher[i]);
    
    fwrite(cipher, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
