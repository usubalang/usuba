
%{
  open Usuba_AST

  (* convert a left_asgn list into an expression *)
  let rec left_to_right (l: left_asgn list) : expr =
    let rec single_l2r = function
      | Ident id    -> Var id
      | Dotted(l,i) -> Field(single_l2r l,i)
      | Index(id,i) -> Access(id,i) in
    let rec aux = function
      | [] -> []
      | hd::tl -> (single_l2r hd)::(aux tl)
    in Tuple(aux l) 
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
%token TOK_FILL_I
%token TOK_FILL
%token TOK_PERM
%token TOK_TABLE
%token TOK_WITH
%token TOK_THEN
%token TOK_ELSE       
       
%token TOK_LPAREN
%token TOK_RPAREN
%token TOK_LBRACKET
%token TOK_RBRACKET
%token TOK_LCURLY
%token TOK_RCURLY
%token TOK_EQUAL
%token TOK_NOT_EQUAL       
%token TOK_COMMA
%token TOK_TWO_COLON
%token TOK_COLON
%token TOK_SEMICOLON
%token TOK_PIPE
%token TOK_LT
%token TOK_LEQ       
%token TOK_GT
%token TOK_GEQ       
%token TOK_DOT
%token TOK_AT

%token TOK_AND
%token TOK_BANG
%token TOK_XOR

%token TOK_PLUS
%token TOK_STAR
%token TOK_DASH
%token TOK_SLASH

%token <string> TOK_id
%token <int> TOK_int               
%token <Usuba_AST.typ> TOK_type

%token TOK_EOF

       
(***************************** Precedence levels ******************************)
       
%left TOK_AT

%nonassoc TOK_EQUAL TOK_NOT_EQUAL TOK_LEQ TOK_GEQ TOK_LT TOK_GT
          
%left TOK_PLUS TOK_DASH
%left TOK_STAR TOK_SLASH
  
%left TOK_DOT
%left TOK_PIPE

%right TOK_BANG
%left TOK_AND TOK_XOR


/*******************\
|*   entry point   *|
\*******************/
%start<Usuba_AST.prog> prog


%%

prog:
  | body=list(def) TOK_EOF { body }

%inline log_op:
  | TOK_AND   { And }
  | TOK_PIPE  { Or  }
  | TOK_XOR   { Xor }

%inline arith_op:
  | TOK_PLUS  { Add }
  | TOK_STAR  { Mul }
  | TOK_DASH  { Sub }
  | TOK_SLASH { Div }

%inline comp_op:              
  | TOK_EQUAL     { Equal }
  | TOK_NOT_EQUAL { Not_equal }
  | TOK_LEQ       { Leq }
  | TOK_GEQ       { Geq }
  | TOK_LT        { Lt  }
  | TOK_GT        { Gt  }


arith_exp:
  | TOK_LPAREN e=arith_exp TOK_RPAREN { e }
  | n = TOK_int { Const n }
  | e1=arith_exp op=arith_op e2=arith_exp { Op(op,e1,e2) }
  | e1=arith_exp op=comp_op e2=arith_exp { Comp(op,e1,e2) }

exp:
  | TOK_LPAREN e=exp TOK_RPAREN { e }
  | x=TOK_int { Const x }  
  | id=TOK_id  { Var(id) }
  | i=TOK_id TOK_LBRACKET n=TOK_int TOK_RBRACKET { Access (i,n) }
  | e=exp TOK_DOT n=TOK_int { Field(e,n) }     
  (* note that a tuple has at least 2 elements (enforced by the following rule) *)
  | TOK_LPAREN e1=exp TOK_COMMA t=explist TOK_RPAREN  { Tuple (e1::t) }
  | x=exp o=log_op y=exp %prec TOK_AND { Log(o,x,y) }
  | x=exp o=arith_op y=exp %prec TOK_AND { Arith(o,x,y) }
  | TOK_BANG x=exp { Not x }
  | f=TOK_id TOK_LPAREN args=explist TOK_RPAREN { Fun(f, args) }
  | f=TOK_id TOK_LBRACKET n=TOK_int TOK_RBRACKET
    TOK_LPAREN args=explist TOK_RPAREN { Fun_i(f, n, args) }
  | f=TOK_id TOK_LBRACKET id=TOK_id TOK_RBRACKET
    TOK_LPAREN args=explist TOK_RPAREN { Fun_v(f, id, args) }
  | ei=exp TOK_AT ef=exp { Concat(ei, ef) }

(* expressions that are not reccursives *)
out_exp:
  | e=exp { e }
  | init=exp TOK_FBY follow=exp { Fby(init,follow,None) }
  | init=exp TOK_LBRACKET f=TOK_id TOK_RBRACKET TOK_FBY follow=exp
    { Fby(init,follow,Some f) }
  | TOK_FILL_I TOK_LT f=TOK_id TOK_SEMICOLON n=TOK_int TOK_GT
    TOK_LPAREN l=explist TOK_RPAREN
    { Fill_i(f,n,Tuple l ) }
  | TOK_FILL TOK_LT f=TOK_id TOK_SEMICOLON n=TOK_int TOK_GT
    TOK_LPAREN l=explist TOK_RPAREN
    { Fill(f,n,Tuple l) }
  | TOK_WITH cond=arith_exp TOK_THEN base=exp TOK_ELSE induc=exp
    { With(cond,base,induc) }
                                     
explist: l=separated_nonempty_list(TOK_COMMA,exp) { l }

pat_single:
  | i=TOK_id                          { Ident i }
  | i=TOK_id TOK_LBRACKET n=TOK_int TOK_RBRACKET { Index (i,n) }
  | p=pat_single TOK_DOT n=TOK_int    { Dotted(p,n) }
                                  
pat:
  | p=pat_single                      { [ p ] }
  | TOK_LPAREN l=separated_nonempty_list(TOK_COMMA,pat_single) TOK_RPAREN   { l }

deq: (* returns a tuple list, is converted to an AST by def *)
  | p=pat TOK_EQUAL e=out_exp              { ( p, e ) }
  | p=pat op=log_op TOK_EQUAL e=out_exp    { ( p, Log(op,left_to_right p,e)) }
  | p=pat op=arith_op TOK_EQUAL e=out_exp  { ( p, Arith(op,left_to_right p,e)) }

deqs: l=separated_nonempty_list(TOK_SEMICOLON, deq) { l }

p:
  | l=separated_list(TOK_COMMA, x=TOK_id TOK_COLON t=typ ck=clock { x, t, ck }) { l }

typ:
  | t=TOK_type size=option(delimited(TOK_LBRACKET,TOK_int,TOK_RBRACKET))
                          { match size with
                            | Some n -> Array(t,n)
                            | None -> t }
                                      
clock:
   | { "" }
   | TOK_TWO_COLON id=TOK_id { id }

def:
  | TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_VAR vars=p TOK_LET body=deqs TOK_TEL
  { Single(f,p_in,p_out,vars, body) }
  | TOK_NODE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN p_out=p TOK_LBRACKET
    l = def_list TOK_RBRACKET
  { Multiple(f,p_in, p_out, l) }
  | TOK_NODE TOK_LT TOK_id TOK_GT  f=TOK_id  TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_VAR vars=p TOK_LET body=deqs TOK_TEL
  { Temporary(f,p_in,p_out,vars, body) }
  | TOK_PERM f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_LCURLY l=intlist TOK_RCURLY
  { Perm(f,p_in, p_out, l) }
  | TOK_PERM TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN p_out=p TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { MultiplePerm(f,p_in, p_out, l) }
  | TOK_TABLE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_LCURLY l=intlist TOK_RCURLY
  { Table(f,p_in, p_out,l) }
  | TOK_TABLE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN p_out=p TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { MultipleTable(f,p_in, p_out, l) }

  
intlist: l=separated_nonempty_list(TOK_COMMA, TOK_int) { l }

permlist:
  | l=separated_nonempty_list(TOK_SEMICOLON,
                              delimited(TOK_LCURLY,intlist,TOK_RCURLY)) { l }
  
def_list:
  l=separated_nonempty_list(TOK_SEMICOLON,
                            TOK_VAR vars=p TOK_LET body=deqs TOK_TEL { vars,body })
                           { l }

%%
