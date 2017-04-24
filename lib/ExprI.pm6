use v6;

unit grammar ExprI;

# Non recursive productions ##
# Misc
token quote  { < " ' > }

# Literal values
proto token literal { * }
      token literal:sym<number> { \d+ }
      token literal:sym<bool>   { true | false }
      token literal:sym<string> { <quote> <-[ " ]>* <quote> }

# Operators ##
token oparn { '(' } # paranthesis are a sort of operator
token cparn { ')' } # ...

# Unary
proto token uny-op { * }
      token uny-op:sym<->   { <sym> }
      token uny-op:sym<not> { <sym> }

# Binary
proto token bin-op { * }
      token bin-op:sym<->    { <sym> }
      token bin-op:sym<+>    { <sym> }
      token bin-op:sym<*>    { <sym> }
      token bin-op:sym<and>  { <sym> }
      token bin-op:sym<or>   { <sym> }
      token bin-op:sym<\>>   { <sym> }
      token bin-op:sym<'=='> { <sym> }
      token bin-op:sym<^^>   { <sym> }

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
