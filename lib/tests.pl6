use v6;

use lib "lib";

use ExprI; use ActionsI;

use PrcdTable; use EvalExprI;

say EvalExprI.eval(ExprI.parse('-((-10+2)*3)'
                  , :actions(ActionsI.new)).made, PrcdTable.get);
#
say ExprI.parse('a + b');
