using DoubleOracle
using Test

@testset verbose = true "DoubleOracle.jl" begin
    include("testgame.jl")
    include("testexact.jl")
end
