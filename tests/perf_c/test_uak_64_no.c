#include <stdlib.h>
#include <stdio.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "des_ua_kwan_MMX64.c"

void orthogonalize(unsigned long *in, __m64 *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _m_from_int64(in[i]);
}

void unorthogonalize(__m64 *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    out[i] = _mm_cvtm64_si64(in[i]);
}

int main() {
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = aligned_alloc(32,64 * sizeof *plain_std);
  __m64 *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);

  __m64 *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);
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
  __m64 *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = _mm_cmpeq_pi32(_mm_setzero_si64(),_mm_setzero_si64());
    else
      key_ortho[63-i] = _mm_setzero_si64();
  
  
  while(fread(plain_std, 8, 64, fh_in)) {

    for (int i = 0; i < 64; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);
    
    orthogonalize(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    unorthogonalize(cipher_ortho,cipher_std);
    
    for (int i = 0; i < 64; i++)
      cipher_std[i] = __builtin_bswap64(cipher_std[i]);

    fwrite(cipher_std, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}