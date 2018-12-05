#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "FAME.h"

/* Checks that OP(v1,v2) == expected */
#define CHECK_BIN(OP,expected,v1,v2) {          \
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

#define CHECK_FTCHK(expected,i,v) {             \
    DATATYPE a = v, rd;                         \
    FTCHK(rd,i,a);                              \
    assert(rd == expected);                     \
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

  // FTCHK 0b0010
  CHECK_FTCHK(0x0000ffff,0b0010,0xffff0000);
  CHECK_FTCHK(0x0000ffff,0b0010,0x0000ffff);
  CHECK_FTCHK(0x00000000,0b0010,0x00000000);
  CHECK_FTCHK(0x00000000,0b0010,0xff00ff00);
  // FTCHK 0b1010
  CHECK_FTCHK(0x0000ffff,0b1010,0xffff0000);
  CHECK_FTCHK(0x0000ffff,0b1010,0x0000ffff);
  CHECK_FTCHK(0xffff0000,0b1010,0x00000000);
  CHECK_FTCHK(0xffff0000,0b1010,0xff00ff00);
  // FTCHK 0b0011
  CHECK_FTCHK(0x00000000,0b0011,0xffff0000);
  CHECK_FTCHK(0x00000000,0b0011,0x0000ffff);
  CHECK_FTCHK(0x0000ffff,0b0011,0x00000000);
  CHECK_FTCHK(0x0000ffff,0b0011,0xff00ff00);
  // FTCHK 0b1011
  CHECK_FTCHK(0xffff0000,0b1011,0xffff0000);
  CHECK_FTCHK(0xffff0000,0b1011,0x0000ffff);
  CHECK_FTCHK(0x0000ffff,0b1011,0x00000000);
  CHECK_FTCHK(0x0000ffff,0b1011,0xff00ff00);
  // FTCHK 0b0100
  CHECK_FTCHK(0x00000000,0b0100,0x00000000);
  CHECK_FTCHK(0x00000000,0b0100,0xffffffff);
  CHECK_FTCHK(0x000000ff,0b0100,0x00ff00ff);
  CHECK_FTCHK(0x000000ff,0b0100,0x000000ff);
  CHECK_FTCHK(0x000000ff,0b0100,0xffffff00);
  // FTCHK 0b1100
  CHECK_FTCHK(0xff00ff00,0b1100,0x00000000);
  CHECK_FTCHK(0xff00ff00,0b1100,0xffffffff);
  CHECK_FTCHK(0x00ff00ff,0b1100,0x00ff00ff);
  CHECK_FTCHK(0x00ff00ff,0b1100,0x000000ff);
  CHECK_FTCHK(0x00ff00ff,0b1100,0xffffff00);
  // FTCHK 0b0101
  CHECK_FTCHK(0x000000ff,0b0101,0x00000000);
  CHECK_FTCHK(0x000000ff,0b0101,0xffffffff);
  CHECK_FTCHK(0x00000000,0b0101,0x00ff00ff);
  CHECK_FTCHK(0x000000ff,0b0101,0x000000ff);
  CHECK_FTCHK(0x000000ff,0b0101,0xffffff00);
  CHECK_FTCHK(0x00000000,0b0101,0x0ff00ff0);
  // FTCHK 0b1101
  CHECK_FTCHK(0x00ff00ff,0b1101,0x00000000);
  CHECK_FTCHK(0x00ff00ff,0b1101,0xffffffff);
  CHECK_FTCHK(0xff00ff00,0b1101,0x00ff00ff);
  CHECK_FTCHK(0x00ff00ff,0b1101,0x000000ff);
  CHECK_FTCHK(0x00ff00ff,0b1101,0xffffff00);
  CHECK_FTCHK(0xff00ff00,0b1101,0x0ff00ff0);
  
  // TIBSROT_2
  CHECK_UN(TIBSROT_2,0x5555aaaa,0xaaaa5555);
  CHECK_UN(TIBSROT_2,0x5a5a5a5a,0xa5a5a5a5);

  // TIBSROT_4
  CHECK_UN(TIBSROT_4,0xeeeeeeee,0x77777777);
  CHECK_UN(TIBSROT_4,0xdddddddd,0xeeeeeeee);

  // ANDC8
  CHECK_BIN(ANDC8,0xff00ff00,0xffffffff,0x00000000);
  CHECK_BIN(ANDC8,0xffffffff,0x00ff00ff,0xffffffff);
  CHECK_BIN(ANDC8,0x00ff00ff,0x00ff00ff,0x00ff00ff);
  CHECK_BIN(ANDC8,0xff00ff00,0x00000000,0xffffffff);

  // XORC8
  CHECK_BIN(XORC8,0x00ff00ff,0xffffffff,0x00000000);
  CHECK_BIN(XORC8,0x00000000,0x00ff00ff,0xffffffff);
  CHECK_BIN(XORC8,0xff00ff00,0x00ff00ff,0x00ff00ff);
  CHECK_BIN(XORC8,0xffffffff,0x00000000,0x00ff00ff);

  // XNORC8
  CHECK_BIN(XNORC8,0xff00ff00,0xffffffff,0x00000000);
  CHECK_BIN(XNORC8,0xffffffff,0x00ff00ff,0xffffffff);
  CHECK_BIN(XNORC8,0x00ff00ff,0x00ff00ff,0x00ff00ff);
  CHECK_BIN(XNORC8,0x00000000,0x00000000,0x00ff00ff);
  
  // ANDC16
  CHECK_BIN(ANDC16,0xffff0000,0xffffffff,0x00000000);
  CHECK_BIN(ANDC16,0xffff00ff,0x00ff00ff,0xffffffff);
  CHECK_BIN(ANDC16,0x00ff00ff,0x00ff00ff,0x00ff00ff);
  CHECK_BIN(ANDC16,0xffff0000,0x00000000,0xffffffff);
  
  // XORC16
  CHECK_BIN(XORC16,0x0000ffff,0xffffffff,0x00000000);
  CHECK_BIN(XORC16,0x00ffff00,0x00ff00ff,0xffffffff);
  CHECK_BIN(XORC16,0xffff0000,0x00ff00ff,0x00ff00ff);
  CHECK_BIN(XORC16,0xff0000ff,0x00000000,0x00ff00ff);

  // XNORC16
  CHECK_BIN(XNORC16,0xffff0000,0xffffffff,0x00000000);
  CHECK_BIN(XNORC16,0xff0000ff,0x00ff00ff,0xffffffff);
  CHECK_BIN(XNORC16,0x0000ffff,0x00ff00ff,0x00ff00ff);
  CHECK_BIN(XNORC16,0x00ffff00,0x00000000,0x00ff00ff);

}

/* Checks that the FD operators are correct */
void test_fd() {

  // FD = 1
  CHECK_BIN(FD_AND_1,0x00000000,0xffffffff,0x00000000);
  CHECK_BIN(FD_AND_1,0x00000000,0x00000000,0xffffffff);
  CHECK_BIN(FD_AND_1,0xffffffff,0xffffffff,0xffffffff);
  CHECK_BIN(FD_AND_1,0xf0f0f0f0,0xffffffff,0xf0f0f0f0);
  CHECK_BIN(FD_AND_1,0x00000000,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_BIN(FD_OR_1,0xffffffff,0xffffffff,0x00000000);
  CHECK_BIN(FD_OR_1,0xffffffff,0x00000000,0xffffffff);
  CHECK_BIN(FD_OR_1,0x00000000,0x00000000,0x00000000);
  CHECK_BIN(FD_OR_1,0xffffffff,0xffffffff,0xffffffff);
  CHECK_BIN(FD_OR_1,0xf0f0f0f0,0x00000000,0xf0f0f0f0);
  CHECK_BIN(FD_OR_1,0xffffffff,0xf0f0f0f0,0x0f0f0f0f);
  
  CHECK_BIN(FD_XOR_1,0xffffffff,0xffffffff,0x00000000);
  CHECK_BIN(FD_XOR_1,0xffffffff,0x00000000,0xffffffff);
  CHECK_BIN(FD_XOR_1,0x00000000,0x00000000,0x00000000);
  CHECK_BIN(FD_XOR_1,0x00000000,0xffffffff,0xffffffff);
  CHECK_BIN(FD_XOR_1,0xf0f0f0f0,0x00000000,0xf0f0f0f0);
  CHECK_BIN(FD_XOR_1,0xffffffff,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_UN(FD_NOT_1,0x00000000,0xffffffff);
  CHECK_UN(FD_NOT_1,0xffffffff,0x00000000);
  CHECK_UN(FD_NOT_1,0xf0f0f0f0,0x0f0f0f0f);

  // FD = 2
  CHECK_BIN(FD_AND_2,0xffff0000,0xffffffff,0x00000000);
  CHECK_BIN(FD_AND_2,0xffff0000,0x00000000,0xffffffff);
  CHECK_BIN(FD_AND_2,0xffffffff,0xffffffff,0xffffffff);
  CHECK_BIN(FD_AND_2,0xfffff0f0,0xffffffff,0xf0f0f0f0);
  CHECK_BIN(FD_AND_2,0xffff0000,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_BIN(FD_OR_2,0x0000ffff,0xffffffff,0x00000000);
  CHECK_BIN(FD_OR_2,0x0000ffff,0x00000000,0xffffffff);
  CHECK_BIN(FD_OR_2,0x00000000,0x00000000,0x00000000);
  CHECK_BIN(FD_OR_2,0xffffffff,0xffffffff,0xffffffff);
  CHECK_BIN(FD_OR_2,0x0000f0f0,0x00000000,0xf0f0f0f0);
  CHECK_BIN(FD_OR_2,0x0000ffff,0xf0f0f0f0,0x0f0f0f0f);
  
  CHECK_BIN(FD_XOR_2,0x0000ffff,0xffffffff,0x00000000);
  CHECK_BIN(FD_XOR_2,0x0000ffff,0x00000000,0xffffffff);
  CHECK_BIN(FD_XOR_2,0xffff0000,0x00000000,0x00000000);
  CHECK_BIN(FD_XOR_2,0xffff0000,0xffffffff,0xffffffff);
  CHECK_BIN(FD_XOR_2,0x0f0ff0f0,0x00000000,0xf0f0f0f0);
  CHECK_BIN(FD_XOR_2,0x0000ffff,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_UN(FD_NOT_2,0x00000000,0xffffffff);
  CHECK_UN(FD_NOT_2,0xffffffff,0x00000000);
  CHECK_UN(FD_NOT_2,0xf0f0f0f0,0x0f0f0f0f);
  
  // FD = 4
  CHECK_BIN(FD_AND_4,0xff00ff00,0xffffffff,0x00000000);
  CHECK_BIN(FD_AND_4,0xff00ff00,0x00000000,0xffffffff);
  CHECK_BIN(FD_AND_4,0xffffffff,0xffffffff,0xffffffff);
  CHECK_BIN(FD_AND_4,0xfff0fff0,0xffffffff,0xf0f0f0f0);
  CHECK_BIN(FD_AND_4,0xff00ff00,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_BIN(FD_OR_4,0x00ff00ff,0xffffffff,0x00000000);
  CHECK_BIN(FD_OR_4,0x00ff00ff,0x00000000,0xffffffff);
  CHECK_BIN(FD_OR_4,0x00000000,0x00000000,0x00000000);
  CHECK_BIN(FD_OR_4,0xffffffff,0xffffffff,0xffffffff);
  CHECK_BIN(FD_OR_4,0x00f000f0,0x00000000,0xf0f0f0f0);
  CHECK_BIN(FD_OR_4,0x00ff00ff,0xf0f0f0f0,0x0f0f0f0f);
  
  CHECK_BIN(FD_XOR_4,0x00ff00ff,0xffffffff,0x00000000);
  CHECK_BIN(FD_XOR_4,0x00ff00ff,0x00000000,0xffffffff);
  CHECK_BIN(FD_XOR_4,0xff00ff00,0x00000000,0x00000000);
  CHECK_BIN(FD_XOR_4,0xff00ff00,0xffffffff,0xffffffff);
  CHECK_BIN(FD_XOR_4,0x0ff00ff0,0x00000000,0xf0f0f0f0);
  CHECK_BIN(FD_XOR_4,0x00ff00ff,0xf0f0f0f0,0x0f0f0f0f);

  CHECK_UN(FD_NOT_4,0x00000000,0xffffffff);
  CHECK_UN(FD_NOT_4,0xffffffff,0x00000000);
  CHECK_UN(FD_NOT_4,0xf0f0f0f0,0x0f0f0f0f);
  
}

#define RED2(x) ((x ^ (x >> 1)) & 0x55555555)
#define RED4(x) ((x ^ (x >> 1) ^ (x >> 2) ^ (x >> 3)) & 0x11111111)

/* The for loop is present because of the randomness */
#define CHECK_TI_BIN(OP,REDUCE,expected,v1,v2) {    \
    DATATYPE a = v1, b = v2, res;                   \
    for (int i = 0; i < 100; i++) {                 \
      OP(res,a,b);                                  \
      assert(REDUCE(res) == expected);              \
    }                                               \
  }
/* The for loop is present because of the randomness */
#define CHECK_TI_UN(OP,REDUCE,expected,v1) {    \
    DATATYPE a = v1, res;                       \
    for (int i = 0; i < 100; i++) {             \
      OP(res,a);                                \
      assert(REDUCE(res) == expected);          \
    }                                           \
  }

/* Checks that the TI operators are **functionally** correct.
   Not that this only checks for FD = 1. */
void test_ti() {
  // no tests for TI == 1 since they would be the same as FD == 1

  // TI = 2
  CHECK_TI_BIN(TI_AND_2,RED2,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN(TI_AND_2,RED2,0x55555555,0xaaaaaaaa,0x55555555);
  CHECK_TI_BIN(TI_AND_2,RED2,0x11111111,0x126a126a,0x11111111);

  CHECK_TI_UN(TI_NOT_2,RED2,0x00000000,0x55555555);
  CHECK_TI_UN(TI_NOT_2,RED2,0x55555555,0xcccccccc);
  CHECK_TI_UN(TI_NOT_2,RED2,0x55555555,0x00000000);
  
  CHECK_TI_BIN(TI_OR_2,RED2,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN(TI_OR_2,RED2,0x55555555,0x55555555,0x55555555);  
  CHECK_TI_BIN(TI_OR_2,RED2,0x55555555,0x88888888,0x22222222);

  CHECK_TI_BIN(TI_XOR_2,RED2,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN(TI_XOR_2,RED2,0x00000000,0xffffffff,0x00000000);
  CHECK_TI_BIN(TI_XOR_2,RED2,0x55555555,0x55555555,0x00000000);

  // TI = 4
  CHECK_TI_BIN(TI_AND_4,RED4,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN(TI_AND_4,RED4,0x00000000,0xffffffff,0x00000000);
  CHECK_TI_BIN(TI_AND_4,RED4,0x11111111,0x88888888,0x11111111);
  CHECK_TI_BIN(TI_AND_4,RED4,0x11110000,0x71716a6a,0x11111111);
  
  CHECK_TI_UN(TI_NOT_4,RED4,0x00000000,0x11111111);
  CHECK_TI_UN(TI_NOT_4,RED4,0x11111111,0xffffffff);
  CHECK_TI_UN(TI_NOT_4,RED4,0x11111111,0x00000000);
  CHECK_TI_UN(TI_NOT_4,RED4,0x10101010,0xf237f237);

  CHECK_TI_BIN(TI_OR_4,RED4,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN(TI_OR_4,RED4,0x11111111,0x71de71de,0x00000000);
  CHECK_TI_BIN(TI_OR_4,RED4,0x11111111,0x10721072,0x07210721);

  CHECK_TI_BIN(TI_XOR_4,RED4,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN(TI_XOR_4,RED4,0x00000000,0xffffffff,0x00000000);
  CHECK_TI_BIN(TI_XOR_4,RED4,0x11111111,0x71de71de,0x00000000);
  CHECK_TI_BIN(TI_XOR_4,RED4,0x11001100,0x10721072,0x07210721);
  CHECK_TI_BIN(TI_XOR_4,RED4,0x00000000,0x11111111,0x77777777);
  
  
  
  
  
}

#include <time.h>
int main() {
  test_custom_instr();
  
  test_fd();

  test_ti();

  printf("All right\n");

  return 0;
}
