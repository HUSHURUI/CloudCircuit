"""
$(TYPEDSIGNATURES)

A pipe port(inlet or outlet) in an pipe network.

# States:
- `p(t)`: [`Pa`] The pressure at this port
- `qm(t)`: [`kg/s`] The mass flow rate passing through this port

# Parameters:
* `T`: [`K`] The temperature of port. It'll be used in future develop.

"""
@connector function Pin(; name)
    sts = @variables v(t) = 1.0 i(t) = 1.0 [connect = Flow]
    return ODESystem(Equation[], t, sts, []; name=name)
end