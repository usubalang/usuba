
%{
  open Abstract_syntax_tree
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

%token TOK_LPAREN
%token TOK_RPAREN
%token TOK_EQUAL
%token TOK_COMMA
%token TOK_TWO_COLON
%token TOK_COLON
%token TOK_SEMICOLON
%token TOK_PIPE
%token TOK_ARROW
       
%token TOK_AND
%token TOK_OR
%token TOK_XOR
%token TOK_NOT

%token <string> TOK_id
%token <string> TOK_constr  (* ident with an uppercase 1st letter *)
%token <int> TOK_int
%token <string*int> TOK_dotted

               
%token <Abstract_syntax_tree.typ> TOK_type

%token TOK_EOF

%nonassoc TOK_MERGE
%nonassoc TOK_PIPE
%nonassoc TOK_WHEN

/*******************\
|*   entry point   *|
\*******************/
%start<Abstract_syntax_tree.prog> prog


%%

prog:
  | d=defs TOK_EOF { List.rev d }

op:
  | TOK_AND { And }
  | TOK_OR  { Or  }
  | TOK_XOR { Xor }
  | TOK_NOT { Not }

exp:
   | TOK_LPAREN e=exp TOK_RPAREN { e }
   | x=TOK_int { Const x }
   | id=TOK_id  { Var(id) }
   | v=TOK_dotted { Field(fst v,snd v) }
   | TOK_LPAREN t=tuple TOK_RPAREN  { Tuple (List.rev t) }
   | o=op TOK_LPAREN args=explist TOK_RPAREN { Op(o, List.rev args) }
   | f=TOK_id TOK_LPAREN args=explist TOK_RPAREN { Fun(f, List.rev args) }
   | e=exp TOK_WHEN cstr=TOK_constr TOK_LPAREN x=TOK_id TOK_RPAREN { Mux(e,cstr,x) }
   | TOK_MERGE ck=TOK_id c=caselist %prec TOK_MERGE { Demux(ck,List.rev c) }

caselist:
   | { [] }                                  
   | front=caselist TOK_PIPE c=TOK_constr TOK_ARROW e=exp %prec TOK_PIPE { (c,e)::front }

tuple:
  | tail=explist TOK_COMMA x=exp    { x::tail }
                                     
explist:
  | x=exp                           { [ x ]     }
  | tail=explist TOK_COMMA x=exp    { x :: tail }

pat:
  | i=TOK_id                          { [ Ident i ] }
  | v=TOK_dotted                      { [ Dotted(fst v,snd v) ] }
  | TOK_LPAREN l=patlist TOK_RPAREN   { List.rev l }

patlist:
  | i=TOK_id                              { [ Ident i ]     }
  | v=TOK_dotted                          { [ Dotted(fst v,snd v) ] }
  | tail=patlist TOK_COMMA i=TOK_id       { (Ident i) :: tail }
  | tail=patlist TOK_COMMA v=TOK_dotted   { (Dotted(fst v,snd v)) :: tail }

deq: (* returns a tuple list, is converted to AST by def *)
  | p=pat TOK_EQUAL e=exp                           { [ ( p, e ) ]  }
  | tail=deq TOK_SEMICOLON p=pat TOK_EQUAL e=exp    { (p,e) :: tail }

p:
  | { [ ] }
  | x=TOK_id TOK_COLON t=TOK_type TOK_TWO_COLON ck=TOK_id
    { [ (x, t, ck) ] }
  | tail=p TOK_COMMA x=TOK_id TOK_COLON t=TOK_type TOK_TWO_COLON ck=TOK_id
    { (x,t,ck) :: tail }

def:
  | TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p
    TOK_VAR vars=p TOK_LET body=deq TOK_TEL
  { (f,List.rev p_in,List.rev p_out,vars,List.rev body) }
  
defs:
  | d=def               { [ d ] }
  | dl=defs d=def       { d::dl }

%%
