
exception Different_values of int * int * int 

let sbox_4_table =
  [|
    [| 7; 13; 14; 3; 0; 6; 9; 10; 1; 2; 8; 5; 11; 12; 4; 15 |];
    [| 13; 8; 11; 5; 6; 15; 0; 3; 4; 7; 2; 12; 1; 10; 14; 9 |];
    [| 10; 6; 9; 0; 12; 11; 7; 13; 15; 1; 3; 14; 5; 2; 8; 4 |];
    [| 3; 15; 0; 6; 10; 1; 13; 8; 9; 4; 5; 11; 12; 7; 2; 14 |]
   |]

  
let s4_std n =
  let row = ((n lsr 4) land 2) lor (n land 1) in
  let col = (n lsr 1) land 15 in
  sbox_4_table.(row).(col)

let sbox_4_logical a1 a2 a3 a4 a5 a6 = 
    let x1 = lnot (a1) in 
    let x2 = lnot (a3) in 
    let x3 = (a3) lor (a1) in 
    let x4 = (x3) land (a5) in 
    let x5 = (x4) lxor (x1) in 
    let x6 = (a3) lor (a2) in 
    let x7 = (x6) lxor (x5) in 
    let x8 = (a5) land (a1) in 
    let x9 = (x3) lxor (x8) in 
    let x10 = (x9) land (a2) in 
    let x11 = (x10) lxor (a5) in 
    let x12 = (x11) land (a4) in 
    let x13 = (x12) lxor (x7) in 
    let x14 = (x4) lxor (x2) in 
    let x15 = (x14) land (a2) in 
    let x16 = (x15) lxor (x9) in 
    let x17 = (x14) land (x5) in 
    let x18 = (x2) lxor (a5) in 
    let x19 = (x18) lor (a2) in 
    let x20 = (x19) lxor (x17) in 
    let x21 = (x20) lor (a4) in 
    let x22 = (x21) lxor (x16) in 
    let x23 = (x22) land (a6) in 
    let x24 = (x23) lxor (x13) in 
    let out2 = x24 in 
    let x25 = lnot (x13) in 
    let x26 = (x22) lor (a6) in 
    let x27 = (x26) lxor (x25) in 
    let out1 = x27 in 
    let x28 = (x11) land (a2) in 
    let x29 = (x17) lxor (x28) in 
    let x30 = (x10) lxor (a3) in 
    let x31 = (x19) lxor (x30) in 
    let x32 = (x31) land (a4) in 
    let x33 = (x32) lxor (x29) in 
    let x34 = (x33) lxor (x25) in 
    let x35 = (x34) land (a2) in 
    let x36 = (x35) lxor (x24) in 
    let x37 = (x34) lor (a4) in 
    let x38 = (x37) lxor (x36) in 
    let x39 = (x38) land (a6) in 
    let x40 = (x39) lxor (x33) in 
    let out4 = x40 in 
    let x41 = (x38) lxor (x26) in 
    let x42 = (x40) lxor (x41) in 
    let out3 = x42 in 
    (out1,out2,out3,out4)



let s4_logical n =
  let (r1, r2, r3, r4) = sbox_4_logical ((n lsr 5) land 1)
                                        ((n lsr 4) land 1)
                                        ((n lsr 3) land 1)
                                        ((n lsr 2) land 1)
                                        ((n lsr 1) land 1)
                                        ((n lsr 0) land 1) in
  (r4 land 1) lor ((r3 land 1) lsl 1) lor ((r2 land 1) lsl 2) lor ((r1 land 1) lsl 3)


                  
let main () =
  let rec iter n =
    if n < 64 then
      let std = s4_std n in
      let log = s4_logical n in
      if std <> log then
        raise (Different_values(n,std,log))
      else
        iter (n+1)
  in iter 0

let () = begin
    main ();
    Printf.printf "Both boxes are equivalent.\n"
  end
           
