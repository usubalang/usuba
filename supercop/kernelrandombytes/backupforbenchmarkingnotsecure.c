#include <stdlib.h>

void kernelrandombytes(unsigned char *x,unsigned long long xlen)
{
  while (xlen > 0) {
    *x++ = random();
    --xlen;
  }
}
