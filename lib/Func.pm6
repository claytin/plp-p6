use Expr;

unit module Func;

grammar Func::Grammar is Expr::Grammar {
    token fun  { fun }
    token if   { if }
    token then { then }
    token else { else }

    rule expression:sym<ife> { <ifthenelse> }

    rule declaration    { <let> <dec-list> <in> <expression> }
    rule dec-list       { <functional-dec> (<comma> <functional-dec>)* }

    rule functional-dec { <var-dec> | <fun-dec> }
    rule fun-dec        { <fun> <id> <params> <equal> <expression> }
    rule params         { <id>+ }

    rule ifthenelse     { <if> <expression> <then> <expression>
                          <else> <expression>}
 }
