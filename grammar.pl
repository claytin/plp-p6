use v6;

grammar PLP {
    my regex wspace { \s }

    ## Literals
    my regex number { \d+ }
    my regex string { ('"'|"'") <-[ " ]>* ('"'|"'") }
    my regex bool   { true | false }

    my regex id     { <[a..zA..Z]> (<number> | <[a..zA..Z]>)* }

    ## Operators and reserved words
    token unary-op  { '-' | not }
    token binary-op { '+' | '-' | and | or | '==' | '++'}
    token equal     { '=' }
    token let       { let }
    token var       { var }
    token in        { in }
    token fun       { fun }

    ## Program
    rule TOP        { <expression> }

    rule expression { <head-expr> <line-expr>?
                    | <unary-op> <expression> <line-expr>? }

    ## Expresssions
    rule head-expr { <value> | <id> | <declaration> }
    rule line-expr { <binary-op> <expression> <line-expr>? }

    rule value   { <literal> }
    rule literal { <number> | <string> | <bool> | <wspace> }
    rule u-expr  { <unary-op> <expression> }
    rule b-expr  { <binary-op> <expression> <line-expr> }

    # Declaration
    rule declaration    { <let> <functional-dec> <in> <expression> }
    rule functional-dec { <var-dec> | <fun-dec> }
    rule var-dec        { <var> <id> <equal> <expression> }
    rule fun-dec        { <fun> <id>+ <equal> <expression> }
}
say PLP.parse('a');

#say PLP.parse('let fun id x x = x in x');