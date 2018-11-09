/* *************************************************************** *\
 * I got this bitsliced DES implementation on Matthew Kwan's blog:
 * http://www.darkside.com.au/bitslice/
 * 
 * I reworked a bit the code: added the includes, and changed 
 * unsigned long to DATATYPE, renamed some functions.
 * I also changed the index in aes__ : the "63-" are mine.
\* *************************************************************** */

#define NO_RUNTIME
#ifdef STD
#include "STD.h"
#elif defined(SSE)
#include "SSE.h"
#elif defined(AVX)
#include "AVX.h"
#else
#error You need to define STD, SSE or AVX.
#endif


/*
 * Generated S-box files.
 *
 * Produced by Matthew Kwan - March 1998
 */


static void
s1 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
  
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54, x55, x56;
	DATATYPE	x57, x58, x59, x60, x61, x62, x63;

	x1 = NOT(a4);
	x2 = NOT(a1);
	x3 = XOR(a4,a3);
	x4 = XOR(x3,x2);
	x5 = OR(a3,x2);
	x6 = AND(x5,x1);
	x7 = OR(a6,x6);
	x8 = XOR(x4,x7);
	x9 = OR(x1,x2);
	x10 = AND(a6,x9);
	x11 = XOR(x7,x10);
	x12 = OR(a2,x11);
	x13 = XOR(x8,x12);
	x14 = XOR(x9,x13);
	x15 = OR(a6,x14);
	x16 = XOR(x1,x15);
	x17 = NOT(x14);
	x18 = AND(x17,x3);
	x19 = OR(a2,x18);
	x20 = XOR(x16,x19);
	x21 = OR(a5,x20);
	x22 = XOR(x13,x21);
	*out4 = XOR(*out4,x22);
	x23 = OR(a3,x4);
	x24 = NOT(x23);
	x25 = OR(a6,x24);
	x26 = XOR(x6,x25);
	x27 = AND(x1,x8);
	x28 = OR(a2,x27);
	x29 = XOR(x26,x28);
	x30 = OR(x1,x8);
	x31 = XOR(x30,x6);
	x32 = AND(x5,x14);
	x33 = XOR(x32,x8);
	x34 = AND(a2,x33);
	x35 = XOR(x31,x34);
	x36 = OR(a5,x35);
	x37 = XOR(x29,x36);
	*out1 = XOR(*out1,x37);
	x38 = AND(a3,x10);
	x39 = OR(x38,x4);
	x40 = AND(a3,x33);
	x41 = XOR(x40,x25);
	x42 = OR(a2,x41);
	x43 = XOR(x39,x42);
	x44 = OR(a3,x26);
	x45 = XOR(x44,x14);
	x46 = OR(a1,x8);
	x47 = XOR(x46,x20);
	x48 = OR(a2,x47);
	x49 = XOR(x45,x48);
	x50 = AND(a5,x49);
	x51 = XOR(x43,x50);
	*out2 = XOR(*out2,x51);
	x52 = XOR(x8,x40);
	x53 = XOR(a3,x11);
	x54 = AND(x53,x5);
	x55 = OR(a2,x54);
	x56 = XOR(x52,x55);
	x57 = OR(a6,x4);
	x58 = XOR(x57,x38);
	x59 = AND(x13,x56);
	x60 = AND(a2,x59);
	x61 = XOR(x58,x60);
	x62 = AND(a5,x61);
	x63 = XOR(x56,x62);
	*out3 = XOR(*out3,x63);
}


static void
s2 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54, x55, x56;

	x1 = NOT(a5);
	x2 = NOT(a1);
	x3 = XOR(a5,a6);
	x4 = XOR(x3,x2);
	x5 = XOR(x4,a2);
	x6 = OR(a6,x1);
	x7 = OR(x6,x2);
	x8 = AND(a2,x7);
	x9 = XOR(a6,x8);
	x10 = AND(a3,x9);
	x11 = XOR(x5,x10);
	x12 = AND(a2,x9);
	x13 = XOR(a5,x6);
	x14 = OR(a3,x13);
	x15 = XOR(x12,x14);
	x16 = AND(a4,x15);
	x17 = XOR(x11,x16);
	*out2 = XOR(*out2,x17);
	x18 = OR(a5,a1);
	x19 = OR(a6,x18);
	x20 = XOR(x13,x19);
	x21 = XOR(x20,a2);
	x22 = OR(a6,x4);
	x23 = AND(x22,x17);
	x24 = OR(a3,x23);
	x25 = XOR(x21,x24);
	x26 = OR(a6,x2);
	x27 = AND(a5,x2);
	x28 = OR(a2,x27);
	x29 = XOR(x26,x28);
	x30 = XOR(x3,x27);
	x31 = XOR(x2,x19);
	x32 = AND(a2,x31);
	x33 = XOR(x30,x32);
	x34 = AND(a3,x33);
	x35 = XOR(x29,x34);
	x36 = OR(a4,x35);
	x37 = XOR(x25,x36);
	*out3 = XOR(*out3,x37);
	x38 = AND(x21,x32);
	x39 = XOR(x38,x5);
	x40 = OR(a1,x15);
	x41 = XOR(x40,x13);
	x42 = OR(a3,x41);
	x43 = XOR(x39,x42);
	x44 = OR(x28,x41);
	x45 = AND(a4,x44);
	x46 = XOR(x43,x45);
	*out1 = XOR(*out1,x46);
	x47 = AND(x19,x21);
	x48 = XOR(x47,x26);
	x49 = AND(a2,x33);
	x50 = XOR(x49,x21);
	x51 = AND(a3,x50);
	x52 = XOR(x48,x51);
	x53 = AND(x18,x28);
	x54 = AND(x53,x50);
	x55 = OR(a4,x54);
	x56 = XOR(x52,x55);
	*out4 = XOR(*out4,x56);
}


static void
s3 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54, x55, x56;
	DATATYPE	x57;

	x1 = NOT(a5);
	x2 = NOT(a6);
	x3 = AND(a5,a3);
	x4 = XOR(x3,a6);
	x5 = AND(a4,x1);
	x6 = XOR(x4,x5);
	x7 = XOR(x6,a2);
	x8 = AND(a3,x1);
	x9 = XOR(a5,x2);
	x10 = OR(a4,x9);
	x11 = XOR(x8,x10);
	x12 = AND(x7,x11);
	x13 = XOR(a5,x11);
	x14 = OR(x13,x7);
	x15 = AND(a4,x14);
	x16 = XOR(x12,x15);
	x17 = AND(a2,x16);
	x18 = XOR(x11,x17);
	x19 = AND(a1,x18);
	x20 = XOR(x7,x19);
	*out4 = XOR(*out4,x20);
	x21 = XOR(a3,a4);
	x22 = XOR(x21,x9);
	x23 = OR(x2,x4);
	x24 = XOR(x23,x8);
	x25 = OR(a2,x24);
	x26 = XOR(x22,x25);
	x27 = XOR(a6,x23);
	x28 = OR(x27,a4);
	x29 = XOR(a3,x15);
	x30 = OR(x29,x5);
	x31 = OR(a2,x30);
	x32 = XOR(x28,x31);
	x33 = OR(a1,x32);
	x34 = XOR(x26,x33);
	*out1 = XOR(*out1,x34);
	x35 = XOR(a3,x9);
	x36 = OR(x35,x5);
	x37 = OR(x4,x29);
	x38 = XOR(x37,a4);
	x39 = OR(a2,x38);
	x40 = XOR(x36,x39);
	x41 = AND(a6,x11);
	x42 = OR(x41,x6);
	x43 = XOR(x34,x38);
	x44 = XOR(x43,x41);
	x45 = AND(a2,x44);
	x46 = XOR(x42,x45);
	x47 = OR(a1,x46);
	x48 = XOR(x40,x47);
	*out3 = XOR(*out3,x48);
	x49 = OR(x2,x38);
	x50 = XOR(x49,x13);
	x51 = XOR(x27,x28);
	x52 = OR(a2,x51);
	x53 = XOR(x50,x52);
	x54 = AND(x12,x23);
	x55 = AND(x54,x52);
	x56 = OR(a1,x55);
	x57 = XOR(x53,x56);
	*out2 = XOR(*out2,x57);
}


static void
s4 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42;

	x1 = NOT(a1);
	x2 = NOT(a3);
	x3 = OR(a1,a3);
	x4 = AND(a5,x3);
	x5 = XOR(x1,x4);
	x6 = OR(a2,a3);
	x7 = XOR(x5,x6);
	x8 = AND(a1,a5);
	x9 = XOR(x8,x3);
	x10 = AND(a2,x9);
	x11 = XOR(a5,x10);
	x12 = AND(a4,x11);
	x13 = XOR(x7,x12);
	x14 = XOR(x2,x4);
	x15 = AND(a2,x14);
	x16 = XOR(x9,x15);
	x17 = AND(x5,x14);
	x18 = XOR(a5,x2);
	x19 = OR(a2,x18);
	x20 = XOR(x17,x19);
	x21 = OR(a4,x20);
	x22 = XOR(x16,x21);
	x23 = AND(a6,x22);
	x24 = XOR(x13,x23);
	*out2 = XOR(*out2,x24);
	x25 = NOT(x13);
	x26 = OR(a6,x22);
	x27 = XOR(x25,x26);
	*out1 = XOR(*out1,x27);
	x28 = AND(a2,x11);
	x29 = XOR(x28,x17);
	x30 = XOR(a3,x10);
	x31 = XOR(x30,x19);
	x32 = AND(a4,x31);
	x33 = XOR(x29,x32);
	x34 = XOR(x25,x33);
	x35 = AND(a2,x34);
	x36 = XOR(x24,x35);
	x37 = OR(a4,x34);
	x38 = XOR(x36,x37);
	x39 = AND(a6,x38);
	x40 = XOR(x33,x39);
	*out4 = XOR(*out4,x40);
	x41 = XOR(x26,x38);
	x42 = XOR(x41,x40);
	*out3 = XOR(*out3,x42);
}


static void
s5 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54, x55, x56;
	DATATYPE	x57, x58, x59, x60, x61, x62;

	x1 = NOT(a6);
	x2 = NOT(a3);
	x3 = OR(x1,x2);
	x4 = XOR(x3,a4);
	x5 = AND(a1,x3);
	x6 = XOR(x4,x5);
	x7 = OR(a6,a4);
	x8 = XOR(x7,a3);
	x9 = OR(a3,x7);
	x10 = OR(a1,x9);
	x11 = XOR(x8,x10);
	x12 = AND(a5,x11);
	x13 = XOR(x6,x12);
	x14 = NOT(x4);
	x15 = AND(x14,a6);
	x16 = OR(a1,x15);
	x17 = XOR(x8,x16);
	x18 = OR(a5,x17);
	x19 = XOR(x10,x18);
	x20 = OR(a2,x19);
	x21 = XOR(x13,x20);
	*out3 = XOR(*out3,x21);
	x22 = OR(x2,x15);
	x23 = XOR(x22,a6);
	x24 = XOR(a4,x22);
	x25 = AND(a1,x24);
	x26 = XOR(x23,x25);
	x27 = XOR(a1,x11);
	x28 = AND(x27,x22);
	x29 = OR(a5,x28);
	x30 = XOR(x26,x29);
	x31 = OR(a4,x27);
	x32 = NOT(x31);
	x33 = OR(a2,x32);
	x34 = XOR(x30,x33);
	*out2 = XOR(*out2,x34);
	x35 = XOR(x2,x15);
	x36 = AND(a1,x35);
	x37 = XOR(x14,x36);
	x38 = XOR(x5,x7);
	x39 = AND(x38,x34);
	x40 = OR(a5,x39);
	x41 = XOR(x37,x40);
	x42 = XOR(x2,x5);
	x43 = AND(x42,x16);
	x44 = AND(x4,x27);
	x45 = AND(a5,x44);
	x46 = XOR(x43,x45);
	x47 = OR(a2,x46);
	x48 = XOR(x41,x47);
	*out1 = XOR(*out1,x48);
	x49 = AND(x24,x48);
	x50 = XOR(x49,x5);
	x51 = XOR(x11,x30);
	x52 = OR(x51,x50);
	x53 = AND(a5,x52);
	x54 = XOR(x50,x53);
	x55 = XOR(x14,x19);
	x56 = XOR(x55,x34);
	x57 = XOR(x4,x16);
	x58 = AND(x57,x30);
	x59 = AND(a5,x58);
	x60 = XOR(x56,x59);
	x61 = OR(a2,x60);
	x62 = XOR(x54,x61);
	*out4 = XOR(*out4,x62);
}


static void
s6 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54, x55, x56;
	DATATYPE	x57;

	x1 = NOT(a2);
	x2 = NOT(a5);
	x3 = XOR(a2,a6);
	x4 = XOR(x3,x2);
	x5 = XOR(x4,a1);
	x6 = AND(a5,a6);
	x7 = OR(x6,x1);
	x8 = AND(a5,x5);
	x9 = AND(a1,x8);
	x10 = XOR(x7,x9);
	x11 = AND(a4,x10);
	x12 = XOR(x5,x11);
	x13 = XOR(a6,x10);
	x14 = AND(x13,a1);
	x15 = AND(a2,a6);
	x16 = XOR(x15,a5);
	x17 = AND(a1,x16);
	x18 = XOR(x2,x17);
	x19 = OR(a4,x18);
	x20 = XOR(x14,x19);
	x21 = AND(a3,x20);
	x22 = XOR(x12,x21);
	*out2 = XOR(*out2,x22);
	x23 = XOR(a6,x18);
	x24 = AND(a1,x23);
	x25 = XOR(a5,x24);
	x26 = XOR(a2,x17);
	x27 = OR(x26,x6);
	x28 = AND(a4,x27);
	x29 = XOR(x25,x28);
	x30 = NOT(x26);
	x31 = OR(a6,x29);
	x32 = NOT(x31);
	x33 = AND(a4,x32);
	x34 = XOR(x30,x33);
	x35 = AND(a3,x34);
	x36 = XOR(x29,x35);
	*out4 = XOR(*out4,x36);
	x37 = XOR(x6,x34);
	x38 = AND(a5,x23);
	x39 = XOR(x38,x5);
	x40 = OR(a4,x39);
	x41 = XOR(x37,x40);
	x42 = OR(x16,x24);
	x43 = XOR(x42,x1);
	x44 = XOR(x15,x24);
	x45 = XOR(x44,x31);
	x46 = OR(a4,x45);
	x47 = XOR(x43,x46);
	x48 = OR(a3,x47);
	x49 = XOR(x41,x48);
	*out1 = XOR(*out1,x49);
	x50 = OR(x5,x38);
	x51 = XOR(x50,x6);
	x52 = AND(x8,x31);
	x53 = OR(a4,x52);
	x54 = XOR(x51,x53);
	x55 = AND(x30,x43);
	x56 = OR(a3,x55);
	x57 = XOR(x54,x56);
	*out3 = XOR(*out3,x57);
}


static void
s7 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54, x55, x56;
	DATATYPE	x57;

	x1 = NOT(a2);
	x2 = NOT(a5);
	x3 = AND(a2,a4);
	x4 = XOR(x3,a5);
	x5 = XOR(x4,a3);
	x6 = AND(a4,x4);
	x7 = XOR(x6,a2);
	x8 = AND(a3,x7);
	x9 = XOR(a1,x8);
	x10 = OR(a6,x9);
	x11 = XOR(x5,x10);
	x12 = AND(a4,x2);
	x13 = OR(x12,a2);
	x14 = OR(a2,x2);
	x15 = AND(a3,x14);
	x16 = XOR(x13,x15);
	x17 = XOR(x6,x11);
	x18 = OR(a6,x17);
	x19 = XOR(x16,x18);
	x20 = AND(a1,x19);
	x21 = XOR(x11,x20);
	*out1 = XOR(*out1,x21);
	x22 = OR(a2,x21);
	x23 = XOR(x22,x6);
	x24 = XOR(x23,x15);
	x25 = XOR(x5,x6);
	x26 = OR(x25,x12);
	x27 = OR(a6,x26);
	x28 = XOR(x24,x27);
	x29 = AND(x1,x19);
	x30 = AND(x23,x26);
	x31 = AND(a6,x30);
	x32 = XOR(x29,x31);
	x33 = OR(a1,x32);
	x34 = XOR(x28,x33);
	*out4 = XOR(*out4,x34);
	x35 = AND(a4,x16);
	x36 = OR(x35,x1);
	x37 = AND(a6,x36);
	x38 = XOR(x11,x37);
	x39 = AND(a4,x13);
	x40 = OR(a3,x7);
	x41 = XOR(x39,x40);
	x42 = OR(x1,x24);
	x43 = OR(a6,x42);
	x44 = XOR(x41,x43);
	x45 = OR(a1,x44);
	x46 = XOR(x38,x45);
	*out2 = XOR(*out2,x46);
	x47 = XOR(x8,x44);
	x48 = XOR(x6,x15);
	x49 = OR(a6,x48);
	x50 = XOR(x47,x49);
	x51 = XOR(x19,x44);
	x52 = XOR(a4,x25);
	x53 = AND(x52,x46);
	x54 = AND(a6,x53);
	x55 = XOR(x51,x54);
	x56 = OR(a1,x55);
	x57 = XOR(x50,x56);
	*out3 = XOR(*out3,x57);
}


static void
s8 (
	DATATYPE	a1,
	DATATYPE	a2,
	DATATYPE	a3,
	DATATYPE	a4,
	DATATYPE	a5,
	DATATYPE	a6,
	DATATYPE	*out1,
	DATATYPE	*out2,
	DATATYPE	*out3,
	DATATYPE	*out4
) {
	DATATYPE	x1, x2, x3, x4, x5, x6, x7, x8;
	DATATYPE	x9, x10, x11, x12, x13, x14, x15, x16;
	DATATYPE	x17, x18, x19, x20, x21, x22, x23, x24;
	DATATYPE	x25, x26, x27, x28, x29, x30, x31, x32;
	DATATYPE	x33, x34, x35, x36, x37, x38, x39, x40;
	DATATYPE	x41, x42, x43, x44, x45, x46, x47, x48;
	DATATYPE	x49, x50, x51, x52, x53, x54;

	x1 = NOT(a1);
	x2 = NOT(a4);
	x3 = XOR(a3,x1);
	x4 = OR(a3,x1);
	x5 = XOR(x4,x2);
	x6 = OR(a5,x5);
	x7 = XOR(x3,x6);
	x8 = OR(x1,x5);
	x9 = XOR(x2,x8);
	x10 = AND(a5,x9);
	x11 = XOR(x8,x10);
	x12 = AND(a2,x11);
	x13 = XOR(x7,x12);
	x14 = XOR(x6,x9);
	x15 = AND(x3,x9);
	x16 = AND(a5,x8);
	x17 = XOR(x15,x16);
	x18 = OR(a2,x17);
	x19 = XOR(x14,x18);
	x20 = OR(a6,x19);
	x21 = XOR(x13,x20);
	*out1 = XOR(*out1,x21);
	x22 = OR(a5,x3);
	x23 = AND(x22,x2);
	x24 = NOT(a3);
	x25 = AND(x24,x8);
	x26 = AND(a5,x4);
	x27 = XOR(x25,x26);
	x28 = OR(a2,x27);
	x29 = XOR(x23,x28);
	x30 = AND(a6,x29);
	x31 = XOR(x13,x30);
	*out4 = XOR(*out4,x31);
	x32 = XOR(x5,x6);
	x33 = XOR(x32,x22);
	x34 = OR(a4,x13);
	x35 = AND(a2,x34);
	x36 = XOR(x33,x35);
	x37 = AND(a1,x33);
	x38 = XOR(x37,x8);
	x39 = XOR(a1,x23);
	x40 = AND(x39,x7);
	x41 = AND(a2,x40);
	x42 = XOR(x38,x41);
	x43 = OR(a6,x42);
	x44 = XOR(x36,x43);
	*out3 = XOR(*out3,x44);
	x45 = XOR(a1,x10);
	x46 = XOR(x45,x22);
	x47 = NOT(x7);
	x48 = AND(x47,x8);
	x49 = OR(a2,x48);
	x50 = XOR(x46,x49);
	x51 = XOR(x19,x29);
	x52 = OR(x51,x38);
	x53 = AND(a6,x52);
	x54 = XOR(x50,x53);
	*out2 = XOR(*out2,x54);
}


/*
 * Bitslice implementation of DES.
 *
 * Checks that the plaintext bits p[0] .. p[63]
 * encrypt to the ciphertext bits c[0] .. c[63]
 * given the key bits k[0] .. k[55]
 */

void
des__ (
	const DATATYPE	*p,
	const DATATYPE	*k,
	DATATYPE	*c
) {
  
	DATATYPE	l0 = p[63-6];
	DATATYPE	l1 = p[63-14];
	DATATYPE	l2 = p[63-22];
	DATATYPE	l3 = p[63-30];
	DATATYPE	l4 = p[63-38];
	DATATYPE	l5 = p[63-46];
	DATATYPE	l6 = p[63-54];
	DATATYPE	l7 = p[63-62];
	DATATYPE	l8 = p[63-4];
	DATATYPE	l9 = p[63-12];
	DATATYPE	l10 = p[63-20];
	DATATYPE	l11 = p[63-28];
	DATATYPE	l12 = p[63-36];
	DATATYPE	l13 = p[63-44];
	DATATYPE	l14 = p[63-52];
	DATATYPE	l15 = p[63-60];
	DATATYPE	l16 = p[63-2];
	DATATYPE	l17 = p[63-10];
	DATATYPE	l18 = p[63-18];
	DATATYPE	l19 = p[63-26];
	DATATYPE	l20 = p[63-34];
	DATATYPE	l21 = p[63-42];
	DATATYPE	l22 = p[63-50];
	DATATYPE	l23 = p[63-58];
	DATATYPE	l24 = p[63-0];
	DATATYPE	l25 = p[63-8];
	DATATYPE	l26 = p[63-16];
	DATATYPE	l27 = p[63-24];
	DATATYPE	l28 = p[63-32];
	DATATYPE	l29 = p[63-40];
	DATATYPE	l30 = p[63-48];
	DATATYPE	l31 = p[63-56];
	DATATYPE	r0 = p[63-7];
	DATATYPE	r1 = p[63-15];
	DATATYPE	r2 = p[63-23];
	DATATYPE	r3 = p[63-31];
	DATATYPE	r4 = p[63-39];
	DATATYPE	r5 = p[63-47];
	DATATYPE	r6 = p[63-55];
	DATATYPE	r7 = p[63-63];
	DATATYPE	r8 = p[63-5];
	DATATYPE	r9 = p[63-13];
	DATATYPE	r10 = p[63-21];
	DATATYPE	r11 = p[63-29];
	DATATYPE	r12 = p[63-37];
	DATATYPE	r13 = p[63-45];
	DATATYPE	r14 = p[63-53];
	DATATYPE	r15 = p[63-61];
	DATATYPE	r16 = p[63-3];
	DATATYPE	r17 = p[63-11];
	DATATYPE	r18 = p[63-19];
	DATATYPE	r19 = p[63-27];
	DATATYPE	r20 = p[63-35];
	DATATYPE	r21 = p[63-43];
	DATATYPE	r22 = p[63-51];
	DATATYPE	r23 = p[63-59];
	DATATYPE	r24 = p[63-1];
	DATATYPE	r25 = p[63-9];
	DATATYPE	r26 = p[63-17];
	DATATYPE	r27 = p[63-25];
	DATATYPE	r28 = p[63-33];
	DATATYPE	r29 = p[63-41];
	DATATYPE	r30 = p[63-49];
	DATATYPE	r31 = p[63-57];

	s1 (XOR(r31,k[47]), XOR(r0,k[11]), XOR(r1,k[26]), XOR(r2,k[3]), XOR(r3,k[13]),
		XOR(r4,k[41]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[27]), XOR(r4,k[6]), XOR(r5,k[54]), XOR(r6,k[48]), XOR(r7,k[39]),
		XOR(r8,k[19]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[53]), XOR(r8,k[25]), XOR(r9,k[33]), XOR(r10,k[34]), XOR(r11,k[17]),
		XOR(r12,k[5]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[4]), XOR(r12,k[55]), XOR(r13,k[24]), XOR(r14,k[32]), XOR(r15,k[40]),
		XOR(r16,k[20]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[36]), XOR(r16,k[31]), XOR(r17,k[21]), XOR(r18,k[8]), XOR(r19,k[23]),
		XOR(r20,k[52]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[14]), XOR(r20,k[29]), XOR(r21,k[51]), XOR(r22,k[9]), XOR(r23,k[35]),
		XOR(r24,k[30]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[2]), XOR(r24,k[37]), XOR(r25,k[22]), XOR(r26,k[0]), XOR(r27,k[42]),
		XOR(r28,k[38]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[16]), XOR(r28,k[43]), XOR(r29,k[44]), XOR(r30,k[1]), XOR(r31,k[7]),
		XOR(r0,k[28]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[54]), XOR(l0,k[18]), XOR(l1,k[33]), XOR(l2,k[10]), XOR(l3,k[20]),
		XOR(l4,k[48]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[34]), XOR(l4,k[13]), XOR(l5,k[4]), XOR(l6,k[55]), XOR(l7,k[46]),
		XOR(l8,k[26]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[3]), XOR(l8,k[32]), XOR(l9,k[40]), XOR(l10,k[41]), XOR(l11,k[24]),
		XOR(l12,k[12]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[11]), XOR(l12,k[5]), XOR(l13,k[6]), XOR(l14,k[39]), XOR(l15,k[47]),
		XOR(l16,k[27]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[43]), XOR(l16,k[38]), XOR(l17,k[28]), XOR(l18,k[15]), XOR(l19,k[30]),
		XOR(l20,k[0]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[21]), XOR(l20,k[36]), XOR(l21,k[31]), XOR(l22,k[16]), XOR(l23,k[42]),
		XOR(l24,k[37]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[9]), XOR(l24,k[44]), XOR(l25,k[29]), XOR(l26,k[7]), XOR(l27,k[49]),
		XOR(l28,k[45]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[23]), XOR(l28,k[50]), XOR(l29,k[51]), XOR(l30,k[8]), XOR(l31,k[14]),
		XOR(l0,k[35]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[11]), XOR(r0,k[32]), XOR(r1,k[47]), XOR(r2,k[24]), XOR(r3,k[34]),
		XOR(r4,k[5]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[48]), XOR(r4,k[27]), XOR(r5,k[18]), XOR(r6,k[12]), XOR(r7,k[3]),
		XOR(r8,k[40]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[17]), XOR(r8,k[46]), XOR(r9,k[54]), XOR(r10,k[55]), XOR(r11,k[13]),
		XOR(r12,k[26]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[25]), XOR(r12,k[19]), XOR(r13,k[20]), XOR(r14,k[53]), XOR(r15,k[4]),
		XOR(r16,k[41]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[2]), XOR(r16,k[52]), XOR(r17,k[42]), XOR(r18,k[29]), XOR(r19,k[44]),
		XOR(r20,k[14]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[35]), XOR(r20,k[50]), XOR(r21,k[45]), XOR(r22,k[30]), XOR(r23,k[1]),
		XOR(r24,k[51]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[23]), XOR(r24,k[31]), XOR(r25,k[43]), XOR(r26,k[21]), XOR(r27,k[8]),
		XOR(r28,k[0]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[37]), XOR(r28,k[9]), XOR(r29,k[38]), XOR(r30,k[22]), XOR(r31,k[28]),
		XOR(r0,k[49]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[25]), XOR(l0,k[46]), XOR(l1,k[4]), XOR(l2,k[13]), XOR(l3,k[48]),
		XOR(l4,k[19]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[5]), XOR(l4,k[41]), XOR(l5,k[32]), XOR(l6,k[26]), XOR(l7,k[17]),
		XOR(l8,k[54]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[6]), XOR(l8,k[3]), XOR(l9,k[11]), XOR(l10,k[12]), XOR(l11,k[27]),
		XOR(l12,k[40]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[39]), XOR(l12,k[33]), XOR(l13,k[34]), XOR(l14,k[10]), XOR(l15,k[18]),
		XOR(l16,k[55]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[16]), XOR(l16,k[7]), XOR(l17,k[1]), XOR(l18,k[43]), XOR(l19,k[31]),
		XOR(l20,k[28]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[49]), XOR(l20,k[9]), XOR(l21,k[0]), XOR(l22,k[44]), XOR(l23,k[15]),
		XOR(l24,k[38]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[37]), XOR(l24,k[45]), XOR(l25,k[2]), XOR(l26,k[35]), XOR(l27,k[22]),
		XOR(l28,k[14]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[51]), XOR(l28,k[23]), XOR(l29,k[52]), XOR(l30,k[36]), XOR(l31,k[42]),
		XOR(l0,k[8]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[39]), XOR(r0,k[3]), XOR(r1,k[18]), XOR(r2,k[27]), XOR(r3,k[5]),
		XOR(r4,k[33]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[19]), XOR(r4,k[55]), XOR(r5,k[46]), XOR(r6,k[40]), XOR(r7,k[6]),
		XOR(r8,k[11]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[20]), XOR(r8,k[17]), XOR(r9,k[25]), XOR(r10,k[26]), XOR(r11,k[41]),
		XOR(r12,k[54]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[53]), XOR(r12,k[47]), XOR(r13,k[48]), XOR(r14,k[24]), XOR(r15,k[32]),
		XOR(r16,k[12]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[30]), XOR(r16,k[21]), XOR(r17,k[15]), XOR(r18,k[2]), XOR(r19,k[45]),
		XOR(r20,k[42]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[8]), XOR(r20,k[23]), XOR(r21,k[14]), XOR(r22,k[31]), XOR(r23,k[29]),
		XOR(r24,k[52]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[51]), XOR(r24,k[0]), XOR(r25,k[16]), XOR(r26,k[49]), XOR(r27,k[36]),
		XOR(r28,k[28]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[38]), XOR(r28,k[37]), XOR(r29,k[7]), XOR(r30,k[50]), XOR(r31,k[1]),
		XOR(r0,k[22]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[53]), XOR(l0,k[17]), XOR(l1,k[32]), XOR(l2,k[41]), XOR(l3,k[19]),
		XOR(l4,k[47]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[33]), XOR(l4,k[12]), XOR(l5,k[3]), XOR(l6,k[54]), XOR(l7,k[20]),
		XOR(l8,k[25]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[34]), XOR(l8,k[6]), XOR(l9,k[39]), XOR(l10,k[40]), XOR(l11,k[55]),
		XOR(l12,k[11]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[10]), XOR(l12,k[4]), XOR(l13,k[5]), XOR(l14,k[13]), XOR(l15,k[46]),
		XOR(l16,k[26]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[44]), XOR(l16,k[35]), XOR(l17,k[29]), XOR(l18,k[16]), XOR(l19,k[0]),
		XOR(l20,k[1]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[22]), XOR(l20,k[37]), XOR(l21,k[28]), XOR(l22,k[45]), XOR(l23,k[43]),
		XOR(l24,k[7]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[38]), XOR(l24,k[14]), XOR(l25,k[30]), XOR(l26,k[8]), XOR(l27,k[50]),
		XOR(l28,k[42]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[52]), XOR(l28,k[51]), XOR(l29,k[21]), XOR(l30,k[9]), XOR(l31,k[15]),
		XOR(l0,k[36]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[10]), XOR(r0,k[6]), XOR(r1,k[46]), XOR(r2,k[55]), XOR(r3,k[33]),
		XOR(r4,k[4]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[47]), XOR(r4,k[26]), XOR(r5,k[17]), XOR(r6,k[11]), XOR(r7,k[34]),
		XOR(r8,k[39]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[48]), XOR(r8,k[20]), XOR(r9,k[53]), XOR(r10,k[54]), XOR(r11,k[12]),
		XOR(r12,k[25]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[24]), XOR(r12,k[18]), XOR(r13,k[19]), XOR(r14,k[27]), XOR(r15,k[3]),
		XOR(r16,k[40]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[31]), XOR(r16,k[49]), XOR(r17,k[43]), XOR(r18,k[30]), XOR(r19,k[14]),
		XOR(r20,k[15]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[36]), XOR(r20,k[51]), XOR(r21,k[42]), XOR(r22,k[0]), XOR(r23,k[2]),
		XOR(r24,k[21]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[52]), XOR(r24,k[28]), XOR(r25,k[44]), XOR(r26,k[22]), XOR(r27,k[9]),
		XOR(r28,k[1]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[7]), XOR(r28,k[38]), XOR(r29,k[35]), XOR(r30,k[23]), XOR(r31,k[29]),
		XOR(r0,k[50]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[24]), XOR(l0,k[20]), XOR(l1,k[3]), XOR(l2,k[12]), XOR(l3,k[47]),
		XOR(l4,k[18]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[4]), XOR(l4,k[40]), XOR(l5,k[6]), XOR(l6,k[25]), XOR(l7,k[48]),
		XOR(l8,k[53]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[5]), XOR(l8,k[34]), XOR(l9,k[10]), XOR(l10,k[11]), XOR(l11,k[26]),
		XOR(l12,k[39]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[13]), XOR(l12,k[32]), XOR(l13,k[33]), XOR(l14,k[41]), XOR(l15,k[17]),
		XOR(l16,k[54]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[45]), XOR(l16,k[8]), XOR(l17,k[2]), XOR(l18,k[44]), XOR(l19,k[28]),
		XOR(l20,k[29]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[50]), XOR(l20,k[38]), XOR(l21,k[1]), XOR(l22,k[14]), XOR(l23,k[16]),
		XOR(l24,k[35]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[7]), XOR(l24,k[42]), XOR(l25,k[31]), XOR(l26,k[36]), XOR(l27,k[23]),
		XOR(l28,k[15]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[21]), XOR(l28,k[52]), XOR(l29,k[49]), XOR(l30,k[37]), XOR(l31,k[43]),
		XOR(l0,k[9]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[6]), XOR(r0,k[27]), XOR(r1,k[10]), XOR(r2,k[19]), XOR(r3,k[54]),
		XOR(r4,k[25]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[11]), XOR(r4,k[47]), XOR(r5,k[13]), XOR(r6,k[32]), XOR(r7,k[55]),
		XOR(r8,k[3]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[12]), XOR(r8,k[41]), XOR(r9,k[17]), XOR(r10,k[18]), XOR(r11,k[33]),
		XOR(r12,k[46]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[20]), XOR(r12,k[39]), XOR(r13,k[40]), XOR(r14,k[48]), XOR(r15,k[24]),
		XOR(r16,k[4]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[52]), XOR(r16,k[15]), XOR(r17,k[9]), XOR(r18,k[51]), XOR(r19,k[35]),
		XOR(r20,k[36]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[2]), XOR(r20,k[45]), XOR(r21,k[8]), XOR(r22,k[21]), XOR(r23,k[23]),
		XOR(r24,k[42]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[14]), XOR(r24,k[49]), XOR(r25,k[38]), XOR(r26,k[43]), XOR(r27,k[30]),
		XOR(r28,k[22]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[28]), XOR(r28,k[0]), XOR(r29,k[1]), XOR(r30,k[44]), XOR(r31,k[50]),
		XOR(r0,k[16]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[20]), XOR(l0,k[41]), XOR(l1,k[24]), XOR(l2,k[33]), XOR(l3,k[11]),
		XOR(l4,k[39]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[25]), XOR(l4,k[4]), XOR(l5,k[27]), XOR(l6,k[46]), XOR(l7,k[12]),
		XOR(l8,k[17]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[26]), XOR(l8,k[55]), XOR(l9,k[6]), XOR(l10,k[32]), XOR(l11,k[47]),
		XOR(l12,k[3]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[34]), XOR(l12,k[53]), XOR(l13,k[54]), XOR(l14,k[5]), XOR(l15,k[13]),
		XOR(l16,k[18]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[7]), XOR(l16,k[29]), XOR(l17,k[23]), XOR(l18,k[38]), XOR(l19,k[49]),
		XOR(l20,k[50]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[16]), XOR(l20,k[0]), XOR(l21,k[22]), XOR(l22,k[35]), XOR(l23,k[37]),
		XOR(l24,k[1]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[28]), XOR(l24,k[8]), XOR(l25,k[52]), XOR(l26,k[2]), XOR(l27,k[44]),
		XOR(l28,k[36]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[42]), XOR(l28,k[14]), XOR(l29,k[15]), XOR(l30,k[31]), XOR(l31,k[9]),
		XOR(l0,k[30]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[34]), XOR(r0,k[55]), XOR(r1,k[13]), XOR(r2,k[47]), XOR(r3,k[25]),
		XOR(r4,k[53]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[39]), XOR(r4,k[18]), XOR(r5,k[41]), XOR(r6,k[3]), XOR(r7,k[26]),
		XOR(r8,k[6]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[40]), XOR(r8,k[12]), XOR(r9,k[20]), XOR(r10,k[46]), XOR(r11,k[4]),
		XOR(r12,k[17]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[48]), XOR(r12,k[10]), XOR(r13,k[11]), XOR(r14,k[19]), XOR(r15,k[27]),
		XOR(r16,k[32]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[21]), XOR(r16,k[43]), XOR(r17,k[37]), XOR(r18,k[52]), XOR(r19,k[8]),
		XOR(r20,k[9]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[30]), XOR(r20,k[14]), XOR(r21,k[36]), XOR(r22,k[49]), XOR(r23,k[51]),
		XOR(r24,k[15]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[42]), XOR(r24,k[22]), XOR(r25,k[7]), XOR(r26,k[16]), XOR(r27,k[31]),
		XOR(r28,k[50]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[1]), XOR(r28,k[28]), XOR(r29,k[29]), XOR(r30,k[45]), XOR(r31,k[23]),
		XOR(r0,k[44]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[48]), XOR(l0,k[12]), XOR(l1,k[27]), XOR(l2,k[4]), XOR(l3,k[39]),
		XOR(l4,k[10]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[53]), XOR(l4,k[32]), XOR(l5,k[55]), XOR(l6,k[17]), XOR(l7,k[40]),
		XOR(l8,k[20]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[54]), XOR(l8,k[26]), XOR(l9,k[34]), XOR(l10,k[3]), XOR(l11,k[18]),
		XOR(l12,k[6]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[5]), XOR(l12,k[24]), XOR(l13,k[25]), XOR(l14,k[33]), XOR(l15,k[41]),
		XOR(l16,k[46]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[35]), XOR(l16,k[2]), XOR(l17,k[51]), XOR(l18,k[7]), XOR(l19,k[22]),
		XOR(l20,k[23]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[44]), XOR(l20,k[28]), XOR(l21,k[50]), XOR(l22,k[8]), XOR(l23,k[38]),
		XOR(l24,k[29]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[1]), XOR(l24,k[36]), XOR(l25,k[21]), XOR(l26,k[30]), XOR(l27,k[45]),
		XOR(l28,k[9]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[15]), XOR(l28,k[42]), XOR(l29,k[43]), XOR(l30,k[0]), XOR(l31,k[37]),
		XOR(l0,k[31]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[5]), XOR(r0,k[26]), XOR(r1,k[41]), XOR(r2,k[18]), XOR(r3,k[53]),
		XOR(r4,k[24]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[10]), XOR(r4,k[46]), XOR(r5,k[12]), XOR(r6,k[6]), XOR(r7,k[54]),
		XOR(r8,k[34]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[11]), XOR(r8,k[40]), XOR(r9,k[48]), XOR(r10,k[17]), XOR(r11,k[32]),
		XOR(r12,k[20]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[19]), XOR(r12,k[13]), XOR(r13,k[39]), XOR(r14,k[47]), XOR(r15,k[55]),
		XOR(r16,k[3]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[49]), XOR(r16,k[16]), XOR(r17,k[38]), XOR(r18,k[21]), XOR(r19,k[36]),
		XOR(r20,k[37]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[31]), XOR(r20,k[42]), XOR(r21,k[9]), XOR(r22,k[22]), XOR(r23,k[52]),
		XOR(r24,k[43]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[15]), XOR(r24,k[50]), XOR(r25,k[35]), XOR(r26,k[44]), XOR(r27,k[0]),
		XOR(r28,k[23]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[29]), XOR(r28,k[1]), XOR(r29,k[2]), XOR(r30,k[14]), XOR(r31,k[51]),
		XOR(r0,k[45]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[19]), XOR(l0,k[40]), XOR(l1,k[55]), XOR(l2,k[32]), XOR(l3,k[10]),
		XOR(l4,k[13]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[24]), XOR(l4,k[3]), XOR(l5,k[26]), XOR(l6,k[20]), XOR(l7,k[11]),
		XOR(l8,k[48]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[25]), XOR(l8,k[54]), XOR(l9,k[5]), XOR(l10,k[6]), XOR(l11,k[46]),
		XOR(l12,k[34]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[33]), XOR(l12,k[27]), XOR(l13,k[53]), XOR(l14,k[4]), XOR(l15,k[12]),
		XOR(l16,k[17]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[8]), XOR(l16,k[30]), XOR(l17,k[52]), XOR(l18,k[35]), XOR(l19,k[50]),
		XOR(l20,k[51]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[45]), XOR(l20,k[1]), XOR(l21,k[23]), XOR(l22,k[36]), XOR(l23,k[7]),
		XOR(l24,k[2]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[29]), XOR(l24,k[9]), XOR(l25,k[49]), XOR(l26,k[31]), XOR(l27,k[14]),
		XOR(l28,k[37]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[43]), XOR(l28,k[15]), XOR(l29,k[16]), XOR(l30,k[28]), XOR(l31,k[38]),
		XOR(l0,k[0]), &r4, &r26, &r14, &r20);
	s1 (XOR(r31,k[33]), XOR(r0,k[54]), XOR(r1,k[12]), XOR(r2,k[46]), XOR(r3,k[24]),
		XOR(r4,k[27]), &l8, &l16, &l22, &l30);
	s2 (XOR(r3,k[13]), XOR(r4,k[17]), XOR(r5,k[40]), XOR(r6,k[34]), XOR(r7,k[25]),
		XOR(r8,k[5]), &l12, &l27, &l1, &l17);
	s3 (XOR(r7,k[39]), XOR(r8,k[11]), XOR(r9,k[19]), XOR(r10,k[20]), XOR(r11,k[3]),
		XOR(r12,k[48]), &l23, &l15, &l29, &l5);
	s4 (XOR(r11,k[47]), XOR(r12,k[41]), XOR(r13,k[10]), XOR(r14,k[18]), XOR(r15,k[26]),
		XOR(r16,k[6]), &l25, &l19, &l9, &l0);
	s5 (XOR(r15,k[22]), XOR(r16,k[44]), XOR(r17,k[7]), XOR(r18,k[49]), XOR(r19,k[9]),
		XOR(r20,k[38]), &l7, &l13, &l24, &l2);
	s6 (XOR(r19,k[0]), XOR(r20,k[15]), XOR(r21,k[37]), XOR(r22,k[50]), XOR(r23,k[21]),
		XOR(r24,k[16]), &l3, &l28, &l10, &l18);
	s7 (XOR(r23,k[43]), XOR(r24,k[23]), XOR(r25,k[8]), XOR(r26,k[45]), XOR(r27,k[28]),
		XOR(r28,k[51]), &l31, &l11, &l21, &l6);
	s8 (XOR(r27,k[2]), XOR(r28,k[29]), XOR(r29,k[30]), XOR(r30,k[42]), XOR(r31,k[52]),
		XOR(r0,k[14]), &l4, &l26, &l14, &l20);
	s1 (XOR(l31,k[40]), XOR(l0,k[4]), XOR(l1,k[19]), XOR(l2,k[53]), XOR(l3,k[6]),
		XOR(l4,k[34]), &r8, &r16, &r22, &r30);
	s2 (XOR(l3,k[20]), XOR(l4,k[24]), XOR(l5,k[47]), XOR(l6,k[41]), XOR(l7,k[32]),
		XOR(l8,k[12]), &r12, &r27, &r1, &r17);
	s3 (XOR(l7,k[46]), XOR(l8,k[18]), XOR(l9,k[26]), XOR(l10,k[27]), XOR(l11,k[10]),
		XOR(l12,k[55]), &r23, &r15, &r29, &r5);
	s4 (XOR(l11,k[54]), XOR(l12,k[48]), XOR(l13,k[17]), XOR(l14,k[25]), XOR(l15,k[33]),
		XOR(l16,k[13]), &r25, &r19, &r9, &r0);
	s5 (XOR(l15,k[29]), XOR(l16,k[51]), XOR(l17,k[14]), XOR(l18,k[1]), XOR(l19,k[16]),
		XOR(l20,k[45]), &r7, &r13, &r24, &r2);
	s6 (XOR(l19,k[7]), XOR(l20,k[22]), XOR(l21,k[44]), XOR(l22,k[2]), XOR(l23,k[28]),
		XOR(l24,k[23]), &r3, &r28, &r10, &r18);
	s7 (XOR(l23,k[50]), XOR(l24,k[30]), XOR(l25,k[15]), XOR(l26,k[52]), XOR(l27,k[35]),
		XOR(l28,k[31]), &r31, &r11, &r21, &r6);
	s8 (XOR(l27,k[9]), XOR(l28,k[36]), XOR(l29,k[37]), XOR(l30,k[49]), XOR(l31,k[0]),
		XOR(l0,k[21]), &r4, &r26, &r14, &r20);

    c[63-5] = l8;
    c[63-3] = l16;
    c[63-51] = l22;
    c[63-49] = l30;
    c[63-37] = l12;
    c[63-25] = l27;
    c[63-15] = l1;
    c[63-11] = l17;
    c[63-59] = l23;
    c[63-61] = l15;
    c[63-41] = l29;
    c[63-47] = l5;
    c[63-9] = l25;
    c[63-27] = l19;
    c[63-13] = l9;
    c[63-7] = l0;
    c[63-63] = l7;
    c[63-45] = l13;
    c[63-1] = l24;
    c[63-23] = l2;
    c[63-31] = l3;
    c[63-33] = l28;
    c[63-21] = l10;
    c[63-19] = l18;
    c[63-57] = l31;
    c[63-29] = l11;
    c[63-43] = l21;
    c[63-55] = l6;
    c[63-39] = l4;
    c[63-17] = l26;
    c[63-53] = l14;
    c[63-35] = l20;
    c[63-4] = r8;
    c[63-2] = r16;
    c[63-50] = r22;
    c[63-48] = r30;
    c[63-36] = r12;
    c[63-24] = r27;
    c[63-14] = r1;
    c[63-10] = r17;
    c[63-58] = r23;
    c[63-60] = r15;
    c[63-40] = r29;
    c[63-46] = r5;
    c[63-8] = r25;
    c[63-26] = r19;
    c[63-12] = r9;
    c[63-6] = r0;
    c[63-62] = r7;
    c[63-44] = r13;
    c[63-0] = r24;
    c[63-22] = r2;
    c[63-30] = r3;
    c[63-32] = r28;
    c[63-20] = r10;
    c[63-18] = r18;
    c[63-56] = r31;
    c[63-28] = r11;
    c[63-42] = r21;
    c[63-54] = r6;
    c[63-38] = r4;
    c[63-16] = r26;
    c[63-52] = r14;
    c[63-34] = r20;

}
