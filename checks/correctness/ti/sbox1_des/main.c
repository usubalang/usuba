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

void f__ (/*inputs*/ DATATYPE a0__,DATATYPE a1__,DATATYPE a2__,DATATYPE a3__,DATATYPE a4__,DATATYPE a5__, /*outputs*/ DATATYPE* out0__,DATATYPE* out1__,DATATYPE* out2__,DATATYPE* out3__);

unsigned long table[] = {
    14, 0, 4, 15, 13, 7, 1, 4, 2, 14, 15, 2, 11, 13, 8, 1,
    3, 10, 10, 6, 6, 12, 12, 11, 5, 9, 9, 5, 0, 3, 7, 8,
    4, 15, 1, 12, 14, 8, 8, 2, 13, 4, 6, 9, 2, 1, 11, 7,
    15, 5, 12, 11, 9, 3, 7, 14, 3, 10, 10, 0, 5, 6, 0, 13
};


#define FOR(x) for (DATATYPE x = 0; x < 8; x++)
#define LIST4(x) x##0, x##1, x##2, x##3
#define LIST6(x) LIST4(x), x##4, x##5
#define BITS_TO_INT4(c,d,e,f) ((f&1) | ((e&1) << 1) | ((d&1) << 2) | ((c&1) << 3))
#define BITS_TO_INT6(a,b,c,d,e,f) (BITS_TO_INT4(c,d,e,f) | ((b&1) << 4) | ((a&1) << 5))

void verif() {
  FOR(a0) FOR(a1) FOR(a2) FOR(a3) FOR(a4) FOR(a5) {
    DATATYPE LIST4(b);
    f__(LIST6(a),LIST4(&b));

#define RED_DEF(X,x,i) DATATYPE X##i = REDUCE(x##i)
#define RED_A(i) RED_DEF(A,a,i)
    RED_A(0); RED_A(1); RED_A(2); RED_A(3); RED_A(4); RED_A(5);
#define RED_B(i) RED_DEF(B,b,i)
    RED_B(0); RED_B(1); RED_B(2); RED_B(3);

    
    DATATYPE in  = BITS_TO_INT6(A0,A1,A2,A3,A4,A5);
    DATATYPE out = BITS_TO_INT4(B0,B1,B2,B3);
    assert(table[in] == out);
  }
}


#define NB_LOOP (1000 * 1000 * 10)
void speed() {
  DATATYPE a0 = rand(), a1 = rand(), a2 = rand(), a3 = rand(), a4 = rand(), a5 = rand();
  DATATYPE LIST4(b);

  /* Warming up caches */
  for (int i = 0; i < 100000; i++)
    f__(LIST6(a),LIST4(&b));


  uint64_t timer = _rdtsc();
  for (unsigned long i = 0; i < NB_LOOP; i++)
    f__(LIST6(a),LIST4(&b));
  timer = _rdtsc() - timer;

  printf("original: %lu cycles/run\n",timer/NB_LOOP);
}


    
int main() {

  verif();

  speed();
}
