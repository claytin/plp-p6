use v6;

use Grammar::Expr::I;
use Util::Eval;

unit class Action::Expr::I;

has @.val; # values stack

# just "returns" the evaluation result
method TOP ($/) { make @.val.pop }

# all expr*_:sym<rec> behave similarly;
# see Util::Evaluator for more information on sub eval
method expr4_:sym<rec> ($/) {
    # --
    try my $res = eval $<b-op4>.made, @.val;
    die "Err: type of the operands don't match for '$<b-op4>'" if $!;

    @.val.push: $res;
}

method expr3_:sym<rec> ($/) {
    # --
    try my $res = eval $<b-op3>.made, @.val;
    die "Err: type of the operands don't match for '$<b-op3>'" if $!;

    @.val.push: $res;
}

method expr2_:sym<rec> ($/) {
    # --
    try my $res = eval $<b-op2>.made, @.val;
    die "Err: type of the operands don't match for '$<b-op2>'" if $!;

    @.val.push: $res;
}

# same as binary expressions
method expr1:sym<unry> ($/) {
    # --
    try my $res = eval $<u-op>.made, @.val.pop;
    die "Err: type of the operand don't match for '$<u-op>'" if $!;

    @.val.push: $res;
}

# add the synthesized value to the values stack
method expr0:sym<val> ($/) { @.val.push: $<value>.made }

# the value is passed up on the tree
method value:sym<lit> ($/) { make $<literal>.made }

# for the following methods
# take a match object and cast them into a Perl 6 native value (object)
method literal:sym<number> ($/) { make $/.Int }
method literal:sym<bool>   ($/) { $/.Str eq 'true' ?? make Bool::True
                                                   !! make Bool::False }
method literal:sym<string> ($/) { make $/.Str.substr(1, *-1) } # no " or '

# operators are lamabdas;
# this could be way simpler, but doing so in this format embodies a powerful
# introspection mechanism (see Signature, in the Perl 6 docs)
method b-op4:sym<\>>   ($/) { make -> Any $a, Any $b --> Bool { $a > $b } }
method b-op4:sym<'=='> ($/) { make -> Any $a, Any $b --> Bool { $a == $b || $a eq $b } }

method b-op3:sym<->  ($/) { make -> Int $a, Int $b --> Int { $a - $b } }
method b-op3:sym<+>  ($/) { make -> Int $a, Int $b --> Int { $a + $b } }
method b-op3:sym<^^> ($/) { make -> Str $a, Str $b --> Str { $a ~ $b } }
method b-op3:sym<or> ($/) { make -> Bool $a, Bool $b --> Bool { $a || $b } }

method b-op2:sym<*>   ($/) { make -> Int $a, Int $b --> Int { $a * $b } }
method b-op2:sym<and> ($/) { make -> Bool $a, Bool $b --> Bool { $a && $b } }

method u-op:sym<->   ($/) { make -> Int $a --> Int { -$a } }
method u-op:sym<not> ($/) { make -> Bool $a --> Bool { !$a } }

