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

#include "des_64_simd.c"

void print_int64 (unsigned long c) {
  for (int i = 0; i < 64; i++)
    printf("%lu", c >> i & 1);
  printf("\n");
}


void orthogonalize(unsigned long *in, __m64 *out) {
  for (int j = 0; j < 64; j++) {
    unsigned long tmp = 0;
    for (int i = 0; i < 64; i++)
      tmp |= (in[i]>>j & 1) << i;
    out[j] = _mm_cvtsi64_m64(tmp);
  }
}

void unorthogonalize(__m64 *in, unsigned long *out) {

  for (int i = 0; i < 64; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++) {
    unsigned long tmp = _mm_cvtm64_si64(in[j]);
    for (int i = 0; i < 64; i++)
      out[i] |= (tmp>>i & 1) << j;
  }
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
  unsigned long key_std = *(unsigned long*) key_std_char;
  __m64 *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  __m64 dummy = _mm_setzero_si64();
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      // _mm64_cmpeq_epi64(x,x) sets all the bits to 1.
      key_ortho[i] = _mm_cmpeq_pi32(dummy,dummy);
    else
      // _mm64_setzero_si64() sets all the bits to 0.
      key_ortho[i] = _mm_setzero_si64();
  
  
  while(fread(plain_std, 8, 64, fh_in)) {

    orthogonalize(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    unorthogonalize(cipher_ortho,cipher_std);
    
    fwrite(cipher_std, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
