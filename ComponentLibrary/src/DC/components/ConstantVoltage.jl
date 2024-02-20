function ConstantVoltage(; name, V=1.0)
    @named p = Pin()
    @named n = Pin()
    sts = @variables begin
        v(t) = 1.0
        i(t) = 1.0
    end
    ps = @parameters V = V
    eqs = [
        v ~ V
        V ~ p.v - n.v
        0 ~ p.i + n.i
        i ~ p.i
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end