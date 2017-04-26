

let is_live' (v',a'1,a'2,a'3,a'4,a'5,a'6,a'7,a'8) = 
    let _tmp4_ = not (s1') in 
    let _tmp5_ = not (s2') in 
    let _tmp16_ = (_tmp5_) && (_tmp4_) in 
    let _tmp7_ = (s3') && (_tmp16_) in 
    let _tmp8_ = (_tmp7_) && (v') in 
    let _tmp9_ = not (v') in 
    let _tmp10_ = not (v1') in 
    let _tmp11_ = not (v2') in 
    let _tmp17_ = (_tmp11_) && (_tmp10_) in 
    let _tmp13_ = (v3') && (_tmp17_) in 
    let _tmp14_ = (v4') && (_tmp13_) in 
    let _tmp18_ = (_tmp14_) && (_tmp9_) in 
    let _tmp19_ = (_tmp18_) || (_tmp8_) in 
    let b' = _tmp19_ in 
    (b')


let main vstream astream = 
    Stream.from
    (fun _ -> 
    try
        let v = Stream.next vstream in
        let (v1) = (Int64.logand (Int64.shift_right v 0) Int64.one = Int64.one) in
        let a = Stream.next astream in
        let (a1,a2,a3,a4,a5,a6,a7,a8) = (Int64.logand (Int64.shift_right a 7) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 6) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 0) Int64.one = Int64.one) in
        let (ret1) = is_live' (v1,a1,a2,a3,a4,a5,a6,a7,a8) in
        let (b) = (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (b)
    with Stream.Failure -> None)
