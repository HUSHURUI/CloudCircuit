module Basic#这里放《电路》教材中的基本组件

using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)

include("connectors.jl")
include("components/Resistor.jl")
include("components/ConstantVoltage.jl")
include("components/Capacitor.jl")
include("components/Ground.jl")
include("components/ConstantCurrent.jl")
include("components/VCC.jl")
include("components/VCV.jl")
include("components/CCC.jl")
include("components/CCV.jl")


export t, ∂
export Resistor
export ConstantVoltage
export Capacitor
export Ground
export Pin
export ConstantCurrent
export VCC
export VCV
export CCC
export CCV

end