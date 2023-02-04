# Solution utilities

This part summarizes funtions and structures providing solutions for games defined in previous section.

```@docs
Algorithm
```

## Matrix Game

This serves as a general solver for matrix game with arbitrary size, not necessarily corresponding to size of the actual Normal-Form game.
It solves a linear program for the passed matrix `u` (game or subgame) and saves the outcomes and equilibrium strategies of both players.

```@docs
MatrixGame
```

Again, for easier extraction of results, indexing shortcuts are provided.

```@docs
(:MatrixGame)(::Player)
Base.getindex(::MatrixGame, ::Player)
```

## Solution

Solution represents the final solution of the whole Normal-Form game.
It holds final equilibria strategies and outcomes.

```@docs
Solution
Solution(::MatrixGame, ::NormalFormGame, ::Type{<:Algorithm})
```

As always, the shortcuts for easier indexing and uitilization of the `Player` abstraction.

```@docs
(:Solution)(::Player)
Base.getindex(::Solution, ::Player)
```

When probabilities are to be joined with corresponding action names, the `pairstrategies` function is advised to be used.

```@docs
pairstrategies(::Vector{String}, ::Vector{Float64})
```

To compare two solutions whether they are the same (or approximately the same with tolerance `atol`) use the following functions.

```@docs
samepayoffs(::NTuple{2,Float64}, ::NTuple{2,Float64})
samestrategies(::Vector{Tuple{String,Float64}}, ::Vector{Tuple{String,Float64}})
samesolutions(::Solution, ::Solution)
```
