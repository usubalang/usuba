
(* naive algorithm, not very efficient *)
(* it can be used to convert both from and to orthogonal format *)
(* size will typically be 64 *)
let convert_ortho (size: int) (input: int array) : int array =
  let out = Array.make size 0 in
  for i = 0 to Array.length input - 1 do
    for j = 0 to size-1 do
      let b = (input.(i) lsr j) land 1 in
      out.(j) <- out.(j) lor (b lsl i)
    done
  done;
  out

    
