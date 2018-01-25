
perm ShiftRows_single (inputSR:u16x1) returns (out:u16x1) {
      0,  1,  2,  3,
      5,  6,  7,  4,
     10, 11,  8,  9,
     15, 12, 13, 14
}

node ShiftRows (inputSR:u16x8) returns (out:u16x8)
vars
let
    forall i in [0,7] { out[i] = ShiftRows_single(inputSR[i]) }
tel