use Grammar::Expr::II;
use Action::Expr::I;

# import of the classes representing the expressions wich can be produced by
# the Expr::II language
use Lang::Expr::Id;

use Util::Env; # an environment is needed for the evaluations of Expr::II

unit class Action::Expr::II is Action::Expr::I;

## Attributes
has Util::Environment $.env; # environment wich holds the bindings

# same as the method TOP for Expr::I, but now an environment is necessary
method TOP ($/) { make @.expr.pop.eval($.env).value }

# increments the environment with a new scope
method let ($/) { $.env.inc }

method expr0:sym<id> ($/) { @.expr.push: $<id>.made }

# when a let is matched, a scope had been resolved, and it must be removed from
# the environment
method expr0:sym<let> ($/) {
    # --
    @.expr.push: @.expr.pop.eval($.env); # the expressioni in the current scope

    $.env.dec; # remove the scope
}

# declaration match must produce a binding
# binds the last id produced with the expression on the top of the stack
method dec:sym<var> ($/) { $.env.bind: $<id>.made.name, @.expr.pop; }

# just passes up the id produced, as an object
method id ($/) { make Lang::Expr::Id.new(name => $/.Str) }
