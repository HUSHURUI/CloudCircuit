"理想变压器,变压器同名端同侧,N为匝数比"
function IdealTransformer(; name, N = 1)
    @named in_p = Pin()
    @named in_n = Pin()
    @named out_p = Pin()
    @named out_n = Pin()
    ps = @parameters begin
        N = N
    end
    sts = @variables begin
        v1(t) = 1
        v2(t) = 1   
    end
    eqs = [
        v1 ~ in_p.v - in_n.v
        v2 ~ out_p.v - out_n.v
        v1 ~ v2*N
		out_p.i ~ in_p.i*(-N)
		in_p.i + in_n.i ~ 0
		out_p.i + out_n.i ~ 0
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), in_p, in_n, out_p, out_n)
end
