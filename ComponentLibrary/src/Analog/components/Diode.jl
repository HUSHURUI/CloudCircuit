"较为理想的二极管,不考虑反向击穿,IS为反向饱和电流,UT为温度电压当量"
function Diode(; name, IS = 0.0000001, UT = 0.026) #0.0000001
    @named p = Pin()
    @named n = Pin()
    ps = @parameters begin
        IS = IS  
        UT = UT
    end
    sts = @variables begin
        v(t) = 0 
    end
    eqs = [
        v ~ p.v - n.v
        0 ~ p.i + n.i 
        p.i ~ IS*(exp(v/UT)-1)
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), p, n)
end
