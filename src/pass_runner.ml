open Usuba_AST
open Basic_utils

(* A pass is defined by a config, as action to run, and a name. The
name is only used for debugging purposes (when running the program
with -v xx) *)
type pass = { conf:config;
              action:prog -> config -> prog;
              name:string }

(* |def_conf| is the config used by default for all passes. *)
class pass_runner (def_conf:config) =
object (self)

  (* The passes to run. They are stored in reverse order and the list
  is reverted before running the passes. *)
  val mutable passes : pass list = []

  (* Registers a pass. The default conf (|def_conf|) will be used if
  no conf is provided. *)
  method register_pass ?(conf:config=def_conf)
                       (action:prog -> config -> prog)
                       (name:string) : unit =
    passes <- { conf=conf; action=action; name=name } :: passes

  (* Runs a pass. *)
  method run_pass (pass:pass) (prog:prog) : prog =
    let conf = pass.conf in

    if conf.verbose >= 5 then Printf.eprintf "\rRunning pass %s... %!" pass.name;

    let prog' = pass.action prog pass.conf in
    passes <- [];

    if conf.verbose >= 3 then Printf.eprintf "done.%!";
    if conf.verbose >= 5 then Printf.eprintf "\n";
    if conf.verbose >= 100 then Printf.eprintf "%s\n\n=========================\n\n"
                                               (Usuba_print.prog_to_str prog');

    prog'

  (* Runs all passes. *)
  method run_all_passes (prog:prog) : prog =
    (* Note the use of fold_right, which amounts to using fold_left + rev.*)
    List.fold_right self#run_pass passes prog

  method get_passes () : pass list = passes
  method get_conf () : config = def_conf
end
