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


let f' (a'1,a'2,a'3,a'4,a'5,a'6) = 
    let b'1 = a'1 in 
    let b'2 = a'2 in 
    let b'3 = a'3 in 
    let b'4 = a'4 in 
    let c'1 = a'5 in 
    let c'2 = a'6 in 
    (b'1,b'2,b'3,b'4,c'1,c'2)


let main astream = 
  let cpt = ref 64 in
  let stack_b = ref [| |] in
  let stack_c = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_b.(!cpt),!stack_c.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let a = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a.(i) <- Stream.next astream
        done;
        let a' = convert_ortho 6 a in
        let (a1,a2,a3,a4,a5,a6) = (a'.(63),a'.(62),a'.(61),a'.(60),a'.(59),a'.(58)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f' (a1,a2,a3,a4,a5,a6) in
        let b = Array.make 4 0 in
        b.(0) <- ret4;
        b.(1) <- ret3;
        b.(2) <- ret2;
        b.(3) <- ret1;
        stack_b := convert_unortho b;

        let c = Array.make 2 0 in
        c.(0) <- ret6;
        c.(1) <- ret5;
        stack_c := convert_unortho c;

        cpt := 0;
        let return = Some (!stack_b.(!cpt),!stack_c.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
