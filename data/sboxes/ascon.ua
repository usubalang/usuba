node Sbox(x:v5) returns (xr:v5)
vars
    x0,x1,x2,x3,x4:v1,
    t0,t1,t2,t3,t4:v1
let
    (x0,x1,x2,x3,x4) = x;

    x0 ^:= x4;
    x4 ^:= x3;
    x2 ^:= x1;

    t0 = ~x0;
    t1 = ~x1;
    t2 = ~x2;
    t3 = ~x3;
    t4 = ~x4;

    t0 &:= x1;
    t1 &:= x2;
    t2 &:= x3;
    t3 &:= x4;
    t4 &:= x0;

    x0 ^:= t1;
    x1 ^:= t2;
    x2 ^:= t3;
    x3 ^:= t4;
    x4 ^:= t0;

    x1 ^:= x0;
    x0 ^:= x4;
    x3 ^:= x2;
    x2 := ~x2;

    xr = (x0,x1,x2,x3,x4)
tel