
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define RUNTIME
#define ORTHO
#include "SSE.h"

#include "aes.c"

void aes_bs(DATATYPE plain[128],DATATYPE key[11][128], DATATYPE cipher[128]) {
  AES__(plain,key,cipher);
}
