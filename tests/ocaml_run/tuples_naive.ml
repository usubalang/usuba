

let id x = x

let assing_ ((a_1,a_2,a_3,a_4,a_5,a_6),(b_1,b_2,b_3,b_4),(c_1,c_2)) = 
    let (c_1,c_2,b_1,b_2,b_3,b_4) = (b_1,b_2,b_3,b_4,c_1,c_2) in 
    let (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12) = (b_1,b_2,b_3,b_4,a_1,a_2,a_3,a_4,a_5,a_6,c_1,c_2) in 
    (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12)


let main a_stream b_stream c_stream = 
    Stream.from
    (fun _ -> 
    try
        let a_ = Stream.next a_stream in
        let (a_1,a_2,a_3,a_4,a_5,a_6) = (Int64.logand (Int64.shift_right a_ 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right a_ 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right a_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right a_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right a_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right a_ 0) Int64.one = Int64.one) in
        let b_ = Stream.next b_stream in
        let (b_1,b_2,b_3,b_4) = (Int64.logand (Int64.shift_right b_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right b_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right b_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right b_ 0) Int64.one = Int64.one) in
        let c_ = Stream.next c_stream in
        let (c_1,c_2) = (Int64.logand (Int64.shift_right c_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right c_ 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12) = assing_ ((a_1,a_2,a_3,a_4,a_5,a_6),(b_1,b_2,b_3,b_4),(c_1,c_2)) in
        let (d_') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 11) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 10) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 9) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 8) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 7) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 6) else Int64.zero)) (if ret7 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret8 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret9 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret10 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret11 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret12 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (d_')
    with Stream.Failure -> None)
