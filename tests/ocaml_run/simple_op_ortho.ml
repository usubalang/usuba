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


let f' (x'1,x'2,x'3,x'4,x'5,x'6,y'1,y'2,y'3,y'4,y'5,y'6) = 
    let _tmp32_1 = (y'1) lxor (x'1) in 
    let _tmp33_1 = (y'2) lxor (x'2) in 
    let _tmp34_1 = (y'3) lxor (x'3) in 
    let _tmp35_1 = (y'4) lxor (x'4) in 
    let _tmp36_1 = (y'5) lxor (x'5) in 
    let _tmp37_1 = (y'6) lxor (x'6) in 
    let _tmp38_1 = (_tmp32_1) lor (y'1) in 
    let _tmp39_1 = (_tmp33_1) lor (y'2) in 
    let _tmp40_1 = (_tmp34_1) lor (y'3) in 
    let _tmp41_1 = (_tmp35_1) lor (y'4) in 
    let _tmp42_1 = (_tmp36_1) lor (y'5) in 
    let _tmp43_1 = (_tmp37_1) lor (y'6) in 
    let _tmp44_1 = lnot (_tmp38_1) in 
    let _tmp44_2 = lnot (_tmp39_1) in 
    let _tmp44_3 = lnot (_tmp40_1) in 
    let _tmp44_4 = lnot (_tmp41_1) in 
    let _tmp44_5 = lnot (_tmp42_1) in 
    let _tmp44_6 = lnot (_tmp43_1) in 
    let x'1 = (_tmp44_1) land (_tmp32_1) in 
    let x'2 = (_tmp44_2) land (_tmp33_1) in 
    let x'3 = (_tmp44_3) land (_tmp34_1) in 
    let x'4 = (_tmp44_4) land (_tmp35_1) in 
    let x'5 = (_tmp44_5) land (_tmp36_1) in 
    let x'6 = (_tmp44_6) land (_tmp37_1) in 
    let _tmp45_1 = (_tmp38_1) lor (_tmp32_1) in 
    let _tmp46_1 = (_tmp32_1) lxor (_tmp45_1) in 
    let _tmp47_1 = (_tmp38_1) land (_tmp46_1) in 
    let _tmp48_1 = (_tmp39_1) lor (_tmp33_1) in 
    let _tmp49_1 = (_tmp33_1) lxor (_tmp48_1) in 
    let _tmp50_1 = (_tmp39_1) land (_tmp49_1) in 
    let _tmp51_1 = (_tmp40_1) lor (_tmp34_1) in 
    let _tmp52_1 = (_tmp34_1) lxor (_tmp51_1) in 
    let _tmp53_1 = (_tmp40_1) land (_tmp52_1) in 
    let _tmp54_1 = (_tmp41_1) lor (_tmp35_1) in 
    let _tmp55_1 = (_tmp35_1) lxor (_tmp54_1) in 
    let _tmp56_1 = (_tmp41_1) land (_tmp55_1) in 
    let _tmp57_1 = (_tmp42_1) lor (_tmp36_1) in 
    let _tmp58_1 = (_tmp36_1) lxor (_tmp57_1) in 
    let _tmp59_1 = (_tmp42_1) land (_tmp58_1) in 
    let _tmp60_1 = (_tmp43_1) lor (_tmp37_1) in 
    let _tmp61_1 = (_tmp37_1) lxor (_tmp60_1) in 
    let _tmp62_1 = (_tmp43_1) land (_tmp61_1) in 
    let z'1 = _tmp47_1 in 
    let z'2 = _tmp50_1 in 
    let z'3 = _tmp53_1 in 
    let z'4 = _tmp56_1 in 
    let z'5 = _tmp59_1 in 
    let z'6 = _tmp62_1 in 
    (z'1,z'2,z'3,z'4,z'5,z'6)


let main xstream ystream = 
  let cpt = ref 64 in
  let stack_z = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_z.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x.(i) <- Stream.next xstream
        done;
        let x' = convert_ortho 6 x in
        let (x1,x2,x3,x4,x5,x6) = (x'.(63),x'.(62),x'.(61),x'.(60),x'.(59),x'.(58)) in

        let y = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          y.(i) <- Stream.next ystream
        done;
        let y' = convert_ortho 6 y in
        let (y1,y2,y3,y4,y5,y6) = (y'.(63),y'.(62),y'.(61),y'.(60),y'.(59),y'.(58)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f' (x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6) in
        let z = Array.make 6 0 in
        z.(0) <- ret6;
        z.(1) <- ret5;
        z.(2) <- ret4;
        z.(3) <- ret3;
        z.(4) <- ret2;
        z.(5) <- ret1;
        stack_z := convert_unortho z;

        cpt := 0;
        let return = Some (!stack_z.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
