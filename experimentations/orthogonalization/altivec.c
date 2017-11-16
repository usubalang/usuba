/* gcc -O3 -march=native -maltivec -mabi=altivec -o altivec altivec.c */


#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
//#include <malloc.h>

#include "AltiVec.h"

void print32bin (const unsigned int n) {
  for (int i = 0; i < 32; i++)
    printf("%u",(n>>i) & 1);
}  

void print64bin (const uint64_t n) {
  for (int i = 0; i < 64; i++) {
    printf("%llu",(n>>i) & 1);
  }  
}


void print128bin (const DATATYPE v) {
  DATATYPE out;
  vec_st(v,0,&out);
  uint64_t* tmp = (uint64_t*)&out;
  for (int i = 1; i >= 0; i--) {
    print64bin(tmp[i]);
  }
  puts("");
}

void check_ortho () {
  
  //DATATYPE* buffer = ALLOC(128);
  DATATYPE buffer[128];

  for (unsigned int i = 0, a = -1; i < 32; i++) {
    buffer[i] = (DATATYPE){ -1UL, -1UL, -1UL, a };
    a <<= 1;
  }
  for (unsigned int i = 0, a = -1; i < 32; i++) {
    buffer[i+32] = (DATATYPE){ -1UL, -1UL, a, 0UL };
    a <<= 1;
  }
  for (unsigned int i = 0, a = -1; i < 32; i++) {
    buffer[i+64] = (DATATYPE){ -1UL, a, 0UL, 0UL };
    a <<= 1;
  }
  for (unsigned int i = 0, a = -1; i < 32; i++) {
    buffer[i+96] = (DATATYPE){ a, 0UL, 0UL, 0UL };
    a <<= 1;
  }

  for (int i = 0; i < 128; i++)
    print128bin(buffer[i]);

  real_ortho_128x128(buffer);

  printf("\n\n\n");
  for (int i = 0; i < 10; i++)
    puts("*******************************************************************************");
  printf("\n\n\n");
  
  for (int i = 0; i < 128; i++)
    print128bin(buffer[i]); 

}


int main() {

  check_ortho();

  /*

  //unsigned int tmp[4] = { -1UL, -1UL, 0UL, 0UL };
  //unsigned int tmp[4];
  //unsigned int* tmp = memalign(16,4*sizeof(unsigned int));
  DATATYPE init;
  unsigned int* tmp = (unsigned int*)&init;
  //posix_memalign(&tmp,4*sizeof(int),16);
  tmp[0] = -1UL; tmp[1] = -1UL; tmp[2] = 0; tmp[3] = -1UL;

  for (int i = 3; i >= 0; i--) print32bin(tmp[i]); puts("");

  DATATYPE v = vec_ld(0,(DATATYPE*)tmp);
  //  DATATYPE v = { -1UL, -1UL, 0UL, 0UL };

  for (int i = 3; i >= 0; i--) print32bin(tmp[i]); puts("");
  print128bin(v);
  for (int i = 3; i >= 0; i--) print32bin(tmp[i]); puts("");
  
  */
  

  return 0;
  
}
