module DoubleOracle

using JuMP, Clp

include(joinpath("game", "player.jl"))
include(joinpath("game", "actions.jl"))
include(joinpath("game", "game.jl"))
include(joinpath("solve", "solve.jl"))
include(joinpath("solve", "solution.jl"))
include(joinpath("solve", "exact.jl"))

export Player, createplayers
export ActionSet, allnames
export NormalFormGame, load, generate
export MatrixGame
export Algorithm, LinearProgram, solve
export Solution, pairstrategies

end
