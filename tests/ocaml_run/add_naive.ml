

let f' (x',y') = 
    let z' = (x') + (y') in 
    (z')


let main xstream ystream = 
    Stream.from
    (fun _ -> 
    try
        let x = Stream.next xstream in
        let (x1,x2,x3,x4,x5,x6,x7,x8) = (Int64.logand (Int64.shift_right x 7) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 6) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right x 0) Int64.one = Int64.one) in
        let y = Stream.next ystream in
        let (y1,y2,y3,y4,y5,y6,y7,y8) = (Int64.logand (Int64.shift_right y 7) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 6) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right y 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8) = f' (x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8) in
        let (z) = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 7) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 6) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret7 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret8 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (z)
    with Stream.Failure -> None)
