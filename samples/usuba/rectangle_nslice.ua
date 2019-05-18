_no_inline table SubColumn (input:v4) returns (out:v4) {
    6, 5, 12, 10, 1, 14, 7, 9, 11, 0, 3, 13, 8, 15, 4, 2
}

node RL1 (input:u<H>16) returns (out:u<H>16)
let
    out = Shuffle(input,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0])
tel

node RL12 (input:u<H>16) returns (out:u<H>16)
let
    out = Shuffle(input,[12,13,14,15,0,1,2,3,4,5,6,7,8,9,10,11])
tel

node RL13 (input:u<H>16) returns (out:u<H>16)
let
    out = Shuffle(input,[13,14,15,0,1,2,3,4,5,6,7,8,9,10,11,12])
tel

node ShiftRows (input:u<H>16x4) returns (out:u<H>16x4)
vars
let
    out[0] = input[0];
    out[1] = RL1(input[1]);
    out[2] = RL12(input[2]);
    out[3] = RL13(input[3])
tel

node Rectangle (plain:u<H>16x4, key:const u<H>16x4[26]) returns (cipher:u<H>16x4)
vars
    tmp : u<H>16x4[26]
let

    tmp[0] = plain;

    _no_unroll forall i in [0,24] {
      tmp[i+1] = ShiftRows( SubColumn( tmp[i] ^ key[i] ) )
    }

    cipher = tmp[25] ^ key[25]

tel