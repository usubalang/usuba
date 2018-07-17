#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <x86intrin.h>

#include "STD.h"

#define assert(e) if (!(e)) {                          \
    fprintf(stderr,"Assert failed line %d.\n",__LINE__);    \
    exit(EXIT_FAILURE);                                     \
  }


void f__ (/*inputs*/ DATATYPE a0__,DATATYPE a1__,DATATYPE a2__,DATATYPE a3__,DATATYPE a4__,DATATYPE a5__, /*outputs*/ DATATYPE* out0__,DATATYPE* out1__,DATATYPE* out2__,DATATYPE* out3__);
void _fd_f__ (/*inputs*/ DATATYPE a0__,DATATYPE _fd_a0__,DATATYPE a1__,DATATYPE _fd_a1__,DATATYPE a2__,DATATYPE _fd_a2__,DATATYPE a3__,DATATYPE _fd_a3__,DATATYPE a4__,DATATYPE _fd_a4__,DATATYPE a5__,DATATYPE _fd_a5__, /*outputs*/ DATATYPE* out0__,DATATYPE* _fd_out0__,DATATYPE* out1__,DATATYPE* _fd_out1__,DATATYPE* out2__,DATATYPE* _fd_out2__,DATATYPE* out3__,DATATYPE* _fd_out3__);

unsigned long table[] = {
    14, 0, 4, 15, 13, 7, 1, 4, 2, 14, 15, 2, 11, 13, 8, 1,
    3, 10, 10, 6, 6, 12, 12, 11, 5, 9, 9, 5, 0, 3, 7, 8,
    4, 15, 1, 12, 14, 8, 8, 2, 13, 4, 6, 9, 2, 1, 11, 7,
    15, 5, 12, 11, 9, 3, 7, 14, 3, 10, 10, 0, 5, 6, 0, 13
};


#define FOR(x) for (DATATYPE x = 0; x <= 1; x++)
#define BITS_TO_INT4(c,d,e,f) ((f&1) | ((e&1) << 1) | ((d&1) << 2) | ((c&1) << 3))
#define BITS_TO_INT6(a,b,c,d,e,f) (BITS_TO_INT4(c,d,e,f) | ((b&1) << 4) | ((a&1) << 5))
#define LIST4(x) x##0, x##1, x##2, x##3
#define LIST6(x) LIST4(x), x##4, x##5

void verif_std() {
  FOR(a0) FOR(a1) FOR(a2) FOR(a3) FOR(a4) FOR(a5) {
    DATATYPE LIST4(out);
    f__(LIST6(a),LIST4(&out));
    
    DATATYPE in  = BITS_TO_INT6(a0,a1,a2,a3,a4,a5);
    DATATYPE out = BITS_TO_INT4(out0,out1,out2,out3);
    assert(table[in] == out);
  }
}

void verif_fd() {

  FOR(a0) FOR(a1) FOR(a2) FOR(a3) FOR(a4) FOR(a5) {
    DATATYPE LIST4(out);
    DATATYPE LIST4(_fd_out);
    _fd_f__(a0,~a0,a1,~a1,a2,~a2,a3,~a3,a4,~a4,a5,~a5,
            &out0, &_fd_out0, &out1, &_fd_out1,
            &out2, &_fd_out2, &out3, &_fd_out3);
    DATATYPE in  = BITS_TO_INT6(a0,a1,a2,a3,a4,a5);
    DATATYPE out = BITS_TO_INT4(out0,out1,out2,out3);
    DATATYPE _fd_in  = BITS_TO_INT6(~a0,~a1,~a2,~a3,~a4,~a5);
    DATATYPE _fd_out = BITS_TO_INT4(_fd_out0,_fd_out1,_fd_out2,_fd_out3);

    assert((out0&1) == ((~_fd_out0)&1));
    assert((out1&1) == ((~_fd_out1)&1));
    assert((out2&1) == ((~_fd_out2)&1));
    assert((out3&1) == ((~_fd_out3)&1));
    
    assert(table[in] == out);
    assert(table[(~_fd_in)&0x3F] == ((~_fd_out) & 0xF));
  }
}

#define NB_LOOP (1000 * 1000 * 10)
void speed_std() {
  DATATYPE a0 = rand(), a1 = rand(), a2 = rand(), a3 = rand(), a4 = rand(), a5 = rand();
  DATATYPE LIST4(out);

  /* Warming up caches */
  for (int i = 0; i < 100000; i++)
    f__(LIST6(a),LIST4(&out));


  uint64_t timer = _rdtsc();
  for (unsigned long i = 0; i < NB_LOOP; i++)
    f__(LIST6(a),LIST4(&out));
  timer = _rdtsc() - timer;

  printf("original: %lu cycles/run\n",timer/NB_LOOP);
}

void speed_fd() {
  DATATYPE a0 = rand(), a1 = rand(), a2 = rand(), a3 = rand(), a4 = rand(), a5 = rand(),
    b0 = rand(), b1 = rand(), b2 = rand(), b3 = rand(), b4 = rand(), b5 = rand();
  DATATYPE LIST4(out), LIST4(out2);
    

  /* Warming up caches */
  for (int i = 0; i < 100000; i++)
    _fd_f__(LIST6(a),LIST6(b),LIST4(&out),LIST4(&out2));


  uint64_t timer = _rdtsc();
  for (unsigned long i = 0; i < NB_LOOP; i++)
    _fd_f__(LIST6(a),LIST6(b),LIST4(&out),LIST4(&out2));
  timer = _rdtsc() - timer;

  printf("protected: %lu cycles/run\n",timer/NB_LOOP);
}


    
int main() {

  verif_std();
  verif_fd();

  speed_std();
  speed_fd();
}
