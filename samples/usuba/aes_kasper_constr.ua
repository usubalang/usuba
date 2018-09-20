# _no_inline table SubBytes (input:u1x8) returns (output:u1x8) {
#     99, 124, 119, 123, 242, 107, 111, 197, 48, 1, 103, 43, 254, 215, 171, 118,
#     202, 130, 201, 125, 250, 89, 71, 240, 173, 212, 162, 175, 156, 164, 114, 192,
#     183, 253, 147, 38, 54, 63, 247, 204, 52, 165, 229, 241, 113, 216, 49, 21,
#     4, 199, 35, 195, 24, 150, 5, 154, 7, 18, 128, 226, 235, 39, 178, 117,
#     9, 131, 44, 26, 27, 110, 90, 160, 82, 59, 214, 179, 41, 227, 47, 132,
#     83, 209, 0, 237, 32, 252, 177, 91, 106, 203, 190, 57, 74, 76, 88, 207,
#     208, 239, 170, 251, 67, 77, 51, 133, 69, 249, 2, 127, 80, 60, 159, 168,
#     81, 163, 64, 143, 146, 157, 56, 245, 188, 182, 218, 33, 16, 255, 243, 210,
#     205, 12, 19, 236, 95, 151, 68, 23, 196, 167, 126, 61, 100, 93, 25, 115,
#     96, 129, 79, 220, 34, 42, 144, 136, 70, 238, 184, 20, 222, 94, 11, 219,
#     224, 50, 58, 10, 73, 6, 36, 92, 194, 211, 172, 98, 145, 149, 228, 121,
#     231, 200, 55, 109, 141, 213, 78, 169, 108, 86, 244, 234, 101, 122, 174, 8,
#     186, 120, 37, 46, 28, 166, 180, 198, 232, 221, 116, 31, 75, 189, 139, 138,
#     112, 62, 181, 102, 72, 3, 246, 14, 97, 53, 87, 185, 134, 193, 29, 158,
#     225, 248, 152, 17, 105, 217, 142, 148, 155, 30, 135, 233, 206, 85, 40, 223,
#     140, 161, 137, 13, 191, 230, 66, 104, 65, 153, 45, 15, 176, 84, 187, 22
# }

node InBasisChange(b0:u1x1, b1:u1x1, b2:u1x1, b3:u1x1, b4:u1x1, b5:u1x1, b6:u1x1, b7:u1x1)
     returns (o0:u1x1, o1:u1x1, o2:u1x1, o3:u1x1, o4:u1x1, o5:u1x1, o6:u1x1, o7:u1x1)
vars
    t0:u1x1,t1:u1x1,t2:u1x1,t3:u1x1,t4:u1x1,t5:u1x1,t6:u1x1,
    t7:u1x1,t8:u1x1,t9:u1x1,t10:u1x1,t11:u1x1,t12:u1x1
let
    t0 = b6 ^ b5;
	t1 = b1 ^ b2;
	t2 = b0 ^ t0;
	t3 = t1 ^ b6;
	t4 = b0 ^ b3;
    
	t5 = t4 ^ t3;
	t6 = b7 ^ t4;
	t7 = t2 ^ b7;
	t8 = b4 ^ t6;
	t9 = t2 ^ b4;
    
	t10 = b1 ^ t8;
	t11 = t7 ^ t1;
	t12 = t2 ^ b1;

    (o0, o1, o2, o3, o4, o5, o6, o7) = (t5, t2, b0, t10, t7, t12, t9, t11)
tel

node OutBasisChange(b7:u1x1, b1:u1x1, b4:u1x1, b2:u1x1, b6:u1x1, b5:u1x1, b0:u1x1, b3:u1x1)
     returns (o0:u1x1, o1:u1x1, o2:u1x1, o3:u1x1, o4:u1x1, o5:u1x1, o6:u1x1, o7:u1x1)
vars
    t0:u1x1,t1:u1x1,t2:u1x1,t3:u1x1,t4:u1x1,t5:u1x1,t6:u1x1,
    t7:u1x1,t8:u1x1,t9:u1x1,t10:u1x1
let
	t0 = b7 ^ b0;
	t1 = b1 ^ b6;
	t2 = b4 ^ t0;
	t3 = b6 ^ b0;
	t4 = b0 ^ t1;
    
	t5 = b5 ^ t1;
	t6 = b5 ^ b2;
	t7 = b2 ^ b3;
	t8 = t2 ^ t6;
	t9 = b3 ^ t6;
    
	t10 = t3 ^ t9;

    (o0, o1, o2, o3, o4, o5, o6, o7) = (t4, t5, t8, t10, t9, t0, t7, t6)
tel

node Mul_GF4_N(x0:u1x1, x1:u1x1, y0:u1x1, y1:u1x1)
     returns (o0:u1x1, o1:u1x1)
vars
    t0:u1x1,t1:u1x1,t2:u1x1,t3:u1x1,t4:u1x1,t5:u1x1,t6:u1x1
let
    t0 = y0 ^ y1;
	t1 = x0 & t0;
	t2 = x1 ^ x0;
	t3 = y1 & t2;
	t4 = y0 & x1;
	t5 = t3 ^ t4;
	t6 = t1 ^ t3;

    (o0, o1) = (t6, t5)
tel    

node Mul_GF4(i0:u1x1, i1:u1x1, y0:u1x1, y1:u1x1)
     returns (o0:u1x1, o1:u1x1)
vars
    t0:u1x1,t1:u1x1,t2:u1x1,t3:u1x1,t4:u1x1,t5:u1x1,t6:u1x1
let
    t0 = y0 ^ y1;
	t1 = i0 & t0;
	t2 = i0 ^ i1;
	t3 = y1 & t2;
	t4 = i1 & y0;
	t5 = t4 ^ t3;
	t6 = t1 ^ t4;

    (o0,o1) = (t5,t6)
tel


node Mul_GF16_2(x0:u1x1, x1:u1x1, x2:u1x1, x3:u1x1, x4:u1x1, x5:u1x1, x6:u1x1, x7:u1x1,
                y0:u1x1, y1:u1x1, y2:u1x1, y3:u1x1)
     returns (o0:u1x1, o1:u1x1, o2:u1x1, o3:u1x1, o4:u1x1, o5:u1x1, o6:u1x1, o7:u1x1)
vars
    t0:u1x1,t1:u1x1,t2:u1x1,t3:u1x1,t4:u1x1,t5:u1x1,t6:u1x1,
    t7:u1x1,t8:u1x1,t9:u1x1,t10:u1x1,t11:u1x1,t12:u1x1,
    t13:u1x1,t14:u1x1,t15:u1x1,t16:u1x1,t17:u1x1,t18:u1x1,
    t19:u1x1,t20:u1x1,t21:u1x1,t22:u1x1,t23:u1x1,t24:u1x1,
    t25:u1x1,t26:u1x1,t27:u1x1
let
	(t0,t1) = Mul_GF4(x0,x1,y0,y1);
	t2 = x2 ^ x0;
	t3 = x3 ^ x1;
	t4 = y2 ^ y0;
	t5 = y3 ^ y1;
	(t6,t7) = Mul_GF4_N(t2,t3,t4,t5);
	(t8,t9) = Mul_GF4(x2,x3,y2,y3);
	t10 = t6 ^ t8;
	t11 = t0 ^ t6;
	t12 = t7 ^ t9;
	t13 = t1 ^ t7;
	t14 = x4 ^ x6;
	t15 = x5 ^ x7;
	(t16,t17) = Mul_GF4_N(t14,t15,t4,t5);
	(t18,t19) = Mul_GF4(x6,x7,y2,y3);
	t20 = y2 ^ t4;
	t21 = y3 ^ t5;
	(t22,t23) = Mul_GF4(x4,x5,t20,t21);
	t24 = t16 ^ t22;
	t25 = t16 ^ t18;
	t26 = t17 ^ t23;
	t27 = t17 ^ t19;

    (o0,o1,o2,o3,o4,o5,o6,o7) = (t24, t26, t25, t27, t11, t13, t10, t12)
tel

node Inv_GF256(x0:u1x1, x1:u1x1, x2:u1x1, x3:u1x1, x4:u1x1, x5:u1x1, x6:u1x1, x7:u1x1)
     returns (o0:u1x1, o1:u1x1, o2:u1x1, o3:u1x1, o4:u1x1, o5:u1x1, o6:u1x1, o7:u1x1)
vars
    t0:u1x1,t1:u1x1,t2:u1x1,t3:u1x1,t4:u1x1,t5:u1x1,t6:u1x1,
    t7:u1x1,t8:u1x1,t9:u1x1,t10:u1x1,t11:u1x1,t12:u1x1,
    t13:u1x1,t14:u1x1,t15:u1x1,t16:u1x1,t17:u1x1,t18:u1x1,
    t19:u1x1,t20:u1x1,t21:u1x1,t22:u1x1,t23:u1x1,t24:u1x1,
    t25:u1x1,t26:u1x1,t27:u1x1,t28:u1x1,t29:u1x1,t30:u1x1,
    t31:u1x1,t32:u1x1,t33:u1x1,t34:u1x1,t35:u1x1,t36:u1x1,
    t37:u1x1,t38:u1x1,t39:u1x1,t40:u1x1,t41:u1x1,t42:u1x1,
    t43:u1x1,t44:u1x1,t45:u1x1,t46:u1x1,t47:u1x1,t48:u1x1,t49:u1x1
let
	t0 = x4 ^ x6;
	t1 = x5 ^ x7;
	t2 = x1 ^ x3;
	t3 = x7 ^ x6;
	t4 = x0 ^ x2;
	
	t5 = t0 ^ t1;
	t6 = t1 & t2;
	t7 = t2 | t1;
	t8 = t0 & t4;
	t9 = t4 | t0;
	t10 = t2 ^ t4;
	t11 = t10 & t5;
	t12 = x3 ^ x2;
	t13 = t12 & t3;
	t14 = t13 ^ t9;
	t15 = t13 ^ t7;
	t16 = x4 ^ x5;
	t17 = x1 ^ x0;
	t18 = t16 | t17;
	t19 = t17 & t16;
	t20 = t19 ^ t6;
	t21 = t11 ^ t14;
	t22 = t8 ^ t15;
	t23 = t11 ^ t18;
	t24 = t8 ^ t20;
	t25 = t8 ^ t23;
	t26 = x7 & x3;
	t27 = x6 & x2;
	t28 = x5 & x1;
	t29 = x4 | x0;
	t30 = t26 ^ t21;
	t31 = t27 ^ t22;
	t32 = t28 ^ t25;
	t33 = t29 ^ t24;
	
	t34 = t30 ^ t31;
	t35 = t32 & t30;
	t36 = t33 ^ t35;
	t37 = t34 & t36;
	t38 = t31 ^ t37;
	t39 = t32 ^ t33;
	t40 = t31 ^ t35;
	t41 = t40 & t39;
	t42 = t33 ^ t41;
	t43 = t42 ^ t32;
	t44 = t36 ^ t42;
	t45 = t33 & t44;
	t46 = t45 ^ t43;
	t47 = t45 ^ t36;
	t48 = t38 & t47;
	t49 = t34 ^ t48;
	
	(o0,o1,o2,o3,o4,o5,o6,o7) = Mul_GF16_2(x0, x1, x2, x3, x4, x5, x6, x7, t38, t49, t42, t46)
tel


_no_inline node SubBytes (b7:u1x1,b6:u1x1,b5:u1x1,b4:u1x1,b3:u1x1,b2:u1x1,b1:u1x1,b0:u1x1)
           returns (o7:u1x1,o6:u1x1,o5:u1x1,o4:u1x1,o3:u1x1,o2:u1x1,o1:u1x1,o0:u1x1)
let
    (o0,o1,o2,o3,o4,o5,o6,o7) =
             OutBasisChange(Inv_GF256(InBasisChange(b0,b1,b2,b3,b4,b5,b6,b7)))
tel


node ShiftRows (inputSR:u16x8) returns (out:u16x8)
let
    forall i in [0,7] {
        out[i] = Shuffle(inputSR[i],[  0,  5, 10, 15,
                                       4,  9, 14,  3,
                                       8, 13,  2,  7,
                                      12,  1,  6, 11 ])
     }
tel

node RL32 (input:u16x1) returns (out:u16x1)
let
     out = Shuffle(input,[ 1,  2,  3,  0,  5,  6,  7,  4,
                           9, 10, 11,  8, 13, 14, 15, 12 ])
tel

node RL64 (input:u16x1) returns (out:u16x1)
let
     out = Shuffle(input,[  2,  3,  0,  1,  6,  7,  4,  5,
                           10, 11,  8,  9, 14, 15, 12, 13 ])
tel

# Note: the 7-x are due to the fact that Kasper & Schwabe don't index their array
# the same way we do.
node MixColumn (a:u16x8) returns (b:u16x8)
vars
let
    b[7-0] = (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-0])) ^ RL64(a[7-0] ^ (RL32(a[7-0])));
    b[7-1] = (a[7-0] ^ (RL32(a[7-0]))) ^ (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-1])) ^ RL64(a[7-1] ^ (RL32(a[7-1])));
    b[7-2] = (a[7-1] ^ (RL32(a[7-1]))) ^ (RL32(a[7-2])) ^ RL64(a[7-2] ^ (RL32(a[7-2])));
    b[7-3] = (a[7-2] ^ (RL32(a[7-2]))) ^ (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-3])) ^ RL64(a[7-3] ^ (RL32(a[7-3])));
    b[7-4] = (a[7-3] ^ (RL32(a[7-3]))) ^ (a[7-7] ^ (RL32(a[7-7]))) ^ (RL32(a[7-4])) ^ RL64(a[7-4] ^ (RL32(a[7-4])));
    b[7-5] = (a[7-4] ^ (RL32(a[7-4]))) ^ (RL32(a[7-5])) ^ RL64(a[7-5] ^ (RL32(a[7-5])));
    b[7-6] = (a[7-5] ^ (RL32(a[7-5]))) ^ (RL32(a[7-6])) ^ RL64(a[7-6] ^ (RL32(a[7-6])));
    b[7-7] = (a[7-6] ^ (RL32(a[7-6]))) ^ (RL32(a[7-7])) ^ RL64(a[7-7] ^ (RL32(a[7-7])))
tel



node AES (plain:u16x8,key:u16x8[11]) returns (cipher:u16x8)
vars
    tmp : u16x8[10]
let
    # Initial AddRoundKey
    tmp[0] = plain;

    # 9 rounds (the last is special)
    forall i in [1,9] {
      tmp[i] = MixColumn( ShiftRows( SubBytes( tmp[i-1] ^ key[i-1] ) ) )
    }

    # Last (10th) round (no MixColumn)
    cipher = ShiftRows(SubBytes(tmp[9] ^ key[9])) ^ key[10]

tel