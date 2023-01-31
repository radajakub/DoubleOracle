using Pkg
Pkg.activate(pwd())

using DoubleOracle

if length(ARGS) >= 1
    println("Loading game from file")
    nfg = load(ARGS[1], NormalFormGame)
else
    println("Generating random game")
    nfg = generate(NormalFormGame)
end

print(nfg)

print("Solving given normal form game by Linear programming")
solution = solve(nfg, LinearProgram)

println(solution)
