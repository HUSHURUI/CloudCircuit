function VCV(; name, gain=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e1 = Pin()
  @named e2 = Pin()
  sts = @variables begin
    v(t) = 1.0
    i(t) = 1.0
  end
  ps = @parameters begin
    gain = gain
  end
  eqs = [
    0 ~ p.i + n.i
    v ~ p.v - n.v
    v ~ gain * (e1.v - e2.v)
    i ~ p.i
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n, e1, e2)
end