node sbox_des_1 (a:u6) returns (out:u4)
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool, x43:bool, x44:bool, x45:bool, x46:bool, x47:bool, x48:bool,
	x49:bool, x50:bool, x51:bool, x52:bool, x53:bool, x54:bool, x55:bool, x56:bool,
	x57:bool, x58:bool, x59:bool, x60:bool, x61:bool, x62:bool, x63:bool
let
	x1 = ~a.4;
	x2 = ~a.1;
	x3 = a.4 ^ a.3;
	x4 = x3 ^ x2;
	x5 = a.3 | x2;
	x6 = x5 & x1;
	x7 = a.6 | x6;
	x8 = x4 ^ x7;
	x9 = x1 | x2;
	x10 = a.6 & x9;
	x11 = x7 ^ x10;
	x12 = a.2 | x11;
	x13 = x8 ^ x12;
	x14 = x9 ^ x13;
	x15 = a.6 | x14;
	x16 = x1 ^ x15;
	x17 = ~x14;
	x18 = x17 & x3;
	x19 = a.2 | x18;
	x20 = x16 ^ x19;
	x21 = a.5 | x20;
	x22 = x13 ^ x21;
	out.4 = x22;
	x23 = a.3 | x4;
	x24 = ~x23;
	x25 = a.6 | x24;
	x26 = x6 ^ x25;
	x27 = x1 & x8;
	x28 = a.2 | x27;
	x29 = x26 ^ x28;
	x30 = x1 | x8;
	x31 = x30 ^ x6;
	x32 = x5 & x14;
	x33 = x32 ^ x8;
	x34 = a.2 & x33;
	x35 = x31 ^ x34;
	x36 = a.5 | x35;
	x37 = x29 ^ x36;
	out.1 = x37;
	x38 = a.3 & x10;
	x39 = x38 | x4;
	x40 = a.3 & x33;
	x41 = x40 ^ x25;
	x42 = a.2 | x41;
	x43 = x39 ^ x42;
	x44 = a.3 | x26;
	x45 = x44 ^ x14;
	x46 = a.1 | x8;
	x47 = x46 ^ x20;
	x48 = a.2 | x47;
	x49 = x45 ^ x48;
	x50 = a.5 & x49;
	x51 = x43 ^ x50;
	out.2 = x51;
	x52 = x8 ^ x40;
	x53 = a.3 ^ x11;
	x54 = x53 & x5;
	x55 = a.2 | x54;
	x56 = x52 ^ x55;
	x57 = a.6 | x4;
	x58 = x57 ^ x38;
	x59 = x13 & x56;
	x60 = a.2 & x59;
	x61 = x58 ^ x60;
	x62 = a.5 & x61;
	x63 = x56 ^ x62;
	out.3 = x63
tel