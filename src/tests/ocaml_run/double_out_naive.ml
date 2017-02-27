let id x = x

let convert1 ((in11,in12,in13,in14,in15,in16,in17,in18)) = 
    let out11 = in11 in 
    let out12 = in12 in 
    let out13 = in13 in 
    let out14 = in14 in 
    let out21 = in15 in 
    let out22 = in16 in 
    let out23 = in17 in 
    let out24 = in18 in 
    ((out11,out12,out13,out14),(out21,out22,out23,out24))


let f_ ((a_1,a_2,a_3,a_4),(b_1,b_2,b_3,b_4)) = 
    let (c_1,c_2,c_3,c_4) = (a_1,a_2,a_3,a_4) in 
    let (d_1,d_2,d_3,d_4) = (b_1,b_2,b_3,b_4) in 
    (c_1,c_2,c_3,c_4,d_1,d_2,d_3,d_4)


let g_ ((a_1,a_2,a_3,a_4),(b_1,b_2,b_3,b_4)) = 
    let (c_1,c_2,c_3,c_4,d_1,d_2,d_3,d_4) = f_ (id ((a_1,a_2,a_3,a_4),(b_1,b_2,b_3,b_4))) in 
    (c_1,c_2,c_3,c_4,d_1,d_2,d_3,d_4)


let h_ ((a_1,a_2,a_3,a_4),(b_1,b_2,b_3,b_4)) = 
    let (c_1,c_2,c_3,c_4,d_1,d_2,d_3,d_4) = g_ (convert1 (f_ (id ((a_1,a_2,a_3,a_4),(b_1,b_2,b_3,b_4))))) in 
    (c_1,c_2,c_3,c_4,d_1,d_2,d_3,d_4)


let main a_stream b_stream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next a_stream in
        let (a1,a2,a3,a4) = (a lsr 3 land 1 = 1,a lsr 2 land 1 = 1,a lsr 1 land 1 = 1,a lsr 0 land 1 = 1) in
        let b = Stream.next b_stream in
        let (b1,b2,b3,b4) = (b lsr 3 land 1 = 1,b lsr 2 land 1 = 1,b lsr 1 land 1 = 1,b lsr 0 land 1 = 1) in
        let (c1',c2',c3',c4',d1',d2',d3',d4') = h_ ((a1,a2,a3,a4),(b1,b2,b3,b4)) in
        let (retc1,retc2,retc3,retc4,retd1,retd2,retd3,retd4) = (if c1' then (Int64.shift_left Int64.one 7) else Int64.zero),(if c2' then (Int64.shift_left Int64.one 6) else Int64.zero),(if c3' then (Int64.shift_left Int64.one 5) else Int64.zero),(if c4' then (Int64.shift_left Int64.one 4) else Int64.zero),(if d1' then (Int64.shift_left Int64.one 3) else Int64.zero),(if d2' then (Int64.shift_left Int64.one 2) else Int64.zero),(if d3' then (Int64.shift_left Int64.one 1) else Int64.zero),(if d4' then (Int64.shift_left Int64.one 0) else Int64.zero)
        in Some ((retc1,retc2,retc3,retc4),(retd1,retd2,retd3,retd4))
    with Stream.Failure -> None)
