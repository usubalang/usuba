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