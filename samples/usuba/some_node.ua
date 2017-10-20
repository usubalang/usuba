node main (a:u10) returns (b:u10)
vars
let
   b.1 = a.1 ^ a.4;
   b.2 = a.2 & a.6;
   b.3 = a.9 ^ a.1;
   b.4 = a.7 | a.3;
   b.5 = ~ a.2;
   b.6 = a.10 & a.2;
   b.7 = a.8 ^ a.4;
   b.8 = a.6 & a.5;
   b.9 = a.10 | a.7;
   b.10 = a.5 | a.9
tel