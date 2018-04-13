#include <stdlib.h>
#include <string.h>
#include <stdio.h>


int makeKey(const char* keyMaterial, unsigned int key[33][4]);



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



#define ROL(x,n) ((((unsigned int)(x))<<(n))| \
                  (((unsigned int)(x))>>(32-(n))))
#define PHI 0x9e3779b9
#define min(x,y) (((x)<(y))?(x):(y))
int serpent_convert_from_string(int len, const char *str, unsigned int *val);

int makeKey(const char* keyMaterial, unsigned int key[33][4]) {
  unsigned int i,j;
  unsigned int w[132],k[132];
  unsigned int key_int[8];

  int keyLen = 256;

  for (int i = 0; i < 8; i++)
    key_int[i] = (unsigned int)keyMaterial[i*4];

  for(i=0; i<keyLen/32; i++)
    w[i]=key_int[i];
  if(keyLen<256)
    w[i]=(key_int[i]&((1L<<((keyLen&31)))-1))|(1L<<((keyLen&31)));
  for(i++; i<8; i++)
    w[i]=0;
  for(i=8; i<16; i++)
    w[i]=ROL(w[i-8]^w[i-5]^w[i-3]^w[i-1]^PHI^(i-8),11);
  for(i=0; i<8; i++)
    w[i]=w[i+8];
  for(i=8; i<132; i++)
    w[i]=ROL(w[i-8]^w[i-5]^w[i-3]^w[i-1]^PHI^i,11);

    
  sbox__3(w[  0], w[  1], w[  2], w[  3], &k[  0], &k[  1], &k[  2], &k[  3]);
  sbox__2(w[  4], w[  5], w[  6], w[  7], &k[  4], &k[  5], &k[  6], &k[  7]);
  sbox__1(w[  8], w[  9], w[ 10], w[ 11], &k[  8], &k[  9], &k[ 10], &k[ 11]);
  sbox__0(w[ 12], w[ 13], w[ 14], w[ 15], &k[ 12], &k[ 13], &k[ 14], &k[ 15]);
  sbox__7(w[ 16], w[ 17], w[ 18], w[ 19], &k[ 16], &k[ 17], &k[ 18], &k[ 19]);
  sbox__6(w[ 20], w[ 21], w[ 22], w[ 23], &k[ 20], &k[ 21], &k[ 22], &k[ 23]);
  sbox__5(w[ 24], w[ 25], w[ 26], w[ 27], &k[ 24], &k[ 25], &k[ 26], &k[ 27]);
  sbox__4(w[ 28], w[ 29], w[ 30], w[ 31], &k[ 28], &k[ 29], &k[ 30], &k[ 31]);
  sbox__3(w[ 32], w[ 33], w[ 34], w[ 35], &k[ 32], &k[ 33], &k[ 34], &k[ 35]);
  sbox__2(w[ 36], w[ 37], w[ 38], w[ 39], &k[ 36], &k[ 37], &k[ 38], &k[ 39]);
  sbox__1(w[ 40], w[ 41], w[ 42], w[ 43], &k[ 40], &k[ 41], &k[ 42], &k[ 43]);
  sbox__0(w[ 44], w[ 45], w[ 46], w[ 47], &k[ 44], &k[ 45], &k[ 46], &k[ 47]);
  sbox__7(w[ 48], w[ 49], w[ 50], w[ 51], &k[ 48], &k[ 49], &k[ 50], &k[ 51]);
  sbox__6(w[ 52], w[ 53], w[ 54], w[ 55], &k[ 52], &k[ 53], &k[ 54], &k[ 55]);
  sbox__5(w[ 56], w[ 57], w[ 58], w[ 59], &k[ 56], &k[ 57], &k[ 58], &k[ 59]);
  sbox__4(w[ 60], w[ 61], w[ 62], w[ 63], &k[ 60], &k[ 61], &k[ 62], &k[ 63]);
  sbox__3(w[ 64], w[ 65], w[ 66], w[ 67], &k[ 64], &k[ 65], &k[ 66], &k[ 67]);
  sbox__2(w[ 68], w[ 69], w[ 70], w[ 71], &k[ 68], &k[ 69], &k[ 70], &k[ 71]);
  sbox__1(w[ 72], w[ 73], w[ 74], w[ 75], &k[ 72], &k[ 73], &k[ 74], &k[ 75]);
  sbox__0(w[ 76], w[ 77], w[ 78], w[ 79], &k[ 76], &k[ 77], &k[ 78], &k[ 79]);
  sbox__7(w[ 80], w[ 81], w[ 82], w[ 83], &k[ 80], &k[ 81], &k[ 82], &k[ 83]);
  sbox__6(w[ 84], w[ 85], w[ 86], w[ 87], &k[ 84], &k[ 85], &k[ 86], &k[ 87]);
  sbox__5(w[ 88], w[ 89], w[ 90], w[ 91], &k[ 88], &k[ 89], &k[ 90], &k[ 91]);
  sbox__4(w[ 92], w[ 93], w[ 94], w[ 95], &k[ 92], &k[ 93], &k[ 94], &k[ 95]);
  sbox__3(w[ 96], w[ 97], w[ 98], w[ 99], &k[ 96], &k[ 97], &k[ 98], &k[ 99]);
  sbox__2(w[100], w[101], w[102], w[103], &k[100], &k[101], &k[102], &k[103]);
  sbox__1(w[104], w[105], w[106], w[107], &k[104], &k[105], &k[106], &k[107]);
  sbox__0(w[108], w[109], w[110], w[111], &k[108], &k[109], &k[110], &k[111]);
  sbox__7(w[112], w[113], w[114], w[115], &k[112], &k[113], &k[114], &k[115]);
  sbox__6(w[116], w[117], w[118], w[119], &k[116], &k[117], &k[118], &k[119]);
  sbox__5(w[120], w[121], w[122], w[123], &k[120], &k[121], &k[122], &k[123]);
  sbox__4(w[124], w[125], w[126], w[127], &k[124], &k[125], &k[126], &k[127]);
  sbox__3(w[128], w[129], w[130], w[131], &k[128], &k[129], &k[130], &k[131]);

  //for (int i = 0; i < 8; i++) printf("%016lX\n", k[i]);
  
  
  for(i=0; i<=32; i++)
    for(j=0; j<4; j++)
      key[i][j] = k[4*i+j];

  return 1;
}
