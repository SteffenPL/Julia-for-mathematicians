using OrdinaryDiffEq
using GLMakie
using ForwardDiff

#=

    2. Higher dimensions

    We consider the first order ODE
    in ℝⁿ × ℝᵐ where we have

    dS/dt = -S*I
    dI/dt = S*I - I
    dR/dt = I
=#



function lorenz!(du, u, p, t)
     du[1] = 10.0*(u[2]-u[1])
     du[2] = u[1]*(28.0-u[3]) - u[2]
     du[3] = u[1]*u[2] - (8/3)*u[3]
    nothing  # no need to return anything
end


u0 = [1.0;0.0;0.0]
tspan = (0.0,100.0)

prob = ODEProblem(lorenz!,u0,tspan)
sol = solve(prob, saveat = 0.01)

begin
    f = Figure()

    ax = Axis3(f[1,1], title = "Lorenz model")
    lines!(sol[1,:], sol[2,:], sol[3,:])

    ax.elevation = pi/8
    ax.azimuth = -1pi/8

    f
end


display(f)
