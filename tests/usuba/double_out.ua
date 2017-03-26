node f (a: uint_4::_, b: uint_4::_) returns c:uint_4::_,d:uint_4::_
vars
let
    c = a;
    d = b
tel

node g (a: uint_4::_, b: uint_4::_) returns c:uint_4::_,d:uint_4::_
vars
let
    (c,d) = f(a,b)
tel

node h (a: uint_4::_, b: uint_4::_) returns c:uint_4::_,d:uint_4::_
vars
let
    (c,d) = g(f(a,b))
tel