# Bitsliced version
# Specification: https://csrc.nist.gov/CSRC/media/Projects/lightweight-cryptography/documents/round-2/spec-doc-rnd2/gimli-spec-round2.pdf

# Due to a bug in Usuba, the generic version (which uses u32) cannot
# be directly bitsliced by Usuba. This is why there are two versions
# of Gimli here: the first one uses u32 while the second one uses b32.

# _no_inline node SPbox (col:u32[3]) returns (colR:u32[3])
# vars
#     x, y, z : u32
# let
#     x = col[0] <<< 24;
#     y = col[1] <<< 9;
#     z = col[2];

#     colR[2] = x ^ (z << 1) ^ ((y&z) << 2);
#     colR[1] = y ^ x        ^ ((x|z) << 1);
#     colR[0] = z ^ y        ^ ((x&y) << 3);
# tel

# node NonlinearLayer (state:u32[3][4]) returns (stateR:u32[3][4])
# let
#     forall i in [0, 3] {
#       stateR[0..2][i] = SPbox(state[0..2][i]);
#     }
# tel

# node SmallSwap (state:u32[3][4]) returns (stateR:u32[3][4])
# let
#     stateR = (state[0][1,0,3,2], state[1,2][0..3]);
# tel

# node BigSwap (state:u32[3][4]) returns (stateR:u32[3][4])
# let
#     stateR = (state[0][2,3,0,1], state[1,2][0..3]);
# tel

# node AddRC (state:u32[3][4],rc:u32) returns (stateR:u32[3][4])
# let
#     stateR = (state[0][0] ^ rc, state[0][1..3], state[1,2])
# tel

# node gimli (state:u32[3][4]) returns (stateR:u32[3][4])
# vars
#     rc:u32[6],
#     round:u32[7][3][4]
# let
#     rc = (0x9e377918:u32, 0x9e377914:u32, 0x9e377910:u32,
#           0x9e37790c:u32, 0x9e377908:u32, 0x9e377904:u32);

#     round[0] = state;

#     forall r in [0,5] {
#       round[r+1] = NonlinearLayer(
#                      BigSwap(
#                        NonlinearLayer(
#                          NonlinearLayer(
#                            AddRC(
#                              SmallSwap(
#                                NonlinearLayer(round[r])),
#                               rc[r])))))
#     }
#     stateR = round[6];
# tel


_no_inline node SPbox (col:b32[3]) returns (colR:b32[3])
vars
    x, y, z : b32
let
    x = col[0] <<< 24;
    y = col[1] <<< 9;
    z = col[2];

    colR[2] = x ^ (z << 1) ^ ((y&z) << 2);
    colR[1] = y ^ x        ^ ((x|z) << 1);
    colR[0] = z ^ y        ^ ((x&y) << 3);
tel

node NonlinearLayer (state:b32[3][4]) returns (stateR:b32[3][4])
let
    forall i in [0, 3] {
      stateR[0..2][i] = SPbox(state[0..2][i]);
    }
tel

node SmallSwap (state:b32[3][4]) returns (stateR:b32[3][4])
let
    stateR = (state[0][1,0,3,2], state[1,2][0..3]);
tel

node BigSwap (state:b32[3][4]) returns (stateR:b32[3][4])
let
    stateR = (state[0][2,3,0,1], state[1,2][0..3]);
tel

node AddRC (state:b32[3][4],rc:b32) returns (stateR:b32[3][4])
let
    stateR = (state[0][0] ^ rc, state[0][1..3], state[1,2])
tel

node gimli (state:b32[3][4]) returns (stateR:b32[3][4])
vars
    rc:b32[6],
    round:b32[7][3][4]
let
    rc = (0x9e377918:b32, 0x9e377914:b32, 0x9e377910:b32,
          0x9e37790c:b32, 0x9e377908:b32, 0x9e377904:b32);

    round[0] = state;

    forall r in [0,5] {
      round[r+1] = NonlinearLayer(
                     BigSwap(
                       NonlinearLayer(
                         NonlinearLayer(
                           AddRC(
                             SmallSwap(
                               NonlinearLayer(round[r])),
                              rc[r])))))
    }
    stateR = round[6];
tel