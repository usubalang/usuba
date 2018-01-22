node sbox_des_2 (a:u6) returns (out:u4)
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool, x43:bool, x44:bool, x45:bool, x46:bool, x47:bool, x48:bool,
	x49:bool, x50:bool, x51:bool, x52:bool, x53:bool, x54:bool, x55:bool, x56:bool
let
	x1 = ~a[4];
	x2 = ~a[0];
	x3 = a[4] ^ a[5];
	x4 = x3 ^ x2;
	x5 = x4 ^ a[1];
	x6 = a[5] | x1;
	x7 = x6 | x2;
	x8 = a[1] & x7;
	x9 = a[5] ^ x8;
	x10 = a[2] & x9;
	x11 = x5 ^ x10;
	x12 = a[1] & x9;
	x13 = a[4] ^ x6;
	x14 = a[2] | x13;
	x15 = x12 ^ x14;
	x16 = a[3] & x15;
	x17 = x11 ^ x16;
	out[1] = x17;
	x18 = a[4] | a[0];
	x19 = a[5] | x18;
	x20 = x13 ^ x19;
	x21 = x20 ^ a[1];
	x22 = a[5] | x4;
	x23 = x22 & x17;
	x24 = a[2] | x23;
	x25 = x21 ^ x24;
	x26 = a[5] | x2;
	x27 = a[4] & x2;
	x28 = a[1] | x27;
	x29 = x26 ^ x28;
	x30 = x3 ^ x27;
	x31 = x2 ^ x19;
	x32 = a[1] & x31;
	x33 = x30 ^ x32;
	x34 = a[2] & x33;
	x35 = x29 ^ x34;
	x36 = a[3] | x35;
	x37 = x25 ^ x36;
	out[2] = x37;
	x38 = x21 & x32;
	x39 = x38 ^ x5;
	x40 = a[0] | x15;
	x41 = x40 ^ x13;
	x42 = a[2] | x41;
	x43 = x39 ^ x42;
	x44 = x28 | x41;
	x45 = a[3] & x44;
	x46 = x43 ^ x45;
	out[0] = x46;
	x47 = x19 & x21;
	x48 = x47 ^ x26;
	x49 = a[1] & x33;
	x50 = x49 ^ x21;
	x51 = a[2] & x50;
	x52 = x48 ^ x51;
	x53 = x18 & x28;
	x54 = x53 & x50;
	x55 = a[3] | x54;
	x56 = x52 ^ x55;
	out[3] = x56
tel