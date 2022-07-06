(* Returns two filenames:
     - a filename to store the source of |def|
     - a filename to store the _refreshed_ version of |def|.
   Basically, those files should be used as input and output to
   tightprove.
   Note that this function creates the directory of the files, but
   not the files themselves. (the point being that the caller can
   easily create the files should he need to, but doesn't have to
   bother create the directory, which would be trickier)
*)
let gen_file_names (def : Tp_AST.def) (conf : Config.config) : string * string =
  let hashcode = Hashtbl.hash def in

  let root_dir = conf.tightprove_dir in
  let dir = root_dir ^ "/" ^ string_of_int hashcode in
  let source_file = dir ^ "/source.tp" in
  let refreshed_file = dir ^ "/refreshed.tp" in

  if not (Sys.file_exists conf.tightprove_dir) then
    Unix.mkdir conf.tightprove_dir 0o755;

  if not (Sys.file_exists dir) then Unix.mkdir dir 0o755;

  (source_file, refreshed_file)

(* Search cache for |def| refreshed.

   The cache is fairly approximative for now: each def gets hashed,
   and a directory with its hash name is created. Collisions are _not_
   handled, meaning that if 2 defs have the same hash, then they will
   erase each other refreshed version each time we try to refresh
   them.

   TODO: A better way might be to use SHA256 hash (which we can safely
   consider uniq) instead. However, the question "what to hash?"
   remains. The answer is probably a textual representation of the
   node. To be future-proof though, we need to 1- settle on a
   representation, 2- normalize variable names *)
let get_from_cache (def : Tp_AST.def) (conf : Config.config) : Tp_AST.def option
    =
  let source_file, refreshed_file = gen_file_names def conf in

  if Sys.file_exists source_file && Sys.file_exists refreshed_file then
    let source_def = Parser_api_tp.parse_file source_file in
    if source_def = def then Some (Parser_api_tp.parse_file refreshed_file)
    else None
  else None

(* Runs tightprove on |source_file| to produce |refreshed_file|.

   |register_size| comes from the Tp_AST.def we are refreshing. It is
   used to determine whether we are bitslicing or vslicing (if it's 1,
   then it's bitslicing, otherwise it's vslicing). *)
let run_tightprove (source_file : string) (refreshed_file : string)
    (register_size : int) : unit =
  let slicing = if register_size = 1 then "b" else "v" in

  let cmd =
    Printf.sprintf "%s %s %s %s %s" Config.sage Config.tightprove source_file
      refreshed_file slicing
  in
  ignore (Unix.system cmd)

(* Gets a refreshed version of |def|:
    - if it's already present in the cache, just fetch it from the cache
    - if it's not in the cache, then call tightprove to generate it,
      and update the cache *)
let get_refreshed_def (def : Tp_AST.def) (conf : Config.config) : Tp_AST.def =
  match get_from_cache def conf with
  | Some r_def -> r_def
  | None ->
      (* Not in the cache, need to send it to tightprove *)
      let source_file, refreshed_file = gen_file_names def conf in
      (* Generate tightPROVE's input *)
      Print_tp.print_def_to_file def source_file;
      (* Call tightPROVE *)
      run_tightprove source_file refreshed_file def.Tp_AST.rs;
      (* Return tightPROVE's output... *)
      Parser_api_tp.parse_file refreshed_file
