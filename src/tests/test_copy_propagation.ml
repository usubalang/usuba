open Usuba_AST
open Utils
open Copy_propagation
open Parser_api

(* Just a bunch of equations; no loops; no arrays; no functions calls. *)
let test_simple () =
  let def = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c:u1
let
    a = x ^ y;
    b = a;
    c = b;
    z = c;
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c:u1
let
    a = x ^ y;
    z = a;
tel" in
  assert (result = expected)

(* Still no funcalls and no loops, but some arrays *)
let test_arrays () =
  let def = parse_def
"node f(x,y:u1[2]) returns (z:u1[2])
   vars a,b,c:u1[2]
let
    a[0] = x[0] ^ y[0];
    a[1] = x[1] ^ y[1];
    b[0] = a[0];
    b[1] = a[1];
    c[0] = b[0];
    c[1] = b[1];
    z[0] = c[0];
    z[1] = c[1];
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u1[2]) returns (z:u1[2])
   vars a,b,c:u1[2]
let
    a[0] = x[0] ^ y[0];
    a[1] = x[1] ^ y[1];
    z[0] = a[0];
    z[1] = a[1];
tel" in
    assert (result = expected)

(* With a loop (but no funcalls) *)
let test_loop_nofun () =
  let def = parse_def
"node f(x,y:u1[2]) returns (z:u1[2])
   vars a,b,c:u1[2]
let
    forall i in [1,2] {
      a[i] = x[i] ^ y[i];
    }
    b[0] = a[0];
    b[1] = a[1];
    c[0] = b[0];
    c[1] = b[1];
    z[0] = c[0];
    z[1] = c[1];
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u1[2]) returns (z:u1[2])
   vars a,b,c:u1[2]
let
    forall i in [1,2] {
      a[i] = x[i] ^ y[i];
    }
    z[0] = a[0];
    z[1] = a[1];
 tel" in
  assert (result = expected)


(* With a funcall (but no loops, no arr) *)
let test_funcall_noarr () =
  let def = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c,d:u1
let
    a = x ^ y;
    b = a;
    c = f(b);
    d = c;
    z = d;
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c,d:u1
let
    a = x ^ y;
    c = f(a);
    z = c;
tel" in
  assert (result = expected)


(* With a funcall and arrays (but no loops) *)
let test_funcall_arr () =
  let def = parse_def
"node f(x,y:u2[2]) returns (z:u2[2])
   vars a,b,c,d:u2[2]
let
    a[0] = x[0] ^ y[0];
    a[1] = x[1] ^ y[1];
    b[0] = a[0];
    b[1] = a[1];
    c = f(b);
    d[0] = c[0];
    d[1] = c[1];
    z[0] = d[0];
    z[1] = d[1];
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u2[2]) returns (z:u2[2])
   vars a,b,c,d:u2[2]
let
    a[0] = x[0] ^ y[0];
    a[1] = x[1] ^ y[1];
    b[0] = a[0];
    b[1] = a[1];
    c = f(b);
    z[0] = c[0];
    z[1] = c[1];
tel" in
  assert (result = expected)

(* With a funcall, arrays and loop. Funcall is outside the loop. *)
let test_funcall_loop1 () =
  let def = parse_def
"node f(x,y:u2[2]) returns (z:u2[2])
   vars a,b,c,d,e:u2[2]
let
    forall i in [0,1] {
      a[i] = x[i] ^ y[i];
    }
    b[0] = a[0];
    b[1] = a[1];
    c[0] = b[0];
    c[1] = b[1];
    d = f(c);
    e[0] = d[0];
    e[1] = d[1];
    z[0] = e[0];
    z[1] = e[1];
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u2[2]) returns (z:u2[2])
   vars a,b,c,d,e:u2[2]
let
    forall i in [0,1] {
      a[i] = x[i] ^ y[i];
    }
    c[0] = a[0];
    c[1] = a[1];
    d = f(c);
    z[0] = d[0];
    z[1] = d[1];
tel" in
  assert (result = expected)


(* With a funcall, arrays and loop. Funcall is inside the loop. *)
let test_funcall_loop2 () =
  let def = parse_def
"node f(x,y:u2[2]) returns (z:u2[2])
   vars a,b,c,d,e:u2[2]
let
    forall i in [0,1] {
      a[i] = x[i] ^ y[i];
      b[i] = a[i];
      c[i] = b[i];
      d[i] = f(c[i]);
      e[i] = d[i];
      z[i] = e[i]
    }
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u2[2]) returns (z:u2[2])
   vars a,b,c,d,e:u2[2]
let
    forall i in [0,1] {
      a[i] = x[i] ^ y[i];
      b[i] = a[i];
      c[i] = b[i];
      d[i] = f(c[i]);
      e[i] = d[i];
      z[i] = e[i]
    }
tel" in
  assert (result = expected)

(* Just makes sure that assignments of Consts are indeed removed. *)
let test_simple_const () =
    let def = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c:u1
let
    a = 5;
    b = a;
    c = b;
    z = c;
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u1) returns (z:u1)
   vars a,b,c:u1
let
    z = 5;
tel" in
  assert (result = expected)


(* Shuffle are a bit special because they only work on Vars. Making
   sure that no Shuffle will use a variable that was optimized away or
   something like that. *)
let test_shuffle () =
  let def = parse_def
"node f(x,y:u4) returns (z:u4)
   vars a,b,c,d,e:u4
let
    a = 5;
    b = a{1,0,3,2};
    c = b ^ x;
    d = c ^ y;
    e = d;
    z = e;
tel" in
  let result = cp_def def in
  (* Note that local variables are not optimized away by this module. *)
  let expected = parse_def
"node f(x,y:u4) returns (z:u4)
   vars a,b,c,d,e:u4
let
    a = 5;
    b = a{1,0,3,2};
    c = b ^ x;
    d = c ^ y;
    z = d;
tel" in
  assert (result = expected)




let test () =
  test_simple ();
  test_arrays ();
  test_loop_nofun ();
  test_funcall_noarr ();
  test_funcall_arr ();
  test_funcall_loop1 ();
  test_simple_const ();
  test_shuffle ()
