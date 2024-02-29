include("../src/DC/DC.jl")
#测试用的，不作为参赛展示
@named R1 = Resistor(; R=10)
@named R2 = Resistor(; R=20)
@named C1 = Capacitor(; C=5)
@named C2 = Capacitor(; C=2)
@named S1 = ConstantVoltage(; V=15)
@named G = Ground()

connections = [
    connect(S1.p, R1.p)
    connect(R1.n, C1.p)
    connect(C1.n, S1.n, G.g)
    connect(R1.n, R2.n)
    connect(C2.p, R2.p)
    connect(C2.n, R1.p)
]
@named _model = ODESystem(connections, t)
@named model = compose(_model, [R1, C1, R2, C2, S1, G])
sys = structural_simplify(model)
u0 = [
    C1.v => 0.0
    C2.v => 1.0
]
tspan = (0, 10.0)
prob = ODEProblem(sys, u0, tspan)
sol = solve(prob, Rodas4())
sol[C1.v]
sol[R1.n.v]
sol[C1.p.v]
# plot(sol[t], sol[C1.v])
include("convertjson.jl")
convertjson(sol,)
@test sol.retcode == ReturnCode.Success