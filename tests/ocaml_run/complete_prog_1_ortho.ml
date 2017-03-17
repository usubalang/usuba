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


let nxor_ (x_,y_) = 
    let tmp_ = ((x_1) lxor (y_1)) in 
    let z_ = ((lnot (tmp_))) in 
    (z_)



let nand_ (x_,y_) = 
    let tmp_ = ((x_1) land (y_1)) in 
    let z_ = ((lnot (tmp_))) in 
    (z_)



let triple_nxor_ (x_,y_,z_) = 
    let tmp1_ = nxor_ (x_1,y_1) in 
    let b_ = nxor_ (tmp1_,z_1) in 
    (b_)



let random_box_ (x1_,x2_,x3_,x4_) = 
    let a_ = ((x1_1) lxor (x2_1)) in 
    let r1_ = ((x1_1) lor (x2_1)) in 
    let _tmp11_1 = nxor_ (a_,x3_1) in 
    let b_ = ((lnot (_tmp11_1))) in 
    let _tmp12_1 = triple_nxor_ (x2_1,x3_1,x4_1) in 
    let c_ = nand_ (b_,_tmp12_1) in 
    let _tmp13_1 = ((x1_1) lxor (x4_1)) in 
    let d_ = (c_) lor ((_tmp13_1)) in 
    let r2_ = (d_) lxor ((x3_1)) in 
    let _tmp14_1 = (b_) land (d_) in 
    let _tmp15_1 = ((x2_1) lor (x4_1)) in 
    let r3_ = nand_ (_tmp14_1,_tmp15_1) in 
    (r1_,r2_,r3_)


let main x1stream x2stream x3stream x4stream = 
  let cpt = ref 64 in
  let stack_r1 = ref [| |] in
  let stack_r2 = ref [| |] in
  let stack_r3 = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_r1.(!cpt),!stack_r2.(!cpt),!stack_r3.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x1 = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x1.(i) <- Stream.next x1stream
        done;
        let x1' = convert_ortho 1 x1 in
        let (x11) = (x1'.(63)) in

        let x2 = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x2.(i) <- Stream.next x2stream
        done;
        let x2' = convert_ortho 1 x2 in
        let (x21) = (x2'.(63)) in

        let x3 = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x3.(i) <- Stream.next x3stream
        done;
        let x3' = convert_ortho 1 x3 in
        let (x31) = (x3'.(63)) in

        let x4 = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x4.(i) <- Stream.next x4stream
        done;
        let x4' = convert_ortho 1 x4 in
        let (x41) = (x4'.(63)) in
        let (ret1,ret2,ret3) = random_box_ (x11,x21,x31,x41) in
        let r1 = Array.make 1 0 in
        r1.(0) <- ret64;
        stack_r1 := convert_unortho r1;

        let r2 = Array.make 1 0 in
        r2.(0) <- ret65;
        stack_r2 := convert_unortho r2;

        let r3 = Array.make 1 0 in
        r3.(0) <- ret66;
        stack_r3 := convert_unortho r3;

        cpt := 0;
        let return = Some (!stack_r1.(!cpt),!stack_r2.(!cpt),!stack_r3.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
