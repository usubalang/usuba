
%{
  open Tp_AST
  open Lexing
  open Utils
  exception Syntax_error
%}

/*******************\
|*      tokens     *|
\*******************/
%token TOK_RS
%token TOK_IN
%token TOK_AND
%token TOK_OR
%token TOK_XOR
%token TOK_NOT
%token TOK_SETCST
%token TOK_SETCSTALL

%token TOK_LPAREN
%token TOK_RPAREN
%token TOK_EQUAL
%token TOK_LROTATE
%token TOK_LSHIFT
%token TOK_RROTATE
%token TOK_RSHIFT

%token TOK_PLUS
%token TOK_STAR
%token TOK_DASH
%token TOK_SLASH
%token TOK_MOD

%token <Tp_AST.ident> TOK_id
%token <int> TOK_int

%token TOK_EOF


(***************************** Precedence levels ******************************)


(******************************** Entry Point *********************************)
%start<Tp_AST.prog> prog
%start<Tp_AST.expr> expr_a

%%

prog:
  TOK_RS TOK_EQUAL rs=TOK_int
  inputs=list(TOK_IN v=TOK_id { v })
  body=list(v=TOK_id TOK_EQUAL e=expr { { lhs = v; rhs = e } })
  TOK_EOF
  { { rs = rs; inputs = inputs; body = body } }

%inline log_op:
  | TOK_AND   { And }
  | TOK_OR    { Or  }
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

expr:
  | TOK_LPAREN e=expr TOK_RPAREN                  { e             }
  | x=TOK_id                                      { ExpVar x      }
  | TOK_SETCST TOK_LPAREN i=TOK_int TOK_RPAREN    { Const i       }
  | TOK_SETCSTALL TOK_LPAREN i=TOK_int TOK_RPAREN { ConstAll i    }
  | TOK_NOT x=TOK_id                              { Not x         }
  | op=log_op   x=TOK_id y=TOK_id                 { Log(op,x,y)   }
  | op=arith_op x=TOK_id y=TOK_id                 { Arith(op,x,y) }
  | x=TOK_id op=shift_op i=TOK_int                { Shift(op,x,i) }
expr_a: e=expr TOK_EOF { e }

%%
