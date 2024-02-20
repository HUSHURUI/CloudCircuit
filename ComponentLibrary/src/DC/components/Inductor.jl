function Inductor(; name, L=1.0)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters begin
        L = L
    end
    sts = @variables begin
        v(t) = 1.0
        i(t) = 1.0
    end
    eqs = [
        v ~ p.v - n.v
        ∂(p.i) ~ v / L
        0 ~ p.i + n.i
        i ~ p.i
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end