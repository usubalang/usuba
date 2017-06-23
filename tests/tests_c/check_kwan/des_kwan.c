/*
 * Generated S-box files.
 *
 * Produced by Matthew Kwan - March 1998
 */


static void
s1 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54, x55, x56;
	unsigned long	x57, x58, x59, x60, x61, x62, x63;

	x1 = ~a4;
	x2 = ~a1;
	x3 = a4 ^ a3;
	x4 = x3 ^ x2;
	x5 = a3 | x2;
	x6 = x5 & x1;
	x7 = a6 | x6;
	x8 = x4 ^ x7;
	x9 = x1 | x2;
	x10 = a6 & x9;
	x11 = x7 ^ x10;
	x12 = a2 | x11;
	x13 = x8 ^ x12;
	x14 = x9 ^ x13;
	x15 = a6 | x14;
	x16 = x1 ^ x15;
	x17 = ~x14;
	x18 = x17 & x3;
	x19 = a2 | x18;
	x20 = x16 ^ x19;
	x21 = a5 | x20;
	x22 = x13 ^ x21;
	*out4 ^= x22;
	x23 = a3 | x4;
	x24 = ~x23;
	x25 = a6 | x24;
	x26 = x6 ^ x25;
	x27 = x1 & x8;
	x28 = a2 | x27;
	x29 = x26 ^ x28;
	x30 = x1 | x8;
	x31 = x30 ^ x6;
	x32 = x5 & x14;
	x33 = x32 ^ x8;
	x34 = a2 & x33;
	x35 = x31 ^ x34;
	x36 = a5 | x35;
	x37 = x29 ^ x36;
	*out1 ^= x37;
	x38 = a3 & x10;
	x39 = x38 | x4;
	x40 = a3 & x33;
	x41 = x40 ^ x25;
	x42 = a2 | x41;
	x43 = x39 ^ x42;
	x44 = a3 | x26;
	x45 = x44 ^ x14;
	x46 = a1 | x8;
	x47 = x46 ^ x20;
	x48 = a2 | x47;
	x49 = x45 ^ x48;
	x50 = a5 & x49;
	x51 = x43 ^ x50;
	*out2 ^= x51;
	x52 = x8 ^ x40;
	x53 = a3 ^ x11;
	x54 = x53 & x5;
	x55 = a2 | x54;
	x56 = x52 ^ x55;
	x57 = a6 | x4;
	x58 = x57 ^ x38;
	x59 = x13 & x56;
	x60 = a2 & x59;
	x61 = x58 ^ x60;
	x62 = a5 & x61;
	x63 = x56 ^ x62;
	*out3 ^= x63;
}


static void
s2 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54, x55, x56;

	x1 = ~a5;
	x2 = ~a1;
	x3 = a5 ^ a6;
	x4 = x3 ^ x2;
	x5 = x4 ^ a2;
	x6 = a6 | x1;
	x7 = x6 | x2;
	x8 = a2 & x7;
	x9 = a6 ^ x8;
	x10 = a3 & x9;
	x11 = x5 ^ x10;
	x12 = a2 & x9;
	x13 = a5 ^ x6;
	x14 = a3 | x13;
	x15 = x12 ^ x14;
	x16 = a4 & x15;
	x17 = x11 ^ x16;
	*out2 ^= x17;
	x18 = a5 | a1;
	x19 = a6 | x18;
	x20 = x13 ^ x19;
	x21 = x20 ^ a2;
	x22 = a6 | x4;
	x23 = x22 & x17;
	x24 = a3 | x23;
	x25 = x21 ^ x24;
	x26 = a6 | x2;
	x27 = a5 & x2;
	x28 = a2 | x27;
	x29 = x26 ^ x28;
	x30 = x3 ^ x27;
	x31 = x2 ^ x19;
	x32 = a2 & x31;
	x33 = x30 ^ x32;
	x34 = a3 & x33;
	x35 = x29 ^ x34;
	x36 = a4 | x35;
	x37 = x25 ^ x36;
	*out3 ^= x37;
	x38 = x21 & x32;
	x39 = x38 ^ x5;
	x40 = a1 | x15;
	x41 = x40 ^ x13;
	x42 = a3 | x41;
	x43 = x39 ^ x42;
	x44 = x28 | x41;
	x45 = a4 & x44;
	x46 = x43 ^ x45;
	*out1 ^= x46;
	x47 = x19 & x21;
	x48 = x47 ^ x26;
	x49 = a2 & x33;
	x50 = x49 ^ x21;
	x51 = a3 & x50;
	x52 = x48 ^ x51;
	x53 = x18 & x28;
	x54 = x53 & x50;
	x55 = a4 | x54;
	x56 = x52 ^ x55;
	*out4 ^= x56;
}


static void
s3 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54, x55, x56;
	unsigned long	x57;

	x1 = ~a5;
	x2 = ~a6;
	x3 = a5 & a3;
	x4 = x3 ^ a6;
	x5 = a4 & x1;
	x6 = x4 ^ x5;
	x7 = x6 ^ a2;
	x8 = a3 & x1;
	x9 = a5 ^ x2;
	x10 = a4 | x9;
	x11 = x8 ^ x10;
	x12 = x7 & x11;
	x13 = a5 ^ x11;
	x14 = x13 | x7;
	x15 = a4 & x14;
	x16 = x12 ^ x15;
	x17 = a2 & x16;
	x18 = x11 ^ x17;
	x19 = a1 & x18;
	x20 = x7 ^ x19;
	*out4 ^= x20;
	x21 = a3 ^ a4;
	x22 = x21 ^ x9;
	x23 = x2 | x4;
	x24 = x23 ^ x8;
	x25 = a2 | x24;
	x26 = x22 ^ x25;
	x27 = a6 ^ x23;
	x28 = x27 | a4;
	x29 = a3 ^ x15;
	x30 = x29 | x5;
	x31 = a2 | x30;
	x32 = x28 ^ x31;
	x33 = a1 | x32;
	x34 = x26 ^ x33;
	*out1 ^= x34;
	x35 = a3 ^ x9;
	x36 = x35 | x5;
	x37 = x4 | x29;
	x38 = x37 ^ a4;
	x39 = a2 | x38;
	x40 = x36 ^ x39;
	x41 = a6 & x11;
	x42 = x41 | x6;
	x43 = x34 ^ x38;
	x44 = x43 ^ x41;
	x45 = a2 & x44;
	x46 = x42 ^ x45;
	x47 = a1 | x46;
	x48 = x40 ^ x47;
	*out3 ^= x48;
	x49 = x2 | x38;
	x50 = x49 ^ x13;
	x51 = x27 ^ x28;
	x52 = a2 | x51;
	x53 = x50 ^ x52;
	x54 = x12 & x23;
	x55 = x54 & x52;
	x56 = a1 | x55;
	x57 = x53 ^ x56;
	*out2 ^= x57;
}


static void
s4 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42;

	x1 = ~a1;
	x2 = ~a3;
	x3 = a1 | a3;
	x4 = a5 & x3;
	x5 = x1 ^ x4;
	x6 = a2 | a3;
	x7 = x5 ^ x6;
	x8 = a1 & a5;
	x9 = x8 ^ x3;
	x10 = a2 & x9;
	x11 = a5 ^ x10;
	x12 = a4 & x11;
	x13 = x7 ^ x12;
	x14 = x2 ^ x4;
	x15 = a2 & x14;
	x16 = x9 ^ x15;
	x17 = x5 & x14;
	x18 = a5 ^ x2;
	x19 = a2 | x18;
	x20 = x17 ^ x19;
	x21 = a4 | x20;
	x22 = x16 ^ x21;
	x23 = a6 & x22;
	x24 = x13 ^ x23;
	*out2 ^= x24;
	x25 = ~x13;
	x26 = a6 | x22;
	x27 = x25 ^ x26;
	*out1 ^= x27;
	x28 = a2 & x11;
	x29 = x28 ^ x17;
	x30 = a3 ^ x10;
	x31 = x30 ^ x19;
	x32 = a4 & x31;
	x33 = x29 ^ x32;
	x34 = x25 ^ x33;
	x35 = a2 & x34;
	x36 = x24 ^ x35;
	x37 = a4 | x34;
	x38 = x36 ^ x37;
	x39 = a6 & x38;
	x40 = x33 ^ x39;
	*out4 ^= x40;
	x41 = x26 ^ x38;
	x42 = x41 ^ x40;
	*out3 ^= x42;
}


static void
s5 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54, x55, x56;
	unsigned long	x57, x58, x59, x60, x61, x62;

	x1 = ~a6;
	x2 = ~a3;
	x3 = x1 | x2;
	x4 = x3 ^ a4;
	x5 = a1 & x3;
	x6 = x4 ^ x5;
	x7 = a6 | a4;
	x8 = x7 ^ a3;
	x9 = a3 | x7;
	x10 = a1 | x9;
	x11 = x8 ^ x10;
	x12 = a5 & x11;
	x13 = x6 ^ x12;
	x14 = ~x4;
	x15 = x14 & a6;
	x16 = a1 | x15;
	x17 = x8 ^ x16;
	x18 = a5 | x17;
	x19 = x10 ^ x18;
	x20 = a2 | x19;
	x21 = x13 ^ x20;
	*out3 ^= x21;
	x22 = x2 | x15;
	x23 = x22 ^ a6;
	x24 = a4 ^ x22;
	x25 = a1 & x24;
	x26 = x23 ^ x25;
	x27 = a1 ^ x11;
	x28 = x27 & x22;
	x29 = a5 | x28;
	x30 = x26 ^ x29;
	x31 = a4 | x27;
	x32 = ~x31;
	x33 = a2 | x32;
	x34 = x30 ^ x33;
	*out2 ^= x34;
	x35 = x2 ^ x15;
	x36 = a1 & x35;
	x37 = x14 ^ x36;
	x38 = x5 ^ x7;
	x39 = x38 & x34;
	x40 = a5 | x39;
	x41 = x37 ^ x40;
	x42 = x2 ^ x5;
	x43 = x42 & x16;
	x44 = x4 & x27;
	x45 = a5 & x44;
	x46 = x43 ^ x45;
	x47 = a2 | x46;
	x48 = x41 ^ x47;
	*out1 ^= x48;
	x49 = x24 & x48;
	x50 = x49 ^ x5;
	x51 = x11 ^ x30;
	x52 = x51 | x50;
	x53 = a5 & x52;
	x54 = x50 ^ x53;
	x55 = x14 ^ x19;
	x56 = x55 ^ x34;
	x57 = x4 ^ x16;
	x58 = x57 & x30;
	x59 = a5 & x58;
	x60 = x56 ^ x59;
	x61 = a2 | x60;
	x62 = x54 ^ x61;
	*out4 ^= x62;
}


static void
s6 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54, x55, x56;
	unsigned long	x57;

	x1 = ~a2;
	x2 = ~a5;
	x3 = a2 ^ a6;
	x4 = x3 ^ x2;
	x5 = x4 ^ a1;
	x6 = a5 & a6;
	x7 = x6 | x1;
	x8 = a5 & x5;
	x9 = a1 & x8;
	x10 = x7 ^ x9;
	x11 = a4 & x10;
	x12 = x5 ^ x11;
	x13 = a6 ^ x10;
	x14 = x13 & a1;
	x15 = a2 & a6;
	x16 = x15 ^ a5;
	x17 = a1 & x16;
	x18 = x2 ^ x17;
	x19 = a4 | x18;
	x20 = x14 ^ x19;
	x21 = a3 & x20;
	x22 = x12 ^ x21;
	*out2 ^= x22;
	x23 = a6 ^ x18;
	x24 = a1 & x23;
	x25 = a5 ^ x24;
	x26 = a2 ^ x17;
	x27 = x26 | x6;
	x28 = a4 & x27;
	x29 = x25 ^ x28;
	x30 = ~x26;
	x31 = a6 | x29;
	x32 = ~x31;
	x33 = a4 & x32;
	x34 = x30 ^ x33;
	x35 = a3 & x34;
	x36 = x29 ^ x35;
	*out4 ^= x36;
	x37 = x6 ^ x34;
	x38 = a5 & x23;
	x39 = x38 ^ x5;
	x40 = a4 | x39;
	x41 = x37 ^ x40;
	x42 = x16 | x24;
	x43 = x42 ^ x1;
	x44 = x15 ^ x24;
	x45 = x44 ^ x31;
	x46 = a4 | x45;
	x47 = x43 ^ x46;
	x48 = a3 | x47;
	x49 = x41 ^ x48;
	*out1 ^= x49;
	x50 = x5 | x38;
	x51 = x50 ^ x6;
	x52 = x8 & x31;
	x53 = a4 | x52;
	x54 = x51 ^ x53;
	x55 = x30 & x43;
	x56 = a3 | x55;
	x57 = x54 ^ x56;
	*out3 ^= x57;
}


static void
s7 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54, x55, x56;
	unsigned long	x57;

	x1 = ~a2;
	x2 = ~a5;
	x3 = a2 & a4;
	x4 = x3 ^ a5;
	x5 = x4 ^ a3;
	x6 = a4 & x4;
	x7 = x6 ^ a2;
	x8 = a3 & x7;
	x9 = a1 ^ x8;
	x10 = a6 | x9;
	x11 = x5 ^ x10;
	x12 = a4 & x2;
	x13 = x12 | a2;
	x14 = a2 | x2;
	x15 = a3 & x14;
	x16 = x13 ^ x15;
	x17 = x6 ^ x11;
	x18 = a6 | x17;
	x19 = x16 ^ x18;
	x20 = a1 & x19;
	x21 = x11 ^ x20;
	*out1 ^= x21;
	x22 = a2 | x21;
	x23 = x22 ^ x6;
	x24 = x23 ^ x15;
	x25 = x5 ^ x6;
	x26 = x25 | x12;
	x27 = a6 | x26;
	x28 = x24 ^ x27;
	x29 = x1 & x19;
	x30 = x23 & x26;
	x31 = a6 & x30;
	x32 = x29 ^ x31;
	x33 = a1 | x32;
	x34 = x28 ^ x33;
	*out4 ^= x34;
	x35 = a4 & x16;
	x36 = x35 | x1;
	x37 = a6 & x36;
	x38 = x11 ^ x37;
	x39 = a4 & x13;
	x40 = a3 | x7;
	x41 = x39 ^ x40;
	x42 = x1 | x24;
	x43 = a6 | x42;
	x44 = x41 ^ x43;
	x45 = a1 | x44;
	x46 = x38 ^ x45;
	*out2 ^= x46;
	x47 = x8 ^ x44;
	x48 = x6 ^ x15;
	x49 = a6 | x48;
	x50 = x47 ^ x49;
	x51 = x19 ^ x44;
	x52 = a4 ^ x25;
	x53 = x52 & x46;
	x54 = a6 & x53;
	x55 = x51 ^ x54;
	x56 = a1 | x55;
	x57 = x50 ^ x56;
	*out3 ^= x57;
}


static void
s8 (
	unsigned long	a1,
	unsigned long	a2,
	unsigned long	a3,
	unsigned long	a4,
	unsigned long	a5,
	unsigned long	a6,
	unsigned long	*out1,
	unsigned long	*out2,
	unsigned long	*out3,
	unsigned long	*out4
) {
	unsigned long	x1, x2, x3, x4, x5, x6, x7, x8;
	unsigned long	x9, x10, x11, x12, x13, x14, x15, x16;
	unsigned long	x17, x18, x19, x20, x21, x22, x23, x24;
	unsigned long	x25, x26, x27, x28, x29, x30, x31, x32;
	unsigned long	x33, x34, x35, x36, x37, x38, x39, x40;
	unsigned long	x41, x42, x43, x44, x45, x46, x47, x48;
	unsigned long	x49, x50, x51, x52, x53, x54;

	x1 = ~a1;
	x2 = ~a4;
	x3 = a3 ^ x1;
	x4 = a3 | x1;
	x5 = x4 ^ x2;
	x6 = a5 | x5;
	x7 = x3 ^ x6;
	x8 = x1 | x5;
	x9 = x2 ^ x8;
	x10 = a5 & x9;
	x11 = x8 ^ x10;
	x12 = a2 & x11;
	x13 = x7 ^ x12;
	x14 = x6 ^ x9;
	x15 = x3 & x9;
	x16 = a5 & x8;
	x17 = x15 ^ x16;
	x18 = a2 | x17;
	x19 = x14 ^ x18;
	x20 = a6 | x19;
	x21 = x13 ^ x20;
	*out1 ^= x21;
	x22 = a5 | x3;
	x23 = x22 & x2;
	x24 = ~a3;
	x25 = x24 & x8;
	x26 = a5 & x4;
	x27 = x25 ^ x26;
	x28 = a2 | x27;
	x29 = x23 ^ x28;
	x30 = a6 & x29;
	x31 = x13 ^ x30;
	*out4 ^= x31;
	x32 = x5 ^ x6;
	x33 = x32 ^ x22;
	x34 = a4 | x13;
	x35 = a2 & x34;
	x36 = x33 ^ x35;
	x37 = a1 & x33;
	x38 = x37 ^ x8;
	x39 = a1 ^ x23;
	x40 = x39 & x7;
	x41 = a2 & x40;
	x42 = x38 ^ x41;
	x43 = a6 | x42;
	x44 = x36 ^ x43;
	*out3 ^= x44;
	x45 = a1 ^ x10;
	x46 = x45 ^ x22;
	x47 = ~x7;
	x48 = x47 & x8;
	x49 = a2 | x48;
	x50 = x46 ^ x49;
	x51 = x19 ^ x29;
	x52 = x51 | x38;
	x53 = a6 & x52;
	x54 = x50 ^ x53;
	*out2 ^= x54;
}


/*
 * Bitslice implementation of DES.
 *
 * Checks that the plaintext bits p[0] .. p[63]
 * encrypt to the ciphertext bits c[0] .. c[63]
 * given the key bits k[0] .. k[55]
 */

void
deseval (
	const unsigned long	*p,
	unsigned long	*c,
	const unsigned long	*k
) {
	unsigned long	l0 = p[6];
	unsigned long	l1 = p[14];
	unsigned long	l2 = p[22];
	unsigned long	l3 = p[30];
	unsigned long	l4 = p[38];
	unsigned long	l5 = p[46];
	unsigned long	l6 = p[54];
	unsigned long	l7 = p[62];
	unsigned long	l8 = p[4];
	unsigned long	l9 = p[12];
	unsigned long	l10 = p[20];
	unsigned long	l11 = p[28];
	unsigned long	l12 = p[36];
	unsigned long	l13 = p[44];
	unsigned long	l14 = p[52];
	unsigned long	l15 = p[60];
	unsigned long	l16 = p[2];
	unsigned long	l17 = p[10];
	unsigned long	l18 = p[18];
	unsigned long	l19 = p[26];
	unsigned long	l20 = p[34];
	unsigned long	l21 = p[42];
	unsigned long	l22 = p[50];
	unsigned long	l23 = p[58];
	unsigned long	l24 = p[0];
	unsigned long	l25 = p[8];
	unsigned long	l26 = p[16];
	unsigned long	l27 = p[24];
	unsigned long	l28 = p[32];
	unsigned long	l29 = p[40];
	unsigned long	l30 = p[48];
	unsigned long	l31 = p[56];
	unsigned long	r0 = p[7];
	unsigned long	r1 = p[15];
	unsigned long	r2 = p[23];
	unsigned long	r3 = p[31];
	unsigned long	r4 = p[39];
	unsigned long	r5 = p[47];
	unsigned long	r6 = p[55];
	unsigned long	r7 = p[63];
	unsigned long	r8 = p[5];
	unsigned long	r9 = p[13];
	unsigned long	r10 = p[21];
	unsigned long	r11 = p[29];
	unsigned long	r12 = p[37];
	unsigned long	r13 = p[45];
	unsigned long	r14 = p[53];
	unsigned long	r15 = p[61];
	unsigned long	r16 = p[3];
	unsigned long	r17 = p[11];
	unsigned long	r18 = p[19];
	unsigned long	r19 = p[27];
	unsigned long	r20 = p[35];
	unsigned long	r21 = p[43];
	unsigned long	r22 = p[51];
	unsigned long	r23 = p[59];
	unsigned long	r24 = p[1];
	unsigned long	r25 = p[9];
	unsigned long	r26 = p[17];
	unsigned long	r27 = p[25];
	unsigned long	r28 = p[33];
	unsigned long	r29 = p[41];
	unsigned long	r30 = p[49];
	unsigned long	r31 = p[57];

    //  p[57]        p[7]        p[15]       p[23]      p[31]
	s1 (r31 ^ k[47], r0 ^ k[11], r1 ^ k[26], r2 ^ k[3], r3 ^ k[13],
    //  p[39]
		r4 ^ k[41], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[27], r4 ^ k[6], r5 ^ k[54], r6 ^ k[48], r7 ^ k[39],
		r8 ^ k[19], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[53], r8 ^ k[25], r9 ^ k[33], r10 ^ k[34], r11 ^ k[17],
		r12 ^ k[5], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[4], r12 ^ k[55], r13 ^ k[24], r14 ^ k[32], r15 ^ k[40],
		r16 ^ k[20], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[36], r16 ^ k[31], r17 ^ k[21], r18 ^ k[8], r19 ^ k[23],
		r20 ^ k[52], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[14], r20 ^ k[29], r21 ^ k[51], r22 ^ k[9], r23 ^ k[35],
		r24 ^ k[30], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[2], r24 ^ k[37], r25 ^ k[22], r26 ^ k[0], r27 ^ k[42],
		r28 ^ k[38], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[16], r28 ^ k[43], r29 ^ k[44], r30 ^ k[1], r31 ^ k[7],
		r0 ^ k[28], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[54], l0 ^ k[18], l1 ^ k[33], l2 ^ k[10], l3 ^ k[20],
		l4 ^ k[48], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[34], l4 ^ k[13], l5 ^ k[4], l6 ^ k[55], l7 ^ k[46],
		l8 ^ k[26], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[3], l8 ^ k[32], l9 ^ k[40], l10 ^ k[41], l11 ^ k[24],
		l12 ^ k[12], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[11], l12 ^ k[5], l13 ^ k[6], l14 ^ k[39], l15 ^ k[47],
		l16 ^ k[27], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[43], l16 ^ k[38], l17 ^ k[28], l18 ^ k[15], l19 ^ k[30],
		l20 ^ k[0], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[21], l20 ^ k[36], l21 ^ k[31], l22 ^ k[16], l23 ^ k[42],
		l24 ^ k[37], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[9], l24 ^ k[44], l25 ^ k[29], l26 ^ k[7], l27 ^ k[49],
		l28 ^ k[45], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[23], l28 ^ k[50], l29 ^ k[51], l30 ^ k[8], l31 ^ k[14],
		l0 ^ k[35], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[11], r0 ^ k[32], r1 ^ k[47], r2 ^ k[24], r3 ^ k[34],
		r4 ^ k[5], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[48], r4 ^ k[27], r5 ^ k[18], r6 ^ k[12], r7 ^ k[3],
		r8 ^ k[40], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[17], r8 ^ k[46], r9 ^ k[54], r10 ^ k[55], r11 ^ k[13],
		r12 ^ k[26], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[25], r12 ^ k[19], r13 ^ k[20], r14 ^ k[53], r15 ^ k[4],
		r16 ^ k[41], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[2], r16 ^ k[52], r17 ^ k[42], r18 ^ k[29], r19 ^ k[44],
		r20 ^ k[14], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[35], r20 ^ k[50], r21 ^ k[45], r22 ^ k[30], r23 ^ k[1],
		r24 ^ k[51], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[23], r24 ^ k[31], r25 ^ k[43], r26 ^ k[21], r27 ^ k[8],
		r28 ^ k[0], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[37], r28 ^ k[9], r29 ^ k[38], r30 ^ k[22], r31 ^ k[28],
		r0 ^ k[49], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[25], l0 ^ k[46], l1 ^ k[4], l2 ^ k[13], l3 ^ k[48],
		l4 ^ k[19], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[5], l4 ^ k[41], l5 ^ k[32], l6 ^ k[26], l7 ^ k[17],
		l8 ^ k[54], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[6], l8 ^ k[3], l9 ^ k[11], l10 ^ k[12], l11 ^ k[27],
		l12 ^ k[40], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[39], l12 ^ k[33], l13 ^ k[34], l14 ^ k[10], l15 ^ k[18],
		l16 ^ k[55], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[16], l16 ^ k[7], l17 ^ k[1], l18 ^ k[43], l19 ^ k[31],
		l20 ^ k[28], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[49], l20 ^ k[9], l21 ^ k[0], l22 ^ k[44], l23 ^ k[15],
		l24 ^ k[38], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[37], l24 ^ k[45], l25 ^ k[2], l26 ^ k[35], l27 ^ k[22],
		l28 ^ k[14], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[51], l28 ^ k[23], l29 ^ k[52], l30 ^ k[36], l31 ^ k[42],
		l0 ^ k[8], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[39], r0 ^ k[3], r1 ^ k[18], r2 ^ k[27], r3 ^ k[5],
		r4 ^ k[33], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[19], r4 ^ k[55], r5 ^ k[46], r6 ^ k[40], r7 ^ k[6],
		r8 ^ k[11], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[20], r8 ^ k[17], r9 ^ k[25], r10 ^ k[26], r11 ^ k[41],
		r12 ^ k[54], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[53], r12 ^ k[47], r13 ^ k[48], r14 ^ k[24], r15 ^ k[32],
		r16 ^ k[12], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[30], r16 ^ k[21], r17 ^ k[15], r18 ^ k[2], r19 ^ k[45],
		r20 ^ k[42], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[8], r20 ^ k[23], r21 ^ k[14], r22 ^ k[31], r23 ^ k[29],
		r24 ^ k[52], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[51], r24 ^ k[0], r25 ^ k[16], r26 ^ k[49], r27 ^ k[36],
		r28 ^ k[28], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[38], r28 ^ k[37], r29 ^ k[7], r30 ^ k[50], r31 ^ k[1],
		r0 ^ k[22], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[53], l0 ^ k[17], l1 ^ k[32], l2 ^ k[41], l3 ^ k[19],
		l4 ^ k[47], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[33], l4 ^ k[12], l5 ^ k[3], l6 ^ k[54], l7 ^ k[20],
		l8 ^ k[25], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[34], l8 ^ k[6], l9 ^ k[39], l10 ^ k[40], l11 ^ k[55],
		l12 ^ k[11], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[10], l12 ^ k[4], l13 ^ k[5], l14 ^ k[13], l15 ^ k[46],
		l16 ^ k[26], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[44], l16 ^ k[35], l17 ^ k[29], l18 ^ k[16], l19 ^ k[0],
		l20 ^ k[1], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[22], l20 ^ k[37], l21 ^ k[28], l22 ^ k[45], l23 ^ k[43],
		l24 ^ k[7], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[38], l24 ^ k[14], l25 ^ k[30], l26 ^ k[8], l27 ^ k[50],
		l28 ^ k[42], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[52], l28 ^ k[51], l29 ^ k[21], l30 ^ k[9], l31 ^ k[15],
		l0 ^ k[36], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[10], r0 ^ k[6], r1 ^ k[46], r2 ^ k[55], r3 ^ k[33],
		r4 ^ k[4], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[47], r4 ^ k[26], r5 ^ k[17], r6 ^ k[11], r7 ^ k[34],
		r8 ^ k[39], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[48], r8 ^ k[20], r9 ^ k[53], r10 ^ k[54], r11 ^ k[12],
		r12 ^ k[25], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[24], r12 ^ k[18], r13 ^ k[19], r14 ^ k[27], r15 ^ k[3],
		r16 ^ k[40], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[31], r16 ^ k[49], r17 ^ k[43], r18 ^ k[30], r19 ^ k[14],
		r20 ^ k[15], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[36], r20 ^ k[51], r21 ^ k[42], r22 ^ k[0], r23 ^ k[2],
		r24 ^ k[21], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[52], r24 ^ k[28], r25 ^ k[44], r26 ^ k[22], r27 ^ k[9],
		r28 ^ k[1], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[7], r28 ^ k[38], r29 ^ k[35], r30 ^ k[23], r31 ^ k[29],
		r0 ^ k[50], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[24], l0 ^ k[20], l1 ^ k[3], l2 ^ k[12], l3 ^ k[47],
		l4 ^ k[18], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[4], l4 ^ k[40], l5 ^ k[6], l6 ^ k[25], l7 ^ k[48],
		l8 ^ k[53], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[5], l8 ^ k[34], l9 ^ k[10], l10 ^ k[11], l11 ^ k[26],
		l12 ^ k[39], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[13], l12 ^ k[32], l13 ^ k[33], l14 ^ k[41], l15 ^ k[17],
		l16 ^ k[54], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[45], l16 ^ k[8], l17 ^ k[2], l18 ^ k[44], l19 ^ k[28],
		l20 ^ k[29], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[50], l20 ^ k[38], l21 ^ k[1], l22 ^ k[14], l23 ^ k[16],
		l24 ^ k[35], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[7], l24 ^ k[42], l25 ^ k[31], l26 ^ k[36], l27 ^ k[23],
		l28 ^ k[15], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[21], l28 ^ k[52], l29 ^ k[49], l30 ^ k[37], l31 ^ k[43],
		l0 ^ k[9], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[6], r0 ^ k[27], r1 ^ k[10], r2 ^ k[19], r3 ^ k[54],
		r4 ^ k[25], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[11], r4 ^ k[47], r5 ^ k[13], r6 ^ k[32], r7 ^ k[55],
		r8 ^ k[3], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[12], r8 ^ k[41], r9 ^ k[17], r10 ^ k[18], r11 ^ k[33],
		r12 ^ k[46], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[20], r12 ^ k[39], r13 ^ k[40], r14 ^ k[48], r15 ^ k[24],
		r16 ^ k[4], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[52], r16 ^ k[15], r17 ^ k[9], r18 ^ k[51], r19 ^ k[35],
		r20 ^ k[36], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[2], r20 ^ k[45], r21 ^ k[8], r22 ^ k[21], r23 ^ k[23],
		r24 ^ k[42], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[14], r24 ^ k[49], r25 ^ k[38], r26 ^ k[43], r27 ^ k[30],
		r28 ^ k[22], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[28], r28 ^ k[0], r29 ^ k[1], r30 ^ k[44], r31 ^ k[50],
		r0 ^ k[16], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[20], l0 ^ k[41], l1 ^ k[24], l2 ^ k[33], l3 ^ k[11],
		l4 ^ k[39], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[25], l4 ^ k[4], l5 ^ k[27], l6 ^ k[46], l7 ^ k[12],
		l8 ^ k[17], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[26], l8 ^ k[55], l9 ^ k[6], l10 ^ k[32], l11 ^ k[47],
		l12 ^ k[3], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[34], l12 ^ k[53], l13 ^ k[54], l14 ^ k[5], l15 ^ k[13],
		l16 ^ k[18], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[7], l16 ^ k[29], l17 ^ k[23], l18 ^ k[38], l19 ^ k[49],
		l20 ^ k[50], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[16], l20 ^ k[0], l21 ^ k[22], l22 ^ k[35], l23 ^ k[37],
		l24 ^ k[1], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[28], l24 ^ k[8], l25 ^ k[52], l26 ^ k[2], l27 ^ k[44],
		l28 ^ k[36], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[42], l28 ^ k[14], l29 ^ k[15], l30 ^ k[31], l31 ^ k[9],
		l0 ^ k[30], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[34], r0 ^ k[55], r1 ^ k[13], r2 ^ k[47], r3 ^ k[25],
		r4 ^ k[53], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[39], r4 ^ k[18], r5 ^ k[41], r6 ^ k[3], r7 ^ k[26],
		r8 ^ k[6], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[40], r8 ^ k[12], r9 ^ k[20], r10 ^ k[46], r11 ^ k[4],
		r12 ^ k[17], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[48], r12 ^ k[10], r13 ^ k[11], r14 ^ k[19], r15 ^ k[27],
		r16 ^ k[32], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[21], r16 ^ k[43], r17 ^ k[37], r18 ^ k[52], r19 ^ k[8],
		r20 ^ k[9], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[30], r20 ^ k[14], r21 ^ k[36], r22 ^ k[49], r23 ^ k[51],
		r24 ^ k[15], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[42], r24 ^ k[22], r25 ^ k[7], r26 ^ k[16], r27 ^ k[31],
		r28 ^ k[50], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[1], r28 ^ k[28], r29 ^ k[29], r30 ^ k[45], r31 ^ k[23],
		r0 ^ k[44], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[48], l0 ^ k[12], l1 ^ k[27], l2 ^ k[4], l3 ^ k[39],
		l4 ^ k[10], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[53], l4 ^ k[32], l5 ^ k[55], l6 ^ k[17], l7 ^ k[40],
		l8 ^ k[20], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[54], l8 ^ k[26], l9 ^ k[34], l10 ^ k[3], l11 ^ k[18],
		l12 ^ k[6], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[5], l12 ^ k[24], l13 ^ k[25], l14 ^ k[33], l15 ^ k[41],
		l16 ^ k[46], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[35], l16 ^ k[2], l17 ^ k[51], l18 ^ k[7], l19 ^ k[22],
		l20 ^ k[23], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[44], l20 ^ k[28], l21 ^ k[50], l22 ^ k[8], l23 ^ k[38],
		l24 ^ k[29], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[1], l24 ^ k[36], l25 ^ k[21], l26 ^ k[30], l27 ^ k[45],
		l28 ^ k[9], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[15], l28 ^ k[42], l29 ^ k[43], l30 ^ k[0], l31 ^ k[37],
		l0 ^ k[31], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[5], r0 ^ k[26], r1 ^ k[41], r2 ^ k[18], r3 ^ k[53],
		r4 ^ k[24], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[10], r4 ^ k[46], r5 ^ k[12], r6 ^ k[6], r7 ^ k[54],
		r8 ^ k[34], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[11], r8 ^ k[40], r9 ^ k[48], r10 ^ k[17], r11 ^ k[32],
		r12 ^ k[20], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[19], r12 ^ k[13], r13 ^ k[39], r14 ^ k[47], r15 ^ k[55],
		r16 ^ k[3], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[49], r16 ^ k[16], r17 ^ k[38], r18 ^ k[21], r19 ^ k[36],
		r20 ^ k[37], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[31], r20 ^ k[42], r21 ^ k[9], r22 ^ k[22], r23 ^ k[52],
		r24 ^ k[43], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[15], r24 ^ k[50], r25 ^ k[35], r26 ^ k[44], r27 ^ k[0],
		r28 ^ k[23], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[29], r28 ^ k[1], r29 ^ k[2], r30 ^ k[14], r31 ^ k[51],
		r0 ^ k[45], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[19], l0 ^ k[40], l1 ^ k[55], l2 ^ k[32], l3 ^ k[10],
		l4 ^ k[13], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[24], l4 ^ k[3], l5 ^ k[26], l6 ^ k[20], l7 ^ k[11],
		l8 ^ k[48], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[25], l8 ^ k[54], l9 ^ k[5], l10 ^ k[6], l11 ^ k[46],
		l12 ^ k[34], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[33], l12 ^ k[27], l13 ^ k[53], l14 ^ k[4], l15 ^ k[12],
		l16 ^ k[17], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[8], l16 ^ k[30], l17 ^ k[52], l18 ^ k[35], l19 ^ k[50],
		l20 ^ k[51], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[45], l20 ^ k[1], l21 ^ k[23], l22 ^ k[36], l23 ^ k[7],
		l24 ^ k[2], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[29], l24 ^ k[9], l25 ^ k[49], l26 ^ k[31], l27 ^ k[14],
		l28 ^ k[37], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[43], l28 ^ k[15], l29 ^ k[16], l30 ^ k[28], l31 ^ k[38],
		l0 ^ k[0], &r4, &r26, &r14, &r20);
	s1 (r31 ^ k[33], r0 ^ k[54], r1 ^ k[12], r2 ^ k[46], r3 ^ k[24],
		r4 ^ k[27], &l8, &l16, &l22, &l30);
	s2 (r3 ^ k[13], r4 ^ k[17], r5 ^ k[40], r6 ^ k[34], r7 ^ k[25],
		r8 ^ k[5], &l12, &l27, &l1, &l17);
	s3 (r7 ^ k[39], r8 ^ k[11], r9 ^ k[19], r10 ^ k[20], r11 ^ k[3],
		r12 ^ k[48], &l23, &l15, &l29, &l5);
	s4 (r11 ^ k[47], r12 ^ k[41], r13 ^ k[10], r14 ^ k[18], r15 ^ k[26],
		r16 ^ k[6], &l25, &l19, &l9, &l0);
	s5 (r15 ^ k[22], r16 ^ k[44], r17 ^ k[7], r18 ^ k[49], r19 ^ k[9],
		r20 ^ k[38], &l7, &l13, &l24, &l2);
	s6 (r19 ^ k[0], r20 ^ k[15], r21 ^ k[37], r22 ^ k[50], r23 ^ k[21],
		r24 ^ k[16], &l3, &l28, &l10, &l18);
	s7 (r23 ^ k[43], r24 ^ k[23], r25 ^ k[8], r26 ^ k[45], r27 ^ k[28],
		r28 ^ k[51], &l31, &l11, &l21, &l6);
	s8 (r27 ^ k[2], r28 ^ k[29], r29 ^ k[30], r30 ^ k[42], r31 ^ k[52],
		r0 ^ k[14], &l4, &l26, &l14, &l20);
	s1 (l31 ^ k[40], l0 ^ k[4], l1 ^ k[19], l2 ^ k[53], l3 ^ k[6],
		l4 ^ k[34], &r8, &r16, &r22, &r30);
	s2 (l3 ^ k[20], l4 ^ k[24], l5 ^ k[47], l6 ^ k[41], l7 ^ k[32],
		l8 ^ k[12], &r12, &r27, &r1, &r17);
	s3 (l7 ^ k[46], l8 ^ k[18], l9 ^ k[26], l10 ^ k[27], l11 ^ k[10],
		l12 ^ k[55], &r23, &r15, &r29, &r5);
	s4 (l11 ^ k[54], l12 ^ k[48], l13 ^ k[17], l14 ^ k[25], l15 ^ k[33],
		l16 ^ k[13], &r25, &r19, &r9, &r0);
	s5 (l15 ^ k[29], l16 ^ k[51], l17 ^ k[14], l18 ^ k[1], l19 ^ k[16],
		l20 ^ k[45], &r7, &r13, &r24, &r2);
	s6 (l19 ^ k[7], l20 ^ k[22], l21 ^ k[44], l22 ^ k[2], l23 ^ k[28],
		l24 ^ k[23], &r3, &r28, &r10, &r18);
	s7 (l23 ^ k[50], l24 ^ k[30], l25 ^ k[15], l26 ^ k[52], l27 ^ k[35],
		l28 ^ k[31], &r31, &r11, &r21, &r6);
	s8 (l27 ^ k[9], l28 ^ k[36], l29 ^ k[37], l30 ^ k[49], l31 ^ k[0],
		l0 ^ k[21], &r4, &r26, &r14, &r20);

    c[5] = l8;
    c[3] = l16;
    c[51] = l22;
    c[49] = l30;
    c[37] = l12;
    c[25] = l27;
    c[15] = l1;
    c[11] = l17;
    c[59] = l23;
    c[61] = l15;
    c[41] = l29;
    c[47] = l5;
    c[9] = l25;
    c[27] = l19;
    c[13] = l9;
    c[7] = l0;
    c[63] = l7;
    c[45] = l13;
    c[1] = l24;
    c[23] = l2;
    c[31] = l3;
    c[33] = l28;
    c[21] = l10;
    c[19] = l18;
    c[57] = l31;
    c[29] = l11;
    c[43] = l21;
    c[55] = l6;
    c[39] = l4;
    c[17] = l26;
    c[53] = l14;
    c[35] = l20;
    c[4] = r8;
    c[2] = r16;
    c[50] = r22;
    c[48] = r30;
    c[36] = r12;
    c[24] = r27;
    c[14] = r1;
    c[10] = r17;
    c[58] = r23;
    c[60] = r15;
    c[40] = r29;
    c[46] = r5;
    c[8] = r25;
    c[26] = r19;
    c[12] = r9;
    c[6] = r0;
    c[62] = r7;
    c[44] = r13;
    c[0] = r24;
    c[22] = r2;
    c[30] = r3;
    c[32] = r28;
    c[20] = r10;
    c[18] = r18;
    c[56] = r31;
    c[28] = r11;
    c[42] = r21;
    c[54] = r6;
    c[38] = r4;
    c[16] = r26;
    c[52] = r14;
    c[34] = r20;


}
