#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "des_kwan.c"

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


void real_ortho(unsigned long data[]) {
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

void orthogonalize(unsigned long data[]){
  real_ortho(data);
}

void unorthogonalize(unsigned long data[]){
  real_ortho(data);
}

int main() {
  /* Hardcoding the key for now. */
  unsigned char key_std_char[8] = {0x13,0x34,0x57,0x79,0x9B,0xBC,0xDF,0xF1};
  unsigned long key_std = *(unsigned long*) key_std_char;
  unsigned long *key_ortho = malloc(64 * sizeof *key_ortho);
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[i] = -1;
    else
      key_ortho[i] = 0;
  

  FILE* fh_in = fopen("input.txt","rb");

  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  unsigned long *plain_std = aligned_alloc(32,size);

  fread(plain_std,size,1,fh_in);
  fclose(fh_in);
  
  clock_t timer = clock();
  for (int u = 0; u < 16; u++) {
    for (int x = 0; x < size/8; x += 64) {
  
      unsigned long* loc_std = plain_std + x;
    
      for (int i = 0; i < 64; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);

      orthogonalize(loc_std);
      
      deseval(loc_std, loc_std, key_ortho);

      unorthogonalize(loc_std);
    
      for (int i = 0; i < 64; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  printf("%f\n",((double)clock()-timer)/CLOCKS_PER_SEC);
  
  FILE* fh_out = fopen("output.txt","wb");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);

}
