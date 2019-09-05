#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "mixcol.c"

uint32_t TV[4][2] = {
  {0xCCCCCCC6, 0x753138bf},
  {0xCC6CCCCC, 0x9dd3d5a9},
  {0xCCCACCC6, 0x8db7bc26},
  {0x5CCCCCCC, 0xf44e6cbc} };


void test() {
  for (int i = 0; i < 4; i++) {
    uint32_t y;
    MixColumnSerial__(TV[i][0], &y);
    if (TV[i][1] != y) {
      printf("Bug!\n");
    } else {
      printf("OK\n");
    }
  }
  printf("houra!\n");
}

int main() {
  test();
}
