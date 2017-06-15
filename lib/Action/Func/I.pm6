use v6;

use Grammar::Func::I;
use Action::Expr::II;

use Lang::Expr::If;
use Lang::Expr::Fun;
use Lang::Expr::App;

unit class Action::Func::I is Action::Expr::II;

method fun ($/) { $.env.inc }

method expr0:sym<if> ($/) {
    # --
    @.expr.push: Lang::Expr::If.new( else-expr => @.expr.pop
                                   , then-expr => @.expr.pop
                                   , predicate => @.expr.pop );
}

method expr0:sym<app> ($/) {
    my Lang::Expr @rev; # revesre expressions list

    for $<expr-list><expr4> { @rev.push: @.expr.pop }

    @.expr.push: Lang::Expr::App.new( name => $<id>.made.name
                                    , args => @rev.reverse );
}

method dec:sym<fun> ($/) {
    my Str @parm;

    my Lang::Expr $body = @.expr.pop; # the expression on top of the stack
                                      # corresponds to the funtion body

    for $<params><id> { @parm.push: $_.Str } # this ids are not expressions
                                             # only place holders

    $.env.bind: $<id>.made.name, Lang::Expr::Fun.new( parm => @parm
                                                    , body => $body );
}
