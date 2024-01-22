module Analog #这里放《模电》教材中的基本组件

using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)

include("connectors.jl")
include("components/IdealOpAmp3pin.jl")
include("components/OpAmp.jl")

export t, ∂
export OpAmp
export IdealOpAmp3pin
export Ground
export Pin



end