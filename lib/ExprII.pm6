use ExprI;

unit grammar ExprII is ExprI;

# Non recursive productions ##
token id { <[a..zA..Z]> [$<number> | <[a..zA..Z]>]* }

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