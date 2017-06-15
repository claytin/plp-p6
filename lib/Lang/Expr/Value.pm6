use Lang::Expr;

use Util::Env;

unit class Lang::Expr::Value does Lang::Expr;

## Attributes
has $.value;

method eval (Util::Environment $env?) returns Lang::Expr {
    return self;
}

method well-typed (Util::Environment $env?) returns Bool {
    return True;
}

method type (Util::Environment $env?) { return $.value.WHAT }
