include("../src/DC/DC.jl")
include("../src/Analog/Analog.jl")
#using Plots
# 运放+二极管 文氏桥
begin
    @named R1 = Resistor(; R=47000)
    @named R2 = Resistor(; R=47000)
    @named R3 = Resistor(; R=10000)
    @named R4 = Resistor(; R=30000)
    @named R5 = Resistor(; R=47000)
    @named A = IdealOpAmp(;)
    @named D1 = Diode(;)
    @named D2 = Diode(;)
    @named C1 = Capacitor(; C=1e-7)
    @named C2 = Capacitor(; C=1e-7)
    @named G = Ground()

    connections = [
        connect(R2.n, C2.n, R3.n, G.g)
        connect(R2.p, C2.p, R1.p, A.in_p)
        connect(R1.n, C1.p)
        connect(C1.n, A.out, R4.n, D1.p, D2.n)
        connect(R3.p, A.in_n, R4.p, R5.p)
        connect(R5.n, D1.n, D2.p)
    ]
    @named _model = ODESystem(connections, t)
    @named model = compose(_model, [R1, R2, R3, R4, R5, C1, C2, D1, D2, A, G])
end
sys = structural_simplify(model)
begin
    u0 = []
    tspan = (0, 2.0)
    prob = ODEProblem(sys, u0, tspan)
    sol = solve(prob, Rodas4())
end
using Plots
sol[R1.p.v]
plot(sol[t], sol[A.out.v])