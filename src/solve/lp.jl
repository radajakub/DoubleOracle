"""
    LinearProgram

Subtype of `Algorithm` representing exact solution of a Normal-Form game by linear programming.
"""
abstract type LinearProgram <: Algorithm end

Base.show(io::IO, ::Type{LinearProgram}) = print(io, "Linear program")

"""
    solve(nfg::NormalFormGame, ::Type{LinearProgram})

Solve the `NormalFormGame` by linear programming and return the payoff and equilibrium strategies.
"""
function solve(nfg::NormalFormGame, ::Type{LinearProgram})
    # solve nfg as a full Matrix game
    mg = MatrixGame(nfg.U)
    # transform MatrixGame to Solution and return it
    return Solution(mg, nfg, LinearProgram)
end
