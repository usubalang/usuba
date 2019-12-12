#pragma once

/* This file only contains "advanced" custom instructed, ie, all
   custom instructions but ANDCx, XORCx and XNORCx.

 */

#if defined(X86) || defined(NO_CUSTOM_INSTR)

#define TIBS(rd,y,r1,r2) {                          \
    DATATYPE _r1 = r1, _r2 = r2;                    \
    rd = 0, y = 0;                                  \
    for (int i = 31, j = 0; i >= 16; i--, j++) {    \
      rd |= ((_r1 >> i) & 1) << (31 - j*2);         \
      rd |= ((_r2 >> i) & 1) << (31 - (j*2+1));     \
    }                                               \
    for (int i = 0; i < 16; i++) {                  \
      y |= ((_r2 >> i) & 1) << i*2;                 \
      y |= ((_r1 >> i) & 1) << (i*2+1);             \
    }                                               \
  }

/* r1/r2 are actually the destination, and rd/y the source
   but it makes it clearer to name them that way (since
   INVTIBS is the inverse of TIBS) */
#define INVTIBS(r1,r2,rd,y) {                       \
    r1 = 0, r2 = 0;                                 \
    for (int i = 31, j = 31; i >= 0; i -= 2, j--) { \
      r1 |= ((rd >> i) & 1) << j;                   \
      r2 |= ((rd >> (i-1)) & 1) << j;               \
    }                                               \
    for (int i = 31, j = 15; i >= 0; i -= 2, j--) { \
      r1 |= ((y >> i) & 1) << j;                    \
      r2 |= ((y >> (i-1)) & 1) << j;                \
    }                                               \
  }

#define RED(rd,y,i,a) {                                                 \
    if (i == 0b010) {                                                   \
      rd = ((a) << 16) | ((a) & 0xFFFF);                                \
      y  = ((a) & 0xFFFF0000) | ((a) >> 16);                            \
    }                                                                   \
    else if (i == 0b011) {                                              \
      rd = (~(a) << 16) | ((a) & 0xFFFF);                               \
      y  = (~(a) & 0xFFFF0000) | ((a) >> 16);                           \
    }                                                                   \
    else if (i == 0b100) {                                              \
      rd = ((a) & 0xFF) | (((a) & 0xFF) << 8) |                         \
      (((a) & 0xFF) << 16) | (((a) & 0xFF) << 24);                      \
      y  = (((a) & 0xFF00) >> 8) | ((a) & 0xFF00) |                     \
      (((a) & 0xFF00) << 8) | (((a) & 0xFF00) << 16);                   \
    }                                                                   \
    else if (i == 0b101) {                                              \
      rd = ((a) & 0xFF) | ((~(a) & 0xFF) << 8) |                        \
      (((a) & 0xFF) << 16) | ((~(a) & 0xFF) << 24);                     \
      y  = (((a) & 0xFF00) >> 8) | (~(a) & 0xFF00) |                    \
      (((a) & 0xFF00) << 8) | ((~(a) & 0xFF00) << 16);                  \
    }                                                                   \
    else if (i == 0b110) {                                              \
      rd = (((a) & 0xFF0000) >> 16) | (((a) & 0xFF0000) >> 8) |         \
      ((a) & 0xFF0000) | (((a) & 0xFF0000) << 8);                       \
      y  = (((a) & 0xFF000000) >> 24) | (((a) & 0xFF000000) >> 16) |    \
      (((a) & 0xFF000000) >> 8) | ((a) & 0xFF000000);                   \
    }                                                                   \
    else if (i == 0b111) {                                              \
      rd = (((a) & 0xFF0000) >> 16) | ((~(a) & 0xFF0000) >> 8) |        \
      ((a) & 0xFF0000) | ((~(a) & 0xFF0000) << 8);                      \
      y  = (((a) & 0xFF000000) >> 24) | ((~(a) & 0xFF000000) >> 16) |   \
      (((a) & 0xFF000000) >> 8) | (~(a) & 0xFF000000);                  \
    }                                                                   \
    else {                                                              \
      fprintf(stderr, "Invalid RED@%d.\n",i);                           \
      exit(EXIT_FAILURE);                                               \
    }                                                                   \
  }

#define FTCHK(rd,i,a) {                                                 \
    if (i == 0b0010 || i == 0b1010) {                                   \
      int low = a & 0xFFFF, high = a >> 16;                             \
      int _fault_flags = low ^ high;                                     \
      if (i == 0b0010) rd = _fault_flags | (_fault_flags << 16);          \
      if (i == 0b1010) rd = _fault_flags | (~_fault_flags << 16);         \
    }                                                                   \
    else if (i == 0b0011 || i == 0b1011) {                              \
      int low = a & 0xFFFF, high = a >> 16;                             \
      int _fault_flags = (~(low ^ high)) & 0xFFFF;                       \
      if (i == 0b0011) rd = _fault_flags | (_fault_flags << 16);          \
      if (i == 0b1011) rd = _fault_flags | (~_fault_flags << 16);         \
    }                                                                   \
    else if (i == 0b0100 || i == 0b1100) {                              \
      int q1 = a & 0xff,         q2 = (a >> 8) & 0xff,                  \
          q3 = (a >> 16) & 0xff, q4 = (a >> 24) & 0xff;                 \
      int _fault_flags = (q1 ^ q2) | (q1 ^ q3) | (q1 ^ q4);              \
      if (i == 0b0100) rd = _fault_flags | (_fault_flags << 8) |          \
                         (_fault_flags << 16) | (_fault_flags << 24);     \
      if (i == 0b1100) rd = _fault_flags | ((~_fault_flags & 0xff) << 8) | \
                         (_fault_flags << 16) | ((~_fault_flags & 0xff) << 24); \
    }                                                                   \
    else if (i == 0b0101 || i == 0b1101) {                              \
      int q1 = a & 0xff,         q2 = (a >> 8) & 0xff,                  \
          q3 = (a >> 16) & 0xff, q4 = (a >> 24) & 0xff;                 \
      int _fault_flags = (~(q1 ^ q2) | (q1 ^ q3) | ~(q1 ^ q4)) & 0xff;   \
      if (i == 0b0101) rd = _fault_flags | (_fault_flags << 8) |          \
                         (_fault_flags << 16) | (_fault_flags << 24);     \
      if (i == 0b1101) rd = _fault_flags | ((~_fault_flags & 0xff) << 8) | \
                         (_fault_flags << 16) | ((~_fault_flags & 0xff) << 24); \
    }                                                                   \
    else if (i == 0b11100) {                                            \
      int q1 = a & 0xff,         q2 = (a >> 8) & 0xff,                  \
          q3 = (a >> 16) & 0xff, q4 = (a >> 24) & 0xff;                 \
      int _fault_flags = (q1&q2) | (q1&q3) | (q1&q4) | (q2&q3) | (q2&q4) | (q3&q4); \
      rd = _fault_flags | (_fault_flags << 8) |                         \
        (_fault_flags << 16) | (_fault_flags << 24);                    \
    }                                                                   \
    else if (i == 0b11101) {                                            \
      int q1 = a & 0xff,         q2 = (~a >> 8) & 0xff,                 \
          q3 = (a >> 16) & 0xff, q4 = (~a >> 24) & 0xff;                \
      int _fault_flags = (q1&q2) | (q1&q3) | (q1&q4) | (q2&q3) | (q2&q4) | (q3&q4); \
      rd = _fault_flags | ((~_fault_flags & 0xff) << 8) |                 \
        (_fault_flags << 16) | ((~_fault_flags & 0xff) << 24);            \
    }                                                                   \
                                                                        \
    /* else { */                                                        \
    /* fprintf(stderr, "Invalid FTCHK@%d.\n",i); */                     \
    /* exit(EXIT_FAILURE); */                                           \
    /* } */                                                             \
  }

#define SUBROT_2(r,a) r = ((a << 1) & 0xAAAAAAAA) | ((a >> 1) & 0x55555555)
#define SUBROT_4(r,a) r = ((a << 1) & 0xEEEEEEEE) | ((a >> 3) & 0x11111111)

#endif // #if defined(X86) || defined(NO_CUSTOM_INSTR)
