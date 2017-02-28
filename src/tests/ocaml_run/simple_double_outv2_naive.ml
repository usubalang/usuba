let id x = x

let f_ ((a_1,a_2,a_3,a_4,a_5,a_6)) = 
    let (b_1,b_2,b_3,b_4,c_1,c_2) = (a_1,a_2,a_3,a_4,a_5,a_6) in 
    (b_1,b_2,b_3,b_4,c_1,c_2)


let main a_stream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next a_stream in
        let (a1,a2,a3,a4,a5,a6) = (Int64.logand (Int64.shift_right a 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f_ ((a1,a2,a3,a4,a5,a6)) in
        let (b',c') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (b',c')
    with Stream.Failure -> None)
