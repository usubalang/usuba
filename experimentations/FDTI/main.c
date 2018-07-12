#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

/* Do NOT change the order of those define/include */
#define NO_RUNTIME
#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif
/* including the architecture specific .h */
#include "STD.h"

void adder__ (DATATYPE a__,DATATYPE b__,DATATYPE _fd_a__,DATATYPE _fd_b__,
              DATATYPE *s__,DATATYPE *c__,DATATYPE *_fd_s__,DATATYPE *_fd_c__);


#define assert(e) if (!(e)) fprintf(stderr,"Assert failed line %d.\n",__LINE__)
#define assertFatal(e) if (!(e)) {                          \
    fprintf(stderr,"Assert failed line %d.\n",__LINE__);    \
    exit(EXIT_FAILURE);                                     \
  }



void checkCorrectness() {

  for (DATATYPE a = 0; a <= 5; a++)
    for (DATATYPE b = 0; b <= 5; b++) {

      DATATYPE a2 = ~a;
      DATATYPE b2 = ~b;

      DATATYPE s = 0, s2 = 0, c = 0, c2 = 0;

      DATATYPE A = ((a >> 2) & 1) ^ ((a >> 1) & 1) ^ (a & 1);
      DATATYPE B = ((b >> 2) & 1) ^ ((b >> 1) & 1) ^ (b & 1);

      /* Check TI / FD adders */
      adder__(a,a2,b,b2,&s,&s2,&c,&c2);

      DATATYPE S = ((s >> 2) & 1) ^ ((s >> 1) & 1) ^ (s & 1);
      DATATYPE C = ((c >> 2) & 1) ^ ((c >> 1) & 1) ^ (c & 1);
      
      /* Check correct result */
      assertFatal((S == (A^B))  && (C == (A&B)));


      DATATYPE S2 = ((s2 >> 2) & 1) ^ ((s2 >> 1) & 1) ^ (s2 & 1);
      DATATYPE C2 = ((c2 >> 2) & 1) ^ ((c2 >> 1) & 1) ^ (c2 & 1);

      
      assertFatal((S != S2) && (C != C2));

      assertFatal( (((s >> 2) & 1) != ((s2 >> 2) & 1)) &&
                   (((s >> 1) & 1) != ((s2 >> 1) & 1)) &&
                   (((s >> 0) & 1) != ((s2 >> 0) & 1)) );
      // This test won't pass on fdti unless manually modified
      assertFatal( (((c >> 2) & 1) != ((c2 >> 2) & 1)) &&
                   (((c >> 1) & 1) != ((c2 >> 1) & 1)) &&
                   (((c >> 0) & 1) != ((c2 >> 0) & 1)) );
    
  }

  printf("Program correct.\n");
}


int main() {
  checkCorrectness();
}
