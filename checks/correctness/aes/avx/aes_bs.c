
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define RUNTIME
#define ORTHO
#include "AVX.h"

#include "aes.c"

void aes_bs(DATATYPE plain[256], DATATYPE key[11][128], DATATYPE cipher[256]) {
  for (int i = 0; i < 256; i++)
    plain[i] = _mm256_shuffle_epi8(plain[i],
                                   _mm256_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7,
                                                   8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
  
  
  real_ortho_256x256(plain);
  
  AES__(plain,key,cipher);
  AES__(&plain[128],key,&cipher[128]);

  real_ortho_256x256(cipher);
  for (int i = 0; i < 256; i++)
    cipher[i] = _mm256_shuffle_epi8(cipher[i],
                                    _mm256_set_epi8(8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7,
                                                    8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7));
}
