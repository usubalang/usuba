

let id x = x

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


let f_ ((in_1,in_2,in_3,in_4,in_5,in_6)) = 
    let (__tmp1_1,__tmp1_2,__tmp1_3,__tmp1_4,__tmp1_5,__tmp1_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp2_1,__tmp2_2,__tmp2_3,__tmp2_4,__tmp2_5,__tmp2_6) = ((lnot (__tmp1_1)),(lnot (__tmp1_2)),(lnot (__tmp1_3)),(lnot (__tmp1_4)),(lnot (__tmp1_5)),(lnot (__tmp1_6))) in 
    let (__tmp3_1,__tmp3_2,__tmp3_3,__tmp3_4,__tmp3_5,__tmp3_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp4_1,__tmp4_2,__tmp4_3,__tmp4_4,__tmp4_5,__tmp4_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp5_1,__tmp5_2,__tmp5_3,__tmp5_4,__tmp5_5,__tmp5_6) = (in_1,in_2,in_3,in_4,in_5,in_6) in 
    let (__tmp6_1,__tmp6_2,__tmp6_3,__tmp6_4,__tmp6_5,__tmp6_6) = ((__tmp2_1) land (__tmp3_1),(__tmp2_2) land (__tmp3_2),(__tmp2_3) land (__tmp3_3),(__tmp2_4) land (__tmp3_4),(__tmp2_5) land (__tmp3_5),(__tmp2_6) land (__tmp3_6)) in 
    let (__tmp7_1,__tmp7_2,__tmp7_3,__tmp7_4,__tmp7_5,__tmp7_6) = ((__tmp4_1) land (__tmp5_1),(__tmp4_2) land (__tmp5_2),(__tmp4_3) land (__tmp5_3),(__tmp4_4) land (__tmp5_4),(__tmp4_5) land (__tmp5_5),(__tmp4_6) land (__tmp5_6)) in 
    let (out_1,out_2,out_3,out_4,out_5,out_6) = ((__tmp6_1) lor (__tmp7_1),(__tmp6_2) lor (__tmp7_2),(__tmp6_3) lor (__tmp7_3),(__tmp6_4) lor (__tmp7_4),(__tmp6_5) lor (__tmp7_5),(__tmp6_6) lor (__tmp7_6)) in 
    (out_1,out_2,out_3,out_4,out_5,out_6)


let main in_stream = 
  let cpt = ref 64 in
  let stack_out_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_out_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let in_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in_.(i) <- Stream.next in_stream
        done;
        let in_' = convert_ortho 6 in_ in
        let (in_1,in_2,in_3,in_4,in_5,in_6) = (in_'.(63),in_'.(62),in_'.(61),in_'.(60),in_'.(59),in_'.(58)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f_((in_1,in_2,in_3,in_4,in_5,in_6)) in
        let out_ = Array.make 6 0 in
        out_.(0) <- ret64;
        out_.(1) <- ret63;
        out_.(2) <- ret62;
        out_.(3) <- ret61;
        out_.(4) <- ret60;
        out_.(5) <- ret59;
        stack_out_ := convert_unortho out_;

        cpt := 0;
        let return = Some (!stack_out_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
