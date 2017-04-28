#include <emmintrin.h>
#include <smmintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include "x86intrin.h"
#include <inttypes.h>


void add_pack (__m128i x1, __m128i x2, __m128i x3, __m128i x4,
               __m128i x5, __m128i x6, __m128i x7, __m128i x8,
               __m128i x9, __m128i x10, __m128i x11, __m128i x12,
               __m128i x13, __m128i x14, __m128i x15, __m128i x16,
               __m128i y1, __m128i y2, __m128i y3, __m128i y4,
               __m128i y5, __m128i y6, __m128i y7, __m128i y8,
               __m128i y9, __m128i y10, __m128i y11, __m128i y12,
               __m128i y13, __m128i y14, __m128i y15, __m128i y16,
               __m128i* out)  {
  out[0] = _mm_add_epi8(x1,y1);
  out[1] = _mm_add_epi8(x2,y2);
  out[2] = _mm_add_epi8(x3,y3);
  out[3] = _mm_add_epi8(x4,y4);
  out[4] = _mm_add_epi8(x5,y5);
  out[5] = _mm_add_epi8(x6,y6);
  out[6] = _mm_add_epi8(x7,y7);
  out[7] = _mm_add_epi8(x8,y8);
  out[8] = _mm_add_epi8(x9,y9);
  out[9] = _mm_add_epi8(x10,y10);
  out[10] = _mm_add_epi8(x11,y11);
  out[11] = _mm_add_epi8(x12,y12);
  out[12] = _mm_add_epi8(x13,y13);
  out[13] = _mm_add_epi8(x14,y14);
  out[14] = _mm_add_epi8(x15,y15);
  out[15] = _mm_add_epi8(x16,y16);
}


__m128i add(__m128i a, __m128i b, __m128i* c) {
  __m128i res = _mm_xor_si128(a,b);
  return _mm_xor_si128(res,a);
}

void add_bitslice (__m128i x1, __m128i x2, __m128i x3, __m128i x4,
                   __m128i x5, __m128i x6, __m128i x7, __m128i x8,
                   __m128i x9, __m128i x10, __m128i x11, __m128i x12,
                   __m128i x13, __m128i x14, __m128i x15, __m128i x16,
                   __m128i y1, __m128i y2, __m128i y3, __m128i y4,
                   __m128i y5, __m128i y6, __m128i y7, __m128i y8,
                   __m128i y9, __m128i y10, __m128i y11, __m128i y12,
                   __m128i y13, __m128i y14, __m128i y15, __m128i y16,
                   __m128i* out) {
  __m128i c = _mm_setzero_si128();
  out[0] = add(x1,y1,&c);
  out[1] = add(x2,y2,&c);
  out[2] = add(x3,y3,&c);
  out[3] = add(x4,y4,&c);
  out[4] = add(x5,y5,&c);
  out[5] = add(x6,y6,&c);
  out[6] = add(x7,y7,&c);
  out[7] = add(x8,y8,&c); 
  out[8] = add(x9,y9,&c);
  out[9] = add(x10,y10,&c);
  out[10] = add(x11,y11,&c);
  out[11] = add(x12,y12,&c);
  out[12] = add(x13,y13,&c);
  out[13] = add(x14,y14,&c);
  out[14] = add(x15,y15,&c);
  out[15] = add(x16,y16,&c); 
}


int main () {
  
  uint64_t begin, end;
  FILE* f = fopen("/dev/null","w");

  __m128i x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
    y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16;

  int size = 1e6;
  srand(time(NULL));
  __m128i *restrict buffer = aligned_alloc(32,size * 16 * sizeof *buffer);

  x1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x7 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x8 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x9 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x10 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x11 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x12 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x13 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x14 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x15 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x16 = _mm_set_epi32(rand(),rand(),rand(),rand());

  y1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y7 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y8 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y9 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y10 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y11 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y12 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y13 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y14 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y15 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y16 = _mm_set_epi32(rand(),rand(),rand(),rand());

  for (int i = 0; i < size*16; i++) {
    __m128i tmp;
    buffer[i] = add(x1,x2,&tmp);
  }
  fwrite(buffer,sizeof *buffer,size*16,f);
  
  
  printf("Packed...... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_pack(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
             y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
             &(buffer[j*16]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*16,f);
  
  printf("Bitsliced... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                 y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
                 &(buffer[j*16]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*16,f);

  return 0;
}
