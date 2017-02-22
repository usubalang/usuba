open Ocaml_runtime
let nxor x y = 
    let tmp = ((x) && (not (y))) || ((not (x)) && (y)) in 
    let z = not (tmp) in 
    (z)


let nand x y = 
    let tmp = (x) && (y) in 
    let z = not (tmp) in 
    (z)
