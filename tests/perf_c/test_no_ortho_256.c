/* Compile with:
   gcc -o test_des test_des.c -Wall -Wextra -O3 -march=native
   
   Run with:
   ./des

   Make sure "input.txt" is present in the directory before running 
   (you can generate it with "make_input.c" if needed).
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"

#include "des_256.c"

void dummy_ortho(unsigned long *in, __m256i *out) {
    for (int i = 0; i < 64; i++)
      out[i] = _mm256_set_epi64x (in[i*2], in[i*2+1], in[i*2+2], in[i*2+3]);
}

void dummy_unortho(__m256i *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    _mm256_store_si256 ((__m256i*)&(out[i*4]), in[i]);
}



int main() {

  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = aligned_alloc(32,256 * sizeof *plain_std);
  __m256i *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);

  __m256i *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);
  unsigned long *cipher_std = aligned_alloc(32,256 * sizeof *cipher_std);
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std = *(unsigned long*) key_std_char;
  __m256i *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  __m256i dummy = _mm256_setzero_si256();
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      // _mm256_cmpeq_epi64(x,x) sets all the bits to 1.
      key_ortho[i] = _mm256_cmpeq_epi64(dummy,dummy);
    else
      // _mm256_setzero_si256() sets all the bits to 0.
      key_ortho[i] = _mm256_setzero_si256();
  
  
  while(fread(plain_std, 8, 256, fh_in)) {

    dummy_ortho(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    dummy_unortho(cipher_ortho,cipher_std);
    
    fwrite(cipher_std, 8, 256, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
