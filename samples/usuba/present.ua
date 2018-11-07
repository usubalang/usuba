#pragma bitslicing

table sbox (a:u4) returns (out:u4) {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

perm pLayer (a:u64) returns (out:u64) {
      0, 16, 32, 48,  1, 17, 33, 49,  2, 18, 34, 50,  3, 19, 35, 51,
      4, 20, 36, 52,  5, 21, 37, 53,  6, 22, 38, 54,  7, 23, 39, 55,
      8, 24, 40, 56,  9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59,
     12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63
}

node present_round (inp:u64, key:u64) returns (out:u64)
vars
    sbox_in  : u4[16],
    sbox_out : u4[16]
let
    sbox_in = inp ^ key;
    forall i in [0, 15] { sbox_out[i] = sbox(sbox_in[i]) }
    out = pLayer(sbox_out)
tel

node present (plain:u64, key:u64[32]) returns (cipher:u64)
vars
    tmp : u64[32]
let
    tmp[0] = plain;
    forall i in [1, 31] {
      tmp[i] = present_round(tmp[i-1], key[i-1])
    }
    cipher = tmp[31] ^ key[31]
tel