module DoubleOracle

using JuMP, Clp

include(joinpath("game", "player.jl"))
include(joinpath("game", "actions.jl"))

export Player, createplayers
export ActionSet

end
