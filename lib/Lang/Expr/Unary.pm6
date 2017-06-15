use Lang::Expr;
use Lang::Expr::Value;

use Util::Env;

unit class Lang::Expr::Unary does Lang::Expr;

## Attributes
has $.op; # operator
has Lang::Expr $.expr;

# applies the operator to the value returned by the evaluations of expr
method eval (Util::Environment $env?) returns Lang::Expr {
    # --
    die "Err: type error at unary expression" unless $.expr.well-typed($env);

    return Lang::Expr::Value.new(value => ($.op)($.expr.eval($env).value));
}

# its well-typed if its expression also is well-typed, and the type of the
# expression matches the type of the parameter expected by the operator
method well-typed (Util::Environment $env?) returns Bool {
    return $.expr.well-typed($env) &&
           $.op.signature.params[0].type === $.expr.type;
}

# the type of the expression is equal to the return type of the operator
method type () { return $.op.signature.returns }
