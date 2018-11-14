#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>

#ifdef std
#define STD
#endif

#ifdef sse
#define SSE
#endif

#ifdef avx
#define AVX
#endif



#define KEY_SIZE  64
#define BLOC_SIZE 64

#ifdef STD
#define NO_RUNTIME
#include "STD.h"
#define CHUNK_SIZE 64

static void orthogonalize(uint64_t* data, uint64_t* out) {
  for (int i = 0; i < 64; i++)
    out[i] = data[i];
}

static void unorthogonalize(uint64_t *in, uint64_t* data) {
  for (int i = 0; i < 64; i++)
    data[i] = in[i];
}

#elif defined(SSE)
#define NO_RUNTIME
#include "SSE.h"
#define CHUNK_SIZE 256

static void orthogonalize(uint64_t* data, __m128i* out) {
  for (int i = 0; i < 128; i++)
    out[i] = _mm_set_epi64x(data[i], data[128+i]);
}

static void unorthogonalize(__m128i *in, uint64_t* data) {
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

static void orthogonalize(uint64_t* data, __m256i* out) {
  for (int i = 0; i < 256; i++)
    out[i] = _mm256_set_epi64x(data[i], data[256+i], data[512+i], data[768+i]);
}

static void unorthogonalize(__m256i *in, uint64_t* data) {
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

#if defined(STD)
#include "std/des.c"
#elif defined(SSE)
#include "sse/des.c"
#else
#include "avx/des.c"
#endif



#define NB_LOOP 100000

/* Bench the implementation */
void speed() {
  
  uint64_t key_std    = 0x133457799BBCDFF1;
  DATATYPE key_ortho[KEY_SIZE];
  DATATYPE key_cst[KEY_SIZE];
  
  for (int i = 0; i < 64; i++)
    key_ortho[63-i] = key_cst[63-i] = (key_std >> i) & 1 ? SET_ALL_ONE() : SET_ALL_ZERO();

  DATATYPE plain_ortho[REG_SIZE];
  DATATYPE cipher_ortho[REG_SIZE];
  uint64_t plain_std[CHUNK_SIZE];
  for (int i = 0; i < CHUNK_SIZE; i++)
    plain_std[i] = rand();

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
  }                                                                 \

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
  speed();
}
