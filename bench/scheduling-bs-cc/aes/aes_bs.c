
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define RUNTIME
#define ORTHO
#include "SSE.h"

void AES__ (/*inputs*/ DATATYPE plain__[128],DATATYPE key__[11][128], /*outputs*/ DATATYPE cipher__[128]);

void aes_bs(DATATYPE plain[128],DATATYPE key[11][128], DATATYPE cipher[128]) {
  for (int i = 0; i < 128; i++)
    plain[i] = _mm_shuffle_epi8(plain[i],_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
  
  real_ortho_128x128(plain);
  
  AES__(plain,key,cipher);

  real_ortho_128x128(cipher);
  
  for (int i = 0; i < 128; i++)
    cipher[i] = _mm_shuffle_epi8(cipher[i],_mm_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
}
