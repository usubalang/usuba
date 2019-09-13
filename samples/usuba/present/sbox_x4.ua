table sbox (a:v4) returns (out:v4) {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

node sbox_x4 (inp:b4[4]) returns (out:b4[4])
let
    forall i in [0, 3] { out[i] = sbox(inp[i]) }
tel