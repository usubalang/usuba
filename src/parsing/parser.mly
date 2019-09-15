
%{
  open Usuba_AST
  open Lexing
  open Utils
  exception Syntax_error

  (* convert a left_asgn list into an expression *)
  let rec left_to_right (l: var list) : expr =
    match l with
     | [] -> raise Syntax_error
     | x::[] -> ExpVar x
     | _ -> Tuple (List.map (fun x -> ExpVar x) l)
%}

/*******************\
|*      tokens     *|
\*******************/
%token TOK_NODE
%token TOK_RETURN
%token TOK_VAR
%token TOK_LET
%token TOK_TEL
%token TOK_FBY
%token TOK_PERM
%token TOK_TABLE
%token TOK_FORALL
%token TOK_IN
%token TOK_WHEN
%token TOK_WHENOT
%token TOK_MERGE
%token TOK_ON
%token TOK_ONOT
%token TOK_BASE
%token TOK_SHUFFLE
%token TOK_INLINE
%token TOK_NOINLINE
%token TOK_UNROLL
%token TOK_NOUNROLL
%token TOK_INTERLEAVE
%token TOK_NOOPT
%token TOK_CONST
%token TOK_LAZYLIFT
%token TOK_PIPELINED
%token TOK_SAFEEXIT

%token TOK_NAT
%token TOK_B
%token TOK_U
%token TOK_V
%token TOK_CROSS

%token TOK_LPAREN
%token TOK_RPAREN
%token TOK_LBRACKET
%token TOK_RBRACKET
%token TOK_LCURLY
%token TOK_RCURLY
%token TOK_EQUAL
%token TOK_COMMA
%token TOK_TWO_COLON
%token TOK_COLON
%token TOK_SEMICOLON
%token TOK_PIPE
%token TOK_LROTATE
%token TOK_LSHIFT
%token TOK_RROTATE
%token TOK_RSHIFT
%token TOK_RLSHIFT
%token TOK_RANGE
%token TOK_LT
%token TOK_GT
%token TOK_ARROW
%token TOK_SQUOTE

%token TOK_AND
%token TOK_TILDE
%token TOK_XOR

%token TOK_PLUS
%token TOK_STAR
%token TOK_DASH
%token TOK_SLASH
%token TOK_MOD

%token <Usuba_AST.ident> TOK_id
%token <Usuba_AST.ident> TOK_id_no_x
%token <int> TOK_int
%token <Usuba_AST.constr> TOK_constr
%token <Usuba_AST.dir> TOK_dir

%token TOK_EOF


(***************************** Precedence levels ******************************)

%nonassoc TOK_FBY
%nonassoc TOK_WHEN
%nonassoc TOK_WHENOT
%nonassoc TOK_ARROW

%nonassoc TOK_LSHIFT TOK_RSHIFT TOK_RLSHIFT TOK_LROTATE TOK_RROTATE

%left TOK_PLUS TOK_DASH
%left TOK_STAR TOK_SLASH TOK_MOD

%left TOK_AND TOK_XOR TOK_PIPE
%nonassoc TOK_TILDE

%left TOK_id_no_x TOK_U TOK_B TOK_V TOK_IN TOK_CROSS TOK_dir
%left TOK_id


(******************************** Entry Point *********************************)
%start<Usuba_AST.prog> prog
%start<Usuba_AST.arith_expr> arith_exp_a
%start<Usuba_AST.var> var_a
%start<Usuba_AST.expr> exp_a
%start<Usuba_AST.deq> deq_a
%start<Usuba_AST.def> def_a

%%

prog:
  | body=list(def) TOK_EOF { { nodes = body } }

%inline log_op:
  | TOK_AND   { And }
  | TOK_PIPE  { Or  }
  | TOK_XOR   { Xor }

%inline arith_op:
  | TOK_PLUS  { Add }
  | TOK_STAR  { Mul }
  | TOK_DASH  { Sub }
  | TOK_SLASH { Div }
  | TOK_MOD   { Mod }

%inline shift_op:
  | TOK_LSHIFT  { Lshift  }
  | TOK_RSHIFT  { Rshift  }
  | TOK_RLSHIFT { RLshift }
  | TOK_LROTATE { Lrotate }
  | TOK_RROTATE { Rrotate }

ident:
  | id=ident_no_x { id }
  | id=TOK_id     { id }
  | s=ident e=ident %prec TOK_id_no_x { fresh_ident (s.name ^ e.name) }

ident_no_x:
  | id=TOK_id_no_x  { id }
  | TOK_IN     { fresh_ident "in" }
  | TOK_CROSS  { fresh_ident "x"  }
  | TOK_U id=ident_no_x  { fresh_ident ("u" ^ id.name) }
  | TOK_B id=ident_no_x  { fresh_ident ("b" ^ id.name) }
  | TOK_V id=ident_no_x  { fresh_ident ("v" ^ id.name) }
  | TOK_U n=TOK_int { fresh_ident ("u" ^ (string_of_int n)) }
  | TOK_B n=TOK_int { fresh_ident ("b" ^ (string_of_int n)) }
  | TOK_V n=TOK_int { fresh_ident ("v" ^ (string_of_int n)) }
  | TOK_U n=TOK_int id=ident_no_x { fresh_ident ("u" ^ (string_of_int n) ^ id.name) }
  | TOK_B n=TOK_int id=ident_no_x { fresh_ident ("b" ^ (string_of_int n) ^ id.name) }
  | TOK_V n=TOK_int id=ident_no_x { fresh_ident ("v" ^ (string_of_int n) ^ id.name) }
  | TOK_U      { fresh_ident "u"  }
  | TOK_B      { fresh_ident "b"  }
  | TOK_V      { fresh_ident "v"  }
  | d=TOK_dir  { match d with
                 | Hslice -> fresh_ident "H"
                 | Vslice -> fresh_ident "V"
                 | Bslice -> fresh_ident "B"
                 | _ -> raise Syntax_error }

arith_exp:
  | TOK_LPAREN e=arith_exp TOK_RPAREN { e }
  | n = TOK_int { Const_e n }
  | x = ident  { Var_e x }
  | e1=arith_exp op=arith_op e2=arith_exp { Op_e(op,e1,e2) }
arith_exp_a: ae=arith_exp TOK_EOF { ae }

var:
  | id=ident { Var id  }
  | v=var TOK_LBRACKET n=arith_exp TOK_RBRACKET { Index (v,n) }
  | v=var TOK_LBRACKET ei=arith_exp TOK_RANGE ef=arith_exp TOK_RBRACKET
    { Range(v,ei,ef) }
  | v=var TOK_LBRACKET e1=arith_exp TOK_COMMA
    l=separated_nonempty_list(TOK_COMMA,arith_exp) TOK_RBRACKET
    { Slice(v,e1::l) }
var_a: v=var TOK_EOF { v }

exp:
  | TOK_LPAREN e=exp TOK_RPAREN { e }
  | x=TOK_int { Const(x,None) }
  | x=TOK_int TOK_COLON t=typ { Const(x,Some t) }
  | x=var { ExpVar x }
    (* note that a tuple has at least 2 elements (enforced by the following rule) *)
  | TOK_LPAREN e1=exp TOK_COMMA t=explist TOK_RPAREN  { Tuple (e1::t) }
  | TOK_SHUFFLE TOK_LPAREN v=var TOK_COMMA TOK_LBRACKET
    l=separated_nonempty_list(TOK_COMMA, TOK_int) TOK_RBRACKET TOK_RPAREN
     { Shuffle(v,l) }
  | v=var TOK_LCURLY l=separated_nonempty_list(TOK_COMMA, TOK_int) TOK_RCURLY
     { Shuffle(v,l) }
  | x=exp o=log_op y=exp   { Log(o,x,y) }
  | x=exp o=arith_op y=exp { Arith(o,x,y) }
  | x=exp o=shift_op y=arith_exp { Shift(o,x,y) }
  | TOK_TILDE x=exp { Not x }
  | f=ident TOK_LPAREN args=explist TOK_RPAREN { Fun(f, args) }
  | f=ident TOK_LT n=arith_exp TOK_GT
    TOK_LPAREN args=explist TOK_RPAREN { Fun_v(f, n, args) }
  | a=exp TOK_WHEN constr=TOK_constr TOK_LPAREN x=ident TOK_RPAREN { When(a,constr, x) }
  | a=exp TOK_WHENOT constr=TOK_constr TOK_LPAREN x=ident TOK_RPAREN
    (* Transforming Whenot into When. Would be cleaner to do it later, todo.. *)
    { match constr with
      | True -> When(a,False, x)
      | False -> When(a,True, x) }
  | TOK_MERGE ck=ident c=caselist { Merge(ck,c) }
  | init=exp TOK_FBY follow=exp { Fby(init,follow,None) }
  (* | init=exp TOK_LT f=ident TOK_GT TOK_FBY follow=exp *)
  (*   { Fby(init,follow,Some f) } *)
exp_a: e=exp TOK_EOF { e }

explist: l=separated_nonempty_list(TOK_COMMA,exp) { l }

caselist:
  | option(TOK_PIPE)
    l=separated_nonempty_list(TOK_PIPE,c=TOK_constr TOK_ARROW e=exp {c,e}) { l }

pat:
  | p=var                      { [ p ] }
  | TOK_LPAREN l=separated_nonempty_list(TOK_COMMA,var) TOK_RPAREN   { l }

norec_deq:
  | p=pat TOK_EQUAL e=exp              { Eqn( p, e, false ) }
  | p=pat op=log_op TOK_EQUAL e=exp    { Eqn( p, Log(op,left_to_right p,e), false) }
  | p=pat op=arith_op TOK_EQUAL e=exp  { Eqn( p, Arith(op,left_to_right p,e), false) }
  | p=pat TOK_COLON TOK_EQUAL e=exp              { Eqn( p, e, true) }
  | p=pat op=log_op TOK_COLON TOK_EQUAL e=exp    { Eqn( p, Log(op,left_to_right p,e), true) }
  | p=pat op=arith_op TOK_COLON TOK_EQUAL e=exp  { Eqn( p, Arith(op,left_to_right p,e), true) }

opt_stmt:
   | TOK_UNROLL    { Unroll    }
   | TOK_NOUNROLL  { No_unroll }
   | TOK_PIPELINED { Pipelined }
   | TOK_SAFEEXIT  { Safe_exit }

deq_forall:
 | opts=list(opt_stmt) TOK_FORALL i=ident TOK_IN TOK_LBRACKET startr=arith_exp
   TOK_COMMA endr=arith_exp TOK_RBRACKET TOK_LCURLY d=deqs TOK_RCURLY
    { Loop(i, startr, endr, d, opts) }

(* Doesn't use the |deq| rule because it would make semicolons mandatory after
   foralls. *)
deqs:
  | d=deq_forall list(TOK_SEMICOLON) ds=deqs { d :: ds }
  | d=norec_deq  nonempty_list(TOK_SEMICOLON) ds=deqs { d :: ds }
  | d=deq_forall list(TOK_SEMICOLON)  { [ d ] }
  | d=norec_deq  list(TOK_SEMICOLON)  { [ d ] }

deq:
  | d=deq_forall { d }
  | d=norec_deq  { d }
deq_a: d=deq TOK_EOF { d }

opt_var_d:
  TOK_CONST { Pconst }
  | TOK_LAZYLIFT { PlazyLift }

var_d:
  ids=separated_list(TOK_COMMA, ident) TOK_COLON attr=list(opt_var_d) t=typ ck=pclock
  { List.map (fun x -> { vid = x; vtyp=t; vck=ck; vopts=attr }) ids }

p:
  | l=separated_list(TOK_COMMA, var_d) { List.flatten l }

dir:
  | { default_dir }
  | TOK_LT dir=TOK_dir TOK_GT { dir }
  | TOK_LT i=TOK_int   TOK_GT { Mslice i }
  | TOK_LT TOK_SQUOTE id=ident TOK_GT { Varslice id }

mtyp:
  | i=TOK_int { Mint i }
  | TOK_SQUOTE id=ident_no_x { Mvar id }


primitive_typ:
  | TOK_NAT  { Nat  }
  (* u<D>mxn *)
  | TOK_U dir=dir m=mtyp xn=TOK_id
    { let s  = xn.name in
      let re = Str.regexp "^x\\([0-9]+\\)$" in
      match Str.string_match re s 0 with
      | true ->  let n_str :string = Str.matched_group 1 s in
                 let n:int     = int_of_string n_str in
                 Uint(dir,m,n)
      | false -> raise Syntax_error
      }
  (* u<D>m *)
  | TOK_U dir=dir m=mtyp { Uint(dir, m, 1) }
  (* b<D>n *)
  | TOK_B dir=dir n=TOK_int { Uint(dir, Mint 1, n) }
  (* v<D>n *)
  | TOK_V dir=dir n=TOK_int { Uint(dir, default_m, n) }


typ:
  | t=primitive_typ sizes=list(delimited(TOK_LBRACKET,arith_exp,TOK_RBRACKET))
    { match sizes with
      | [] -> t
      | _ -> List.fold_right (fun s i -> Array(i, eval_arith_ne s)) sizes t }

pclock:
   | { Base }
   | TOK_TWO_COLON ck=clock { ck }

clock:
   | TOK_BASE { Base }
   | ck=clock TOK_ON x=ident { On(ck,x) }
   | ck=clock TOK_ONOT x=ident { Onot(ck,x) }


opt_def:
   | TOK_INLINE   { Inline    }
   | TOK_NOINLINE { No_inline }
   | TOK_INTERLEAVE TOK_LPAREN n=TOK_int TOK_RPAREN { Interleave n }
   | TOK_NOOPT    { No_opt    }

def:
  (* A node *)
  | opts=list(opt_def) TOK_NODE f=ident TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_VAR vars=p TOK_LET body=deqs TOK_TEL
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Single(vars,body) } }
  (* A node without local variables *)
  | opts=list(opt_def) TOK_NODE f=ident TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LET body=deqs TOK_TEL
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Single([],body) } }
  (* A permutation *)
  | opts=list(opt_def) TOK_PERM f=ident TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LCURLY l=intlist TOK_RCURLY
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Perm l } }
  (* A table *)
  | opts=list(opt_def) TOK_TABLE f=ident TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LCURLY l=intlist TOK_RCURLY
  { { id=f;p_in=p_in;p_out=p_out;opt=Is_table::opts;node=Table l } }

  (* ARRAYS *)
  (* An array of nodes *)
  | opts=list(opt_def) TOK_NODE TOK_LBRACKET TOK_RBRACKET f=ident TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = def_list TOK_RBRACKET
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;
        node=Multiple (List.map (fun (x,y) -> Single(x,y)) l) } }
  (* An array of permutations *)
  | opts=list(opt_def) TOK_PERM TOK_LBRACKET TOK_RBRACKET f=ident TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Multiple (List.map (fun x -> Perm x ) l) } }
  (* An array of table *)
  | opts=list(opt_def) TOK_TABLE TOK_LBRACKET TOK_RBRACKET f=ident TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { { id=f;p_in=p_in;p_out=p_out;opt=Is_table::opts;
      node=Multiple (List.map (fun x -> Table x) l) } }
def_a: d=def TOK_EOF { d }

intlist: l=separated_nonempty_list(TOK_COMMA, TOK_int) { l }

permlist:
  | l=separated_nonempty_list(TOK_SEMICOLON,
                              delimited(TOK_LCURLY,intlist,TOK_RCURLY)) { l }

def_list:
  l=separated_nonempty_list(TOK_SEMICOLON, def_list_elem)
                           { l }

def_list_elem:
  | TOK_VAR vars=p TOK_LET body=deqs TOK_TEL { vars,body }
  | TOK_LET body=deqs TOK_TEL { [],body }

%%
