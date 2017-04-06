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

#include "des_64.c"


void orthogonalize(unsigned long *in, unsigned long *out) {
  for (int j = 0; j < 64; j++) {
    out[j] = 0;
    for (int i = 0; i < 64; i++)
      out[j] |= (in[i]>>j & 1) << i;
  }
}

void unorthogonalize(unsigned long *in, unsigned long *out) {

  for (int i = 0; i < 64; i++) out[i] = 0;
  
  for (int j = 0; j < 64; j++)
    for (int i = 0; i < 64; i++)
      out[i] |= (in[j]>>i & 1) << j;
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
  unsigned long key_std = *(unsigned long*) key_std_char;
  unsigned long *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      // _mm64_cmpeq_epi64(x,x) sets all the bits to 1.
      key_ortho[i] = -1;
    else
      // _mm64_setzero_si64() sets all the bits to 0.
      key_ortho[i] = 0;
  
  
  while(fread(plain_std, 8, 64, fh_in)) {

    orthogonalize(plain_std, plain_ortho);
    
    des__(plain_ortho, key_ortho, cipher_ortho);
             
    unorthogonalize(cipher_ortho,cipher_std);
    
    fwrite(cipher_std, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
