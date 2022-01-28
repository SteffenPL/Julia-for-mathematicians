### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ c12ef471-40b9-4b3e-81b6-6d10fa4e5f04
begin
	bigbreak = HTML("<br>"^4);
	using PlutoUI
	using Test
end

# ╔═╡ 58863e50-8029-11ec-28da-35397c3e293f
md"""
# Loops
Topics: 
1. `while` loops
2. `for` loops

## `while` loops 
The syntax for a while is
```julia
while *condition*
    *loop body*
end
```
For example, we could use while to count or to iterate over an array.

"""

# ╔═╡ e75a73ad-c49a-4d0d-a548-e96ed41cc5cc
let
	n = 0
	while n < 10
	    n += 1
	    println(n)
	end
	n
end

# ╔═╡ bfe2dd76-54a3-479e-9f94-efaecde8266b
with_terminal() do
	myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
	
	i = 1
	while i <= length(myfriends)
	    friend = myfriends[i]
	    println("Hi $friend, it's great to see you!")
	    i += 1
	end
end

# ╔═╡ ecd9ce51-6596-4a58-97d1-fbdee32ff1d8
bigbreak

# ╔═╡ 1e88489d-f123-4171-b406-47f6da914674
md"""
## `for` loops

The syntax for a for loop is
```julia
for *var* in *loop iterable*
    *loop body*
end
```
We could use a for loop to generate the same results as either of the examples above:
"""

# ╔═╡ 22ddbdaf-9483-417c-a702-317daa8c6537
with_terminal() do
	for n in 1:10
	    println(n)
	end
end

# ╔═╡ 3a38e1ef-7454-498d-af5d-876a9fa6e963
with_terminal() do
	myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
	
	for friend in myfriends
	    println("Hi $friend, it's great to see you!")
	end
end

# ╔═╡ f0390b57-a52e-4669-b992-2acd54f484da
bigbreak

# ╔═╡ f5a82c3e-47c6-4712-9c7e-7ff3fc1e5203
md"""
Now let's use for loops to create some addition tables, where the value of every entry is the sum of its row and column indices.

Note that we iterate over this array via column-major loops in order to get the best performance!

First, we initialize an array with zeros.

"""

# ╔═╡ 44c04d48-4e24-4034-b188-c92ba252ff22
begin
	m, n = 5, 5
	A = fill(0, (m, n))
end

# ╔═╡ 7a662dce-97fa-4c1c-ba60-51f6f147e808
begin
	for j in 1:n
	    for i in 1:m
	        A[i, j] = i + j
	    end
	end
	A
end

# ╔═╡ e2308376-31cd-4418-932c-8f166b4a316f
md"
Here's some syntactic sugar for the same nested for loop"

# ╔═╡ 0ae376b8-8451-46d7-9bb4-cc259a5b4557
B = fill(0, (m, n))

# ╔═╡ bf437047-2de0-4a5c-93d8-1ecab06dcda6
begin
	for j in 1:n, i in 1:m
	    B[i, j] = i + j
	end
	B
end

# ╔═╡ 4441001f-fd92-4f6b-9e5c-6daee5274d54
md"""The more "Julia" way to create this addition table would have been with an array comprehension."""

# ╔═╡ 2b9190e9-28c5-456f-97f4-b3b59b2d4957
C = [i + j for i in 1:m, j in 1:n]

# ╔═╡ 99eefdf8-3ea5-41fb-92cc-5655b5e92fc2
bigbreak

# ╔═╡ f77c41cd-a36e-4ec0-968c-f1842b703032
md"""
## Exercises

4.1

Loop over integers between 1 and 100 and print their squares.
"""

# ╔═╡ 7021bc95-71bf-4861-98d2-a3f358e5aae6
with_terminal() do 
	# write your code here
end

# ╔═╡ 33e4917e-ec98-44f5-85e4-b8f0c617f03c
bigbreak

# ╔═╡ e53d967c-d166-4208-a237-d4b692ab7431
md"""
4.2

Add to the code above a bit to create a dictionary, squares that holds integers and their squares as key, value pairs such that

```julia
squares[10] == 100
```
"""

# ╔═╡ 8a9b4ff0-1ebc-4546-9ac8-663c77d748c0
begin 
	squares = missing
end

# ╔═╡ ebab307a-1a97-48da-89f2-940cb7936c6e
begin
	@assert squares[10] == 100
	@assert squares[11] == 121
end

# ╔═╡ d5ba15fa-255c-4bef-bb9d-d165232cd009
bigbreak

# ╔═╡ e7eeb88a-2e15-487a-b9f4-177b81d52b09
md"""
4.3

Use an array comprehension to create an an array `squares_arr` that stores the squares for all integers between 1 and 100.

"""

# ╔═╡ 5c13e9a8-491b-4486-ac35-c54ed91791c7
begin
	squares_arr = Int64[]
end

# ╔═╡ 01e7c0a1-9d4d-4f20-8625-6f8c08eeb418
begin
	@assert length(squares_arr) == 100
	@assert sum(squares_arr) == 338350
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
# ╟─c12ef471-40b9-4b3e-81b6-6d10fa4e5f04
# ╟─58863e50-8029-11ec-28da-35397c3e293f
# ╠═e75a73ad-c49a-4d0d-a548-e96ed41cc5cc
# ╠═bfe2dd76-54a3-479e-9f94-efaecde8266b
# ╟─ecd9ce51-6596-4a58-97d1-fbdee32ff1d8
# ╠═1e88489d-f123-4171-b406-47f6da914674
# ╠═22ddbdaf-9483-417c-a702-317daa8c6537
# ╠═3a38e1ef-7454-498d-af5d-876a9fa6e963
# ╟─f0390b57-a52e-4669-b992-2acd54f484da
# ╠═f5a82c3e-47c6-4712-9c7e-7ff3fc1e5203
# ╠═44c04d48-4e24-4034-b188-c92ba252ff22
# ╠═7a662dce-97fa-4c1c-ba60-51f6f147e808
# ╟─e2308376-31cd-4418-932c-8f166b4a316f
# ╠═0ae376b8-8451-46d7-9bb4-cc259a5b4557
# ╠═bf437047-2de0-4a5c-93d8-1ecab06dcda6
# ╟─4441001f-fd92-4f6b-9e5c-6daee5274d54
# ╠═2b9190e9-28c5-456f-97f4-b3b59b2d4957
# ╟─99eefdf8-3ea5-41fb-92cc-5655b5e92fc2
# ╟─f77c41cd-a36e-4ec0-968c-f1842b703032
# ╠═7021bc95-71bf-4861-98d2-a3f358e5aae6
# ╟─33e4917e-ec98-44f5-85e4-b8f0c617f03c
# ╟─e53d967c-d166-4208-a237-d4b692ab7431
# ╠═8a9b4ff0-1ebc-4546-9ac8-663c77d748c0
# ╠═ebab307a-1a97-48da-89f2-940cb7936c6e
# ╟─d5ba15fa-255c-4bef-bb9d-d165232cd009
# ╟─e7eeb88a-2e15-487a-b9f4-177b81d52b09
# ╠═5c13e9a8-491b-4486-ac35-c54ed91791c7
# ╠═01e7c0a1-9d4d-4f20-8625-6f8c08eeb418
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
