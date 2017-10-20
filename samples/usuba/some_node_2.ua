node main (a:u10) returns (b:u10)
vars
   x:u10
let
   x.1 = a.1 ^ a.4;
   x.2 = a.2 & a.6;
   x.3 = a.9 ^ a.1;
   x.4 = a.7 | a.3;
   x.5 = ~ a.2;
   x.6 = a.10 & a.2;
   x.7 = a.8 ^ a.4;
   x.8 = a.6 & a.5;
   x.9 = a.10 | a.7;
   x.10 = a.5 | a.9;
   b = x
tel