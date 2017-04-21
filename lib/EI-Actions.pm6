use Expr;

unit module EI-Actions;

class ActionsI is export {
    my Any @token;
    my Any @value;

    method TOP ($/) { make @token }

    method value:sym<lit> ($/) { @token.push($<literal>.made => "V") }

    method literal:sym<number> ($/) { make $/.Int }
    method literal:sym<bool>   ($/) { make $/.Str }
    method literal:sym<string> ($/) { make $/.Str }

    # method bool   ($/) { $full-expr = $/.Str eq "true" ?? True !! False }
    # method string ($/) { $full-expr = $/.Str }
}
