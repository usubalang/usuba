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


let f' (x',y') = 
    let z' = (y') + (x') in 
    (z')


let main xstream ystream = 
  let cpt = ref 64 in
  let stack_z = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_z.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x.(i) <- Stream.next xstream
        done;
        let x' = convert_ortho 8 x in
        let (x1,x2,x3,x4,x5,x6,x7,x8) = (x'.(63),x'.(62),x'.(61),x'.(60),x'.(59),x'.(58),x'.(57),x'.(56)) in

        let y = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          y.(i) <- Stream.next ystream
        done;
        let y' = convert_ortho 8 y in
        let (y1,y2,y3,y4,y5,y6,y7,y8) = (y'.(63),y'.(62),y'.(61),y'.(60),y'.(59),y'.(58),y'.(57),y'.(56)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8) = f' (x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8) in
        let z = Array.make 8 0 in
        z.(0) <- ret8;
        z.(1) <- ret7;
        z.(2) <- ret6;
        z.(3) <- ret5;
        z.(4) <- ret4;
        z.(5) <- ret3;
        z.(6) <- ret2;
        z.(7) <- ret1;
        stack_z := convert_unortho z;

        cpt := 0;
        let return = Some (!stack_z.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
