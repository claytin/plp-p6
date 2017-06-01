use v6;

use Grammar::Func::I;
use Action::Expr::II;

use Util::Eval;

unit class Action::Func::I is Action::Expr::II;

method fun ($/) { $.env.inc }

method expr0:sym<if> ($/) {
    # --
    try my $res = eval @.val;
    die "Err: type of the operands don't match for 'if'" if $!;

    @.val.push: $res;
}
