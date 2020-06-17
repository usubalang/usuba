#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <math.h>
#include <unistd.h>

unsigned int expected;

void init_password(int length) {
  srand(time(NULL));
  // yeah yeah I know, `rand() % x` won't have a uniform distribution.
  expected = rand() % (int) pow(10,length);
  printf("Password initialized: %0*u\n", length, expected);
}

int check_password(unsigned int provided, int length) {
  unsigned int ref = expected;
  /* printf("check_password(%0*u) (== %0*u)\n",length,provided,length,expected); */
  while (length-- > 0) {
    if ((ref % 10) != (provided % 10)) {
      return 0;
    }
    ref      /= 10;
    provided /= 10;
    /* printf("  1st ok; moving on to %0*u vs %0*u\n",length,provided,length,ref); */
    /* usleep(10); */
  }
  return 1;
}

void print_password(int length) {
  printf("Password: %0*u\n", length, expected);
}
