

let id x = x

let key1_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_4,out_2,out_3) = (in_1,in_2,in_3,in_4) in 
    (out_1,out_2,out_3,out_4)


let key2_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_4,out_3,out_2,out_1) = (in_1,in_2,in_3,in_4) in 
    (out_1,out_2,out_3,out_4)


let key3_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_2,out_3,out_4) = (in2_1,in2_2,in_1,in_4) in 
    (out_1,out_2,out_3,out_4)


let f1_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_2,out_3,out_4) = key1_ (id ((in_1,in_2,in_3,in_4),(in2_1,in2_2))) in 
    let (out2_1,out2_2) = (in2_1,in2_2) in 
    (out_1,out_2,out_3,out_4,out2_1,out2_2)


let f2_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_2,out_3,out_4) = key2_ (id ((in_1,in_2,in_3,in_4),(in2_1,in2_2))) in 
    let (out2_1,out2_2) = (in2_1,in2_2) in 
    (out_1,out_2,out_3,out_4,out2_1,out2_2)


let main_ ((init_1,init_2,init_3,init_4),(supp_1,supp_2)) = 
    let (__tmp1_1,__tmp1_2,__tmp1_3,__tmp1_4) = (init_1,init_2,init_3,init_4) in 
    let (__tmp2_1,__tmp2_2,__tmp2_3,__tmp2_4) = (init_1,init_2,init_3,init_4) in 
    let (__tmp3_1,__tmp3_2,__tmp3_3,__tmp3_4) = ((__tmp1_1) && (__tmp2_1),(__tmp1_2) && (__tmp2_2),(__tmp1_3) && (__tmp2_3),(__tmp1_4) && (__tmp2_4)) in 
    let (__tmp4_1,__tmp4_2,__tmp4_3,__tmp4_4) = (init_1,init_2,init_3,init_4) in 
    let (tmp1_1,tmp1_2,tmp1_3,tmp1_4,tmp21_1,tmp21_2) = ((__tmp3_1) && (__tmp4_1),(__tmp3_2) && (__tmp4_2),(__tmp3_3) && (__tmp4_3),(__tmp3_4) && (__tmp4_4),supp_1,supp_2) in 
    let (tmp2_1,tmp2_2,tmp2_3,tmp2_4,tmp22_1,tmp22_2) = f1_ (id ((tmp1_1,tmp1_2,tmp1_3,tmp1_4),(tmp21_1,tmp21_2))) in 
    let (tmp3_1,tmp3_2,tmp3_3,tmp3_4,tmp23_1,tmp23_2) = f2_ (id ((tmp2_1,tmp2_2,tmp2_3,tmp2_4),(tmp22_1,tmp22_2))) in 
    let (out_1,out_2,out_3,out_4) = (tmp3_1,tmp3_2,tmp3_3,tmp3_4) in 
    (out_1,out_2,out_3,out_4)


let main init_stream supp_stream = 
    Stream.from
    (fun _ -> 
    try
        let init_ = Stream.next init_stream in
        let (init_1,init_2,init_3,init_4) = (Int64.logand (Int64.shift_right init_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right init_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right init_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right init_ 0) Int64.one = Int64.one) in
        let supp_ = Stream.next supp_stream in
        let (supp_1,supp_2) = (Int64.logand (Int64.shift_right supp_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right supp_ 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4) = main_ ((init_1,init_2,init_3,init_4),(supp_1,supp_2)) in
        let (out_') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out_')
    with Stream.Failure -> None)
