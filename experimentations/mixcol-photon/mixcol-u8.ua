node xtimes(e:u4) returns (e':u4)
vars
    t, c: u4
let
    t = e << 1;
    c = e >> 3;
    e' = (t & 0xf) ^ c ^ (c << 1)
tel

node step(x:u4[8]) returns (x':u4[8])
vars
    acc:u4
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

node MixColumnSerial(X:u4[8]) returns (Y:u4[8])
vars
    x:u4[9][8],
    y:u4[9]
let
    forall i in [0, 7] { x[0][i] = X[i] & 0xf }

    forall i in [0, 7] { x[i+1] = step(x[i]) }
    
    Y = x[8]
tel