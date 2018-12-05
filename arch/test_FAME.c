#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "FAME.h"

/* Checks that OP(v1,v2) == expected */
#define CHECK(OP,expected,v1,v2) {              \
    DATATYPE a = v1, b = v2, r;                 \
    OP(r,a,b);                                  \
    assert(r == expected);                      \
  }

/* Checks that OP(v1) == expected */
#define CHECK_UN(OP,expected,v1) {              \
    DATATYPE a = v1, r;                         \
    OP(r,a);                                    \
    assert(r == expected);                      \
  }

#define CHECK_RED(expect_rd,expect_y,i,v) {     \
    DATATYPE a = v, rd, y;                      \
    RED(rd,y,i,a);                              \
    assert(rd == expect_rd && y == expect_y);   \
  }

/* tests the basic (custom) instructions (TIBSROT, ANDC8, XORC16, etc.) */
void test_custom_instr() {

  // RED 0b010
  CHECK_RED(0x00000000,0xffffffff,0b010,0xffff0000);
  CHECK_RED(0xffffffff,0x00000000,0b010,0x0000ffff);
  CHECK_RED(0x00ff00ff,0xff00ff00,0b010,0xff0000ff);
  // RED 0b011
  CHECK_RED(0xffff0000,0x0000ffff,0b011,0xffff0000);
  CHECK_RED(0x0000ffff,0xffff0000,0b011,0x0000ffff);
  CHECK_RED(0xff0000ff,0x00ffff00,0b011,0xff0000ff);
  // RED 0b100
  CHECK_RED(0x00000000,0xffffffff,0b100,0x0000ff00);
  CHECK_RED(0x00000000,0xffffffff,0b100,0xffffff00);
  CHECK_RED(0xffffffff,0x00000000,0b100,0x000000ff);
  CHECK_RED(0xf0f0f0f0,0x0f0f0f0f,0b100,0x00000ff0);
  // RED 0b101
  CHECK_RED(0xff00ff00,0x00ff00ff,0b101,0x0000ff00);
  CHECK_RED(0xff00ff00,0x00ff00ff,0b101,0xffffff00);
  CHECK_RED(0x00ff00ff,0xff00ff00,0b101,0x000000ff);
  CHECK_RED(0x0ff00ff0,0xf00ff00f,0b101,0x00000ff0);
  // RED 0b110
  CHECK_RED(0x00000000,0xffffffff,0b110,0xff000000);
  CHECK_RED(0x00000000,0xffffffff,0b110,0xff00ffff);
  CHECK_RED(0xffffffff,0x00000000,0b110,0x00ff0000);
  CHECK_RED(0xf0f0f0f0,0x0f0f0f0f,0b110,0x0ff00000);
  // RED 0b111
  CHECK_RED(0xff00ff00,0x00ff00ff,0b111,0xff000000);
  CHECK_RED(0xff00ff00,0x00ff00ff,0b111,0xff00ffff);
  CHECK_RED(0x00ff00ff,0xff00ff00,0b111,0x00ff0000);
  CHECK_RED(0x0ff00ff0,0xf00ff00f,0b111,0x0ff00000);
  
  // TIBSROT_2
  CHECK_UN(TIBSROT_2,0x5555aaaa,0xaaaa5555);
  CHECK_UN(TIBSROT_2,0x5a5a5a5a,0xa5a5a5a5);

  // TIBSROT_4
  CHECK_UN(TIBSROT_4,0xeeeeeeee,0x77777777);
  CHECK_UN(TIBSROT_4,0xdddddddd,0xeeeeeeee);

  // ANDC8
  CHECK(ANDC8,0xff00ff00,0xffffffff,0x00000000);
  CHECK(ANDC8,0xffffffff,0x00ff00ff,0xffffffff);
  CHECK(ANDC8,0x00ff00ff,0x00ff00ff,0x00ff00ff);
  CHECK(ANDC8,0xff00ff00,0x00000000,0xffffffff);

  // XORC8
  CHECK(XORC8,0x00ff00ff,0xffffffff,0x00000000);
  CHECK(XORC8,0x00000000,0x00ff00ff,0xffffffff);
  CHECK(XORC8,0xff00ff00,0x00ff00ff,0x00ff00ff);
  CHECK(XORC8,0xffffffff,0x00000000,0x00ff00ff);

  // XNORC8
  CHECK(XNORC8,0xff00ff00,0xffffffff,0x00000000);
  CHECK(XNORC8,0xffffffff,0x00ff00ff,0xffffffff);
  CHECK(XNORC8,0x00ff00ff,0x00ff00ff,0x00ff00ff);
  CHECK(XNORC8,0x00000000,0x00000000,0x00ff00ff);
  
  // ANDC16
  CHECK(ANDC16,0xffff0000,0xffffffff,0x00000000);
  CHECK(ANDC16,0xffff00ff,0x00ff00ff,0xffffffff);
  CHECK(ANDC16,0x00ff00ff,0x00ff00ff,0x00ff00ff);
  CHECK(ANDC16,0xffff0000,0x00000000,0xffffffff);
  
  // XORC16
  CHECK(XORC16,0x0000ffff,0xffffffff,0x00000000);
  CHECK(XORC16,0x00ffff00,0x00ff00ff,0xffffffff);
  CHECK(XORC16,0xffff0000,0x00ff00ff,0x00ff00ff);
  CHECK(XORC16,0xff0000ff,0x00000000,0x00ff00ff);

  // XNORC16
  CHECK(XNORC16,0xffff0000,0xffffffff,0x00000000);
  CHECK(XNORC16,0xff0000ff,0x00ff00ff,0xffffffff);
  CHECK(XNORC16,0x0000ffff,0x00ff00ff,0x00ff00ff);
  CHECK(XNORC16,0x00ffff00,0x00000000,0x00ff00ff);

}

/* Checks that the FD operators are correct */
void test_fd() {

  // FD = 1
  CHECK(FD_AND_1,0x00000000,0xffffffff,0x00000000);
  CHECK(FD_AND_1,0x00000000,0x00000000,0xffffffff);
  CHECK(FD_AND_1,0xffffffff,0xffffffff,0xffffffff);
  CHECK(FD_AND_1,0xf0f0f0f0,0xffffffff,0xf0f0f0f0);
  CHECK(FD_AND_1,0x00000000,0xf0f0f0f0,0x0f0f0f0f);

  CHECK(FD_OR_1,0xffffffff,0xffffffff,0x00000000);
  CHECK(FD_OR_1,0xffffffff,0x00000000,0xffffffff);
  CHECK(FD_OR_1,0x00000000,0x00000000,0x00000000);
  CHECK(FD_OR_1,0xffffffff,0xffffffff,0xffffffff);
  CHECK(FD_OR_1,0xf0f0f0f0,0x00000000,0xf0f0f0f0);
  CHECK(FD_OR_1,0xffffffff,0xf0f0f0f0,0x0f0f0f0f);
  
  CHECK(FD_XOR_1,0xffffffff,0xffffffff,0x00000000);
  CHECK(FD_XOR_1,0xffffffff,0x00000000,0xffffffff);
  CHECK(FD_XOR_1,0x00000000,0x00000000,0x00000000);
  CHECK(FD_XOR_1,0x00000000,0xffffffff,0xffffffff);
  CHECK(FD_XOR_1,0xf0f0f0f0,0x00000000,0xf0f0f0f0);
  CHECK(FD_XOR_1,0xffffffff,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_UN(FD_NOT_1,0x00000000,0xffffffff);
  CHECK_UN(FD_NOT_1,0xffffffff,0x00000000);
  CHECK_UN(FD_NOT_1,0xf0f0f0f0,0x0f0f0f0f);

  // FD = 2
  CHECK(FD_AND_2,0xffff0000,0xffffffff,0x00000000);
  CHECK(FD_AND_2,0xffff0000,0x00000000,0xffffffff);
  CHECK(FD_AND_2,0xffffffff,0xffffffff,0xffffffff);
  CHECK(FD_AND_2,0xfffff0f0,0xffffffff,0xf0f0f0f0);
  CHECK(FD_AND_2,0xffff0000,0xf0f0f0f0,0x0f0f0f0f);

  CHECK(FD_OR_2,0x0000ffff,0xffffffff,0x00000000);
  CHECK(FD_OR_2,0x0000ffff,0x00000000,0xffffffff);
  CHECK(FD_OR_2,0x00000000,0x00000000,0x00000000);
  CHECK(FD_OR_2,0xffffffff,0xffffffff,0xffffffff);
  CHECK(FD_OR_2,0x0000f0f0,0x00000000,0xf0f0f0f0);
  CHECK(FD_OR_2,0x0000ffff,0xf0f0f0f0,0x0f0f0f0f);
  
  CHECK(FD_XOR_2,0x0000ffff,0xffffffff,0x00000000);
  CHECK(FD_XOR_2,0x0000ffff,0x00000000,0xffffffff);
  CHECK(FD_XOR_2,0xffff0000,0x00000000,0x00000000);
  CHECK(FD_XOR_2,0xffff0000,0xffffffff,0xffffffff);
  CHECK(FD_XOR_2,0x0f0ff0f0,0x00000000,0xf0f0f0f0);
  CHECK(FD_XOR_2,0x0000ffff,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_UN(FD_NOT_2,0x00000000,0xffffffff);
  CHECK_UN(FD_NOT_2,0xffffffff,0x00000000);
  CHECK_UN(FD_NOT_2,0xf0f0f0f0,0x0f0f0f0f);
  
  // FD = 4
  CHECK(FD_AND_4,0xff00ff00,0xffffffff,0x00000000);
  CHECK(FD_AND_4,0xff00ff00,0x00000000,0xffffffff);
  CHECK(FD_AND_4,0xffffffff,0xffffffff,0xffffffff);
  CHECK(FD_AND_4,0xfff0fff0,0xffffffff,0xf0f0f0f0);
  CHECK(FD_AND_4,0xff00ff00,0xf0f0f0f0,0x0f0f0f0f);

  CHECK(FD_OR_4,0x00ff00ff,0xffffffff,0x00000000);
  CHECK(FD_OR_4,0x00ff00ff,0x00000000,0xffffffff);
  CHECK(FD_OR_4,0x00000000,0x00000000,0x00000000);
  CHECK(FD_OR_4,0xffffffff,0xffffffff,0xffffffff);
  CHECK(FD_OR_4,0x00f000f0,0x00000000,0xf0f0f0f0);
  CHECK(FD_OR_4,0x00ff00ff,0xf0f0f0f0,0x0f0f0f0f);
  
  CHECK(FD_XOR_4,0x00ff00ff,0xffffffff,0x00000000);
  CHECK(FD_XOR_4,0x00ff00ff,0x00000000,0xffffffff);
  CHECK(FD_XOR_4,0xff00ff00,0x00000000,0x00000000);
  CHECK(FD_XOR_4,0xff00ff00,0xffffffff,0xffffffff);
  CHECK(FD_XOR_4,0x0ff00ff0,0x00000000,0xf0f0f0f0);
  CHECK(FD_XOR_4,0x00ff00ff,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_UN(FD_NOT_4,0x00000000,0xffffffff);
  CHECK_UN(FD_NOT_4,0xffffffff,0x00000000);
  CHECK_UN(FD_NOT_4,0xf0f0f0f0,0x0f0f0f0f);
  
}

void test_ti() {
  // no tests for TI == 1 since they would be the same as FD == 1

  // TI = 2
  int a, b, c;
  a = 0x00000000;
  b = 0x00000000;
  TI_AND_2(c,a,b);
  
}

#include <time.h>
int main() {
  /* srand(time(NULL)); */
  test_custom_instr();
  
  test_fd();

  test_ti();

  printf("All right\n");

  return 0;
}
