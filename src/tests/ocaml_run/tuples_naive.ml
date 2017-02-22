open Ocaml_runtime
let assing_ a_1 a_2 a_3 a_4 a_5 a_6 b_1 b_2 b_3 b_4 c_1 c_2 = 
    let (c_1,c_2,b_1,b_2,b_3,b_4) = (b_1,b_2,b_3,b_4,c_1,c_2) in 
    let (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12) = (b_1,b_2,b_3,b_4,a_1,a_2,a_3,a_4,a_5,a_6,c_1,c_2) in 
    (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12)
