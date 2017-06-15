(***************************************************************************** )
                              convert_tables.ml                                 

   This module converts lookup tables into circuits. In Usuba, this means 
   converting "table" into "node". 
   This is done using Binary Decision Diagrams (BDD). This is hardly optimized
   for now, and a lot of useless redondancy is present. In a near future, we
   should improve this.
    
    After this module has ran, there souldn't be any "Table" nor "MultipleTable"
    left.

( *****************************************************************************)


open Usuba_AST
open Utils


let expand_intn (id: ident) (n: int) =
  let rec aux i =
    if i > n then []
    else (Field(Var id,Const_e i)) :: (aux (i+1))
  in aux 1
         
let rec rewrite_p (p: p) =
  List.flatten @@
    List.map (fun (id,typ,_) ->
        match typ with
        | Bool  -> [ Var id ]
        | Int x -> expand_intn id x
        | Nat -> raise (Invalid_AST "Nat")
        | Array _ -> raise (Invalid_AST "Array")) p

let get_bits (l:int list) (i:int) : int list =
  List.rev @@ List.map (fun x -> x lsr i land 1) l

let tmp_var i j k =
  "tmp_" ^ (string_of_int i) ^ "_" ^ (string_of_int j) ^ "_" ^ (string_of_int k)

(* let mux c a b = Log(Xor,[Var a; Log(And,[c; Var b])]) *)
(* let mux c a b = Log(Xor,[Var a; Log(And,[c;Log(Xor,[Var a;Var b])])]) *)
let mux c a b = Log(Or,Log(Andn,c,ExpVar(Var a)),Log(And,c,ExpVar(Var b)))

                   
let rewrite_table (id:ident) (p_in:p) (p_out:p)
                  (opt:def_opt list) (l:int list) : def =
  let exp_p_in  = Array.of_list @@ rewrite_p p_in in
  let exp_p_out = Array.of_list @@ rewrite_p p_out in
  let size_in = Array.length exp_p_in in
  let size_out = Array.length exp_p_out in
  let body = ref [] in
  let vars = ref [] in
  for i = 1 to size_out do (* for each bit ou the output *)

    (* get the bits of the output the current rank *)
    let bits = Array.of_list (List.rev (get_bits l (size_out-i))) in

    (* initialise rank 0 *)
    for j = 1 to List.length l do
      let var = tmp_var i 0 (j-1) in
      vars := (var,Bool,"") :: !vars;
      body := Norec ([Var var],Const bits.(j-1)) :: !body
    done;

    (* for each depth *)
    for j = 1 to size_in do
      
      for k = 1 to pow 2 (size_in-j) do
        let var_l  = tmp_var i j (k-1) in
        let var_r1 = tmp_var i (j-1) ((k-1)*2) in
        let var_r2 = tmp_var i (j-1) ((k-1)*2+1) in
      vars := (var_l,Bool,"") :: (var_r1,Bool,"") :: (var_r2,Bool,"") ::!vars;
        body := Norec ([Var var_l],
                       mux (ExpVar exp_p_in.(size_in-j)) var_r1 var_r2)
                :: !body
      done
    done;
    
    (* set output *)
    let var = tmp_var i size_in 0 in
    vars := (var,Bool,"") :: !vars;
    body := Norec ([exp_p_out.(i-1)], ExpVar(Var var)) :: !body
      
  done;
  { id = id; p_in = p_in; p_out = p_out; opt = opt;
    node = Single(!vars,List.rev !body) }

let rewrite_single_table (id:ident) (p_in:p) (p_out:p)
                         (opt:def_opt list) (l:int list) : def =
  try
    let (found,_) = List.find (fun (a,b) -> b = l) Sbox_index.sboxes in
    let file_name = "data/sboxes/" ^ found ^ ".ua" in
    let new_node = List.nth (Parse_file.parse_file file_name).nodes 0 in
    { new_node with id = id;
                    opt = opt }
  with Not_found -> rewrite_table id p_in p_out opt l


let rec rewrite_def (def: def) : def list =
  let id    = def.id in
  let p_in  = def.p_in in
  let p_out = def.p_out in
  let opt   = def.opt in
  match def.node with
  | Table l -> [ rewrite_single_table id p_in p_out opt l ]
  | MultipleTable l ->
     List.mapi (fun i x -> 
                rewrite_single_table (id ^ (string_of_int i)) p_in p_out opt x) l
  | _ -> [ def ]
           
                       
let convert_tables (p: prog) : prog =
  let res = { nodes = List.flatten (List.map rewrite_def p.nodes) } in
  res
