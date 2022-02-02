### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ 31e93532-d915-4638-ac42-6d5a8b51472e
using PlutoUI

# ╔═╡ 9ba84189-80cd-4760-9e48-feca71f313c5
using DualNumbers

# ╔═╡ a37e3c58-bd22-4bc6-b003-bb8d350d49ed
using Unitful

# ╔═╡ b4b177dd-97db-4a6d-987c-64426b90bd51
bigbreak = HTML("<br>"^4);

# ╔═╡ 47e2cc32-8290-11ec-2253-e528a7b8198e
md"""
# Multiple dispatch ⭐ 
"""

# ╔═╡ ab103ac0-dba1-4f4f-91d8-3872f234436f
md"""### Starting with the familiar: Generic functions

If we write generic functions, Julia will figure out the types and try to make sense of it (if possible):
"""

# ╔═╡ 808b1e07-2912-4417-aef7-1b5de503e244
f(x) = x.^2

# ╔═╡ 849bd1c6-969b-479e-b519-f5d444bcb840
md"Hence, all of these inputs work:"

# ╔═╡ 67437820-a50b-49f2-af6b-7ba80277103e
(
	f_int    = f(1), 
	f_array  = f([1,2]), 
	f_string = f("hi")
)

# ╔═╡ e0fd7d97-187e-4937-9ca1-6473e167de4a
bigbreak

# ╔═╡ 19e8f83e-ca03-4677-9c6a-44f392d92a12
md"Indeed, under the hood, Julia does compile for all of these inputs specialised functions:"

# ╔═╡ 3e6b096d-58d3-46a6-8936-93186042c9b7
with_terminal() do 
	@code_llvm f( (1.0, 1.0,1.0, 1.0) )
end

# ╔═╡ a213f381-52bf-4008-815e-b3c007b08b50
with_terminal() do 
	@code_llvm f( [1.0, 1.0, 1.0] )
end

# ╔═╡ e6fc063f-19ef-4af4-b476-2c28ba161a93
md"""
### Short interlude

If you want to deep dive into how Julia works, it is often very interesting to check how Julia actually converts simple commands. 
It needs some time to get used to the output, but it is worth it!

The `@code_*` commands are
```julia
@code_lowered f(x)   # Julia's internal representation after removing syntax sugar
@code_warntype f(x)  # highlighted lines mark type instabilities
@code_llvm f(x)      # the final product of the Julia JIT compiler
@code_native f(x)    # after optimisation with the LLVM for your machine
```

"""

# ╔═╡ 08714061-f90d-45f7-83ad-191b8d309e74


# ╔═╡ 2a255075-0bf6-4347-bf2a-1ded087d2514


# ╔═╡ 08d4c62e-1265-4925-8465-9ff1904057a3


# ╔═╡ 93051f8a-7802-4a2b-891b-46037a7f97b3
md"## Specifying the types

Sometimes the same function needs different implementation depending on the type:
"

# ╔═╡ 1c2b3808-ce65-4313-9380-58a42844eba9
begin
	# this function picks randomly between a and b:
	random(a, b) = rand([a,b])

	# integers between a and b
	random(a::Int64, b::Int64) = rand(a:b)

	# floats between a and b
	random(a::Float64, b::Float64) = a + (b-a)*rand()
end

# ╔═╡ 1ff517d6-2145-4ab5-93e2-faeb0882dcdc
methods(random)

# ╔═╡ 4292041a-db6d-4235-809e-3bac423a7342
random(1.0, 2.0)

# ╔═╡ c0834dbb-0128-4219-a119-6df81bf876e4
random(1, 6)

# ╔═╡ a92b084e-ede0-408b-8bee-f8508fc2a470
random(1, 6.32)

# ╔═╡ 6682b551-f8da-4bc9-ad77-d41444ba6022


# ╔═╡ a9c019a5-a08e-467a-b635-fab0debd158d
md"#### Definition:

- **A function** (say `random`) is identified by the function name. 
- The **different implementations** (say `random(::Int64,::Int64), ...`) of the function **are called methods**. 
Hence, each function can have several methods.
"

# ╔═╡ 97036832-f4ca-4b34-b2da-6857439d529b


# ╔═╡ 88d8106c-2008-455b-a42a-fa3dd582c831
md"### → Julia always applies the most specific method for the given inputs!

These methods could overlap in crazy ways! _(It (usually) just works!™)_"

# ╔═╡ e53b709a-dd90-4a8c-bc59-781c685f4954


# ╔═╡ 2f381972-5972-4369-bb2d-67d01199eaf2


# ╔═╡ 2161f348-7efe-4cd0-b998-2d301fac22e4
md"## The key point of multiple dispatch

We want maximal control about how functions look for different types.


Multiple dispatch is
- **dynamic**
  - deciding at runtime what to do
- **modular**
  - reducing duplicate code
- **extensible**
  - allowing to add something to existing code
- **~ fast**
  - trying to keep amount of recomplilation minimal
 
(see: [Expression problem](https://en.wikipedia.org/wiki/Expression_problem))
"

# ╔═╡ 54eac40f-31aa-4df5-a1e6-3b863c12198f


# ╔═╡ 433fca14-845a-4267-b6be-b4ea1d9100c4
bigbreak

# ╔═╡ dd260866-8e10-4b36-a62f-2f930617e579
md""" 
## The type hiearachy

How does Julia decide which method to call?


#### With a partial ordering `<:` on all types! 🧮 😎
"""

# ╔═╡ ba329815-e6bd-410f-82b4-bc7f89655661
Float64 <: Real <: Number

# ╔═╡ b7751fd9-6d65-4d5f-a570-4d71af818132
Int64 <: Integer <: Real <: Number

# ╔═╡ 72476e34-5ff3-48bf-848b-3e9be57faca3
Float64 <: Integer

# ╔═╡ 2431f98b-4e98-4528-acf6-65e27abb08c7
String <: AbstractString <: Any

# ╔═╡ f38fccdb-167c-44bd-8d9d-c3ae2fb79db7
Vector{Float64} <: Vector <: AbstractArray

# ╔═╡ ba7efcc8-479f-409b-846f-2696001d7a6b


# ╔═╡ 1ca91764-5f29-403e-8417-7d7cbb55042f
md"For each input with types `T1, T2, T3, ...`, Julia calls basically the method with input types

$\inf \{ \mathbf{S} \mid \text{method with argument types } \mathbf{S} \text{ exists and } \mathbf{T} <: \mathbf{S} \}$ 

with respect to the type ordering `<:`."

# ╔═╡ de4767b1-e882-4c55-9d22-0b91cc0d49d9
begin 
	g(x::Number) = x
	g(x::Real) = x^2
	g(x::Float64) = x^3
end

# ╔═╡ 4d2f8eaa-fd3f-4b65-a804-7c1658a319c8
g( 1 + 2im )

# ╔═╡ 8d6623d2-60cf-43e7-b040-6787e8b7edad
g(3.0)

# ╔═╡ 97919302-24c5-4d6e-829b-c973f04da574
supertype(supertype(supertype(Int64)))

# ╔═╡ 352f54bf-3520-4f1c-9124-8d2871466e47
bigbreak

# ╔═╡ ce1a54c5-1ff0-4458-82f5-a1984b5be4fc
md"**Quick exercise:**

Find a case in which Julia cannot determine which method to call!"

# ╔═╡ b31fdae8-76f1-4998-945b-ca37f6173c0f


# ╔═╡ 82a2733a-da60-485f-8482-6189101933aa


# ╔═╡ 32a1a877-2146-4e8e-90c1-3b021b6d9348
md"**Note:** A case which is important to keep in mind is this one:"

# ╔═╡ 0a9e5987-869d-4b10-987d-4408769894c1
Vector{Int64} <: Vector{Integer}

# ╔═╡ 9eb5aa13-7df1-4f2d-8f9b-d2b8b7e13a84
md"However, with so called _parametric types_ we can handle that:"

# ╔═╡ 57e75a99-1af9-452e-af11-81157551c12e
Vector{Int64} <: Vector{T} where T <: Integer

# ╔═╡ 61b1d73d-f7c3-4136-b92b-3a95b5143d2c
bigbreak

# ╔═╡ e97156d1-bea8-491f-b190-5c95d9a5b536
md"### How is that related to Object Oriented Programming?

> Yes and No: Multiple dispatch is more flexible 😃, but less ordered 😢.

In other words: OOP ensures that the programmer does not too stupid things. In Julia you can literally be a **type pirate** ☠.
"

# ╔═╡ c000aa68-b1ab-40ed-9376-32be9c51dc1a
md"
#### Short interlude: Let's be a type pirate ☠
_Run for example: `Base.:+(x::Float64, y::Float64) = 0.0` in a Julia REPL and compute `sin(1)`. (Afterwards, do something like that never again!)_
"

# ╔═╡ 4737b51a-539e-45ec-bf32-e3798d5ae5cd


# ╔═╡ c7a2a4bd-3e1d-438f-9270-725c3c9616f8
md" → You should usually only define methods for your custom types. Don't mess too much with other peoples types or it will backfire!"

# ╔═╡ 19412b07-a5ce-4c7a-b193-2b5e60c521f7
bigbreak

# ╔═╡ e4b689a9-f03a-4e28-8739-e018041d3c79
md"""
## Putting it all together: Being fast and generic is cool!


#### Example: (Derivative of solutions with respect to inital data)
"""

# ╔═╡ 3e537363-610e-40e0-8b8e-44e4713a17cd
md"Let's consider this simple implementation of a (scalar) explicit Euler method."

# ╔═╡ 4e965956-3633-4f4c-80ad-ff3f29958b54
function euler(f, x0::T, dt, n) where T
	x = zeros(T, n)
	x[1] = x0
	
	for i in 2:n
		x[i] = x[i-1] + dt * f(x[i-1])
	end
	return x
end

# ╔═╡ ae2eedbd-6cb8-4356-924f-eed0926f388b
sol = euler( x -> -sin(x), 1.0, 0.1, 100)

# ╔═╡ 9228a5bc-84d5-4e5e-a971-211ac9b47fe3


# ╔═╡ 65c828b1-ff10-4428-afd9-ec1748054a5b
md"Now, let's see what happens if we plug in another type of `Numbers`!"

# ╔═╡ 71449f89-4c20-4eb6-b41b-5ac39f2ab829


# ╔═╡ c8639b54-fef0-485a-8e8d-10d90ab6ef95
md"### Automatic differentiation"

# ╔═╡ aba97bf0-2519-4ebb-8ead-d7abb4042adb
dual_sol = euler( x -> -sin(x), Dual(1.0, 1.0), 0.1, 100)

# ╔═╡ b3a96ab1-2285-4db3-b67e-040278da2312


# ╔═╡ 6890676a-37eb-4808-8967-5ac17ec286f4
md"##### It just works!™

We have implemented a method to compute the gradient of the numerical solution with respect to initial data. (aka Automatic Differentiation)"

# ╔═╡ 39072267-77e1-4b7e-9efc-f0a904ebf587
md"""
The solution $x(t, x_0)$ of 

$\dot x = -\sin(x), \quad x(0) = x_0$

has approximately the derivative
$\frac{\partial x}{\partial x_0}(10, 1) ≈$ $(dualpart(dual_sol[end])).

_Notice that in order to do automatic differentiation, not a single line of the `euler` function had to change!_

"""

# ╔═╡ 6bf56af9-ad4f-417b-9356-9b582f9655e9


# ╔═╡ 91c8ea46-9fc4-4d94-94ec-0824555d4a2d
md"#### Units"

# ╔═╡ f5113d03-754f-4ace-91f3-27bf015cce9c
unit_sol = euler( x -> -x/u"hr", 1.0u"μm", 0.1u"s", 100)

# ╔═╡ 384f9598-abca-4727-8f26-037bc5f377bb


# ╔═╡ 5683bafe-96a6-404d-9ef3-4b493ac7e5e4


# ╔═╡ 7b92479f-2638-4bcc-822f-ce638a073d3c


# ╔═╡ 0a97a970-199e-4853-895e-fefc6d7753e6
md"### Unlimited possibilities to hijack this Euler method!"

# ╔═╡ fe5ad85b-f1d6-4d3e-a382-3d050c60c4cf
md"_Reminder:_ All of that compiled to almost C-like machine code!"

# ╔═╡ 8beec153-5a22-44b2-ae98-4cff82ec263c
bigbreak

# ╔═╡ e101a76d-d2ca-43c7-ab01-953c8397b7c9
md"""
# Exercises


7.1

A famous example for multiple dispatch is the
`Base.show(io, x)` function.

It is responsible for displaying Julia objects. 
_(It works for text, numbers, images, html, ... you name it, then you can implement it)._

Overwrite the show function for `Tuple{Float64,Float64}` such that it displays 
> 1 ❤ 2
when you call `print( (1,2) )`.

Hint: Use `print(io, ...)` to write something directly to input-output `io`.
"""

# ╔═╡ c1ed7bc2-2936-452c-b5b7-06de12adbe40
Base.show(io::IO, x::Tuple{Int64, Int64}) = nothing

# ╔═╡ 35f7e19f-bca1-4d5a-8f8d-dc4c4c77592e
with_terminal() do
	print( (1, 2+5) )
end

# ╔═╡ c79e90d9-d5e0-4f37-8abe-f49731a5d830
bigbreak

# ╔═╡ 716a277e-525b-4fed-81be-c8ceb50f9aec
md"""
7.2

Implement the product for `Tuple{Number,Number}` as
$(x,y) * (a,b) = xb - ya$

_Hint: The multiplication is called `Base.:*`_ 
"""

# ╔═╡ 8d48eb42-bbca-45c1-8c32-be9da3712835
Tup2f = Tuple{Number,Number} # if you want, you can use this type

# ╔═╡ 7e9c3310-e098-4e98-a02e-fdd905292f64
# enter your code here

# ╔═╡ 1fe523b2-f9b2-4a90-b45f-54dd9cb9dcd4


# ╔═╡ 214287e1-ac41-458a-aedf-16150f0b1da3
# (1.0,2) * (4,5) == -3.0  # test

# ╔═╡ 9b3fc16a-bee4-4917-92cf-41e64ab6ce39
bigbreak

# ╔═╡ e1befdce-9555-4a14-ad8e-48c64b4a74a6
md"""
7.3

Define a function `h` which returns the sum of integer arrays, but the product for all non-integer arrays. 
"""


# ╔═╡ 838b3265-4724-4e56-95f9-56566862ffff
# enter your code here

# ╔═╡ 35e901dc-93f1-4927-a6c7-c01a6934ca83
# h([1, 2]) == 3
# h([1.0, 2.0]) == 2.0

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DualNumbers = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
DualNumbers = "~0.6.6"
PlutoUI = "~0.7.32"
Unitful = "~1.10.1"
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

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f9982ef575e19b0e5c7a98c6e75ee496c0f73a93"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.12.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f74e9d5388b8620b4cee35d4c5a618dd4dc547f4"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.3.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "84f04fe68a3176a583b864e492578b9466d87f1e"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.6"

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

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

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

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

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

[[deps.NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

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

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "2cf929d64681236a2e074ffafb8d568733d2e6af"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.3"

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

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e6bf188613555c78062842777b116905a9f9dd49"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.0"

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

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "b95e0b8a8d1b6a6c3e0b3ca393a7a285af47c264"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.10.1"

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
# ╟─31e93532-d915-4638-ac42-6d5a8b51472e
# ╟─b4b177dd-97db-4a6d-987c-64426b90bd51
# ╟─47e2cc32-8290-11ec-2253-e528a7b8198e
# ╟─ab103ac0-dba1-4f4f-91d8-3872f234436f
# ╠═808b1e07-2912-4417-aef7-1b5de503e244
# ╟─849bd1c6-969b-479e-b519-f5d444bcb840
# ╠═67437820-a50b-49f2-af6b-7ba80277103e
# ╟─e0fd7d97-187e-4937-9ca1-6473e167de4a
# ╟─19e8f83e-ca03-4677-9c6a-44f392d92a12
# ╠═3e6b096d-58d3-46a6-8936-93186042c9b7
# ╠═a213f381-52bf-4008-815e-b3c007b08b50
# ╟─e6fc063f-19ef-4af4-b476-2c28ba161a93
# ╟─08714061-f90d-45f7-83ad-191b8d309e74
# ╟─2a255075-0bf6-4347-bf2a-1ded087d2514
# ╟─08d4c62e-1265-4925-8465-9ff1904057a3
# ╟─93051f8a-7802-4a2b-891b-46037a7f97b3
# ╠═1c2b3808-ce65-4313-9380-58a42844eba9
# ╟─1ff517d6-2145-4ab5-93e2-faeb0882dcdc
# ╠═4292041a-db6d-4235-809e-3bac423a7342
# ╠═c0834dbb-0128-4219-a119-6df81bf876e4
# ╠═a92b084e-ede0-408b-8bee-f8508fc2a470
# ╟─6682b551-f8da-4bc9-ad77-d41444ba6022
# ╟─a9c019a5-a08e-467a-b635-fab0debd158d
# ╟─97036832-f4ca-4b34-b2da-6857439d529b
# ╟─88d8106c-2008-455b-a42a-fa3dd582c831
# ╟─e53b709a-dd90-4a8c-bc59-781c685f4954
# ╟─2f381972-5972-4369-bb2d-67d01199eaf2
# ╟─2161f348-7efe-4cd0-b998-2d301fac22e4
# ╟─54eac40f-31aa-4df5-a1e6-3b863c12198f
# ╟─433fca14-845a-4267-b6be-b4ea1d9100c4
# ╟─dd260866-8e10-4b36-a62f-2f930617e579
# ╠═ba329815-e6bd-410f-82b4-bc7f89655661
# ╠═b7751fd9-6d65-4d5f-a570-4d71af818132
# ╠═72476e34-5ff3-48bf-848b-3e9be57faca3
# ╠═2431f98b-4e98-4528-acf6-65e27abb08c7
# ╠═f38fccdb-167c-44bd-8d9d-c3ae2fb79db7
# ╟─ba7efcc8-479f-409b-846f-2696001d7a6b
# ╟─1ca91764-5f29-403e-8417-7d7cbb55042f
# ╠═de4767b1-e882-4c55-9d22-0b91cc0d49d9
# ╠═4d2f8eaa-fd3f-4b65-a804-7c1658a319c8
# ╠═8d6623d2-60cf-43e7-b040-6787e8b7edad
# ╠═97919302-24c5-4d6e-829b-c973f04da574
# ╟─352f54bf-3520-4f1c-9124-8d2871466e47
# ╟─ce1a54c5-1ff0-4458-82f5-a1984b5be4fc
# ╟─b31fdae8-76f1-4998-945b-ca37f6173c0f
# ╟─82a2733a-da60-485f-8482-6189101933aa
# ╟─32a1a877-2146-4e8e-90c1-3b021b6d9348
# ╠═0a9e5987-869d-4b10-987d-4408769894c1
# ╟─9eb5aa13-7df1-4f2d-8f9b-d2b8b7e13a84
# ╠═57e75a99-1af9-452e-af11-81157551c12e
# ╟─61b1d73d-f7c3-4136-b92b-3a95b5143d2c
# ╟─e97156d1-bea8-491f-b190-5c95d9a5b536
# ╟─c000aa68-b1ab-40ed-9376-32be9c51dc1a
# ╟─4737b51a-539e-45ec-bf32-e3798d5ae5cd
# ╟─c7a2a4bd-3e1d-438f-9270-725c3c9616f8
# ╟─19412b07-a5ce-4c7a-b193-2b5e60c521f7
# ╟─e4b689a9-f03a-4e28-8739-e018041d3c79
# ╟─3e537363-610e-40e0-8b8e-44e4713a17cd
# ╠═4e965956-3633-4f4c-80ad-ff3f29958b54
# ╠═ae2eedbd-6cb8-4356-924f-eed0926f388b
# ╟─9228a5bc-84d5-4e5e-a971-211ac9b47fe3
# ╟─65c828b1-ff10-4428-afd9-ec1748054a5b
# ╟─71449f89-4c20-4eb6-b41b-5ac39f2ab829
# ╟─c8639b54-fef0-485a-8e8d-10d90ab6ef95
# ╠═9ba84189-80cd-4760-9e48-feca71f313c5
# ╠═aba97bf0-2519-4ebb-8ead-d7abb4042adb
# ╟─b3a96ab1-2285-4db3-b67e-040278da2312
# ╟─6890676a-37eb-4808-8967-5ac17ec286f4
# ╟─39072267-77e1-4b7e-9efc-f0a904ebf587
# ╟─6bf56af9-ad4f-417b-9356-9b582f9655e9
# ╟─91c8ea46-9fc4-4d94-94ec-0824555d4a2d
# ╠═a37e3c58-bd22-4bc6-b003-bb8d350d49ed
# ╠═f5113d03-754f-4ace-91f3-27bf015cce9c
# ╟─384f9598-abca-4727-8f26-037bc5f377bb
# ╟─5683bafe-96a6-404d-9ef3-4b493ac7e5e4
# ╟─7b92479f-2638-4bcc-822f-ce638a073d3c
# ╟─0a97a970-199e-4853-895e-fefc6d7753e6
# ╟─fe5ad85b-f1d6-4d3e-a382-3d050c60c4cf
# ╟─8beec153-5a22-44b2-ae98-4cff82ec263c
# ╟─e101a76d-d2ca-43c7-ab01-953c8397b7c9
# ╠═c1ed7bc2-2936-452c-b5b7-06de12adbe40
# ╠═35f7e19f-bca1-4d5a-8f8d-dc4c4c77592e
# ╟─c79e90d9-d5e0-4f37-8abe-f49731a5d830
# ╟─716a277e-525b-4fed-81be-c8ceb50f9aec
# ╠═8d48eb42-bbca-45c1-8c32-be9da3712835
# ╠═7e9c3310-e098-4e98-a02e-fdd905292f64
# ╟─1fe523b2-f9b2-4a90-b45f-54dd9cb9dcd4
# ╠═214287e1-ac41-458a-aedf-16150f0b1da3
# ╟─9b3fc16a-bee4-4917-92cf-41e64ab6ce39
# ╟─e1befdce-9555-4a14-ad8e-48c64b4a74a6
# ╠═838b3265-4724-4e56-95f9-56566862ffff
# ╠═35e901dc-93f1-4927-a6c7-c01a6934ca83
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
