

let id x = x

let f1_ ((input_1,input_2)) = 
    let (out_2,out_1) = (input_1,input_2) in 
    (out_1,out_2)


let f2_ ((input_1,input_2)) = 
    let (out_1,out_2) = (input_1,input_2) in 
    (out_1,out_2)


let main_ ((in_1,in_2)) = 
    let (tmp_1,tmp_2) = f1_ (id ((in_1,in_2))) in 
    let (out_1,out_2) = f2_ (id ((tmp_1,tmp_2))) in 
    (out_1,out_2)


let main in_stream = 
    Stream.from
    (fun _ -> 
    try
        let in_ = Stream.next in_stream in
        let (in_1,in_2) = (Int64.logand (Int64.shift_right in_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in_ 0) Int64.one = Int64.one) in
        let (ret1,ret2) = main_ ((in_1,in_2)) in
        let (out_') = (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out_')
    with Stream.Failure -> None)
