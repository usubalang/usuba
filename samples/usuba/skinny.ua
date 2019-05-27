node sbox_calc(a:v8) returns (b:v8)
let
    b = (a[0], a[1], a[2], a[3] ^ ~(a[0] | a[1]),
         a[4], a[5], a[6], a[7] ^ ~(a[4] | a[5]))
tel

perm sbox_perm(a:v8) returns (b:v8) {
     6, 7, 1, 2, 4, 8, 5, 3
}

perm sbox_last_perm(a:v8) returns (b:v8) {
     1, 3, 2, 4, 5, 7, 6, 8
}

node sbox_quarter(a:v8) returns (b:v8)
let
    b = sbox_perm(sbox_calc(a))
tel

node sbox_last_quarter(a:v8) returns (b:v8)
let
    b = sbox_last_perm(sbox_calc(a))
tel

node sbox(a:v8) returns (b:v8)
let
    b = sbox_last_quarter(sbox_quarter(sbox_quarter(sbox_quarter(a))))
tel

_no_inline node SubCell(state:u8[4][4]) returns (stateR:u8[4][4])
let
    forall i in [0, 3] {
      forall j in [0, 3] {
        stateR[i][j] = sbox(state[i][j])
      }
    }
tel

node AddConstants(state:u8[4][4], c:u8) returns (stateR:u8[4][4])
let
    stateR[0][0] = state[0][0] ^ (c & 0xf);
    stateR[1][0] = state[1][0] ^ ((c >> 4) & 0x3);
    stateR[2][0] = state[2][0] ^ 0x2;

    stateR[0,1,2][1,2,3] = state[0,1,2][1,2,3];
    stateR[3] = state[3];
tel

node AddKey(state:u8[4][4], keyCells:u8[2][4][4])
     returns (stateR:u8[4][4], keyCellsR:u8[2][4][4])
vars
    keyCells16 : u8[2][16],
    keyCells_tmp : u8[2][4][4]
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
        keyCellsR[1][i][j] = ((keyCells_tmp[1][i][j]<<1)&0xFE)^((keyCells_tmp[1][i][j]>>7)&0x01)^((keyCells_tmp[1][i][j]>>5)&0x01);
      }
    }
    keyCellsR[0] = keyCells_tmp[0];
    keyCellsR[1][2,3] = keyCells_tmp[1][2,3]
tel

node ShiftRows(state:u8[16]) returns (stateR:u8[16])
let
    stateR = state[0, 1, 2, 3, 7, 4, 5, 6, 10, 11, 8, 9, 13, 14, 15, 12]
tel

node MixColumn(state:u8[4][4]) returns (stateR:u8[4][4])
let
    forall j in [0, 3] {
        state[1][j] ^:= state[2][j];
        state[2][j] ^:= state[0][j];
        state[3][j] ^:= state[2][j];

        stateR[3,2,1,0][j] = state[2,1,0,3][j];
    }
tel

node Skinny (input:u8[4][4], tweaky:u8[32]) returns (output:u8[4][4])
vars
    state: u8[49][4][4],
    keyCells : u8[49][2][4][4],
    RC : u8[48],
    tmp : u8[4][4]
let
    RC = ( 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3E, 0x3D, 0x3B, 0x37, 0x2F,
		   0x1E, 0x3C, 0x39, 0x33, 0x27, 0x0E, 0x1D, 0x3A, 0x35, 0x2B,
		   0x16, 0x2C, 0x18, 0x30, 0x21, 0x02, 0x05, 0x0B, 0x17, 0x2E,
		   0x1C, 0x38, 0x31, 0x23, 0x06, 0x0D, 0x1B, 0x36, 0x2D, 0x1A,
		   0x34, 0x29, 0x12, 0x24, 0x08, 0x11, 0x22, 0x04 );

    state[0] = input;
    keyCells[0] = tweaky;

    forall i in [0, 47] {
        (tmp, keyCells[i+1]) = AddKey(AddConstants(SubCell(state[i]), RC[i]), keyCells[i]);
        state[i+1] = MixColumn(ShiftRows(tmp))
    }

    output = state[48]

tel