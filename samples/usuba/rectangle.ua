# Specification: https://eprint.iacr.org/2014/084.pdf

_no_inline table SubColumn (input:v4) returns (out:v4) {
    6, 5, 12, 10, 1, 14, 7, 9, 11, 0, 3, 13, 8, 15, 4, 2
}

node ShiftRows (input:u16x4) returns (out:u16x4)
vars
let
    out[0] = input[0];
    out[1] = input[1] <<< 1;
    out[2] = input[2] <<< 12;
    out[3] = input[3] <<< 13
tel

node Rectangle (plain:u16x4,key:const u16x4[26]) returns (cipher:u16x4)
vars
    tmp : u16x4[26]
let

    tmp[0] = plain;

    forall i in [0,24] {
      tmp[i+1] = ShiftRows( SubColumn( tmp[i] ^ key[i] ) )
    }

    cipher = tmp[25] ^ key[25]

tel