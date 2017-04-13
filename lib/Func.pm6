use Expr;

unit module Func;


grammar Func::Grammar is Expr::Grammar {
    token fun { fun }
    token if     { if }   
    token then   { then }     
    token else   { else }

    rule expression { <ifthenelse> | <head-expr> <line-expr>?
                    | <unary-op> <expression> <line-expr>? }

    rule declaration    { <let> <functional-dec> (',' <functional-dec>)*
                          <in> <expression> }

    rule functional-dec { <var-dec> | <fun-dec> }
    rule fun-dec        { <fun> <id> <id>+ <equal> <expression> }

    rule ifthenelse { <if> <expression> <then> 
                    <expression> <else> <expression>}
                


}
