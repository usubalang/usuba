open Ocaml_runtime
let f_or_ ((a_1,a_2,a_3,a_4),(b_1,b_2,b_3,b_4)) = 
    let (out_1,out_2,out_3,out_4) = ((a_1) || (b_1),(a_2) || (b_2),(a_3) || (b_3),(a_4) || (b_4)) in 
    (out_1,out_2,out_3,out_4)


let main a_stream b_stream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next a_stream in
        let (a1,a2,a3,a4) = (a lsr 3 land 1 = 1,a lsr 2 land 1 = 1,a lsr 1 land 1 = 1,a lsr 0 land 1 = 1) in
        let b = Stream.next b_stream in
        let (b1,b2,b3,b4) = (b lsr 3 land 1 = 1,b lsr 2 land 1 = 1,b lsr 1 land 1 = 1,b lsr 0 land 1 = 1) in
        let (out1',out2',out3',out4') = f_or_ ((a1,a2,a3,a4),(b1,b2,b3,b4)) in
        let out' = (if out1' then 8 else 0)lor(if out2' then 4 else 0)lor(if out3' then 2 else 0)lor(if out4' then 1 else 0) in Some out'
    with Stream.Failure -> None)
