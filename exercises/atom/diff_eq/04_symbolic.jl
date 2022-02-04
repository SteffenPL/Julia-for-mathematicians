using ModelingToolkit
using DifferentialEquations

@parameters t α
@variables x(t) y(t)
D = Differential(t)

eqs = [D(x) ~ y * x,
       D(y) ~ -α * x]

@named sys = ODESystem(eqs)

u0 = [ x => 1.0, y => 2.0]
tspan = (0.0, 1.0)
p = [α => 1.0]
prob = ODEProblem(sys, u0, tspan, p)
sol = solve(prob)

#=
using SymbolicUtils
r1 = @rule (~y)*(~x) => (~y)^2
r1(eqs[1].rhs)
=#
