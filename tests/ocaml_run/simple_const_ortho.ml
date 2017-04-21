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


let test_tuple' (a'1,a'2,a'3) = 
    let b'1 = a'1 in 
    let b'2 = a'2 in 
    let b'3 = a'3 in 
    let b'4 = 0 in 
    let b'5 = 0 in 
    let b'6 = 0 in 
    let b'7 = -1 in 
    let b'8 = -1 in 
    (b'1,b'2,b'3,b'4,b'5,b'6,b'7,b'8)


let main astream = 
  let cpt = ref 64 in
  let stack_b = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_b.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let a = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          a.(i) <- Stream.next astream
        done;
        let a' = convert_ortho 3 a in
        let (a1,a2,a3) = (a'.(63),a'.(62),a'.(61)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8) = test_tuple' (a1,a2,a3) in
        let b = Array.make 8 0 in
        b.(0) <- ret8;
        b.(1) <- ret7;
        b.(2) <- ret6;
        b.(3) <- ret5;
        b.(4) <- ret4;
        b.(5) <- ret3;
        b.(6) <- ret2;
        b.(7) <- ret1;
        stack_b := convert_unortho b;

        cpt := 0;
        let return = Some (!stack_b.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
