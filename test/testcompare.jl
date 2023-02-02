@testset verbose = true "Compare both algorithms on random instances" begin
    # parameters
    A1min = 2
    A1max = 5
    A2min = 2
    A2max = 5
    minutil = -10
    maxutil = 10
    utilstep = 1

    for _ in 1:10
        # generate a random game
        nfg = generate(NormalFormGame; A1min, A1max, A2min, A2max, minutil, maxutil, utilstep)
        lpsolution = solve(nfg, LinearProgram)
        dosolution = solve(nfg, DoubleOracleAlgorithm)

        # compare solutions if the error is tolerated
        @test samesolutions(lpsolution, dosolution)
    end
end
