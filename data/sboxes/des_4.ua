node sbox_des_4 (a:u6) returns (out:u4)
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool
let
	x1 = ~a.1;
	x2 = ~a.3;
	x3 = a.1 | a.3;
	x4 = a.5 & x3;
	x5 = x1 ^ x4;
	x6 = a.2 | a.3;
	x7 = x5 ^ x6;
	x8 = a.1 & a.5;
	x9 = x8 ^ x3;
	x10 = a.2 & x9;
	x11 = a.5 ^ x10;
	x12 = a.4 & x11;
	x13 = x7 ^ x12;
	x14 = x2 ^ x4;
	x15 = a.2 & x14;
	x16 = x9 ^ x15;
	x17 = x5 & x14;
	x18 = a.5 ^ x2;
	x19 = a.2 | x18;
	x20 = x17 ^ x19;
	x21 = a.4 | x20;
	x22 = x16 ^ x21;
	x23 = a.6 & x22;
	x24 = x13 ^ x23;
	out.2 = x24;
	x25 = ~x13;
	x26 = a.6 | x22;
	x27 = x25 ^ x26;
	out.1 = x27;
	x28 = a.2 & x11;
	x29 = x28 ^ x17;
	x30 = a.3 ^ x10;
	x31 = x30 ^ x19;
	x32 = a.4 & x31;
	x33 = x29 ^ x32;
	x34 = x25 ^ x33;
	x35 = a.2 & x34;
	x36 = x24 ^ x35;
	x37 = a.4 | x34;
	x38 = x36 ^ x37;
	x39 = a.6 & x38;
	x40 = x33 ^ x39;
	out.4 = x40;
	x41 = x26 ^ x38;
	x42 = x41 ^ x40;
	out.3 = x42
tel