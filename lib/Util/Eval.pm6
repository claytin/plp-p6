use v6;

unit module Evaluator;

# checks if the types of the parameters are compatible, and if they match the
# operator signature;
#
# $op: operator, $p1, $p2: parameters one and two
multi sub type-check ($op, $p1, $p2) returns Bool {
    return False unless $p1.WHAT === $p2.WHAT;

    return ($p1, $p2) ~~ $op.signature # check if the signatures match
}

# $op: operator, $p: parameter
multi sub type-check ($op, $p) returns Bool {
    # explicitly checks if the parameter type matches the one from operator
    return $p.WHAT === $op.signature.params[0].type;
}

multi sub type-check ($p) returns Bool { return $p.WHAT === (Bool) }
# evaluates binary applications
#
# $op: operator; @val: the stack from where the values will be retrieved
multi sub eval ($op, @val) is export {
    if type-check($op, @val[@val.end - 1], @val[@val.end]) {

        # these pops grant the correct order of the parameters
        my $p2 = @val.pop;
        my $p1 = @val.pop;

        # apply the operator
        return ($op)($p1, $p2);
    }

    return Failure;
}

# evaluates unary applications
#
# $op: operator; $val: value wich $op will be aplied to
multi sub eval ($op, $val) is export {
    return ($op)($val) if type-check $op, $val;

    return Failure;
}

multi sub eval (@val) is export {
    my $else-value = @val.pop;
    my $then-value = @val.pop;
    my $predicate  = @val.pop;

    if type-check($predicate) {
        $predicate ?? return $then-value !! return $else-value;
    }

    return Failure;
}
