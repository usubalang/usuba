open Remove_dead_code
open Parser_api

let test_simple () =
  let def =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a,b,c,d:u1\n\
       let\n\
      \    a = x ^ y;\n\
      \    b = 1;\n\
      \    c = a ^ b;\n\
      \    z = a;\n\
       tel"
  in
  let expected =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a:u1\n\
       let\n\
      \    a = x ^ y;\n\
      \    z = a;\n\
       tel"
  in
  assert (remove_dead_code_def def = expected)

let test_loop_feedback () =
  let def =
    parse_def
      "node f(x,y:u1[2]) returns (z:u1[2])\n\
      \   vars zt:u1[2],t1:u1[3],t2:u1[3],u:u1\n\
       let\n\
      \    t1[0] = y[0];\n\
      \    t2[0] = y[1];\n\
      \    u = 1;\n\
      \    forall i in [0,1] {\n\
      \      zt[i] = t1[i] ^ x[i];\n\
      \      t1[i+1] = t1[i] ^ t2[i];\n\
      \      t2[i+1] = u ^ 1\n\
      \    }\n\
      \    z[0] = zt[1];\n\
      \    z[1] = zt[2];\n\
      \ tel"
  in
  let expected =
    parse_def
      "node f(x,y:u1[2]) returns (z:u1[2])\n\
      \   vars zt:u1[2],t1:u1[3],t2:u1[3],u:u1\n\
       let\n\
      \    t1[0]  = y[0];\n\
      \    t2[0] = y[1];\n\
      \    u = 1;\n\
      \    forall i in [0,1] {\n\
      \      zt[i] = t1[i] ^ x[i];\n\
      \      t1[i+1] = t1[i] ^ t2[i];\n\
      \      t2[i+1] = u ^ 1\n\
      \    }\n\
      \    z[0] = zt[1];\n\
      \    z[1] = zt[2];\n\
      \ tel"
  in
  assert (remove_dead_code_def def = expected)

let test () =
  (* test_simple (); *)
  test_loop_feedback ()
