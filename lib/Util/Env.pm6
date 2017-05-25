use v6;

unit class Util::Environment;

has @!env;

# pushes an empty context (scope) into the environment
# the scope is just a hash wich will contain the corresponding bindings
submethod BUILD () { @!env.push: {} } # build is called when new it's used

# pushes a new empty scope into the environment
method inc () { @!env.push: {} }

# pops a scope from the environment
method dec () { @!env.pop }

# maps an id to a value, for the scope at the top of the environment
method bind ($id, $val) { @!env[@!env.end].push: $id => $val }

# recives an id and returns the corresponding value, if in scope
# returns the result of the lookup on the remaining scopes, otherwise
method get ($id) {
    return @!env[@!env.end]{$id} if @!env[@!env.end]{$id};

    return self!lookup: @!env[0 .. @!env.end - 1], $id;
}

# searches through all scopes, except the current one, for id
# returns its value, otherwise dies
method !lookup (@env-tail, $id) {

    for @env-tail -> %scp {
        return %scp{$id} if %scp{$id};
    }

    die "Err: Undeclared id $id";
}
