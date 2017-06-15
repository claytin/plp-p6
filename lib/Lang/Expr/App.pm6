use Lang::Expr;
use Lang::Expr::Fun;
use Lang::Expr::Value;

use Util::Env;

unit class Lang::Expr::App does Lang::Expr;

has Str $.name;
has Lang::Expr @.args;

# binds the application arguments to the correspondent function
# returns a new environment containig the function dynamic scope
method !bind-args (Util::Environment $env, Lang::Expr::Value @argv)
    returns Util::Environment {
    # --
    my Lang::Expr::Fun $f = $env.get($.name);

    unless $f.parm.elems > @.args.elems {
        $env.inc; # pushes the function dynamic scope into the environment

        loop (my $i = 0; $i < $f.parm.elems; $i++) {
            $env.bind: $f.parm[$i], @argv[$i]; # bind positional arguments
        }

        return $env;
    }

    die "Err: to few arguments for function $.name";
}

# solves the expressions wich are argumets of a function f, before passing them
method !eval-args (Util::Environment $env) returns Array of Lang::Expr::Value {
    my Lang::Expr::Value @argv; # argument value

    for @.args {
        @argv.push: Lang::Expr::Value.new(value => $_.eval($env).value);
    }

    return @argv;
}

# it's an indirection to the evaluation of a function of the same name
method eval (Util::Environment $env?) returns Lang::Expr {
    my Lang::Expr::Value @argv = self!eval-args: $env; # eval

    # apply
    my Lang::Expr::Value $value = Lang::Expr::Value.new(
        value => $env.get($.name).eval(self!bind-args($env, @argv)).value
    );

    $env.dec; # removes the function dynamic scope

    return $value;
}

# always is well-typed, for simplicity reasons
method well-typed (Util::Environment $env?) returns Bool { return True }

# the type of the application is the same as the function beeing applied
method type (Util::Environment $env?) { return $env.get($.name).type($env) }
