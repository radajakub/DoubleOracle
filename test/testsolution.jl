@testset verbose = true "Solution transformation" begin

    @testset verbose = true "Strategy pairing" begin
        names = ["A", "B", "C"]
        probs = [0.5, 0.3, 0.2]
        @test pairstrategies(names, probs) == [("A", 0.5), ("B", 0.3), ("C", 0.2)]
    end

end
