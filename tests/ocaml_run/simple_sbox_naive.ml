

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
