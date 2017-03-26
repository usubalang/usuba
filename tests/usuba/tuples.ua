node assign ( a : uint_6::_, b : uint_4::_, c : uint_2::_ ) returns d : uint_12::_
vars
let
    (c,b) = (b,c);
    d = (b,a,c)
tel