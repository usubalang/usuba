open Ocaml_runtime
let f_ ((x_1,x_2,x_3,x_4),(y_1,y_2,y_3,y_4)) = 
    let (z_1,z_2,z_3,z_4) = ((x_1) land (y_1),(x_2) land (y_2),(x_3) land (y_3),(x_4) land (y_4)) in 
    (z_1,z_2,z_3,z_4)


let main x_stream y_stream = 
    Stream.from
    (fun _ -> 
    try
        let x = Stream.next x_stream in
        let (x1,x2,x3,x4) = (x lsr 3 land 1 = 1,x lsr 2 land 1 = 1,x lsr 1 land 1 = 1,x lsr 0 land 1 = 1) in
        let y = Stream.next y_stream in
        let (y1,y2,y3,y4) = (y lsr 3 land 1 = 1,y lsr 2 land 1 = 1,y lsr 1 land 1 = 1,y lsr 0 land 1 = 1) in
        let (z1',z2',z3',z4') = f_ ((x1,x2,x3,x4),(y1,y2,y3,y4)) in
        let return1' = (if z1' then 8 else 0)lor(if z2' then 4 else 0)lor(if z3' then 2 else 0)lor(if z4' then 1 else 0) in Some return1'
    with Stream.Failure -> None)
