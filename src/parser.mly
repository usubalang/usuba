
%{
    open Abstract_syntax_tree
%}

/*******************\
|*      tokens     *|
\*******************/
%token TOK_NODE
%token TOK_RETURN
%token TOK_LET
%token TOK_TEL
%token TOK_WHEN
%token TOK_MERGE

%token TOK_UNDEF

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
/* do we need int ? */

%token TOK_EOF

%nonassoc TOK_MERGE

/*******************\
|*   entry point   *|
\*******************/
%start<Abstract_syntax_tree.prog> prog


%%

prog:
  | d=defs TOK_EOF { d }

op:
  | TOK_AND { AST_and }
  | TOK_OR  { AST_or  }
  | TOK_XOR { AST_xor }
  | TOK_NOT { AST_not }

exp:
  | TOK_LPAREN; e=exp; TOK_RPAREN { e }
  | x=TOK_int { AST_const x }
  | id=TOK_id  { AST_var(id) }
  | TOK_LPAREN; t=explist; TOK_RPAREN  { AST_tuple t }
  | o=op; TOK_LPAREN; args=explist; TOK_RPAREN { AST_op(o, args) }
  | f=TOK_id; TOK_LPAREN; args=explist; TOK_RPAREN { AST_fun(f, args) }
  | e=exp; TOK_WHEN; cstr=TOK_constr; TOK_LPAREN; x=TOK_id; TOK_LPAREN
    { AST_mux(e,cstr,x) }
  | TOK_MERGE; ck=TOK_id; c=caselist { AST_demux(ck,(List.rev c)) }

explist:
  | x=exp                           { [ x ]     }
  | tail=explist; TOK_COMMA; x=exp  { x :: tail }

caselist:
  | TOK_PIPE; c=TOK_constr; TOK_ARROW; e=exp  { [ (c,e) ] }
  | tail=caselist; TOK_PIPE; c=TOK_constr; TOK_ARROW; e=exp  { (c,e)::tail }

pat:
  | i=TOK_id                          { [ i ] }
  | TOK_LPAREN; l=patlist; TOK_RPAREN { l   }

patlist:
  | i=TOK_id                            { [ i ]     }
  | tail=patlist; TOK_COMMA; i=TOK_id   { i :: tail }

deq: (* returns a tuple list, is converted to AST by def *)
  | p=pat; TOK_EQUAL; e=exp                           { [ ( p, e ) ]  }
  | tail=deq; TOK_SEMICOLON; p=pat; TOK_EQUAL; e=exp  { (p,e) :: tail }

p:
  | l=plist         { List.rev l }

psingle:
  | x=TOK_id TOK_COLON TOK_UNDEF TOK_TWO_COLON TOK_UNDEF
    { (x, AST_undef, AST_undef) }

plist:
  | e=psingle                        { [ e ] }
  | tail=plist; TOK_COMMA; e=psingle { e :: tail }

def:
  | TOK_NODE f=TOK_id TOK_LPAREN p_in=p TOK_RPAREN TOK_RETURN p_out=p TOK_LET body=deq TOK_TEL
  { (f,p_in,p_out,(List.rev body)) }
  
defs:
  | d=def              { [ d ] }
  | d=def; dl=defs     { d::dl }

%%