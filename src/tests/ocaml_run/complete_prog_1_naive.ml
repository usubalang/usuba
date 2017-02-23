open Ocaml_runtime
let nxor_ (x_,y_) = 
    let tmp_ = ((x_) && (not (y_))) || ((not (x_)) && (y_)) in 
    let z_ = (not (tmp_)) in 
    (z_)


let nand_ (x_,y_) = 
    let tmp_ = (x_) && (y_) in 
    let z_ = (not (tmp_)) in 
    (z_)


let triple_nxor_ (x_,y_,z_) = 
    let tmp1_ = nxor_ (id (x_,y_)) in 
    let b_ = nxor_ (id (tmp1_,z_)) in 
    (b_)


let random_box_ (x1_,x2_,x3_,x4_) = 
    let a_ = ((x1_) && (not (x2_))) || ((not (x1_)) && (x2_)) in 
    let r1_ = (x1_) || (x2_) in 
    let b_ = (not (nxor_ (id (a_,x3_)))) in 
    let c_ = nand_ (id (b_,triple_nxor_ (id (x2_,x3_,x4_)))) in 
    let d_ = (c_) || (((x1_) && (not (x4_))) || ((not (x1_)) && (x4_))) in 
    let r2_ = ((d_) && (not (x3_))) || ((not (d_)) && (x3_)) in 
    let r3_ = nand_ (id ((b_) && (d_),(x2_) || (x4_))) in 
    (r1_,r2_,r3_)
