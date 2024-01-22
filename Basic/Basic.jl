module Basic#这里放《电路》教材中的基本组件

using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)

include("connectors.jl")
include("components/Resistor.jl")
include("components/ConstantVoltage.jl")
include("components/Capacitor.jl")
include("components/Ground.jl")
include("components/IdealOpAmp3pin.jl")
include("components/Transformer.jl")
include("components/CosineVoltage.jl")
include("components/IdealTransformer.jl")

export t, ∂
export Resistor
export ConstantVoltage
export Capacitor
export Ground
export Pin
export IdealOpAmp3pin
export OpAmp
export Transformer
export CosineVoltage
export IdealTransformer
end