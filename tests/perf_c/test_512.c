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

#include "des_512.c"

void print_int64 (unsigned long c) {
  for (int i = 0; i < 64; i++)
    printf("%lu", c >> i & 1);
  printf("\n");
}


void orthogonalize(unsigned long *in, __m512i *out) {
  for (int j = 0; j < 64; j++) {
    unsigned long tmp[8] = {0,0,0,0,0,0,0,0};
    for (int i = 0; i < 512; i++)
      tmp[i/64] |= (in[i]>>j & 1) << i;
    out[j] = _mm512_set_epi64 (tmp[0], tmp[1], tmp[2], tmp[3],
                               tmp[4], tmp[5], tmp[6], tmp[7]);
  }
}

void unorthogonalize(__m512i *in, unsigned long *out) {

  for (int i = 0; i < 512; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++) {
    // converting the __m128i to 2 long (easier to access the bits).
    unsigned long tmp[8];
    _mm512_store_si512 ((__m512i*)tmp, in[j]);
    for (int i = 0; i < 512; i++)
      out[i] |= (tmp[i/64]>>i%64 & 1) << j;
  }
}

int main() {

  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = aligned_alloc(32,512 * sizeof *plain_std);
  __m512i *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);

  __m512i *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);
  unsigned long *cipher_std = aligned_alloc(32,512 * sizeof *cipher_std);
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std = *(unsigned long*) key_std_char;
  __m512i *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  __m512i dummy = _mm512_setzero_si512();
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      // _mm512_cmpeq_epi64(x,x) sets all the bits to 1.
      key_ortho[i] = _mm512_set_epi64(-1,-1,-1,-1,-1,-1,-1,-1);
    else
      // _mm512_setzero_si512() sets all the bits to 0.
      key_ortho[i] = _mm512_setzero_si512();
  
  
  while(fread(plain_std, 8, 512, fh_in)) {

    orthogonalize(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    unorthogonalize(cipher_ortho,cipher_std);
    
    fwrite(cipher_std, 8, 512, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
