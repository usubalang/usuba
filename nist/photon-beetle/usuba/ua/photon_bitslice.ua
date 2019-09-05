_no_inline table Sbox (x:b4) returns (y:b4) {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

node SubCells(x:b4[8][8]) returns (y:b4[8][8])
let
    forall i in [0, 7] {
        forall j in [0, 7] {
            y[i][j] = Sbox(x[i][j]) 
        }
    }
tel

node ShiftRows(x:b4[8][8]) returns (y:b4[8][8])
let
    forall i in [0, 7] {
        forall j in [0, 7] {
            y[i][j] = x[i][(j+i) % 8]
        }
    }
tel

node AddConstant(x:b4[8][8],rc:b4) returns (y:b4[8][8])
vars
    IC : b4[8]
let
    IC = (0:b4, 1:b4, 3:b4, 7:b4, 15:b4, 14:b4, 12:b4, 8:b4);
    forall i in [0, 7] {
        y[i][0] = x[i][0] ^ rc ^ IC[i];
        y[i][1..7] = x[i][1 .. 7];
    }
tel


node xtimes(e:b4) returns (e':b4)
vars
    t, c: b4
let
    t = e << 1;
    c = e >> 3;
    e' = (t & 0xf:b4) ^ c ^ (c << 1)
tel

node step(x:b4[8]) returns (x':b4[8])
vars
    acc:b4
let
    acc  = 0:b4;
    acc := acc ^ x[3] ^ x[5];
    acc := xtimes(acc);
    acc := acc ^ x[1] ^ x[6] ^ x[7];
    acc := xtimes(acc);
    acc := acc ^ x[0] ^ x[2] ^ x[3] ^ x[4] ^ x[7];
    acc := xtimes(acc);
    acc := acc ^ x[3] ^ x[6];
    x' = (x[1..7], acc)
tel

node MixColumnRow(X:b4[8]) returns (Y:b4[8])
vars
    x:b4[9][8],
    y:b4[9]
let
    forall i in [0, 7] { x[0][i] = X[i] & 0xf:b4 }

    forall i in [0, 7] { x[i+1] = step(x[i]) }
    
    Y = x[8]
tel


node MixColumnSerial(X:b4[8][8]) returns (Y:b4[8][8])
let
    forall i in [0, 7] { Y[0..7][i] = MixColumnRow(X[0..7][i]) }
tel


node Photon(plain:b4[8][8]) returns (cipher:b4[8][8])
vars
    RC : b4[12],
    state:b4[13][8][8]
let
    RC = (1:b4, 3:b4, 7:b4, 14:b4, 13:b4, 11:b4, 6:b4, 12:b4, 9:b4, 2:b4, 5:b4, 10:b4);
    
    state[0] = plain;
    forall i in [0, 11] {
        state[i+1] =
          MixColumnSerial(
            ShiftRows(
              SubCells(
                AddConstant(state[i], RC[i]))));
    }
    cipher = state[12]
tel