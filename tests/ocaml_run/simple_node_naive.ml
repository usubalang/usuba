

let node1_ (x_) = 
    let x_ = (x_1) in 
    (x_)


let main xstream = 
    Stream.from
    (fun _ -> 
    try
        let x = Stream.next xstream in
        let (x1) = (Int64.logand (Int64.shift_right x 0) Int64.one = Int64.one) in
        let (ret1) = node1_ (x1) in
        let (x') = (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (x')
    with Stream.Failure -> None)
