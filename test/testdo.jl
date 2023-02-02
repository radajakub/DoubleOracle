@testset verbose = true "Double Oracle algorithm" begin
    # prepare data for the test

    # create normal form game with payoff matrix 5×6
    A1 = ActionSet(Player(1), string.(split("12345")))
    A2 = ActionSet(Player(2), string.(split("123456")))

    # create row Oracle O1
    O1 = Oracle(Player(1), 2)
    add!(O1, 4)

    # create column Oracle O2
    O2 = Oracle(Player(2), 1)
    add!(O2, 3)
    add!(O2, 4)

    @testset verbose = true "Restrictions" begin
        # create nfg for this test only
        # 5×6 matrix of numbers 0:29 filled by rows
        #  0   1   2   3   4   5
        #  6   7   8   9  10  11
        # 12  13  14  15  16  17
        # 18  19  20  21  22  23
        # 24  25  26  27  28  29
        U = [6 * row + col for row in 0:4, col in 0:5]
        nfg = NormalFormGame("test", (Player(1), Player(2)), (A1, A2), U)

        @testset verbose = true "Game restriction" begin
            result = [6 8 9; 18 20 21]
            @test restrict(nfg, O1, O2) == result
        end

        @testset verbose = true "Row restriction" begin
            result = [6 7 8 9 10 11; 18 19 20 21 22 23]
            @test restrict(nfg, O1, RowRestriction) == result
        end

        @testset verbose = true "Column restriction" begin
            result = [0 2 3; 6 8 9; 12 14 15; 18 20 21; 24 26 27]
            @test restrict(nfg, O2, ColumnRestriction) == result
        end
    end

    @testset verbose = true "Best response" begin
        # define payoff matrix arbitrarily and construct the nfg
        U = [
            -7 2 -3 1 -1 6
            5 -1 1 -5 2 -7
            -5 -10 8 10 0 -3
            -2 -10 7 -6 7 -1
            8 0 10 -3 -6 -2
        ]
        nfg = NormalFormGame("test", (Player(1), Player(2)), (A1, A2), U)

        @testset verbose = true "Row player" begin
            # Create a probability distribution for Oracle O2 (length is 3)
            p2 = [0.3, 0.2, 0.5]
            # thus using the payoff matrix above, we use the oracle of the oponent to restrict the game by columns
            # -7  -3   1
            #  5   1  -5
            # -5   8  10
            # -2   7  -6
            #  8  10  -3
            # and multiply each row by the mixed strategy of the oracle to get the expected payoff by playing the given pure strategy
            # -2.2, -0.8, 5.1, -2.2, 2.9
            # and take argmax, which is 3
            @test bestresponse(nfg, O2, p2, ColumnRestriction) == 3
        end
        @testset verbose = true "Column player" begin
            # Create a probability distribution for Oracle O1 (length is 2)
            p1 = [0.9, 0.1]
            # thus using the matrix from above, we use the oracle of the oponent to restrict the game by rows
            #  5   -1   1  -5   2  -7
            # -2  -10   7  -6   7  -1
            # and multiply each column by the mixed strategy of the oracle to get the expected payoff by playing the given pure strategy
            # 4.3, -1.9, 1.6, -5.1, 2.5, -6.4
            # and take argmin, which is 6
            @test bestresponse(nfg, O1, p1, RowRestriction) == 6
        end
    end

    @testset verbose = true "Algorithm results" begin

        # load Matching Pennies example Normal-Form game
        nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame)
        solution = solve(nfg, DoubleOracleAlgorithm)
        P1, P2 = createplayers(2)

        @testset verbose = true "Outcome value" begin
            @test solution(P1) == 0.0
            @test solution(P2) == -0.0
        end

        @testset verbose = true "Strategies" begin
            @test solution[P1] == [("1", 0.5), ("2", 0.5)]
            @test solution[P2] == [("A", 0.5), ("B", 0.5)]
        end

    end

end
