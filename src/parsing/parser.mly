%{
  open Prelude
  open Usuba_AST
  open Utils

  (* convert a left_assign list into an expression *)
  let left_to_right (l: var list) : expr =
    match l with
     | [] -> assert false
     | [x] -> ExpVar x
     | _ -> Tuple (List.map (fun x -> ExpVar x) l)

  type 'a decl = DSingle of 'a | DMultiple of 'a list

%}

/*******************/
/*      TOKENS     */
/*******************/

/* Declaration type token */
%token NODE PERM TABLE ARRAY INCLUDE
/* Keywords inside declaration */
%token RETURN
%token VAR LET TEL FORALL IN
/* Options */
%token SHUFFLE BITMASK PACK INLINE NOINLINE UNROLL NOUNROLL INTERLEAVE NOOPT
%token CONST LAZYLIFT PIPELINED

/* Characters */
%token LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY
%token EQUAL COMMA COLON SEMICOLON PIPE
%token LROTATE LSHIFT RROTATE RSHIFT RASHIFT
%token RANGE LT GT
/* Operators */
%token AND TILDE BANG XOR
%token PLUS STAR DASH SLASH MOD

/* Values */
%token <Usuba_AST.ident * Usuba_AST.typ option> IDENT
%token <Usuba_AST.typ> TYPE
%token <string> STRING
%token <int> INT

/* End of file */
%token EOF


(***************************** Precedence levels ******************************)

%nonassoc LSHIFT RSHIFT RASHIFT LROTATE RROTATE

%left PLUS DASH
%left STAR SLASH MOD

%left AND XOR PIPE
%nonassoc TILDE BANG


(******************************** Entry Point *********************************)
%start<Usuba_AST.def_or_inc list> prog

(********************************** Testing ***********************************)

%start<Usuba_AST.arith_expr> isolated_arith_expr
%start<Usuba_AST.var> isolated_var
%start<Usuba_AST.expr> isolated_expr
%start<Usuba_AST.deq> isolated_deq
%start<Usuba_AST.def> isolated_def

%%

prog:
  | body=list(def_or_inc) EOF { body }

%inline log_op:
  | AND   { And }
  | PIPE  { Or  }
  | XOR   { Xor }

%inline arith_op:
  | PLUS  { Add }
  | STAR  { Mul }
  | DASH  { Sub }
  | SLASH { Div }
  | MOD   { Mod }

%inline shift_op:
  | LSHIFT  { Lshift  }
  | RSHIFT  { Rshift  }
  | RASHIFT { RAshift }
  | LROTATE { Lrotate }
  | RROTATE { Rrotate }

%inline ident:
  | id = IDENT { let id, _ = id in id }

%inline typ_or_typ_ident:
  | id = IDENT
    { let id, t = id in
      match t with
      | None -> raise (Errors.Malformed_type (Ident.name id))
      | Some t -> t }
  | t = TYPE { t }

arith_expr:
  | LPAREN e = arith_expr RPAREN { e }
  | n = INT { Const_e n }
  | id = ident  { Var_e id }
  | e1 = arith_expr op = arith_op e2 = arith_expr { Op_e (op, e1, e2) }

isolated_arith_expr: ae = arith_expr EOF { ae }

var:
  | id = ident
    { Var id }
  | v = var LBRACKET ae = arith_expr RBRACKET
    { Index (v, ae) }
  | v = var LBRACKET aei = arith_expr RANGE aef = arith_expr RBRACKET
    { Range (v, aei, aef) }
  | v = var LBRACKET ae = arith_expr COMMA ae_list = separated_nonempty_list(COMMA, arith_expr) RBRACKET
    { Slice (v, ae :: ae_list) }

isolated_var: v = var EOF { v }

typ_expl: COLON t = typ { t }

expr:
  | LPAREN e = expr RPAREN
    { e }
  | x = INT
    { Const(x, None) }
  | x = INT COLON t = typ
    { Const(x, Some t) }
  | x = var
    { ExpVar x }
    (* note that a tuple has at least 2 elements (enforced by the following rule) *)
  | LPAREN e = expr COMMA exp_list = separated_nonempty_list(COMMA, expr) RPAREN
    { Tuple (e :: exp_list) }
  | SHUFFLE LPAREN v=var COMMA LBRACKET
      int_list = separated_nonempty_list(COMMA, INT) RBRACKET RPAREN
    { Shuffle(v, int_list) }
  | v = var LCURLY int_list = separated_nonempty_list(COMMA, INT) RCURLY
    { Shuffle(v, int_list) }
  | e1 = expr op = log_op e2 = expr
    { Log(op , e1, e2) }
  | e1 = expr op = arith_op e2 = expr
    { Arith(op , e1, e2) }
  | e1 = expr op = shift_op e2 = arith_expr
    { Shift(op , e1, e2) }
  | TILDE e = expr
    { Not e }
  | BANG e = expr
    { Not e }
  | BITMASK LPAREN e = expr COMMA ae = arith_expr RPAREN
    { Bitmask(e, ae) }
  | PACK LPAREN e1 = expr COMMA e2 = expr RPAREN t = option(typ_expl)
    { Pack(e1, e2, t) }
  | f = ident LPAREN args = explist RPAREN
    { Fun(f, args) }
  | f = ident LT ae = arith_expr GT LPAREN args = explist RPAREN
    { Fun_v(f, ae , args) }

isolated_expr: e = expr EOF { e }

explist: l = separated_nonempty_list(COMMA, expr) { l }

pat:
  | p=var                      { [ p ] }
  | LPAREN l=separated_nonempty_list(COMMA,var) RPAREN   { l }

_norec_deq:
  | p = pat imperative = boption(COLON) EQUAL e = expr
    { Eqn( p, e, imperative ) }
  | p = pat op = log_op imperative = boption(COLON) EQUAL e = expr
    { Eqn( p, Log(op, left_to_right p, e), imperative) }
  | p = pat op = arith_op imperative = boption(COLON) EQUAL e = expr
    { Eqn( p, Arith(op, left_to_right p, e), imperative) }

norec_deq:
  | d = _norec_deq { { content = d; orig = [] } }

opt_stmt:
   | UNROLL    { Unroll    }
   | NOUNROLL  { No_unroll }
   | PIPELINED { Pipelined }

deq_forall:
 | opts = list(opt_stmt) FORALL id = ident IN LBRACKET start = arith_expr
   COMMA stop = arith_expr RBRACKET LCURLY body = deqs RCURLY
    { { content = Loop {id; start; stop; body; opts}; orig = [] } }

(* Doesn't use the |deq| rule because it would make semicolons mandatory after
   foralls. *)
deqs:
  | d = deq_forall list(SEMICOLON) ds=deqs { d :: ds }
  | d = norec_deq  nonempty_list(SEMICOLON) ds=deqs { d :: ds }
  | d = deq_forall list(SEMICOLON)  { [ d ] }
  | d = norec_deq  list(SEMICOLON)  { [ d ] }

deq:
  | d = deq_forall { d }
  | d = norec_deq  { d }

isolated_deq: d = deq EOF { d }

opt_var_d:
  | CONST    { Pconst }
  | LAZYLIFT { PlazyLift }

var_d:
  | ids = separated_nonempty_list(COMMA, ident) COLON vd_opts = list(opt_var_d)
vd_typ = typ
  { List.map (fun vd_id -> { vd_id; vd_typ; vd_opts; vd_orig = [] }) ids }

p:
  | var_list = separated_list(COMMA, var_d) { List.flatten var_list }

typ:
  | t = typ_or_typ_ident sizes = list(delimited(LBRACKET, arith_expr, RBRACKET))
    {
      match sizes with
      | [] -> t
      | _ -> List.fold_right (fun s i -> Array(i, Const_e (eval_arith_ne s))) sizes t }

opt_def:
   | INLINE   { Inline    }
   | NOINLINE { No_inline }
   | INTERLEAVE LPAREN n = INT RPAREN { Interleave n }
   | NOOPT    { No_opt    }


def_or_inc:
   | d=def { Def d }
   | s=inc { Inc s }

inc:
  | INCLUDE s = STRING { s }

is_perm:
  | PERM { true }
  | TABLE { false }

def:
  (* A node *)
  | opt = list(opt_def) NODE is_array = boption(ARRAY) id = ident
    LPAREN p_in = p RPAREN
    RETURN LPAREN p_out = p RPAREN
    body = node_body
    {
      let node = match is_array, body with
        | true, DMultiple l -> Multiple (List.map (fun (x, y) -> Single (x, y)) l)
        | true, DSingle _ ->
           let loc = $loc(is_array) in
           raise (Errors.Table_of_single (loc, "node"))
        | false, DSingle (vars, body) -> Single (vars, body)
        | false, DMultiple _ ->
           let loc = $loc(is_array) in
           raise (Errors.Single_of_table (loc, "node"))
      in
      { id; p_in; p_out; opt; node } }
  (* A permutation or table *)
  | opt = list(opt_def) is_perm = is_perm is_array = boption(ARRAY) id = ident
    LPAREN p_in = p RPAREN
    RETURN LPAREN p_out = p RPAREN
    body = perm_or_table_body
    {
      let opt = if is_perm then opt else Is_table::opt in
      let node = match is_array, body with
        | true, DMultiple l -> Multiple (List.map (fun x -> if is_perm then Perm x else Table x) l)
        | true, DSingle _ ->
           let loc = $loc(is_array) in
           raise (Errors.Table_of_single (loc,
                    (if is_perm then "perm" else "table")))
        | false, DSingle e -> if is_perm then Perm e else Table e
        | false, DMultiple _ ->
           let loc = $loc(is_array) in
           raise (Errors.Single_of_table (loc,
                    (if is_perm then "perm" else "table")))
      in
      { id; p_in; p_out; opt; node } }

isolated_def: d = def EOF { d }

/* Permutations or tables body */
perm_or_table_body:
  | e = p_or_t_body_elem
    { DSingle e }
  | LBRACKET dl = separated_nonempty_list(SEMICOLON, p_or_t_body_elem) RBRACKET
    { DMultiple dl }

p_or_t_body_elem:
  | l = delimited(LCURLY, separated_nonempty_list(COMMA, INT), RCURLY)
    { l }

/* Nodes body */
node_body:
  | e = node_body_elem
    { DSingle e }
  | LBRACKET dl = separated_nonempty_list(SEMICOLON, node_body_elem) RBRACKET
    { DMultiple dl }

node_body_elem:
  | vars = loption (vars) LET body=deqs TEL { vars, body }

vars: VAR vars = p { vars }
