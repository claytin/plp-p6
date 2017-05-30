use v6;

use Grammar::Expr::II;
use Action::Expr::I;

use Util::Evaluator;

unit class Action::Expr::II is Action::Expr::I;

has $.env;  # environment wich holds the bindings

# increments the environment with a new scope
method let ($/) { $.env.inc }

# sets the flag var; the next id is expected to be a variable name
# looks fo the id value in the environment and prepares it to be used
method expr0:sym<id> ($/) { @.val.push: $.env.get($<id>.made) }

# when let is matched all the subproductions (expressions) has been resolveed
# the scope should be removed from the environment
method expr0:sym<let> ($/) { $.env.dec }

# declaration match must produce a binding
method dec:sym<var> ($/) { $.env.bind: $<id>.made, @.val.pop }

# just passes up the id produced
method id ($/) { make $/.Str }
