

let test_tuple' (a'1,a'2,a'3) = 
    let b'1 = a'1 in 
    let b'2 = a'2 in 
    let b'3 = a'3 in 
    let b'4 = false in 
    let b'5 = false in 
    let b'6 = false in 
    let b'7 = true in 
    let b'8 = true in 
    (b'1,b'2,b'3,b'4,b'5,b'6,b'7,b'8)


let main astream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next astream in
        let (a1,a2,a3) = (Int64.logand (Int64.shift_right a 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right a 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8) = test_tuple' (a1,a2,a3) in
        let (b) = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 7) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 6) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret7 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret8 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (b)
    with Stream.Failure -> None)
