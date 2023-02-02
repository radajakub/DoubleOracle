"""
    DoubleOracleAlgorithm

Subtype of `Algorithm` representing solution of a Normal-Form game by the Double Oracle algorithm.
"""
abstract type DoubleOracleAlgorithm <: Algorithm end

"""
    GameRestrictions

Abstract type uniting possible partial restrictions of the game.
Partial restriction means only some subset of rows or columns is preserved.
"""
abstract type GameRestriction end

"""
    ColumnRestriction

A game restriction which preserves only some columns from the payoff matrix.
All rows in the given columns are preserved as well.
"""
abstract type ColumnRestriction <: GameRestriction end

"""
    RowRestriction

A game restriction which preserves only some rows from the payoff matrix.
All columns in the given rows are preserved as well.
"""
abstract type RowRestriction <: GameRestriction end

"""
    restrict(nfg::NormalFormGame, O1::Oracle, O2::Oracle)

Create a restriction of the payoff matrix of `nfg`, where only a subset of columns and a subset of rows is preserved.
The preserved rows are given by actions in Oracle `O1`, the columns by Oracle `O2`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/test.nfg", NormalFormGame);

julia> O1 = Oracle(Player(1), 1);

julia> O2 = Oracle(Player(2), 2);

julia> add!(O2, 3);

julia> nfg.U
2×3 Matrix{Float64}:
  30.0  -10.0   20.0
 -10.0   20.0  -20.0

julia> O1
Oracle for Player 1 has actions: [1]

julia> O2
Oracle for Player 2 has actions: [2, 3]

julia> restrict(nfg, O1, O2)
1×2 Matrix{Float64}:
 -10.0  20.0

```
"""
restrict(nfg::NormalFormGame, O1::Oracle, O2::Oracle) = nfg.U[O1.selected, O2.selected]

"""
    restrict(nfg::NormalFormGame, O::Oracle, ::Type{ColumnRestriction})

Create a restriction of the payoff matrix of `nfg`, where only a subset of columns is preserved.
The preserved columns correspond to action ids given by Oracle `O`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/test.nfg", NormalFormGame);

julia> O = Oracle(Player(2), 2);

julia> add!(O, 3);

julia> nfg.U
2×3 Matrix{Float64}:
  30.0  -10.0   20.0
 -10.0   20.0  -20.0

julia> O
Oracle for Player 2 has actions: [2, 3]

julia> restrict(nfg, O, ColumnRestriction)
2×2 Matrix{Float64}:
 -10.0   20.0
  20.0  -20.0
```
"""
restrict(nfg::NormalFormGame, O::Oracle, ::Type{ColumnRestriction}) = nfg.U[:, O.selected]

"""
    restrict(nfg::NormalFormGame, O::Oracle, ::Type{RowRestriction})

Create a restriction of the payoff matrix of `nfg`, where only a subset of columns is preserved.
The preserved columns correspond to action ids given by Oracle `O`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/test.nfg", NormalFormGame);

julia> O = Oracle(Player(1), 1);

julia> nfg.U
2×3 Matrix{Float64}:
  30.0  -10.0   20.0
 -10.0   20.0  -20.0

julia> O
Oracle for Player 1 has actions: [1]

julia> restrict(nfg, O, RowRestriction)
1×3 Matrix{Float64}:
 30.0  -10.0  20.0

```
"""
restrict(nfg::NormalFormGame, O::Oracle, ::Type{RowRestriction}) = nfg.U[O.selected, :]

"""
    bestresponse(nfg::NormalFormGame, O::Oracle, p::Vector{Float64}, ::Type{ColumnRestriction})

Find id of a best response pure strategy in a Normal-Form game, when fixing Oracle `O` of the opponent and the equilibrium mixed strategy `p`, which is computed by solving a game restricted by Oracles of both players.
This function finds the best response of the row player.
"""
function bestresponse(nfg::NormalFormGame, O::Oracle, p::Vector{Float64}, ::Type{ColumnRestriction})
    # take all rows and such columns that are present in the oracle of the oponent
    restriction = restrict(nfg, O, ColumnRestriction)
    # mutliply each row by the strategy of the opponent (is fixed for now)
    rowvalues = restriction * p
    # take the action leading to maximum value
    return argmax(rowvalues)
end

"""
    bestresponse(nfg::NormalFormGame, O::Oracle, p::Vector{Float64}, ::Type{RowRestriction})

Find id of a best response pure strategy in a Normal-Form game, when fixing Oracle `O` of the opponent and the equilibrium mixed strategy `p`, which is computed by solving a game restricted by Oracles of both players.
This function finds the best response of the column player.
"""
function bestresponse(nfg::NormalFormGame, O::Oracle, p::Vector{Float64}, ::Type{RowRestriction})
    # take such rows that are present in the oracle of the oponent and all columns
    restriction = restrict(nfg, O, RowRestriction)
    # mutliply each column by the strategy of the opponent (is fixed for now)
    columnvalues = restriction' * p
    # take the action leading to minimum value
    return argmin(columnvalues)
end

"""
    solve(nfg::NormalFormGame, ::Type{DoubleOracleAlgorithm})

Solve the `NormalFormGame` by Oracle algorithm and return the outcome and equilibrium strategies.

# Algorithm
1. Start from random actions in the Oracles for both players
2. Repeat
    1. Solve a restriction of the game given by the Oracles by Linear programming method
    2. Find best response pure strategies to the equilibrium strategies from the restricted game
    3. If both found pure strategies are already present in the Oracles, end the loop
    4. Add best responses to Oracles
3. Return final equilibrium strategies and payoffs
"""
function solve(nfg::NormalFormGame, ::Type{DoubleOracleAlgorithm})
    A1, A2 = nfg.A
    # select initial pure strategies for both player
    a1 = randomaction(A1)
    a2 = randomaction(A2)

    # initialize oracles
    O1 = Oracle(A1.player, a1)
    O2 = Oracle(A2.player, a2)

    # introduce mg variable in this scope so it's available after the main loop ends
    mg = nothing

    while true
        # create a restriction of the whole game to the set of actions present in the oracles
        u = restrict(nfg, O1, O2)

        # solve the restricted game
        mg = MatrixGame(u)

        # extract equilibrium strategies for the restricted game
        pi1, pi2 = mg.strategies

        # compute optimal best reponse for row player
        newa1 = bestresponse(nfg, O2, pi2, ColumnRestriction)
        newa2 = bestresponse(nfg, O1, pi1, RowRestriction)

        # check terminal condition
        if newa1 in O1 && newa2 in O2
            break
        end

        # add actions to oracles
        add!(O1, newa1)
        add!(O2, newa2)
    end

    return Solution(mg, O1, O2, nfg)
end
