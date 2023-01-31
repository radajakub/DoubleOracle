"""
    LinearProgram

Subtype of `Algorithm` representing exact solution of a Normal-Form game by linear programming.
"""
abstract type LinearProgram <: Algorithm end

"""
    solve(NormalFormGame, LinearProgram)

Solve the `NormalFormGame` by linear programming and return the outcome and equilibrium strategies.
"""
function solve(nfg::NormalFormGame, ::Type{LinearProgram})
    return MatrixGame(nfg.U)
end
