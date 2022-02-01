### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ 6a407bd2-802c-11ec-3ed6-a7acf451b25a
begin
	bigbreak = HTML("<br>"^4);
	using PlutoUI
	using Test
end

# ╔═╡ 6a407bd2-802c-11ec-0c58-b3f5f4ac5b8f
md"""
# Functions

Topics:
1. How to declare a function
2. Duck-typing in Julia
3. Mutating vs. non-mutating functions
4. Some higher order functions

"""

# ╔═╡ e75e9339-1d60-4d04-9063-a5885d0113f8
md"""
## How to declare a function
Julia gives us a few different ways to write a function. The first requires the `function` and `end` keywords
"""

# ╔═╡ a637b4f0-bc1a-4071-be73-d00c257d4266
md"### 1. Default variant:"

# ╔═╡ 07ed7ab9-a5a4-418c-b71f-5c2bc681eeb3
function sayhi(name)
    return "Hi $name, it's great to see you!"
end;

# ╔═╡ f8ce588a-cf7f-4b61-ac9f-afb520003571
function f(x)
    x^2
end;

# ╔═╡ fd562b69-53ba-4554-9897-6c5709e237fe
md"
We can call either of these functions like this:"

# ╔═╡ 809baaa8-339b-4b70-bb21-8c24a9cab24f
sayhi("C-3PO")

# ╔═╡ 87ceb82b-94a7-4e5a-84da-f56e24279755
f(42)

# ╔═╡ ed5addf3-f534-4ab7-944d-ca948c177ce4
bigbreak

# ╔═╡ 200a1cbb-9e71-4996-8d4f-8204a8701344
md"### 2. Shortcut variant:"

# ╔═╡ 53a47fcd-52f7-49bf-a274-97496258ace6
md"Alternatively, we could have declared either of these functions in a single line"

# ╔═╡ 2413ce2b-ee1b-4d3f-ad8d-ca4064b19d7c
sayhi2(name) = "Hi $name, it's great to see you!"

# ╔═╡ 928f37b1-9059-4b6e-b733-89997203c138
f2(x) = x^2

# ╔═╡ 40666547-6209-42fd-a14f-4c944a5e30ab
sayhi2("R2D2")

# ╔═╡ b7a066ac-7d19-4449-bb1e-bf7fcab4eadc
f2(42)

# ╔═╡ e9cf1e4e-e5fa-46de-ab86-f7a35e5b1302
bigbreak

# ╔═╡ 9e4f43a7-58e7-4b86-b874-e5cb44298e23
md"### 3. Anonymous functions:"

# ╔═╡ 162585b0-936d-4f9f-8667-3e8c5a1b7212
md"""Finally, we could have declared these as "anonymous" functions"""

# ╔═╡ 191be85a-9cce-4af2-bbe8-6c45d7ab30df
sayhi3 = name -> "Hi $name, it's great to see you!"

# ╔═╡ 6b2b763f-6223-4c50-93a0-54680c4313ff
f3 = x -> x^2

# ╔═╡ 3a74682e-72ff-4f91-9884-52e26c64c427
sayhi3("Chewbacca")

# ╔═╡ 353c23a2-4e6d-401f-8a0c-8038f4ef0998
f3(42)

# ╔═╡ dbd09e73-afa6-4065-baee-342951e10031
bigbreak

# ╔═╡ bcd284f3-cb2a-482e-ba27-9a5f7a86c046
md"""
## Duck-typing in Julia
> If it quacks like a duck, it's a duck.

Julia functions will just work on whatever inputs make sense.

For example, sayhi works on the name of this minor tv character, written as an integer...

"""

# ╔═╡ bd4182c4-18ed-41f4-a3f1-50aa553b4924
sayhi(55595472)

# ╔═╡ 47d3b1f8-cc8d-4b0e-89b6-f1d7d06337f8
md"
And `f` will work on a matrix."

# ╔═╡ c4b6e75d-0a51-4159-b7f7-292f5e25d1be
A = rand(3, 3)

# ╔═╡ 9b8a0c73-27f4-48af-b13b-0af1711440b3
f(A)

# ╔═╡ ec0b4d04-44ce-40ae-b807-8ba38a6a8b59
md"""`f` will also work on a string like "hi" because * is defined for string inputs as string concatenation."""

# ╔═╡ 04a0dbd8-d8f2-434b-8968-63ee989b3131
f("hi")

# ╔═╡ f95f8ea9-1478-4ac2-8e22-085fc6516e56
md"""On the other hand, `f` will not work on a vector. Unlike `A^2`, which is well-defined, the meaning of `v^2` for a vector, `v`, is not a well-defined algebraic operation. """

# ╔═╡ 5620baa2-2aed-49eb-84a1-9fcfdee568c9
v = rand(3)

# ╔═╡ aa60f167-fa1f-4a7e-9d87-eeba0146ed0f
bigbreak

# ╔═╡ 770cafe7-11e8-4b1c-86c9-b51e4c20ec42
# This won't work:
f(v)

# ╔═╡ 652b18db-731f-4283-b5dc-26dc95bf25a5
bigbreak

# ╔═╡ 5bea284c-9eed-467a-b916-1ba6bc99495f
md"""
## Mutating vs. non-mutating functions

By convention, functions followed by `!` alter their contents and functions lacking `!` do not.

For example, let's look at the difference between `sort` and `sort!`.
"""

# ╔═╡ ee1468af-b2d0-4505-ad59-4b04437d0751
let
	w = [3, 1, 2]
	sort(w)
	w
end

# ╔═╡ 1589bbe3-15c4-495b-aae2-eac2f421b2f8
md"""
`sort(w)` returns a sorted array that contains the same elements as `w`, but `w` is left unchanged. <br><br>

On the other hand, when we run `sort!(w)`, the contents of `w` are sorted within the array `w`.
"""

# ╔═╡ efb84537-41b6-41af-9205-9df193d49dcc
let
	w = [3, 1, 2]
	sort!(w)
	w
end

# ╔═╡ d52cb505-1492-4e64-869a-d598fd99d361
bigbreak

# ╔═╡ 2bc704f5-82e8-4a43-b5ae-1cdbfc18747b
md"""
## Optional arguments and keyword arguments

You can provide default values for some input arguments.
"""

# ╔═╡ 3eb97bc4-0ea7-466c-a237-f40fc8b43a71
function g(x, y = 0.0; a = 0, b = 0)
	return a*x + y*b
end

# ╔═╡ 3b57b7eb-d4ea-4668-a702-48d1950e8d63
md"You can call this function in this way:"

# ╔═╡ ce4831c8-e098-4837-901f-383a445a2998
g(1.0; b = 1.0)

# ╔═╡ 216540a3-0c24-4854-b17e-cd1623e93c43
g(1.0, 2.0)

# ╔═╡ 2de2c2bb-1b17-4085-a0d7-de322fb21370
g(1.0; a = 2.0)

# ╔═╡ 8eee9f7d-7645-4ff1-b4ef-04dbb4da386e
g(1.0)

# ╔═╡ 3c315931-12fb-4b86-b745-9053cb8ccf68
md"_It is recommended (but optional) to separate optional arguments and keyword arguments with ';'_"

# ╔═╡ e8a86b02-ecc9-479b-97b9-68e3f6ba410a
bigbreak

# ╔═╡ 20f9c597-b1a9-4f32-bca4-ad174f3b78ed
md"""
## Some higher order functions

### map

`map` is a "higher-order" function in Julia that *takes a function* as one of its input arguments. 
`map` then applies that function to every element of the data structure you pass it. For example, executing

```julia
map(f, [1, 2, 3])
```
will give you an output array where the function `f` has been applied to all elements of `[1, 2, 3]`
```julia
[f(1), f(2), f(3)]
```
"""

# ╔═╡ 01590c72-ec3e-4db5-957a-02308a6a5e6c
map(f, [1, 2, 3])

# ╔═╡ 2b69252d-cf04-40b6-95d9-eacf369c4dc5
md"""
Here we've squared all the elements of the vector `[1, 2, 3]`, rather than squaring the vector `[1, 2, 3]`.

To do this, we could have passed to `map` an anonymous function rather than a named function, such as
"""

# ╔═╡ 88dbda57-a845-404e-b680-31c2a473794e
x -> x^3

# ╔═╡ b53c7e60-559c-4d92-99bb-f970f44e48cb
md"via"

# ╔═╡ d0c94953-b7a5-4749-aa4b-b5286233767c
map(x -> x^3, [1, 2, 3])

# ╔═╡ ebb4b925-9c00-471e-b248-d7f5c7794ca0
md"and now we've cubed all the elements of `[1, 2, 3]`!"

# ╔═╡ 783648ba-d6b5-4cdf-91ac-13323255428a
bigbreak

# ╔═╡ e452fd6d-fb31-43b6-b399-0863784115fc
md"""
## broadcast

`broadcast` is another higher-order function like `map`. `broadcast` is a generalization of `map`, so it can do every thing `map` can do and more. The syntax for calling `broadcast` is the same as for calling `map`
"""

# ╔═╡ 928bf981-ba2d-4eb7-9b31-8dd88be33976
broadcast(f, [1, 2, 3])

# ╔═╡ 69e8fbb4-38e2-402b-89a0-018b4083d7a1
md"""
and again, we've applied `f` (squared) to all the elements of `[1, 2, 3]` - this time by "broadcasting" `f`!

Some syntactic sugar for calling `broadcast` is to place a `.` between the name of the function you want to `broadcast` and its input arguments. For example,

```julia
broadcast(f, [1, 2, 3])
```
is the same as
```julia
f.([1, 2, 3])
```
"""

# ╔═╡ 413e16a6-c8af-43b5-85ab-e6bd16690006
f.([1, 2, 3])

# ╔═╡ a20f8214-0126-43f4-8a56-bcfed741463f
md"""
Notice again how different this is from calling 
```julia
f([1, 2, 3])
```
We can square every element of a vector, but we can't square a vector!
"""

# ╔═╡ 0bdca8db-d6f6-4cc3-8661-98c5cb72fdae
md"""
To drive home the point, let's look at the difference between

```julia
f(A)
```
and
```julia
f.(A)
```
for a matrix `A`:
"""

# ╔═╡ 7b411fc5-7ab1-4052-a199-3195a931860a
B = [i + 3*j for j in 0:2, i in 1:3]

# ╔═╡ 33b1ce0b-371d-4af8-af52-7328e4e5b70b
f(B)

# ╔═╡ 3dafca9a-56ee-4a83-9853-917efaf6a93d
md"""
As before we see that for a matrix, `A`,
```
f(A) = A^2 = A * A
``` 

On the other hand,
"""

# ╔═╡ f3efe46a-f1bc-4792-884d-b29ef98595df
f.(B)

# ╔═╡ a18cdba8-8969-4715-992e-2f3ea339c6e1
md"""
contains the squares of all the entries of `A`.

This dot syntax for broadcasting allows us to write relatively complex compound elementwise expressions in a way that looks natural/closer to mathematical notation. For example, we can write
"""

# ╔═╡ 59fea39e-dea8-4412-8cd3-64b4cede04db
A .+ 2 .* f.(A) ./ A

# ╔═╡ 4477326e-bef1-4b74-a24b-c421fcb60c18
md"or"

# ╔═╡ f0dead06-58f6-4c97-9f14-5000b79be8cb
@. A + 2 * f(A) / A  

# ╔═╡ 429ec6d9-f80c-4ca7-85b8-db8096f826ea
md"instead of"

# ╔═╡ c6f86e8a-05e8-4ad3-8e7c-3598b22a4779
broadcast(x -> x + 2 * f(x) / x, A)

# ╔═╡ 60eea80b-a510-455b-a2a4-d16366303b87
md"and the two will do exactly the same!"

# ╔═╡ 63032f05-4635-438b-9c56-5571620a180d
bigbreak

# ╔═╡ 62d01357-fdc5-4bd2-9b32-d7515c0c44f6
md"""### Fusing the dot operator

Composition of `broadcast` is suboptimal, as in each step an intermediate resulat is stored, i.e.
```julia
A .+ B .+ C == broadcast( (r+c) -> r + c, broadcast( (a,b) -> a+b, A, B), C)
```

But with a hand _macro_ we can fuse those broadcast calls, i.e.
```julia
@. A + B + C  ==   broadcast( (a,b,c) -> a+b+c, A, B, C)
```
"""

# ╔═╡ e4f1a223-ff88-4588-94b1-1bd6aeb0e856
A .* A .* A

# ╔═╡ 94070b96-502c-4685-bdb9-f6ee6fe55a06
@. A * A * A

# ╔═╡ 281ac3be-aaea-4078-9fb0-391997924306


# ╔═╡ 96e07c5b-6a14-4aa0-8d96-99aaf19a235f
@allocated @. A * A * A

# ╔═╡ 7617e358-c1bf-42b8-b0e3-6e50f993ec2e
@allocated A .* A .* A

# ╔═╡ 6b3f422f-e8cc-480c-aede-296808d063fc
bigbreak

# ╔═╡ fc405e7f-d062-41ed-bcc3-5599e80e3467
md"""
## Exercises

6.1

Write a function `add_one` that adds 1 to its input.
"""

# ╔═╡ 1e1b4cca-0753-440b-9eb2-6f8382964e71


# ╔═╡ 68c25eb9-c682-4f7d-8c82-1e786557de01


# ╔═╡ 86edb75d-a484-4d7f-bf9a-bc6b97cce3ec
( @isdefined(add_one) && 
hasmethod(add_one, Tuple{Union{Any,Int,Float64}}) && 
add_one(11) == 12)

# ╔═╡ 185ffedc-8462-4ef3-add4-9ba371e236ee
bigbreak

# ╔═╡ 56ead0a8-4c9b-4e07-9a8c-0c56b4b30c21
md"""
6.2

Use map or broadcast to increment every element of matrix `B` by 1 and assign it to a variable `A1`.
"""

# ╔═╡ 8e725749-3c7a-413d-8838-49e471c8b47e
B

# ╔═╡ bd5e73ca-a683-476b-8239-ddf57cba89ba
begin
	A1 = B
end

# ╔═╡ e11ca969-a16a-451d-9f6f-5f826d18a55f


# ╔═╡ b9d3ae00-42a2-4007-a0f9-3327d656a425
A1 == [2 3 4; 5 6 7; 8 9 10]

# ╔═╡ e83429b7-77e9-4efe-a365-827b7234c360
bigbreak

# ╔═╡ 93609093-4353-44a3-be9f-5ac41ec69c81
md"""
6.3 

Use the broadcast dot syntax to increment every element of matrix `A1` by `1` and store it in variable `A2`
"""

# ╔═╡ 43917a91-235f-49ab-9a60-dc0dfd9bcb4d
begin
	A2 = A1
end

# ╔═╡ da127939-3adc-40c9-9031-db9dd3de847b


# ╔═╡ 15459bb0-bd18-4d48-b39a-193f7a01b1f8
A2 == [3 4 5; 6 7 8; 9 10 11]

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
# ╟─6a407bd2-802c-11ec-3ed6-a7acf451b25a
# ╟─6a407bd2-802c-11ec-0c58-b3f5f4ac5b8f
# ╟─e75e9339-1d60-4d04-9063-a5885d0113f8
# ╟─a637b4f0-bc1a-4071-be73-d00c257d4266
# ╠═07ed7ab9-a5a4-418c-b71f-5c2bc681eeb3
# ╠═f8ce588a-cf7f-4b61-ac9f-afb520003571
# ╟─fd562b69-53ba-4554-9897-6c5709e237fe
# ╠═809baaa8-339b-4b70-bb21-8c24a9cab24f
# ╠═87ceb82b-94a7-4e5a-84da-f56e24279755
# ╟─ed5addf3-f534-4ab7-944d-ca948c177ce4
# ╟─200a1cbb-9e71-4996-8d4f-8204a8701344
# ╟─53a47fcd-52f7-49bf-a274-97496258ace6
# ╠═2413ce2b-ee1b-4d3f-ad8d-ca4064b19d7c
# ╠═928f37b1-9059-4b6e-b733-89997203c138
# ╠═40666547-6209-42fd-a14f-4c944a5e30ab
# ╠═b7a066ac-7d19-4449-bb1e-bf7fcab4eadc
# ╟─e9cf1e4e-e5fa-46de-ab86-f7a35e5b1302
# ╟─9e4f43a7-58e7-4b86-b874-e5cb44298e23
# ╟─162585b0-936d-4f9f-8667-3e8c5a1b7212
# ╠═191be85a-9cce-4af2-bbe8-6c45d7ab30df
# ╠═6b2b763f-6223-4c50-93a0-54680c4313ff
# ╠═3a74682e-72ff-4f91-9884-52e26c64c427
# ╠═353c23a2-4e6d-401f-8a0c-8038f4ef0998
# ╟─dbd09e73-afa6-4065-baee-342951e10031
# ╟─bcd284f3-cb2a-482e-ba27-9a5f7a86c046
# ╠═bd4182c4-18ed-41f4-a3f1-50aa553b4924
# ╟─47d3b1f8-cc8d-4b0e-89b6-f1d7d06337f8
# ╠═c4b6e75d-0a51-4159-b7f7-292f5e25d1be
# ╠═9b8a0c73-27f4-48af-b13b-0af1711440b3
# ╟─ec0b4d04-44ce-40ae-b807-8ba38a6a8b59
# ╠═04a0dbd8-d8f2-434b-8968-63ee989b3131
# ╟─f95f8ea9-1478-4ac2-8e22-085fc6516e56
# ╠═5620baa2-2aed-49eb-84a1-9fcfdee568c9
# ╟─aa60f167-fa1f-4a7e-9d87-eeba0146ed0f
# ╠═770cafe7-11e8-4b1c-86c9-b51e4c20ec42
# ╟─652b18db-731f-4283-b5dc-26dc95bf25a5
# ╟─5bea284c-9eed-467a-b916-1ba6bc99495f
# ╠═ee1468af-b2d0-4505-ad59-4b04437d0751
# ╟─1589bbe3-15c4-495b-aae2-eac2f421b2f8
# ╠═efb84537-41b6-41af-9205-9df193d49dcc
# ╟─d52cb505-1492-4e64-869a-d598fd99d361
# ╟─2bc704f5-82e8-4a43-b5ae-1cdbfc18747b
# ╠═3eb97bc4-0ea7-466c-a237-f40fc8b43a71
# ╟─3b57b7eb-d4ea-4668-a702-48d1950e8d63
# ╠═ce4831c8-e098-4837-901f-383a445a2998
# ╠═216540a3-0c24-4854-b17e-cd1623e93c43
# ╠═2de2c2bb-1b17-4085-a0d7-de322fb21370
# ╠═8eee9f7d-7645-4ff1-b4ef-04dbb4da386e
# ╟─3c315931-12fb-4b86-b745-9053cb8ccf68
# ╟─e8a86b02-ecc9-479b-97b9-68e3f6ba410a
# ╟─20f9c597-b1a9-4f32-bca4-ad174f3b78ed
# ╠═01590c72-ec3e-4db5-957a-02308a6a5e6c
# ╟─2b69252d-cf04-40b6-95d9-eacf369c4dc5
# ╠═88dbda57-a845-404e-b680-31c2a473794e
# ╟─b53c7e60-559c-4d92-99bb-f970f44e48cb
# ╠═d0c94953-b7a5-4749-aa4b-b5286233767c
# ╟─ebb4b925-9c00-471e-b248-d7f5c7794ca0
# ╟─783648ba-d6b5-4cdf-91ac-13323255428a
# ╟─e452fd6d-fb31-43b6-b399-0863784115fc
# ╠═928bf981-ba2d-4eb7-9b31-8dd88be33976
# ╟─69e8fbb4-38e2-402b-89a0-018b4083d7a1
# ╠═413e16a6-c8af-43b5-85ab-e6bd16690006
# ╟─a20f8214-0126-43f4-8a56-bcfed741463f
# ╟─0bdca8db-d6f6-4cc3-8661-98c5cb72fdae
# ╠═7b411fc5-7ab1-4052-a199-3195a931860a
# ╠═33b1ce0b-371d-4af8-af52-7328e4e5b70b
# ╟─3dafca9a-56ee-4a83-9853-917efaf6a93d
# ╠═f3efe46a-f1bc-4792-884d-b29ef98595df
# ╟─a18cdba8-8969-4715-992e-2f3ea339c6e1
# ╠═59fea39e-dea8-4412-8cd3-64b4cede04db
# ╟─4477326e-bef1-4b74-a24b-c421fcb60c18
# ╠═f0dead06-58f6-4c97-9f14-5000b79be8cb
# ╟─429ec6d9-f80c-4ca7-85b8-db8096f826ea
# ╠═c6f86e8a-05e8-4ad3-8e7c-3598b22a4779
# ╟─60eea80b-a510-455b-a2a4-d16366303b87
# ╟─63032f05-4635-438b-9c56-5571620a180d
# ╠═62d01357-fdc5-4bd2-9b32-d7515c0c44f6
# ╠═e4f1a223-ff88-4588-94b1-1bd6aeb0e856
# ╠═94070b96-502c-4685-bdb9-f6ee6fe55a06
# ╠═281ac3be-aaea-4078-9fb0-391997924306
# ╠═96e07c5b-6a14-4aa0-8d96-99aaf19a235f
# ╠═7617e358-c1bf-42b8-b0e3-6e50f993ec2e
# ╟─6b3f422f-e8cc-480c-aede-296808d063fc
# ╠═fc405e7f-d062-41ed-bcc3-5599e80e3467
# ╠═1e1b4cca-0753-440b-9eb2-6f8382964e71
# ╟─68c25eb9-c682-4f7d-8c82-1e786557de01
# ╟─86edb75d-a484-4d7f-bf9a-bc6b97cce3ec
# ╟─185ffedc-8462-4ef3-add4-9ba371e236ee
# ╟─56ead0a8-4c9b-4e07-9a8c-0c56b4b30c21
# ╠═8e725749-3c7a-413d-8838-49e471c8b47e
# ╠═bd5e73ca-a683-476b-8239-ddf57cba89ba
# ╟─e11ca969-a16a-451d-9f6f-5f826d18a55f
# ╟─b9d3ae00-42a2-4007-a0f9-3327d656a425
# ╟─e83429b7-77e9-4efe-a365-827b7234c360
# ╠═93609093-4353-44a3-be9f-5ac41ec69c81
# ╠═43917a91-235f-49ab-9a60-dc0dfd9bcb4d
# ╟─da127939-3adc-40c9-9031-db9dd3de847b
# ╟─15459bb0-bd18-4d48-b39a-193f7a01b1f8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
