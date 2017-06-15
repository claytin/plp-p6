use Lang::Expr;
use Lang::Expr::Value;

use Util::Env;

unit class Lang::Expr::If does Lang::Expr;

## Attributes
has Lang::Expr $.predicate;
has Lang::Expr $.then-expr;
has Lang::Expr $.else-expr;

# returns the value of the then expression, if predicate holds
# returns the value of the else expression, otherwise
method eval (Util::Environment $env?) returns Lang::Expr {
    # --
    die "Err: type error, if predicate isn't a boolean value"
        unless $.predicate.type($env) === (Bool);

    return Lang::Expr::Value.new(value => $.then-expr.eval($env).value)
        if $.predicate.eval($env).value;

    return Lang::Expr::Value.new(value => $.else-expr.eval($env).value);
}

# if is well typed if then or else expressions are well-typed, depending on
# the predicate
method well-typed (Util::Environment $env) returns Bool {
    return $.then-expr.well-typed($env) if $.predicate.eval($env).value;

    return $.else-expr.well-typed($env);
}

# the type of if is that from then or else expressions
method type (Util::Environment $env) {
    return $.then-expr.type($env) if $.predicate.eval($env).value;

    return $.else-expr.type($env);
}
