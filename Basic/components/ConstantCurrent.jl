function ConstantCurrent(; name, I=1.0)
  @named p = Pin()
  @named n = Pin()
  ps =@parameters I = I
  eqs = [
    0 ~ p.i + n.i
    I ~ p.i
  ]
  return compose(ODESystem(eqs, t, [], ps; name=name), p, n)
end