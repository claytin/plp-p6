use v6;

use lib "lib";

use Expr;
use Func;

# say Expr::Grammar.parse("if va then let var b = 1 in x else c");
say Func::Grammar.parse("if a then let fun id x = x in x else 5");
