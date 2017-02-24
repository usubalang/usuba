open Ocaml_runtime
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
