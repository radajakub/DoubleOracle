"""
    Solution

Represent solution of the Normal-Form game.
In contrast to MatrixGame, this solution corresponds always to the whole NFG.

# Fields
- name: name of the NormalFormGame (for pretty output)
- method: name of the method used to solve the problem
- payoffs: 2-tuple of payoff for each player
- strategies: 2-tuple of strategies for each player (strategy is a vector of tuples, where first part is name of action and second is a playing probability in equilibrium)
"""
struct Solution
    name::String
    method::Type{<:Algorithm}
    payoffs::NTuple{2,<:Real}
    strategies::NTuple{2,Vector{Tuple{String,Float64}}}
end

"""
    Solution(mg::MatrixGame, nfg::NormalFormGame, method::Type{<:Algorithm})

Construct Solution in a case where `mg` contains solution of the whole `nfg`, i.e. in exact solution by linear programming.
Strategies in `mg` are assumed to be of same length as action sets in `nfg`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame);

julia> mg = MatrixGame(nfg.U);

julia> Solution(mg, nfg, LinearProgram)
The two-player zero-sum Normal-Form game was solved by Linear program
Player 1 gains payoff 0.0 by playing a strategy
 → [1 : 0.5, 2 : 0.5]
Player 2 gains payoff -0.0 by playing a strategy
 → [A : 0.5, B : 0.5]

```
"""
function Solution(mg::MatrixGame, nfg::NormalFormGame, method::Type{<:Algorithm})
    P1, P2 = nfg.N

    # enforce that strategy has the same length as is the number of actions in the action set
    @assert length(mg.strategies[P1]) == nfg.A[P1].n
    @assert length(mg.strategies[P2]) == nfg.A[P2].n

    return Solution(nfg.name, method, mg.payoffs, (pairstrategies(allnames(nfg.A[P1]), mg[P1]), pairstrategies(allnames(nfg.A[P2]), mg[P2])))
end

"""
    Solution(mg::MatrixGame, O1::Oracle, O2::Oracle, nfg::NormalFormGame)

Construct Solution in a case where `mg` contains a solution of a `nfg` restriction defined by Oracles `O1` and `O2`. Most likely used in the Double Oracle algorithm, where not the whole matrix is used.
Full strategies are reconstructed from the partial solution in `mg` and selected actions in Oracles.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame);

julia> O1 = Oracle(Player(1), 1)
Oracle for Player 1 has actions: [1]

julia> O2 = Oracle(Player(2), 2)
Oracle for Player 2 has actions: [2]

julia> subgame = restrict(nfg, O1, O2)
1×1 Matrix{Float64}:
 -1.0

julia> mg = MatrixGame(subgame)
MatrixGame results:
→ payoff of the Nash Equilibrium: (-1.0, 1.0)
→ strategy of row player: [1.0]
→ strategy of column player: [1.0]

julia> Solution(mg, O1, O2, nfg, DoubleOracleAlgorithm)
The two-player zero-sum Normal-Form game was solved by Double Oracle algorithm
Player 1 gains payoff -1.0 by playing a strategy
 → [1 : 1.0, 2 : 0.0]
Player 2 gains payoff 1.0 by playing a strategy
 → [A : 0.0, B : 1.0]

```
"""
function Solution(mg::MatrixGame, O1::Oracle, O2::Oracle, nfg::NormalFormGame, method::Type{<:Algorithm})
    P1, P2 = nfg.N
    A1, A2 = nfg.A

    pi1 = fullstrategy(O1, mg[P1], A1.n)
    pi2 = fullstrategy(O2, mg[P2], A2.n)

    return Solution(nfg.name, method, mg.payoffs, (pairstrategies(allnames(A1), pi1), pairstrategies(allnames(A2), pi2)))
end

function Base.show(io::IO, solution::Solution)
    print(io, "The two-player zero-sum Normal-Form game was solved by $(solution.method)")
    for P in createplayers(2)
        println(io)
        println(io, "$(P) gains payoff $(solution(P)) by playing a strategy")
        print(io, " → [", join(map(pair -> "$(pair[1]) : $(pair[2])", solution[P]), ", "), "]")
    end
end

"""
    (solution::Solution)(p::Player)

Shortcut to obtain `payoff` of a `player` present in `solution`.

# Examples
```jldoctest
julia> solution = Solution("test", LinearProgram, (1.0, -1.0), ([("A", 1)], [("B", 1)]));

julia> solution(Player(2))
-1.0

```
"""
(solution::Solution)(p::Player) = solution.payoffs[p]

"""
    getindex(solution::Solution, p::Player)

Shortcut to obtain `strategy` of a `player` present in `solution`.

# Examples
```jldoctest
julia> solution = Solution("test", LinearProgram, (1.0, -1.0), ([("A", 1)], [("B", 1)]));

julia> solution[Player(2)]
1-element Vector{Tuple{String, Float64}}:
 ("B", 1.0)

```
"""
Base.getindex(solution::Solution, p::Player) = solution.strategies[p]

"""
    samesolutions(s1::Solution, s2::Solution; atol=1e-4)

Compare two solutions `s1`, `s2` whether they are the same (or similar).
Payoffs, names of actions and probabilities are compared with tolerance `atol`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame);

julia> s1 = solve(nfg, LinearProgram);

julia> s2 = solve(nfg, DoubleOracleAlgorithm);

julia> samesolutions(s1, s2)
true
```
"""
function samesolutions(s1::Solution, s2::Solution; atol=1e-4)
    P1, P2 = createplayers(2)
    return samepayoffs(s1.payoffs, s2.payoffs; atol) &&
           samestrategies(s1.strategies[P1], s2.strategies[P1]; atol) &&
           samestrategies(s1.strategies[P2], s2.strategies[P2]; atol)
end

"""
    samepayoffs(s1::NTuple{2, Float64}, s2::NTuple{2, Float64}; atol=1e-4)

Compare two solutions `s1`, `s2` whether they have the same (or similar) payoffs.
Payoffs are compared with tolerance `atol`.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/matching_pennies.nfg", NormalFormGame);

julia> s1 = solve(nfg, LinearProgram);

julia> s2 = solve(nfg, DoubleOracleAlgorithm);

julia> samepayoffs(s1.payoffs, s2.payoffs)
true
```
"""
samepayoffs(s1::NTuple{2,Float64}, s2::NTuple{2,Float64}; atol=1e-4) = all(isapprox.(s1, s2; atol))

"""
    samestrategies(s1::Vector{Tuple{String,Float64}}, s2::Vector{Tuple{String,Float64}}; atol=1e-4)

Compare two vectors of strategies `s1`, `s2` whether they are the same including name of actions and order.
Probabilities in the strategies are compared with tolerance `atol`.

# Examples
```jldoctest
julia> s1 = [("A", 0.2), ("B", 0.5), ("C", 0.3)];

julia> s2 = [("A", 0.20005), ("B", 0.49999), ("C", 0.3)];

julia> s3 = [("A", 0.3), ("B", 0.5), ("D", 0.2)];

julia> samestrategies(s1, s2)
true

julia> samestrategies(s1, s3)
false
```
"""
samestrategies(s1::Vector{Tuple{String,Float64}}, s2::Vector{Tuple{String,Float64}}; atol=1e-4) = all(map((p1, p2) -> p1[1] == p2[1] && isapprox(p1[2], p2[2]; atol), s1, s2))

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

"""
    support(strategy::Vector{Tuple{String,Float64}})

Compute `support` of a `strategy`, i.e. set of actions played with non-zero probability in the `strategy`.
Return the list of `names` of the actions.

# Example
```jldoctest
julia> strategy = [("A", 0.1), ("B", 0.5), ("C", 0.0), ("D", 0.0), ("E", 0.4)];

julia> support(strategy)
3-element Vector{String}:
 "A"
 "B"
 "E"

```
"""
support(strategy::Vector{Tuple{String,Float64}}) = [p[1] for p in strategy if p[2] > 0]

"""
    support(s::Solution)

Compute `support` of a all strategies in the Solution `s`.
Returns an `NTuple{Vector{String}}` of action names based on the number of strategies `N` in `s`.

# Example
```jldoctest
julia> nfg = load("../data/nf_games/test.nfg", NormalFormGame);

julia> s = solve(nfg, LinearProgram);

julia> support(s)
(["1", "2"], ["B", "C"])

```
"""
support(s::Solution) = support.(s.strategies)

"""
    supportratio(strategy::Vector{Tuple{String,Float64}}; digits=2)

Compute ratio of actions in the `support` of a `strategy` to the total number of available actions.
Return number from range ``[0, 1]``.
The `digits` keywoard parameter specifies the rounding precision of the ratio.

# Example
```jldoctest
julia> strategy = [("A", 0.1), ("B", 0.5), ("C", 0.0), ("D", 0.0), ("E", 0.4)];

julia> supportratio(strategy)
0.6

```
"""
supportratio(strategy::Vector{Tuple{String,Float64}}; digits=2) = round(length(support(strategy)) / length(strategy); digits)

"""
    supportratio(s::Solution; digits=2)

Compute the support ratio for all strategies in the Solution `s`.
Returns an `NTuple{Float64}` based on the number of strategies `N` in `s`.
The `digits` keywoard parameter specifies the rounding precision of the ratio.

# Examples
```jldoctest
julia> nfg = load("../data/nf_games/test.nfg", NormalFormGame);

julia> s = solve(nfg, LinearProgram);

julia> supportratio(s)
(1.0, 0.67)
```
"""
supportratio(s::Solution; digits=2) = supportratio.(s.strategies; digits)
