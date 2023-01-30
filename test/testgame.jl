@testset verbose = true "Player abstraction" begin
    @test createplayers(3) == [Player(1), Player(2), Player(3)]
end
