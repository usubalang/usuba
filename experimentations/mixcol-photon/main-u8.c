#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define DATATYPE uint8_t

#include "mixcol-u8.c"

uint8_t TV[4][2][8] = {
  {{0XC,0XC,0XC,0XC,0XC,0XC,0XC,0x6}, {0x7,0x5,0x3,0x1,0x3,0x8,0xb,0xf}},
  {{0XC,0XC,0x6,0XC,0XC,0XC,0XC,0XC}, {0x9,0xd,0xd,0x3,0xd,0x5,0xa,0x9}},
  {{0XC,0XC,0XC,0XA,0XC,0XC,0XC,0x6}, {0x8,0xd,0xb,0x7,0xb,0xc,0x2,0x6}},
  {{0x5,0XC,0XC,0XC,0XC,0XC,0XC,0XC}, {0xf,0x4,0x4,0xe,0x6,0xc,0xb,0xc}} };


void test() {
  for (int i = 0; i < 4; i++) {
    uint8_t y[8];
    MixColumnSerial__(TV[i][0], y);
    for (int j = 0; j < 8; j++) y[j] &= 0xf;
    if (memcmp(TV[i][1],y,8) != 0) {
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
