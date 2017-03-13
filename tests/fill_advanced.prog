node[] key(in:uint_4::_,in2:uint_2::_) returns out:uint_4::_
[
    vars
    let
        (out.1,out.4,out.2,out.3) = in
    tel ;

    vars
    let
        (out.4,out.3,out.2,out.1) = in
    tel ;

    vars
    let
        out = (in2.1,in2.2,in.1,in.4)
    tel

]

node<i> f(in: uint_4::_, in2:uint_2::_) returns out:uint_4::_, out2:uint_2::_
vars
let
    out = key[i](in,in2);
    out2 = in2
tel

node main(init:uint_4::_,supp:uint_2::_) returns out: uint_4::_
vars
    tmp: uint_4[3]::_,
    tmp2: uint_2[3]::_
let
    (tmp,tmp2) = fill_i<f;3>(and(and(init,init),init),supp);
    out = tmp[3]
tel