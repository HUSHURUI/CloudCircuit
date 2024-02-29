include("../src/DC/DC.jl")
include("../src/Analog/Analog.jl")
#using Plots
# 三极管 多级放大电路
begin
    @named RB1 = Resistor(; R=255000)
    @named RB21 = Resistor(; R=51000)
    @named RC2 = Resistor(; R=5100)
    @named RE1 = Resistor(; R=10000)
    @named RB22 = Resistor(; R=10000)
    @named RE2_ = Resistor(; R=100)
    @named RE2__ = Resistor(; R=1000)
    @named RL = Resistor(; R=10000)
    @named C1 = Capacitor(; C=1.0e-5)
    @named C2 = Capacitor(; C=1.0e-5)
    @named C3 = Capacitor(; C=1.0e-5)
    @named CE2 = Capacitor(; C=4.7e-5)
    @named Ui = CosineVoltage(; V=0.01, f=10)
    @named Vcc = ConstantVoltage(; V=15)
    @named T1 = NPN(;)
    @named T2 = NPN(;)
    @named G = Ground()

    connections = [
        connect(Ui.p, C1.p)
        connect(C1.n, T1.b, RB1.p)
        connect(RB1.n, T1.c, RB21.p, RC2.p, Vcc.p)
        connect(T1.e, RE1.p, C2.p)
        connect(C2.n, RB21.n, RB22.p, T2.b)
        connect(T2.c, RC2.n, C3.p)
        connect(C3.n, RL.p)
        connect(RL.n, CE2.n, RE2__.n, RB22.n, RE1.n, Ui.n, Vcc.n, G.g)
        connect(T2.e, RE2_.p)
        connect(RE2_.n, RE2__.p, CE2.p)
    ]
    @named _model = ODESystem(connections, t)
    @named model = compose(_model, [RB1, RB21, RC2, RE1, RB22, RE2_, RE2__, RL, C1, C2, C3, CE2, Ui, Vcc, T1, T2, G])

    sys = structural_simplify(model)
    u0 = [
        C1.v => 0.0
        C2.v => 0.0
        C3.v => 0.0
    ]
    tspan = (0, 2)
    prob = ODEProblem(sys, u0, tspan)
    sol = solve(prob, Rosenbrock23())
end

using Plots

plot(sol[t], sol[Ui.p.v])
plot!(sol[t][160:end], sol[Ui.p.v][160:end])