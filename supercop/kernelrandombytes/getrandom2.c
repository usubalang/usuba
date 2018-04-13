#include <unistd.h>
#include <linux/random.h>

void kernelrandombytes(unsigned char *x,unsigned long long xlen)
{
  int i;

  while (xlen > 0) {
    if (xlen < 1048576) i = xlen; else i = 1048576;

    i = getrandom(x,i,0);
    if (i < 1) {
      sleep(1);
      continue;
    }

    x += i;
    xlen -= i;
  }
}
