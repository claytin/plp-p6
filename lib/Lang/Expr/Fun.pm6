use Lang::Expr;
use Lang::Expr::Value;

use Util::Env;

unit class Lang::Expr::Fun does Lang::Expr;

has Str @.parm; # paramaters
has Lang::Expr $.body;

method eval (Util::Environment $env?) returns Lang::Expr {
    return Lang::Expr::Value.new(value => $.body.eval($env).value);
}

# a functins is well-typed if its body is well-typed
method well-typed (Util::Environment $env?) returns Bool {
    return $.body.well-typed($env);
}

# type of functions will not be implement for now, just returns a lambda string
method type (Util::Environment $env) { return $.body.type($env) }
