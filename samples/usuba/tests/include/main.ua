include "aux.ua"

include "inner_dir/other.ua"

node main (x,y:u32) returns (z:u32)
let
    z = plus(times2(x), times3(y))
tel