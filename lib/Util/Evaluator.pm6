use v6;

unit module Evaluator;

# checks if the types of the parameters are compatible, and if they match the
# operator signature;
#
# $op: operator, $p1, $p2: parameters one and two
multi sub typeCheck ($op, $p1, $p2) returns Bool {
    return ($p1, $p2) ~~ $op.signature # check if the signatures match
}

# $op: operator, $p: parameter
multi sub typeCheck ($op, $p) returns Bool {
    # explicitly checks if the parameter type matches the one from operator
    return ($p).WHAT === $op.signature.params[0].type;
}

# evaluates binary applications
#
# $op: operator; @val: the stack from where the values will be retrieved
multi sub eval ($op, @val) is export {
    if typeCheck($op, @val[@val.end], @val[@val.end - 1]) {

        # these pops grant the correct order of the parameters
        my $p2 = @val.pop;
        my $p1 = @val.pop;

        # apply the operator
        return ($op)($p1, $p2);
    }

    return Nil;
}

# evaluates unary applications
#
# $op: operator; $val: value wich $op will be aplied to
multi sub eval ($op, $val) is export {
    return ($op)($val) if typeCheck $op, $val;

    return Nil;
}
