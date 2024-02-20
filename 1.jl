using ModelingToolkit, DifferentialEquations
@variables t
@connector function Pin(; name)
    sts = @variables begin
        va(t) = 1.0
        vb(t) = 1.0
        (ia(t)=1.0, [connect = Flow])
        (ib(t)=1.0, [connect = Flow])
    end
    return ODESystem(Equation[], t, sts, []; name=name)
end
function Capacitor(; name, C=1.0, w=50)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters begin
        C = C
        w = w
    end
    eqs = [
        (p.va - n.va) * w * C ~ p.ib
        (n.vb - p.vb) * w * C ~ p.ia
        0 ~ p.ia + n.ia
        0 ~ p.ib + n.ib
    ]
    return compose(ODESystem(eqs, t, [], ps; name=name), p, n)
end
function ConstantVoltage(; name, Va=10.0, Vb=0, w=50)
    @named p = Pin()
    @named n = Pin()
    ps = @parameters begin
        Va = Va
        Vb = Vb
        w = w
    end
    eqs = [
        Va ~ p.va - n.va
        Vb ~ p.vb - n.vb
        0 ~ p.ia + n.ia
        0 ~ p.ib + n.ib
    ]
    return compose(ODESystem(eqs, t, [], ps; name=name), p, n)
end
function Resistor(; name, R=10)
    @named p = Pin()
    @named n = Pin()
    eqs = [
        (p.va - n.va) ~ p.ia * R
        (p.vb - n.vb) ~ p.ib * R
        0 ~ p.ia + n.ia
        0 ~ p.ib + n.ib
    ]
    return compose(ODESystem(eqs, t, [], []; name=name), p, n)
end
function Ground(; name)
    @named g = Pin()
    eqs = [
        g.va ~ 0
        g.vb ~ 0
    ]
    return compose(ODESystem(eqs, t, [], []; name=name), g)
end
@named C1 = Capacitor(; C=5)
@named R1 = Resistor(;)
@named S1 = ConstantVoltage(; Va=15, w=3.78)
@named G = Ground()
# 构建连接关系
connections = [
    connect(S1.p, C1.p)
    connect(C1.n, R1.p)
    connect(S1.n, R1.n, G.g)
]
@named _model = ODESystem(connections, t)#这行代码不用改
@named model = compose(_model, [C1, S1, R1, G])#要包含你构建的所有组件名字
sys = structural_simplify(model)#大家关注sys ，不要关注_model和model，我随便起的名字
# equations(sys)  查看系统的方程
# states(sys)     查看系统的变量
u0 = [#定义电容两侧电压差的初始值
    C1.p.va => 0.0
    C1.p.vb => 0.0
]
tspan = (0, 10.0)#设置时间范围，步长是求解器根据自动生成的
prob = ODAEProblem(sys, u0, tspan)#这行代码不用改
sol = solve(prob, Rosenbrock23())#  除了Tsit5()之外，还有Rosenbrock23()等求解器

