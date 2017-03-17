node nor (x:u2::_, y:u2::_) returns out:u2::_
vars
let
    out = !(x | y)
tel

node main (in:u4::_) returns out:u2::_
vars
    x:u2::_,
    y:u2::_,
    t:u2::_
let
    x = (in.1,in.2);
    y = (in.3,in.4);
    out = nor(x,y)
tel
    
    