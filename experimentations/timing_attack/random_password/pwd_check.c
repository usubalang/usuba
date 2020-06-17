#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define EXP_LENGTH 10

#define RAND_CHAR ((rand() % (127-32)) + 32)
//#define RAND_CHAR ((rand() % 26) + 97)

char expected[EXP_LENGTH];

void init_password() {
  srand(time(NULL));
  for (int i = 0; i < EXP_LENGTH; i++)
    expected[i] = RAND_CHAR;
  printf("Password initialized: %s\n", expected);
}

int check_password(char* provided, int length) {
  if (length != EXP_LENGTH) {
    return 0;
  }
  asm volatile("" : "+r" (length));
  for (int i = 0; i < length; i++) {
    if (provided[i] != expected[i]) {
      return 0;
    }
  }
  return 1;
}

void print_pwd() {
  printf("password: %s\n", expected);
}
