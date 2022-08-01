open Copy_propagation
open Parser_api
open Usuba_AST

let ( =! ) dl1 dl2 = equal_def dl1 dl2

(* Just a bunch of equations; no loops; no arrays; no functions calls. *)
let test_simple () =
  let def =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a,b,c:u1\n\
       let\n\
      \    a = x ^ y;\n\
      \    b = a;\n\
      \    c = b;\n\
      \    z = c;\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a,b,c:u1\n\
       let\n\
      \    z = x ^ y;\n\
       tel"
  in
  assert (result =! expected)

(* Still no funcalls and no loops, but some arrays *)
let test_arrays () =
  let def =
    parse_def
      "node f(x,y:u1[2]) returns (z:u1[2])\n\
      \   vars a,b,c:u1[2]\n\
       let\n\
      \    a[0] = x[0] ^ y[0];\n\
      \    a[1] = x[1] ^ y[1];\n\
      \    b[0] = a[0];\n\
      \    b[1] = a[1];\n\
      \    c[0] = b[0];\n\
      \    c[1] = b[1];\n\
      \    z[0] = c[0];\n\
      \    z[1] = c[1];\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u1[2]) returns (z:u1[2])\n\
      \   vars a,b,c:u1[2]\n\
       let\n\
      \    z[0] = x[0] ^ y[0];\n\
      \    z[1] = x[1] ^ y[1];\n\
       tel"
  in
  assert (result =! expected)

(* With a loop (but no funcalls) *)
let test_loop_nofun () =
  let def =
    parse_def
      "node f(x,y:u1[2]) returns (z:u1[2])\n\
      \   vars a,b,c:u1[2]\n\
       let\n\
      \    forall i in [1,2] {\n\
      \      a[i] = x[i] ^ y[i];\n\
      \    }\n\
      \    b[0] = a[0];\n\
      \    b[1] = a[1];\n\
      \    c[0] = b[0];\n\
      \    c[1] = b[1];\n\
      \    z[0] = c[0];\n\
      \    z[1] = c[1];\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u1[2]) returns (z:u1[2])\n\
      \   vars a,b,c:u1[2]\n\
       let\n\
      \    forall i in [1,2] {\n\
      \      a[i] = x[i] ^ y[i];\n\
      \    }\n\
      \    z[0] = a[0];\n\
      \    z[1] = a[1];\n\
      \ tel"
  in
  assert (result =! expected)

(* With a funcall (but no loops, no arr) *)
let test_funcall_noarr () =
  let def =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a,b,c,d:u1\n\
       let\n\
      \    a = x ^ y;\n\
      \    b = a;\n\
      \    c = f(b);\n\
      \    d = c;\n\
      \    z = d;\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a,b,c,d:u1\n\
       let\n\
      \    a = x ^ y;\n\
      \    z = f(a);\n\
       tel"
  in
  assert (result =! expected)

(* With a funcall and arrays (but no loops) *)
let test_funcall_arr () =
  let def =
    parse_def
      "node f(x,y:u2[2]) returns (z:u2[2])\n\
      \   vars a,b,c,d:u2[2]\n\
       let\n\
      \    a[0] = x[0] ^ y[0];\n\
      \    a[1] = x[1] ^ y[1];\n\
      \    b[0] = a[0];\n\
      \    b[1] = a[1];\n\
      \    c = f(b);\n\
      \    d[0] = c[0];\n\
      \    d[1] = c[1];\n\
      \    z[0] = d[0];\n\
      \    z[1] = d[1];\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u2[2]) returns (z:u2[2])\n\
      \   vars a,b,c,d:u2[2]\n\
       let\n\
      \    a[0] = x[0] ^ y[0];\n\
      \    a[1] = x[1] ^ y[1];\n\
      \    b[0] = a[0];\n\
      \    b[1] = a[1];\n\
      \    c = f(b);\n\
      \    z[0] = c[0];\n\
      \    z[1] = c[1];\n\
       tel"
  in
  assert (result =! expected)

(* With a funcall, arrays and loop. Funcall is outside the loop. *)
let test_funcall_loop1 () =
  let def =
    parse_def
      "node f(x,y:u2[2]) returns (z:u2[2])\n\
      \   vars a,b,c,d,e:u2[2]\n\
       let\n\
      \    forall i in [0,1] {\n\
      \      a[i] = x[i] ^ y[i];\n\
      \    }\n\
      \    b[0] = a[0];\n\
      \    b[1] = a[1];\n\
      \    c[0] = b[0];\n\
      \    c[1] = b[1];\n\
      \    d = f(c);\n\
      \    e[0] = d[0];\n\
      \    e[1] = d[1];\n\
      \    z[0] = e[0];\n\
      \    z[1] = e[1];\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u2[2]) returns (z:u2[2])\n\
      \   vars a,b,c,d,e:u2[2]\n\
       let\n\
      \    forall i in [0,1] {\n\
      \      a[i] = x[i] ^ y[i];\n\
      \    }\n\
      \    c[0] = a[0];\n\
      \    c[1] = a[1];\n\
      \    d = f(c);\n\
      \    z[0] = d[0];\n\
      \    z[1] = d[1];\n\
       tel"
  in
  assert (result =! expected)

(* With a funcall, arrays and loop. Funcall is inside the loop. *)
let test_funcall_loop2 () =
  let def =
    parse_def
      "node f(x,y:u2[2]) returns (z:u2[2])\n\
      \   vars a,b,c,d,e:u2[2]\n\
       let\n\
      \    forall i in [0,1] {\n\
      \      a[i] = x[i] ^ y[i];\n\
      \      b[i] = a[i];\n\
      \      c[i] = b[i];\n\
      \      d[i] = f(c[i]);\n\
      \      e[i] = d[i];\n\
      \      z[i] = e[i]\n\
      \    }\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u2[2]) returns (z:u2[2])\n\
      \   vars a,b,c,d,e:u2[2]\n\
       let\n\
      \    forall i in [0,1] {\n\
      \      a[i] = x[i] ^ y[i];\n\
      \      b[i] = a[i];\n\
      \      c[i] = b[i];\n\
      \      d[i] = f(c[i]);\n\
      \      e[i] = d[i];\n\
      \      z[i] = e[i]\n\
      \    }\n\
       tel"
  in
  assert (result =! expected)

(* Just makes sure that assignments of Consts are indeed removed. *)
let test_simple_const () =
  let def =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n\
      \   vars a,b,c:u1\n\
       let\n\
      \    a = 5;\n\
      \    b = a;\n\
      \    c = b;\n\
      \    z = c;\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u1) returns (z:u1)\n   vars a,b,c:u1\nlet\n    z = 5;\ntel"
  in
  assert (result =! expected)

(* Shuffle are a bit special because they only work on Vars. Making
   sure that no Shuffle will use a variable that was optimized away or
   something like that. *)
let test_shuffle () =
  let def =
    parse_def
      "node f(x,y:u4) returns (z:u4)\n\
      \   vars a,b,c,d,e:u4\n\
       let\n\
      \    a = 5;\n\
      \    b = a{1,0,3,2};\n\
      \    c = b ^ x;\n\
      \    d = c ^ y;\n\
      \    e = d;\n\
      \    z = e;\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:u4) returns (z:u4)\n\
      \   vars a,b,c,d,e:u4\n\
       let\n\
      \    a = 5;\n\
      \    b = a{1,0,3,2};\n\
      \    c = b ^ x;\n\
      \    z = c ^ y;\n\
       tel"
  in
  assert (result =! expected)

(* Make sure that Consts assignments are optimized away as well *)
let test_const () =
  let def =
    parse_def
      "node f(x,y:b1) returns (z:b1)\n\
      \    vars a,b:b1\n\
       let\n\
      \    a = 0;\n\
      \    b = a ^ x;\n\
      \    z = b ^ y;\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:b1) returns (z:b1)\n\
      \    vars a,b:b1\n\
       let\n\
      \    b = 0 ^ x;\n\
      \    z = b ^ y;\n\
       tel"
  in
  assert (result =! expected)

(* Make sure that Consts assignments are optimized away as well *)
let test_const_advanced () =
  let def =
    parse_def
      "node f(x,y:b1) returns (z:b1)\n\
      \    vars a,b,c:b1\n\
       let\n\
      \    a = 0;\n\
      \    b = a;\n\
      \    c = b ^ x;\n\
      \    z = c ^ y;\n\
       tel"
  in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected =
    parse_def
      "node f(x,y:b1) returns (z:b1)\n\
      \    vars a,b,c:b1\n\
       let\n\
      \    c = 0 ^ x;\n\
      \    z = c ^ y;\n\
       tel"
  in
  assert (result =! expected)

let test () =
  test_simple ();
  test_arrays ();
  test_loop_nofun ();
  test_funcall_noarr ();
  test_funcall_arr ();
  test_funcall_loop1 ();
  test_simple_const ();
  test_shuffle ();
  test_const ();
  test_const_advanced ()
