let convert_ortho (size: int) (input: int64 array) : int array =
  let out = Array.make size 0 in
  for i = 0 to Array.length input - 1 do
    for j = 0 to size-1 do
      let b = Int64.to_int (Int64.logand (Int64.shift_right input.(i) j) Int64.one) in
      out.(j) <- out.(j) lor (b lsl i)
    done
  done;
  out
 

let convert_unortho (input: int array) : int64 array =
  let out = Array.make 63 Int64.zero in
  for i = 0 to Array.length input - 1 do
    for j = 0 to 62 do
      let b = Int64.of_int (input.(i) lsr j land 1) in
      out.(j) <- Int64.logor out.(j) (Int64.shift_left b i)
    done
  done;
 out


let sbox_4' (a'1,a'2,a'3,a'4,a'5,a'6) = 
    let x'1 = not' (a'1) in 
    let x'2 = not' (a'3) in 
    let x'3 = or' (a'1,a'3) in 
    let x'4 = and' (a'5,x'3) in 
    let x'5 = xor' (x'1,x'4) in 
    let x'6 = or' (a'2,a'3) in 
    let x'7 = xor' (x'5,x'6) in 
    let x'8 = and' (a'1,a'5) in 
    let x'9 = xor' (x'8,x'3) in 
    let x'10 = and' (a'2,x'9) in 
    let x'11 = xor' (a'5,x'10) in 
    let x'12 = and' (a'4,x'11) in 
    let x'13 = xor' (x'7,x'12) in 
    let x'14 = xor' (x'2,x'4) in 
    let x'15 = and' (a'2,x'14) in 
    let x'16 = xor' (x'9,x'15) in 
    let x'17 = and' (x'5,x'14) in 
    let x'18 = xor' (a'5,x'2) in 
    let x'19 = or' (a'2,x'18) in 
    let x'20 = xor' (x'17,x'19) in 
    let x'21 = or' (a'4,x'20) in 
    let x'22 = xor' (x'16,x'21) in 
    let x'23 = and' (a'6,x'22) in 
    let x'24 = xor' (x'13,x'23) in 
    let out'2 = x'24 in 
    let x'25 = not' (x'13) in 
    let x'26 = or' (a'6,x'22) in 
    let x'27 = xor' (x'25,x'26) in 
    let out'1 = x'27 in 
    let x'28 = and' (a'2,x'11) in 
    let x'29 = xor' (x'28,x'17) in 
    let x'30 = xor' (a'3,x'10) in 
    let x'31 = xor' (x'30,x'19) in 
    let x'32 = and' (a'4,x'31) in 
    let x'33 = xor' (x'29,x'32) in 
    let x'34 = xor' (x'25,x'33) in 
    let x'35 = and' (a'2,x'34) in 
    let x'36 = xor' (x'24,x'35) in 
    let x'37 = or' (a'4,x'34) in 
    let x'38 = xor' (x'36,x'37) in 
    let x'39 = and' (a'6,x'38) in 
    let x'40 = xor' (x'33,x'39) in 
    let out'4 = x'40 in 
    let x'41 = xor' (x'26,x'38) in 
    let x'42 = xor' (x'41,x'40) in 
    let out'3 = x'42 in 
    (out'1,out'2,out'3,out'4)


let main astream = 
  let cpt = ref 64 in
  let stack_out = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_out.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let a = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a.(i) <- Stream.next astream
        done;
        let a' = convert_ortho 6 a in
        let (a1,a2,a3,a4,a5,a6) = (a'.(63),a'.(62),a'.(61),a'.(60),a'.(59),a'.(58)) in
        let (ret1,ret2,ret3,ret4) = sbox_4' (a1,a2,a3,a4,a5,a6) in
        let out = Array.make 4 0 in
        out.(0) <- ret64;
        out.(1) <- ret63;
        out.(2) <- ret62;
        out.(3) <- ret61;
        stack_out := convert_unortho out;

        cpt := 0;
        let return = Some (!stack_out.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
