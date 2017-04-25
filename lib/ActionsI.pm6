use v6;

use ExprI;

unit class ActionsI;

my @token;

method TOP ($/) { make @token }

method head-expr:sym<val> ($/) { @token.push('V' => $<value>.made) }

method value:sym<lit> ($/) { make $<literal>.made }

method oparn ($/) { @token.push($/.Str => Any) }
method cparn ($/) { @token.push($/.Str => Any) }

## Unary operators ##
method uny-op:sym<->   ($/) { @token.push('U' ~ $/.Str => Int) }
method uny-op:sym<not> ($/) { @token.push($/.Str => Bool) }

# Binary operators ##
method bin-op:sym<->    ($/) { @token.push('B' ~ $/.Str => Int) }
method bin-op:sym<+>    ($/) { @token.push($/.Str => Int) }
method bin-op:sym<*>    ($/) { @token.push($/.Str => Int) }
method bin-op:sym<and>  ($/) { @token.push($/.Str => Bool) }
method bin-op:sym<or>   ($/) { @token.push($/.Str => Bool) }
method bin-op:sym<\>>   ($/) { @token.push($/.Str => Int) }
method bin-op:sym<'=='> ($/) { @token.push($/.Str => Any) }
method bin-op:sym<^^>   ($/) { @token.push($/.Str => Str) }

# Basic values sinthesis ##
method literal:sym<number> ($/) { make $/.Int }
method literal:sym<bool>   ($/) { $/.Str eq "true" ?? make Bool::True
                                                   !! make Bool::False }
method literal:sym<string> ($/) { make $/.Str }
