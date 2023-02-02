@testset verbose = true "Oracle" begin

    @testset verbose = true "Construction and properties" begin
        # test construction and length
        O = Oracle(Player(1), 4)
        @test length(O) == 1
        @test collect(O) == [4]
        @test O.selected[1] == 4

        # test addition of an element after the current actions
        add!(O, 5)
        @test length(O) == 2
        @test collect(O) == [4, 5]
        @test O.selected[1] == 4

        # test addition of an element before the current actions
        add!(O, 1)
        @test length(O) == 3
        @test collect(O) == [1, 4, 5]
        @test O.selected[1] == 1

        # test adding already existing action
        add!(O, 4)
        @test length(O) == 3
        @test collect(O) == [1, 4, 5]
    end

    @testset verbose = true "Test strategy completion" begin
        O = Oracle(Player(1), 2)
        add!(O, 3)
        add!(O, 7)
        add!(O, 9)
        p = [0.1, 0.05, 0.6, 0.25]
        @test fullstrategy(O, p, 10) == [0.0, 0.1, 0.05, 0.0, 0.0, 0.0, 0.6, 0.0, 0.25, 0.0]
    end

end
