using Pkg
Pkg.activate(pwd())

using DoubleOracle

if length(ARGS) < 0
    println("You must provide an input file path as the first argument!")
    exit(1)
end

nfg = load(ARGS[1], NormalFormGame);
solution = solve(nfg, LinearProgram)

println(solution)
