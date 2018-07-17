#pragma bitslicing

node adder (a:u1,b:u1) returns (s:u1,c:u1)
let
    s = a ^ b;
    c = a & b
tel