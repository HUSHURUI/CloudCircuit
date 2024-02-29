include("../src/DC/DC.jl")
include("../src/Analog/Analog.jl")
#using Plots
# 三极管+电感 文氏桥
begin
    @named R1 = Resistor(; R=51000)
    @named R2 = Resistor(; R=15000)
    @named R3 = Resistor(; R=510)
    @named C1 = Capacitor(; C=0.09)
    @named C2 = Capacitor(; C=0.09)
    @named C3 = Capacitor(; C=0.09)
    @named L1 = Inductor(; L=1)
    @named L2 = Inductor(; L=1.5)
    @named Q = NPN(;)
    @named Us = ConstantVoltage(; V=5)
    @named G = Ground()

    connections = [
        connect(C3.p, C1.p, L2.p)
        connect(C3.n, R2.p, R1.p, Q.b)
        connect(Q.c, C1.n, L1.p)
        connect(R1.n, Us.p, L1.n, L2.n)
        connect(Q.e, R3.p, C2.p)
        connect(R3.n, C2.n, R2.n, G.g, Us.n)
    ]
    @named _model = ODESystem(connections, t)
    @named model = compose(_model, [R1, R2, R3, C1, C2, C3, L1, L2, Q, Us, G])

    sys = structural_simplify(model)

    u0 = [
        C1.v => 0.0
        C2.v => 0.0
        C3.v => 0.0
        L1.i => 0.0
        L2.i => 0.0
    ]
    tspan = (0, 10)
    prob = ODEProblem(sys, u0, tspan)
    sol = solve(prob, Rodas4(),dt=0)
end
using Plots
sol[R1.p.v]
plot(sol[t], sol[C1.v])