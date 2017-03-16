

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


let convert2 ((in1_1)) = 
    let out1_1 = in1_1 in 
    ((out1_1,out1_2),(out2_1,out2_2))



let sbox_ ((in_1,in_2,in_3,in_4)) = 
    let tmp_1_0_0_ = 0 in 
    let tmp_1_0_1_ = -1 in 
    let tmp_1_0_2_ = -1 in 
    let tmp_1_0_3_ = -1 in 
    let tmp_1_0_4_ = 0 in 
    let tmp_1_0_5_ = -1 in 
    let tmp_1_0_6_ = -1 in 
    let tmp_1_0_7_ = 0 in 
    let tmp_1_0_8_ = 0 in 
    let tmp_1_0_9_ = -1 in 
    let tmp_1_0_10_ = -1 in 
    let tmp_1_0_11_ = 0 in 
    let tmp_1_0_12_ = -1 in 
    let tmp_1_0_13_ = -1 in 
    let tmp_1_0_14_ = -1 in 
    let tmp_1_0_15_ = 0 in 
    let __tmp1_ = (lnot (in_4)) in 
    let __tmp2_ = tmp_1_0_0_ in 
    let __tmp3_ = (__tmp1_) land (__tmp2_) in 
    let __tmp4_ = (in_4) land (tmp_1_0_1_) in 
    let tmp_1_1_0_ = (__tmp3_) lor (__tmp4_) in 
    let __tmp5_ = (lnot (in_4)) in 
    let __tmp6_ = tmp_1_0_2_ in 
    let __tmp7_ = (__tmp5_) land (__tmp6_) in 
    let __tmp8_ = (in_4) land (tmp_1_0_3_) in 
    let tmp_1_1_1_ = (__tmp7_) lor (__tmp8_) in 
    let __tmp9_ = (lnot (in_4)) in 
    let __tmp10_ = tmp_1_0_4_ in 
    let __tmp11_ = (__tmp9_) land (__tmp10_) in 
    let __tmp12_ = (in_4) land (tmp_1_0_5_) in 
    let tmp_1_1_2_ = (__tmp11_) lor (__tmp12_) in 
    let __tmp13_ = (lnot (in_4)) in 
    let __tmp14_ = tmp_1_0_6_ in 
    let __tmp15_ = (__tmp13_) land (__tmp14_) in 
    let __tmp16_ = (in_4) land (tmp_1_0_7_) in 
    let tmp_1_1_3_ = (__tmp15_) lor (__tmp16_) in 
    let __tmp17_ = (lnot (in_4)) in 
    let __tmp18_ = tmp_1_0_8_ in 
    let __tmp19_ = (__tmp17_) land (__tmp18_) in 
    let __tmp20_ = (in_4) land (tmp_1_0_9_) in 
    let tmp_1_1_4_ = (__tmp19_) lor (__tmp20_) in 
    let __tmp21_ = (lnot (in_4)) in 
    let __tmp22_ = tmp_1_0_10_ in 
    let __tmp23_ = (__tmp21_) land (__tmp22_) in 
    let __tmp24_ = (in_4) land (tmp_1_0_11_) in 
    let tmp_1_1_5_ = (__tmp23_) lor (__tmp24_) in 
    let __tmp25_ = (lnot (in_4)) in 
    let __tmp26_ = tmp_1_0_12_ in 
    let __tmp27_ = (__tmp25_) land (__tmp26_) in 
    let __tmp28_ = (in_4) land (tmp_1_0_13_) in 
    let tmp_1_1_6_ = (__tmp27_) lor (__tmp28_) in 
    let __tmp29_ = (lnot (in_4)) in 
    let __tmp30_ = tmp_1_0_14_ in 
    let __tmp31_ = (__tmp29_) land (__tmp30_) in 
    let __tmp32_ = (in_4) land (tmp_1_0_15_) in 
    let tmp_1_1_7_ = (__tmp31_) lor (__tmp32_) in 
    let __tmp33_ = (lnot (in_3)) in 
    let __tmp34_ = tmp_1_1_0_ in 
    let __tmp35_ = (__tmp33_) land (__tmp34_) in 
    let __tmp36_ = (in_3) land (tmp_1_1_1_) in 
    let tmp_1_2_0_ = (__tmp35_) lor (__tmp36_) in 
    let __tmp37_ = (lnot (in_3)) in 
    let __tmp38_ = tmp_1_1_2_ in 
    let __tmp39_ = (__tmp37_) land (__tmp38_) in 
    let __tmp40_ = (in_3) land (tmp_1_1_3_) in 
    let tmp_1_2_1_ = (__tmp39_) lor (__tmp40_) in 
    let __tmp41_ = (lnot (in_3)) in 
    let __tmp42_ = tmp_1_1_4_ in 
    let __tmp43_ = (__tmp41_) land (__tmp42_) in 
    let __tmp44_ = (in_3) land (tmp_1_1_5_) in 
    let tmp_1_2_2_ = (__tmp43_) lor (__tmp44_) in 
    let __tmp45_ = (lnot (in_3)) in 
    let __tmp46_ = tmp_1_1_6_ in 
    let __tmp47_ = (__tmp45_) land (__tmp46_) in 
    let __tmp48_ = (in_3) land (tmp_1_1_7_) in 
    let tmp_1_2_3_ = (__tmp47_) lor (__tmp48_) in 
    let __tmp49_ = (lnot (in_2)) in 
    let __tmp50_ = tmp_1_2_0_ in 
    let __tmp51_ = (__tmp49_) land (__tmp50_) in 
    let __tmp52_ = (in_2) land (tmp_1_2_1_) in 
    let tmp_1_3_0_ = (__tmp51_) lor (__tmp52_) in 
    let __tmp53_ = (lnot (in_2)) in 
    let __tmp54_ = tmp_1_2_2_ in 
    let __tmp55_ = (__tmp53_) land (__tmp54_) in 
    let __tmp56_ = (in_2) land (tmp_1_2_3_) in 
    let tmp_1_3_1_ = (__tmp55_) lor (__tmp56_) in 
    let __tmp57_ = (lnot (in_1)) in 
    let __tmp58_ = tmp_1_3_0_ in 
    let __tmp59_ = (__tmp57_) land (__tmp58_) in 
    let __tmp60_ = (in_1) land (tmp_1_3_1_) in 
    let tmp_1_4_0_ = (__tmp59_) lor (__tmp60_) in 
    let out_1 = tmp_1_4_0_ in 
    let tmp_2_0_0_ = -1 in 
    let tmp_2_0_1_ = -1 in 
    let tmp_2_0_2_ = -1 in 
    let tmp_2_0_3_ = -1 in 
    let tmp_2_0_4_ = -1 in 
    let tmp_2_0_5_ = -1 in 
    let tmp_2_0_6_ = -1 in 
    let tmp_2_0_7_ = -1 in 
    let tmp_2_0_8_ = -1 in 
    let tmp_2_0_9_ = -1 in 
    let tmp_2_0_10_ = -1 in 
    let tmp_2_0_11_ = -1 in 
    let tmp_2_0_12_ = -1 in 
    let tmp_2_0_13_ = -1 in 
    let tmp_2_0_14_ = -1 in 
    let tmp_2_0_15_ = -1 in 
    let __tmp61_ = (lnot (in_4)) in 
    let __tmp62_ = tmp_2_0_0_ in 
    let __tmp63_ = (__tmp61_) land (__tmp62_) in 
    let __tmp64_ = (in_4) land (tmp_2_0_1_) in 
    let tmp_2_1_0_ = (__tmp63_) lor (__tmp64_) in 
    let __tmp65_ = (lnot (in_4)) in 
    let __tmp66_ = tmp_2_0_2_ in 
    let __tmp67_ = (__tmp65_) land (__tmp66_) in 
    let __tmp68_ = (in_4) land (tmp_2_0_3_) in 
    let tmp_2_1_1_ = (__tmp67_) lor (__tmp68_) in 
    let __tmp69_ = (lnot (in_4)) in 
    let __tmp70_ = tmp_2_0_4_ in 
    let __tmp71_ = (__tmp69_) land (__tmp70_) in 
    let __tmp72_ = (in_4) land (tmp_2_0_5_) in 
    let tmp_2_1_2_ = (__tmp71_) lor (__tmp72_) in 
    let __tmp73_ = (lnot (in_4)) in 
    let __tmp74_ = tmp_2_0_6_ in 
    let __tmp75_ = (__tmp73_) land (__tmp74_) in 
    let __tmp76_ = (in_4) land (tmp_2_0_7_) in 
    let tmp_2_1_3_ = (__tmp75_) lor (__tmp76_) in 
    let __tmp77_ = (lnot (in_4)) in 
    let __tmp78_ = tmp_2_0_8_ in 
    let __tmp79_ = (__tmp77_) land (__tmp78_) in 
    let __tmp80_ = (in_4) land (tmp_2_0_9_) in 
    let tmp_2_1_4_ = (__tmp79_) lor (__tmp80_) in 
    let __tmp81_ = (lnot (in_4)) in 
    let __tmp82_ = tmp_2_0_10_ in 
    let __tmp83_ = (__tmp81_) land (__tmp82_) in 
    let __tmp84_ = (in_4) land (tmp_2_0_11_) in 
    let tmp_2_1_5_ = (__tmp83_) lor (__tmp84_) in 
    let __tmp85_ = (lnot (in_4)) in 
    let __tmp86_ = tmp_2_0_12_ in 
    let __tmp87_ = (__tmp85_) land (__tmp86_) in 
    let __tmp88_ = (in_4) land (tmp_2_0_13_) in 
    let tmp_2_1_6_ = (__tmp87_) lor (__tmp88_) in 
    let __tmp89_ = (lnot (in_4)) in 
    let __tmp90_ = tmp_2_0_14_ in 
    let __tmp91_ = (__tmp89_) land (__tmp90_) in 
    let __tmp92_ = (in_4) land (tmp_2_0_15_) in 
    let tmp_2_1_7_ = (__tmp91_) lor (__tmp92_) in 
    let __tmp93_ = (lnot (in_3)) in 
    let __tmp94_ = tmp_2_1_0_ in 
    let __tmp95_ = (__tmp93_) land (__tmp94_) in 
    let __tmp96_ = (in_3) land (tmp_2_1_1_) in 
    let tmp_2_2_0_ = (__tmp95_) lor (__tmp96_) in 
    let __tmp97_ = (lnot (in_3)) in 
    let __tmp98_ = tmp_2_1_2_ in 
    let __tmp99_ = (__tmp97_) land (__tmp98_) in 
    let __tmp100_ = (in_3) land (tmp_2_1_3_) in 
    let tmp_2_2_1_ = (__tmp99_) lor (__tmp100_) in 
    let __tmp101_ = (lnot (in_3)) in 
    let __tmp102_ = tmp_2_1_4_ in 
    let __tmp103_ = (__tmp101_) land (__tmp102_) in 
    let __tmp104_ = (in_3) land (tmp_2_1_5_) in 
    let tmp_2_2_2_ = (__tmp103_) lor (__tmp104_) in 
    let __tmp105_ = (lnot (in_3)) in 
    let __tmp106_ = tmp_2_1_6_ in 
    let __tmp107_ = (__tmp105_) land (__tmp106_) in 
    let __tmp108_ = (in_3) land (tmp_2_1_7_) in 
    let tmp_2_2_3_ = (__tmp107_) lor (__tmp108_) in 
    let __tmp109_ = (lnot (in_2)) in 
    let __tmp110_ = tmp_2_2_0_ in 
    let __tmp111_ = (__tmp109_) land (__tmp110_) in 
    let __tmp112_ = (in_2) land (tmp_2_2_1_) in 
    let tmp_2_3_0_ = (__tmp111_) lor (__tmp112_) in 
    let __tmp113_ = (lnot (in_2)) in 
    let __tmp114_ = tmp_2_2_2_ in 
    let __tmp115_ = (__tmp113_) land (__tmp114_) in 
    let __tmp116_ = (in_2) land (tmp_2_2_3_) in 
    let tmp_2_3_1_ = (__tmp115_) lor (__tmp116_) in 
    let __tmp117_ = (lnot (in_1)) in 
    let __tmp118_ = tmp_2_3_0_ in 
    let __tmp119_ = (__tmp117_) land (__tmp118_) in 
    let __tmp120_ = (in_1) land (tmp_2_3_1_) in 
    let tmp_2_4_0_ = (__tmp119_) lor (__tmp120_) in 
    let out_2 = tmp_2_4_0_ in 
    (out_1,out_2)



let init_p_ ((in_1,in_2,in_3,in_4)) = 
    let out_1 = in_1 in 
    let out_2 = in_3 in 
    let out_3 = in_2 in 
    let out_4 = in_4 in 
    (out_1,out_2,out_3,out_4)



let array_var_ ((in1_1,in1_2),(in2_1,in2_2)) = 
    let (out_1,out_2) = (in2_1,in2_2) in 
    (out_1,out_2)



let array_node1_ ((input_1,input_2)) = 
    let (out_2,out_1) = (input_1,input_2) in 
    (out_1,out_2)



let array_node2_ ((input_1,input_2)) = 
    let (out_1,out_2) = (input_1,input_2) in 
    (out_1,out_2)



let main_ ((in_1,in_2,in_3,in_4)) = 
    let (in_1,in_2,in_3,in_4) = init_p_ (id ((in_1,in_2,in_3,in_4))) in 
    let (t1_1,t1_2) = sbox_ (id ((in_1,in_2,in_3,in_4))) in 
    let (t21_1,t21_2,t22_1,t22_2) = (in_1,in_2,in_3,in_4) in 
    let (t3_1,t3_2) = array_var_ (convert2 (t2_)) in 
    let (t4_1,t4_2) = array_node1_ (id ((t3_1,t3_2))) in 
    let (out_1,out_2,out_3,out_4) = (t3_1,t3_2,t4_1,t4_2) in 
    (out_1,out_2,out_3,out_4)


let main in_stream = 
  let cpt = ref 64 in
  let stack_out_ = ref [| |] in
  Stream.from
    (fun _ -> 
    if !cpt < 63 then let ret = (!stack_out_.(!cpt)) in
                          incr cpt;
                          Some ret
    else
      try
        let in_ = Array.make 63 Int64.zero in
        for i = 0 to 62 do
          in_.(i) <- Stream.next in_stream
        done;
        let in_' = convert_ortho 4 in_ in
        let (in_1,in_2,in_3,in_4) = (in_'.(63),in_'.(62),in_'.(61),in_'.(60)) in
        let (ret1,ret2,ret3,ret4) = main_((in_1,in_2,in_3,in_4)) in
        let out_ = Array.make 4 0 in
        out_.(0) <- ret64;
        out_.(1) <- ret63;
        out_.(2) <- ret62;
        out_.(3) <- ret61;
        stack_out_ := convert_unortho out_;

        cpt := 0;
        let return = Some (!stack_out_.(!cpt)) in 
        incr cpt;
        return
      with Stream.Failure -> None)
