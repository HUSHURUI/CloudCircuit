function Resistance(; name, R=1.0, X=1.0)
    @named p = Pin()
    @named n = Pin()
    sts = @variables begin
        va(t) = 1.0
        vb(t) = 1.0
        ia(t) = 1.0
        ib(t) = 1.0
        P(t) = 1.0
        Q(t) = 1.0
    end
    ps = @parameters begin
        R = R
        X = X
    end
    eqs = [
        va ~ p.va - n.va
        vb ~ p.vb - n.vb
        ia ~ p.ia
        ib ~ p.ib
        p.ia + n.ia ~ 0
        p.ib + n.ib ~ 0
        va ~ _multiplyA(R, X, ia, ib)
        vb ~ _multiplyB(R, X, ia, ib)
        P ~ _multiplyA(va, vb, ia, -ib)
        Q ~ _multiplyB(va, vb, ia, -ib)
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end