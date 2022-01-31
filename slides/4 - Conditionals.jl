### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ d2e14b19-98d7-4fba-8bd9-bbbb47e002f6
begin
	bigbreak = HTML("<br>"^4);
	using PlutoUI
	using Test
end

# ╔═╡ ce3c8fde-802a-11ec-1b1a-31be58ae3474
md"""
# Conditionals
with the if keyword
In Julia, the syntax

```julia
if *condition 1*
    *option 1*
elseif *condition 2*
    *option 2*
else
    *option 3*
end
```
allows us to conditionally evaluate one of our options.

For example, we might want to implement the FizzBuzz test: 
given a number, N, print
-  "Fizz" if N is divisible by 3,
-  "Buzz" if N is divisible by 5, and
-  "FizzBuzz" if N is divisible by 3 and 5.

Otherwise just print the number itself! Enter your choice for N here:
"""

# ╔═╡ fd2ee11d-1734-457b-b587-4128b474b772
@bind N PlutoUI.Slider(1:20, show_value = true)

# ╔═╡ 7b619e85-abb8-4115-a9df-b5fedd04a8e4
md"N = $N"

# ╔═╡ da9796ce-4572-4d2d-bb96-5949f52d46d0
with_terminal() do 
	if (N % 3 == 0) && (N % 5 == 0) 
		# `&&` means "AND"; % computes the remainder after division
	    println("FizzBuzz")
	elseif N % 3 == 0
	    println("Fizz")
	elseif N % 5 == 0
	    println("Buzz")
	else
	    println(N)
	end
end

# ╔═╡ aca5d158-2902-4b7a-bf50-6f7a722f5ea7
md"""
with ternary operators
For this last block, we could instead use the ternary operator with the syntax
```julia
a ? b : c
```
which equates to
```julia
if a
    b
else
    c
end
```
"""

# ╔═╡ 8a3c8101-0c2a-438f-ba58-b80e9b14bc10
md"
Now let's say we want to return the larger of two numbers. Give x and y values here: "

# ╔═╡ 5732d2dc-c411-4c56-9720-ce6d979fc60f
x = 10

# ╔═╡ d993ffa0-c613-4b4b-baeb-a223ce408217
y = 30

# ╔═╡ 782a5034-9184-4a55-b877-bd0bb4e4aebb
md"Using the if and else keywords, we might write:
"

# ╔═╡ 14d69119-9a68-428b-a857-56298b42aee5
if x > y
    x
else
    y
end

# ╔═╡ 46533172-0fe1-406b-a52d-23305282d43b
md"and as a ternary operator, the conditional looks like this:"

# ╔═╡ b13c9cc4-3c4e-4416-896f-d5cbdc2d51c0
(x > y) ? x : y

# ╔═╡ fdfb1f2e-6105-43dd-92cf-4b78e1db8e73
bigbreak

# ╔═╡ 61aa9056-ebfe-4c06-a752-d081ece68167
md"""
## Exercises

5.1

Write a conditional statement that prints "negative", "zero" or "odd" according to the input number `N`.

"""

# ╔═╡ 75efd803-be55-4d0f-b8c8-6b63dd90d68c
md"""M = $(@bind M PlutoUI.Slider(-100:100, show_value = true)) """

# ╔═╡ 8f1298ab-309f-4d4d-8165-4ee522f3b1c8
with_terminal() do 
	# modify this cell to return "negative", "zero" and "positive".
	println(M)
end

# ╔═╡ 602b3c77-e46e-4592-a787-4aeed77eb059
bigbreak

# ╔═╡ c7c1ec65-49ed-4ae9-b9a9-0d82a346af81
md"""
5.2 

Use the ternary operator to construct a reasonable answer from Bob in the dialog below.
"""

# ╔═╡ 283c45af-47a3-4446-b873-205d8aa568e7
with_terminal() do 
	println("""
	Alice: Is the number $M even? 
	Bob:   I don't know.""")
end

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
# ╟─d2e14b19-98d7-4fba-8bd9-bbbb47e002f6
# ╟─ce3c8fde-802a-11ec-1b1a-31be58ae3474
# ╟─fd2ee11d-1734-457b-b587-4128b474b772
# ╟─7b619e85-abb8-4115-a9df-b5fedd04a8e4
# ╠═da9796ce-4572-4d2d-bb96-5949f52d46d0
# ╟─aca5d158-2902-4b7a-bf50-6f7a722f5ea7
# ╟─8a3c8101-0c2a-438f-ba58-b80e9b14bc10
# ╠═5732d2dc-c411-4c56-9720-ce6d979fc60f
# ╠═d993ffa0-c613-4b4b-baeb-a223ce408217
# ╟─782a5034-9184-4a55-b877-bd0bb4e4aebb
# ╠═14d69119-9a68-428b-a857-56298b42aee5
# ╟─46533172-0fe1-406b-a52d-23305282d43b
# ╠═b13c9cc4-3c4e-4416-896f-d5cbdc2d51c0
# ╟─fdfb1f2e-6105-43dd-92cf-4b78e1db8e73
# ╟─61aa9056-ebfe-4c06-a752-d081ece68167
# ╟─75efd803-be55-4d0f-b8c8-6b63dd90d68c
# ╠═8f1298ab-309f-4d4d-8165-4ee522f3b1c8
# ╟─602b3c77-e46e-4592-a787-4aeed77eb059
# ╟─c7c1ec65-49ed-4ae9-b9a9-0d82a346af81
# ╠═283c45af-47a3-4446-b873-205d8aa568e7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
