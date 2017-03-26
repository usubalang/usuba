node[] f ( input: uint_2::_ ) returns out: uint_2::_
[
    vars
    let
        (out.2,out.1) = input
    tel

    ;

    vars
    let
        out = input
    tel
]

node main (in : uint_2::_) returns out: uint_2::_
vars
    tmp: uint_2::_
let
    tmp = f[1](in);
    out = f[2](tmp)
tel