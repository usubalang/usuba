

let main' (x'0'1,x'0'2,x'0'3,x'0'4,x'0'5,x'0'6,x'1'1,x'1'2,x'1'3,x'1'4,x'1'5,x'1'6) = 
    let nxor'0__tmp1_1 = ((x'1'1) && (not (x'0'1))) || ((not (x'1'1)) && (x'0'1)) in 
    let nxor'0__tmp2_1 = ((x'1'2) && (not (x'0'2))) || ((not (x'1'2)) && (x'0'2)) in 
    let nxor'0__tmp3_1 = ((x'1'3) && (not (x'0'3))) || ((not (x'1'3)) && (x'0'3)) in 
    let nxor'0__tmp4_1 = ((x'1'4) && (not (x'0'4))) || ((not (x'1'4)) && (x'0'4)) in 
    let nxor'0__tmp5_1 = ((x'1'5) && (not (x'0'5))) || ((not (x'1'5)) && (x'0'5)) in 
    let nxor'0__tmp6_1 = ((x'1'6) && (not (x'0'6))) || ((not (x'1'6)) && (x'0'6)) in 
    let nxor'0_z'1 = not (nxor'0__tmp1_1) in 
    let nxor'0_z'2 = not (nxor'0__tmp2_1) in 
    let nxor'0_z'3 = not (nxor'0__tmp3_1) in 
    let nxor'0_z'4 = not (nxor'0__tmp4_1) in 
    let nxor'0_z'5 = not (nxor'0__tmp5_1) in 
    let nxor'0_z'6 = not (nxor'0__tmp6_1) in 
    let z'0'1 = nxor'0_z'1 in 
    let z'0'2 = nxor'0_z'2 in 
    let z'0'3 = nxor'0_z'3 in 
    let z'0'4 = nxor'0_z'4 in 
    let z'0'5 = nxor'0_z'5 in 
    let z'0'6 = nxor'0_z'6 in 
    let z'1'1 = nxor'0_z'1 in 
    let z'1'2 = nxor'0_z'2 in 
    let z'1'3 = nxor'0_z'3 in 
    let z'1'4 = nxor'0_z'4 in 
    let z'1'5 = nxor'0_z'5 in 
    let z'1'6 = nxor'0_z'6 in 
    (z'0'1,z'0'2,z'0'3,z'0'4,z'0'5,z'0'6,z'1'1,z'1'2,z'1'3,z'1'4,z'1'5,z'1'6)


let main x0'stream x1'stream = 
    Stream.from
    (fun _ -> 
    try
        let x0' = Stream.next x0'stream in
        let (x0'1,x0'2,x0'3,x0'4,x0'5,x0'6) = (Int64.logand (Int64.shift_right x0' 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right x0' 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right x0' 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right x0' 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right x0' 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right x0' 0) Int64.one = Int64.one) in
        let x1' = Stream.next x1'stream in
        let (x1'1,x1'2,x1'3,x1'4,x1'5,x1'6) = (Int64.logand (Int64.shift_right x1' 5) Int64.one = Int64.one,Int64.logand (Int64.shift_right x1' 4) Int64.one = Int64.one,Int64.logand (Int64.shift_right x1' 3) Int64.one = Int64.one,Int64.logand (Int64.shift_right x1' 2) Int64.one = Int64.one,Int64.logand (Int64.shift_right x1' 1) Int64.one = Int64.one,Int64.logand (Int64.shift_right x1' 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12) = main' (x0'1,x0'2,x0'3,x0'4,x0'5,x0'6,x1'1,x1'2,x1'3,x1'4,x1'5,x1'6) in
        let (z0',z1') = (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 5) else Int64.zero)) (if ret2 then (Int64.shift_left Int64.one 4) else Int64.zero)) (if ret3 then (Int64.shift_left Int64.one 3) else Int64.zero)) (if ret4 then (Int64.shift_left Int64.one 2) else Int64.zero)) (if ret5 then (Int64.shift_left Int64.one 1) else Int64.zero)) (if ret6 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (z0',z1')
    with Stream.Failure -> None)
