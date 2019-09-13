table sbox (a:v4) returns (out:v4) {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

// Warning: 1-indexed
perm pLayer (a:b64) returns (out:b64) {
      1,  5,  9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61,
      2,  6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62,
      3,  7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63,
      4,  8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64
}

node present_round (inp:b64, key:b64) returns (out:b64)
vars
    sbox_in  : b4[16],
    sbox_out : b4[16]
let
    sbox_in = inp ^ key;
    forall i in [0, 15] { sbox_out[i] = sbox(sbox_in[i]) }
    out = pLayer(sbox_out)
tel

node present (plain:b64, key:b64[2]) returns (cipher:b64)
vars
    tmp : b64[32]
let
    cipher = present_round(plain,key[0]) ^ key[1]
tel