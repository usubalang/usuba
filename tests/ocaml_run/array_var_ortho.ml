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


let f_ ((in1_1,in1_2),(in2_1,in2_2)) = 
    let (out_1,out_2) = (in2_1,in2_2) in 
    (out_1,out_2)


let main in1_stream in2_stream = 
  let cpt = ref 64 in
  let stack_out_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_out_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let in1_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in1_.(i) <- Stream.next in1_stream
        done;
        let in1_' = convert_ortho 2 in1_ in
        let (in1_1,in1_2) = (in1_'.(0),in1_'.(1)) in

        let in2_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in2_.(i) <- Stream.next in2_stream
        done;
        let in2_' = convert_ortho 2 in2_ in
        let (in2_1,in2_2) = (in2_'.(0),in2_'.(1)) in
        let (ret1,ret2) = f_((in1_1,in1_2),(in2_1,in2_2)) in
        let out_ = Array.make 2 0 in
        out_.(1) <- ret1;
        out_.(2) <- ret2;
        stack_out_ := convert_unortho out_;

        cpt := 0;
        let return = Some (!stack_out_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
