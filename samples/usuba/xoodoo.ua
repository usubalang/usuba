# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/Xoodyak-spec-round2.pdf
# Supported mode: ???

# XXX: this is a tricky one because we keep wanting to do in-place
# array updates, especially when it comes to generating Boolean masked
# code.

node theta(*A:u32[3][4])
vars P, E: u32[4]
let
    P = A[0] ^ A[1] ^ A[2];
    forall i in [0, 3] {
        # avoiding (i-1)%4, because usuba will generate a int for |i|, and
        # when i==0, then (i-1)%4 == -1...
        E[i] = (P[(i+3)%4] <<< 5) ^ (P[(i+3)%4] <<< 14);
    }
    forall i in [0, 2] { A[i] ^:= E }
tel

node rho_west(*A:u32[3][4])
let

    A[1] >>>:= 1;
    forall i in [0, 3] { A[2][i] <<<:= A[2][i] }
tel

node iota(*A:u32[3][4],rc:u32)
let
    A[0][0] ^:= rc;
tel

node chi(*A:u32[3][4])
let
    A ^:= (~A[1]) & A[2],
           ~A[2]) & A[0],
           ~A[0]) & A[1])
tel


# Equivalently
# node chi(A:u32[3][4]) returns (R:u32[3][4])
# vars B:u32[3][4]
# let
#     B[0] = (~A[1]) & A[2];
#     B[1] = (~A[2]) & A[0];
#     B[2] = (~A[0]) & A[1];
#     R = A ^ B;
# tel

node rho_east(A:u32[3][4]) returns (R:u32[3][4])
let
    R[0] = A[0];
    forall i in [0, 3] {
      R[1][i] = A[1][i] <<< 1;
      R[2][i] = A[2][(i+2)%4] <<< 8
    }
tel

node round(*state:u32[3][4], rc:u32)
let
    # XXX: rho_east is not in-place
    state := rho_east(chi(iota(rho_west(theta(state)),rc)))
tel

# node round(*state:u32[3][4], rc:u32)
# vars
#     tmp:u32[3][4]
# let
#     # 1. Not efficient, if compiled naively
#     tmp = rho_east(chi(iota(rho_west(theta(state)),rc)))
#     state := tmp
#
#     # 2. What we would need to write
#     tmp = chi(iota(rho_west(theta(state)),rc))
#     state := rho_east(tmp)
# tel

# Equivalently, with a flattened composition:

# state := theta(state)
# state := rho_west(state)
# state := iota(state, rc)
# state := chi(state)
# state := rho_east(state)

# state := theta(state)
# state := rho_west(state)
# state := iota(state, rc)
# state := chi(state)
# tmp = rho_east(state)
# state := tmp;

# state := theta(state)
# state := rho_west(state)
# state := iota(state, rc)
# tmp = chi(state)
# state := rho_east(tmp)

# Remark: in generated code
#
# x = a ^ b
#
# performance-wise distinct from
#
# a := a ^ b
# (noise)
# x = a


node xoodoo(input:u32[3][4]) returns (output:u32[3][4])
vars state:u32[3][4],
     RC:u32[12]
let
    RC = (0x58,0x38,0x3C0,0xD0,0x120,0x14,
          0x60,0x2C,0x380,0xF0,0x1A0,0x12);

    forall i in [0, 11] {
      i = 0: state = input;
      _    : state := round(state, RC[i]);
    }

    output = state;
tel