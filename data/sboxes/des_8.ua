node sbox_des_7 (a:u6) returns (out:u4)
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool, x43:bool, x44:bool, x45:bool, x46:bool, x47:bool, x48:bool,
	x49:bool, x50:bool, x51:bool, x52:bool, x53:bool, x54:bool
let
	x1 = ~a.1;
	x2 = ~a.4;
	x3 = a.3 ^ x1;
	x4 = a.3 | x1;
	x5 = x4 ^ x2;
	x6 = a.5 | x5;
	x7 = x3 ^ x6;
	x8 = x1 | x5;
	x9 = x2 ^ x8;
	x10 = a.5 & x9;
	x11 = x8 ^ x10;
	x12 = a.2 & x11;
	x13 = x7 ^ x12;
	x14 = x6 ^ x9;
	x15 = x3 & x9;
	x16 = a.5 & x8;
	x17 = x15 ^ x16;
	x18 = a.2 | x17;
	x19 = x14 ^ x18;
	x20 = a.6 | x19;
	x21 = x13 ^ x20;
	out.1 = x21;
	x22 = a.5 | x3;
	x23 = x22 & x2;
	x24 = ~a.3;
	x25 = x24 & x8;
	x26 = a.5 & x4;
	x27 = x25 ^ x26;
	x28 = a.2 | x27;
	x29 = x23 ^ x28;
	x30 = a.6 & x29;
	x31 = x13 ^ x30;
	out.4 = x31;
	x32 = x5 ^ x6;
	x33 = x32 ^ x22;
	x34 = a.4 | x13;
	x35 = a.2 & x34;
	x36 = x33 ^ x35;
	x37 = a.1 & x33;
	x38 = x37 ^ x8;
	x39 = a.1 ^ x23;
	x40 = x39 & x7;
	x41 = a.2 & x40;
	x42 = x38 ^ x41;
	x43 = a.6 | x42;
	x44 = x36 ^ x43;
	out.3 = x44;
	x45 = a.1 ^ x10;
	x46 = x45 ^ x22;
	x47 = ~x7;
	x48 = x47 & x8;
	x49 = a.2 | x48;
	x50 = x46 ^ x49;
	x51 = x19 ^ x29;
	x52 = x51 | x38;
	x53 = a.6 & x52;
	x54 = x50 ^ x53;
	out.2 = x54
tel