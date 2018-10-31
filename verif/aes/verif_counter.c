#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#define unlikely(x)	(!__builtin_expect(!(x),1))
#define likely(x)	(__builtin_expect(!!(x),1))

#define NO_RUNTIME
#include "SSE.h"

#define BLOCK_SIZE 16
#define PARALLEL_FACTOR 8

#define load128()                                                       \
  __m128i input128[8];                                                  \
  {                                                                     \
    __m128i input[8], out_buff[8];                                      \
    int nb_blocks =  0;                                                 \
    if (unlikely(((uint64_t*)&counter128)[1] > (0xffffffffffffffff-8))) {  \
      for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                \
        input[nb_blocks] = _mm_shuffle_epi8(counter128,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
        incr_counter128(counter128);                                              \
      }                                                                 \
    } else {                                                            \
      for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                \
        input[nb_blocks] = _mm_shuffle_epi8(counter128,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
        counter128 = _mm_sub_epi64(counter128,_mm_slli_si128(ONES,8));        \
      }                                                                 \
    }                                                                   \
    memcpy(input64,input,16*8);                                         \
  }

#define load64()                                                        \
  __m128i input64[8];                                                   \
  {                                                                     \
    __m128i input[8], out_buff[8];                                      \
    int nb_blocks =  0;                                                 \
    if (unlikely(counter64[1] > (0xffffffffffffffff-8))) {                \
      for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                \
        input[nb_blocks] = _mm_shuffle_epi8(*((__m128i*)counter64),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
        /* memcpy(&input[nb_blocks],counter64,16) ;  */                   \
        incr_counter64(counter64);                                          \
      }                                                                 \
    }                                                                   \
    else {                                                              \
      for (; nb_blocks < PARALLEL_FACTOR; nb_blocks++) {                \
        input[nb_blocks] = _mm_shuffle_epi8(*((__m128i*)counter64),_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7)); \
        /* memcpy(&input[nb_blocks],counter64,16) ;  */                   \
        ++counter64[1];                                                   \
      }                                                                 \
    }                                                                   \
    memcpy(input64,input,16*8);                                         \
  }


static void incr_counter64(unsigned long c[2]) {
  if (++c[1] == 0) ++c[0];
}

#define incr_counter128(c) {                            \
    printf("        c=");print128hex(c);                \
    __m128i minus_one = _mm_slli_si128(ONES,8);         \
    printf("minus_one=");print128hex(minus_one);        \
    __m128i overflow = _mm_cmpeq_epi64(c, minus_one);   \
    printf(" overflow=");print128hex(overflow);         \
    c = _mm_sub_epi64(c,minus_one);                     \
    printf("        c=");print128hex(c);                \
    overflow = _mm_srli_si128(overflow,8);              \
    printf(" overflow=");print128hex(overflow);         \
    c = _mm_sub_epi64(c,overflow);                      \
    printf("        c=");print128hex(c);                \
    puts("*****************************");              \
  }


static void print64bin (const unsigned long n) {
  char* bytearray = (char*)&n;
#define print8bin(c) printf("%d%d%d%d%d%d%d%d ",c&0x80?1:0,c&0x40?1:0,c&0x20?1:0,\
                            c&0x10?1:0,c&0x08?1:0,c&0x04?1:0,c&0x02?1:0,c&0x01?1:0)
  for (int i = 0; i < 8; i++)
    print8bin(bytearray[i]);
}
static void print128bin (const __m128i v) {
  unsigned long out[2];
  _mm_store_si128 ((__m128i*)out, v);
  for (int i = 0; i <= 1; i++) {
    print64bin(out[i]);
  }
  puts("");
}

void print128hex(__m128i toPrint) {
  char * bytearray = (char *) &toPrint;
  for(int i = 0; i < 16; i++) printf("%02hhx", bytearray[i]);
  printf("\n");
}

int main() {
  unsigned char base_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
  
  __m128i counter128 = _mm_load_si128((__m128i*)base_counter);
  counter128 = _mm_shuffle_epi8(counter128,_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));

  unsigned long counter64[2] __attribute__ ((aligned (32)));
  memcpy(counter64, base_counter, 16);
  counter64[0] = __builtin_bswap64(counter64[0]);
  counter64[1] = __builtin_bswap64(counter64[1]);

  /* print128bin(counter128); */
  /* print128bin(*((__m128i*)counter64)); */
  print128hex(counter128);
  print128hex(*((__m128i*)counter64));

  load64();
  load128();

  print128hex(counter128);
  print128hex(*((__m128i*)counter64));
  
}
