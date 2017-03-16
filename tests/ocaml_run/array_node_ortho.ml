

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


let f1_ ((input_1,input_2)) = 
    let (out_2,out_1) = (input_1,input_2) in 
    (out_1,out_2)



let f2_ ((input_1,input_2)) = 
    let (out_1,out_2) = (input_1,input_2) in 
    (out_1,out_2)



let main_ ((in_1,in_2)) = 
    let (tmp_1,tmp_2) = f1_ (id ((in_1,in_2))) in 
    let (out_1,out_2) = f2_ (id ((tmp_1,tmp_2))) in 
    (out_1,out_2)


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
        let in_' = convert_ortho 2 in_ in
        let (in_1,in_2) = (in_'.(63),in_'.(62)) in
        let (ret1,ret2) = main_((in_1,in_2)) in
        let out_ = Array.make 2 0 in
        out_.(0) <- ret64;
        out_.(1) <- ret63;
        stack_out_ := convert_unortho out_;

        cpt := 0;
        let return = Some (!stack_out_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
