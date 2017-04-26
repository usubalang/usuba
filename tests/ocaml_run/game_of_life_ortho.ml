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


let is_live' (v',a'1,a'2,a'3,a'4,a'5,a'6,a'7,a'8) = 
    let _tmp23_ = lnot (s1') in 
    let _tmp24_ = lnot (s2') in 
    let _tmp35_ = (_tmp24_) land (_tmp23_) in 
    let _tmp26_ = (s3') land (_tmp35_) in 
    let _tmp27_ = (_tmp26_) land (v') in 
    let _tmp28_ = lnot (v') in 
    let _tmp29_ = lnot (v1') in 
    let _tmp30_ = lnot (v2') in 
    let _tmp36_ = (_tmp30_) land (_tmp29_) in 
    let _tmp32_ = (v3') land (_tmp36_) in 
    let _tmp33_ = (v4') land (_tmp32_) in 
    let _tmp37_ = (_tmp33_) land (_tmp28_) in 
    let _tmp38_ = (_tmp37_) lor (_tmp27_) in 
    let b' = _tmp38_ in 
    (b')


let main vstream astream = 
  let cpt = ref 64 in
  let stack_b = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_b.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let v = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          v.(i) <- Stream.next vstream
        done;
        let v' = convert_ortho 1 v in
        let (v1) = (v'.(63)) in

        let a = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a.(i) <- Stream.next astream
        done;
        let a' = convert_ortho 8 a in
        let (a1,a2,a3,a4,a5,a6,a7,a8) = (a'.(63),a'.(62),a'.(61),a'.(60),a'.(59),a'.(58),a'.(57),a'.(56)) in
        let (ret1) = is_live' (v1,a1,a2,a3,a4,a5,a6,a7,a8) in
        let b = Array.make 1 0 in
        b.(0) <- ret1;
        stack_b := convert_unortho b;

        cpt := 0;
        let return = Some (!stack_b.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
