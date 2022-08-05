# [Typing error]: types `u16' and `u8' have different word size: 16 vs 8
node f (x:u8, y:u16) returns (z:u8)
let
    z = x + y
tel
