

let f' (a'1,a'2,a'3,a'4) = 
    let _tmp1_1 = not (a'4) in 
    let tmp_1_1_3 = (_tmp1_1) || (a'4) in 
    let _tmp25_1 = not (a'3) in 
    let _tmp27_1 = (a'3) && (_tmp1_1) in 
    let _tmp29_1 = (_tmp25_1) && (_tmp1_1) in 
    let _tmp30_1 = (a'3) && (tmp_1_1_3) in 
    let tmp_1_2_1 = (_tmp29_1) || (_tmp30_1) in 
    let _tmp32_1 = (_tmp25_1) && (a'4) in 
    let tmp_1_2_2 = (_tmp32_1) || (_tmp27_1) in 
    let _tmp37_1 = not (a'2) in 
    let _tmp38_1 = (_tmp37_1) && (_tmp27_1) in 
    let _tmp39_1 = (a'2) && (tmp_1_2_1) in 
    let tmp_1_3_0 = (_tmp38_1) || (_tmp39_1) in 
    let _tmp41_1 = (_tmp37_1) && (tmp_1_2_2) in 
    let _tmp42_1 = (a'2) && (_tmp27_1) in 
    let tmp_1_3_1 = (_tmp41_1) || (_tmp42_1) in 
    let _tmp43_1 = not (a'1) in 
    let _tmp44_1 = (_tmp43_1) && (tmp_1_3_0) in 
    let _tmp45_1 = (a'1) && (tmp_1_3_1) in 
    let tmp_1_4_0 = (_tmp44_1) || (_tmp45_1) in 
    let b'1 = tmp_1_4_0 in 
    let _tmp72_1 = (a'3) && (a'4) in 
    let tmp_2_2_0 = (_tmp29_1) || (_tmp72_1) in 
    let _tmp83_1 = (_tmp37_1) && (tmp_2_2_0) in 
    let _tmp84_1 = (a'2) && (tmp_2_2_0) in 
    let tmp_2_3_0 = (_tmp83_1) || (_tmp84_1) in 
    let _tmp86_1 = (_tmp37_1) && (tmp_1_2_1) in 
    let _tmp87_1 = (a'2) && (tmp_1_2_2) in 
    let tmp_2_3_1 = (_tmp86_1) || (_tmp87_1) in 
    let _tmp89_1 = (_tmp43_1) && (tmp_2_3_0) in 
    let _tmp90_1 = (a'1) && (tmp_2_3_1) in 
    let tmp_2_4_0 = (_tmp89_1) || (_tmp90_1) in 
    let b'2 = tmp_2_4_0 in 
    (b'1,b'2)


let main' (a') = 
    let b' = a' in 
    (b')


let main astream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next astream in
        let (a1) = (Int64.logand (Int64.shift_right a 0) Int64.one = Int64.one) in
        let (ret1) = main' (a1) in
        let (b) = (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (b)
    with Stream.Failure -> None)
