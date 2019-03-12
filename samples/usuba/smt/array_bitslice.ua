node f (a:b4, b:b4) returns (c:b4)
let
    c = a ^ b
tel

node main(a:b4, b:b4) returns (c:b4)
let
    c = f(a,b)
tel