#module Basic#这里放《电路》教材中的基本组件

using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)

include("connectors.jl")
include("components/Resistor.jl")
include("components/ConstantVoltage.jl")
include("components/CosineVoltage.jl")
include("components/Capacitor.jl")
include("components/Ground.jl")
include("components/ConstantCurrent.jl")
include("components/VCC.jl")
include("components/VCV.jl")
include("components/CCC.jl")
include("components/CCV.jl")
include("components/IdealOpAmp.jl")
include("components/IdealTransformer.jl")
include("components/RealTransformer.jl")