using OrdinaryDiffEq
using GLMakie


#=
 # 1. simplest case

 ̈x =  -sin(x) - λ ̇x

=#
dampedpendulum(du, u, p, t) = @. -sin(u) - p.λ * du

du0 = [0.]
u0  = [1.0]
tspan = (0.0, 100.0)
p = (; λ = 0.1)

prob = SecondOrderODEProblem(dampedpendulum, du0, u0, tspan, p)
sol = solve(prob, VelocityVerlet())

# other solvers, e.g. DPRKN6

begin
    f = Figure()

    ax = Axis(f[1,1], title = "Position")
    lines!(sol.t, sol[1,:])

    ax = Axis(f[1,2], title = "Velocity")
    lines!(sol.t, sol[2,:])

    Label(f[0,1:2], "Damped pendulum", textsize = 24)

    mkpath("plots")
    save("plots/01_damped_pendulum.png", f)
    f
end
