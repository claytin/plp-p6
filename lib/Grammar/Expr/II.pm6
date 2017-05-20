use Grammar::Expr::I;

unit grammar Grammar::Expr::II is Grammar::Expr::I;

# Non recursive productions ##
token id { <[a..zA..Z]> [$<number> | <[a..zA..Z]>]* }

# Separators
token comma { ',' }

# Operators
token equal { '=' } # this is the precedence 5 operator

# Keywords
token let { let }
token var { var }
token in  { in }

# Expresssions ##
rule expr0:sym<id>  { <id> }
rule expr0:sym<dec> { <let> <dec-list> <in> <expr4> }
     # where declarations list is
     rule dec-list { <dec> +% <comma> }

# Variable declaraion ##
proto rule dec { * }
      rule dec:sym<var> { <var> <id> <equal> <expr4> }
