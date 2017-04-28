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
                   __m128i x17, __m128i x18, __m128i x19, __m128i x20,
                   __m128i x21, __m128i x22, __m128i x23, __m128i x24,
                   __m128i x25, __m128i x26, __m128i x27, __m128i x28,
                   __m128i x29, __m128i x30, __m128i x31, __m128i x32,
                   __m128i y1, __m128i y2, __m128i y3, __m128i y4,
                   __m128i y5, __m128i y6, __m128i y7, __m128i y8,
                   __m128i y9, __m128i y10, __m128i y11, __m128i y12,
                   __m128i y13, __m128i y14, __m128i y15, __m128i y16,
                   __m128i y17, __m128i y18, __m128i y19, __m128i y20,
                   __m128i y21, __m128i y22, __m128i y23, __m128i y24,
                   __m128i y25, __m128i y26, __m128i y27, __m128i y28,
                   __m128i y29, __m128i y30, __m128i y31, __m128i y32,
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
  out[16] = _mm_add_epi8(x17,y17);
  out[17] = _mm_add_epi8(x18,y18);
  out[18] = _mm_add_epi8(x19,y19);
  out[19] = _mm_add_epi8(x20,y20);
  out[20] = _mm_add_epi8(x21,y21);
  out[21] = _mm_add_epi8(x22,y22);
  out[22] = _mm_add_epi8(x23,y23);
  out[23] = _mm_add_epi8(x24,y24);
  out[24] = _mm_add_epi8(x25,y25);
  out[25] = _mm_add_epi8(x26,y26);
  out[26] = _mm_add_epi8(x27,y27);
  out[27] = _mm_add_epi8(x28,y28);
  out[28] = _mm_add_epi8(x29,y29);
  out[29] = _mm_add_epi8(x30,y30);
  out[30] = _mm_add_epi8(x31,y31);
  out[31] = _mm_add_epi8(x32,y32);
}

void add_pack_arr (__m128i x[32], __m128i y[32], __m128i *restrict out) {
  for (int i = 0; i < 32; i++) {
    out[i] = _mm_add_epi8(x[i],y[i]);
  }
}


__m128i add(__m128i a, __m128i b, __m128i* c) {
  __m128i tmp = a ^ b;
  __m128i res = tmp ^ *c;
  *c = a&b ^ *c&tmp;
  return res;
}

void add_bitslice (__m128i x1, __m128i x2, __m128i x3, __m128i x4,
                   __m128i x5, __m128i x6, __m128i x7, __m128i x8,
                   __m128i x9, __m128i x10, __m128i x11, __m128i x12,
                   __m128i x13, __m128i x14, __m128i x15, __m128i x16,
                   __m128i x17, __m128i x18, __m128i x19, __m128i x20,
                   __m128i x21, __m128i x22, __m128i x23, __m128i x24,
                   __m128i x25, __m128i x26, __m128i x27, __m128i x28,
                   __m128i x29, __m128i x30, __m128i x31, __m128i x32,
                   __m128i y1, __m128i y2, __m128i y3, __m128i y4,
                   __m128i y5, __m128i y6, __m128i y7, __m128i y8,
                   __m128i y9, __m128i y10, __m128i y11, __m128i y12,
                   __m128i y13, __m128i y14, __m128i y15, __m128i y16,
                   __m128i y17, __m128i y18, __m128i y19, __m128i y20,
                   __m128i y21, __m128i y22, __m128i y23, __m128i y24,
                   __m128i y25, __m128i y26, __m128i y27, __m128i y28,
                   __m128i y29, __m128i y30, __m128i y31, __m128i y32,
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
  out[16] = add(x17,y17,&c);
  out[17] = add(x18,y18,&c);
  out[18] = add(x19,y19,&c);
  out[19] = add(x20,y20,&c);
  out[20] = add(x21,y21,&c);
  out[21] = add(x22,y22,&c);
  out[22] = add(x23,y23,&c);
  out[23] = add(x24,y24,&c);
  out[24] = add(x25,y25,&c);
  out[25] = add(x26,y26,&c);
  out[26] = add(x27,y27,&c);
  out[27] = add(x28,y28,&c);
  out[28] = add(x29,y29,&c);
  out[29] = add(x30,y30,&c);
  out[30] = add(x31,y31,&c);
  out[31] = add(x32,y32,&c);
}

void add_bitslice_arr (__m128i x[32], __m128i y[32], __m128i *restrict out) {
  __m128i c = _mm_setzero_si128();
  for (int i = 0; i < 32; i++) {
    out[i] = add(x[i],y[i],&c);
  }
}

int main () {
  
  uint64_t begin, end;
  FILE* f = fopen("/dev/null","w");

  __m128i x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
    x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,
    y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
    y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32;

  __m128i x[32],y[32];

  int size = 1e6;
  srand(time(NULL));
  __m128i *restrict buffer = aligned_alloc(32,size * 32 * sizeof *buffer);

  for (int i = 0; i < 32; i++) {
    x[i] = _mm_set_epi32(rand(),rand(),rand(),rand());
    y[i] = _mm_set_epi32(rand(),rand(),rand(),rand());
  }
  
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
  x17 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x18 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x19 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x20 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x21 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x22 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x23 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x24 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x25 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x26 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x27 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x28 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x29 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x30 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x31 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x32 = _mm_set_epi32(rand(),rand(),rand(),rand());

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
  y17 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y18 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y19 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y20 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y21 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y22 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y23 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y24 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y25 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y26 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y27 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y28 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y29 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y30 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y31 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y32 = _mm_set_epi32(rand(),rand(),rand(),rand());

  for (int i = 0; i < size*32; i++) {
    __m128i tmp;
    buffer[i] = add(x1,x2,&tmp);
  }
  fwrite(buffer,sizeof *buffer,size*32,f);
  
  
  printf("Packed...... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_pack(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
             x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,
             y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
             y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32,
             &(buffer[j*32]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*32,f);
  
  printf("Bitsliced... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                 x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,
                 y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
                 y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32,
                 &(buffer[j*32]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*32,f);
  
  printf("Pack_ar..... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_pack_arr(x,y,&(buffer[j*32]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*32,f);
  
  printf("Bitsli_ar... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_bitslice_arr(x,y,&(buffer[j*32]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*32,f);
  
  return 0;
}
