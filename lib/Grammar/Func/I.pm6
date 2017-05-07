use Grammar::Expr::II;

unit grammar Grammar::Func::I is Grammar::Expr::II;

token fun  { fun }
token if   { if }
token then { then }
token else { else }

# Expresssions ##
rule expr:sym<app> { <id> <oparn> <expr-list> <cparn> }
rule expr:sym<if>  { <if> <expr> <then> <expr> <else> <expr> }

rule expr-list { <expr> +% <comma> }

# Declaration ##
rule functional-dec { <fun-dec> | <var-dec> }

# Function
rule fun-dec { <fun> <id> <params> <equal> <expr> }
rule params  { <id> <id>* }

rule dec-list { <functional-dec> +% <comma> }
