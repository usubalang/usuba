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
              __m128i y1, __m128i y2, __m128i y3, __m128i y4,
              __m128i y5, __m128i y6, __m128i y7, __m128i y8,
              __m128i* out)  {
  out[0] = _mm_add_epi8(x1,y1);
  out[1] = _mm_add_epi8(x2,y2);
  out[2] = _mm_add_epi8(x3,y3);
  out[3] = _mm_add_epi8(x4,y4);
  out[4] = _mm_add_epi8(x5,y5);
  out[5] = _mm_add_epi8(x6,y6);
  out[6] = _mm_add_epi8(x7,y7);
  out[7] = _mm_add_epi8(x8,y8);
}


__m128i add(__m128i a, __m128i b, __m128i* c) {
  __m128i tmp = a ^ b;
  __m128i res = tmp ^ *c;
  *c = a&b ^ *c&tmp;
  return res;
}

void add_bitslice (__m128i x1, __m128i x2, __m128i x3, __m128i x4,
                   __m128i x5, __m128i x6, __m128i x7, __m128i x8,
                   __m128i y1, __m128i y2, __m128i y3, __m128i y4,
                   __m128i y5, __m128i y6, __m128i y7, __m128i y8,
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
}

void add_lookahead (__m128i a0, __m128i a1, __m128i a2, __m128i a3,
                    __m128i a4, __m128i a5, __m128i a6, __m128i a7,
                    __m128i b0, __m128i b1, __m128i b2, __m128i b3,
                    __m128i b4, __m128i b5, __m128i b6, __m128i b7,
                    __m128i* out) {
  __m128i p0 = a0 ^ b0;
  __m128i p1 = a1 ^ b1;
  __m128i p2 = a2 ^ b2;
  __m128i p3 = a3 ^ b3;
  __m128i p4 = a4 ^ b4;
  __m128i p5 = a5 ^ b5;
  __m128i p6 = a6 ^ b6;
  __m128i p7 = a7 ^ b7;

  __m128i g0 = a0 & b0;
  __m128i g1 = a1 & b1;
  __m128i g2 = a2 & b2;
  __m128i g3 = a3 & b3;
  __m128i g4 = a4 & b4;
  __m128i g5 = a5 & b5;
  __m128i g6 = a6 & b6;

  __m128i c0 = g0;
  __m128i c1 = g1 | p1&g0;
  __m128i c2 = g2 | p2&g1 | p2&p1&g0;
  __m128i c3 = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0;
  __m128i c4 = g4 | p4&g3 | p4&p3&g2 | p4&p3&p2&g1 | p4&p3&p2&p1&g0 ;
  __m128i c5 = g5 | p5&g4 | p5&p4&g3 | p5&p4&p3&g2 | p5&p4&p3&p2&g1 | p5&p4&p3&p2&p1&g0;
  __m128i c6 = g6 | p6&g5 | p6&p5&g4 | p6&p5&p4&g3 | p6&p5&p4&p3&g2 | p6&p5&p4&p3&p2&g1 | p6&p5&p4&p3&p2&p1&g0;
  
  out[0] = p0;
  out[1] = p1 ^ c0;
  out[2] = p2 ^ c1;
  out[3] = p3 ^ c2;
  out[4] = p4 ^ c3;
  out[5] = p5 ^ c4;
  out[6] = p6 ^ c5;
  out[7] = p7 ^ c6;
}


void add_lookahead_reschedul (__m128i a0, __m128i a1, __m128i a2, __m128i a3,
                    __m128i a4, __m128i a5, __m128i a6, __m128i a7,
                    __m128i b0, __m128i b1, __m128i b2, __m128i b3,
                    __m128i b4, __m128i b5, __m128i b6, __m128i b7,
                    __m128i* out) {
  __m128i p0 = a0 ^ b0;
  out[0] = p0;
  

  __m128i g0 = a0 & b0;
  __m128i p1 = a1 ^ b1;
  __m128i c0 = g0;
  out[1] = p1 ^ c0;
  
  __m128i g1 = a1 & b1;
  __m128i c1 = g1 | p1&g0;
  __m128i p2 = a2 ^ b2;
  out[2] = p2 ^ c1;
  
  __m128i g2 = a2 & b2;
  __m128i c2 = g2 | p2&g1 | p2&p1&g0;
  __m128i p3 = a3 ^ b3;
  out[3] = p3 ^ c2;
  
  __m128i g3 = a3 & b3;
  __m128i c3 = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0;
  __m128i p4 = a4 ^ b4;
  out[4] = p4 ^ c3;
  
  __m128i g4 = a4 & b4;
  __m128i c4 = g4 | p4&g3 | p4&p3&g2 | p4&p3&p2&g1 | p4&p3&p2&p1&g0 ;
  __m128i p5 = a5 ^ b5;
  out[5] = p5 ^ c4;
  
  __m128i g5 = a5 & b5;
  __m128i c5 = g5 | p5&g4 | p5&p4&g3 | p5&p4&p3&g2 | p5&p4&p3&p2&g1 | p5&p4&p3&p2&p1&g0;
  __m128i p6 = a6 ^ b6;
  out[6] = p6 ^ c5;
  
  __m128i g6 = a6 & b6;
  __m128i p7 = a7 ^ b7;
  __m128i c6 = g6 | p6&g5 | p6&p5&g4 | p6&p5&p4&g3 | p6&p5&p4&p3&g2 | p6&p5&p4&p3&p2&g1 | p6&p5&p4&p3&p2&p1&g0;
  out[7] = p7 ^ c6;
}

void lookahead_sound() {

  __m128i x1, x2, x3, x4, x5, x6, x7, x8;
  __m128i y1, y2, y3, y4, y5, y6, y7, y8;
  
  x1 = _mm_set_epi8(170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170);
  x2 = _mm_set_epi8(204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204);
  x3 = _mm_set_epi8(227,142,56,227,142,56,227,142,56,227,142,56,227,142,56,227);
  x4 = _mm_set_epi8(240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240);
  x5 = _mm_set_epi8(248,62,15,131,224,248,62,15,131,224,248,62,15,131,224,248);
  x6 = _mm_set_epi8(252,15,192,252,15,192,252,15,192,252,15,192,252,15,192,252);
  x7 = _mm_set_epi8(254,3,248,15,224,63,128,254,3,248,15,224,63,128,254,3);
  x8 = _mm_set_epi8(255,0,255,0,255,0,255,0,255,0,255,0,255,0,255,0);

  y1 = _mm_set_epi8(170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170);
  y2 = _mm_set_epi8(204,204,204,204,204,204,204,204,204,204,204,204,204,204,204,204);
  y3 = _mm_set_epi8(227,142,56,227,142,56,227,142,56,227,142,56,227,142,56,227);
  y4 = _mm_set_epi8(240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240);
  y5 = _mm_set_epi8(248,62,15,131,224,248,62,15,131,224,248,62,15,131,224,248);
  y6 = _mm_set_epi8(252,15,192,252,15,192,252,15,192,252,15,192,252,15,192,252);
  y7 = _mm_set_epi8(254,3,248,15,224,63,128,254,3,248,15,224,63,128,254,3);
  y8 = _mm_set_epi8(255,0,255,0,255,0,255,0,255,0,255,0,255,0,255,0);

  __m128i buf1[8], buf2[8];
  add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buf1);
  add_lookahead(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,buf2);
  for (int i = 0; i < 8; i++)
    if (_mm_test_all_zeros(_mm_cmpeq_epi64(buf1[i],buf2[i]),
                           _mm_cmpeq_epi64(buf1[i],buf1[i]))) {
      printf("Unsound.");
      exit(EXIT_FAILURE);
    }
}

int main () {
  //lookahead_sound();
  
  uint64_t begin, end;
  FILE* f = fopen("/dev/null","w");

  __m128i x1, x2, x3, x4, x5, x6, x7, x8;
  __m128i y1, y2, y3, y4, y5, y6, y7, y8;

  int size = 1e6;
  srand(time(NULL));
  __m128i *restrict buffer = aligned_alloc(32,size * 8 * sizeof *buffer);

  x1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x7 = _mm_set_epi32(rand(),rand(),rand(),rand());
  x8 = _mm_set_epi32(rand(),rand(),rand(),rand());

  y1 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y2 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y3 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y4 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y5 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y6 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y7 = _mm_set_epi32(rand(),rand(),rand(),rand());
  y8 = _mm_set_epi32(rand(),rand(),rand(),rand());

  for (int j = 0; j < size; j++)
    add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,&(buffer[j*8]));
  fwrite(buffer,sizeof *buffer,size*8,f);
  
  printf("Bitsliced... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_bitslice(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,&(buffer[j*8]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*8,f);
  
  for (int j = 0; j < size; j++)
    add_lookahead(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,&(buffer[j*8]));
  fwrite(buffer,sizeof *buffer,size*8,f);
  
  printf("Lookahead... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_lookahead(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,&(buffer[j*8]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*8,f);
  
  for (int j = 0; j < size; j++)
    add_pack(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,&(buffer[j*8]));
  fwrite(buffer,sizeof *buffer,size*8,f);
  
  printf("Packed...... ");fflush(stdout);
  begin = _rdtsc();
  for (int j = 0; j < size; j++)
    add_pack(x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8,&(buffer[j*8]));
  end = _rdtsc();
  printf("%lu\n",end-begin);
  fwrite(buffer,sizeof *buffer,size*8,f);
  
  return 0;
}
