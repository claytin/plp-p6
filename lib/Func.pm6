use Expr;

unit module Func;

grammar Func::Grammar is Expr::Grammar {
    token fun   { fun }
    token if    { if }
    token then  { then }
    token else  { else }
    token oparn { '(' }
    token cparn { ')' }

    rule expression:sym<app> { <application> }
    rule expression:sym<if>  { <ifthenelse> }

    rule declaration    { <let> <dec-list> <in> <expression> }
    rule dec-list       { <functional-dec> (<comma> <functional-dec>)* }

    rule functional-dec { <var-dec> | <fun-dec> }
    rule fun-dec        { <fun> <id> <params> <equal> <expression> }
    rule params         { <id>+ }

    rule application    { <id> <oparn> <expr-list> <cparn> }
    rule expr-list      { <expression> (<comma> <expression>)* }

    rule ifthenelse     { <if> <expression> <then> <expression>
                          <else> <expression>}
 }
