@testset verbose = true "Exact solution by linear programming" begin

    # load Matching Pennies example Normal-Form game
    nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame)
    solution = solve(nfg, LinearProgram)
    P1, P2 = createplayers(2)

    @testset verbose = true "Outcome value" begin
        @test solution(P1) == 0.0
        @test solution(P2) == -0.0
    end

    @testset verbose = true "Strategies" begin
        @test solution[P1] == [0.5 for i in 1:nfg.A[P1].n]
        @test solution[P2] == [0.5 for i in 1:nfg.A[P2].n]
    end

end
