function VCV(; name, gain=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e1 = Pin()
  @named e2 = Pin()
  sts = @variables begin
    u(t)=0
  end
  ps = @parameters begin
    gain = gain
  end
  eqs = [
    0 ~ p.i + n.i
    u ~ p.u - n.u
    u ~ gain * (e1.u - e2.u)
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n, e1, e2)
end