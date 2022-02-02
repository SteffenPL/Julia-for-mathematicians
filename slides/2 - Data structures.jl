### A Pluto.jl notebook ###
# v0.17.4

using Markdown
using InteractiveUtils

# ╔═╡ 59ed6c40-8025-11ec-0ace-d5b826d81255
begin
	bigbreak = HTML("<br>"^4);
	using PlutoUI
	using Test
end

# ╔═╡ c3b89eff-c3e6-47d0-acc8-661dde65305c
md"""
# Data structures
Once we start working with many pieces of data at once, it will be convenient for us to store data in structures like arrays or dictionaries (rather than just relying on variables).

Types of data structures covered: 
1. Tuples and NamedTuples
2. Dictionaries
3. Arrays


As an overview, tuples and arrays are both ordered sequences of elements (so we can index into them). Dictionaries and arrays are both mutable. We'll explain this more below!

"""

# ╔═╡ a58c0b6f-c5f4-43e9-87ad-4eca62157ce4
md"""
## Tuples
We can create a tuple by enclosing an ordered collection of elements in ( ).

Syntax:
```julia
(item1, item2, ...)
```
"""

# ╔═╡ 30233243-ed9d-4bfd-a9af-fcde96677998
myfavoriteanimals = ("penguins", "cats", "sugargliders")

# ╔═╡ 15717659-eb1a-40d4-abfc-7d680f4722c8
md"We can index into this tuple,"

# ╔═╡ 9cd7ec78-75dc-4cfc-a4ef-2fd8e9a8d40c
myfavoriteanimals[1]

# ╔═╡ dae03614-aa84-483a-8e54-5f493a5a1b82
md"but since tuples are immutable, we can't update it"

# ╔═╡ 6d1bb7e6-6cff-4cee-873d-ccc82f4f0be8
myfavoriteanimals[1] = "otters"

# ╔═╡ d85c4c9a-3470-4b5a-95af-f2e9c2b04c00
md"""## Now in 1.6: NamedTuples
As you might guess, NamedTuples are just like Tuples except that each element additionally has a name! They have a special syntax using = inside a tuple:
```julia
(name1 = item1, name2 = item2, ...)
```
_Special case, for just one entry, use `(; name1 = item1)`_
"""

# ╔═╡ a8e3433a-a9d3-4081-a8fe-5fa8732c8d71
yourfavoriteanimals = (bird = "penguins", mammal = "cats", marsupial = "sugargliders")

# ╔═╡ 9bde2570-6ce5-4ad7-8b0b-dd7889f8bea1
md"
Like regular Tuples, NamedTuples are ordered, so we can retrieve their elements via indexing:"

# ╔═╡ f425304c-29c1-40eb-b606-9dc39a62e252
yourfavoriteanimals[1]

# ╔═╡ 9db7047d-d900-403c-9a10-85328d5faf44
md"They also add the special ability to access values by their name:"

# ╔═╡ 560ddf25-33e0-4075-b1f4-475f308c99a7
yourfavoriteanimals.bird

# ╔═╡ ff1774ca-7a03-474a-80c7-ff2bd9f38e61
bigbreak

# ╔═╡ e13cae8d-e8ad-4ed8-a844-e1cedb452493
md""" ## Dictionaries
If we have sets of data related to one another, we may choose to store that data in a dictionary. We can create a dictionary using the Dict() function, which we can initialize as an empty dictionary or one storing key, value pairs.

Syntax:
```julia
Dict(key1 => value1, key2 => value2, ...)
```
A good example is a contacts list, where we associate names with phone numbers.
"""

# ╔═╡ 079ece15-7872-4e24-b762-418152f232e6
myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-2368")

# ╔═╡ 37887043-b092-4d0f-bbc7-4288c4c761cd
md"""
In this example, each name and number is a "key" and "value" pair. We can grab Jenny's number (a value) using the associated key
"""

# ╔═╡ 07fb97a3-60f0-40e5-befe-5d27a0b5d597
myphonebook["Jenny"]

# ╔═╡ 5efd2a9e-7bc9-424e-812d-2fd554677b55
md"We can add another entry to this dictionary as follows"

# ╔═╡ 6647ab87-0ff0-4d61-ad10-897942b461dc
myphonebook["Kramer"] = "555-FILK"

# ╔═╡ 0b438e45-fa85-435b-9319-741379f8bf2d
myphonebook

# ╔═╡ a9ef31b2-9c59-4ed4-ba78-173a383211e2
md"We can delete Kramer from our contact list - and simultaneously grab his number - by using pop!"

# ╔═╡ d869d9fd-703b-475b-b9c2-337cbc1b967a
pop!(myphonebook, "Kramer")

# ╔═╡ 09eb599f-f454-4167-8b63-002e6b3b1ef9
myphonebook

# ╔═╡ 5c30cf8d-1295-4e42-ba93-2b49b005455c
md"Unlike tuples and arrays, dictionaries are not ordered. So, we can't index into them."

# ╔═╡ d96442d4-eaa9-4339-b55f-e48e39169e48
myphonebook[1]

# ╔═╡ 8e1fac94-4a44-499b-a49b-e4761549b166
md"
In the example above, julia thinks you're trying to access a value associated with the key 1."

# ╔═╡ 0536d875-6f77-4834-9fa4-a0a31f7fa09a
bigbreak

# ╔═╡ d54f80fa-750b-494b-be58-933d375fb8c2
md"""
## Arrays
Unlike tuples, arrays are mutable. Unlike dictionaries, arrays contain ordered collections.
We can create an array by enclosing this collection in `[ ]`.

Syntax:
```julia
[item1, item2, ...]
```
For example, we might create an array to keep track of my friends

"""

# ╔═╡ 8bd0408e-7b00-419c-930c-8e9361ad1574
myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

# ╔═╡ 3b2e4202-19be-4de5-92ae-b3911af42f7f
typeof(myfriends)

# ╔═╡ 3b3cab5a-c5e2-4587-9aae-a97cbc15f238
md"The 1 in `Array{String,1}` means this is a one dimensional vector. An `Array{String,2}` would be a 2d matrix, etc. The String is the type of each element."

# ╔═╡ c94ca702-fe13-468f-938a-be9b16a879e2
md"or to store a sequence of numbers"

# ╔═╡ b577d259-b564-47c8-b732-a0af01f30014
fibonacci = [1, 1, 2, 3, 5, 8, 13]

# ╔═╡ 24dea8be-3930-4049-9a44-b8151e164d91
typeof(fibonacci)

# ╔═╡ 7701def7-26b9-4f53-90a9-3eec7be70a16
eltype(fibonacci)

# ╔═╡ d1571780-39a7-4d8d-9ee0-b9770e235bdd
md"we can also mix types"

# ╔═╡ 98457248-d957-4376-8086-6b5866a743c9
mixture = [1, 1, 2, 3, "Ted", "Robyn"]

# ╔═╡ 0553623d-5416-4cf4-8cd8-a836dbe5c41f
typeof(mixture)

# ╔═╡ cf556b7b-1d94-43d7-99f8-0a134bd9865b
md"Once we have an array, we can grab individual pieces of data from inside that array by indexing into the array. For example, if we want the third friend listed in myfriends, we write"

# ╔═╡ 46bdba66-e0fa-4631-b0a1-9d532aa25e89
myfriends[1]

# ╔═╡ 6debf09f-ff30-4e30-93b3-8872c258908c
md"
We can use indexing to edit an existing element of an array"

# ╔═╡ 28821165-3106-4983-be9f-3155cbc4ba53
myfriends[3] = "Baby Bop"

# ╔═╡ b221fbd3-c519-4c9c-8c98-bcee6fae796d
bigbreak

# ╔═╡ 3b5b7dcf-6a56-49cb-9dd8-1b2aba81ef87
md"""
### Yes, Julia is 1-based indexing, not 0-based like Python. 
_(I share your pain)._

"""

# ╔═╡ 8f398c3a-9def-4f41-a171-45d38527c83c
bigbreak

# ╔═╡ a39e4255-43ee-4ed3-8282-fd25ca0b8d53
md"""
Let's continue anyway.

We can also edit the array by using the push! and pop! functions. push! adds an element to the end of an array and pop! removes the last element of an array.

We can add another number to our fibonnaci sequence
"""

# ╔═╡ 214cde58-aa66-4499-9a5e-5a6a36c22115
push!(fibonacci, 21)

# ╔═╡ 7aa62fe2-9c5e-4640-8960-21a9084e436f
md"and then remove it"

# ╔═╡ 687f65ad-2320-4cab-b576-0b94de505c10
pop!(fibonacci)

# ╔═╡ 55e690c8-14c2-46f8-bd3c-f64e34a8d74e
fibonacci

# ╔═╡ 58fbd165-41f3-4cac-aaa3-e498e4621d1d
md"So far I've given examples of only 1D arrays of scalars, but arrays can have an arbitrary number of dimensions and can also store other arrays.

For example, the following are arrays of arrays:"

# ╔═╡ a6fc5004-5ef2-409c-9b6a-5e7e7efb25ad
favorites = [["koobideh", "chocolate", "eggs"],["penguins", "cats", "sugargliders"]]

# ╔═╡ c4d8af83-f7f9-47a0-9023-fe46e6bc1109
favorites[2][1]

# ╔═╡ 6229a275-b52d-4c81-a05b-f22d15b0cf32
numbers = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]

# ╔═╡ 53cd90d5-8a70-43a6-b72e-d61185c0b7aa
typeof(numbers)

# ╔═╡ 4fdc2f91-dc97-4c58-9cc1-486d30ad7890
bigbreak

# ╔═╡ 08924e9f-27b8-444a-b9af-9fa34cf1d61b
md"Below are examples of 2D and 3D arrays populated with random values."

# ╔═╡ daa23583-9b16-4a76-bde8-9324f3dc1908
rand(4,3)

# ╔═╡ 12e389d6-9ac2-49b5-a678-cf71787541eb
rand(4,3,2)

# ╔═╡ e791a417-a00a-479e-b433-3773dd74a48e
bigbreak

# ╔═╡ b18f9af8-130d-4bac-ba8f-230e89d229b7
X = [1 2; 2 3 ]

# ╔═╡ 26de3d3b-9229-4c34-a7d1-e0c89ef6f843
Z = [i+j for i in 1:10, j in 1:10]

# ╔═╡ 30933711-723e-4b8f-8be9-3928635e068e
Z[3:5, 2:2:6]

# ╔═╡ eb9a5d9f-9f39-401c-aa35-102414ed99de
bigbreak

# ╔═╡ 3280db88-0d68-4426-9f89-0fd3914e6ffa
md"Be careful when you want to copy arrays!"

# ╔═╡ 4fa1d5b9-36a0-491e-a034-c887ee7338d8
fibonacci

# ╔═╡ 68ce440d-53f8-4312-8911-a7348e602a1f
somenumbers = copy(fibonacci)

# ╔═╡ 1be992a6-fc03-437f-9dc1-6072f0b08327
somenumbers[1] = 404

# ╔═╡ 36086001-a2bd-4648-b2b3-3d526f0dcf71
fibonacci

# ╔═╡ 5ece33d6-4622-4385-b84c-639bd7571915
md"Editing somenumbers caused fibonacci to get updated as well!

In the above example, we didn't actually make a copy of fibonacci. **We just created a new way to access the entries in the array bound to fibonacci.**

If we'd like to make a copy of the array bound to fibonacci, we can use the copy function."

# ╔═╡ ce690520-a919-4e3d-a201-ec2baedf913d
let
	a = [[1,2],1]
	
	b = deepcopy(a)
	b[1][1] = 10
	b[2] = 2
	a
end

# ╔═╡ 28263f4f-37b0-43fd-9eab-6169d82b0581
bigbreak

# ╔═╡ 421ab876-efa5-4a7d-9d33-5b9eca5f528e
begin 
	# let's restore the original array
	fibonacci[1] = 1
	fibonacci
end

# ╔═╡ 142b9281-196f-4d3e-ae7d-fbc1011255f6
somemorenumbers = copy(fibonacci)

# ╔═╡ 91e7e129-c7b5-4e1f-9025-bdac4d569b46
somemorenumbers[1] = 404

# ╔═╡ 0e20de93-a6f1-415c-a08e-53de67065bc4
fibonacci

# ╔═╡ be7bad99-185a-43ed-9c8d-33e5abcdbbd0


# ╔═╡ 40b0919d-64a5-4a89-95fb-5266c2c07260
md"In this last example, fibonacci was not updated. Therefore we see that the arrays bound to somemorenumbers and fibonacci are distinct."

# ╔═╡ ec0fa200-0c79-467a-af5c-97e79f37253d
let
	function gradientdecent(f, x0)
	
	end

	x0 = [1., 2.]
	gradientdecent( nothing, x0)
end

# ╔═╡ 55633c9d-2c1b-40c5-9475-48f18b1f8d77
bigbreak

# ╔═╡ 69e96bb3-fc25-4f44-89cd-8f2aeb7065fe
md"Variables are just associated to values!"

# ╔═╡ 9d4aeb68-6649-42f6-8a93-997a136499d4
begin 
	A = [1,2,3]
	
	A_orig = Ref(A)  # points to the array [1,2,3]

	A .= (2 * A)
	
end

# ╔═╡ 2a3d5a98-751c-48c9-b102-89bc40e74251
typeof(2*A)

# ╔═╡ 457bc2c7-9aae-4b28-b216-ef9454227651
A

# ╔═╡ f35046c4-4a6e-42e5-b691-78b6ef3b0d27
md"The original array (might) still exists and we wasted memory!"

# ╔═╡ 8af669a5-4f1f-4f0e-9de7-030e3196f96b
A_orig[]

# ╔═╡ 32035322-60ec-4ed7-a340-84c6457a2464
md""" 
#### Why did we not overwrite the original array?
Imagine, in the first step we did
```julia
A = [1, 2, 3] 
```

$(LocalResource("images/var_1.svg", :width => 800))
After the command 
```julia 
A = 2*A
```
the variable is bound to a new value. **The old value remains unchanged!**

$(LocalResource("images/var_2.svg", :width => 800))

"""

# ╔═╡ 2c04e557-4afa-4acc-ace1-45f994aa3ed3
bigbreak

# ╔═╡ 83c37801-d248-442a-a360-829f740f5cd9
md"""
## Exercises
3.1
Create an array, `x` with the number 1 to 20 and add `+ 10` to all odd entries.

"""

# ╔═╡ 4170966b-cbb4-4b7b-b6e0-528f63a1c019
begin
	x = []
	# ...
end

# ╔═╡ f720b6ad-eea0-4c07-b528-822b80305000
md"""_The current solution is $( (x == [i + (i%2==1)*10 for i in 1:20]) ? "correct" : "false")._"""

# ╔═╡ 7831cafd-8ac8-41be-ad0d-a5abeeb66276
bigbreak

# ╔═╡ fc60372a-f853-4005-bc40-64e9d0615a32
md"""
3.2

Try to add `"Emergency"` as key to `ourphonebook` with the value `string(911)` with the following code
```julia
ourphonebook["Emergency"] = 112
```
Why doesn't this work?
"""

# ╔═╡ 89b74238-dd21-4063-bdb8-d64adcc2184c
ourphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-2368")

# ╔═╡ b8c1cdf5-550e-49be-83b0-2a01fc583886
# enter you code here

# ╔═╡ 1b7789aa-1969-486c-a733-6e3d10d135bc


# ╔═╡ f42fa416-47d1-49b6-9d4b-365740908e03
md"How can you change the definition of `ourphonebook` such that you can add and integer value?"

# ╔═╡ 4f191e04-1972-47af-b1d9-2de4857833bb
bigbreak

# ╔═╡ 342337cc-6202-45f7-bf5d-6688b770ac75
md"""
!!! hint "Hint"  
      Check out `typeof()` for these dictionaries. You can use `Dict{K,V}` instead of the generic `Dict` to create a dictionary with key type `T` and value type `V`. What should `V` be?
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
# ╟─59ed6c40-8025-11ec-0ace-d5b826d81255
# ╟─c3b89eff-c3e6-47d0-acc8-661dde65305c
# ╟─a58c0b6f-c5f4-43e9-87ad-4eca62157ce4
# ╠═30233243-ed9d-4bfd-a9af-fcde96677998
# ╟─15717659-eb1a-40d4-abfc-7d680f4722c8
# ╠═9cd7ec78-75dc-4cfc-a4ef-2fd8e9a8d40c
# ╟─dae03614-aa84-483a-8e54-5f493a5a1b82
# ╠═6d1bb7e6-6cff-4cee-873d-ccc82f4f0be8
# ╟─d85c4c9a-3470-4b5a-95af-f2e9c2b04c00
# ╠═a8e3433a-a9d3-4081-a8fe-5fa8732c8d71
# ╟─9bde2570-6ce5-4ad7-8b0b-dd7889f8bea1
# ╠═f425304c-29c1-40eb-b606-9dc39a62e252
# ╟─9db7047d-d900-403c-9a10-85328d5faf44
# ╠═560ddf25-33e0-4075-b1f4-475f308c99a7
# ╟─ff1774ca-7a03-474a-80c7-ff2bd9f38e61
# ╟─e13cae8d-e8ad-4ed8-a844-e1cedb452493
# ╠═079ece15-7872-4e24-b762-418152f232e6
# ╟─37887043-b092-4d0f-bbc7-4288c4c761cd
# ╠═07fb97a3-60f0-40e5-befe-5d27a0b5d597
# ╟─5efd2a9e-7bc9-424e-812d-2fd554677b55
# ╠═6647ab87-0ff0-4d61-ad10-897942b461dc
# ╠═0b438e45-fa85-435b-9319-741379f8bf2d
# ╟─a9ef31b2-9c59-4ed4-ba78-173a383211e2
# ╠═d869d9fd-703b-475b-b9c2-337cbc1b967a
# ╠═09eb599f-f454-4167-8b63-002e6b3b1ef9
# ╟─5c30cf8d-1295-4e42-ba93-2b49b005455c
# ╠═d96442d4-eaa9-4339-b55f-e48e39169e48
# ╟─8e1fac94-4a44-499b-a49b-e4761549b166
# ╟─0536d875-6f77-4834-9fa4-a0a31f7fa09a
# ╟─d54f80fa-750b-494b-be58-933d375fb8c2
# ╠═8bd0408e-7b00-419c-930c-8e9361ad1574
# ╟─3b2e4202-19be-4de5-92ae-b3911af42f7f
# ╟─3b3cab5a-c5e2-4587-9aae-a97cbc15f238
# ╟─c94ca702-fe13-468f-938a-be9b16a879e2
# ╠═b577d259-b564-47c8-b732-a0af01f30014
# ╠═24dea8be-3930-4049-9a44-b8151e164d91
# ╠═7701def7-26b9-4f53-90a9-3eec7be70a16
# ╟─d1571780-39a7-4d8d-9ee0-b9770e235bdd
# ╠═98457248-d957-4376-8086-6b5866a743c9
# ╠═0553623d-5416-4cf4-8cd8-a836dbe5c41f
# ╟─cf556b7b-1d94-43d7-99f8-0a134bd9865b
# ╠═46bdba66-e0fa-4631-b0a1-9d532aa25e89
# ╟─6debf09f-ff30-4e30-93b3-8872c258908c
# ╠═28821165-3106-4983-be9f-3155cbc4ba53
# ╟─b221fbd3-c519-4c9c-8c98-bcee6fae796d
# ╟─3b5b7dcf-6a56-49cb-9dd8-1b2aba81ef87
# ╟─8f398c3a-9def-4f41-a171-45d38527c83c
# ╟─a39e4255-43ee-4ed3-8282-fd25ca0b8d53
# ╠═214cde58-aa66-4499-9a5e-5a6a36c22115
# ╟─7aa62fe2-9c5e-4640-8960-21a9084e436f
# ╠═687f65ad-2320-4cab-b576-0b94de505c10
# ╠═55e690c8-14c2-46f8-bd3c-f64e34a8d74e
# ╟─58fbd165-41f3-4cac-aaa3-e498e4621d1d
# ╠═a6fc5004-5ef2-409c-9b6a-5e7e7efb25ad
# ╠═c4d8af83-f7f9-47a0-9023-fe46e6bc1109
# ╠═6229a275-b52d-4c81-a05b-f22d15b0cf32
# ╠═53cd90d5-8a70-43a6-b72e-d61185c0b7aa
# ╟─4fdc2f91-dc97-4c58-9cc1-486d30ad7890
# ╟─08924e9f-27b8-444a-b9af-9fa34cf1d61b
# ╠═daa23583-9b16-4a76-bde8-9324f3dc1908
# ╠═12e389d6-9ac2-49b5-a678-cf71787541eb
# ╟─e791a417-a00a-479e-b433-3773dd74a48e
# ╠═b18f9af8-130d-4bac-ba8f-230e89d229b7
# ╠═26de3d3b-9229-4c34-a7d1-e0c89ef6f843
# ╠═30933711-723e-4b8f-8be9-3928635e068e
# ╟─eb9a5d9f-9f39-401c-aa35-102414ed99de
# ╟─3280db88-0d68-4426-9f89-0fd3914e6ffa
# ╠═4fa1d5b9-36a0-491e-a034-c887ee7338d8
# ╠═68ce440d-53f8-4312-8911-a7348e602a1f
# ╠═1be992a6-fc03-437f-9dc1-6072f0b08327
# ╠═36086001-a2bd-4648-b2b3-3d526f0dcf71
# ╟─5ece33d6-4622-4385-b84c-639bd7571915
# ╠═ce690520-a919-4e3d-a201-ec2baedf913d
# ╟─28263f4f-37b0-43fd-9eab-6169d82b0581
# ╠═421ab876-efa5-4a7d-9d33-5b9eca5f528e
# ╠═142b9281-196f-4d3e-ae7d-fbc1011255f6
# ╠═91e7e129-c7b5-4e1f-9025-bdac4d569b46
# ╠═0e20de93-a6f1-415c-a08e-53de67065bc4
# ╠═be7bad99-185a-43ed-9c8d-33e5abcdbbd0
# ╟─40b0919d-64a5-4a89-95fb-5266c2c07260
# ╠═ec0fa200-0c79-467a-af5c-97e79f37253d
# ╟─55633c9d-2c1b-40c5-9475-48f18b1f8d77
# ╟─69e96bb3-fc25-4f44-89cd-8f2aeb7065fe
# ╠═9d4aeb68-6649-42f6-8a93-997a136499d4
# ╠═2a3d5a98-751c-48c9-b102-89bc40e74251
# ╠═457bc2c7-9aae-4b28-b216-ef9454227651
# ╟─f35046c4-4a6e-42e5-b691-78b6ef3b0d27
# ╠═8af669a5-4f1f-4f0e-9de7-030e3196f96b
# ╟─32035322-60ec-4ed7-a340-84c6457a2464
# ╟─2c04e557-4afa-4acc-ace1-45f994aa3ed3
# ╟─83c37801-d248-442a-a360-829f740f5cd9
# ╠═4170966b-cbb4-4b7b-b6e0-528f63a1c019
# ╟─f720b6ad-eea0-4c07-b528-822b80305000
# ╟─7831cafd-8ac8-41be-ad0d-a5abeeb66276
# ╟─fc60372a-f853-4005-bc40-64e9d0615a32
# ╠═89b74238-dd21-4063-bdb8-d64adcc2184c
# ╠═b8c1cdf5-550e-49be-83b0-2a01fc583886
# ╟─1b7789aa-1969-486c-a733-6e3d10d135bc
# ╟─f42fa416-47d1-49b6-9d4b-365740908e03
# ╟─4f191e04-1972-47af-b1d9-2de4857833bb
# ╟─342337cc-6202-45f7-bf5d-6688b770ac75
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
