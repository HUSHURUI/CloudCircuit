"NPN型三极管,应用EM模型,Is为晶体管饱和电流"
function NPN(; name, Is = 1e-14, Icbo = 1e-14/0.96, Iebo = 1e-14/0.996, Vt =0.026) 
    @named c = Pin()
    @named b = Pin()
    @named e = Pin()
    ps = @parameters begin
        Is = Is  # Transistor saturation current
        Icbo  = Icbo 
        Iebo = Iebo
        Vt = Vt  # Voltage equivalent of temperature
    end
    sts = @variables begin
        vbc(t) = 0 
        vbe(t) = 0 
    end
    eqs = [
        vbc ~ b.v - c.v
        vbe ~ b.v - e.v
        0 ~ c.i + b.i + e.i
        e.i ~ -Iebo*(exp(vbe/Vt)-1) + Is*(exp(vbc/Vt)-1)
        c.i ~ -Icbo*(exp(vbc/Vt)-1) + Is*(exp(vbe/Vt)-1)
    ]
    return compose(ODESystem(eqs, t, sts, ps; name=name), c, b, e)
end
