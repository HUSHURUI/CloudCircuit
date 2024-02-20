using ComponentLibrary
using ComponentLibrary.DC
using ModelingToolkit, DifferentialEquations
using Plots
# 一阶动态电路
@named R1 = Resistor(; R=2)
@named R2 = Resistor(; R=2)
@named R3 = Resistor(; R=4)
@named R4 = Resistor(; R=2)
@named R5 = Resistor(; R=2)
@named R6 = Resistor(; R=2)
@named R7 = Resistor(; R=2)
@named R8 = Resistor(; R=4)
@named R9 = Resistor(; R=2)
@named Is5 = ConstantCurrent(; I=4)
@named Us1 = ConstantVoltage(; V=12)
@named Us2 = ConstantVoltage(; V=12)
@named Us6 = ConstantVoltage(; V=12)
@named Us9 = ConstantVoltage(; V=12)
@named CCC = CCC(; gain=2)
@named VCC = VCC(; transConductance=2)
@named G = Ground()

connections = [
    connect(CCC.p, R1.p, R7.p, R9.p)
    connect(R9.n, Us9.p)
    connect(R7.n, R8.p, R2.p)
    connect(Us9.n, R8.n, R3.p, VCC.p)
    connect(R2.n, Us2.p)
    connect(Us2.n, R4.p, R5.p, Is5.p, Us6.n)
    connect(Is5.n, R5.n, R3.n, VCC.n)
    connect(R1.n, Us1.p)
    connect(CCC.n, Us1.n, R4.n, R6.p, G.g)
    connect(R6.n, Us6.p)
]
@named _model = ODESystem(connections, t)
@named model = compose(_model, [R1, R2, R3, R4, R5, R7, R8, R9, Is5, Us1, Us2, Us6, Us9, CCC, VCC, G])
sys = structural_simplify(model)
u0 = []
tspan = (0, 10.0)#试一下步长
prob = ODAEProblem(sys, u0, tspan)
sol = solve(prob, Tsit5())
sol[R1.p.v]
plot(sol[t], sol[R1.v])