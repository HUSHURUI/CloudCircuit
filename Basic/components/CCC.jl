function CCC(; name, gain=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e = Pin()
  sts = @variables begin
    u(t)=0
  end
  ps = @parameters begin
    gain = gain
  end
  eqs = [
    0 ~ p.i + n.i
    u ~ p.u - n.u
    p.i ~ gain * e.i
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n, e)
end