function Generator(; name, Va=1.0, Vb=1.0)
    @named p = Pin()
    sts = @variables begin
        ia(t) = 1.0
        ib(t) = 1.0
        P(t) = 1.0
        Q(t) = 1.0
    end
    ps = @parameters begin
        Va = Va
        Vb = Vb
    end
    eqs = [
        Va ~ p.va
        Vb ~ p.vb
        ia + p.ia ~ 0
        ib + p.ib ~ 0
        P ~ _multiplyA(Va, Vb, ia, -ib)
        Q ~ _multiplyB(Va, Vb, ia, -ib)
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p)
end