function Capacitor(; name, C=1.0)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters begin
        C = C
    end
    sts = @variables begin
        v(t) = 1.0
    end
    eqs = [
        v ~ p.v - n.v
        ∂(v) ~ p.i / C
        0 ~ p.i + n.i
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end