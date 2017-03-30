

let f' (a'1,a'2,a'3,a'4,a'5,a'6) = 
    let b'1 = a'1 in 
    let b'2 = a'2 in 
    let b'3 = a'3 in 
    let b'4 = a'4 in 
    let c'1 = a'5 in 
    let c'2 = a'6 in 
    (b'1,b'2,b'3,b'4,c'1,c'2)


let main astream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next astream in
        let (a1,a2,a3,a4,a5,a6) = (Int64.logand (Int64.shift_right a 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f' (a1,a2,a3,a4,a5,a6) in
        let (b,c) = (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (b,c)
    with Stream.Failure -> None)
