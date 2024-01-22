include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录
using .Basic #导入模块
using Plots
using ModelingToolkit, DifferentialEquations
@named R = Resistor(; R=10)
@named S = CosineVoltage(;V=100,f=10/(2*pi),phase = 0)
@named G = Ground() 
@named T = Transformer(;L1=5,L2=3.2,M=3.999999999)
# 构建连接关系

connections = [
	connect(S.p,T.in_p)
	connect(S.n,T.in_n,G.g,T.out_n,R.n)
	connect(T.out_p,R.p)
]

@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [R,S,G,T])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  #查看系统的方程
# states(sys)     #查看系统的变量
u0 = [
	T.in_p.i => 0
	T.out_p.i => 0
]
tspan = (0, 10)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys,u0,tspan)#这行代码不用改
sol = solve(prob,Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
plot(sol[t],sol[S.p.i],label = "i1")
plot!(sol[t],sol[R.n.i],label = "i2")
x = 1 : 10
y = [6.4 for i in 1:10]
plot!(x,y)
# plot!(sol[t],sol[T.in_p.i])
# plot!(sol[t],sol[T.out_p.i])
