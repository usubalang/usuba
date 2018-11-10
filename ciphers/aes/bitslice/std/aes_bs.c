
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define RUNTIME
#define ORTHO
#include "STD.h"

#include "aes.c"


void aes_bs(DATATYPE plain[128],DATATYPE key[11][128], DATATYPE cipher[128]) {
  for (int i = 0; i < 128; i++)
    plain[i] = __builtin_bswap64(plain[i]);
  
  orthogonalize(plain,plain);
  orthogonalize(&plain[64],&plain[64]);

  DATATYPE tmp[128];
  AES__(plain,key,tmp);
  
  orthogonalize(tmp,tmp);
  orthogonalize(&tmp[64],&tmp[64]);
  
  for (int i = 0; i < 128; i++)
    tmp[i] = __builtin_bswap64(tmp[i]);

  for (int i = 0; i < 64; i++) {
    cipher[i*2] = tmp[i];
    cipher[i*2+1] = tmp[i+64];
  }
}
