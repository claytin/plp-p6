use v6;

unit grammar Grammar::Expr::I;

# Non recursive productions ##
# Literal values
proto token literal { * }
      token literal:sym<number> { \d+ }
      token literal:sym<bool>   { true | false }
      token literal:sym<string> { < " ' > <-[ " ]>* < " ' > }

# Separators
token oparn { '(' }
token cparn { ')' }

# Operators ##
# Unary
proto token u-op { * }
      token u-op:sym<->   { <sym> }
      token u-op:sym<not> { <sym> }

# Binary
proto token b-op { * }
      token b-op:sym<->    { <sym> }
      token b-op:sym<+>    { <sym> }
      token b-op:sym<*>    { <sym> }
      token b-op:sym<and>  { <sym> }
      token b-op:sym<or>   { <sym> }
      token b-op:sym<\>>   { <sym> }
      token b-op:sym<'=='> { <sym> }
      token b-op:sym<^^>   { <sym> }

## Program ##
rule TOP { ^ <expr> $ }

# Expresssions ##
proto rule expr { * }
      rule expr:sym<head> { <head-expr> <line-expr>? }
      rule expr:sym<unry> { <u-op> <expr> <line-expr>? }

proto rule head-expr { * }
      rule head-expr:sym<val> { <value> }

rule line-expr { <b-op> <expr> <line-expr>? }

# Values
proto rule value { * }
      rule value:sym<lit> { <literal> }
