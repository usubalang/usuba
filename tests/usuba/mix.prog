table sbox (in:u4::_) returns out:u2::_ {
      01,11,11,11,01,11,11,01,01,11,11,01,11,11,11,01
}

perm init_p (in:u4::_) returns out:u4::_ {
     1,3,2,4
}

node array_var (in: uint_2[2]::_) returns out: uint_2::_
vars
let
    out = in[2]
tel

node[] array_node ( input: uint_2::_ ) returns out: uint_2::_
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

node main (in: u4::_) returns out: u4::_
vars
    t1:u2::_,
    t2:u2[2]::_,
    t3:u2::_,
    t4:u2::_
let
    in = init_p(in);
    t1 = sbox(in);
    (t2[1],t2[2]) = (in.1,in.2,in.3,in.4);
    t3 = array_var(t2);
    t4 = array_node[1](t3);
    out = (t3,t4)
tel