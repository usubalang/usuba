#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "des_kwan_output_sep.c"

static unsigned long mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};

static unsigned long mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};


void orthogonalize(unsigned long data[]) {
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        unsigned long u = data[j + k] & mask_l[i];
        unsigned long v = data[j + k] & mask_r[i];
        unsigned long x = data[j + n + k] & mask_l[i];
        unsigned long y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}

int main() {
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
  unsigned long *plain = malloc(64 * sizeof *plain);
  unsigned long *cipher = malloc(64 * sizeof *cipher);
  
  /* Hardcoding the key for now. */
  unsigned long key_std = 0x133457799BBCDFF1;
  unsigned long *key_ortho = malloc(64* sizeof *key_ortho);

  for (int i = 0; i < 8; i++)
    for (int j = 1; j < 8; j++)
      key_ortho[i*7+j-1] = key_std >> (i*8+j) & 1 ? -1 : 0;
  
  
  while(fread(plain, 8, 64, fh_in)) {

    for (int i = 0; i < 64; i++)
      plain[i] = __builtin_bswap64(plain[i]);
    
    orthogonalize(plain);
    for (int i = 0; i < 32; i++) {
      unsigned long tmp = plain[i];
      plain[i] = plain[63-i];
      plain[63-i] = tmp;
    }
    
    deseval(plain, cipher, key_ortho);
    
    for (int i = 0; i < 32; i++) {
      unsigned long tmp = cipher[i];
      cipher[i] = cipher[63-i];
      cipher[63-i] = tmp;
    }
    orthogonalize(cipher);
    
    for (int i = 0; i < 64; i++)
      cipher[i] = __builtin_bswap64(cipher[i]);
    
    fwrite(cipher, 8, 64, fh_out);
  }

  fclose(fh_in);
  fclose(fh_out);
}
