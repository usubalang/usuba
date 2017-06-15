#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "wip_des_kwan.c"

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
  /* unsigned long key_std = */
  /*   ((unsigned long) key_std_char[0]) << 0  |  */
  /*   ((unsigned long) key_std_char[1]) << 8  | */
  /*   ((unsigned long) key_std_char[2]) << 16 | */
  /*   ((unsigned long) key_std_char[3]) << 24 | */
  /*   ((unsigned long) key_std_char[4]) << 32 | */
  /*   ((unsigned long) key_std_char[5]) << 40 | */
  /*   ((unsigned long) key_std_char[6]) << 48 | */
  /*   ((unsigned long) key_std_char[7]) << 56; */
  //key_std = __builtin_bswap64(key_std);
  unsigned long key_std = 0x133457799BBCDFF1;
  unsigned long *key_ortho = malloc(64* sizeof *key_ortho);

  for (int i = 0; i < 8; i++)
    for (int j = 1; j < 8; j++)
      key_ortho[i*7+j-1] = key_std >> (i*8+j) & 1 ? -1 : 0;

  /* for (int i = 0; i < 56; i++) */
  /*   printf("%d",key_ortho[i]&1?1:0); */
  /* printf("\n"); */

  unsigned long plain_std = 0x0123456789ABCDEF;
  unsigned long *plain_ortho = malloc(64 * sizeof *key_ortho);  
  for (int i = 0; i < 64; i++)
    if (plain_std >> i & 1)
      plain_ortho[i] = -1;
    else
      plain_ortho[i] = 0;
  
  /* for (int i = 0; i < 64; i++) */
  /*   printf("%d",plain_ortho[i]&1?1:0); */
  /* printf("\n"); */
      
  deseval(plain_ortho, plain_ortho, key_ortho);

  /* for (int i = 0; i < 64; i++) */
  /*   printf("%d",plain_ortho[i]&1?1:0); */
  /* printf("\n"); */

  unsigned long res = 0;
  for (unsigned long i = 0; i < 64; i++)
    if (plain_ortho[i]&1)
      res |= 1UL << i;
  printf("%lX\n",res);
  
}
