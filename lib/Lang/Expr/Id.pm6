use Lang::Expr;
use Lang::Expr::Value;

use Util::Env;

unit class Lang::Expr::Id does Lang::Expr;

## Attributes
has Str $.name;

# the evaluation of an id is an indirection to the evaluation of the
# expression to wich it is binded to
method eval (Util::Environment $env?) returns Lang::Expr {
    return Lang::Expr::Value.new(value => $env.get($.name).eval($env).value);
}

# an id is well-typed if the expression to wich it is binded to, also is
method well-typed (Util::Environment $env?) returns Bool {
    return $env.get($.name).well-typed($env);
}

# the type of an id is the same as the type of the expression to wich it is
# binded to
method type (Util::Environment $env?) {
    return $env.get($.name).type($env);
}
