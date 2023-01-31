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

    @testset verbose = true "Normal Form Game" begin
        # load game to test
        nf = load("../data/nf_games/matching_pennies.nfg", NormalFormGame)

        # test name
        @test nf.name == "matching_pennies.nfg"

        # test player set
        P1 = Player(1)
        P2 = Player(2)
        @test nf.N == (P1, P2)

        # test action sets
        A1 = ActionSet(P1, ["1", "2"])
        @test length(nf.A[P1]) == 2
        @test nf.A[P1][1] == "1"
        @test nf.A[P1][2] == "2"
        @test nf.A[P1]["1"] == 1
        @test nf.A[P1]["2"] == 2

        A2 = ActionSet(P2, ["A", "B"])
    end

end
