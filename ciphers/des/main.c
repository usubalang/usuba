#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>

#if !defined(kwan) && !defined(ua)
#error Please define kwan or ua
#endif

#ifdef std
#define STD
#endif

#ifdef sse
#define SSE
#endif

#ifdef avx
#define AVX
#endif

#ifdef kwan
#define KWAN
#endif


#define KEY_SIZE  64
#define BLOC_SIZE 64

#ifdef STD
#define NO_RUNTIME
#include "STD.h"
#define CHUNK_SIZE 64
static uint64_t mask_l[6] = {
	0xaaaaaaaaaaaaaaaaUL,
	0xccccccccccccccccUL,
	0xf0f0f0f0f0f0f0f0UL,
	0xff00ff00ff00ff00UL,
	0xffff0000ffff0000UL,
	0xffffffff00000000UL
};

static uint64_t mask_r[6] = {
	0x5555555555555555UL,
	0x3333333333333333UL,
	0x0f0f0f0f0f0f0f0fUL,
	0x00ff00ff00ff00ffUL,
	0x0000ffff0000ffffUL,
	0x00000000ffffffffUL
};


static void real_ortho(uint64_t data[]) {
  for (int i = 0; i < 6; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 64; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        uint64_t u = data[j + k] & mask_l[i];
        uint64_t v = data[j + k] & mask_r[i];
        uint64_t x = data[j + n + k] & mask_l[i];
        uint64_t y = data[j + n + k] & mask_r[i];
        data[j + k] = u | (x >> n);
        data[j + n + k] = (v << n) | y;
      }
  }
}
static void orthogonalize(uint64_t* data, uint64_t* out) {
  for (int i = 0; i < 64; i++)
    out[i] = data[i];
  real_ortho(out);
}

static void unorthogonalize(uint64_t *in, uint64_t* data) {
  for (int i = 0; i < 64; i++)
    data[i] = in[i];
  real_ortho(data);
}

#elif defined(SSE)
#define NO_RUNTIME
#include "SSE.h"
#define CHUNK_SIZE 256

static void real_ortho_128x128(__m128i data[]) {

  __m128i mask_l[7] = {
    _mm_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm_set1_epi64x(0xccccccccccccccccUL),
    _mm_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm_set1_epi64x(0xffff0000ffff0000UL),
    _mm_set1_epi64x(0xffffffff00000000UL),
    _mm_set_epi64x(0x0000000000000000UL,0xffffffffffffffffUL),
  
  };

  __m128i mask_r[7] = {
    _mm_set1_epi64x(0x5555555555555555UL),
    _mm_set1_epi64x(0x3333333333333333UL),
    _mm_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm_set1_epi64x(0x0000ffff0000ffffUL),
    _mm_set1_epi64x(0x00000000ffffffffUL),
    _mm_set_epi64x(0xffffffffffffffffUL,0x0000000000000000UL),
  };
  
  for (int i = 0; i < 7; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 128; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m128i u = _mm_and_si128(data[j + k], mask_l[i]);
        __m128i v = _mm_and_si128(data[j + k], mask_r[i]);
        __m128i x = _mm_and_si128(data[j + n + k], mask_l[i]);
        __m128i y = _mm_and_si128(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm_or_si128(u, _mm_srli_epi64(x, n));
          data[j + n + k] = _mm_or_si128(_mm_slli_epi64(v, n), y);
        } else {
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm_or_si128(u, _mm_slli_si128(x, 8));
          data[j + n + k] = _mm_or_si128(_mm_srli_si128(v, 8), y);
        } 
      }
  }
}

static void orthogonalize(uint64_t* data, __m128i* out) {
  for (int i = 0; i < 128; i++)
    out[i] = _mm_set_epi64x(data[i], data[128+i]);
  real_ortho_128x128(out);
}

static void unorthogonalize(__m128i *in, uint64_t* data) {
  real_ortho_128x128(in);
  for (int i = 0; i < 128; i++) {
    uint64_t tmp[2];
    _mm_store_si128 ((__m128i*)tmp, in[i]);
    data[i] = tmp[1];
    data[128+i] = tmp[0];
  }
}

#elif defined(AVX)
#define NO_RUNTIME
#include "AVX.h"
#define CHUNK_SIZE 1024

static void real_ortho_256x256(__m256i data[]) {

  __m256i mask_l[8] = {
    _mm256_set1_epi64x(0xaaaaaaaaaaaaaaaaUL),
    _mm256_set1_epi64x(0xccccccccccccccccUL),
    _mm256_set1_epi64x(0xf0f0f0f0f0f0f0f0UL),
    _mm256_set1_epi64x(0xff00ff00ff00ff00UL),
    _mm256_set1_epi64x(0xffff0000ffff0000UL),
    _mm256_set1_epi64x(0xffffffff00000000UL),
    _mm256_set_epi64x(0UL,-1UL,0UL,-1UL),
    _mm256_set_epi64x(0UL,0UL,-1UL,-1UL),
  
  };

  __m256i mask_r[8] = {
    _mm256_set1_epi64x(0x5555555555555555UL),
    _mm256_set1_epi64x(0x3333333333333333UL),
    _mm256_set1_epi64x(0x0f0f0f0f0f0f0f0fUL),
    _mm256_set1_epi64x(0x00ff00ff00ff00ffUL),
    _mm256_set1_epi64x(0x0000ffff0000ffffUL),
    _mm256_set1_epi64x(0x00000000ffffffffUL),
    _mm256_set_epi64x(-1UL,0UL,-1UL,0UL),
    _mm256_set_epi64x(-1UL,-1UL,0UL,0UL),
  };
  
  for (int i = 0; i < 8; i ++) {
    int n = (1UL << i);
    for (int j = 0; j < 256; j += (2 * n))
      for (int k = 0; k < n; k ++) {
        __m256i u = _mm256_and_si256(data[j + k], mask_l[i]);
        __m256i v = _mm256_and_si256(data[j + k], mask_r[i]);
        __m256i x = _mm256_and_si256(data[j + n + k], mask_l[i]);
        __m256i y = _mm256_and_si256(data[j + n + k], mask_r[i]);
        if (i <= 5) {
          data[j + k] = _mm256_or_si256(u, _mm256_srli_epi64(x, n));
          data[j + n + k] = _mm256_or_si256(_mm256_slli_epi64(v, n), y);
        } else if (i == 6) {
          /* Note the "inversion" of srli and slli. */
          data[j + k] = _mm256_or_si256(u, _mm256_slli_si256(x, 8));
          data[j + n + k] = _mm256_or_si256(_mm256_srli_si256(v, 8), y);
        } else {
          data[j + k] = _mm256_or_si256(u, _mm256_permute2x128_si256( x , x , 1));
          data[j + n + k] = _mm256_or_si256(_mm256_permute2x128_si256( v , v , 1), y);
        }
      }
  }
}

static void orthogonalize(uint64_t* data, __m256i* out) {
  for (int i = 0; i < 256; i++)
    out[i] = _mm256_set_epi64x(data[i], data[256+i], data[512+i], data[768+i]);
  real_ortho_256x256(out);
}

static void unorthogonalize(__m256i *in, uint64_t* data) {
  real_ortho_256x256(in);
  for (int i = 0; i < 256; i++) {
    uint64_t tmp[4];
    _mm256_store_si256 ((__m256i*)tmp, in[i]);
    data[i] = tmp[3];
    data[256+i] = tmp[2];
    data[512+i] = tmp[1];
    data[768+i] = tmp[0];
  }
}

#else
#error You need to define STD, SSE or AVX.
#endif

#ifdef KWAN
#include "kwan/des.c"
#elif defined(STD)
#include "std/des.c"
#elif defined(SSE)
#include "sse/des.c"
#else
#include "avx/des.c"
#endif


/* Checks the correctness of the implementation against 
   a reference (Perl) implementation */
void verif() {
  uint64_t key_std    = 0x133457799BBCDFF1;
  DATATYPE key_ortho[KEY_SIZE];

#ifdef KWAN
  for (int i = 0, idx = 0; i < 8; i++) {
    for (int j = 1; j < 8; j++) {
      key_ortho[idx++] = (key_std >> (i*8+j)) & 1 ? SET_ALL_ONE() : SET_ALL_ZERO();
    }
  }
#else  
  DATATYPE key_cst[KEY_SIZE];
  for (int i = 0; i < 64; i++)
    key_ortho[63-i] = key_cst[63-i] = (key_std >> i) & 1 ? SET_ALL_ONE() : SET_ALL_ZERO();
#endif

  FILE* fp_in  = fopen("input.txt","rb");
  if (! fp_in ) {
    fprintf(stderr, "Couldn't find input.txt.\n");
    return;
  }
  FILE* fp_out = fopen("out_c.txt","wb");

  DATATYPE plain_ortho[REG_SIZE];
  DATATYPE cipher_ortho[REG_SIZE];
  uint64_t plain_std[CHUNK_SIZE];
  
  while(fread(plain_std, 8, CHUNK_SIZE, fp_in)) {

    for (int i = 0; i < CHUNK_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    orthogonalize(plain_std, plain_ortho);

    for (int i = 0; i < CHUNK_SIZE / REG_SIZE; i++) {
      #ifdef ua
      memcpy(key_ortho,key_cst,KEY_SIZE * (REG_SIZE/8));
      #endif
      des__(&plain_ortho[i*64], key_ortho, &cipher_ortho[i*64]);
    }
    
    unorthogonalize(cipher_ortho,plain_std);
    
    for (int i = 0; i < CHUNK_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    fwrite(plain_std, 8, CHUNK_SIZE, fp_out);
  }

  fclose(fp_in);
  fclose(fp_out);

  if (system("./des_ecb.pl")) fprintf(stderr, "Error while running Perl DES.");
  if (system("diff out_c.txt out_pl.txt")) {
    fprintf(stderr, "Encryption error.\n");
  }

}

#define NB_LOOP 100000

/* Bench the implementation */
void speed() {
  
  uint64_t key_std    = 0x133457799BBCDFF1;
  DATATYPE key_ortho[KEY_SIZE];

#ifdef KWAN
  for (int i = 0, idx = 0; i < 8; i++) {
    for (int j = 1; j < 8; j++) {
      key_ortho[idx++] = (key_std >> (i*8+j)) & 1 ? SET_ALL_ONE() : SET_ALL_ZERO();
    }
  }
#else  
  DATATYPE key_cst[KEY_SIZE];
  for (int i = 0; i < 64; i++)
    key_ortho[63-i] = key_cst[63-i] = (key_std >> i) & 1 ? SET_ALL_ONE() : SET_ALL_ZERO();
#endif

  DATATYPE plain_ortho[REG_SIZE];
  DATATYPE cipher_ortho[REG_SIZE];
  uint64_t plain_std[CHUNK_SIZE];
  for (int i = 0; i < CHUNK_SIZE; i++)
    plain_std[i] = rand();

#ifdef KWAN
#define RUN_DES                                                     \
  {                                                                 \
    for (int i = 0; i < CHUNK_SIZE; i++)                            \
      plain_std[i] = __builtin_bswap64(plain_std[i]);               \
                                                                    \
    orthogonalize(plain_std, plain_ortho);                          \
                                                                    \
    for (int i = 0; i < CHUNK_SIZE / REG_SIZE; i++) {               \
      des__(&plain_ortho[i*64], key_ortho, &cipher_ortho[i*64]);    \
    }                                                               \
                                                                    \
    unorthogonalize(cipher_ortho,plain_std);                        \
                                                                    \
    for (int i = 0; i < CHUNK_SIZE; i++)                            \
      plain_std[i] = __builtin_bswap64(plain_std[i]);               \
  }
#else
#define RUN_DES                                                     \
  {                                                                 \
    for (int i = 0; i < CHUNK_SIZE; i++)                            \
      plain_std[i] = __builtin_bswap64(plain_std[i]);               \
                                                                    \
    orthogonalize(plain_std, plain_ortho);                          \
                                                                    \
    for (int i = 0; i < CHUNK_SIZE / REG_SIZE; i++) {               \
      memcpy(key_ortho,key_cst,KEY_SIZE * (REG_SIZE/8));            \
      des__(&plain_ortho[i*64], key_ortho, &cipher_ortho[i*64]);    \
    }                                                               \
                                                                    \
    unorthogonalize(cipher_ortho,plain_std);                        \
                                                                    \
    for (int i = 0; i < CHUNK_SIZE; i++)                            \
      plain_std[i] = __builtin_bswap64(plain_std[i]);               \
  }
#endif
  
  for (int i = 0; i < 10000; i++) {
    RUN_DES;
  }

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++) {
    RUN_DES;
  }
  timer = _rdtsc() - timer;

  printf("%.2f cycle/byte\n",(double)timer/NB_LOOP/(CHUNK_SIZE*(BLOC_SIZE/8)));

  FILE* fp = fopen("/dev/null","w");
  fwrite(plain_std,CHUNK_SIZE,1,fp);  
}

int main() {
  verif();
  speed();
}
