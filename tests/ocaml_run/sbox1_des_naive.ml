

let sbox_1_ (a_1,a_2,a_3,a_4,a_5,a_6) = 
    let _tmp1_1 = (not (a_6)) in 
    let tmp_1_1_6_ = (_tmp1_1) || (a_6) in 
    let _tmp97_1 = (not (a_5)) in 
    let _tmp98_1 = (_tmp97_1) && (_tmp1_1) in 
    let _tmp99_1 = (a_5) && (a_6) in 
    let tmp_1_2_0_ = (_tmp98_1) || (_tmp99_1) in 
    let _tmp104_1 = (_tmp97_1) && (a_6) in 
    let _tmp105_1 = (a_5) && (_tmp1_1) in 
    let tmp_1_2_2_ = (_tmp104_1) || (_tmp105_1) in 
    let _tmp107_1 = (_tmp97_1) && (tmp_1_1_6_) in 
    let tmp_1_2_3_ = (_tmp107_1) || (_tmp105_1) in 
    let _tmp114_1 = (a_5) && (tmp_1_1_6_) in 
    let tmp_1_2_5_ = (_tmp104_1) || (_tmp114_1) in 
    let tmp_1_2_8_ = (_tmp104_1) || (_tmp99_1) in 
    let tmp_1_2_12_ = (_tmp98_1) || (_tmp114_1) in 
    let _tmp145_1 = (not (a_4)) in 
    let _tmp146_1 = (_tmp145_1) && (tmp_1_2_0_) in 
    let _tmp147_1 = (a_4) && (_tmp98_1) in 
    let tmp_1_3_0_ = (_tmp146_1) || (_tmp147_1) in 
    let _tmp149_1 = (_tmp145_1) && (tmp_1_2_2_) in 
    let _tmp150_1 = (a_4) && (tmp_1_2_3_) in 
    let tmp_1_3_1_ = (_tmp149_1) || (_tmp150_1) in 
    let _tmp153_1 = (a_4) && (tmp_1_2_5_) in 
    let tmp_1_3_2_ = (_tmp149_1) || (_tmp153_1) in 
    let _tmp156_1 = (a_4) && (_tmp99_1) in 
    let tmp_1_3_3_ = (_tmp149_1) || (_tmp156_1) in 
    let _tmp158_1 = (_tmp145_1) && (tmp_1_2_8_) in 
    let tmp_1_3_4_ = (_tmp158_1) || (_tmp150_1) in 
    let _tmp162_1 = (a_4) && (_tmp105_1) in 
    let tmp_1_3_5_ = (_tmp146_1) || (_tmp162_1) in 
    let _tmp164_1 = (_tmp145_1) && (tmp_1_2_12_) in 
    let _tmp165_1 = (a_4) && (tmp_1_2_0_) in 
    let tmp_1_3_6_ = (_tmp164_1) || (_tmp165_1) in 
    let _tmp169_1 = (not (a_3)) in 
    let _tmp170_1 = (_tmp169_1) && (tmp_1_3_0_) in 
    let _tmp171_1 = (a_3) && (tmp_1_3_1_) in 
    let tmp_1_4_0_ = (_tmp170_1) || (_tmp171_1) in 
    let _tmp173_1 = (_tmp169_1) && (tmp_1_3_2_) in 
    let _tmp174_1 = (a_3) && (tmp_1_3_3_) in 
    let tmp_1_4_1_ = (_tmp173_1) || (_tmp174_1) in 
    let _tmp176_1 = (_tmp169_1) && (tmp_1_3_4_) in 
    let _tmp177_1 = (a_3) && (tmp_1_3_5_) in 
    let tmp_1_4_2_ = (_tmp176_1) || (_tmp177_1) in 
    let _tmp179_1 = (_tmp169_1) && (tmp_1_3_6_) in 
    let tmp_1_4_3_ = (_tmp179_1) || (_tmp174_1) in 
    let _tmp181_1 = (not (a_2)) in 
    let _tmp182_1 = (_tmp181_1) && (tmp_1_4_0_) in 
    let _tmp183_1 = (a_2) && (tmp_1_4_1_) in 
    let tmp_1_5_0_ = (_tmp182_1) || (_tmp183_1) in 
    let _tmp185_1 = (_tmp181_1) && (tmp_1_4_2_) in 
    let _tmp186_1 = (a_2) && (tmp_1_4_3_) in 
    let tmp_1_5_1_ = (_tmp185_1) || (_tmp186_1) in 
    let _tmp187_1 = (not (a_1)) in 
    let _tmp188_1 = (_tmp187_1) && (tmp_1_5_0_) in 
    let _tmp189_1 = (a_1) && (tmp_1_5_1_) in 
    let tmp_1_6_0_ = (_tmp188_1) || (_tmp189_1) in 
    let out_1 = tmp_1_6_0_ in 
    let tmp_2_2_1_ = (_tmp107_1) || (_tmp99_1) in 
    let _tmp336_1 = (a_4) && (tmp_2_2_1_) in 
    let tmp_2_3_0_ = (_tmp164_1) || (_tmp336_1) in 
    let _tmp339_1 = (a_4) && (_tmp104_1) in 
    let tmp_2_3_1_ = (_tmp149_1) || (_tmp339_1) in 
    let _tmp341_1 = (_tmp145_1) && (_tmp99_1) in 
    let tmp_2_3_2_ = (_tmp341_1) || (_tmp150_1) in 
    let _tmp347_1 = (_tmp145_1) && (tmp_2_2_1_) in 
    let tmp_2_3_4_ = (_tmp347_1) || (_tmp147_1) in 
    let _tmp350_1 = (_tmp145_1) && (tmp_1_2_3_) in 
    let tmp_2_3_5_ = (_tmp350_1) || (_tmp156_1) in 
    let _tmp354_1 = (a_4) && (_tmp114_1) in 
    let tmp_2_3_6_ = (_tmp350_1) || (_tmp354_1) in 
    let _tmp359_1 = (_tmp169_1) && (tmp_2_3_0_) in 
    let _tmp360_1 = (a_3) && (tmp_2_3_1_) in 
    let tmp_2_4_0_ = (_tmp359_1) || (_tmp360_1) in 
    let _tmp362_1 = (_tmp169_1) && (tmp_2_3_2_) in 
    let tmp_2_4_1_ = (_tmp362_1) || (_tmp177_1) in 
    let _tmp365_1 = (_tmp169_1) && (tmp_2_3_4_) in 
    let _tmp366_1 = (a_3) && (tmp_2_3_5_) in 
    let tmp_2_4_2_ = (_tmp365_1) || (_tmp366_1) in 
    let _tmp368_1 = (_tmp169_1) && (tmp_2_3_6_) in 
    let _tmp369_1 = (a_3) && (_tmp336_1) in 
    let tmp_2_4_3_ = (_tmp368_1) || (_tmp369_1) in 
    let _tmp371_1 = (_tmp181_1) && (tmp_2_4_0_) in 
    let _tmp372_1 = (a_2) && (tmp_2_4_1_) in 
    let tmp_2_5_0_ = (_tmp371_1) || (_tmp372_1) in 
    let _tmp374_1 = (_tmp181_1) && (tmp_2_4_2_) in 
    let _tmp375_1 = (a_2) && (tmp_2_4_3_) in 
    let tmp_2_5_1_ = (_tmp374_1) || (_tmp375_1) in 
    let _tmp377_1 = (_tmp187_1) && (tmp_2_5_0_) in 
    let _tmp378_1 = (a_1) && (tmp_2_5_1_) in 
    let tmp_2_6_0_ = (_tmp377_1) || (_tmp378_1) in 
    let out_2 = tmp_2_6_0_ in 
    let tmp_3_2_2_ = (_tmp107_1) || (_tmp114_1) in 
    let tmp_3_3_0_ = (_tmp146_1) || (_tmp339_1) in 
    let _tmp527_1 = (_tmp145_1) && (tmp_3_2_2_) in 
    let tmp_3_3_1_ = (_tmp527_1) || (_tmp147_1) in 
    let tmp_3_3_2_ = (_tmp527_1) || (_tmp165_1) in 
    let _tmp534_1 = (a_4) && (tmp_1_2_2_) in 
    let _tmp536_1 = (_tmp145_1) && (_tmp104_1) in 
    let tmp_3_3_4_ = (_tmp536_1) || (_tmp165_1) in 
    let _tmp539_1 = (_tmp145_1) && (_tmp105_1) in 
    let _tmp540_1 = (a_4) && (tmp_1_2_12_) in 
    let tmp_3_3_5_ = (_tmp539_1) || (_tmp540_1) in 
    let tmp_3_3_6_ = (_tmp146_1) || (_tmp153_1) in 
    let tmp_3_3_7_ = (_tmp350_1) || (_tmp339_1) in 
    let _tmp548_1 = (_tmp169_1) && (tmp_3_3_0_) in 
    let _tmp549_1 = (a_3) && (tmp_3_3_1_) in 
    let tmp_3_4_0_ = (_tmp548_1) || (_tmp549_1) in 
    let _tmp551_1 = (_tmp169_1) && (tmp_3_3_2_) in 
    let _tmp552_1 = (a_3) && (_tmp534_1) in 
    let tmp_3_4_1_ = (_tmp551_1) || (_tmp552_1) in 
    let _tmp554_1 = (_tmp169_1) && (tmp_3_3_4_) in 
    let _tmp555_1 = (a_3) && (tmp_3_3_5_) in 
    let tmp_3_4_2_ = (_tmp554_1) || (_tmp555_1) in 
    let _tmp557_1 = (_tmp169_1) && (tmp_3_3_6_) in 
    let _tmp558_1 = (a_3) && (tmp_3_3_7_) in 
    let tmp_3_4_3_ = (_tmp557_1) || (_tmp558_1) in 
    let _tmp560_1 = (_tmp181_1) && (tmp_3_4_0_) in 
    let _tmp561_1 = (a_2) && (tmp_3_4_1_) in 
    let tmp_3_5_0_ = (_tmp560_1) || (_tmp561_1) in 
    let _tmp563_1 = (_tmp181_1) && (tmp_3_4_2_) in 
    let _tmp564_1 = (a_2) && (tmp_3_4_3_) in 
    let tmp_3_5_1_ = (_tmp563_1) || (_tmp564_1) in 
    let _tmp566_1 = (_tmp187_1) && (tmp_3_5_0_) in 
    let _tmp567_1 = (a_1) && (tmp_3_5_1_) in 
    let tmp_3_6_0_ = (_tmp566_1) || (_tmp567_1) in 
    let out_3 = tmp_3_6_0_ in 
    let tmp_4_3_1_ = (_tmp539_1) || (_tmp336_1) in 
    let _tmp719_1 = (_tmp145_1) && (_tmp98_1) in 
    let tmp_4_3_2_ = (_tmp719_1) || (_tmp156_1) in 
    let tmp_4_3_3_ = (_tmp527_1) || (_tmp534_1) in 
    let tmp_4_3_6_ = (_tmp347_1) || (_tmp150_1) in 
    let tmp_4_3_7_ = (_tmp719_1) || (_tmp165_1) in 
    let _tmp738_1 = (a_3) && (tmp_4_3_1_) in 
    let tmp_4_4_0_ = (_tmp362_1) || (_tmp738_1) in 
    let _tmp740_1 = (_tmp169_1) && (tmp_4_3_2_) in 
    let _tmp741_1 = (a_3) && (tmp_4_3_3_) in 
    let tmp_4_4_1_ = (_tmp740_1) || (_tmp741_1) in 
    let _tmp743_1 = (_tmp169_1) && (_tmp149_1) in 
    let _tmp744_1 = (a_3) && (tmp_3_3_6_) in 
    let tmp_4_4_2_ = (_tmp743_1) || (_tmp744_1) in 
    let _tmp746_1 = (_tmp169_1) && (tmp_4_3_6_) in 
    let _tmp747_1 = (a_3) && (tmp_4_3_7_) in 
    let tmp_4_4_3_ = (_tmp746_1) || (_tmp747_1) in 
    let _tmp749_1 = (_tmp181_1) && (tmp_4_4_0_) in 
    let _tmp750_1 = (a_2) && (tmp_4_4_1_) in 
    let tmp_4_5_0_ = (_tmp749_1) || (_tmp750_1) in 
    let _tmp752_1 = (_tmp181_1) && (tmp_4_4_2_) in 
    let _tmp753_1 = (a_2) && (tmp_4_4_3_) in 
    let tmp_4_5_1_ = (_tmp752_1) || (_tmp753_1) in 
    let _tmp755_1 = (_tmp187_1) && (tmp_4_5_0_) in 
    let _tmp756_1 = (a_1) && (tmp_4_5_1_) in 
    let tmp_4_6_0_ = (_tmp755_1) || (_tmp756_1) in 
    let out_4 = tmp_4_6_0_ in 
    (out_1,out_2,out_3,out_4)


let main_ (i_) = 
    let r_ = i_ in 
    (r_)


let main istream = 
    Stream.from
    (fun _ -> 
    try
        let i = Stream.next istream in
        let (i1) = (Int64.logand (Int64.shift_right i 0) Int64.one = Int64.one) in
        let (ret1) = main_ (i1) in
        let (r') = (Int64.logor Int64.zero (if ret1 then (Int64.shift_left Int64.one 0) else Int64.zero))
        in Some (r')
    with Stream.Failure -> None)
