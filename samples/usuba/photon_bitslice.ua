# Bitsliced version (only known version)
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/photon-beetle-spec-round2.pdf
# Supported mode: bitslicing

table Sbox : b4 -> b4 {
    12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2
}

node SubCells(*x:b4[8][8])
let
    forall i in [0, 7] {
        forall j in [0, 7] {
            # XXX: use lifting from b4 to b4[8][8]
            x[i][j] := Sbox(x[i][j])
        }
    }
tel

node ShiftRows(x:b4[8][8]) returns (y:b4[8][8])
let
    forall i in [0, 7] {
        forall j in [0, 7] {
            # XXX: using lifting from b4[8] to b4[>8<][8] (on inner dimension)
            y[i][j] = x[i][(j+i) % 8]
        }
    }
tel

node AddConstant(*x:b4[8][8],rc:b4)
vars
    IC : b4[8]
let
    IC = (0:b4, 1:b4, 3:b4, 7:b4, 15:b4, 14:b4, 12:b4, 8:b4);
    forall i in [0, 7] {
        x[i][0] ^:= rc ^ IC[i];
    }
tel

# BEGIN MATRIX MULT
node xtimes(*e:b4)
vars
    t, c: b4
let
    t = e << 1;
    c = e >> 3;
    e := (t & 0xf:b4) ^ c ^ (c << 1)
tel

node step(*x:b4[8])
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
    x := (x[1..7], acc)
tel

node MixColumnRow(*X:b4[8])
let
    forall i in [0, 8] {
    i = 0: X := X & (0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf)
    _    : X := step(X)
    }
tel
# END MATRIX MULT

node MixColumnSerial(*X:b4[8][8])
let
    # XXX: lifting MixColumnRow from b4[8] to b4[>8<][8]
    forall i in [0, 7] { X[0..7][i] := MixColumnRow(X[0..7][i]) }
tel


node Photon(plain:b4[8][8]) returns (cipher:b4[8][8])
vars
    RC : b4[12],
    state:b4[8][8]
let
    RC = (1, 3, 7, 14, 13, 11, 6, 12, 9, 2, 5, 10);

    forall i in [0, 11] {
     i = 0: state = plain;
     _    : state :=
              MixColumnSerial(
                ShiftRows(
                  SubCells(
                    AddConstant(state, RC[i]))));
    }
    cipher = state
tel