
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
  AES__(plain,key,cipher);
  AES__(&plain[128],key,&cipher[128]);
}
