# module Digital #这里放《数电》教材中的基本组件
using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)
# end