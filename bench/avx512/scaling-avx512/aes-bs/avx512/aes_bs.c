
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define RUNTIME
#define ORTHO
#include "AVX512.h"

#include "aes.c"

void aes_bs(DATATYPE plain[512], DATATYPE key[11][128], DATATYPE cipher[512]) {
  AES__(plain,key,cipher);
  AES__(&plain[128],key,&cipher[128]);
  AES__(&plain[256],key,&cipher[256]);
  AES__(&plain[384],key,&cipher[384]);
}
