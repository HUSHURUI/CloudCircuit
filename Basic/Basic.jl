module Basic#这里放《电路》教材中的基本组件

using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)

include("connectors.jl")
include("components/Resistor.jl")
include("components/ConstantVoltage.jl")
include("components/Capacitor.jl")
include("components/Ground.jl")

export t, ∂
export Resistor
export ConstantVoltage
export Capacitor
export Ground
export Pin

end