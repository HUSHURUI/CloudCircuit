"L1对应原边,L2对应副边,变压器同名端同侧,注意此模型当L1*L2=M^2时无效"
function Transformer(; name, L1=1, L2=1, M=1)
    @named in_p = Pin()
    @named in_n = Pin()
    @named out_p = Pin()
    @named out_n = Pin()
    ps = @parameters begin
        L1 = L1
        L2 = L2
		M = M
    end
    sts = @variables begin
        v1(t) = 10
        v2(t) = 10   
    end
    eqs = [
        v1 ~ in_p.v - in_n.v
        v2 ~ out_p.v - out_n.v
        ∂(in_p.i) ~ (v1*L2 - v2*M) / (L1*L2 - M*M)
        ∂(out_p.i) ~ (v2*L1 - v1*M) / (L1*L2 - M*M)
		in_p.i + in_n.i ~ 0
		out_p.i + out_n.i ~ 0
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), in_p, in_n, out_p, out_n)
end


# in(t) = 1
# out(t) = 1
# in ~ ∂(in_p.i)
# out ~ ∂(out_p.i)
# v1 ~ L1*in + M*out
# v2 ~ L2*out + M*in
# ∂(in_p.i) ~ (v1*L2 - v2*M) / (L1*L2 - M*M)
# ∂(out_p.i) ~ (v2*L1 - v1*M) / (L1*L2 - M*M)