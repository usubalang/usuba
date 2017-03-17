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


let nor_ (x_1,x_2,y_1,y_2) = 
    let _tmp3_1 = (x_1) lor (y_1) in 
    let _tmp3_2 = (x_2) lor (y_2) in 
    let out_1 = (lnot (_tmp3_1)) in 
    let out_2 = (lnot (_tmp3_2)) in 
    (out_1,out_2)



let main_ (in_1,in_2,in_3,in_4) = 
    let x_1 = in_1 in 
    let x_2 = in_2 in 
    let y_1 = in_3 in 
    let y_2 = in_4 in 
    let (out_1,out_2) = nor_ (x_1,x_2,y_1,y_2) in 
    (out_1,out_2)


let main instream = 
  let cpt = ref 64 in
  let stack_out = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_out.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let in = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in.(i) <- Stream.next instream
        done;
        let in' = convert_ortho 4 in in
        let (in1,in2,in3,in4) = (in'.(63),in'.(62),in'.(61),in'.(60)) in
        let (ret1,ret2) = main_ (in1,in2,in3,in4) in
        let out = Array.make 2 0 in
        out.(0) <- ret64;
        out.(1) <- ret63;
        stack_out := convert_unortho out;

        cpt := 0;
        let return = Some (!stack_out.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
