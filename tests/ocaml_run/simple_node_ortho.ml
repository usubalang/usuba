

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


let node1_ (x_) = 
    let x_ = x_ in 
    (x_)


let main x_stream = 
  let cpt = ref 64 in
  let stack_x_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_x_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x_.(i) <- Stream.next x_stream
        done;
        let x_' = convert_ortho 1 x_ in
        let (x_1) = (x_'.(63)) in
        let (ret1) = node1_((x_1)) in
        let x_ = Array.make 1 0 in
        x_.(0) <- ret64;
        stack_x_ := convert_unortho x_;

        cpt := 0;
        let return = Some (!stack_x_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
