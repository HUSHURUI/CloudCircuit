@connector function Pin(; name)
    sts = @variables begin
        v(t) = 1.0
    end
    return ODESystem(Equation[], t, sts, []; name=name)
end