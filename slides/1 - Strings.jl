### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ aaad96c0-801e-11ec-0b38-399812dced78
begin 
	using PlutoUI
	using Test
	bigbreak = HTML("<br/>"^4)
end

# ╔═╡ aaad96c0-801e-11ec-27fe-bb16ccca80d2
md"""
# Strings

Topics: 
1. How to get a string
2. String interpolation
3. String concatenation

"""

# ╔═╡ 10e3ed4e-53ee-4042-8538-a9ec15a416a4
md"""## How to get a string
Enclose your characters in `" "` or `\"\"\" \"\"\"`. 

_(Single quotes  `' '` are exclusive for characters, not strings)_ """

# ╔═╡ 71fff504-34f1-4b9e-9d99-ca5e7a245f12
s1 = "I am a string."

# ╔═╡ 97ea92ed-d68f-40b7-8e3f-bd9e27d3a27c
s2 = """I am also a string."""

# ╔═╡ 0cd07f4a-8ab4-4e81-a2ee-0f7b64456232
md"
There are a couple functional differences between strings enclosed in single and triple quotes.
One difference is that, in the latter case, you can use quotation marks within your string.
"

# ╔═╡ d0001d61-e7f4-41ff-9095-4b6d5e8c15f9
"Here, we get an "error" because it's ambiguous where this string ends "

# ╔═╡ 6676d221-4a5a-4748-8f28-d865e910bfcd
"Look, Mom, no \"errors\"!!! "

# ╔═╡ 40791229-8e16-4eae-b1ce-59fc76d8b5b1
""" No "errors" here as well 😜 """

# ╔═╡ 2f819995-9494-40b4-b5be-42978dd7a207
md"**Note that ' ' define a character, but NOT a string!**"

# ╔═╡ 5f10ef9c-36da-4222-8c11-cf00f3d7c051
typeof('a')

# ╔═╡ b52aece1-3652-45e4-b292-0c7db7a37e05
bigbreak

# ╔═╡ 7c478f7a-e3cc-4c89-9339-31abe7bf358f
md"""
## String interpolation

We can use the `$` sign to insert existing variables into a string and to evaluate expressions within a string.
Below is an example that contains some highly sensitive personal information.
"""

# ╔═╡ 47c641a4-cb3f-4000-bebb-af762426dc7d
begin
	name = "Jane"
	num_fingers = 10
	num_toes = 10
end

# ╔═╡ 499b267a-7c8c-4def-a5ea-9f7e4ccae197
"Hello, my name is $name."

# ╔═╡ 702f1673-94b2-406a-b4d9-0aa7f8c2ad7d
"I have $num_fingers fingers and $num_toes toes."

# ╔═╡ 5c78e280-a5f8-495c-90ce-79d02d6bc635
"That is $(num_fingers + num_toes) digits in all!!"

# ╔═╡ 0e0fe89a-748b-4f0f-a189-52b5697dbc49
bigbreak

# ╔═╡ 1e4877f9-2e54-4fe0-be09-ccfed3daf301
md"""
## String concatenation

Below are three ways we can concatenate strings!

The first way is to use the `string()` function.
`string()` converts non-string inputs to strings.
"""

# ╔═╡ b9324e14-da0a-465e-b58c-ebd54eaf49e7
begin
	s3 = "How many cats ";
	s4 = "is too many cats?";
	😺 = 10
end

# ╔═╡ b50fb9f6-427e-4a39-9ca3-ba9e37c59b91
string(s3, s4)

# ╔═╡ a1b26473-0b27-467a-80f1-50a8121caa79
string("I don't know, but ", 😺, " is too few.")

# ╔═╡ 3f5915e4-7564-4395-beae-1074d86d3845
md""

# ╔═╡ 75b87fec-3acb-4442-9eeb-242198b2fa28
md"We can also use * for concatenation!"

# ╔═╡ 0fec7dc0-8ccf-4e25-abfd-30c995cfb3ae
s3*s4

# ╔═╡ 49e637b3-15a6-4220-8ffa-477532e61269
bigbreak

# ╔═╡ 183b4690-dbd1-4aa9-8afa-28f3c9e30e7b
md"""
## Exercises
2.1

Create a string that says "hi" 1000 times, first with `repeat` and then with the exponentiation operator, which can call * under the hood. Assign it the variable hi below.
"""

# ╔═╡ a5602b8b-c16a-493e-acc2-607938edd8f5
hi_repeat = "hi"

# ╔═╡ 5e6c11fe-e294-4480-b33c-1e19eb1afdb0
hi_power = "hi"

# ╔═╡ 2b387e43-7c33-4d65-82b5-3d63ca748e4c
@testset "2.1" begin
	result = "hihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihi"
	@test hi_repeat == result
	@test hi_power == result
end

# ╔═╡ 3fc75a0f-cf3e-4893-b037-cbc9463d5222
md"""
2.2

Declare two variables

```julia
a = 3
b = 4
```
and use them to create two strings:
- `"3 + 4"`
- `"7"` 
and store the results in `c` and `d` respectively
"""

# ╔═╡ 172769c7-9cfb-4fd4-ae91-d882e6c6ea5e
begin
	a = missing
	b = missing
	c = missing
	d = missing
end

# ╔═╡ 3dd734e2-6c5d-4f70-85da-7760eb4b64c1
@testset "2.2" begin
	@test c == "3 + 4"
	@test d == "7"
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
# ╟─aaad96c0-801e-11ec-0b38-399812dced78
# ╟─aaad96c0-801e-11ec-27fe-bb16ccca80d2
# ╟─10e3ed4e-53ee-4042-8538-a9ec15a416a4
# ╠═71fff504-34f1-4b9e-9d99-ca5e7a245f12
# ╠═97ea92ed-d68f-40b7-8e3f-bd9e27d3a27c
# ╟─0cd07f4a-8ab4-4e81-a2ee-0f7b64456232
# ╠═d0001d61-e7f4-41ff-9095-4b6d5e8c15f9
# ╠═6676d221-4a5a-4748-8f28-d865e910bfcd
# ╠═40791229-8e16-4eae-b1ce-59fc76d8b5b1
# ╟─2f819995-9494-40b4-b5be-42978dd7a207
# ╠═5f10ef9c-36da-4222-8c11-cf00f3d7c051
# ╟─b52aece1-3652-45e4-b292-0c7db7a37e05
# ╟─7c478f7a-e3cc-4c89-9339-31abe7bf358f
# ╠═47c641a4-cb3f-4000-bebb-af762426dc7d
# ╠═499b267a-7c8c-4def-a5ea-9f7e4ccae197
# ╠═702f1673-94b2-406a-b4d9-0aa7f8c2ad7d
# ╠═5c78e280-a5f8-495c-90ce-79d02d6bc635
# ╟─0e0fe89a-748b-4f0f-a189-52b5697dbc49
# ╟─1e4877f9-2e54-4fe0-be09-ccfed3daf301
# ╠═b9324e14-da0a-465e-b58c-ebd54eaf49e7
# ╠═b50fb9f6-427e-4a39-9ca3-ba9e37c59b91
# ╠═a1b26473-0b27-467a-80f1-50a8121caa79
# ╟─3f5915e4-7564-4395-beae-1074d86d3845
# ╟─75b87fec-3acb-4442-9eeb-242198b2fa28
# ╠═0fec7dc0-8ccf-4e25-abfd-30c995cfb3ae
# ╟─49e637b3-15a6-4220-8ffa-477532e61269
# ╟─183b4690-dbd1-4aa9-8afa-28f3c9e30e7b
# ╠═a5602b8b-c16a-493e-acc2-607938edd8f5
# ╠═5e6c11fe-e294-4480-b33c-1e19eb1afdb0
# ╠═2b387e43-7c33-4d65-82b5-3d63ca748e4c
# ╟─3fc75a0f-cf3e-4893-b037-cbc9463d5222
# ╠═172769c7-9cfb-4fd4-ae91-d882e6c6ea5e
# ╠═3dd734e2-6c5d-4f70-85da-7760eb4b64c1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
