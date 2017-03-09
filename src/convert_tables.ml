open Abstract_syntax_tree
open Utils


let expand_intn_left (id: ident) (n: int) =
  let rec aux i =
    if i > n then []
    else (Dotted(Ident id, i)) :: (aux (i+1))
  in aux 1
         
let expand_intn_right (id: ident) (n: int) =
  let rec aux i =
    if i > n then []
    else (Field(Var id, i)) :: (aux (i+1))
  in aux 1
         
         
(* Duplicated function from Rewriter.ml *)
let rec rewrite_p_right (p: p) =
  match p with
  | [] -> []
  | (id,typ,_)::tl -> ( match typ with
                        | Bool  -> [ Var id ]
                        | Int x -> expand_intn_right id x
                        | Array _ -> raise (Invalid_AST
                                              "Arrays should have been cleaned by now")
                      ) @ (rewrite_p_right tl)

(* Duplicated function from Rewriter.ml *)
let rec rewrite_p_left (p: p) =
  match p with
  | [] -> []
  | (id,typ,_)::tl -> ( match typ with
                        | Bool  -> [ Ident id ]
                        | Int x -> expand_intn_left id x
                        | Array _ -> raise (Invalid_AST
                                              "Arrays should have been cleaned by now")
                      ) @ (rewrite_p_left tl)

let get_bits (l:int list) (i:int) : int list =
  let rec aux = function
    | [] -> []
    | hd::tl -> (hd lsr i land 1) :: (aux tl)
  in List.rev (aux l)

let tmp_var i j k =
  "tmp_" ^ (string_of_int i) ^ "_" ^ (string_of_int j) ^ "_" ^ (string_of_int k)

(* let mux c a b = Op(Xor,[Var a; Op(And,[c; Var b])]) *)
(* let mux c a b = Op(Xor,[Var a; Op(And,[c;Op(Xor,[Var a;Var b])])]) *)
let mux c a b = Op(Or,[Op(And,[Op(Not,[c]);Var a]);Op(And,[c;Var b])])
                                       
let rewrite_table id p_in p_out l : def =
  let exp_p_in  = Array.of_list (rewrite_p_right p_in) in
  let exp_p_out = Array.of_list (rewrite_p_left p_out) in
  let size_in = Array.length exp_p_in in
  let size_out = Array.length exp_p_out in
  let body : deq ref = ref [] in
  for i = 1 to size_out do (* for each bit ou the output *)

    (* get the bits of the output the current rank *)
    let bits = Array.of_list (List.rev (get_bits l (size_out-i))) in

    (* initialise rank 0 *)
    for j = 1 to List.length l do
      body := ([Ident (tmp_var i 0 (j-1))],Const bits.(j-1)) :: !body
    done;

    (* for each depth *)
    for j = 1 to size_in do
      
      for k = 1 to pow 2 (size_in-j) do
        body := ([Ident (tmp_var i j (k-1))], mux exp_p_in.(size_in-j)
                                                         (tmp_var i (j-1) ((k-1)*2))
                                                         (tmp_var i (j-1) ((k-1)*2+1)))
                  :: !body
      done
    done;
    
    (* set output *) 
    body := ([exp_p_out.(i-1)], Var (tmp_var i size_in 0)) :: !body
      
  done;
    
  Single(id,p_in,p_out,[],List.rev !body)
       
let rec rewrite_defs (l: def list) : def list =
  match l with
  | [] -> []
  | hd :: tl ->
     match hd with
     | Table(id,p_in,p_out,l) -> (rewrite_table id p_in p_out l) :: (rewrite_defs tl)
     | _ -> hd :: (rewrite_defs tl)
            
                       
let rewrite_prog (p: prog) : prog =
  rewrite_defs p
