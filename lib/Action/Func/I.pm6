use v6;

use Grammar::Func::I;
use Action::Expr::II;

use Util::Eval;

unit class Action::Func::I is Action::Expr::II;

method fun ($/) { $.env.inc }

method expr0:sym<if> ($/) {
    # --
    die "Err: type of the operands don't match for '" ~ $/.Str ~ "'"
        if (my $res = eval $<b-op4>.made, @.val) ~~ Nil;

    @.val.push: $res;
}
