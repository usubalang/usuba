# V-sliced version
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/gift-cofb-spec-round2.pdf
# Supported mode: bitslicing, v-slicing, (h-slicing?)

node SubCells(*S:v4)
let
    S[1] ^:= S[0] & S[2];
    S[0] ^:= S[1] & S[3];
    S[2] ^:= S[0] | S[1];
    S[3] ^:= S[2];
    S[1] ^:= S[3];
    S[3] := ~S[3];
    S[2] ^:= S[0] & S[1];
    S := (S[3], S[1], S[2], S[0])
tel

# Equivalently:
# node SubCells(*S0, *S1, *S2, *S3:v1)
# let
#     S1 ^:= S0 & S2;
#     S0 ^:= S1 & S3;
#     S2 ^:= S0 | S1;
#     S3 ^:= S2;
#     S1 ^:= S3;
#     S3 := ~S3;
#     S2 ^:= S0 & S1;
#     (S0, S1, S2, S3) := (S3, S1, S2, S0)
# tel

# Equivalently:
# node SubCells(*S:v4)
# let
#     S[1] ^:= S[0] & S[2];
#     S[0] ^:= S[1] & S[3];
#     S[2] ^:= S[0] | S[1];
#     S[3] ^:= S[2];
#     S[1] ^:= S[3];
#     S[3] := ~S[3];
#     S[2] ^:= S[0] & S[1];
#     forall i in [0,3] {
#       S[i] := S[3-i]  # XXX: Not quite, but in spirit anyways
#     }
# tel

node rowperm<B0_pos,B1_pos,B2_pos,B3_pos>(*S:u32)
vars
    T:u32
let
    T = S;
    forall b in [0,7] {
     b = 0: S := 0;
     _    : S ^:=
                (((T>>(4*b+0))&0x1)<<(b + 8*B0_pos)) ^
                (((T>>(4*b+1))&0x1)<<(b + 8*B1_pos)) ^
                (((T>>(4*b+2))&0x1)<<(b + 8*B2_pos)) ^
                (((T>>(4*b+3))&0x1)<<(b + 8*B3_pos));
    }
tel

node PermBits(*S:u32x4)
let
    S[0] := rowperm(S[0],0,3,2,1);
    S[1] := rowperm(S[1],1,0,3,2);
    S[2] := rowperm(S[2],2,1,0,3);
    S[3] := rowperm(S[3],3,2,1,0);
tel


node AddRoundKey(*S:u32x4, W:u16[8], rc:u32)
let
    S[2] := S[2] ^ pack(W[2], W[3]);
    S[1] := S[1] ^ pack(W[6], W[7]);
    S[3] := S[3] ^ 0x80000000 ^ rc;
    S[0] := S[0];
tel

node KeyUpdate(*W:u16[8])
let
    W := (W[5..0],
          ((W[7] >> 12) ^ (W[7] << 4))  & 0xffff,
          ((W[6] >> 2)  ^ (W[6] << 14)) & 0xffff);
tel


# Equivalently:
# node KeyUpdate(W:u16[8])
# let
#     tmp0 = W[0]
#     tmp1 = W[1]
#     W[0] := ((W[6] >> 2)  ^ (W[6] << 14)) & 0xffff;
#     W[1] := ((W[7] >> 12) ^ (W[7] << 4))  & 0xffff;
#     W[7..2] := (W[5..2], tmp1, tmp0)
# tel

node gift(P:u32x4, K:const u16[8]) returns (C:u32x4)
vars
    state:u32x4,
    W:u32[8],
    GIFT_RC:u32[40]
let
    GIFT_RC = (
        0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3E, 0x3D, 0x3B, 0x37, 0x2F,
        0x1E, 0x3C, 0x39, 0x33, 0x27, 0x0E, 0x1D, 0x3A, 0x35, 0x2B,
        0x16, 0x2C, 0x18, 0x30, 0x21, 0x02, 0x05, 0x0B, 0x17, 0x2E,
        0x1C, 0x38, 0x31, 0x23, 0x06, 0x0D, 0x1B, 0x36, 0x2D, 0x1A);

    forall i in [0, 39] {
        i = 0: state = P;
               W = K;
        _    : state := AddStateKey(PermBits(SubCells(state)),W,GIFT_RC[i]);
               W := KeyUpdate(W);
    }

    C = state
tel