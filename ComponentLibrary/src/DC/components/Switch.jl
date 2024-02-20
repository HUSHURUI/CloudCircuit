using IfElse
function Switch(; name, t0=5.0)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters t0 = t0
    eqs = [
        p.v - n.v ~ p.i * ifelse(t < t0, 1.0e9, 1.0e-9)
        0 ~ p.i + n.i
    ]
    return compose(ODESystem(eqs, t, [], ps; name=name), p, n)
end