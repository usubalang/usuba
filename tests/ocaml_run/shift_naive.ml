

let lshift2' (input'1,input'2,input'3,input'4,input'5,input'6) = 
    let (out'1,out'2,out'3,out'4,out'5,out'6) = (input'3,input'4,input'5,input'6,false,false) in 
    (out'1,out'2,out'3,out'4,out'5,out'6)


let lrotate3' (input'1,input'2,input'3,input'4,input'5,input'6) = 
    let (out'1,out'2,out'3,out'4,out'5,out'6) = (input'4,input'5,input'6,input'1,input'2,input'3) in 
    (out'1,out'2,out'3,out'4,out'5,out'6)


let rshift4' (input'1,input'2,input'3,input'4,input'5,input'6) = 
    let (out'1,out'2,out'3,out'4,out'5,out'6) = (false,false,false,false,input'1,input'2) in 
    (out'1,out'2,out'3,out'4,out'5,out'6)


let rrotate1' (input'1,input'2,input'3,input'4,input'5,input'6) = 
    let (out'1,out'2,out'3,out'4,out'5,out'6) = (input'6,input'1,input'2,input'3,input'4,input'5) in 
    (out'1,out'2,out'3,out'4,out'5,out'6)


let main inputstream = 
    Stream.from
    (fun _ -> 
    try
        let input = Stream.next inputstream in
        let (input1,input2,input3,input4,input5,input6) = (Int64.logand (Int64.shift_right input 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right input 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right input 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right input 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right input 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right input 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = rrotate1' (input1,input2,input3,input4,input5,input6) in
        let (out) = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (out)
    with Stream.Failure -> None)
