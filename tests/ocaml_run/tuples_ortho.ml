

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


let assing_ ((a_1,a_2,a_3,a_4,a_5,a_6),(b_1,b_2,b_3,b_4),(c_1,c_2)) = 
    let (c_1,c_2,b_1,b_2,b_3,b_4) = (b_1,b_2,b_3,b_4,c_1,c_2) in 
    let (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12) = (b_1,b_2,b_3,b_4,a_1,a_2,a_3,a_4,a_5,a_6,c_1,c_2) in 
    (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12)


let main a_stream b_stream c_stream = 
  let cpt = ref 64 in
  let stack_d_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_d_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let a_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a_.(i) <- Stream.next a_stream
        done;
        let a_' = convert_ortho 6 a_ in
        let (a_1,a_2,a_3,a_4,a_5,a_6) = (a_'.(63),a_'.(62),a_'.(61),a_'.(60),a_'.(59),a_'.(58)) in

        let b_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          b_.(i) <- Stream.next b_stream
        done;
        let b_' = convert_ortho 4 b_ in
        let (b_1,b_2,b_3,b_4) = (b_'.(63),b_'.(62),b_'.(61),b_'.(60)) in

        let c_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          c_.(i) <- Stream.next c_stream
        done;
        let c_' = convert_ortho 2 c_ in
        let (c_1,c_2) = (c_'.(63),c_'.(62)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12) = assing_((a_1,a_2,a_3,a_4,a_5,a_6),(b_1,b_2,b_3,b_4),(c_1,c_2)) in
        let d_ = Array.make 12 0 in
        d_.(0) <- ret64;
        d_.(1) <- ret63;
        d_.(2) <- ret62;
        d_.(3) <- ret61;
        d_.(4) <- ret60;
        d_.(5) <- ret59;
        d_.(6) <- ret58;
        d_.(7) <- ret57;
        d_.(8) <- ret56;
        d_.(9) <- ret55;
        d_.(10) <- ret54;
        d_.(11) <- ret53;
        stack_d_ := convert_unortho d_;

        cpt := 0;
        let return = Some (!stack_d_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
