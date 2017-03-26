node des_single (in: uint_64::_, key: uint_64::_) returns out: uint_64::_
vars
let
    out = in
tel

node des_cbc (in: uint_64::_, key: uint_64::_, iv: uint_64::_) returns out: uint_64::_
vars
let
    out = des_single(xor(in,iv),key) fby des_single(xor(out,in), key)
tel