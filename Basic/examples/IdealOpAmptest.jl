include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录
using .Basic #导入模块
using Plots
using ModelingToolkit, DifferentialEquations
@named R1 = Resistor(; R=10)
@named R2 = Resistor(; R=20)
@named R3 = Resistor(; R=30)
@named S1 = ConstantVoltage(; V=3)
@named G = Ground() # 加入了理想运放地线模型的电流不应置为0
@named Op = IdealOpAmp3pin()
# 构建连接关系

connections = [
	connect(S1.p,R1.p)
	connect(R1.n,Op.in_n,R2.p)
	connect(R2.n,Op.out,R3.p)
	connect(R3.n,Op.in_p,S1.n,G.g)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [R1, R2, R3, S1, Op, G])#要包含你构建的所有组件名字
println(equations(model)) 
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
equations(sys)  #查看系统的方程
states(sys)     #查看系统的变量
u0 = []
tspan = (0, 10.0)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys,u0,tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器


sol[Op.out.v]
plot(sol[t],sol[Op.out.v])
