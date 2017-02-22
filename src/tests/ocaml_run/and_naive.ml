open Ocaml_runtime
let f_ x_1 x_2 x_3 x_4 y_1 y_2 y_3 y_4 = 
    let (z_1,z_2,z_3,z_4) = ((x_1) && (y_1),(x_2) && (y_2),(x_3) && (y_3),(x_4) && (y_4)) in 
    (z_1,z_2,z_3,z_4)
