use v6;

use Expr::Grammar;

say Expr.parse("a + 'oi'");
say Expr.parse("let var x = 0 in x + x");
