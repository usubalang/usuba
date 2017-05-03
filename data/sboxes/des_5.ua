node sbox_des_5 (a:u6) returns (out:u4)
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool, x43:bool, x44:bool, x45:bool, x46:bool, x47:bool, x48:bool,
	x49:bool, x50:bool, x51:bool, x52:bool, x53:bool, x54:bool, x55:bool, x56:bool,
	x57:bool, x58:bool, x59:bool, x60:bool, x61:bool, x62:bool
let
	x1 = ~a.6;
	x2 = ~a.3;
	x3 = x1 | x2;
	x4 = x3 ^ a.4;
	x5 = a.1 & x3;
	x6 = x4 ^ x5;
	x7 = a.6 | a.4;
	x8 = x7 ^ a.3;
	x9 = a.3 | x7;
	x10 = a.1 | x9;
	x11 = x8 ^ x10;
	x12 = a.5 & x11;
	x13 = x6 ^ x12;
	x14 = ~x4;
	x15 = x14 & a.6;
	x16 = a.1 | x15;
	x17 = x8 ^ x16;
	x18 = a.5 | x17;
	x19 = x10 ^ x18;
	x20 = a.2 | x19;
	x21 = x13 ^ x20;
	out.3 = x21;
	x22 = x2 | x15;
	x23 = x22 ^ a.6;
	x24 = a.4 ^ x22;
	x25 = a.1 & x24;
	x26 = x23 ^ x25;
	x27 = a.1 ^ x11;
	x28 = x27 & x22;
	x29 = a.5 | x28;
	x30 = x26 ^ x29;
	x31 = a.4 | x27;
	x32 = ~x31;
	x33 = a.2 | x32;
	x34 = x30 ^ x33;
	out.2 = x34;
	x35 = x2 ^ x15;
	x36 = a.1 & x35;
	x37 = x14 ^ x36;
	x38 = x5 ^ x7;
	x39 = x38 & x34;
	x40 = a.5 | x39;
	x41 = x37 ^ x40;
	x42 = x2 ^ x5;
	x43 = x42 & x16;
	x44 = x4 & x27;
	x45 = a.5 & x44;
	x46 = x43 ^ x45;
	x47 = a.2 | x46;
	x48 = x41 ^ x47;
	out.1 = x48;
	x49 = x24 & x48;
	x50 = x49 ^ x5;
	x51 = x11 ^ x30;
	x52 = x51 | x50;
	x53 = a.5 & x52;
	x54 = x50 ^ x53;
	x55 = x14 ^ x19;
	x56 = x55 ^ x34;
	x57 = x4 ^ x16;
	x58 = x57 & x30;
	x59 = a.5 & x58;
	x60 = x56 ^ x59;
	x61 = a.2 | x60;
	x62 = x54 ^ x61;
	out.4 = x62
tel