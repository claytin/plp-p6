use Expr;

unit module Func;


grammar Func::Grammar is Expr::Grammar {
    token fun { fun }

    rule declaration    { <let> <functional-dec> (',' <functional-dec>)*
                          <in> <expression> }

    rule functional-dec { <var-dec> | <fun-dec> }
    rule fun-dec        { <fun> <id> <id>+ <equal> <expression> }
}
