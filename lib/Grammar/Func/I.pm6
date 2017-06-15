use Grammar::Expr::II;

unit grammar Grammar::Func::I is Grammar::Expr::II;

# Keywords
token fun  { fun }
token if   { if }
token then { then }
token else { else }

# Expresssions ##
rule expr0:sym<if>  { <if> <predicate> <then> <if-expr> <else> <else-expr> }
     # with aliases
     rule predicate { <expr4> }
     rule if-expr   { <expr4> }
     rule else-expr { <expr4> }

rule expr0:sym<app> { <id> <oparn> <expr-list> <cparn> } # function application
     # wich has arguments
     rule expr-list { <expr4> +% <comma> }

# Function declaration ##
rule dec:sym<fun> { <fun> <id> <params> <equal> <expr4> }
     # wich has parameters
     rule params { <id> + } # the space between <id> and + is necessary
