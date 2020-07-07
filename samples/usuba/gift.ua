# V-sliced version
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/gift-cofb-spec-round2.pdf

node SubCells(S0,S1,S2,S3:v1) returns (S':v4)
let
    S1 ^:= S0 & S2;
    S0 ^:= S1 & S3;
    S2 ^:= S0 | S1;
    S3 ^:= S2;
    S1 ^:= S3;
    S3 := ~S3;
    S2 ^:= S0 & S1;
    S' = (S3, S1, S2, S0)
tel

node rowperm(S:u32,B0_pos,B1_pos,B2_pos,B3_pos:nat) returns (S':u32)
vars
    T:u32[9]
let
    T[0] = 0;
    forall b in [0,7] {
       T[b+1] = T[b] ^
                (((S>>(4*b+0))&0x1)<<(b + 8*B0_pos)) ^
                (((S>>(4*b+1))&0x1)<<(b + 8*B1_pos)) ^
                (((S>>(4*b+2))&0x1)<<(b + 8*B2_pos)) ^
                (((S>>(4*b+3))&0x1)<<(b + 8*B3_pos));
    }
    S' = T[8];
tel

node PermBits(S:u32x4) returns (S':u32x4)
let
    S'[0] = rowperm(S[0],0,3,2,1);
    S'[1] = rowperm(S[1],1,0,3,2);
    S'[2] = rowperm(S[2],2,1,0,3);
    S'[3] = rowperm(S[3],3,2,1,0);
tel

node AddRoundKey(S:u32x4, W:u32[8], rc:u32) returns (S':u32x4)
let
    S'[2] = S[2] ^ ((W[2] << 16) ^ W[3]);
    S'[1] = S[1] ^ ((W[6] << 16) ^ W[7]);
    S'[3] = S[3] ^ 0x80000000 ^ rc;
    S'[0] = S[0];
tel

node KeyUpdate(W:u32[8]) returns (W':u32[8])
let
    W'[0] = ((W[6] >> 2)  ^ (W[6] << 14)) & 0xffff;
    W'[1] = ((W[7] >> 12) ^ (W[7] << 4))  & 0xffff;
    W'[7..2] = W[5..0];
tel

node gift(P:u32x4, K:const u32[8]) returns (C:u32x4)
vars
    round:u32x4[41],
    W:u32[2][8],
    GIFT_RC:u32[40]
let
    round[0] = P;
    W[0] = K;

    GIFT_RC = (
        0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3E, 0x3D, 0x3B, 0x37, 0x2F,
        0x1E, 0x3C, 0x39, 0x33, 0x27, 0x0E, 0x1D, 0x3A, 0x35, 0x2B,
        0x16, 0x2C, 0x18, 0x30, 0x21, 0x02, 0x05, 0x0B, 0x17, 0x2E,
        0x1C, 0x38, 0x31, 0x23, 0x06, 0x0D, 0x1B, 0x36, 0x2D, 0x1A);

    forall i in [0, 39] {
        round[i+1] =
            AddRoundKey(PermBits(SubCells(round[i])),W[i%2],GIFT_RC[i]);
        W[(i+1)%2] = KeyUpdate(W[i%2]);
    }

    C = round[40]
tel