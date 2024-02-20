function CCV(; name, transResistance=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e = Pin()
  sts = @variables begin
    v(t) = 1.0
    i(t) = 1.0
end
  ps = @parameters begin
    transResistance = transResistance
  end
  eqs = [
    0 ~ p.i + n.i
    v ~ p.v - n.v
    v ~ transResistance * e.i
    i~p.i
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n, e)
end