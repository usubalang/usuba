#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <x86intrin.h>
#include <stdint.h>


#ifndef NB_LOOP
#define NB_LOOP 10000000
#endif


#ifdef USUBA
#include "aes.c"
#if !defined(EXPANDED)
#define fun() AES__(input,key,input)
#else
#define fun() AES__(key,input[0],input[1],input[2],input[3],input[4],input[5],input[6],input[7],input)
#endif
#endif

#ifdef FULL_KIVI
void AES__(__m128i*,__m128i,__m128i,__m128i,__m128i,__m128i,__m128i,__m128i,__m128i);
#define fun() AES__((__m128i*)key,input[0],input[1],input[2],input[3],input[4],input[5],input[6],input[7]);
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

  __m128i input[8];
  for (int i = 0; i < 8; i++)
    input[i] = _mm_set_epi64x(rand(),rand());
  __m128i key[11][8];
  for (int i = 0; i < 11; i++)
    for (int j = 0; j < 8; j++)
      key[i][j] = _mm_set_epi64x(rand(),rand());
  

  for (int i = 0; i < 10000; i++)
    fun();

  uint64_t timer = _rdtsc();
  for (int i = 0; i < NB_LOOP; i++)
    fun();
  timer = _rdtsc() - timer;

  
  uint64_t expected[16] = {
    0x22a00729bc777e38, 0xda67603b80e150ea, 0x5b12f1070162a737, 0xe15ce43bc0b6acad,
    0x42a4e46156eda339, 0x76f0c1298728d59b, 0x8516bef55a58bba2, 0xb1baa78874f0183f,
    0x3e17df20e326c7d6, 0x9b6a237ef98392dc, 0x345428a813560deb, 0xe42049bf160fa0a1,
    0xc6fe2b40955c0ae4, 0xc31627b6742ed0f5, 0x5399ec066a8734a3, 0x4f834153faf82460 };
  
  if (memcmp(expected,input,16*8) != 0) {
    fprintf(stderr, "Invalid computation.\n");
  }

  printf("%.2f cycles\n", (double)timer / NB_LOOP);
    
  FILE* f = fopen("/dev/null", "w");
  fwrite(input,16,8,f);
  fclose(f);
}
