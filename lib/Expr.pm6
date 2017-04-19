use v6;

unit module Expr;

grammar Expr::Grammar is export {
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
    token comma     { ',' }

    # Program ##
    rule TOP        { ^ <expression> $ }

    # Expresssions ##
    proto rule expression {*}
          rule expression:sym<head> { <head-expr> <line-expr>? }
          rule expression:sym<unry> { <unary-op> <expression> <line-expr>? }

    rule head-expr { <value> | <id> | <declaration> }
    rule line-expr { <binary-op> <expression> <line-expr>? }

    # Values
    rule value   { <literal> }
    rule literal { <number> | <string> | <bool> }

    # Declaration
    rule declaration { <let> <dec-list> <in> <expression> }
    rule dec-list    { <var-dec> (<comma> <var-dec>)* }
    rule var-dec     { <var> <id> <equal> <expression> }
}
