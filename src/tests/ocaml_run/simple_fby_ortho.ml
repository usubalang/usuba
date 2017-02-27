let id x = x

let referencize1 (x1,x2,x3,x4) = ref x1,ref x2,ref x3,ref x4

let f_ = 
    let (c_1',c_2',c_3',c_4') = referencize1 ((false,false,false,true)) in

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
        let (d1,d2,d3,d4) = (d lsr 3 land 1 = 1,d lsr 2 land 1 = 1,d lsr 1 land 1 = 1,d lsr 0 land 1 = 1) in
        let (c1',c2',c3',c4') = f_ ((d1,d2,d3,d4)) in
        let (retc1,retc2,retc3,retc4) = (if c1' then 8 else 0)lor(if c2' then 4 else 0)lor(if c3' then 2 else 0)lor(if c4' then 1 else 0)
        in Some ((retc1,retc2,retc3,retc4))
    with Stream.Failure -> None)
