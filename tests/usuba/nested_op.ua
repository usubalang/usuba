node f (in:u6::_) returns out:u6::_
vars
let
    out = or(and(not(in),in),and(in,in))
tel
