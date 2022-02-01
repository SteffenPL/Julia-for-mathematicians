


#=

    # The Game of Life

On a N × N grid, each grid point represents on cell.
The cells are either alive or dead.

The rules for switching between alive and dead are:
1. Any live cell with two or three live neighbours survives.
2. Any dead cell with three live neighbours becomes a live cell.
3. All other live cells die in the next generation.
Similarly, all other dead cells stay dead.

The neighbours are the cell to the left, right, top, bottom.
(i.e. without diagonal.)

Implement the Game of Life!

=#


function simulate(X, n_steps)
    # put your code here
end

# initial data
nx = ny = 100
X = falses(nx, ny)
X[4,6] = true
X[5,5] = true
X[6,5] = true
X[6,6] = true
X[6,7] = true
sol = simulate(X, 10000)

#=
# If you want, you can use this code are a visualisation
# The variable `sol` is expected to be of size nx × ny × n_steps

using GLMakie

let
    f = Figure()
    sl = Slider(f[2,1], range = 1:size(sol,3))
    state = @lift sol[:,:,$(sl.value)]
    image(f[1,1],
            state,
            interpolate = false,
            axis = (aspect = DataAspect(),
                    title = "Conway's Game of Life"))
    f  # or display(f)
end
=#



#=
using BenchmarkTools
@btime simulate($X, 100) seconds=0.1
=#
