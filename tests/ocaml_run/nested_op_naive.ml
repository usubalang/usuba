

let id x = x

let f_ ((in_1,in_2,in_3,in_4,in_5,in_6)) = 
    let (__tmp1_1,__tmp1_2,__tmp1_3,__tmp1_4,__tmp1_5,__tmp1_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp2_1,__tmp2_2,__tmp2_3,__tmp2_4,__tmp2_5,__tmp2_6) = ((not (__tmp1_1)),(not (__tmp1_2)),(not (__tmp1_3)),(not (__tmp1_4)),(not (__tmp1_5)),(not (__tmp1_6))) in 
    let (__tmp3_1,__tmp3_2,__tmp3_3,__tmp3_4,__tmp3_5,__tmp3_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp4_1,__tmp4_2,__tmp4_3,__tmp4_4,__tmp4_5,__tmp4_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp5_1,__tmp5_2,__tmp5_3,__tmp5_4,__tmp5_5,__tmp5_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp6_1,__tmp6_2,__tmp6_3,__tmp6_4,__tmp6_5,__tmp6_6) = ((__tmp2_1) && (__tmp3_1),(__tmp2_2) && (__tmp3_2),(__tmp2_3) && (__tmp3_3),(__tmp2_4) && (__tmp3_4),(__tmp2_5) && (__tmp3_5),(__tmp2_6) && (__tmp3_6)) in 
    let (__tmp7_1,__tmp7_2,__tmp7_3,__tmp7_4,__tmp7_5,__tmp7_6) = ((__tmp4_1) && (__tmp5_1),(__tmp4_2) && (__tmp5_2),(__tmp4_3) && (__tmp5_3),(__tmp4_4) && (__tmp5_4),(__tmp4_5) && (__tmp5_5),(__tmp4_6) && (__tmp5_6)) in 
    let (out_1,out_2,out_3,out_4,out_5,out_6) = ((__tmp6_1) || (__tmp7_1),(__tmp6_2) || (__tmp7_2),(__tmp6_3) || (__tmp7_3),(__tmp6_4) || (__tmp7_4),(__tmp6_5) || (__tmp7_5),(__tmp6_6) || (__tmp7_6)) in 
    (out_1,out_2,out_3,out_4,out_5,out_6)


let main in_stream = 
    Stream.from
    (fun _ -> 
    try
        let in_ = Stream.next in_stream in
        let (in_1,in_2,in_3,in_4,in_5,in_6) = (Int64.logand (Int64.shift_right in_ 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right in_ 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right in_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right in_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right in_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in_ 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f_ ((in_1,in_2,in_3,in_4,in_5,in_6)) in
        let (out_') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out_')
    with Stream.Failure -> None)
