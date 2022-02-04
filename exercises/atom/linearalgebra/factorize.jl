#=
    Goal:
        For the given Hilbert matrix H, and a collection of
        100 random vectors bᵢ,
        compute H⁻¹ bᵢ using
        a) the LU factorization
        b) the automatic factorization
        c) use a SVD factorization

    Hint:
=#

using LinearAlgebra

# construction of a Hilbert matrix
N = 25
H = Float64[1/(i+j-1) for i in 1:N, j in 1:N]

M = 1000
xs = [rand(N) for _ in 1:M]

H_lu = lu(H)
H_fact = factorize(H)

bs = [H*x for x in xs]

ratios = zeros(M)
for i in 1:M
    res_lu   = norm(xs[i] - H_lu\bs[i])
    res_fact = norm(xs[i] - H_fact\bs[i])
    ratios[i] = res_lu/res_fact
end


# optional: visuation of the results
using CairoMakie
begin
    p = hist(ratios, bins=100, axis = (title = "Ratio",))
    vlines!(p.axis, [1.0], color = :red)
    current_figure()
end


norm(xs[1] - lu(H) \ bs[1])
norm(xs[1] - svd(H) \ bs[1])
