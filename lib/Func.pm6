use Expr;

unit module Func;


grammar Func::Grammar is Expr::Grammar {
    token fun { fun }

    rule declaration    { <let> <dec-list> <in> <expression> }
    rule dec-list       { <functional-dec> (<comma> <functional-dec>)* }

    rule functional-dec { <var-dec> | <fun-dec> }
    rule fun-dec        { <fun> <id> <params> <equal> <expression> }
    rule params         { <id>+ }
}
