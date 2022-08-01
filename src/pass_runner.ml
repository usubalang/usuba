open Prelude
open Usuba_AST
open Basic_utils

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
class pass_runner (def_conf : Config.config) =
  object (self)
    (* For passes called within passes, keep track of the callers *)
    val mutable callers : string list = []

    (* Used to keep track of the currents passes being benchmarked *)
    val mutable in_bench : string list = []
    method push_in_bench (pass : string) : unit = in_bench <- pass :: in_bench
    method pop_in_bench () : unit = in_bench <- List.tl in_bench
    method get_in_bench () : string list = in_bench

    (* Used to pass the next passes to Custom (cf above) benchmarking passes. *)
    val mutable nexts : (('b * string * int) * bool * pass_type) list = []

    method get_nexts () =
      let ret = nexts in
      nexts <- [];
      ret

    method private fprintf
        : 'a. Format.formatter -> ('a, Format.formatter, unit) format -> 'a =
      fun ppf msg ->
        Format.fprintf ppf "[%s]" (List.hd callers);
        (* STDLIB_IMPORT: Comparing to an empty list *)
        if Stdlib.(List.tl callers <> []) then
          Format.fprintf ppf " (%s ->)"
            (join " -> " (List.rev (List.tl callers)));
        Format.fprintf ppf msg

    method private printf : 'a. ('a, Format.formatter, unit) format -> 'a =
      fun msg -> self#fprintf Format.std_formatter msg

    (* Runs a pass. *)
    method private run_pass (conf, action, name, depth) (prog : prog) : prog =
      callers <- name :: callers;
      if conf.Config.verbose >= 5 then self#printf "starting... ";
      if conf.verbose >= 2 then
        if depth = 1 then Format.eprintf "@,[@[<v 2>%s" name
        else Format.eprintf "@,%s_%03d" name (!(conf.step_counter) + 1);
      (* STDLIB_IMPORT: Comparing to a sum option (similar to int comparison *)
      if depth = 0 && Stdlib.(conf.dump_steps <> Some AST) then
        incr conf.step_counter;
      let prog' = action self prog conf in

      if conf.verbose >= 5 then self#printf "done.";
      if conf.verbose >= 100 then
        self#printf
          "@.@[<v 0> Result  %a_%03d:@,\
           =========================@,\
           %a@,\
           =========================@,\
           @."
          Usuba_pp.String.(pp_lowercase ~ocaml_ident:true)
          (List.hd callers) !(conf.step_counter)
          (if Option.equal Config.equal_dump_steps conf.dump_steps (Some AST)
          then Usuba_AST.pp_prog
          else Usuba_print.pp_prog ())
          prog';
      (match conf.dump_steps with
      | None -> ()
      | Some AST ->
          if depth = 0 then (
            dump_to_file prog' conf;
            dump_caller callers conf)
      | Some d ->
          let filename =
            Format.sprintf "%s_%03d.ua" conf.dump_steps_base_file
              !(conf.step_counter)
          in
          let co = open_out filename in
          let dump =
            match d with
            | Usuba -> Format.asprintf "%a" (Usuba_print.pp_prog ()) prog'
            | Sexp -> Stdppx.Sexp.to_string @@ Usuba_AST.sexp_of_prog prog'
            | _ -> assert false
          in
          Format.fprintf (Format.formatter_of_out_channel co) "%s@." dump;
          close_out co);
      callers <- List.tl callers;
      if conf.verbose >= 2 && depth = 1 then Format.eprintf "@]@,]";
      prog'

    (* Returns |prog| without running the pass, but prints some debug if
       verbosity is high enough *)
    method private skip_module (conf : Config.config) (name : string)
        (prog : prog) : prog =
      callers <- name :: callers;
      if conf.verbose >= 5 then self#printf "skipping.";
      callers <- List.tl callers;
      prog

    (* Runs the passes in argument *)
    method private run_passes passes (prog : prog) : prog =
      List.fold_right self#run_pass (List.rev passes) prog

    (* Runs a module *)
    method run_module ?(conf : Config.config = def_conf) (action, name, depth)
        (prog : prog) : prog =
      let pass = (conf, action, name, depth) in
      self#run_pass pass prog

    (* Runs several modules *)
    method run_modules ?(conf : Config.config = def_conf) moduls (prog : prog)
        : prog =
      let passes =
        List.map
          (fun (action, name, depth) -> (conf, action, name, depth))
          moduls
      in
      self#run_passes passes prog

    (* Runs a module if |guard| is true *)
    method run_module_guard ?(conf : Config.config = def_conf) (guard : bool)
        (action, name, depth) (prog : prog) : prog =
      if guard then self#run_module ~conf (action, name, depth) prog
      else self#skip_module conf name prog

    (* Runs several modules, each protected by a guard *)
    method run_modules_guard ?(conf : Config.config = def_conf)
        (moduls : (('b * string * int) * bool) list) (prog : prog) : prog =
      List.fold_right
        (fun ((action, name, depth), guard) prog ->
          if guard then self#run_pass (conf, action, name, depth) prog
          else self#skip_module conf name prog)
        (List.rev moduls) prog

    (* Runs several modules, while benchmarking those who require
       benchmarking (those modules are also protected by a guard) *)
    method run_modules_bench ?(conf : Config.config = def_conf)
        (moduls : (('b * string * int) * bool * pass_type) list)
        (*        ^^^  ^^^^^^    ^^^    ^^^^   ^^^^^^^^^ *)
        (*    action    name    depth  guard   bench-type *)
          (prog : prog) : prog =
      match moduls with
      | [] -> prog
      | ((action, name, depth), guard, bench) :: tl ->
          if guard then
            match bench with
            | Toggle true ->
                self#run_bench_toggle (conf, action, name, depth) tl prog
            | Custom true -> self#run_custom_bench_pass conf action tl prog
            | _ ->
                let prog = self#run_pass (conf, action, name, depth) prog in
                self#run_modules_bench ~conf tl prog
          else
            let prog = self#skip_module conf name prog in
            self#run_modules_bench ~conf tl prog

    (* Benchmarks the module defined by |action| and |name|, and
       enables/disables it if the performances are better with/without
       it. *)
    method private run_bench_toggle (conf, action, name, depth)
        (nexts : (('b * string * int) * bool * pass_type) list) (prog : prog)
        : prog =
      self#push_in_bench (Format.sprintf "%s:on" name);
      let prog_opt_on =
        self#run_modules_bench ~conf
          (((action, name, depth), true, Always) :: nexts)
          prog
      in
      self#pop_in_bench ();
      self#push_in_bench (Format.sprintf "%s:off" name);
      let prog_opt_off =
        self#run_modules_bench ~conf
          (((action, name, depth), false, Always) :: nexts)
          prog
      in
      self#pop_in_bench ();

      let perfs_on, perfs_off =
        list_to_tuple2 (Perfs.compare_perfs [ prog_opt_on; prog_opt_off ] conf)
      in

      Format.printf "[%s] %s: on:%.2f  --  off:%.2f ---> %s@."
        (join " | " in_bench) name perfs_on perfs_off
        (* STDLIB_IMPORT: Comparing float *)
        (if Stdlib.(perfs_on < perfs_off) then "enabling" else "disabling");

      (* STDLIB_IMPORT: Comparing float *)
      if Stdlib.(perfs_on < perfs_off) then prog_opt_on else prog_opt_off

    (* Just a convenience wrapper to let a module benchmark iself. It is
       used in particular in the Inline and Interleave modules, which
       are more complex than simple on/off. *)
    method run_custom_bench_pass (conf : Config.config) action
        (_nexts : (('b * string * int) * bool * pass_type) list) (prog : prog) =
      nexts <- _nexts;
      (* Note that the module called (|action|) is supposed to empty self#nexts *)
      action self prog conf
  end
