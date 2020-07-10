# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/Xoodyak-spec-round2.pdf
# Supported mode: ???

# XXX: this is a tricky one because we keep wanting to do in-place
# array updates, especially when it comes to generating Boolean masked
# code.

node theta(A:u32[3][4]) returns (R:u32[3][4])
vars P, E: u32[4]
let
    P = A[0] ^ A[1] ^ A[2];
    forall i in [0, 3] {
        # avoiding (i-1)%4, because usuba will generate a int for |i|, and
        # when i==0, then (i-1)%4 == -1...
        E[i] = (P[(i+3)%4] <<< 5) ^ (P[(i+3)%4] <<< 14);
    }
    forall i in [0, 2] { R[i] = A[i] ^ E }
tel

# XXX: in-place update of A
node rho_west(A:u32[3][4]) returns (R:u32[3][4])
let
    R[0] = A[0];
    R[1] = A[1] >>> 1;
    # XXX: will need temporaries
    forall i in [0, 3] { R[2][i] = A[2][i] <<< 11 }
tel

# XXX: in-place update of A
node iota(A:u32[3][4],rc:u32) returns (R:u32[3][4])
let
    R[0][0]    = A[0][0] ^ rc;
    # XXX: don't want to write these 2 lines:
    R[0][1..3] = A[0][1..3];
    R[1,2]     = A[1,2];
tel

# XXX: in-place update of A
node chi(A:u32[3][4]) returns (R:u32[3][4])
vars B:u32[3][4]
let
    B[0] = (~A[1]) & A[2];
    B[1] = (~A[2]) & A[0];
    B[2] = (~A[0]) & A[1];
    R = A ^ B;
tel

# XXX: in-place update of A
node rho_east(A:u32[3][4]) returns (R:u32[3][4])
let
    R[0] = A[0];
    # XXX: use imperative loops
    forall i in [0, 3] {
      R[1][i] = A[1][i] <<< 1;
      R[2][i] = A[2][(i+2)%4] <<< 8
    }
tel

# XXX: in-place update of state
node round(state:u32[3][4], rc:u32) returns (stateR:u32[3][4])
let
    # XXX: rho_west . theta is not in-place
    stateR = rho_east(chi(iota(rho_west(theta(state)),rc)))
tel


node xoodoo(input:u32[3][4]) returns (output:u32[3][4])
vars state:u32[13][3][4],
     RC:u32[12]
let
    RC = (0x58,0x38,0x3C0,0xD0,0x120,0x14,
          0x60,0x2C,0x380,0xF0,0x1A0,0x12);
    # XXX: use imperative loop
    state[0] = input;
    forall i in [0, 11] {
        state[i+1] = round(state[i], RC[i]);
    }
    output = state[12];
tel