use v6;

unit grammar Grammar::Expr::I;

## Non recursive productions ##
# Literals ##
proto token literal { * }
      token literal:sym<number> { \d+ }
      token literal:sym<bool>   { true | false }
      token literal:sym<string> { < " ' > <-[ " ]>* < " ' > }

# Separators ##
token oparn { '(' }
token cparn { ')' }

# Operators ##
# separated by precedence, loosest-tightest
# Binary
proto token b-op4 { * }
      token b-op4:sym<\>> { <sym> }
      token b-op4:sym<==> { <sym> }

proto token b-op3 { * }
      token b-op3:sym<->  { <sym> }
      token b-op3:sym<+>  { <sym> }
      token b-op3:sym<^^> { <sym> }
      token b-op3:sym<or> { <sym> }

proto token b-op2 { * }
      token b-op2:sym<*>   { <sym> }
      token b-op2:sym<and> { <sym> }

# Unary
# these are the tightests precedence (1) operators
proto token u-op { * }
      token u-op:sym<->   { <sym> }
      token u-op:sym<not> { <sym> }

## Program ##
rule TOP { ^ <expr4> $ }

# Expresssions ##
# the following expressions could have been written in a better fashion, still
# they represent the left recursion removal explicitly, wich is nice
rule expr4 { <expr3> <expr4_> }
proto rule expr4_ { * }
      rule expr4_:sym<rec> { <b-op4> <expr4> <expr4_> }
      rule expr4_:sym<eps> { {} } # eps stands for epsilon (empty production)

rule expr3 { <expr2> <expr3_> }
proto rule expr3_ { * }
      rule expr3_:sym<rec> { <b-op3> <expr3> <expr3_> }
      rule expr3_:sym<eps> { {} }

rule expr2 { <expr1> <expr2_> }
proto rule expr2_ { * }
      rule expr2_:sym<rec> { <b-op2> <expr2> <expr2_> }
      rule expr2_:sym<eps> { {} }

proto rule expr1 { * }
      rule expr1:sym<unry> { <u-op> <expr0> }
      rule expr1:sym<fin>  { <expr0> }

proto rule expr0 { * }
      rule expr0:sym<parn> { <oparn> <expr4> <cparn> }
      rule expr0:sym<val>  { <value> }

# Values
proto rule value { * }
      rule value:sym<lit> { <literal> }
