node f (a:u8x4, b:u8x4) returns (c:u8x4)
let
    c = a ^ b
tel

node main(a:u8x4, b:u8x4) returns (c:u8x4)
let
    c = f(a,b)
tel