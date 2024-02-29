function Admittance(; name, G=1.0, B=1.0)
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
        G = G
        B = B
    end
    eqs = [
        va ~ p.va - n.va
        vb ~ p.vb - n.vb
        ia ~ p.ia
        ib ~ p.ib
        p.ia + n.ia ~ 0
        p.ib + n.ib ~ 0
        ia ~ _multiplyA(G, B, va, vb)
        ib ~ _multiplyB(G, B, va, vb)
        P ~ _multiplyA(va, vb, ia, -ib)
        Q ~ _multiplyB(va, vb, ia, -ib)
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end