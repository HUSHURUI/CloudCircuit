include("../Basic.jl")#两个点表示上一级目录，一个点表示当前目录
using .Basic #导入模块
using ModelingToolkit, DifferentialEquations
@named R1 = Resistor(; R=10)
@named R2 = Resistor(; R=20)
@named C1 = Capacitor(; C=5)
@named C2 = Capacitor(; C=2)
@named S1 = ConstantVoltage(; V=15)
@named G = Ground()
# 构建连接关系
connections = [
    connect(S1.p, R1.p)
    connect(R1.n, C1.p)
    connect(C1.n, S1.n, G.g)
    connect(R1.n, R2.n)
    connect(C2.p, R2.p)
    connect(C2.n, R1.p)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [R1, C1, R2, C2, S1, G])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  查看系统的方程
# states(sys)     查看系统的变量
u0 = [#定义电容两侧电压差的初始值
    C1.v => 0.0
    C2.v => 1.0
]
tspan = (0, 10.0)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys, u0, tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器
# 查看变量的值 sol[组件名.变量名]
sol[C1.v]
sol[R1.n.v]
sol[C1.p.v]
# 如果想查看函数图像，就执行下面的代码
using Plots
plot(sol[t], sol[C1.v])#plot 函数也是理解多重派发的好例子 具体怎么用直接问gpt