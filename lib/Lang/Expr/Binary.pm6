use Lang::Expr;
use Lang::Expr::Value;

use Util::Env;

unit class Lang::Expr::Binary does Lang::Expr;

## Attributes
has $.op; # operator
has Lang::Expr $.left;
has Lang::Expr $.right;

# apply the operator to the results of evaluating the expressions to the left,
# and to the right, of the operator
method eval (Util::Environment $env?) returns Lang::Expr {
    die "Err: type error for left or right expression"
        unless $.left.well-typed($env) && $.right.well-typed($env);

    return Lang::Expr::Value.new( value => ($.op)( $.left.eval($env).value
                                                 , $.right.eval($env).value ));
}

# check if left and right are well-typed, and if the type of the expressions,
# as parameters of the operator, match the operator signature
method well-typed (Util::Environment $env?) returns Bool {
    return $.left.well-typed($env) && $.right.well-typed($env) &&
           ($.left.type($env), $.right.type($env)) ~~ $.op.signature;
}

# the type of the expression is equal to the type returned by the operator
method type (Util::Environment $env?) { return $.op.signature.returns }
