

let nxor_ (x_,y_) = 
    let tmp_ = (((x_1) && ((not (y_1)))) || (((not (x_1))) && (y_1))) in 
    let z_ = ((not (tmp_))) in 
    (z_)


let nand_ (x_,y_) = 
    let tmp_ = ((x_1) && (y_1)) in 
    let z_ = ((not (tmp_))) in 
    (z_)


let triple_nxor_ (x_,y_,z_) = 
    let tmp1_ = nxor_ (x_1,y_1) in 
    let b_ = nxor_ (tmp1_,z_1) in 
    (b_)


let random_box_ (x1_,x2_,x3_,x4_) = 
    let a_ = (((x1_1) && ((not (x2_1)))) || (((not (x1_1))) && (x2_1))) in 
    let r1_ = ((x1_1) || (x2_1)) in 
    let _tmp6_1 = nxor_ (a_,x3_1) in 
    let b_ = ((not (_tmp6_1))) in 
    let _tmp7_1 = triple_nxor_ (x2_1,x3_1,x4_1) in 
    let c_ = nand_ (b_,_tmp7_1) in 
    let _tmp8_1 = (((x1_1) && ((not (x4_1)))) || (((not (x1_1))) && (x4_1))) in 
    let d_ = (c_) || ((_tmp8_1)) in 
    let r2_ = ((d_) && ((not (x3_1)))) || (((not (d_))) && ((x3_1))) in 
    let _tmp9_1 = (b_) && (d_) in 
    let _tmp10_1 = ((x2_1) || (x4_1)) in 
    let r3_ = nand_ (_tmp9_1,_tmp10_1) in 
    (r1_,r2_,r3_)


let main x1stream x2stream x3stream x4stream = 
    Stream.from
    (fun _ -> 
    try
        let x1 = Stream.next x1stream in
        let (x11) = (Int64.logand (Int64.shift_right x1 0) Int64.one = Int64.one) in
        let x2 = Stream.next x2stream in
        let (x21) = (Int64.logand (Int64.shift_right x2 0) Int64.one = Int64.one) in
        let x3 = Stream.next x3stream in
        let (x31) = (Int64.logand (Int64.shift_right x3 0) Int64.one = Int64.one) in
        let x4 = Stream.next x4stream in
        let (x41) = (Int64.logand (Int64.shift_right x4 0) Int64.one = Int64.one) in
        let (ret1,ret2,ret3) = random_box_ (x11,x21,x31,x41) in
        let (r1',r2',r3') = (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero)),(Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (r1',r2',r3')
    with Stream.Failure -> None)
