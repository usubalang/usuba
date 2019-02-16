_no_inline table SubColumn_single (input:v4) returns (out:v4) {
    6, 5, 12, 10, 1, 14, 7, 9, 11, 0, 3, 13, 8, 15, 4, 2
}

node SubColumn (input:b64) returns (out:b64)
let
     forall i in  [0,15] {
         out[i,i+16,i+32,i+48] =
            SubColumn_single(input[i,i+16,i+32,i+48])
     }
tel

node ShiftRows (input:b16[4]) returns (out:b16[4])
vars
let
    out[0] = input[0];
    out[1] = input[1] <<< 1;
    out[2] = input[2] <<< 12;
    out[3] = input[3] <<< 13
tel

node Rectangle (plain:b64,key:const b64[26]) returns (cipher:b64)
vars
    tmp : b64[26]
let

    tmp[0] = plain;

    _no_unroll forall i in [0,24] {
      tmp[i+1] = ShiftRows( SubColumn( tmp[i] ^ key[i] ) )
    }

    cipher = tmp[25] ^ key[25]

tel