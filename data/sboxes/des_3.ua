node sbox_des_3 (a:u6) returns (out:u4)
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool, x43:bool, x44:bool, x45:bool, x46:bool, x47:bool, x48:bool,
	x49:bool, x50:bool, x51:bool, x52:bool, x53:bool, x54:bool, x55:bool, x56:bool,
	x57:bool
let
	x1 = ~a[4];
	x2 = ~a[5];
	x3 = a[4] & a[2];
	x4 = x3 ^ a[5];
	x5 = a[3] & x1;
	x6 = x4 ^ x5;
	x7 = x6 ^ a[1];
	x8 = a[2] & x1;
	x9 = a[4] ^ x2;
	x10 = a[3] | x9;
	x11 = x8 ^ x10;
	x12 = x7 & x11;
	x13 = a[4] ^ x11;
	x14 = x13 | x7;
	x15 = a[3] & x14;
	x16 = x12 ^ x15;
	x17 = a[1] & x16;
	x18 = x11 ^ x17;
	x19 = a[0] & x18;
	x20 = x7 ^ x19;
	out[3] = x20;
	x21 = a[2] ^ a[3];
	x22 = x21 ^ x9;
	x23 = x2 | x4;
	x24 = x23 ^ x8;
	x25 = a[1] | x24;
	x26 = x22 ^ x25;
	x27 = a[5] ^ x23;
	x28 = x27 | a[3];
	x29 = a[2] ^ x15;
	x30 = x29 | x5;
	x31 = a[1] | x30;
	x32 = x28 ^ x31;
	x33 = a[0] | x32;
	x34 = x26 ^ x33;
	out[0] = x34;
	x35 = a[2] ^ x9;
	x36 = x35 | x5;
	x37 = x4 | x29;
	x38 = x37 ^ a[3];
	x39 = a[1] | x38;
	x40 = x36 ^ x39;
	x41 = a[5] & x11;
	x42 = x41 | x6;
	x43 = x34 ^ x38;
	x44 = x43 ^ x41;
	x45 = a[1] & x44;
	x46 = x42 ^ x45;
	x47 = a[0] | x46;
	x48 = x40 ^ x47;
	out[2] = x48;
	x49 = x2 | x38;
	x50 = x49 ^ x13;
	x51 = x27 ^ x28;
	x52 = a[1] | x51;
	x53 = x50 ^ x52;
	x54 = x12 & x23;
	x55 = x54 & x52;
	x56 = a[0] | x55;
	x57 = x53 ^ x56;
	out[1] = x57
tel