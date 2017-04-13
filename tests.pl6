use v6;

use lib "lib";

use Expr;
use Func;

say so Expr::Grammar.parse("Hallo");
say so Func::Grammar.parse("let fun id x = x in x");
