# module Analog #这里放《模电》教材中的基本组件
using ModelingToolkit, DifferentialEquations

@variables t
∂ = Differential(t)
# end