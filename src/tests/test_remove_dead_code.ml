open Usuba_AST
open Utils
open Remove_dead_code
open Parser_api

let test_simple () =
  let def = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c,d:u1
let
    a = x ^ y;
    b = 1;
    c = a ^ b;
    z = a;
tel" in
  let expected = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a:u1
let
    a = x ^ y;
    z = a;
tel" in
  assert (remove_dead_code_def def = expected)


let test_loop_feedback () =
  let def = parse_def
"node f(x,y:u1[2]) returns (z:u1[2])
   vars zt:u1[2],t1:u1[3],t2:u1[3],u:u1
let
    t1[0] = y[0];
    t2[0] = y[1];
    u = 1;
    forall i in [0,1] {
      zt[i] = t1[i] ^ x[i];
      t1[i+1] = t1[i] ^ t2[i];
      t2[i+1] = u ^ 1
    }
    z[0] = zt[1];
    z[1] = zt[2];
 tel" in
  let expected = parse_def
"node f(x,y:u1[2]) returns (z:u1[2])
   vars zt:u1[2],t1:u1[3],t2:u1[3],u:u1
let
    t1[0]  = y[0];
    t2[0] = y[1];
    u = 1;
    forall i in [0,1] {
      zt[i] = t1[i] ^ x[i];
      t1[i+1] = t1[i] ^ t2[i];
      t2[i+1] = u ^ 1
    }
    z[0] = zt[1];
    z[1] = zt[2];
 tel" in
  assert (remove_dead_code_def def = expected)


let test () =
  (* test_simple (); *)
  test_loop_feedback ()
