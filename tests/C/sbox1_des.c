#include <stdlib.h>
#include <stdio.h>
#include "mmintrin.h"
#include "immintrin.h"
#include "tmmintrin.h"
#include "emmintrin.h"



static void f__ (unsigned long a1,unsigned long a2,unsigned long a3,unsigned long a4,unsigned long a5,unsigned long a6,unsigned long* out1,unsigned long* out2,unsigned long* out3,unsigned long* out4) {
  unsigned long x1;
  unsigned long x2;
  unsigned long x3;
  unsigned long x4;
  unsigned long x5;
  unsigned long x6;
  unsigned long x7;
  unsigned long x8;
  unsigned long x9;
  unsigned long x10;
  unsigned long x11;
  unsigned long x12;
  unsigned long x13;
  unsigned long x14;
  unsigned long x15;
  unsigned long x16;
  unsigned long x17;
  unsigned long x18;
  unsigned long x19;
  unsigned long x20;
  unsigned long x21;
  unsigned long x22;
  unsigned long x23;
  unsigned long x24;
  unsigned long x25;
  unsigned long x26;
  unsigned long x27;
  unsigned long x28;
  unsigned long x29;
  unsigned long x30;
  unsigned long x31;
  unsigned long x32;
  unsigned long x33;
  unsigned long x34;
  unsigned long x35;
  unsigned long x36;
  unsigned long x37;
  unsigned long x38;
  unsigned long x39;
  unsigned long x40;
  unsigned long x41;
  unsigned long x42;
  unsigned long x43;
  unsigned long x44;
  unsigned long x45;
  unsigned long x46;
  unsigned long x47;
  unsigned long x48;
  unsigned long x49;
  unsigned long x50;
  unsigned long x51;
  unsigned long x52;
  unsigned long x53;
  unsigned long x54;
  unsigned long x55;
  unsigned long x56;
  unsigned long x57;
  unsigned long x58;
  unsigned long x59;
  unsigned long x60;
  unsigned long x61;
  unsigned long x62;
  unsigned long x63;

  x1 = ~(a4);
  x2 = ~(a1);
  x3 = (a3) ^ (a4);
  x4 = (x2) ^ (x3);
  x5 = (x2) | (a3);
  x6 = (x1) & (x5);
  x7 = (x6) | (a6);
  x8 = (x7) ^ (x4);
  x9 = (x2) | (x1);
  x10 = (x9) & (a6);
  x11 = (x10) ^ (x7);
  x12 = (x11) | (a2);
  x13 = (x12) ^ (x8);
  x14 = (x13) ^ (x9);
  x15 = (x14) | (a6);
  x16 = (x15) ^ (x1);
  x17 = ~(x14);
  x18 = (x3) & (x17);
  x19 = (x18) | (a2);
  x20 = (x19) ^ (x16);
  x21 = (x20) | (a5);
  x22 = (x21) ^ (x13);
  *out4 = x22;
  x23 = (x4) | (a3);
  x24 = ~(x23);
  x25 = (x24) | (a6);
  x26 = (x25) ^ (x6);
  x27 = (x8) & (x1);
  x28 = (x27) | (a2);
  x29 = (x28) ^ (x26);
  x30 = (x8) | (x1);
  x31 = (x6) ^ (x30);
  x32 = (x14) & (x5);
  x33 = (x8) ^ (x32);
  x34 = (x33) & (a2);
  x35 = (x34) ^ (x31);
  x36 = (x35) | (a5);
  x37 = (x36) ^ (x29);
  *out1 = x37;
  x38 = (x10) & (a3);
  x39 = (x4) | (x38);
  x40 = (x33) & (a3);
  x41 = (x25) ^ (x40);
  x42 = (x41) | (a2);
  x43 = (x42) ^ (x39);
  x44 = (x26) | (a3);
  x45 = (x14) ^ (x44);
  x46 = (x8) | (a1);
  x47 = (x20) ^ (x46);
  x48 = (x47) | (a2);
  x49 = (x48) ^ (x45);
  x50 = (x49) & (a5);
  x51 = (x50) ^ (x43);
  *out2 = x51;
  x52 = (x40) ^ (x8);
  x53 = (x11) ^ (a3);
  x54 = (x5) & (x53);
  x55 = (x54) | (a2);
  x56 = (x55) ^ (x52);
  x57 = (x4) | (a6);
  x58 = (x38) ^ (x57);
  x59 = (x56) & (x13);
  x60 = (x59) & (a2);
  x61 = (x60) ^ (x58);
  x62 = (x61) & (a5);
  x63 = (x62) ^ (x56);
  *out3 = x63;
}


void main__ (unsigned long a[6],unsigned long b[4]) {

  f__(a[0],a[1],a[2],a[3],a[4],a[5],&b[0],&b[1],&b[2],&b[3]);
}


int main() { return 0; }