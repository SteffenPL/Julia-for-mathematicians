using ForwardDiff
using LinearAlgebra
using StaticArrays

norm²(x) = sum( z -> z^2, x)
# this is a bit faster than norm (but don't worry, norm()^2 is fine)

function linesearch(f, Δx, m², x, α, β; t_min = 1e-5)
	t = 1.0
	fx = f(x)
	z = x + t*Δx
	while t > t_min
		z .= x + t*Δx
		if f(z) <= fx + α * t * m²
			return t
		end
		t = t*β
	end

	return NaN64
end

using ForwardDiff: GradientConfig, Chunk

function gradientdecent(f, x0, α, β, ε;
							max_steps = 1e4, traj = true,
							cfg = GradientConfig(f, x0, Chunk{length(x0)}()))
	x = copy(x0)
	i = 0
	∇f = similar(x0)

	if traj
		X = [x0]
	end

	Δx = -∇f
	#@show typeof(Δx) typeof(∇f)
	while i < max_steps
		ForwardDiff.gradient!(∇f, f, x, cfg)
		Δx .= -∇f

		m² = norm²(∇f)
		if m² < ε;	break  end

		t = linesearch(f, Δx, m², x, α, β)
		x .= x + t * Δx

		if isnan(t)
			@error "Gradient decent method did not find a solution."
			return missing
		end

		if traj; push!(X, copy(x)) end

		i += 1
	end

	if i == max_steps
		@error "Gradient decent method did not find a solution."
		return missing
	else
		return traj ? (; min = x, traj = reduce(hcat,X)) : x
	end
end


begin
	f(x) = exp(x[1]+3x[2]-0.1) + exp(x[1]-3x[2]-0.1) + exp(-x[1]-0.1)
	α = 0.25
	β = 0.5
	ε = 1e-15
	x0 = [-1.8, 1.2]

	sol = gradientdecent(f, x0, α, β, ε; traj = true)
	size(sol.traj)
end


@elapsed  let
	f(x) = exp(x[1]+3x[2]-0.1) + exp(x[1]-3x[2]-0.1) + exp(-x[1]-0.1)
	α = 0.25
	β = 0.5
	ε = 1e-15
	x0 = @MVector[-1.8, 1.2]
	for i in 1:1000
		gradientdecent(f, x0, 0.25, 0.5, ε; traj = false)
	end
end

using GLMakie
let
	fig = Figure()
	ax = Axis(fig[1,1], title = "Trajectory of gradient decent method")

	lines!(sol.traj[1,:], sol.traj[2,:], linewidth = 2, color = :black)

	xs = LinRange(-2.5,0.5,100)
	ys = LinRange(-1.5,1.5,100)
	z = [f((x,y)) for x in xs, y in ys]
	heatmap!(xs, ys, z, colormap = :heat)
	contour!(xs, ys, z, levels = 100 )

	fig
end
