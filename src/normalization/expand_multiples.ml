open Usuba_AST

let run _ prog _ =
  {
    nodes =
      Basic_utils.flat_map
        (fun def ->
          match def.node with
          | Multiple l ->
              List.mapi
                (fun i x ->
                  {
                    def with
                    id = Ident.fresh_suffixed def.id (Printf.sprintf "%d'" i);
                    node = x;
                  })
                l
          | _ -> [ def ])
        prog.nodes;
  }

let as_pass = (run, "Expand_multiples", 0)
