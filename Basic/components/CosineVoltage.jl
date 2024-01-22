"V代表幅值,phase代表初相位,f代表频率"
function CosineVoltage(; name, V=1.0, phase=0, f = 50)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters  begin
		V = V
		phase = phase
		f = f
	end
    eqs = [
	   V*cos(2*pi*f*t + phase) ~ p.v - n.v
        0 ~ p.i + n.i
    ]
    return compose(ODESystem(eqs, t, [], ps; name=name), p, n)
end