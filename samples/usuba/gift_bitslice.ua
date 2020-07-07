# Bitsliced version
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/gift-cofb-spec-round2.pdf

// We use a different source file for the bitsliced and vsliced codes
// of Gift, because PermBits can be written somewhat more simply when
// doing bitslicing by using a bit permutation (done through indexing
// within an array)

node SubCells(S0,S1,S2,S3:b32) returns (S':b128)
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

node PermBits(S:b32[4]) returns (S':b32[4])
let
    S'[0] = S[0][2,6,10,14,18,22,26,30,1,5,9,13,17,21,25,29,0,4,8,12,16,20,24,28,3,7,11,15,19,23,27,31];
    S'[1] = S[1][1,5,9,13,17,21,25,29,0,4,8,12,16,20,24,28,3,7,11,15,19,23,27,31,2,6,10,14,18,22,26,30];
    S'[2] = S[2][0,4,8,12,16,20,24,28,3,7,11,15,19,23,27,31,2,6,10,14,18,22,26,30,1,5,9,13,17,21,25,29];
    S'[3] = S[3][3,7,11,15,19,23,27,31,2,6,10,14,18,22,26,30,1,5,9,13,17,21,25,29,0,4,8,12,16,20,24,28];
tel

node AddRoundKey(S:b32[4], W:b32[8], rc:b32) returns (S':b32[4])
let
    S'[2] = S[2] ^ ((W[2] << 16) ^ W[3]);
    S'[1] = S[1] ^ ((W[6] << 16) ^ W[7]);
    S'[3] = S[3] ^ 0x80000000:b32 ^ rc;
    S'[0] = S[0];
tel

node KeyUpdate(W:b32[8]) returns (W':b32[8])
let
    W'[0] = ((W[6] >> 2)  ^ (W[6] << 14)) & 0xffff:b32;
    W'[1] = ((W[7] >> 12) ^ (W[7] << 4))  & 0xffff:b32;
    W'[7..2] = W[5..0];
tel

node gift(P:b32[4], K:const b32[8]) returns (C:b32[4])
vars
    round:b32[41][4],
    W:b32[2][8],
    GIFT_RC:b32[40]
let
    round[0] = P;
    W[0] = K;

    GIFT_RC = (
        0x01:b32, 0x03:b32, 0x07:b32, 0x0F:b32, 0x1F:b32,
        0x3E:b32, 0x3D:b32, 0x3B:b32, 0x37:b32, 0x2F:b32,
        0x1E:b32, 0x3C:b32, 0x39:b32, 0x33:b32, 0x27:b32,
        0x0E:b32, 0x1D:b32, 0x3A:b32, 0x35:b32, 0x2B:b32,
        0x16:b32, 0x2C:b32, 0x18:b32, 0x30:b32, 0x21:b32,
        0x02:b32, 0x05:b32, 0x0B:b32, 0x17:b32, 0x2E:b32,
        0x1C:b32, 0x38:b32, 0x31:b32, 0x23:b32, 0x06:b32,
        0x0D:b32, 0x1B:b32, 0x36:b32, 0x2D:b32, 0x1A:b32);

    forall i in [0, 39] {
        round[i+1] =
            AddRoundKey(PermBits(SubCells(round[i])),W[i%2],GIFT_RC[i]);
        W[(i+1)%2] = KeyUpdate(W[i%2]);
    }

    C = round[40]
tel