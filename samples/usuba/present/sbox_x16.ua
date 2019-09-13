table sbox (a:v4) returns (out:v4) {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

node sbox_x16 (inp:b4[16]) returns (out:b4[16])
let
    forall i in [0, 15] { out[i] = sbox(inp[i]) }
tel