

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


let f_ ((x_1,x_2,x_3,x_4,x_5,x_6),(y_1,y_2,y_3,y_4,y_5,y_6)) = 
    let (__tmp1_1,__tmp1_2,__tmp1_3,__tmp1_4,__tmp1_5,__tmp1_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp2_1,__tmp2_2,__tmp2_3,__tmp2_4,__tmp2_5,__tmp2_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (x_1,x_2,x_3,x_4,x_5,x_6) = (((__tmp1_1) land ((lnot (__tmp2_1)))) lor (((lnot (__tmp1_1))) land (__tmp2_1)),((__tmp1_2) land ((lnot (__tmp2_2)))) lor (((lnot (__tmp1_2))) land (__tmp2_2)),((__tmp1_3) land ((lnot (__tmp2_3)))) lor (((lnot (__tmp1_3))) land (__tmp2_3)),((__tmp1_4) land ((lnot (__tmp2_4)))) lor (((lnot (__tmp1_4))) land (__tmp2_4)),((__tmp1_5) land ((lnot (__tmp2_5)))) lor (((lnot (__tmp1_5))) land (__tmp2_5)),((__tmp1_6) land ((lnot (__tmp2_6)))) lor (((lnot (__tmp1_6))) land (__tmp2_6))) in 
    let (__tmp3_1,__tmp3_2,__tmp3_3,__tmp3_4,__tmp3_5,__tmp3_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (__tmp4_1,__tmp4_2,__tmp4_3,__tmp4_4,__tmp4_5,__tmp4_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (y_1,y_2,y_3,y_4,y_5,y_6) = ((__tmp3_1) lor (__tmp4_1),(__tmp3_2) lor (__tmp4_2),(__tmp3_3) lor (__tmp4_3),(__tmp3_4) lor (__tmp4_4),(__tmp3_5) lor (__tmp4_5),(__tmp3_6) lor (__tmp4_6)) in 
    let (__tmp5_1,__tmp5_2,__tmp5_3,__tmp5_4,__tmp5_5,__tmp5_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (__tmp6_1,__tmp6_2,__tmp6_3,__tmp6_4,__tmp6_5,__tmp6_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp7_1,__tmp7_2,__tmp7_3,__tmp7_4,__tmp7_5,__tmp7_6) = ((lnot (__tmp5_1)),(lnot (__tmp5_2)),(lnot (__tmp5_3)),(lnot (__tmp5_4)),(lnot (__tmp5_5)),(lnot (__tmp5_6))) in 
    let (x_1,x_2,x_3,x_4,x_5,x_6) = ((__tmp6_1) land (__tmp7_1),(__tmp6_2) land (__tmp7_2),(__tmp6_3) land (__tmp7_3),(__tmp6_4) land (__tmp7_4),(__tmp6_5) land (__tmp7_5),(__tmp6_6) land (__tmp7_6)) in 
    let (__tmp8_1,__tmp8_2,__tmp8_3,__tmp8_4,__tmp8_5,__tmp8_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp9_1,__tmp9_2,__tmp9_3,__tmp9_4,__tmp9_5,__tmp9_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (__tmp10_1,__tmp10_2,__tmp10_3,__tmp10_4,__tmp10_5,__tmp10_6) = ((__tmp8_1) lor (__tmp9_1),(__tmp8_2) lor (__tmp9_2),(__tmp8_3) lor (__tmp9_3),(__tmp8_4) lor (__tmp9_4),(__tmp8_5) lor (__tmp9_5),(__tmp8_6) lor (__tmp9_6)) in 
    let (__tmp11_1,__tmp11_2,__tmp11_3,__tmp11_4,__tmp11_5,__tmp11_6) = (x_1,x_2,x_3,x_4,x_5,x_6) in 
    let (__tmp12_1,__tmp12_2,__tmp12_3,__tmp12_4,__tmp12_5,__tmp12_6) = (((__tmp10_1) land ((lnot (__tmp11_1)))) lor (((lnot (__tmp10_1))) land (__tmp11_1)),((__tmp10_2) land ((lnot (__tmp11_2)))) lor (((lnot (__tmp10_2))) land (__tmp11_2)),((__tmp10_3) land ((lnot (__tmp11_3)))) lor (((lnot (__tmp10_3))) land (__tmp11_3)),((__tmp10_4) land ((lnot (__tmp11_4)))) lor (((lnot (__tmp10_4))) land (__tmp11_4)),((__tmp10_5) land ((lnot (__tmp11_5)))) lor (((lnot (__tmp10_5))) land (__tmp11_5)),((__tmp10_6) land ((lnot (__tmp11_6)))) lor (((lnot (__tmp10_6))) land (__tmp11_6))) in 
    let (__tmp13_1,__tmp13_2,__tmp13_3,__tmp13_4,__tmp13_5,__tmp13_6) = (y_1,y_2,y_3,y_4,y_5,y_6) in 
    let (z_1,z_2,z_3,z_4,z_5,z_6) = ((__tmp12_1) land (__tmp13_1),(__tmp12_2) land (__tmp13_2),(__tmp12_3) land (__tmp13_3),(__tmp12_4) land (__tmp13_4),(__tmp12_5) land (__tmp13_5),(__tmp12_6) land (__tmp13_6)) in 
    (z_1,z_2,z_3,z_4,z_5,z_6)


let main x_stream y_stream = 
  let cpt = ref 64 in
  let stack_z_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_z_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let x_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          x_.(i) <- Stream.next x_stream
        done;
        let x_' = convert_ortho 6 x_ in
        let (x_1,x_2,x_3,x_4,x_5,x_6) = (x_'.(63),x_'.(62),x_'.(61),x_'.(60),x_'.(59),x_'.(58)) in

        let y_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          y_.(i) <- Stream.next y_stream
        done;
        let y_' = convert_ortho 6 y_ in
        let (y_1,y_2,y_3,y_4,y_5,y_6) = (y_'.(63),y_'.(62),y_'.(61),y_'.(60),y_'.(59),y_'.(58)) in
        let (ret1,ret2,ret3,ret4,ret5,ret6) = f_((x_1,x_2,x_3,x_4,x_5,x_6),(y_1,y_2,y_3,y_4,y_5,y_6)) in
        let z_ = Array.make 6 0 in
        z_.(0) <- ret64;
        z_.(1) <- ret63;
        z_.(2) <- ret62;
        z_.(3) <- ret61;
        z_.(4) <- ret60;
        z_.(5) <- ret59;
        stack_z_ := convert_unortho z_;

        cpt := 0;
        let return = Some (!stack_z_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
