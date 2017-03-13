

let id x = x

let referencize1 (x1,x2,x3,x4) = ref x1,ref x2,ref x3,ref x4

let custom_not_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((not (in_1),not (in_2),not (in_3),not (in_4))) in 
    (out_1,out_2,out_3,out_4)


let f_ = 
    let (c_1',c_2',c_3',c_4') = referencize1 (false,false,false,true) in

    fun ((d_1,d_2,d_3,d_4)) -> 
    let (c_1,c_2,c_3,c_4) = (!c_1',!c_2',!c_3',!c_4') in
let (c_1'',c_2'',c_3'',c_4'') = (((d_1) || (c_1),(d_2) || (c_2),(d_3) || (c_3),(d_4) || (c_4))) in
    c_1' := c_1'';
    c_2' := c_2'';
    c_3' := c_3'';
    c_4' := c_4'';
    (c_1,c_2,c_3,c_4)


let main d_stream = 
    Stream.from
    (fun _ -> 
    try
        let d = Stream.next d_stream in
        let (d1,d2,d3,d4) = (Int64.logand (Int64.shift_right d 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right d 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right d 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right d 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4) = f_ ((d1,d2,d3,d4)) in
        let (c') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (c')
    with Stream.Failure -> None)
