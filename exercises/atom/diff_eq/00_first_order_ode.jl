using DifferentialEquations
using GLMakie


#=
 # 1. simplest case

  ̇x = - λ ̇x

=#

testeq(u, p, t) = @. - p.k * ( p.a - u ) * u

u0  = [0.1]
tspan = (0.0, 60.0)
p = (; k = 1.0, a = 1.6)

prob = ODEProblem(testeq, u0, tspan, p)
sol = solve(prob) #, reltol = 1e-6, abstol = 1e-8)

begin
    f = Figure()

    ax = Axis(f[1,1], title = "Numerical solution and interpolation", xlabel=L"x(t)", ylabel=L"t")
    scatter!(sol.t, sol[1,:])
    lines!(sol.t, sol[1,:])

    sol_int = sol(LinRange(tspan..., 100))
    lines!(sol_int.t, sol_int[1,:])

    mkpath("plots")
    save("plots/00_first_order.png", f)
    f
end
