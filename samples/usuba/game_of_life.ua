
node add_bool (a:bool,b:bool,c_in:bool) returns (out:bool,c_out:bool)
vars
    tmp:bool
let
    tmp = a ^ b;
    out = tmp ^ c_in;
    c_out = (a&b) ^ (c_in&tmp)
tel

node add4 (a:u4,b:u4) returns (res:u4)
vars
    carry:bool[4]
let
    carry[0] = 0;
    forall i in [0,3],
       (res.i,carry[i+1]) = add_bool(a.i,b.i,carry[i])
tel

node is_live (v:bool,a:u8) returns (b:bool)
vars
    tmp:u4[8]
let
    forall i in [0,7],
        tmp[i] = (a.i,a.i,a.i,a.i);
    b = (v & (~s1&~s2&s3)) | (~v&(~v1&~v2&v3&v4))
tel
