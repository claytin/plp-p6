use v6;

use Grammar::Expr::I;

unit class Action::Expr::I;

has @!val; # stack of values

# private method wich checks if the types of the val are compatible
# $op: operator, $p1, $p2: parameters one and two (optional)
method !compat ($op, $p1, $p2?) returns Bool {
    # for binary functions checks if the signatures match;
    # when unary, check if the type of the parameter is the expected
    # the same method doesn't work for both
    return ($p1, $p2) ~~ $op.signature ||
           ($p1).WHAT === $op.signature.params[0].type;
}

# just "returns" the evaluation result
method TOP ($/) { make @!val.pop }

# FOR ALL expr*_:sym<rec> methods
# they all behave similarly, they call !compat for type checking and if those
# are compatible, proceed to apply the correspondent operator (*-opN for exprN)
method expr4_:sym<rec> ($/) {
    if self!compat($<b-op4>.made, @!val[@!val.end], @!val[@!val.end - 1]) {

        # these pops grant the correct order of the parameters
        my $p2 = @!val.pop;
        my $p1 = @!val.pop;

        # apply the operator
        @!val.push(($<b-op4>.made)($p1, $p2));
    } else {
        die "Err: type of the operands don't match for '$<b-op4>'";
    }
}

method expr3_:sym<rec> ($/) {
    if self!compat($<b-op3>.made, @!val[@!val.end], @!val[@!val.end - 1]) {

        my $p2 = @!val.pop;
        my $p1 = @!val.pop;

        @!val.push(($<b-op3>.made)($p1, $p2));
    } else {
        die "Err: type of the operands don't match for '$<b-op3>'";
    }
}

method expr2_:sym<rec> ($/) {
    if self!compat($<b-op2>.made, @!val[@!val.end], @!val[@!val.end - 1]) {

        my $p2 = @!val.pop;
        my $p1 = @!val.pop;

        @!val.push(($<b-op2>.made)($p1, $p2));
    } else {
        die "Err: type of the operands don't match for '$<b-op2>'";
    }
}

# same as binary expressions
method expr1:sym<unry> ($/) {
    if self!compat($<u-op>.made, @!val[@!val.end]) {
        @!val.push(($<u-op>.made)(@!val.pop));
    } else {
        die "Err: type of the operands don't match for '$<u-op>'";
    }
}

# add the synthesized value to the values stack
method expr0:sym<val> ($/) { @!val.push($<value>.made) }

# the value is passed up on the tree
method value:sym<lit> ($/) { make $<literal>.made }

# the following methods take a match object and cast them into a Perl 6 native
# value (object)
method literal:sym<number> ($/) { make $/.Int }
method literal:sym<bool>   ($/) { $/.Str eq 'true' ?? make Bool::True
                                                   !! make Bool::False }
method literal:sym<string> ($/) { make $/.Str.substr(1,*-1) } # no " or '

# operators are lamabdas;
# this could be way simpler, but doing so in this format embodies a powerful
# introspection mechanism (see Perl 6 docs for Signature)
method b-op4:sym<\>>   ($/) { make -> Any $a, Any $b --> Bool { $a > $b } }
method b-op4:sym<'=='> ($/) { make -> Any $a, Any $b --> Bool { $a == $b } }

method b-op3:sym<->  ($/) { make -> Int $a, Int $b --> Int { $a - $b } }
method b-op3:sym<+>  ($/) { make -> Int $a, Int $b --> Int { $a + $b } }
method b-op3:sym<^^> ($/) { make -> Str $a, Str $b --> Str { $a ~ $b } }
method b-op3:sym<or> ($/) { make -> Bool $a, Bool $b --> Bool { $a || $b } }

method b-op2:sym<*>   ($/) { make -> Int $a, Int $b --> Int { $a * $b } }
method b-op2:sym<and> ($/) { make -> Bool $a, Bool $b --> Bool { $a && $b } }

method u-op:sym<->   ($/) { make -> Int $a --> Int { -$a } }
method u-op:sym<not> ($/) { make -> Bool $a --> Bool { !$a } }

