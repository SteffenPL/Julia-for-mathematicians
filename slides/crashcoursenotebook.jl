### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ d55bc09f-90f8-4a68-8f66-49a0538c682d
begin
	using PlutoUI
	using Test
	bigbreak = HTML("<br/>"^4)
	html"""<style>
main {
    max-width: 1200px;
}</style>"""
end

# ╔═╡ 67910dd6-000d-4d10-9473-be3a5944cf5d
md"
# Crash-course: _Understanding_ Julia

## The origin story of Julia. 🥚 🐔

The _'two language problem'_

> Scientific computing has traditionally required the highest performance, yet domain   experts have largely moved to slower dynamic languages for daily work. 

Our answer
> The Julia programming language is a **flexible dynamic language**, appropriate for scientific and numerical computing, **with performance comparable to traditional statically-typed** languages.
"

# ╔═╡ 4ef295dd-11e0-4fe2-9c11-9a0e8a27f2ab
html"""<img src="https://julialang.org/assets/benchmarks/benchmarks.svg""></img>"""

# ╔═╡ b54a2e64-0303-4ff6-82f4-fb3f91f9b771
html"""<h3>In this course we will learn <span style="color:#38f"><i>why</i> Julia is fast</span> and the basics of <span style="color:#f84"><i>programming</i> in Julia</span>.</h3> """

# ╔═╡ c5a7ba98-0f68-414d-8923-2c35caac34cc
bigbreak

# ╔═╡ 9138271c-ddfe-4181-9506-ba3922593163
md"""
### We will use material from:
0. [JuliaAcademy: Introduction to Julia](https://github.com/JuliaAcademy/Introduction-to-Julia)
1. [The manual from the official Julia documentation](https://docs.julialang.org/en/v1/manual/getting-started/),
2. [The Fast Track to Julia (cheat-sheet)](https://steffenpl.github.io/Julia-Cheat-Sheet/).
4. [MATLAB–Python–Julia (cheat-sheet)](https://cheatsheets.quantecon.org/)
5. [Makie.jl Plotting function examples](https://makie.juliaplots.org/stable/examples/plotting_functions/)


!!! correct "Hint: Where to find details?" 
	If you need more details on a specific topic, read the **the official documentation**! It is _actually_ **well-written** and an **excellent introduction**!

"""

# ╔═╡ e1ffc859-b8f7-4f74-aa64-c83041e5c808
bigbreak

# ╔═╡ 9a7536a5-5c0f-4514-a64a-02504b1bad46
md"""
## Outline

**Today:**
- Intro
- The Julia RELP and Juno IDE
- Essential data types
- Control flow
- Arrays and functions
  
**Tuesday:**
- Scope of variables
- The type system and multiple dispatch
- Custom datatypes 
- The package manager
- Plotting _(with Makie.jl)_


**Wednesday:**
- Linear Algebra
- More plotting
- Interfaces
- Parametric methods and types

**Thursday:**
- Modules
- Testing
- Workflow
- ... (let's see were we end up)

"""

# ╔═╡ cf47e80d-a42d-4df0-81b0-9360b9decae9
bigbreak

# ╔═╡ 6592ddea-7126-458d-8a38-f058ab3cb366
html"""<h2>Disclaimer: Julia is <span style="color:red;">not</span> <i> simply "MATLAB but faster"</i>!</h2>"""

# ╔═╡ bfd077aa-8c54-44b0-bafb-67cb1f8e7176
md"Even if similar on the surface, those languages are very different."

# ╔═╡ 3545e4f9-df86-4261-943b-e79a48274716
md"""
Imagine this MATLAB code (taken from the official documentation):
```julia
# MATLAB code
x = -2:0.25:2;
y = x;
[X,Y] = meshgrid(x, y);

F = X.*exp(-X.^2-Y.^2);
```
"""

# ╔═╡ 273be1ff-58b0-4dab-9726-80b1fa8aa0c1
md"Typical naive translation to Julia *could* look like this:"

# ╔═╡ 1af43c9b-151f-4b22-aa88-110ad018e0ad
meshgrid(x,y) = x * one.(y'), one.(x) * y'   # Julia does not have meshgrid function, let's just make one for this example 	

# ╔═╡ ae2fc32c-a471-4e64-9d33-e9e6bf677166
let
	x = -2:0.25:2
	y = x
	X, Y = meshgrid(x, y)
	
	F = X .* exp.( -X.^2 - Y.^2 )
	
	F[1:3,1:3]
end  # hide output

# ╔═╡ 3608f7cf-86e3-4cdb-ada6-46c6beb3310a
md"...but there is a small problem here:"

# ╔═╡ b6406021-00e6-419f-8e15-9f80196433eb
md"""
!!! danger "MATLAB ≠ Julia"
	Good MATLAB code is often poor Julia code. *(And vice versa!)*

However, good Julia code is often still pretty (and usually needs much less memory)!
"""

# ╔═╡ be19363a-dfd3-430e-b1c9-f8b69309411d
let 
	xs = -2:0.25:2
	ys = xs
	
	F = [x * exp( -x^2-y^2 ) for x in xs, y in ys]
	
	F[1:3,1:3]
end

# ╔═╡ 0c50f149-4cea-4793-acd2-91b58595dc3b
md"""
### 👉 Do not blindly apply MATLAB or python tips to Julia!

Check out the [Noteworthy Differences from other Languages](https://docs.julialang.org/en/v1/manual/noteworthy-differences/) if you want to see more! *(We will see some of these later.)*

Most prominent difference: There is often no reason to avoid `for` loops in Julia!
"""

# ╔═╡ a725c129-1f57-47d3-810c-bfee4f600bcf
md"""#### ☝ Important: In Julia, the first index is "1" *and not zero*.
*(For all non-MATLAB users: I feel you, but that's how it is.)*"""

# ╔═╡ 80986d60-d993-4293-bd22-72cdef15988b
bigbreak

# ╔═╡ 9bccf94a-19d1-4d31-82d5-d882b1fd1e29
md"## Task #0: How to work with Julia in the terminal (aka REPL) and the Juno IDE."

# ╔═╡ 711dc218-0d78-4a39-a380-bc461e249ba5
bigbreak

# ╔═╡ 7bcf336b-c2dc-40ad-bb43-82fbca1c8565
md"""## Task #1: Compute 1+2 with Julia

...let's call it the mathematician's Hello World 😜
"""

# ╔═╡ e42073de-0d42-42c3-9f1a-53f2ff54b91c
bigbreak

# ╔═╡ 52fb0f4d-c1c0-4ca2-9bd1-913414fcf9c8
md"""
## Task #2: Some basic math
!!! correct "Warm-up: Fibonacci numbers"
    Compute the first 100.000 Fibonacci numbers (using a `for` loop).
"""

# ╔═╡ 20b697f4-0bf2-426b-ae3b-a3864386cc19
bigbreak

# ╔═╡ 6714a575-dc6a-4926-bcfa-349b91aca16e
md"# This looks just like MATLAB! Why is that faster?"

# ╔═╡ 5c66ea8a-ca3e-4d07-b16c-8f4015f87671
html"<h3>The answer is not as simple as it might seem...</h3>"

# ╔═╡ 5efe07fc-b7e4-4069-83c6-b1534c39ac99
md"""
Let's consider a simple function, like this generic `add(x,y) = x + y`.

The first time we call `add` with new input types, 
the Julia **just-in-time** (JIT) compiler generates a code with *static types* and compiles that!
"""

# ╔═╡ 172cf452-791b-4d7a-934a-0dfa05374e14
add(x,y) = x+y

# ╔═╡ 8d9ca351-c8f6-49bd-8a91-2c34e883d0c4
md"For `(Int64, Int64)`"

# ╔═╡ 3675a743-1ddc-4cd4-b954-8ca354bea723
with_terminal() do 
	@code_llvm debuginfo=:none add(1,2) 
end

# ╔═╡ d533573e-10fd-4480-9b17-93ef3dacb91e
md"For `(Float64, Float64)`"

# ╔═╡ 2e34f342-f0a8-4e62-a4bc-6bda81c5b0c6
with_terminal() do 
	@code_llvm debuginfo=:none add(1.0,2.0) 
end

# ╔═╡ 6c9df6b6-746a-4721-b77b-52718abab2e5
md"Doing the same in a for loop is still fast!"

# ╔═╡ 549a0344-a442-4dfd-b01f-f1b06723df7e
function add_4_numbers(x,y)
	z = zero(eltype(x))
	@inbounds for i in 1:4
		z += x[i] + y[i]
	end
	return z
end

# ╔═╡ ab6b4c8b-0b62-4c50-bf2f-f9b969d23aff
with_terminal() do 
	@code_llvm add_4_numbers([1,2,3,4],[1,2,3,5])
end

# ╔═╡ dd6dff51-8765-48da-9ccc-6fb6ca228bff
bigbreak

# ╔═╡ 299f6a19-a805-4ff2-8108-95dd94a5bb6d


# ╔═╡ 92da736b-2da2-43bb-9c8c-c661a327acc0
md"""
### Meeting Julia's JIT compiler and type stability

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
PlutoUI = "~0.7.30"
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
git-tree-sha1 = "92f91ba9e5941fc781fecf5494ac1da87bdac775"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5c0eb9099596090bb3215260ceca687b888a1575"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.30"

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
# ╟─d55bc09f-90f8-4a68-8f66-49a0538c682d
# ╟─67910dd6-000d-4d10-9473-be3a5944cf5d
# ╟─4ef295dd-11e0-4fe2-9c11-9a0e8a27f2ab
# ╟─b54a2e64-0303-4ff6-82f4-fb3f91f9b771
# ╟─c5a7ba98-0f68-414d-8923-2c35caac34cc
# ╟─9138271c-ddfe-4181-9506-ba3922593163
# ╟─e1ffc859-b8f7-4f74-aa64-c83041e5c808
# ╟─9a7536a5-5c0f-4514-a64a-02504b1bad46
# ╟─cf47e80d-a42d-4df0-81b0-9360b9decae9
# ╟─6592ddea-7126-458d-8a38-f058ab3cb366
# ╟─bfd077aa-8c54-44b0-bafb-67cb1f8e7176
# ╟─3545e4f9-df86-4261-943b-e79a48274716
# ╟─273be1ff-58b0-4dab-9726-80b1fa8aa0c1
# ╠═1af43c9b-151f-4b22-aa88-110ad018e0ad
# ╠═ae2fc32c-a471-4e64-9d33-e9e6bf677166
# ╟─3608f7cf-86e3-4cdb-ada6-46c6beb3310a
# ╟─b6406021-00e6-419f-8e15-9f80196433eb
# ╠═be19363a-dfd3-430e-b1c9-f8b69309411d
# ╟─0c50f149-4cea-4793-acd2-91b58595dc3b
# ╟─a725c129-1f57-47d3-810c-bfee4f600bcf
# ╟─80986d60-d993-4293-bd22-72cdef15988b
# ╟─9bccf94a-19d1-4d31-82d5-d882b1fd1e29
# ╟─711dc218-0d78-4a39-a380-bc461e249ba5
# ╟─7bcf336b-c2dc-40ad-bb43-82fbca1c8565
# ╟─e42073de-0d42-42c3-9f1a-53f2ff54b91c
# ╟─52fb0f4d-c1c0-4ca2-9bd1-913414fcf9c8
# ╟─20b697f4-0bf2-426b-ae3b-a3864386cc19
# ╟─6714a575-dc6a-4926-bcfa-349b91aca16e
# ╟─5c66ea8a-ca3e-4d07-b16c-8f4015f87671
# ╟─5efe07fc-b7e4-4069-83c6-b1534c39ac99
# ╠═172cf452-791b-4d7a-934a-0dfa05374e14
# ╟─8d9ca351-c8f6-49bd-8a91-2c34e883d0c4
# ╠═3675a743-1ddc-4cd4-b954-8ca354bea723
# ╟─d533573e-10fd-4480-9b17-93ef3dacb91e
# ╠═2e34f342-f0a8-4e62-a4bc-6bda81c5b0c6
# ╠═6c9df6b6-746a-4721-b77b-52718abab2e5
# ╠═549a0344-a442-4dfd-b01f-f1b06723df7e
# ╠═ab6b4c8b-0b62-4c50-bf2f-f9b969d23aff
# ╟─dd6dff51-8765-48da-9ccc-6fb6ca228bff
# ╠═299f6a19-a805-4ff2-8108-95dd94a5bb6d
# ╟─92da736b-2da2-43bb-9c8c-c661a327acc0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
