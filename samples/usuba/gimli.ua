_no_inline node SPbox (col:u32[3]) returns (colR:u32[3])
vars
    x, y, z : u32
let
    x = col[0] <<< 24;
    y = col[1] <<< 9;
    z = col[2];

    colR[2] = x ^ (z << 1) ^ ((y&z) << 2);
    colR[1] = y ^ x        ^ ((x|z) << 1);
    colR[0] = z ^ y        ^ ((x&y) << 3);
tel

node NonlinearLayer (state:u32x4[3]) returns (stateR:u32x4[3])
let
    forall i in [0, 3] {
      stateR[0..2][i] = SPbox(state[0..2][i]);
    }
tel

node SmallSwap (state:u32x4[3]) returns (stateR:u32x4[3])
let
    stateR = (state[0][1,0,3,2], state[1,2][0..3]);
tel

node BigSwap (state:u32x4[3]) returns (stateR:u32x4[3])
let
    stateR = (state[0][2,3,0,1], state[1,2][0..3]);
tel

node AddRC (state:u32x4[3],rc:u32) returns (stateR:u32x4[3])
let
    stateR = (state[0][0] ^ rc, state[0][1..3], state[1,2])
tel

node gimli (state:u32x4[3]) returns (stateR:u32x4[3])
vars
    rc:u32[6],
    round:u32x4[37][3]
let
    rc = (0x9e377918, 0x9e377914, 0x9e377910,
          0x9e37790c, 0x9e377908, 0x9e377904);
    
    round[0] = state;

    forall r in [0,5] {
       round[r*6+1] = NonlinearLayer(round[r*6]);
       round[r*6+2] = AddRC(SmallSwap(round[r*6+1]), rc[r]);
       round[r*6+3] = NonlinearLayer(round[r*6+2]);
       round[r*6+4] = NonlinearLayer(round[r*6+3]);
       round[r*6+5] = BigSwap(round[r*6+4]);
       round[r*6+6] = NonlinearLayer(round[r*6+5]);
    }

    stateR = round[36];
tel