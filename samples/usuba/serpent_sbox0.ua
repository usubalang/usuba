table sbox0 (input:u32x4) returns (out:u32x4)  {
  3, 8,15, 1,10, 6, 5,11,14,13, 4, 2, 7, 0, 9,12
}

node main (input:u32x4) returns (out:u32x4)
let
    out = sbox0(input)
tel