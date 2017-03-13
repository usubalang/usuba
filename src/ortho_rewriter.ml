
open Usuba_AST
open Utils
open Specific_rewriter

module Ortho_rewriter =
  ( struct

    let keep_print = true

    let print_fun = ref []
                       
    let gen_print l =
      let name = "print" ^ (string_of_int (id_generator ())) in
      let size = List.length l in
      let param = gen_list "p" size in
      let body = "let " ^ name ^ " (" ^ (join "," param) ^ ") =\n"
                 ^ (join "\n"
                         (List.map
                            (fun x -> "print_int (" ^ x ^ " land 1);") param))
                 ^ "\nprint_endline \"\";\n1" in
      print_fun := body :: !print_fun;
      name

    let gen_ortho (id,size) =
      let rec aux i =
        if i > size then ([],[])
        else let (left,right) = aux (i+1) in
             ((id^(string_of_int i))::left, (id ^ "'.(" ^ (string_of_int (64-i)) ^ ")")::right)
      in
      let (left,right) = aux 1 in
      let get_from_stream = "let " ^ id ^ " = Array.make 63 Int64.zero in\n"
                            ^ (indent 2) ^ "for i = 0 to 62 do\n"
                            ^ (indent_small 5) ^ id ^ ".(i) <- Stream.next " ^ id ^ "stream\n"
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
                              | Int n -> gen_list id n
                              | Array _ -> raise
                                             (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                                "Arrays should have been cleaned by now") ))
                            @ (aux tl)
      in aux p_out
             
    let gen_unortho p_out =
      let l = combine_out p_out in
      let left = gen_list "ret" (List.length l) in
      let rec aux p i =
        match p with
        | [] -> []
        | (id,typ,_)::tl -> let size = match typ with
                              | Bool -> 1
                              | Int n -> n
                              | Array _ -> raise
                                             (Invalid_AST
                                                "Arrays should have been cleaned by now") in
                            let tmp = ref ((indent 2) ^ "let " ^ id ^ " = Array.make "
                                           ^ (string_of_int size) ^ " 0 in\n")  in
                            for c = 1 to size do
                              tmp := !tmp ^ (indent 2) ^ id ^ ".(" ^ (string_of_int (c-1))
                                     ^ ") <- ret" ^ (string_of_int (i+65-c)) ^ ";\n"
                            done;
                            tmp := !tmp ^ (indent 2) ^ "stack_" ^ id
                                   ^ " := convert_unortho " ^ id ^ ";\n";
                            !tmp::(aux tl (i+size)) in
      let right = aux p_out 0 in
      (join "," left,
       (join "\n" right) ^ "\n"
      )    

        
    let gen_entry_point = function
      | Single(name, p_in, p_out, _, _) ->
         let params = List.map (fun (id,typ,_) ->
                                match typ with
                                | Bool  -> (id,1)
                                | Int n -> (id,n)
                                | Array _ -> raise
                                               (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                                  "Arrays should have been cleaned by now")))
                               p_in in
         let ortho = List.map gen_ortho params in
         let in_streams = List.map (fun (id,_) -> id ^ "stream") params in
         let head = "let main " ^ (join " " in_streams) ^ " = \n"
                    ^ (indent_small 1) ^ "let cpt = ref 64 in" in
         let stacks = join ("\n" ^ (indent_small 1))
                           (List.map (fun (id,_,_) ->
                                      "let stack_" ^ id ^ " = ref [| |] in") p_out) in
         let ret = join ","
                        (List.map (fun (id,_,_) ->
                                   "!stack_" ^ id ^ ".(!cpt)") p_out) in
         let (left,right) = gen_unortho p_out in
         (!print_fun, 
          head ^ "\n" ^ (indent_small 1) ^ stacks ^ "\n"
          ^ (indent_small 1) ^ "Stream.from\n" ^ (indent 1) ^ "(fun _ -> \n"
          ^ (indent 1) ^ "if !cpt < 63 then let ret = (" ^ ret ^ ") in\n"
          ^ (indent_small 13) ^ "incr cpt;\n" ^ (indent_small 13) ^ "Some ret\n"
          ^ (indent 1) ^ "else\n" ^ (indent_small 3) ^ "try\n"
          ^ (indent 2) ^ (join ("\n"^(indent 2)) (List.map snd ortho))
          ^ (indent 2) ^ "let (" ^ left ^ ") = " ^ name ^ "("
          ^ (join "," (List.map (fun (x,_)->"("^x^")") ortho)) ^ ") in\n"
          ^ right
          ^ (indent 2) ^ "cpt := 0;\n"
          ^ (indent 2) ^ "let return = Some (" ^ ret ^ ") in \n"
          ^ (indent 2) ^ "incr cpt;" ^ "\n"
          ^ (indent 2) ^ "return\n"
          ^ (indent_small 3) ^ "with Stream.Failure -> None)\n")
      | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                            "Arrays should have been cleaned by now"))
      | Temporary _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                             "Temporary should be gone by now"))
      | Perm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                        "Perm should be gone by now"))
      | MultiplePerm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                                "MultiplePerm should have been cleaned by now"))
      | Table _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                         "Tables should be gone by now"))

  end : SPECIFIC_REWRITER )
