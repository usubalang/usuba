node des (plaintext : uint_64::_, key : uint_64::_) returns ciphered : uint_64::_
vars
    left  : uint_32::_,
    right : uint_32::_,
    roundkey : uint_48::_,
    expanded : uint_48::_,
    s1 : uint_6::_, s2 : uint_6::_, s3 : uint_6::_, s4 : uint_6::_,
    s5 : uint_6::_, s6 : uint_6::_, s7 : uint_6::_, s8 : uint_6::_, 
    c : uint_32::_,
    permuted_c : uint_32::_
let

    # Initial permutation, and splitting into left and right 
    (left, right) = init_p(plaintext);

    ################## Main part (the 16 rounds) ##################

    ##### Round 1 #####    

    # expansion (expand), computation of round key (key), xoring those two values
    # then splitting the result unto 8 boxes (the input of the sboxes)
    (s1,s2,s3,s4,s5,s6,s7,s8) = xor(expand(right), roundkey1(key));
          
    # Sboxes (and final round permutation)
    c = permut( sbox_1(s1), sbox_2(s2), sbox_3(s3), sbox_4(s4),
                sbox_5(s5), sbox_6(s6), sbox_7(s7), sbox_8(s8) );

    (left,right) = (right, xor(left,c));

    ##### Round 2-16 not implemented #####

    # .....


    # Regrouping left and right and computing final permuation
    ciphered = final_p(left, right)    
tel