function Ground(; name)
    @named g = Pin()
    eqs = [
        g.v ~ 0
        # g.i ~ 0
    ]
    return compose(ODESystem(eqs, t, [], []; name=name), g)
end