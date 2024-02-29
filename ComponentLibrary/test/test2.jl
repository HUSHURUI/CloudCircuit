include("../src/DC/DC.jl")
#using Plots
# 直流受控源 带RLC欠阻尼
begin
    @named R1 = Resistor(; R=2)
    @named R2 = Resistor(; R=2)
    @named R3 = Resistor(; R=4.5)
    @named R4 = Resistor(; R=5)
    @named R5 = Resistor(; R=6)
    @named R6 = Resistor(; R=2.5)
    @named R7 = Resistor(; R=1.5)
    @named R8 = Resistor(; R=0.1)
    @named R9 = Resistor(; R=2.5)
    @named Is5 = ConstantCurrent(; I=4)
    @named Us1 = ConstantVoltage(; V=32)
    @named Us2 = ConstantVoltage(; V=16)
    @named Us6 = ConstantVoltage(; V=16)
    @named Us9 = ConstantVoltage(; V=8)
    @named C1 = Capacitor(; C=0.7)
    @named C2 = Capacitor(; C=0.1)
    @named L1 = Inductor(; L=6)
    @named Cs = VCC(; transConductance=2.5)
    @named G = Ground()

    connections = [
        R6.p.v ~ Cs.e1.v
        R6.n.v ~ Cs.e2.v
        connect(R1.p, R7.p, R9.p)
        connect(R9.n, Us9.p)
        connect(R7.n, R8.p, R2.p)
        connect(R8.n, L1.p)
        connect(L1.n, C2.p)
        connect(Us9.n, C2.n, R3.p, Cs.p)
        connect(R2.n, Us2.p)
        connect(Us2.n, R4.p, R5.p, Is5.p, C1.p, G.g)
        connect(Is5.n, R5.n, R3.n, Cs.n, Us6.n)
        connect(R1.n, Us1.p)
        connect(Us1.n, R4.n, R6.p, C1.n)
        connect(R6.n, Us6.p)
    ]
    @named _model = ODESystem(connections, t)
    @named model = compose(_model, [R1, R2, R3, R4, R5, R6, R7, R8, R9, Is5, Us1, Us2, Us6, Us9, C1, C2, L1, Cs, G])
end
sys = structural_simplify(model)
begin
    u0 = []
    tspan = (0, 10.0)
    prob = ODEProblem(sys, u0, tspan)
    sol = solve(prob, Rodas4())
end
using Plots
sol[R1.p.v]
plot(sol[t], sol[R1.v])