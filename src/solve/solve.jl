"""
    Algorithm

Abstract type representing solving algorithms of a game in the Game Theory
"""
abstract type Algorithm end

"""
    MatrixGame

Solve and represent solution of a Matrix game with matrix `u`.
Solution is made by a standard linear program for two-player zero-sum Normal-form games.
Both outcome and an equilibrium strategy is saved for both players.
Note that this can be only a solution of a subgame, not necessarily the whole NFG.

# Fields
- `outcomes`: 2-tuple with game outcomes for each respective player
- `strategies`: 2-tuple with en equilibrium strategies (probability distribution over rows/columns Δ(A)) for each respective player

# Examples
```jldoctest
julia> u = [1 -1; -1 1];
julia> MatrixGame(u)
MatrixGame results:
→ outcome of the Nash Equilibrium: (0.0, -0.0)
→ strategy of row player: [0.5, 0.5]
→ strategy of columne player: [0.5, 0.5]
```
"""
struct MatrixGame
    outcomes::NTuple{2,<:Real}
    strategies::NTuple{2,Vector{Float64}}

    function MatrixGame(u::AbstractMatrix{T}) where {T<:Real}
        # define auxiliary vector of actions as the U can be smaller than original game
        A1 = 1:size(u)[1]
        A2 = 1:size(u)[2]

        # define and setup model
        lp = Model(Clp.Optimizer)
        set_silent(lp)

        # define standard linear program for Normal Form Games

        # utility of player 1
        @variable(lp, V)
        # strategy of player 1, i.e. π₁
        @variable(lp, pi1[A1])

        # maximize utility of player 1
        @objective(lp, Max, V)

        # best response constraint for each action a1 ∈ A1
        @constraint(lp, a[a2=A2], sum(u[a1, a2] * pi1[a1] for a1 in A1) >= V)
        # strategy must sum to 1
        @constraint(lp, b, sum(pi1) == 1)
        # elements of strategy must be non-negative
        @constraint(lp, c, pi1 .>= 0)

        optimize!(lp)

        utility = objective_value(lp)

        return new((utility, -utility), (value.(pi1), dual.(a)))
    end
end

function Base.show(io::IO, mg::MatrixGame)
    P1, P2 = createplayers(2)
    println(io, "MatrixGame results:")
    println(io, "→ outcome of the Nash Equilibrium: $((mg(P1), mg(P2)))")
    println(io, "→ strategy of row player: $(mg[P1])")
    print(io, "→ strategy of column player: $(mg[P2])")
end

"""
    (mg::MatrixGame)(p::Player)

Obtain the `outcome` value of a `player` from the `MatrixGame` structure.

# Examples
```jldoctest
julia> mg = MatrixGame([1 -1; -1 1]);
julia> mg(Player(1))
0.0
```
"""
(mg::MatrixGame)(p::Player) = mg.outcomes[p]


"""
    getindex(mg::MatrixGame, p::Player)

Obtain the `strategy` of a `player` from the `MatrixGame` structure.

# Examples
```jldoctest
julia> mg = MatrixGame([1 -1; -1 1]);
julia> mg[Player(1)]
2-element Vector{Float64}:
 0.5
 0.5
```
"""
Base.getindex(mg::MatrixGame, p::Player) = mg.strategies[p]
