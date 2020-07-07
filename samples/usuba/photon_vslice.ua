# H-sliced version
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/photon-beetle-spec-round2.pdf

# Note that Photon Vslice is not valid Usuba per-se: it uses a table,
# which cannot be converted to a circuit given how it's called. (well,
# it would be doable, but would require a lot of machinery in the
# like of sbox(a&1,(a>>1)&1,(a>>2)&1,...))

_no_inline table Sbox (x:u4) returns (y:u4) {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

node SubCells(x:u4[8][8]) returns (y:u4[8][8])
let
    forall i in [0, 7] {
        forall j in [0, 7] {
            y[i][j] = Sbox(x[i][j])
        }
    }
tel

node ShiftRows(x:u4[8][8]) returns (y:u4[8][8])
let
    forall i in [0, 7] {
        forall j in [0, 7] {
            y[i][j] = x[i][(j+i) % 8]
        }
    }
tel

node AddConstant(x:u4[8][8],rc:u4) returns (y:u4[8][8])
vars
    IC : u4[8]
let
    IC = (0, 1, 3, 7, 15, 14, 12, 8);
    forall i in [0, 7] {
        y[i][0] = x[i][0] ^ rc ^ IC[i];
        y[i][1..7] = x[i][1 .. 7];
    }
tel


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

node MixColumnRow(X:u4[8]) returns (Y:u4[8])
vars
    x:u4[9][8],
    y:u4[9]
let
    forall i in [0, 7] { x[0][i] = X[i] & 0xf }

    forall i in [0, 7] { x[i+1] = step(x[i]) }

    Y = x[8]
tel


node MixColumnSerial(X:u4[8][8]) returns (Y:u4[8][8])
let
    forall i in [0, 7] { Y[0..7][i] = MixColumnRow(X[0..7][i]) }
tel


node Photon(plain:u4[8][8]) returns (cipher:u4[8][8])
vars
    RC : u4[12],
    state:u4[13][8][8]
let
    RC = (1, 3, 7, 14, 13, 11, 6, 12, 9, 2, 5, 10);

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