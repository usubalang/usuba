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
               __m128i *restrict out)  {
  out[0] = _mm_add_epi16(x1,y1);
  out[1] = _mm_add_epi16(x2,y2);
  out[2] = _mm_add_epi16(x3,y3);
  out[3] = _mm_add_epi16(x4,y4);
  out[4] = _mm_add_epi16(x5,y5);
  out[5] = _mm_add_epi16(x6,y6);
  out[6] = _mm_add_epi16(x7,y7);
  out[7] = _mm_add_epi16(x16,y16);
  out[8] = _mm_add_epi16(x9,y9);
  out[9] = _mm_add_epi16(x10,y10);
  out[10] = _mm_add_epi16(x11,y11);
  out[11] = _mm_add_epi16(x12,y12);
  out[12] = _mm_add_epi16(x13,y13);
  out[13] = _mm_add_epi16(x14,y14);
  out[14] = _mm_add_epi16(x15,y15);
  out[15] = _mm_add_epi16(x16,y16);
}


__m128i add(__m128i a, __m128i b, __m128i *restrict c) {
  __m128i tmp = _mm_xor_si128(a,b);
  __m128i res = _mm_xor_si128(tmp,*c);
  *c =_mm_xor_si128(_mm_and_si128(a,b),_mm_and_si128(*c,tmp));
  return res;
}

void add_bitslice (__m128i x1, __m128i x2, __m128i x3, __m128i x4,
                   __m128i x5, __m128i x6, __m128i x7, __m128i x8,
                   __m128i x9, __m128i x10, __m128i x11, __m128i x12,
                   __m128i x13, __m128i x14, __m128i x15, __m128i x16,
                   __m128i y1, __m128i y2, __m128i y3, __m128i y4,
                   __m128i y5, __m128i y6, __m128i y7, __m128i y8,
                   __m128i y9, __m128i y10, __m128i y11, __m128i y12,
                   __m128i y13, __m128i y14, __m128i y15, __m128i y16,
                   __m128i *restrict out) {
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

void add_lookahead (__m128i a0, __m128i a1, __m128i a2, __m128i a3,
                    __m128i a4, __m128i a5, __m128i a6, __m128i a7,
                    __m128i a8, __m128i a9, __m128i a10, __m128i a11,
                    __m128i a12, __m128i a13, __m128i a14, __m128i a15,
                    __m128i b0, __m128i b1, __m128i b2, __m128i b3,
                    __m128i b4, __m128i b5, __m128i b6, __m128i b7,
                    __m128i b8, __m128i b9, __m128i b10, __m128i b11,
                    __m128i b12, __m128i b13, __m128i b14, __m128i b15,
                    __m128i *restrict out) {
  __m128i p0 = a0 ^ b0;
  __m128i p1 = a1 ^ b1;
  __m128i p2 = a2 ^ b2;
  __m128i p3 = a3 ^ b3;
  __m128i p4 = a4 ^ b4;
  __m128i p5 = a5 ^ b5;
  __m128i p6 = a6 ^ b6;
  __m128i p7 = a7 ^ b7;
  __m128i p8 = a8 ^ b8;
  __m128i p9 = a9 ^ b9;
  __m128i p10 = a10 ^ b10;
  __m128i p11 = a11 ^ b11;
  __m128i p12 = a12 ^ b12;
  __m128i p13 = a13 ^ b13;
  __m128i p14 = a14 ^ b14;
  __m128i p15 = a15 ^ b15;

  __m128i g0 = a0 & b0;
  __m128i g1 = a1 & b1;
  __m128i g2 = a2 & b2;
  __m128i g3 = a3 & b3;
  __m128i g4 = a4 & b4;
  __m128i g5 = a5 & b5;
  __m128i g6 = a6 & b6;
  __m128i g7 = a7 & b7;
  __m128i g8 = a8 & b8;
  __m128i g9 = a9 & b9;
  __m128i g10 = a10 & b10;
  __m128i g11 = a11 & b11;
  __m128i g12 = a12 & b12;
  __m128i g13 = a13 & b13;
  __m128i g14 = a14 & b14;

  __m128i c0 = g0;
  __m128i c1 = g1 | p1&g0;
  __m128i c2 = g2 | p2&g1 | p2&p1&g0;
  __m128i c3 = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0;
  __m128i c4 = g4 | p4&g3 | p4&p3&g2 | p4&p3&p2&g1 | p4&p3&p2&p1&g0 ;
  __m128i c5 = g5 | p5&g4 | p5&p4&g3 | p5&p4&p3&g2 | p5&p4&p3&p2&g1 | p5&p4&p3&p2&p1&g0;
  __m128i c6 = g6 | p6&g5 | p6&p5&g4 | p6&p5&p4&g3 | p6&p5&p4&p3&g2 | p6&p5&p4&p3&p2&g1 | p6&p5&p4&p3&p2&p1&g0;
  __m128i c7 = g7 | p7&g6 | p7&p6&g5 | p7&p6&p5&g4 | p7&p6&p5&p4&g3 | p7&p6&p5&p4&p3&g2 | p7&p6&p5&p4&p3&p2&g1 | p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c8 = g8 | p8&g7 | p8&p7&g6 | p8&p7&p6&g5 | p8&p7&p6&p5&g4 | p8&p7&p6&p5&p4&g3 | p8&p7&p6&p5&p4&p3&g2 | p8&p7&p6&p5&p4&p3&p2&g1 | p8&p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c9 = g9 | p9&g8 | p9&p8&g7 | p9&p8&p7&g6 | p9&p8&p7&p6&g5 | p9&p8&p7&p6&p5&g4 | p9&p8&p7&p6&p5&p4&g3 | p9&p8&p7&p6&p5&p4&p3&g2 | p9&p8&p7&p6&p5&p4&p3&p2&g1 | p9&p8&p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c10 = g10 | p10&g9 | p10&p9&g8 | p10&p9&p8&g7 | p10&p9&p8&p7&g6 | p10&p9&p8&p7&p6&g5 | p10&p9&p8&p7&p6&p5&g4 | p10&p9&p8&p7&p6&p5&p4&g3 | p10&p9&p8&p7&p6&p5&p4&p3&g2 | p10&p9&p8&p7&p6&p5&p4&p3&p2&g1 | p10&p9&p8&p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c11 = g11 | p11&g10 | p11&p10&g9 | p11&p10&p9&g8 | p11&p10&p9&p8&g7 | p11&p10&p9&p8&p7&g6 | p11&p10&p9&p8&p7&p6&g5 | p11&p10&p9&p8&p7&p6&p5&g4 | p11&p10&p9&p8&p7&p6&p5&p4&g3 | p11&p10&p9&p8&p7&p6&p5&p4&p3&g2 | p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&g1 | p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c12 = g12 | p12&g11 | p12&p11&g10 | p12&p11&p10&g9 | p12&p11&p10&p9&g8 | p12&p11&p10&p9&p8&g7 |p12& p11&p10&p9&p8&p7&g6 | p12&p11&p10&p9&p8&p7&p6&g5 | p12&p11&p10&p9&p8&p7&p6&p5&g4 | p12&p11&p10&p9&p8&p7&p6&p5&p4&g3 | p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&g2 | p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&g1 | p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c13 = g13 | p13&g12 | p13&p12&g11 | p13&p12&p11&g10 | p13&p12&p11&p10&g9 | p13&p12&p11&p10&p9&g8 | p13&p12&p11&p10&p9&p8&g7 | p13&p12&p11&p10&p9&p8&p7&g6 | p13&p12&p11&p10&p9&p8&p7&p6&g5 | p13&p12&p11&p10&p9&p8&p7&p6&p5&g4 | p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&g3 | p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&g2 | p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&g1 | p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&p1&g0;
  __m128i c14 = g14 | p14&g13 | p14&p13&g12 | p14&p13&p12&g11 | p14&p13&p12&p11&g10 | p14&p13&p12&p11&p10&g9 | p14&p13&p12&p11&p10&p9&g8 | p14&p13&p12&p11&p10&p9&p8&g7 | p14&p13&p12&p11&p10&p9&p8&p7&g6 | p14&p13&p12&p11&p10&p9&p8&p7&p6&g5 | p14&p13&p12&p11&p10&p9&p8&p7&p6&p5&g4 | p14&p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&g3 | p14&p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&g2 | p14&p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&g1 | p14&p13&p12&p11&p10&p9&p8&p7&p6&p5&p4&p3&p2&p1&g0;
  
  out[0] = p0;
  out[1] = p1 ^ c0;
  out[2] = p2 ^ c1;
  out[3] = p3 ^ c2;
  out[4] = p4 ^ c3;
  out[5] = p5 ^ c4;
  out[6] = p6 ^ c5;
  out[7] = p7 ^ c6;
  out[8] = p8 ^ c7;
  out[9] = p9 ^ c8;
  out[10] = p10 ^ c9;
  out[11] = p11 ^ c10;
  out[12] = p12 ^ c11;
  out[13] = p13 ^ c12;
  out[14] = p14 ^ c13;
  out[15] = p15 ^ c14;
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
  
  printf("Lookahead... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_lookahead(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,
                  y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,
                  &(buffer[j*16]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*16,f);
  
  return 0;
}
