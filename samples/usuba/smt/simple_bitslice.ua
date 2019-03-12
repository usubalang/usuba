node f (a:b1, b:b1) returns (c:b1)
let
    c = a ^ b
tel

node main(a:b1, b:b1) returns (c:b1)
let
    c = f(a,b)
tel