### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ 1704925c-9d29-4b52-9e42-8ba60bec1901
using PlutoUI

# ╔═╡ cf7a9ec8-2077-41ad-a5ee-e6131a3bc0d5
using Test

# ╔═╡ b8ad4763-2d32-4ea7-9bd1-c059abc3ef02
md"""## Computing the Fibonacci sequence

Below, you will find a function `fib` which computes the first `N` (default: 100.000) numbers of the Fibonacci sequence

$x_0 = 1, \quad x_1 = 1,$

$x_n = x_{n-2} + x_{n-1} \quad \text{for } n = 2, 3, \dots$
"""

# ╔═╡ a231d855-94c7-4f80-88ab-09771ead491a
md"""
#### Your mission, should you decide to accept it, is to make `fib` (roughly) 10× faster.  

## 🚀

There are at least two mistakes in the given code. (One much more relevant than the other). 
If you want, you can find some tips in the hint boxes below.

Useful functions for `Vector`s might be:
- `sizehint!()` gives Julia the hint how large the vector might become
- `zeros(Int64, N)`  creates a vector of zeros with element type `Int64`
- `Vector{Int64}(undef, N)` creates an uninitialized vector with element type `Int64`

Check the documentation (e.g. `?sizehint!`) for their function.
"""

# ╔═╡ 458fe3b8-ae71-4f5e-ac71-e87aebf49d26
md"---"

# ╔═╡ 8eb5164a-e6ac-4294-951c-d466d1545056
HTML("<br>"^4)

# ╔═╡ a95a799f-0b24-43a1-a3d5-a307dc66c871
md"Good luck!"

# ╔═╡ 4300ee90-8164-11ec-27f6-d1e8d92def77
function fib(N = 1_000_000; x₀ = 1, x₁ = 1)
	# modify this code to improve the performance
	
	x = zeros(Int128, N)
	append!(x, (x₀, x₁))
	for i in 3:N
		x[i] = x[i-1] + x[i-2]
	end
	return x
end

# ╔═╡ 3572451e-af64-42dd-aa66-6e2b78c6e687
fib()[end]

# ╔═╡ d533c36f-57db-4a99-ab63-9b6d0819c40e
#@test fib()[end] == 2754320626097736315  # this line tests if `fib` works correctly

# ╔═╡ bf1fcc4a-d8de-4299-b7f8-4cd2616247eb
x = fib()

# ╔═╡ 7d806a4b-3975-483b-a8bb-8287aa808153


# ╔═╡ 574d2013-adf0-4598-99c9-23978777c350
md"If you change the function and press `Shift+Enter` (to run the cell), then the timings get updated."

# ╔═╡ fadc6a39-2d55-4930-995f-1c2b179de623
md"*Note: Run the cell below to reset all timings:*"

# ╔═╡ 150c4d64-6c6c-479f-a6e9-414807c12b3e
timings = Float64[]  # initialises/resets the vector with previous timings 

# ╔═╡ 086109b0-8c06-414e-addc-62d23eac2a6e
with_terminal() do
	fib() # the first computation is always a bit slower, so we skip that
	
	println("Last run:")
	@time fib()
	
	printstyled("History:\n", color = :light_green)
	for t in reverse(timings)
		printstyled( round(t, digits=3), " ms\n", color = :green )
	end

	push!(timings, 1000 * @elapsed(fib()))

	nothing  # we don't want to display anything. Hence, we return nothing
end

# ╔═╡ 249b210f-2b48-485b-b3e3-68cb15420935
md"*Optional: If you want to do the performance timing yourself, you could either use the `@time fib()` command, or, even better, the `@benchmark fib()` command from the package `BenchmarkTools.jl`. (Hence, you need to run `using BenchmarkTools` to include it.)*"

# ╔═╡ ee060fd9-e843-4646-965a-301f419ef647
HTML("<br>"^4)

# ╔═╡ 9631ba25-0d87-4622-a176-1bb460355a46
md"""
!!! hint "Hint #1"
    Adding new element to an existing `Vector` can take up much time. 
	It is better to allocate enough memory beforehand.
	
    You could use `sizehint!(x, N)`, which tells the program which size to allocate for that array.

	Or you could allocate directly a vector of size `N`, but then you need to modify the for loop accordingly, since we then don't have to `push!` element into the vector, but just to access the `i`th position.
"""

# ╔═╡ 6fe358c6-96c2-4116-aa44-d9ed8bd7144a
HTML("<br>"^4)

# ╔═╡ 510641a3-f73e-4f07-abd9-ae865fe5e6b1
md"""
!!! hint "Hint #2"
	The main problem is this: The vector `x` has type `typeof(x) == Vector{Any}`!
    This wastes a lot of resources. 

    To avoid this, you could at least create it as 
	`x = Int64[]`.

    Or in combination with Hint #1, you could use
	`x = zeros(Int64, N)` and change the `for` loop accordingly.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
PlutoUI = "~0.7.32"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0b5cfbb704034b5b4c1869e36634438a047df065"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "ae6145ca68947569058866e443df69587acc1806"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.32"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═1704925c-9d29-4b52-9e42-8ba60bec1901
# ╠═cf7a9ec8-2077-41ad-a5ee-e6131a3bc0d5
# ╟─b8ad4763-2d32-4ea7-9bd1-c059abc3ef02
# ╟─a231d855-94c7-4f80-88ab-09771ead491a
# ╟─458fe3b8-ae71-4f5e-ac71-e87aebf49d26
# ╟─8eb5164a-e6ac-4294-951c-d466d1545056
# ╟─a95a799f-0b24-43a1-a3d5-a307dc66c871
# ╠═4300ee90-8164-11ec-27f6-d1e8d92def77
# ╠═3572451e-af64-42dd-aa66-6e2b78c6e687
# ╠═d533c36f-57db-4a99-ab63-9b6d0819c40e
# ╠═bf1fcc4a-d8de-4299-b7f8-4cd2616247eb
# ╟─7d806a4b-3975-483b-a8bb-8287aa808153
# ╟─574d2013-adf0-4598-99c9-23978777c350
# ╟─086109b0-8c06-414e-addc-62d23eac2a6e
# ╟─fadc6a39-2d55-4930-995f-1c2b179de623
# ╠═150c4d64-6c6c-479f-a6e9-414807c12b3e
# ╟─249b210f-2b48-485b-b3e3-68cb15420935
# ╟─ee060fd9-e843-4646-965a-301f419ef647
# ╟─9631ba25-0d87-4622-a176-1bb460355a46
# ╟─6fe358c6-96c2-4116-aa44-d9ed8bd7144a
# ╟─510641a3-f73e-4f07-abd9-ae865fe5e6b1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
