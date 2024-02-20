include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录
@named R = Resistor(; R=10)
@named R1 = Resistor(; R=10)
@named S = CosineVoltage(; V=10, f= 0.1, phase=0)
# @named S = ConstantVoltage(;V=10)
@named G = Ground()
@named C = Capacitor()
@named D1 = Diode()
# 构建连接关系
# 二极管整流电路，需用ODE方法
connections = [
    connect(S.p, D1.p)
    connect(D1.n, R.p)
    connect(S.n, R.n, G.g)
    connect(S.p, R1.p)
    connect(C.p, R1.n)
    connect(C.n, S.n)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [S, D1, R, G, C, R1])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  #查看系统的方程
# states(sys)     #查看系统的变量
u0 = [
    C.v => 0
]
tspan = (0, 100)#设置时间范围，步长是求解器根据自动生成的
prob = ODEProblem(sys, u0, tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
plot(sol[t], sol[R.p.v], label="R.v")