#include <sys/random.h>

void kernelrandombytes(unsigned char *x,unsigned long long xlen)
{
  int i;

  while (xlen > 0) {
    if (xlen < 256) i = xlen; else i = 256;
    getentropy(x,i);
    x += i;
    xlen -= i;
  }
}
