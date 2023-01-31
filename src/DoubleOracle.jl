module DoubleOracle

using JuMP, Clp

include(joinpath("game", "player.jl"))
export Player, createplayers

include(joinpath("game", "actions.jl"))
export ActionSet, allnames

include(joinpath("game", "game.jl"))
export NormalFormGame, load

end
