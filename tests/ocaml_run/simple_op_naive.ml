

let f' (x'1,x'2,x'3,x'4,x'5,x'6,y'1,y'2,y'3,y'4,y'5,y'6) = 
    let _tmp1_1 = ((y'1) && (not (x'1))) || ((not (y'1)) && (x'1)) in 
    let _tmp2_1 = ((y'2) && (not (x'2))) || ((not (y'2)) && (x'2)) in 
    let _tmp3_1 = ((y'3) && (not (x'3))) || ((not (y'3)) && (x'3)) in 
    let _tmp4_1 = ((y'4) && (not (x'4))) || ((not (y'4)) && (x'4)) in 
    let _tmp5_1 = ((y'5) && (not (x'5))) || ((not (y'5)) && (x'5)) in 
    let _tmp6_1 = ((y'6) && (not (x'6))) || ((not (y'6)) && (x'6)) in 
    let _tmp7_1 = (_tmp1_1) || (y'1) in 
    let _tmp8_1 = (_tmp2_1) || (y'2) in 
    let _tmp9_1 = (_tmp3_1) || (y'3) in 
    let _tmp10_1 = (_tmp4_1) || (y'4) in 
    let _tmp11_1 = (_tmp5_1) || (y'5) in 
    let _tmp12_1 = (_tmp6_1) || (y'6) in 
    let _tmp13_1 = not (_tmp7_1) in 
    let _tmp13_2 = not (_tmp8_1) in 
    let _tmp13_3 = not (_tmp9_1) in 
    let _tmp13_4 = not (_tmp10_1) in 
    let _tmp13_5 = not (_tmp11_1) in 
    let _tmp13_6 = not (_tmp12_1) in 
    let x'1 = (_tmp13_1) && (_tmp1_1) in 
    let x'2 = (_tmp13_2) && (_tmp2_1) in 
    let x'3 = (_tmp13_3) && (_tmp3_1) in 
    let x'4 = (_tmp13_4) && (_tmp4_1) in 
    let x'5 = (_tmp13_5) && (_tmp5_1) in 
    let x'6 = (_tmp13_6) && (_tmp6_1) in 
    let _tmp14_1 = (_tmp7_1) || (_tmp1_1) in 
    let _tmp15_1 = ((_tmp1_1) && (not (_tmp14_1))) || ((not (_tmp1_1)) && (_tmp14_1)) in 
    let _tmp16_1 = (_tmp7_1) && (_tmp15_1) in 
    let _tmp17_1 = (_tmp8_1) || (_tmp2_1) in 
    let _tmp18_1 = ((_tmp2_1) && (not (_tmp17_1))) || ((not (_tmp2_1)) && (_tmp17_1)) in 
    let _tmp19_1 = (_tmp8_1) && (_tmp18_1) in 
    let _tmp20_1 = (_tmp9_1) || (_tmp3_1) in 
    let _tmp21_1 = ((_tmp3_1) && (not (_tmp20_1))) || ((not (_tmp3_1)) && (_tmp20_1)) in 
    let _tmp22_1 = (_tmp9_1) && (_tmp21_1) in 
    let _tmp23_1 = (_tmp10_1) || (_tmp4_1) in 
    let _tmp24_1 = ((_tmp4_1) && (not (_tmp23_1))) || ((not (_tmp4_1)) && (_tmp23_1)) in 
    let _tmp25_1 = (_tmp10_1) && (_tmp24_1) in 
    let _tmp26_1 = (_tmp11_1) || (_tmp5_1) in 
    let _tmp27_1 = ((_tmp5_1) && (not (_tmp26_1))) || ((not (_tmp5_1)) && (_tmp26_1)) in 
    let _tmp28_1 = (_tmp11_1) && (_tmp27_1) in 
    let _tmp29_1 = (_tmp12_1) || (_tmp6_1) in 
    let _tmp30_1 = ((_tmp6_1) && (not (_tmp29_1))) || ((not (_tmp6_1)) && (_tmp29_1)) in 
    let _tmp31_1 = (_tmp12_1) && (_tmp30_1) in 
    let z'1 = _tmp16_1 in 
    let z'2 = _tmp19_1 in 
    let z'3 = _tmp22_1 in 
    let z'4 = _tmp25_1 in 
    let z'5 = _tmp28_1 in 
    let z'6 = _tmp31_1 in 
    (z'1,z'2,z'3,z'4,z'5,z'6)


let main xstream ystream = 
    Stream.from
    (fun _ -> 
    try
        let x = Stream.next xstream in
        let (x1,x2,x3,x4,x5,x6) = (Int64.logand (Int64.shift_right x 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 0) Int64.one = Int64.one) in
        let y = Stream.next ystream in
        let (y1,y2,y3,y4,y5,y6) = (Int64.logand (Int64.shift_right y 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f' (x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6) in
        let (z) = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (z)
    with Stream.Failure -> None)
