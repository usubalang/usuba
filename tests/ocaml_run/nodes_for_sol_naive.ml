

let nor_ (x_1,x_2,y_1,y_2) = 
    let _tmp2_1 = (x_1) || (y_1) in 
    let _tmp2_2 = (x_2) || (y_2) in 
    let out_1 = (not (_tmp2_1)) in 
    let out_2 = (not (_tmp2_2)) in 
    (out_1,out_2)


let main_ (in_1,in_2,in_3,in_4) = 
    let x_1 = in_1 in 
    let x_2 = in_2 in 
    let y_1 = in_3 in 
    let y_2 = in_4 in 
    let (out_1,out_2) = nor_ (x_1,x_2,y_1,y_2) in 
    (out_1,out_2)


let main instream = 
    Stream.from
    (fun _ -> 
    try
        let in = Stream.next instream in
        let (in1,in2,in3,in4) = (Int64.logand (Int64.shift_right in 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right in 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right in 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in 0) Int64.one = Int64.one) in
        let (ret1,ret2) = main_ (in1,in2,in3,in4) in
        let (out') = (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out')
    with Stream.Failure -> None)
