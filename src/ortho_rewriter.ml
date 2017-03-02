
open Abstract_syntax_tree
open Utils
open Specific_rewriter

module Ortho_rewriter =
  ( struct

    let keep_print = false
                       
    let gen_print l = ""

    let gen_ortho (id,size) =
      let rec aux i =
        if i > size then ([],[])
        else let (left,right) = aux (i+1) in
             ((id^(string_of_int i))::left, (id ^ "'.(" ^ (string_of_int (i-1)) ^ ")")::right)
      in
      let (left,right) = aux 1 in
      let get_from_stream = "let " ^ id ^ " = Array.make 63 Int64.zero in\n"
                            ^ (indent 2) ^ "for i = 0 to 62 do\n"
                            ^ (indent_small 5) ^ id ^ ".(i) <- Stream.next " ^ id ^ "_stream\n"
                            ^ (indent 2) ^ "done;\n" in
      let grab_ortho = (indent 2) ^ "let ("^ (join "," left) ^ ") = (" ^ (join "," right) ^ ") in\n" in
      (join "," left,
       get_from_stream
       ^ (indent 2) ^ "let " ^ id  ^ "' = convert_ortho " ^ (string_of_int size) ^ " " ^ id ^ " in\n"
       ^ grab_ortho)

        
    let combine_out p_out =
      let rec aux = function
        | [] -> []
        | (id,typ,_)::tl -> ( match typ with
                              | Bool -> [ id ]
                              | Int n -> gen_list id n ) @ (aux tl)
      in aux p_out
             
    let gen_unortho p_out =
      let l = combine_out p_out in
      let left = gen_list "ret" (List.length l) in
      let rec aux p i =
        match p with
        | [] -> []
        | (id,typ,_)::tl -> let size = match typ with Bool -> 1 | Int n -> n in
                            let tmp = ref ((indent 2) ^ "let " ^ id ^ " = Array.make "
                                           ^ (string_of_int size) ^ " 0 in\n")  in
                            for c = 1 to size do
                              tmp := !tmp ^ (indent 2) ^ id ^ ".(" ^ (string_of_int c)
                                     ^ ") <- ret" ^ (string_of_int (i+c)) ^ ";\n"
                            done;
                            tmp := !tmp ^ (indent 2) ^ "stack_" ^ id
                                   ^ " := convert_unortho " ^ id ^ ";\n";
                            !tmp::(aux tl (i+size)) in
      let right = aux p_out 0 in
      (join "," left,
       (join "\n" right) ^ "\n"
      )    

        
    let gen_entry_point (name, p_in, p_out, _, _) =
      let params = List.map (fun (id,typ,_) -> match typ with
                                               | Bool  -> (id,1)
                                               | Int n -> (id,n)) p_in in
      let ortho = List.map gen_ortho params in
      let in_streams = List.map (fun (id,_) -> id ^ "_stream") params in
      let head = "let main " ^ (join " " in_streams) ^ " = \n"
                 ^ (indent_small 1) ^ "let cpt = ref 0 in" in
      let stacks = join ("\n" ^ (indent_small 1))
                        (List.map (fun (id,_,_) ->
                                   "let stack_" ^ id ^ " = ref [| |] in") p_out) in
      let ret = join ","
                     (List.map (fun (id,_,_) ->
                                "!stack_" ^ id ^ ".(!cpt)") p_out) in
      let (left,right) = gen_unortho p_out in
      ([],
       head ^ "\n" ^ (indent_small 1) ^ stacks ^ "\n"
       ^ (indent_small 1) ^ "Stream.from\n" ^ (indent 1) ^ "(fun _ -> \n"
       ^ (indent 1) ^ "if !cpt < 64 then let ret = (" ^ ret ^ ") in\n"
       ^ (indent_small 13) ^ "incr cpt;\n" ^ (indent_small 13) ^ "Some ret\n"
       ^ (indent 1) ^ "else\n" ^ (indent_small 3) ^ "try\n"
       ^ (indent 2) ^ (join ("\n"^(indent 2)) (List.map snd ortho))
       ^ (indent 2) ^ "let (" ^ left ^ ") = " ^ name ^ "_ ("
       ^ (join "," (List.map (fun (x,_)->"("^x^")") ortho)) ^ ") in\n"
       ^ right
       ^ (indent 2) ^ "cpt := 0;\n"
       ^ (indent 2) ^ "let return = Some (" ^ ret ^ ") in \n"
       ^ (indent 2) ^ "incr cpt;" ^ "\n"
       ^ (indent 2) ^ "return\n"
       ^ (indent_small 3) ^ "with Stream.Failure -> None)\n")
                             

  end : SPECIFIC_REWRITER )