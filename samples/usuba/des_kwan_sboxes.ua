node[] sbox (a:u6) returns (out:u4) [

# S-box 1
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
;
# S-box 2
vars
	x1:bool, x2:bool, x3:bool, x4:bool, x5:bool, x6:bool, x7:bool, x8:bool,
	x9:bool, x10:bool, x11:bool, x12:bool, x13:bool, x14:bool, x15:bool, x16:bool,
	x17:bool, x18:bool, x19:bool, x20:bool, x21:bool, x22:bool, x23:bool, x24:bool,
	x25:bool, x26:bool, x27:bool, x28:bool, x29:bool, x30:bool, x31:bool, x32:bool,
	x33:bool, x34:bool, x35:bool, x36:bool, x37:bool, x38:bool, x39:bool, x40:bool,
	x41:bool, x42:bool, x43:bool, x44:bool, x45:bool, x46:bool, x47:bool, x48:bool,
	x49:bool, x50:bool, x51:bool, x52:bool, x53:bool, x54:bool, x55:bool, x56:bool
let
	x1 = ~a.5;
	x2 = ~a.1;
	x3 = a.5 ^ a.6;
	x4 = x3 ^ x2;
	x5 = x4 ^ a.2;
	x6 = a.6 | x1;
	x7 = x6 | x2;
	x8 = a.2 & x7;
	x9 = a.6 ^ x8;
	x10 = a.3 & x9;
	x11 = x5 ^ x10;
	x12 = a.2 & x9;
	x13 = a.5 ^ x6;
	x14 = a.3 | x13;
	x15 = x12 ^ x14;
	x16 = a.4 & x15;
	x17 = x11 ^ x16;
	out.2 = x17;
	x18 = a.5 | a.1;
	x19 = a.6 | x18;
	x20 = x13 ^ x19;
	x21 = x20 ^ a.2;
	x22 = a.6 | x4;
	x23 = x22 & x17;
	x24 = a.3 | x23;
	x25 = x21 ^ x24;
	x26 = a.6 | x2;
	x27 = a.5 & x2;
	x28 = a.2 | x27;
	x29 = x26 ^ x28;
	x30 = x3 ^ x27;
	x31 = x2 ^ x19;
	x32 = a.2 & x31;
	x33 = x30 ^ x32;
	x34 = a.3 & x33;
	x35 = x29 ^ x34;
	x36 = a.4 | x35;
	x37 = x25 ^ x36;
	out.3 = x37;
	x38 = x21 & x32;
	x39 = x38 ^ x5;
	x40 = a.1 | x15;
	x41 = x40 ^ x13;
	x42 = a.3 | x41;
	x43 = x39 ^ x42;
	x44 = x28 | x41;
	x45 = a.4 & x44;
	x46 = x43 ^ x45;
	out.1 = x46;
	x47 = x19 & x21;
	x48 = x47 ^ x26;
	x49 = a.2 & x33;
	x50 = x49 ^ x21;
	x51 = a.3 & x50;
	x52 = x48 ^ x51;
	x53 = x18 & x28;
	x54 = x53 & x50;
	x55 = a.4 | x54;
	x56 = x52 ^ x55;
	out.4 = x56
tel
;
# S-box 3
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
	x1 = ~a.5;
	x2 = ~a.6;
	x3 = a.5 & a.3;
	x4 = x3 ^ a.6;
	x5 = a.4 & x1;
	x6 = x4 ^ x5;
	x7 = x6 ^ a.2;
	x8 = a.3 & x1;
	x9 = a.5 ^ x2;
	x10 = a.4 | x9;
	x11 = x8 ^ x10;
	x12 = x7 & x11;
	x13 = a.5 ^ x11;
	x14 = x13 | x7;
	x15 = a.4 & x14;
	x16 = x12 ^ x15;
	x17 = a.2 & x16;
	x18 = x11 ^ x17;
	x19 = a.1 & x18;
	x20 = x7 ^ x19;
	out.4 = x20;
	x21 = a.3 ^ a.4;
	x22 = x21 ^ x9;
	x23 = x2 | x4;
	x24 = x23 ^ x8;
	x25 = a.2 | x24;
	x26 = x22 ^ x25;
	x27 = a.6 ^ x23;
	x28 = x27 | a.4;
	x29 = a.3 ^ x15;
	x30 = x29 | x5;
	x31 = a.2 | x30;
	x32 = x28 ^ x31;
	x33 = a.1 | x32;
	x34 = x26 ^ x33;
	out.1 = x34;
	x35 = a.3 ^ x9;
	x36 = x35 | x5;
	x37 = x4 | x29;
	x38 = x37 ^ a.4;
	x39 = a.2 | x38;
	x40 = x36 ^ x39;
	x41 = a.6 & x11;
	x42 = x41 | x6;
	x43 = x34 ^ x38;
	x44 = x43 ^ x41;
	x45 = a.2 & x44;
	x46 = x42 ^ x45;
	x47 = a.1 | x46;
	x48 = x40 ^ x47;
	out.3 = x48;
	x49 = x2 | x38;
	x50 = x49 ^ x13;
	x51 = x27 ^ x28;
	x52 = a.2 | x51;
	x53 = x50 ^ x52;
	x54 = x12 & x23;
	x55 = x54 & x52;
	x56 = a.1 | x55;
	x57 = x53 ^ x56;
	out.2 = x57
tel
;
# S-box 4
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
;
# S-box 5
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
;
# S-box 6
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
;
# S-box 7
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
	x3 = a.2 & a.4;
	x4 = x3 ^ a.5;
	x5 = x4 ^ a.3;
	x6 = a.4 & x4;
	x7 = x6 ^ a.2;
	x8 = a.3 & x7;
	x9 = a.1 ^ x8;
	x10 = a.6 | x9;
	x11 = x5 ^ x10;
	x12 = a.4 & x2;
	x13 = x12 | a.2;
	x14 = a.2 | x2;
	x15 = a.3 & x14;
	x16 = x13 ^ x15;
	x17 = x6 ^ x11;
	x18 = a.6 | x17;
	x19 = x16 ^ x18;
	x20 = a.1 & x19;
	x21 = x11 ^ x20;
	out.1 = x21;
	x22 = a.2 | x21;
	x23 = x22 ^ x6;
	x24 = x23 ^ x15;
	x25 = x5 ^ x6;
	x26 = x25 | x12;
	x27 = a.6 | x26;
	x28 = x24 ^ x27;
	x29 = x1 & x19;
	x30 = x23 & x26;
	x31 = a.6 & x30;
	x32 = x29 ^ x31;
	x33 = a.1 | x32;
	x34 = x28 ^ x33;
	out.4 = x34;
	x35 = a.4 & x16;
	x36 = x35 | x1;
	x37 = a.6 & x36;
	x38 = x11 ^ x37;
	x39 = a.4 & x13;
	x40 = a.3 | x7;
	x41 = x39 ^ x40;
	x42 = x1 | x24;
	x43 = a.6 | x42;
	x44 = x41 ^ x43;
	x45 = a.1 | x44;
	x46 = x38 ^ x45;
	out.2 = x46;
	x47 = x8 ^ x44;
	x48 = x6 ^ x15;
	x49 = a.6 | x48;
	x50 = x47 ^ x49;
	x51 = x19 ^ x44;
	x52 = a.4 ^ x25;
	x53 = x52 & x46;
	x54 = a.6 & x53;
	x55 = x51 ^ x54;
	x56 = a.1 | x55;
	x57 = x50 ^ x56;
	out.3 = x57
tel
;
# S-box 8
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

]



perm expand (a: u32) returns ( out:u48 )  {
     32, 1, 2, 3, 4, 5, 4, 5, 6, 7, 8, 9, 8, 9, 10, 11, 12, 13,
     12, 13, 14, 15, 16, 17, 16, 17, 18, 19, 20, 21, 20, 21,
     22, 23, 24, 25, 24, 25, 26, 27, 28, 29, 28, 29, 30, 31, 32, 1
}

perm init_p (a:u64) returns ( out:u64 ) {
     58, 50, 42, 34, 26, 18, 10, 2, 60, 52, 44, 36, 28, 20, 12, 4,
     62, 54, 46, 38, 30, 22, 14, 6, 64, 56, 48, 40, 32, 24, 16, 8,
     57, 49, 41, 33, 25, 17, 9, 1, 59, 51, 43, 35, 27, 19, 11, 3,
     61, 53, 45, 37, 29, 21, 13, 5, 63, 55, 47, 39, 31, 23, 15, 7
}

perm final_p (a:u64) returns ( out:u64 ) {
     40, 8, 48, 16, 56, 24, 64, 32, 39, 7, 47, 15, 55, 23, 63, 31,
     38, 6, 46, 14, 54, 22, 62, 30, 37, 5, 45, 13, 53, 21, 61, 29,
     36, 4, 44, 12, 52, 20, 60, 28, 35, 3, 43, 11, 51, 19, 59, 27,
     34, 2, 42, 10, 50, 18, 58, 26, 33, 1, 41, 9, 49, 17, 57, 25
}

perm permut ( a:u32 ) returns ( out:u32 ) {
     16, 7, 20, 21, 29, 12, 28, 17, 1, 15, 23, 26, 5, 18, 31, 10,
     2, 8, 24, 14, 32, 27, 3, 9, 19, 13, 30, 6, 22, 11, 4, 25
}


perm[] roundkey (key : u64) returns ( roundkey : u48 )
[
    { 10, 51, 34, 60, 49, 17, 33, 57, 2, 9, 19, 42, 3, 35, 26, 25,
	  44, 58, 59, 1, 36, 27, 18, 41, 22, 28, 39, 54, 37, 4, 47, 30,
	  5, 53, 23, 29, 61, 21, 38, 63, 15, 20, 45, 14, 13, 62, 55, 31 } ;
      
    { 2, 43, 26, 52, 41, 9, 25, 49, 59, 1, 11, 34, 60, 27, 18, 17,
	36, 50, 51, 58, 57, 19, 10, 33, 14, 20, 31, 46, 29, 63, 39, 22,
	28, 45, 15, 21, 53, 13, 30, 55, 7, 12, 37, 6, 5, 54, 47, 23 } ;

    { 51, 27, 10, 36, 25, 58, 9, 33, 43, 50, 60, 18, 44, 11, 2, 1,
	49, 34, 35, 42, 41, 3, 59, 17, 61, 4, 15, 30, 13, 47, 23, 6,
	12, 29, 62, 5, 37, 28, 14, 39, 54, 63, 21, 53, 20, 38, 31, 7 } ;

    { 35, 11, 59, 49, 9, 42, 58, 17, 27, 34, 44, 2, 57, 60, 51, 50,
	33, 18, 19, 26, 25, 52, 43, 1, 45, 55, 62, 14, 28, 31, 7, 53,
	63, 13, 46, 20, 21, 12, 61, 23, 38, 47, 5, 37, 4, 22, 15, 54 } ;

    { 19, 60, 43, 33, 58, 26, 42, 1, 11, 18, 57, 51, 41, 44, 35, 34,
	17, 2, 3, 10, 9, 36, 27, 50, 29, 39, 46, 61, 12, 15, 54, 37,
	47, 28, 30, 4, 5, 63, 45, 7, 22, 31, 20, 21, 55, 6, 62, 38 } ;

    { 3, 44, 27, 17, 42, 10, 26, 50, 60, 2, 41, 35, 25, 57, 19, 18,
	1, 51, 52, 59, 58, 49, 11, 34, 13, 23, 30, 45, 63, 62, 38, 21,
	31, 12, 14, 55, 20, 47, 29, 54, 6, 15, 4, 5, 39, 53, 46, 22 } ;

    { 52, 57, 11, 1, 26, 59, 10, 34, 44, 51, 25, 19, 9, 41, 3, 2,
	50, 35, 36, 43, 42, 33, 60, 18, 28, 7, 14, 29, 47, 46, 22, 5,
	15, 63, 61, 39, 4, 31, 13, 38, 53, 62, 55, 20, 23, 37, 30, 6 } ;

    { 36, 41, 60, 50, 10, 43, 59, 18, 57, 35, 9, 3, 58, 25, 52, 51,
	34, 19, 49, 27, 26, 17, 44, 2, 12, 54, 61, 13, 31, 30, 6, 20,
	62, 47, 45, 23, 55, 15, 28, 22, 37, 46, 39, 4, 7, 21, 14, 53 } ;

    { 57, 33, 52, 42, 2, 35, 51, 10, 49, 27, 1, 60, 50, 17, 44, 43,
	26, 11, 41, 19, 18, 9, 36, 59, 4, 46, 53, 5, 23, 22, 61, 12,
	54, 39, 37, 15, 47, 7, 20, 14, 29, 38, 31, 63, 62, 13, 6, 45 } ;

    { 41, 17, 36, 26, 51, 19, 35, 59, 33, 11, 50, 44, 34, 1, 57, 27,
	10, 60, 25, 3, 2, 58, 49, 43, 55, 30, 37, 20, 7, 6, 45, 63,
	38, 23, 21, 62, 31, 54, 4, 61, 13, 22, 15, 47, 46, 28, 53, 29 } ;

    { 25, 1, 49, 10, 35, 3, 19, 43, 17, 60, 34, 57, 18, 50, 41, 11,
	59, 44, 9, 52, 51, 42, 33, 27, 39, 14, 21, 4, 54, 53, 29, 47,
	22, 7, 5, 46, 15, 38, 55, 45, 28, 6, 62, 31, 30, 12, 37, 13 } ;

    { 9, 50, 33, 59, 19, 52, 3, 27, 1, 44, 18, 41, 2, 34, 25, 60,
	43, 57, 58, 36, 35, 26, 17, 11, 23, 61, 5, 55, 38, 37, 13, 31,
	6, 54, 20, 30, 62, 22, 39, 29, 12, 53, 46, 15, 14, 63, 21, 28 } ;

    { 58, 34, 17, 43, 3, 36, 52, 11, 50, 57, 2, 25, 51, 18, 9, 44,
	27, 41, 42, 49, 19, 10, 1, 60, 7, 45, 20, 39, 22, 21, 28, 15,
	53, 38, 4, 14, 46, 6, 23, 13, 63, 37, 30, 62, 61, 47, 5, 12 } ;

    { 42, 18, 1, 27, 52, 49, 36, 60, 34, 41, 51, 9, 35, 2, 58, 57,
	11, 25, 26, 33, 3, 59, 50, 44, 54, 29, 4, 23, 6, 5, 12, 62,
	37, 22, 55, 61, 30, 53, 7, 28, 47, 21, 14, 46, 45, 31, 20, 63 } ;

    { 26, 2, 50, 11, 36, 33, 49, 44, 18, 25, 35, 58, 19, 51, 42, 41,
	60, 9, 10, 17, 52, 43, 34, 57, 38, 13, 55, 7, 53, 20, 63, 46,
	21, 6, 39, 45, 14, 37, 54, 12, 31, 5, 61, 30, 29, 15, 4, 47 } ;

    { 18, 59, 42, 3, 57, 25, 41, 36, 10, 17, 27, 50, 11, 43, 34, 33,
	52, 1, 2, 9, 44, 35, 26, 49, 30, 5, 47, 62, 45, 12, 55, 38,
	13, 61, 31, 37, 6, 29, 46, 4, 23, 28, 53, 22, 21, 7, 63, 39 } 
]


node des_single ( left_in : u32, right_in : u32, key : u48 )
        returns ( out : u64 )
vars
    sbox_in : u6[8], sbox_out : u4[8]
let
    # Initial expansion and xor with the key
    sbox_in = expand(right_in) ^ key;

    # Computing the s-boxes
    forall i in [0,7], sbox_out[i] = sbox[i](sbox_in[i]);

    # linear permutation and final xor and switch left/right
    out = (right_in,left_in ^ permut(sbox_out))
tel

node des ( plaintext : u64, key : u64 )
     returns ( ciphered : u64 )
vars
    des : u64[17],
    left : u32, right : u32
let
    # Initialisation (initial permutation)
    des[0] = init_p(plaintext);
    
    # Computing the 16 rounds
    forall i in [1,16], des[i] = des_single(des[i-1],roundkey[i-1](key));

    # Regrouping left and right and computing final permuation
    (left,right) = des[16];
    ciphered = final_p(right,left)
tel
