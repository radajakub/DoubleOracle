"""
    Solution

Represent solution of the Normal-Form game.
In contrast to MatrixGame, this solution corresponds always to the whole NFG.

# Fields
-       name: name of the NormalFormGame (for pretty output)
-   outcomes: 2-tuple of outcome for each player
- strategies: 2-tuple of strategies for each player (strategy is a vector of tuples, where first part is name of action and second is a playing probability in equilibrium)
"""
struct Solution
    name::String
    outcomes::NTuple{2,<:Real}
    strategies::NTuple{2,Vector{Tuple{String,Float64}}}
end

"""
    Solution(mg::MatrixGame, nfg::NormalFormGame)

Construct Solution in a case where `mg` contains solution of the whole `nfg`, i.e. in exact solution by linear programming.
Strategies in `mg` are assumed to be of same length as action sets in `nfg`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame);

julia> mg = MatrixGame(nfg.U);

julia> Solution(mg, nfg)
The two-player zero-sum Normal-Form game was solved

Player 1 gains outcome 0.0 by playing a strategy
 → [1 : 0.5, 2 : 0.5]

Player 2 gains outcome -0.0 by playing a strategy
 → [A : 0.5, B : 0.5]

```
"""
function Solution(mg::MatrixGame, nfg::NormalFormGame)
    P1, P2 = nfg.N

    # enforce that strategy has the same length as is the number of actions in the action set
    @assert length(mg.strategies[P1]) == nfg.A[P1].n
    @assert length(mg.strategies[P2]) == nfg.A[P2].n

    return Solution(nfg.name, mg.outcomes, (pairstrategies(allnames(nfg.A[P1]), mg[P1]), pairstrategies(allnames(nfg.A[P2]), mg[P2])))
end

function Base.show(io::IO, solution::Solution)
    println(io, "The two-player zero-sum Normal-Form game was solved")
    for P in createplayers(2)
        println(io)
        println(io, "$(P) gains outcome $(solution(P)) by playing a strategy")
        println(io, " → [", join(map(pair -> "$(pair[1]) : $(pair[2])", solution[P]), ", "), "]")
    end
end

"""
    (solution::Solution)(p::Player)

Shortcut to obtain `outcome` of a `player` present in `solution`.

# Examples
```jldoctest
julia> solution = Solution("test", (1.0, -1.0), ([("A", 1)], [("B", 1)]));

julia> solution(Player(2))
-1.0

```
"""
(solution::Solution)(p::Player) = solution.outcomes[p]

"""
    getindex(solution::Solution, p::Player)

Shortcut to obtain `strategy` of a `player` present in `solution`.

# Examples
```jldoctest
julia> solution = Solution("test", (1.0, -1.0), ([("A", 1)], [("B", 1)]));

julia> solution[Player(2)]
1-element Vector{Tuple{String, Float64}}:
 ("B", 1.0)

```
"""
Base.getindex(solution::Solution, p::Player) = solution.strategies[p]

"""
    pairstrategies(names::Vector{String}, probs::Vector{Float64})

Merge `names` and `probs` (probabilities) in such a way that first element in `names` is joined with first element in `probs` into a tuple and so on.

# Examples
```jldoctest
julia> names = ["A", "B"];

julia> probs = [1.0, 0.0];

julia> pairstrategies(names, probs)
2-element Vector{Tuple{String, Float64}}:
 ("A", 1.0)
 ("B", 0.0)

```
"""
pairstrategies(names::Vector{String}, probs::Vector{Float64}) = collect(zip(names, probs))
