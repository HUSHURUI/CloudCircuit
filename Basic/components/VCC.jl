function VCC(; name, transConductance=1.0)
  @named p = Pin()
  @named n = Pin()
  @named e1 = Pin()
  @named e2 = Pin()
  sts = @variables begin
    u(t)=0
  end
  ps = @parameters begin
    transConductance = transConductance
  end
  eqs = [
    0 ~ p.i + n.i
    u ~ p.u - n.u
    p.i ~ gain * (e1.u - e2.u)
  ]
  return compose(ODESystem(eqs, t,sts, ps; name=name), p, n, e1,e2)
end