include("../src/AC/AC.jl")
#电力系统仿真
@named R1 = Resistance(; R=10.8, X=16.64)
@named R2 = Resistance(; R=1.16, X=20.17)
@named C1 = Admittance(; G=0, B=2.19e-4)
@named C2 = Admittance(; G=0, B=2.19e-4)
@named C3 = Admittance(; G=5.13e-6, B=-3.64e-5)
@named S = Generator(; Va=117e3, Vb=0)
@named L = Load(; P=40e6, Q=30e6)
@named G = Ground()

connections = [
    connect(S.p, R1.p, C1.p)
    connect(R1.n, C2.p, C3.p, R2.p)
    connect(R2.n, L.p)
    connect(C1.n, C2.n, C3.n, G.g)
]
@named _model = ODESystem(connections, t)
@named model = compose(_model, [R1, R2, C1, C2, C3, S, L, G])
sys = structural_simplify(model)
u0 = []
tspan = (0, 10.0)
prob = ODEProblem(sys, u0, tspan)
sol = solve(prob, Rodas4())