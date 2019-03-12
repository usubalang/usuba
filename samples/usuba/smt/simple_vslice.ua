node f (a:u8, b:u8) returns (c:u8)
let
    c = a ^ b
tel

node main(a:u8, b:u8) returns (c:u8)
let
    c = f(a,b)
tel