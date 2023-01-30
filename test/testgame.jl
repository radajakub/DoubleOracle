@testset verbose = true "Game definition parts" begin

    @testset verbose = true "Player abstraction" begin
        @test createplayers(3) == [Player(1), Player(2), Player(3)]
        @test repr(Player(42)) == "Player 42"
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

end
