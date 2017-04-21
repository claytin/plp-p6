use Expr;

unit module Func;

grammar FuncI is ExprII is export {
    token fun  { fun }
    token if   { if }
    token then { then }
    token else { else }

    # Expresssions ##
    rule expr:sym<app> { <id> <oparn> <expr-list> <cparn> }
    rule expr:sym<if>  { <if> <expr> <then> <expr> <else> <expr> }

    rule expr-list { <expr> (<comma> <expr>)* }

    # Declaration ##
    rule functional-dec { <fun-dec> | <var-dec> }

    # Function
    rule fun-dec { <fun> <id> <params> <equal> <expr> }
    rule params  { <id> <id>* }

    rule dec-list { <functional-dec> (<comma> <functional-dec>)* }
 }
