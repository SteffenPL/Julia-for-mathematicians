using Test
last_runtimes = Float64[]

#=

	Computing the Fibonacci sequence
	===

	Below, you will find a function `fib` which computes the first `N` (default: 100.000) numbers of the Fibonacci sequence

	> Your mission, should you decide to accept it, is to make `fib` (roughly) 10× faster. 🚀

	There are at least two mistakes in the given code. (One much more relevant than the other).
	If you want, you can find some tips in the hint boxes below.

	Useful functions for `Vector`s might be:
	- `sizehint!()` gives Julia the hint how large the vector might become
	- `zeros(Int64, N)`  creates a vector of zeros with element type `Int64`
	- `Vector{Int64}(undef, N)` creates an uninitialized vector with element type `Int64`

	Check the documentation (e.g. `?sizehint!`) for their function.
=#



function fib(N = 100_000; x₀ = 1, x₁ = 1)
	# modify this code to improve the performance

	x = Int64[]
	append!(x, (x₀, x₁))
	for i in 3:N
		push!(x, x[i-1] + x[i-2])
	end
	return x
end


@test fib()[end] == 2754320626097736315  # this line tests if `fib` works correctly

# this is how you call the function:
x = fib()


#=

How to benchmark a function:

  To test the performance, you can either use `@time`\`@elapsed` or,
  the accurate `@btime`\`@belapsed` from the package `BenchmarkTools`

=#

@time fib()

begin
	# run function again and show hisotry
	current_runtime = @elapsed fib()
	push!(last_runtimes, current_runtime)


	println("Current runtime: ", 1000 * current_runtime, " ms")
	println("Last runtimes: ")
	for t in reverse(last_runtimes)
		println("  ", 1000 * t, " ms")
	end
end


println()



#=

	If you want some hints, continue reading:

	Hint #1"
    ---

	Adding new element to an existing `Vector` can take up much time.
	It is better to allocate enough memory beforehand.

    You could use `sizehint!(x, N)`, which tells the program which size to allocate for that array.

	Or you could allocate directly a vector of size `N`, but then you need to modify the for loop accordingly, since we then don't have to `push!` element into the vector, but just to access the `i`th position.


	Hint #2
	---

	The main problem is this: The vector `x` has type `typeof(x) == Vector{Any}`!
    This wastes a lot of resources.

    To avoid this, you could at least create it as
	`x = Int64[]`.

    Or in combination with Hint #1, you could use
	`x = zeros(Int64, N)` and change the `for` loop accordingly.

=#
