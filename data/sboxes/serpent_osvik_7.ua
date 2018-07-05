_no_opt node s7 (r0:bool,r1:bool,r2:bool,r3:bool) returns (r5:bool,r6:bool,r7:bool,r8:bool)
vars
    r4 : bool
let
  r4 = r1;
  r1 |= r2;
  r1 ^= r3;
  r4 ^= r2;
  r2 ^= r1;
  r3 |= r4;
  r3 &= r0;
  r4 ^= r2;
  r3 ^= r1;
  r1 |= r4;
  r1 ^= r0;
  r0 |= r4;
  r0 ^= r2;
  r1 ^= r4;
  r2 ^= r1;
  r1 &= r0;
  r1 ^= r4;
  r2 = ~r2;
  r2 |= r0;
  r4 ^= r2;
  r5 = r4;
  r6 = r3;
  r7 = r1;
  r8 = r0
tel