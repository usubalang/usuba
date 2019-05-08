node SubBytes (s0:v1,s1:v1,s2:v1,s3:v1) returns (ret:v1[4])
let
    s0 ^:= s3;
    s3 ^:= s0 & s1;
    s0 ^:= s1 & s2;
    s1 ^:= s2 & s3;
    s2 ^:= s0 & s3;
    s2 ^:= s1;
    s1 ^:= s0;
    s3 := ~s3;

    ret = (s0, s1, s3, s2)
tel