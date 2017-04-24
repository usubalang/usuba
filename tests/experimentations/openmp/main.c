#include <stdlib.h>
#include <stdio.h>
#include "tmmintrin.h"
#include "emmintrin.h"
#include "smmintrin.h"
#include "immintrin.h"
#include "omp.h"
#include "x86intrin.h"
#include <inttypes.h>


#include "des_ua_kwan_AVX256.c"

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

void orthogonalize(unsigned long* data, __m256i* out) {
  real_ortho(data);
  real_ortho(&(data[64]));
  real_ortho(&(data[128]));
  real_ortho(&(data[192]));
  for (int i = 0; i < 64; i++)
    out[i] = _mm256_set_epi64x(data[i], data[64+i], data[128+i], data[192+i]);
}

void unorthogonalize(__m256i *in, unsigned long* data) {
  for (int i = 0; i < 64; i++) {
    unsigned long tmp[4];
    _mm256_store_si256 ((__m256i*)tmp, in[i]);
    data[i] = tmp[0];
    data[64+i] = tmp[1];
    data[128+i] = tmp[2];
    data[192+i] = tmp[3];
  }
  real_ortho(data);
  real_ortho(&(data[64]));
  real_ortho(&(data[128]));
  real_ortho(&(data[192]));
}

void single_des (unsigned long *buff_in, unsigned long* buff_out,
                 __m256i *key_ortho, unsigned long size) {
  __m256i *plain_ortho = aligned_alloc(32,64 * sizeof *plain_ortho);
  __m256i *cipher_ortho = aligned_alloc(32,64 * sizeof *cipher_ortho);

  int id = omp_get_thread_num();
  
  for (int i = 0; i < size; i+=256) {
    unsigned long* plain_std = &(buff_in[size*id+i]);
    unsigned long* cipher_std = &(buff_out[size*id+i]);
    
    for (int i = 0; i < 256; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    orthogonalize(plain_std, plain_ortho);

    des__(plain_ortho, key_ortho, cipher_ortho);

    unorthogonalize(cipher_ortho,cipher_std);
    
    for (int i = 0; i < 256; i++)
      cipher_std[i] = __builtin_bswap64(cipher_std[i]);
  }
}

int main() {
  
  FILE* fh_in = fopen("input.txt","rb");
  FILE* fh_out = fopen("output.txt","wb");
  
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
  __m256i *key_ortho = aligned_alloc(32,64 * sizeof *key_ortho);
  
  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = _mm256_cmpeq_epi64(_mm256_setzero_si256(),_mm256_setzero_si256());
    else
      key_ortho[63-i] = _mm256_setzero_si256();
  
  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);

  unsigned long* buff_in  = malloc(size * sizeof(char));
  unsigned long* buff_out = malloc(size * sizeof(char));

  if (fread(buff_in,1,size,fh_in) != size){
    fprintf(stderr,"Read went wrong.\n"); exit(1);
  }


  for (int i = 1; i <= 8; i++) {
    uint64_t start = _rdtsc();
    #pragma omp parallel num_threads(i)
    {
      single_des(buff_in,buff_out,key_ortho,size/i/sizeof(unsigned long));
    }
    printf("%2d => %llu\n",i, _rdtsc() - start);
  }
  
  
  fwrite(buff_out,1,size,fh_out);

  fclose(fh_in);
  fclose(fh_out);
}
