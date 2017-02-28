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

let referencize1 (x1,x2,x3,x4) = ref x1,ref x2,ref x3,ref x4

let f_ = 
    let (c_1',c_2',c_3',c_4') = referencize1 (0,0,0,-1) in

    fun ((d_1,d_2,d_3,d_4)) -> 
    let (c_1,c_2,c_3,c_4) = (!c_1',!c_2',!c_3',!c_4') in
let (c_1'',c_2'',c_3'',c_4'') = (((d_1) lor (c_1),(d_2) lor (c_2),(d_3) lor (c_3),(d_4) lor (c_4))) in
    c_1' := c_1'';
    c_2' := c_2'';
    c_3' := c_3'';
    c_4' := c_4'';
    (c_1,c_2,c_3,c_4)


let main d_stream = 
  let cpt = ref 0 in
  let stack_c = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_c.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let d = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          d.(i) <- Stream.next d_stream
        done;
        let d' = convert_ortho 4 d in
        let (d1,d2,d3,d4) = (d'.(0),d'.(1),d'.(2),d'.(3)) in
        let (ret1,ret2,ret3,ret4) = f_ ((d1,d2,d3,d4)) in
        let c = Array.make 4 0 in
        c.(1) <- ret1;
        c.(2) <- ret2;
        c.(3) <- ret3;
        c.(4) <- ret4;
        stack_c := convert_unortho c;

        cpt := 0;
        let return = Some (!stack_c.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
