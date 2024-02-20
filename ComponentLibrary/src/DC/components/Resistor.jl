function Resistor(; name, R=1.0)
    @named p = Pin()
    @named n = Pin()
    sts = @variables begin
        v(t) = 1.0
        i(t) = 1.0
    end
    ps = @parameters R = R
    eqs = [
        p.v - n.v ~ p.i * R
        0 ~ p.i + n.i
        v ~ p.v - n.v
        i ~ p.i
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end