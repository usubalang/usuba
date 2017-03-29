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


let main' (x'0'1,x'0'2,x'0'3,x'0'4,x'0'5,x'0'6,x'1'1,x'1'2,x'1'3,x'1'4,x'1'5,x'1'6) = 
    let nxor'0__tmp9_1 = (x'1'1) lxor (x'0'1) in 
    let nxor'0__tmp10_1 = (x'1'2) lxor (x'0'2) in 
    let nxor'0__tmp11_1 = (x'1'3) lxor (x'0'3) in 
    let nxor'0__tmp12_1 = (x'1'4) lxor (x'0'4) in 
    let nxor'0__tmp13_1 = (x'1'5) lxor (x'0'5) in 
    let nxor'0__tmp14_1 = (x'1'6) lxor (x'0'6) in 
    let nxor'0_z'1 = lnot (nxor'0__tmp9_1) in 
    let nxor'0_z'2 = lnot (nxor'0__tmp10_1) in 
    let nxor'0_z'3 = lnot (nxor'0__tmp11_1) in 
    let nxor'0_z'4 = lnot (nxor'0__tmp12_1) in 
    let nxor'0_z'5 = lnot (nxor'0__tmp13_1) in 
    let nxor'0_z'6 = lnot (nxor'0__tmp14_1) in 
    let z'0'1 = nxor'0_z'1 in 
    let z'0'2 = nxor'0_z'2 in 
    let z'0'3 = nxor'0_z'3 in 
    let z'0'4 = nxor'0_z'4 in 
    let z'0'5 = nxor'0_z'5 in 
    let z'0'6 = nxor'0_z'6 in 
    let z'1'1 = nxor'0_z'1 in 
    let z'1'2 = nxor'0_z'2 in 
    let z'1'3 = nxor'0_z'3 in 
    let z'1'4 = nxor'0_z'4 in 
    let z'1'5 = nxor'0_z'5 in 
    let z'1'6 = nxor'0_z'6 in 
    (z'0'1,z'0'2,z'0'3,z'0'4,z'0'5,z'0'6,z'1'1,z'1'2,z'1'3,z'1'4,z'1'5,z'1'6)


let main x0'stream x1'stream = 
  let cpt = ref 64 in
  let stack_z0' = ref [| |] in
  let stack_z1' = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_z0'.(!cpt),!stack_z1'.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x0' = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x0'.(i) <- Stream.next x0'stream
        done;
        let x0'' = convert_ortho 6 x0' in
        let (x0'1,x0'2,x0'3,x0'4,x0'5,x0'6) = (x0''.(63),x0''.(62),x0''.(61),x0''.(60),x0''.(59),x0''.(58)) in

        let x1' = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x1'.(i) <- Stream.next x1'stream
        done;
        let x1'' = convert_ortho 6 x1' in
        let (x1'1,x1'2,x1'3,x1'4,x1'5,x1'6) = (x1''.(63),x1''.(62),x1''.(61),x1''.(60),x1''.(59),x1''.(58)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6,ret7,ret8,ret9,ret10,ret11,ret12) = main' (x0'1,x0'2,x0'3,x0'4,x0'5,x0'6,x1'1,x1'2,x1'3,x1'4,x1'5,x1'6) in
        let z0' = Array.make 6 0 in
        z0'.(0) <- ret6;
        z0'.(1) <- ret5;
        z0'.(2) <- ret4;
        z0'.(3) <- ret3;
        z0'.(4) <- ret2;
        z0'.(5) <- ret1;
        stack_z0' := convert_unortho z0';

        let z1' = Array.make 6 0 in
        z1'.(0) <- ret12;
        z1'.(1) <- ret11;
        z1'.(2) <- ret10;
        z1'.(3) <- ret9;
        z1'.(4) <- ret8;
        z1'.(5) <- ret7;
        stack_z1' := convert_unortho z1';

        cpt := 0;
        let return = Some (!stack_z0'.(!cpt),!stack_z1'.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
