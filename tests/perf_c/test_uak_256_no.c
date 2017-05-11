#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "des_ua_kwan_AVX256.c"

void orthogonalize(unsigned long *in, __m256i *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _mm256_set_epi64x (in[i*4], in[i*4+1], in[i*4+2], in[i*4+3]);
}

void unorthogonalize(__m256i *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    _mm256_store_si256 ((__m256i*)&(out[i*4]), in[i]);
}

int main() {
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
  __m256i *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = _mm256_cmpeq_epi64(_mm256_setzero_si256(),_mm256_setzero_si256());
    else
      key_ortho[63-i] = _mm256_setzero_si256();
  
  FILE* fh_in = fopen("input.txt","rb");

  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  unsigned long *plain_std = aligned_alloc(32,size);
  __m256i *plain_ortho = aligned_alloc(32,256 * sizeof *plain_ortho);
  __m256i *cipher_ortho = aligned_alloc(32,256 * sizeof *cipher_ortho);

  fread(plain_std,size,1,fh_in);
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < 16; u++) {
    for (int x = 0; x < size/8; x += 256) {
  
      unsigned long* loc_std = plain_std + x;
    
      for (int i = 0; i < 256; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);

      orthogonalize(loc_std, plain_ortho);
    
      des__(plain_ortho, key_ortho, cipher_ortho);
    
      unorthogonalize(cipher_ortho,loc_std);
    
      for (int i = 0; i < 256; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  printf("%f\n",((double)clock()-timer)/CLOCKS_PER_SEC);
  
  FILE* fh_out = fopen("output.txt","wb");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);
}
