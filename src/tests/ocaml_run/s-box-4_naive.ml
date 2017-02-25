open Ocaml_runtime
let sbox_4_ ((a_1,a_2,a_3,a_4,a_5,a_6)) = 
    let x_1 = (not (a_1)) in 
    let x_2 = (not (a_3)) in 
    let x_3 = (a_1) || (a_3) in 
    let x_4 = (a_5) && (x_3) in 
    let x_5 = ((x_1) && (not (x_4))) || ((not (x_1)) && (x_4)) in 
    let x_6 = (a_2) || (a_3) in 
    let x_7 = ((x_5) && (not (x_6))) || ((not (x_5)) && (x_6)) in 
    let x_8 = (a_1) && (a_5) in 
    let x_9 = ((x_8) && (not (x_3))) || ((not (x_8)) && (x_3)) in 
    let x_10 = (a_2) && (x_9) in 
    let x_11 = ((a_5) && (not (x_10))) || ((not (a_5)) && (x_10)) in 
    let x_12 = (a_4) && (x_11) in 
    let x_13 = ((x_7) && (not (x_12))) || ((not (x_7)) && (x_12)) in 
    let x_14 = ((x_2) && (not (x_4))) || ((not (x_2)) && (x_4)) in 
    let x_15 = (a_2) && (x_14) in 
    let x_16 = ((x_9) && (not (x_15))) || ((not (x_9)) && (x_15)) in 
    let x_17 = (x_5) && (x_14) in 
    let x_18 = ((a_5) && (not (x_2))) || ((not (a_5)) && (x_2)) in 
    let x_19 = (a_2) || (x_18) in 
    let x_20 = ((x_17) && (not (x_19))) || ((not (x_17)) && (x_19)) in 
    let x_21 = (a_4) || (x_20) in 
    let x_22 = ((x_16) && (not (x_21))) || ((not (x_16)) && (x_21)) in 
    let x_23 = (a_6) && (x_22) in 
    let x_24 = ((x_13) && (not (x_23))) || ((not (x_13)) && (x_23)) in 
    let out_2 = x_24 in 
    let x_25 = (not (x_13)) in 
    let x_26 = (a_6) || (x_22) in 
    let x_27 = ((x_25) && (not (x_26))) || ((not (x_25)) && (x_26)) in 
    let out_1 = x_27 in 
    let x_28 = (a_2) && (x_11) in 
    let x_29 = ((x_28) && (not (x_17))) || ((not (x_28)) && (x_17)) in 
    let x_30 = ((a_3) && (not (x_10))) || ((not (a_3)) && (x_10)) in 
    let x_31 = ((x_30) && (not (x_19))) || ((not (x_30)) && (x_19)) in 
    let x_32 = (a_4) && (x_31) in 
    let x_33 = ((x_29) && (not (x_32))) || ((not (x_29)) && (x_32)) in 
    let x_34 = ((x_25) && (not (x_33))) || ((not (x_25)) && (x_33)) in 
    let x_35 = (a_2) && (x_34) in 
    let x_36 = ((x_24) && (not (x_35))) || ((not (x_24)) && (x_35)) in 
    let x_37 = (a_4) || (x_34) in 
    let x_38 = ((x_36) && (not (x_37))) || ((not (x_36)) && (x_37)) in 
    let x_39 = (a_6) && (x_38) in 
    let x_40 = ((x_33) && (not (x_39))) || ((not (x_33)) && (x_39)) in 
    let out_4 = x_40 in 
    let x_41 = ((x_26) && (not (x_38))) || ((not (x_26)) && (x_38)) in 
    let x_42 = ((x_41) && (not (x_40))) || ((not (x_41)) && (x_40)) in 
    let out_3 = x_42 in 
    (out_1,out_2,out_3,out_4)


let main a_stream = 
    Stream.from
    (fun _ -> 
    try
        let a = Stream.next a_stream in
        let (a1,a2,a3,a4,a5,a6) = (a lsr 5 land 1 = 1,a lsr 4 land 1 = 1,a lsr 3 land 1 = 1,a lsr 2 land 1 = 1,a lsr 1 land 1 = 1,a lsr 0 land 1 = 1) in
        let (out1',out2',out3',out4') = sbox_4_ ((a1,a2,a3,a4,a5,a6)) in
        let out' = (if out1' then 8 else 0)lor(if out2' then 4 else 0)lor(if out3' then 2 else 0)lor(if out4' then 1 else 0) in Some out'
    with Stream.Failure -> None)
