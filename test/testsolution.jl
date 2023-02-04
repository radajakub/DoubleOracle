@testset verbose = true "Solution transformation" begin

    @testset verbose = true "Strategy pairing" begin
        names = ["A", "B", "C"]
        probs = [0.5, 0.3, 0.2]
        @test pairstrategies(names, probs) == [("A", 0.5), ("B", 0.3), ("C", 0.2)]
    end


    atol = 1e-4
    tolerated = 1e-5
    untolerated = 1e-3

    @testset verbose = true "Compare payoffs" begin
        payoff1 = (0.5, 0.5)

        # tolerated error
        payoff2 = payoff1 .+ (tolerated, 0)
        @test samepayoffs(payoff1, payoff2; atol)

        # untolerated error
        payoff3 = payoff1 .+ (0, untolerated)
        @test !samepayoffs(payoff1, payoff3; atol)
    end

    @testset verbose = true "Compare strategies" begin
        s1 = [("A", 0.33), ("B", 0.47), ("C", 0.2)]

        # tolerated error in probabilities
        s2 = [("A", 0.33 + tolerated), ("B", 0.47 - tolerated), ("C", 0.2)]
        @test samestrategies(s1, s2; atol)

        # untolerated error in probabilities
        s3 = [("A", 0.33 + untolerated), ("B", 0.47 + tolerated), ("C", 0.2)]
        @test !samestrategies(s1, s3; atol)

        # change of action id even with equal probabilities
        s4 = [("a", 0.33), ("B", 0.47), ("C", 0.2)]
        @test !samestrategies(s1, s4; atol)
    end

    @testset verbose = true "Support" begin
        # test nice ratio
        s1 = [("A", 0.0), ("B", 0.1), ("C", 0.001), ("D", 0.0), ("E", 0.8999), ("F", 0.0)]
        @test support(s1) == ["B", "C", "E"]
        @test supportratio(s1) == 0.5

        # test rounding of ratio
        s2 = [("A", 0.0), ("B", 0.1), ("C", 0.9)]
        @test supportratio(s2) == 0.67
        @test supportratio(s2; digits=3) == 0.667

        # test solution support
        nfg = load("../data/nf_games/test.nfg", NormalFormGame)
        s = solve(nfg, LinearProgram)
        @test support(s) == (["1", "2"], ["B", "C"])
        @test supportratio(s) == (1.0, 0.67)
    end

end
