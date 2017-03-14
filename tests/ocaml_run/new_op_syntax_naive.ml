

let id x = x

let f_ ((x_1,x_2,x_3,x_4,x_5,x_6),(y_1,y_2,y_3,y_4,y_5,y_6)) = 
    let (__tmp1_1,__tmp1_2,__tmp1_3,__tmp1_4,__tmp1_5,__tmp1_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp2_1,__tmp2_2,__tmp2_3,__tmp2_4,__tmp2_5,__tmp2_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (x_1,x_2,x_3,x_4,x_5,x_6) = (((__tmp1_1) && ((not (__tmp2_1)))) || (((not (__tmp1_1))) && (__tmp2_1)),((__tmp1_2) && ((not (__tmp2_2)))) || (((not (__tmp1_2))) && (__tmp2_2)),((__tmp1_3) && ((not (__tmp2_3)))) || (((not (__tmp1_3))) && (__tmp2_3)),((__tmp1_4) && ((not (__tmp2_4)))) || (((not (__tmp1_4))) && (__tmp2_4)),((__tmp1_5) && ((not (__tmp2_5)))) || (((not (__tmp1_5))) && (__tmp2_5)),((__tmp1_6) && ((not (__tmp2_6)))) || (((not (__tmp1_6))) && (__tmp2_6))) in 
    let (__tmp3_1,__tmp3_2,__tmp3_3,__tmp3_4,__tmp3_5,__tmp3_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (__tmp4_1,__tmp4_2,__tmp4_3,__tmp4_4,__tmp4_5,__tmp4_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (y_1,y_2,y_3,y_4,y_5,y_6) = ((__tmp3_1) || (__tmp4_1),(__tmp3_2) || (__tmp4_2),(__tmp3_3) || (__tmp4_3),(__tmp3_4) || (__tmp4_4),(__tmp3_5) || (__tmp4_5),(__tmp3_6) || (__tmp4_6)) in 
    let (__tmp5_1,__tmp5_2,__tmp5_3,__tmp5_4,__tmp5_5,__tmp5_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (__tmp6_1,__tmp6_2,__tmp6_3,__tmp6_4,__tmp6_5,__tmp6_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp7_1,__tmp7_2,__tmp7_3,__tmp7_4,__tmp7_5,__tmp7_6) = ((not (__tmp5_1)),(not (__tmp5_2)),(not (__tmp5_3)),(not (__tmp5_4)),(not (__tmp5_5)),(not (__tmp5_6))) in 
    let (x_1,x_2,x_3,x_4,x_5,x_6) = ((__tmp6_1) && (__tmp7_1),(__tmp6_2) && (__tmp7_2),(__tmp6_3) && (__tmp7_3),(__tmp6_4) && (__tmp7_4),(__tmp6_5) && (__tmp7_5),(__tmp6_6) && (__tmp7_6)) in 
    let (__tmp8_1,__tmp8_2,__tmp8_3,__tmp8_4,__tmp8_5,__tmp8_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp9_1,__tmp9_2,__tmp9_3,__tmp9_4,__tmp9_5,__tmp9_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (__tmp10_1,__tmp10_2,__tmp10_3,__tmp10_4,__tmp10_5,__tmp10_6) = ((__tmp8_1) || (__tmp9_1),(__tmp8_2) || (__tmp9_2),(__tmp8_3) || (__tmp9_3),(__tmp8_4) || (__tmp9_4),(__tmp8_5) || (__tmp9_5),(__tmp8_6) || (__tmp9_6)) in 
    let (__tmp11_1,__tmp11_2,__tmp11_3,__tmp11_4,__tmp11_5,__tmp11_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp12_1,__tmp12_2,__tmp12_3,__tmp12_4,__tmp12_5,__tmp12_6) = (((__tmp10_1) && ((not (__tmp11_1)))) || (((not (__tmp10_1))) && (__tmp11_1)),((__tmp10_2) && ((not (__tmp11_2)))) || (((not (__tmp10_2))) && (__tmp11_2)),((__tmp10_3) && ((not (__tmp11_3)))) || (((not (__tmp10_3))) && (__tmp11_3)),((__tmp10_4) && ((not (__tmp11_4)))) || (((not (__tmp10_4))) && (__tmp11_4)),((__tmp10_5) && ((not (__tmp11_5)))) || (((not (__tmp10_5))) && (__tmp11_5)),((__tmp10_6) && ((not (__tmp11_6)))) || (((not (__tmp10_6))) && (__tmp11_6))) in 
    let (__tmp13_1,__tmp13_2,__tmp13_3,__tmp13_4,__tmp13_5,__tmp13_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (z_1,z_2,z_3,z_4,z_5,z_6) = ((__tmp12_1) && (__tmp13_1),(__tmp12_2) && (__tmp13_2),(__tmp12_3) && (__tmp13_3),(__tmp12_4) && (__tmp13_4),(__tmp12_5) && (__tmp13_5),(__tmp12_6) && (__tmp13_6)) in 
    (z_1,z_2,z_3,z_4,z_5,z_6)


let main x_stream y_stream = 
    Stream.from
    (fun _ -> 
    try
        let x_ = Stream.next x_stream in
        let (x_1,x_2,x_3,x_4,x_5,x_6) = (Int64.logand (Int64.shift_right x_ 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right x_ 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right x_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right x_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right x_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right x_ 0) Int64.one = Int64.one) in
        let y_ = Stream.next y_stream in
        let (y_1,y_2,y_3,y_4,y_5,y_6) = (Int64.logand (Int64.shift_right y_ 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right y_ 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right y_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right y_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right y_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right y_ 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f_ ((x_1,x_2,x_3,x_4,x_5,x_6),(y_1,y_2,y_3,y_4,y_5,y_6)) in
        let (z_') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (z_')
    with Stream.Failure -> None)
