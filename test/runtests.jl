using DoubleOracle
using Test

@testset verbose = true "DoubleOracle.jl" begin
    include("testgame.jl")
    include("testsolution.jl")
    include("testlp.jl")
    include("testoracle.jl")
    include("testdo.jl")
end
