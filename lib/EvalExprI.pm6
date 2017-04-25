unit class EvalExprI;

method !compat ($op, @operand) {
    if @operand.elems > 1 {
        return @operand[0].value.WHAT === @operand[1].value.WHAT &&
               @operand[0].value.WHAT === $op.value &&
               @operand[1].value.WHAT === $op.value;
    } else {
        return @operand[0].value.WHAT === $op.value;
    }
}

method !apply ($op, @operand) {
    die "Err: types do not match in expression"
        unless self.compat($op, @operand);

    given $op.key {
        when '+'   { return 'V' => @operand[0].value + @operand[1].value }
        when 'B-'  { return 'V' => @operand[0].value - @operand[1].value }
        when '*'   { return 'V' => @operand[0].value * @operand[1].value }
        when '^^'  { return 'V' => @operand[0].value ~ @operand[1].value }
        when '=='  { return 'V' => @operand[0].value == @operand[1].value }
        when '>'   { return 'V' => @operand[0].value > @operand[1].value }
        when 'and' { return 'V' => @operand[0].value && @operand[1].value }
        when 'or'  { return 'V' => @operand[0].value || @operand[1].value }
        when 'U-'  { return 'V' => -@operand[0].value }
        when 'or'  { return 'V' => !@operand[0].value }
    }
}

method eval (@tkstream, %prcd) {
    my Str $flux = "";
    my @wrk;    # working stack, it holds the values been resolved
    my @reduce; # values resolved or already applied

    @wrk.push('$' => Nil);
    @tkstream.push('$' => Nil);
    $flux = "init";

    say @tkstream.head.key;

    until @tkstream.elems == @wrk.elems == 1 &&
          @tkstream.head.key eq @wrk.head.key eq '$' {

               # my $tk = @tkstream.shift if @tkstream.head.key ne '$';
          my $tk = @tkstream.head.key ne '$' ?? @tkstream.shift
                                             !! '$' => Nil;

        if %prcd{@wrk[@wrk.end].key}{$tk.key} === Less {
            @wrk.push($tk);
            $flux~= ", push(P)";
        } else {
            while %prcd{@wrk[@wrk.end].key}{$tk.key} === More {
                my $aux = @wrk.pop;

                $flux ~= ", pop(P)";
                if $aux.key eq 'V' {
                    @reduce.push($aux);
                    $flux ~= ", push(R)";
                } elsif $aux.key ne ')' && $aux.key ne '(' {
                    my @operand;

                    @operand.push(@reduce.pop);
                    @operand.push(@reduce.pop) if $aux.key ne 'U-' &&
                                                  $aux.key ne 'not' ;

                    @reduce.push(self.apply($aux, @operand));
                    $flux ~= ", (apply & push(R))";
                }
            }

            @wrk.push($tk);
        }
        say $flux; $flux = "";
        say @tkstream, " <> ", @wrk;
    }

    return @reduce.pop;
}