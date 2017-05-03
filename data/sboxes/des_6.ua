node sbox_des_6 (a:u6) returns (out:u4)
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
	x1 = ~a.2;
	x2 = ~a.5;
	x3 = a.2 ^ a.6;
	x4 = x3 ^ x2;
	x5 = x4 ^ a.1;
	x6 = a.5 & a.6;
	x7 = x6 | x1;
	x8 = a.5 & x5;
	x9 = a.1 & x8;
	x10 = x7 ^ x9;
	x11 = a.4 & x10;
	x12 = x5 ^ x11;
	x13 = a.6 ^ x10;
	x14 = x13 & a.1;
	x15 = a.2 & a.6;
	x16 = x15 ^ a.5;
	x17 = a.1 & x16;
	x18 = x2 ^ x17;
	x19 = a.4 | x18;
	x20 = x14 ^ x19;
	x21 = a.3 & x20;
	x22 = x12 ^ x21;
	out.2 = x22;
	x23 = a.6 ^ x18;
	x24 = a.1 & x23;
	x25 = a.5 ^ x24;
	x26 = a.2 ^ x17;
	x27 = x26 | x6;
	x28 = a.4 & x27;
	x29 = x25 ^ x28;
	x30 = ~x26;
	x31 = a.6 | x29;
	x32 = ~x31;
	x33 = a.4 & x32;
	x34 = x30 ^ x33;
	x35 = a.3 & x34;
	x36 = x29 ^ x35;
	out.4 = x36;
	x37 = x6 ^ x34;
	x38 = a.5 & x23;
	x39 = x38 ^ x5;
	x40 = a.4 | x39;
	x41 = x37 ^ x40;
	x42 = x16 | x24;
	x43 = x42 ^ x1;
	x44 = x15 ^ x24;
	x45 = x44 ^ x31;
	x46 = a.4 | x45;
	x47 = x43 ^ x46;
	x48 = a.3 | x47;
	x49 = x41 ^ x48;
	out.1 = x49;
	x50 = x5 | x38;
	x51 = x50 ^ x6;
	x52 = x8 & x31;
	x53 = a.4 | x52;
	x54 = x51 ^ x53;
	x55 = x30 & x43;
	x56 = a.3 | x55;
	x57 = x54 ^ x56;
	out.3 = x57
tel