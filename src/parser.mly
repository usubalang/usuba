
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
%token TOK_INLINE
%token TOK_NOINLINE
%token TOK_WHEN
%token TOK_MERGE
       
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
%token TOK_DOT
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

%token <string> TOK_id
%token <int> TOK_int               
%token <Usuba_AST.typ> TOK_type
%token <Usuba_AST.intr_fun> TOK_intrinsic
                         
%token TOK_EOF

       
(***************************** Precedence levels ******************************)

%nonassoc TOK_FBY
%nonassoc TOK_WHEN
%nonassoc TOK_ARROW
%nonassoc TOK_LT
       
%nonassoc TOK_LSHIFT TOK_RSHIFT TOK_LROTATE TOK_RROTATE

%left TOK_PLUS TOK_DASH
%left TOK_STAR TOK_SLASH

%left TOK_AND TOK_XOR TOK_PIPE
%nonassoc TOK_TILDE
  
%nonassoc TOK_DOT


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
  | v=var TOK_DOT n=arith_exp { Field(v,n) }
  | i=TOK_id TOK_LBRACKET n=arith_exp TOK_RBRACKET { Index (i,n) }
  | i=TOK_id TOK_LBRACKET ei=arith_exp TOK_RANGE ef=arith_exp TOK_RBRACKET
    { Range(i,ei,ef) }
  | i=TOK_id TOK_LBRACKET e1=arith_exp TOK_COMMA
    l=separated_nonempty_list(TOK_COMMA,arith_exp) TOK_RBRACKET
    { Slice(i,e1::l) }

exp:
  | TOK_LPAREN e=exp TOK_RPAREN { e }
  | x=TOK_int { Const x }
  | x=var { ExpVar x } 
    (* note that a tuple has at least 2 elements (enforced by the following rule) *)
  | TOK_LPAREN e1=exp TOK_COMMA t=explist TOK_RPAREN  { Tuple (e1::t) }
  | x=exp o=log_op y=exp   { Log(o,x,y) }
  | x=exp o=arith_op y=exp { Arith(o,x,y) }
  | x=exp o=shift_op y=arith_exp { Shift(o,x,y) }
  | TOK_TILDE x=exp { Not x }
  | f=TOK_id TOK_LPAREN args=explist TOK_RPAREN { Fun(f, args) }
  | f=TOK_id TOK_LBRACKET n=arith_exp TOK_RBRACKET
    TOK_LPAREN args=explist TOK_RPAREN { Fun_v(f, n, args) }
  | f=TOK_intrinsic TOK_LPAREN x=exp TOK_COMMA y=exp TOK_RPAREN { Intr(f,x,y) }
  | a=exp TOK_WHEN constr=TOK_id TOK_LPAREN x=TOK_id TOK_RPAREN { When(a,constr,x) }
  | TOK_MERGE ck=TOK_id c=caselist { Merge(ck,c) }
  | init=exp TOK_FBY follow=exp { Fby(init,follow,None) }
  | init=exp TOK_LT f=TOK_id TOK_GT TOK_FBY follow=exp
    { Fby(init,follow,Some f) }
                                     
explist: l=separated_nonempty_list(TOK_COMMA,exp) { l }

caselist:
  | option(TOK_PIPE)
    l=separated_nonempty_list(TOK_PIPE,c=TOK_id TOK_ARROW e=exp {c,e}) { l }

pat:
  | p=var                      { [ p ] }
  | TOK_LPAREN l=separated_nonempty_list(TOK_COMMA,var) TOK_RPAREN   { l }

norec_deq:
  | p=pat TOK_EQUAL e=exp              { Norec( p, e ) }
  | p=pat op=log_op TOK_EQUAL e=exp    { Norec( p, Log(op,left_to_right p,e)) }
  | p=pat op=arith_op TOK_EQUAL e=exp  { Norec( p, Arith(op,left_to_right p,e)) }

deq_forall:
  | TOK_FORALL i=TOK_id TOK_IN TOK_LBRACKET startr=arith_exp TOK_COMMA
    endr=arith_exp TOK_RBRACKET TOK_LCURLY d=deqs TOK_RCURLY
    { Rec(i, startr, endr, d) }

deqs:
  | d1=deq_forall ds=deqs { d1 :: ds }
  | d=norec_deq TOK_SEMICOLON ds=deqs { d :: ds }
  | d=deq_forall { [ d ] }
  | d=norec_deq  { [ d ] }
                                      
p:
  | l=separated_list(TOK_COMMA, x=TOK_id TOK_COLON t=typ ck=pclock { x, t, ck }) { l }

typ:
  | t=TOK_type size=option(delimited(TOK_LBRACKET,arith_exp,TOK_RBRACKET))
                          { match size with
                            | Some n -> Array(t,n)
                            | None -> t }
                                      
pclock:
   | { "_" }
   | TOK_TWO_COLON id=TOK_id { id }

opt_def:
   | TOK_INLINE   { Inline }
   | TOK_NOINLINE { No_inline }

def:
  | opts=list(opt_def) TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_VAR vars=p TOK_LET body=deqs TOK_TEL
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Single(vars,body) } }
  | opts=list(opt_def) TOK_NODE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = def_list TOK_RBRACKET
    { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Multiple l } }
                 
  | opts=list(opt_def) TOK_PERM f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LCURLY l=intlist TOK_RCURLY
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Perm l } }
  | opts=list(opt_def) TOK_PERM TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=MultiplePerm l } }

  | opts=list(opt_def) TOK_TABLE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN
    TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN
    TOK_LCURLY l=intlist TOK_RCURLY
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=Table l } }
  | opts=list(opt_def) TOK_TABLE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN TOK_LPAREN p_out=p TOK_RPAREN TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { { id=f;p_in=p_in;p_out=p_out;opt=opts;node=MultipleTable l } }

  
intlist: l=separated_nonempty_list(TOK_COMMA, TOK_int) { l }

permlist:
  | l=separated_nonempty_list(TOK_SEMICOLON,
                              delimited(TOK_LCURLY,intlist,TOK_RCURLY)) { l }
  
def_list:
  l=separated_nonempty_list(TOK_SEMICOLON,
                            TOK_VAR vars=p TOK_LET body=deqs TOK_TEL { vars,body })
                           { l }

%%
