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


let key1_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_4,out_2,out_3) = (in_1,in_2,in_3,in_4) in 
    (out_1,out_2,out_3,out_4)



let key2_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_4,out_3,out_2,out_1) = (in_1,in_2,in_3,in_4) in 
    (out_1,out_2,out_3,out_4)



let key3_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_2,out_3,out_4) = (in2_1,in2_2,in_1,in_4) in 
    (out_1,out_2,out_3,out_4)



let f1_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_2,out_3,out_4) = key1_ (id ((in_1,in_2,in_3,in_4),(in2_1,in2_2))) in 
    let (out2_1,out2_2) = (in2_1,in2_2) in 
    (out_1,out_2,out_3,out_4,out2_1,out2_2)



let f2_ ((in_1,in_2,in_3,in_4),(in2_1,in2_2)) = 
    let (out_1,out_2,out_3,out_4) = key2_ (id ((in_1,in_2,in_3,in_4),(in2_1,in2_2))) in 
    let (out2_1,out2_2) = (in2_1,in2_2) in 
    (out_1,out_2,out_3,out_4,out2_1,out2_2)



let main_ ((init_1,init_2,init_3,init_4),(supp_1,supp_2)) = 
    let (__tmp1_1,__tmp1_2,__tmp1_3,__tmp1_4) = (init_1,init_2,init_3,init_4) in 
    let (__tmp2_1,__tmp2_2,__tmp2_3,__tmp2_4) = (init_1,init_2,init_3,init_4) in 
    let (__tmp3_1,__tmp3_2,__tmp3_3,__tmp3_4) = ((__tmp1_1) land (__tmp2_1),(__tmp1_2) land (__tmp2_2),(__tmp1_3) land (__tmp2_3),(__tmp1_4) land (__tmp2_4)) in 
    let (__tmp4_1,__tmp4_2,__tmp4_3,__tmp4_4) = (init_1,init_2,init_3,init_4) in 
    let (tmp1_1,tmp1_2,tmp1_3,tmp1_4,tmp21_1,tmp21_2) = ((__tmp3_1) land (__tmp4_1),(__tmp3_2) land (__tmp4_2),(__tmp3_3) land (__tmp4_3),(__tmp3_4) land (__tmp4_4),supp_1,supp_2) in 
    let (tmp2_1,tmp2_2,tmp2_3,tmp2_4,tmp22_1,tmp22_2) = f1_ (id ((tmp1_1,tmp1_2,tmp1_3,tmp1_4),(tmp21_1,tmp21_2))) in 
    let (tmp3_1,tmp3_2,tmp3_3,tmp3_4,tmp23_1,tmp23_2) = f2_ (id ((tmp2_1,tmp2_2,tmp2_3,tmp2_4),(tmp22_1,tmp22_2))) in 
    let (out_1,out_2,out_3,out_4) = (tmp3_1,tmp3_2,tmp3_3,tmp3_4) in 
    (out_1,out_2,out_3,out_4)


let main init_stream supp_stream = 
  let cpt = ref 64 in
  let stack_out_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_out_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let init_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          init_.(i) <- Stream.next init_stream
        done;
        let init_' = convert_ortho 4 init_ in
        let (init_1,init_2,init_3,init_4) = (init_'.(0),init_'.(1),init_'.(2),init_'.(3)) in

        let supp_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          supp_.(i) <- Stream.next supp_stream
        done;
        let supp_' = convert_ortho 2 supp_ in
        let (supp_1,supp_2) = (supp_'.(0),supp_'.(1)) in
        let (ret1,ret2,ret3,ret4) = main_((init_1,init_2,init_3,init_4),(supp_1,supp_2)) in
        let out_ = Array.make 4 0 in
        out_.(1) <- ret1;
        out_.(2) <- ret2;
        out_.(3) <- ret3;
        out_.(4) <- ret4;
        stack_out_ := convert_unortho out_;

        cpt := 0;
        let return = Some (!stack_out_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
