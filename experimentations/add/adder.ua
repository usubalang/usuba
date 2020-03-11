node full_adder(a:b1,b:b1,cin:b1) returns (s:b1,cout:b1)
let
    s = a ^ b ^ cin;
    cout = (a & b) ^ (cin & (a ^ b));
tel


node add_8(a:b8,b:b8) returns (s:b8)
vars c:b9
let
    c[0] = 0;
    _unroll forall i in [0, 7] {
      (s[i], c[i+1]) = full_adder(a[i], b[i], c[i]);
    }
tel


node add_16(a:b16,b:b16) returns (s:b16)
vars c:b17
let
    c[0] = 0;
    _unroll forall i in [0, 15] {
      (s[i], c[i+1]) = full_adder(a[i], b[i], c[i]);
    }
tel


node add_32(a:b32,b:b32) returns (s:b32)
vars c:b33
let
    c[0] = 0;
    _unroll forall i in [0, 31] {
      (s[i], c[i+1]) = full_adder(a[i], b[i], c[i]);
    }
tel