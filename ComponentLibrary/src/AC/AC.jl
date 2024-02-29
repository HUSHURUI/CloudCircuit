using ModelingToolkit, DifferentialEquations
@variables t
∂ = Differential(t)
include("utils.jl")

include("components/Admittance.jl")
include("components/Generator.jl")
include("components/Ground.jl")
include("components/Load.jl")
include("components/Resistance.jl")