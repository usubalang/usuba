
%{
  open Usuba_AST
  open Lexing
  open Printf
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
%token TOK_RANGE
%token TOK_LT
%token TOK_GT
%token TOK_ARROW

%token TOK_AND
%token TOK_TILDE
%token TOK_XOR

%token TOK_PLUS
%token TOK_STAR
%token TOK_DASH
%token TOK_SLASH
%token TOK_MOD

%token <Usuba_AST.ident> TOK_id
%token <int> TOK_int               
%token <Usuba_AST.typ> TOK_type
%token <Usuba_AST.constr> TOK_constr
                              
%token TOK_EOF

       
(***************************** Precedence levels ******************************)

%nonassoc TOK_FBY
%nonassoc TOK_WHEN
%nonassoc TOK_WHENOT
%nonassoc TOK_ARROW
       
%nonassoc TOK_LSHIFT TOK_RSHIFT TOK_LROTATE TOK_RROTATE

%left TOK_PLUS TOK_DASH
%left TOK_STAR TOK_SLASH TOK_MOD

%left TOK_AND TOK_XOR TOK_PIPE
%nonassoc TOK_TILDE
  

(******************************** Entry Point *********************************)
%start<Usuba_AST.prog> prog


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
  | TOK_LROTATE { Lrotate }
  | TOK_RROTATE { Rrotate }

arith_exp:
  | TOK_LPAREN e=arith_exp TOK_RPAREN { e }
  | n = TOK_int { Const_e n }
  | x = TOK_id  { Var_e x }
  | e1=arith_exp op=arith_op e2=arith_exp { Op_e(op,e1,e2) }

var:
  | id=TOK_id { Var id  }
  | v=var TOK_LBRACKET n=arith_exp TOK_RBRACKET { Index (v,n) }
  | v=var TOK_LBRACKET ei=arith_exp TOK_RANGE ef=arith_exp TOK_RBRACKET
    { Range(v,ei,ef) }
  | v=var TOK_LBRACKET e1=arith_exp TOK_COMMA
    l=separated_nonempty_list(TOK_COMMA,arith_exp) TOK_RBRACKET
    { Slice(v,e1::l) }

exp:
  | TOK_LPAREN e=exp TOK_RPAREN { e }
  | x=TOK_int { Const x }
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
  | f=TOK_id TOK_LPAREN args=explist TOK_RPAREN { Fun(f, args) }
  | f=TOK_id TOK_LT n=arith_exp TOK_GT
    TOK_LPAREN args=explist TOK_RPAREN { Fun_v(f, n, args) }
  | a=exp TOK_WHEN constr=TOK_constr TOK_LPAREN x=TOK_id TOK_RPAREN { When(a,constr, x) }
  | a=exp TOK_WHENOT constr=TOK_constr TOK_LPAREN x=TOK_id TOK_RPAREN
    (* Transforming Whenot into When. Would be cleaner to do it later, todo.. *)
    { match constr with
      | True -> When(a,False, x)
      | False -> When(a,True, x) }
  | TOK_MERGE ck=TOK_id c=caselist { Merge(ck,c) }
  | init=exp TOK_FBY follow=exp { Fby(init,follow,None) }
  (* | init=exp TOK_LT f=TOK_id TOK_GT TOK_FBY follow=exp *)
  (*   { Fby(init,follow,Some f) } *)
                                     
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
 | opts=list(opt_stmt) TOK_FORALL i=TOK_id TOK_IN TOK_LBRACKET startr=arith_exp
   TOK_COMMA endr=arith_exp TOK_RBRACKET TOK_LCURLY d=deqs TOK_RCURLY
    { Loop(i, startr, endr, d, opts) }

deqs:
  | d=deq_forall ds=deqs { d :: ds }
  | d=norec_deq TOK_SEMICOLON ds=deqs { d :: ds }
  | d=deq_forall { [ d ] }
  | d=norec_deq  { [ d ] }

opt_var_d:
  TOK_CONST { Pconst }
  | TOK_LAZYLIFT { PlazyLift }

var_d:
  x=TOK_id TOK_COLON attr=list(opt_var_d) t=typ ck=pclock
  { { vid = x; vtyp=t; vck=ck; vopts=attr } }

p:
  | l=separated_list(TOK_COMMA, var_d) { l }

typ:
  | t=TOK_type sizes=list(delimited(TOK_LBRACKET,arith_exp,TOK_RBRACKET))
                          { match sizes with
                            | [] -> t
                            | _ -> List.fold_left (fun i s -> Array(i,s)) t sizes }
                                      
pclock:
   | { Base }
   | TOK_TWO_COLON ck=clock { ck }

clock:
   | TOK_BASE { Base }
   | ck=clock TOK_ON x=TOK_id { On(ck,x) }
   | ck=clock TOK_ONOT x=TOK_id { Onot(ck,x) }


opt_def:
   | TOK_INLINE   { Inline    }
   | TOK_NOINLINE { No_inline }
   | TOK_INTERLEAVE TOK_LPAREN n=TOK_int TOK_RPAREN { Interleave n }
   | TOK_NOOPT    { No_opt    }

def:
  (* A node *)
  | opts=list(opt_def) TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_VAR vars=p TOK_LET body=deqs TOK_TEL
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Single(vars,body) } }
  (* A node without local variables *)
  | opts=list(opt_def) TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LET body=deqs TOK_TEL
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Single([],body) } }
  (* A permutation *)
  | opts=list(opt_def) TOK_PERM f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LCURLY l=intlist TOK_RCURLY
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Perm l } }
  (* A table *)
  | opts=list(opt_def) TOK_TABLE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LCURLY l=intlist TOK_RCURLY
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Table l } }

  (* ARRAYS *)
  (* An array of nodes *)
  | opts=list(opt_def) TOK_NODE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = def_list TOK_RBRACKET
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;
        node=Multiple (List.map (fun (x,y) -> Single(x,y)) l) } }
  (* An array of permutations *)
  | opts=list(opt_def) TOK_PERM TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Multiple (List.map (fun x -> Perm x ) l) } }
  (* An array of table *)
  | opts=list(opt_def) TOK_TABLE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Multiple (List.map (fun x -> Table x) l) } }

  
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
