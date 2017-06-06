open Usuba_AST
open Utils

module Select_size = struct
  let type_init = ref false
  let slice_type = ref (AVX 256) (* this is the default slicing *)
  let pack_size = ref (-1)

  let is_maxed (slice:slice_type) : bool =
    match slice with
    | Std -> true
    | MMX n -> n = 64
    | SSE n -> n = 128
    | AVX n -> n = 256
    | AVX512 -> true

  let select_size_intr (f:intr_fun) : unit =
    let slice =
      match f with
      | And64 | Or64 | Xor64 | Not64
      | Add64 | Sub64 | Mul64 | Div64 | Mod64
                                        -> Std
      (* MMX *)
      | Pand64 | Por64 | Pxor64 | Pandn64 -> MMX 64
      | Paddb64 | Psubb64 -> MMX 8
      | Paddw64 | Psubw64 -> MMX 16
      | Paddd64 | Psubd64 -> MMX 32
                                 
      (* SSE *)
      | Pand128 | Por128 | Pxor128 | Pandn128 -> SSE 128
      | Paddb128 | Psubb128 -> SSE 8
      | Paddw128 | Psubw128 -> SSE 16
      | Paddd128 | Psubd128 -> SSE 32
      | Paddq128|  Psubq128 -> SSE 64
                                   
      (* AVX *) 
      | VPand256 | VPor256 | VPxor256 | VPandn256 -> AVX 256
      | VPaddb256 | VPsubb256 -> AVX 8
      | VPaddw256 | VPsubw256 -> AVX 16
      | VPaddd256 | VPsubd256 -> AVX 32
      | VPaddq256|  VPsubq256 -> AVX 64
                                     
      (* AVX-512 *)
      | VPandd512 | VPord512 | VPxord512 | VPandnd512
                                           -> AVX512 in
    if !type_init then
      ( if !slice_type <> slice then
          raise (Error "Incompatible slicing sizes") )
    else
      (type_init := true;
       slice_type := slice)
        
  let rec select_size_expr (e:expr) : unit =
    match e with
    | Tuple l -> List.iter select_size_expr l
    | Not e -> select_size_expr e
    | Shift(_,e,_) -> select_size_expr e
    | Log(_,x,y) -> select_size_expr x; select_size_expr y
    | Arith(_,x,y) -> select_size_expr x; select_size_expr y
    | Intr(f,x,y) -> select_size_expr x; select_size_expr y;
                     select_size_intr f
    | Fun(_,l) -> List.iter select_size_expr l
    | Fun_v _ -> raise (Invalid_AST "Fun_v in instr select")
    | Fby(ei,ef,_) -> select_size_expr ei; select_size_expr ef
    | _ -> ()

  let select_size_int (n:int) : unit =
    if n <= 8 then
      (if !pack_size < 8 then
         pack_size := 8 )
    else if n <= 16 then
      (if !pack_size < 16 then
         pack_size := 16)
    else if n <= 32 then
      (if !pack_size < 32 then
         pack_size := 32)
    else if n <= 64 then
      (if !pack_size < 64 then
         pack_size := 64)
    else
      raise (Error ("Can't pack size " ^ (string_of_int n)))

            
  let select_size_vars (p:p) : unit =
    List.iter (fun (_,typ,_) ->
              match typ with
              | Int n when n > 1 -> select_size_int n
              | _ -> ()) p
             
  let select_size_def (def:def) : unit =
    match def.node with
    | Single(vars,body) ->
       select_size_vars def.p_in;
       select_size_vars def.p_out;
       select_size_vars vars;
       List.iter (function
                   | Norec(_,e) -> select_size_expr e
                   | _ -> raise (Invalid_AST "Rec in instr select")) body
    | _ -> raise (Invalid_AST "Non-single node in instruction selection")
                 
  let select_size (prog:prog) : slice_type =
    List.iter select_size_def prog.nodes;
    if !pack_size = -1 then
      !slice_type
    else
      match !slice_type with
      | Std -> if !pack_size <> 64 then
                 raise (Error ("Can't pack size " ^ (string_of_int !pack_size)
                               ^ " with standart registers"))
               else Std
      | MMX n -> if !pack_size <= n && n = 64 then MMX !pack_size
                 else if !pack_size < n then MMX n
                 else raise (Error ("Can't pack with to both " ^ (string_of_int n)
                                    ^ " and " ^ (string_of_int !pack_size) ^ " bits"))
      | SSE n -> if !pack_size <= n && n = 128 then SSE !pack_size
                 else if !pack_size < n then SSE n
                 else raise (Error ("Can't pack with to both " ^ (string_of_int n)
                                    ^ " and " ^ (string_of_int !pack_size) ^ " bits"))
      | AVX n -> if !pack_size <= n && n = 256 then AVX !pack_size
                 else if !pack_size < n then AVX n
                 else raise (Error ("Can't pack with to both " ^ (string_of_int n)
                                    ^ " and " ^ (string_of_int !pack_size) ^ " bits"))
      | AVX512 -> raise (Not_implemented ("Can't pack with AVX512 for now"))
end

let slice_type = ref Std
                     
let logop_to_intr (op:log_op) : intr_fun =
  match !slice_type with
  | Std ->  begin
             match op with
             | Or  -> Or64
             | And -> And64
             | Xor -> Xor64
             | Andn -> raise (Error "Andn") end
  | MMX _ ->
     begin
       match op with
       | Or  -> Por64
       | And -> Pand64
       | Xor -> Pxor64
       | Andn -> Pandn64 end
  | SSE _ ->
     begin
       match op with
       | Or  -> Por128
       | And -> Pand128
       | Xor -> Pxor128
       | Andn -> Pandn128 end
  | AVX _ ->
     begin
       match op with
       | Or  -> VPor256
       | And -> VPand256
       | Xor -> VPxor256
       | Andn -> VPandn256 end
  | AVX512 ->
     begin
       match op with
       | Or  -> VPord512
       | And -> VPandd512
       | Xor -> VPxord512
       | Andn -> VPandnd512 end

let arith_op_to_intr (op:arith_op) : intr_fun =
  match op with
  | Add -> begin
           match !slice_type with
           | Std    -> Add64
           | MMX 8  -> Paddb64
           | MMX 16 -> Paddw64
           | MMX 32 -> Paddd64
           | SSE 8  -> Paddb128
           | SSE 16 -> Paddw128
           | SSE 32 -> Paddd128
           | SSE 64 -> Paddq128
           | AVX 8  -> VPaddb256
           | AVX 16 -> VPaddw256
           | AVX 32 -> VPaddd256
           | AVX 64 -> VPaddq256
           | MMX _ | SSE _ | AVX _ | AVX512
              -> raise (Error "Can't bitslice addition")
         end
  | Sub -> begin
           match !slice_type with
           | Std    -> Sub64
           | MMX 8  -> Psubb64
           | MMX 16 -> Psubw64
           | MMX 32 -> Psubd64
           | SSE 8  -> Psubb128
           | SSE 16 -> Psubw128
           | SSE 32 -> Psubd128
           | SSE 64 -> Psubq128
           | AVX 8  -> VPsubb256
           | AVX 16 -> VPsubw256
           | AVX 32 -> VPsubd256
           | AVX 64 -> VPsubq256
           | MMX _ | SSE _ | AVX _ | AVX512
              -> raise (Error "Can't bitslice subtraction")
         end
  | Mul -> begin
           match !slice_type with
           | Std  -> Mul64
           | _ -> raise (Not_implemented "Only standart mul supported for now")
         end
  | Div -> begin
           match !slice_type with
           | Std  -> Div64
           | _ -> raise (Not_implemented "Only standart div supported for now")
         end
  | Mod -> begin
           match !slice_type with
           | Std  -> Mod64
           | _ -> raise (Not_implemented "Only standart mod supported for now")
         end
       

let rec norm_expr (e:expr) : expr =
  match e with
  | Log(Andn,x,y) ->
     (match !slice_type with
      | Std -> Intr(And64,Not(norm_expr x),norm_expr y)
      | _ -> Intr(logop_to_intr Andn,norm_expr x,norm_expr y))     
  | Log(op,x,y) -> Intr(logop_to_intr op,norm_expr x,norm_expr y)
  | Not x ->
     (match !slice_type with
      | Std -> Not(norm_expr x)
      | _ -> norm_expr (Log(Andn,x,Const 1)))
  | Shift _ -> raise (Not_implemented "Shifts")
  | Arith(op,x,y) -> Intr(arith_op_to_intr op,
                          norm_expr x, norm_expr y)
  | Fun(f,l) -> Fun(f,List.map norm_expr l)
  | Fby(ei,ef,id) -> Fby(norm_expr ei,norm_expr ef,id)
  | _ -> e
       
       
let norm_deq (deq:deq) : deq =
  match deq with
  | Norec(p,e) -> Norec(p,norm_expr e)
  | _ -> raise (Invalid_AST "Rec")
       
let norm_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with node = Single(vars,List.map norm_deq body) }
  | _ -> raise (Invalid_AST "Non-Single node")
       
let select_instr (prog:prog) : slice_type * prog =
  print_endline "Warning: slice type locked to Std";
  slice_type := Std; (*Select_size.select_size prog; *)
  !slice_type, { nodes = List.map norm_def prog.nodes }
