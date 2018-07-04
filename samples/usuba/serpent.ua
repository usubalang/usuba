#pragma vectorization

_no_inline table[] sbox (input:u32x4) returns (out:u32x4) [
    { 3, 8,15, 1,10, 6, 5,11,14,13, 4, 2, 7, 0, 9,12 } ;
	{15,12, 2, 7, 9, 0, 5,10, 1,11,14, 8, 6,13, 3, 4 } ;
	{ 8, 6, 7, 9, 3,12,10,15,13, 1,14, 4, 0,11, 5, 2 } ;
	{ 0,15,11, 8,12, 9, 6, 3,13, 1, 2, 4,10, 7, 5,14 } ;
	{ 1,15, 8, 3,12, 0,11, 6, 2, 5, 4,10, 9,14, 7,13 } ;
	{15, 5, 2,11, 4,10, 9,12, 0, 3,14, 8,13, 6, 7, 1 } ;
	{ 7, 2,12, 5, 8, 4, 6,11,14, 9, 1,15,13, 3,10, 0 } ;
	{ 1,13,15, 0,14, 8, 2,11, 7, 4,12,10, 9, 3, 5, 6 }
]


_no_inline node transform (input:u32x4) returns (out:u32x4)
vars
    x0:u32x1[4],
    x1:u32x1[3],
    x2:u32x1[4],
    x3:u32x1[3]
let
    (x0[0],x1[0],x2[0],x3[0]) = input;
    x0[1] = x0[0] <<< 13;
    x2[1] = x2[0] <<< 3;
    x1[1] = x1[0] ^ x0[1] ^ x2[1];
    x3[1] = x3[0] ^ x2[1] ^ (x0[1] << 3);
    x1[2] = x1[1] <<< 1;
    x3[2] = x3[1] <<< 7;
    x0[2] = x0[1] ^ x1[2] ^ x3[2];
    x2[2] = x2[1] ^ x3[2] ^ (x1[2] << 7);
    x0[3] = x0[2] <<< 5;
    x2[3] = x2[2] <<< 22;
    out = (x0[3],x1[2],x2[3],x3[2])
tel

node Serpent (plaintext:u32x4, keys:u32x4[33]) returns (ciphertext:u32x4)
vars
    tmp : u32x4[32]
let
    tmp[0] = plaintext;

    forall i in [0,30] {
        tmp[i+1] = transform(sbox<i%8>(tmp[i] ^ keys[i]))
    }

    ciphertext = sbox<7>(tmp[31] ^ keys[31]) ^ keys[32]
    
tel