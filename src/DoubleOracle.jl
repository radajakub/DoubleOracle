module DoubleOracle

using JuMP
using Clp
using LinearAlgebra
using StatsBase

include(joinpath("game", "player.jl"))
include(joinpath("game", "actions.jl"))
include(joinpath("game", "game.jl"))
include(joinpath("solve", "utils.jl"))
include(joinpath("solve", "oracle.jl"))
include(joinpath("solve", "solution.jl"))
include(joinpath("solve", "lp.jl"))
include(joinpath("solve", "do.jl"))

export Player, createplayers
export ActionSet, allnames, randomaction
export Game, NormalFormGame, load, generate
export MatrixGame
export Solution, pairstrategies, samesolutions, samepayoffs, samestrategies, support, supportratio
export Algorithm, LinearProgram, DoubleOracleAlgorithm, solve
export Oracle, add!, fullstrategy
export bestresponse, restrict, GameRestriction, ColumnRestriction, RowRestriction

end
