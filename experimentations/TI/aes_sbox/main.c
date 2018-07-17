#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "STD.h"

#if TI == 2
#define REDUCE(x) ((x >> 1) & 1) ^ (x & 1)
#elif TI == 3
#define REDUCE(x) ((x >> 2) & 1) ^ ((x >> 1) & 1) ^ (x & 1)
#elif TI == 4
#define REDUCE(x) ((x >> 3) & 1) ^ ((x >> 2) & 1) ^ ((x >> 1) & 1) ^ (x & 1)
#elif TI == 8
#define REDUCE(x) ((x >> 7) & 1) ^ ((x >> 6) & 1) ^ ((x >> 5) & 1) ^ ((x >> 4) & 1) \
  ^ ((x >> 3) & 1) ^ ((x >> 2) & 1) ^ ((x >> 1) & 1) ^ (x & 1)
#else
#error "Invalid TI value:"
#endif

#define assert(e) if (!(e)) {                          \
    fprintf(stderr,"Assert failed line %d.\n",__LINE__);    \
    exit(EXIT_FAILURE);                                     \
  }

void f__ (/*inputs*/ DATATYPE U0,DATATYPE U1,DATATYPE U2,DATATYPE U3,DATATYPE U4,DATATYPE U5,DATATYPE U6,DATATYPE U7, /*outputs*/ DATATYPE* S0,DATATYPE* S1,DATATYPE* S2,DATATYPE* S3,DATATYPE* S4,DATATYPE* S5,DATATYPE* S6,DATATYPE* S7);

unsigned long table[] = {
    99, 124, 119, 123, 242, 107, 111, 197, 48, 1, 103, 43, 254, 215, 171, 118,
    202, 130, 201, 125, 250, 89, 71, 240, 173, 212, 162, 175, 156, 164, 114, 192,
    183, 253, 147, 38, 54, 63, 247, 204, 52, 165, 229, 241, 113, 216, 49, 21,
    4, 199, 35, 195, 24, 150, 5, 154, 7, 18, 128, 226, 235, 39, 178, 117,
    9, 131, 44, 26, 27, 110, 90, 160, 82, 59, 214, 179, 41, 227, 47, 132,
    83, 209, 0, 237, 32, 252, 177, 91, 106, 203, 190, 57, 74, 76, 88, 207,
    208, 239, 170, 251, 67, 77, 51, 133, 69, 249, 2, 127, 80, 60, 159, 168,
    81, 163, 64, 143, 146, 157, 56, 245, 188, 182, 218, 33, 16, 255, 243, 210,
    205, 12, 19, 236, 95, 151, 68, 23, 196, 167, 126, 61, 100, 93, 25, 115,
    96, 129, 79, 220, 34, 42, 144, 136, 70, 238, 184, 20, 222, 94, 11, 219,
    224, 50, 58, 10, 73, 6, 36, 92, 194, 211, 172, 98, 145, 149, 228, 121,
    231, 200, 55, 109, 141, 213, 78, 169, 108, 86, 244, 234, 101, 122, 174, 8,
    186, 120, 37, 46, 28, 166, 180, 198, 232, 221, 116, 31, 75, 189, 139, 138,
    112, 62, 181, 102, 72, 3, 246, 14, 97, 53, 87, 185, 134, 193, 29, 158,
    225, 248, 152, 17, 105, 217, 142, 148, 155, 30, 135, 233, 206, 85, 40, 223,
    140, 161, 137, 13, 191, 230, 66, 104, 65, 153, 45, 15, 176, 84, 187, 22
};



#define FOR(x) for (DATATYPE x = 0; x < 8; x++)
#define LIST8(x) x##0, x##1, x##2, x##3, x##4, x##5, x##6, x##7
#define BITS_TO_INT8(a,b,c,d,e,f,g,h) ((h&1) | ((g&1)<<1) | ((f&1)<<2) | ((e&1)<<3) \
                                       | ((d&1)<<4) | ((c&1)<<5) | ((b&1)<<6) | ((a&1)<<7))
#define LIST8(x) x##0, x##1, x##2, x##3, x##4, x##5, x##6, x##7

void verif() {
  FOR(a0) FOR(a1) FOR(a2) FOR(a3) FOR(a4) FOR(a5) FOR(a6) FOR(a7) {
    DATATYPE LIST8(b);
    f__(LIST8(a),LIST8(&b));
    
#define RED_DEF(X,x,i) DATATYPE X##i = REDUCE(x##i)
#define RED_A(i) RED_DEF(A,a,i)
    RED_A(0); RED_A(1); RED_A(2); RED_A(3); RED_A(4); RED_A(5); RED_A(6); RED_A(7);
#define RED_B(i) RED_DEF(B,b,i)
    RED_B(0); RED_B(1); RED_B(2); RED_B(3); RED_B(4); RED_B(5); RED_B(6); RED_B(7);
    
    DATATYPE in  = BITS_TO_INT8(A0,A1,A2,A3,A4,A5,A6,A7);
    DATATYPE out = BITS_TO_INT8(B0,B1,B2,B3,B4,B5,B6,B7);
    assert(table[in] == out);
  }
}

#define NB_LOOP (1000 * 1000 * 1)
void speed() {
  DATATYPE a0 = rand(), a1 = rand(), a2 = rand(), a3 = rand(),
    a4 = rand(), a5 = rand(), a6 = rand(), a7 = rand();
  DATATYPE LIST8(b);

  /* Warming up caches */
  for (int i = 0; i < 100000; i++)
    f__(LIST8(a),LIST8(&b));


  uint64_t timer = _rdtsc();
  for (unsigned long i = 0; i < NB_LOOP; i++)
    f__(LIST8(a),LIST8(&b));
  timer = _rdtsc() - timer;

  printf("original: %lu cycles/run\n",timer/NB_LOOP);
}



    
int main() {

  verif();

  speed();
}
