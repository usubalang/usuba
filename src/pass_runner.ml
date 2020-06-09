open Usuba_AST
open Basic_utils
open Printf

(* Always: pass should always run
   Toggle: the pass_runner should benchmark the pass and disable if
           it's bad for performances
   Custom: the module will do something else itself (used when there
           are more options than a simple on/off; for inlining for
           instance)
   The "bool" parameters are guards: if they are true, the Custom/Toogle
   are enabled, otherwise they are disabled and act like Always.
*)
type pass_type = Always | Custom of bool | Toggle of bool


(* |def_conf| is the config used by default for all passes. *)
class pass_runner (def_conf:config) =
object (self)

  (* For passes called within passes, keep track of the callers *)
  val mutable callers : string list = []

  (* Used to keep track of the currents passes being benchmarked *)
  val mutable in_bench : string list = []
  method push_in_bench (pass:string) : unit =
    in_bench <- pass :: in_bench
  method pop_in_bench () : unit =
    in_bench <- List.tl in_bench
  method get_in_bench () : string list = in_bench

  (* Used to pass the next passes to Custom (cf above) benchmarking passes. *)
  val mutable nexts : ((('b * string) * bool * pass_type) list) = []
  method get_nexts () =
    let ret = nexts in
    nexts <- [];
    ret

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

  (* Runs several modules, while benchmarking those who require
     benchmarking (those modules are also protected by a guard) *)
  method run_modules_bench ?(conf:config=def_conf)
                           (moduls:(('b * string) * bool * pass_type) list)
                           (*        ^^^  ^^^^^^    ^^^^   ^^^^^^^^^ *)
                           (*    action    name     guard    bench-type *)
                           (prog:prog) : prog =
    match moduls with
    | [] -> prog
    | ((action,name),guard,bench) :: tl ->
       if guard then
         match bench with
         | Toggle true -> self#run_bench_toggle (conf, action, name) tl prog
         | Custom true -> self#run_custom_bench_pass conf action tl prog
         | _ -> let prog = self#run_pass (conf, action, name) prog in
                self#run_modules_bench ~conf:conf tl prog
       else
         let prog = self#skip_module conf name prog in
         self#run_modules_bench ~conf:conf tl prog


  (* Benchmarks the module defined by |action| and |name|, and
     enables/disables it if the performances are better with/without
     it. *)
  method private run_bench_toggle (conf, action, name)
                                  (nexts:(('b * string) * bool * pass_type) list)
                                  (prog:prog) : prog =
    self#push_in_bench (sprintf "%s:on" name);
    let prog_opt_on  = self#run_modules_bench ~conf:conf
                               (((action,name),true,Always) :: nexts) prog in
    self#pop_in_bench ();
    self#push_in_bench (sprintf "%s:off" name);
    let prog_opt_off = self#run_modules_bench ~conf:conf
                               (((action,name),false,Always) :: nexts) prog in
        self#pop_in_bench ();

    let (perfs_on, perfs_off) =
       list_to_tuple2
         (Perfs.compare_perfs [ prog_opt_on; prog_opt_off ] conf) in

    Printf.printf "[%s] %s: on:%.2f  --  off:%.2f ---> %s\n%!"
                  (join " | " in_bench)
                  name perfs_on perfs_off
                  (if perfs_on < perfs_off then "enabling" else "disabling");

    if perfs_on < perfs_off then prog_opt_on else prog_opt_off


  (* Just a convenience wrapper to let a module benchmark iself. It is
     used in particular in the Inline and Interleave modules, which
     are more complex than simple on/off. *)
  method run_custom_bench_pass (conf:config)
                               action
                               (_nexts:(('b * string) * bool * pass_type) list)
                               (prog:prog) =
    nexts <- _nexts;
    (* Note that the module called (|action|) is supposed to empty self#nexts *)
    action self prog conf


end
