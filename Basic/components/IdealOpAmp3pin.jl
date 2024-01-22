function IdealOpAmp3pin(; name)
    @named in_p = Pin()
    @named in_n = Pin()
    @named out = Pin()
    eqs = [
        in_p.v ~ in_n.v
		in_p.i ~ 0
		in_n.i ~ 0
    ]
    return compose(ODESystem(eqs, t, [], []; name=name), in_p, in_n, out)
end