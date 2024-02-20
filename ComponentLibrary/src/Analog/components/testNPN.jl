include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录
@named R1 = Resistor(; R=5)
@named R2 = Resistor(; R=5)
# @named S = CosineVoltage(; V=100, f= 0.1, phase=0)
@named VC = ConstantVoltage(;V=1)
@named VB = ConstantVoltage(;V=0.8)
@named G = Ground()
@named D = NPN()
# 共射极放大电路
# 构建连接关系
connections = [
    connect(VB.p,R1.p)
    connect(R1.n,D.b)
    connect(D.c,R2.p)
    connect(R2.n,VC.p)
    connect(D.e,VC.n,VB.n,G.g)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [VB,VC,G,D,R1,R2])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  #查看系统的方程
# states(sys)     #查看系统的变量
u0 = [
]
tspan = (0, 10)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys, u0, tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
Beta = sol[D.c.i][1]/sol[D.b.i][1]
print("放大系数为",Beta)
plot!(sol[t], sol[D.b.i], label="b.i")
plot!(sol[t], sol[D.c.i], label="c.i")

# x = 1:10
# y = [6.4 for i in 1:10]
# plot!(x, y)
# plot!(sol[t],sol[T.in_p.i])
# plot!(sol[t],sol[T.out_p.i])
