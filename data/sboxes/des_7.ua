node sbox_des_7 (a:u6) returns (out:u4)
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
	x1 = ~a[1];
	x2 = ~a[4];
	x3 = a[1] & a[3];
	x4 = x3 ^ a[4];
	x5 = x4 ^ a[2];
	x6 = a[3] & x4;
	x7 = x6 ^ a[1];
	x8 = a[2] & x7;
	x9 = a[0] ^ x8;
	x10 = a[5] | x9;
	x11 = x5 ^ x10;
	x12 = a[3] & x2;
	x13 = x12 | a[1];
	x14 = a[1] | x2;
	x15 = a[2] & x14;
	x16 = x13 ^ x15;
	x17 = x6 ^ x11;
	x18 = a[5] | x17;
	x19 = x16 ^ x18;
	x20 = a[0] & x19;
	x21 = x11 ^ x20;
	out[0] = x21;
	x22 = a[1] | x21;
	x23 = x22 ^ x6;
	x24 = x23 ^ x15;
	x25 = x5 ^ x6;
	x26 = x25 | x12;
	x27 = a[5] | x26;
	x28 = x24 ^ x27;
	x29 = x1 & x19;
	x30 = x23 & x26;
	x31 = a[5] & x30;
	x32 = x29 ^ x31;
	x33 = a[0] | x32;
	x34 = x28 ^ x33;
	out[3] = x34;
	x35 = a[3] & x16;
	x36 = x35 | x1;
	x37 = a[5] & x36;
	x38 = x11 ^ x37;
	x39 = a[3] & x13;
	x40 = a[2] | x7;
	x41 = x39 ^ x40;
	x42 = x1 | x24;
	x43 = a[5] | x42;
	x44 = x41 ^ x43;
	x45 = a[0] | x44;
	x46 = x38 ^ x45;
	out[1] = x46;
	x47 = x8 ^ x44;
	x48 = x6 ^ x15;
	x49 = a[5] | x48;
	x50 = x47 ^ x49;
	x51 = x19 ^ x44;
	x52 = a[3] ^ x25;
	x53 = x52 & x46;
	x54 = a[5] & x53;
	x55 = x51 ^ x54;
	x56 = a[0] | x55;
	x57 = x50 ^ x56;
	out[2] = x57
tel