use Util::Env;

# this is sort of an interface for the language expressions
role Lang::Expr {
    # evaluates an expression and returns as result another expression
    # an environment might be needed for the evaluation
    method eval (Util::Environment $env?) returns Lang::Expr { ... }

    # checks if the expression is well typed
    # returns true if it is, and false otherwise
    method well-typed (Util::Environment $env?) returns Bool { ... }

    # just returns the type of the expression
    method type (Util::Environment $env?) { ... }
}
