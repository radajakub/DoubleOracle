using DoubleOracle
using Test

@testset verbose = true "DoubleOracle.jl" begin
    include("testgame.jl")
    include("testexact.jl")
    include("testsolution.jl")
end
