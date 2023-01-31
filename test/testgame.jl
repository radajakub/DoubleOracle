@testset verbose = true "Game definition parts" begin

    @testset verbose = true "Player abstraction" begin
        # test player representation
        @test repr(Player(42)) == "Player 42"

        # test player generating
        @test createplayers(3) == [Player(1), Player(2), Player(3)]

        # test player indexing
        names = ["C++", "Julia", "Pascal", "Python"]
        @test isnothing(names[Player(0)])
        @test isnothing(names[Player(5)])
        @test names[Player(2)] == "Julia"
    end

    @testset verbose = true "ActionSet" begin
        A = ActionSet(Player(1), ["A1", "A2", "A3", "A4"])

        # test getindex
        @test A[2] == "A2"
        @test A["A4"] == 4

        # test length
        @test length(A) == 4

        # test iterate
        @test collect(A) == [1, 2, 3, 4]
    end

    @testset verbose = true "NormalFormGame" begin
        # load game to test
        nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame)

        # test name
        @test nfg.name == "matching_pennies.nfg"

        # test player set
        P1 = Player(1)
        P2 = Player(2)
        @test nfg.N == (P1, P2)

        # test action sets
        A1 = ActionSet(P1, ["1", "2"])
        @test length(nfg.A[P1]) == 2
        @test nfg.A[P1][1] == "1"
        @test nfg.A[P1][2] == "2"
        @test nfg.A[P1]["1"] == 1
        @test nfg.A[P1]["2"] == 2

        A2 = ActionSet(P2, ["A", "B"])
        @test length(nfg.A[P2]) == 2
        @test nfg.A[P2][1] == "A"
        @test nfg.A[P2][2] == "B"
        @test nfg.A[P2]["A"] == 1
        @test nfg.A[P2]["B"] == 2

        # test indexing by actions and ids directly
        @test nfg[1, 1] == 1
        @test nfg[2, 1] == -1
        @test nfg[1, 2] == -1
        @test nfg[2, 2] == 1

        @test nfg["1", "A"] == 1
        @test nfg["2", "A"] == -1
        @test nfg["1", "B"] == -1
        @test nfg["2", "B"] == 1
    end

    @testset verbose = true "Random NormalFormGame" begin
        A1min = 2
        A1max = 5
        A2min = 3
        A2max = 4
        minutil = -10
        maxutil = 10
        utilstep = 1
        nfg = generate(NormalFormGame; A1min, A2min, A1max, A2max, minutil, maxutil, utilstep)

        A1, A2 = nfg.A

        # test sizes and constraints
        @test nfg.N == tuple(createplayers(2)...)
        @test A1min <= A1.n <= A1max
        @test A2min <= A2.n <= A2max
        @test all(minutil .<= nfg.U .<= maxutil)
    end

end
