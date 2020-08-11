node s3 (x0:v1,x1:v1,x2:v1,x3:v1) returns (x5:v1,x6:v1,x7:v1,x8:v1)
vars x4 : v1
let
  x4   = x1;
  x1 ^:= x3;
  x3 |:= x0;
  x4 &:= x0;
  x0 ^:= x2;
  x2 ^:= x1;
  x1 &:= x3;
  x2 ^:= x3;
  x0 |:= x4;
  x4 ^:= x3;
  x1 ^:= x0;
  x0 &:= x3;
  x3 &:= x4;
  x3 ^:= x2;
  x4 |:= x1;
  x2 &:= x1;
  x4 ^:= x3;
  x0 ^:= x3;
  x3 ^:= x2;

  x5 = x3;
  x6 = x4;
  x7 = x1;
  x8 = x0
tel