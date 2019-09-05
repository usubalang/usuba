node xtimes(e:u32) returns (e':u32)
vars
    t, c: u32
let
    t = e << 1;
    c = e >> 3;
    e' = (t & 0xf) ^ c ^ (c << 1)
tel

node step(x:u32[8]) returns (x':u32[8])
vars
    acc:u32
let
    acc  = 0;
    acc := acc ^ x[3] ^ x[5];
    acc := xtimes(acc);
    acc := acc ^ x[1] ^ x[6] ^ x[7];
    acc := xtimes(acc);
    acc := acc ^ x[0] ^ x[2] ^ x[3] ^ x[4] ^ x[7];
    acc := xtimes(acc);
    acc := acc ^ x[3] ^ x[6];
    x' = (x[1..7], acc)
tel

node MixColumnSerial(X:u32) returns (Y:u32)
vars
    x:u32[9][8],
    y:u32[9]
let
    forall i in [0, 7] { x[0][i] = (X >> (28-i*4)) & 0xf }

    forall i in [0, 7] { x[i+1] = step(x[i]) }

    y[0] = 0;
    forall i in [0, 7] { y[i+1] = (y[i] << 4) | x[8][i] }

    Y = y[8]
tel