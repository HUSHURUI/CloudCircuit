@connector function Pin(; name)
    sts = @variables begin
        v(t) = 1.0
        (i(t)=1.0, [connect = Flow])
    end
    return ODESystem(Equation[], t, sts, []; name=name)
end