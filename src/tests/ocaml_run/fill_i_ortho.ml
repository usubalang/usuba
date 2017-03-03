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


let f_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((lnot (in_1),lnot (in_2),lnot (in_3),lnot (in_4))) in 
    (out_1,out_2,out_3,out_4)



let f1_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((lnot (in_1),lnot (in_2),lnot (in_3),lnot (in_4))) in 
    (out_1,out_2,out_3,out_4)



let f2_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((lnot (in_1),lnot (in_2),lnot (in_3),lnot (in_4))) in 
    (out_1,out_2,out_3,out_4)



let main_ ((init_1,init_2,init_3,init_4),(in1_1,in1_2,in1_3,in1_4),(in2_1,in2_2,in2_3,in2_4),(in3_1,in3_2,in3_3,in3_4)) = 
    let (out1_1,out1_2,out1_3,out1_4) = (init_1,init_2,init_3,init_4) in 
    let (out2_1,out2_2,out2_3,out2_4) = f1_ (id ((out1_1,out1_2,out1_3,out1_4))) in 
    let (out3_1,out3_2,out3_3,out3_4) = f2_ (id ((out2_1,out2_2,out2_3,out2_4))) in 
    (out1_1,out1_2,out1_3,out1_4,out2_1,out2_2,out2_3,out2_4,out3_1,out3_2,out3_3,out3_4)


let main init_stream in1_stream in2_stream in3_stream = 
  let cpt = ref 64 in
  let stack_out1_ = ref [| |] in
  let stack_out2_ = ref [| |] in
  let stack_out3_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_out1_.(!cpt),!stack_out2_.(!cpt),!stack_out3_.(!cpt)) in
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

        let in1_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in1_.(i) <- Stream.next in1_stream
        done;
        let in1_' = convert_ortho 4 in1_ in
        let (in1_1,in1_2,in1_3,in1_4) = (in1_'.(0),in1_'.(1),in1_'.(2),in1_'.(3)) in

        let in2_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in2_.(i) <- Stream.next in2_stream
        done;
        let in2_' = convert_ortho 4 in2_ in
        let (in2_1,in2_2,in2_3,in2_4) = (in2_'.(0),in2_'.(1),in2_'.(2),in2_'.(3)) in

        let in3_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in3_.(i) <- Stream.next in3_stream
        done;
        let in3_' = convert_ortho 4 in3_ in
        let (in3_1,in3_2,in3_3,in3_4) = (in3_'.(0),in3_'.(1),in3_'.(2),in3_'.(3)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12) = main_((init_1,init_2,init_3,init_4),(in1_1,in1_2,in1_3,in1_4),(in2_1,in2_2,in2_3,in2_4),(in3_1,in3_2,in3_3,in3_4)) in
        let out1_ = Array.make 4 0 in
        out1_.(1) <- ret1;
        out1_.(2) <- ret2;
        out1_.(3) <- ret3;
        out1_.(4) <- ret4;
        stack_out1_ := convert_unortho out1_;

        let out2_ = Array.make 4 0 in
        out2_.(1) <- ret5;
        out2_.(2) <- ret6;
        out2_.(3) <- ret7;
        out2_.(4) <- ret8;
        stack_out2_ := convert_unortho out2_;

        let out3_ = Array.make 4 0 in
        out3_.(1) <- ret9;
        out3_.(2) <- ret10;
        out3_.(3) <- ret11;
        out3_.(4) <- ret12;
        stack_out3_ := convert_unortho out3_;

        cpt := 0;
        let return = Some (!stack_out1_.(!cpt),!stack_out2_.(!cpt),!stack_out3_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
