open Ocaml_runtime
let node1_ (x_) = 
    let x_ = x_ in 
    (x_)


let main x_stream = 
    Stream.from
    (fun _ -> 
    try
        let x = Stream.next x_stream in
        let (x1) = (x lsr 0 land 1 = 1) in
        let (x') = node1_ ((x1)) in
        let return1' = (if x' then 1 else 0) in Some return1'
    with Stream.Failure -> None)
