# NOTE: this should work.
perm ShiftRows_single (inputSR:u16x1) returns (out:u16x1) {
     0,5,10,15,4,9,14,3,8,13,2,7,12,1,6,11
}

node ShiftRows (inputSR:u16x8) returns (out:u16x8)
vars
let
    forall i in [0,7] { out[i] = ShiftRows_single(inputSR[i]) }
tel