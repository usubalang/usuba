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


let rrotate1' (input'1,input'2,input'3,input'4,input'5,input'6) = 
    let out'1 = input'6 in 
    let out'2 = input'1 in 
    let out'3 = input'2 in 
    let out'4 = input'3 in 
    let out'5 = input'4 in 
    let out'6 = input'5 in 
    (out'1,out'2,out'3,out'4,out'5,out'6)


let main inputstream = 
  let cpt = ref 64 in
  let stack_out = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_out.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let input = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          input.(i) <- Stream.next inputstream
        done;
        let input' = convert_ortho 6 input in
        let (input1,input2,input3,input4,input5,input6) = (input'.(63),input'.(62),input'.(61),input'.(60),input'.(59),input'.(58)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = rrotate1' (input1,input2,input3,input4,input5,input6) in
        let out = Array.make 6 0 in
        out.(0) <- ret6;
        out.(1) <- ret5;
        out.(2) <- ret4;
        out.(3) <- ret3;
        out.(4) <- ret2;
        out.(5) <- ret1;
        stack_out := convert_unortho out;

        cpt := 0;
        let return = Some (!stack_out.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
