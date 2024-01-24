include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录0118练习.md
@named R1 = Resistor(; R=10)
@named R2 = Resistor(; R=20)
@named S1 = ConstantCurrent(; I=15)
@named G = Ground()
@named S2 = CCC(; gain=2)
connections = [
    connect(S1.n, R1.p)
    connect(R1.n, R2.p)
    connect(S1.p, R2.n, S2.p, G.g)
    connect(S2.n, R1.p)
    connect(S2.e, R2.p)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [R1, R2, S1, S2, G])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
tspan = (0, 10.0)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys, [], tspan)
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
sol[R2.n.v]