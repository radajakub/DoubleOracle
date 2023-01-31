using Pkg
Pkg.activate(pwd())

using DoubleOracle

# decide if game is generated or loaded from file
if length(ARGS) >= 1
    println("Loading game from file")
    nfg = load(ARGS[1], NormalFormGame)
else
    println("Generating random game")

    # generation parameters
    A1min = 2
    A1max = 5
    A2min = 2
    A2max = 5
    minutil = -10
    maxutil = 10
    utilstep = 1

    nfg = generate(NormalFormGame; A1min, A1max, A2min, A2max, minutil, maxutil, utilstep)
end

print(nfg)

# solve normal form game by linear program
print("Solving given normal form game by Linear programming")
solution = solve(nfg, LinearProgram)

println(solution)
