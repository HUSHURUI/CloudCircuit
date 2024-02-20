function ConstantCurrent(; name, I=1.0)
  @named p = Pin()
  @named n = Pin()
  sts = @variables begin
    v(t) = 1.0
    i(t) = 1.0
  end
  ps = @parameters I = I
  eqs = [
    0 ~ p.i + n.i
    I ~ p.i
    v ~ p.v - n.v
    i ~ I
  ]
  return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end