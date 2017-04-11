use v6;

unit module Expr::Grammar;

grammar Expr {
    # Non recursive productions ##
    # Literal values
    token number { \d+ }
    token quote  { < " ' > }
    regex string { <quote> <-[ " ]>* <quote> } # beacause token doesn't work
    token bool   { true | false }

    token id     { <[a..zA..Z]> (<number> | <[a..zA..Z]>)* }

    # Operators and reserved words
    token unary-op  { '-' | not }
    token binary-op { < - + and or == ++ > }
    token equal     { '=' }
    token let       { let }
    token var       { var }
    token in        { in }

    # Program ##
    rule TOP        { ^ <expression> $ }

    # Expresssions ##
    rule expression { <head-expr> <line-expr>?
                    | <unary-op> <expression> <line-expr>? }


    rule head-expr { <value> | <id> | <declaration> }
    rule line-expr { <binary-op> <expression> <line-expr>? }

    # Values
    rule value   { <literal> }
    rule literal { <number> | <string> | <bool> }

    # Declaration
    rule declaration { <let> <var-dec> (',' <var-dec>)* <in> <expression> }
    rule var-dec     { <var> <id> <equal> <expression> }
}

grammar Functional is Expr {
    token fun { fun }

    rule declaration    { <let> <functional-dec> (',' <functional-dec>)*
                          <in> <expression> }

    rule functional-dec { <var-dec> | <fun-dec> }
    rule fun-dec        { <fun> <id> <id>+ <equal> <expression> }
}

# say Expr.parse("a + 'oi'");
say Expr.parse("let var a = b, var b = a in a + b");


# say Functional.parse("a + 'oi'");
say Functional.parse("let var x = 10, fun id x = x in x + x");
