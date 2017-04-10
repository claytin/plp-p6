use v6.c;

grammar PLP::Grammar {
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
    token fun       { fun }

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
    rule declaration    { <let> <functional-dec> <in> <expression> }
    rule functional-dec { <var-dec> | <fun-dec> }
    rule var-dec        { <var> <id> <equal> <expression> }
    rule fun-dec        { <fun> <id> <id>* <equal> <expression> }
}

say PLP::Grammar.parse("'aloha'");
say PLP::Grammar.parse("let fun id x = x in x");
say PLP::Grammar.parse("let var b = 0 in let fun pi = 31416 in x");
