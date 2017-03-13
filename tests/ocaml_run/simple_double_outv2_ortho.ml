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

let f_ ((a_1,a_2,a_3,a_4,a_5,a_6)) = 
    let (b_1,b_2,b_3,b_4,c_1,c_2) = (a_1,a_2,a_3,a_4,a_5,a_6) in 
    (b_1,b_2,b_3,b_4,c_1,c_2)


let main a_stream = 
  let cpt = ref 0 in
  let stack_b = ref [| |] in
  let stack_c = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 64 then let ret = (!stack_b.(!cpt),!stack_c.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let a = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a.(i) <- Stream.next a_stream
        done;
        let a' = convert_ortho 6 a in
        let (a1,a2,a3,a4,a5,a6) = (a'.(0),a'.(1),a'.(2),a'.(3),a'.(4),a'.(5)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f_ ((a1,a2,a3,a4,a5,a6)) in
        let b = Array.make 4 0 in
        b.(1) <- ret1;
        b.(2) <- ret2;
        b.(3) <- ret3;
        b.(4) <- ret4;
        stack_b := convert_unortho b;

        let c = Array.make 2 0 in
        c.(1) <- ret5;
        c.(2) <- ret6;
        stack_c := convert_unortho c;

        cpt := 0;
        let return = Some (!stack_b.(!cpt),!stack_c.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
