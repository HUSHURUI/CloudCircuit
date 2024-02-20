function CCC(; name, gain=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e = Pin()
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
    p.i ~ gain * e.i
    i ~ p.i
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n, e)
end