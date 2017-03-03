

let id x = x

let f_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((not (in_1),not (in_2),not (in_3),not (in_4))) in 
    (out_1,out_2,out_3,out_4)


let f1_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((not (in_1),not (in_2),not (in_3),not (in_4))) in 
    (out_1,out_2,out_3,out_4)


let f2_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((not (in_1),not (in_2),not (in_3),not (in_4))) in 
    (out_1,out_2,out_3,out_4)


let main_ ((init_1,init_2,init_3,init_4),(in1_1,in1_2,in1_3,in1_4),(in2_1,in2_2,in2_3,in2_4),(in3_1,in3_2,in3_3,in3_4)) = 
    let (out1_1,out1_2,out1_3,out1_4) = (init_1,init_2,init_3,init_4) in 
    let (out2_1,out2_2,out2_3,out2_4) = f1_ (id ((out1_1,out1_2,out1_3,out1_4))) in 
    let (out3_1,out3_2,out3_3,out3_4) = f2_ (id ((out2_1,out2_2,out2_3,out2_4))) in 
    (out1_1,out1_2,out1_3,out1_4,out2_1,out2_2,out2_3,out2_4,out3_1,out3_2,out3_3,out3_4)


let main init_stream in1_stream in2_stream in3_stream = 
    Stream.from
    (fun _ -> 
    try
        let init_ = Stream.next init_stream in
        let (init_1,init_2,init_3,init_4) = (Int64.logand (Int64.shift_right init_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right init_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right init_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right init_ 0) Int64.one = Int64.one) in
        let in1_ = Stream.next in1_stream in
        let (in1_1,in1_2,in1_3,in1_4) = (Int64.logand (Int64.shift_right in1_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right in1_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right in1_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in1_ 0) Int64.one = Int64.one) in
        let in2_ = Stream.next in2_stream in
        let (in2_1,in2_2,in2_3,in2_4) = (Int64.logand (Int64.shift_right in2_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right in2_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right in2_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in2_ 0) Int64.one = Int64.one) in
        let in3_ = Stream.next in3_stream in
        let (in3_1,in3_2,in3_3,in3_4) = (Int64.logand (Int64.shift_right in3_ 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right in3_ 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right in3_ 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right in3_ 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12) = main_ ((init_1,init_2,init_3,init_4),(in1_1,in1_2,in1_3,in1_4),(in2_1,in2_2,in2_3,in2_4),(in3_1,in3_2,in3_3,in3_4)) in
        let (out1_',out2_',out3_') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out1_',out2_',out3_')
    with Stream.Failure -> None)
