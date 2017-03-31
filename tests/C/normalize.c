#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <time.h>

typedef struct _int128 {
  int c[4];
} int128;

void print_uint128(int128 n) {
  for (int i = 0; i < 4; i++)
    for (int j = 31; j >= 0; j--)
      printf("%d",n.c[i] >> j & 1);
}

uint64_t rand64() {
  return ((uint64_t) rand() <<  0) ^
    ((uint64_t) rand() << 16) ^ 
    ((uint64_t) rand() << 32) ^
    ((uint64_t) rand() << 48);
}


void orthogonalize (uint64_t in[128], int128 out[64]) {
  for (int i = 0; i < 128; i++)
    for (int j = 0; j < 64; j++) 
      out[j].c[i/32] |= ((in[i] >> j) & 1) << (31-(i%32));
}


int main() {
  srand(7); /* tadaaaaa */
  
  uint64_t* in = malloc(128 * sizeof *in);
  for (int i = 0; i < 128; i++)
    in[i] = rand64();

  int128* out = calloc(64, sizeof *out);
  orthogonalize(in,out);

  print_uint128(out[0]);
  printf("\n");
  for (int i = 0; i < 128; i++) {
    printf("%lu",in[i]&1);
  }
  printf("\n\n************************\n\n");
  print_uint128(out[31]);
  printf("\n");
  for (int i = 0; i < 128; i++) {
    printf("%lu",in[i]>>31&1);
  }
  printf("\n\n************************\n\n");
  print_uint128(out[63]);
  printf("\n");
  for (int i = 0; i < 128; i++) {
    printf("%lu",in[i]>>63);
  }

  return 0;
}
