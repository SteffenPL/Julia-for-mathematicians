using LinearAlgebra # for the norm and dot function
using ForwardDiff # for automatic differentiation

#=

## Gradient decent with backtracking line search

Write a function `gradient_decent(f, x0, α, β)` which implements the gradient decent with backtracking line search.

Below you find some pseudo-code and a few template for the functions you could create.
(You can change name and arguments of the functions in your implementation of course.)

The pseudo algorithms are:


Gradient decent:
given a starting point x_0

x = x_0
repeat until stopping criterium
	Compute decent direction Δx = ∇f(x).
 	Line search: Choose a step size t > 0.
    Update: x = x + t * Δx

 	Stopping criterium: ‖ ∇f(x) ‖² < ε
end


Backtracking line search:
given x, f, Δx, α, β

t = 1
repeat until f(x + t Δx) < f(x) + α t dot( ∇f(x), Δx )
 	Udate: t = β t
end

Source: [https://web.stanford.edu/class/ee364a/lectures/unconstrained.pdf](https://web.stanford.edu/class/ee364a/lectures/unconstrained.pdf)

=#

function linesearch(f, Δx, x, α, β; t_min = 1e-5)
	# write your code here

	return NaN
end

function gradientdecent(f, x0, α, β, ε; max_steps = 1e4)
	@assert β < 1
	@assert α < 0.5
	# write your code here

	return NaN
end

# test case

begin
	f(x) = exp(x[1]+3x[2]-0.1) + exp(x[1]-3x[2]-0.1) + exp(-x[1]-0.1)
	α = 0.25
	β = 0.5
	ε = 1e-8
	x0 = [0.0, 0.0]

	gradientdecent(f, x0, α, β, ε)
end
