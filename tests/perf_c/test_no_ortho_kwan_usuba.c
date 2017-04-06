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

#include "kwan_usuba_des.c"

void print_int64 (unsigned long c) {
  for (int i = 0; i < 64; i++)
    printf("%lu", c >> i & 1);
  printf("\n");
}

void print_int128 (__m128i n) {
  unsigned long tmp[2];
  _mm_store_si128 ((__m128i*)tmp, n);
  for (int i = 0; i < 2; i++)
    for (int j = 0; j < 64; j++)
      printf("%lu",(unsigned long)tmp[i] >> (63-j) & 1);
  printf("\n");
}

void print_nth_bit (__m128i* in, int nth) {
  for (int i = 0; i < 64; i++) {
    unsigned long tmp[2];
    _mm_store_si128 ((__m128i*)tmp, in[i]);
    printf("%lu",tmp[nth/64] >> nth%64 & 1);
  }
  printf("\n");
}

void dummy_ortho(unsigned long *in, __m128i *out) {
    for (int i = 0; i < 64; i++)
      out[i] = _mm_set_epi64x (in[i*2], in[i*2+1]);
}

void dummy_unortho(__m128i *in, unsigned long *out) {
  for (int i = 0; i < 64; i++)
    _mm_store_si128 ((__m128i*)&(out[i*2]), in[i]);
}


int main() {

  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain_std = malloc(128 * sizeof *plain_std);
  __m128i *plain_ortho = malloc(64 * sizeof *plain_ortho);

  __m128i *cipher_ortho = malloc(64 * sizeof *cipher_ortho);
  unsigned long *cipher_std = malloc(128 * sizeof *cipher_std);
  
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std = *(unsigned long*) key_std_char;
  __m128i *key_ortho = malloc(64 * sizeof *key_ortho);
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      // _mm_cmpeq_epi64(x,x) sets all the bits to 1.
      key_ortho[i] = _mm_cmpeq_epi64(key_ortho[i],key_ortho[i]);
    else
      // _mm_setzero_si128() sets all the bits to 0.
      key_ortho[i] = _mm_setzero_si128();
  
  
  while(fread(plain_std, 8, 128, fh_in)) {

    dummy_ortho(plain_std, plain_ortho);
    
    /* print_int64(plain_std[0]); */
    /* print_nth_bit(plain_ortho,0); */
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    dummy_unortho(cipher_ortho,cipher_std);
    
    fwrite(cipher_std, 8, 128, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
