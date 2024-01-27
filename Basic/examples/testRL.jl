include("../Basic.jl")
using Plots
@named R1 = Resistor(; R=10)
@named R2 = Resistor(; R=20)
#@named C1 = Capacitor(; C=5)
#@named C2 = Capacitor(; C=2)
@named L1 = Inductor(; L=5)
@named L2 = Inductor(; L=2)
@named S1 = ConstantVoltage(; V=15)
@named G = Ground()
# 构建连接关系
connections = [
    connect(S1.p, R1.p)
    connect(R1.n, L1.p)
    connect(L1.n, S1.n, G.g)
    connect(R1.n, R2.p)
    connect(L2.p, R2.n)
    connect(L2.n, S1.n,G.g)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [R1, L1, R2, L2, S1, G])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  查看系统的方程
# states(sys)     查看系统的变量
v0 = [#定义电容两侧电压差的初始值
    L1.v => 0.0
    L2.v => 1.0
    
]
tspan = (0, 10.0)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys, v0, tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
# 查看变量的值 sol[组件名.变量名]
sol[L2.v]
sol[R2.n.v]
sol[L2.p.v]
plot(sol[t],sol[L2.v],label = "L2.v",title = "testRL")
