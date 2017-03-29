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


let f' (a'1,a'2,a'3,a'4) = 
    let _tmp91_1 = lnot (a'4) in 
    let tmp_1_1_3 = (_tmp91_1) lor (a'4) in 
    let _tmp115_1 = lnot (a'3) in 
    let _tmp117_1 = (a'3) land (_tmp91_1) in 
    let _tmp119_1 = (_tmp115_1) land (_tmp91_1) in 
    let _tmp120_1 = (a'3) land (tmp_1_1_3) in 
    let tmp_1_2_1 = (_tmp119_1) lor (_tmp120_1) in 
    let _tmp122_1 = (_tmp115_1) land (a'4) in 
    let tmp_1_2_2 = (_tmp122_1) lor (_tmp117_1) in 
    let _tmp127_1 = lnot (a'2) in 
    let _tmp128_1 = (_tmp127_1) land (_tmp117_1) in 
    let _tmp129_1 = (a'2) land (tmp_1_2_1) in 
    let tmp_1_3_0 = (_tmp128_1) lor (_tmp129_1) in 
    let _tmp131_1 = (_tmp127_1) land (tmp_1_2_2) in 
    let _tmp132_1 = (a'2) land (_tmp117_1) in 
    let tmp_1_3_1 = (_tmp131_1) lor (_tmp132_1) in 
    let _tmp133_1 = lnot (a'1) in 
    let _tmp134_1 = (_tmp133_1) land (tmp_1_3_0) in 
    let _tmp135_1 = (a'1) land (tmp_1_3_1) in 
    let tmp_1_4_0 = (_tmp134_1) lor (_tmp135_1) in 
    let b'1 = tmp_1_4_0 in 
    let _tmp162_1 = (a'3) land (a'4) in 
    let tmp_2_2_0 = (_tmp119_1) lor (_tmp162_1) in 
    let _tmp173_1 = (_tmp127_1) land (tmp_2_2_0) in 
    let _tmp174_1 = (a'2) land (tmp_2_2_0) in 
    let tmp_2_3_0 = (_tmp173_1) lor (_tmp174_1) in 
    let _tmp176_1 = (_tmp127_1) land (tmp_1_2_1) in 
    let _tmp177_1 = (a'2) land (tmp_1_2_2) in 
    let tmp_2_3_1 = (_tmp176_1) lor (_tmp177_1) in 
    let _tmp179_1 = (_tmp133_1) land (tmp_2_3_0) in 
    let _tmp180_1 = (a'1) land (tmp_2_3_1) in 
    let tmp_2_4_0 = (_tmp179_1) lor (_tmp180_1) in 
    let b'2 = tmp_2_4_0 in 
    (b'1,b'2)



let main' (a') = 
    let b' = a' in 
    (b')


let main astream = 
  let cpt = ref 64 in
  let stack_b = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_b.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let a = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a.(i) <- Stream.next astream
        done;
        let a' = convert_ortho 1 a in
        let (a1) = (a'.(63)) in
        let (ret1) = main' (a1) in
        let b = Array.make 1 0 in
        b.(0) <- ret64;
        stack_b := convert_unortho b;

        cpt := 0;
        let return = Some (!stack_b.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
