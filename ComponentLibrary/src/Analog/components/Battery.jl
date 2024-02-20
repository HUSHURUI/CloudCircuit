function Battery(; name, V=1.0)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters V = V
    eqs = [
        V ~ p.v - n.v
        0 ~ p.i + n.i
    ]
    return compose(ODESystem(eqs, t, [], ps; name=name), p, n)
end