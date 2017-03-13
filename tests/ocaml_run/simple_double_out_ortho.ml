let id x = x

let f_ ((a_1,a_2,a_3,a_4,a_5,a_6)) = 
    let (b_1,b_2,b_3,b_4) = (a_1,a_2,a_3,a_4) in 
    let (c_1,c_2) = (a_5,a_6) in 
    (b_1,b_2,b_3,b_4,c_1,c_2)


let main a_stream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next a_stream in
        let (a1,a2,a3,a4,a5,a6) = (a lsr 5 land 1 = 1,a lsr 4 land 1 = 1,a lsr 3 land 1 = 1,a lsr 2 land 1 = 1,a lsr 1 land 1 = 1,a lsr 0 land 1 = 1) in
        let (b1',b2',b3',b4',c1',c2') = f_ ((a1,a2,a3,a4,a5,a6)) in
        let (retb1,retb2,retb3,retb4,retc1,retc2) = (if b1' then 32 else 0)lor(if b2' then 16 else 0)lor(if b3' then 8 else 0)lor(if b4' then 4 else 0)lor(if c1' then 2 else 0)lor(if c2' then 1 else 0)
        in Some ((retb1,retb2,retb3,retb4),(retc1,retc2))
    with Stream.Failure -> None)
