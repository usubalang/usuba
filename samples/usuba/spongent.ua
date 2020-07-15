# Specification: https://eprint.iacr.org/2011/697.pdf
# Supported mode: ???

table sBox : b4 -> b4 {
    0xe,0xd,0xb,0x0,0x2,0x1,0x4,0xf,0x7,0xa,0x8,0x5,0x9,0xc,0x3,0x6
}

node sBoxLayer(*state:b8[20])
let
    # XXX: first level of lifting
    forall i in [0, 19] {
        # XXX: second level of lifting
        # XXX: lifting b4 -> b8[20] of sBox
        state[i][0..3] := sBox(state[i][0..3]);
        state[i][4..7] := sBox(state[i][4..7]);
    }
tel

# XXX: enable defining a `perm` through an arbitrary bit-mapping
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

node counterLayer(*state:b8[20],counter:b8)
let
    state[0]  ^:= (counter, 0);
    state[19] ^:= (0, counter[6..0]);
tel

# XXX: this may not  actually be in-place?
node lfsr(*counter:b7)
let
    counter :=   (counter << 1)
               | (((0x40 & counter) >> 6)
                ^ ((0x20 & counter) >> 5));
tel

node permutation(input:b8[20]) returns (output:b8[20])
vars
    state:b8[20],
    counter:b7
let

    forall i in [0, 80] {
     i = 0:    state   = input;
               counter = 0x75;
     _    :    state   := pLayer(sBoxLayer(counterLayer(state,counter)));
               counter := lfsr(counter);
    }

    output = state;
tel


# XXX: Is this the "same"? yes if unrolling and constant propagation from counter[0]

# node permutation'(input:b8[20], counter: b7[80]) returns (output:b8[20])
# let
#    ...
# tel

# node permutation(input:b8[20]) returns (output:b8[20])
# vars
#     counter: b7[80]
# let
#     counter[0] = 0x75
#     forall i in [1, 80]{
#       counter[i] = lfsr(counter[i-1])
#     }
#     permutation'(input, counter)
# tel
