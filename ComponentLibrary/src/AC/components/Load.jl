function Load(; name, P=1.0, Q=1.0)
    @named p = Pin()
    sts = @variables begin
        va(t) = 1.0
        vb(t) = 1.0
        ia(t) = 1.0
        ib(t) = 1.0
    end
    ps = @parameters begin
        P = P
        Q = Q
    end
    eqs = [
        va ~ p.va
        vb ~ p.vb
        ia ~ p.ia
        ib ~ p.ib
        P ~ _multiplyA(va, vb, ia, -ib)
        Q ~ _multiplyB(va, vb, ia, -ib)
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p)
end