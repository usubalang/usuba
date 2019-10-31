#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "FAME.h"

int fault_flags = 0;

#define assert_eq(got,expected) {                                       \
    if (got != expected) {                                              \
      fprintf(stderr, "%s:%d: Assertion `" #expected " = " #got         \
              "' failed: expected %08x, got %08x.\n",                   \
              __FILE__, __LINE__, expected, got);                       \
      exit(EXIT_FAILURE);                                               \
    }                                                                   \
  }

/* Checks that OP(v1,v2) == expected */
#define CHECK_BIN(OP,expected,v1,v2) {          \
    DATATYPE a = v1, b = v2, r;                 \
    OP(r,a,b);                                  \
    assert_eq(r, expected);                     \
  }

/* Checks that OP(v1) == expected */
#define CHECK_UN(OP,expected,v1) {              \
    DATATYPE a = v1, r;                         \
    OP(r,a);                                    \
    assert_eq(r,  expected);                    \
  }

/* Note: CHECK_TIBS and CHECK_INVTIBS could be factorized.
   However, it's trickier for CHECK_RED, because "i" is an immediate,
   and not a register. */
#define CHECK_TIBS(expect_rd,expect_y,v1,v2) {  \
    DATATYPE r1 = v1, r2 = v2, rd, y;           \
    TIBS(rd,y,r1,r2);                           \
    assert(rd == expect_rd && y == expect_y);   \
  }
#define CHECK_INVTIBS(expect_rd,expect_y,v1,v2) {   \
    DATATYPE r1 = v1, r2 = v2, rd, y;               \
    INVTIBS(rd,y,r1,r2);                            \
    assert(rd == expect_rd && y == expect_y);       \
  }

#define CHECK_RED(expect_rd,expect_y,i,v) {     \
    DATATYPE a = v, rd, y;                      \
    RED(rd,y,i,a);                              \
    assert(rd == expect_rd && y == expect_y);   \
  }

#define CHECK_FTCHK(expected,i,v) {             \
    DATATYPE a = v, rd= 0;                      \
    FTCHK(rd,i,a);                              \
    assert_eq(rd, expected);                    \
  }

/* tests the basic (custom) instructions (SUBROT, ANDC8, XORC16, etc.) */
void test_custom_instr() {

  //TIBS
  CHECK_TIBS(0x00000000,0x00000000,0x00000000,0x00000000);
  CHECK_TIBS(0xffffffff,0xffffffff,0xffffffff,0xffffffff);
  CHECK_TIBS(0xffffffff,0x00000000,0xffff0000,0xffff0000);
  CHECK_TIBS(0x00000000,0xffffffff,0x0000ffff,0x0000ffff);
  CHECK_TIBS(0xaaaaaaaa,0xaaaaaaaa,0xffffffff,0x00000000);
  CHECK_TIBS(0xaaaaaaaa,0x55555555,0xffff0000,0x0000ffff);
  CHECK_TIBS(0xff55aa00,0xff55aa00,0xf0f0f0f0,0xff00ff00);

  //INVTIBS
  CHECK_INVTIBS(0x00000000,0x00000000,0x00000000,0x00000000);
  CHECK_INVTIBS(0xffffffff,0xffffffff,0xffffffff,0xffffffff);
  CHECK_INVTIBS(0xffff0000,0xffff0000,0xffffffff,0x00000000);
  CHECK_INVTIBS(0x0000ffff,0x0000ffff,0x00000000,0xffffffff);
  CHECK_INVTIBS(0xffffffff,0x00000000,0xaaaaaaaa,0xaaaaaaaa);
  CHECK_INVTIBS(0xffff0000,0x0000ffff,0xaaaaaaaa,0x55555555);
  CHECK_INVTIBS(0xf0f0f0f0,0xff00ff00,0xff55aa00,0xff55aa00);

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
  CHECK_FTCHK(0xffffffff,0b0010,0xffff0000);
  CHECK_FTCHK(0xffffffff,0b0010,0x0000ffff);
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
  CHECK_FTCHK(0xffffffff,0b0011,0x00000000);
  CHECK_FTCHK(0xffffffff,0b0011,0xff00ff00);
  // FTCHK 0b1011
  CHECK_FTCHK(0xffff0000,0b1011,0xffff0000);
  CHECK_FTCHK(0xffff0000,0b1011,0x0000ffff);
  CHECK_FTCHK(0x0000ffff,0b1011,0x00000000);
  CHECK_FTCHK(0x0000ffff,0b1011,0xff00ff00);
  // FTCHK 0b0100
  CHECK_FTCHK(0x00000000,0b0100,0x00000000);
  CHECK_FTCHK(0x00000000,0b0100,0xffffffff);
  CHECK_FTCHK(0x00000000,0b0100,0xf0f0f0f0);
  CHECK_FTCHK(0xffffffff,0b0100,0x00ff00ff);
  CHECK_FTCHK(0xffffffff,0b0100,0x000000ff);
  CHECK_FTCHK(0xffffffff,0b0100,0xffffff00);
  // FTCHK 0b1100
  CHECK_FTCHK(0xff00ff00,0b1100,0x00000000);
  CHECK_FTCHK(0xff00ff00,0b1100,0xffffffff);
  CHECK_FTCHK(0xff00ff00,0b1100,0xf0f0f0f0);
  CHECK_FTCHK(0x00ff00ff,0b1100,0x00ff00ff);
  CHECK_FTCHK(0x00ff00ff,0b1100,0x000000ff);
  CHECK_FTCHK(0x00ff00ff,0b1100,0xffffff00);
  // FTCHK 0b0101
  CHECK_FTCHK(0xffffffff,0b0101,0x00000000);
  CHECK_FTCHK(0xffffffff,0b0101,0xffffffff);
  CHECK_FTCHK(0x00000000,0b0101,0x00ff00ff);
  CHECK_FTCHK(0xffffffff,0b0101,0x000000ff);
  CHECK_FTCHK(0xffffffff,0b0101,0xffffff00);
  CHECK_FTCHK(0x00000000,0b0101,0x0ff00ff0);
  // FTCHK 0b1101
  CHECK_FTCHK(0x00ff00ff,0b1101,0x00000000);
  CHECK_FTCHK(0x00ff00ff,0b1101,0xffffffff);
  CHECK_FTCHK(0xff00ff00,0b1101,0x00ff00ff);
  CHECK_FTCHK(0x00ff00ff,0b1101,0x000000ff);
  CHECK_FTCHK(0x00ff00ff,0b1101,0xffffff00);
  CHECK_FTCHK(0xff00ff00,0b1101,0x0ff00ff0);
  // FTCHK 0b11100
  CHECK_FTCHK(0xff00ff00,0b11100,0x00000000);
  CHECK_FTCHK(0x00ff00ff,0b11100,0xffffffff);
  CHECK_FTCHK(0xff00ff00,0b11100,0x00ff0000);
  CHECK_FTCHK(0x00ff00ff,0b11100,0xffffff00);
  // FTCHK 0b11101
  CHECK_FTCHK(0xff00ff00,0b11100,0xff000000);
  CHECK_FTCHK(0x00ff00ff,0b11100,0xffffff00);
  CHECK_FTCHK(0xff00ff00,0b11100,0x00ff0000);
  CHECK_FTCHK(0x00ff00ff,0b11100,0xffffff00);

  // SUBROT_2
  CHECK_UN(SUBROT_2,0x5555aaaa,0xaaaa5555);
  CHECK_UN(SUBROT_2,0x5a5a5a5a,0xa5a5a5a5);

  // SUBROT_4
  CHECK_UN(SUBROT_4,0xeeeeeeee,0x77777777);
  CHECK_UN(SUBROT_4,0xdddddddd,0xeeeeeeee);

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
  CHECK_BIN(ANDC16,0xffff0000,0xeeee1111,0x5555aaaa);

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
#define CHECK_TI_BIN_FD1(OP,REDUCE,expected,v1,v2) {    \
    DATATYPE a = v1, b = v2, res;                   \
    fault_flags = 0;                                \
    for (int i = 0; i < 100; i++) {                 \
      OP(res,a,b);                                  \
      assert(REDUCE(res) == expected);              \
    }                                               \
    assert_eq(fault_flags, 0);                      \
  }
#define CHECK_TI_UN_FD1(OP,REDUCE,expected,v1) {    \
    DATATYPE a = v1, res;                       \
    fault_flags = 0;                            \
    for (int i = 0; i < 100; i++) {             \
      OP(res,a);                                \
      assert(REDUCE(res) == expected);          \
    }                                           \
    assert_eq(fault_flags, 0);                  \
  }
#define CHECK_TI_BIN_FD2(OP,REDUCE,expected,v1,v2) {           \
    DATATYPE a = v1, b = v2, res;                               \
    fault_flags = 0;                                            \
    for (int i = 0; i < 100; i++) {                             \
      OP(res,a,b);                                              \
      int lh = res & 0xffff, hh = ~res >> 16;                   \
      assert_eq(REDUCE(lh),expected);                           \
      assert_eq(lh,hh);                                         \
    }                                                           \
    assert_eq(fault_flags, 0);                                  \
  }
#define CHECK_TI_UN_FD2(OP,REDUCE,expected,v1) {               \
    DATATYPE a = v1, res;                                       \
    fault_flags = 0;                                            \
    for (int i = 0; i < 100; i++) {                             \
      OP(res,a);                                                \
      int lh = res & 0xffff, hh = ~res >> 16;                   \
      assert(REDUCE(lh) == expected && lh == hh);               \
    }                                                           \
    assert_eq(fault_flags, 0);                                  \
  }
#define CHECK_TI_BIN_FD4(OP,REDUCE,expected,v1,v2) {                    \
    DATATYPE a = v1, b = v2, res;                                       \
    fault_flags = 0;                                                    \
    for (int i = 0; i < 100; i++) {                                     \
      OP(res,a,b);                                                      \
      int b1 = res & 0xff, b2 = (~res >> 8) & 0xff,                     \
        b3 = (res >> 16) & 0xff, b4 = (~res >> 24) & 0xff;              \
      assert(REDUCE(b1) == expected && b1 == b2 && b1 == b3 && b1 == b4); \
    }                                                                   \
    assert_eq(fault_flags, 0);                                          \
  }
#define CHECK_TI_UN_FD4(OP,REDUCE,expected,v1) {                       \
    DATATYPE a = v1, res;                                               \
    fault_flags = 0;                                                    \
    for (int i = 0; i < 100; i++) {                                     \
      OP(res,a);                                                        \
      int b1 = res & 0xff, b2 = (~res >> 8) & 0xff,                     \
        b3 = (res >> 16) & 0xff, b4 = (~res >> 24) & 0xff;              \
      assert(REDUCE(b1) == expected && b1 == b2 && b1 == b3 && b1 == b4); \
    }                                                                   \
    assert_eq(fault_flags, 0);                                          \
  }

/* Checks that the TI operators are **functionally** correct */
void test_ti() {
  // no tests for TI == 1 since they would be the same as FD == 1

#if FD == 1
  // TI = 2
  CHECK_TI_BIN_FD1(TI_AND_2,RED2,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN_FD1(TI_AND_2,RED2,0x55555555,0xaaaaaaaa,0x55555555);
  CHECK_TI_BIN_FD1(TI_AND_2,RED2,0x11111111,0x126a126a,0x11111111);
  CHECK_TI_BIN_FD1(TI_AND_2,RED2,0x10101010,0x10101010,0x11111111);
  CHECK_TI_BIN_FD1(TI_AND_2,RED2,0x11111111,0x11111111,0x55555555);

  CHECK_TI_UN_FD1(TI_NOT_2,RED2,0x00000000,0x55555555);
  CHECK_TI_UN_FD1(TI_NOT_2,RED2,0x55555555,0xcccccccc);
  CHECK_TI_UN_FD1(TI_NOT_2,RED2,0x55555555,0x00000000);

  CHECK_TI_BIN_FD1(TI_OR_2,RED2,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN_FD1(TI_OR_2,RED2,0x55555555,0x55555555,0x55555555);
  CHECK_TI_BIN_FD1(TI_OR_2,RED2,0x55555555,0x88888888,0x22222222);

  CHECK_TI_BIN_FD1(TI_XOR_2,RED2,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN_FD1(TI_XOR_2,RED2,0x00000000,0xffffffff,0x00000000);
  CHECK_TI_BIN_FD1(TI_XOR_2,RED2,0x55555555,0x55555555,0x00000000);

  // TI = 4
  CHECK_TI_BIN_FD1(TI_AND_4,RED4,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN_FD1(TI_AND_4,RED4,0x00000000,0xffffffff,0x00000000);
  CHECK_TI_BIN_FD1(TI_AND_4,RED4,0x11111111,0x88888888,0x11111111);
  CHECK_TI_BIN_FD1(TI_AND_4,RED4,0x11110000,0x71716a6a,0x11111111);

  CHECK_TI_UN_FD1(TI_NOT_4,RED4,0x00000000,0x11111111);
  CHECK_TI_UN_FD1(TI_NOT_4,RED4,0x11111111,0xffffffff);
  CHECK_TI_UN_FD1(TI_NOT_4,RED4,0x11111111,0x00000000);
  CHECK_TI_UN_FD1(TI_NOT_4,RED4,0x10101010,0xf237f237);

  CHECK_TI_BIN_FD1(TI_OR_4,RED4,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN_FD1(TI_OR_4,RED4,0x11111111,0x71de71de,0x00000000);
  CHECK_TI_BIN_FD1(TI_OR_4,RED4,0x11111111,0x10721072,0x07210721);

  CHECK_TI_BIN_FD1(TI_XOR_4,RED4,0x00000000,0x00000000,0x00000000);
  CHECK_TI_BIN_FD1(TI_XOR_4,RED4,0x00000000,0xffffffff,0x00000000);
  CHECK_TI_BIN_FD1(TI_XOR_4,RED4,0x11111111,0x71de71de,0x00000000);
  CHECK_TI_BIN_FD1(TI_XOR_4,RED4,0x11001100,0x10721072,0x07210721);
  CHECK_TI_BIN_FD1(TI_XOR_4,RED4,0x00000000,0x11111111,0x77777777);

#elif FD == 2

  // TI = 2
  CHECK_TI_BIN_FD2(TI_AND_2,RED2,0x0000,0xffff0000,0xffff0000);
  CHECK_TI_BIN_FD2(TI_AND_2,RED2,0x5555,0x5555aaaa,0xaaaa5555);
  CHECK_TI_BIN_FD2(TI_AND_2,RED2,0x1111,0xeeee1111,0xaaaa5555);

  CHECK_TI_UN_FD2(TI_NOT_2,RED2,0x0000,0xaaaa5555);
  CHECK_TI_UN_FD2(TI_NOT_2,RED2,0x5555,0x3333cccc);
  CHECK_TI_UN_FD2(TI_NOT_2,RED2,0x5555,0xffff0000);

  CHECK_TI_BIN_FD2(TI_OR_2,RED2,0x0000,0xffff0000,0xffff0000);
  CHECK_TI_BIN_FD2(TI_OR_2,RED2,0x5555,0xaaaa5555,0xaaaa5555);
  CHECK_TI_BIN_FD2(TI_OR_2,RED2,0x5555,0x77778888,0xdddd2222);

  CHECK_TI_BIN_FD2(TI_XOR_2,RED2,0x0000,0xffff0000,0xffff0000);
  CHECK_TI_BIN_FD2(TI_XOR_2,RED2,0x0000,0x0000ffff,0xffff0000);
  CHECK_TI_BIN_FD2(TI_XOR_2,RED2,0x5555,0xaaaa5555,0xffff0000);

  // TI = 4
  CHECK_TI_BIN_FD2(TI_AND_4,RED4,0x0000,0xffff0000,0xffff0000);
  CHECK_TI_BIN_FD2(TI_AND_4,RED4,0x0000,0x0000ffff,0xffff0000);
  CHECK_TI_BIN_FD2(TI_AND_4,RED4,0x1111,0x77778888,0xeeee1111);
  CHECK_TI_BIN_FD2(TI_AND_4,RED4,0x0000,0x95956a6a,0xeeee1111);

  CHECK_TI_UN_FD2(TI_NOT_4,RED4,0x0000,0xeeee1111);
  CHECK_TI_UN_FD2(TI_NOT_4,RED4,0x1111,0x0000ffff);
  CHECK_TI_UN_FD2(TI_NOT_4,RED4,0x1111,0xffff0000);
  CHECK_TI_UN_FD2(TI_NOT_4,RED4,0x1010,0x0dc8f237);

  CHECK_TI_BIN_FD2(TI_OR_4,RED4,0x0000,0xffff0000,0xffff0000);
  CHECK_TI_BIN_FD2(TI_OR_4,RED4,0x1111,0x8e2171de,0xffff0000);
  CHECK_TI_BIN_FD2(TI_OR_4,RED4,0x1111,0xef8d1072,0xf8de0721);

  CHECK_TI_BIN_FD2(TI_XOR_4,RED4,0x0000,0xffff0000,0xffff0000);
  CHECK_TI_BIN_FD2(TI_XOR_4,RED4,0x0000,0x0000ffff,0xffff0000);
  CHECK_TI_BIN_FD2(TI_XOR_4,RED4,0x1111,0x8e2171de,0xffff0000);
  CHECK_TI_BIN_FD2(TI_XOR_4,RED4,0x1100,0xef8d1072,0xf8de0721);
  CHECK_TI_BIN_FD2(TI_XOR_4,RED4,0x0000,0xeeee1111,0x88887777);


#elif FD == 4

  // TI = 2
  CHECK_TI_BIN_FD4(TI_AND_2,RED2,0x00,0xff00ff00,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_AND_2,RED2,0x55,0x55aa55aa,0xaa55aa55);
  CHECK_TI_BIN_FD4(TI_AND_2,RED2,0x11,0xee11ee11,0xaa55aa55);

  CHECK_TI_UN_FD4(TI_NOT_2,RED2,0x00,0xaa55aa55);
  CHECK_TI_UN_FD4(TI_NOT_2,RED2,0x55,0x33cc33cc);
  CHECK_TI_UN_FD4(TI_NOT_2,RED2,0x55,0xff00ff00);

  CHECK_TI_BIN_FD4(TI_OR_2,RED2,0x00,0xff00ff00,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_OR_2,RED2,0x55,0xaa55aa55,0xaa55aa55);
  CHECK_TI_BIN_FD4(TI_OR_2,RED2,0x55,0x77887788,0xdd22dd22);

  CHECK_TI_BIN_FD4(TI_XOR_2,RED2,0x00,0xff00ff00,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_XOR_2,RED2,0x00,0x00ff00ff,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_XOR_2,RED2,0x55,0xaa55aa55,0xff00ff00);

  // TI = 4
  CHECK_TI_BIN_FD4(TI_AND_4,RED4,0x00,0xff00ff00,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_AND_4,RED4,0x00,0x00ff00ff,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_AND_4,RED4,0x11,0x77887788,0xee11ee11);
  CHECK_TI_BIN_FD4(TI_AND_4,RED4,0x00,0x956a956a,0xee11ee11);

  CHECK_TI_UN_FD4(TI_NOT_4,RED4,0x00,0xee11ee11);
  CHECK_TI_UN_FD4(TI_NOT_4,RED4,0x11,0x00ff00ff);
  CHECK_TI_UN_FD4(TI_NOT_4,RED4,0x11,0xff00ff00);
  CHECK_TI_UN_FD4(TI_NOT_4,RED4,0x10,0xc837c837);

  CHECK_TI_BIN_FD4(TI_OR_4,RED4,0x00,0xff00ff00,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_OR_4,RED4,0x11,0x21de21de,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_OR_4,RED4,0x11,0x8d728d72,0xde21de21);
  CHECK_TI_BIN_FD4(TI_OR_4,RED4,0x11,0xef10ef10,0xf807f807);

  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x00,0xff00ff00,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x00,0x00ff00ff,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x11,0x21de21de,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x11,0x8e718e71,0xff00ff00);
  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x00,0x8d728d72,0xde21de21);
  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x11,0xef10ef10,0xf807f807);
  CHECK_TI_BIN_FD4(TI_XOR_4,RED4,0x00,0xee11ee11,0x88778877);



#endif



}

int main() {
  test_custom_instr();

  test_fd();

  test_ti();

  printf("All right\n");

  return 0;
}
