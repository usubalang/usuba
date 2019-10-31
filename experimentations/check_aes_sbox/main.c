#include <stdio.h>
#include <stdlib.h>

#include "FAME.h"

#if FD == 1
int fault_flags = 0; /* no redundancy -> no fault check */
#elif FD == 2
int fault_flags = 0x00000000;
#elif FD == 4 && !defined(CORRECT)
int fault_flags = 0x00000000;
#elif FD == 4 && defined(CORRECT)
int fault_flags = 0xff00ff00;
#endif

#ifdef X86
#define assert_eq(a,b) if (!(a == b)) {                                 \
    fprintf(stderr,"Assert failed line %d: %d != %d.\n",__LINE__,a,b);  \
    exit(EXIT_FAILURE);                                                 \
  }
#else
#define assert_eq(a,b) if (!(a == b)) {                                 \
    printf("Assert failed line %x: %x != %x.\n",__LINE__,a,b);  \
    exit(EXIT_FAILURE);                                                 \
  }

#endif

void sbox__ (/*inputs*/ DATATYPE U0,DATATYPE U1,DATATYPE U2,DATATYPE U3,DATATYPE U4,DATATYPE U5,DATATYPE U6,DATATYPE U7, /*outputs*/ DATATYPE* S0,DATATYPE* S1,DATATYPE* S2,DATATYPE* S3,DATATYPE* S4,DATATYPE* S5,DATATYPE* S6,DATATYPE* S7);

unsigned int table[] = {
    99, 124, 119, 123, 242, 107, 111, 197, 48, 1, 103, 43, 254, 215, 171, 118,
    202, 130, 201, 125, 250, 89, 71, 240, 173, 212, 162, 175, 156, 164, 114, 192,
    183, 253, 147, 38, 54, 63, 247, 204, 52, 165, 229, 241, 113, 216, 49, 21,
    4, 199, 35, 195, 24, 150, 5, 154, 7, 18, 128, 226, 235, 39, 178, 117,
    9, 131, 44, 26, 27, 110, 90, 160, 82, 59, 214, 179, 41, 227, 47, 132,
    83, 209, 0, 237, 32, 252, 177, 91, 106, 203, 190, 57, 74, 76, 88, 207,
    208, 239, 170, 251, 67, 77, 51, 133, 69, 249, 2, 127, 80, 60, 159, 168,
    81, 163, 64, 143, 146, 157, 56, 245, 188, 182, 218, 33, 16, 255, 243, 210,
    205, 12, 19, 236, 95, 151, 68, 23, 196, 167, 126, 61, 100, 93, 25, 115,
    96, 129, 79, 220, 34, 42, 144, 136, 70, 238, 184, 20, 222, 94, 11, 219,
    224, 50, 58, 10, 73, 6, 36, 92, 194, 211, 172, 98, 145, 149, 228, 121,
    231, 200, 55, 109, 141, 213, 78, 169, 108, 86, 244, 234, 101, 122, 174, 8,
    186, 120, 37, 46, 28, 166, 180, 198, 232, 221, 116, 31, 75, 189, 139, 138,
    112, 62, 181, 102, 72, 3, 246, 14, 97, 53, 87, 185, 134, 193, 29, 158,
    225, 248, 152, 17, 105, 217, 142, 148, 155, 30, 135, 233, 206, 85, 40, 223,
    140, 161, 137, 13, 191, 230, 66, 104, 65, 153, 45, 15, 176, 84, 187, 22
};


#define FOR(x) for (DATATYPE x = 0; x <= 1; x++)
#define BITS_TO_INT8(a,b,c,d,e,f,g,h) ((h&1) | ((g&1)<<1) | ((f&1)<<2) | ((e&1)<<3) \
                                       | ((d&1)<<4) | ((c&1)<<5) | ((b&1)<<6) | ((a&1)<<7))
#define LIST8(x) x##0, x##1, x##2, x##3, x##4, x##5, x##6, x##7
#define MAP(f,id)                                                       \
  DATATYPE id##2_0 = f(id##0), id##2_1 = f(id##1), id##2_2 = f(id##2), id##2_3 = f(id##3), \
    id##2_4 = f(id##4), id##2_5 = f(id##5), id##2_6 = f(id##6), id##2_7 = f(id##7);

int bit_to_reg(int b) {
#if TI == 2
  int r = RAND() & 1;
  b = (r << 1) | (b ^ r);
#elif TI == 4
  int r1 = RAND() & 1, r2 = RAND() & 1, r3 = RAND() & 1;
  b = (r3 << 3) | (r2 << 2) | (r1 << 1) | (r1 ^ r2 ^ r3 ^ b);
#endif
#if FD == 1
  return b;
#elif FD == 2
  return b | (~b << 16);
#elif FD == 4
  return b | ((~b&0xff) << 8) | (b << 16) | ((~b&0xff) << 24);
#endif
}

int reg_to_bit(int r) {
#if TI == 1
  return r & 1;
#elif TI == 2
  int b1 = (r >> 1) & 1, b2 = r & 1;
  return b1 ^ b2;
#elif TI == 4
  int b1 = (r >> 3) & 1, b2 = (r >> 2) & 1, b3 = (r >> 1) & 1, b4 = r & 1;
  return b1 ^ b2 ^ b3 ^ b4;
#endif
}

void verif() {
  FOR(a0) FOR(a1) FOR(a2) FOR(a3) FOR(a4) FOR(a5) FOR(a6) FOR(a7) {
    DATATYPE LIST8(out);
    MAP(bit_to_reg,a);
    MAP(reg_to_bit,a2_);
    assert_eq(a0,a2_2_0); assert_eq(a1,a2_2_1); assert_eq(a2,a2_2_2); assert_eq(a3,a2_2_3);
    assert_eq(a4,a2_2_4); assert_eq(a5,a2_2_5); assert_eq(a6,a2_2_6); assert_eq(a7,a2_2_7);

    int fault_flags_before = fault_flags;
    sbox__(LIST8(a2_),LIST8(&out));
    MAP(reg_to_bit,out);

    DATATYPE in  = BITS_TO_INT8(a0,a1,a2,a3,a4,a5,a6,a7);
    DATATYPE out = BITS_TO_INT8(out2_0,out2_1,out2_2,out2_3,out2_4,out2_5,out2_6,out2_7);
    assert_eq(table[in], out);
    assert_eq(fault_flags, fault_flags_before);
  }
}

int main() {
  verif();
  printf("Sbox seems correct.\n");
}
