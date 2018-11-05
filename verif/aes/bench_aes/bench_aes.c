#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>
#include <stdint.h>


#ifndef NB_LOOP
#define NB_LOOP 10000000
#endif


#ifdef UA_MACRO
#define USUBA
#define MACRO
#elif defined(UA_KIVI)
#define USUBA
#define KIVI
#elif !defined(FULL_KIVI)
#error Please define UA_MACRO, UA_KIVI or FULL_KIVI
#endif


#ifdef USUBA
#include "aes.c"

#ifdef INDIRECT
#ifdef EXPANDED
void __attribute__ ((noinline))
    tmp(__m128i key[11][8], __m128i v0, __m128i v1, __m128i v2, __m128i v3,
        __m128i v4, __m128i v5, __m128i v6, __m128i v7, __m128i* input) {
  AES__(key,v0,v1,v2,v3,v4,v5,v6,v7,input);
}
#define fun() tmp(key,input[0],input[1],input[2],input[3],\
                  input[4],input[5],input[6],input[7], input);
#else
void __attribute__ ((noinline))
tmp(__m128i input[8], __m128i key[11][8], __m128i output[8]) {
  AES__(input, key, output);
}
#define fun() tmp(input,key,input)
#endif // #ifdef EXPANDED

#elif defined(EXPANDED)
#define fun() AES__(key,input[0],input[1],input[2],input[3],\
                    input[4],input[5],input[6],input[7],input)

#else
#define fun() AES__(input,key,input)

#endif // #ifdef INDIRECT

#endif // #ifdef USUBA

#ifdef FULL_KIVI
#ifdef INDIRECT
void AES__(__m128i*,__m128i,__m128i,__m128i,__m128i,__m128i,__m128i,__m128i,__m128i);
void __attribute__ ((noinline)) tmp(__m128i* key, __m128i v0, __m128i v1, __m128i v2, __m128i v3,
         __m128i v4, __m128i v5, __m128i v6, __m128i v7, __m128i* input) {
  __asm__("callq AES__;"
          : "+x" (v0), "+x" (v1), "+x" (v2), "+x" (v3), "+x" (v4), "+x" (v5), "+x" (v6), "+x" (v7)
          : "m" (key)
          : "eax", "r8", "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15");
  input[0] = v0; input[1] = v1; input[2] = v2; input[3] = v3;
  input[4] = v4; input[5] = v5; input[6] = v6; input[7] = v7;
}
#define fun() tmp((__m128i*)key,input[0],input[1],input[2],input[3],input[4],input[5],input[6],input[7], input);
#else
#include "kivi_orig_inline.c"
#define fun() AES__(key,input[0],input[1],input[2],input[3],input[4],input[5],input[6],input[7])
#endif
#endif

#ifndef PRINT128HEX
#define PRINT128HEX
#include <x86intrin.h>
void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
}
#endif
#include <x86intrin.h>
void print(__m128i toPrint) {
  uint64_t* buff = (uint64_t *) &toPrint;
  printf("%016lx %016lx", buff[0], buff[1]);
  printf("\n");
}

int main() {

  srand(1);

  __m128i input[8];
  for (int i = 0; i < 8; i++)
    input[i] = _mm_set_epi64x(rand(),rand());
  __m128i key[11][8];
  for (int i = 0; i < 11; i++)
    for (int j = 0; j < 8; j++)
      key[i][j] = _mm_set_epi64x(rand(),rand());

  for (int i = 0; i < 10000; i++)
    fun();
  //printf("%016lx %016lx\n",((uint64_t*)input)[0],((uint64_t*)input)[1]);

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    fun();
  timer = _rdtsc() - timer;

  /* for (int i = 0; i < 4; i++) { */
  /*   printf("0x%016lx, 0x%016lx, 0x%016lx, 0x%016lx,\n",((uint64_t*)input)[i*4+0],((uint64_t*)input)[i*4+1],((uint64_t*)input)[i*4+2],((uint64_t*)input)[i*4+3]); */
  /* } */

#ifdef __clang__
  uint64_t expected[16] = {
    0x22a00729bc777e38, 0xda67603b80e150ea, 0x5b12f1070162a737, 0xe15ce43bc0b6acad,
    0x42a4e46156eda339, 0x76f0c1298728d59b, 0x8516bef55a58bba2, 0xb1baa78874f0183f,
    0x3e17df20e326c7d6, 0x9b6a237ef98392dc, 0x345428a813560deb, 0xe42049bf160fa0a1,
    0xc6fe2b40955c0ae4, 0xc31627b6742ed0f5, 0x5399ec066a8734a3, 0x4f834153faf82460,
  };

#else
  uint64_t expected[16] = {
    0xda67603b80e150ea, 0x22a00729bc777e38, 0xe15ce43bc0b6acad, 0x5b12f1070162a737,
    0x76f0c1298728d59b, 0x42a4e46156eda339, 0xb1baa78874f0183f, 0x8516bef55a58bba2,
    0x9b6a237ef98392dc, 0x3e17df20e326c7d6, 0xe42049bf160fa0a1, 0x345428a813560deb,
    0xc31627b6742ed0f5, 0xc6fe2b40955c0ae4, 0x4f834153faf82460, 0x5399ec066a8734a3,
  };
#endif
  
  if (memcmp(expected,input,16*8) != 0) {
    fprintf(stderr, "Invalid computation.\n");
  }

  printf("%.2f cycles\n", (double)timer / NB_LOOP);
    
  FILE* f = fopen("/dev/null", "w");
  fwrite(input,16,8,f);
  fclose(f);
}
