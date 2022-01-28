### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ cdb3b623-4b24-49a9-b799-ee349287715c
using PlutoUI

# ╔═╡ 855f2a3b-b7ce-4b3d-9ebd-359f8e13bfc2
bigbreak = HTML("<br/>"^4);

# ╔═╡ b2e97780-801b-11ec-0433-c7952bc1387d
md"""
# Getting started

Topics:
  1. How to print
  2. How to assign variables
  3. Ho to comment
  4. Syntax for basic math
"""

# ╔═╡ 2f8bea58-1b67-4ff0-80b9-70f17c5eb26b
md"""
## How to print

In Julia we usually use `println()` to print
"""

# ╔═╡ feb26c6b-f169-4543-be6e-fd48c4b37f3b
with_terminal() do 
	println("I'm excited to learn Julia!")
end

# ╔═╡ f4fbcb5f-8744-45d3-a5a8-acef9efd3a79
md"""
_Note: In Pluto, the terminal is often hidden. But Pluto will show the last value of each cell anyway._
"""

# ╔═╡ 18c5fa07-8e59-4c25-be5c-90fd7406b20a
"I'm excited to learn Julia!"

# ╔═╡ a9debd68-5e03-4c69-962d-87449024b3e8
md"""
## How to assign variables

All we need is a variable name, value, and an equal's sign!
Julia will figure out types for us.
"""

# ╔═╡ 4df6e513-6b77-4e6b-8870-d9cf84ebdfc7
my_answer = 42

# ╔═╡ c6dc20f1-d2bd-4f2f-b536-8a1560e928ed
typeof(my_answer)

# ╔═╡ 71777029-f294-42c6-963c-8b6bc15610bc
my_pi = 3.14159

# ╔═╡ 593e8d96-7a1c-47cc-9e23-7aba58867d5a
typeof(my_pi)

# ╔═╡ c66ebcb1-d3f4-4208-ad86-ac3745b8a386
😺 = "smiley cat!"

# ╔═╡ 3a9a5ec6-4ab8-4c44-a621-76a3c4e08233
typeof(😺)

# ╔═╡ 0b7b3b48-18da-426b-91f9-54f8bac5fd76
md"_To type a smiley cat, use **'\' + tab completion** to select the emoji name and then tab again_
"

# ╔═╡ 4ec52ccd-6f3a-4027-87bd-54487ff75562
#\:smi + <tab> --> select with down arrow + <enter> ---> <tab> + <enter> to complete

# ╔═╡ cba0e0e6-531c-4b90-a36f-480b6c5b9d9a
md"""After assigning a value to a variable, we can reassign a value of a different type to that variable without any issue.

_Note: This is the second point in which Pluto is a bit different. Since these notebooks are reactive, you cannot reassign. (But this has many advantages later).
However, we can simulate a normal Julia enviroment by adding a `begin` `end` block._
"""

# ╔═╡ f4e86b43-263f-4240-8c10-67987bfd1103
begin
	🐶 = 1.0
	T1 = typeof(🐶)

	🐶 = 1
	T2 = typeof(🐶)

	"First 🐶 was of type $T1, then is was of type $T2"
end

# ╔═╡ ee1e0582-c26e-4550-a3a8-07d4eb1919b8
md"_Note: until now, we never had to define the type. Julia allows us to write **generic** code._"

# ╔═╡ 54b80a4f-d8bc-40ad-8020-943b3df9578f
bigbreak

# ╔═╡ 83fc7fb2-df70-4959-9dd2-038c6e6df3e9
md"## How to comment"

# ╔═╡ 31ee93da-94ee-41f3-a04a-9be1f3f686ca
# either use the pound/has key!

# ╔═╡ 5364a296-23d4-4c18-8b0e-741501bd3316
#=

For multi-line comments, 
use the '#= =#' sequence.

=#

# ╔═╡ 8f0decf1-bdef-456b-bb08-6633876bcd75
bigbreak

# ╔═╡ a3642d38-9c35-4ebc-bc6a-f8d189fffabf
md"## Syntax for basic math"

# ╔═╡ 180d1eba-dd3f-472f-a141-478b0b88f763
begin
	sum = 3 + 7
	difference = 10 - 3
	product = 20 * 5
	quotient = 100 / 10
	power = 10 ^ 2
	modulus = 101 % 2
	
	
	(;sum, difference, product, quotient, power, modulus)
end

# ╔═╡ 9ad0c3a5-29f3-40ab-b967-3717f1af4942
bigbreak

# ╔═╡ d1119526-13ae-4555-ab59-cafce95e9ee7
md"## Exercises"

# ╔═╡ 4102dafc-6980-4cbc-a454-41be99a4b64b
md""" 
1.1

Look up docs for the convert function. 

_Hint: Use `?convert` to access the help._"""

# ╔═╡ 9eee1016-2809-4c1c-8076-1ed172bbbe2c


# ╔═╡ d4ec0db3-5c68-462e-b53c-d495259d6324
md"1.2 

Assign 365 to a variable named `days`. Convert days to a float and assign it to variable `days_float` "

# ╔═╡ 4d45400d-b904-418b-80b6-9dc59bda41a6
begin 
	days = 0
	days_float = 0
end

# ╔═╡ f6c062f6-b8b7-49d4-ba25-19a5ba26b6e1
begin 
	@assert days == 365
	@assert days_float == 365.0
end

# ╔═╡ ada179c2-a434-4947-a85b-e35f340e0d7c
md"""1.3

See what happens when you execute
```julia 
convert(Int64, "1") 
```
and
```julia 
parse(Int64, "1")
```
"""

# ╔═╡ 7ace7d27-1397-4e58-ab44-ce9492e4d1be


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
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
# ╟─cdb3b623-4b24-49a9-b799-ee349287715c
# ╟─855f2a3b-b7ce-4b3d-9ebd-359f8e13bfc2
# ╟─b2e97780-801b-11ec-0433-c7952bc1387d
# ╟─2f8bea58-1b67-4ff0-80b9-70f17c5eb26b
# ╠═feb26c6b-f169-4543-be6e-fd48c4b37f3b
# ╟─f4fbcb5f-8744-45d3-a5a8-acef9efd3a79
# ╠═18c5fa07-8e59-4c25-be5c-90fd7406b20a
# ╟─a9debd68-5e03-4c69-962d-87449024b3e8
# ╠═4df6e513-6b77-4e6b-8870-d9cf84ebdfc7
# ╠═c6dc20f1-d2bd-4f2f-b536-8a1560e928ed
# ╠═71777029-f294-42c6-963c-8b6bc15610bc
# ╠═593e8d96-7a1c-47cc-9e23-7aba58867d5a
# ╠═c66ebcb1-d3f4-4208-ad86-ac3745b8a386
# ╠═3a9a5ec6-4ab8-4c44-a621-76a3c4e08233
# ╟─0b7b3b48-18da-426b-91f9-54f8bac5fd76
# ╠═4ec52ccd-6f3a-4027-87bd-54487ff75562
# ╟─cba0e0e6-531c-4b90-a36f-480b6c5b9d9a
# ╠═f4e86b43-263f-4240-8c10-67987bfd1103
# ╟─ee1e0582-c26e-4550-a3a8-07d4eb1919b8
# ╟─54b80a4f-d8bc-40ad-8020-943b3df9578f
# ╟─83fc7fb2-df70-4959-9dd2-038c6e6df3e9
# ╠═31ee93da-94ee-41f3-a04a-9be1f3f686ca
# ╠═5364a296-23d4-4c18-8b0e-741501bd3316
# ╟─8f0decf1-bdef-456b-bb08-6633876bcd75
# ╟─a3642d38-9c35-4ebc-bc6a-f8d189fffabf
# ╠═180d1eba-dd3f-472f-a141-478b0b88f763
# ╟─9ad0c3a5-29f3-40ab-b967-3717f1af4942
# ╟─d1119526-13ae-4555-ab59-cafce95e9ee7
# ╟─4102dafc-6980-4cbc-a454-41be99a4b64b
# ╠═9eee1016-2809-4c1c-8076-1ed172bbbe2c
# ╟─d4ec0db3-5c68-462e-b53c-d495259d6324
# ╠═4d45400d-b904-418b-80b6-9dc59bda41a6
# ╠═f6c062f6-b8b7-49d4-ba25-19a5ba26b6e1
# ╟─ada179c2-a434-4947-a85b-e35f340e0d7c
# ╠═7ace7d27-1397-4e58-ab44-ce9492e4d1be
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
