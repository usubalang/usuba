table SubColumn_single (input:u1x4) returns (out:u1x4) {
    6, 5, 12, 10, 1, 14, 7, 9, 11, 0, 3, 13, 8, 15, 4, 2
}

node SubColumn (input:u1x64) returns (out:u1x64)
let
     forall i in  [0,15] {
         out[i*4 .. i*4+3] = SubColumn_single(input[i*4 .. i*4+3])
     }
tel

node ShiftRows (input:u1x16[4]) returns (out:u1x16[4])
vars
let
    out[0] = input[0];
    out[1] = input[1] <<< 1;
    out[2] = input[2] <<< 12;
    out[3] = input[3] <<< 13
tel

node Rectangle (plain:u1x64,key:const u1x64[26]) returns (cipher:u1x64)
vars
    tmp : u1x64[26]
let

    tmp[0] = plain;

    _no_unroll forall i in [0,24] {
      tmp[i+1] = ShiftRows( SubColumn( tmp[i] ^ key[i] ) )
    }

    cipher = tmp[25] ^ key[25]

tel