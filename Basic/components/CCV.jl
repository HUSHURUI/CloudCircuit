function CCV(; name, transResistance=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e = Pin()
  sts = @variables begin
    u(t) = 0
  end
  ps = @parameters begin
    transResistance = transResistance
  end
  eqs = [
    0 ~ p.i + n.i
    u ~ p.v - n.v
    u ~ transResistance * e.i
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n, e)
end