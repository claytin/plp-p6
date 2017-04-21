use v6;

unit module Expr;

grammar ExprI is export {
    # Non recursive productions ##
    # Misc
    token quote  { < " ' > }

    # Literal values
    proto token literal { * }
          token literal:sym<number> { \d+ }
          token literal:sym<bool>   { true | false }
          regex literal:sym<string> { <quote> <-[ " ]>* <quote> }

    # Operators
    token oparn  { '(' } # paranthesis are a sort of operator
    token cparn  { ')' } # ...
    token uny-op { '-' | not }
    token bin-op { < - + * and or \< == ^^ > }

    ## Program ##
    rule TOP { ^ <expr> $ }

    # Expresssions ##
    proto rule expr { * }
          rule expr:sym<parn> { <oparn> <expr> <cparn> <line-expr>?}
          rule expr:sym<head> { <head-expr> <line-expr>? }
          rule expr:sym<unry> { <uny-op> <expr> <line-expr>? }

    proto rule head-expr { * }
          rule head-expr:sym<val> { <value> }

    rule line-expr { <bin-op> <expr> <line-expr>? }

    # Values
    proto rule value { * }
          rule value:sym<lit> { <literal> }

}

grammar ExprII is ExprI is export {
    # Non recursive productions ##
    token id { <[a..zA..Z]> (<number> | <[a..zA..Z]>)* }

    # Operators
    token equal { '=' }

    # Reserved keywords
    token let { let }
    token var { var }
    token in  { in }

    # Separator
    token comma { ',' }

    # Expresssions ##
    # Declaration
    rule expr:sym<dec> { <let> <dec-list> <in> <expr> }

    rule head-expr:sym<id>  { <id> }

    rule dec-list { <var-dec> (<comma> <var-dec>)* }
    rule var-dec  { <var> <id> <equal> <expr> }
}
