use Grammar::Expr::I; # correspondent grammar

# import of the classes representing the expressions wich can be produced by
# the Expr::I language
use Lang::Expr::Value;
use Lang::Expr::Unary;
use Lang::Expr::Binary;

unit class Action::Expr::I;

## Attributes
has @.expr; # expressions stack

# call the avaluation method for the expression on the top of the stack
# "returns" the evaluation result
method TOP ($/) { make @.expr.pop.eval.value }

# all expr*_:sym<rec> behave similarly;
# they create an expression object, correspondent to the productions match,
# and push it into the expressions stack
method expr4_:sym<rec> ($/) {
    # --
    @.expr.push: Lang::Expr::Binary.new( op    => $<b-op4>.made
                                       , right => @.expr.pop
                                       , left  => @.expr.pop );
}

method expr3_:sym<rec> ($/) {
    # --
    @.expr.push: Lang::Expr::Binary.new( op    => $<b-op3>.made
                                       , right => @.expr.pop
                                       , left  => @.expr.pop );
}

method expr2_:sym<rec> ($/) {
    # --
    @.expr.push: Lang::Expr::Binary.new( op    => $<b-op2>.made
                                       , right => @.expr.pop
                                       , left  => @.expr.pop );
}

# same as the binary expressions
method expr1:sym<unry> ($/) {
    # --
    @.expr.push: Lang::Expr::Unary.new( op   => $<u-op>.made
                                      , expr => $.expr.pop);
}

method expr0:sym<val> ($/) {
    @.expr.push: Lang::Expr::Value.new(value => $<value>.made);
}

# the value is passed up on the tree
method value:sym<lit> ($/) { make $<literal>.made }

# for the following methods literal:sym*
# take a match object and cast them into a Perl 6 native value (object)
method literal:sym<number> ($/) { make $/.Int }
method literal:sym<bool>   ($/) { $/.Str eq 'true' ?? make Bool::True
                                                   !! make Bool::False }
method literal:sym<string> ($/) { make $/.Str.substr(1, *-1) } # no " or '

# operators are lamabdas;
# these definitions could be way shorter, but doing so in this format embodies
# a powerful introspection mechanism (see the Perl 6 docs for Signature)
method b-op4:sym<\>> ($/) { make -> Any $a, Any $b --> Bool { $a > $b } }
method b-op4:sym<==> ($/) {
    # --
    make -> Any $a, Any $b --> Bool {
        if $a.WHAT === (Int) {$a == $b} else {$a eq $b}
    }
}

method b-op3:sym<->  ($/) { make -> Int $a, Int $b --> Int { $a - $b } }
method b-op3:sym<+>  ($/) { make -> Int $a, Int $b --> Int { $a + $b } }
method b-op3:sym<^^> ($/) { make -> Str $a, Str $b --> Str { $a ~ $b } }
method b-op3:sym<or> ($/) { make -> Bool $a, Bool $b --> Bool { $a || $b } }

method b-op2:sym<*>   ($/) { make -> Int $a, Int $b --> Int { $a * $b } }
method b-op2:sym<and> ($/) { make -> Bool $a, Bool $b --> Bool { $a && $b } }

method u-op:sym<->   ($/) { make -> Int $a --> Int { -$a } }
method u-op:sym<not> ($/) { make -> Bool $a --> Bool { !$a } }

