_no_inline table SubBytes (i:b4) returns (o:b4) {
  0x2, 0xd, 0x3, 0x9, 0x7, 0xb, 0xa, 0x6, 0xe, 0x0, 0xf, 0x4, 0x8, 0x5, 0x1, 0xc
}

_no_inline node AddRoundKey (i,k:b128) returns (o:b128)
let
    o = i ^ k
tel

_no_inline node SubBytesAll (input:b128) returns (output:b128)
let
    forall i in [0, 31] {
       output[i,32+i,64+i,96+i] = SubBytes(input[i,32+i,64+i,96+i])
    }
tel

node col_mult (a,b:b32) returns (r:b1)
vars
    acc:b32
let
    acc[0] = a[0] & b[0];
    forall i in [1,31] {
        acc[i] = acc[i-1] ^ (a[i] & b[i])
    }
    r = acc[31]
tel

_no_inline node MixRows (input:b32[4]) returns (output:b32[4])
vars
    M: b32[4][33]
let
    M[0][0] = (1,0,1,0,0,0,1,1,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,1);
             #(1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,1,0,1);
             #(1,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,1,0);
    M[1][0] = (0,1,1,0,0,0,1,1,0,1,0,0,0,0,0,1,0,1,1,1,0,0,0,0,0,0,1,0,0,0,0,1);
             #(1,0,0,0,0,1,0,0,0,0,0,0,1,1,1,0,1,0,0,0,0,0,1,0,1,1,0,0,0,1,1,0);
             #(0,1,0,0,0,0,1,0,0,0,0,0,0,1,1,1,0,1,0,0,0,0,0,1,0,1,1,0,0,0,1,1);
    M[2][0] = (0,1,1,0,1,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,0,0,1,0,1,0,0,0,0,0,0,0);
             #(0,0,0,0,0,0,0,1,0,1,0,0,1,1,1,1,0,0,1,1,0,1,0,0,1,0,0,1,0,1,1,0);
             #(0,0,0,0,0,0,0,0,1,0,1,0,0,1,1,1,1,0,0,1,1,0,1,0,0,1,0,0,1,0,1,1);
    M[3][0] = (0,1,0,0,1,0,0,0,1,0,1,0,0,1,0,1,0,1,0,0,1,0,0,0,0,0,0,1,0,0,1,1);
             #(1,1,0,0,1,0,0,0,0,0,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,0,1,0,0,1,0);
             #(0,1,1,0,0,1,0,0,0,0,0,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,0,1,0,0,1);
    forall col in [0,3] {
       forall idx in [0,31] {
           output[col][idx] = col_mult(input[col], M[col][idx]);
           M[col][idx+1] = M[col][idx] >>> 1
       }
    }
tel

node pyjamask (plaintext:b128, key:b128[15]) returns (ciphertext:b128)
vars
    round: b128[15]
let
    round[0] = plaintext;
    forall i in [0, 13] {
        round[i+1] = MixRows(SubBytesAll(AddRoundKey(round[i], key[i])))
    }
    ciphertext = AddRoundKey(round[14], key[14])
tel
