# Specification: https://eprint.iacr.org/2011/697.pdf

table sBox (x:b4) returns (y:b4) {
    #3, 8,15, 1,10, 6, 5,11,14,13, 4, 2, 7, 0, 9,12
    0xe,0xd,0xb,0x0,0x2,0x1,0x4,0xf,0x7,0xa,0x8,0x5,0x9,0xc,0x3,0x6
}

node sBoxLayer(state:b8[20]) returns (stateR:b8[20])
let
    forall i in [0, 19] {
        stateR[i][0..3] = sBox(state[i][0..3]);
        stateR[i][4..7] = sBox(state[i][4..7]);
    }
tel

# node pLayer(state:b160) returns (stateR:b160)
# let
#     forall i in [0, 158] {
#         stateR[(i*40)%159] = state[i];
#     }
#     stateR[159] = state[159];
# tel

node pLayer(state:b8[20]) returns (stateR:b8[20])
vars x:b1[160], PermutedBitNo:nat, y:nat
let
    forall i in [0, 18] {
        forall j in [0, 7] {
            x[i*8+j]      = state[i][7-j];
            stateR[((((8*i+j)*40) % 159) / 8)][7-((((8*i+j)*40) % 159) - (8*((((8*i+j)*40) % 159) / 8)))] = x[i*8+j];
        }
    }
    forall j in [0, 6] {
        x[19*8+j]      = state[19][7-j];
        stateR[((((8*19+j)*40) % 159) / 8)][7-((((8*19+j)*40) % 159) - (8*((((8*19+j)*40) % 159) / 8)))] = x[19*8+j];
    }
    stateR[19][0] = state[19][0];
tel

node counterLayer(state:b8[20],counter:b8) returns (stateR:b8[20])
let
    stateR[1..18] = state[1..18];
    stateR[0]     = state[0]  ^ counter;
    stateR[19]    = state[19] ^ counter[7..0];
tel

node lfsr(counter:b8) returns (counterR:b8)
let
    counterR = ((counter << 1) | (((0x40:b8 & counter) >> 6) ^ ((0x20:b8 & counter) >> 5))) & 0x7f:b8;
tel

node permutation(input:b8[20]) returns (output:b8[20])
vars
    state:b8[81][20],
    counter:b8[81] # Actually u7, but this is maintained manually
let
    state[0]   = input;
    counter[0] = 0x75:b8;

    forall i in [0, 79] {
        state[i+1]   = pLayer(sBoxLayer(counterLayer(state[i],counter[i])));
        counter[i+1] = lfsr(counter[i]);
    }

    output = state[80];
tel