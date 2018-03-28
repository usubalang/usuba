
#pragma push_macro("AND")
#undef AND
#define AND(a,b) ((a) & (b))
#pragma push_macro("OR")
#undef OR
#define OR(a,b)   ((a) | (b))
#pragma push_macro("XOR")
#undef XOR
#define XOR(a,b)  ((a) ^ (b))
#pragma push_macro("ANDN")
#undef ANDN
#define ANDN(a,b) (~(a) & (b))
#pragma push_macro("NOT")
#undef NOT
#define NOT(a)    (~(a))

/* auxiliary functions */
void sbox__0 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t05;
  unsigned int t06;
  unsigned int t07;
  unsigned int t08;
  unsigned int t09;
  unsigned int t11;
  unsigned int t12;
  unsigned int t13;
  unsigned int t14;
  unsigned int t15;
  unsigned int t17;


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

void sbox__1 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t04;
  unsigned int t05;
  unsigned int t06;
  unsigned int t07;
  unsigned int t08;
  unsigned int t10;
  unsigned int t11;
  unsigned int t12;
  unsigned int t13;
  unsigned int t16;
  unsigned int t17;


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

void sbox__2 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t05;
  unsigned int t06;
  unsigned int t07;
  unsigned int t08;
  unsigned int t09;
  unsigned int t10;
  unsigned int t12;
  unsigned int t13;
  unsigned int t14;


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

void sbox__3 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t04;
  unsigned int t05;
  unsigned int t06;
  unsigned int t07;
  unsigned int t08;
  unsigned int t09;
  unsigned int t10;
  unsigned int t11;
  unsigned int t13;
  unsigned int t14;
  unsigned int t15;


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

void sbox__4 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t04;
  unsigned int t05;
  unsigned int t06;
  unsigned int t08;
  unsigned int t09;
  unsigned int t10;
  unsigned int t11;
  unsigned int t12;
  unsigned int t13;
  unsigned int t14;
  unsigned int t15;
  unsigned int t16;


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

void sbox__5 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t04;
  unsigned int t05;
  unsigned int t07;
  unsigned int t08;
  unsigned int t09;
  unsigned int t10;
  unsigned int t11;
  unsigned int t12;
  unsigned int t13;
  unsigned int t14;


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

void sbox__6 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t04;
  unsigned int t05;
  unsigned int t07;
  unsigned int t08;
  unsigned int t09;
  unsigned int t10;
  unsigned int t11;
  unsigned int t12;
  unsigned int t13;
  unsigned int t15;
  unsigned int t17;
  unsigned int t18;


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

void sbox__7 (/*inputs*/ unsigned int a,unsigned int b,unsigned int c,unsigned int d, /*outputs*/ unsigned int* w,unsigned int* x,unsigned int* y,unsigned int* z) {
  
  // Variables declaration
  unsigned int t01;
  unsigned int t02;
  unsigned int t03;
  unsigned int t04;
  unsigned int t05;
  unsigned int t06;
  unsigned int t08;
  unsigned int t09;
  unsigned int t10;
  unsigned int t11;
  unsigned int t13;
  unsigned int t14;
  unsigned int t15;
  unsigned int t16;
  unsigned int t17;


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

#pragma pop_macro("AND")
#pragma pop_macro("OR")
#pragma pop_macro("XOR")
#pragma pop_macro("ANDN")
#pragma pop_macro("NOT")
