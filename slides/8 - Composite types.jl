### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ a2a0a0d7-b457-40bd-ae6b-da14cc557031
begin
	using PlutoUI
	bigbreak = HTML("<br>"^4)
	nothing
end

# ╔═╡ 6643612d-d1a6-4fdc-8398-e12682891eb0
using LinearAlgebra

# ╔═╡ 9426ed50-83ae-11ec-34f2-2f8e36fc8d05
md"""
# Composite types aka `structs`

If your project growths it gets more important to keep things modular.
"""

# ╔═╡ 869614f3-f243-4319-9f8f-64c3cc13eb97
md"## 1. Inmutable structs

The definition is rather easy. It needs name and a list of its variables (optionally with types)."

# ╔═╡ 70d2151b-0de1-41c2-a73a-7ee6f01a2d9f
struct Point
	x
	y
end

# ╔═╡ 24eabc0b-496b-4159-8da6-29910b85ea4f
md"There will always be a default constructor:"

# ╔═╡ 996a3423-bd55-49d7-9401-d270b6e109c1
p = Point(1.0, 2.0)

# ╔═╡ 909cc091-b321-4752-9f7a-62d1aa3a3a3d
p.x

# ╔═╡ be82d829-d6c3-4822-8f57-3f0727776817
p.y

# ╔═╡ 3528ea22-89da-4330-9b66-49fdfef87687
# p.x = 10   # does not work!

# ╔═╡ 260566f0-c909-41a2-9ebf-ddb8103635f4


# ╔═╡ 8f62d5bd-764b-49e5-9b00-05d9f90332f9
md"Two typical use cases of inmutable structs:

- Parameters for a solver which do not change during the simulation.
- Implementation of useful syntax, by methods functions for your type.
- Realisation of an interface for your data. (Construction of a mutable struct is often almost zero overhead.)
"

# ╔═╡ 1515c0ab-f7ed-4273-9b64-c810abbaf941
md"### Example (`FastDiagonal`)"

# ╔═╡ 5790a006-640d-4751-a690-b139654049c6
md"Let's implement a matrix like type, which only stores diagonal elements."

# ╔═╡ 62ee2d5b-d757-47db-9019-37622330e9bc
begin
	struct FastDiag{T}
	    data::Vector{T}
	end
	
	import Base: *, +
	function *(A::FastDiag{T}, x::Vector{T}) where T
	    return A.data .* x
	end
	
	function +(A::FastDiag{T}, B::FastDiag{T}) where T
	    return FastDiag{T}( A.data + B.data )
	end

	nothing # just to surpress Pluto output
end


# ╔═╡ dbd7131b-05a9-4d70-8864-d5ca9b2fe9c5
md"It is always good, if your type is `concrete`. That means Julia can predict each variables type in advance."

# ╔═╡ 3c7c5961-014d-47c6-8ffa-cd06198682ce
isconcretetype(FastDiag{Float64})

# ╔═╡ b9a4a4ac-c07f-4f73-aa48-dbfa123a267a


# ╔═╡ cb9e96e1-597a-4b0e-912a-1972c84edd5f
begin
    N = 1000
    A = [i == j ? rand() : 0.0 for i in 1:N, j in 1:N]
	A_diag = collect(diag(A))
    A_fast = FastDiag(diag(A))
	
    x = rand(N)	
end

# ╔═╡ 0fbd5d9a-30dc-4e73-9bff-c088768de5ab
md"Let's first make sure that our methods work correctly:"

# ╔═╡ 4a9409d1-d04d-459c-93a2-fd47315a1c27
A * x == A_fast * x

# ╔═╡ 1dc516fd-b6de-466c-8cc2-ec56301cebba
md"Now, let's measure performance:"

# ╔═╡ 49044d10-11a2-44e7-9a86-481ddfd595c4
with_terminal() do 
	printstyled("Full matrix             :", color = :red)
	@time A * x
	
	printstyled("Fast digonal type       :", color = :green)
	@time A_fast * x
	
	printstyled("On the fly construction :", color = :green)
	@time FastDiag(A_diag) * x
end

# ╔═╡ 35345440-550c-4723-9aec-e08142ff0802
md"### Success 🚀

By the way, there is a build in Diagonal type `Diagonal` in the `LinearAlgebra` standard package.

It has basically the same definition as our example!"

# ╔═╡ 7c12b757-8ca5-4d2b-92b0-d204f94e6d0b


# ╔═╡ 292ee470-e286-47ea-8065-92ad2fc824d7
Diagonal(A_diag) * x

# ╔═╡ 55485242-77c4-43ec-996d-c1177ab34ecf
bigbreak

# ╔═╡ ee6fa527-4d43-4b51-baa3-2cb2fa57d81b
md"### Are inmutable structs constant values? NO!"

# ╔═╡ f491e000-1f10-443d-bf18-18a413f8cf94
begin
	data = [1,2,3]
    D = FastDiag(data)

	D.data[2] = 100
	
	(;data, D)
end

# ╔═╡ c13de59d-508e-4472-a602-17d334337ca4
md"
The variables (here `data`) are inmutable. 

But if the value is of an mutable type, than we can mutate the underlying data indeed!"

# ╔═╡ 2dc06114-7f29-4021-943d-e2b14f787e3d
bigbreak

# ╔═╡ 95fbd51f-62a0-4167-9478-452420d19369
md"## 2. Mutable structs"

# ╔═╡ 91185b65-573b-42de-8238-3cd046aa5b98
md"We just have to add the keyword `mutable`. That's it!"

# ╔═╡ fa237ef5-f1df-4826-8062-81e061be64a2
mutable struct SimulationState
	X::Vector{Float64}
	t::Float64
end

# ╔═╡ f01b0192-2a01-4e04-905b-3500c84c52c1
s = SimulationState( [10.0, 20.0], 0.0)

# ╔═╡ 5e55db0d-6245-47e6-ac65-6a37d66758ae
s.t = 10.0

# ╔═╡ 1ab4ba54-b86c-46ec-8852-326223fce26b
s

# ╔═╡ 72fec38d-4c24-4356-97de-71a2914b821f
bigbreak

# ╔═╡ 82209778-7d13-49fd-9812-1d534ad79a49
md"## 3. Parametric types and functions"

# ╔═╡ 94b65eff-9df8-4621-9a92-74ae0a0c8052
md"Warning: This is more an advanced feature. If you want to use it, your will have to study it a bit more!"

# ╔═╡ 5fa76a28-b1d4-4c94-a7b8-5057115caa7a
struct Unpredictable
	x
end

# ╔═╡ aa7189d4-53a5-4c54-bfdb-c8b242be2613
struct Predictable{T}
	x::T
end

# ╔═╡ 7fc21ab5-52d9-4b12-a0c9-780cf2c62c75


# ╔═╡ 8ad53b1a-55c3-4a85-9f06-0ecd01305120
square(s) = s.x^2

# ╔═╡ 2c21a7fe-3223-46d4-af30-296045c905ec
a = Unpredictable(rand([1.0, 2, "3"]))

# ╔═╡ d7a61c32-0ed9-4d04-91e1-d6849057df2d
b = Predictable(rand([1.0, 2, "3"]))

# ╔═╡ fc842dae-373f-4ec5-815e-e25193fce8fe
with_terminal() do
	println("a = ", a.x, "\t     typeof(a) = ", typeof(a))
	println("b = ", b.x, "\t     typeof(b) = ", typeof(b))
end
	

# ╔═╡ 9c4c826b-f1a8-43f9-a50c-455826223402
bigbreak

# ╔═╡ 4f962f52-99e4-4d2c-a16c-7b187b03d9d6
md"#### Problem: Type instabilities:"

# ╔═╡ e02cf43c-3389-4020-b2cc-57f201cee0aa
md"The output of `@code_warntype` shows whenever some types are unpredictable at compile time:"

# ╔═╡ 0bfee97a-6b2c-42d7-b095-b356f5858bc0
with_terminal() do 
	@code_warntype square(a)
end

# ╔═╡ 4120837d-749b-4813-b53f-0ab22bceacee
with_terminal() do 
	@code_warntype square(b)
end

# ╔═╡ 08facfc2-4b2b-4055-891b-b8ea6b0b61d0
bigbreak

# ╔═╡ 27352174-d77c-4d61-bcf4-b897e451c5f6
md"### Parametric functions

You can define always a domain of types which you would like to allow.

**Syntax:**
```julia
function fnc(x::T, y::S) where {T, S <: AbstractVector}
   #
end
```
"

# ╔═╡ e355c3b9-470d-447a-8208-cf99dfbceadc
function pseudo_dot(x::Vector{T}, y::Vector{S}) where {T<:Number, S<:Number}
	res = zero(T)
	for i in 1:min(length(x), length(y))
		res += x[i] * y[i]
	end
	return res
end

# ╔═╡ 99f36b6d-ade6-4f37-8dfb-76c967c445d9
pseudo_dot( [1, 2, 3], [1.0, 1im])

# ╔═╡ cebfa1b4-6876-41ac-b219-032f061f44ac
bigbreak

# ╔═╡ 665b754d-be3e-4982-8e03-02d1b5fbbf39
md"## 4. Abstract types

You might want to define a type hiearachy for your types!

We cannot define relations directly between our custom structs. Instead, we use abstract types to carry the hierachy information!


It is up to convention/documentation what an abstract type actually represents.
Famous example `AbstractArray`, see also [Documentation - Interfaces](https://docs.julialang.org/en/v1/manual/interfaces/#Indexing)
"

# ╔═╡ 7bf7c3c4-85cd-4d86-bbb1-933a7d5c8328


# ╔═╡ 40d2b89f-802d-441d-8053-ffd95feb22a0
md"Let's consider this example"

# ╔═╡ 7f67b94e-495d-4605-b0f4-7978a323a798
abstract type AbstractAlgorithm end

# ╔═╡ 9b214cfc-a24e-4e4d-86e3-71451f647268


# ╔═╡ 4f55481e-7884-4dd8-92ab-14a9fedd2840
md"#### Our `AbstractAlgorithm` Interface:

We assume that everything which is more specific than `AbstractAlgorithm`
has at least a function
```julia
minimise(::Function, ::AbstractAlgorithm)
```


Now, how could someone implement an algorithm? Just define the needed functions!
"

# ╔═╡ 685f46ae-e3dd-4514-bba2-393602831d3a


# ╔═╡ 7f40cabc-8ce8-4ecc-b22e-1dc62bd8b648
struct RandomSolver <: AbstractAlgorithm 
	
	domain::Tuple{Float64, Float64}
	n_steps::Int64
	
end

# ╔═╡ 7e32559f-7148-472a-bff0-2777bd0df755
random(d::Tuple{Float64,Float64}) = d[1] + (d[2]-d[1]) * rand()

# ╔═╡ f6c9269f-56a1-4e23-a7c7-93783c149e84
function minimise(f, r::RandomSolver)
	minimum( f( random(r.domain) ) for i in 1:r.n_steps )
end

# ╔═╡ 75c1c92f-1e03-4ec3-86dc-65cfb2bfe35e


# ╔═╡ d2e013da-c752-4fe8-a020-c67a5e89c397
bigbreak

# ╔═╡ 9705e4c1-1fdf-40aa-be08-b2df34715d11
md"## Exercises"

# ╔═╡ bfb72e16-8e42-430b-921a-cec2818eaf24


# ╔═╡ 5d2e637e-3f40-49d2-9f4b-59b7c1ee6afe
md"""
7.1

Define your own type, which represents a point on a circle.
Implement a add function, so that two points on a circle can be added!

It should allow operations such as
```julia
CirclePoint( π ) + CirclePoint( π ) == CirclePoint( 0.0 )
```

"""

# ╔═╡ ef533b3f-b705-461f-a590-b0a11fa05f52


# ╔═╡ 38599bbf-6e45-49d8-a117-2d1822688bed
bigbreak

# ╔═╡ 16dc8591-a6b3-4256-bbd9-093548352449
md"""
7.2 

Implement your own an `AbstractAlgorithm`, call it `GridAlgorithm` which is compatible with the code below!

The algorithm should try to find the minimum of a function by evaluation of equidistant grid points in it's domain.

"""

# ╔═╡ ac3f9a7f-ecdf-486a-a3df-a7bdd3d91012
struct GridAlgorithm

end

# ╔═╡ c577d146-2b43-4820-956e-c708861e8881
# minimise( x -> x^2,   GridAlgorithm( (-10, 10),  10000) )

# ╔═╡ d638bc5e-44b5-401b-a4ce-e47552c28960


# ╔═╡ f2d11973-64b6-47b5-b34a-c4ae9405be0b
md"Imagine someone wrote code to allow solution of multidimensional functions.

*Does this `ProcutAlgorithm` still work with your implementation?*"

# ╔═╡ 97c78e41-21e5-46b0-b06f-c754143cae0c
struct ProductAlgorithm <: AbstractAlgorithm
	algs::Vector{AbstractAlgorithm}
end

# ╔═╡ 4e2e930c-8e2b-4bd3-98f1-ae35055d7b81
function minimise(f::Function, r::ProductAlgorithm)
	N = length(r.algs)
	x0 = zeros(N)

	for i in 1:N
		f_i = x -> f( [( j == i ) ? x : x0[j] for j in 1:N] )

		x_i = minimise( f_i, r.algs[i] )
		x0[i] = x_i
	end

	return x0
end

# ╔═╡ d69d58e1-a9d2-4933-a78e-a5cecc0c0c82
minimise( x -> x^2,   RandomSolver( (-10, 10),  10000) )

# ╔═╡ ced56d45-1a1d-4389-bb9d-5067e8500628
minimise( x -> x[1]^2 + x[2]^2, 
			ProductAlgorithm( [RandomSolver( (-10.0, 10),  1000), 
								RandomSolver( (-10.0, 10),  1000)] ))

# ╔═╡ 7383fa13-825b-4e65-af4a-3e90533ca342
bigbreak

# ╔═╡ c09a103b-d086-4718-90d5-9cd59d972286
md"""
7.3 Optional: (Object oriented programming)

Let's imagine three datatypes
"""

# ╔═╡ af24c0dd-b37f-420a-83bd-59e2ccddf17c
abstract type AbstractScientist end  

# ╔═╡ fe617e26-b9cb-4252-bb14-45c1514e6c0f
struct Scientist <: AbstractScientist
	name
	field
end

# ╔═╡ e4a7b64f-8c2a-4077-aefb-8e8b9f22f65b
struct Mathematician <: AbstractScientist
	name
	field
	specialisation
end

# ╔═╡ a2fdbb49-dc6c-4ca7-affa-1639b62b7e10
md"""
Task: Complete the code below, such that scientists say "Hi, my name is Anna, I work in the chemisty department".

But mathematicians just say, "Hi, I'm Axel. Do you like optimisation."
"""

# ╔═╡ 7fd35958-c367-4002-9cea-482e0d1f495a
begin
	# your solution
	sayhi(x) = "Hello" # define the function appropriately 
	
end

# ╔═╡ c106b584-471d-4ef7-b14d-ea2c82b9385b
with_terminal() do 
	s = Scientist("Anna", "chemistry")
	m = Mathematician("Axel", "mathematics", "optimisation")

	println( sayhi(s) )
	println( sayhi(m) )
	nothing
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

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
# ╟─a2a0a0d7-b457-40bd-ae6b-da14cc557031
# ╟─9426ed50-83ae-11ec-34f2-2f8e36fc8d05
# ╟─869614f3-f243-4319-9f8f-64c3cc13eb97
# ╠═70d2151b-0de1-41c2-a73a-7ee6f01a2d9f
# ╟─24eabc0b-496b-4159-8da6-29910b85ea4f
# ╠═996a3423-bd55-49d7-9401-d270b6e109c1
# ╠═909cc091-b321-4752-9f7a-62d1aa3a3a3d
# ╠═be82d829-d6c3-4822-8f57-3f0727776817
# ╠═3528ea22-89da-4330-9b66-49fdfef87687
# ╟─260566f0-c909-41a2-9ebf-ddb8103635f4
# ╟─8f62d5bd-764b-49e5-9b00-05d9f90332f9
# ╟─1515c0ab-f7ed-4273-9b64-c810abbaf941
# ╟─5790a006-640d-4751-a690-b139654049c6
# ╠═62ee2d5b-d757-47db-9019-37622330e9bc
# ╟─dbd7131b-05a9-4d70-8864-d5ca9b2fe9c5
# ╠═3c7c5961-014d-47c6-8ffa-cd06198682ce
# ╟─b9a4a4ac-c07f-4f73-aa48-dbfa123a267a
# ╠═6643612d-d1a6-4fdc-8398-e12682891eb0
# ╠═cb9e96e1-597a-4b0e-912a-1972c84edd5f
# ╟─0fbd5d9a-30dc-4e73-9bff-c088768de5ab
# ╠═4a9409d1-d04d-459c-93a2-fd47315a1c27
# ╟─1dc516fd-b6de-466c-8cc2-ec56301cebba
# ╠═49044d10-11a2-44e7-9a86-481ddfd595c4
# ╟─35345440-550c-4723-9aec-e08142ff0802
# ╟─7c12b757-8ca5-4d2b-92b0-d204f94e6d0b
# ╠═292ee470-e286-47ea-8065-92ad2fc824d7
# ╟─55485242-77c4-43ec-996d-c1177ab34ecf
# ╟─ee6fa527-4d43-4b51-baa3-2cb2fa57d81b
# ╠═f491e000-1f10-443d-bf18-18a413f8cf94
# ╟─c13de59d-508e-4472-a602-17d334337ca4
# ╟─2dc06114-7f29-4021-943d-e2b14f787e3d
# ╟─95fbd51f-62a0-4167-9478-452420d19369
# ╟─91185b65-573b-42de-8238-3cd046aa5b98
# ╠═fa237ef5-f1df-4826-8062-81e061be64a2
# ╠═f01b0192-2a01-4e04-905b-3500c84c52c1
# ╠═5e55db0d-6245-47e6-ac65-6a37d66758ae
# ╠═1ab4ba54-b86c-46ec-8852-326223fce26b
# ╟─72fec38d-4c24-4356-97de-71a2914b821f
# ╟─82209778-7d13-49fd-9812-1d534ad79a49
# ╟─94b65eff-9df8-4621-9a92-74ae0a0c8052
# ╠═5fa76a28-b1d4-4c94-a7b8-5057115caa7a
# ╠═aa7189d4-53a5-4c54-bfdb-c8b242be2613
# ╟─7fc21ab5-52d9-4b12-a0c9-780cf2c62c75
# ╠═8ad53b1a-55c3-4a85-9f06-0ecd01305120
# ╠═2c21a7fe-3223-46d4-af30-296045c905ec
# ╠═d7a61c32-0ed9-4d04-91e1-d6849057df2d
# ╠═fc842dae-373f-4ec5-815e-e25193fce8fe
# ╟─9c4c826b-f1a8-43f9-a50c-455826223402
# ╟─4f962f52-99e4-4d2c-a16c-7b187b03d9d6
# ╟─e02cf43c-3389-4020-b2cc-57f201cee0aa
# ╠═0bfee97a-6b2c-42d7-b095-b356f5858bc0
# ╠═4120837d-749b-4813-b53f-0ab22bceacee
# ╟─08facfc2-4b2b-4055-891b-b8ea6b0b61d0
# ╠═27352174-d77c-4d61-bcf4-b897e451c5f6
# ╠═e355c3b9-470d-447a-8208-cf99dfbceadc
# ╠═99f36b6d-ade6-4f37-8dfb-76c967c445d9
# ╟─cebfa1b4-6876-41ac-b219-032f061f44ac
# ╟─665b754d-be3e-4982-8e03-02d1b5fbbf39
# ╟─7bf7c3c4-85cd-4d86-bbb1-933a7d5c8328
# ╟─40d2b89f-802d-441d-8053-ffd95feb22a0
# ╠═7f67b94e-495d-4605-b0f4-7978a323a798
# ╟─9b214cfc-a24e-4e4d-86e3-71451f647268
# ╟─4f55481e-7884-4dd8-92ab-14a9fedd2840
# ╟─685f46ae-e3dd-4514-bba2-393602831d3a
# ╠═7f40cabc-8ce8-4ecc-b22e-1dc62bd8b648
# ╠═7e32559f-7148-472a-bff0-2777bd0df755
# ╠═f6c9269f-56a1-4e23-a7c7-93783c149e84
# ╟─75c1c92f-1e03-4ec3-86dc-65cfb2bfe35e
# ╠═d69d58e1-a9d2-4933-a78e-a5cecc0c0c82
# ╟─d2e013da-c752-4fe8-a020-c67a5e89c397
# ╟─9705e4c1-1fdf-40aa-be08-b2df34715d11
# ╟─bfb72e16-8e42-430b-921a-cec2818eaf24
# ╟─5d2e637e-3f40-49d2-9f4b-59b7c1ee6afe
# ╠═ef533b3f-b705-461f-a590-b0a11fa05f52
# ╟─38599bbf-6e45-49d8-a117-2d1822688bed
# ╠═16dc8591-a6b3-4256-bbd9-093548352449
# ╠═ac3f9a7f-ecdf-486a-a3df-a7bdd3d91012
# ╠═c577d146-2b43-4820-956e-c708861e8881
# ╟─d638bc5e-44b5-401b-a4ce-e47552c28960
# ╟─f2d11973-64b6-47b5-b34a-c4ae9405be0b
# ╠═97c78e41-21e5-46b0-b06f-c754143cae0c
# ╠═4e2e930c-8e2b-4bd3-98f1-ae35055d7b81
# ╠═ced56d45-1a1d-4389-bb9d-5067e8500628
# ╟─7383fa13-825b-4e65-af4a-3e90533ca342
# ╟─c09a103b-d086-4718-90d5-9cd59d972286
# ╠═af24c0dd-b37f-420a-83bd-59e2ccddf17c
# ╠═fe617e26-b9cb-4252-bb14-45c1514e6c0f
# ╠═e4a7b64f-8c2a-4077-aefb-8e8b9f22f65b
# ╟─a2fdbb49-dc6c-4ca7-affa-1639b62b7e10
# ╟─7fd35958-c367-4002-9cea-482e0d1f495a
# ╠═c106b584-471d-4ef7-b14d-ea2c82b9385b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
