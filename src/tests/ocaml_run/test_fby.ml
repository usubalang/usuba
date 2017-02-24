(*

# the usuba node :

node f (b: uint_4::_) returns c: uint_4::_
vars
let
  c = 1 fby or(b,c)
tel

# or, naively:

node f (b1: bool::_, b2: bool::_, b3: bool::_, b4: bool::_)
  returns (c1: bool::_, c2: bool::_, c3: bool::_, c4: bool::_)
vars
let
  (c1,c2,c3,c4) = 1 fby (or(b1,c1),or(b2,c2),or(b3,c3),or(b4,c4))
tel

*)

(* "or" will be boring, "xor" is nicer *)
let ( || ) = fun x y -> (x && not y) || (not x && y)


(* ************************************************ *)
(*                   Naive version                  *)
(* ************************************************ *)


(* this following implementation can be simplified into the second version of f_naive *)
(* let f_naive = *)
(*   let (c1,c2,c3,c4) = (ref false, ref false, ref false, ref true) in *)
(*   fun (b1, b2, b3, b4) -> *)
(*   let (_,_,_,c4') = (b1 || !c1, b2|| !c2, b3 || !c3, b4 || !c4) in *)
(*   let (_,_,c3',_) = (b1 || !c1, b2|| !c2, b3 || c4', b4 || !c4) in *)
(*   let (_,c2',_,_) = (b1 || !c1, b2|| c3', b3 || c4', b4 || !c4) in *)
(*   let (c1',_,_,_) = (b1 || c2', b2|| c3', b3 || c4', b4 || !c4) in *)
(*   let tmp = (!c1,!c2,!c3,!c4) in *)
(*   c1 := c1'; c2 := c2'; c3 := c3'; c4 := c4'; *)
(*   tmp *) 

(*
f_naive: (bool * bool * bool * bool) -> (bool * bool * bool * bool)
*)    
let f_naive =
  let (c1,c2,c3,c4) = (ref false, ref false, ref false, ref true) in
  fun (b1, b2, b3, b4) ->
  (let c4' = b4 || !c4 in
   let c3' = b3 || !c3 in
   let c2' = b2 || !c2 in
   let c1' = b1 || !c1 in
   let tmp = (!c1,!c2,!c3,!c4) in
   c1 := c1'; c2 := c2'; c3 := c3'; c4 := c4';
   tmp)
    
let main_naive (in_stream: (bool*bool*bool*bool) Stream.t)
    : (bool*bool*bool*bool) Stream.t =
  Stream.from
    (fun _ ->
     try Some (f_naive @@ Stream.next in_stream)
     with Stream.Failure -> None)

    
(* ************************************************ *)
(*            Orthogonalized version                *)
(* ************************************************ *)
    

(* 
f_ortho: (bool array * bool array * bool array * bool array)
          -> (bool array * bool array * bool array * bool array)
 *)

(* this version doesn't yields the same results as the naive (not orthogonalized) version *)
(* hence f_ortho_v2 bellow *)
let f_ortho =
  let (c1,c2,c3,c4) = (ref (Array.make 3 false), ref (Array.make 3 false),
                       ref (Array.make 3 false), ref (Array.make 3 false)) in
  !c4.(0) <- true;
  fun (b1, b2, b3, b4) ->
  (let c4' = Array.map2 (fun x y -> x || y) b4 !c4 in
   let c3' = Array.map2 (fun x y -> x || y) b3 !c3 in
   let c2' = Array.map2 (fun x y -> x || y) b2 !c2 in
   let c1' = Array.map2 (fun x y -> x || y) b1 !c1 in
   let tmp = (!c1,!c2,!c3,!c4) in
   c1 := c1'; c2 := c2'; c3 := c3'; c4 := c4';
   tmp)

(* This one yields the same results as the naive (not orthohonalized) version. *)
(* However, it appears that we don't need 4 arrays as temporary variables. *)
(* Hence f_ortho_v3 bellow *)
let f_ortho_v2 =
  let (c1,c2,c3,c4) = (ref (Array.make 3 false), ref (Array.make 3 false),
                       ref (Array.make 3 false), ref (Array.make 3 false)) in
  !c4.(0) <- true;
  fun (b1, b2, b3, b4) ->
  (
  let (t1,t2,t3,t4) = (Array.make 3 false, Array.make 3 false,
                       Array.make 3 false, Array.make 3 false) in
  t1.(0) <- !c1.(0); t2.(0) <- !c2.(0); t3.(0) <- !c3.(0); t4.(0) <- !c4.(0);
  !c1.(0) <- b1.(0) || !c1.(0); !c2.(0) <- b2.(0) || !c2.(0);
  !c3.(0) <- b3.(0) || !c3.(0); !c4.(0) <- b4.(0) || !c4.(0);
  t1.(1) <- !c1.(0); t2.(1) <- !c2.(0); t3.(1) <- !c3.(0); t4.(1) <- !c4.(0);
  !c1.(1) <- b1.(1) || !c1.(0); !c2.(1) <- b2.(1) || !c2.(0);
  !c3.(1) <- b3.(1) || !c3.(0); !c4.(1) <- b4.(1) || !c4.(0);
  t1.(2) <- !c1.(1); t2.(2) <- !c2.(1); t3.(2) <- !c3.(1); t4.(2) <- !c4.(1);
  !c1.(2) <- b1.(2) || !c1.(1); !c2.(2) <- b2.(2) || !c2.(1);
  !c3.(2) <- b3.(2) || !c3.(1); !c4.(2) <- b4.(2) || !c4.(1);
  !c1.(0) <- !c1.(2); !c2.(0) <- !c2.(2); !c3.(0) <- !c3.(2); !c4.(0) <- !c4.(2);
  (t1,t2,t3,t4))

let f_ortho_v3 =
  let (c1,c2,c3,c4) = (ref false, ref false, ref false, ref true) in
  fun (b1, b2, b3, b4) ->
  (
  let (t1,t2,t3,t4) = (Array.make 3 false, Array.make 3 false,
                       Array.make 3 false, Array.make 3 false) in
  t1.(0) <- !c1; t2.(0) <- !c2; t3.(0) <- !c3; t4.(0) <- !c4;
  c1 := b1.(0) || !c1; c2 := b2.(0) || !c2;
  c3 := b3.(0) || !c3; c4 := b4.(0) || !c4;
  t1.(1) <- !c1; t2.(1) <- !c2; t3.(1) <- !c3; t4.(1) <- !c4;
  c1 := b1.(1) || !c1; c2 := b2.(1) || !c2;
  c3 := b3.(1) || !c3; c4 := b4.(1) || !c4;
  t1.(2) <- !c1; t2.(2) <- !c2; t3.(2) <- !c3; t4.(2) <- !c4;
  c1 := b1.(2) || !c1; c2 := b2.(2) || !c2;
  c3 := b3.(2) || !c3; c4 := b4.(2) || !c4;
  (t1,t2,t3,t4))    
    

let main_ortho (in_stream: (bool*bool*bool*bool) Stream.t)
    : (bool*bool*bool*bool) Stream.t =
  let stack = ref [] in
  Stream.from
    (fun _ ->
     match !stack with
     | [] -> (try
                 (* Get three elements *)
                 let (a1,a2,a3,a4) = Stream.next in_stream in
                 let (b1,b2,b3,b4) = Stream.next in_stream in
                 let (c1,c2,c3,c4) = Stream.next in_stream in
                 (* Orthogonalize them into 4 arrays *)
                 let u = Array.make 3 true in
                 let v = Array.make 3 true in
                 let w = Array.make 3 true in
                 let x = Array.make 3 true in
                 u.(0) <- a1; u.(1) <- b1; u.(2) <- c1;
                 v.(0) <- a2; v.(1) <- b2; v.(2) <- c2;
                 w.(0) <- a3; w.(1) <- b3; w.(2) <- c3;
                 x.(0) <- a4; x.(1) <- b4; x.(2) <- c4;

                 let (u',v',w',x') = f_ortho_v3 (u,v,w,x) in
                 
                 (* unorthogolize the returned values *)
                 let (a1',a2',a3',a4') = (u'.(0),v'.(0),w'.(0),x'.(0)) in
                 let (b1',b2',b3',b4') = (u'.(1),v'.(1),w'.(1),x'.(1)) in
                 let (c1',c2',c3',c4') = (u'.(2),v'.(2),w'.(2),x'.(2)) in

                 stack := [Some(b1',b2',b3',b4');Some(c1',c2',c3',c4')];
                 Some (a1',a2',a3',a4')
                      
               with Stream.Failure -> None)
     | e::tl -> stack := tl; e)
                                        


(* ************************************************ *)
(*             Tests / comparisons                  *)
(* ************************************************ *)

(* Note: both streams are the same. *)
let stream1 = Stream.of_list [ (true,true,false,true);
                               (false,true,true,false);
                               (false,true,false,false);
                               (false,false,true,false);
                               (true,false,true,true);
                               (false,false,true,true)]
let stream2 = Stream.of_list [ (true,true,false,true);
                               (false,true,true,false);
                               (false,true,false,false);
                               (false,false,true,false);
                               (true,false,true,true);
                               (false,false,true,true) ]


let stream1' = main_naive stream1
let stream2' = main_ortho stream2

                          
let () =
  print_endline "Naive:";
  Stream.iter (fun (a,b,c,d) -> print_endline("("^(string_of_bool a)^","
                                              ^(string_of_bool a)^","
                                              ^(string_of_bool b)^","
                                              ^(string_of_bool c)^")")) stream1';
  print_endline "\nOrtho:";
  Stream.iter (fun (a,b,c,d) -> print_endline("("^(string_of_bool a)^","
                                              ^(string_of_bool a)^","
                                              ^(string_of_bool b)^","
                                              ^(string_of_bool c)^")")) stream2'
              
