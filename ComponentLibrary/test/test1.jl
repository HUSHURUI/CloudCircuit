include("../src/DC/DC.jl")
#using Plots
# 一阶动态电路 带开关
@named R1 = Resistor(; R=2)
@named R2 = Resistor(; R=2)
@named R3 = Resistor(; R=4)
@named R4 = Resistor(; R=2)
@named R5 = Resistor(; R=2)
@named Is = ConstantCurrent(; I=4)
@named Us = ConstantVoltage(; V=12)
@named C1 = Capacitor(; C=0.5)
@named L1 = Inductor(; L=0.1)
@named SW = Switch(; t0=10)
@named G = Ground()

connections = [
    connect(Is.n, R1.n, L1.n, SW.n, Us.n, C1.n, G.g)
    connect(Is.p, R1.p, R2.p)
    connect(R2.n, L1.p, R3.p)
    connect(R3.n, SW.p, R4.p, R5.p)
    connect(R5.n, C1.p)
    connect(R4.n, Us.p)
]
@named _model = ODESystem(connections, t)
@named model = compose(_model, [R1, R2, R3, R4, R5, C1, L1, Is, Us, SW, G])
sys = structural_simplify(model)
u0 = [
    C1.v => 0.0
    L1.i => 0.0
]
tspan = (0, 20.0)
prob = ODEProblem(sys, u0, tspan)
sol = solve(prob, Rodas4())
sol[C1.v]
sol[R1.n.v]
sol[C1.p.v]
plot(sol[t], sol[C1.v])