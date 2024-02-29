@connector function Pin(; name)
    sts = @variables begin
        va(t) = 1.0
        vb(t) = 1.0
        (ia(t)=1.0, [connect = Flow])
        (ib(t)=1.0, [connect = Flow])
    end
    return ODESystem(Equation[], t, sts, []; name=name)
end


function _multiplyA(a1, b1, a2, b2)
    return a1 * a2 - b1 * b2
end

function _multiplyB(a1, b1, a2, b2)
    return a2 * b1 + a1 * b2
end
