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

let expand_fun_1 (in_0_1,in_0_2,in_0_3,in_0_4) =
    let (in_1_1,in_1_2,in_1_3,in_1_4) = cst_not_ (in_0_1,in_0_2,in_0_3,in_0_4) in
    let (in_2_1,in_2_2,in_2_3,in_2_4) = cst_not_ (in_1_1,in_1_2,in_1_3,in_1_4) in
    let (in_3_1,in_3_2,in_3_3,in_3_4) = cst_not_ (in_2_1,in_2_2,in_2_3,in_2_4) in
    let (in_4_1,in_4_2,in_4_3,in_4_4) = cst_not_ (in_3_1,in_3_2,in_3_3,in_3_4) in
    let (in_5_1,in_5_2,in_5_3,in_5_4) = cst_not_ (in_4_1,in_4_2,in_4_3,in_4_4) in
    let (in_6_1,in_6_2,in_6_3,in_6_4) = cst_not_ (in_5_1,in_5_2,in_5_3,in_5_4) in
    let (in_7_1,in_7_2,in_7_3,in_7_4) = cst_not_ (in_6_1,in_6_2,in_6_3,in_6_4) in
    let (in_8_1,in_8_2,in_8_3,in_8_4) = cst_not_ (in_7_1,in_7_2,in_7_3,in_7_4) in
    let (in_9_1,in_9_2,in_9_3,in_9_4) = cst_not_ (in_8_1,in_8_2,in_8_3,in_8_4) in
    let (in_10_1,in_10_2,in_10_3,in_10_4) = cst_not_ (in_9_1,in_9_2,in_9_3,in_9_4) in
    let (in_11_1,in_11_2,in_11_3,in_11_4) = cst_not_ (in_10_1,in_10_2,in_10_3,in_10_4) in
    let (in_12_1,in_12_2,in_12_3,in_12_4) = cst_not_ (in_11_1,in_11_2,in_11_3,in_11_4) in
    let (in_13_1,in_13_2,in_13_3,in_13_4) = cst_not_ (in_12_1,in_12_2,in_12_3,in_12_4) in
    let (in_14_1,in_14_2,in_14_3,in_14_4) = cst_not_ (in_13_1,in_13_2,in_13_3,in_13_4) in
    let (in_15_1,in_15_2,in_15_3,in_15_4) = cst_not_ (in_14_1,in_14_2,in_14_3,in_14_4) in
    let (in_16_1,in_16_2,in_16_3,in_16_4) = cst_not_ (in_15_1,in_15_2,in_15_3,in_15_4) in
    let (in_17_1,in_17_2,in_17_3,in_17_4) = cst_not_ (in_16_1,in_16_2,in_16_3,in_16_4) in
    let (in_18_1,in_18_2,in_18_3,in_18_4) = cst_not_ (in_17_1,in_17_2,in_17_3,in_17_4) in
    let (in_19_1,in_19_2,in_19_3,in_19_4) = cst_not_ (in_18_1,in_18_2,in_18_3,in_18_4) in
    let (in_20_1,in_20_2,in_20_3,in_20_4) = cst_not_ (in_19_1,in_19_2,in_19_3,in_19_4) in
    let (in_21_1,in_21_2,in_21_3,in_21_4) = cst_not_ (in_20_1,in_20_2,in_20_3,in_20_4) in
    let (in_22_1,in_22_2,in_22_3,in_22_4) = cst_not_ (in_21_1,in_21_2,in_21_3,in_21_4) in
    let (in_23_1,in_23_2,in_23_3,in_23_4) = cst_not_ (in_22_1,in_22_2,in_22_3,in_22_4) in
    let (in_24_1,in_24_2,in_24_3,in_24_4) = cst_not_ (in_23_1,in_23_2,in_23_3,in_23_4) in
    let (in_25_1,in_25_2,in_25_3,in_25_4) = cst_not_ (in_24_1,in_24_2,in_24_3,in_24_4) in
    let (in_26_1,in_26_2,in_26_3,in_26_4) = cst_not_ (in_25_1,in_25_2,in_25_3,in_25_4) in
    let (in_27_1,in_27_2,in_27_3,in_27_4) = cst_not_ (in_26_1,in_26_2,in_26_3,in_26_4) in
    let (in_28_1,in_28_2,in_28_3,in_28_4) = cst_not_ (in_27_1,in_27_2,in_27_3,in_27_4) in
    let (in_29_1,in_29_2,in_29_3,in_29_4) = cst_not_ (in_28_1,in_28_2,in_28_3,in_28_4) in
    let (in_30_1,in_30_2,in_30_3,in_30_4) = cst_not_ (in_29_1,in_29_2,in_29_3,in_29_4) in
    let (in_31_1,in_31_2,in_31_3,in_31_4) = cst_not_ (in_30_1,in_30_2,in_30_3,in_30_4) in
    let (in_32_1,in_32_2,in_32_3,in_32_4) = cst_not_ (in_31_1,in_31_2,in_31_3,in_31_4) in
    let (in_33_1,in_33_2,in_33_3,in_33_4) = cst_not_ (in_32_1,in_32_2,in_32_3,in_32_4) in
    let (in_34_1,in_34_2,in_34_3,in_34_4) = cst_not_ (in_33_1,in_33_2,in_33_3,in_33_4) in
    let (in_35_1,in_35_2,in_35_3,in_35_4) = cst_not_ (in_34_1,in_34_2,in_34_3,in_34_4) in
    let (in_36_1,in_36_2,in_36_3,in_36_4) = cst_not_ (in_35_1,in_35_2,in_35_3,in_35_4) in
    let (in_37_1,in_37_2,in_37_3,in_37_4) = cst_not_ (in_36_1,in_36_2,in_36_3,in_36_4) in
    let (in_38_1,in_38_2,in_38_3,in_38_4) = cst_not_ (in_37_1,in_37_2,in_37_3,in_37_4) in
    let (in_39_1,in_39_2,in_39_3,in_39_4) = cst_not_ (in_38_1,in_38_2,in_38_3,in_38_4) in
    let (in_40_1,in_40_2,in_40_3,in_40_4) = cst_not_ (in_39_1,in_39_2,in_39_3,in_39_4) in
    let (in_41_1,in_41_2,in_41_3,in_41_4) = cst_not_ (in_40_1,in_40_2,in_40_3,in_40_4) in
    let (in_42_1,in_42_2,in_42_3,in_42_4) = cst_not_ (in_41_1,in_41_2,in_41_3,in_41_4) in
    let (in_43_1,in_43_2,in_43_3,in_43_4) = cst_not_ (in_42_1,in_42_2,in_42_3,in_42_4) in
    let (in_44_1,in_44_2,in_44_3,in_44_4) = cst_not_ (in_43_1,in_43_2,in_43_3,in_43_4) in
    let (in_45_1,in_45_2,in_45_3,in_45_4) = cst_not_ (in_44_1,in_44_2,in_44_3,in_44_4) in
    let (in_46_1,in_46_2,in_46_3,in_46_4) = cst_not_ (in_45_1,in_45_2,in_45_3,in_45_4) in
    let (in_47_1,in_47_2,in_47_3,in_47_4) = cst_not_ (in_46_1,in_46_2,in_46_3,in_46_4) in
    let (in_48_1,in_48_2,in_48_3,in_48_4) = cst_not_ (in_47_1,in_47_2,in_47_3,in_47_4) in
    let (in_49_1,in_49_2,in_49_3,in_49_4) = cst_not_ (in_48_1,in_48_2,in_48_3,in_48_4) in
    let (in_50_1,in_50_2,in_50_3,in_50_4) = cst_not_ (in_49_1,in_49_2,in_49_3,in_49_4) in
    let (in_51_1,in_51_2,in_51_3,in_51_4) = cst_not_ (in_50_1,in_50_2,in_50_3,in_50_4) in
    let (in_52_1,in_52_2,in_52_3,in_52_4) = cst_not_ (in_51_1,in_51_2,in_51_3,in_51_4) in
    let (in_53_1,in_53_2,in_53_3,in_53_4) = cst_not_ (in_52_1,in_52_2,in_52_3,in_52_4) in
    let (in_54_1,in_54_2,in_54_3,in_54_4) = cst_not_ (in_53_1,in_53_2,in_53_3,in_53_4) in
    let (in_55_1,in_55_2,in_55_3,in_55_4) = cst_not_ (in_54_1,in_54_2,in_54_3,in_54_4) in
    let (in_56_1,in_56_2,in_56_3,in_56_4) = cst_not_ (in_55_1,in_55_2,in_55_3,in_55_4) in
    let (in_57_1,in_57_2,in_57_3,in_57_4) = cst_not_ (in_56_1,in_56_2,in_56_3,in_56_4) in
    let (in_58_1,in_58_2,in_58_3,in_58_4) = cst_not_ (in_57_1,in_57_2,in_57_3,in_57_4) in
    let (in_59_1,in_59_2,in_59_3,in_59_4) = cst_not_ (in_58_1,in_58_2,in_58_3,in_58_4) in
    let (in_60_1,in_60_2,in_60_3,in_60_4) = cst_not_ (in_59_1,in_59_2,in_59_3,in_59_4) in
    let (in_61_1,in_61_2,in_61_3,in_61_4) = cst_not_ (in_60_1,in_60_2,in_60_3,in_60_4) in
    let (in_62_1,in_62_2,in_62_3,in_62_4) = cst_not_ (in_61_1,in_61_2,in_61_3,in_61_4) in
    let out1 = (in_0_1 lsl 0) lor (in_1_1 lsl 1) lor (in_2_1 lsl 2) lor (in_3_1 lsl 3) lor (in_4_1 lsl 4) lor (in_5_1 lsl 5) lor (in_6_1 lsl 6) lor (in_7_1 lsl 7) lor (in_8_1 lsl 8) lor (in_9_1 lsl 9) lor (in_10_1 lsl 10) lor (in_11_1 lsl 11) lor (in_12_1 lsl 12) lor (in_13_1 lsl 13) lor (in_14_1 lsl 14) lor (in_15_1 lsl 15) lor (in_16_1 lsl 16) lor (in_17_1 lsl 17) lor (in_18_1 lsl 18) lor (in_19_1 lsl 19) lor (in_20_1 lsl 20) lor (in_21_1 lsl 21) lor (in_22_1 lsl 22) lor (in_23_1 lsl 23) lor (in_24_1 lsl 24) lor (in_25_1 lsl 25) lor (in_26_1 lsl 26) lor (in_27_1 lsl 27) lor (in_28_1 lsl 28) lor (in_29_1 lsl 29) lor (in_30_1 lsl 30) lor (in_31_1 lsl 31) lor (in_32_1 lsl 32) lor (in_33_1 lsl 33) lor (in_34_1 lsl 34) lor (in_35_1 lsl 35) lor (in_36_1 lsl 36) lor (in_37_1 lsl 37) lor (in_38_1 lsl 38) lor (in_39_1 lsl 39) lor (in_40_1 lsl 40) lor (in_41_1 lsl 41) lor (in_42_1 lsl 42) lor (in_43_1 lsl 43) lor (in_44_1 lsl 44) lor (in_45_1 lsl 45) lor (in_46_1 lsl 46) lor (in_47_1 lsl 47) lor (in_48_1 lsl 48) lor (in_49_1 lsl 49) lor (in_50_1 lsl 50) lor (in_51_1 lsl 51) lor (in_52_1 lsl 52) lor (in_53_1 lsl 53) lor (in_54_1 lsl 54) lor (in_55_1 lsl 55) lor (in_56_1 lsl 56) lor (in_57_1 lsl 57) lor (in_58_1 lsl 58) lor (in_59_1 lsl 59) lor (in_60_1 lsl 60) lor (in_61_1 lsl 61) lor (in_62_1 lsl 62) in
    let out2 = (in_0_2 lsl 0) lor (in_1_2 lsl 1) lor (in_2_2 lsl 2) lor (in_3_2 lsl 3) lor (in_4_2 lsl 4) lor (in_5_2 lsl 5) lor (in_6_2 lsl 6) lor (in_7_2 lsl 7) lor (in_8_2 lsl 8) lor (in_9_2 lsl 9) lor (in_10_2 lsl 10) lor (in_11_2 lsl 11) lor (in_12_2 lsl 12) lor (in_13_2 lsl 13) lor (in_14_2 lsl 14) lor (in_15_2 lsl 15) lor (in_16_2 lsl 16) lor (in_17_2 lsl 17) lor (in_18_2 lsl 18) lor (in_19_2 lsl 19) lor (in_20_2 lsl 20) lor (in_21_2 lsl 21) lor (in_22_2 lsl 22) lor (in_23_2 lsl 23) lor (in_24_2 lsl 24) lor (in_25_2 lsl 25) lor (in_26_2 lsl 26) lor (in_27_2 lsl 27) lor (in_28_2 lsl 28) lor (in_29_2 lsl 29) lor (in_30_2 lsl 30) lor (in_31_2 lsl 31) lor (in_32_2 lsl 32) lor (in_33_2 lsl 33) lor (in_34_2 lsl 34) lor (in_35_2 lsl 35) lor (in_36_2 lsl 36) lor (in_37_2 lsl 37) lor (in_38_2 lsl 38) lor (in_39_2 lsl 39) lor (in_40_2 lsl 40) lor (in_41_2 lsl 41) lor (in_42_2 lsl 42) lor (in_43_2 lsl 43) lor (in_44_2 lsl 44) lor (in_45_2 lsl 45) lor (in_46_2 lsl 46) lor (in_47_2 lsl 47) lor (in_48_2 lsl 48) lor (in_49_2 lsl 49) lor (in_50_2 lsl 50) lor (in_51_2 lsl 51) lor (in_52_2 lsl 52) lor (in_53_2 lsl 53) lor (in_54_2 lsl 54) lor (in_55_2 lsl 55) lor (in_56_2 lsl 56) lor (in_57_2 lsl 57) lor (in_58_2 lsl 58) lor (in_59_2 lsl 59) lor (in_60_2 lsl 60) lor (in_61_2 lsl 61) lor (in_62_2 lsl 62) in
    let out3 = (in_0_3 lsl 0) lor (in_1_3 lsl 1) lor (in_2_3 lsl 2) lor (in_3_3 lsl 3) lor (in_4_3 lsl 4) lor (in_5_3 lsl 5) lor (in_6_3 lsl 6) lor (in_7_3 lsl 7) lor (in_8_3 lsl 8) lor (in_9_3 lsl 9) lor (in_10_3 lsl 10) lor (in_11_3 lsl 11) lor (in_12_3 lsl 12) lor (in_13_3 lsl 13) lor (in_14_3 lsl 14) lor (in_15_3 lsl 15) lor (in_16_3 lsl 16) lor (in_17_3 lsl 17) lor (in_18_3 lsl 18) lor (in_19_3 lsl 19) lor (in_20_3 lsl 20) lor (in_21_3 lsl 21) lor (in_22_3 lsl 22) lor (in_23_3 lsl 23) lor (in_24_3 lsl 24) lor (in_25_3 lsl 25) lor (in_26_3 lsl 26) lor (in_27_3 lsl 27) lor (in_28_3 lsl 28) lor (in_29_3 lsl 29) lor (in_30_3 lsl 30) lor (in_31_3 lsl 31) lor (in_32_3 lsl 32) lor (in_33_3 lsl 33) lor (in_34_3 lsl 34) lor (in_35_3 lsl 35) lor (in_36_3 lsl 36) lor (in_37_3 lsl 37) lor (in_38_3 lsl 38) lor (in_39_3 lsl 39) lor (in_40_3 lsl 40) lor (in_41_3 lsl 41) lor (in_42_3 lsl 42) lor (in_43_3 lsl 43) lor (in_44_3 lsl 44) lor (in_45_3 lsl 45) lor (in_46_3 lsl 46) lor (in_47_3 lsl 47) lor (in_48_3 lsl 48) lor (in_49_3 lsl 49) lor (in_50_3 lsl 50) lor (in_51_3 lsl 51) lor (in_52_3 lsl 52) lor (in_53_3 lsl 53) lor (in_54_3 lsl 54) lor (in_55_3 lsl 55) lor (in_56_3 lsl 56) lor (in_57_3 lsl 57) lor (in_58_3 lsl 58) lor (in_59_3 lsl 59) lor (in_60_3 lsl 60) lor (in_61_3 lsl 61) lor (in_62_3 lsl 62) in
    let out4 = (in_0_4 lsl 0) lor (in_1_4 lsl 1) lor (in_2_4 lsl 2) lor (in_3_4 lsl 3) lor (in_4_4 lsl 4) lor (in_5_4 lsl 5) lor (in_6_4 lsl 6) lor (in_7_4 lsl 7) lor (in_8_4 lsl 8) lor (in_9_4 lsl 9) lor (in_10_4 lsl 10) lor (in_11_4 lsl 11) lor (in_12_4 lsl 12) lor (in_13_4 lsl 13) lor (in_14_4 lsl 14) lor (in_15_4 lsl 15) lor (in_16_4 lsl 16) lor (in_17_4 lsl 17) lor (in_18_4 lsl 18) lor (in_19_4 lsl 19) lor (in_20_4 lsl 20) lor (in_21_4 lsl 21) lor (in_22_4 lsl 22) lor (in_23_4 lsl 23) lor (in_24_4 lsl 24) lor (in_25_4 lsl 25) lor (in_26_4 lsl 26) lor (in_27_4 lsl 27) lor (in_28_4 lsl 28) lor (in_29_4 lsl 29) lor (in_30_4 lsl 30) lor (in_31_4 lsl 31) lor (in_32_4 lsl 32) lor (in_33_4 lsl 33) lor (in_34_4 lsl 34) lor (in_35_4 lsl 35) lor (in_36_4 lsl 36) lor (in_37_4 lsl 37) lor (in_38_4 lsl 38) lor (in_39_4 lsl 39) lor (in_40_4 lsl 40) lor (in_41_4 lsl 41) lor (in_42_4 lsl 42) lor (in_43_4 lsl 43) lor (in_44_4 lsl 44) lor (in_45_4 lsl 45) lor (in_46_4 lsl 46) lor (in_47_4 lsl 47) lor (in_48_4 lsl 48) lor (in_49_4 lsl 49) lor (in_50_4 lsl 50) lor (in_51_4 lsl 51) lor (in_52_4 lsl 52) lor (in_53_4 lsl 53) lor (in_54_4 lsl 54) lor (in_55_4 lsl 55) lor (in_56_4 lsl 56) lor (in_57_4 lsl 57) lor (in_58_4 lsl 58) lor (in_59_4 lsl 59) lor (in_60_4 lsl 60) lor (in_61_4 lsl 61) lor (in_62_4 lsl 62) in
    (out1,out2,out3,out4)

let custom_not_ ((in_1,in_2,in_3,in_4)) = 
    let (out_1,out_2,out_3,out_4) = ((lnot (in_1),lnot (in_2),lnot (in_3),lnot (in_4))) in 
    (out_1,out_2,out_3,out_4)


let f_ = 
    let (c_1',c_2',c_3',c_4') = referencize1 (expand_fun_1(0,0,0,1)) in

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
