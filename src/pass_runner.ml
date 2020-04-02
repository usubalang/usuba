open Usuba_AST
open Basic_utils
open Printf


(* |def_conf| is the config used by default for all passes. *)
class pass_runner (def_conf:config) =
object (self)

  (* For passes called within passes, keep track of the callers *)
  val mutable callers : string list = []

  method private print (msg:string) : unit =
    let current_str = List.hd callers in
    let callers_str =
      if List.tl callers <> [] then
        sprintf " (%s ->)" (join " -> " (List.rev (List.tl callers)))
      else "" in
    Printf.eprintf "[%s]%s %s\n%!" current_str callers_str msg

  (* Runs a pass. *)
  method private run_pass (conf, action, name) (prog:prog) : prog =
    callers <- name :: callers;

    if conf.verbose >= 5 then self#print "starting...";

    let prog' = action self prog conf in

    if conf.verbose >= 5 then self#print "done.";
    if conf.verbose >= 100 then
      self#print (sprintf " Result:\n=========================\n%s\n=========================\n\n"
                          (Usuba_print.prog_to_str prog'));

    callers <- List.tl callers;

    prog'

  (* Returns |prog| without running the pass, but prints some debug if
     verbosity is high enough *)
  method private skip_module (conf:config) (name:string) (prog:prog) : prog =
    callers <- name :: callers;
    if conf.verbose >= 5 then self#print "skipping.";
    callers <- List.tl callers;
    prog

  (* Runs the passes in argument *)
  method private run_passes passes (prog:prog) : prog =
    List.fold_right self#run_pass (List.rev passes) prog


  (* Runs a module *)
  method run_module ?(conf:config=def_conf) (action, name) (prog:prog) : prog =
    let pass = (conf, action, name) in
    self#run_pass pass prog

  (* Runs several modules *)
  method run_modules ?(conf:config=def_conf) moduls (prog:prog) : prog =
    let passes = List.map (fun (action,name) -> (conf, action, name)) moduls in
    self#run_passes passes prog

  (* Runs a module if |guard| is true *)
  method run_module_guard ?(conf:config=def_conf) (guard:bool)
                          (action, name) (prog:prog) : prog =
    if guard then self#run_module ~conf:conf (action,name) prog
    else self#skip_module conf name prog

  (* Runs several modules, each protected by a guard *)
  method run_modules_guard ?(conf:config=def_conf)
                           (moduls:(('b * string) * bool) list)
                           (prog:prog) : prog =
    List.fold_right (fun ((action,name),guard) prog ->
                     if guard then self#run_pass (conf, action, name) prog
                     else self#skip_module conf name prog)
                    (List.rev moduls) prog
end
