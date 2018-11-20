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

#ifdef avx512
#define AVX512
#endif



#define KEY_SIZE  64
#define BLOC_SIZE 64

#ifdef STD
#define NO_RUNTIME
#include "STD.h"
#define CHUNK_SIZE 64


#elif defined(SSE)
#define NO_RUNTIME
#include "SSE.h"
#define CHUNK_SIZE 256


#elif defined(AVX)
#define NO_RUNTIME
#include "AVX.h"
#define CHUNK_SIZE 1024


#elif defined(AVX512)
#define NO_RUNTIME
#include "AVX512.h"
#define CHUNK_SIZE 4096


#else
#error You need to define STD, SSE or AVX.
#endif

#if defined(STD)
#include "std/des.c"
#elif defined(SSE)
#include "sse/des.c"
#elif defined(AVX)
#include "avx/des.c"
#else
#include "avx512/des.c"
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
  {                                                                     \
                                                                        \
                                                                        \
    for (int i = 0; i < CHUNK_SIZE / REG_SIZE; i++) {                   \
      memcpy(key_ortho,key_cst,KEY_SIZE * (REG_SIZE/8));                \
      des__((DATATYPE*)&plain_ortho[i*64], key_ortho, (DATATYPE*)&cipher_ortho[i*64]); \
    }                                                                   \
                                                                        \
                                                                        \
  }                                                                     \

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
