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

open Prelude
open Usuba_AST
open Basic_utils
open Utils

let bitslice = ref false

let rewrite_p (p : p) : var list =
  let env_var = Ident.Hashtbl.create 10 in
  List.iter (fun vd -> Ident.Hashtbl.add env_var vd.vd_id vd.vd_typ) p;
  flat_map (fun vd -> expand_var env_var ~bitslice:!bitslice (Var vd.vd_id)) p

let tmp_var i = Ident.create_free ("tmp_" ^ string_of_int i)
let fake_mux c a b = Log (Xor, a, Log (And, b, c))

let rewrite_table (id : ident) (p_in : p) (p_out : p) (opt : def_opt list)
    (l : int list) : def =
  let const_typ = get_base_type (List.hd p_in).vd_typ in
  let msize =
    match get_type_m const_typ with Mint m -> m | _ -> assert false
  in
  let zero = Const (0, Some const_typ) in
  let one = Const (gen_minus_one msize, Some const_typ) in
  let exp_p_in = Array.of_list @@ rewrite_p p_in in
  let exp_p_out = Array.of_list @@ rewrite_p p_out in
  let si = Array.length exp_p_in in
  let so = Array.length exp_p_out in
  let body = ref [] in
  let vars = ref [] in

  let n2 = Array.init (List.length l) (fun i -> ref (List.nth l i)) in

  for i = 0 to si - 1 do
    for j = 0 to Array.length n2 - 1 do
      if (j lsr i) land 1 = 1 then
        n2.(j) := !(n2.(j)) lxor !(n2.(j lxor (1 lsl i)))
    done
  done;

  let var_offset = ref 0 in
  for i = 0 to so - 1 do
    let l = ref 0 in
    let k = ref 0 in
    while !k < 1 lsl si do
      let v1 =
        if !(n2.(!k)) land (1 lsl (so - 1 - i)) <> 0 then one else zero
      in
      let v2 =
        if !(n2.(!k + 1)) land (1 lsl (so - 1 - i)) <> 0 then one else zero
      in
      let cond = ExpVar exp_p_in.(si - 1) in
      let expr = fake_mux cond v1 v2 in
      let var = tmp_var (!var_offset + !l) in
      vars := simple_var_d var :: !vars;
      body := ([ Var var ], expr) :: !body;
      l := !l + 1;
      k := !k + 2
    done;

    let m = ref 0 in
    for j = 1 to si - 1 do
      k := 0;
      while !k < 1 lsl (si - j) do
        let v1 = ExpVar (Var (tmp_var (!var_offset + (!m + !k)))) in
        let v2 = ExpVar (Var (tmp_var (!var_offset + (!m + !k + 1)))) in
        let cond = ExpVar exp_p_in.(si - 1 - j) in
        let expr = fake_mux cond v1 v2 in
        let var = tmp_var (!var_offset + !l) in
        vars := simple_var_d var :: !vars;
        body := ([ Var var ], expr) :: !body;
        l := !l + 1;
        k := !k + 2
      done;
      m := !m + (1 lsl (si - j))
    done;

    body :=
      ([ exp_p_out.(i) ], ExpVar (Var (tmp_var (!var_offset + (!l - 1)))))
      :: !body;
    var_offset := !var_offset + (1 lsl si)
  done;

  let body =
    List.rev_map
      (fun (lhs, rhs) -> { orig = []; content = Eqn (lhs, rhs, false) })
      !body
  in
  { id; p_in; p_out; opt; node = Single (!vars, body) }

(* When a table is replaced by a node, it's param types might be
   different and need to be fixed:

     - word-size polymorphic types can be specialized

     - if the original types of the table params are unx1, then the
       type unx1 needs to be expanded to a u1xn. In practice, there
       are two cases here: either the circuit's parameters have type
       unx1, and nothing needs to be done, or they have type u1xn, in
       which case, nothing needs to be done either. Arguably, they
       could have type ukxm, when k*m=n, but that sounds horribly
       evil. Gonna assume this won't happen, and add a TODO just in
       case.
       TODO: fix the aforementioned issue.
*)
let fix_p (old_p : p) (new_p : p) : p =
  match List.length old_p with
  | 1 -> (* second case *) new_p
  | _ ->
      (* first case *)
      (* Assuming that the types of |new_p| all have the same
         word-size, and retrived it. TODO: remove this assumption. *)
      let m = get_type_m (List.hd old_p).vd_typ in
      List.map (fun x -> { x with vd_typ = replace_m x.vd_typ m }) new_p

let rewrite_single_table (id : ident) (p_in : p) (p_out : p)
    (opt : def_opt list) (l : int list) (conf : Config.config) : def =
  if conf.precal_tbl then
    try
      let found, _ =
        List.find (fun (_, b) -> List.equal Int.equal b l) Sbox_index.sboxes
      in
      let sbox_dir = Config.data_dir ^ "/sboxes/" in
      let file_name = sbox_dir ^ found ^ ".ua" in
      let new_node =
        Rename.rename_def
          (List.nth (Parser_api.parse_file [ sbox_dir ] file_name).nodes 0)
      in
      {
        new_node with
        id;
        p_in = fix_p p_in new_node.p_in;
        p_out = fix_p p_out new_node.p_out;
        opt = new_node.opt @ opt;
      }
    with Not_found ->
      Simple_opts.opt_def
        (Norm_tuples.norm_tuples_def
           (Unfold_unnest.norm_def (Ident.Hashtbl.create 1)
              (rewrite_table id p_in p_out opt l)))
  else
    let table = rewrite_table id p_in p_out opt l in
    Simple_opts.opt_def
      (Norm_tuples.norm_tuples_def
         (Unfold_unnest.norm_def (Ident.Hashtbl.create 1) table))

let rewrite_def (def : def) (conf : Config.config) : def =
  let id = def.id in
  let p_in = def.p_in in
  let p_out = def.p_out in
  let opt = def.opt in
  match def.node with
  | Table l -> rewrite_single_table id p_in p_out opt l conf
  | _ -> def

let run _ (prog : prog) (conf : Config.config) : prog =
  bitslice := conf.slicing_set && Config.equal_slicing conf.slicing_type B;
  if conf.keep_tables then prog
  else { nodes = List.map (fun x -> rewrite_def x conf) prog.nodes }

let as_pass = (run, "Convert_tables", 0)
