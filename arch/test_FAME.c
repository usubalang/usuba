#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <assert.h>

#define X86
#include "FAME.h"

/* Checks that OP(v1,v2) == expected */
#define CHECK(OP,expected,v1,v2) {              \
    int a = v1, b = v2, r;                      \
    OP(r,a,b);                                  \
    assert(r == expected);                      \
  }

/* Checks that OP(v1) == expected */
#define CHECK_UN(OP,expected,v1) {              \
    int a = v1, r;                              \
    OP(r,a);                                    \
    assert(r == expected);                      \
  }

/* tests the basic (custom) instructions (TIBSROT, ANDC8, XORC16, etc.) */
void test_custom_instr() {
  int a, b, c;
  
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

int main() {
  test_custom_instr();
  
  test_fd();

  return 0;
}
