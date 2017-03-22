
%{
  open Usuba_AST

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
%token TOK_WHEN
%token TOK_MERGE
%token TOK_FBY
%token TOK_FILL_I
%token TOK_FILL
%token TOK_PERM
%token TOK_TABLE
       
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
%token TOK_ARROW
%token TOK_LT
%token TOK_GT
%token TOK_DOT

%token TOK_AND
%token TOK_BANG
%token TOK_XOR

%token TOK_PLUS
%token TOK_STAR
%token TOK_DASH
%token TOK_SLASH

%token <string> TOK_id
%token <string> TOK_constr  (* ident with an uppercase 1st letter *)
%token <int> TOK_int               
%token <Usuba_AST.typ> TOK_type

%token TOK_EOF

%left TOK_AND TOK_XOR TOK_BANG 
%left TOK_PLUS TOK_STAR TOK_DASH TOK_SLASH

%nonassoc TOK_MERGE
%nonassoc TOK_PIPE
%nonassoc TOK_WHEN
%nonassoc TOK_LBRACKET
%nonassoc TOK_FBY
%left TOK_DOT

/*******************\
|*   entry point   *|
\*******************/
%start<Usuba_AST.prog> prog


%%

prog:
  | d=defs TOK_EOF { List.rev d }


log_op:
  | TOK_AND   { And }
  | TOK_PIPE  { Or  }
  | TOK_XOR   { Xor }

arith_op:
  | TOK_PLUS { Add }
  | TOK_STAR { Mul }
  | TOK_DASH { Sub }
  | TOK_SLASH { Div }


exp:
   | TOK_LPAREN e=exp TOK_RPAREN { e }
   | x=TOK_int { Const x }
   | id=TOK_id  { Var(id) }
   | i=TOK_id TOK_LBRACKET n=TOK_int TOK_RBRACKET { Access (i,n) }
   | e=exp TOK_DOT n=TOK_int { Field(e,n) }
   | TOK_LPAREN t=tuple TOK_RPAREN  { Tuple (List.rev t) }
   | x=exp o=log_op y=exp %prec TOK_AND { Log(o,x,y) }
   | x=exp o=arith_op y=exp %prec TOK_AND { Arith(o,x,y) }
   | TOK_BANG x=exp { Not x }
   | f=TOK_id TOK_LPAREN args=explist TOK_RPAREN { Fun(f, List.rev args) }
   | f=TOK_id TOK_LBRACKET n=TOK_int TOK_RBRACKET
     TOK_LPAREN args=explist TOK_RPAREN { Fun_i(f, n, List.rev args) }
   | f=TOK_id TOK_LBRACKET id=TOK_id TOK_RBRACKET
     TOK_LPAREN args=explist TOK_RPAREN { Fun_v(f, id, List.rev args) }
   | e=exp TOK_WHEN cstr=TOK_constr TOK_LPAREN x=TOK_id TOK_RPAREN { Mux(e,cstr,x) }
   | TOK_MERGE ck=TOK_id c=caselist %prec TOK_MERGE { Demux(ck,List.rev c) }
   | init=exp TOK_FBY follow=exp { Fby(init,follow,None) }
   | init=exp TOK_LBRACKET f=TOK_id TOK_RBRACKET TOK_FBY follow=exp
     { Fby(init,follow,Some f) }
   | TOK_FILL_I TOK_LT f=TOK_id TOK_SEMICOLON n=TOK_int TOK_GT
     TOK_LPAREN l=explist TOK_RPAREN
     { Fill_i(f,n,Tuple(List.rev l)) }
   | TOK_FILL TOK_LT f=TOK_id TOK_SEMICOLON n=TOK_int TOK_GT
     TOK_LPAREN l=explist TOK_RPAREN
     { Fill(f,n,Tuple(List.rev l)) }
caselist:
   | { [] }                                  
   | front=caselist TOK_PIPE c=TOK_constr TOK_ARROW e=exp %prec TOK_PIPE { (c,e)::front }

tuple:
  | tail=explist TOK_COMMA x=exp    { x::tail }
                                     
explist:
  | x=exp                           { [ x ]     }
  | tail=explist TOK_COMMA x=exp    { x :: tail }

pat_single:
  | i=TOK_id                          { Ident i }
  | i=TOK_id TOK_LBRACKET n=TOK_int TOK_RBRACKET { Index (i,n) }
  | p=pat_single TOK_DOT n=TOK_int    { Dotted(p,n) }
                                  
pat:
  | p=pat_single                      { [ p ] }
  | TOK_LPAREN l=patlist TOK_RPAREN   { List.rev l }

patlist:
  | p=pat_single                          { [ p ] }
  | tail=patlist TOK_COMMA p=pat_single   { p :: tail }

deq: (* returns a tuple list, is converted to AST by def *)
  | p=pat TOK_EQUAL e=exp                           { [ ( p, e ) ]  }
  | p=pat op=log_op TOK_EQUAL e=exp
    { [ ( p, Log(op,left_to_right p,e)) ]  }
  | p=pat op=arith_op TOK_EQUAL e=exp
    { [ ( p, Arith(op,left_to_right p,e)) ]  }
  | tail=deq TOK_SEMICOLON p=pat TOK_EQUAL e=exp    { (p,e) :: tail }
  | tail=deq TOK_SEMICOLON p=pat op=log_op TOK_EQUAL e=exp
    { ( p, Log(op,left_to_right p,e )) :: tail }
  | tail=deq TOK_SEMICOLON p=pat op=arith_op TOK_EQUAL e=exp
    { ( p, Arith(op,left_to_right p,e )) :: tail }

p:
  | { [ ] }
  | x=TOK_id TOK_COLON t=typ ck=clock { [ (x, t, ck) ] }
  | tail=p TOK_COMMA x=TOK_id TOK_COLON t=typ ck=clock { (x,t,ck) :: tail }

typ:
  | t=TOK_type { t }
  | t=TOK_type TOK_LBRACKET n=TOK_int TOK_RBRACKET { Array(t,n) }

clock:
   | { "" }
   | TOK_TWO_COLON id=TOK_id { id }

def:
  | TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_VAR vars=p TOK_LET body=deq TOK_TEL
  { Single(f,List.rev p_in,List.rev p_out,List.rev vars,List.rev body) }
  | TOK_NODE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN p_out=p TOK_LBRACKET
    l = def_list TOK_RBRACKET
  { Multiple(f,List.rev p_in, List.rev p_out, List.rev l) }
  | TOK_NODE TOK_LT TOK_id TOK_GT  f=TOK_id  TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_VAR vars=p TOK_LET body=deq TOK_TEL
  { Temporary(f,List.rev p_in,List.rev p_out,List.rev vars,List.rev body) }
  | TOK_PERM f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_LCURLY l=intlist TOK_RCURLY
  { Perm(f,List.rev p_in, List.rev p_out, List.rev l) }
  | TOK_PERM TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN p_out=p TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { MultiplePerm(f,List.rev p_in, List.rev p_out, List.rev l) }
  | TOK_TABLE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_LCURLY l=intlist TOK_RCURLY
  { Table(f,List.rev p_in, List.rev p_out, List.rev l) }
  | TOK_TABLE TOK_LBRACKET TOK_RBRACKET f=TOK_id TOK_LPAREN p_in=p
    TOK_RPAREN TOK_RETURN p_out=p TOK_LBRACKET
    l = permlist TOK_RBRACKET
  { MultipleTable(f,List.rev p_in, List.rev p_out, List.rev l) }

  
intlist:
  | i=TOK_int { [ i ] }
  | tail=intlist TOK_COMMA i=TOK_int { i::tail }

permlist:
  | TOK_LCURLY l=intlist TOK_RCURLY { [ List.rev l ] }
  | tail=permlist TOK_SEMICOLON TOK_LCURLY l=intlist TOK_RCURLY
    { (List.rev l) :: tail }
  
def_list:
  | TOK_VAR vars=p TOK_LET body=deq TOK_TEL { [(vars,body)] }
  | tail=def_list  TOK_SEMICOLON
    TOK_VAR vars=p TOK_LET body=deq TOK_TEL { (vars,body)::tail }
    

defs:
  | d=def               { [ d ] }
  | dl=defs d=def       { d::dl }

%%
