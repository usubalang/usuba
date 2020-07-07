# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/SKINNY-spec-round2.pdf

node sbox_calc(a:b8) returns (b:b8)
let
    b = (a[0], a[1], a[2], a[3] ^ ~(a[0] | a[1]),
         a[4], a[5], a[6], a[7] ^ ~(a[4] | a[5]))
tel

perm sbox_perm(a:b8) returns (b:b8) {
     6, 7, 1, 2, 4, 8, 5, 3
}

perm sbox_last_perm(a:b8) returns (b:b8) {
     1, 2, 3, 4, 5, 7, 6, 8
}

node sbox_quarter(a:b8) returns (b:b8)
let
    b = sbox_perm(sbox_calc(a))
tel

node sbox_last_quarter(a:b8) returns (b:b8)
let
    b = sbox_last_perm(sbox_calc(a))
tel

node sbox(a:b8) returns (b:b8)
let
    b = sbox_last_quarter(sbox_quarter(sbox_quarter(sbox_quarter(a))))
tel

node SubCell(state:b8[4][4]) returns (stateR:b8[4][4])
let
    forall i in [0, 3] {
      forall j in [0, 3] {
        stateR[i][j] = sbox(state[i][j])
      }
    }
tel

node AddConstants(state:b8[4][4], c:b8) returns (stateR:b8[4][4])
let
    stateR[0][0] = state[0][0] ^ (c & 0xf:b8);
    stateR[1][0] = state[1][0] ^ ((c >> 4) & 0x3:b8);
    stateR[2][0] = state[2][0] ^ 0x2:b8;

    stateR[0,1,2][1,2,3] = state[0,1,2][1,2,3];
    stateR[3] = state[3];
tel

node AddKey(state:b8[4][4], keyCells:b8[2][4][4])
     returns (stateR:b8[4][4], keyCellsR:b8[2][4][4])
vars
    keyCells16 : b8[2][16],
    keyCells_tmp : b8[2][4][4]
let
    // apply the subtweakey to the internal state
    forall i in [0, 1] {
        forall j in [0, 3] {
            stateR[i][j] = state[i][j] ^ keyCells[0][i][j] ^ keyCells[1][i][j];
        }
    }
    stateR[2,3] = state[2,3];

    // update the subtweakey states with the permutation
    keyCells16 = keyCells;
    keyCells16[0] := keyCells16[0][9,15,8,13,10,14,12,11,0,1,2,3,4,5,6,7];
    keyCells16[1] := keyCells16[1][9,15,8,13,10,14,12,11,0,1,2,3,4,5,6,7];
    keyCells_tmp = keyCells16;

    // update the subtweakey states with the LFSRs
     forall i in [0, 1] {
       forall j in [0, 3] {
        keyCellsR[1][i][j] = ((keyCells_tmp[1][i][j]<<1)&0xfe:b8)^((keyCells_tmp[1][i][j]>>7)&0x01:b8)^((keyCells_tmp[1][i][j]>>5)&0x01:b8);
      }
    }
    keyCellsR[0] = keyCells_tmp[0];
    keyCellsR[1][2,3] = keyCells_tmp[1][2,3]
tel

node ShiftRows(state:b8[16]) returns (stateR:b8[16])
let
    stateR = state[0, 1, 2, 3, 7, 4, 5, 6, 10, 11, 8, 9, 13, 14, 15, 12]
tel

node MixColumn(state:b8[4][4]) returns (stateR:b8[4][4])
let
    forall j in [0, 3] {
        state[1][j] ^:= state[2][j];
        state[2][j] ^:= state[0][j];
        state[3][j] ^:= state[2][j];

        stateR[3,2,1,0][j] = state[2,1,0,3][j];
    }
tel

node Skinny (input:b8[4][4], tweaky:b8[32]) returns (output:b8[4][4])
vars
    state: b8[49][4][4],
    keyCells : b8[49][2][4][4],
    RC : b8[48],
    tmp : b8[48][4][4]
let
    RC = ( 0x01:b8, 0x03:b8, 0x07:b8, 0x0F:b8, 0x1F:b8, 0x3E:b8, 0x3D:b8, 0x3B:b8, 0x37:b8, 0x2F:b8,
		   0x1E:b8, 0x3C:b8, 0x39:b8, 0x33:b8, 0x27:b8, 0x0E:b8, 0x1D:b8, 0x3A:b8, 0x35:b8, 0x2B:b8,
		   0x16:b8, 0x2C:b8, 0x18:b8, 0x30:b8, 0x21:b8, 0x02:b8, 0x05:b8, 0x0B:b8, 0x17:b8, 0x2E:b8,
		   0x1C:b8, 0x38:b8, 0x31:b8, 0x23:b8, 0x06:b8, 0x0D:b8, 0x1B:b8, 0x36:b8, 0x2D:b8, 0x1A:b8,
		   0x34:b8, 0x29:b8, 0x12:b8, 0x24:b8, 0x08:b8, 0x11:b8, 0x22:b8, 0x04:b8 );

    state[0] = input;
    keyCells[0] = tweaky;

    forall i in [0, 47] {
        (tmp[i], keyCells[i+1]) = AddKey(AddConstants(SubCell(state[i]), RC[i]), keyCells[i]);
        state[i+1] = MixColumn(ShiftRows(tmp[i]))
    }

    output = state[48]

tel