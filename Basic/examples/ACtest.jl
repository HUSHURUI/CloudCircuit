include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录
using .Basic #导入模块
using Plots
using ModelingToolkit, DifferentialEquations
@named R1 = Resistor(; R=10)
@named S = CosineVoltage(;V=311,f=1)
@named G = Ground() 
@named C = Capacitor()
# 构建连接关系

connections = [
	connect(S.p,R1.p)
	connect(R1.n,C.p)
	connect(S.n,C.n,G.g)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [S,R1,G,C])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  #查看系统的方程
# states(sys)     #查看系统的变量
u0 = [
	
]
tspan = (0, 10.0)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys,u0,tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
sol[t]
plot(sol[t],sol[C.p.v])
plot!(sol[t],sol[C.p.i])


