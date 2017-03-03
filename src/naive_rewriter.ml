
open Abstract_syntax_tree
open Utils
open Specific_rewriter

module Naive_rewriter =
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
                            (fun x -> "print_int (if " ^ x ^ " then 1 else 0);") param))
                 ^ "\nprint_endline \"\";\ntrue" in
      print_fun := body :: !print_fun;
      name

    let gen_ortho (id,size) =
      let rec aux i =
        if i > size then ([],[])
        else let stri = (string_of_int i) in
             let stri_m1 = (string_of_int (i-1)) in
             let (left,right) = aux (i+1) in
             ((id^stri)::left, ("Int64.logand (Int64.shift_right " ^ id ^ " " ^ stri_m1
                                ^ ") Int64.one = Int64.one")::right)
      in
      let (left,right) = aux 1 in
      (join "," left,
       "let " ^ id ^ " = Stream.next " ^ id ^ "stream in\n" ^
         (indent 2) ^ "let (" ^ (join "," left) ^ ") = (" ^ (join "," (List.rev right)) ^ ") in")


        
    let combine_out p_out =
      let rec aux = function
        | [] -> []
        | (id,typ,_)::tl -> ( match typ with
                              | Bool -> [ id ]
                              | Int n -> gen_list id n 
                              | Array _ -> raise
                                             (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^ 
                                                "Arrays should have been cleaned by now")))
                            @ (aux tl)
      in aux p_out
             
    let gen_unortho p_out =
      let l = combine_out p_out in
      let rec aux size i =
        if i > size then []
        else ( let mul = "(Int64.shift_left Int64.one " ^ (string_of_int (size-i)) ^ ")" in
               let id_curr  = "ret" ^ (string_of_int i) in
               ("(if " ^ id_curr ^ " then " ^ mul ^ " else Int64.zero)")::(aux size (i+1)))
      in
      let left = gen_list "ret" (List.length l) in
      let right = List.map (fun (_,typ,_) ->
                            let size = match typ with
                                Bool -> 1
                              | Int n -> n
                              | Array _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__)
                                                               ^ 
                                                    "Arrays should have been cleaned by now")) in
                            ( List.fold_left (fun x y -> "(Int64.logor " ^ x ^ " " ^ y ^ ")")
                                             "Int64.zero" (aux size 1) )) p_out in
      let ret = join "," (List.map (fun (id,_,_) -> id^"'") p_out) in
      (join "," left,
       "let (" ^ ret ^ ") = " ^ (join "," right) ^ "\n"
       ^ (indent 2) ^ "in Some (" ^ ret ^ ")")    

        
    let gen_entry_point = function
      | Single(name, p_in, p_out, _, _) -> 
         let params = List.map (fun (id,typ,_) ->
                                match typ with
                                | Bool  -> (id,1)
                                | Int n -> (id,n)
                                | Array _ -> raise (Invalid_AST
                                                      (__FILE__ ^ (string_of_int __LINE__)
                                                       ^ "Arrays should have been cleaned by now")))
                               p_in in
         let ortho = List.map gen_ortho params in
         let in_streams = List.map (fun (id,_) -> id ^ "stream") params in
         let head = "let main " ^ (join " " in_streams) ^ " = " in
         let (left,right) = gen_unortho p_out in
         (!print_fun,
          head ^ "\n" ^ (indent 1) ^ "Stream.from\n" ^ (indent 1) ^ "(fun _ -> \n"
          ^ (indent 1) ^ "try\n"
          ^ (indent 2) ^ (join ("\n"^(indent 2)) (List.map snd ortho)) ^ "\n"
          ^ (indent 2) ^ "let (" ^ left ^ ") = " ^ name ^ " ("
          ^ (join "," (List.map (fun (x,_)->"("^x^")") ortho)) ^ ") in\n"
          ^ (indent 2) ^ right ^ "\n"
          ^ (indent 1) ^ "with Stream.Failure -> None)\n")
      | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                            "Arrays should have been cleaned by now"))
      | Temporary _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                             "Temporary should be gone by now"))

  end : SPECIFIC_REWRITER)
