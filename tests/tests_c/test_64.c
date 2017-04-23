#include <stdlib.h>
#include <stdio.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"
#include "x86intrin.h"
#include <inttypes.h>

#include "des_ua_kwan_Std64.c"

int main() {
  
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");

  uint64_t reading = _rdtsc();
  unsigned long buf[64];
  while(fread(buf, 8, 64, fh_in)) {
    fwrite(buf, 8, 64, fh_out);
  }
  reading = _rdtsc() - reading;
  printf("File read/write: %lu cycles\n",reading);

  rewind(fh_in);
  rewind(fh_out);
  
  uint64_t start = _rdtsc();
  
  unsigned long *restrict plain_std = malloc(64 * sizeof *plain_std);
  unsigned long *restrict cipher_std = malloc(64 * sizeof *cipher_std);
  
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
  unsigned long *restrict key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = -1;
    else
      key_ortho[63-i] = 0;

  uint64_t cpt = 0, tot = 0, tmp;

  uint64_t mid = _rdtsc();
  while(fread(plain_std, 8, 64, fh_in)) {

    for (int i = 0; i < 64; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    tmp = _rdtsc();
    des__(plain_std, key_ortho, cipher_std);
    tot += _rdtsc() - tmp;
    cpt++;
    
    for (int i = 0; i < 64; i++)
      cipher_std[i] = __builtin_bswap64(cipher_std[i]);

    fwrite(cipher_std, 8, 64, fh_out);
  }
  mid = _rdtsc() - mid;
 
  fclose(fh_in);
  fclose(fh_out);

  
  printf("Avg per DES call.... %lu cycles\n",tot/cpt);
  printf("Total time in DES... %lu cycles\n",tot);
  printf("Total middle........ %lu cycles\n",mid);
  printf("Nowhere............. %lu cycles\n",mid-tot);
  printf("Total execution..... %llu cycles\n",_rdtsc()-start);
}
