

let id x = x

let f_ ((in1_1,in1_2),(in2_1,in2_2)) = 
    let (out_1,out_2) = (in2_1,in2_2) in 
    (out_1,out_2)


let main in1_stream in2_stream = 
    Stream.from
    (fun _ -> 
    try
        let in1_ = Stream.next in1_stream in
        let (in1_1,in1_2) = (Int64.logand (Int64.shift_right in1_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in1_ 0) Int64.one = Int64.one) in
        let in2_ = Stream.next in2_stream in
        let (in2_1,in2_2) = (Int64.logand (Int64.shift_right in2_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in2_ 0) Int64.one = Int64.one) in
        let (ret1,ret2) = f_ ((in1_1,in1_2),(in2_1,in2_2)) in
        let (out_') = (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out_')
    with Stream.Failure -> None)
