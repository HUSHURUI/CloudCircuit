function Ground(; name)
    @named g = Pin()
    eqs = [
        g.va ~ 0
        g.vb ~ 0
    ]
    return compose(ODESystem(eqs, t, [], []; name=name), g)
end