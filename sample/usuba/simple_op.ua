node f ( x: u6, y: u6 ) returns ( z: u6 )
vars
let
    x ^= y;
    y |= x;
    x &= !y;
    z = x | y ^ x & y
tel