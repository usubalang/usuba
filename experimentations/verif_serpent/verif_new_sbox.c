
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

#define NO_RUNTIME
#ifndef BITS_PER_REG
#define BITS_PER_REG 32
#endif
/* including the architecture specific .h */
#include "STD.h"

/* auxiliary functions */
void sbox__0__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t17;


  // Instructions (body)
  t01 = XOR(b,c);
  t02 = OR(a,d);
  t03 = XOR(a,b);
  *z = XOR(t02,t01);
  t05 = OR(c,*z);
  t06 = XOR(a,d);
  t07 = OR(b,c);
  t08 = AND(d,t05);
  t09 = AND(t03,t07);
  *y = XOR(t09,t08);
  t11 = AND(t09,*y);
  t12 = XOR(c,d);
  t13 = XOR(t07,t11);
  t14 = AND(b,t06);
  t15 = XOR(t06,t13);
  *w = NOT(t15);
  t17 = XOR(*w,t14);
  *x = XOR(t12,t17);

}

void sbox__1__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t16;
  DATATYPE t17;


  // Instructions (body)
  t01 = OR(a,d);
  t02 = XOR(c,d);
  t03 = NOT(b);
  t04 = XOR(a,c);
  t05 = OR(a,t03);
  t06 = AND(d,t04);
  t07 = AND(t01,t02);
  t08 = OR(b,t06);
  *y = XOR(t02,t05);
  t10 = XOR(t07,t08);
  t11 = XOR(t01,t10);
  t12 = XOR(*y,t11);
  t13 = AND(b,d);
  *z = NOT(t10);
  *x = XOR(t13,t12);
  t16 = OR(t10,*x);
  t17 = AND(t05,t16);
  *w = XOR(c,t17);

}

void sbox__2__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;


  // Instructions (body)
  t01 = OR(a,c);
  t02 = XOR(a,b);
  t03 = XOR(d,t01);
  *w = XOR(t02,t03);
  t05 = XOR(c,*w);
  t06 = XOR(b,t05);
  t07 = OR(b,t05);
  t08 = AND(t01,t06);
  t09 = XOR(t03,t07);
  t10 = OR(t02,t09);
  *x = XOR(t10,t08);
  t12 = OR(a,d);
  t13 = XOR(t09,*x);
  t14 = XOR(b,t13);
  *z = NOT(t09);
  *y = XOR(t12,t14);

}

void sbox__3__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;


  // Instructions (body)
  t01 = XOR(a,c);
  t02 = OR(a,d);
  t03 = AND(a,d);
  t04 = AND(t01,t02);
  t05 = OR(b,t03);
  t06 = AND(a,b);
  t07 = XOR(d,t04);
  t08 = OR(c,t06);
  t09 = XOR(b,t07);
  t10 = AND(d,t05);
  t11 = XOR(t02,t10);
  *z = XOR(t08,t09);
  t13 = OR(d,*z);
  t14 = OR(a,t07);
  t15 = AND(b,t13);
  *y = XOR(t08,t11);
  *w = XOR(t14,t15);
  *x = XOR(t05,t04);

}

void sbox__4__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t16;


  // Instructions (body)
  t01 = OR(a,b);
  t02 = OR(b,c);
  t03 = XOR(a,t02);
  t04 = XOR(b,d);
  t05 = OR(d,t03);
  t06 = AND(d,t01);
  *z = XOR(t03,t06);
  t08 = AND(*z,t04);
  t09 = AND(t04,t05);
  t10 = XOR(c,t06);
  t11 = AND(b,c);
  t12 = XOR(t04,t08);
  t13 = OR(t11,t03);
  t14 = XOR(t10,t09);
  t15 = AND(a,t05);
  t16 = OR(t11,t12);
  *y = XOR(t13,t08);
  *x = XOR(t15,t16);
  *w = NOT(t14);

}

void sbox__5__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t14;


  // Instructions (body)
  t01 = XOR(b,d);
  t02 = OR(b,d);
  t03 = AND(a,t01);
  t04 = XOR(c,t02);
  t05 = XOR(t03,t04);
  *w = NOT(t05);
  t07 = XOR(a,t01);
  t08 = OR(d,*w);
  t09 = OR(b,t05);
  t10 = XOR(d,t08);
  t11 = OR(b,t07);
  t12 = OR(t03,*w);
  t13 = OR(t07,t10);
  t14 = XOR(t01,t11);
  *y = XOR(t09,t13);
  *x = XOR(t07,t08);
  *z = XOR(t12,t14);

}

void sbox__6__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t07;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t12;
  DATATYPE t13;
  DATATYPE t15;
  DATATYPE t17;
  DATATYPE t18;


  // Instructions (body)
  t01 = AND(a,d);
  t02 = XOR(b,c);
  t03 = XOR(a,d);
  t04 = XOR(t01,t02);
  t05 = OR(b,c);
  *x = NOT(t04);
  t07 = AND(t03,t05);
  t08 = AND(b,*x);
  t09 = OR(a,c);
  t10 = XOR(t07,t08);
  t11 = OR(b,d);
  t12 = XOR(c,t11);
  t13 = XOR(t09,t10);
  *y = NOT(t13);
  t15 = AND(*x,t03);
  *z = XOR(t12,t07);
  t17 = XOR(a,b);
  t18 = XOR(*y,t15);
  *w = XOR(t17,t18);

}

void sbox__7__ (/*inputs*/ DATATYPE a,DATATYPE b,DATATYPE c,DATATYPE d, /*outputs*/ DATATYPE* w,DATATYPE* x,DATATYPE* y,DATATYPE* z) {
  
  // Variables declaration
  DATATYPE t01;
  DATATYPE t02;
  DATATYPE t03;
  DATATYPE t04;
  DATATYPE t05;
  DATATYPE t06;
  DATATYPE t08;
  DATATYPE t09;
  DATATYPE t10;
  DATATYPE t11;
  DATATYPE t13;
  DATATYPE t14;
  DATATYPE t15;
  DATATYPE t16;
  DATATYPE t17;


  // Instructions (body)
  t01 = AND(a,c);
  t02 = NOT(d);
  t03 = AND(a,t02);
  t04 = OR(b,t01);
  t05 = AND(a,b);
  t06 = XOR(c,t04);
  *z = XOR(t03,t06);
  t08 = OR(c,*z);
  t09 = OR(d,t05);
  t10 = XOR(a,t08);
  t11 = AND(t04,*z);
  *x = XOR(t09,t10);
  t13 = XOR(b,*x);
  t14 = XOR(t01,*x);
  t15 = XOR(c,t05);
  t16 = OR(t11,t13);
  t17 = OR(t02,t14);
  *w = XOR(t15,t17);
  *y = XOR(a,t16);

}

void S0(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r3 ^= r0;
  r4 = r1; 
  r1 &= r3;
  r4 ^= r2;
  r1 ^= r0;
  r0 |= r3;
  r0 ^= r4;
  r4 ^= r3;
  r3 ^= r2;
  r2 |= r1;
  r2 ^= r4;
  r4 = ~r4; 
  r4 |= r1;
  r1 ^= r3;
  r1 ^= r4;
  r3 |= r0;
  r1 ^= r3;
  r4 ^= r3;
  *r5 = r1;
  *r6 = r4;
  *r7 = r2;
  *r8 = r0;
}
void S1(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r0 = ~r0;  
  r2 = ~r2;
  r4 = r0; 
  r0 &= r1;
  r2 ^= r0;
  r0 |= r3;
  r3 ^= r2;
  r1 ^= r0;
  r0 ^= r4;
  r4 |= r1;
  r1 ^= r3;
  r2 |= r0;
  r2 &= r4;
  r0 ^= r1;
  r1 &= r2;
  r1 ^= r0;
  r0 &= r2;
  r0 ^= r4;
  *r5 = r2;
  *r6 = r0;
  *r7 = r3;
  *r8 = r1;
}
void S2(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r4 = r0;
  r0 &= r2; 
  r0 ^= r3; 
  r2 ^= r1; 
  r2 ^= r0; 
  r3 |= r4; 
  r3 ^= r1; 
  r4 ^= r2; 
  r1 = r3;  
  r3 |= r4; 
  r3 ^= r0; 
  r0 &= r1; 
  r4 ^= r0; 
  r1 ^= r3; 
  r1 ^= r4; 
  r4 = ~r4; 
  *r5 = r2;
  *r6 = r3;
  *r7 = r1;
  *r8 = r4;
}
void S3(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
        DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r4 = r0; 
  r0 |= r3;
  r3 ^= r1;
  r1 &= r4;
  r4 ^= r2;
  r2 ^= r3;
  r3 &= r0;
  r4 |= r1;
  r3 ^= r4;
  r0 ^= r1;
  r4 &= r0;
  r1 ^= r3;
  r4 ^= r2;
  r1 |= r0;
  r1 ^= r2;
  r0 ^= r3;
  r2 = r1; 
  r1 |= r3;
  r1 ^= r0;
  *r5 = r1;
  *r6 = r2;
  *r7 = r3;
  *r8 = r4;
}
void S4(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r1 ^= r3;
  r3 = ~r3;
  r2 ^= r3;
  r3 ^= r0;
  r4 = r1; 
  r1 &= r3;
  r1 ^= r2;
  r4 ^= r3;
  r0 ^= r4;
  r2 &= r4;
  r2 ^= r0;
  r0 &= r1;
  r3 ^= r0;
  r4 |= r1;
  r4 ^= r0;
  r0 |= r3;
  r0 ^= r2;
  r2 &= r3;
  r0 = ~r0;
  r4 ^= r2;
  *r5 = r1;
  *r6 = r4;
  *r7 = r0;
  *r8 = r3;
}
void S5(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
   DATATYPE r4;
   r0 ^= r1;
   r1 ^= r3;
   r3 = ~r3;
   r4 = r1; 
   r1 &= r0;
   r2 ^= r3;
   r1 ^= r2;
   r2 |= r4;
   r4 ^= r3;
   r3 &= r1;
   r3 ^= r0;
   r4 ^= r1;
   r4 ^= r2;
   r2 ^= r0;
   r0 &= r3;
   r2 = ~r2;
   r0 ^= r4;
   r4 |= r3;
   r2 ^= r4;
  *r5 = r1;
  *r6 = r3;
  *r7 = r0;
  *r8 = r2;
}
void S6(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
   DATATYPE r4;
   r2 = ~r2; 
   r4 = r3; 
   r3 &= r0;
   r0 ^= r4;
   r3 ^= r2;
   r2 |= r4;
   r1 ^= r3;
   r2 ^= r0;
   r0 |= r1;
   r2 ^= r1;
   r4 ^= r0;
   r0 |= r3;
   r0 ^= r2;
   r4 ^= r3;
   r4 ^= r0;
   r3 = ~r3;
   r2 &= r4;
   r2 ^= r3;
  *r5 = r0;
  *r6 = r1;
  *r7 = r4;
  *r8 = r2;
}
void S7(DATATYPE r0, DATATYPE r1, DATATYPE r2, DATATYPE r3,
               DATATYPE* r5, DATATYPE* r6, DATATYPE* r7, DATATYPE* r8) {
  DATATYPE r4;
  r4 = r1;
  r1 |= r2;
  r1 ^= r3;
  r4 ^= r2;
  r2 ^= r1;
  r3 |= r4;
  r3 &= r0;
  r4 ^= r2;
  r3 ^= r1;
  r1 |= r4;
  r1 ^= r0;
  r0 |= r4;
  r0 ^= r2;
  r1 ^= r4;
  r2 ^= r1;
  r1 &= r0;
  r1 ^= r4;
  r2 = ~r2;
  r2 |= r0;
  r4 ^= r2;
  *r5 = r4;
  *r6 = r3;
  *r7 = r1;
  *r8 = r0;
}


#define D DATATYPE

void check_eq (void (*old)(D,D,D,D,D*,D*,D*,D*),
               void (*new)(D,D,D,D,D*,D*,D*,D*),
               char* name) {
  for (D r0 = 0; r0 <= 1; r0++)
    for (D r1 = 0; r1 <= 1; r1++)
      for (D r2 = 0; r2 <= 1; r2++)
        for (D r3 = 0; r3 <= 1; r3++) {
          D a0, a1, a2, a3,
            b0, b1, b2, b3;
          (*old)(r0,r1,r2,r3,&a0,&a1,&a2,&a3);
          (*new)(r0,r1,r2,r3,&b0,&b1,&b2,&b3);
          if (a0 != b0 || a1 != b1 || a2 != b2 || a3 != b3) {
            printf("Error: %s: %d%d%d%d -- %d%d%d%d\n",
                          name,a0&1,a1&1,a2&1,a3&1,b0&1,b1&1,b2&1,b3&1);
          }
        }
}
  
int main() {

  check_eq(&S0,&sbox__0__,"SBOX-0");
  check_eq(&S1,&sbox__1__,"SBOX-1");
  check_eq(&S2,&sbox__2__,"SBOX-2");
  check_eq(&S3,&sbox__3__,"SBOX-3");
  check_eq(&S4,&sbox__4__,"SBOX-4");
  check_eq(&S5,&sbox__5__,"SBOX-5");
  check_eq(&S6,&sbox__6__,"SBOX-6");
  check_eq(&S7,&sbox__7__,"SBOX-7");
    
  
  return 0;
}
