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


let node1_ (x_) = 
    let x_ = (x_1) in 
    (x_)


let main xstream = 
  let cpt = ref 64 in
  let stack_x = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_x.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x.(i) <- Stream.next xstream
        done;
        let x' = convert_ortho 1 x in
        let (x1) = (x'.(63)) in
        let (ret1) = node1_ (x1) in
        let x = Array.make 1 0 in
        x.(0) <- ret64;
        stack_x := convert_unortho x;

        cpt := 0;
        let return = Some (!stack_x.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)